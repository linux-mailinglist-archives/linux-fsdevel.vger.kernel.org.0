Return-Path: <linux-fsdevel+bounces-51088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C6AD2BCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EA87A3F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 02:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863881C75E2;
	Tue, 10 Jun 2025 02:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64F1624E5;
	Tue, 10 Jun 2025 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749521441; cv=none; b=ArJxypHN4M42KFKH5FsglBNgZDhQE4ZxAmmSakZgZV0mk/zvRhY8hrW8VbmZZZWb2B8GVRccX79EepkX5mDxS1+4mB/WS036eOxcSK8E5ymxCGvB5kwTeLo5bhwZQrliVILXTu/32V9YR8xXV/EKUw26NLO9m98wQEfxRub1rNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749521441; c=relaxed/simple;
	bh=7r+gjaLUxohy1g3DPttixjKBYym83aEFktlGPw2yFKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aladmBpYn+28qjVh0LaD3KER7z+lvsu/QOzNSzWMY1NR8/8CC+GBvJqSQhRCvmSjbab5qsUUJ92wZaXFwAk3FAVk1ngT4RWo5e08CgVSwB/2U8aXHwy/9XsOaTR41Y/uRl7Zi7H4s/aAsr7Gnlr2CQpgILpAZ9aTwvz2dRDZgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6faff792f9bso48099876d6.1;
        Mon, 09 Jun 2025 19:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749521438; x=1750126238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgFVpQSPIamoJ83eX+jqQTfc3LjadWZZ8RnIxJP2vBM=;
        b=j3aqev8g5OHEzlhihFytLJ7q37hGfNCgAmraKMM5IjAoaYKjQeQbfLLhToUem0atjb
         mqVrTXajRkDkWDzPeGRmjtTnlP4Vk2/gTD6uN6JFROOB+StSvtzA/u9X3K+ln7WC388w
         IyFVWWFhx5c5DUrNMHNkib5qx2W0ys9ZnpGSNsmE11mG+FY4OKqKaRTOFbjJWoGaNJR2
         TWxuPK2p3JbeT2prWBu39sTF4TrBVTYnQMfKq2cK5rLHVzmiTLYz8MX2WzfzZi1Wtv6z
         X2hfCTcmGGTaOgHRaCUmQfkS4HrDwekXuOvzSYX3usFf8+TcK2TndBuEwGUGp31whzo4
         j6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV07nN8CJtXkDZkYXs3DT0qYPlowV4ExcAgDScg7yEPPZ2ne4Lh7htR+Ge8hoJINIOEsx+ZwuAyuwmK44KGpMLs@vger.kernel.org, AJvYcCWS3m7q5X4YnkwC0HODYkn2dHRZtpU3e3LCDdIEmAXsRX7CNlw4zeHA6thXVpI22JMXQiQ2ji4802/UjGqv@vger.kernel.org, AJvYcCWgRaDwV4yyjB+0kAu16C4uuZ1KZoHCpxdpYhO3dkjDyMu+n9IKEBc8LmszD0VlY18vaiAZUrxw0N6nZgqf@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1F+us3/F0Nk4F6VdVrUcpa7UtBP0MPhm13a/7oSV29HWSoFU
	RUjqqCrB4qBJ6KfoThAWu87eWw/zUE9P8u+XjCJwndVhANU919m9SLiB
X-Gm-Gg: ASbGncsIskRA4/fsO9i4PJHa4oTKqgRQ4Q/Mbjq4v0v+nPZT9XZ+cqF7d8vQ+dlr09S
	91rozSUO2Gpj3P9mbVGL+dP7ce3CCeboiq6ukEM/U29T1Fn6ZNl/Bjv9SZRYS7/OW3h5oqwvXy8
	Ly53h1aIA1iLVq+WysbVFlOqyTMzCWUv5+K2PiAo4KGSsxtyqxwhh7HkBA9AwNoo+1qqNuzP7KG
	tNLa46jIrmzmBPreVPvwi3f2lCM0NCZBb9hfHktcIVpsBx1Yk4fYbcBPb7H2bxEO82mQPzSdxKc
	1XT1NNWtOU9ZlRe4AhjNl4ZHSkpPG5qQca3QRFp0HallNxd6Rus0MqTEfM2BngQHN+dPTv/oHzs
	0gnNay9mSahq1yb6Hz7a3UQ==
X-Google-Smtp-Source: AGHT+IEGBGjuXTdyD0YeMgSGEz748uRrth91BwIUUZQUHtCjGGSY8M+nCuXpUR7zWCsTj3PtcI4l+w==
X-Received: by 2002:a05:6214:2488:b0:6fa:ba15:e8a with SMTP id 6a1803df08f44-6fb24c4b51bmr14981186d6.8.1749521438097;
        Mon, 09 Jun 2025 19:10:38 -0700 (PDT)
Received: from localhost.localdomain (ip170.ip-51-81-44.us. [51.81.44.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b2a021sm59508786d6.83.2025.06.09.19.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 19:10:37 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 RESEND] selftests: filesystems: Add functional test for the abort file in fusectl
Date: Tue, 10 Jun 2025 10:10:03 +0800
Message-ID: <20250610021007.2800329-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch add a simple functional test for the "abort" file
in fusectlfs (/sys/fs/fuse/connections/ID/about).

A simple fuse daemon is added for testing.

Related discussion can be found in the link below.

Link: https://lore.kernel.org/all/CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com/
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
Changes in v3:
- Apply changes suggested by Amir Goldstein
  - Rename the test subdir to filesystems/fuse
  - Verify errno when connection is aborted
- Apply changes suggested by Shuah Khan
  - Update commit message
- Link to v2: https://lore.kernel.org/all/20250517012350.10317-2-chenlinxuan@uniontech.com/
Changes in v2:
- Apply changes suggested by Amir Goldstein
   - Check errno
- Link to v1: https://lore.kernel.org/all/20250515073449.346774-2-chenlinxuan@uniontech.com/
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fuse/.gitignore     |   3 +
 .../selftests/filesystems/fuse/Makefile       |  21 +++
 .../selftests/filesystems/fuse/fuse_mnt.c     | 146 ++++++++++++++++++
 .../selftests/filesystems/fuse/fusectl_test.c | 116 ++++++++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_mnt.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fusectl_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa163..04d90432c1841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9901,6 +9901,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse*
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
+F:	tools/testing/selftests/filesystems/fuse/
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 339b31e6a6b59..c37a76a8ca214 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -36,6 +36,7 @@ TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
 TARGETS += filesystems/mount-notify
+TARGETS += filesystems/fuse
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
new file mode 100644
index 0000000000000..3e72e742d08e8
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fuse_mnt
+fusectl_test
diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
new file mode 100644
index 0000000000000..612aad69a93aa
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/Makefile
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
diff --git a/tools/testing/selftests/filesystems/fuse/fuse_mnt.c b/tools/testing/selftests/filesystems/fuse/fuse_mnt.c
new file mode 100644
index 0000000000000..d12b17f30fadc
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fuse_mnt.c
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
diff --git a/tools/testing/selftests/filesystems/fuse/fusectl_test.c b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
new file mode 100644
index 0000000000000..7050fbe0970e7
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
@@ -0,0 +1,116 @@
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
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOTCONN);
+}
+
+TEST_HARNESS_MAIN
-- 
2.43.0


