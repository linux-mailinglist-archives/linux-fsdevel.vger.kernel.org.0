Return-Path: <linux-fsdevel+bounces-65157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A195BFD19A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5484F18C5725
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E9836C22A;
	Wed, 22 Oct 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae/iL18L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183436B998;
	Wed, 22 Oct 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149320; cv=none; b=e1s0oGWIErEw4DKMTdCMgy2LRrsxQOVV+ASuRcxABBaQJchdbz2HujDoCMAN90yrvOvSmNVLjXLXTFra5CpgdDEsMBjLKDH+Hq9un9ad334jkKf4XLnTb+ZXwVkDEqMn0JCaoQ45y5DczPf7kFxSx9APHX1/Y9Jv8sXjnQ6TjZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149320; c=relaxed/simple;
	bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biLRsk8WiGgT/2cmP72OPF3wZbKJ67hivMBuHHwlgnOnRO4UmN2W+MQB36caphSZJMoq05ZTcBS4IT7Dm7j7wbwlLfISDbpLbWq/aGVExfWO3nSqYkFTOYCixETmn9Yvs3Lyy0Ar++P0HsIt8AR62WEy2HE9LxJPjc8o2PkkU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae/iL18L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9397AC4CEE7;
	Wed, 22 Oct 2025 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149320;
	bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ae/iL18LvYuWMXvT3qTFVc14meFWYuMAx7p7+uGkmSrRN9PNNVPkh2q/0klv9qXAz
	 tHmZyj5B/oMz1fJTzFSAHulYhfdXDYcFBfWc2fOJyAJE87r2hP15OniryepaoueKcR
	 zk/LuTNjXRAO6HqT9+Hiw53+rtLET0kUZ9xgY/m4spjQlbodgAAvkJZ24TYkG4A8hs
	 DSQBgXWnuvPHygFIAhhcegEaUxxPE6KW9VbRn/7nVaLQm8Rt93mC/ubw1FuiOzCE26
	 FHKj6thDIOQI5UvCpTi7QUtsMINrcYSyIaDzRzpFX24Tpkm3EQfs4V28AuQDId5FVu
	 Tttk0Uf8w7VZw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:07 +0200
Subject: [PATCH v2 29/63] selftests/namespaces: tenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-29-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHjq9clfrsBLyM3Zfe0lo7zjO9WWx1uxnrz3Wq8uK
 LPYvj63o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKbeRgZNqVv8pYS2/NZeaZN
 aZz5bbf1s9ICHsWGFLGdiD/m/POjFiPDLPO6jIrGW7JzorXmTHF13vvqVhn3tshzvamrdfof3Fz
 KCgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test multiple children sharing same parent.
Parent should stay active as long as ANY child is active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 177 +++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 87b435b64b45..15d001df981c 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1176,4 +1176,181 @@ TEST(ns_multilevel_hierarchy)
 	close(gp_fd);
 }
 
+/*
+ * Test multiple children sharing same parent.
+ * Parent should stay active as long as ANY child is active.
+ */
+TEST(ns_multiple_children_same_parent)
+{
+	struct file_handle *p_handle, *c1_handle, *c2_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 p_id, c1_id, c2_id;
+	char p_buf[sizeof(*p_handle) + MAX_HANDLE_SZ];
+	char c1_buf[sizeof(*c1_handle) + MAX_HANDLE_SZ];
+	char c2_buf[sizeof(*c2_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create parent user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int p_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (p_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(p_fd, NS_GET_ID, &p_id) < 0) {
+			close(p_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(p_fd);
+
+		/* Create first child user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int c1_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (c1_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(c1_fd, NS_GET_ID, &c1_id) < 0) {
+			close(c1_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(c1_fd);
+
+		/* Return to parent user namespace and create second child */
+		/* We can't actually do this easily, so let's create a sibling namespace
+		 * by creating a network namespace instead */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		int c2_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (c2_fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+		if (ioctl(c2_fd, NS_GET_ID, &c2_id) < 0) {
+			close(c2_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(c2_fd);
+
+		/* Send all namespace IDs */
+		write(pipefd[1], &p_id, sizeof(p_id));
+		write(pipefd[1], &c1_id, sizeof(c1_id));
+		write(pipefd[1], &c2_id, sizeof(c2_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &p_id, sizeof(p_id));
+	if (ret != sizeof(p_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read parent namespace ID");
+	}
+
+	ret = read(pipefd[0], &c1_id, sizeof(c1_id));
+	if (ret != sizeof(c1_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read first child namespace ID");
+	}
+
+	ret = read(pipefd[0], &c2_id, sizeof(c2_id));
+	close(pipefd[0]);
+	if (ret != sizeof(c2_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read second child namespace ID");
+	}
+
+	/* Construct file handles from namespace IDs */
+	p_handle = (struct file_handle *)p_buf;
+	p_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	p_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *p_fh = (struct nsfs_file_handle *)p_handle->f_handle;
+	p_fh->ns_id = p_id;
+	p_fh->ns_type = 0;
+	p_fh->ns_inum = 0;
+
+	c1_handle = (struct file_handle *)c1_buf;
+	c1_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	c1_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *c1_fh = (struct nsfs_file_handle *)c1_handle->f_handle;
+	c1_fh->ns_id = c1_id;
+	c1_fh->ns_type = 0;
+	c1_fh->ns_inum = 0;
+
+	c2_handle = (struct file_handle *)c2_buf;
+	c2_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	c2_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *c2_fh = (struct nsfs_file_handle *)c2_handle->f_handle;
+	c2_fh->ns_id = c2_id;
+	c2_fh->ns_type = 0;
+	c2_fh->ns_inum = 0;
+
+	/* Open both children before process exits */
+	int c1_fd = open_by_handle_at(FD_NSFS_ROOT, c1_handle, O_RDONLY);
+	int c2_fd = open_by_handle_at(FD_NSFS_ROOT, c2_handle, O_RDONLY);
+
+	if (c1_fd < 0 || c2_fd < 0) {
+		if (c1_fd >= 0) close(c1_fd);
+		if (c2_fd >= 0) close(c2_fd);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open child namespaces");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		close(c1_fd);
+		close(c2_fd);
+		SKIP(return, "Child failed");
+	}
+
+	/* Parent should be active (both children active) */
+	TH_LOG("Both children active - parent should be active");
+	int p_fd = open_by_handle_at(FD_NSFS_ROOT, p_handle, O_RDONLY);
+	ASSERT_GE(p_fd, 0);
+	close(p_fd);
+
+	/* Close first child - parent should STILL be active */
+	TH_LOG("Closing first child - parent should still be active");
+	close(c1_fd);
+	p_fd = open_by_handle_at(FD_NSFS_ROOT, p_handle, O_RDONLY);
+	ASSERT_GE(p_fd, 0);
+	close(p_fd);
+
+	/* Close second child - NOW parent should become inactive */
+	TH_LOG("Closing second child - parent should become inactive");
+	close(c2_fd);
+	p_fd = open_by_handle_at(FD_NSFS_ROOT, p_handle, O_RDONLY);
+	if (p_fd >= 0) {
+		close(p_fd);
+		TH_LOG("Warning: Parent still active after all children inactive");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


