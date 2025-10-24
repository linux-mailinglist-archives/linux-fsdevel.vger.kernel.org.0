Return-Path: <linux-fsdevel+bounces-65490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA6C05E21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F45C3A4C61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F313570B5;
	Fri, 24 Oct 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuawUr7K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B4315D5F;
	Fri, 24 Oct 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303434; cv=none; b=QvOabAUZqP7OpQ+/PcmTc8uPJzJQfmifp6bNtsGIHIPytkdmAEjKspJ0CsFdJocCFdnOGYs5tDT2Ufr3gwsZ/w3homzmAA9BlN8LvSlAi8inCYB7wKdWFm55+k3ur+37gB2yDCL8JWgIn5qjemDftJ12/YUWuD3q7CnBz3RjmhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303434; c=relaxed/simple;
	bh=2cIPwZqTW4MWIZYsYx6FhB5M6WCZGsZgp86akiGTfiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhqE6nzoUpqYnPkQ27FwuY1QYfOX0CmRHTb9o4ynW4/Zb08YjkVyWbXAYt69nHvtD5nYKFzaL0wxGheK/vJ7c/kFVV7Oody/sQYO8DOC/Xa1yvcrYerS8BEuUELASKLolQ8Tp7O8Jz/sImjlYs7R5ZT8mexADP37Xuz2xETp2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuawUr7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BA6C113D0;
	Fri, 24 Oct 2025 10:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303434;
	bh=2cIPwZqTW4MWIZYsYx6FhB5M6WCZGsZgp86akiGTfiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JuawUr7K8ktut6eWXmAuBdE3hkBdUxsW4sEInCknZW7mlFej4Z3g//UvORgsQaVP1
	 FmcMBP9T4mede1HNQ0TY/pcNVUZQ95r2v0g8FfSSojQkRwWi69EcnCUGYKV6EFKSE6
	 gsUFr2YczhlhvvMi5NU2j1oiPzX5jPdSPUvn/OVBrFLWSYcI/X2XyYk+NEOMOS6gK+
	 az27IEHbabwQ+qAMkeUFhCAlxEMfU5KWiNcpm77D9W9N6oICp47hpeuRmx2pKa3Yym
	 9ID0qAluhCBOAxVzAzgccELXFhOM7p5KrxZD7G114IYOyZ4O4TyJaliY7X3p6aWjiC
	 vON4sSkCkEKSA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:19 +0200
Subject: [PATCH v3 50/70] selftests/namespaces: fifth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-50-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2cIPwZqTW4MWIZYsYx6FhB5M6WCZGsZgp86akiGTfiE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmp/uufOryq9U8u5F7aeL3u1LNps2sk17P/dS63NJ
 BeebWNK7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIhz6Gf2arf72qsayf5sz6
 wjGgZq1Iw2k2rcvvPUzKJybO9X108BQjw+TNC3f5xB7dFjv7TT2HzpWfTxX+WR2TNC6JYP6j+Y/
 FlgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that CAP_SYS_ADMIN in parent user namespace allows seeing
child user namespace's owned namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 7727c5964104..b990b785dd7f 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -442,4 +442,123 @@ TEST(listns_current_user_permissions)
 	TH_LOG("LISTNS_CURRENT_USER returned %zd namespaces", count);
 }
 
+/*
+ * Test that CAP_SYS_ADMIN in parent user namespace allows seeing
+ * child user namespace's owned namespaces.
+ */
+TEST(listns_parent_userns_cap_sys_admin)
+{
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool found_child_userns;
+	ssize_t count;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 parent_userns_id;
+		__u64 child_userns_id;
+		struct ns_id_req req;
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool found_child_userns;
+
+		close(pipefd[0]);
+
+		/* Create parent user namespace - we have CAP_SYS_ADMIN in it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get parent user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &parent_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create child user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get child user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create namespaces owned by child user namespace */
+		if (unshare(CLONE_NEWNET) < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* List namespaces owned by parent user namespace */
+		req.size = sizeof(req);
+		req.spare = 0;
+		req.ns_id = 0;
+		req.ns_type = 0;
+		req.spare2 = 0;
+		req.user_ns_id = parent_userns_id;
+
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		/* Should see child user namespace in the list */
+		found_child_userns = false;
+		if (ret > 0) {
+			for (ssize_t i = 0; i < ret; i++) {
+				if (ns_ids[i] == child_userns_id) {
+					found_child_userns = true;
+					break;
+				}
+			}
+		}
+
+		write(pipefd[1], &found_child_userns, sizeof(found_child_userns));
+		write(pipefd[1], &ret, sizeof(ret));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	found_child_userns = false;
+	count = 0;
+	read(pipefd[0], &found_child_userns, sizeof(found_child_userns));
+	read(pipefd[0], &count, sizeof(count));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(found_child_userns);
+	TH_LOG("Process with CAP_SYS_ADMIN in parent user namespace saw child user namespace (total: %zd)",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


