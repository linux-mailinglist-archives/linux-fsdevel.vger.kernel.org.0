Return-Path: <linux-fsdevel+bounces-49833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE37AC37C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAAD1893792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 01:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63F13BC3F;
	Mon, 26 May 2025 01:43:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F322B9BC;
	Mon, 26 May 2025 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223824; cv=none; b=oUMNOUxaJ4TQm4AzECyGkSuBFFbfrhynuZN9hAp8sLu4e8mbrHMI7MLJOf+iB00xx8OyfOF0TzUC5fdnyWbqeTKsT5vRkM6pajAz//fz8AzjZsKQOn40XTF+epNR+Sxw6yZfM1hHhv9IGp0ga4110kcIjUj3Y4Z/IW5f4AtlhE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223824; c=relaxed/simple;
	bh=fyz2nEDEbWYdSIxpbtNzl/+mvDjI7RkRSAoZXJNpd4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5tcrSxxj3I+9o+I7uG/6eoVB8XCB/r4M9HMB2uClAfVRW6ZVSA9Z7Ey+YXfiKPVCZYcM0FnoricjykFPEJ3/4huMpx1cb5zwiPT51Ri8UjftdD0moIGXgqCXrBtQqWDFVbvaMUnRyLqcnuFYe7D1bGxiyM8uATxspM2ia+1tYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e5eb4a697so1441297b3.1;
        Sun, 25 May 2025 18:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748223821; x=1748828621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpJ7RTgZgpwm6jf6bC9XQp+u1j3Pk5lRyQ7bZfDffP0=;
        b=TnlraoeS2x2vnkt6KsicflQGM1oQejyyl8meeigJUogNgsY0w62RbseGnJ4sGPlz1s
         WUmItXn/oc2wc2AWrH/NiTEZPLRKhHVPfHZbmLUuZ9KnjKx0TPKDJEsyMHWYAT/HdrPM
         OdQnSkaDzKNPWbcIj14lr4AaxkQIOjo23X7uG+c20Xhfg7+9VP9I4UTMGBRwXVOdznAX
         vqek/LWAGyV+53ufXAHT2r/7aVx03vzE/t7Au8yppdL7YTocuP18DZzGscJOLAOvSkzE
         v32aH6rB8DGvFcEIRlqImBp1HjKzd6zX9cfUaAYpW7shp0DLnP8vTu6w6JXkd6YBIyDb
         ssvw==
X-Forwarded-Encrypted: i=1; AJvYcCUgwtKaE8iOcYkPNV3136tlUZRBPUuy+4uPanwg1Ok/E+WB9ooYq/j+XXIw1Ob/QNsWGY9EyXWpGLrRsTuk@vger.kernel.org, AJvYcCVNbfrXAbiKJ7c+aKlWXogPO8kK5NFceTYnTxtpLpURsmFzqEZ1Kk1kXmVrhiNhOCnaLDlrd7Jf7OyF5pbS@vger.kernel.org, AJvYcCXLd/M+NNCNLkU8xhVnP4cZ+Czl/v+XctMpdS12F3B+UlNWLk1QME3UD8kRhUJ5rvFy3fqHy+Wm+RHlfuUaoGUT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Ti3/B0O9j0jugks7R8ymw+U1qvGs3842we2awK8o/eWGWwEE
	TqWE0cCuCNYUn8KXyMsvG8UU0QRDXxDZJcq+E1A/DOJT8DM8sQ8rm5pJxs/RPw==
X-Gm-Gg: ASbGncuJVKZgSvCijl1Rkcx7hCoOcfaK09wb2ubScMEhKcdivO4SC4fjd1gmf31dz2N
	FkOfzh2QDmVT/EFws7Y6i2JkfILRG/3O4BiOf3bss1DrqC/jA2OIpnx8LTPRoIJ/Uk44rLoXYi4
	A3Y1pzK3HCFHgQiWQVXa/YETP4JGf5Cdjsyc3fkcA9DQ0tKU4KRYfO8fSK4oiuEv4FQEzcDsVr0
	uBPIqaiKzPnOMcOoooLCHsmMAJkuGuKCVvKT2BITcgDJ5Osk2T1mXhpKjG8CXPoPkSMUZUi6kUz
	KuYnH21cjAAadA7XoE7OVNE5XnmxZKv5WZdz4kM/f/kirG22ZObMLcKiD1OVbkkfGFO38ZGPq3K
	cwMZVVfmD/r8=
X-Google-Smtp-Source: AGHT+IHEICGzWp8IfG+SnDDcbOkeI073pYXL33D+eut7TRy2/2VFjSNveWgJYvssjNdJ0hGWgFbKmg==
X-Received: by 2002:a05:690c:6f08:b0:70d:ed5d:b4cb with SMTP id 00721157ae682-70e2d9a55c3mr77230547b3.18.1748223821011;
        Sun, 25 May 2025 18:43:41 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70e41f4cf92sm4363747b3.78.2025.05.25.18.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 18:43:40 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	wentao@uniontech.com,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] selftests: filesystems: Add functional test for the abort file in fusectl
Date: Mon, 26 May 2025 09:42:21 +0800
Message-ID: <20250526014226.14192-1-chenlinxuan@uniontech.com>
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
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
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
index dd844ac8d9107..55bf95f06dbb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9740,6 +9740,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 F:	Documentation/filesystems/fuse.rst
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
+F:	tools/testing/selftests/filesystems/fuse/
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 80fb84fa3cfcb..cadd4c217f3e0 100644
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


