Return-Path: <linux-fsdevel+bounces-66262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139EC1A651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC045662C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF60B384B82;
	Wed, 29 Oct 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2XEC0WU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBEF34DB56;
	Wed, 29 Oct 2025 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740688; cv=none; b=bTKuRtyK0/XvN0Ib2RxObouFNOfdM3zRYbn9/Rou0gVxqfPz4lrJOnuXYNfqoFx0D2e+FEC9FdALs7iTzS3oYohLXotHkS71xAjYLe4EN1BjddEiCuYq7pdM0c5iy9MlY1usWNseDA8DQvrW5WnHnj1Mvzd2zmeTIl6Ewa4STVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740688; c=relaxed/simple;
	bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDZwCjTCqBL9B05nH+2idmLfMUTX0Mk4ejbjpnjkxNag+0IoWjeq93RXJJ8Gi1NnbGlw4pRdmq0e8T+oKLvk+ahylOK0Oz5U43WBufpRSklPl7KMs0+MReoxHDiTEy2HDKFp2oKb+K0dPS6u9GVvq7eXe3ipmZK60ZZ+MAUKq+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2XEC0WU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BE0C4CEFD;
	Wed, 29 Oct 2025 12:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740686;
	bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W2XEC0WUW0T2gpEPCOB1YPGwINSIVf4JdFGAw+YafN8uuVNoAbPwcREVBIkhHY0nq
	 nsZaPIcD+cV2wjlAgBml0U0eLYsNAH3lQ1J0I28nZs/VmP/WSa9wO+dxglFSdb02uv
	 813+KNiPkue8i2VnL705uy3aQjkZvu7SrS7ECGVd6JH1FxSuzw2HF9yWjAQELiesX9
	 vdmMRMnT2gHI2pPWPPYv/+wfLwc4fZATcVHlgcCAHnsjWKyuMZaNSEYWvc6y0aDir0
	 yPUIPQX0sINVP9EhepVWip1hEYNlMGZA58xvfU4WKGi0voeESxq9XxS5FghQAH1OiV
	 aQVY1AGmLZsRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:02 +0100
Subject: [PATCH v4 49/72] selftests/namespaces: second listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-49-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/wqqJQoHPy6n2tHb+24Li+Lu21E+HeJSWgV7yWDzDrk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfV/3ThdjWOmxdaW/sPGs1SkDSSNlz/NNrq15ZuAW
 OnSttXSHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZWsrIsPqJ3PRli5g07vwq
 Ou9qf6gvIflgp6j/PpZbZvbzyjeumsjI0FQuW5/Iq5sYFcrx+aKWK1d25EfOk49SvcP+HA6+duA
 IFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that users with CAP_SYS_ADMIN in a user namespace can see
all namespaces owned by that user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 907fe419ec22..c99c87cca046 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -128,4 +128,104 @@ TEST(listns_unprivileged_current_only)
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
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(success);
+	TH_LOG("User with CAP_SYS_ADMIN saw %zd namespaces owned by their user namespace",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


