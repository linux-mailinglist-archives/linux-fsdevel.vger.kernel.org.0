Return-Path: <linux-fsdevel+bounces-77929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDQ2LUEwnGkKAgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:47:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A18E175199
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 11:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D69F3071425
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6335356A24;
	Mon, 23 Feb 2026 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeesAPuz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFCC2BEC43;
	Mon, 23 Feb 2026 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843525; cv=none; b=i1y4NEL5PcdLqOu3GbaQLhEmUcWWGIFNQBFVmtatDYHI9WDufr3Q9Va4FikiwGEI/6t2ZcAcv37EYRaq53cuFZBPikf+F6ovF0QZlbIzcMbnDcUBiUhOV8vrMRU2aVzLp4w9FUBqwKV1744JYn8bpJ92pFgkh5neHgbfCB0jAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843525; c=relaxed/simple;
	bh=n+Jv75j3zPFGHzS562mA4zc6GC32QSF8L3sxOl/3Sv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3C8yKzydi5t9NtJ9nDJ0dMIAx8mWggehPq6AqekASTvJnPZqxykFLTIZkYR71rDsB+TIbNM8986ctdUMW+HMf4O/jF9ATLsmGWUBUU19G89MxY+jt1qA2dwqBq9KaqDRcfDtgGwrqfz2bkLzIQ8PgOeHoMNNdYP6fhiCWA84f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeesAPuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09622C116D0;
	Mon, 23 Feb 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771843524;
	bh=n+Jv75j3zPFGHzS562mA4zc6GC32QSF8L3sxOl/3Sv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DeesAPuzy4OY1MzeYzCxGoDKAoTxOo+xG+Dyr5v8OOk4rl5FJippoM2qs548grglU
	 1vaeS3ydAUwSrIjJrLbN7ZcAoj4PagbwpN1zNx/apHG44jrzFeifWrVSLG8fUeMSRB
	 IyFYpOdRIRtwVv6mSzxlqHSJZCQaGNLPnnzdoK/MV5hRqjeJU+22jTd8yAyb56xn+4
	 uV3WodMPLgqOPe0QX9KTH8vVRHlGuEVqcv6rM59r9ifRQOiQuyFKK1Lxu/5HwR+ZTm
	 84N4eSgnZaNhlTdKuPo/gcFh60OmkdYn1S7R+a9P8gCj3Y/LK3u9iIQMs2RLwItpRU
	 3E7OdLVD2/BSw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Feb 2026 11:45:01 +0100
Subject: [PATCH v4 4/4] selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260223-work-pidfs-autoreap-v4-4-e393c08c09d1@kernel.org>
References: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
In-Reply-To: <20260223-work-pidfs-autoreap-v4-0-e393c08c09d1@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=n+Jv75j3zPFGHzS562mA4zc6GC32QSF8L3sxOl/3Sv0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTO0d9p6Mcm9u9wx/beo+6nfj8Id/Gb036xTma17MKw7
 ynffskUdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEu4bhn4rCLZ7Xq4Ta84+L
 mZpxuu+U3MO05XqM6Lyrq/gTw3cqxTAyHK3fv1ryYlzefz6NB48SAo8WdDMnvspY9kC/Y3nXxbp
 QNgA=
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
	TAGGED_FROM(0.00)[bounces-77929-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pfd.events:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A18E175199
X-Rspamd-Action: no action

Add tests for the new CLONE_PIDFD_AUTOKILL clone3() flag:

- autokill_sets_no_new_privs: child created with CLONE_PIDFD_AUTOKILL
  has no_new_privs set, parent does not
- autoreap_no_new_privs_unset: plain CLONE_AUTOREAP child does not get
  no_new_privs (only CLONE_PIDFD_AUTOKILL sets it)
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
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 286 +++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
index 9e52a16239ea..9037542eef2a 100644
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
@@ -504,4 +508,286 @@ TEST(autoreap_no_inherit)
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
+ * Test that CLONE_PIDFD_AUTOKILL sets no_new_privs on the child.
+ * The child checks via prctl(PR_GET_NO_NEW_PRIVS) and reports back.
+ * The parent must NOT have no_new_privs set afterwards.
+ */
+TEST(autokill_sets_no_new_privs)
+{
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	/* Ensure parent does not already have no_new_privs. */
+	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("Parent already has no_new_privs set, cannot run test");
+	}
+
+	pid = create_autokill_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_PIDFD_AUTOKILL not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/*
+		 * Child: check no_new_privs. Exit 0 if set, 1 if not.
+		 */
+		ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+		_exit(ret == 1 ? 0 : 1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Parent must still NOT have no_new_privs. */
+	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("Parent got no_new_privs after creating autokill child");
+	}
+
+	/* Wait for child to exit. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	/* Verify child exited with 0 (no_new_privs was set). */
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0) {
+		TH_LOG("Child did not have no_new_privs set");
+	}
+
+	close(pidfd);
+}
+
+/*
+ * Test that a plain CLONE_AUTOREAP child does NOT get no_new_privs.
+ * Only CLONE_PIDFD_AUTOKILL should set it.
+ */
+TEST(autoreap_no_new_privs_unset)
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
+		/*
+		 * Child: check no_new_privs. Exit 0 if NOT set, 1 if set.
+		 */
+		ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+		_exit(ret == 0 ? 0 : 1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0) {
+		TH_LOG("Plain autoreap child unexpectedly has no_new_privs");
+	}
+
+	close(pidfd);
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


