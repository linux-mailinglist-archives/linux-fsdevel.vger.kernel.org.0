Return-Path: <linux-fsdevel+bounces-65161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594E1BFD1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103431A61638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FE36CA73;
	Wed, 22 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKNbJVxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3598368F52;
	Wed, 22 Oct 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149342; cv=none; b=tebqyiKUSEDYAsAaQp93ruXgnqkq2TA2G9aaeK5PWmDGmSIaIRSbvPXd5+wilVyI8PRws2PyNTEzxmZ2Ua0ZIxyoUxrHLV3QhAsRHoRpPWLOuxBSNoSt+P9oXwlwpHNckss0HOwyEYMLPG6rkVNCzlGPwMSPbe3/08vhAhXk2D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149342; c=relaxed/simple;
	bh=fdHj1hsijB+BXri97N5cswYO4dlb02Ygb6q9aUmDKdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzYlGo4S2Nv0JhiECW7nZR4FcX2ye4rOsFovE7nPIY6gx3WOqu+i2my8j2JHXjGMFPN4UplHlPgzZ2EovgONe63D4Lwvb3mDFG5tTRzKe/9xlh8LjIhyc7k4mDKciSmken21h1A6GcYKhqqCyaXQ0k5PVCiRUjgTDUW6uezFdNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKNbJVxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27ABC113D0;
	Wed, 22 Oct 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149341;
	bh=fdHj1hsijB+BXri97N5cswYO4dlb02Ygb6q9aUmDKdA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IKNbJVxOWPHbZFlBVVwdlFPbO12K8GPtzoW+y/QvadKR9dYQNcttdp79eTyrrBrkN
	 FNKa6tOe0de7FAjW5tVi1sCBM53Fz2Q1LwQQ9sVBS3IvQF6lTMOYyZp43iO1JLpJbR
	 i0+el02Zzyo+D+ol/h17RCiq537uklBXTShHeRKesakTmaRJpuru/+bCWvGbtecGsi
	 ry0B76HfjUi7+jiLgPyEIqG0ojzmCyp67CRf76wAhUHeo99hYBQLjW8EtpIS0P22xt
	 gyU8+TT300/udIPp5/+f1IQ8hRjQ9UyEh0g+aV2vpknwgR7J/OLsxgfvunneA5Knh2
	 2qZ+tlzhwFHMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:11 +0200
Subject: [PATCH v2 33/63] selftests/namespaces: fourteenth active reference
 count tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-33-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fdHj1hsijB+BXri97N5cswYO4dlb02Ygb6q9aUmDKdA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHg2ue27W/vpvv06b7vUHQ7Z+tjPYjQ9rnz5Sevtn
 e8mcOSXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE8Dgjw6enjn2mqm2TfXQ6
 /i0/qWvqG3Y+58NkkUO1nK3fniRuE2dkOL1IeN00FdXq0JoE3f2RdxmmeXrZW65Tm9u4dO/bzdq
 +PAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that user namespace as a child also propagates correctly.
Create user_A -> user_B, verify when user_B is active that user_A
is also active. This is different from non-user namespace children.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/ns_active_ref_test.c      | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/namespaces/ns_active_ref_test.c b/tools/testing/selftests/namespaces/ns_active_ref_test.c
index 4c077223b05c..1eb4dc07e924 100644
--- a/tools/testing/selftests/namespaces/ns_active_ref_test.c
+++ b/tools/testing/selftests/namespaces/ns_active_ref_test.c
@@ -1914,4 +1914,142 @@ TEST(ns_parent_multiple_children_refcount)
 	}
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
+	if (WEXITSTATUS(status) != 0) {
+		close(ub_fd);
+		SKIP(return, "Child failed");
+	}
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
+	if (ua_fd >= 0) {
+		close(ua_fd);
+		TH_LOG("Warning: user_A still active");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


