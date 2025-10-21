Return-Path: <linux-fsdevel+bounces-64899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E304BF64A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 14:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A772134C6AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC285393DF3;
	Tue, 21 Oct 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdnTFMDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA34932E6B3;
	Tue, 21 Oct 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047282; cv=none; b=jauYDzCvLizPaWeJl67tJtYpkBqSY3Py5Las69oBlnTNxNIXfbgX5P+pG9nYqPThXuaCtQF/yQea0gdanvB9WMlR6KrThD8z0iouu72kwjg8SuIWU0gjpYk2Hb/ZLuuospnG7+n3QJitrgxM80pZ6YYogEoIm+/lGm/oH3CIxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047282; c=relaxed/simple;
	bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AlIsAJmj2NR/ENUenFYtswarvVbF9jiEGEikyuKnts6EhPkGeCsfjQJDp9ckvRAfAeRpVZ512w4lEibRaPKNEWYTSwXXJscwys/Qkp+Q0QWv53rFMinpWmlMOPIoCa5sHMTuN8WhRe3u9mSvKkDFoSkluMX2ybzKsG5ZHpknRco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdnTFMDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0B9C4CEF1;
	Tue, 21 Oct 2025 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047282;
	bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdnTFMDTwFXHFuujB+n2q93dvk41YRGjdmay+TXzLQ6LD0Bb/PslarbDOzdho3Gb7
	 YeEfp5WiQJJ4/4HoVeIRvw17bA1S3iECixJrDnGUVbLRnoUPu2RptxKCaDRQ/0k6WV
	 +pG7AmVJOH4+Waoz6w8JVRh3fJcOxNQxd6R0itSsL/1b3a/JT65QlcpqWhVEtN49WO
	 3QauUsXp1DM+wkCgJFI/kEyDScNIpAySFzfLwgs5+E9MaDDbf0FJxspr9sBojV9mwT
	 /6nzTKf2/vP9koWVgRiX/udBxCokXIoPVhSBx8/nmdXBLz1rhTIvGncy1j8p957Hn1
	 u0iFn6qKpDkHA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:54 +0200
Subject: [PATCH RFC DRAFT 48/50] selftests/namespaces: fifth listns()
 permission test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-48-ad44261a8a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3x/9uGUkPPny4S4Ps08+Pa/nK6Myduu369dZsbbl
 5tmXDTw7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIdWGG/zlSr6K8Q7bOPHIh
 fHXS4UvWHc5Hyjx0+YsLqmff2TZl3VRGhvcmKjyfHoXJHVx+n7NyRkP1qWvZnjtWdIslppU/m1u
 VywEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that CAP_SYS_ADMIN in parent user namespace allows seeing
child user namespace's owned namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 122 +++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index ff42109779ca..07c0c2be0aa5 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -451,4 +451,126 @@ TEST(listns_current_user_permissions)
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
+
+	if (WEXITSTATUS(status) != 0) {
+		SKIP(return, "Child failed to setup namespaces");
+	}
+
+	ASSERT_TRUE(found_child_userns);
+	TH_LOG("Process with CAP_SYS_ADMIN in parent user namespace saw child user namespace (total: %zd)",
+			count);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


