Return-Path: <linux-fsdevel+bounces-77934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC1sFStUnGktDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBAB176B21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB7C13031371
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BF19E968;
	Mon, 23 Feb 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An+WTrsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0918D658;
	Mon, 23 Feb 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852821; cv=none; b=si+GKZlx8wsuO20aqCV4ibZ/cWOySmz+6xA2LJeUTPEnWH0yVzF/I3HGqTnbL2Qk51nAfRU7Z+nhiaSHi44uYnFXVc0TKbQy8ATK9IG6wfv9KDfN2FYXDUbvmODVE9eFGMebXUZsQgPeYM1nTlMn6Nhy30bTTGpv9VZwcW8zr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852821; c=relaxed/simple;
	bh=ZxJIMdlct5l9zBlEujtxSo3Sysm2g8soeik3PzMFxM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upvXIw5RUFu7Fn0w+YiUl+5GzTH8voKEfQOWa/oWoR58VvjmHNX+4b3fisiHWluIqT+D48CdLCCHBpeKP5RMExl9+SgNXfBZXSfcrC7Jm86M5wetXC7v3Sg+uBFAqSPSTQQHeE5hE9vPJedKD83ryQwAhoiC3CIBCZynCpjLMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An+WTrsq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF70C19424;
	Mon, 23 Feb 2026 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771852820;
	bh=ZxJIMdlct5l9zBlEujtxSo3Sysm2g8soeik3PzMFxM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=An+WTrsqWyb+tpcRCwRd8YbfPY3xvbwa96UmrAJkhmLyt4KoA7G/32AsMDEodrn9c
	 V1NSjQE9LI3roWPRnzu939M18D0daXjsQMDv2OoUUanPz+TZmCNFzwWC+UZ6j5P5NB
	 71W1xvexBiV5TyxIfPggrJZ51sl/Ql4iNcG4DSmGhlawlSCH+XmvaxHdnEr446HiUN
	 t2G022llZh3KLnctdYeJD3T71CgaW2RrSyCCG52zri5UAfjT6EJhj/Mb6fJR9rXdLv
	 LDToT1OQqcuUlOSQ3tUDRDMT36zml74ZvaeIUm/eVpx/lqVkptwCxwW3s9rUp46vfI
	 j3ySGEuWu4ZVg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Feb 2026 14:20:09 +0100
Subject: [PATCH RFC v3 2/2] selftests/pidfd: add inode ownership and
 permission tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-work-pidfs-inode-owner-v3-2-490855c59999@kernel.org>
References: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
In-Reply-To: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZxJIMdlct5l9zBlEujtxSo3Sysm2g8soeik3PzMFxM0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOCeErviKnxqMjcKk6yFqG4/mhXNn2muPz7r24c4PP7
 3yiXI52RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWpjEy7BXheuL3LnbV7QNd
 1tK1XkldpXmlrnnRl25Y1xkdcvnyiJFhtlvVzyMLilfWqmxafFwnW3KvX8Xhlo1Mtcv12x/c3+L
 JDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77934-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBBAB176B21
X-Rspamd-Action: no action

Test the pidfs inode ownership reporting (via fstat) and the permission
model (via user.* xattr operations that trigger pidfs_permission()):

Ownership tests:
- owner_self: own pidfd reports caller's euid/egid
- owner_child: child pidfd reports correct ownership
- owner_child_changed_euid: ownership tracks live credential changes
- owner_exited_child: ownership persists after exit and reap
- owner_exited_child_changed_euid: exit_cred preserves changed credentials

Permission tests:
- permission_same_user: same-user xattr access succeeds (EOPNOTSUPP)
- permission_different_user_denied: cross-user access denied (EPERM)
- permission_kthread: kernel thread access always denied (EPERM)

The user.* xattr namespace is used to exercise pidfs_permission() from
userspace: xattr_permission() calls inode_permission() for user.* on
S_IFREG inodes, so fgetxattr() returns EOPNOTSUPP when permission is
granted (no handler) and EPERM when denied.

Tests requiring root skip gracefully via SKIP().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../selftests/pidfd/pidfd_inode_owner_test.c       | 289 +++++++++++++++++++++
 3 files changed, 291 insertions(+), 1 deletion(-)

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
index 000000000000..58666b87638b
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_inode_owner_test.c
@@ -0,0 +1,289 @@
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
+	EXPECT_EQ(st.st_uid, geteuid());
+	EXPECT_EQ(st.st_gid, getegid());
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
+	EXPECT_EQ(st.st_uid, geteuid());
+	EXPECT_EQ(st.st_gid, getegid());
+}
+
+/* Ownership tracks credential changes in a live task. */
+TEST_F(pidfs_inode_owner, owner_child_changed_euid)
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
+	EXPECT_EQ(st.st_uid, geteuid());
+	EXPECT_EQ(st.st_gid, getegid());
+
+	close(pidfd);
+}
+
+/* Exit credentials preserve changed credentials. */
+TEST_F(pidfs_inode_owner, owner_exited_child_changed_euid)
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
+		 * Same user passes may_signal_creds() and
+		 * generic_permission(), so we get EOPNOTSUPP
+		 * (no user.* xattr handler) instead of EPERM.
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
+/* Cross-user access is denied without signal permission. */
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
+		char buf;
+
+		/* Drop to uid/gid 65534 and lose all capabilities. */
+		if (setresgid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+		if (setresuid(65534, 65534, 65534))
+			_exit(PIDFD_ERROR);
+
+		/* Open pidfd for init (uid 0). */
+		fd = sys_pidfd_open(1, 0);
+		if (fd < 0)
+			_exit(PIDFD_ERROR);
+
+		/*
+		 * uid 65534 cannot signal uid 0 (no CAP_KILL),
+		 * so pidfs_permission() denies access.
+		 */
+		if (fgetxattr(fd, "user.test", &buf, sizeof(buf)) < 0 &&
+		    errno == EPERM) {
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
+/* Kernel thread access is always denied. */
+TEST_F(pidfs_inode_owner, permission_kthread)
+{
+	int pidfd;
+	struct stat st;
+	char buf;
+
+	/* pid 2 is kthreadd. */
+	pidfd = sys_pidfd_open(2, 0);
+	ASSERT_GE(pidfd, 0);
+
+	/* pidfs_permission() returns EPERM for kernel threads. */
+	ASSERT_LT(fgetxattr(pidfd, "user.test", &buf, sizeof(buf)), 0);
+	EXPECT_EQ(errno, EPERM);
+
+	/* fstat bypasses permission and reports root ownership. */
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


