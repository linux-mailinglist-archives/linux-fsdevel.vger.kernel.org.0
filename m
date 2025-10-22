Return-Path: <linux-fsdevel+bounces-65176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE8EBFD293
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57BCD357C6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE403596EF;
	Wed, 22 Oct 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIHwQsrK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7C27CB04;
	Wed, 22 Oct 2025 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149421; cv=none; b=a7gyqx8nmuD4KFHM9EjUivAqR/yaES4MziwHXLLJIDmjH1GOMOsUNoi97hMB0Bc50sI2P0PGdIMLWUi7DuXYXpFMggelERXgKwcDv83nIvTiMboFs0yJhAJfZeqmZntAMViGIBOgL/W/GTGnoW3ZlUPgMj/VpJyNgE8e6FvvIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149421; c=relaxed/simple;
	bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUXoNrasFmnxPTH2V5OukdZiSG0vqVMmsMkkzbsbhV84FfBlQGCQTNcjyGF6uu6XpvvvYotOC94hwlbR0cbXWjjLGWulPC7up63ruDsVrp+4h3ZS5IFHp+PWykRLakLNkGnL/6VrzgT2eY+pJBmC4xDlea5W7kLmrzjnt1ZJaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIHwQsrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B943C4CEE7;
	Wed, 22 Oct 2025 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149421;
	bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PIHwQsrKY+HJJMKbr8/FAAHVsbomjOxoIqYyM+FJtfAkCbMKTWZosaJzWIvDDlb2o
	 qDj6ac7hJRSxYPfCWrj3yI2QVxS+iCF/cebVtVLQYiDXwDR2w+vg1g/Up58fGhFu9q
	 oAKYPWGKQ8BXBjrJXz5NCfiEMbkZhvMYkwVQvwTfCIFnhuSOYOWObSM0VYvg9XFlh4
	 2IQCkkPtU2IyPee1otUawM30CGYKKzp7pbeF3NzT8oHdeJsb6BygMPtoHwGA3drNyU
	 +vhf2se+8Zw9EW6Cf7zb7ZF7CeRqANLuvtLrEXJqka29SN6O2F36GJQz29XTtxZYTu
	 jKqsODHOmSD9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:26 +0200
Subject: [PATCH v2 48/63] selftests/namespaces: fourth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-48-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+NPTtaVGIJjtOfL6a6/pXZ3Jnd+MAnJdtzTqZX7/Ujw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHguZH1/7QV9yUPzG4ud0w8VnfpXfOrROs/kTxPT2
 JJ1J86t7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIRA8jw+/sGh6h8obpnc/5
 p2j9F5/q3yT3UDChwLBmyq2w9Mo5BYwM51JtzEz7lnXPfaTxZmWDzyrjG/bW7ztrC/rK9+xuVN/
 KBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test permission checking with LISTNS_CURRENT_USER.
Verify that listing with LISTNS_CURRENT_USER respects permissions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 4e47b4c82c56..ff42109779ca 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -372,4 +372,83 @@ TEST(listns_cannot_see_sibling_userns_namespaces)
 	TH_LOG("User namespace B correctly could not see sibling namespace A's network namespace");
 }
 
+/*
+ * Test permission checking with LISTNS_CURRENT_USER.
+ * Verify that listing with LISTNS_CURRENT_USER respects permissions.
+ */
+TEST(listns_current_user_permissions)
+{
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool success;
+	ssize_t count;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = 0,
+			.spare2 = 0,
+			.user_ns_id = LISTNS_CURRENT_USER,
+		};
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool success;
+
+		close(pipefd[0]);
+
+		/* Create user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Create some namespaces owned by this user namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (unshare(CLONE_NEWUTS) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* List with LISTNS_CURRENT_USER - should see our owned namespaces */
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		success = (ret >= 3);  /* At least user, net, uts */
+		write(pipefd[1], &success, sizeof(success));
+		write(pipefd[1], &ret, sizeof(ret));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	success = false;
+	count = 0;
+	read(pipefd[0], &success, sizeof(success));
+	read(pipefd[0], &count, sizeof(count));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespaces");
+	}
+
+	ASSERT_TRUE(success);
+	TH_LOG("LISTNS_CURRENT_USER returned %zd namespaces", count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


