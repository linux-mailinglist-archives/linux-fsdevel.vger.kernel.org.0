Return-Path: <linux-fsdevel+bounces-78497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGpEOfhVoGlLiQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:17:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3281A75A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 176FE30AFD6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9703ACF05;
	Thu, 26 Feb 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9dBo1bH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20673ACEE9;
	Thu, 26 Feb 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113883; cv=none; b=L1e11DR3Rz6wun/KJcnSig5NQlcH0VsMStRnrMz9uDoLDhceOaDvjKRGBf92Gok2HdZTA/w/vJ17ZiATJRT1wjilL1yifzNfWLYCehmfzne4WQ90Uaj4fcmDY8W21X20kUoSE7SYyNWQ1FYqzMmFiQ5z/q+fCIxNrFuYznlP8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113883; c=relaxed/simple;
	bh=TDnJu/pMKQyvPl38p8goYkYRU9gufN4lR8yOJqLo3HU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JL48fbmo+vWCZm3Y8gMMkNiXSZwBa/cnZ7a+fhwptceKhjFMzKPF2MLqGgmXSfsyYU61fNIe4FBEYI9oiJqQSRnjPMkr4GXKDuiMXiwltLOdKHz5gLZx7FX+9MHwjZu/nLmEarQF9xb/m9v3NyyTjHeHYdixEvfgOMhH94kNTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9dBo1bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C29C19423;
	Thu, 26 Feb 2026 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113883;
	bh=TDnJu/pMKQyvPl38p8goYkYRU9gufN4lR8yOJqLo3HU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W9dBo1bH6sGVvjfealiq/uFOSoAlmLRBbeIF2iPiW9oEcbYv6tQ0dnw7krt2jeBqt
	 yJ/j729uTuxB9JKO3Lg/THQXDwT+3RyminZny4re1+4/9H8eZJ6dtxJiF/bAH/vovW
	 LuE/bx8H2+5dOwX76D8DySPtswX385ZLkQ/DzKM1lrf3Aqt1af1lo3iGv/x18m1/uS
	 mtrKbZVw0/CMdVkNOCJLVSD+NdOHGCcjEKETPgC2noPfsDwwjy4YpKjf8zR3zYudl1
	 N27ug9n8EwuQ4qMHHnhO4NGLJWnqijSYVzgklYBiu+AHZIFA7GPSCTsWcdqOvYHpse
	 mS5L7wP1wF79Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:51:04 +0100
Subject: [PATCH v5 6/6] selftests/pidfd: add CLONE_PIDFD_AUTOKILL tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260226-work-pidfs-autoreap-v5-6-d148b984a989@kernel.org>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
In-Reply-To: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=8062; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TDnJu/pMKQyvPl38p8goYkYRU9gufN4lR8yOJqLo3HU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8D+d3NvnbPbtofCe3dVy/e0LlKfIRRbem+d1/0K2b
 Iq8TtPDjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlY+jH8jzqt+unfxkUrtv0M
 6vod77z+YMb+/UG8j3lOOj+9Xsyw5RXD/+h711eqGXw6arm0c06vfFGHQkUPi8IGxgO3Tq/U077
 xnRkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78497-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pfd.events:url]
X-Rspamd-Queue-Id: 4B3281A75A2
X-Rspamd-Action: no action

Add tests for CLONE_PIDFD_AUTOKILL:

- autokill_basic: Verify closing the clone3 pidfd kills the child.
- autokill_requires_pidfd: Verify AUTOKILL without CLONE_PIDFD fails.
- autokill_requires_autoreap: Verify AUTOKILL without CLONE_AUTOREAP
  fails.
- autokill_rejects_thread: Verify AUTOKILL with CLONE_THREAD fails.
- autokill_pidfd_open_no_effect: Verify only the clone3 pidfd triggers
  autokill, not pidfd_open().
- autokill_requires_cap_sys_admin: Verify AUTOKILL without CLONE_NNP
  fails with -EPERM for an unprivileged caller.
- autokill_without_nnp_with_cap: Verify AUTOKILL without CLONE_NNP
  succeeds with CAP_SYS_ADMIN.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 278 +++++++++++++++++++++
 1 file changed, 278 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
index 5fb11230fb07..36adee6c424e 100644
--- a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
@@ -26,10 +26,37 @@
 #define CLONE_AUTOREAP 0x400000000ULL
 #endif
 
+#ifndef CLONE_PIDFD_AUTOKILL
+#define CLONE_PIDFD_AUTOKILL 0x800000000ULL
+#endif
+
 #ifndef CLONE_NNP
 #define CLONE_NNP 0x1000000000ULL
 #endif
 
+#ifndef _LINUX_CAPABILITY_VERSION_3
+#define _LINUX_CAPABILITY_VERSION_3 0x20080522
+#endif
+
+struct cap_header {
+	__u32 version;
+	int pid;
+};
+
+struct cap_data {
+	__u32 effective;
+	__u32 permitted;
+	__u32 inheritable;
+};
+
+static int drop_all_caps(void)
+{
+	struct cap_header hdr = { .version = _LINUX_CAPABILITY_VERSION_3 };
+	struct cap_data data[2] = {};
+
+	return syscall(__NR_capset, &hdr, data);
+}
+
 static pid_t create_autoreap_child(int *pidfd)
 {
 	struct __clone_args args = {
@@ -619,4 +646,255 @@ TEST(autoreap_no_new_privs_unset)
 	close(pidfd);
 }
 
+/*
+ * Helper: create a child with CLONE_PIDFD | CLONE_PIDFD_AUTOKILL | CLONE_AUTOREAP | CLONE_NNP.
+ */
+static pid_t create_autokill_child(int *pidfd)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP | CLONE_NNP,
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
+	int pidfd = -1;
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL,
+		.exit_signal	= 0,
+		.pidfd		= ptr_to_u64(&pidfd),
+	};
+	pid_t pid;
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
+	int pidfd = -1;
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP | CLONE_THREAD |
+				  CLONE_SIGHAND | CLONE_VM,
+		.exit_signal	= 0,
+		.pidfd		= ptr_to_u64(&pidfd),
+	};
+	pid_t pid;
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
+/*
+ * Test that CLONE_PIDFD_AUTOKILL without CLONE_NNP fails with EPERM
+ * for an unprivileged caller.
+ */
+TEST(autokill_requires_cap_sys_admin)
+{
+	int pidfd = -1, ret;
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP,
+		.exit_signal	= 0,
+		.pidfd		= ptr_to_u64(&pidfd),
+	};
+	pid_t pid;
+
+	/* Drop all capabilities so we lack CAP_SYS_ADMIN. */
+	ret = drop_all_caps();
+	ASSERT_EQ(ret, 0);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EPERM);
+}
+
+/*
+ * Test that CLONE_PIDFD_AUTOKILL without CLONE_NNP succeeds with
+ * CAP_SYS_ADMIN.
+ */
+TEST(autokill_without_nnp_with_cap)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_PIDFD_AUTOKILL |
+				  CLONE_AUTOREAP,
+		.exit_signal	= 0,
+	};
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	if (geteuid() != 0)
+		SKIP(return, "Need root/CAP_SYS_ADMIN");
+
+	args.pidfd = ptr_to_u64(&pidfd);
+
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_PIDFD_AUTOKILL not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0)
+		_exit(0);
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Wait for child to exit. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
+
+	close(pidfd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


