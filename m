Return-Path: <linux-fsdevel+bounces-64891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4ABF6488
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642D5503411
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE4134CFCA;
	Tue, 21 Oct 2025 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI717obE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784832ED21;
	Tue, 21 Oct 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047242; cv=none; b=t7twdTj0VKZUABXWfSfSsOdVdJoSFp2y+izGofGCc26PYAnkZy1yE8Wqb6j/aenJDMw506OKbd+CGd/3oyA+vUZxzrXD+l3UJD5qK2VlT1N/flQ6mREJLgCRRwdgeP2AGQlWreuQhLEX3dLB3BGXliIhAT8dXnBJB4LDUSCTVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047242; c=relaxed/simple;
	bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lvfnOAG4zSVtGtAauTZPQ/iQiXTSKs6BlWcKO6oj9sseDZCZ+9JNd1zB5wdOq7QUi7YfvoseM6TuT/Ndr56cL3oFxgWbpkWuSwHOl4IDBJtASQPDS1dCQYein8RDuzji7ZZUIEL/dk/LxwKGemu+hP6AtfNz+pNw7JO7M+EnjHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI717obE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E28C4CEFD;
	Tue, 21 Oct 2025 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047242;
	bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bI717obESmGM0zhYVSTw0xxWy1nlhI/WfmtEyFBvL9Rw2+vP0HrYyjQKeWVWRw7MX
	 buOB+EqQXxQrcz/07IyF9icBDS+mkgYGU9Ml7IovMvyANmc7U2R5m20jxS7GTb6MVx
	 YheiQiZM4JP2aiG7qrluLBqF+dY+UNrDUQdVdyPcxe/PohZyPHOlgqpdKqIB2X7wsF
	 VCSrpabpmol/DN01EvliztM6GV5o1hWJZuzBo64gHyPHFKFwdljZwShUMvgg862yA1
	 X6HCbIYPbsSp2bWZFmpMCbgmcVa3/E6E8MVRwjYJN3ZkbgKT5XyUwnYgAI+UYozlIV
	 ebJnv/T9kkgJQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:46 +0200
Subject: [PATCH RFC DRAFT 40/50] selftests/namespaces: sixth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-40-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4vBs0iC1GliO+F4XrLBJxRIywFUw/24vdpBSDdc51/s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3y3uXZe1M3HFstePDSbsX3Lo52T7kd886q83nA5j
 VHPvq5At6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi0QoM/122tvLmnohbUV7f
 vORn/psHlrWc6vtWJq0+clUo/Izu10+MDK927DHmjtc5LB4cVPvxd9+pdKnVRb72ooxLU4LqA7d
 P4gUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with specific user namespace ID.
Create a user namespace and list namespaces it owns.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 109 +++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index e854794abe56..e1e90ef933cf 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -327,4 +327,113 @@ TEST(listns_only_active)
 	}
 }
 
+/*
+ * Test listns() with specific user namespace ID.
+ * Create a user namespace and list namespaces it owns.
+ */
+TEST(listns_specific_userns)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,  /* Will be filled with created userns ID */
+	};
+	__u64 ns_ids[100];
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	__u64 user_ns_id = 0;
+	int bytes;
+	ssize_t ret;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 ns_id;
+		char buf;
+
+		close(pipefd[0]);
+
+		/* Create new user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &ns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send ID to parent */
+		write(pipefd[1], &ns_id, sizeof(ns_id));
+
+		/* Create some namespaces owned by this user namespace */
+		unshare(CLONE_NEWNET);
+		unshare(CLONE_NEWUTS);
+
+		/* Wait for parent signal */
+		read(pipefd[1], &buf, 1);
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+	bytes = read(pipefd[0], &user_ns_id, sizeof(user_ns_id));
+
+	if (bytes != sizeof(user_ns_id)) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get user namespace ID from child");
+	}
+
+	TH_LOG("Child created user namespace with ID %llu", (unsigned long long)user_ns_id);
+
+	/* List namespaces owned by this user namespace */
+	req.user_ns_id = user_ns_id;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+	if (ret < 0) {
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		if (errno == ENOSYS) {
+			SKIP(return, "listns() not supported");
+		}
+		ASSERT_GE(ret, 0);
+	}
+
+	TH_LOG("Found %zd namespaces owned by user namespace %llu", ret,
+	       (unsigned long long)user_ns_id);
+
+	/* Should find at least the network and UTS namespaces we created */
+	if (ret > 0) {
+		for (ssize_t i = 0; i < ret && i < 10; i++)
+			TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+	}
+
+	/* Signal child to exit */
+	close(pipefd[0]);
+	waitpid(pid, &status, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


