Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8E1948D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgCZU17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 16:27:59 -0400
Received: from smtp-190f.mail.infomaniak.ch ([185.125.25.15]:57439 "EHLO
        smtp-190f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728788AbgCZU17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:27:59 -0400
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 48pGkt1Wz8zlhZq1;
        Thu, 26 Mar 2020 21:27:50 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 48pGks5VrNzljcyd;
        Thu, 26 Mar 2020 21:27:49 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
Subject: [PATCH v15 08/10] selftests/landlock: Add initial tests
Date:   Thu, 26 Mar 2020 21:27:29 +0100
Message-Id: <20200326202731.693608-9-mic@digikod.net>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200326202731.693608-1-mic@digikod.net>
References: <20200326202731.693608-1-mic@digikod.net>
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

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Changes since v14:
* Add new tests:
  - Compatibility: empty_attr_{ruleset,path_beneath,enforce} to check
    minimal attr size.
  - Access types: link_to, rename_from, rename_to, rmdir, unlink,
    make_char, make_block, make_reg, make_sock, make_fifo, make_sym,
    make_dir, chroot, execute.
  - Test privilege escalation prevention by enforcing a nested rule, on
    a parent directory, with less restrictions than one on a child
    directory.
  - Test for empty and more than 32-bits allowed_access
* Merge the two test mount hierarchies.
* Complete relative path tests by combining chdir and chroot.
* Adjust tests:
  - Remove the layout1/extend_ruleset_with_denied_path test.
  - Extend layout1/whitelist test with checks on file.
  - Add and use create_dir_and_file().
* Only use read/write checks but not stat(2) for tests.
* Rename test.h to common.h and improve it.
* Rename path name to make them more consistent, easy to understand and
  make them in a common directory.
* Make create_ruleset() more generic.
* Constify variables.
* Re-add static global variables.
* Remove useless openat(2).
* Fix and complete kernel config.
* Set umask and clean up file modes.
* Clean up open flags.
* Improve Makefile.
* Fix spelling.
* Improve comments and error messages.

Changes since v13:
* Add back the filesystem tests (from v10) and extend them.
* Add tests for the new syscall.

Previous version:
https://lore.kernel.org/lkml/20191104172146.30797-7-mic@digikod.net/
---
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    4 +
 tools/testing/selftests/landlock/Makefile     |   26 +
 tools/testing/selftests/landlock/common.h     |   42 +
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/test_base.c  |  113 ++
 tools/testing/selftests/landlock/test_fs.c    | 1249 +++++++++++++++++
 .../testing/selftests/landlock/test_ptrace.c  |  294 ++++
 tools/testing/selftests/landlock/true.c       |    5 +
 9 files changed, 1739 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/test_base.c
 create mode 100644 tools/testing/selftests/landlock/test_fs.c
 create mode 100644 tools/testing/selftests/landlock/test_ptrace.c
 create mode 100644 tools/testing/selftests/landlock/true.c

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
index 000000000000..fd081d6ef7c0
--- /dev/null
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -0,0 +1,4 @@
+/test_base
+/test_fs
+/test_ptrace
+/true
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
new file mode 100644
index 000000000000..96ec5863c156
--- /dev/null
+++ b/tools/testing/selftests/landlock/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+
+test_src := $(wildcard test_*.c)
+
+TEST_GEN_PROGS := $(test_src:.c=)
+
+TEST_GEN_PROGS_EXTENDED := true
+
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
+
+# Cf. tools/testing/selftests/arm64/Makefile
+ifeq ($(KBUILD_OUTPUT),)
+khdr_dir = $(top_srcdir)/usr/include
+else
+khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
+endif
+
+CFLAGS += -Wall -O2 -I$(khdr_dir)
+
+$(khdr_dir)/linux/landlock.h: khdr
+
+$(TEST_GEN_PROGS): $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
+
+$(OUTPUT)/true: true.c
+	$(CC) -Os -static -o $@ $<
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
new file mode 100644
index 000000000000..3e0d56a4363a
--- /dev/null
+++ b/tools/testing/selftests/landlock/common.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock test helpers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#include <errno.h>
+#include <linux/landlock.h>
+#include <sys/syscall.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef landlock
+static inline int landlock(const unsigned int command,
+		const unsigned int options,
+		const size_t attr_size, void *const attr_ptr)
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
+	self->attr_ruleset.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_WRITE_FILE;
+	self->ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET,
+			sizeof(self->attr_ruleset), &self->attr_ruleset);
+	ASSERT_LE(0, self->ruleset_fd);
+}
+
+FIXTURE_TEARDOWN(ruleset_rw) {
+	ASSERT_EQ(0, close(self->ruleset_fd));
+}
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
new file mode 100644
index 000000000000..042298105821
--- /dev/null
+++ b/tools/testing/selftests/landlock/config
@@ -0,0 +1,5 @@
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_PATH=y
+CONFIG_SECURITY=y
+CONFIG_SHMEM=y
+CONFIG_TMPFS=y
diff --git a/tools/testing/selftests/landlock/test_base.c b/tools/testing/selftests/landlock/test_base.c
new file mode 100644
index 000000000000..effc419593ce
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_base.c
@@ -0,0 +1,113 @@
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
+#include "common.h"
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
+		.size_attr_enforce = ~0ULL,
+	};
+
+	ASSERT_EQ(0, landlock(LANDLOCK_CMD_GET_FEATURES,
+				LANDLOCK_OPT_GET_FEATURES,
+				sizeof(attr_features), &attr_features));
+	ASSERT_EQ(((LANDLOCK_OPT_GET_FEATURES << 1) - 1),
+			attr_features.options_get_features);
+	ASSERT_EQ(((LANDLOCK_OPT_CREATE_RULESET << 1) - 1),
+			attr_features.options_create_ruleset);
+	ASSERT_EQ(((LANDLOCK_OPT_ADD_RULE_PATH_BENEATH << 1) - 1),
+			attr_features.options_add_rule);
+	ASSERT_EQ(((LANDLOCK_OPT_ENFORCE_RULESET << 1) - 1),
+			attr_features.options_enforce_ruleset);
+	ASSERT_EQ(((LANDLOCK_ACCESS_FS_CHROOT << 1) - 1),
+			attr_features.access_fs);
+	ASSERT_EQ(sizeof(struct landlock_attr_ruleset),
+		attr_features.size_attr_ruleset);
+	ASSERT_EQ(sizeof(struct landlock_attr_path_beneath),
+		attr_features.size_attr_path_beneath);
+	ASSERT_EQ(sizeof(struct landlock_attr_enforce),
+		attr_features.size_attr_enforce);
+}
+
+TEST(empty_attr_ruleset) {
+	int err;
+
+	/* Similar to struct landlock_attr_create.handled_access_fs = 0 */
+	err = landlock(LANDLOCK_CMD_CREATE_RULESET,
+			LANDLOCK_OPT_CREATE_RULESET, 0, NULL);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_EQ(err, -1);
+}
+
+TEST(empty_attr_path_beneath) {
+	int err;
+
+	/* Similar to struct landlock_attr_path_beneath.*_fd = 0 */
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH, 0, NULL);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_EQ(err, -1);
+}
+
+TEST(empty_attr_enforce) {
+	int err;
+
+	/* Similar to struct landlock_attr_enforce.ruleset_fd = 0 */
+	err = landlock(LANDLOCK_CMD_ENFORCE_RULESET,
+			LANDLOCK_OPT_ENFORCE_RULESET, 0, NULL);
+	ASSERT_EQ(errno, EINVAL);
+	ASSERT_EQ(err, -1);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/test_fs.c b/tools/testing/selftests/landlock/test_fs.c
new file mode 100644
index 000000000000..747f2cf7a59f
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_fs.c
@@ -0,0 +1,1249 @@
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
+#include <string.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/sendfile.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <unistd.h>
+
+#include "common.h"
+
+#define TMP_DIR "tmp/"
+#define FILE_NAME "file"
+#define BINARY_PATH "./true"
+
+/* Paths (sibling number and depth) */
+static const char dir_s1d1[] = TMP_DIR "s1d1";
+static const char file_s1d1[] = TMP_DIR "s1d1/" FILE_NAME;
+static const char dir_s1d2[] = TMP_DIR "s1d1/s1d2";
+static const char file_s1d2[] = TMP_DIR "s1d1/s1d2/" FILE_NAME;
+static const char dir_s1d3[] = TMP_DIR "s1d1/s1d2/s1d3";
+static const char file_s1d3[] = TMP_DIR "s1d1/s1d2/s1d3/" FILE_NAME;
+
+static const char dir_s2d1[] = TMP_DIR "s2d1";
+static const char file_s2d1[] = TMP_DIR "s2d1/" FILE_NAME;
+static const char dir_s2d2[] = TMP_DIR "s2d1/s2d2";
+static const char file_s2d2[] = TMP_DIR "s2d1/s2d2/" FILE_NAME;
+static const char dir_s2d3[] = TMP_DIR "s2d1/s2d2/s2d3";
+static const char file_s2d3[] = TMP_DIR "s2d1/s2d2/s2d3/" FILE_NAME;
+
+static const char dir_s3d1[] = TMP_DIR "s3d1";
+/* dir_s3d2 is a mount point. */
+static const char dir_s3d2[] = TMP_DIR "s3d1/s3d2";
+static const char dir_s3d3[] = TMP_DIR "s3d1/s3d2/s3d3";
+
+static void create_dir_and_file(struct __test_metadata *const _metadata,
+		const char *const dir_path)
+{
+	int file_fd;
+	const size_t file_name_len = sizeof(FILE_NAME);
+	char *const file_path = alloca(strlen(dir_path) + file_name_len + 2);
+
+	strcpy(file_path, dir_path);
+	strcat(file_path, "/");
+	strcat(file_path, FILE_NAME);
+
+	ASSERT_EQ(0, mkdir(dir_path, 0700)) {
+		TH_LOG("Failed to create directory \"%s\": %s\n", dir_path,
+				strerror(errno));
+	}
+	file_fd = open(file_path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
+			0700);
+	ASSERT_LE(0, file_fd);
+	ASSERT_EQ(0, close(file_fd));
+}
+
+static void delete_dir_and_file(const char *const dir_path)
+{
+	char *const file_path = alloca(strlen(dir_path) +
+			sizeof(FILE_NAME) + 2);
+
+	strcpy(file_path, dir_path);
+	strcat(file_path, "/");
+	strcat(file_path, FILE_NAME);
+
+	unlink(file_path);
+	/* file_path may be a directory, cf. layout1/make_directory. */
+	rmdir(file_path);
+	rmdir(dir_path);
+}
+
+static void cleanup_layout1(void)
+{
+	delete_dir_and_file(dir_s1d3);
+	delete_dir_and_file(dir_s1d2);
+	delete_dir_and_file(dir_s1d1);
+
+	delete_dir_and_file(dir_s2d3);
+	delete_dir_and_file(dir_s2d2);
+	delete_dir_and_file(dir_s2d1);
+
+	delete_dir_and_file(dir_s3d3);
+	umount(dir_s3d2);
+	delete_dir_and_file(dir_s3d2);
+	delete_dir_and_file(dir_s3d1);
+
+	delete_dir_and_file(TMP_DIR);
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
+	umask(0077);
+	create_dir_and_file(_metadata, TMP_DIR);
+
+	create_dir_and_file(_metadata, dir_s1d1);
+	create_dir_and_file(_metadata, dir_s1d2);
+	create_dir_and_file(_metadata, dir_s1d3);
+
+	create_dir_and_file(_metadata, dir_s2d1);
+	create_dir_and_file(_metadata, dir_s2d2);
+	create_dir_and_file(_metadata, dir_s2d3);
+
+	create_dir_and_file(_metadata, dir_s3d1);
+	create_dir_and_file(_metadata, dir_s3d2);
+	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
+	create_dir_and_file(_metadata, dir_s3d3);
+}
+
+FIXTURE_TEARDOWN(layout1)
+{
+	/*
+	 * cleanup_layout1() would be denied here, use TEST(cleanup) instead.
+	 */
+}
+
+static void test_path_rel(struct __test_metadata *const _metadata,
+		const int dirfd, const char *const path, const int ret)
+{
+	int fd;
+
+	/* Works with file and directories. */
+	fd = openat(dirfd, path, O_RDONLY | O_CLOEXEC);
+	if (ret) {
+		ASSERT_EQ(-1, fd) {
+			TH_LOG("Successfully opened \"%s\": %s\n", path,
+					strerror(errno));
+		}
+		ASSERT_EQ(EACCES, errno) {
+			TH_LOG("Wrong error code to open \"%s\": %s\n", path,
+					strerror(errno));
+		}
+	} else {
+		ASSERT_NE(-1, fd) {
+			TH_LOG("Failed to open \"%s\": %s\n", path,
+					strerror(errno));
+		}
+		EXPECT_EQ(0, close(fd));
+	}
+}
+
+static void test_path(struct __test_metadata *const _metadata,
+		const char *const path, const int ret)
+{
+	return test_path_rel(_metadata, AT_FDCWD, path, ret);
+}
+
+TEST_F(layout1, no_restriction)
+{
+	test_path(_metadata, dir_s1d1, 0);
+	test_path(_metadata, file_s1d1, 0);
+	test_path(_metadata, dir_s1d2, 0);
+	test_path(_metadata, file_s1d2, 0);
+	test_path(_metadata, dir_s1d3, 0);
+	test_path(_metadata, file_s1d3, 0);
+
+	test_path(_metadata, dir_s2d1, 0);
+	test_path(_metadata, file_s2d1, 0);
+	test_path(_metadata, dir_s2d2, 0);
+	test_path(_metadata, file_s2d2, 0);
+	test_path(_metadata, dir_s2d3, 0);
+	test_path(_metadata, file_s2d3, 0);
+
+	test_path(_metadata, dir_s3d1, 0);
+	test_path(_metadata, dir_s3d2, 0);
+	test_path(_metadata, dir_s3d3, 0);
+}
+
+TEST_F(ruleset_rw, inval)
+{
+	int err;
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.parent_fd = -1,
+	};
+	struct landlock_attr_enforce attr_enforce;
+
+	path_beneath.ruleset_fd = self->ruleset_fd;
+	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Tests without O_PATH. */
+	path_beneath.parent_fd = open(dir_s1d2, O_DIRECTORY |
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
+	/* Checks unhandled allowed_access. */
+	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+
+	/* Test with legitimate values. */
+	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
+	ASSERT_EQ(errno, EINVAL);
+	errno = 0;
+	ASSERT_EQ(err, -1);
+
+	/* Test with unknown (64-bits) value. */
+	path_beneath.allowed_access |= (1ULL << 60);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	path_beneath.allowed_access &= ~(1ULL << 60);
+	ASSERT_EQ(errno, EINVAL);
+	errno = 0;
+	ASSERT_EQ(err, -1);
+
+	/* Test with no access. */
+	path_beneath.allowed_access = 0;
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	path_beneath.allowed_access &= ~(1ULL << 60);
+	ASSERT_EQ(err, 0);
+
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
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.ruleset_fd = self->ruleset_fd,
+	};
+	int err;
+
+	path_beneath.parent_fd = open("/proc/self/ns/mnt", O_PATH | O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0);
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(err, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+static void add_path_beneath(struct __test_metadata *const _metadata,
+		const int ruleset_fd, const __u64 allowed_access,
+		const char *const path)
+{
+	int err;
+	struct landlock_attr_path_beneath path_beneath = {
+		.ruleset_fd = ruleset_fd,
+		.allowed_access = allowed_access,
+	};
+
+	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
+	ASSERT_GE(path_beneath.parent_fd, 0) {
+		TH_LOG("Failed to open directory \"%s\": %s\n", path,
+				strerror(errno));
+	}
+	err = landlock(LANDLOCK_CMD_ADD_RULE,
+			LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
+			sizeof(path_beneath), &path_beneath);
+	ASSERT_EQ(err, 0) {
+		TH_LOG("Failed to update the ruleset with \"%s\": %s\n", path,
+				strerror(errno));
+	}
+	ASSERT_EQ(errno, 0);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+struct rule {
+	const char *path;
+	__u64 access;
+};
+
+#define ACCESS_RO ( \
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_READ_DIR)
+
+#define ACCESS_RW ( \
+	ACCESS_RO | \
+	LANDLOCK_ACCESS_FS_WRITE_FILE)
+
+static int create_ruleset(struct __test_metadata *const _metadata,
+		const __u64 handled_access_fs, const struct rule rules[])
+{
+	int ruleset_fd, i;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = handled_access_fs,
+	};
+
+	ASSERT_NE(NULL, rules) {
+		TH_LOG("No rule list\n");
+	}
+	ASSERT_NE(NULL, rules[0].path) {
+		TH_LOG("Empty rule list\n");
+	}
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
+
+	for (i = 0; rules[i].path; i++) {
+		ASSERT_EQ(rules[i].access, rules[i].access &
+				attr_features.access_fs);
+		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
+				rules[i].path);
+	}
+	return ruleset_fd;
+}
+
+static void enforce_ruleset(struct __test_metadata *const _metadata,
+		const int ruleset_fd)
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
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{
+			.path = file_s2d2,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Tests on a directory. */
+	test_path(_metadata, "/", -1);
+	test_path(_metadata, dir_s1d1, -1);
+	test_path(_metadata, file_s1d1, -1);
+	test_path(_metadata, dir_s1d2, 0);
+	test_path(_metadata, file_s1d2, 0);
+	test_path(_metadata, dir_s1d3, 0);
+	test_path(_metadata, file_s1d3, 0);
+
+	/* Tests on a file. */
+	test_path(_metadata, dir_s2d2, -1);
+	test_path(_metadata, file_s2d2, 0);
+}
+
+TEST_F(layout1, unhandled_access)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Because the policy does not handle LANDLOCK_ACCESS_FS_CHROOT,
+	 * chroot(2) should be allowed.
+	 */
+	ASSERT_EQ(0, chroot(dir_s1d1));
+	ASSERT_EQ(0, chroot(dir_s1d2));
+	ASSERT_EQ(0, chroot(dir_s1d3));
+}
+
+TEST_F(layout1, ruleset_overlap)
+{
+	const struct rule rules[] = {
+		/* These rules should be ORed among them. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{},
+	};
+	int open_fd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, open(file_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	open_fd = open(file_s1d2, O_WRONLY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+
+	open_fd = open(file_s1d3, O_WRONLY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+}
+
+TEST_F(layout1, inherit_superset)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{},
+	};
+	int open_fd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	ASSERT_EQ(-1, open(file_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(-1, open(file_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(-1, open(file_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/*
+	 * Tests shared rule extension: the following rules should not grant
+	 * any new access, only remove some.  Once enforced, these rules are
+	 * ANDed with the previous ones.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
+			dir_s1d2);
+	/*
+	 * According to ruleset_fd, dir_s1d2 should now have the
+	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
+	 * access rights (even if this directory is opened a second time).
+	 * However, when enforcing this updated ruleset, the ruleset tied to
+	 * the current process (i.e. its domain) will still only have the
+	 * dir_s1d2 with LANDLOCK_ACCESS_FS_READ_FILE and
+	 * LANDLOCK_ACCESS_FS_READ_DIR accesses, but
+	 * LANDLOCK_ACCESS_FS_WRITE_FILE must not be allowed because it would
+	 * be a privilege escalation.
+	 */
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(-1, open(file_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file_s1d2. */
+	ASSERT_EQ(-1, open(file_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file_s1d3. */
+	ASSERT_EQ(-1, open(file_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/*
+	 * Try to get more privileges by adding new access rights to the parent
+	 * directory: dir_s1d1.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(-1, open(file_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file_s1d2. */
+	ASSERT_EQ(-1, open(file_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file_s1d3. */
+	ASSERT_EQ(-1, open(file_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/*
+	 * Now, dir_s1d3 get a new rule tied to it, only allowing
+	 * LANDLOCK_ACCESS_FS_WRITE_FILE.  The (kernel internal) difference is
+	 * that there was no rule tied to it before.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
+			dir_s1d3);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Same tests and results as above, except for open(dir_s1d3) which is
+	 * now denied because the new rule mask the rule previously inherited
+	 * from dir_s1d2.
+	 */
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(-1, open(file_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file_s1d2. */
+	ASSERT_EQ(-1, open(file_s1d2, O_WRONLY | O_CLOEXEC));
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_NE(-1, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file_s1d3. */
+	ASSERT_EQ(-1, open(file_s1d3, O_WRONLY | O_CLOEXEC));
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	/* Readdir of dir_s1d3 is now forbidden too. */
+	ASSERT_EQ(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F(layout1, rule_on_mountpoint)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d1,
+			.access = ACCESS_RO,
+		},
+		{
+			/* dir_s3d2 is a mount point. */
+			.path = dir_s3d2,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, dir_s1d1, 0);
+
+	test_path(_metadata, dir_s2d1, -1);
+
+	test_path(_metadata, dir_s3d1, -1);
+	test_path(_metadata, dir_s3d2, 0);
+	test_path(_metadata, dir_s3d3, 0);
+}
+
+TEST_F(layout1, rule_over_mountpoint)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d1,
+			.access = ACCESS_RO,
+		},
+		{
+			/* dir_s3d2 is a mount point. */
+			.path = dir_s3d1,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, dir_s1d1, 0);
+
+	test_path(_metadata, dir_s2d1, -1);
+
+	test_path(_metadata, dir_s3d1, 0);
+	test_path(_metadata, dir_s3d2, 0);
+	test_path(_metadata, dir_s3d3, 0);
+}
+
+/*
+ * This test verifies that we can apply a landlock rule on the root (/), it
+ * might require special handling.
+ */
+TEST_F(layout1, rule_over_root)
+{
+	const struct rule rules[] = {
+		{
+			.path = "/",
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, "/", 0);
+	test_path(_metadata, dir_s1d1, 0);
+}
+
+TEST_F(layout1, rule_inside_mount_ns)
+{
+	const struct rule rules[] = {
+		{
+			.path = "s3d3",
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	int ruleset_fd;
+
+	ASSERT_NE(-1, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_NE(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3)) {
+		TH_LOG("Failed to pivot_root into \"%s\": %s\n", dir_s3d2,
+				strerror(errno));
+	};
+	ASSERT_NE(-1, chdir("/"));
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_path(_metadata, "s3d3", 0);
+	test_path(_metadata, "/", -1);
+}
+
+TEST_F(layout1, mount_and_pivot)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d2,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3));
+}
+
+enum relative_access {
+	REL_OPEN,
+	REL_CHDIR,
+	REL_CHROOT_ONLY,
+	REL_CHROOT_CHDIR,
+};
+
+static void test_relative_path(struct __test_metadata *const _metadata,
+		const enum relative_access rel)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{
+			.path = dir_s2d2,
+			.access = ACCESS_RO,
+		},
+		{},
+	};
+	int dirfd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	switch (rel) {
+	case REL_OPEN:
+	case REL_CHDIR:
+		break;
+	case REL_CHROOT_ONLY:
+		ASSERT_EQ(0, chdir(dir_s2d2));
+		break;
+	case REL_CHROOT_CHDIR:
+		ASSERT_EQ(0, chdir(dir_s1d2));
+		break;
+	default:
+		ASSERT_TRUE(false);
+		return;
+	}
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	switch (rel) {
+	case REL_OPEN:
+		dirfd = open(dir_s1d2, O_DIRECTORY);
+		ASSERT_NE(-1, dirfd);
+		break;
+	case REL_CHDIR:
+		ASSERT_NE(-1, chdir(dir_s1d2));
+		dirfd = AT_FDCWD;
+		break;
+	case REL_CHROOT_ONLY:
+		/* Do chroot into dir_s1d2 (relative to dir_s2d2). */
+		ASSERT_NE(-1, chroot("../../s1d1/s1d2")) {
+			TH_LOG("Failed to chroot: %s\n", strerror(errno));
+		}
+		dirfd = AT_FDCWD;
+		break;
+	case REL_CHROOT_CHDIR:
+		/* Do chroot into dir_s1d2. */
+		ASSERT_NE(-1, chroot(".")) {
+			TH_LOG("Failed to chroot: %s\n", strerror(errno));
+		}
+		dirfd = AT_FDCWD;
+		break;
+	}
+
+	test_path_rel(_metadata, dirfd, "..",
+			(rel == REL_CHROOT_CHDIR) ? 0 : -1);
+	test_path_rel(_metadata, dirfd, ".", 0);
+
+	if (rel == REL_CHROOT_ONLY)
+		/* The current directory is dir_s2d2. */
+		test_path_rel(_metadata, dirfd, "./s2d3", 0);
+	else
+		/* The current directory is dir_s1d2. */
+		test_path_rel(_metadata, dirfd, "./s1d3", 0);
+
+	if (rel != REL_CHROOT_CHDIR) {
+		test_path_rel(_metadata, dirfd, "../../s1d1", -1);
+		test_path_rel(_metadata, dirfd, "../../s1d1/s1d2", 0);
+		test_path_rel(_metadata, dirfd, "../../s1d1/s1d2/s1d3", 0);
+
+		test_path_rel(_metadata, dirfd, "../../s2d1", -1);
+		test_path_rel(_metadata, dirfd, "../../s2d1/s2d2", 0);
+		test_path_rel(_metadata, dirfd, "../../s2d1/s2d2/s2d3", 0);
+	}
+
+	if (rel == REL_OPEN)
+		EXPECT_EQ(0, close(dirfd));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F(layout1, relative_open)
+{
+	test_relative_path(_metadata, REL_OPEN);
+}
+
+TEST_F(layout1, relative_chdir)
+{
+	test_relative_path(_metadata, REL_CHDIR);
+}
+
+TEST_F(layout1, relative_chroot_only)
+{
+	test_relative_path(_metadata, REL_CHROOT_ONLY);
+}
+
+TEST_F(layout1, relative_chroot_chdir)
+{
+	test_relative_path(_metadata, REL_CHROOT_CHDIR);
+}
+
+TEST_F(layout1, chroot)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_CHROOT,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_CHROOT, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, chroot(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, chroot(dir_s1d2)) {
+		TH_LOG("Failed to chroot into \"%s\": %s\n", file_s1d2,
+				strerror(errno));
+	};
+	/* This chroot still works because we didn't chdir(dir_s1d2). */
+	ASSERT_EQ(0, chroot(dir_s1d3));
+}
+
+static void copy_binary(struct __test_metadata *const _metadata,
+		const char *const dst_path)
+{
+	int dst_fd, src_fd;
+	struct stat statbuf;
+
+	dst_fd = open(dst_path, O_WRONLY | O_TRUNC | O_CLOEXEC);
+	ASSERT_LE(0, dst_fd) {
+		TH_LOG("Failed to open \"%s\": %s\n", dst_path,
+				strerror(errno));
+	}
+	src_fd = open(BINARY_PATH, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, src_fd) {
+		TH_LOG("Failed to open \"" BINARY_PATH "\": %s\n",
+				strerror(errno));
+	}
+	ASSERT_EQ(0, fstat(src_fd, &statbuf));
+	ASSERT_LE(0, sendfile(dst_fd, src_fd, 0, statbuf.st_size));
+	ASSERT_EQ(0, close(src_fd));
+	ASSERT_EQ(0, close(dst_fd));
+}
+
+static void test_execute(struct __test_metadata *const _metadata,
+		const char *const path, const int ret)
+{
+	int status;
+	char *const argv[] = {(char *)path, NULL};
+	const pid_t child = fork();
+
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(ret, execve(path, argv, NULL)) {
+			TH_LOG("Failed to execute \"%s\": %s\n", path,
+					strerror(errno));
+		};
+		ASSERT_EQ(EACCES, errno);
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(0, WEXITSTATUS(status)) {
+		TH_LOG("Unexpected return code for \"%s\": %s\n", path,
+				strerror(errno));
+	};
+}
+
+TEST_F(layout1, execute)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_EXECUTE, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	copy_binary(_metadata, file_s1d1);
+	copy_binary(_metadata, file_s1d2);
+	copy_binary(_metadata, file_s1d3);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_execute(_metadata, file_s1d1, -1);
+	test_execute(_metadata, file_s1d2, 0);
+	test_execute(_metadata, file_s1d3, 0);
+}
+
+TEST_F(layout1, link_to)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_LINK_TO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_LINK_TO, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, link(file_s2d1, file_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, link(file_s2d1, file_s1d2)) {
+		TH_LOG("Failed to link file to \"%s\": %s\n", file_s1d2,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, link(file_s2d1, file_s1d3));
+}
+
+static void test_rename(struct __test_metadata *const _metadata)
+{
+	/* Renames files. */
+	ASSERT_EQ(-1, rename(file_s2d1, file_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, rename(file_s2d2, file_s1d2)) {
+		TH_LOG("Failed to rename file \"%s\": %s\n", file_s2d3,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, rename(file_s2d3, file_s1d3));
+
+	/* Renames directories (reverse order). */
+	ASSERT_EQ(0, unlink(file_s1d3));
+	ASSERT_EQ(0, rename(dir_s2d3, dir_s1d3)) {
+		TH_LOG("Failed to rename directory \"%s\": %s\n", dir_s2d3,
+				strerror(errno));
+	};
+
+	ASSERT_EQ(0, rmdir(dir_s1d3));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(-1, rename(dir_s2d2, dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, rmdir(dir_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(-1, rename(dir_s2d1, dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F(layout1, rename_from)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_RENAME_FROM,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_RENAME_FROM, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_rename(_metadata);
+}
+
+TEST_F(layout1, rename_to)
+{
+	/*
+	 * Same tests as layout1/rename_from, except the rename_from access
+	 * rule is on dir_s1d2.
+	 */
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_RENAME_TO,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_RENAME_TO, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_rename(_metadata);
+}
+
+TEST_F(layout1, rmdir)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_RMDIR,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_RMDIR, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, rmdir(dir_s1d3)) {
+		TH_LOG("Failed to remove directory \"%s\": %s\n", file_s1d2,
+				strerror(errno));
+	}
+	ASSERT_EQ(-1, rmdir(dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rmdir(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F(layout1, unlink)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_UNLINK,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_UNLINK, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, unlink(file_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file_s1d2)) {
+		TH_LOG("Failed to unlink file \"%s\": %s\n", file_s1d2,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, unlink(file_s1d3));
+}
+
+static void test_make_file(struct __test_metadata *const _metadata,
+		const __u64 access, const mode_t mode, const dev_t dev)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = access,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata, access, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mknod(file_s1d1, mode | 0400, dev));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mknod(file_s1d2, mode | 0400, dev)) {
+		TH_LOG("Failed to make file \"%s\": %s\n",
+				file_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, mknod(file_s1d3, mode | 0400, dev));
+}
+
+TEST_F(layout1, make_char)
+{
+	/* Creates a /dev/null device. */
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, S_IFCHR,
+			major(1) | minor(3));
+}
+
+TEST_F(layout1, make_block)
+{
+	/* Creates a /dev/loop0 device. */
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_BLOCK, S_IFBLK,
+			major(7) | minor(0));
+}
+
+TEST_F(layout1, make_reg)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFREG, 0);
+}
+
+TEST_F(layout1, make_sock)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_SOCK, S_IFSOCK, 0);
+}
+
+TEST_F(layout1, make_fifo)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_FIFO, S_IFIFO, 0);
+}
+
+TEST_F(layout1, make_sym)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_SYM,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_MAKE_SYM, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, symlink("none", file_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, symlink("none", file_s1d2)) {
+		TH_LOG("Failed to make symlink \"%s\": %s\n",
+				file_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, symlink("none", file_s1d3));
+}
+
+TEST_F(layout1, make_dir)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_DIR,
+		},
+		{},
+	};
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_MAKE_DIR, rules);
+
+	ASSERT_NE(-1, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file_s1d1));
+	ASSERT_EQ(0, unlink(file_s1d2));
+	ASSERT_EQ(0, unlink(file_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Uses file_* as directory names. */
+	ASSERT_EQ(-1, mkdir(file_s1d1, 0700));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mkdir(file_s1d2, 0700)) {
+		TH_LOG("Failed to make directory \"%s\": %s\n",
+				file_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, mkdir(file_s1d3, 0700));
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
index 000000000000..407cc99e5340
--- /dev/null
+++ b/tools/testing/selftests/landlock/test_ptrace.c
@@ -0,0 +1,294 @@
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
+#include "common.h"
+
+static void create_domain(struct __test_metadata *const _metadata)
+{
+	int ruleset_fd, err;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_enforce attr_enforce;
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
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
+static void check_ptrace(struct __test_metadata *const _metadata,
+		const bool domain_both, const bool domain_parent,
+		const bool domain_child)
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
diff --git a/tools/testing/selftests/landlock/true.c b/tools/testing/selftests/landlock/true.c
new file mode 100644
index 000000000000..3f9ccbf52783
--- /dev/null
+++ b/tools/testing/selftests/landlock/true.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+int main(void)
+{
+	return 0;
+}
-- 
2.26.0.rc2

