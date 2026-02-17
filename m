Return-Path: <linux-fsdevel+bounces-77428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI6tFgvulGnUIwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:39:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B725C1518DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C883072D98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4CE314D2D;
	Tue, 17 Feb 2026 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx8V/DRn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506973115B0;
	Tue, 17 Feb 2026 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367801; cv=none; b=Nz7OPFfgrrO6x8D2SDpumH1Qs/4Ga2mQQerDJihbDHrmPIVhc0gB7JniAQP8HXbC2qq4KZYY4dD8/DHzRos8DJHWq/D081oMEe2J/DIi7+Zqzo204Cm/pHfLcy5Bh70+UR6c/qbjNF6d+WyfPbVL7nlX4bf3UhL25u8tBmDLQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367801; c=relaxed/simple;
	bh=s0blIPC3flognjkRr3c4Cqmf4RCIecIC8Ux7vpdHkxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrEW0Ksi5/13vZsqfPfoTs+Ox7fDqRwSJUsOEUH6Jg92rv5LbQlOTH7GMv8UFbkQvVtg7udKY/cgOPK8Xhv50/rGDdcXYu+gKEfHvp5EMOgCwCt0nXHi8uOANEIT6l9RIqkjWU88MUpz2gbzl6o//WYC1ZoXHQ8UbioNDlut++M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx8V/DRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4265FC4CEF7;
	Tue, 17 Feb 2026 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367800;
	bh=s0blIPC3flognjkRr3c4Cqmf4RCIecIC8Ux7vpdHkxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qx8V/DRn1WkYWv1ZbRCoNdfrqTSJ7i5D6POKmNbY3gRKLhAEFJ/Q2ZxiQS7+bR+3X
	 1F/B19NI2TQQhayklCohBfra8rPbgKh8OPRFYPCdKlAQ27cmJKhluOXFxiy/L67Zps
	 j36cMY4R0gAOkLTNEE0c9lN4eo/Go1gtPnGTlY0DRZ1K49J46dsOQARGI9Gr09TsX9
	 A6kjzn+zTjGSvi9ioXOn3Y7hWiuwtwoMcrqpOBVFbTrB3zwnT1aaIgheSh3yGttgdT
	 OzPyr3QhQ3SDyMbKmV71cRWcSVH7tmFG6BCx0yQ8Rr+9k09fAfU1BE+l/Dde/r+2nO
	 +5I1G/40y6Jdg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 17 Feb 2026 23:35:53 +0100
Subject: [PATCH RFC v3 4/4] selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260217-work-pidfs-autoreap-v3-4-33a403c20111@kernel.org>
References: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
In-Reply-To: <20260217-work-pidfs-autoreap-v3-0-33a403c20111@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5781; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s0blIPC3flognjkRr3c4Cqmf4RCIecIC8Ux7vpdHkxc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROeZt3bXL23/QFqq+E93jM+io51+zS4i037tYd3tpjO
 jPUwLoisaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAih20Z/tfqf7eNmXtXIWTy
 gm8c3X8+c/3Tval+YPKvbcciTmRU2Csw/OEz2cx2w//QoVd7N77rf71HRsiIt6BA78qj6mn3U34
 6s3EDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77428-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pfd.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B725C1518DD
X-Rspamd-Action: no action

Add tests for the new CLONE_PIDFD_AUTOKILL clone3() flag:

- autokill_basic: child blocks in pause(), parent closes clone3 pidfd,
  child is killed and autoreaped
- autokill_requires_pidfd: CLONE_PIDFD_AUTOKILL without CLONE_PIDFD
  fails with EINVAL
- autokill_requires_autoreap: CLONE_PIDFD_AUTOKILL without
  CLONE_AUTOREAP fails with EINVAL
- autokill_rejects_thread: CLONE_PIDFD_AUTOKILL with CLONE_THREAD fails
  with EINVAL
- autokill_pidfd_open_no_effect: closing a pidfd_open() fd does not kill
  the child, closing the clone3 pidfd does

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 187 +++++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
index 3c0c45359473..a1dc4f075fc3 100644
--- a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
@@ -28,6 +28,10 @@
 #define CLONE_AUTOREAP 0x400000000ULL
 #endif
 
+#ifndef CLONE_PIDFD_AUTOKILL
+#define CLONE_PIDFD_AUTOKILL 0x800000000ULL
+#endif
+
 static pid_t create_autoreap_child(int *pidfd)
 {
 	struct __clone_args args = {
@@ -486,4 +490,187 @@ TEST(autoreap_no_inherit)
 	close(pidfd);
 }
 
+/*
+ * Helper: create a child with CLONE_PIDFD | CLONE_PIDFD_AUTOKILL | CLONE_AUTOREAP.
+ */
+static pid_t create_autokill_child(int *pidfd)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP,
+		.exit_signal	= 0,
+		.pidfd		= ptr_to_u64(pidfd),
+	};
+
+	return sys_clone3(&args, sizeof(args));
+}
+
+/*
+ * Basic autokill test: child blocks in pause(), parent closes the
+ * clone3 pidfd, child should be killed and autoreaped.
+ */
+TEST(autokill_basic)
+{
+	int pidfd = -1, pollfd_fd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	pid = create_autokill_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_PIDFD_AUTOKILL not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pause();
+		_exit(1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	/*
+	 * Open a second pidfd via pidfd_open() so we can observe the
+	 * child's death after closing the clone3 pidfd.
+	 */
+	pollfd_fd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pollfd_fd, 0);
+
+	/* Close the clone3 pidfd — this should trigger autokill. */
+	close(pidfd);
+
+	/* Wait for the child to die via the pidfd_open'd fd. */
+	pfd.fd = pollfd_fd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/* Child should be autoreaped — no zombie. */
+	usleep(100000);
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(pollfd_fd);
+}
+
+/*
+ * CLONE_PIDFD_AUTOKILL without CLONE_PIDFD must fail with EINVAL.
+ */
+TEST(autokill_requires_pidfd)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD_AUTOKILL | CLONE_AUTOREAP,
+		.exit_signal	= 0,
+	};
+	pid_t pid;
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * CLONE_PIDFD_AUTOKILL without CLONE_AUTOREAP must fail with EINVAL.
+ */
+TEST(autokill_requires_autoreap)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL,
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
+ * CLONE_PIDFD_AUTOKILL with CLONE_THREAD must fail with EINVAL.
+ */
+TEST(autokill_rejects_thread)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP | CLONE_THREAD |
+				  CLONE_SIGHAND | CLONE_VM,
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
+ * Test that only the clone3 pidfd triggers autokill, not pidfd_open().
+ * Close the pidfd_open'd fd first — child should survive.
+ * Then close the clone3 pidfd — child should be killed and autoreaped.
+ */
+TEST(autokill_pidfd_open_no_effect)
+{
+	int pidfd = -1, open_fd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	pid = create_autokill_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_PIDFD_AUTOKILL not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		pause();
+		_exit(1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Open a second pidfd via pidfd_open(). */
+	open_fd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(open_fd, 0);
+
+	/*
+	 * Close the pidfd_open'd fd — child should survive because
+	 * only the clone3 pidfd has autokill.
+	 */
+	close(open_fd);
+	usleep(200000);
+
+	/* Verify child is still alive by polling the clone3 pidfd. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("Child died after closing pidfd_open fd — should still be alive");
+	}
+
+	/* Open another observation fd before triggering autokill. */
+	open_fd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(open_fd, 0);
+
+	/* Now close the clone3 pidfd — this triggers autokill. */
+	close(pidfd);
+
+	pfd.fd = open_fd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+	ASSERT_TRUE(pfd.revents & POLLIN);
+
+	/* Child should be autoreaped — no zombie. */
+	usleep(100000);
+	ret = waitpid(pid, NULL, WNOHANG);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ECHILD);
+
+	close(open_fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


