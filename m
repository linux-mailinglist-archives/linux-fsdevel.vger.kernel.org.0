Return-Path: <linux-fsdevel+bounces-65158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA2BFD305
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3333B0FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085B2BDC2C;
	Wed, 22 Oct 2025 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYD5zpTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5436C24C;
	Wed, 22 Oct 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149325; cv=none; b=eZ5UMlw8dx/NJcimN5ktxSHNAAet/Qon4aKmYiHjkH7+eRpPYlmoaKTnhkDSk/ksKTUYqoWS3ebaGZc7Iplh1+3VSXiViRtKRfv6nBDUxeOGpayxs7KImnUJAdWT/nzV6pcVK7qLLNadlLQXe+3HnAjJQc7AH4PSnoQH2MoScL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149325; c=relaxed/simple;
	bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paudmdrd23WFbweThiJ02dYdVu9SRRLCqtukxZ4/q7RyAuU0P5CP/K0LCOVAdCn6BfSprlaZ7XQ/VStD/ToMpuHYoFJWRKJHwDnYgkbjtLTbndLpXP9Bi882TaykRRInC7QtV05qrMCs+uj0rGiUb4coksOH4VoTqDK3iLAEkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYD5zpTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF3FC4CEF7;
	Wed, 22 Oct 2025 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149325;
	bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MYD5zpTo3Uo7bqM+eMBO33qzRIlw2WUzMXB5p0cchxfKBCi1v3ikwIQ/M5WJH+wZ7
	 y7FsKHjko6Z+cLjrUvPNlOFSyNNzzi7Mp3FsaThJ1eiUbWOpRi815QKxEXp3gRCFZi
	 4GPz17tvrZHn+fJ1ULp4ab9B/GvFjXKVaXsX3MG/XznY7K+fwUFx+fsoH1dQSr4VuD
	 h3DBGb+5bSYLSc5dnEv4MjH1mluPkRt39bnaDxzf3alpeRc2MrFvv6St04a7JFP+wK
	 sDVtCwjQykobp+LnDyaco2rec5a458T4jL02K3KxQ2HXYyFQQm6hb7+TXX7ssTvFIV
	 p8VptF65Ipbfw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:08 +0200
Subject: [PATCH v2 30/63] selftests/namespaces: eleventh active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-30-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5721; i=brauner@kernel.org;
 h=from:subject:message-id; bh=H4jWaPD3RLb43DWhIT3tk1IDFLr01dcU/60jks3O+nc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHg2KXTOsv671fUaVxW37uqbW7mnTWTvPv8pqbHNn
 z2+B3/z7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIwRSG/+nPFjXKbd1+/1Nu
 Prvalt7OX50RyX21eScTxeb6Wfxbb8HwP/rfNYvHnvEL6zdxdWxc6BFXubDdXOVwtsGsuBaTHXl
 TmAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that different namespace types with same owner all contribute
active references to the owning user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 15d001df981c..3c2f99b25067 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1353,4 +1353,182 @@ TEST(ns_multiple_children_same_parent)
 	}
 }
 
+/*
+ * Test that different namespace types with same owner all contribute
+ * active references to the owning user namespace.
+ */
+TEST(ns_different_types_same_owner)
+{
+	struct file_handle *u_handle, *n_handle, *ut_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 u_id, n_id, ut_id;
+	char u_buf[sizeof(*u_handle) + MAX_HANDLE_SZ];
+	char n_buf[sizeof(*n_handle) + MAX_HANDLE_SZ];
+	char ut_buf[sizeof(*ut_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create user namespace */
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
+		/* Create network namespace (owned by user namespace) */
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
+		/* Create UTS namespace (also owned by user namespace) */
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
+	u_handle = (struct file_handle *)u_buf;
+	u_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	u_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *u_fh = (struct nsfs_file_handle *)u_handle->f_handle;
+	u_fh->ns_id = u_id;
+	u_fh->ns_type = 0;
+	u_fh->ns_inum = 0;
+
+	n_handle = (struct file_handle *)n_buf;
+	n_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	n_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *n_fh = (struct nsfs_file_handle *)n_handle->f_handle;
+	n_fh->ns_id = n_id;
+	n_fh->ns_type = 0;
+	n_fh->ns_inum = 0;
+
+	ut_handle = (struct file_handle *)ut_buf;
+	ut_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	ut_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *ut_fh = (struct nsfs_file_handle *)ut_handle->f_handle;
+	ut_fh->ns_id = ut_id;
+	ut_fh->ns_type = 0;
+	ut_fh->ns_inum = 0;
+
+	/* Open both non-user namespaces before process exits */
+	int n_fd = open_by_handle_at(FD_NSFS_ROOT, n_handle, O_RDONLY);
+	int ut_fd = open_by_handle_at(FD_NSFS_ROOT, ut_handle, O_RDONLY);
+
+	if (n_fd < 0 || ut_fd < 0) {
+		if (n_fd >= 0) close(n_fd);
+		if (ut_fd >= 0) close(ut_fd);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open namespaces");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		close(n_fd);
+		close(ut_fd);
+		SKIP(return, "Child failed");
+	}
+
+	/*
+	 * Both network and UTS namespaces are active.
+	 * User namespace should be active (gets 2 active refs).
+	 */
+	TH_LOG("Both net and uts active - user namespace should be active");
+	int u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close network namespace - user namespace should STILL be active */
+	TH_LOG("Closing network ns - user ns should still be active (uts still active)");
+	close(n_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	ASSERT_GE(u_fd, 0);
+	close(u_fd);
+
+	/* Close UTS namespace - user namespace should become inactive */
+	TH_LOG("Closing uts ns - user ns should become inactive");
+	close(ut_fd);
+	u_fd = open_by_handle_at(FD_NSFS_ROOT, u_handle, O_RDONLY);
+	if (u_fd >= 0) {
+		close(u_fd);
+		TH_LOG("Warning: User namespace still active after all owned namespaces inactive");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


