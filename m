Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69A3292BCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgJSQtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgJSQtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:49:46 -0400
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [IPv6:2001:1600:3:17::190d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC6BC0613CE
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2020 09:49:45 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CFN5f3BW4zlhM7n;
        Mon, 19 Oct 2020 18:49:42 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CFN5f09Nszlh8TG;
        Mon, 19 Oct 2020 18:49:42 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: [RESEND PATCH v11 3/3] selftest/interpreter: Add tests for trusted_for(2) policies
Date:   Mon, 19 Oct 2020 18:49:32 +0200
Message-Id: <20201019164932.1430614-4-mic@digikod.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019164932.1430614-1-mic@digikod.net>
References: <20201019164932.1430614-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Test that checks performed by trusted_for(2) on file descriptors are
consistent with noexec mount points and file execute permissions,
according to the policy configured with the fs.trust_policy sysctl.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vincent Strubel <vincent.strubel@ssi.gouv.fr>
---

Changes since v10:
* Update selftest Makefile.

Changes since v9:
* Rename the syscall and the sysctl.
* Update tests for enum trusted_for_usage

Changes since v8:
* Update with the dedicated syscall introspect_access(2) and the renamed
  fs.introspection_policy sysctl.
* Remove check symlink which can't be use as is anymore.
* Use socketpair(2) to test UNIX socket.

Changes since v7:
* Update tests with faccessat2/AT_INTERPRETED, including new ones to
  check that setting R_OK or W_OK returns EINVAL.
* Add tests for memfd, pipefs and nsfs.
* Rename and move back tests to a standalone directory.

Changes since v6:
* Add full combination tests for all file types, including block
  devices, character devices, fifos, sockets and symlinks.
* Properly save and restore initial sysctl value for all tests.

Changes since v5:
* Refactor with FIXTURE_VARIANT, which make the tests much more easy to
  read and maintain.
* Save and restore initial sysctl value (suggested by Kees Cook).
* Test with a sysctl value of 0.
* Check errno in sysctl_access_write test.
* Update tests for the CAP_SYS_ADMIN switch.
* Update tests to check -EISDIR (replacing -EACCES).
* Replace FIXTURE_DATA() with FIXTURE() (spotted by Kees Cook).
* Use global const strings.

Changes since v3:
* Replace RESOLVE_MAYEXEC with O_MAYEXEC.
* Add tests to check that O_MAYEXEC is ignored by open(2) and openat(2).

Changes since v2:
* Move tests from exec/ to openat2/ .
* Replace O_MAYEXEC with RESOLVE_MAYEXEC from openat2(2).
* Cleanup tests.

Changes since v1:
* Move tests from yama/ to exec/ .
* Fix _GNU_SOURCE in kselftest_harness.h .
* Add a new test sysctl_access_write to check if CAP_MAC_ADMIN is taken
  into account.
* Test directory execution which is always forbidden since commit
  73601ea5b7b1 ("fs/open.c: allow opening only regular files during
  execve()"), and also check that even the root user can not bypass file
  execution checks.
* Make sure delete_workspace() always as enough right to succeed.
* Cosmetic cleanup.
---
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/interpreter/.gitignore  |   2 +
 tools/testing/selftests/interpreter/Makefile  |  21 +
 tools/testing/selftests/interpreter/config    |   1 +
 .../selftests/interpreter/trust_policy_test.c | 362 ++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 tools/testing/selftests/interpreter/.gitignore
 create mode 100644 tools/testing/selftests/interpreter/Makefile
 create mode 100644 tools/testing/selftests/interpreter/config
 create mode 100644 tools/testing/selftests/interpreter/trust_policy_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9018f45d631d..5a7cf8dd7ce2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -21,6 +21,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += intel_pstate
+TARGETS += interpreter
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
diff --git a/tools/testing/selftests/interpreter/.gitignore b/tools/testing/selftests/interpreter/.gitignore
new file mode 100644
index 000000000000..82a4846cbc4b
--- /dev/null
+++ b/tools/testing/selftests/interpreter/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*_test
diff --git a/tools/testing/selftests/interpreter/Makefile b/tools/testing/selftests/interpreter/Makefile
new file mode 100644
index 000000000000..dbca8ebda67e
--- /dev/null
+++ b/tools/testing/selftests/interpreter/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2
+LDLIBS += -lcap
+
+src_test := $(wildcard *_test.c)
+TEST_GEN_PROGS := $(src_test:.c=)
+
+KSFT_KHDR_INSTALL := 1
+include ../lib.mk
+
+khdr_dir = $(top_srcdir)/usr/include
+
+$(khdr_dir)/asm-generic/unistd.h: khdr
+	@:
+
+$(khdr_dir)/linux/trusted-for.h: khdr
+	@:
+
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/asm-generic/unistd.h $(khdr_dir)/linux/trusted-for.h ../kselftest_harness.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -I$(khdr_dir)
diff --git a/tools/testing/selftests/interpreter/config b/tools/testing/selftests/interpreter/config
new file mode 100644
index 000000000000..dd53c266bf52
--- /dev/null
+++ b/tools/testing/selftests/interpreter/config
@@ -0,0 +1 @@
+CONFIG_SYSCTL=y
diff --git a/tools/testing/selftests/interpreter/trust_policy_test.c b/tools/testing/selftests/interpreter/trust_policy_test.c
new file mode 100644
index 000000000000..4818c5524ec0
--- /dev/null
+++ b/tools/testing/selftests/interpreter/trust_policy_test.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test trusted_for(2) with fs.trust_policy sysctl
+ *
+ * Copyright © 2018-2020 ANSSI
+ *
+ * Author: Mickaël Salaün <mic@digikod.net>
+ */
+
+#define _GNU_SOURCE
+#include <asm-generic/unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/trusted-for.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/capability.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/sysmacros.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef trusted_for
+static int trusted_for(const int fd, const enum trusted_for_usage usage,
+		const __u32 flags)
+{
+	errno = 0;
+	return syscall(__NR_trusted_for, fd, usage, flags);
+}
+#endif
+
+static const char sysctl_path[] = "/proc/sys/fs/trust_policy";
+
+static const char workdir_path[] = "./test-mount";
+static const char reg_file_path[] = "./test-mount/regular_file";
+static const char dir_path[] = "./test-mount/directory";
+static const char block_dev_path[] = "./test-mount/block_device";
+static const char char_dev_path[] = "./test-mount/character_device";
+static const char fifo_path[] = "./test-mount/fifo";
+
+static void ignore_dac(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[2] = {
+		CAP_DAC_OVERRIDE,
+		CAP_DAC_READ_SEARCH,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void ignore_sys_admin(struct __test_metadata *_metadata, int override)
+{
+	cap_t caps;
+	const cap_value_t cap_val[1] = {
+		CAP_SYS_ADMIN,
+	};
+
+	caps = cap_get_proc();
+	ASSERT_NE(NULL, caps);
+	ASSERT_EQ(0, cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_val,
+				override ? CAP_SET : CAP_CLEAR));
+	ASSERT_EQ(0, cap_set_proc(caps));
+	EXPECT_EQ(0, cap_free(caps));
+}
+
+static void test_omx(struct __test_metadata *_metadata,
+		const char *const path, const int err_access)
+{
+	int flags = O_RDONLY | O_CLOEXEC;
+	int fd, access_ret, access_errno;
+
+	/* Do not block on pipes. */
+	if (path == fifo_path)
+		flags |= O_NONBLOCK;
+
+	fd = open(path, flags);
+	ASSERT_LE(0, fd) {
+		TH_LOG("Failed to open %s: %s", path, strerror(errno));
+	}
+	access_ret = trusted_for(fd, TRUSTED_FOR_EXECUTION, 0);
+	access_errno = errno;
+	if (err_access) {
+		ASSERT_EQ(err_access, access_errno) {
+			TH_LOG("Wrong error for trusted_for(2) with %s: %s",
+					path, strerror(access_errno));
+		}
+		ASSERT_EQ(-1, access_ret);
+	} else {
+		ASSERT_EQ(0, access_ret) {
+			TH_LOG("Access denied for %s: %s", path, strerror(access_errno));
+		}
+	}
+
+	/* Tests unsupported trusted usage. */
+	access_ret = trusted_for(fd, 0, 0);
+	ASSERT_EQ(-1, access_ret);
+	ASSERT_EQ(EINVAL, errno);
+
+	access_ret = trusted_for(fd, 2, 0);
+	ASSERT_EQ(-1, access_ret);
+	ASSERT_EQ(EINVAL, errno);
+
+	EXPECT_EQ(0, close(fd));
+}
+
+static void test_policy_fd(struct __test_metadata *_metadata, const int fd,
+		const bool has_policy)
+{
+	const int ret = trusted_for(fd, TRUSTED_FOR_EXECUTION, 0);
+
+	if (has_policy) {
+		ASSERT_EQ(-1, ret);
+		ASSERT_EQ(EACCES, errno) {
+			TH_LOG("Wrong error for trusted_for(2) with FD: %s", strerror(errno));
+		}
+	} else {
+		ASSERT_EQ(0, ret) {
+			TH_LOG("Access denied for FD: %s", strerror(errno));
+		}
+	}
+}
+
+FIXTURE(access) {
+	char initial_sysctl_value;
+	int memfd, pipefd;
+	int pipe_fds[2], socket_fds[2];
+};
+
+static void test_file_types(struct __test_metadata *_metadata, FIXTURE_DATA(access) *self,
+		const int err_code, const bool has_policy)
+{
+	/* Tests are performed on a tmpfs mount point. */
+	test_omx(_metadata, reg_file_path, err_code);
+	test_omx(_metadata, dir_path, has_policy ? EACCES : 0);
+	test_omx(_metadata, block_dev_path, has_policy ? EACCES : 0);
+	test_omx(_metadata, char_dev_path, has_policy ? EACCES : 0);
+	test_omx(_metadata, fifo_path, has_policy ? EACCES : 0);
+
+	/* Checks that exec is denied for any socket FD. */
+	test_policy_fd(_metadata, self->socket_fds[0], has_policy);
+
+	/* Checks that exec is denied for any memfd. */
+	test_policy_fd(_metadata, self->memfd, has_policy);
+
+	/* Checks that exec is denied for any pipefs FD. */
+	test_policy_fd(_metadata, self->pipefd, has_policy);
+}
+
+static void test_files(struct __test_metadata *_metadata, FIXTURE_DATA(access) *self,
+		const int err_code, const bool has_policy)
+{
+	/* Tests as root. */
+	ignore_dac(_metadata, 1);
+	test_file_types(_metadata, self, err_code, has_policy);
+
+	/* Tests without bypass. */
+	ignore_dac(_metadata, 0);
+	test_file_types(_metadata, self, err_code, has_policy);
+}
+
+static void sysctl_write_char(struct __test_metadata *_metadata, const char value)
+{
+	int fd;
+
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, write(fd, &value, 1));
+	EXPECT_EQ(0, close(fd));
+}
+
+static char sysctl_read_char(struct __test_metadata *_metadata)
+{
+	int fd;
+	char sysctl_value;
+
+	fd = open(sysctl_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ASSERT_EQ(1, read(fd, &sysctl_value, 1));
+	EXPECT_EQ(0, close(fd));
+	return sysctl_value;
+}
+
+FIXTURE_VARIANT(access) {
+	const bool mount_exec;
+	const bool file_exec;
+	const int sysctl_err_code[3];
+};
+
+FIXTURE_VARIANT_ADD(access, mount_exec_file_exec) {
+	.mount_exec = true,
+	.file_exec = true,
+	.sysctl_err_code = {0, 0, 0},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_exec_file_noexec)
+{
+	.mount_exec = true,
+	.file_exec = false,
+	.sysctl_err_code = {0, EACCES, EACCES},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_exec)
+{
+	.mount_exec = false,
+	.file_exec = true,
+	.sysctl_err_code = {EACCES, 0, EACCES},
+};
+
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_noexec)
+{
+	.mount_exec = false,
+	.file_exec = false,
+	.sysctl_err_code = {EACCES, EACCES, EACCES},
+};
+
+FIXTURE_SETUP(access)
+{
+	int procfd_path_size;
+	static const char path_template[] = "/proc/self/fd/%d";
+	char procfd_path[sizeof(path_template) + 10];
+
+	/*
+	 * Cleans previous workspace if any error previously happened (don't
+	 * check errors).
+	 */
+	umount(workdir_path);
+	rmdir(workdir_path);
+
+	/* Creates a clean mount point. */
+	ASSERT_EQ(0, mkdir(workdir_path, 00700));
+	ASSERT_EQ(0, mount("test", workdir_path, "tmpfs", MS_MGC_VAL |
+				(variant->mount_exec ? 0 : MS_NOEXEC),
+				"mode=0700,size=4k"));
+
+	/* Creates a regular file. */
+	ASSERT_EQ(0, mknod(reg_file_path, S_IFREG | (variant->file_exec ? 0500 : 0400), 0));
+	/* Creates a directory. */
+	ASSERT_EQ(0, mkdir(dir_path, variant->file_exec ? 0500 : 0400));
+	/* Creates a character device: /dev/null. */
+	ASSERT_EQ(0, mknod(char_dev_path, S_IFCHR | 0400, makedev(1, 3)));
+	/* Creates a block device: /dev/loop0 */
+	ASSERT_EQ(0, mknod(block_dev_path, S_IFBLK | 0400, makedev(7, 0)));
+	/* Creates a fifo. */
+	ASSERT_EQ(0, mknod(fifo_path, S_IFIFO | 0400, 0));
+
+	/* Creates a regular file without user mount point. */
+	self->memfd = memfd_create("test-interpreted", MFD_CLOEXEC);
+	ASSERT_LE(0, self->memfd);
+	/* Sets mode, which must be ignored by the exec check. */
+	ASSERT_EQ(0, fchmod(self->memfd, variant->file_exec ? 0500 : 0400));
+
+	/* Creates a pipefs file descriptor. */
+	ASSERT_EQ(0, pipe(self->pipe_fds));
+	procfd_path_size = snprintf(procfd_path, sizeof(procfd_path),
+			path_template, self->pipe_fds[0]);
+	ASSERT_LT(procfd_path_size, sizeof(procfd_path));
+	self->pipefd = open(procfd_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, self->pipefd);
+	ASSERT_EQ(0, fchmod(self->pipefd, variant->file_exec ? 0500 : 0400));
+
+	/* Creates a socket file descriptor. */
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0, self->socket_fds));
+
+	/* Saves initial sysctl value. */
+	self->initial_sysctl_value = sysctl_read_char(_metadata);
+
+	/* Prepares for sysctl writes. */
+	ignore_sys_admin(_metadata, 1);
+}
+
+FIXTURE_TEARDOWN(access)
+{
+	EXPECT_EQ(0, close(self->memfd));
+	EXPECT_EQ(0, close(self->pipefd));
+	EXPECT_EQ(0, close(self->pipe_fds[0]));
+	EXPECT_EQ(0, close(self->pipe_fds[1]));
+	EXPECT_EQ(0, close(self->socket_fds[0]));
+	EXPECT_EQ(0, close(self->socket_fds[1]));
+
+	/* Restores initial sysctl value. */
+	sysctl_write_char(_metadata, self->initial_sysctl_value);
+
+	/* There is no need to unlink the test files. */
+	ASSERT_EQ(0, umount(workdir_path));
+	ASSERT_EQ(0, rmdir(workdir_path));
+}
+
+TEST_F(access, sysctl_0)
+{
+	/* Do not enforce anything. */
+	sysctl_write_char(_metadata, '0');
+	test_files(_metadata, self, 0, false);
+}
+
+TEST_F(access, sysctl_1)
+{
+	/* Enforces mount exec check. */
+	sysctl_write_char(_metadata, '1');
+	test_files(_metadata, self, variant->sysctl_err_code[0], true);
+}
+
+TEST_F(access, sysctl_2)
+{
+	/* Enforces file exec check. */
+	sysctl_write_char(_metadata, '2');
+	test_files(_metadata, self, variant->sysctl_err_code[1], true);
+}
+
+TEST_F(access, sysctl_3)
+{
+	/* Enforces mount and file exec check. */
+	sysctl_write_char(_metadata, '3');
+	test_files(_metadata, self, variant->sysctl_err_code[2], true);
+}
+
+FIXTURE(cleanup) {
+	char initial_sysctl_value;
+};
+
+FIXTURE_SETUP(cleanup)
+{
+	/* Saves initial sysctl value. */
+	self->initial_sysctl_value = sysctl_read_char(_metadata);
+}
+
+FIXTURE_TEARDOWN(cleanup)
+{
+	/* Restores initial sysctl value. */
+	ignore_sys_admin(_metadata, 1);
+	sysctl_write_char(_metadata, self->initial_sysctl_value);
+}
+
+TEST_F(cleanup, sysctl_access_write)
+{
+	int fd;
+	ssize_t ret;
+
+	ignore_sys_admin(_metadata, 1);
+	sysctl_write_char(_metadata, '0');
+
+	ignore_sys_admin(_metadata, 0);
+	fd = open(sysctl_path, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+	ret = write(fd, "0", 1);
+	ASSERT_EQ(-1, ret);
+	ASSERT_EQ(EPERM, errno);
+	EXPECT_EQ(0, close(fd));
+}
+
+TEST_HARNESS_MAIN
-- 
2.28.0

