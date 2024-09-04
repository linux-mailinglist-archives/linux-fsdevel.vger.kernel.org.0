Return-Path: <linux-fsdevel+bounces-28654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBD96C8A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 22:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AE11C25B75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9D148850;
	Wed,  4 Sep 2024 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0PCqefC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B71487E3
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481982; cv=none; b=BthDmMplYMgBu+u6a8ITvFD8lakGgPwNEmhgZ2Bim04Y2VkpmfAzQXr9xx/jdkZELsBoBN3TGxA8H8iWtKRSXLlS/80DLV6UbYbCBAHaSr97aXPpTum8+KnF9lXERVj66zmX4U29NpKblGDOViYf77DmUb7VS9HD5iPTMS3OGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481982; c=relaxed/simple;
	bh=f+NjH4Z2t5pF7c2wtN0DAjcEVYdQ7nCiMJjPSnxgYJA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPlOiurc0gTStSeXCbShkL0lIZExfJnwCg2qpOwRVemAWsMmz9VBLlxlUt15L58bIKGPnQhhFpn4FPmemfsEds5Npb02LXeT3a0ypfvpSO5/pRSvG+Pb9HdKvGZiqVnxQsIFWiOr5bYF3jAfsbHf0Si28trahAU9k9QiOY0rF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0PCqefC0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a977bf0290so1216985a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1725481978; x=1726086778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bPtD0zXDWXKkzSosUzDBZ4wjH31WFYtCqOW3jxYg7A=;
        b=0PCqefC0Vicg9e4XTCs+zH0O0lpo/n+o6FmXNXbRqLgkPW+yI8meKwAC0H+/57nzB3
         25Df/hPXT40P0n66LIaj/81vS98xgj4s9sdMpIuCttXlG8AzEPhm9Chf9JuHiSYS/GVD
         7nnQN4fOIUhYTakT9q8wxpNuh8wpAqlEWt9Cdm5Ga3iiWreEWze6BQychWvwqiys8WbY
         yTVUNRJWDqtaQW37LszaFY/PyrGURQGoezpNOR+Hm30zuTfiNJgLNJen38k5GnYDeHLq
         j8tjstZjkqeNVpX74rCbD8Gu5ssuDsM/1pp83HgZbyzl2QT8Rfk5injHwpcTvU8c/WQA
         UHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725481978; x=1726086778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bPtD0zXDWXKkzSosUzDBZ4wjH31WFYtCqOW3jxYg7A=;
        b=mfh4SZ4negyrm46KGRJOrG/ZPfetVtLH0PU9mkSarDPhC0+WL/Aqzsme6RVYcJlFHq
         yIVky1WCjyEDsmaYnNvcioKlJE6Q+MvapjY0a9i3rl/MANKYXJFiiyS/2t2w4/H9+4Jl
         sbVGoTsXi2E1+CNUDNF3jde/xZaLrw9XPBAHWxbrWHGXhyDXmLxF/ORyUELI9pBmb4eH
         s/VXHCG6NfOCVHNQEX9MIA6dpuLuK1n7wNM7s92HoLlqL7jlBZu26akHDEMCrpORQIvA
         G6XEeDjgmqelcjy4mXMKXCSzMQbxkJgDELHrFu3eNKgnsqJVI/fzwErCX24JY2YYWrmi
         fcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnWOjZoNaUIu6DdwO+hszgeEKH9SkioQp5eISBThV6Oh/nhNZ7O8bqtXW/xqaBZiAu9PtVaLsa/e/Q2Y4M@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkiMsoZyytDV8tLN4wtOo4MU+QoZZ/QgtVG5KPzwlikqL5kW9
	mX3CDPjcqc2oF4uhah18iDCoK2V+llaRL9XXAdjhdNSp/q+QQWmgWNMr3fKRuLkzXaE8GTD5x3r
	e
X-Google-Smtp-Source: AGHT+IHQkJ/dO/Nq/QMeotf4DjMK2MVwk8cqQpc0rlYG+gVxpaXo7UjX3y5aIc4Rj2BQTsNFsd/jcw==
X-Received: by 2002:a05:620a:2807:b0:7a1:d8df:c0d7 with SMTP id af79cd13be357-7a8041af4c3mr1903881485a.23.1725481977687;
        Wed, 04 Sep 2024 13:32:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98efed3dasm15418985a.95.2024.09.04.13.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 13:32:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fstests: add a test for the precontent fanotify hooks
Date: Wed,  4 Sep 2024 16:32:48 -0400
Message-ID: <e331c5f1485b7d9fa1278fb205a223af3a18366e.1725481837.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725481837.git.josef@toxicpanda.com>
References: <cover.1725481837.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a test to validate the precontent hooks work properly for reads
and page faults.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 doc/group-names.txt            |   1 +
 src/Makefile                   |   2 +-
 src/precontent/Makefile        |  26 ++
 src/precontent/mmap-validate.c | 227 +++++++++++++++++
 src/precontent/populate.c      | 188 ++++++++++++++
 src/precontent/remote-fetch.c  | 441 +++++++++++++++++++++++++++++++++
 tests/generic/800              |  68 +++++
 tests/generic/800.out          |   2 +
 8 files changed, 954 insertions(+), 1 deletion(-)
 create mode 100644 src/precontent/Makefile
 create mode 100644 src/precontent/mmap-validate.c
 create mode 100644 src/precontent/populate.c
 create mode 100644 src/precontent/remote-fetch.c
 create mode 100644 tests/generic/800
 create mode 100644 tests/generic/800.out

diff --git a/doc/group-names.txt b/doc/group-names.txt
index 6cf71796..93ba6a23 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -56,6 +56,7 @@ fiexchange		XFS_IOC_EXCHANGE_RANGE ioctl
 freeze			filesystem freeze tests
 fsck			general fsck tests
 fsmap			FS_IOC_GETFSMAP ioctl
+fsnotify		fsnotify tests
 fsr			XFS free space reorganizer
 fuzzers			filesystem fuzz tests
 growfs			increasing the size of a filesystem
diff --git a/src/Makefile b/src/Makefile
index 559209be..6dae892e 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -40,7 +40,7 @@ EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
 	      soak_duration.awk
 
-SUBDIRS = log-writes perf
+SUBDIRS = log-writes perf precontent
 
 LLDLIBS = $(LIBHANDLE) $(LIBACL) -lpthread -lrt -luuid
 
diff --git a/src/precontent/Makefile b/src/precontent/Makefile
new file mode 100644
index 00000000..367a34bb
--- /dev/null
+++ b/src/precontent/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+TARGETS = $(basename $(wildcard *.c))
+
+CFILES = $(TARGETS:=.c)
+LDIRT = $(TARGETS)
+
+default: depend $(TARGETS)
+
+depend: .dep
+
+include $(BUILDRULES)
+
+$(TARGETS): $(CFILES)
+	@echo "    [CC]    $@"
+	$(Q)$(LTLINK) $@.c -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+
+install:
+	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/precontent
+	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/precontent
+
+-include .dep
+
diff --git a/src/precontent/mmap-validate.c b/src/precontent/mmap-validate.c
new file mode 100644
index 00000000..af606d5b
--- /dev/null
+++ b/src/precontent/mmap-validate.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _FILE_OFFSET_BITS 64
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+/* 1 MiB. */
+#define FILE_SIZE (1 * 1024 * 1024)
+#define PAGE_SIZE 4096
+
+#define __free(func) __attribute__((cleanup(func)))
+
+static void freep(void *ptr)
+{
+	void *real_ptr = *(void **)ptr;
+	if (real_ptr == NULL)
+		return;
+	free(real_ptr);
+}
+
+static void close_fd(int *fd)
+{
+	if (*fd < 0)
+		return;
+	close(*fd);
+}
+
+static void unmap(void *ptr)
+{
+	void *real_ptr = *(void **)ptr;
+	if (real_ptr == NULL)
+		return;
+	munmap(real_ptr, PAGE_SIZE);
+}
+
+static void print_buffer(const char *buf, off_t buf_off, off_t off, size_t len)
+{
+	for (int i = 0; i <= (len / 32); i++) {
+		printf("%lu:", off + (i * 32));
+
+		for (int c = 0; c < 32; c++) {
+			if (!(c % 8))
+				printf(" ");
+			printf("%c", buf[buf_off++]);
+		}
+		printf("\n");
+	}
+}
+
+static int validate_buffer(const char *type, const char *buf,
+			   const char *pattern, off_t bufoff, off_t off,
+			   size_t len)
+{
+
+	if (memcmp(buf + bufoff, pattern + off, len)) {
+		printf("Buffers do not match at off %lu size %lu after %s\n",
+		       off, len, type);
+		printf("read buffer\n");
+		print_buffer(buf, bufoff, off, len);
+		printf("valid buffer\n");
+		print_buffer(pattern, off, off, len);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int validate_range_fd(int fd, char *pattern, off_t off, size_t len)
+{
+	char *buf __free(freep) = NULL;
+	ssize_t ret;
+	size_t readin = 0;
+
+	buf = malloc(len);
+	if (!buf) {
+		perror("malloc buf");
+		return 1;
+	}
+
+	while ((ret = pread(fd, buf + readin, len - readin, off + readin)) > 0) {
+		readin += ret;
+		if (readin == len)
+			break;
+	}
+
+	if (ret < 0) {
+		perror("read");
+		return 1;
+	}
+
+	return validate_buffer("read", buf, pattern, 0, off, len);
+}
+
+static int validate_file(const char *file, char *pattern)
+{
+	int fd __free(close_fd) = -EBADF;
+	char *buf __free(unmap) = NULL;
+	int ret;
+
+	fd = open(file, O_RDONLY);
+	if (fd < 0) {
+		perror("open file");
+		return 1;
+	}
+
+	/* Cycle through the file and do some random reads and validate them. */
+	for (int i = 0; i < 5; i++) {
+		off_t off = random() % FILE_SIZE;
+		size_t len = random() % PAGE_SIZE;
+
+		while ((off + len) > FILE_SIZE) {
+			len = FILE_SIZE - off;
+			if (len)
+				break;
+			len = random() % PAGE_SIZE;
+		}
+
+		ret = validate_range_fd(fd, pattern, off, len);
+		if (ret)
+			return ret;
+	}
+
+	buf = mmap(NULL, FILE_SIZE, PROT_READ|PROT_EXEC, MAP_PRIVATE, fd, 0);
+	if (!buf) {
+		perror("mmap");
+		return 1;
+	}
+
+	/* Validate random ranges of the mmap buffer. */
+	for (int i = 0; i < 5; i++) {
+		off_t off = random() % FILE_SIZE;
+		size_t len = random() % PAGE_SIZE;
+
+		while ((off + len) > FILE_SIZE) {
+			len = FILE_SIZE - off;
+			if (len)
+				break;
+			len = random() % PAGE_SIZE;
+		}
+
+		ret = validate_buffer("mmap", buf, pattern, off, off, len);
+		if (ret)
+			return ret;
+	}
+
+	/* Now check the whole thing, one page at a time. */
+	for (int i = 0; i < (FILE_SIZE / PAGE_SIZE); i++) {
+		ret = validate_buffer("mmap", buf, pattern, i * PAGE_SIZE,
+				      i * PAGE_SIZE, PAGE_SIZE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int create_file(const char *file, char *pattern)
+{
+	ssize_t ret;
+	size_t written = 0;
+	int fd __free(close_fd) = -EBADF;
+
+	fd = open(file, O_RDWR | O_CREAT, 0644);
+	if (fd < 0) {
+		perror("opening file");
+		return 1;
+	}
+
+	while ((ret = write(fd, pattern + written, FILE_SIZE - written)) > 0) {
+		written += ret;
+		if (written == FILE_SIZE)
+			break;
+	}
+
+	if (ret < 0) {
+		perror("writing to the file");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void generate_pattern(char *pattern)
+{
+	for (int i = 0; i < (FILE_SIZE / PAGE_SIZE); i++) {
+		char fill = 'a' + (i % 26);
+
+		memset(pattern + (i * PAGE_SIZE), fill, PAGE_SIZE);
+	}
+}
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: mmap-validate <create|validate> <file>\n");
+}
+
+int main(int argc, char **argv)
+{
+	char *pattern __free(freep) = NULL;
+
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	pattern = malloc(FILE_SIZE * sizeof(char));
+	if (!pattern) {
+		perror("malloc pattern");
+		return 1;
+	}
+
+	generate_pattern(pattern);
+
+	if (!strcmp(argv[1], "create"))
+		return create_file(argv[2], pattern);
+
+	if (strcmp(argv[1], "validate")) {
+		usage();
+		return 1;
+	}
+
+	return validate_file(argv[2], pattern);
+}
diff --git a/src/precontent/populate.c b/src/precontent/populate.c
new file mode 100644
index 00000000..9c935427
--- /dev/null
+++ b/src/precontent/populate.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _FILE_OFFSET_BITS 64
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#define __free(func) __attribute__((cleanup(func)))
+
+static void close_fd(int *fd)
+{
+	if (*fd < 0)
+		return;
+	close(*fd);
+}
+
+static void close_dir(DIR **dir)
+{
+	if (*dir == NULL)
+		return;
+	closedir(*dir);
+}
+
+static void freep(void *ptr)
+{
+	void *real_ptr = *(void **)ptr;
+	if (real_ptr == NULL)
+		return;
+	free(real_ptr);
+}
+
+/*
+ * Dup a path, make sure there's a trailing '/' to make path concat easier.
+ */
+static char *pathdup(const char *orig)
+{
+	char *ret;
+	size_t len = strlen(orig);
+
+	/* Easy path, we have a trailing '/'. */
+	if (orig[len - 1] == '/')
+		return strdup(orig);
+
+	ret = malloc((len + 2) * sizeof(char));
+	if (!ret)
+		return ret;
+
+	memcpy(ret, orig, len);
+	ret[len] = '/';
+	len++;
+	ret[len] = '\0';
+	return ret;
+}
+
+static int process_directory(DIR *srcdir, char *srcpath, char *dstpath)
+{
+	char *src __free(freep) = NULL;
+	char *dst __free(freep) = NULL;
+	size_t srclen = strlen(srcpath) + 256;
+	size_t dstlen = strlen(dstpath) + 256;
+	struct dirent *dirent;
+
+	src = malloc(srclen * sizeof(char));
+	dst = malloc(dstlen * sizeof(char));
+	if (!src || !dst) {
+		perror("allocating path buf");
+		return -1;
+	}
+
+	errno = 0;
+	while ((dirent = readdir(srcdir)) != NULL) {
+		if (!strcmp(dirent->d_name, ".") ||
+		    !strcmp(dirent->d_name, ".."))
+			continue;
+
+		if (dirent->d_type == DT_DIR) {
+			DIR *nextdir __free(close_dir) = NULL;
+			struct stat st;
+			int ret;
+
+			snprintf(src, srclen, "%s%s/", srcpath, dirent->d_name);
+			snprintf(dst, dstlen, "%s%s/", dstpath, dirent->d_name);
+
+			nextdir = opendir(src);
+			if (!nextdir) {
+				fprintf(stderr, "Couldn't open directory %s: %s (%d)\n",
+					src, strerror(errno), errno);
+				return -1;
+			}
+
+			if (stat(src, &st)) {
+				fprintf(stderr, "Couldn't stat directory %s: %s (%d)\n",
+					src, strerror(errno), errno);
+				return -1;
+			}
+
+			if (mkdir(dst, st.st_mode)) {
+				fprintf(stderr, "Couldn't mkdir %s: %s (%d)\n",
+					dst, strerror(errno), errno);
+				return -1;
+			}
+
+			ret = process_directory(nextdir, src, dst);
+			if (ret)
+				return ret;
+		} else if (dirent->d_type == DT_REG) {
+			int fd __free(close_fd) = -EBADF;
+			struct stat st;
+
+			snprintf(src, srclen, "%s%s", srcpath, dirent->d_name);
+			snprintf(dst, dstlen, "%s%s", dstpath, dirent->d_name);
+
+			if (stat(src, &st)) {
+				fprintf(stderr, "Couldn't stat file %s: %s (%d)\n",
+					src, strerror(errno), errno);
+				return -1;
+			}
+
+			fd = open(dst, O_WRONLY|O_CREAT, st.st_mode);
+			if (fd < 0) {
+				fprintf(stderr, "Couldn't create file %s: %s (%d)\n",
+					dst, strerror(errno), errno);
+				return -1;
+			}
+
+			if (truncate(dst, st.st_size)) {
+				fprintf(stderr, "Couldn't truncate file %s: %s (%d)\n",
+					dst, strerror(errno), errno);
+				return -1;
+			}
+
+
+			if (fsync(fd)) {
+				fprintf(stderr, "Couldn't fsync file %s: %s (%d)\n",
+					dst, strerror(errno), errno);
+				return -1;
+			}
+
+			if (posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED)) {
+				fprintf(stderr, "Couldn't clear cache on file %s: %s (%d)\n",
+					dst, strerror(errno), errno);
+				return -1;
+			}
+		}
+		errno = 0;
+	}
+
+	if (errno) {
+		perror("readdir");
+		return -1;
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	DIR *srcdir __free(close_dir) = NULL;
+	char *dstpath __free(freep) = NULL;
+	char *srcpath __free(freep) = NULL;
+	int ret;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: populate <src directory> <dest directory>\n");
+		return 1;
+	}
+
+	srcpath = pathdup(argv[1]);
+	dstpath = pathdup(argv[2]);
+	if (!dstpath || !srcpath) {
+		perror("allocating paths");
+		return 1;
+	}
+
+	srcdir = opendir(srcpath);
+	if (!srcdir) {
+		perror("open src directory");
+		return 1;
+	}
+
+	ret = process_directory(srcdir, srcpath, dstpath);
+	return ret ? 1 : 0;
+}
diff --git a/src/precontent/remote-fetch.c b/src/precontent/remote-fetch.c
new file mode 100644
index 00000000..2e35b9f8
--- /dev/null
+++ b/src/precontent/remote-fetch.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _FILE_OFFSET_BITS 64
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <sys/sendfile.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#ifndef FAN_ERRNO_BITS
+#define FAN_ERRNO_BITS 8
+#define FAN_ERRNO_SHIFT (32 - FAN_ERRNO_BITS)
+#define FAN_ERRNO_MASK ((1 << FAN_ERRNO_BITS) - 1)
+#define FAN_DENY_ERRNO(err) \
+	(FAN_DENY | ((((__u32)(err)) & FAN_ERRNO_MASK) << FAN_ERRNO_SHIFT))
+#endif
+
+#ifndef FAN_PRE_ACCESS
+#define FAN_PRE_ACCESS 0x00080000
+#endif
+
+#ifndef FAN_PRE_MODIFY
+#define FAN_PRE_MODIFY 0x00100000
+#endif
+
+#ifndef FAN_EVENT_INFO_TYPE_RANGE
+#define FAN_EVENT_INFO_TYPE_RANGE	6
+struct fanotify_event_info_range {
+	struct fanotify_event_info_header hdr;
+	__u32 pad;
+	__u64 offset;
+	__u64 count;
+};
+#endif
+
+#define FAN_EVENTS (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
+
+#define __round_mask(x, y) ((__typeof__(x))((y)-1))
+#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
+#define round_down(x, y) ((x) & ~__round_mask(x, y))
+
+static const char *srcpath;
+static const char *dstpath;
+static int pagesize;
+static bool use_sendfile = false;
+
+#define __free(func) __attribute__((cleanup(func)))
+
+static void close_dir(DIR **dir)
+{
+	if (*dir == NULL)
+		return;
+	closedir(*dir);
+}
+
+static void close_fd(int *fd)
+{
+	if (*fd < 0)
+		return;
+	close(*fd);
+}
+
+static void freep(void *ptr)
+{
+	void *real_ptr = *(void **)ptr;
+	if (real_ptr == NULL)
+		return;
+	free(real_ptr);
+}
+
+static int strip_dstpath(char *path)
+{
+	size_t remaining;
+
+	if (strlen(path) <= strlen(dstpath)) {
+		fprintf(stderr, "'%s' not in the path '%s'", path, dstpath);
+		return -1;
+	}
+
+	if (strncmp(path, dstpath, strlen(dstpath))) {
+		fprintf(stderr, "path '%s' doesn't start with the source path '%s'\n",
+			path, dstpath);
+		return -1;
+	}
+
+	remaining = strlen(path) - strlen(dstpath);
+	memmove(path, path + strlen(dstpath), remaining);
+
+	/* strip any leading / in order to make it easier to concat. */
+	while (*path == '/') {
+		if (remaining == 0) {
+			fprintf(stderr, "you gave us a weird ass string\n");
+			return -1;
+		}
+		remaining--;
+		memmove(path, path + 1, remaining);
+	}
+	path[remaining] = '\0';
+	return 0;
+}
+
+/*
+ * Dup a path, make sure there's a trailing '/' to make path concat easier.
+ */
+static char *pathdup(const char *orig)
+{
+	char *ret;
+	size_t len = strlen(orig);
+
+	/* Easy path, we have a trailing '/'. */
+	if (orig[len - 1] == '/')
+		return strdup(orig);
+
+	ret = malloc((len + 2) * sizeof(char));
+	if (!ret)
+		return ret;
+
+	memcpy(ret, orig, len);
+	ret[len] = '/';
+	len++;
+	ret[len] = '\0';
+	return ret;
+}
+
+static char *get_relpath(int fd)
+{
+	char procfd_path[PATH_MAX];
+	char abspath[PATH_MAX];
+	ssize_t path_len;
+	int ret;
+
+	/* readlink doesn't NULL terminate. */
+	memset(abspath, 0, sizeof(abspath));
+
+	snprintf(procfd_path, sizeof(procfd_path), "/proc/self/fd/%d", fd);
+	path_len = readlink(procfd_path, abspath, sizeof(abspath) - 1);
+	if (path_len < 0) {
+		perror("readlink");
+		return NULL;
+	}
+
+	ret = strip_dstpath(abspath);
+	if (ret < 0)
+		return NULL;
+
+	return strdup(abspath);
+}
+
+static int copy_range(int src_fd, int fd, off_t offset, size_t count)
+{
+	off_t src_offset = offset;
+	ssize_t copied;
+
+	if (use_sendfile)
+		goto slow;
+
+	while ((copied = copy_file_range(src_fd, &src_offset, fd, &offset,
+					 count, 0)) >= 0) {
+		if (copied == 0)
+			return 0;
+
+		count -= copied;
+		if (count == 0)
+			return 0;
+	}
+
+	if (errno != EXDEV) {
+		perror("copy_file_range");
+		return -1;
+	}
+	use_sendfile = true;
+
+slow:
+	/* I love linux interfaces. */
+	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
+		perror("seeking");
+		return -1;
+	}
+
+	while ((copied = sendfile(fd, src_fd, &src_offset, count)) >= 0) {
+		if (copied == 0)
+			return 0;
+
+		count -= copied;
+		if (count == 0)
+			return 0;
+	}
+
+	perror("sendfile");
+	return -1;
+}
+
+static int handle_event(int fanotify_fd, int fd, off_t offset, size_t count)
+{
+	char path[PATH_MAX];
+	char *relpath __free(freep) = NULL;
+	int src_fd __free(close_fd) = -1;
+	off_t end = offset + count;
+	blkcnt_t src_blocks;
+	struct stat st;
+
+	relpath = get_relpath(fd);
+	if (!relpath)
+		return -1;
+
+	offset = round_down(offset, pagesize);
+	end = round_up(end, pagesize);
+	count = end - offset;
+
+	snprintf(path, sizeof(path), "%s%s", srcpath, relpath);
+	src_fd = open(path, O_RDONLY);
+	if (src_fd < 0) {
+		fprintf(stderr, "srcpath %s relpath %s\n", srcpath, relpath);
+		fprintf(stderr, "error opening file %s: %s (%d)\n", path, strerror(errno), errno);
+		return -1;
+	}
+
+	if (fstat(src_fd, &st)) {
+		perror("src fd is fucked");
+		return -1;
+	}
+
+	src_blocks = st.st_blocks;
+
+	if (fstat(fd, &st)) {
+		perror("fd is fucked");
+		return -1;
+	}
+
+	/*
+	 * If we are the same size or larger (which can happen if we copy zero's
+	 * instead of inserting a hole) then just assume we're full.  This is
+	 * approximation can fall over, but its good enough for a PoC.
+	 */
+	if (st.st_blocks >= src_blocks) {
+		int ret;
+
+		snprintf(path, sizeof(path), "%s%s", dstpath, relpath);
+		ret = fanotify_mark(fanotify_fd, FAN_MARK_REMOVE,
+				    FAN_EVENTS, -1, path);
+		if (ret < 0) {
+			/* We already removed the mark, carry on. */
+			if (errno == ENOENT) {
+				errno = 0;
+				return 0;
+			}
+			perror("removing fanotify mark");
+			return -1;
+		}
+		return 0;
+	}
+
+
+	return copy_range(src_fd, fd, offset, count);
+}
+
+static int handle_events(int fd)
+{
+	const struct fanotify_event_metadata *metadata;
+	struct fanotify_event_metadata buf[200];
+	ssize_t len;
+	struct fanotify_response response;
+	int ret = 0;
+
+	len = read(fd, (void *)buf, sizeof(buf));
+	if (len <= 0 && errno != EINTR) {
+		perror("reading fanotify events");
+		return -1;
+	}
+
+	metadata = buf;
+	while(FAN_EVENT_OK(metadata, len)) {
+		off_t offset = 0;
+		size_t count = 0;
+
+		if (metadata->vers != FANOTIFY_METADATA_VERSION) {
+			fprintf(stderr, "invalid metadata version, have %d, expect %d\n",
+				metadata->vers, FANOTIFY_METADATA_VERSION);
+			return -1;
+		}
+		if (metadata->fd < 0) {
+			fprintf(stderr, "metadata fd is an error\n");
+			return -1;
+		}
+		if (!(metadata->mask & FAN_EVENTS)) {
+			fprintf(stderr, "metadata mask incorrect %llu\n",
+				metadata->mask);
+			return -1;
+		}
+
+		/*
+		 * We have a specific range, load that instead of filling the
+		 * entire file in.
+		 */
+		if (metadata->event_len > FAN_EVENT_METADATA_LEN) {
+			const struct fanotify_event_info_range *range;
+			range = (const struct fanotify_event_info_range *)(metadata + 1);
+			if (range->hdr.info_type == FAN_EVENT_INFO_TYPE_RANGE) {
+				count = range->count;
+				offset = range->offset;
+				if (count == 0) {
+					ret = 0;
+					goto next;
+				}
+			}
+		}
+
+		/* We don't have a range, pre-fill the whole file. */
+		if (count == 0) {
+			struct stat st;
+
+			if (fstat(metadata->fd, &st)) {
+				perror("stat() on opened file");
+				return -1;
+			}
+
+			count = st.st_size;
+		}
+
+		ret = handle_event(fd, metadata->fd, offset, count);
+next:
+		response.fd = metadata->fd;
+		if (ret)
+			response.response = FAN_DENY_ERRNO(errno);
+		else
+			response.response = FAN_ALLOW;
+		write(fd, &response, sizeof(response));
+		close(metadata->fd);
+		metadata = FAN_EVENT_NEXT(metadata, len);
+	}
+
+	return ret;
+}
+
+static int add_marks(const char *src, int fanotify_fd)
+{
+	char *path __free(freep) = NULL;
+	DIR *dir __free(close_dir) = NULL;
+	size_t pathlen = strlen(src) + 256;
+	struct dirent *dirent;
+
+	path = malloc(pathlen * sizeof(char));
+	if (!path) {
+		perror("allocating path buf");
+		return -1;
+	}
+
+	dir = opendir(src);
+	if (!dir) {
+		fprintf(stderr, "Couldn't open directory %s: %s (%d)\n",
+			src, strerror(errno), errno);
+		return -1;
+	}
+
+	errno = 0;
+	while ((dirent = readdir(dir)) != NULL) {
+		int ret;
+
+		if (!strcmp(dirent->d_name, ".") ||
+		    !strcmp(dirent->d_name, ".."))
+			continue;
+
+		if (dirent->d_type == DT_DIR) {
+			snprintf(path, pathlen, "%s%s/", src, dirent->d_name);
+			ret = add_marks(path, fanotify_fd);
+			if (ret)
+				return ret;
+		} else if (dirent->d_type == DT_REG) {
+			ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD,
+					    FAN_EVENTS, dirfd(dir),
+					    dirent->d_name);
+			if (ret < 0) {
+				perror("fanotify_mark");
+				return -1;
+			}
+		}
+		errno = 0;
+	}
+	return 0;
+}
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: remote-fetch <src directory> <dest directory>\n");
+}
+
+int main(int argc, char **argv)
+{
+	int fd __free(close_fd) = -1;
+	int dirfd __free(close_fd) = -1;
+	int ret;
+
+	if (argc != 3) {
+		usage();
+		return 1;
+	}
+
+	pagesize = sysconf(_SC_PAGESIZE);
+	if (pagesize < 0) {
+		perror("sysconf");
+		return 1;
+	}
+
+	srcpath = pathdup(argv[1]);
+	dstpath = pathdup(argv[2]);
+	if (!srcpath || !dstpath) {
+		perror("allocate paths");
+		return 1;
+	}
+
+	dirfd = open(dstpath, O_DIRECTORY | O_RDONLY);
+	if (dirfd < 0) {
+		perror("open dstpath");
+		return 1;
+	}
+
+	fd = fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_UNLIMITED_MARKS, O_WRONLY | O_LARGEFILE);
+	if (fd < 0) {
+		perror("fanotify_init");
+		return 1;
+	}
+
+	ret = add_marks(dstpath, fd);
+	if (ret < 0)
+		return 1;
+
+	for (;;) {
+		ret = handle_events(fd);
+		if (ret)
+			break;
+	}
+
+	return (ret < 0) ? 1 : 0;
+}
diff --git a/tests/generic/800 b/tests/generic/800
new file mode 100644
index 00000000..08ac5b26
--- /dev/null
+++ b/tests/generic/800
@@ -0,0 +1,68 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 800
+#
+# Validate the pre-content related fanotify features
+#
+# The mmap-verify pre-content tool generates a file and then validates that the
+# pre-content watched directory properly fills it in with a mixture of page
+# faults and normal reads.
+#
+. ./common/preamble
+_begin_fstest quick auto fsnotify 
+
+_cleanup()
+{
+	cd /
+	rm -rf $TEST_DIR/dst-$seq
+	rm -rf $TEST_DIR/src-$seq
+}
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_test_program "precontent/mmap-validate"
+_require_test_program "precontent/populate"
+_require_test_program "precontent/remote-fetch"
+
+dstdir=$TEST_DIR/dst-$seq
+srcdir=$TEST_DIR/src-$seq
+
+POPULATE=$here/src/precontent/populate
+REMOTE_FETCH=$here/src/precontent/remote-fetch
+MMAP_VALIDATE=$here/src/precontent/mmap-validate
+
+mkdir $dstdir $srcdir
+
+# Generate the test file
+$MMAP_VALIDATE create $srcdir/validate
+
+# Generate the stub file in the watch directory
+$POPULATE $srcdir $dstdir
+
+# Start the remote watcher
+$REMOTE_FETCH $srcdir $dstdir &
+
+FETCH_PID=$!
+
+# We may not support fanotify, give it a second to start and then make sure the
+# fetcher is running before we try to validate the buffer
+sleep 1
+
+if ! ps -p $FETCH_PID > /dev/null
+then
+	_notrun "precontent watches not supported"
+fi
+
+$MMAP_VALIDATE validate $dstdir/validate
+
+kill -9 $FETCH_PID &> /dev/null
+wait $FETCH_PID &> /dev/null
+
+echo "Silence is golden"
+
+# success, all done
+status=$?
+exit
diff --git a/tests/generic/800.out b/tests/generic/800.out
new file mode 100644
index 00000000..bdfaa2ce
--- /dev/null
+++ b/tests/generic/800.out
@@ -0,0 +1,2 @@
+QA output created by 800
+Silence is golden
-- 
2.43.0


