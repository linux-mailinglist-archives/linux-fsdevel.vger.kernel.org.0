Return-Path: <linux-fsdevel+bounces-77928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIvAMOIvnGkKAgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:45:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD917514F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971D4303CEFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109F35DD1C;
	Mon, 23 Feb 2026 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Memv8GZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9B3612D2;
	Mon, 23 Feb 2026 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843522; cv=none; b=HZt6upql09R+s7PPWv57XfqwS6X4FG6oJGMG7sy5BBxJUJV9WX7DazRXPvBHaSOC+GpEv3gnhGQ2Fx5SDc//q8sjsfhuPFkeOWR350i4/sJFTNSwchadSAcGyqhcoZMfQbf2wNRkPQDz7a8q5benC/5bnhm2V0b4E8wRysqGAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843522; c=relaxed/simple;
	bh=lQWnqJdd5KZDYPYMpsNBRE3B8p6+ExaMxdmOo4pbBnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXSpo82u1YXh2y0CWeL4dBeIt4eZVtC+kRKem2cBntPK+qXVSespPO/HVCxU9F+knf84Bv+scux5e7MtVbhA/rHWEO+VzWxhG3KCS1H3dtw/ngP+1vzxR1cVz69uW+sFRyQKGyl3o+ffdOFqvrvtmYyNI3atYOMDXrZqHSG5OHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Memv8GZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDEC19424;
	Mon, 23 Feb 2026 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771843522;
	bh=lQWnqJdd5KZDYPYMpsNBRE3B8p6+ExaMxdmOo4pbBnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Memv8GZb4zr6FIcBxpeWbbhN6cFLT26CsdQSy2Y7r/iEfl/8ufUMzxRH10kpc2hI/
	 SfShLdBad4YRiFF4TcbPCfTLA/VJ0MT61XXIjv7e5PGigipuw1kejtLb0iwCN604U6
	 QAZeTnozMvA9zPHvkkLKoi2Sy42t1ntOh7vGCBaefEo0pwGxafXzOsMmroymqY1zSP
	 RtoY44ziWMi7M9MIJ/MAbJb0OoHCtwW7iGFRfcYN1qVYNJSsO6BmnVHAhSmrcRmok1
	 IdiNg69z4ybRt9v4pTc3nWAtzpVgRIwGJtREqo9R+lD/tbab245dVCHEK6gHXNBxKL
	 TOp7sHAsLWXAA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Feb 2026 11:45:00 +0100
Subject: [PATCH v4 3/4] selftests/pidfd: add CLONE_AUTOREAP tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-work-pidfs-autoreap-v4-3-e393c08c09d1@kernel.org>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
In-Reply-To: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=14666; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lQWnqJdd5KZDYPYMpsNBRE3B8p6+ExaMxdmOo4pbBnU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO0d85td3iyvFPWUdFWzR3cN2ddetE5A3dzNYS4yunZ
 19Kss7f0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR++MMv1nLTeKui8r8OPr/
 rqTERe1kRfmFafv9vedlV4nFaKupXWZkaL8f+mTf0hd1VcVN65OP7Ihz2LhOW/6qu0siz7bC+bn
 PuQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77928-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pfd.events:url]
X-Rspamd-Queue-Id: 37DD917514F
X-Rspamd-Action: no action

Add tests for the new CLONE_AUTOREAP clone3() flag:

- autoreap_without_pidfd: CLONE_AUTOREAP without CLONE_PIDFD works
  (fire-and-forget)
- autoreap_rejects_exit_signal: CLONE_AUTOREAP with non-zero
  exit_signal fails
- autoreap_rejects_parent: CLONE_AUTOREAP with CLONE_PARENT fails
- autoreap_rejects_thread: CLONE_AUTOREAP with CLONE_THREAD fails
- autoreap_basic: child exits, pidfd poll works, PIDFD_GET_INFO returns
  correct exit code, waitpid() returns -ECHILD
- autoreap_signaled: child killed by signal, exit info correct via pidfd
- autoreap_reparent: autoreap grandchild reparented to subreaper still
  auto-reaps
- autoreap_multithreaded: autoreap process with sub-threads auto-reaps
  after last thread exits
- autoreap_no_inherit: grandchild forked without CLONE_AUTOREAP becomes
  a regular zombie

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/.gitignore           |   1 +
 tools/testing/selftests/pidfd/Makefile             |   2 +-
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 507 +++++++++++++++++++++
 3 files changed, 509 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
index 144e7ff65d6a..4cd8ec7fd349 100644
--- a/tools/testing/selftests/pidfd/.gitignore
+++ b/tools/testing/selftests/pidfd/.gitignore
@@ -12,3 +12,4 @@ pidfd_info_test
 pidfd_exec_helper
 pidfd_xattr_test
 pidfd_setattr_test
+pidfd_autoreap_test
diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 764a8f9ecefa..4211f91e9af8 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -4,7 +4,7 @@ CFLAGS += -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
 	pidfd_file_handle_test pidfd_bind_mount pidfd_info_test \
-	pidfd_xattr_test pidfd_setattr_test
+	pidfd_xattr_test pidfd_setattr_test pidfd_autoreap_test
 
 TEST_GEN_PROGS_EXTENDED := pidfd_exec_helper
 
diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
new file mode 100644
index 000000000000..9e52a16239ea
--- /dev/null
+++ b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/types.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "pidfd.h"
+#include "kselftest_harness.h"
+
+#ifndef CLONE_AUTOREAP
+#define CLONE_AUTOREAP 0x400000000ULL
+#endif
+
+static pid_t create_autoreap_child(int *pidfd)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_AUTOREAP,
+		.exit_signal	= 0,
+		.pidfd		= ptr_to_u64(pidfd),
+	};
+
+	return sys_clone3(&args, sizeof(args));
+}
+
+/*
+ * Test that CLONE_AUTOREAP works without CLONE_PIDFD (fire-and-forget).
+ */
+TEST(autoreap_without_pidfd)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_AUTOREAP,
+		.exit_signal	= 0,
+	};
+	pid_t pid;
+	int ret;
+
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		_exit(0);
+
+	/*
+	 * Give the child a moment to exit and be autoreaped.
+	 * Then verify no zombie remains.
+	 */
+	usleep(200000);
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+}
+
+/*
+ * Test that CLONE_AUTOREAP with a non-zero exit_signal fails.
+ */
+TEST(autoreap_rejects_exit_signal)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_AUTOREAP,
+		.exit_signal	= SIGCHLD,
+	};
+	int pidfd = -1;
+	pid_t pid;
+
+	args.pidfd = ptr_to_u64(&pidfd);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test that CLONE_AUTOREAP with CLONE_PARENT fails.
+ */
+TEST(autoreap_rejects_parent)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_AUTOREAP | CLONE_PARENT,
+		.exit_signal	= 0,
+	};
+	int pidfd = -1;
+	pid_t pid;
+
+	args.pidfd = ptr_to_u64(&pidfd);
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test that CLONE_AUTOREAP with CLONE_THREAD fails.
+ */
+TEST(autoreap_rejects_thread)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_AUTOREAP |
+				  CLONE_THREAD | CLONE_SIGHAND |
+				  CLONE_VM,
+		.exit_signal	= 0,
+	};
+	int pidfd = -1;
+	pid_t pid;
+
+	args.pidfd = ptr_to_u64(&pidfd);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Basic test: create an autoreap child, let it exit, verify:
+ * - pidfd becomes readable (poll returns POLLIN)
+ * - PIDFD_GET_INFO returns the correct exit code
+ * - waitpid() returns -1/ECHILD (no zombie)
+ */
+TEST(autoreap_basic)
+{
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	pid = create_autoreap_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		_exit(42);
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Wait for the child to exit via pidfd poll. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/* Verify exit info via PIDFD_GET_INFO. */
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	/*
+	 * exit_code is in waitpid format: for _exit(42),
+	 * WIFEXITED is true and WEXITSTATUS is 42.
+	 */
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 42);
+
+	/* Verify no zombie: waitpid should fail with ECHILD. */
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(pidfd);
+}
+
+/*
+ * Test that an autoreap child killed by a signal reports
+ * the correct exit info.
+ */
+TEST(autoreap_signaled)
+{
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	pid = create_autoreap_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pause();
+		_exit(1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Kill the child. */
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	ASSERT_EQ(ret, 0);
+
+	/* Wait for exit via pidfd. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/* Verify signal info. */
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFSIGNALED(info.exit_code));
+	ASSERT_EQ(WTERMSIG(info.exit_code), SIGKILL);
+
+	/* No zombie. */
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(pidfd);
+}
+
+/*
+ * Test autoreap survives reparenting: middle process creates an
+ * autoreap grandchild, then exits. The grandchild gets reparented
+ * to us (the grandparent, which is a subreaper). When the grandchild
+ * exits, it should still be autoreaped - no zombie under us.
+ */
+TEST(autoreap_reparent)
+{
+	int ipc_sockets[2], ret;
+	int pidfd = -1;
+	struct pollfd pfd;
+	pid_t mid_pid, grandchild_pid;
+	char buf[32] = {};
+
+	/* Make ourselves a subreaper so reparented children come to us. */
+	ret = prctl(PR_SET_CHILD_SUBREAPER, 1);
+	ASSERT_EQ(ret, 0);
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	mid_pid = fork();
+	ASSERT_GE(mid_pid, 0);
+
+	if (mid_pid == 0) {
+		/* Middle child: create an autoreap grandchild. */
+		int gc_pidfd = -1;
+
+		close(ipc_sockets[0]);
+
+		grandchild_pid = create_autoreap_child(&gc_pidfd);
+		if (grandchild_pid < 0) {
+			write_nointr(ipc_sockets[1], "E", 1);
+			close(ipc_sockets[1]);
+			_exit(1);
+		}
+
+		if (grandchild_pid == 0) {
+			/* Grandchild: wait for signal to exit. */
+			close(ipc_sockets[1]);
+			if (gc_pidfd >= 0)
+				close(gc_pidfd);
+			pause();
+			_exit(0);
+		}
+
+		/* Send grandchild PID to grandparent. */
+		snprintf(buf, sizeof(buf), "%d", grandchild_pid);
+		write_nointr(ipc_sockets[1], buf, strlen(buf));
+		close(ipc_sockets[1]);
+		if (gc_pidfd >= 0)
+			close(gc_pidfd);
+
+		/* Middle child exits, grandchild gets reparented. */
+		_exit(0);
+	}
+
+	close(ipc_sockets[1]);
+
+	/* Read grandchild's PID. */
+	ret = read_nointr(ipc_sockets[0], buf, sizeof(buf) - 1);
+	close(ipc_sockets[0]);
+	ASSERT_GT(ret, 0);
+
+	if (buf[0] == 'E') {
+		waitpid(mid_pid, NULL, 0);
+		prctl(PR_SET_CHILD_SUBREAPER, 0);
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	}
+
+	grandchild_pid = atoi(buf);
+	ASSERT_GT(grandchild_pid, 0);
+
+	/* Wait for the middle child to exit. */
+	ret = waitpid(mid_pid, NULL, 0);
+	ASSERT_EQ(ret, mid_pid);
+
+	/*
+	 * Now the grandchild is reparented to us (subreaper).
+	 * Open a pidfd for the grandchild and kill it.
+	 */
+	pidfd = sys_pidfd_open(grandchild_pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ret = sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
+	ASSERT_EQ(ret, 0);
+
+	/* Wait for it to exit via pidfd poll. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/*
+	 * The grandchild should have been autoreaped even though
+	 * we (the new parent) haven't set SA_NOCLDWAIT.
+	 * waitpid should return -1/ECHILD.
+	 */
+	ret = waitpid(grandchild_pid, NULL, WNOHANG);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, ECHILD);
+
+	close(pidfd);
+
+	/* Clean up subreaper status. */
+	prctl(PR_SET_CHILD_SUBREAPER, 0);
+}
+
+static int thread_sock_fd;
+
+static void *thread_func(void *arg)
+{
+	/* Signal parent we're running. */
+	write_nointr(thread_sock_fd, "1", 1);
+
+	/* Give main thread time to call _exit() first. */
+	usleep(200000);
+
+	return NULL;
+}
+
+/*
+ * Test that an autoreap child with multiple threads is properly
+ * autoreaped only after all threads have exited.
+ */
+TEST(autoreap_multithreaded)
+{
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int ipc_sockets[2], ret;
+	int pidfd = -1;
+	struct pollfd pfd;
+	pid_t pid;
+	char c;
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid = create_autoreap_child(&pidfd);
+	if (pid < 0 && errno == EINVAL) {
+		close(ipc_sockets[0]);
+		close(ipc_sockets[1]);
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	}
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pthread_t thread;
+
+		close(ipc_sockets[0]);
+
+		/*
+		 * Create a sub-thread that outlives the main thread.
+		 * The thread signals readiness, then sleeps.
+		 * The main thread waits briefly, then calls _exit().
+		 */
+		thread_sock_fd = ipc_sockets[1];
+		pthread_create(&thread, NULL, thread_func, NULL);
+		pthread_detach(thread);
+
+		/* Wait for thread to be running. */
+		usleep(100000);
+
+		/* Main thread exits; sub-thread is still alive. */
+		_exit(99);
+	}
+
+	close(ipc_sockets[1]);
+
+	/* Wait for the sub-thread to signal readiness. */
+	ret = read_nointr(ipc_sockets[0], &c, 1);
+	close(ipc_sockets[0]);
+	ASSERT_EQ(ret, 1);
+
+	/* Wait for the process to fully exit via pidfd poll. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/* Verify exit info. */
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 99);
+
+	/* No zombie. */
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(pidfd);
+}
+
+/*
+ * Test that autoreap is NOT inherited by grandchildren.
+ */
+TEST(autoreap_no_inherit)
+{
+	int ipc_sockets[2], ret;
+	int pidfd = -1;
+	pid_t pid;
+	char buf[2] = {};
+	struct pollfd pfd;
+
+	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid = create_autoreap_child(&pidfd);
+	if (pid < 0 && errno == EINVAL) {
+		close(ipc_sockets[0]);
+		close(ipc_sockets[1]);
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	}
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pid_t gc;
+		int status;
+
+		close(ipc_sockets[0]);
+
+		/* Autoreap child forks a grandchild (without autoreap). */
+		gc = fork();
+		if (gc < 0) {
+			write_nointr(ipc_sockets[1], "E", 1);
+			_exit(1);
+		}
+		if (gc == 0) {
+			/* Grandchild: exit immediately. */
+			close(ipc_sockets[1]);
+			_exit(77);
+		}
+
+		/*
+		 * The grandchild should become a regular zombie
+		 * since it was NOT created with CLONE_AUTOREAP.
+		 * Wait for it to verify.
+		 */
+		ret = waitpid(gc, &status, 0);
+		if (ret == gc && WIFEXITED(status) &&
+		    WEXITSTATUS(status) == 77) {
+			write_nointr(ipc_sockets[1], "P", 1);
+		} else {
+			write_nointr(ipc_sockets[1], "F", 1);
+		}
+		close(ipc_sockets[1]);
+		_exit(0);
+	}
+
+	close(ipc_sockets[1]);
+
+	ret = read_nointr(ipc_sockets[0], buf, 1);
+	close(ipc_sockets[0]);
+	ASSERT_EQ(ret, 1);
+
+	/*
+	 * 'P' means the autoreap child was able to waitpid() its
+	 * grandchild (correct - grandchild should be a normal zombie,
+	 * not autoreaped).
+	 */
+	ASSERT_EQ(buf[0], 'P');
+
+	/* Wait for the autoreap child to exit. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	/* Autoreap child itself should be autoreaped. */
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(pidfd);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.3


