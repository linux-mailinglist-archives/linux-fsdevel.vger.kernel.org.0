Return-Path: <linux-fsdevel+bounces-64896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C6BF6502
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82264540EDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FBD34FF74;
	Tue, 21 Oct 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0iTTYSh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84934FF5C;
	Tue, 21 Oct 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047267; cv=none; b=PSbw+9i6MqFkyiI4ugkuexhXGKk6TlecvtlSY/TAjH6bGWST12tumXl4Bdl0GpRrZb6xMbIB8kxr17IGu7S/aashGm9EoPcGEBG1fdNby9IBcDknhwC0joNHvXgxtAx7/FuCHybJKy7icIrCyTbahNUjpa0qN5/wxTToQFZSJiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047267; c=relaxed/simple;
	bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k3zgSrvkuNCZpwNVf90s5zlV/JFDMNGTCdKJa/u47wgWAGB7ABCM5ygymH7oCSKlhI1I9T89G8AW44kjGwYxp6e9pB/2ZhQ+gmJBfOenvS4rvOA2Xk2BmmkfDKOaYofhKiHhlVwAyBi+nPkqcl3CK4f5hDETHwEgX2OHwJE24lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0iTTYSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93748C4CEF1;
	Tue, 21 Oct 2025 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047266;
	bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D0iTTYShynUcHJSlJo+hUZiJHvzKhIqr9uML4BkcQpFI/uP9vzrFYGTgaEE3r0Zfp
	 UDJ+pfAh52rKiBaow0nzJipcsuv+QRepKibuZSS9DA/BCU6gXmy25lmJu43WKFF40x
	 0Pl/W5+QVImeq5QGVnag0iYf6MCYia/I9VGbXTvs0MRKXZJlSuBZ6VRF7DA0REbt1m
	 hK0MDD1EQwISwU013CCJLsQfBcUEcXDz79zOoEWajCbGCwofacTi26mzY8QMopxyw3
	 +mJ9mE2dZh0tioz+bd3fnG9//Yo9QVZM4sqwf/T4MLiMo21+m/ERC9nQwCCvUsahag
	 bPLU1cV3akr3w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:51 +0200
Subject: [PATCH RFC DRAFT 45/50] selftests/namespaces: second listns()
 permission test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-45-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rZyevUn6hfyhcE1DB3cv3yJAhND3Rlxt9xlbt7Q4T1s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zfoxP8bZXScga5dHPjr/8r5rSJdcRHMm/MMBM7f
 rRSb0lZRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESmZTL89799Lfyzgnb0qukx
 LPq8Snuunnd/b+jx9CKvuMFPy97FRowM11dqJ3RfrXcTUD02vbOgwEZzu0ZF5iXb1j1rfI2FQ45
 xAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that users with CAP_SYS_ADMIN in a user namespace can see
all namespaces owned by that user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 87ec71560d99..803c42fc76ec 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -131,4 +131,107 @@ TEST(listns_unprivileged_current_only)
 			unexpected_count);
 }
 
+/*
+ * Test that users with CAP_SYS_ADMIN in a user namespace can see
+ * all namespaces owned by that user namespace.
+ */
+TEST(listns_cap_sys_admin_in_userns)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,  /* All types */
+		.spare2 = 0,
+		.user_ns_id = 0,  /* Will be set to our created user namespace */
+	};
+	__u64 ns_ids[100];
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
+		int fd;
+		__u64 userns_id;
+		ssize_t ret;
+		int min_expected;
+		bool success;
+
+		close(pipefd[0]);
+
+		/* Create user namespace - we'll have CAP_SYS_ADMIN in it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get the user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create several namespaces owned by this user namespace */
+		unshare(CLONE_NEWNET);
+		unshare(CLONE_NEWUTS);
+		unshare(CLONE_NEWIPC);
+
+		/* List namespaces owned by our user namespace */
+		req.user_ns_id = userns_id;
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+		if (ret < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/*
+		 * We have CAP_SYS_ADMIN in this user namespace,
+		 * so we should see all namespaces owned by it.
+		 * That includes: net, uts, ipc, and the user namespace itself.
+		 */
+		min_expected = 4;
+		success = (ret >= min_expected);
+
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
+	TH_LOG("User with CAP_SYS_ADMIN saw %zd namespaces owned by their user namespace",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


