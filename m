Return-Path: <linux-fsdevel+bounces-66264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B47C1A7E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37C2580FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91B393DD6;
	Wed, 29 Oct 2025 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqBjq4kq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6D3855B0;
	Wed, 29 Oct 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740698; cv=none; b=Eg3RvJ5CF2q/z6KJugFdsDCYwT+6a0J09q7Pj4BYThr/7A2RnOFrCDRGx6omM6fnpi4TSCgpQW4ypM/l3yeINan/0KJ9pDRhg+VRVA7m6VFFv5YWy4jWoLHpT7EPDQ9+rHPKKzeHita+iyM7e4mDF1E/VY5Q/cp/5Zn5UjuSXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740698; c=relaxed/simple;
	bh=2cVn/rLMAtz+rjww4mseoVKumw7c91HQOHzmtSbA+4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JEA5ybWP6aMGLKiyLWijvQpBSaqmDrzJ+uSALXT4+NsAo/XwNu6Ch7R/pcT5HvD4radrO3fLYN7LbBf6U6hY/L7igP4gA6+cp+t5Zx+x7tZyV6M3i2wpdOsEpRpTIc6ZIxed8Lr8eNIp5FzMzlmZ2wc+hS9etPJA2jgt6niqmpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqBjq4kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FEEC4CEFD;
	Wed, 29 Oct 2025 12:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740697;
	bh=2cVn/rLMAtz+rjww4mseoVKumw7c91HQOHzmtSbA+4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GqBjq4kqMnZ46w1uTSS6/DWln99+3lMSBB+pQC3+FReZ12KIIRnOkh0i0qcFhun/S
	 87ER+Pc066q4kVfmNeRk7nNLMq4Q8Fzq8nBQtBRrUNP9+bu3DQyEXg9xOwNLGRT+5S
	 5tlmCcP+YkK4OojvDuDfsh5CBbm6pNCLUqFcIDleMJ8BKgKEYaF9yyXomaJNemxOtb
	 kLX4Nmn/aKvUBZPKVG06OYSaKnR2lKPoxLTugzBySkkL5X6Q00hUhwZVQcsnEQ1eTD
	 w8Mc1MyXbmVS66Q8jZ8flJm6aU2cG9vXgwvxROBM7nNsppBL7PkrVpp86giiQRR9cz
	 xYn/XBjZhhI+g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:04 +0100
Subject: [PATCH v4 51/72] selftests/namespaces: fourth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-51-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2cVn/rLMAtz+rjww4mseoVKumw7c91HQOHzmtSbA+4Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfULaHp/zjNV7N+kcE6/2/Gviq3+cs7pk16IMy7au
 KrwYnBMRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER2SzAy/OQsunEyZbdMlv77
 F1sCp1ed33Z++kzfkwr8Tjsvb53xbAEjwznOaIXd9Xuj2c4E565/dNHlWX9I0RzJFdx5T5ZPOPl
 6Jy8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test permission checking with LISTNS_CURRENT_USER.
Verify that listing with LISTNS_CURRENT_USER respects permissions.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index aed7288c7eca..7727c5964104 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -366,4 +366,80 @@ TEST(listns_cannot_see_sibling_userns_namespaces)
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
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(success);
+	TH_LOG("LISTNS_CURRENT_USER returned %zd namespaces", count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


