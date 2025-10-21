Return-Path: <linux-fsdevel+bounces-64884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33BBF6413
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E2825035A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6493C347FE3;
	Tue, 21 Oct 2025 11:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K96nrx9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14C032F76F;
	Tue, 21 Oct 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047205; cv=none; b=o81T0F+6CFUJr2JK9ibTQTxCPRWWpn3vnyMfT7wbpTGdCsMUIvBjwa7NEksbJg5bqbdAuTRJcaXn1ABwAfyWOTFL9BD/+PR8N7Hez2FKMRjb/2QDJ7Xw2XeRpaBR9Ew2NrcXC9mPWIgtWmjz/Mgo6PJo2MRjXAH+0+wfF+0b+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047205; c=relaxed/simple;
	bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLRdPocwcAbN0cv7v+7VS8kvYxGd1AT8dsJtkYchmQxUhZXQdnHPU/lvj0PqkKj24Ki0gzqs5oVCONHh7X0M5oyxZRzW997DlyoB0p1kUCly0k6zCN4ELl1EM1yMpOyWKLV6o7MZYt9ehkmiEpauzPNjfL3IyhXUcLmUlKf6vuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K96nrx9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3332C4CEF1;
	Tue, 21 Oct 2025 11:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047205;
	bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K96nrx9iRRnUGTehuxNYsZGfuis5YRpdPUhmvFazK5iOROI0WTD+z0SMfd4zXY/YC
	 GdQeBKbn7arTSykFAo18wlpv+lCNwnnd8EpiUTyFCGz0c9hB7cHUqw9K/rCoxb9/Dt
	 YeMzQwPDRJLlMtmvpoM3xbvd/tFesEcXsTCKoZiQtNZRSdHSEBFUVGkHsKPnFypqWp
	 9kHZRXIb4h55nopOZuXfbSGj62mqCKVIB5ym4LDJxmQ4de5r//c8LwG94v1+UDUmK2
	 6DEcnqInL2OTeYuzMmJiwZGdLeWGkaQZRj4g2dk+vvG0d7wSFGuFfsQkuKefQ/7llc
	 Bp/6NbkhsR53Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:39 +0200
Subject: [PATCH RFC DRAFT 33/50] selftests/namespaces: fifteenth active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-33-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425; i=brauner@kernel.org;
 h=from:subject:message-id; bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3z3KeqKn7CHwL7UJ9UxTOqmewvk7gt9vSZ1ftF33
 bPL1G/M7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI805Ghvnat++UHHXm//hD
 y0x7dr1hX2v5ai8m5lh9UWf+VzdkXjAyPC4Jmeq3v37VIv8zi87tnZGZnPqlwaXNaml25wNDy63
 qrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test different namespace types (net, uts, ipc) all contributing
active references to the same owning user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 1eb4dc07e924..8b1553be6881 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -2052,4 +2052,175 @@ TEST(ns_userns_child_propagation)
 	}
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
+	if (WEXITSTATUS(status) != 0) {
+		close(n_fd);
+		close(ut_fd);
+		SKIP(return, "Child failed");
+	}
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
+	if (u_fd >= 0) {
+		close(u_fd);
+		TH_LOG("Warning: User ns still active");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


