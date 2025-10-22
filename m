Return-Path: <linux-fsdevel+bounces-65159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0784BFD332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF133B9EDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BFE36CA8C;
	Wed, 22 Oct 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anhSpSoc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469C36CA73;
	Wed, 22 Oct 2025 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149331; cv=none; b=XCJ1mrkiSqQtskcJHohsWdoXJX1xKS8CwM/QTH5IdkyVQNVNHeCaMv7heLGDwEy9v+QeX2v5LcsBlMFuSpJJw0GnbuznYwAEX88HATp09bjqUXlcHIRBhkikQyQn9Ph3AamHMM7ENgQbAJx07Q+ZzkNh02EoLHhLb+uKD/QqH0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149331; c=relaxed/simple;
	bh=YF6LlFsedC0FcPBAnpIIRxVh8Wv/PCUOI1UuPciGHmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CC/mCsOw/SEkfye4EbEqtC23XceS0d7U5wzjCFnSrh9d1zwj5kCqnLoA6BaVMuqxLlhx43q9UONqr980F4097A8RgJ647YsJkFdEaA97aBuPCiy5wIJDczblyUyJ6he44X5KJhBqbGCGMDN99R4qKFWCi53r2eY+UEv7sNVkdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anhSpSoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322CCC4CEE7;
	Wed, 22 Oct 2025 16:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149331;
	bh=YF6LlFsedC0FcPBAnpIIRxVh8Wv/PCUOI1UuPciGHmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anhSpSocL4/Y0wO7SWHo1+WKZyZmaX1PqPELD+iJSgf5O0FBBgxstD49+P6aX20a/
	 Ndd0oimDGHnrrdjvxvC4ySXLdIHTvE2FS118PmUlXmbPRQ+kmYCDGD/ce/JbTKKUt1
	 5jsNKZ8PZmiqwynUblI9pu8friTlb9o0l8VxdsGJmA0uAT07Nq11Aj4bz2QM1SkQ73
	 EL5Frw6tzWjc0W4wIFsXBYVZBn/6AcoN1I2HunYU7BA1Rb16Txgegd8tmEl0RruLCt
	 A6gPMypjB7VyFHv2RdIF0dYSasMkC0a6GxsRLerRjsJWMpl5NJoQO4OZi1n8WrDjZv
	 AG3BKlQqeyDcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:09 +0200
Subject: [PATCH v2 31/63] selftests/namespaces: twelth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-31-71a588572371@kernel.org>
References: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
In-Reply-To: <20251022-work-namespace-nstree-listns-v2-0-71a588572371@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=6173; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YF6LlFsedC0FcPBAnpIIRxVh8Wv/PCUOI1UuPciGHmg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHhmWHNzW3HXn7tan3lYVqTELgpme15bPfVd2ZT+h
 Avh/5+YdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk1Q1GhgdH3PiX5ay2+TC7
 h42nS4I9yk9a/EntMQ+edsWkl7ciBBgZru5avHZbIIdZcshdFpXn8eUvbHJ/n2ISnqydJH/ufsp
 TXgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test hierarchical propagation with deep namespace hierarchy.
Create: init_user_ns -> user_A -> user_B -> net_ns
When net_ns is active, both user_A and user_B should be active.
This verifies the conditional recursion in __ns_ref_active_put() works.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 182 +++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 3c2f99b25067..63cc88fe5cc1 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1531,4 +1531,186 @@ TEST(ns_different_types_same_owner)
 	}
 }
 
+/*
+ * Test hierarchical propagation with deep namespace hierarchy.
+ * Create: init_user_ns -> user_A -> user_B -> net_ns
+ * When net_ns is active, both user_A and user_B should be active.
+ * This verifies the conditional recursion in __ns_ref_active_put() works.
+ */
+TEST(ns_deep_hierarchy_propagation)
+{
+	struct file_handle *ua_handle, *ub_handle, *net_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 ua_id, ub_id, net_id;
+	char ua_buf[sizeof(*ua_handle) + MAX_HANDLE_SZ];
+	char ub_buf[sizeof(*ub_handle) + MAX_HANDLE_SZ];
+	char net_buf[sizeof(*net_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create user_A -> user_B -> net hierarchy */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int ua_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (ua_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(ua_fd, NS_GET_ID, &ua_id) < 0) {
+			close(ua_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(ua_fd);
+
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int ub_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (ub_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(ub_fd, NS_GET_ID, &ub_id) < 0) {
+			close(ub_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(ub_fd);
+
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int net_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (net_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(net_fd, NS_GET_ID, &net_id) < 0) {
+			close(net_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(net_fd);
+
+		/* Send all three namespace IDs */
+		write(pipefd[1], &ua_id, sizeof(ua_id));
+		write(pipefd[1], &ub_id, sizeof(ub_id));
+		write(pipefd[1], &net_id, sizeof(net_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &ua_id, sizeof(ua_id));
+	if (ret != sizeof(ua_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user_A namespace ID");
+	}
+
+	ret = read(pipefd[0], &ub_id, sizeof(ub_id));
+	if (ret != sizeof(ub_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user_B namespace ID");
+	}
+
+	ret = read(pipefd[0], &net_id, sizeof(net_id));
+	close(pipefd[0]);
+	if (ret != sizeof(net_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read network namespace ID");
+	}
+
+	/* Construct file handles from namespace IDs */
+	ua_handle = (struct file_handle *)ua_buf;
+	ua_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	ua_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *ua_fh = (struct nsfs_file_handle *)ua_handle->f_handle;
+	ua_fh->ns_id = ua_id;
+	ua_fh->ns_type = 0;
+	ua_fh->ns_inum = 0;
+
+	ub_handle = (struct file_handle *)ub_buf;
+	ub_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	ub_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *ub_fh = (struct nsfs_file_handle *)ub_handle->f_handle;
+	ub_fh->ns_id = ub_id;
+	ub_fh->ns_type = 0;
+	ub_fh->ns_inum = 0;
+
+	net_handle = (struct file_handle *)net_buf;
+	net_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	net_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *net_fh = (struct nsfs_file_handle *)net_handle->f_handle;
+	net_fh->ns_id = net_id;
+	net_fh->ns_type = 0;
+	net_fh->ns_inum = 0;
+
+	/* Open net_ns before child exits to keep it active */
+	int net_fd = open_by_handle_at(FD_NSFS_ROOT, net_handle, O_RDONLY);
+	if (net_fd < 0) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open network namespace");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		close(net_fd);
+		SKIP(return, "Child failed");
+	}
+
+	/* With net_ns active, both user_A and user_B should be active */
+	TH_LOG("Testing user_B active (net_ns active causes propagation)");
+	int ub_fd = open_by_handle_at(FD_NSFS_ROOT, ub_handle, O_RDONLY);
+	ASSERT_GE(ub_fd, 0);
+
+	TH_LOG("Testing user_A active (propagated through user_B)");
+	int ua_fd = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	ASSERT_GE(ua_fd, 0);
+
+	/* Close net_ns - user_B should stay active (we hold direct ref) */
+	TH_LOG("Closing net_ns, user_B should remain active (direct ref held)");
+	close(net_fd);
+	int ub_fd2 = open_by_handle_at(FD_NSFS_ROOT, ub_handle, O_RDONLY);
+	ASSERT_GE(ub_fd2, 0);
+	close(ub_fd2);
+
+	/* Close user_B - user_A should stay active (we hold direct ref) */
+	TH_LOG("Closing user_B, user_A should remain active (direct ref held)");
+	close(ub_fd);
+	int ua_fd2 = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	ASSERT_GE(ua_fd2, 0);
+	close(ua_fd2);
+
+	/* Close user_A - everything should become inactive */
+	TH_LOG("Closing user_A, all should become inactive");
+	close(ua_fd);
+
+	/* All should now be inactive */
+	ua_fd = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	if (ua_fd >= 0) {
+		close(ua_fd);
+		TH_LOG("Warning: user_A still active");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


