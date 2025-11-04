# Partir de l'image officielle Rundeck
FROM rundeck/rundeck:latest

USER root

# Installer les clients PostgreSQL (ici, 'postgresql-client'
# installera la version récente disponible dans les dépôts Debian)
# Ajustez si nécessaire pour votre distribution
RUN apt-get update && apt-get install -y postgresql-client curl && rm -rf /var/lib/apt/lists/*

# === C'est la partie cruciale pour PG 9.2.2 ===
# Nous téléchargeons le binaire 'pg_dump' spécifique à la 9.2.2
# (Exemple pour un binaire 64-bit Linux)
RUN curl -o /tmp/postgresql-9.2.2-binaries.tar.gz https://ftp.postgresql.org/pub/source/v9.2.2/postgresql-9.2.2.tar.gz
RUN tar -xvzf /tmp/postgresql-9.2.2-binaries.tar.gz -C /usr/local/
# Assurez-vous que le binaire pg_dump 9.2.2 est dans /usr/local/pgsql/bin/pg_dump
# Renommons-le pour éviter les conflits
RUN mv /usr/local/pgsql/bin/pg_dump /usr/local/bin/pg_dump_9.2

# Revenir à l'utilisateur Rundeck
USER rundeck
