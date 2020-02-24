Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F8C16AACD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBXQKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 11:10:21 -0500
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:54075 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgBXQKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:10:20 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id ED8F41003709C;
        Mon, 24 Feb 2020 17:02:33 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48R6K53HsjzlnBxx;
        Mon, 24 Feb 2020 17:02:33 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [RFC PATCH v14 08/10] selftests/landlock: Add initial tests
Date:   Mon, 24 Feb 2020 17:02:13 +0100
Message-Id: <20200224160215.4136-9-mic@digikod.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224160215.4136-1-mic@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Test landlock syscall, ptrace hooks semantic and filesystem
access-control.

This is an initial batch, more tests will follow.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Changes since v13:
* Add back the filesystem tests (from v10) and extend them.
* Add tests for the new syscall.

Previous version:
https://lore.kernel.org/lkml/20191104172146.30797-7-mic@digikod.net/
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/landlock/.gitignore   |   3 +
 tools/testing/selftests/landlock/Makefile     |  13 +
 tools/testing/selftests/landlock/config       |   4 +
 tools/testing/selftests/landlock/test.h       |  40 ++
 tools/testing/selftests/landlock/test_base.c  |  80 +++
 tools/testing/selftests/landlock/test_fs.c    | 624 ++++++++++++++++++
 .../testing/selftests/landlock/test_ptrace.c  | 293 ++++++++
 8 files changed, 1058 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/test.h
 create mode 100644 tools/testing/selftests/landlock/test_base.c
 create mode 100644 tools/testing/selftests/landlock/test_fs.c
 create mode 100644 tools/testing/selftests/landlock/test_ptrace.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6ec503912bea..5183f269c244 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -24,6 +24,7 @@ TARGETS += ir
 TARGETS += kcmp
 TARGETS += kexec
 TARGETS += kvm
+TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
diff --git a/tools/testing/selftests/landlock/.gitignore b/tools/testing/selftests/landlock/.gitignore
new file mode 100644
index 000000000000..4ee53c733af0
--- /dev/null
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -0,0 +1,3 @@
+/test_base
+/test_fs
+/test_ptrace
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
new file mode 100644
index 000000000000..c7e26e1251c4
--- /dev/null
+++ b/tools/testing/selftests/landlock/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+test_src := $(wildcard test_*.c)
+
+TEST_GEN_PROGS := $(test_src:.c=)
+
+usr_include := ../../../../usr/include
+
+CFLAGS += -Wall -O2 -I$(usr_include)
+
+include ../lib.mk
+
+$(TEST_GEN_PROGS): ../kselftest_harness.h $(usr_include)/linux/landlock.h
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
new file mode 100644
index 000000000000..662f72c5a0df
--- /dev/null
+++ b/tools/testing/selftests/landlock/config
@@ -0,0 +1,4 @@
+CONFIG_HEADERS_INSTALL=y
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_PATH=y
+CONFIG_SECURITY=y
diff --git a/tools/testing/selftests/landlock/test.h b/tools/testing/selftests/landlock/test.h
new file mode 100644
index 000000000000..f9cebd8fc169
--- /dev/null
+++ b/tools/testing/selftests/landlock/test.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock test helpers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#include <errno.h>
+#include <sys/syscall.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef landlock
+static inline int landlock(unsigned int command, unsigned int options,
+		size_t attr_size, void *attr_ptr)
+{
+	errno = 0;
+	return syscall(__NR_landlock, command, options, attr_size, attr_ptr, 0,
+			NULL);
+}
+#endif
+
+FIXTURE(ruleset_rw) {
+	struct landlock_attr_ruleset attr_ruleset;
+	int ruleset_fd;
+};
+
+FIXTURE_SETUP(ruleset_rw) {
+	self->attr_ruleset.handled_access_fs = LANDLOCK_ACCESS_FS_READ |
+		LANDLOCK_ACCESS_FS_WRITE;
+	self->ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET,
+			sizeof(self->attr_ruleset), &self->attr_ruleset);
+	ASSERT_LE(0, self->ruleset_fd);
+}
+
+FIXTURE_TEARDOWN(ruleset_rw) {
+	ASSERT_EQ(0, close(self->ruleset_fd));
+}
diff --git a/tools/testing/selftests/landlock/test_base.c b/tools/testing/selftests/landlock/test_base.c
new file mode 100644
index 000000000000..1ac7dbead3b2
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_base.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - common resources
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sys/prctl.h>
+
+#include "test.h"
+
+#define FDINFO_TEMPLATE "/proc/self/fdinfo/%d"
+#define FDINFO_SIZE 128
+
+#ifndef O_PATH
+#define O_PATH		010000000
+#endif
+
+TEST_F(ruleset_rw, fdinfo)
+{
+	int fdinfo_fd, fdinfo_path_size, fdinfo_buf_size;
+	char fdinfo_path[sizeof(FDINFO_TEMPLATE) + 2];
+	char fdinfo_buf[FDINFO_SIZE];
+
+	fdinfo_path_size = snprintf(fdinfo_path, sizeof(fdinfo_path),
+			FDINFO_TEMPLATE, self->ruleset_fd);
+	ASSERT_LE(fdinfo_path_size, sizeof(fdinfo_path));
+
+	fdinfo_fd = open(fdinfo_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fdinfo_fd, 0);
+
+	fdinfo_buf_size = read(fdinfo_fd, fdinfo_buf, sizeof(fdinfo_buf));
+	ASSERT_LE(fdinfo_buf_size, sizeof(fdinfo_buf) - 1);
+
+	/*
+	 * fdinfo_buf: pos:        0
+	 * flags:  02000002
+	 * mnt_id: 13
+	 * handled_access_fs:     804000
+	 */
+	EXPECT_EQ(0, close(fdinfo_fd));
+}
+
+TEST(features)
+{
+	struct landlock_attr_features attr_features = {
+		.options_get_features = ~0ULL,
+		.options_create_ruleset = ~0ULL,
+		.options_add_rule = ~0ULL,
+		.options_enforce_ruleset = ~0ULL,
+		.access_fs = ~0ULL,
+		.size_attr_ruleset = ~0ULL,
+		.size_attr_path_beneath = ~0ULL,
+	};
+
+	ASSERT_EQ(0, landlock(LANDLOCK_CMD_GET_FEATURES,
+				LANDLOCK_OPT_CREATE_RULESET,
+				sizeof(attr_features), &attr_features));
+	ASSERT_EQ(((LANDLOCK_OPT_GET_FEATURES << 1) - 1),
+			attr_features.options_get_features);
+	ASSERT_EQ(((LANDLOCK_OPT_CREATE_RULESET << 1) - 1),
+			attr_features.options_create_ruleset);
+	ASSERT_EQ(((LANDLOCK_OPT_ADD_RULE_PATH_BENEATH << 1) - 1),
+			attr_features.options_add_rule);
+	ASSERT_EQ(((LANDLOCK_OPT_ENFORCE_RULESET << 1) - 1),
+			attr_features.options_enforce_ruleset);
+	ASSERT_EQ(((LANDLOCK_ACCESS_FS_MAP << 1) - 1),
+			attr_features.access_fs);
+	ASSERT_EQ(sizeof(struct landlock_attr_ruleset),
+		attr_features.size_attr_ruleset);
+	ASSERT_EQ(sizeof(struct landlock_attr_path_beneath),
+		attr_features.size_attr_path_beneath);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/test_fs.c b/tools/testing/selftests/landlock/test_fs.c
new file mode 100644
index 000000000000..627cb3a71f89
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_fs.c
@@ -0,0 +1,624 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - filesystem
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <sched.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test.h"
+
+#define TMP_PREFIX "tmp_"
+
+/* Paths (sibling number and depth) */
+const char dir_s0_d1[] = TMP_PREFIX "a0";
+const char dir_s0_d2[] = TMP_PREFIX "a0/b0";
+const char dir_s0_d3[] = TMP_PREFIX "a0/b0/c0";
+const char dir_s1_d1[] = TMP_PREFIX "a1";
+const char dir_s2_d1[] = TMP_PREFIX "a2";
+const char dir_s2_d2[] = TMP_PREFIX "a2/b2";
+
+/* dir_s3_d1 is a tmpfs mount. */
+const char dir_s3_d1[] = TMP_PREFIX "a3";
+const char dir_s3_d2[] = TMP_PREFIX "a3/b3";
+
+/* dir_s4_d2 is a tmpfs mount. */
+const char dir_s4_d1[] = TMP_PREFIX "a4";
+const char dir_s4_d2[] = TMP_PREFIX "a4/b4";
+
+static void cleanup_layout1(void)
+{
+	rmdir(dir_s2_d2);
+	rmdir(dir_s2_d1);
+	rmdir(dir_s1_d1);
+	rmdir(dir_s0_d3);
+	rmdir(dir_s0_d2);
+	rmdir(dir_s0_d1);
+
+	/* dir_s3_d2 may be bind mounted */
+	umount(dir_s3_d2);
+	rmdir(dir_s3_d2);
+	umount(dir_s3_d1);
+	rmdir(dir_s3_d1);
+
+	umount(dir_s4_d2);
+	rmdir(dir_s4_d2);
+	rmdir(dir_s4_d1);
+}
+
+FIXTURE(layout1) {
+};
+
+FIXTURE_SETUP(layout1)
+{
+	cleanup_layout1();
+
+	/* Do not pollute the rest of the system. */
+	ASSERT_NE(-1, unshare(CLONE_NEWNS));
+
+	ASSERT_EQ(0, mkdir(dir_s0_d1, 0600));
+	ASSERT_EQ(0, mkdir(dir_s0_d2, 0600));
+	ASSERT_EQ(0, mkdir(dir_s0_d3, 0600));
+	ASSERT_EQ(0, mkdir(dir_s1_d1, 0600));
+	ASSERT_EQ(0, mkdir(dir_s2_d1, 0600));
+	ASSERT_EQ(0, mkdir(dir_s2_d2, 0600));
+
+	ASSERT_EQ(0, mkdir(dir_s3_d1, 0600));
+	ASSERT_EQ(0, mount("tmp", dir_s3_d1, "tmpfs", 0, NULL));
+	ASSERT_EQ(0, mkdir(dir_s3_d2, 0600));
+
+	ASSERT_EQ(0, mkdir(dir_s4_d1, 0600));
+	ASSERT_EQ(0, mkdir(dir_s4_d2, 0600));
+	ASSERT_EQ(0, mount("tmp", dir_s4_d2, "tmpfs", 0, NULL));
+}
+
+FIXTURE_TEARDOWN(layout1)
+{
+	/*
+	 * cleanup_layout1() would be denied here, use TEST(cleanup) instead.
+	 */
+}
+
+static void test_path_rel(struct __test_metadata *_metadata, int dirfd,
+		const char *path, int ret)
+{
+	int fd;
+	struct stat statbuf;
+
+	/* faccessat() can not be restricted for now */
+	ASSERT_EQ(ret, fstatat(dirfd, path, &statbuf, 0)) {
+		TH_LOG("fstatat path \"%s\" returned %s\n", path,
+				strerror(errno));
+	}
+	if (ret) {
+		ASSERT_EQ(EACCES, errno);
+	}
+	fd = openat(dirfd, path, O_DIRECTORY);
+	if (ret) {
+		ASSERT_EQ(-1, fd);
+		ASSERT_EQ(EACCES, errno);
+	} else {
+		ASSERT_NE(-1, fd);
+		EXPECT_EQ(0, close(fd));
+	}
+}
+
+static void test_path(struct __test_metadata *_metadata, const char *path,
+		int ret)
+{
+	return test_path_rel(_metadata, AT_FDCWD, path, ret);
+}
+
+TEST_F(layout1, no_restriction)
+{
+	test_path(_metadata, dir_s0_d1, 0);
+	test_path(_metadata, dir_s0_d2, 0);
+	test_path(_metadata, dir_s0_d3, 0);
+	test_path(_metadata, dir_s1_d1, 0);
+	test_path(_metadata, dir_s2_d2, 0);
+}
+
+TEST_F(ruleset_rw, inval)
+{
+	int err;
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ |
+			LANDLOCK_ACCESS_FS_WRITE,
+		.parent_fd = -1,
+	};
+	struct landlock_attr_enforce attr_enforce;
+
+	path_beneath.ruleset_fd = self->ruleset_fd;
+	path_beneath.parent_fd = open(dir_s0_d2, O_PATH | O_NOFOLLOW |
+			O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Tests without O_PATH. */
+	path_beneath.parent_fd = open(dir_s0_d2, O_NOFOLLOW | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(err, -1);
+	ASSERT_EQ(errno, EBADR);
+	errno = 0;
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Checks un-handled access. */
+	path_beneath.parent_fd = open(dir_s0_d2, O_PATH | O_NOFOLLOW |
+			O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(errno, EINVAL);
+	errno = 0;
+	ASSERT_EQ(err, -1);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+
+	attr_enforce.ruleset_fd = self->ruleset_fd;
+	err = landlock(LANDLOCK_CMD_ENFORCE_RULESET,
+			LANDLOCK_OPT_ENFORCE_RULESET, sizeof(attr_enforce),
+			&attr_enforce);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+}
+
+TEST_F(ruleset_rw, nsfs)
+{
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ |
+			LANDLOCK_ACCESS_FS_WRITE,
+		.ruleset_fd = self->ruleset_fd,
+	};
+	int err;
+
+	path_beneath.parent_fd = open("/proc/self/ns/mnt", O_PATH | O_NOFOLLOW |
+			O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+static void add_path_beneath(struct __test_metadata *_metadata, int ruleset_fd,
+		__u64 allowed_access, const char *path)
+{
+	int err;
+	struct landlock_attr_path_beneath path_beneath = {
+		.ruleset_fd = ruleset_fd,
+		.allowed_access = allowed_access,
+	};
+
+	path_beneath.parent_fd = open(path, O_PATH | O_NOFOLLOW | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0) {
+		TH_LOG("Failed to open directory \"%s\": %s\n", path,
+				strerror(errno));
+	}
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(err, 0) {
+		TH_LOG("Failed to update the ruleset with \"%s\": %s\n",
+				path, strerror(errno));
+	}
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+static int create_ruleset(struct __test_metadata *_metadata,
+		const char *const dirs[])
+{
+	int ruleset_fd, dirs_len, i;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs =
+			LANDLOCK_ACCESS_FS_OPEN |
+			LANDLOCK_ACCESS_FS_READ |
+			LANDLOCK_ACCESS_FS_WRITE |
+			LANDLOCK_ACCESS_FS_EXECUTE |
+			LANDLOCK_ACCESS_FS_GETATTR
+	};
+	__u64 allowed_access =
+			LANDLOCK_ACCESS_FS_OPEN |
+			LANDLOCK_ACCESS_FS_READ |
+			LANDLOCK_ACCESS_FS_GETATTR;
+
+	ASSERT_NE(NULL, dirs) {
+		TH_LOG("No directory list\n");
+	}
+	ASSERT_NE(NULL, dirs[0]) {
+		TH_LOG("Empty directory list\n");
+	}
+	/* Gets the number of dir entries. */
+	for (dirs_len = 0; dirs[dirs_len]; dirs_len++);
+
+	ASSERT_EQ(0, landlock(LANDLOCK_CMD_GET_FEATURES,
+				LANDLOCK_OPT_GET_FEATURES,
+				sizeof(attr_features), &attr_features));
+	/* Only for test, use a binary AND for real application instead. */
+	ASSERT_EQ(attr_ruleset.handled_access_fs,
+			attr_ruleset.handled_access_fs &
+			attr_features.access_fs);
+	ASSERT_EQ(allowed_access, allowed_access & attr_features.access_fs);
+	ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET, sizeof(attr_ruleset),
+			&attr_ruleset);
+	ASSERT_GE(ruleset_fd, 0) {
+		TH_LOG("Failed to create a ruleset: %s\n", strerror(errno));
+	}
+
+	for (i = 0; dirs[i]; i++) {
+		add_path_beneath(_metadata, ruleset_fd, allowed_access,
+				dirs[i]);
+	}
+	return ruleset_fd;
+}
+
+static void enforce_ruleset(struct __test_metadata *_metadata, int ruleset_fd)
+{
+	struct landlock_attr_enforce attr_enforce = {
+		.ruleset_fd = ruleset_fd,
+	};
+	int err;
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+
+	err = landlock(LANDLOCK_CMD_ENFORCE_RULESET,
+			LANDLOCK_OPT_ENFORCE_RULESET, sizeof(attr_enforce),
+			&attr_enforce);
+	ASSERT_EQ(err, 0) {
+		TH_LOG("Failed to enforce ruleset: %s\n", strerror(errno));
+	}
+	ASSERT_EQ(errno, 0);
+}
+
+TEST_F(layout1, whitelist)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s0_d2, dir_s1_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, "/", -1);
+	test_path(_metadata, dir_s0_d1, -1);
+	test_path(_metadata, dir_s0_d2, 0);
+	test_path(_metadata, dir_s0_d3, 0);
+}
+
+TEST_F(layout1, unhandled_access)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s0_d2, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Because the policy does not handled LANDLOCK_ACCESS_FS_CHROOT,
+	 * chroot(2) should be allowed.
+	 */
+	ASSERT_EQ(0, chroot(dir_s0_d1));
+	ASSERT_EQ(0, chroot(dir_s0_d2));
+	ASSERT_EQ(0, chroot(dir_s0_d3));
+}
+
+TEST_F(layout1, ruleset_overlap)
+{
+	struct stat statbuf;
+	int open_fd;
+	int ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s1_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	/* These rules should be ORed among them. */
+	add_path_beneath(_metadata, ruleset_fd,
+			LANDLOCK_ACCESS_FS_GETATTR, dir_s0_d2);
+	add_path_beneath(_metadata, ruleset_fd,
+			LANDLOCK_ACCESS_FS_OPEN, dir_s0_d2);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d1, &statbuf, 0));
+	ASSERT_EQ(-1, openat(AT_FDCWD, dir_s0_d1, O_DIRECTORY));
+	ASSERT_EQ(0, fstatat(AT_FDCWD, dir_s0_d2, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d2, O_DIRECTORY);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	ASSERT_EQ(0, fstatat(AT_FDCWD, dir_s0_d3, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d3, O_DIRECTORY);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+}
+
+TEST_F(layout1, inherit_superset)
+{
+	struct stat statbuf;
+	int ruleset_fd, open_fd;
+
+	ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s1_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	add_path_beneath(_metadata, ruleset_fd,
+			LANDLOCK_ACCESS_FS_OPEN, dir_s0_d2);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d1, &statbuf, 0));
+	ASSERT_EQ(-1, openat(AT_FDCWD, dir_s0_d1, O_DIRECTORY));
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d2, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d2, O_DIRECTORY);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d3, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d3, O_DIRECTORY);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/*
+	 * Test shared rule extension: the following rules should not grant any
+	 * new access, only remove some.  Once enforced, these rules are ANDed
+	 * with the previous ones.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_GETATTR,
+			dir_s0_d2);
+	/*
+	 * In ruleset_fd, dir_s0_d2 should now have the LANDLOCK_ACCESS_FS_OPEN
+	 * and LANDLOCK_ACCESS_FS_GETATTR access rights (even if this directory
+	 * is opened a second time).  However, when enforcing this updated
+	 * ruleset, the ruleset tied to the current process will still only
+	 * have the dir_s0_d2 with LANDLOCK_ACCESS_FS_OPEN access,
+	 * LANDLOCK_ACCESS_FS_GETATTR must not be allowed because it would be a
+	 * privilege escalation.
+	 */
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d1, &statbuf, 0));
+	ASSERT_EQ(-1, openat(AT_FDCWD, dir_s0_d1, O_DIRECTORY));
+
+	/* It is still forbiden to fstat(dir_s0_d2). */
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d2, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d2, O_DIRECTORY);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d3, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d3, O_DIRECTORY);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/*
+	 * Now, dir_s0_d3 get a new rule tied to it, only allowing
+	 * LANDLOCK_ACCESS_FS_GETATTR.  The kernel internal difference is that
+	 * there was no rule tied to it before.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_GETATTR,
+			dir_s0_d3);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Same tests and results as above, except for open(dir_s0_d3) which is
+	 * now denied because the new rule mask the rule previously inherited
+	 * from dir_s0_d2.
+	 */
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d1, &statbuf, 0));
+	ASSERT_EQ(-1, openat(AT_FDCWD, dir_s0_d1, O_DIRECTORY));
+
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d2, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d2, O_DIRECTORY);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbiden to fstat(dir_s0_d3). */
+	ASSERT_EQ(-1, fstatat(AT_FDCWD, dir_s0_d3, &statbuf, 0));
+	open_fd = openat(AT_FDCWD, dir_s0_d3, O_DIRECTORY);
+	/* open(dir_s0_d3) is now forbidden. */
+	ASSERT_EQ(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F(layout1, extend_ruleset_with_denied_path)
+{
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_GETATTR,
+	};
+
+	path_beneath.ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s0_d2, NULL });
+	ASSERT_NE(-1, path_beneath.ruleset_fd);
+	enforce_ruleset(_metadata, path_beneath.ruleset_fd);
+
+	ASSERT_EQ(-1, open(dir_s0_d1, O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Tests that we can't create a rule for which we are not allowed to
+	 * open its path.
+	 */
+	path_beneath.parent_fd = open(dir_s0_d1, O_PATH | O_NOFOLLOW
+			| O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	ASSERT_EQ(-1, landlock(LANDLOCK_CMD_ADD_RULE,
+				LANDLOCK_OPT_CREATE_RULESET,
+				sizeof(path_beneath), &path_beneath));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	EXPECT_EQ(0, close(path_beneath.ruleset_fd));
+}
+
+TEST_F(layout1, rule_on_mountpoint)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s0_d1, dir_s3_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, dir_s1_d1, -1);
+	test_path(_metadata, dir_s0_d1, 0);
+	test_path(_metadata, dir_s3_d1, 0);
+}
+
+TEST_F(layout1, rule_over_mountpoint)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+			(const char *const []){ dir_s4_d1, dir_s0_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, dir_s4_d2, 0);
+	test_path(_metadata, dir_s0_d1, 0);
+	test_path(_metadata, dir_s4_d1, 0);
+}
+
+/*
+ * This test verifies that we can apply a landlock rule on the root (/), it
+ * might require special handling.
+ */
+TEST_F(layout1, rule_over_root)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+		(const char *const []){ "/", NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, "/", 0);
+	test_path(_metadata, dir_s0_d1, 0);
+}
+
+TEST_F(layout1, rule_inside_mount_ns)
+{
+	ASSERT_NE(-1, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_NE(-1, syscall(SYS_pivot_root, dir_s3_d1, dir_s3_d2));
+	ASSERT_NE(-1, chdir("/"));
+
+	int ruleset_fd = create_ruleset(_metadata,
+		(const char *const []){ "b3", NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, "b3", 0);
+	test_path(_metadata, "/", -1);
+}
+
+TEST_F(layout1, mount_and_pivot)
+{
+	int ruleset_fd = create_ruleset(_metadata,
+		(const char *const []){ dir_s3_d1, NULL });
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3_d1, dir_s3_d2));
+}
+
+enum relative_access {
+	REL_OPEN,
+	REL_CHDIR,
+	REL_CHROOT,
+};
+
+static void check_access(struct __test_metadata *_metadata,
+		bool enforce, enum relative_access rel)
+{
+	int dirfd;
+	int ruleset_fd = -1;
+
+	if (enforce) {
+		ruleset_fd = create_ruleset(_metadata, (const char *const []){
+				dir_s0_d2, dir_s1_d1, NULL });
+		ASSERT_NE(-1, ruleset_fd);
+		if (rel == REL_CHROOT)
+			ASSERT_NE(-1, chdir(dir_s0_d2));
+		enforce_ruleset(_metadata, ruleset_fd);
+	} else if (rel == REL_CHROOT)
+		ASSERT_NE(-1, chdir(dir_s0_d2));
+	switch (rel) {
+	case REL_OPEN:
+		dirfd = open(dir_s0_d2, O_DIRECTORY);
+		ASSERT_NE(-1, dirfd);
+		break;
+	case REL_CHDIR:
+		ASSERT_NE(-1, chdir(dir_s0_d2));
+		dirfd = AT_FDCWD;
+		break;
+	case REL_CHROOT:
+		ASSERT_NE(-1, chroot(".")) {
+			TH_LOG("Failed to chroot: %s\n", strerror(errno));
+		}
+		dirfd = AT_FDCWD;
+		break;
+	default:
+		ASSERT_TRUE(false);
+		return;
+	}
+
+	test_path_rel(_metadata, dirfd, "..", (rel == REL_CHROOT) ? 0 : -1);
+	test_path_rel(_metadata, dirfd, ".", 0);
+	if (rel != REL_CHROOT) {
+		test_path_rel(_metadata, dirfd, "./c0", 0);
+		test_path_rel(_metadata, dirfd, "../../" TMP_PREFIX "a1", 0);
+		test_path_rel(_metadata, dirfd, "../../" TMP_PREFIX "a2", -1);
+	}
+
+	if (rel == REL_OPEN)
+		EXPECT_EQ(0, close(dirfd));
+	if (enforce)
+		EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F(layout1, deny_open)
+{
+	check_access(_metadata, true, REL_OPEN);
+}
+
+TEST_F(layout1, deny_chdir)
+{
+	check_access(_metadata, true, REL_CHDIR);
+}
+
+TEST_F(layout1, deny_chroot)
+{
+	check_access(_metadata, true, REL_CHROOT);
+}
+
+TEST(cleanup)
+{
+	cleanup_layout1();
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/test_ptrace.c b/tools/testing/selftests/landlock/test_ptrace.c
new file mode 100644
index 000000000000..fcdb41e172d1
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_ptrace.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - ptrace
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <signal.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "test.h"
+
+static void create_domain(struct __test_metadata *_metadata)
+{
+	int ruleset_fd, err;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_enforce attr_enforce;
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ,
+	};
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ,
+	};
+
+	ASSERT_EQ(0, landlock(LANDLOCK_CMD_GET_FEATURES,
+				LANDLOCK_OPT_GET_FEATURES,
+				sizeof(attr_features), &attr_features));
+	/* Only for test, use a binary AND for real application instead. */
+	ASSERT_EQ(attr_ruleset.handled_access_fs,
+			attr_ruleset.handled_access_fs &
+			attr_features.access_fs);
+	ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET, sizeof(attr_ruleset),
+			&attr_ruleset);
+	ASSERT_GE(ruleset_fd, 0) {
+		TH_LOG("Failed to create a ruleset: %s\n", strerror(errno));
+	}
+	path_beneath.ruleset_fd = ruleset_fd;
+	path_beneath.parent_fd = open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY
+			| O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+
+	attr_enforce.ruleset_fd = ruleset_fd;
+	err = landlock(LANDLOCK_CMD_ENFORCE_RULESET,
+			LANDLOCK_OPT_ENFORCE_RULESET, sizeof(attr_enforce),
+			&attr_enforce);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(errno, 0);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+/* test PTRACE_TRACEME and PTRACE_ATTACH for parent and child */
+static void check_ptrace(struct __test_metadata *_metadata,
+		bool domain_both, bool domain_parent, bool domain_child)
+{
+	pid_t child, parent;
+	int status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	parent = getpid();
+	ASSERT_EQ(0, pipe(pipe_child));
+	ASSERT_EQ(0, pipe(pipe_parent));
+	if (domain_both)
+		create_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+		if (domain_child)
+			create_domain(_metadata);
+
+		/* sync #1 */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1)) {
+			TH_LOG("Failed to read() sync #1 from parent");
+		}
+		ASSERT_EQ('.', buf_child);
+
+		/* Tests the parent protection. */
+		ASSERT_EQ(domain_child ? -1 : 0,
+				ptrace(PTRACE_ATTACH, parent, NULL, 0));
+		if (domain_child) {
+			ASSERT_EQ(EPERM, errno);
+		} else {
+			ASSERT_EQ(parent, waitpid(parent, &status, 0));
+			ASSERT_EQ(1, WIFSTOPPED(status));
+			ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
+		}
+
+		/* sync #2 */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1)) {
+			TH_LOG("Failed to write() sync #2 to parent");
+		}
+
+		/* Tests traceme. */
+		ASSERT_EQ(domain_parent ? -1 : 0, ptrace(PTRACE_TRACEME));
+		if (domain_parent) {
+			ASSERT_EQ(EPERM, errno);
+		} else {
+			ASSERT_EQ(0, raise(SIGSTOP));
+		}
+
+		/* sync #3 */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1)) {
+			TH_LOG("Failed to read() sync #3 from parent");
+		}
+		ASSERT_EQ('.', buf_child);
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+	}
+
+	EXPECT_EQ(0, close(pipe_child[1]));
+	EXPECT_EQ(0, close(pipe_parent[0]));
+	if (domain_parent)
+		create_domain(_metadata);
+
+	/* sync #1 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1)) {
+		TH_LOG("Failed to write() sync #1 to child");
+	}
+
+	/* Tests the parent protection. */
+	/* sync #2 */
+	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1)) {
+		TH_LOG("Failed to read() sync #2 from child");
+	}
+	ASSERT_EQ('.', buf_parent);
+
+	/* Tests traceme. */
+	if (!domain_parent) {
+		ASSERT_EQ(child, waitpid(child, &status, 0));
+		ASSERT_EQ(1, WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	}
+	/* Tests attach. */
+	ASSERT_EQ(domain_parent ? -1 : 0,
+			ptrace(PTRACE_ATTACH, child, NULL, 0));
+	if (domain_parent) {
+		ASSERT_EQ(EPERM, errno);
+	} else {
+		ASSERT_EQ(child, waitpid(child, &status, 0));
+		ASSERT_EQ(1, WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	}
+
+	/* sync #3 */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1)) {
+		TH_LOG("Failed to write() sync #3 to child");
+	}
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || WEXITSTATUS(status))
+		_metadata->passed = 0;
+}
+
+/*
+ * Test multiple tracing combinations between a parent process P1 and a child
+ * process P2.
+ *
+ * Yama's scoped ptrace is presumed disabled.  If enabled, this optional
+ * restriction is enforced in addition to any Landlock check, which means that
+ * all P2 requests to trace P1 would be denied.
+ */
+
+/*
+ *        No domain
+ *
+ *   P1-.               P1 -> P2 : allow
+ *       \              P2 -> P1 : allow
+ *        'P2
+ */
+TEST(allow_without_domain) {
+	check_ptrace(_metadata, false, false, false);
+}
+
+/*
+ *        Child domain
+ *
+ *   P1--.              P1 -> P2 : allow
+ *        \             P2 -> P1 : deny
+ *        .'-----.
+ *        |  P2  |
+ *        '------'
+ */
+TEST(allow_with_one_domain) {
+	check_ptrace(_metadata, false, false, true);
+}
+
+/*
+ *        Parent domain
+ * .------.
+ * |  P1  --.           P1 -> P2 : deny
+ * '------'  \          P2 -> P1 : allow
+ *            '
+ *            P2
+ */
+TEST(deny_with_parent_domain) {
+	check_ptrace(_metadata, false, true, false);
+}
+
+/*
+ *        Parent + child domain (siblings)
+ * .------.
+ * |  P1  ---.          P1 -> P2 : deny
+ * '------'   \         P2 -> P1 : deny
+ *         .---'--.
+ *         |  P2  |
+ *         '------'
+ */
+TEST(deny_with_sibling_domain) {
+	check_ptrace(_metadata, false, true, true);
+}
+
+/*
+ *         Same domain (inherited)
+ * .-------------.
+ * | P1----.     |      P1 -> P2 : allow
+ * |        \    |      P2 -> P1 : allow
+ * |         '   |
+ * |         P2  |
+ * '-------------'
+ */
+TEST(allow_sibling_domain) {
+	check_ptrace(_metadata, true, false, false);
+}
+
+/*
+ *         Inherited + child domain
+ * .-----------------.
+ * |  P1----.        |  P1 -> P2 : allow
+ * |         \       |  P2 -> P1 : deny
+ * |        .-'----. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+TEST(allow_with_nested_domain) {
+	check_ptrace(_metadata, true, false, true);
+}
+
+/*
+ *         Inherited + parent domain
+ * .-----------------.
+ * |.------.         |  P1 -> P2 : deny
+ * ||  P1  ----.     |  P2 -> P1 : allow
+ * |'------'    \    |
+ * |             '   |
+ * |             P2  |
+ * '-----------------'
+ */
+TEST(deny_with_nested_and_parent_domain) {
+	check_ptrace(_metadata, true, true, false);
+}
+
+/*
+ *         Inherited + parent and child domain (siblings)
+ * .-----------------.
+ * | .------.        |  P1 -> P2 : deny
+ * | |  P1  .        |  P2 -> P1 : deny
+ * | '------'\       |
+ * |          \      |
+ * |        .--'---. |
+ * |        |  P2  | |
+ * |        '------' |
+ * '-----------------'
+ */
+TEST(deny_with_forked_domain) {
+	check_ptrace(_metadata, true, true, true);
+}
+
+TEST_HARNESS_MAIN
-- 
2.25.0

