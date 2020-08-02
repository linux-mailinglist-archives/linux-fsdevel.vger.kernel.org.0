Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1F4239C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 00:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgHBWAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 18:00:20 -0400
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:34847 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728193AbgHBWAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 18:00:15 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BKZgD3ZD3zlhb67;
        Sun,  2 Aug 2020 23:59:36 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BKZgD0Y52zlh8TB;
        Sun,  2 Aug 2020 23:59:36 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v20 10/12] selftests/landlock: Add initial tests
Date:   Sun,  2 Aug 2020 23:59:01 +0200
Message-Id: <20200802215903.91936-11-mic@digikod.net>
X-Mailer: git-send-email 2.28.0.rc2
In-Reply-To: <20200802215903.91936-1-mic@digikod.net>
References: <20200802215903.91936-1-mic@digikod.net>
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

Test coverage for security/landlock/ is 93.6% of lines.  The code not
covered only deals with internal kernel errors (e.g. memory allocation)
and race conditions.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
---

Changes since v19:
* Update with the new Landlock syscalls.
* Fix device creation.
* Check the new landlock_attr_features members: last_rule_type and
  last_target_type .
* Constify variables.

Changes since v18:
* Replace ruleset_rw.inval with layout1.inval to avoid inexistent test
  layout.
* Use the new FIXTURE_VARIANT for ptrace_test: makes the tests more
  readable and usable.
* Add ARRAY_SIZE() macro to please checkpatch.

Changes since v17:
* Add new test for mknod with a zero mode.
* Use memset(3) to initialize attr_features in base_test.

Changes since v16:
* Add new unpriv_enforce_without_no_new_privs test: check that ruleset
  enforcing is forbiden without no_new_privs and CAP_SYS_ADMIN.
* Drop capabilities when useful.
* Check the new size_attr_features field from struct
  landlock_attr_features.
* Update the empty_or_same_ruleset test to check complementary empty
  ruleset.
* Update base_test according to the new attribute structures and fix the
  inconsistent_attr test accordingly.
* Switch syscall attribute pointer and size arguments.
* Rename test files with a "_test" suffix.

Changes since v14:
* Add new tests:
  - superset: check new layer bitmask.
  - max_layers: check maximum number of layers.
  - release_inodes: check that umount work well.
  - empty_or_same_ruleset.
  - inconsistent_attr: checks copy_to_user limits.
  - in ruleset_rw.inval to check ruleset FD.
  - proc_unlinked_file: check file access through /proc/self/fd .
  - file_access_rights: check that a file can only get consistent access
    rights.
  - unpriv: check that NO_NEW_PRIVS or CAP_SYS_ADMIN is required.
  - check pipe access through /proc/self/fd .
  - check move_mount(2).
  - check ruleset file descriptor properties.
  - proc_nsfs: extend to check that internal filesystems (e.g. nsfs) are
    allowed.
* Double-check read and write effective actions.
* Fix potential desynchronization between the kernel sources and
  installed headers by overriding the build step in the Makefile.  This
  also enable to build with Clang.
* Add two files in the test directories (for link test and rename test).
* Remove test for ruleset's show_fdinfo().
* Replace EBADR with EBADFD.
* Update tests accordingly to the changes of rename and link rights.
* Fix (now) illegal access rights tied to files.
* Update rename and link tests.
* Remove superfluous '\n' in TH_LOG() calls.
* Make assert calls consistent and readable.
* Fix the execute test.
* Make tests future-proof.
* Cosmetic fixes.

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

Previous changes:
https://lore.kernel.org/lkml/20191104172146.30797-7-mic@digikod.net/
---
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   29 +
 tools/testing/selftests/landlock/base_test.c  |  154 ++
 tools/testing/selftests/landlock/common.h     |  122 ++
 tools/testing/selftests/landlock/config       |    5 +
 tools/testing/selftests/landlock/fs_test.c    | 1698 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  310 +++
 tools/testing/selftests/landlock/true.c       |    5 +
 9 files changed, 2326 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..25f00c514cc1 100644
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
index 000000000000..470203a7cd73
--- /dev/null
+++ b/tools/testing/selftests/landlock/.gitignore
@@ -0,0 +1,2 @@
+/*_test
+/true
diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
new file mode 100644
index 000000000000..d29bd0804c14
--- /dev/null
+++ b/tools/testing/selftests/landlock/Makefile
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0
+
+src_test := $(wildcard *_test.c)
+
+TEST_GEN_PROGS := $(src_test:.c=)
+
+TEST_GEN_PROGS_EXTENDED := true
+
+KSFT_KHDR_INSTALL := 1
+OVERRIDE_TARGETS := 1
+include ../lib.mk
+
+# Cf. tools/testing/selftests/arm64/Makefile
+ifeq ($(KBUILD_OUTPUT),)
+khdr_dir = $(top_srcdir)/usr/include
+else
+khdr_dir = $(KBUILD_OUTPUT)/kselftest/usr/include
+endif
+
+CFLAGS += -Wall -O2
+
+$(khdr_dir)/linux/landlock.h: khdr
+	@:
+
+$(OUTPUT)/true: true.c
+	$(LINK.c) $< $(LDLIBS) -o $@ -static
+
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
new file mode 100644
index 000000000000..4b3f8c7ab9d6
--- /dev/null
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Common user space base
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/landlock.h>
+#include <string.h>
+#include <sys/prctl.h>
+
+#include "common.h"
+
+#ifndef O_PATH
+#define O_PATH		010000000
+#endif
+
+TEST(features)
+{
+	struct landlock_attr_features attr_features;
+
+	/* Tests that all fields are properly initialized. */
+	memset(&attr_features, 0xff, sizeof(attr_features));
+	ASSERT_EQ(0, landlock_get_features(&attr_features, sizeof(attr_features)));
+	ASSERT_EQ(0, attr_features.options_get_features);
+	ASSERT_EQ(0, attr_features.options_create_ruleset);
+	ASSERT_EQ(0, attr_features.options_add_rule);
+	ASSERT_EQ(0, attr_features.options_enforce_ruleset);
+	ASSERT_EQ(sizeof(struct landlock_attr_features),
+		attr_features.size_attr_features);
+	ASSERT_EQ(sizeof(struct landlock_attr_ruleset),
+		attr_features.size_attr_ruleset);
+	ASSERT_EQ(sizeof(struct landlock_attr_path_beneath),
+		attr_features.size_attr_path_beneath);
+	ASSERT_EQ(((LANDLOCK_ACCESS_FS_MAKE_SYM << 1) - 1),
+			attr_features.access_fs);
+	ASSERT_EQ(LANDLOCK_RULE_PATH_BENEATH, attr_features.last_rule_type);
+	ASSERT_EQ(LANDLOCK_TARGET_CURRENT_THREAD, attr_features.last_target_type);
+}
+
+TEST(inconsistent_attr) {
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *const buf = malloc(page_size + 1);
+	struct landlock_attr_ruleset *const ruleset = (void *)buf;
+	struct landlock_attr_features *const features = (void *)buf;
+
+	ASSERT_NE(NULL, buf);
+
+	/* Checks copy_from_user(). */
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset, 0));
+	/* The size if less than sizeof(struct landlock_attr_enforce). */
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 1));
+	/* The size if less than sizeof(struct landlock_attr_enforce). */
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, sizeof(struct landlock_attr_ruleset)));
+	ASSERT_EQ(EFAULT, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset, page_size + 1));
+	ASSERT_EQ(E2BIG, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset, page_size));
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Checks non-zero value. */
+	buf[page_size - 2] = '.';
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset, page_size));
+	ASSERT_EQ(E2BIG, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset, page_size + 1));
+	ASSERT_EQ(E2BIG, errno);
+
+	/* Checks copy_to_user(). */
+	ASSERT_EQ(-1, landlock_get_features(NULL, 0));
+	ASSERT_EQ(ENODATA, errno);
+	ASSERT_EQ(-1, landlock_get_features(features, 0));
+	ASSERT_EQ(ENODATA, errno);
+
+	ASSERT_EQ(0, landlock_get_features(features, 1));
+
+	ASSERT_EQ(-1, landlock_get_features(features, page_size + 1));
+	ASSERT_EQ(E2BIG, errno);
+
+	ASSERT_EQ('.', buf[page_size - 2]);
+	ASSERT_EQ(0, landlock_get_features(features, page_size));
+	ASSERT_EQ('\0', buf[page_size - 2]);
+
+	free(buf);
+}
+
+TEST(empty_attr_ruleset) {
+	/* Similar to struct landlock_attr_ruleset.handled_access_fs = 0 */
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0));
+	ASSERT_EQ(EINVAL, errno);
+}
+
+TEST(empty_attr_path_beneath) {
+	const struct landlock_attr_ruleset ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	const int ruleset_fd = landlock_create_ruleset(&ruleset, sizeof(ruleset));
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Similar to struct landlock_attr_path_beneath.parent_fd = 0 */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH, NULL, 0));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST(inval_fd_enforce) {
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	ASSERT_EQ(-1, landlock_enforce_ruleset(-1));
+	ASSERT_EQ(EBADF, errno);
+}
+
+TEST(unpriv_enforce_without_no_new_privs) {
+	int err;
+
+	disable_caps(_metadata);
+	err = landlock_enforce_ruleset(-1);
+	ASSERT_EQ(errno, EPERM);
+	ASSERT_EQ(err, -1);
+}
+
+TEST(ruleset_fd)
+{
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int ruleset_fd;
+	char buf;
+
+	disable_caps(_metadata);
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset,
+			sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(-1, write(ruleset_fd, ".", 1));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(-1, read(ruleset_fd, &buf, 1));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
new file mode 100644
index 000000000000..a8132b16b6f0
--- /dev/null
+++ b/tools/testing/selftests/landlock/common.h
@@ -0,0 +1,122 @@
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
+#include <sys/capability.h>
+#include <sys/syscall.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+#ifndef landlock_get_features
+static inline int landlock_get_features(
+		struct landlock_attr_features *const features_ptr,
+		const size_t features_size)
+{
+	errno = 0;
+	return syscall(__NR_landlock_get_features, features_ptr, features_size, 0);
+}
+#endif
+
+#ifndef landlock_create_ruleset
+static inline int landlock_create_ruleset(
+		const struct landlock_attr_ruleset *const ruleset_ptr,
+		const size_t ruleset_size)
+{
+	errno = 0;
+	return syscall(__NR_landlock_create_ruleset, ruleset_ptr, ruleset_size, 0);
+}
+#endif
+
+#ifndef landlock_add_rule
+static inline int landlock_add_rule(const int ruleset_fd,
+		const enum landlock_rule_type rule_type,
+		const void *const rule_ptr, const size_t rule_size)
+{
+	errno = 0;
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type, rule_ptr,
+			rule_size, 0);
+}
+#endif
+
+#ifndef landlock_enforce_ruleset
+static inline int landlock_enforce_ruleset(const int ruleset_fd)
+{
+	errno = 0;
+	return syscall(__NR_landlock_enforce_ruleset, ruleset_fd,
+			LANDLOCK_TARGET_CURRENT_THREAD, -1, 0);
+}
+#endif
+
+static void disable_caps(struct __test_metadata *const _metadata)
+{
+	cap_t cap_p;
+	/* Only these two capabilities are useful for the tests. */
+	const cap_value_t caps[] = {
+		CAP_MKNOD,
+		CAP_SYS_ADMIN,
+		CAP_SYS_CHROOT,
+	};
+
+	cap_p = cap_get_proc();
+	ASSERT_NE(NULL, cap_p) {
+		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_clear(cap_p)) {
+		TH_LOG("Failed to cap_clear: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED, ARRAY_SIZE(caps),
+				caps, CAP_SET)) {
+		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_set_proc(cap_p)) {
+		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_free(cap_p)) {
+		TH_LOG("Failed to cap_free: %s", strerror(errno));
+	}
+}
+
+static void effective_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps, const cap_flag_value_t value)
+{
+	cap_t cap_p;
+
+	cap_p = cap_get_proc();
+	ASSERT_NE(NULL, cap_p) {
+		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &caps, value)) {
+		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_set_proc(cap_p)) {
+		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
+	}
+	ASSERT_NE(-1, cap_free(cap_p)) {
+		TH_LOG("Failed to cap_free: %s", strerror(errno));
+	}
+}
+
+/* We can't put such helpers in a library because of kselftest_harness.h . */
+__attribute__((__unused__))
+static void set_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps)
+{
+	effective_cap(_metadata, caps, CAP_SET);
+}
+
+__attribute__((__unused__))
+static void clear_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps)
+{
+	effective_cap(_metadata, caps, CAP_CLEAR);
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
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
new file mode 100644
index 000000000000..9d2b119df384
--- /dev/null
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -0,0 +1,1698 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Filesystem
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
+#include <sys/capability.h>
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
+#define FILE_1 "file1"
+#define FILE_2 "file2"
+#define BINARY_PATH "./true"
+
+/* Paths (sibling number and depth) */
+static const char dir_s1d1[] = TMP_DIR "s1d1";
+static const char file1_s1d1[] = TMP_DIR "s1d1/" FILE_1;
+static const char file2_s1d1[] = TMP_DIR "s1d1/" FILE_2;
+static const char dir_s1d2[] = TMP_DIR "s1d1/s1d2";
+static const char file1_s1d2[] = TMP_DIR "s1d1/s1d2/" FILE_1;
+static const char file2_s1d2[] = TMP_DIR "s1d1/s1d2/" FILE_2;
+static const char dir_s1d3[] = TMP_DIR "s1d1/s1d2/s1d3";
+static const char file1_s1d3[] = TMP_DIR "s1d1/s1d2/s1d3/" FILE_1;
+static const char file2_s1d3[] = TMP_DIR "s1d1/s1d2/s1d3/" FILE_2;
+
+static const char dir_s2d1[] = TMP_DIR "s2d1";
+static const char file1_s2d1[] = TMP_DIR "s2d1/" FILE_1;
+static const char dir_s2d2[] = TMP_DIR "s2d1/s2d2";
+static const char file1_s2d2[] = TMP_DIR "s2d1/s2d2/" FILE_1;
+static const char dir_s2d3[] = TMP_DIR "s2d1/s2d2/s2d3";
+static const char file1_s2d3[] = TMP_DIR "s2d1/s2d2/s2d3/" FILE_1;
+static const char file2_s2d3[] = TMP_DIR "s2d1/s2d2/s2d3/" FILE_2;
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
+	char *const file1_path = alloca(strlen(dir_path) + sizeof(FILE_1) + 2);
+	char *const file2_path = alloca(strlen(dir_path) + sizeof(FILE_2) + 2);
+
+	strcpy(file1_path, dir_path);
+	strcat(file1_path, "/");
+	strcat(file1_path, FILE_1);
+
+	strcpy(file2_path, dir_path);
+	strcat(file2_path, "/");
+	strcat(file2_path, FILE_2);
+
+	ASSERT_EQ(0, mkdir(dir_path, 0700)) {
+		TH_LOG("Failed to create directory \"%s\": %s", dir_path,
+				strerror(errno));
+	}
+	file_fd = open(file1_path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
+			0700);
+	ASSERT_LE(0, file_fd);
+	ASSERT_EQ(0, close(file_fd));
+
+	file_fd = open(file2_path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
+			0700);
+	ASSERT_LE(0, file_fd);
+	ASSERT_EQ(0, close(file_fd));
+}
+
+static void delete_dir_and_file(const char *const dir_path)
+{
+	char *const file1_path = alloca(strlen(dir_path) +
+			sizeof(FILE_1) + 2);
+	char *const file2_path = alloca(strlen(dir_path) +
+			sizeof(FILE_2) + 2);
+
+	strcpy(file1_path, dir_path);
+	strcat(file1_path, "/");
+	strcat(file1_path, FILE_1);
+
+	strcpy(file2_path, dir_path);
+	strcat(file2_path, "/");
+	strcat(file2_path, FILE_2);
+
+	unlink(file1_path);
+	unlink(file2_path);
+	/* file1_path may be a directory, cf. layout1/make_directory. */
+	rmdir(file1_path);
+	rmdir(dir_path);
+}
+
+static void cleanup_layout1(struct __test_metadata *const _metadata)
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
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	umount(dir_s3d2);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
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
+	disable_caps(_metadata);
+	cleanup_layout1(_metadata);
+
+	/* Do not pollute the rest of the system. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
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
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
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
+			TH_LOG("Successfully opened \"%s\": %s", path,
+					strerror(errno));
+		}
+		ASSERT_EQ(EACCES, errno) {
+			TH_LOG("Wrong error code to open \"%s\": %s", path,
+					strerror(errno));
+		}
+	} else {
+		ASSERT_LE(0, fd) {
+			TH_LOG("Failed to open \"%s\": %s", path,
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
+	test_path(_metadata, file1_s1d1, 0);
+	test_path(_metadata, file2_s1d1, 0);
+	test_path(_metadata, dir_s1d2, 0);
+	test_path(_metadata, file1_s1d2, 0);
+	test_path(_metadata, file2_s1d2, 0);
+	test_path(_metadata, dir_s1d3, 0);
+	test_path(_metadata, file1_s1d3, 0);
+
+	test_path(_metadata, dir_s2d1, 0);
+	test_path(_metadata, file1_s2d1, 0);
+	test_path(_metadata, dir_s2d2, 0);
+	test_path(_metadata, file1_s2d2, 0);
+	test_path(_metadata, dir_s2d3, 0);
+	test_path(_metadata, file1_s2d3, 0);
+
+	test_path(_metadata, dir_s3d1, 0);
+	test_path(_metadata, dir_s3d2, 0);
+	test_path(_metadata, dir_s3d3, 0);
+}
+
+TEST_F(layout1, inval)
+{
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.parent_fd = -1,
+	};
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+	};
+	int ruleset_fd;
+
+	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	ruleset_fd = open(dir_s1d1, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	/* Returns EBADF because ruleset_fd contains O_PATH. */
+	ASSERT_EQ(EBADF, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Gets a real ruleset. */
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Tests without O_PATH. */
+	path_beneath.parent_fd = open(dir_s1d2, O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Checks unhandled allowed_access. */
+	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	/* Test with legitimate values. */
+	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(EINVAL, errno);
+	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
+
+	/* Test with unknown (64-bits) value. */
+	path_beneath.allowed_access |= (1ULL << 60);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(EINVAL, errno);
+	path_beneath.allowed_access &= ~(1ULL << 60);
+
+	/* Test with no access. */
+	path_beneath.allowed_access = 0;
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	path_beneath.allowed_access &= ~(1ULL << 60);
+
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Enforces the ruleset. */
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_enforce_ruleset(ruleset_fd));
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+#define ACCESS_FILE ( \
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_READ_FILE)
+
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_MAKE_SYM
+
+#define ACCESS_ALL ( \
+	ACCESS_FILE | \
+	LANDLOCK_ACCESS_FS_READ_DIR | \
+	LANDLOCK_ACCESS_FS_CHROOT | \
+	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
+	LANDLOCK_ACCESS_FS_REMOVE_FILE | \
+	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
+	LANDLOCK_ACCESS_FS_MAKE_DIR | \
+	LANDLOCK_ACCESS_FS_MAKE_REG | \
+	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
+	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
+	ACCESS_LAST)
+
+TEST_F(layout1, file_access_rights)
+{
+	__u64 access;
+	int err;
+	struct landlock_attr_path_beneath path_beneath = {};
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = ACCESS_ALL,
+	};
+	const int ruleset_fd = landlock_create_ruleset(&attr_ruleset,
+			sizeof(attr_ruleset));
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Tests access rights for files. */
+	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
+		path_beneath.allowed_access = access;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath));
+		if ((access | ACCESS_FILE) == ACCESS_FILE) {
+			ASSERT_EQ(0, err);
+		} else {
+			ASSERT_EQ(-1, err);
+			ASSERT_EQ(EINVAL, errno);
+		}
+	}
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+static void add_path_beneath(struct __test_metadata *const _metadata,
+		const int ruleset_fd, const __u64 allowed_access,
+		const char *const path)
+{
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = allowed_access,
+	};
+
+	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd) {
+		TH_LOG("Failed to open directory \"%s\": %s", path,
+				strerror(errno));
+	}
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath))) {
+		TH_LOG("Failed to update the ruleset with \"%s\": %s", path,
+				strerror(errno));
+	}
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
+	struct landlock_attr_features attr_features = {};
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = handled_access_fs,
+	};
+
+	ASSERT_NE(NULL, rules) {
+		TH_LOG("No rule list");
+	}
+	ASSERT_NE(NULL, rules[0].path) {
+		TH_LOG("Empty rule list");
+	}
+
+	ASSERT_EQ(0, landlock_get_features(&attr_features, sizeof(attr_features)));
+	/* Only for test, use a binary AND for real application instead. */
+	ASSERT_EQ(attr_ruleset.handled_access_fs,
+			attr_ruleset.handled_access_fs &
+			attr_features.access_fs);
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd) {
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
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
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_enforce_ruleset(ruleset_fd)) {
+		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
+	}
+}
+
+TEST_F(layout1, proc_nsfs)
+{
+	const struct rule rules[] = {
+		{
+			.path = "/dev/null",
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	struct landlock_attr_path_beneath path_beneath;
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access |
+			LANDLOCK_ACCESS_FS_READ_DIR, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	test_path(_metadata, "/proc/self/ns/mnt", 0);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	test_path(_metadata, "/", -1);
+	test_path(_metadata, "/dev", -1);
+	test_path(_metadata, "/dev/null", 0);
+	test_path(_metadata, "/dev/full", -1);
+
+	test_path(_metadata, "/proc", -1);
+	test_path(_metadata, "/proc/self", -1);
+	test_path(_metadata, "/proc/self/ns", -1);
+	/*
+	 * Because nsfs is an internal filesystem, /proc/self/ns/mnt is a
+	 * disconnected path.  Such path cannot be identified and must then be
+	 * allowed.
+	 */
+	test_path(_metadata, "/proc/self/ns/mnt", 0);
+
+	/*
+	 * Checks that it is not possible to add nsfs-like filesystem
+	 * references to a ruleset.
+	 */
+	path_beneath.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_WRITE_FILE,
+	path_beneath.parent_fd = open("/proc/self/ns/mnt", O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+static void drop_privileges(struct __test_metadata *const _metadata)
+{
+	cap_t caps;
+	const cap_value_t cap_val = CAP_SYS_ADMIN;
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_val,
+				CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	ASSERT_EQ(0, cap_free(caps));
+}
+
+TEST_F(layout1, unpriv) {
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	int ruleset_fd;
+
+	drop_privileges(_metadata);
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(-1, landlock_enforce_ruleset(ruleset_fd));
+	ASSERT_EQ(EPERM, errno);
+
+	/* enforce_ruleset() calls prctl(no_new_privs). */
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
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
+			.path = file1_s2d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	char buf;
+	int reg_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Tests on a directory. */
+	test_path(_metadata, "/", -1);
+	test_path(_metadata, dir_s1d1, -1);
+	test_path(_metadata, file1_s1d1, -1);
+	test_path(_metadata, dir_s1d2, 0);
+	test_path(_metadata, file1_s1d2, 0);
+	test_path(_metadata, dir_s1d3, 0);
+	test_path(_metadata, file1_s1d3, 0);
+
+	/* Tests on a file. */
+	test_path(_metadata, dir_s2d2, -1);
+	test_path(_metadata, file1_s2d2, 0);
+
+	/* Checks effective read and write actions. */
+	reg_fd = open(file1_s2d2, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(1, write(reg_fd, ".", 1));
+	ASSERT_LE(0, lseek(reg_fd, 0, SEEK_SET));
+	ASSERT_EQ(1, read(reg_fd, &buf, 1));
+	ASSERT_EQ('.', buf);
+	ASSERT_EQ(0, close(reg_fd));
+
+	/* Just in case, double-checks effective actions. */
+	reg_fd = open(file1_s2d2, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(-1, write(reg_fd, &buf, 1));
+	ASSERT_EQ(EBADF, errno);
+	ASSERT_EQ(0, close(reg_fd));
+}
+
+TEST_F(layout1, unhandled_access)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	set_cap(_metadata, CAP_SYS_CHROOT);
+
+	ASSERT_LE(0, ruleset_fd);
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
+		{}
+	};
+	int open_fd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	open_fd = open(file1_s1d2, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+
+	open_fd = open(file1_s1d3, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+}
+
+TEST_F(layout1, inherit_subset)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{}
+	};
+	int open_fd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(-1, open(file1_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
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
+	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(-1, open(file1_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
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
+	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(-1, open(file1_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
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
+	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(-1, open(file1_s1d2, O_WRONLY | O_CLOEXEC));
+	/* Readdir access is still allowed. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_WRONLY | O_CLOEXEC));
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	/* Readdir of dir_s1d3 is now forbidden too. */
+	ASSERT_EQ(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F(layout1, inherit_superset)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d3,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	int open_fd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Readdir access is denied for dir_s1d2. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_EQ(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is allowed for dir_s1d3. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+
+	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_READ_DIR, dir_s1d2);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Readdir access is still denied for dir_s1d2. */
+	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_EQ(-1, open_fd);
+	ASSERT_EQ(EACCES, errno);
+	/* Readdir access is still allowed for dir_s1d3. */
+	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	ASSERT_EQ(0, close(open_fd));
+}
+
+TEST_F(layout1, max_layers)
+{
+	int i, err;
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	for (i = 0; i < 64; i++)
+		enforce_ruleset(_metadata, ruleset_fd);
+
+	for (i = 0; i < 2; i++) {
+		err = landlock_enforce_ruleset(ruleset_fd);
+		ASSERT_EQ(-1, err);
+		ASSERT_EQ(E2BIG, errno);
+	}
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F(layout1, empty_or_same_ruleset)
+{
+	struct landlock_attr_ruleset attr_ruleset = {};
+	int ruleset_fd;
+
+	/* Tests empty handled_access_fs. */
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(-1, ruleset_fd);
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Enforces policy which deny read access to all files. */
+	attr_ruleset.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE;
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	test_path(_metadata, file1_s1d1, -1);
+	test_path(_metadata, dir_s1d1, 0);
+
+	/* Nests a policy which deny read access to all directories. */
+	attr_ruleset.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR;
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	test_path(_metadata, file1_s1d1, -1);
+	test_path(_metadata, dir_s1d1, -1);
+
+	/* Enforces a second time with the same ruleset. */
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
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
+		{}
+	};
+	int ruleset_fd;
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3)) {
+		TH_LOG("Failed to pivot_root into \"%s\": %s", dir_s3d2,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, chdir("/"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(EPERM, errno);
+}
+
+TEST_F(layout1, move_mount)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s3d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+				dir_s1d2, 0)) {
+		TH_LOG("Failed to move_mount: %s", strerror(errno));
+	}
+	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
+				dir_s3d2, 0));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+				dir_s1d2, 0));
+	ASSERT_EQ(EPERM, errno);
+}
+
+TEST_F(layout1, release_inodes)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d1,
+			.access = ACCESS_RO,
+		},
+		{
+			.path = dir_s3d2,
+			.access = ACCESS_RO,
+		},
+		{
+			.path = dir_s3d3,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	int test_fd;
+
+	ASSERT_LE(0, ruleset_fd);
+	/* Unmount a file hierarchy while it is being used by a ruleset. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, umount(dir_s3d2));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_fd = open(file1_s1d1, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, test_fd);
+	/* This dir_s3d2 is not allowed, only the tmpfs on it was. */
+	ASSERT_EQ(-1, open(dir_s3d2, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	/* This dir_s3d3 would not be allowed and does not exist anyway. */
+	ASSERT_EQ(-1, open(dir_s3d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(ENOENT, errno);
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
+		{}
+	};
+	int dirfd;
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
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
+
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	switch (rel) {
+	case REL_OPEN:
+		dirfd = open(dir_s1d2, O_DIRECTORY);
+		ASSERT_LE(0, dirfd);
+		break;
+	case REL_CHDIR:
+		ASSERT_EQ(0, chdir(dir_s1d2));
+		dirfd = AT_FDCWD;
+		break;
+	case REL_CHROOT_ONLY:
+		/* Do chroot into dir_s1d2 (relative to dir_s2d2). */
+		ASSERT_EQ(0, chroot("../../s1d1/s1d2")) {
+			TH_LOG("Failed to chroot: %s", strerror(errno));
+		}
+		dirfd = AT_FDCWD;
+		break;
+	case REL_CHROOT_CHDIR:
+		/* Do chroot into dir_s1d2. */
+		ASSERT_EQ(0, chroot(".")) {
+			TH_LOG("Failed to chroot: %s", strerror(errno));
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	set_cap(_metadata, CAP_SYS_CHROOT);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, chroot(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, chroot(dir_s1d2)) {
+		TH_LOG("Failed to chroot into \"%s\": %s", file1_s1d2,
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
+		TH_LOG("Failed to open \"%s\": %s", dst_path,
+				strerror(errno));
+	}
+	src_fd = open(BINARY_PATH, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, src_fd) {
+		TH_LOG("Failed to open \"" BINARY_PATH "\": %s",
+				strerror(errno));
+	}
+	ASSERT_EQ(0, fstat(src_fd, &statbuf));
+	ASSERT_EQ(statbuf.st_size, sendfile(dst_fd, src_fd, 0,
+				statbuf.st_size));
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
+			TH_LOG("Failed to execute \"%s\": %s", path,
+					strerror(errno));
+		};
+		ASSERT_EQ(EACCES, errno);
+		_exit(_metadata->passed ? 2 : 1);
+		return;
+	}
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(ret ? 2 : 0, WEXITSTATUS(status)) {
+		TH_LOG("Unexpected return code for \"%s\": %s", path,
+				strerror(errno));
+	};
+}
+
+TEST_F(layout1, execute)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	copy_binary(_metadata, file1_s1d1);
+	copy_binary(_metadata, file1_s1d2);
+	copy_binary(_metadata, file1_s1d3);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	test_execute(_metadata, file1_s1d1, -1);
+	test_execute(_metadata, file1_s1d2, 0);
+	test_execute(_metadata, file1_s1d3, 0);
+}
+
+TEST_F(layout1, link)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Denies linking because of reparenting. */
+	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2)) {
+		TH_LOG("Failed to link file to \"%s\": %s", file2_s1d2,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
+}
+
+TEST_F(layout1, rename_file)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{
+			.path = dir_s2d2,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Replaces file. */
+	ASSERT_EQ(-1, rename(file1_s2d3, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	/* Same parent. */
+	ASSERT_EQ(0, rename(file2_s2d3, file1_s2d3)) {
+		TH_LOG("Failed to rename file \"%s\": %s", file2_s2d3,
+				strerror(errno));
+	};
+
+	/* Renames files. */
+	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	/* Same parent. */
+	ASSERT_EQ(0, rename(file2_s1d3, file1_s1d3));
+}
+
+TEST_F(layout1, rename_dir)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		},
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Empties dir_s1d3. */
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Renames directory. */
+	ASSERT_EQ(-1, rename(dir_s2d3, dir_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, rename(dir_s1d3, file1_s1d2)) {
+		TH_LOG("Failed to rename directory \"%s\": %s", dir_s1d3,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, rmdir(file1_s1d2));
+}
+
+TEST_F(layout1, rmdir)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, rmdir(dir_s1d3));
+	/* dir_s1d2 itself cannot be removed. */
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
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, unlink(file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d2)) {
+		TH_LOG("Failed to unlink file \"%s\": %s", file1_s1d2,
+				strerror(errno));
+	};
+	ASSERT_EQ(0, unlink(file1_s1d3));
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, access, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	unlink(file1_s1d1);
+	unlink(file1_s1d2);
+	unlink(file1_s1d3);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mknod(file1_s1d1, mode | 0400, dev));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev)) {
+		TH_LOG("Failed to make file \"%s\": %s",
+				file1_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, mknod(file1_s1d3, mode | 0400, dev));
+}
+
+TEST_F(layout1, make_char)
+{
+	/* Creates a /dev/null device. */
+	set_cap(_metadata, CAP_MKNOD);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, S_IFCHR,
+			makedev(1, 3));
+}
+
+TEST_F(layout1, make_block)
+{
+	/* Creates a /dev/loop0 device. */
+	set_cap(_metadata, CAP_MKNOD);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_BLOCK, S_IFBLK,
+			makedev(7, 0));
+}
+
+TEST_F(layout1, make_reg)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFREG, 0);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, 0, 0);
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
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, symlink("none", file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, symlink("none", file1_s1d2)) {
+		TH_LOG("Failed to make symlink \"%s\": %s",
+				file1_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, symlink("none", file1_s1d3));
+}
+
+TEST_F(layout1, make_dir)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_DIR,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file1_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Uses file_* as directory names. */
+	ASSERT_EQ(-1, mkdir(file1_s1d1, 0700));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mkdir(file1_s1d2, 0700)) {
+		TH_LOG("Failed to make directory \"%s\": %s",
+				file1_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, mkdir(file1_s1d3, 0700));
+}
+
+static int open_proc_fd(struct __test_metadata *const _metadata, const int fd,
+		const int open_flags)
+{
+	static const char path_template[] = "/proc/self/fd/%d";
+	char procfd_path[sizeof(path_template) + 10];
+	const int procfd_path_size = snprintf(procfd_path, sizeof(procfd_path),
+			path_template, fd);
+
+	ASSERT_LE(procfd_path_size, sizeof(procfd_path));
+	return open(procfd_path, open_flags);
+}
+
+TEST_F(layout1, proc_unlinked_file)
+{
+	const struct rule rules[] = {
+		{
+			.path = file1_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	int reg_fd, proc_fd;
+	const int ruleset_fd = create_ruleset(_metadata,
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, open(file1_s1d2, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	reg_fd = open(file1_s1d2, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	test_path(_metadata, file1_s1d2, 0);
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, proc_fd);
+	EXPECT_EQ(0, close(proc_fd));
+
+	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDWR | O_CLOEXEC);
+	ASSERT_EQ(-1, proc_fd) {
+		TH_LOG("Successfully opened /proc/self/fd/%d: %s",
+				reg_fd, strerror(errno));
+	}
+	ASSERT_EQ(EACCES, errno);
+
+	EXPECT_EQ(0, close(reg_fd));
+}
+
+TEST_F(layout1, proc_pipe)
+{
+	int reg_fd, proc_fd;
+	int pipe_fds[2];
+	char buf = '\0';
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	/* Limits read and write access to files tied to the filesystem. */
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access,
+			rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks enforcement for normal files. */
+	reg_fd = open(file1_s1d2, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	EXPECT_EQ(0, close(reg_fd));
+	ASSERT_EQ(-1, open(file1_s1d1, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Checks access to pipes through FD. */
+	ASSERT_EQ(0, pipe(pipe_fds));
+	ASSERT_EQ(1, write(pipe_fds[1], ".", 1)) {
+		TH_LOG("Failed to write in pipe: %s", strerror(errno));
+	}
+	ASSERT_EQ(1, read(pipe_fds[0], &buf, 1));
+	ASSERT_EQ('.', buf);
+
+	/* Checks write access to pipe through /proc/self/fd . */
+	proc_fd = open_proc_fd(_metadata, pipe_fds[1], O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, proc_fd);
+	ASSERT_EQ(1, write(proc_fd, ".", 1)) {
+		TH_LOG("Failed to write through /proc/self/fd/%d: %s",
+				pipe_fds[1], strerror(errno));
+	}
+	EXPECT_EQ(0, close(proc_fd));
+
+	/* Checks read access to pipe through /proc/self/fd . */
+	proc_fd = open_proc_fd(_metadata, pipe_fds[0], O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, proc_fd);
+	buf = '\0';
+	ASSERT_EQ(1, read(proc_fd, &buf, 1)) {
+		TH_LOG("Failed to read through /proc/self/fd/%d: %s",
+				pipe_fds[1], strerror(errno));
+	}
+	EXPECT_EQ(0, close(proc_fd));
+
+	EXPECT_EQ(0, close(pipe_fds[0]));
+	EXPECT_EQ(0, close(pipe_fds[1]));
+}
+
+TEST(cleanup)
+{
+	cleanup_layout1(_metadata);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
new file mode 100644
index 000000000000..27dffd765931
--- /dev/null
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Ptrace
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
+	int ruleset_fd;
+	struct landlock_attr_features attr_features;
+	struct landlock_attr_ruleset attr_ruleset = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	struct landlock_attr_path_beneath path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+
+	ASSERT_EQ(0, landlock_get_features(&attr_features, sizeof(attr_features)));
+	/* Only for test, use a binary AND for real application instead. */
+	ASSERT_EQ(attr_ruleset.handled_access_fs,
+			attr_ruleset.handled_access_fs & attr_features.access_fs);
+	ruleset_fd = landlock_create_ruleset(&attr_ruleset, sizeof(attr_ruleset));
+	ASSERT_LE(0, ruleset_fd) {
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	path_beneath.parent_fd = open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY
+			| O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, sizeof(path_beneath)));
+	ASSERT_EQ(0, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, errno);
+
+	ASSERT_EQ(0, landlock_enforce_ruleset(ruleset_fd));
+	ASSERT_EQ(0, errno);
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+FIXTURE(hierarchy) { };
+
+FIXTURE_VARIANT(hierarchy) {
+	const bool domain_both;
+	const bool domain_parent;
+	const bool domain_child;
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, allow_without_domain) {
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = false,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_domain) {
+	.domain_both = false,
+	.domain_parent = false,
+	.domain_child = true,
+};
+
+/*
+ *        Parent domain
+ * .------.
+ * |  P1  --.           P1 -> P2 : deny
+ * '------'  \          P2 -> P1 : allow
+ *            '
+ *            P2
+ */
+FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_domain) {
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = false,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_domain) {
+	.domain_both = false,
+	.domain_parent = true,
+	.domain_child = true,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_domain) {
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = false,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_domain) {
+	.domain_both = true,
+	.domain_parent = false,
+	.domain_child = true,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_and_parent_domain) {
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = false,
+};
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
+FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_domain) {
+	.domain_both = true,
+	.domain_parent = true,
+	.domain_child = true,
+};
+
+FIXTURE_SETUP(hierarchy)
+{ }
+
+FIXTURE_TEARDOWN(hierarchy)
+{ }
+
+/* test PTRACE_TRACEME and PTRACE_ATTACH for parent and child */
+TEST_F(hierarchy, trace)
+{
+	pid_t child, parent;
+	int status;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+
+	disable_caps(_metadata);
+
+	parent = getpid();
+	ASSERT_EQ(0, pipe(pipe_child));
+	ASSERT_EQ(0, pipe(pipe_parent));
+	if (variant->domain_both)
+		create_domain(_metadata);
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		EXPECT_EQ(0, close(pipe_parent[1]));
+		EXPECT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child)
+			create_domain(_metadata);
+
+		/* sync #1 */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1)) {
+			TH_LOG("Failed to read() sync #1 from parent");
+		}
+		ASSERT_EQ('.', buf_child);
+
+		/* Tests the parent protection. */
+		ASSERT_EQ(variant->domain_child ? -1 : 0,
+				ptrace(PTRACE_ATTACH, parent, NULL, 0));
+		if (variant->domain_child) {
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
+		ASSERT_EQ(variant->domain_parent ? -1 : 0, ptrace(PTRACE_TRACEME));
+		if (variant->domain_parent) {
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
+	if (variant->domain_parent)
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
+	if (!variant->domain_parent) {
+		ASSERT_EQ(child, waitpid(child, &status, 0));
+		ASSERT_EQ(1, WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	}
+	/* Tests attach. */
+	ASSERT_EQ(variant->domain_parent ? -1 : 0,
+			ptrace(PTRACE_ATTACH, child, NULL, 0));
+	if (variant->domain_parent) {
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
2.28.0.rc2

