Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9233DF62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhCPUoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhCPUnR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:43:17 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02680C0613E6;
        Tue, 16 Mar 2021 13:43:11 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4F0QGk34DzzMq0tN;
        Tue, 16 Mar 2021 21:43:10 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4F0QGj6yXtzlh8T9;
        Tue, 16 Mar 2021 21:43:09 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v30 10/12] selftests/landlock: Add user space tests
Date:   Tue, 16 Mar 2021 21:42:50 +0100
Message-Id: <20210316204252.427806-11-mic@digikod.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316204252.427806-1-mic@digikod.net>
References: <20210316204252.427806-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Test all Landlock system calls, ptrace hooks semantic and filesystem
access-control with multiple layouts.

Test coverage for security/landlock/ is 93.6% of lines.  The code not
covered only deals with internal kernel errors (e.g. memory allocation)
and race conditions.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Reviewed-by: Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>
Link: https://lore.kernel.org/r/20210316204252.427806-11-mic@digikod.net
---

Changes since v29:
* Add new tests with chroot (parent directory).
* Extend test_make_file() and make_sym() to test link(2) and rename(2),
  which helps cover get_mode_access().

Changes since v28:
* Creates a standalone filesystem test environement: do not update the
  root mount point options, and creates a private mount hierarchy with a
  deterministic filesystem (tmpfs).  This is now possible thanks to
  TEST_F_FORK().
* Factor out layout management with prepare_layout() and
  cleanup_layout() for layout1, layout1_bind and layout2_overlay.
* Add and use a drop_caps() helper as much as possible (complementary to
  the disable_caps() helper).  This is possible for fs_test.c thanks to
  TEST_F_FORK().
* Improve layout1.execute to make sure LANDLOCK_ACCESS_FS_EXECUTE only
  restricts execve(2).
* Improve ptrace_test.c with /proc/<pid>/environ checks to also test
  PTRACE_MODE_READ.
* Extend layout1.rename_file and layout1.rename_dir tests with
  renameat2/RENAME_EXCHANGE and more comments.
* Tests unlinkat/AT_REMOVEDIR in complement to rmdir().
* Add a test to layout1.inval to check a rule with a ruleset as a
  path_beneath.parent_fd .
* Add CONFIG_TMPFS_XATTR to avoid overlayfs warnings ("upper fs does not
  support xattr, falling back to index=off and metacopy=off").
* Reduce capabilities use.
* Remove useless TH_LOG().

Changes since v27:
* Add layout1.non_overlapping_accesses to check rules without
  overlapping access rights (fixed in this patchset).
* Extend layout1.interleaved_masked_accesses with a non-overlapping
  execute-only rule.
* Update tests for empty path_beneath.allowed_access, and replace
  useless (i.e. deny-only rules) code in
  layout1.interleaved_masked_accesses with equivalent meaningful rules.
* Fix the returned step when a test failed with TEST_F_FORK().
* Update MAINTAINERS.
* Cosmetic fix to please checkpatch.
* Fix typo in comment.
* Update landlock_restrict_self(2).

Changes since v26:
* Add layout1_bind tests to check inherited bind mount accesses.
* Add layout2_overlay tests to check non-inherited overlayfs accesses.
* Fix final cleanup which was reordered because of kselftest_harness
  changes.
* Update layout1.inherit_subset test according to the
  check_access_path_layer() change.
* Implement TEST_F_FORK() to be able to use FIXTURE_TEARDOWN() to clean
  up layouts even if the test (child) lost access rights or failed.
  Remove now useless layout*.cleanup .
* Update syscall names.
* Clean up FIXTURE_SETUP(layout1).
* Clean up file layout management:
  - Replace specific create_dir_and_file() with generic
    create_directory() and create_file().
  - Replace specific delete_dir_and_file() with generic remove_path().
  - Rename and move cleanup_*() to remove_*() to improve readability.
  - Use EXPECT_*() for all FIXTURE_TEARDOWN() code.

Changes since v25:
* Add a new test to check that Landlock ruleset file descriptors
  received through UNIX sockets are usable.  Contributed by Vincent
  Dagonneau.
* Improve hierarchy.trace tests to not hang when testing on a kernel
  that don't support Landlock.
* Replace EXPECT_EQ(0, close(*)) with ASSERT_EQ(0, close(*)).
* Guard WEXITSTATUS() use with WIFEXITED() in ptrace tests.
* Use pipe2(2) with O_CLOEXEC.
* Remove useless errno set for syscall wrappers, and related useless checks.
* Rename test.
* Add Microsoft copyright for layout1.interleaved_masked_accesses .

Changes since v24:
* Revert the ruleset_overlap test from v24: check that access righs are
  ORed together when building a ruleset.  Keep the extra checks
  added with v24.
* Revert inherit_subset test from v24: use the automatic ORing of
  access rights for the same file.
* Update interleaved_masked_accesses test (added with v24) to stop when
  all layers allowed at least one time an inode in the path walk.
* Extend interleaved_masked_accesses test with new tricky interleaved
  layers which would not work as intended with (allow or deny) bitmask
  layer implementations.
* Simplify and rename test_path*() to test_open*() to make easier the
  diagnostic in case of unattended errors.
* Replace most call to open(2) with a call to test_open(), which
  reduces the number of lines and make tests more readable.
* Fix erroneous check in inherit_superset.

Changes since v23:
* Add an interleaved_masked_accesses test to check corner cases for
  interleaved layered ruleset combinations.
* Update ruleset_overlap and inherit_subset tests to follow the new
  intersect access rights behavior.
* Extend the inherit_superset test to check that layers are handled as
  expected in the superset use case, which complete the inherit_subset
  checks.
* Fix comment (spotted by Vincent Dagonneau).

Changes since v22:
* Extend and add a new test to better check rules applied to the root
  directory: rule_over_root_allow_then_deny, rule_over_root_deny.
* Change the signature of test_path*() to make the calls clearer.

Changes since v21:
* Remove layout1.chroot test and update layout1.unhandled_access to not
  rely on LANDLOCK_ACCESS_FS_CHROOT.
* Clean up comments.

Changes since v20:
* Update with new syscalls and type names.
* Use the full syscall interfaces: explicitely set the "flags" field to
  zero.
* Update the empty_path_beneath_attr test to check for EFAULT.
* Update and merge tests for the simplified copy_min_struct_from_user().
* Clean up makefile.
* Rename some types and variables in a more consistent way.

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
 MAINTAINERS                                   |    1 +
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/landlock/.gitignore   |    2 +
 tools/testing/selftests/landlock/Makefile     |   24 +
 tools/testing/selftests/landlock/base_test.c  |  219 ++
 tools/testing/selftests/landlock/common.h     |  183 ++
 tools/testing/selftests/landlock/config       |    7 +
 tools/testing/selftests/landlock/fs_test.c    | 2792 +++++++++++++++++
 .../testing/selftests/landlock/ptrace_test.c  |  337 ++
 tools/testing/selftests/landlock/true.c       |    5 +
 10 files changed, 3571 insertions(+)
 create mode 100644 tools/testing/selftests/landlock/.gitignore
 create mode 100644 tools/testing/selftests/landlock/Makefile
 create mode 100644 tools/testing/selftests/landlock/base_test.c
 create mode 100644 tools/testing/selftests/landlock/common.h
 create mode 100644 tools/testing/selftests/landlock/config
 create mode 100644 tools/testing/selftests/landlock/fs_test.c
 create mode 100644 tools/testing/selftests/landlock/ptrace_test.c
 create mode 100644 tools/testing/selftests/landlock/true.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 70ec117efa8a..8cab5854844e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10005,6 +10005,7 @@ W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
 F:	include/uapi/linux/landlock.h
 F:	security/landlock/
+F:	tools/testing/selftests/landlock/
 K:	landlock
 K:	LANDLOCK
 
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6c575cf34a71..bc3299a20338 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -25,6 +25,7 @@ TARGETS += ir
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
index 000000000000..a99596ca9882
--- /dev/null
+++ b/tools/testing/selftests/landlock/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -Wall -O2
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
+khdr_dir = $(top_srcdir)/usr/include
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
index 000000000000..262c3c8d953a
--- /dev/null
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -0,0 +1,219 @@
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
+#include <sys/socket.h>
+#include <sys/types.h>
+
+#include "common.h"
+
+#ifndef O_PATH
+#define O_PATH		010000000
+#endif
+
+TEST(inconsistent_attr) {
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *const buf = malloc(page_size + 1);
+	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
+
+	ASSERT_NE(NULL, buf);
+
+	/* Checks copy_from_user(). */
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 0, 0));
+	/* The size if less than sizeof(struct landlock_attr_enforce). */
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, 1, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 1, 0));
+	/* The size if less than sizeof(struct landlock_attr_enforce). */
+	ASSERT_EQ(EFAULT, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(NULL,
+				sizeof(struct landlock_ruleset_attr), 0));
+	ASSERT_EQ(EFAULT, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
+	ASSERT_EQ(E2BIG, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr,
+				sizeof(struct landlock_ruleset_attr), 0));
+	ASSERT_EQ(ENOMSG, errno);
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Checks non-zero value. */
+	buf[page_size - 2] = '.';
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size, 0));
+	ASSERT_EQ(E2BIG, errno);
+
+	ASSERT_EQ(-1, landlock_create_ruleset(ruleset_attr, page_size + 1, 0));
+	ASSERT_EQ(E2BIG, errno);
+
+	free(buf);
+}
+
+TEST(empty_path_beneath_attr) {
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	const int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Similar to struct landlock_path_beneath_attr.parent_fd = 0 */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				NULL, 0));
+	ASSERT_EQ(EFAULT, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST(inval_fd_enforce) {
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(EBADF, errno);
+}
+
+TEST(unpriv_enforce_without_no_new_privs) {
+	int err;
+
+	drop_caps(_metadata);
+	err = landlock_restrict_self(-1, 0);
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(err, -1);
+}
+
+TEST(ruleset_fd_io)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
+	};
+	int ruleset_fd;
+	char buf;
+
+	drop_caps(_metadata);
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
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
+/* Tests enforcement of a ruleset FD transferred through a UNIX socket. */
+TEST(ruleset_fd_transfer)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd_tx, dir_fd;
+	union {
+		/* Aligned ancillary data buffer. */
+		char buf[CMSG_SPACE(sizeof(ruleset_fd_tx))];
+		struct cmsghdr _align;
+	} cmsg_tx = {};
+	char data_tx = '.';
+	struct iovec io = {
+		.iov_base = &data_tx,
+		.iov_len = sizeof(data_tx),
+	};
+	struct msghdr msg = {
+		.msg_iov = &io,
+		.msg_iovlen = 1,
+		.msg_control = &cmsg_tx.buf,
+		.msg_controllen = sizeof(cmsg_tx.buf),
+	};
+	struct cmsghdr *cmsg;
+	int socket_fds[2];
+	pid_t child;
+	int status;
+
+	drop_caps(_metadata);
+
+	/* Creates a test ruleset with a simple rule. */
+	ruleset_fd_tx = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd_tx);
+	path_beneath_attr.parent_fd = open("/tmp", O_PATH | O_NOFOLLOW |
+			O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_attr.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd_tx, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath_attr, 0));
+	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	ASSERT_NE(NULL, cmsg);
+	cmsg->cmsg_len = CMSG_LEN(sizeof(ruleset_fd_tx));
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	memcpy(CMSG_DATA(cmsg), &ruleset_fd_tx, sizeof(ruleset_fd_tx));
+
+	/* Sends the ruleset FD over a socketpair and then close it. */
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, socket_fds));
+	ASSERT_EQ(sizeof(data_tx), sendmsg(socket_fds[0], &msg, 0));
+	ASSERT_EQ(0, close(socket_fds[0]));
+	ASSERT_EQ(0, close(ruleset_fd_tx));
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		int ruleset_fd_rx;
+
+		*(char *)msg.msg_iov->iov_base = '\0';
+		ASSERT_EQ(sizeof(data_tx), recvmsg(socket_fds[1], &msg, MSG_CMSG_CLOEXEC));
+		ASSERT_EQ('.', *(char *)msg.msg_iov->iov_base);
+		ASSERT_EQ(0, close(socket_fds[1]));
+		cmsg = CMSG_FIRSTHDR(&msg);
+		ASSERT_EQ(cmsg->cmsg_len, CMSG_LEN(sizeof(ruleset_fd_tx)));
+		memcpy(&ruleset_fd_rx, CMSG_DATA(cmsg), sizeof(ruleset_fd_tx));
+
+		/* Enforces the received ruleset on the child. */
+		ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+		ASSERT_EQ(0, landlock_restrict_self(ruleset_fd_rx, 0));
+		ASSERT_EQ(0, close(ruleset_fd_rx));
+
+		/* Checks that the ruleset enforcement. */
+		ASSERT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		ASSERT_EQ(EACCES, errno);
+		dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		ASSERT_LE(0, dir_fd);
+		ASSERT_EQ(0, close(dir_fd));
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+
+	ASSERT_EQ(0, close(socket_fds[1]));
+
+	/* Checks that the parent is unrestricted. */
+	dir_fd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, dir_fd);
+	ASSERT_EQ(0, close(dir_fd));
+	dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, dir_fd);
+	ASSERT_EQ(0, close(dir_fd));
+
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
new file mode 100644
index 000000000000..20e2a9286d71
--- /dev/null
+++ b/tools/testing/selftests/landlock/common.h
@@ -0,0 +1,183 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Landlock test helpers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2019-2020 ANSSI
+ * Copyright © 2021 Microsoft Corporation
+ */
+
+#include <errno.h>
+#include <linux/landlock.h>
+#include <sys/capability.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#endif
+
+/*
+ * TEST_F_FORK() is useful when a test drop privileges but the corresponding
+ * FIXTURE_TEARDOWN() requires them (e.g. to remove files from a directory
+ * where write actions are denied).  For convenience, FIXTURE_TEARDOWN() is
+ * also called when the test failed, but not when FIXTURE_SETUP() failed.  For
+ * this to be possible, we must not call abort() but instead exit smoothly
+ * (hence the step print).
+ */
+#define TEST_F_FORK(fixture_name, test_name) \
+	static void fixture_name##_##test_name##_child( \
+		struct __test_metadata *_metadata, \
+		FIXTURE_DATA(fixture_name) *self, \
+		const FIXTURE_VARIANT(fixture_name) *variant); \
+	TEST_F(fixture_name, test_name) \
+	{ \
+		int status; \
+		const pid_t child = fork(); \
+		if (child < 0) \
+			abort(); \
+		if (child == 0) { \
+			_metadata->no_print = 1; \
+			fixture_name##_##test_name##_child(_metadata, self, variant); \
+			if (_metadata->skip) \
+				_exit(255); \
+			if (_metadata->passed) \
+				_exit(0); \
+			_exit(_metadata->step); \
+		} \
+		if (child != waitpid(child, &status, 0)) \
+			abort(); \
+		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
+			_metadata->passed = 0; \
+			_metadata->step = 1; \
+			return; \
+		} \
+		switch (WEXITSTATUS(status)) { \
+		case 0: \
+			_metadata->passed = 1; \
+			break; \
+		case 255: \
+			_metadata->passed = 1; \
+			_metadata->skip = 1; \
+			break; \
+		default: \
+			_metadata->passed = 0; \
+			_metadata->step = WEXITSTATUS(status); \
+			break; \
+		} \
+	} \
+	static void fixture_name##_##test_name##_child( \
+		struct __test_metadata __attribute__((unused)) *_metadata, \
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		const FIXTURE_VARIANT(fixture_name) \
+			__attribute__((unused)) *variant)
+
+#ifndef landlock_create_ruleset
+static inline int landlock_create_ruleset(
+		const struct landlock_ruleset_attr *const attr,
+		const size_t size, const __u32 flags)
+{
+	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
+}
+#endif
+
+#ifndef landlock_add_rule
+static inline int landlock_add_rule(const int ruleset_fd,
+		const enum landlock_rule_type rule_type,
+		const void *const rule_attr, const __u32 flags)
+{
+	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
+			rule_attr, flags);
+}
+#endif
+
+#ifndef landlock_restrict_self
+static inline int landlock_restrict_self(const int ruleset_fd,
+		const __u32 flags)
+{
+	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
+}
+#endif
+
+static void _init_caps(struct __test_metadata *const _metadata, bool drop_all)
+{
+	cap_t cap_p;
+	/* Only these three capabilities are useful for the tests. */
+	const cap_value_t caps[] = {
+		CAP_DAC_OVERRIDE,
+		CAP_MKNOD,
+		CAP_SYS_ADMIN,
+		CAP_SYS_CHROOT,
+	};
+
+	cap_p = cap_get_proc();
+	EXPECT_NE(NULL, cap_p) {
+		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
+	}
+	EXPECT_NE(-1, cap_clear(cap_p)) {
+		TH_LOG("Failed to cap_clear: %s", strerror(errno));
+	}
+	if (!drop_all) {
+		EXPECT_NE(-1, cap_set_flag(cap_p, CAP_PERMITTED,
+					ARRAY_SIZE(caps), caps, CAP_SET)) {
+			TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
+		}
+	}
+	EXPECT_NE(-1, cap_set_proc(cap_p)) {
+		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
+	}
+	EXPECT_NE(-1, cap_free(cap_p)) {
+		TH_LOG("Failed to cap_free: %s", strerror(errno));
+	}
+}
+
+/* We cannot put such helpers in a library because of kselftest_harness.h . */
+__attribute__((__unused__))
+static void disable_caps(struct __test_metadata *const _metadata)
+{
+	_init_caps(_metadata, false);
+}
+
+__attribute__((__unused__))
+static void drop_caps(struct __test_metadata *const _metadata)
+{
+	_init_caps(_metadata, true);
+}
+
+static void _effective_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps, const cap_flag_value_t value)
+{
+	cap_t cap_p;
+
+	cap_p = cap_get_proc();
+	EXPECT_NE(NULL, cap_p) {
+		TH_LOG("Failed to cap_get_proc: %s", strerror(errno));
+	}
+	EXPECT_NE(-1, cap_set_flag(cap_p, CAP_EFFECTIVE, 1, &caps, value)) {
+		TH_LOG("Failed to cap_set_flag: %s", strerror(errno));
+	}
+	EXPECT_NE(-1, cap_set_proc(cap_p)) {
+		TH_LOG("Failed to cap_set_proc: %s", strerror(errno));
+	}
+	EXPECT_NE(-1, cap_free(cap_p)) {
+		TH_LOG("Failed to cap_free: %s", strerror(errno));
+	}
+}
+
+__attribute__((__unused__))
+static void set_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps)
+{
+	_effective_cap(_metadata, caps, CAP_SET);
+}
+
+__attribute__((__unused__))
+static void clear_cap(struct __test_metadata *const _metadata,
+		const cap_value_t caps)
+{
+	_effective_cap(_metadata, caps, CAP_CLEAR);
+}
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
new file mode 100644
index 000000000000..0f0a65287bac
--- /dev/null
+++ b/tools/testing/selftests/landlock/config
@@ -0,0 +1,7 @@
+CONFIG_OVERLAY_FS=y
+CONFIG_SECURITY_LANDLOCK=y
+CONFIG_SECURITY_PATH=y
+CONFIG_SECURITY=y
+CONFIG_SHMEM=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_TMPFS=y
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
new file mode 100644
index 000000000000..af54cc0618c6
--- /dev/null
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -0,0 +1,2792 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Landlock tests - Filesystem
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2020 ANSSI
+ * Copyright © 2020-2021 Microsoft Corporation
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
+#define TMP_DIR		"tmp"
+#define BINARY_PATH	"./true"
+
+/* Paths (sibling number and depth) */
+static const char dir_s1d1[] = TMP_DIR "/s1d1";
+static const char file1_s1d1[] = TMP_DIR "/s1d1/f1";
+static const char file2_s1d1[] = TMP_DIR "/s1d1/f2";
+static const char dir_s1d2[] = TMP_DIR "/s1d1/s1d2";
+static const char file1_s1d2[] = TMP_DIR "/s1d1/s1d2/f1";
+static const char file2_s1d2[] = TMP_DIR "/s1d1/s1d2/f2";
+static const char dir_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3";
+static const char file1_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3/f1";
+static const char file2_s1d3[] = TMP_DIR "/s1d1/s1d2/s1d3/f2";
+
+static const char dir_s2d1[] = TMP_DIR "/s2d1";
+static const char file1_s2d1[] = TMP_DIR "/s2d1/f1";
+static const char dir_s2d2[] = TMP_DIR "/s2d1/s2d2";
+static const char file1_s2d2[] = TMP_DIR "/s2d1/s2d2/f1";
+static const char dir_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3";
+static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
+static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
+
+static const char dir_s3d1[] = TMP_DIR "/s3d1";
+/* dir_s3d2 is a mount point. */
+static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
+static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
+
+/*
+ * layout1 hierarchy:
+ *
+ * tmp
+ * ├── s1d1
+ * │   ├── f1
+ * │   ├── f2
+ * │   └── s1d2
+ * │       ├── f1
+ * │       ├── f2
+ * │       └── s1d3
+ * │           ├── f1
+ * │           └── f2
+ * ├── s2d1
+ * │   ├── f1
+ * │   └── s2d2
+ * │       ├── f1
+ * │       └── s2d3
+ * │           ├── f1
+ * │           └── f2
+ * └── s3d1
+ *     └── s3d2
+ *         └── s3d3
+ */
+
+static void mkdir_parents(struct __test_metadata *const _metadata,
+		const char *const path)
+{
+	char *walker;
+	const char *parent;
+	int i, err;
+
+	ASSERT_NE(path[0], '\0');
+	walker = strdup(path);
+	ASSERT_NE(NULL, walker);
+	parent = walker;
+	for (i = 1; walker[i]; i++) {
+		if (walker[i] != '/')
+			continue;
+		walker[i] = '\0';
+		err = mkdir(parent, 0700);
+		ASSERT_FALSE(err && errno != EEXIST) {
+			TH_LOG("Failed to create directory \"%s\": %s",
+					parent, strerror(errno));
+		}
+		walker[i] = '/';
+	}
+	free(walker);
+}
+
+static void create_directory(struct __test_metadata *const _metadata,
+		const char *const path)
+{
+	mkdir_parents(_metadata, path);
+	ASSERT_EQ(0, mkdir(path, 0700)) {
+		TH_LOG("Failed to create directory \"%s\": %s", path,
+				strerror(errno));
+	}
+}
+
+static void create_file(struct __test_metadata *const _metadata,
+		const char *const path)
+{
+	mkdir_parents(_metadata, path);
+	ASSERT_EQ(0, mknod(path, S_IFREG | 0700, 0)) {
+		TH_LOG("Failed to create file \"%s\": %s", path,
+				strerror(errno));
+	}
+}
+
+static int remove_path(const char *const path)
+{
+	char *walker;
+	int i, ret, err = 0;
+
+	walker = strdup(path);
+	if (!walker) {
+		err = ENOMEM;
+		goto out;
+	}
+	if (unlink(path) && rmdir(path)) {
+		if (errno != ENOENT)
+			err = errno;
+		goto out;
+	}
+	for (i = strlen(walker); i > 0; i--) {
+		if (walker[i] != '/')
+			continue;
+		walker[i] = '\0';
+		ret = rmdir(walker);
+		if (ret) {
+			if (errno != ENOTEMPTY && errno != EBUSY)
+				err = errno;
+			goto out;
+		}
+		if (strcmp(walker, TMP_DIR) == 0)
+			goto out;
+	}
+
+out:
+	free(walker);
+	return err;
+}
+
+static void prepare_layout(struct __test_metadata *const _metadata)
+{
+	disable_caps(_metadata);
+	umask(0077);
+	create_directory(_metadata, TMP_DIR);
+
+	/*
+	 * Do not pollute the rest of the system: creates a private mount point
+	 * for tests relying on pivot_root(2) and move_mount(2).
+	 */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, unshare(CLONE_NEWNS));
+	ASSERT_EQ(0, mount("tmp", TMP_DIR, "tmpfs", 0, "size=4m,mode=700"));
+	ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+static void cleanup_layout(struct __test_metadata *const _metadata)
+{
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, umount(TMP_DIR));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, remove_path(TMP_DIR));
+}
+
+static void create_layout1(struct __test_metadata *const _metadata)
+{
+	create_file(_metadata, file1_s1d1);
+	create_file(_metadata, file1_s1d2);
+	create_file(_metadata, file1_s1d3);
+	create_file(_metadata, file2_s1d1);
+	create_file(_metadata, file2_s1d2);
+	create_file(_metadata, file2_s1d3);
+
+	create_file(_metadata, file1_s2d1);
+	create_file(_metadata, file1_s2d2);
+	create_file(_metadata, file1_s2d3);
+	create_file(_metadata, file2_s2d3);
+
+	create_directory(_metadata, dir_s3d2);
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
+}
+
+static void remove_layout1(struct __test_metadata *const _metadata)
+{
+	EXPECT_EQ(0, remove_path(file2_s1d3));
+	EXPECT_EQ(0, remove_path(file2_s1d2));
+	EXPECT_EQ(0, remove_path(file2_s1d1));
+	EXPECT_EQ(0, remove_path(file1_s1d3));
+	EXPECT_EQ(0, remove_path(file1_s1d2));
+	EXPECT_EQ(0, remove_path(file1_s1d1));
+
+	EXPECT_EQ(0, remove_path(file2_s2d3));
+	EXPECT_EQ(0, remove_path(file1_s2d3));
+	EXPECT_EQ(0, remove_path(file1_s2d2));
+	EXPECT_EQ(0, remove_path(file1_s2d1));
+
+	EXPECT_EQ(0, remove_path(dir_s3d3));
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	umount(dir_s3d2);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, remove_path(dir_s3d2));
+}
+
+FIXTURE(layout1) {
+};
+
+FIXTURE_SETUP(layout1)
+{
+	prepare_layout(_metadata);
+
+	create_layout1(_metadata);
+}
+
+FIXTURE_TEARDOWN(layout1)
+{
+	remove_layout1(_metadata);
+
+	cleanup_layout(_metadata);
+}
+
+/*
+ * This helper enables to use the ASSERT_* macros and print the line number
+ * pointing to the test caller.
+ */
+static int test_open_rel(const int dirfd, const char *const path, const int flags)
+{
+	int fd;
+
+	/* Works with file and directories. */
+	fd = openat(dirfd, path, flags | O_CLOEXEC);
+	if (fd < 0)
+		return errno;
+	/*
+	 * Mixing error codes from close(2) and open(2) should not lead to any
+	 * (access type) confusion for this test.
+	 */
+	if (close(fd) != 0)
+		return errno;
+	return 0;
+}
+
+static int test_open(const char *const path, const int flags)
+{
+	return test_open_rel(AT_FDCWD, path, flags);
+}
+
+TEST_F_FORK(layout1, no_restriction)
+{
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s2d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, inval)
+{
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE,
+		.parent_fd = -1,
+	};
+	struct landlock_ruleset_attr ruleset_attr = {
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
+				&path_beneath, 0));
+	/* Returns EBADF because ruleset_fd contains O_PATH. */
+	ASSERT_EQ(EBADF, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ruleset_fd = open(dir_s1d1, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	/* Returns EBADFD because ruleset_fd is not a valid ruleset. */
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Gets a real ruleset. */
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Tests without O_PATH. */
+	path_beneath.parent_fd = open(dir_s1d2, O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Tests with a ruleset FD. */
+	path_beneath.parent_fd = ruleset_fd;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(EBADFD, errno);
+
+	/* Checks unhandled allowed_access. */
+	path_beneath.parent_fd = open(dir_s1d2, O_PATH | O_DIRECTORY |
+			O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+
+	/* Test with legitimate values. */
+	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_EXECUTE;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(EINVAL, errno);
+	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
+
+	/* Test with unknown (64-bits) value. */
+	path_beneath.allowed_access |= (1ULL << 60);
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(EINVAL, errno);
+	path_beneath.allowed_access &= ~(1ULL << 60);
+
+	/* Test with no access. */
+	path_beneath.allowed_access = 0;
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0));
+	ASSERT_EQ(ENOMSG, errno);
+	path_beneath.allowed_access &= ~(1ULL << 60);
+
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+
+	/* Enforces the ruleset. */
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
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
+TEST_F_FORK(layout1, file_access_rights)
+{
+	__u64 access;
+	int err;
+	struct landlock_path_beneath_attr path_beneath = {};
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = ACCESS_ALL,
+	};
+	const int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+
+	/* Tests access rights for files. */
+	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd);
+	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
+		path_beneath.allowed_access = access;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0);
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
+	struct landlock_path_beneath_attr path_beneath = {
+		.allowed_access = allowed_access,
+	};
+
+	path_beneath.parent_fd = open(path, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath.parent_fd) {
+		TH_LOG("Failed to open directory \"%s\": %s", path,
+				strerror(errno));
+	}
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				&path_beneath, 0)) {
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
+	struct landlock_ruleset_attr ruleset_attr = {
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
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd) {
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+
+	for (i = 0; rules[i].path; i++) {
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
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0)) {
+		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
+	}
+}
+
+TEST_F_FORK(layout1, proc_nsfs)
+{
+	const struct rule rules[] = {
+		{
+			.path = "/dev/null",
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	struct landlock_path_beneath_attr path_beneath;
+	const int ruleset_fd = create_ruleset(_metadata, rules[0].access |
+			LANDLOCK_ACCESS_FS_READ_DIR, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open("/dev", O_RDONLY));
+	ASSERT_EQ(0, test_open("/dev/null", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open("/dev/full", O_RDONLY));
+
+	ASSERT_EQ(EACCES, test_open("/proc", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open("/proc/self", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open("/proc/self/ns", O_RDONLY));
+	/*
+	 * Because nsfs is an internal filesystem, /proc/self/ns/mnt is a
+	 * disconnected path.  Such path cannot be identified and must then be
+	 * allowed.
+	 */
+	ASSERT_EQ(0, test_open("/proc/self/ns/mnt", O_RDONLY));
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
+				&path_beneath, 0));
+	ASSERT_EQ(EBADFD, errno);
+	ASSERT_EQ(0, close(path_beneath.parent_fd));
+}
+
+TEST_F_FORK(layout1, unpriv) {
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	int ruleset_fd;
+
+	drop_caps(_metadata);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
+	ASSERT_EQ(EPERM, errno);
+
+	/* enforce_ruleset() calls prctl(no_new_privs). */
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, effective_access)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Tests on a directory. */
+	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+
+	/* Tests on a file. */
+	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
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
+TEST_F_FORK(layout1, unhandled_access)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	/* Here, we only handle read accesses, not write accesses. */
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RO, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Because the policy does not handle LANDLOCK_ACCESS_FS_WRITE_FILE,
+	 * opening for write-only should be allowed, but not read-write.
+	 */
+	ASSERT_EQ(0, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+
+	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
+}
+
+TEST_F_FORK(layout1, ruleset_overlap)
+{
+	const struct rule rules[] = {
+		/* These rules should be ORed among them. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks s1d1 hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d2 hierarchy. */
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* Checks s1d3 hierarchy. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+}
+
+TEST_F_FORK(layout1, non_overlapping_accesses)
+{
+	const struct rule layer1[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
+		},
+		{}
+	};
+	const struct rule layer2[] = {
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd;
+
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG,
+			layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_REMOVE_FILE,
+			layer2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Unchanged accesses for file creation. */
+	ASSERT_EQ(-1, mknod(file1_s1d1, S_IFREG | 0700, 0));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mknod(file1_s1d2, S_IFREG | 0700, 0));
+
+	/* Checks file removing. */
+	ASSERT_EQ(-1, unlink(file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d3));
+}
+
+TEST_F_FORK(layout1, interleaved_masked_accesses)
+{
+	/*
+	 * Checks overly restrictive rules:
+	 * layer 1: allows R   s1d1/s1d2/s1d3/file1
+	 * layer 2: allows RW  s1d1/s1d2/s1d3
+	 *          allows  W  s1d1/s1d2
+	 *          denies R   s1d1/s1d2
+	 * layer 3: allows R   s1d1
+	 * layer 4: allows R   s1d1/s1d2
+	 *          denies  W  s1d1/s1d2
+	 * layer 5: allows R   s1d1/s1d2
+	 * layer 6: allows   X ----
+	 * layer 7: allows  W  s1d1/s1d2
+	 *          denies R   s1d1/s1d2
+	 */
+	const struct rule layer1_read[] = {
+		/* Allows read access to file1_s1d3 with the first layer. */
+		{
+			.path = file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	/* First rule with write restrictions. */
+	const struct rule layer2_read_write[] = {
+		/* Start by granting read-write access via its parent directory... */
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* ...but also denies read access via its grandparent directory. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const struct rule layer3_read[] = {
+		/* Allows read access via its great-grandparent directory. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const struct rule layer4_read_write[] = {
+		/*
+		 * Try to confuse the deny access by denying write (but not
+		 * read) access via its grandparent directory.
+		 */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const struct rule layer5_read[] = {
+		/*
+		 * Try to override layer2's deny read access by explicitly
+		 * allowing read access via file1_s1d3's grandparent.
+		 */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const struct rule layer6_execute[] = {
+		/*
+		 * Restricts an unrelated file hierarchy with a new access
+		 * (non-overlapping) type.
+		 */
+		{
+			.path = dir_s2d1,
+			.access = LANDLOCK_ACCESS_FS_EXECUTE,
+		},
+		{}
+	};
+	const struct rule layer7_read_write[] = {
+		/*
+		 * Finally, denies read access to file1_s1d3 via its
+		 * grandparent.
+		 */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+			layer1_read);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that read access is granted for file1_s1d3 with layer 1. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE, layer2_read_write);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that previous access rights are unchanged with layer 2. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+			layer3_read);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that previous access rights are unchanged with layer 3. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file2_s1d3, O_WRONLY));
+
+	/* This time, denies write access for the file hierarchy. */
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE, layer4_read_write);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that the only change with layer 4 is that write access is
+	 * denied.
+	 */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE,
+			layer5_read);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that previous access rights are unchanged with layer 5. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_EXECUTE,
+			layer6_execute);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that previous access rights are unchanged with layer 6. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+
+	ruleset_fd = create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_WRITE_FILE, layer7_read_write);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks read access is now denied with layer 7. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(file2_s1d3, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, inherit_subset)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	/* Readdir access is allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* Write access is forbidden. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	/* Readdir access is allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
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
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	/* Readdir access is still allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	/* Readdir access is still allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+
+	/*
+	 * Try to get more privileges by adding new access rights to the parent
+	 * directory: dir_s1d1.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, ACCESS_RW, dir_s1d1);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	/* Readdir access is still allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	/* Readdir access is still allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+
+	/*
+	 * Now, dir_s1d3 get a new rule tied to it, only allowing
+	 * LANDLOCK_ACCESS_FS_WRITE_FILE.  The (kernel internal) difference is
+	 * that there was no rule tied to it before.
+	 */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
+			dir_s1d3);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Same tests and results as above, except for open(dir_s1d3) which is
+	 * now denied because the new rule mask the rule previously inherited
+	 * from dir_s1d2.
+	 */
+
+	/* Same tests and results as above. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d2. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	/* Readdir access is still allowed. */
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* It is still forbidden to write in file1_s1d3. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	/*
+	 * Readdir of dir_s1d3 is still allowed because of the OR policy inside
+	 * the same layer.
+	 */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+}
+
+TEST_F_FORK(layout1, inherit_superset)
+{
+	const struct rule rules[] = {
+		{
+			.path = dir_s1d3,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+
+	/* Readdir access is denied for dir_s1d2. */
+	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	/* Readdir access is allowed for dir_s1d3. */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	/* File access is allowed for file1_s1d3. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+
+	/* Now dir_s1d2, parent of dir_s1d3, gets a new rule tied to it. */
+	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_READ_DIR, dir_s1d2);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Readdir access is still denied for dir_s1d2. */
+	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+	/* Readdir access is still allowed for dir_s1d3. */
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+	/* File access is still allowed for file1_s1d3. */
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, max_layers)
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
+		err = landlock_restrict_self(ruleset_fd, 0);
+		ASSERT_EQ(-1, err);
+		ASSERT_EQ(E2BIG, errno);
+	}
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, empty_or_same_ruleset)
+{
+	struct landlock_ruleset_attr ruleset_attr = {};
+	int ruleset_fd;
+
+	/* Tests empty handled_access_fs. */
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(-1, ruleset_fd);
+	ASSERT_EQ(ENOMSG, errno);
+
+	/* Enforces policy which deny read access to all files. */
+	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE;
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+
+	/* Nests a policy which deny read access to all directories. */
+	ruleset_attr.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR;
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+
+	/* Enforces a second time with the same ruleset. */
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, rule_on_mountpoint)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+
+	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+
+	ASSERT_EQ(EACCES, test_open(dir_s3d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, rule_over_mountpoint)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+
+	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s3d3, O_RDONLY));
+}
+
+/*
+ * This test verifies that we can apply a landlock rule on the root directory
+ * (which might require special handling).
+ */
+TEST_F_FORK(layout1, rule_over_root_allow_then_deny)
+{
+	struct rule rules[] = {
+		{
+			.path = "/",
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks allowed access. */
+	ASSERT_EQ(0, test_open("/", O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+
+	rules[0].access = LANDLOCK_ACCESS_FS_READ_FILE;
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks denied access (on a directory). */
+	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, rule_over_root_deny)
+{
+	const struct rule rules[] = {
+		{
+			.path = "/",
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks denied access (on a directory). */
+	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+}
+
+TEST_F_FORK(layout1, rule_inside_mount_ns)
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
+	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3)) {
+		TH_LOG("Failed to pivot root: %s", strerror(errno));
+	};
+	ASSERT_EQ(0, chdir("/"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_open("s3d3", O_RDONLY));
+	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+}
+
+TEST_F_FORK(layout1, mount_and_pivot)
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
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+TEST_F_FORK(layout1, move_mount)
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
+	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+				dir_s1d2, 0)) {
+		TH_LOG("Failed to move mount: %s", strerror(errno));
+	}
+
+	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
+				dir_s3d2, 0));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(-1, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+				dir_s1d2, 0));
+	ASSERT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+TEST_F_FORK(layout1, release_inodes)
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
+
+	ASSERT_LE(0, ruleset_fd);
+	/* Unmount a file hierarchy while it is being used by a ruleset. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, umount(dir_s3d2));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s3d2, O_RDONLY));
+	/* This dir_s3d3 would not be allowed and does not exist anyway. */
+	ASSERT_EQ(ENOENT, test_open(dir_s3d3, O_RDONLY));
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
+	/*
+	 * Common layer to check that chroot doesn't ignore it (i.e. a chroot
+	 * is not a disconnected root directory).
+	 */
+	const struct rule layer1_base[] = {
+		{
+			.path = TMP_DIR,
+			.access = ACCESS_RO,
+		},
+		{}
+	};
+	const struct rule layer2_subs[] = {
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
+	int dirfd, ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_subs);
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
+	ASSERT_EQ((rel == REL_CHROOT_CHDIR) ? 0 : EACCES,
+			test_open_rel(dirfd, "..", O_RDONLY));
+	ASSERT_EQ(0, test_open_rel(dirfd, ".", O_RDONLY));
+
+	if (rel == REL_CHROOT_ONLY) {
+		/* The current directory is dir_s2d2. */
+		ASSERT_EQ(0, test_open_rel(dirfd, "./s2d3", O_RDONLY));
+	} else {
+		/* The current directory is dir_s1d2. */
+		ASSERT_EQ(0, test_open_rel(dirfd, "./s1d3", O_RDONLY));
+	}
+
+	if (rel == REL_CHROOT_ONLY || rel == REL_CHROOT_CHDIR) {
+		/* Checks the root dir_s1d2. */
+		ASSERT_EQ(0, test_open_rel(dirfd, "/..", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "/", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "/f1", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "/s1d3", O_RDONLY));
+	}
+
+	if (rel != REL_CHROOT_CHDIR) {
+		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s1d1", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s1d1/s1d2/s1d3", O_RDONLY));
+
+		ASSERT_EQ(EACCES, test_open_rel(dirfd, "../../s2d1", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2", O_RDONLY));
+		ASSERT_EQ(0, test_open_rel(dirfd, "../../s2d1/s2d2/s2d3", O_RDONLY));
+	}
+
+	if (rel == REL_OPEN)
+		ASSERT_EQ(0, close(dirfd));
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
+TEST_F_FORK(layout1, relative_open)
+{
+	test_relative_path(_metadata, REL_OPEN);
+}
+
+TEST_F_FORK(layout1, relative_chdir)
+{
+	test_relative_path(_metadata, REL_CHDIR);
+}
+
+TEST_F_FORK(layout1, relative_chroot_only)
+{
+	test_relative_path(_metadata, REL_CHROOT_ONLY);
+}
+
+TEST_F_FORK(layout1, relative_chroot_chdir)
+{
+	test_relative_path(_metadata, REL_CHROOT_CHDIR);
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
+		const int err, const char *const path)
+{
+	int status;
+	char *const argv[] = {(char *)path, NULL};
+	const pid_t child = fork();
+
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		ASSERT_EQ(err ? -1 : 0, execve(path, argv, NULL)) {
+			TH_LOG("Failed to execute \"%s\": %s", path,
+					strerror(errno));
+		};
+		ASSERT_EQ(err, errno);
+		_exit(_metadata->passed ? 2 : 1);
+		return;
+	}
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	ASSERT_EQ(1, WIFEXITED(status));
+	ASSERT_EQ(err ? 2 : 0, WEXITSTATUS(status)) {
+		TH_LOG("Unexpected return code for \"%s\": %s", path,
+				strerror(errno));
+	};
+}
+
+TEST_F_FORK(layout1, execute)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	test_execute(_metadata, EACCES, file1_s1d1);
+
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	test_execute(_metadata, 0, file1_s1d2);
+
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	test_execute(_metadata, 0, file1_s1d3);
+}
+
+TEST_F_FORK(layout1, link)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	/* Denies linking because of reparenting. */
+	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
+	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
+}
+
+TEST_F_FORK(layout1, rename_file)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Tries to replace a file, from a directory that allows file removal,
+	 * but to a different directory (which also allows file removal).
+	 */
+	ASSERT_EQ(-1, rename(file1_s2d3, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, file1_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d3, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Tries to replace a file, from a directory that denies file removal,
+	 * to a different directory (which allows file removal).
+	 */
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Exchanges files and directories that partially allow removal. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s2d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, dir_s2d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Renames files with different parents. */
+	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
+	ASSERT_EQ(EACCES, errno);
+
+	/* Exchanges and renames files with same parent. */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(0, rename(file2_s2d3, file1_s2d3));
+
+	/* Exchanges files and directories with same parent, twice. */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s2d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(0, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s2d3,
+				RENAME_EXCHANGE));
+}
+
+TEST_F_FORK(layout1, rename_dir)
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
+	/* Empties dir_s1d3 to allow renaming. */
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Exchanges and renames directory to a different parent. */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d3, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(dir_s2d3, dir_s1d3));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d2, AT_FDCWD, dir_s1d3,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Exchanges directory to the same parent, which doesn't allow
+	 * directory removal.
+	 */
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d1, AT_FDCWD, dir_s2d1,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s1d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(EACCES, errno);
+
+	/*
+	 * Exchanges and renames directory to the same parent, which allows
+	 * directory removal.
+	 */
+	ASSERT_EQ(0, renameat2(AT_FDCWD, dir_s1d3, AT_FDCWD, file1_s1d2,
+				RENAME_EXCHANGE));
+	ASSERT_EQ(0, unlink(dir_s1d3));
+	ASSERT_EQ(0, mkdir(dir_s1d3, 0700));
+	ASSERT_EQ(0, rename(file1_s1d2, dir_s1d3));
+	ASSERT_EQ(0, rmdir(dir_s1d3));
+}
+
+TEST_F_FORK(layout1, remove_dir)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, rmdir(dir_s1d3));
+	ASSERT_EQ(0, mkdir(dir_s1d3, 0700));
+	ASSERT_EQ(0, unlinkat(AT_FDCWD, dir_s1d3, AT_REMOVEDIR));
+
+	/* dir_s1d2 itself cannot be removed. */
+	ASSERT_EQ(-1, rmdir(dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d2, AT_REMOVEDIR));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rmdir(dir_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, unlinkat(AT_FDCWD, dir_s1d1, AT_REMOVEDIR));
+	ASSERT_EQ(EACCES, errno);
+}
+
+TEST_F_FORK(layout1, remove_file)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, unlink(file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, unlinkat(AT_FDCWD, file1_s1d1, 0));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlinkat(AT_FDCWD, file1_s1d3, 0));
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
+	ASSERT_EQ(0, unlink(file1_s1d1));
+	ASSERT_EQ(0, unlink(file2_s1d1));
+	ASSERT_EQ(0, mknod(file2_s1d1, mode | 0400, dev)) {
+		TH_LOG("Failed to make file \"%s\": %s",
+				file2_s1d1, strerror(errno));
+	};
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d2));
+
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, mknod(file1_s1d1, mode | 0400, dev));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, mknod(file1_s1d2, mode | 0400, dev)) {
+		TH_LOG("Failed to make file \"%s\": %s",
+				file1_s1d2, strerror(errno));
+	};
+	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d2));
+	ASSERT_EQ(0, rename(file1_s1d2, file2_s1d2));
+
+	ASSERT_EQ(0, mknod(file1_s1d3, mode | 0400, dev));
+	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+	ASSERT_EQ(0, rename(file1_s1d3, file2_s1d3));
+}
+
+TEST_F_FORK(layout1, make_char)
+{
+	/* Creates a /dev/null device. */
+	set_cap(_metadata, CAP_MKNOD);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_CHAR, S_IFCHR,
+			makedev(1, 3));
+}
+
+TEST_F_FORK(layout1, make_block)
+{
+	/* Creates a /dev/loop0 device. */
+	set_cap(_metadata, CAP_MKNOD);
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_BLOCK, S_IFBLK,
+			makedev(7, 0));
+}
+
+TEST_F_FORK(layout1, make_reg_1)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, S_IFREG, 0);
+}
+
+TEST_F_FORK(layout1, make_reg_2)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_REG, 0, 0);
+}
+
+TEST_F_FORK(layout1, make_sock)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_SOCK, S_IFSOCK, 0);
+}
+
+TEST_F_FORK(layout1, make_fifo)
+{
+	test_make_file(_metadata, LANDLOCK_ACCESS_FS_MAKE_FIFO, S_IFIFO, 0);
+}
+
+TEST_F_FORK(layout1, make_sym)
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
+	ASSERT_EQ(0, unlink(file2_s1d1));
+	ASSERT_EQ(0, symlink("none", file2_s1d1));
+
+	ASSERT_EQ(0, unlink(file1_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d2));
+
+	ASSERT_EQ(0, unlink(file1_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(-1, symlink("none", file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, rename(file2_s1d1, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, symlink("none", file1_s1d2));
+	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d2));
+	ASSERT_EQ(0, rename(file1_s1d2, file2_s1d2));
+
+	ASSERT_EQ(0, symlink("none", file1_s1d3));
+	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+	ASSERT_EQ(0, rename(file1_s1d3, file2_s1d3));
+}
+
+TEST_F_FORK(layout1, make_dir)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Uses file_* as directory names. */
+	ASSERT_EQ(-1, mkdir(file1_s1d1, 0700));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(0, mkdir(file1_s1d2, 0700));
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
+	ASSERT_LT(procfd_path_size, sizeof(procfd_path));
+	return open(procfd_path, open_flags);
+}
+
+TEST_F_FORK(layout1, proc_unlinked_file)
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	reg_fd = open(file1_s1d2, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, reg_fd);
+	ASSERT_EQ(0, unlink(file1_s1d2));
+
+	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, proc_fd);
+	ASSERT_EQ(0, close(proc_fd));
+
+	proc_fd = open_proc_fd(_metadata, reg_fd, O_RDWR | O_CLOEXEC);
+	ASSERT_EQ(-1, proc_fd) {
+		TH_LOG("Successfully opened /proc/self/fd/%d: %s",
+				reg_fd, strerror(errno));
+	}
+	ASSERT_EQ(EACCES, errno);
+
+	ASSERT_EQ(0, close(reg_fd));
+}
+
+TEST_F_FORK(layout1, proc_pipe)
+{
+	int proc_fd;
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
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks enforcement for normal files. */
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDWR));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDWR));
+
+	/* Checks access to pipes through FD. */
+	ASSERT_EQ(0, pipe2(pipe_fds, O_CLOEXEC));
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
+	ASSERT_EQ(0, close(proc_fd));
+
+	/* Checks read access to pipe through /proc/self/fd . */
+	proc_fd = open_proc_fd(_metadata, pipe_fds[0], O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, proc_fd);
+	buf = '\0';
+	ASSERT_EQ(1, read(proc_fd, &buf, 1)) {
+		TH_LOG("Failed to read through /proc/self/fd/%d: %s",
+				pipe_fds[1], strerror(errno));
+	}
+	ASSERT_EQ(0, close(proc_fd));
+
+	ASSERT_EQ(0, close(pipe_fds[0]));
+	ASSERT_EQ(0, close(pipe_fds[1]));
+}
+
+FIXTURE(layout1_bind) {
+};
+
+FIXTURE_SETUP(layout1_bind)
+{
+	prepare_layout(_metadata);
+
+	create_layout1(_metadata);
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(layout1_bind)
+{
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, umount(dir_s2d2));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+
+	remove_layout1(_metadata);
+
+	cleanup_layout(_metadata);
+}
+
+static const char bind_dir_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3";
+static const char bind_file1_s1d3[] = TMP_DIR "/s2d1/s2d2/s1d3/f1";
+
+/*
+ * layout1_bind hierarchy:
+ *
+ * tmp
+ * ├── s1d1
+ * │   ├── f1
+ * │   ├── f2
+ * │   └── s1d2
+ * │       ├── f1
+ * │       ├── f2
+ * │       └── s1d3
+ * │           ├── f1
+ * │           └── f2
+ * ├── s2d1
+ * │   ├── f1
+ * │   └── s2d2
+ * │       ├── f1
+ * │       ├── f2
+ * │       └── s1d3
+ * │           ├── f1
+ * │           └── f2
+ * └── s3d1
+ *     └── s3d2
+ *         └── s3d3
+ */
+
+TEST_F_FORK(layout1_bind, no_restriction)
+{
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
+	ASSERT_EQ(ENOENT, test_open(dir_s2d3, O_RDONLY));
+	ASSERT_EQ(ENOENT, test_open(file1_s2d3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY));
+	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(dir_s3d1, O_RDONLY));
+}
+
+TEST_F_FORK(layout1_bind, same_content_same_file)
+{
+	/*
+	 * Sets access right on parent directories of both source and
+	 * destination mount points.
+	 */
+	const struct rule layer1_parent[] = {
+		{
+			.path = dir_s1d1,
+			.access = ACCESS_RO,
+		},
+		{
+			.path = dir_s2d1,
+			.access = ACCESS_RW,
+		},
+		{}
+	};
+	/*
+	 * Sets access rights on the same bind-mounted directories.  The result
+	 * should be ACCESS_RW for both directories, but not both hierarchies
+	 * because of the first layer.
+	 */
+	const struct rule layer2_mount_point[] = {
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = dir_s2d2,
+			.access = ACCESS_RW,
+		},
+		{}
+	};
+	/* Only allow read-access to the s1d3 hierarchies. */
+	const struct rule layer3_source[] = {
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	/* Removes all access rights. */
+	const struct rule layer4_destination[] = {
+		{
+			.path = bind_file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd;
+
+	/* Sets rules for the parent directories. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_parent);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks source hierarchy. */
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* Checks destination hierarchy. */
+	ASSERT_EQ(0, test_open(file1_s2d1, O_RDWR));
+	ASSERT_EQ(0, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+
+	/* Sets rules for the mount points. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_mount_point);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks source hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	/* Checks destination hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s2d1, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s2d1, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(file1_s2d2, O_RDWR));
+	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+	ASSERT_EQ(0, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+
+	/* Sets a (shared) rule only on the source. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3_source);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks source hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d2, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d2, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s1d3, O_RDONLY | O_DIRECTORY));
+
+	/* Checks destination hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s2d2, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY | O_DIRECTORY));
+
+	ASSERT_EQ(0, test_open(bind_file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+	ASSERT_EQ(EACCES, test_open(bind_dir_s1d3, O_RDONLY | O_DIRECTORY));
+
+	/* Sets a (shared) rule only on the destination. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer4_destination);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks source hierarchy. */
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(file1_s1d3, O_WRONLY));
+
+	/* Checks destination hierarchy. */
+	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_RDONLY));
+	ASSERT_EQ(EACCES, test_open(bind_file1_s1d3, O_WRONLY));
+}
+
+#define LOWER_BASE	TMP_DIR "/lower"
+#define LOWER_DATA	LOWER_BASE "/data"
+static const char lower_fl1[] = LOWER_DATA "/fl1";
+static const char lower_dl1[] = LOWER_DATA "/dl1";
+static const char lower_dl1_fl2[] = LOWER_DATA "/dl1/fl2";
+static const char lower_fo1[] = LOWER_DATA "/fo1";
+static const char lower_do1[] = LOWER_DATA "/do1";
+static const char lower_do1_fo2[] = LOWER_DATA "/do1/fo2";
+static const char lower_do1_fl3[] = LOWER_DATA "/do1/fl3";
+
+static const char (*lower_base_files[])[] = {
+	&lower_fl1,
+	&lower_fo1,
+	NULL
+};
+static const char (*lower_base_directories[])[] = {
+	&lower_dl1,
+	&lower_do1,
+	NULL
+};
+static const char (*lower_sub_files[])[] = {
+	&lower_dl1_fl2,
+	&lower_do1_fo2,
+	&lower_do1_fl3,
+	NULL
+};
+
+#define UPPER_BASE	TMP_DIR "/upper"
+#define UPPER_DATA	UPPER_BASE "/data"
+#define UPPER_WORK	UPPER_BASE "/work"
+static const char upper_fu1[] = UPPER_DATA "/fu1";
+static const char upper_du1[] = UPPER_DATA "/du1";
+static const char upper_du1_fu2[] = UPPER_DATA "/du1/fu2";
+static const char upper_fo1[] = UPPER_DATA "/fo1";
+static const char upper_do1[] = UPPER_DATA "/do1";
+static const char upper_do1_fo2[] = UPPER_DATA "/do1/fo2";
+static const char upper_do1_fu3[] = UPPER_DATA "/do1/fu3";
+
+static const char (*upper_base_files[])[] = {
+	&upper_fu1,
+	&upper_fo1,
+	NULL
+};
+static const char (*upper_base_directories[])[] = {
+	&upper_du1,
+	&upper_do1,
+	NULL
+};
+static const char (*upper_sub_files[])[] = {
+	&upper_du1_fu2,
+	&upper_do1_fo2,
+	&upper_do1_fu3,
+	NULL
+};
+
+#define MERGE_BASE	TMP_DIR "/merge"
+#define MERGE_DATA	MERGE_BASE "/data"
+static const char merge_fl1[] = MERGE_DATA "/fl1";
+static const char merge_dl1[] = MERGE_DATA "/dl1";
+static const char merge_dl1_fl2[] = MERGE_DATA "/dl1/fl2";
+static const char merge_fu1[] = MERGE_DATA "/fu1";
+static const char merge_du1[] = MERGE_DATA "/du1";
+static const char merge_du1_fu2[] = MERGE_DATA "/du1/fu2";
+static const char merge_fo1[] = MERGE_DATA "/fo1";
+static const char merge_do1[] = MERGE_DATA "/do1";
+static const char merge_do1_fo2[] = MERGE_DATA "/do1/fo2";
+static const char merge_do1_fl3[] = MERGE_DATA "/do1/fl3";
+static const char merge_do1_fu3[] = MERGE_DATA "/do1/fu3";
+
+static const char (*merge_base_files[])[] = {
+	&merge_fl1,
+	&merge_fu1,
+	&merge_fo1,
+	NULL
+};
+static const char (*merge_base_directories[])[] = {
+	&merge_dl1,
+	&merge_du1,
+	&merge_do1,
+	NULL
+};
+static const char (*merge_sub_files[])[] = {
+	&merge_dl1_fl2,
+	&merge_du1_fu2,
+	&merge_do1_fo2,
+	&merge_do1_fl3,
+	&merge_do1_fu3,
+	NULL
+};
+
+/*
+ * layout2_overlay hierarchy:
+ *
+ * tmp
+ * ├── lower
+ * │   └── data
+ * │       ├── dl1
+ * │       │   └── fl2
+ * │       ├── do1
+ * │       │   ├── fl3
+ * │       │   └── fo2
+ * │       ├── fl1
+ * │       └── fo1
+ * ├── merge
+ * │   └── data
+ * │       ├── dl1
+ * │       │   └── fl2
+ * │       ├── do1
+ * │       │   ├── fl3
+ * │       │   ├── fo2
+ * │       │   └── fu3
+ * │       ├── du1
+ * │       │   └── fu2
+ * │       ├── fl1
+ * │       ├── fo1
+ * │       └── fu1
+ * └── upper
+ *     ├── data
+ *     │   ├── do1
+ *     │   │   ├── fo2
+ *     │   │   └── fu3
+ *     │   ├── du1
+ *     │   │   └── fu2
+ *     │   ├── fo1
+ *     │   └── fu1
+ *     └── work
+ *         └── work
+ */
+
+FIXTURE(layout2_overlay) {
+};
+
+FIXTURE_SETUP(layout2_overlay)
+{
+	prepare_layout(_metadata);
+
+	create_directory(_metadata, LOWER_BASE);
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	/* Creates tmpfs mount points to get deterministic overlayfs. */
+	ASSERT_EQ(0, mount("tmp", LOWER_BASE, "tmpfs", 0, "size=4m,mode=700"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	create_file(_metadata, lower_fl1);
+	create_file(_metadata, lower_dl1_fl2);
+	create_file(_metadata, lower_fo1);
+	create_file(_metadata, lower_do1_fo2);
+	create_file(_metadata, lower_do1_fl3);
+
+	create_directory(_metadata, UPPER_BASE);
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount("tmp", UPPER_BASE, "tmpfs", 0, "size=4m,mode=700"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	create_file(_metadata, upper_fu1);
+	create_file(_metadata, upper_du1_fu2);
+	create_file(_metadata, upper_fo1);
+	create_file(_metadata, upper_do1_fo2);
+	create_file(_metadata, upper_do1_fu3);
+	ASSERT_EQ(0, mkdir(UPPER_WORK, 0700));
+
+	create_directory(_metadata, MERGE_DATA);
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	set_cap(_metadata, CAP_DAC_OVERRIDE);
+	ASSERT_EQ(0, mount("overlay", MERGE_DATA, "overlay", 0,
+				"lowerdir=" LOWER_DATA
+				",upperdir=" UPPER_DATA
+				",workdir=" UPPER_WORK));
+	clear_cap(_metadata, CAP_DAC_OVERRIDE);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+FIXTURE_TEARDOWN(layout2_overlay)
+{
+	EXPECT_EQ(0, remove_path(lower_do1_fl3));
+	EXPECT_EQ(0, remove_path(lower_dl1_fl2));
+	EXPECT_EQ(0, remove_path(lower_fl1));
+	EXPECT_EQ(0, remove_path(lower_do1_fo2));
+	EXPECT_EQ(0, remove_path(lower_fo1));
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, umount(LOWER_BASE));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, remove_path(LOWER_BASE));
+
+	EXPECT_EQ(0, remove_path(upper_do1_fu3));
+	EXPECT_EQ(0, remove_path(upper_du1_fu2));
+	EXPECT_EQ(0, remove_path(upper_fu1));
+	EXPECT_EQ(0, remove_path(upper_do1_fo2));
+	EXPECT_EQ(0, remove_path(upper_fo1));
+	EXPECT_EQ(0, remove_path(UPPER_WORK "/work"));
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, umount(UPPER_BASE));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, remove_path(UPPER_BASE));
+
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, umount(MERGE_DATA));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+	EXPECT_EQ(0, remove_path(MERGE_DATA));
+
+	cleanup_layout(_metadata);
+}
+
+TEST_F_FORK(layout2_overlay, no_restriction)
+{
+	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_dl1_fl2, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_fo1, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_do1, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_do1_fo2, O_RDONLY));
+	ASSERT_EQ(0, test_open(lower_do1_fl3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(upper_fu1, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_du1, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_du1_fu2, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_fo1, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_do1, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_do1_fo2, O_RDONLY));
+	ASSERT_EQ(0, test_open(upper_do1_fu3, O_RDONLY));
+
+	ASSERT_EQ(0, test_open(merge_fl1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_dl1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_dl1_fl2, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_fu1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_du1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_du1_fu2, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_fo1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_do1, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_do1_fo2, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_do1_fl3, O_RDONLY));
+	ASSERT_EQ(0, test_open(merge_do1_fu3, O_RDONLY));
+}
+
+#define for_each_path(path_list, path_entry, i)			\
+	for (i = 0, path_entry = *path_list[i]; path_list[i];	\
+			path_entry = *path_list[++i])
+
+TEST_F_FORK(layout2_overlay, same_content_different_file)
+{
+	/* Sets access right on parent directories of both layers. */
+	const struct rule layer1_base[] = {
+		{
+			.path = LOWER_BASE,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = UPPER_BASE,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = MERGE_BASE,
+			.access = ACCESS_RW,
+		},
+		{}
+	};
+	const struct rule layer2_data[] = {
+		{
+			.path = LOWER_DATA,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = UPPER_DATA,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = MERGE_DATA,
+			.access = ACCESS_RW,
+		},
+		{}
+	};
+	/* Sets access right on directories inside both layers. */
+	const struct rule layer3_subdirs[] = {
+		{
+			.path = lower_dl1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = lower_do1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = upper_du1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = upper_do1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = merge_dl1,
+			.access = ACCESS_RW,
+		},
+		{
+			.path = merge_du1,
+			.access = ACCESS_RW,
+		},
+		{
+			.path = merge_do1,
+			.access = ACCESS_RW,
+		},
+		{}
+	};
+	/* Tighten access rights to the files. */
+	const struct rule layer4_files[] = {
+		{
+			.path = lower_dl1_fl2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = lower_do1_fo2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = lower_do1_fl3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = upper_du1_fu2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = upper_do1_fo2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = upper_do1_fu3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = merge_dl1_fl2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = merge_du1_fu2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = merge_do1_fo2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = merge_do1_fl3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = merge_do1_fu3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	const struct rule layer5_merge_only[] = {
+		{
+			.path = MERGE_DATA,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{}
+	};
+	int ruleset_fd;
+	size_t i;
+	const char *path_entry;
+
+	/* Sets rules on base directories (i.e. outside overlay scope). */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks lower layer. */
+	for_each_path(lower_base_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	for_each_path(lower_base_directories, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(lower_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	/* Checks upper layer. */
+	for_each_path(upper_base_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	for_each_path(upper_base_directories, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(upper_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	/*
+	 * Checks that access rights are independent from the lower and upper
+	 * layers: write access to upper files viewed through the merge point
+	 * is still allowed, and write access to lower file viewed (and copied)
+	 * through the merge point is still allowed.
+	 */
+	for_each_path(merge_base_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+	for_each_path(merge_base_directories, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(merge_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+
+	/* Sets rules on data directories (i.e. inside overlay scope). */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer2_data);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks merge. */
+	for_each_path(merge_base_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+	for_each_path(merge_base_directories, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(merge_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+
+	/* Same checks with tighter rules. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer3_subdirs);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks changes for lower layer. */
+	for_each_path(lower_base_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+	}
+	/* Checks changes for upper layer. */
+	for_each_path(upper_base_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+	}
+	/* Checks all merge accesses. */
+	for_each_path(merge_base_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+	}
+	for_each_path(merge_base_directories, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(merge_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+
+	/* Sets rules directly on overlayed files. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer4_files);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks unchanged accesses on lower layer. */
+	for_each_path(lower_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	/* Checks unchanged accesses on upper layer. */
+	for_each_path(upper_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDONLY));
+		ASSERT_EQ(EACCES, test_open(path_entry, O_WRONLY));
+	}
+	/* Checks all merge accesses. */
+	for_each_path(merge_base_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+	}
+	for_each_path(merge_base_directories, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(merge_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+
+	/* Only allowes access to the merge hierarchy. */
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer5_merge_only);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks new accesses on lower layer. */
+	for_each_path(lower_sub_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+	}
+	/* Checks new accesses on upper layer. */
+	for_each_path(upper_sub_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY));
+	}
+	/* Checks all merge accesses. */
+	for_each_path(merge_base_files, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDWR));
+	}
+	for_each_path(merge_base_directories, path_entry, i) {
+		ASSERT_EQ(EACCES, test_open(path_entry, O_RDONLY | O_DIRECTORY));
+	}
+	for_each_path(merge_sub_files, path_entry, i) {
+		ASSERT_EQ(0, test_open(path_entry, O_RDWR));
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
new file mode 100644
index 000000000000..15fbef9cc849
--- /dev/null
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -0,0 +1,337 @@
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
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_MAKE_BLOCK,
+	};
+
+	ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+			sizeof(ruleset_attr), 0);
+	EXPECT_LE(0, ruleset_fd) {
+		TH_LOG("Failed to create a ruleset: %s", strerror(errno));
+	}
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	EXPECT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+}
+
+static int test_ptrace_read(const pid_t pid)
+{
+	static const char path_template[] = "/proc/%d/environ";
+	char procenv_path[sizeof(path_template) + 10];
+	int procenv_path_size, fd;
+
+	procenv_path_size = snprintf(procenv_path, sizeof(procenv_path),
+			path_template, pid);
+	if (procenv_path_size >= sizeof(procenv_path))
+		return E2BIG;
+
+	fd = open(procenv_path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return errno;
+	/*
+	 * Mixing error codes from close(2) and open(2) should not lead to any
+	 * (access type) confusion for this test.
+	 */
+	if (close(fd) != 0)
+		return errno;
+	return 0;
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
+/* Test PTRACE_TRACEME and PTRACE_ATTACH for parent and child. */
+TEST_F(hierarchy, trace)
+{
+	pid_t child, parent;
+	int status, err_proc_read;
+	int pipe_child[2], pipe_parent[2];
+	char buf_parent;
+	long ret;
+
+	/*
+	 * Removes all effective and permitted capabilities to not interfere
+	 * with cap_ptrace_access_check() in case of PTRACE_MODE_FSCREDS.
+	 */
+	drop_caps(_metadata);
+
+	parent = getpid();
+	ASSERT_EQ(0, pipe2(pipe_child, O_CLOEXEC));
+	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
+	if (variant->domain_both) {
+		create_domain(_metadata);
+		if (!_metadata->passed)
+			/* Aborts before forking. */
+			return;
+	}
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		char buf_child;
+
+		ASSERT_EQ(0, close(pipe_parent[1]));
+		ASSERT_EQ(0, close(pipe_child[0]));
+		if (variant->domain_child)
+			create_domain(_metadata);
+
+		/* Waits for the parent to be in a domain, if any. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+
+		/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the parent. */
+		err_proc_read = test_ptrace_read(parent);
+		ret = ptrace(PTRACE_ATTACH, parent, NULL, 0);
+		if (variant->domain_child) {
+			EXPECT_EQ(-1, ret);
+			EXPECT_EQ(EPERM, errno);
+			EXPECT_EQ(EACCES, err_proc_read);
+		} else {
+			EXPECT_EQ(0, ret);
+			EXPECT_EQ(0, err_proc_read);
+		}
+		if (ret == 0) {
+			ASSERT_EQ(parent, waitpid(parent, &status, 0));
+			ASSERT_EQ(1, WIFSTOPPED(status));
+			ASSERT_EQ(0, ptrace(PTRACE_DETACH, parent, NULL, 0));
+		}
+
+		/* Tests child PTRACE_TRACEME. */
+		ret = ptrace(PTRACE_TRACEME);
+		if (variant->domain_parent) {
+			EXPECT_EQ(-1, ret);
+			EXPECT_EQ(EPERM, errno);
+		} else {
+			EXPECT_EQ(0, ret);
+		}
+
+		/*
+		 * Signals that the PTRACE_ATTACH test is done and the
+		 * PTRACE_TRACEME test is ongoing.
+		 */
+		ASSERT_EQ(1, write(pipe_child[1], ".", 1));
+
+		if (!variant->domain_parent) {
+			ASSERT_EQ(0, raise(SIGSTOP));
+		}
+
+		/* Waits for the parent PTRACE_ATTACH test. */
+		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+
+	ASSERT_EQ(0, close(pipe_child[1]));
+	ASSERT_EQ(0, close(pipe_parent[0]));
+	if (variant->domain_parent)
+		create_domain(_metadata);
+
+	/* Signals that the parent is in a domain, if any. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+
+	/*
+	 * Waits for the child to test PTRACE_ATTACH on the parent and start
+	 * testing PTRACE_TRACEME.
+	 */
+	ASSERT_EQ(1, read(pipe_child[0], &buf_parent, 1));
+
+	/* Tests child PTRACE_TRACEME. */
+	if (!variant->domain_parent) {
+		ASSERT_EQ(child, waitpid(child, &status, 0));
+		ASSERT_EQ(1, WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	} else {
+		/* The child should not be traced by the parent. */
+		EXPECT_EQ(-1, ptrace(PTRACE_DETACH, child, NULL, 0));
+		EXPECT_EQ(ESRCH, errno);
+	}
+
+	/* Tests PTRACE_ATTACH and PTRACE_MODE_READ on the child. */
+	err_proc_read = test_ptrace_read(child);
+	ret = ptrace(PTRACE_ATTACH, child, NULL, 0);
+	if (variant->domain_parent) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(EPERM, errno);
+		EXPECT_EQ(EACCES, err_proc_read);
+	} else {
+		EXPECT_EQ(0, ret);
+		EXPECT_EQ(0, err_proc_read);
+	}
+	if (ret == 0) {
+		ASSERT_EQ(child, waitpid(child, &status, 0));
+		ASSERT_EQ(1, WIFSTOPPED(status));
+		ASSERT_EQ(0, ptrace(PTRACE_DETACH, child, NULL, 0));
+	}
+
+	/* Signals that the parent PTRACE_ATTACH test is done. */
+	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
+	ASSERT_EQ(child, waitpid(child, &status, 0));
+	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
+			WEXITSTATUS(status) != EXIT_SUCCESS)
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
2.30.2

