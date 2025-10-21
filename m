Return-Path: <linux-fsdevel+bounces-64893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C09BF6464
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DD05354A06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A124E337BA7;
	Tue, 21 Oct 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D73ZWQfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8B330B3A;
	Tue, 21 Oct 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047253; cv=none; b=AozA/Hak02aF+yh6GxxzNin4AUwFekwIV9wa1anhp//cF1wMInAlZ04h/6hNGU3g9jefVyz4A4tI8Nl+paWQ4enGjFIpHPRqcg3LvabBGlOJ9C3Nt5dCKpGnMPN5OaxzH2egrifulq6IOC8/XVWIHCrUl+u/OshIxGlDFxEo2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047253; c=relaxed/simple;
	bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TNRFLUXL1x1iKsznP5KMtlFHe4PXnDQw3WhJsoPWfe50r4DCO1AXfrLPCOCoDuU5e2/Zm+t7p3nIZNfB9X54vE25zROIKqfzpuFCD6Y8NaYFKqP67C03VSn7ZWBu7JL9ZrkXa3jP43p/UAsR8JgGhzRm1EH3nhIT0WYt604SFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D73ZWQfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92650C4CEF5;
	Tue, 21 Oct 2025 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047252;
	bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D73ZWQfvX6+4O7OBuostsMUjIKoA+fPF9ThEtDNzqoHLAGVj60UtQh/lRDo0GI08z
	 KTU430P7bLfq+4gx+9wG0zus/Ud7/+ua6t3moptUk11/jyccMOMxwLSNOJYvwCnsgX
	 GkY8Pc4fF76zu7cTYoVZeoOhjgn/g0RuW+FTPYGYpd9baVzVbiM+IH8kRPNPf14f/T
	 AVsoWsQeOrKdvA6bfFj0GGka22rjG4/zZPCgoIf+BxIi0ez+V9I+axyqDeJFMcx1oB
	 DSz46SNKHw++wV7JnCDKb96Kcl21iMYMJ85CXzTW+XXCuxZgGIPRPilJNj/AytuOir
	 6/AwnIIKMl6Iw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:48 +0200
Subject: [PATCH RFC DRAFT 42/50] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-42-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V4fLSyijbME7l6bI490uSVspsEhpOL9UHRqTJM6dwA8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3x3KVv9/jlrgRVS2gd7f2sUeL5bGCN1KfTFBVHJe
 3FXOrPDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSOIWR4dq2c2XrX3SsWDzP
 b/uhoxNXaGVdM+RmzEoRFfK+naTpNZuR4deqefOc1Ap3ndhyfWP/X50FT/dwt5Y7P3waeVnj0ex
 /p/kA
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


