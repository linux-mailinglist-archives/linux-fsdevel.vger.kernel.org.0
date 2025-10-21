Return-Path: <linux-fsdevel+bounces-64879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F28BF6397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17761893E69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A56B3446CF;
	Tue, 21 Oct 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F49M6U7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D3F32ED20;
	Tue, 21 Oct 2025 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047180; cv=none; b=FzBbWfJLDUnOY2/jeG9B4P5DvDS8m9dVfo2HGecsBYA3aG6cXSB+8WDcDKHtu5oBntsrmrLkPvQd4TE7mYDxwZmmc0fC6UodfVNQRt4GGxaJaB+tdPCTRacMFZ4pNvYu5KPneSSLHbLvtQJMjCiUNdzEZUshqdmlEObsXFERYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047180; c=relaxed/simple;
	bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2yZQjdsEGMt3/OeJNidsOi6Ixn9/AJZ3CEybpBLivpAqHYIBARAkEaoMrksfL0T6KKKaJsx6bQgEkFjO+nYH80jioVg0iReAORdalV7yDVbPnPeBvrtxQ+AJY99U2wWM0n39Z6093MTXoExUsQlJUSlDXTdCw2e5AqTLsSBGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F49M6U7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF0C4CEF1;
	Tue, 21 Oct 2025 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047179;
	bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F49M6U7K70BJ/lsXTPa41Jvp3gJgolyvA+ePtLWkR9TZy3+4diLuQ1OnigPsTA+C2
	 ustM9dCbhZbVM6KRqRcwRriRavqKJg3ReIjdOtvJb7k7tcbKXosoxoxLDIrvI0zYrE
	 GuzcuZUIKt+ETtyqTACpEgt2OXdRW8Tm2pM0X19YL0mmm0jBg+Y62t8cM52R0L7RNL
	 vCDz4/eYUNj0JzA8DsE7mSVSQ2991hv30ge7I6BRXRMnvHHbdF0upG2ZgNwmy2mMny
	 KS+9pDiLEwciowQimws4avldG5ltiRoEbyPNCfYhS0LObqGjm/UIivQIxif70iBK+L
	 tNsbjMoQy+Hbg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:34 +0200
Subject: [PATCH RFC DRAFT 28/50] selftests/namespaces: tenth active
 reference count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-28-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I1mnXxN1C6AOW3tyeK+RAqokVAFrl2UVgQuyKj9qhRM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zX/2mvTcue3cXVBTLJN1vKmSa0Mou+f/y3+2rwm
 uKwJytiO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaylZeR4dW+c4qTz5UcCzp/
 4XbHupd/57XVP205Mb0tclntr41TLtxl+O+/4U/wEt7sYPc+1z+KL7OkIx+zd7R2/JGLs86xqvh
 6jRsA
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


