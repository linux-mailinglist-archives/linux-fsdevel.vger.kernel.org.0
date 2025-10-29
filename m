Return-Path: <linux-fsdevel+bounces-66250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC3FC1A5C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4285824D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3634AB07;
	Wed, 29 Oct 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLUt5/Ty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F8336EEF;
	Wed, 29 Oct 2025 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740628; cv=none; b=Sj2M62+2wVcdGpysw3HLe6k2bfylcS6kjV+JSJAa1v71PlzdZ/SvifW0srrA+wQLXHCsPFPgECJu377F+VAQyPS9vWwNwkOWL4peDoP5jrlTYN0Kg5zfvSq4oYfydihMMbnKiMvoPY7ndhTQjeQHZl/k7B/Hf20kKhfraAtCmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740628; c=relaxed/simple;
	bh=ZSob+cuR8TNM3RYLLd2l60NqKAeHuoXtXyT5AeRNtxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaoUc8py8I50/5wc9t0Mx2F/THr5iABRC4X+7xLeGa9F9e4k8wiYhnJ7LJfDLNZ43fUxfqGbpiTua5A+YPTM51zvRRMsEdwZ1ubqWqGNcKs+MVRxOKJFAQQrVNknE5lyTXy1Kv038DwGOGbM2KrU7a37iHEWpHy7zZN4WXUL0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLUt5/Ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BA4C4CEFF;
	Wed, 29 Oct 2025 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740626;
	bh=ZSob+cuR8TNM3RYLLd2l60NqKAeHuoXtXyT5AeRNtxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PLUt5/TyWea+Uocoe4cwpWFDWFHJkcOzodSH3RsVgZaGhqvM9b5954lJ0czBiZ4Yp
	 XHj178gG42gHDq1Ju000cf/gLl0I79ma9HkE1e1o1YgUdxTsW9wqLGRqSNmXi3Q/zp
	 UoAbmpxazuknWaYMadstcX0LPm1oqbdM/T0vi7ijd4UCuDyEJmbNwbkqDUIBdpwH1w
	 g1m3OvI5DQmcD0YxKumsY8iGZBvIQ/YmRoDRjLKl7uvpnhLR0MTgooXWr/o1iOvUdO
	 JbHvz6zovFPlHgMR+fuZoglenMKoVhhPxlsPHnIoVvirEDcYrse5M0Cobh7ljJqR56
	 RC3c9TeMBUtRw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:50 +0100
Subject: [PATCH v4 37/72] selftests/namespaces: fifteenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-37-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5309; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZSob+cuR8TNM3RYLLd2l60NqKAeHuoXtXyT5AeRNtxA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfX9Esi7yJflwLtGsFzk26GevplB1qsP7RR10t4on
 DZx6pTYjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInUn2Vk+JBx7fO+l16/f3Ee
 zNos9/mm16HNhheWXrv055H79+O1NzgZ/qdGN2ppzZj8sWndD5O3Bj98X/puv9o03+64fc2jO1p
 FJqwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test different namespace types (net, uts, ipc) all contributing
active references to the same owning user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 430702c041a9..b7fa973a2572 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1949,4 +1949,168 @@ TEST(ns_userns_child_propagation)
 	ASSERT_LT(ua_fd, 0);
 }
 
+/*
+ * Test different namespace types (net, uts, ipc) all contributing
+ * active references to the same owning user namespace.
+ */
+TEST(ns_mixed_types_same_owner)
+{
+	struct file_handle *user_handle, *net_handle, *uts_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 u_id, n_id, ut_id;
+	char u_buf[sizeof(*user_handle) + MAX_HANDLE_SZ];
+	char n_buf[sizeof(*net_handle) + MAX_HANDLE_SZ];
+	char ut_buf[sizeof(*uts_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int u_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (u_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(u_fd, NS_GET_ID, &u_id) < 0) {
+			close(u_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(u_fd);
+
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int n_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (n_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(n_fd, NS_GET_ID, &n_id) < 0) {
+			close(n_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(n_fd);
+
+		if (unshare(CLONE_NEWUTS) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int ut_fd = open("/proc/self/ns/uts", O_RDONLY);
+		if (ut_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(ut_fd, NS_GET_ID, &ut_id) < 0) {
+			close(ut_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(ut_fd);
+
+		/* Send all namespace IDs */
+		write(pipefd[1], &u_id, sizeof(u_id));
+		write(pipefd[1], &n_id, sizeof(n_id));
+		write(pipefd[1], &ut_id, sizeof(ut_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &u_id, sizeof(u_id));
+	if (ret != sizeof(u_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user namespace ID");
+	}
+
+	ret = read(pipefd[0], &n_id, sizeof(n_id));
+	if (ret != sizeof(n_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read network namespace ID");
+	}
+
+	ret = read(pipefd[0], &ut_id, sizeof(ut_id));
+	close(pipefd[0]);
+	if (ret != sizeof(ut_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read UTS namespace ID");
+	}
+
+	/* Construct file handles from namespace IDs */
+	user_handle = (struct file_handle *)u_buf;
+	user_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	user_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *u_fh = (struct nsfs_file_handle *)user_handle->f_handle;
+	u_fh->ns_id = u_id;
+	u_fh->ns_type = 0;
+	u_fh->ns_inum = 0;
+
+	net_handle = (struct file_handle *)n_buf;
+	net_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	net_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *n_fh = (struct nsfs_file_handle *)net_handle->f_handle;
+	n_fh->ns_id = n_id;
+	n_fh->ns_type = 0;
+	n_fh->ns_inum = 0;
+
+	uts_handle = (struct file_handle *)ut_buf;
+	uts_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	uts_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *ut_fh = (struct nsfs_file_handle *)uts_handle->f_handle;
+	ut_fh->ns_id = ut_id;
+	ut_fh->ns_type = 0;
+	ut_fh->ns_inum = 0;
+
+	/* Open both non-user namespaces */
+	int n_fd = open_by_handle_at(FD_NSFS_ROOT, net_handle, O_RDONLY);
+	int ut_fd = open_by_handle_at(FD_NSFS_ROOT, uts_handle, O_RDONLY);
+	if (n_fd < 0 || ut_fd < 0) {
+		if (n_fd >= 0) close(n_fd);
+		if (ut_fd >= 0) close(ut_fd);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open namespaces");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* User namespace should be active (2 active children) */
+	TH_LOG("Both net and uts active - user ns should be active");
+	int u_fd = open_by_handle_at(FD_NSFS_ROOT, user_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close net - user ns should STILL be active (uts still active) */
+	TH_LOG("Closing net - user ns should still be active");
+	close(n_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, user_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close uts - user ns should become inactive */
+	TH_LOG("Closing uts - user ns should become inactive");
+	close(ut_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, user_handle, O_RDONLY);
+	ASSERT_LT(u_fd, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


