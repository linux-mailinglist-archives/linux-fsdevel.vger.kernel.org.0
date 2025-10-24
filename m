Return-Path: <linux-fsdevel+bounces-65474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1017EC05D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4115507952
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC0C346798;
	Fri, 24 Oct 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYeVc1t8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC2314B69;
	Fri, 24 Oct 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303353; cv=none; b=V4HO5DZ+n23cNx53CKK14CvwkseNtpdBUkKkzFNAD7Pbojlc8Td1ceChmNunlx9N385SSU/HeKH8hZKH695jtCum2IQpzuOqPqq5+OedDerz//0ALmJGqAmoNtBHJ9uCV2AB8WqlAibsotYpEUbtW1+/t3dhbf2wg11cExW11+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303353; c=relaxed/simple;
	bh=d+4+UcmFmPg23QL+eCNaKFnhnQg3HsdsjL7eCoiFS0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tDav80fsLjrztPncKyGgtJSdpEyg+9sdal8nwaaUxi/Z6SPvBzqzATAeIJC/bDrFAFlJODQqb+cifMHRJ4JldcacfZ37gncMDEJ3Y7BiZ+F1rwx/AxltM9aTee3BjP7o7sdeGA5AA56rT0aKiTQs3p2VUH0zzZEpzwPheIOyqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYeVc1t8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868C6C113D0;
	Fri, 24 Oct 2025 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303353;
	bh=d+4+UcmFmPg23QL+eCNaKFnhnQg3HsdsjL7eCoiFS0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tYeVc1t8XciAXWQSkpEGfscl2mNHN6Z7RBC//4cbLhMmOJxzUjY5RBkFuQ5ea6boE
	 5tdFSgUsmvBSwfv7UaNS/CkyKHPJ6mGQ9lJUZ3KoMXV8tNjrbLB0UcGZy9Jm1Mbm11
	 oG2pkDOwYYqAocJHrHeDw0PINBf78WxhyoJQ5NW9OjkcaLzPCpkIyfPJM849TgDnR4
	 y6hpzVtI9jIktcy9v3AUuG5ipA2gZ/PPJRHQCz1BUeDS2o5ZbEwt6zZBwMPY2z8JDR
	 E0bJuOkrfrCUif8gnNNJN/x9DKUVE+Akggcv3dE5poXWFRASFxs51H6Z4cHR47aERZ
	 A+S5Fg747hUHg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:03 +0200
Subject: [PATCH v3 34/70] selftests/namespaces: fourteenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-34-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4427; i=brauner@kernel.org;
 h=from:subject:message-id; bh=d+4+UcmFmPg23QL+eCNaKFnhnQg3HsdsjL7eCoiFS0k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpL7V/kILbP6bnHhEkbxDnz+fdZ92btv6nqd05vV
 +s/kXPvOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayQY+RYYN55PKoa6bxsyuu
 nbTt/Z1r/jzodYyzxepkm6MOikfsHRj+h5cJXWh2Wr5Tm/3wTply9TSuWQ8eLO4ue31meeAW21d
 2PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that user namespace as a child also propagates correctly.
Create user_A -> user_B, verify when user_B is active that user_A
is also active. This is different from non-user namespace children.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 25f06e623064..430702c041a9 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1817,4 +1817,136 @@ TEST(ns_parent_multiple_children_refcount)
 	ASSERT_LT(p_fd, 0);
 }
 
+/*
+ * Test that user namespace as a child also propagates correctly.
+ * Create user_A -> user_B, verify when user_B is active that user_A
+ * is also active. This is different from non-user namespace children.
+ */
+TEST(ns_userns_child_propagation)
+{
+	struct file_handle *ua_handle, *ub_handle;
+	int ret, pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 ua_id, ub_id;
+	char ua_buf[sizeof(*ua_handle) + MAX_HANDLE_SZ];
+	char ub_buf[sizeof(*ub_handle) + MAX_HANDLE_SZ];
+
+	ASSERT_EQ(pipe(pipefd), 0);
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+
+		/* Create user_A */
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
+		/* Create user_B (child of user_A) */
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
+		/* Send both namespace IDs */
+		write(pipefd[1], &ua_id, sizeof(ua_id));
+		write(pipefd[1], &ub_id, sizeof(ub_id));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	close(pipefd[1]);
+
+	/* Read both namespace IDs - fixed size, no parsing needed */
+	ret = read(pipefd[0], &ua_id, sizeof(ua_id));
+	if (ret != sizeof(ua_id)) {
+		close(pipefd[0]);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user_A namespace ID");
+	}
+
+	ret = read(pipefd[0], &ub_id, sizeof(ub_id));
+	close(pipefd[0]);
+	if (ret != sizeof(ub_id)) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to read user_B namespace ID");
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
+	/* Open user_B before child exits */
+	int ub_fd = open_by_handle_at(FD_NSFS_ROOT, ub_handle, O_RDONLY);
+	if (ub_fd < 0) {
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to open user_B");
+	}
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	/* With user_B active, user_A should also be active */
+	TH_LOG("Testing user_A active when child user_B is active");
+	int ua_fd = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	ASSERT_GE(ua_fd, 0);
+
+	/* Close user_B */
+	TH_LOG("Closing user_B");
+	close(ub_fd);
+
+	/* user_A should remain active (we hold direct ref) */
+	int ua_fd2 = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	ASSERT_GE(ua_fd2, 0);
+	close(ua_fd2);
+
+	/* Close user_A - should become inactive */
+	TH_LOG("Closing user_A - should become inactive");
+	close(ua_fd);
+
+	ua_fd = open_by_handle_at(FD_NSFS_ROOT, ua_handle, O_RDONLY);
+	ASSERT_LT(ua_fd, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


