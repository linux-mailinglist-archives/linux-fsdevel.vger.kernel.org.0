Return-Path: <linux-fsdevel+bounces-65484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57045C05DDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5A43B7325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E082334FF5B;
	Fri, 24 Oct 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb5fxbOR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228EB315790;
	Fri, 24 Oct 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303404; cv=none; b=l137DUEFH+JH018R8LbuEOD0Noerd/NgOaEVJ8X+oiW9oy6xgkzOvm0nqt8zPy/0y9myiqW9mHBXjFbEniGK7Rx3YqCjwAAxp6KLj1uvCjZ5LYKt5aVMLG+8bxw59LoJhrN3IXHxFBAJXAyOlT6UfavLjKhevG07jyvltAVwweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303404; c=relaxed/simple;
	bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxT0z/Eb/v9djg2JnLpV8yaOuNZfdmMR4/L21WzaFjHga11j+6eDafyAB0m3hsnyXx6yMaoNWF+R4LiF4DkFhigpgywpHs5hnAEjgrlxtaNipaC9nsQza6g+TSzKRleqWUHVgZ7QdhETCUwTI0K8m+HtyowO3pCRS09+kVGQZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb5fxbOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19754C4CEF5;
	Fri, 24 Oct 2025 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303403;
	bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tb5fxbOREhXkPUhu0L4hZCuE2FKuyN2YU77awTMDEq4iGRsdQCnvfIF80JwcekrSA
	 fkjervaqKGjQDW6o3IyhY/ijBC7kOd6yn1Tf6borqXuRgqgNJHPab/cE5TdLsM7eho
	 z51UWpTw7187ENAPj14RXZCakt0wWqSKRHRN2IGDS0OuLou7R+7SIQdtS6OJZ3c5LG
	 elaulD9L7INrKshNc1zBLp5GIbxKbswNh9RTT6tapO5teAuazQ/hh6yB/haHnXJ1ZT
	 7aY5wwkw3PZwWvo7CLhb2Eh8aVN4fYdk65AZnamxE87UrJasHqZlt9jk36bBmbH5l6
	 I130OXpO+f00g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:13 +0200
Subject: [PATCH v3 44/70] selftests/namespaces: eigth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-44-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4158; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmoT+Ldtg/j7yRxdD/x0FLkOTNY4Ib0mKcfp+saKQ
 49+Pj7j3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR18GMDGvPWxvcEZ8+JfHm
 1zoT9+/RjDyRRhc6FizccF1fOWj/IQGG/6WLfvy7ZFV2W0JR713tmsjd+cabpn5f6uyUWOaz7nl
 eEicA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that hierarchical active reference propagation keeps parent
user namespaces visible in listns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 150 +++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index d73c2a2898cf..d3be6f97d34e 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -477,4 +477,154 @@ TEST(listns_multiple_types)
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
+	int sv[2];
+	pid_t pid;
+	int status;
+	int bytes;
+	__u64 ns_ids[100];
+	ssize_t ret;
+	bool found_parent, found_child;
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, sv), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		char buf;
+
+		close(sv[0]);
+
+		/* Create parent user namespace */
+		if (setup_userns() < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &parent_ns_id) < 0) {
+			close(fd);
+			close(sv[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Create child user namespace */
+		if (setup_userns() < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &child_ns_id) < 0) {
+			close(fd);
+			close(sv[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* Send both IDs to parent */
+		if (write(sv[1], &parent_ns_id, sizeof(parent_ns_id)) != sizeof(parent_ns_id)) {
+			close(sv[1]);
+			exit(1);
+		}
+		if (write(sv[1], &child_ns_id, sizeof(child_ns_id)) != sizeof(child_ns_id)) {
+			close(sv[1]);
+			exit(1);
+		}
+
+		/* Wait for parent signal */
+		if (read(sv[1], &buf, 1) != 1) {
+			close(sv[1]);
+			exit(1);
+		}
+		close(sv[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(sv[1]);
+
+	/* Read both namespace IDs */
+	bytes = read(sv[0], &parent_ns_id, sizeof(parent_ns_id));
+	bytes += read(sv[0], &child_ns_id, sizeof(child_ns_id));
+
+	if (bytes != (int)(2 * sizeof(__u64))) {
+		close(sv[0]);
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
+		close(sv[0]);
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
+	if (write(sv[0], "X", 1) != 1) {
+		close(sv[0]);
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		ASSERT_TRUE(false);
+	}
+	close(sv[0]);
+	waitpid(pid, &status, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


