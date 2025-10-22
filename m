Return-Path: <linux-fsdevel+bounces-65162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E3DBFD1F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427A11A030B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D94374ACA;
	Wed, 22 Oct 2025 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ippgv8ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B63C374AB5;
	Wed, 22 Oct 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149347; cv=none; b=Zrt10kAw+uloymHQr3OJYqiaAn2PkpOGvW8XYGP6P2OhKr9pHElIdm3ngYqAL2gNQQlP9Qs2ApcZGHBmXODf8yBZT3KlsI/+jM3nCxD6Ac+O4jSifMLej2qTlsIrM5CwQN3eAYn/NOZnKL6/ffC6s1JguxsE/QTyfwk6U7H+7Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149347; c=relaxed/simple;
	bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcNZIKt/TSf8FyGVtb4+yE7VPclGhisJVUUzpADQPhG/UEVxGUafBTopDDq4QK6dB02cwawEoo6HGSpYdQXMuUJLdEzEmEzPJTk0dfTCsKuMQ77KoHogCysm2ferUDqorW3K2QKw9/TYQMt019RYR29xh8DbtlhjbTSMyw1F/iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ippgv8ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169DCC4CEFD;
	Wed, 22 Oct 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149346;
	bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ippgv8ce4RsVynXiVpkXCyz27UerBAqyx61/XoDOaRsUJ6OTINJdT07QaZX7zoI4f
	 KGqpzIjSE8tUZMlaakfXZG8mtswha11sVromh+TDU3z4BH6JACmcsf78xM/fOaXopg
	 FLwlXwtIXfPcuBWNV+f30Y1JkUNL6U3XvRFdHPxwWfVfUyvXas201erm326ntV018o
	 3ghgdeHONztq9qol20Coi0hBrFGk1dpBpGYGnpndc4hu2CDyN1XKRV6W6yHULaZe6j
	 zyLAJ9hpmiHZhsHY1vCMVCYMGc6aMGrv81F8gG89WZJYXLZmwFg59jAhhE5BfK5tbe
	 IqMK7vr6NghPQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:12 +0200
Subject: [PATCH v2 34/63] selftests/namespaces: fifteenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-34-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425; i=brauner@kernel.org;
 h=from:subject:message-id; bh=elfrUH3DfTC46qvkbhHf42IekzBPgA/k+oqQpuntS3A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHi253im8uH2tqU/M37NtLGMnu42taE/brnvq5LAw
 v6LybapHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNps2NkeBBofeaVw8R+npV7
 43ewVt6okDmvwV+VwFu7LnT3t4wbpxn+KZT/O3VAfeYUdRfzV7XTXK49ymFJ/DzFoXdRKH/s/Ks
 JrAA=
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


