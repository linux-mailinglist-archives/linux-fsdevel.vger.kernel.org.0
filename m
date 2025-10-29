Return-Path: <linux-fsdevel+bounces-66263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660DC1A657
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE8E14FE27E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19211384B9C;
	Wed, 29 Oct 2025 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOuKStk7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45234DB56;
	Wed, 29 Oct 2025 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740692; cv=none; b=gs0/aaO9OstY+gql+Bad+7ni6YQA7yIRwJhlEkWXmtip29w/IvFPb0o9ZY5ikL8FXNdcE/tWchIL4f4scdYBlb/dOaucHBnXwE2A2n9x7qvzAfIaPR7QJ0rFcBCrvnfGw7Yvd2BSpLGtm2E/yHzN8s8eGfOWG7dbwBiVQHd7szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740692; c=relaxed/simple;
	bh=BRZDSulpqgKAoYJKytoqb4ZSZJTwZJCYiydXZiVuqVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdyOuA9QGg99e1k+Ti0kOCyW05L8lkuDN/mYPF5vDHyw8ll2kE2f9Pju5pSoQd/sS+3EjQtsMi6KPUgYMOyEDm47rBsPwIBwVUqb5yAd4cOF5FhujDf5/5/pyYxYhkpjN0p8NWTbjNzYNPaYO9j5/vzfErGcqjguxaWrgFRBdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOuKStk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CFBC4CEF7;
	Wed, 29 Oct 2025 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740692;
	bh=BRZDSulpqgKAoYJKytoqb4ZSZJTwZJCYiydXZiVuqVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XOuKStk7kKPLL9uZUbud2tMiJHyFn4nl7d15b8cMhxHfw/PEBPsq1AZSWfTJJNvyd
	 jZh11CtelFV3LJjFp2YnT/Os5m9oTIu502/HVVSmx+iOmW8in+msd/PcRWkJYodwoH
	 fjrbrkvqjdrNxrodtrEix8ikmFNI+dlryrSHIcKu3OzGd6jaxKNEEeNhgftFJxKa1w
	 zP9rcC8WGMOPgzFwYhaVJITQVeY9b6TuaiC/OlzDOVcguv8JcG47TT7VQnP3kvV9PQ
	 kaOw1+sMrbL7f2rLFzQ+HxUDXjlcBPwRS3Str2MW5AvMcRVtvijdBdBPzIODoStZDU
	 XRDl43SwQcUvg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:03 +0100
Subject: [PATCH v4 50/72] selftests/namespaces: third listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-50-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4038; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BRZDSulpqgKAoYJKytoqb4ZSZJTwZJCYiydXZiVuqVY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVrhV/92LP6UkPJgg2ztqfNSZ1ac0Ky7L3mo3Xvc
 l9WGgcydpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk8zJGhh8XJn6uX76be22F
 kGlUaZDqkvtS4Wqf9zEXvHtWuTrQP4Xhv0PixTmbwn9ONFOKCXjclMYyT/PGcuUwLxe1p9NjWGJ
 e8gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that users cannot see namespaces from unrelated user namespaces.
Create two sibling user namespaces, verify they can't see each other's
owned namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index c99c87cca046..aed7288c7eca 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -228,4 +228,142 @@ TEST(listns_cap_sys_admin_in_userns)
 			count);
 }
 
+/*
+ * Test that users cannot see namespaces from unrelated user namespaces.
+ * Create two sibling user namespaces, verify they can't see each other's
+ * owned namespaces.
+ */
+TEST(listns_cannot_see_sibling_userns_namespaces)
+{
+	int pipefd[2];
+	pid_t pid1, pid2;
+	int status;
+	__u64 netns_a_id;
+	int pipefd2[2];
+	bool found_sibling_netns;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	/* Fork first child - creates user namespace A */
+	pid1 = fork();
+	ASSERT_GE(pid1, 0);
+
+	if (pid1 == 0) {
+		int fd;
+		__u64 netns_a_id;
+		char buf;
+
+		close(pipefd[0]);
+
+		/* Create user namespace A */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Create network namespace owned by user namespace A */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get network namespace ID */
+		fd = open("/proc/self/ns/net", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &netns_a_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send namespace ID to parent */
+		write(pipefd[1], &netns_a_id, sizeof(netns_a_id));
+
+		/* Keep alive for sibling to check */
+		read(pipefd[1], &buf, 1);
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent reads namespace A ID */
+	close(pipefd[1]);
+	netns_a_id = 0;
+	read(pipefd[0], &netns_a_id, sizeof(netns_a_id));
+
+	TH_LOG("User namespace A created network namespace with ID %llu",
+	       (unsigned long long)netns_a_id);
+
+	/* Fork second child - creates user namespace B */
+	ASSERT_EQ(pipe(pipefd2), 0);
+
+	pid2 = fork();
+	ASSERT_GE(pid2, 0);
+
+	if (pid2 == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = CLONE_NEWNET,
+			.spare2 = 0,
+			.user_ns_id = 0,
+		};
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool found_sibling_netns;
+
+		close(pipefd[0]);
+		close(pipefd2[0]);
+
+		/* Create user namespace B (sibling to A) */
+		if (setup_userns() < 0) {
+			close(pipefd2[1]);
+			exit(1);
+		}
+
+		/* Try to list all network namespaces */
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		found_sibling_netns = false;
+		if (ret > 0) {
+			for (ssize_t i = 0; i < ret; i++) {
+				if (ns_ids[i] == netns_a_id) {
+					found_sibling_netns = true;
+					break;
+				}
+			}
+		}
+
+		/* We should NOT see the sibling's network namespace */
+		write(pipefd2[1], &found_sibling_netns, sizeof(found_sibling_netns));
+		close(pipefd2[1]);
+		exit(0);
+	}
+
+	/* Parent reads result from second child */
+	close(pipefd2[1]);
+	found_sibling_netns = false;
+	read(pipefd2[0], &found_sibling_netns, sizeof(found_sibling_netns));
+	close(pipefd2[0]);
+
+	/* Signal first child to exit */
+	close(pipefd[0]);
+
+	/* Wait for both children */
+	waitpid(pid2, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	waitpid(pid1, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	/* Second child should NOT have seen first child's namespace */
+	ASSERT_FALSE(found_sibling_netns);
+	TH_LOG("User namespace B correctly could not see sibling namespace A's network namespace");
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


