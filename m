Return-Path: <linux-fsdevel+bounces-51427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C6AD6C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B85FE189F1EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98C22CBD9;
	Thu, 12 Jun 2025 09:41:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCCA1F4E57;
	Thu, 12 Jun 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721266; cv=none; b=LuIvsXTCGxcA4nksI9e0a62mDGx4eRLksuZJ/t3vkd3jAV6Z/Ef++k/HIqmm8pP95qMPdbtUAA5bsSoWevYvs5YjPWPHBMXZENZEy5QUiBsAu3JnVgnEcVDUdxEwONq2KjcAcJgfPlA7xqINyd4hMhgmtyyXmUkI59kPwRhPpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721266; c=relaxed/simple;
	bh=b/Go0e0SPBXelUR+Rblym1PzKoqWXhQb1Ibhst5qET8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DN1T/OfcC43wLbTupAAcyC6ia+yxLVhZPAa6DO3JAPLNekllkaBSO3FumsrGdP9J4faVvEYWW4jv3FQHkVZOUHLQANA7QSw0TPTz0YS9gSFGbNr4TfPP+0u51/r1Pv3lPN+C5WujK0bhWJF+ewY3DTk0MkQxjCfriWgswNLHops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so9117616d6.0;
        Thu, 12 Jun 2025 02:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721261; x=1750326061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZigkp6977n7o0kJ1uRvH0t8l9zBqkzAG20YexVIaxY=;
        b=goEKzveDAWGUz0RztNt5wNBBxlrjgSQPDuve9RZFViMJ/ZS9yYNm7mkmlbztdLVbU8
         /+6ygBjgkEOtW20WxgRgebr/ZH6BxYu8kqO9D96ZrcBxBRGVnuHNAtJx5ZiR2qnwLNw4
         +M3wpxYzJh2D97aq56qbvwgfTutTJxhk4xpOu7/9QOUgzOPkHGYPg3fL7WgcooVd5cHw
         9xCNoJYtFk/vlp1P5Kpobff8WL2BqqYBeoN0NrtGbEzv97Cl4UDTg2piByBNvS/i53H6
         NcLNgFKoFA/yZFPibICNUa09BAGrQ0yqRqtqfOyEePZPrJsdBTXxDMh/5h73etIbP88I
         N4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCFyUk6N+p1PzmEn2f37JjBalOzLUJLUIIzolSMUutAm2zxSJFHg3dQ3xlscVWUlaE8HmlSuDGGdugi1f@vger.kernel.org, AJvYcCVrnEWOVomK7ll3lkek/9Mnb8rIZw24qqMIYWesd51QfpFO3IZaRbLAe9O8sjoAh4/ZP5ZrwhGWQumut1cR@vger.kernel.org, AJvYcCX7Z3e1RW2AbfbzXDlbCLCAcS27caJq18jNyWtW8idCC1KjkYxcgEev2JCG84X3xOJaNVwZmgO5xgYDEpBADNSJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxwY4yWnfD/lWbIeACKs93JKv0ZNq1HmED5mrALhZnzw+o0z/zg
	p7QlGn/Dy8XWDAHO2FQ8AO1Rth4WIsk4SA8g5aJ3s8A2wdkJhwC0uq6d
X-Gm-Gg: ASbGnctgvuG/sNxunZstdNNsghb6kgryjijin3hfViGvYttAp8uqAq8F7bpzuX+a5xg
	7UbDHDM/RThRlv0a3SYn7LK5v4kIguGaRCl16QqBtkjCX1tZAV5BJ8UBmHlhXJOaJk33Z1tEQ65
	dViv51HlxW7CSQ4hCn7MPHibMUCIi3G6x77wR196WS9xYZHCqAJV+Zq1ZvThy1a4apZshL9JHQz
	GSAZ4TtpVtRYKu9uUQyf66oSAGSXDfOn0rGbs2Q2cZ53MexHxqQ2R81/NHj2CtsYtnaIHBBXfXg
	3DX5/P4nKvyYqLsv3kzufIE332B+L+n63hxDIp18jIYEdNyMT0ruWMwXcxeqemjkT9//qk8LlkW
	YasTuUeaewl/Da88cKZzi+A==
X-Google-Smtp-Source: AGHT+IFeiRJqQVCJDJGl8h55NyWwwtlNJX39DpyRFGVhACv3Tu5Nc9VbIVBmEVrP566QYRdRG02jkw==
X-Received: by 2002:a05:6214:4109:b0:6fa:a0af:7644 with SMTP id 6a1803df08f44-6fb2c365ff8mr117115046d6.27.1749721260797;
        Thu, 12 Jun 2025 02:41:00 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b30535sm8462806d6.38.2025.06.12.02.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:41:00 -0700 (PDT)
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
Subject: [PATCH v4] selftests: filesystems: Add functional test for the abort file in fusectl
Date: Thu, 12 Jun 2025 17:40:29 +0800
Message-ID: <20250612094033.2538122-2-chenlinxuan@uniontech.com>
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
Co-developed-by: Miklos Szeredi <miklos@szeredi.hu>
Reviewed-by: Miklos Szeredi <miklos@szeredi.hu>
---
Changes in v4:
- Apply patch suggested by Miklos Szeredi
  - Setting up a userns environment for testing
  - Fix a EBUSY on umount/rmdir
- Link to v3: https://lore.kernel.org/all/20250610021007.2800329-2-chenlinxuan@uniontech.com/
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
 .../selftests/filesystems/fuse/fusectl_test.c | 140 +++++++++++++++++
 6 files changed, 312 insertions(+)
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
index 0000000000000..8d124d1cacb26
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fuse/fusectl_test.c
@@ -0,0 +1,140 @@
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
+#include <sched.h>
+#include <linux/limits.h>
+
+#include "../../kselftest_harness.h"
+
+#define FUSECTL_MOUNTPOINT "/sys/fs/fuse/connections"
+#define FUSE_MOUNTPOINT "/tmp/fuse_mnt_XXXXXX"
+#define FUSE_DEVICE "/dev/fuse"
+#define FUSECTL_TEST_VALUE "1"
+
+static void write_file(struct __test_metadata *const _metadata,
+		       const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY);
+	size_t len = strlen(val);
+
+	ASSERT_GE(fd, 0);
+	ASSERT_EQ(write(fd, val, len), len);
+	ASSERT_EQ(close(fd), 0);
+}
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
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+	char buf[32];
+
+	/* Setup userns */
+	ASSERT_EQ(unshare(CLONE_NEWNS|CLONE_NEWUSER), 0);
+	sprintf(buf, "0 %d 1", uid);
+	write_file(_metadata, "/proc/self/uid_map", buf);
+	write_file(_metadata, "/proc/self/setgroups", "deny");
+	sprintf(buf, "0 %d 1", gid);
+	write_file(_metadata, "/proc/self/gid_map", buf);
+	ASSERT_EQ(mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL), 0);
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
+	umount2(self->fuse_mountpoint, MNT_DETACH);
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


