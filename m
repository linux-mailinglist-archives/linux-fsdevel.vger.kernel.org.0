Return-Path: <linux-fsdevel+bounces-66242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E28C1A49E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE49C562D65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95E135BDB3;
	Wed, 29 Oct 2025 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/wt+3Xx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446AA35A94E;
	Wed, 29 Oct 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740588; cv=none; b=BRYhslenyReItlgI1d4ni7u1yYw0chr3dFzLql9ZG0KQYzk6RAP1kadTrjr1MWtu9QTmgUUuyKmIL1AWUcCDns8yUO/uXMb45AuytJ+uD3nishTgs+5espTdn+/vDdXwgEm4qFtJPiR4fUA+8mFkguArbuP+jxyiQS6WhvAlB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740588; c=relaxed/simple;
	bh=uKR7z2WD/2U9Ks1GPvzLGsI7e1WaqtgCdzzqT45jKts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dqu7b+xv3nHSG7YKInFe4WUIdA1T6Dvxw4qb8dELVhL23npXPuMSB1hmMZVMB4irPm+6NPUqdXjyVH+4gwK+J+hU5tUmFbL98LWEyMuHPLDe+SNSjHXNBj14SfY827ga1Z2fbZ0RP2Alhj+PQtI+ofVaJhwlz+50bvCz/5nK49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/wt+3Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D07C4CEFD;
	Wed, 29 Oct 2025 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740585;
	bh=uKR7z2WD/2U9Ks1GPvzLGsI7e1WaqtgCdzzqT45jKts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l/wt+3XxcPN0Qb2GeG9QKhX3QefpUntgythHBpihFr0LD8U8ZmSTCHgISnXYaR52+
	 V0uD75YQvNWahLKZTNfp+S1Iw26P8u54Bq7U1Sunyvx+PaJBo7v4WDGQAJGYc1K1ef
	 FW13XVLCI8VOodVXNcfd+hfhMUYDuBD3xIsfR5EAHibgnN3ZpcqT+CfVz+V7oP6y9W
	 SFfLDG0mYb5Lqy2NTl/j7X9EiM618mpDQ3zM4K7Y3/TNH2N2BG6YVDrSxxJxKpX+TH
	 FYMv5HqFXUQ0h33VcmunDy3Oy7GOsCq9sMwEi2TjA+j0hdHONFmlm53w3oKGqGtEwS
	 lDmN2oRVDOQqg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:42 +0100
Subject: [PATCH v4 29/72] selftests/namespaces: seventh active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-29-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8847; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uKR7z2WD/2U9Ks1GPvzLGsI7e1WaqtgCdzzqT45jKts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfU+YAoRjlHrXHz7+YV2s9evjTvdV2h8yurZ1BEom
 PHRaYtGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET2LmVkOPCs9p8jg7u6ZKZC
 WfQzFWfOqZKP072SCgr3zdvOte3/HYb/OVbb7qvlXP//seJyg9F/5x1qFc4LZOrXt21X/3Gvz4S
 LEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test hierarchical active reference propagation.
When a child namespace is active, its owning user namespace should also
be active automatically due to hierarchical active reference propagation.
This ensures parents are always reachable when children are active.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 222 +++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 50653096fcb6..60876965dd71 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -20,6 +20,10 @@
 #define FD_NSFS_ROOT -10003 /* Root of the nsfs filesystem */
 #endif
 
+#ifndef FILEID_NSFS
+#define FILEID_NSFS 0xf1
+#endif
+
 /*
  * Test that initial namespaces can be reopened via file handle.
  * Initial namespaces should have active ref count of 1 from boot.
@@ -603,4 +607,222 @@ TEST(ns_fd_keeps_active)
 	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
 }
 
+/*
+ * Test hierarchical active reference propagation.
+ * When a child namespace is active, its owning user namespace should also
+ * be active automatically due to hierarchical active reference propagation.
+ * This ensures parents are always reachable when children are active.
+ */
+TEST(ns_parent_always_reachable)
+{
+	struct file_handle *parent_handle, *child_handle;
+	int ret;
+	int child_nsfd;
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 parent_id, child_id;
+	char parent_buf[sizeof(*parent_handle) + MAX_HANDLE_SZ];
+	char child_buf[sizeof(*child_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* Child process */
+		close(pipefd[0]);
+
+		TH_LOG("Child: creating parent user namespace and setting up mappings");
+
+		/* Create parent user namespace with mappings */
+		ret = setup_userns();
+		if (ret < 0) {
+			TH_LOG("Child: setup_userns() for parent failed: %s", strerror(errno));
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		TH_LOG("Child: parent user namespace created, now uid=%d gid=%d", getuid(), getgid());
+
+		/* Get namespace ID for parent user namespace */
+		int parent_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (parent_fd < 0) {
+			TH_LOG("Child: failed to open parent /proc/self/ns/user: %s", strerror(errno));
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		TH_LOG("Child: opened parent userns fd %d", parent_fd);
+
+		if (ioctl(parent_fd, NS_GET_ID, &parent_id) < 0) {
+			TH_LOG("Child: NS_GET_ID for parent failed: %s", strerror(errno));
+			close(parent_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(parent_fd);
+
+		TH_LOG("Child: got parent namespace ID %llu", (unsigned long long)parent_id);
+
+		/* Create child user namespace within parent */
+		TH_LOG("Child: creating nested child user namespace");
+		ret = setup_userns();
+		if (ret < 0) {
+			TH_LOG("Child: setup_userns() for child failed: %s", strerror(errno));
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		TH_LOG("Child: nested child user namespace created, uid=%d gid=%d", getuid(), getgid());
+
+		/* Get namespace ID for child user namespace */
+		int child_fd = open("/proc/self/ns/user", O_RDONLY);
+		if (child_fd < 0) {
+			TH_LOG("Child: failed to open child /proc/self/ns/user: %s", strerror(errno));
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		TH_LOG("Child: opened child userns fd %d", child_fd);
+
+		if (ioctl(child_fd, NS_GET_ID, &child_id) < 0) {
+			TH_LOG("Child: NS_GET_ID for child failed: %s", strerror(errno));
+			close(child_fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(child_fd);
+
+		TH_LOG("Child: got child namespace ID %llu", (unsigned long long)child_id);
+
+		/* Send both namespace IDs to parent */
+		TH_LOG("Child: sending both namespace IDs to parent");
+		write(pipefd[1], &parent_id, sizeof(parent_id));
+		write(pipefd[1], &child_id, sizeof(child_id));
+		close(pipefd[1]);
+
+		TH_LOG("Child: exiting - parent userns should become inactive");
+		/* Exit - parent user namespace should become inactive */
+		exit(0);
+	}
+
+	/* Parent process */
+	close(pipefd[1]);
+
+	TH_LOG("Parent: reading both namespace IDs from child");
+
+	/* Read both namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &parent_id, sizeof(parent_id));
+	if (ret != sizeof(parent_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read parent namespace ID from child");
+	}
+
+	ret = read(pipefd[0], &child_id, sizeof(child_id));
+	close(pipefd[0]);
+	if (ret != sizeof(child_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read child namespace ID from child");
+	}
+
+	TH_LOG("Parent: received parent_id=%llu, child_id=%llu",
+	       (unsigned long long)parent_id, (unsigned long long)child_id);
+
+	/* Construct file handles from namespace IDs */
+	parent_handle = (struct file_handle *)parent_buf;
+	parent_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	parent_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *parent_fh = (struct nsfs_file_handle *)parent_handle->f_handle;
+	parent_fh->ns_id = parent_id;
+	parent_fh->ns_type = 0;
+	parent_fh->ns_inum = 0;
+
+	child_handle = (struct file_handle *)child_buf;
+	child_handle->handle_bytes = sizeof(struct nsfs_file_handle);
+	child_handle->handle_type = FILEID_NSFS;
+	struct nsfs_file_handle *child_fh = (struct nsfs_file_handle *)child_handle->f_handle;
+	child_fh->ns_id = child_id;
+	child_fh->ns_type = 0;
+	child_fh->ns_inum = 0;
+
+	TH_LOG("Parent: opening child namespace BEFORE child exits");
+
+	/* Open child namespace while child is still alive to keep it active */
+	child_nsfd = open_by_handle_at(FD_NSFS_ROOT, child_handle, O_RDONLY);
+	if (child_nsfd < 0) {
+		TH_LOG("Failed to open child namespace: %s (errno=%d)", strerror(errno), errno);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open child namespace");
+	}
+
+	TH_LOG("Opened child namespace fd %d", child_nsfd);
+
+	/* Now wait for child to exit */
+	TH_LOG("Parent: waiting for child to exit");
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	TH_LOG("Child process exited, parent holds fd to child namespace");
+
+	/*
+	 * With hierarchical active reference propagation:
+	 * Since the child namespace is active (parent process holds fd),
+	 * the parent user namespace should ALSO be active automatically.
+	 * This is because when we took an active reference on the child,
+	 * it propagated up to the owning user namespace.
+	 */
+	TH_LOG("Attempting to reopen parent namespace (should SUCCEED - hierarchical propagation)");
+	int parent_fd = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	ASSERT_GE(parent_fd, 0);
+
+	TH_LOG("SUCCESS: Parent namespace is active (fd=%d) due to active child", parent_fd);
+
+	/* Verify we can also get parent via NS_GET_USERNS */
+	TH_LOG("Verifying NS_GET_USERNS also works");
+	int parent_fd2 = ioctl(child_nsfd, NS_GET_USERNS);
+	if (parent_fd2 < 0) {
+		close(parent_fd);
+		close(child_nsfd);
+		TH_LOG("NS_GET_USERNS failed: %s (errno=%d)", strerror(errno), errno);
+		SKIP(return, "NS_GET_USERNS not supported or failed");
+	}
+
+	TH_LOG("NS_GET_USERNS succeeded, got parent fd %d", parent_fd2);
+
+	/* Verify both methods give us the same namespace */
+	struct stat st1, st2;
+	ASSERT_EQ(fstat(parent_fd, &st1), 0);
+	ASSERT_EQ(fstat(parent_fd2, &st2), 0);
+	TH_LOG("Parent namespace inodes: parent_fd=%lu, parent_fd2=%lu", st1.st_ino, st2.st_ino);
+	ASSERT_EQ(st1.st_ino, st2.st_ino);
+
+	/*
+	 * Close child fd - parent should remain active because we still
+	 * hold direct references to it (parent_fd and parent_fd2).
+	 */
+	TH_LOG("Closing child fd - parent should remain active (direct refs held)");
+	close(child_nsfd);
+
+	/* Parent should still be openable */
+	TH_LOG("Verifying parent still active via file handle");
+	int parent_fd3 = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	ASSERT_GE(parent_fd3, 0);
+	close(parent_fd3);
+
+	TH_LOG("Closing all fds to parent namespace");
+	close(parent_fd);
+	close(parent_fd2);
+
+	/* Both should now be inactive */
+	TH_LOG("Attempting to reopen parent (should fail - inactive, no refs)");
+	parent_fd = open_by_handle_at(FD_NSFS_ROOT, parent_handle, O_RDONLY);
+	ASSERT_LT(parent_fd, 0);
+	TH_LOG("Parent inactive as expected: %s (errno=%d)", strerror(errno), errno);
+	ASSERT_TRUE(errno == ENOENT || errno == ESTALE);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


