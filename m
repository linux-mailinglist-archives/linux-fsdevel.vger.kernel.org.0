Return-Path: <linux-fsdevel+bounces-49097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4860DAB7EEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE737A4BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123428541B;
	Thu, 15 May 2025 07:35:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB42749C0;
	Thu, 15 May 2025 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294546; cv=none; b=o/hEN4A4alL98Rl6pvwAm7ULutEyV/cP6PnqlKiGhcsrzuM0uBf74fCFDhLVWQivXlujd/9UTWrHe6FQhEsGjZJx/XXIsqHtSFVNfrFKovS1BWmXMYRFBQaR6EnKifuzy2Z1X4RpqTFqsL3LZME5EZUSxnSdRsV/I6hbr5i4I9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294546; c=relaxed/simple;
	bh=zClRaKQdUXGC0UaJH2EaGNCbySr1fs44a9f7xGw5akk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFJ/hHTKREAe7SOJqmYSnZJS8usvv7EqAJdI/FUtDiahC7EZuyIDutlk/0YQmkBLRSr73HwnEpBMN8JdZ7wUh6hN4lbksdzPNZD9d/3s5a6vXcUhe2q39RveBPcDcXLuSt1uqqGVFBBnpM0Ik5tqHCCvjI0qoxTVgdGOa8xK+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c55500cf80so51346085a.1;
        Thu, 15 May 2025 00:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747294542; x=1747899342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=harYvwBRn7GyyYvuKyey4/F9XcHEoNQ/j36WaB/W8s4=;
        b=W1ff+uHI9Y/rrZZX36FnENsRndT1qM/n3+GqcwCcuUgE7LRGV8ToNXNXLlhyukA4br
         l1RE8+g0EK6zcfwH5HsLlmvprUUbSEK6XHSfb4vNyoht+N0bsU1Jxz1lWGPwRkdliWPR
         dAEOF4QT3IJKVW7zF5caos1FTVRrE6w4zOXUlMFfSx7KLVXj6V9k53jVqlIcZ9QCpcMM
         2TAj+fYuYeWo5+3q5fGvyHwISfik8oDZ4BCrpe9cKKc9OuyGNvBx0qqIHx6Lxk/g5JdM
         IvSpm1pQs8oVhgtkohdzShHdMwAcVfAM7/z61HWJtHLA3NZR0fBuTfeqgfhGCFIaenL4
         iPJw==
X-Forwarded-Encrypted: i=1; AJvYcCU0MvyfwBEz6q3IJEoUF3FCnPUKfN1fVzYZOC1WTn7GI+iNFRCAXYyLT77IhAjAO4JfA4XbrxJer5ZkdIxY@vger.kernel.org, AJvYcCVR9QJ+9ENBUU5QTXJXyqzyK538XvwecWo4lR+ZnsUkVkh8F9IQbBZ9J4Bhdb+UEz2zI5RFYLUGRy8cNAvD8uEl@vger.kernel.org, AJvYcCX1sNfyLwAr8DorNvhkJXj1Cdj82m16srfAFNO+Tq/4gaTXOI3za0BiCGA+a98l6F6i+MYhkcsayThYCwwl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kbuPXloCyoWThV2MkS9BBUvoVegkx9d2iQh3vxeYZPWjJ0Cm
	OQPFXjVq3Bo+7kaPiMn5eqpigBZq51Y9H1aCZL4SmFYov74tsXHe
X-Gm-Gg: ASbGncvG8V1UdVyR9vWf3m7qbNEnpmdPbfBhbF2NhuvLwXnajcvV8K7A21zZc+oZlHS
	0YBuSZH5OYdBdN0BKTxyAYUneFzwIVfDnltLc0JkDI4FdbQE/52LkJbJvBGgBqlhGFvN0JMVr00
	UOODOMAmjrcol4GiUT/U8llDAWUMtHDzBIFk85Wqa1r+a0LVWAn6EpnCNAMwJcYlLhGXaGU1kwk
	4m19lEXVNh0bV2DLvU3H7dXSe0pB2/KmrxF0tLY3oJ8dzNw0FXGiR9qa/Zlo8p3IHxLQj9RhACD
	CtXNH6XoewjT+U3XznH4ObagIOBsj69rWHb4Bj+B+lSWMmhGg52/Hg/GjmqPLM/yowaxvVkDYR4
	h87n94iENvBCLbRfso613Sw==
X-Google-Smtp-Source: AGHT+IHtkzbOPMQiJ/VBBAm81blRK95Sq3tOLA7DixsT4IsjRcY/JSG1nSmQlWrlkIYbyiLRfv0Hcg==
X-Received: by 2002:a05:6214:400c:b0:6e4:4011:9df7 with SMTP id 6a1803df08f44-6f896e3fdc3mr110865726d6.16.1747294542421;
        Thu, 15 May 2025 00:35:42 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39f588asm91036526d6.49.2025.05.15.00.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 00:35:41 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentao@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests: Add functional test for the abort file in fusectl
Date: Thu, 15 May 2025 15:34:45 +0800
Message-ID: <20250515073449.346774-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add a simple functional test for the "about" file
in fusectlfs (/sys/fs/fuse/connections/ID/about).

A simple fuse daemon is added for testing.

Related discussion can be found in the link below.

Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fusectl/.gitignore  |   3 +
 .../selftests/filesystems/fusectl/Makefile    |  21 +++
 .../selftests/filesystems/fusectl/fuse_mnt.c  | 146 ++++++++++++++++++
 .../filesystems/fusectl/fusectl_test.c        | 115 ++++++++++++++
 6 files changed, 287 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fusectl/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fusectl/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
 create mode 100644 tools/testing/selftests/filesystems/fusectl/fusectl_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f21f1dabb5fe1..efc6c89113b95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9740,6 +9740,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse.rst
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
+F:	tools/testing/selftests/filesystems/fusectl
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 80fb84fa3cfcb..a9bfefa961889 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,6 +36,7 @@ TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fusectl
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/fusectl/.gitignore b/tools/testing/selftests/filesystems/fusectl/.gitignore
new file mode 100644
index 0000000000000..3e72e742d08e8
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fuse_mnt
+fusectl_test
diff --git a/tools/testing/selftests/filesystems/fusectl/Makefile b/tools/testing/selftests/filesystems/fusectl/Makefile
new file mode 100644
index 0000000000000..612aad69a93aa
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := fusectl_test
+TEST_GEN_FILES := fuse_mnt
+
+include ../../lib.mk
+
+VAR_CFLAGS := $(shell pkg-config fuse --cflags 2>/dev/null)
+ifeq ($(VAR_CFLAGS),)
+VAR_CFLAGS := -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse
+endif
+
+VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
+ifeq ($(VAR_LDLIBS),)
+VAR_LDLIBS := -lfuse -pthread
+endif
+
+$(OUTPUT)/fuse_mnt: CFLAGS += $(VAR_CFLAGS)
+$(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
diff --git a/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c b/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
new file mode 100644
index 0000000000000..d12b17f30fadc
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/fuse_mnt.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fusectl test file-system
+ * Creates a simple FUSE filesystem with a single read-write file (/test)
+ */
+
+#define FUSE_USE_VERSION 26
+
+#include <fuse.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+
+static char *content;
+static size_t content_size = 0;
+static const char test_path[] = "/test";
+
+static int test_getattr(const char *path, struct stat *st)
+{
+	memset(st, 0, sizeof(*st));
+
+	if (!strcmp(path, "/")) {
+		st->st_mode = S_IFDIR | 0755;
+		st->st_nlink = 2;
+		return 0;
+	}
+
+	if (!strcmp(path, test_path)) {
+		st->st_mode = S_IFREG | 0664;
+		st->st_nlink = 1;
+		st->st_size = content_size;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int test_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
+			off_t offset, struct fuse_file_info *fi)
+{
+	if (strcmp(path, "/"))
+		return -ENOENT;
+
+	filler(buf, ".", NULL, 0);
+	filler(buf, "..", NULL, 0);
+	filler(buf, test_path + 1, NULL, 0);
+
+	return 0;
+}
+
+static int test_open(const char *path, struct fuse_file_info *fi)
+{
+	if (strcmp(path, test_path))
+		return -ENOENT;
+
+	return 0;
+}
+
+static int test_read(const char *path, char *buf, size_t size, off_t offset,
+		     struct fuse_file_info *fi)
+{
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if (!content || content_size == 0)
+		return 0;
+
+	if (offset >= content_size)
+		return 0;
+
+	if (offset + size > content_size)
+		size = content_size - offset;
+
+	memcpy(buf, content + offset, size);
+
+	return size;
+}
+
+static int test_write(const char *path, const char *buf, size_t size,
+		      off_t offset, struct fuse_file_info *fi)
+{
+	size_t new_size;
+
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if(offset > content_size)
+		return -EINVAL;
+
+	new_size = MAX(offset + size, content_size);
+
+	if (new_size > content_size)
+		content = realloc(content, new_size);
+
+	content_size = new_size;
+
+	if (!content)
+		return -ENOMEM;
+
+	memcpy(content + offset, buf, size);
+
+	return size;
+}
+
+static int test_truncate(const char *path, off_t size)
+{
+	if (strcmp(path, test_path) != 0)
+		return -ENOENT;
+
+	if (size == 0) {
+		free(content);
+		content = NULL;
+		content_size = 0;
+		return 0;
+	}
+
+	content = realloc(content, size);
+
+	if (!content)
+		return -ENOMEM;
+
+	if (size > content_size)
+		memset(content + content_size, 0, size - content_size);
+
+	content_size = size;
+	return 0;
+}
+
+static struct fuse_operations memfd_ops = {
+	.getattr = test_getattr,
+	.readdir = test_readdir,
+	.open = test_open,
+	.read = test_read,
+	.write = test_write,
+	.truncate = test_truncate,
+};
+
+int main(int argc, char *argv[])
+{
+	return fuse_main(argc, argv, &memfd_ops, NULL);
+}
diff --git a/tools/testing/selftests/filesystems/fusectl/fusectl_test.c b/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
new file mode 100644
index 0000000000000..8ff130ae43122
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fusectl/fusectl_test.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2025 Chen Linxuan <chenlinxuan@uniontech.com>
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <linux/limits.h>
+
+#include "../../kselftest_harness.h"
+
+#define FUSECTL_MOUNTPOINT "/sys/fs/fuse/connections"
+#define FUSE_MOUNTPOINT "/tmp/fuse_mnt_XXXXXX"
+#define FUSE_DEVICE "/dev/fuse"
+#define FUSECTL_TEST_VALUE "1"
+
+FIXTURE(fusectl){
+	char fuse_mountpoint[sizeof(FUSE_MOUNTPOINT)];
+	int connection;
+};
+
+FIXTURE_SETUP(fusectl)
+{
+	const char *fuse_mnt_prog = "./fuse_mnt";
+	int status, pid;
+	struct stat statbuf;
+
+	strcpy(self->fuse_mountpoint, FUSE_MOUNTPOINT);
+
+	if (!mkdtemp(self->fuse_mountpoint))
+		SKIP(return,
+		     "Failed to create FUSE mountpoint %s",
+		     strerror(errno));
+
+	if (access(FUSECTL_MOUNTPOINT, F_OK))
+		SKIP(return,
+		     "FUSE control filesystem not mounted");
+
+	pid = fork();
+	if (pid < 0)
+		SKIP(return,
+		     "Failed to fork FUSE daemon process: %s",
+		     strerror(errno));
+
+	if (pid == 0) {
+		execlp(fuse_mnt_prog, fuse_mnt_prog, self->fuse_mountpoint, NULL);
+		exit(errno);
+	}
+
+	waitpid(pid, &status, 0);
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		SKIP(return,
+		     "Failed to start FUSE daemon %s",
+		     strerror(WEXITSTATUS(status)));
+	}
+
+	if (stat(self->fuse_mountpoint, &statbuf))
+		SKIP(return,
+		     "Failed to stat FUSE mountpoint %s",
+		     strerror(errno));
+
+	self->connection = statbuf.st_dev;
+}
+
+FIXTURE_TEARDOWN(fusectl)
+{
+	umount(self->fuse_mountpoint);
+	rmdir(self->fuse_mountpoint);
+}
+
+TEST_F(fusectl, abort)
+{
+	char path_buf[PATH_MAX];
+	int abort_fd, test_fd, ret;
+
+	sprintf(path_buf, "/sys/fs/fuse/connections/%d/abort", self->connection);
+
+	ASSERT_EQ(0, access(path_buf, F_OK));
+
+	abort_fd = open(path_buf, O_WRONLY);
+	ASSERT_GE(abort_fd, 0);
+
+	sprintf(path_buf, "%s/test", self->fuse_mountpoint);
+
+	test_fd = open(path_buf, O_RDWR);
+	ASSERT_GE(test_fd, 0);
+
+	ret = read(test_fd, path_buf, sizeof(path_buf));
+	ASSERT_EQ(ret, 0);
+
+	ret = write(test_fd, "test", sizeof("test"));
+	ASSERT_EQ(ret, sizeof("test"));
+
+	ret = lseek(test_fd, 0, SEEK_SET);
+	ASSERT_GE(ret, 0);
+
+	ret = write(abort_fd, FUSECTL_TEST_VALUE, sizeof(FUSECTL_TEST_VALUE));
+	ASSERT_GT(ret, 0);
+
+	close(abort_fd);
+
+	ret = read(test_fd, path_buf, sizeof(path_buf));
+	ASSERT_LT(ret, 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


