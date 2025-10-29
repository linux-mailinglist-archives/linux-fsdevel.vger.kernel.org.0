Return-Path: <linux-fsdevel+bounces-66259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D3BC1A7A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E30556660D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B220381E7E;
	Wed, 29 Oct 2025 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9/GT1+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E034D4ED;
	Wed, 29 Oct 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740671; cv=none; b=C7co+51bUGAmozKQZD1JRR9mZU4QybCFa5IPGkk8Rsocp/uS4unUGmFcjcdy9SLs5of525QOsrAl+H6VTFMHb4yp4SMfBeGD/V4ZyR48HdJmfBLZn1VsVUEnsMjpw1/hERB7OKsk64FZdNkS5j+tGkylkCG9UJ2cye+3pW2o7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740671; c=relaxed/simple;
	bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHMIXtAcLCzl5yGJQF6JSJdzMWjUf9pomtMw1j88AoemXOgItziPOVAg0oCfLtTr5HGACumUnEXpf/lbtX3+dMvX6Lm8HJjESk37u9sOenUe/GBlCYlECNGNp3GHSaMYCyJnmrlz8ghYIaWNu5WIU+DVzPgdy/ns4Zy6Juc0foo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9/GT1+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B44FC4CEF7;
	Wed, 29 Oct 2025 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740671;
	bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J9/GT1+Ojc1LkCPiysfkxDX55ShajBlDoFrRkC+IgA2NmWSTqjLiZIwIrTPaNctWo
	 HvA8TpTCp4AMdZjZFwzm0w9JJM76xJ5ajbqg4K/bMNJ0gd4l7KmIsFFvUxawALXUp6
	 WqF2JDouFVF0I0GRZR4IxWF92/+tQU4traS6wM27bdDis+YmQrFGEna3Dmj3NKdiBP
	 lSXx72vay/fwNQMh0EGb2ByNI5FlnDWuaeHulLrS9/6uSm4T75zbDszrcgaXdSiOEp
	 CQqANPKB08HiopZ/U3Ydb52ZUjOPUKrUpkOPZwx49JOQw6yHUhEEkDB3qGxg9WhxMT
	 hzuTeb+weAh3w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:59 +0100
Subject: [PATCH v4 46/72] selftests/namespaces: eigth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-46-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4158; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vycCLgs/SEoxdQIQ6EcoGlOuO/CNJYVzQfqAbKcG6n0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfUd/2UgI2qwIKNakEtxsXlxRJvXi7ypxxdffujBN
 uvZbiGXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn4RTAynJJ/lM7A+WSmrMKt
 GSY6dfLlWjLXrt1eFXmm+3FQSIvocob/ie2hxzIepUT+5Z16a03vRvG5FwMFbtZGZXzR3VfjOEu
 WHQA=
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


