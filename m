Return-Path: <linux-fsdevel+bounces-65160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C2BFD311
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D413B87AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E66368F30;
	Wed, 22 Oct 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtwSQowD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524227703C;
	Wed, 22 Oct 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149337; cv=none; b=rXkSjPjY5q9PuNlI/z8X5+bB4pRR26QRmJ8jt2qj5+dUrlYy2827fG1zvdTcklkoHD2W1ublaFATsMSxkl5KQSbpS0FGODUK2w1AFTh4MxuP7qW3+YQ8X7yncQxuKKM+GtwUbwPYzT0Tgbl2Me6J0a3EWKuzH34thvt7WTWETfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149337; c=relaxed/simple;
	bh=vsrRT4zqgD+nKit9MH7tv6SchshKJx7ljsx1OLBVRIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQP9y+qJ3ZQqCuKo2+cuTeAdtwJjyogpln40gn4q9Z9mC2c5DRreFT6BKIcmR2ZeBLEs+wE2YoPasLZh1JZzHmFStXegBvNdruS228LewzwDxBcMa0D4ywsyJi5lFc7Jn/3Ct+dy/YA/yWaXAzFi8SixIFxblIaFzS0GgY8VfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtwSQowD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4485C4CEFD;
	Wed, 22 Oct 2025 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149336;
	bh=vsrRT4zqgD+nKit9MH7tv6SchshKJx7ljsx1OLBVRIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UtwSQowDPUxM7jr/H84m9ZfhgSDHxtsMhG5+q1h/gx2UEvOliYJQxs5Wz1DwTRJYS
	 fW8LN542gm+miWCKBsrvJNy33O7E2vehZ68kZSiNWxGivHJVzpxiGSbWfvm7aj+Oaq
	 L4FG73cB2NjR0hV5GZTq4yCZk5O5VZTrX4uFYARmWy0xnLiUvGWA/WIggvOugP1aWx
	 C6ZpARjnsuH/qntEKDx2wopS3apRAm41U4q6QB+DS7IhgVNtpINdwadMvoUzABaYMB
	 b+sdMwOtElmWIth/2xlDW3fiYzTSlrPrg+LkChIFbXXmd004UUg6/JnNgOqyX7W7Tg
	 BWplrksfkeXqw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:10 +0200
Subject: [PATCH v2 32/63] selftests/namespaces: thirteenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-32-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vsrRT4zqgD+nKit9MH7tv6SchshKJx7ljsx1OLBVRIQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHg2wfUB7y/phdxZ6hwLG2fOZc9+tWvmCaPpimZmD
 StcjL9v7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI7HFGhjf1SlqrthX2X00v
 VDwlU+T958TDU+3qzV8Pi5Z56yeqSjAyPF24IHzP9uW+i5rnPds0oXH7h8UJ2jbMV3fk9ie4yz0
 tYgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that parent stays active as long as ANY child is active.
Create parent user namespace with two child net namespaces.
Parent should remain active until BOTH children are inactive.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 201 +++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 63cc88fe5cc1..4c077223b05c 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1713,4 +1713,205 @@ TEST(ns_deep_hierarchy_propagation)
 	}
 }
 
+/*
+ * Test that parent stays active as long as ANY child is active.
+ * Create parent user namespace with two child net namespaces.
+ * Parent should remain active until BOTH children are inactive.
+ */
+TEST(ns_parent_multiple_children_refcount)
+{
+	struct file_handle *parent_handle, *net1_handle, *net2_handle;
+	int ret, pipefd[2], syncpipe[2];
+	pid_t pid;
+	int status;
+	__u64 p_id, n1_id, n2_id;
+	char p_buf[sizeof(*parent_handle) + MAX_HANDLE_SZ];
+	char n1_buf[sizeof(*net1_handle) + MAX_HANDLE_SZ];
+	char n2_buf[sizeof(*net2_handle) + MAX_HANDLE_SZ];
+	char sync_byte;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	ASSERT_EQ(pipe(syncpipe), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		close(syncpipe[1]);
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
+		/* Create first network namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		int n1_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (n1_fd < 0) {
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+		if (ioctl(n1_fd, NS_GET_ID, &n1_id) < 0) {
+			close(n1_fd);
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+		/* Keep n1_fd open so first namespace stays active */
+
+		/* Create second network namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(n1_fd);
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+
+		int n2_fd = open("/proc/self/ns/net", O_RDONLY);
+		if (n2_fd < 0) {
+			close(n1_fd);
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+		if (ioctl(n2_fd, NS_GET_ID, &n2_id) < 0) {
+			close(n1_fd);
+			close(n2_fd);
+			close(pipefd[1]);
+			close(syncpipe[0]);
+			exit(1);
+		}
+		/* Keep both n1_fd and n2_fd open */
+
+		/* Send all namespace IDs */
+		write(pipefd[1], &p_id, sizeof(p_id));
+		write(pipefd[1], &n1_id, sizeof(n1_id));
+		write(pipefd[1], &n2_id, sizeof(n2_id));
+		close(pipefd[1]);
+
+		/* Wait for parent to signal before exiting */
+		read(syncpipe[0], &sync_byte, 1);
+		close(syncpipe[0]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+	close(syncpipe[0]);
+
+	/* Read all three namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &p_id, sizeof(p_id));
+	if (ret != sizeof(p_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read parent namespace ID");
+	}
+
+	ret = read(pipefd[0], &n1_id, sizeof(n1_id));
+	if (ret != sizeof(n1_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read first network namespace ID");
+	}
+
+	ret = read(pipefd[0], &n2_id, sizeof(n2_id));
+	close(pipefd[0]);
+	if (ret != sizeof(n2_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read second network namespace ID");
+	}
+
+	/* Construct file handles from namespace IDs */
+	parent_handle = (struct file_handle *)p_buf;
+	parent_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	parent_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *p_fh = (struct nsfs_file_handle *)parent_handle->f_handle;
+	p_fh->ns_id = p_id;
+	p_fh->ns_type = 0;
+	p_fh->ns_inum = 0;
+
+	net1_handle = (struct file_handle *)n1_buf;
+	net1_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	net1_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *n1_fh = (struct nsfs_file_handle *)net1_handle->f_handle;
+	n1_fh->ns_id = n1_id;
+	n1_fh->ns_type = 0;
+	n1_fh->ns_inum = 0;
+
+	net2_handle = (struct file_handle *)n2_buf;
+	net2_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	net2_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *n2_fh = (struct nsfs_file_handle *)net2_handle->f_handle;
+	n2_fh->ns_id = n2_id;
+	n2_fh->ns_type = 0;
+	n2_fh->ns_inum = 0;
+
+	/* Open both net namespaces while child is still alive */
+	int n1_fd = open_by_handle_at(FD_NSFS_ROOT, net1_handle, O_RDONLY);
+	int n2_fd = open_by_handle_at(FD_NSFS_ROOT, net2_handle, O_RDONLY);
+	if (n1_fd < 0 || n2_fd < 0) {
+		if (n1_fd >= 0) close(n1_fd);
+		if (n2_fd >= 0) close(n2_fd);
+		sync_byte = 'G';
+		write(syncpipe[1], &sync_byte, 1);
+		close(syncpipe[1]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open net namespaces");
+	}
+
+	/* Signal child that we have opened the namespaces */
+	sync_byte = 'G';
+	write(syncpipe[1], &sync_byte, 1);
+	close(syncpipe[1]);
+
+	/* Wait for child to exit */
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) != 0) {
+		close(n1_fd);
+		close(n2_fd);
+		SKIP(return, "Child failed");
+	}
+
+	/* Parent should be active (has 2 active children) */
+	TH_LOG("Both net namespaces active - parent should be active");
+	int p_fd = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	ASSERT_GE(p_fd, 0);
+	close(p_fd);
+
+	/* Close first net namespace - parent should STILL be active */
+	TH_LOG("Closing first net ns - parent should still be active");
+	close(n1_fd);
+	p_fd = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	ASSERT_GE(p_fd, 0);
+	close(p_fd);
+
+	/* Close second net namespace - parent should become inactive */
+	TH_LOG("Closing second net ns - parent should become inactive");
+	close(n2_fd);
+	p_fd = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	if (p_fd >= 0) {
+		close(p_fd);
+		TH_LOG("Warning: Parent still active after all children inactive");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


