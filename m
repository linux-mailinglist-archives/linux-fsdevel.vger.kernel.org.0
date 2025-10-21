Return-Path: <linux-fsdevel+bounces-64900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FDBBF64A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CB19A2698
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C85340272;
	Tue, 21 Oct 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k56CjcQr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A7340282;
	Tue, 21 Oct 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047287; cv=none; b=kiMEmARdPjo63NfmdTNU8WOrf/DAtlPVggRwgslDvc4E3LiZJmBwseL/IBc6LY1Vxq0bZiet1DHNBX4srixGxPAOGs5holTpm9p1+C/GBD9S5Ok/mzA3AWrXA8Kt1CJmevXkqL6+/5lWcYRrd4OeoulO7pVKceFKcwyNIrEbXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047287; c=relaxed/simple;
	bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GyCQN9ul07K1TR22OY4rCe/lw7dPggN6lNk+ctrIRUbx+83SiBe3Rz3Zy9Qe440wbfAnodzax+c0vv+gEi1cOldya92Jp6a05vK/hJE1FGo8sZos7gu4DeEXrrwoi2w8u9L4cJVWPleqMBQNZCdgXcg9m5+5A+uZhRMItXo47m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k56CjcQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4518C4CEFD;
	Tue, 21 Oct 2025 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047287;
	bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k56CjcQrfgL+lHhiTYqs67nqOzI9yjnL60HczgPgk/cbHjhtjU90xZrLGBKG9orB2
	 s03OMJPSaflfkuWJEkQ/RwHvY7m/pDFhb5ZcDCrtFYaabfCMkSYdyx7JMxspnH6+av
	 FMAsBSr51lbsaQwqv28YpvfBHp7oy6p6EM1BjyTHY/Mz96YnJp4/WCnj4pbNIc31lr
	 +bN9In4VojYUg392Ar4bZ69zyIdY8T1fBw99jXw8LFKoIrow40eS3XS4PY23ZZ3/c8
	 vB2VDw7QevxzaDEM0ZzNjuDgxXXV3N+S1YQxKV7EXXbTxGO6iLZs4Dx9OGmiiMknNg
	 ogERhEF6SREaA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:55 +0200
Subject: [PATCH RFC DRAFT 49/50] selftests/namespaces: sixth listns()
 permission test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-49-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zyvSyEvHN08sO6ilDq1bp8H9I2nWZ5I4e4dJ8kwOeEM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3yvX7suviu+Wc3jXf/3P2F+Cp7rN8Y9ME1RqLy7o
 4qt8/bbjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlIxTP8zzmeuENn9nLGR21K
 U1fOdDhsr/Y08uj8cwJO3VOmztj0+wDD/+Ar5u4VnSs+Czm3uDgkHLT2ebtPeJnZzuutoVfZYi3
 m8gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
This is different from seeing namespaces owned by a user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 07c0c2be0aa5..709250ce1542 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -573,4 +573,94 @@ TEST(listns_parent_userns_cap_sys_admin)
 			count);
 }
 
+/*
+ * Test that we can see user namespaces we have CAP_SYS_ADMIN inside of.
+ * This is different from seeing namespaces owned by a user namespace.
+ */
+TEST(listns_cap_sys_admin_inside_userns)
+{
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool found_ours;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		int fd;
+		__u64 our_userns_id;
+		struct ns_id_req req;
+		__u64 ns_ids[100];
+		ssize_t ret;
+		bool found_ours;
+
+		close(pipefd[0]);
+
+		/* Create user namespace - we have CAP_SYS_ADMIN inside it */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Get our user namespace ID */
+		fd = open("/proc/self/ns/user", O_RDONLY);
+		if (fd < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		if (ioctl(fd, NS_GET_ID, &our_userns_id) < 0) {
+			close(fd);
+			close(pipefd[1]);
+			exit(1);
+		}
+		close(fd);
+
+		/* List all user namespaces globally */
+		req.size = sizeof(req);
+		req.spare = 0;
+		req.ns_id = 0;
+		req.ns_type = CLONE_NEWUSER;
+		req.spare2 = 0;
+		req.user_ns_id = 0;
+
+		ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+
+		/* We should be able to see our own user namespace */
+		found_ours = false;
+		if (ret > 0) {
+			for (ssize_t i = 0; i < ret; i++) {
+				if (ns_ids[i] == our_userns_id) {
+					found_ours = true;
+					break;
+				}
+			}
+		}
+
+		write(pipefd[1], &found_ours, sizeof(found_ours));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	found_ours = false;
+	read(pipefd[0], &found_ours, sizeof(found_ours));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespace");
+	}
+
+	ASSERT_TRUE(found_ours);
+	TH_LOG("Process can see user namespace it has CAP_SYS_ADMIN inside of");
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


