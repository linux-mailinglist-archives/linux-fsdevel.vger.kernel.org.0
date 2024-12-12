Return-Path: <linux-fsdevel+bounces-37213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701189EF98B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 18:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9DD28DF85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 17:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63B52236F0;
	Thu, 12 Dec 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ECcUjtaM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA2222D67
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025908; cv=none; b=Nl/MvE4kz0jaTFhK7BvyxibYqRl4tOa/z/AfUoA5agWv9Hntn0FCCkzHo88Q5rtv3UA3jPMULz4katvdD1lhUoq7gMSQ5eskPe2oIActLg/8Vr80RO5slHvmxeyEpL1dpsGdg5MTCgtoPChjA2nowVN89EAI49885U9gSZ+gOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025908; c=relaxed/simple;
	bh=lbhC+mvZIAoG7xhdjm5LENhni/9WOIsUYDECC6tGOl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNK/NIzTBAc63VHxydP1BIV6myLqtHnabpYt44TLEFXCMgf0oidXNlabwZ/mpnO0RRU7eILeDlBGWXv9C7jGB0QlgPLgmHJAXtUClYEaBt6jQ8I/wKQBawKsxcwbXd1AcWV4kb3wDANkCfsMyEYE+SgVrwCKwiUvD2UXVoJMjFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ECcUjtaM; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y8KYY3sFXz48T;
	Thu, 12 Dec 2024 18:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734025361;
	bh=NJA1wkTvDepTdZWu6suzGWYZ3X+EHKG+WCwGdfCn6d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECcUjtaMxEKGxj7zI3CzQylRpYdPH7EqOKQLW2oLWyzf/iztf2q2eW9ONaiTATeoo
	 yE1zt79kMWj/4PzrCGp2/2gA8ZMqyN+CaCbZfziOm1uYYMUBwyx1fOQOn0kDWpNmk5
	 SlwzlaZlGB8yi/TFesQUokDbjNdJxFQ2nVLmBfHY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Y8KYX3wZZzlr;
	Thu, 12 Dec 2024 18:42:40 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v23 3/8] selftests/exec: Add 32 tests for AT_EXECVE_CHECK and exec securebits
Date: Thu, 12 Dec 2024 18:42:18 +0100
Message-ID: <20241212174223.389435-4-mic@digikod.net>
In-Reply-To: <20241212174223.389435-1-mic@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Test that checks performed by execveat(..., AT_EXECVE_CHECK) are
consistent with noexec mount points and file execute permissions.

Test that SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE are
inherited by child processes and that they can be pinned with the
appropriate SECBIT_EXEC_RESTRICT_FILE_LOCKED and
SECBIT_EXEC_DENY_INTERACTIVE_LOCKED bits.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241212174223.389435-4-mic@digikod.net
---

Changes since v21:
* Fix test's variants formatting.

Changes since v20:
* Rename AT_CHECK to AT_EXECVE_CHECK.

Changes since v19:
* Rename securebits.
* Rename test file.

Changes since v18:
* Rewrite tests with the new design: execveat/AT_CHECK and securebits.
* Simplify the capability dropping and improve it with the NOROOT
  securebits.
* Replace most ASSERT with EXPECT.
* Fix NULL execve's argv to avoid kernel warning.
* Move tests to exec/
* Build a "false" static binary to test full execution path.

Changes since v14:
* Add Reviewed-by Kees Cook.

Changes since v13:
* Move -I to CFLAGS (suggested by Kees Cook).
* Update sysctl name.

Changes since v12:
* Fix Makefile's license.

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
 tools/testing/selftests/exec/.gitignore   |   2 +
 tools/testing/selftests/exec/Makefile     |   7 +
 tools/testing/selftests/exec/check-exec.c | 456 ++++++++++++++++++++++
 tools/testing/selftests/exec/config       |   2 +
 tools/testing/selftests/exec/false.c      |   5 +
 5 files changed, 472 insertions(+)
 create mode 100644 tools/testing/selftests/exec/check-exec.c
 create mode 100644 tools/testing/selftests/exec/config
 create mode 100644 tools/testing/selftests/exec/false.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index a0dc5d4bf733..a32c63bb4df1 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -9,6 +9,8 @@ execveat.ephemeral
 execveat.denatured
 non-regular
 null-argv
+/check-exec
+/false
 /load_address.*
 !load_address.c
 /recursion-depth
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index ba012bc5aab9..8713d1c862ae 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -1,6 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS = -Wall
 CFLAGS += -Wno-nonnull
+CFLAGS += $(KHDR_INCLUDES)
+
+LDLIBS += -lcap
 
 ALIGNS := 0x1000 0x200000 0x1000000
 ALIGN_PIES        := $(patsubst %,load_address.%,$(ALIGNS))
@@ -9,12 +12,14 @@ ALIGNMENT_TESTS   := $(ALIGN_PIES) $(ALIGN_STATIC_PIES)
 
 TEST_PROGS := binfmt_script.py
 TEST_GEN_PROGS := execveat non-regular $(ALIGNMENT_TESTS)
+TEST_GEN_PROGS_EXTENDED := false
 TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
 # Makefile is a run-time dependency, since it's accessed by the execveat test
 TEST_FILES := Makefile
 
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
+TEST_GEN_PROGS += check-exec
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
@@ -38,3 +43,5 @@ $(OUTPUT)/load_address.0x%: load_address.c
 $(OUTPUT)/load_address.static.0x%: load_address.c
 	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=$(lastword $(subst ., ,$@)) \
 		-fPIE -static-pie $< -o $@
+$(OUTPUT)/false: false.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -static $< -o $@
diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
new file mode 100644
index 000000000000..4d3f4525e1e1
--- /dev/null
+++ b/tools/testing/selftests/exec/check-exec.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test execveat(2) with AT_EXECVE_CHECK, and prctl(2) with
+ * SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE, and their locked
+ * counterparts.
+ *
+ * Copyright © 2018-2020 ANSSI
+ * Copyright © 2024 Microsoft Corporation
+ *
+ * Author: Mickaël Salaün <mic@digikod.net>
+ */
+
+#include <asm-generic/unistd.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/prctl.h>
+#include <linux/securebits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/capability.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/sysmacros.h>
+#include <unistd.h>
+
+/* Defines AT_EXECVE_CHECK without type conflicts. */
+#define _ASM_GENERIC_FCNTL_H
+#include <linux/fcntl.h>
+
+#include "../kselftest_harness.h"
+
+static void drop_privileges(struct __test_metadata *const _metadata)
+{
+	const unsigned int noroot = SECBIT_NOROOT | SECBIT_NOROOT_LOCKED;
+	cap_t cap_p;
+
+	if ((cap_get_secbits() & noroot) != noroot)
+		EXPECT_EQ(0, cap_set_secbits(noroot));
+
+	cap_p = cap_get_proc();
+	EXPECT_NE(NULL, cap_p);
+	EXPECT_NE(-1, cap_clear(cap_p));
+
+	/*
+	 * Drops everything, especially CAP_SETPCAP, CAP_DAC_OVERRIDE, and
+	 * CAP_DAC_READ_SEARCH.
+	 */
+	EXPECT_NE(-1, cap_set_proc(cap_p));
+	EXPECT_NE(-1, cap_free(cap_p));
+}
+
+static int test_secbits_set(const unsigned int secbits)
+{
+	int err;
+
+	err = prctl(PR_SET_SECUREBITS, secbits);
+	if (err)
+		return errno;
+	return 0;
+}
+
+FIXTURE(access)
+{
+	int memfd, pipefd;
+	int pipe_fds[2], socket_fds[2];
+};
+
+FIXTURE_VARIANT(access)
+{
+	const bool mount_exec;
+	const bool file_exec;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(access, mount_exec_file_exec) {
+	/* clang-format on */
+	.mount_exec = true,
+	.file_exec = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(access, mount_exec_file_noexec) {
+	/* clang-format on */
+	.mount_exec = true,
+	.file_exec = false,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_exec) {
+	/* clang-format on */
+	.mount_exec = false,
+	.file_exec = true,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(access, mount_noexec_file_noexec) {
+	/* clang-format on */
+	.mount_exec = false,
+	.file_exec = false,
+};
+
+static const char binary_path[] = "./false";
+static const char workdir_path[] = "./test-mount";
+static const char reg_file_path[] = "./test-mount/regular_file";
+static const char dir_path[] = "./test-mount/directory";
+static const char block_dev_path[] = "./test-mount/block_device";
+static const char char_dev_path[] = "./test-mount/character_device";
+static const char fifo_path[] = "./test-mount/fifo";
+
+FIXTURE_SETUP(access)
+{
+	int procfd_path_size;
+	static const char path_template[] = "/proc/self/fd/%d";
+	char procfd_path[sizeof(path_template) + 10];
+
+	/* Makes sure we are not already restricted nor locked. */
+	EXPECT_EQ(0, test_secbits_set(0));
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
+	ASSERT_EQ(0, mount("test", workdir_path, "tmpfs",
+			   MS_MGC_VAL | (variant->mount_exec ? 0 : MS_NOEXEC),
+			   "mode=0700,size=9m"));
+
+	/* Creates a regular file. */
+	ASSERT_EQ(0, mknod(reg_file_path,
+			   S_IFREG | (variant->file_exec ? 0700 : 0600), 0));
+	/* Creates a directory. */
+	ASSERT_EQ(0, mkdir(dir_path, variant->file_exec ? 0700 : 0600));
+	/* Creates a character device: /dev/null. */
+	ASSERT_EQ(0, mknod(char_dev_path, S_IFCHR | 0400, makedev(1, 3)));
+	/* Creates a block device: /dev/loop0 */
+	ASSERT_EQ(0, mknod(block_dev_path, S_IFBLK | 0400, makedev(7, 0)));
+	/* Creates a fifo. */
+	ASSERT_EQ(0, mknod(fifo_path, S_IFIFO | 0600, 0));
+
+	/* Creates a regular file without user mount point. */
+	self->memfd = memfd_create("test-exec-probe", MFD_CLOEXEC);
+	ASSERT_LE(0, self->memfd);
+	/* Sets mode, which must be ignored by the exec check. */
+	ASSERT_EQ(0, fchmod(self->memfd, variant->file_exec ? 0700 : 0600));
+
+	/* Creates a pipefs file descriptor. */
+	ASSERT_EQ(0, pipe(self->pipe_fds));
+	procfd_path_size = snprintf(procfd_path, sizeof(procfd_path),
+				    path_template, self->pipe_fds[0]);
+	ASSERT_LT(procfd_path_size, sizeof(procfd_path));
+	self->pipefd = open(procfd_path, O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, self->pipefd);
+	ASSERT_EQ(0, fchmod(self->pipefd, variant->file_exec ? 0700 : 0600));
+
+	/* Creates a socket file descriptor. */
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_DGRAM | SOCK_CLOEXEC, 0,
+				self->socket_fds));
+}
+
+FIXTURE_TEARDOWN_PARENT(access)
+{
+	/* There is no need to unlink the test files. */
+	EXPECT_EQ(0, umount(workdir_path));
+	EXPECT_EQ(0, rmdir(workdir_path));
+}
+
+static void fill_exec_fd(struct __test_metadata *_metadata, const int fd_out)
+{
+	char buf[1024];
+	size_t len;
+	int fd_in;
+
+	fd_in = open(binary_path, O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd_in);
+	/* Cannot use copy_file_range(2) because of EXDEV. */
+	len = read(fd_in, buf, sizeof(buf));
+	EXPECT_LE(0, len);
+	while (len > 0) {
+		EXPECT_EQ(len, write(fd_out, buf, len))
+		{
+			TH_LOG("Failed to write: %s (%d)", strerror(errno),
+			       errno);
+		}
+		len = read(fd_in, buf, sizeof(buf));
+		EXPECT_LE(0, len);
+	}
+	EXPECT_EQ(0, close(fd_in));
+}
+
+static void fill_exec_path(struct __test_metadata *_metadata,
+			   const char *const path)
+{
+	int fd_out;
+
+	fd_out = open(path, O_CLOEXEC | O_WRONLY);
+	ASSERT_LE(0, fd_out)
+	{
+		TH_LOG("Failed to open %s: %s", path, strerror(errno));
+	}
+	fill_exec_fd(_metadata, fd_out);
+	EXPECT_EQ(0, close(fd_out));
+}
+
+static void test_exec_fd(struct __test_metadata *_metadata, const int fd,
+			 const int err_code)
+{
+	char *const argv[] = { "", NULL };
+	int access_ret, access_errno;
+
+	/*
+	 * If we really execute fd, filled with the "false" binary, the current
+	 * thread will exits with an error, which will be interpreted by the
+	 * test framework as an error.  With AT_EXECVE_CHECK, we only check a
+	 * potential successful execution.
+	 */
+	access_ret =
+		execveat(fd, "", argv, NULL, AT_EMPTY_PATH | AT_EXECVE_CHECK);
+	access_errno = errno;
+	if (err_code) {
+		EXPECT_EQ(-1, access_ret);
+		EXPECT_EQ(err_code, access_errno)
+		{
+			TH_LOG("Wrong error for execveat(2): %s (%d)",
+			       strerror(access_errno), errno);
+		}
+	} else {
+		EXPECT_EQ(0, access_ret)
+		{
+			TH_LOG("Access denied: %s", strerror(access_errno));
+		}
+	}
+}
+
+static void test_exec_path(struct __test_metadata *_metadata,
+			   const char *const path, const int err_code)
+{
+	int flags = O_CLOEXEC;
+	int fd;
+
+	/* Do not block on pipes. */
+	if (path == fifo_path)
+		flags |= O_NONBLOCK;
+
+	fd = open(path, flags | O_RDONLY);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open %s: %s", path, strerror(errno));
+	}
+	test_exec_fd(_metadata, fd, err_code);
+	EXPECT_EQ(0, close(fd));
+}
+
+/* Tests that we don't get ENOEXEC. */
+TEST_F(access, regular_file_empty)
+{
+	const int exec = variant->mount_exec && variant->file_exec;
+
+	test_exec_path(_metadata, reg_file_path, exec ? 0 : EACCES);
+
+	drop_privileges(_metadata);
+	test_exec_path(_metadata, reg_file_path, exec ? 0 : EACCES);
+}
+
+TEST_F(access, regular_file_elf)
+{
+	const int exec = variant->mount_exec && variant->file_exec;
+
+	fill_exec_path(_metadata, reg_file_path);
+
+	test_exec_path(_metadata, reg_file_path, exec ? 0 : EACCES);
+
+	drop_privileges(_metadata);
+	test_exec_path(_metadata, reg_file_path, exec ? 0 : EACCES);
+}
+
+/* Tests that we don't get ENOEXEC. */
+TEST_F(access, memfd_empty)
+{
+	const int exec = variant->file_exec;
+
+	test_exec_fd(_metadata, self->memfd, exec ? 0 : EACCES);
+
+	drop_privileges(_metadata);
+	test_exec_fd(_metadata, self->memfd, exec ? 0 : EACCES);
+}
+
+TEST_F(access, memfd_elf)
+{
+	const int exec = variant->file_exec;
+
+	fill_exec_fd(_metadata, self->memfd);
+
+	test_exec_fd(_metadata, self->memfd, exec ? 0 : EACCES);
+
+	drop_privileges(_metadata);
+	test_exec_fd(_metadata, self->memfd, exec ? 0 : EACCES);
+}
+
+TEST_F(access, non_regular_files)
+{
+	test_exec_path(_metadata, dir_path, EACCES);
+	test_exec_path(_metadata, block_dev_path, EACCES);
+	test_exec_path(_metadata, char_dev_path, EACCES);
+	test_exec_path(_metadata, fifo_path, EACCES);
+	test_exec_fd(_metadata, self->socket_fds[0], EACCES);
+	test_exec_fd(_metadata, self->pipefd, EACCES);
+}
+
+/* clang-format off */
+FIXTURE(secbits) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(secbits)
+{
+	const bool is_privileged;
+	const int error;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(secbits, priv) {
+	/* clang-format on */
+	.is_privileged = true,
+	.error = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(secbits, unpriv) {
+	/* clang-format on */
+	.is_privileged = false,
+	.error = EPERM,
+};
+
+FIXTURE_SETUP(secbits)
+{
+	/* Makes sure no exec bits are set. */
+	EXPECT_EQ(0, test_secbits_set(0));
+	EXPECT_EQ(0, prctl(PR_GET_SECUREBITS));
+
+	if (!variant->is_privileged)
+		drop_privileges(_metadata);
+}
+
+FIXTURE_TEARDOWN(secbits)
+{
+}
+
+TEST_F(secbits, legacy)
+{
+	EXPECT_EQ(variant->error, test_secbits_set(0));
+}
+
+#define CHILD(...)                     \
+	do {                           \
+		pid_t child = vfork(); \
+		EXPECT_LE(0, child);   \
+		if (child == 0) {      \
+			__VA_ARGS__;   \
+			_exit(0);      \
+		}                      \
+	} while (0)
+
+TEST_F(secbits, exec)
+{
+	unsigned int secbits = prctl(PR_GET_SECUREBITS);
+
+	secbits |= SECBIT_EXEC_RESTRICT_FILE;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+	EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS));
+	CHILD(EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS)));
+
+	secbits |= SECBIT_EXEC_DENY_INTERACTIVE;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+	EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS));
+	CHILD(EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS)));
+
+	secbits &= ~(SECBIT_EXEC_RESTRICT_FILE | SECBIT_EXEC_DENY_INTERACTIVE);
+	EXPECT_EQ(0, test_secbits_set(secbits));
+	EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS));
+	CHILD(EXPECT_EQ(secbits, prctl(PR_GET_SECUREBITS)));
+}
+
+TEST_F(secbits, check_locked_set)
+{
+	unsigned int secbits = prctl(PR_GET_SECUREBITS);
+
+	secbits |= SECBIT_EXEC_RESTRICT_FILE;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+	secbits |= SECBIT_EXEC_RESTRICT_FILE_LOCKED;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+
+	/* Checks lock set but unchanged. */
+	EXPECT_EQ(variant->error, test_secbits_set(secbits));
+	CHILD(EXPECT_EQ(variant->error, test_secbits_set(secbits)));
+
+	secbits &= ~SECBIT_EXEC_RESTRICT_FILE;
+	EXPECT_EQ(EPERM, test_secbits_set(0));
+	CHILD(EXPECT_EQ(EPERM, test_secbits_set(0)));
+}
+
+TEST_F(secbits, check_locked_unset)
+{
+	unsigned int secbits = prctl(PR_GET_SECUREBITS);
+
+	secbits |= SECBIT_EXEC_RESTRICT_FILE_LOCKED;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+
+	/* Checks lock unset but unchanged. */
+	EXPECT_EQ(variant->error, test_secbits_set(secbits));
+	CHILD(EXPECT_EQ(variant->error, test_secbits_set(secbits)));
+
+	secbits &= ~SECBIT_EXEC_RESTRICT_FILE;
+	EXPECT_EQ(EPERM, test_secbits_set(0));
+	CHILD(EXPECT_EQ(EPERM, test_secbits_set(0)));
+}
+
+TEST_F(secbits, restrict_locked_set)
+{
+	unsigned int secbits = prctl(PR_GET_SECUREBITS);
+
+	secbits |= SECBIT_EXEC_DENY_INTERACTIVE;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+	secbits |= SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+
+	/* Checks lock set but unchanged. */
+	EXPECT_EQ(variant->error, test_secbits_set(secbits));
+	CHILD(EXPECT_EQ(variant->error, test_secbits_set(secbits)));
+
+	secbits &= ~SECBIT_EXEC_DENY_INTERACTIVE;
+	EXPECT_EQ(EPERM, test_secbits_set(0));
+	CHILD(EXPECT_EQ(EPERM, test_secbits_set(0)));
+}
+
+TEST_F(secbits, restrict_locked_unset)
+{
+	unsigned int secbits = prctl(PR_GET_SECUREBITS);
+
+	secbits |= SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;
+	EXPECT_EQ(0, test_secbits_set(secbits));
+
+	/* Checks lock unset but unchanged. */
+	EXPECT_EQ(variant->error, test_secbits_set(secbits));
+	CHILD(EXPECT_EQ(variant->error, test_secbits_set(secbits)));
+
+	secbits &= ~SECBIT_EXEC_DENY_INTERACTIVE;
+	EXPECT_EQ(EPERM, test_secbits_set(0));
+	CHILD(EXPECT_EQ(EPERM, test_secbits_set(0)));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/exec/config b/tools/testing/selftests/exec/config
new file mode 100644
index 000000000000..c308079867b3
--- /dev/null
+++ b/tools/testing/selftests/exec/config
@@ -0,0 +1,2 @@
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_LOOP=y
diff --git a/tools/testing/selftests/exec/false.c b/tools/testing/selftests/exec/false.c
new file mode 100644
index 000000000000..104383ec3a79
--- /dev/null
+++ b/tools/testing/selftests/exec/false.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+int main(void)
+{
+	return 1;
+}
-- 
2.47.1


