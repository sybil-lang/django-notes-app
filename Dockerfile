# Use a smaller base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app/backend

# Install system dependencies (only required ones)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

# Copy only requirements first (so Docker can cache deps if code changes)
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the code
COPY . .

# Expose port
EXPOSE 8000

# Default command (you can override in docker-compose)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

#this is opitmized docker file
