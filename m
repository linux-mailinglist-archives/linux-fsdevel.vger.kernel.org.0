Return-Path: <linux-fsdevel+bounces-65171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E7BFD24E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9709534650D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378642C15A3;
	Wed, 22 Oct 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9+5Q+wQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D8358D26;
	Wed, 22 Oct 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149395; cv=none; b=qVChMW+yr2W4nZDxk0Bi2yEKD7xAZgBtdDvs2s08gxfnbEB5QlYHK76kGCKBZfxvx+dxzGrHxV/DSQXyp5Fen8PJlgDWv4gigWvijp+f9DckRFDlIgTZeYJFGWVj9xRol/fHqK4KYvWeOD9X+aDM8BAfe2DyqoWVgmYHxASj0J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149395; c=relaxed/simple;
	bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6Yrt2AchikRDyYMkJXtl1zap6TKJWYJV33E6p2J+IROmnx5pL7q0/MJIG7DJqmuvxULl31YqCK7yEghOfK70eEo4FYOccacEcNzcg2OdNzbWJPi0Wiq3HUs6uOG5e2XkVQLMN44bngXxpBJzri6Xb6xLuWwCS92JqwZdjMdOnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9+5Q+wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A5C4CEF7;
	Wed, 22 Oct 2025 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149395;
	bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r9+5Q+wQtrvIl/42nprWF6mcRZjwgXTGkTMjLqYZyHohNs+fbs9fTzMm1Fwpma9gE
	 qVa6l7QLDO3EgOZoEf78DDt+tnrCH8H3iysm0Q4dhx1zco7A4cMbVjysm1RjlmheqS
	 FOAtWWE/KBoZL2PjGtZat0OTYM/3GC/wj4eAb03Rl8v1EnQ54uu1x8QFw8XY5Rimd2
	 7O9xGSbPduNKQmOR4G/baupt5JJPfM8QzFeVK79l0Nfjs8j5NNDl9P4zdqpkPz/nn4
	 IiWD2+GG4uqmv1yZmvItLUcq6mCkv+w254tIICqWpYvygcskUAqboWryTAzv1DfZdQ
	 78Vlo/P4yGpYw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:21 +0200
Subject: [PATCH v2 43/63] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-43-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHi2/fNrydyog4pnb1wL0eLa/EFrf+TZiCkZPouSF
 p9avSOlqqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiB9Yx/Hd03X7Srb9Iwqt7
 RcX5/Op8nefPj5f/15m9IeNQ68bXLrUMf7jtnb7Ly5y36XDzFV6rPHHi2q1uR6TXRpnI3831e86
 3nQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that hierarchical active reference propagation keeps parent
user namespaces visible in listns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 135 +++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 6afffddf9764..ddf4509d5cd6 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -467,4 +467,139 @@ TEST(listns_multiple_types)
 		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
 }
 
+/*
+ * Test that hierarchical active reference propagation keeps parent
+ * user namespaces visible in listns().
+ */
+TEST(listns_hierarchical_visibility)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWUSER,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 parent_ns_id = 0, child_ns_id = 0;
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	int bytes;
+	__u64 ns_ids[100];
+	ssize_t ret;
+	bool found_parent, found_child;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		char buf;
+
+		close(pipefd[0]);
+
+		/* Create parent user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &parent_ns_id) < 0) {
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
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_ns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send both IDs to parent */
+		write(pipefd[1], &parent_ns_id, sizeof(parent_ns_id));
+		write(pipefd[1], &child_ns_id, sizeof(child_ns_id));
+
+		/* Wait for parent signal */
+		read(pipefd[1], &buf, 1);
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	/* Read both namespace IDs */
+	bytes = read(pipefd[0], &parent_ns_id, sizeof(parent_ns_id));
+	bytes += read(pipefd[0], &child_ns_id, sizeof(child_ns_id));
+
+	if (bytes != (int)(2 * sizeof(__u64))) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "Failed to get namespace IDs from child");
+	}
+
+	TH_LOG("Parent user namespace ID: %llu", (unsigned long long)parent_ns_id);
+	TH_LOG("Child user namespace ID: %llu", (unsigned long long)child_ns_id);
+
+	/* List all user namespaces */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+	if (ret < 0 && errno == ENOSYS) {
+		close(pipefd[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		SKIP(return, "listns() not supported");
+	}
+
+	ASSERT_GE(ret, 0);
+	TH_LOG("Found %zd active user namespaces", ret);
+
+	/* Both parent and child should be visible (active due to child process) */
+	found_parent = false;
+	found_child = false;
+	for (ssize_t i = 0; i < ret; i++) {
+		if (ns_ids[i] == parent_ns_id)
+			found_parent = true;
+		if (ns_ids[i] == child_ns_id)
+			found_child = true;
+	}
+
+	TH_LOG("Parent namespace %s, child namespace %s",
+	       found_parent ? "found" : "NOT FOUND",
+	       found_child ? "found" : "NOT FOUND");
+
+	ASSERT_TRUE(found_child);
+	/* With hierarchical propagation, parent should also be active */
+	ASSERT_TRUE(found_parent);
+
+	/* Signal child to exit */
+	close(pipefd[0]);
+	waitpid(pid, &status, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


