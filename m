Return-Path: <linux-fsdevel+bounces-78414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH20NYuEn2mVcgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A78319EC77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7AC3092092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20033815E1;
	Wed, 25 Feb 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOeM1v2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FF3806D9;
	Wed, 25 Feb 2026 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061777; cv=none; b=eeYLdgX19nR0idyNiqsTuIH81geintpGuMHIT3Y5O8RsPiLhnjJVowu+vWYl9jSz1bELJE+E55+9L9RracVE12mxe4SvcxluZhEfVN1s7PqjN4VpfMywe2CQVSjHAlPV74xEIubq/Hmz5roQkOEJltqBqo6aKK7DLEd7KSWol5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061777; c=relaxed/simple;
	bh=ZhBOqZBMABjhlGhR8/nIBrwbHQEP/sWUGyrp2/NmTEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n++p76dLhL/EcRHUyNjOSa0JA0aJ4UaxftP4P5x2gJy75qGkNwj5vlpePRP1YrDDCbNmIMd4k3L0vih9wWYamVa9vIwyhna3w1MJH9sAWaqSSkM45VwWygpZ8aSq1waQFsn9sNhRFmzrwhxAMl9CQBGHnNwb/HwAL+N74kx10MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOeM1v2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B895C19425;
	Wed, 25 Feb 2026 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061776;
	bh=ZhBOqZBMABjhlGhR8/nIBrwbHQEP/sWUGyrp2/NmTEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eOeM1v2X3cZo+qMaL07yJkxEj6VN9cQh/5esTCmnqaeOBl5x1OtFKmwxllAxdMgfB
	 LgkZZ2+WUw1ymBFOj0YDbHJyDMYIfHX26XSAxqC3UcWLEPalB0uoZaLPtNZNCtNRm1
	 Y1EFi1JlZVXqLCWBpfnBejMWDvMFpKE6qMZMgQL4E5wauTB48ZEVw7H2WtrI9Vsv4T
	 +/FRNH2F26I1hhdf5OubSDKKFijo0xUrCA6wH6s6GLNMGyNZDoVqMOWU3PY+3Ak0Hd
	 I742+ViRQlbTwzbQl+j4lgBMn/5ZYKFoTbBvCxblfrHaR+iFfQzMBp8i1njN/pxe9f
	 sjhvmU+cIBCKA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 00:22:45 +0100
Subject: [PATCH RFC v4 2/2] selftests/pidfd: add inode ownership and
 permission tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-pidfs-inode-owner-v4-2-990032ec9700@kernel.org>
References: <20260226-work-pidfs-inode-owner-v4-0-990032ec9700@kernel.org>
In-Reply-To: <20260226-work-pidfs-inode-owner-v4-0-990032ec9700@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9663; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZhBOqZBMABjhlGhR8/nIBrwbHQEP/sWUGyrp2/NmTEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOb/H6/99gVcWm6POr68SKrNv3+bydb+a4cM77a3avt
 kx7drQjsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiLbwM/3NXnndf9JQr2P9g
 Dz/fjn0hF/meGV8Kv30rKd67Nzdg4kJGhi/NW45r1acVTC35GJMzS3L/vaTg48duruwUkPTbzDx
 nAysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-78414-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A78319EC77
X-Rspamd-Action: no action

Test the pidfs inode ownership reporting (via fstat) and the permission
model (via user.* xattr operations that trigger pidfs_permission()):

Ownership tests:
- owner_self: own pidfd reports caller's uid/gid
- owner_child: child pidfd reports correct ownership
- owner_child_changed_uid: ownership tracks live credential changes
- owner_exited_child: ownership persists after exit and reap
- owner_exited_child_changed_uid: exit_cred preserves changed credentials
- owner_kthread: kernel thread pidfd reports root ownership

Permission tests:
- permission_same_user: same-user xattr access succeeds (EOPNOTSUPP)
- permission_different_user_denied: cross-user access denied (EACCES)

The user.* xattr namespace is used to exercise pidfs_permission() from
userspace: xattr_permission() calls inode_permission() for user.* on
S_IFREG inodes, so fgetxattr() returns EOPNOTSUPP when permission is
granted (no handler) and EACCES when denied.

Tests requiring root skip gracefully via SKIP().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../selftests/pidfd/pidfd_inode_owner_test.c       | 314 +++++++++++++++++++++
 3 files changed, 316 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 144e7ff65d6a..1981d39fe3dc 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -12,3 +12,4 @@ pidfd_info_test
 pidfd_exec_helper
 pidfd_xattr_test
 pidfd_setattr_test
+pidfd_inode_owner_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 764a8f9ecefa..904c9fd595c1 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
-	pidfd_xattr_test pidfd_setattr_test
+	pidfd_xattr_test pidfd_setattr_test pidfd_inode_owner_test
 
 TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
 
diff --git a/tools/testing/selftests/pidfd/pidfd_inode_owner_test.c b/tools/testing/selftests/pidfd/pidfd_inode_owner_test.c
new file mode 100644
index 000000000000..0c15d0ccaafc
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_inode_owner_test.c
@@ -0,0 +1,314 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "kselftest_harness.h"
+
+FIXTURE(pidfs_inode_owner)
+{
+	pid_t child_pid;
+	int child_pidfd;
+};
+
+FIXTURE_SETUP(pidfs_inode_owner)
+{
+	int pipe_fds[2];
+	char buf;
+
+	self->child_pid = -1;
+	self->child_pidfd = -1;
+
+	ASSERT_EQ(pipe(pipe_fds), 0);
+
+	self->child_pid = create_child(&self->child_pidfd, 0);
+	ASSERT_GE(self->child_pid, 0);
+
+	if (self->child_pid == 0) {
+		close(pipe_fds[0]);
+		write_nointr(pipe_fds[1], "c", 1);
+		close(pipe_fds[1]);
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	close(pipe_fds[1]);
+	ASSERT_EQ(read_nointr(pipe_fds[0], &buf, 1), 1);
+	close(pipe_fds[0]);
+}
+
+FIXTURE_TEARDOWN(pidfs_inode_owner)
+{
+	if (self->child_pid > 0) {
+		kill(self->child_pid, SIGKILL);
+		sys_waitid(P_PID, self->child_pid, NULL, WEXITED);
+	}
+	if (self->child_pidfd >= 0)
+		close(self->child_pidfd);
+}
+
+/* Own pidfd reports correct ownership. */
+TEST_F(pidfs_inode_owner, owner_self)
+{
+	int pidfd;
+	struct stat st;
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, getuid());
+	EXPECT_EQ(st.st_gid, getgid());
+
+	close(pidfd);
+}
+
+/* Child pidfd reports correct ownership. */
+TEST_F(pidfs_inode_owner, owner_child)
+{
+	struct stat st;
+
+	ASSERT_EQ(fstat(self->child_pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, getuid());
+	EXPECT_EQ(st.st_gid, getgid());
+}
+
+/* Ownership tracks credential changes in a live task. */
+TEST_F(pidfs_inode_owner, owner_child_changed_uid)
+{
+	pid_t pid;
+	int pidfd, pipe_fds[2];
+	struct stat st;
+	char buf;
+
+	if (getuid() != 0)
+		SKIP(return, "Test requires root");
+
+	ASSERT_EQ(pipe(pipe_fds), 0);
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipe_fds[0]);
+		if (setresgid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		if (setresuid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		write_nointr(pipe_fds[1], "c", 1);
+		close(pipe_fds[1]);
+		pause();
+		_exit(EXIT_SUCCESS);
+	}
+
+	close(pipe_fds[1]);
+	ASSERT_EQ(read_nointr(pipe_fds[0], &buf, 1), 1);
+	close(pipe_fds[0]);
+
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, (uid_t)65534);
+	EXPECT_EQ(st.st_gid, (gid_t)65534);
+
+	kill(pid, SIGKILL);
+	sys_waitid(P_PID, pid, NULL, WEXITED);
+	close(pidfd);
+}
+
+/* Ownership persists after the child exits and is reaped. */
+TEST_F(pidfs_inode_owner, owner_exited_child)
+{
+	pid_t pid;
+	int pidfd;
+	struct stat st;
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		_exit(EXIT_SUCCESS);
+
+	ASSERT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, getuid());
+	EXPECT_EQ(st.st_gid, getgid());
+
+	close(pidfd);
+}
+
+/* Exit credentials preserve changed credentials. */
+TEST_F(pidfs_inode_owner, owner_exited_child_changed_uid)
+{
+	pid_t pid;
+	int pidfd;
+	struct stat st;
+
+	if (getuid() != 0)
+		SKIP(return, "Test requires root");
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		if (setresgid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		if (setresuid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		_exit(EXIT_SUCCESS);
+	}
+
+	ASSERT_EQ(sys_waitid(P_PID, pid, NULL, WEXITED), 0);
+
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, (uid_t)65534);
+	EXPECT_EQ(st.st_gid, (gid_t)65534);
+
+	close(pidfd);
+}
+
+/* Same-user cross-process permission check succeeds. */
+TEST_F(pidfs_inode_owner, permission_same_user)
+{
+	pid_t pid;
+	int pidfd;
+	pid_t parent_pid = getpid();
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		char buf;
+
+		fd = sys_pidfd_open(parent_pid, 0);
+		if (fd < 0)
+			_exit(PIDFD_ERROR);
+
+		/*
+		 * user.* xattr access triggers pidfs_permission().
+		 * Same user's FSUID matches target's RUID, so
+		 * generic_permission() passes and we get EOPNOTSUPP
+		 * (no user.* xattr handler) instead of EACCES.
+		 */
+		if (fgetxattr(fd, "user.test", &buf, sizeof(buf)) < 0 &&
+		    errno == EOPNOTSUPP) {
+			close(fd);
+			_exit(PIDFD_PASS);
+		}
+
+		close(fd);
+		_exit(PIDFD_FAIL);
+	}
+
+	ASSERT_EQ(wait_for_pid(pid), PIDFD_PASS);
+	close(pidfd);
+}
+
+/* Cross-user access is denied when FSUID doesn't match target's RUID. */
+TEST_F(pidfs_inode_owner, permission_different_user_denied)
+{
+	pid_t pid;
+	int pidfd;
+
+	if (getuid() != 0)
+		SKIP(return, "Test requires root");
+
+	pid = create_child(&pidfd, 0);
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		struct stat init_st;
+		char buf;
+
+		/* Open pidfd for init (uid 0). */
+		fd = sys_pidfd_open(1, 0);
+		if (fd < 0)
+			_exit(PIDFD_ERROR);
+
+		/* Verify init is actually uid 0 (may not be in all namespaces). */
+		if (fstat(fd, &init_st) || init_st.st_uid != 0) {
+			close(fd);
+			_exit(PIDFD_SKIP);
+		}
+
+		/* Drop to uid/gid 65534 and lose all capabilities. */
+		if (setresgid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		if (setresuid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+
+		/*
+		 * FSUID 65534 doesn't match target's RUID 0, and
+		 * no CAP_DAC_OVERRIDE, so generic_permission()
+		 * returns -EACCES.
+		 */
+		if (fgetxattr(fd, "user.test", &buf, sizeof(buf)) < 0 &&
+		    errno == EACCES) {
+			close(fd);
+			_exit(PIDFD_PASS);
+		}
+
+		close(fd);
+		_exit(PIDFD_FAIL);
+	}
+
+	{
+		int ret = wait_for_pid(pid);
+		if (ret == PIDFD_SKIP)
+			SKIP(goto out, "pid 1 is not uid 0 (not in init PID namespace?)");
+		ASSERT_EQ(ret, PIDFD_PASS);
+	}
+out:
+	close(pidfd);
+}
+
+/* Kernel thread pidfd reports root ownership. */
+TEST_F(pidfs_inode_owner, owner_kthread)
+{
+	int pidfd;
+	struct stat st;
+	char comm[16] = {};
+	FILE *f;
+
+	/*
+	 * pid 2 is kthreadd only in the init PID namespace.
+	 * Skip if we're in a different PID namespace.
+	 */
+	f = fopen("/proc/2/comm", "r");
+	if (!f)
+		SKIP(return, "Cannot read /proc/2/comm");
+	if (!fgets(comm, sizeof(comm), f)) {
+		fclose(f);
+		SKIP(return, "Cannot read /proc/2/comm");
+	}
+	fclose(f);
+	comm[strcspn(comm, "\n")] = '\0';
+	if (strcmp(comm, "kthreadd") != 0)
+		SKIP(return, "pid 2 is not kthreadd (not in init PID namespace?)");
+
+	pidfd = sys_pidfd_open(2, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st), 0);
+	EXPECT_EQ(st.st_uid, (uid_t)0);
+	EXPECT_EQ(st.st_gid, (gid_t)0);
+
+	close(pidfd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


