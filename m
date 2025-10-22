Return-Path: <linux-fsdevel+bounces-65177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8C2BFD3BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4121A561F56
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7682D3204;
	Wed, 22 Oct 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpKfz1kr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DAF359705;
	Wed, 22 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149426; cv=none; b=L3TalmqZ5ELrwG9qJTalktRhZWTNAGU5acEoq0/RHlGwXKqjYuCzgy/gFaKLjjvjymw2p1tulHZNBIISGNo1J0Y4pBXayfoS//Q/lodsTd5i+8Jh7yCs9wRQKkkBUSt5MI36mQul/DhDQeFsl23Iv/h0OXH/jaOS0QxRY1DtSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149426; c=relaxed/simple;
	bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4ZAMH+K1mSrACYN0ZLEnzLoeYgaGZEFMn7MgJ/svqk8HOWv4O1t85WndGVZqB4LYd1vFFGDRwoLsBJwLKLAUWJxXSOtvPiway1FZOtTPpd1Sql5clznNHXsY7oe6nOmRvRPzNrMpxFZ6fOHJjYyx3MU9i4MkjEJYQrXH/xRpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpKfz1kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C08C4CEE7;
	Wed, 22 Oct 2025 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149426;
	bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jpKfz1krkE7610Pnfxf3fdl9ixPsI1cQOT5vFIECUfBcCYPiouFUUCQqb1Sf8Bvo1
	 BbpmN98V4ZV67xOK2wfeYl/fAbQGK7RvB5jVhlDV7CrpyEazdmMXa1kfjngx1kCBdG
	 kbJk+8MO9CiWYlWtSi4DUFDhyKhv86TUnX9X5AGfrWAgpBiy6twkOFMuuBevxAn8WN
	 F16N/WXMbuj5FZvPPtkOQRgx4B3yYAX5f8jcsQTDKIYfqy6WHM8ZxEFfy7Rkk2/kcz
	 oRorrDUMh9pt8CS4aOZHKMr5HCJE0dOkqWLS+lOkhUGsV15mz8lN1+l+7D1W/MHleW
	 eCvBo/L7ulk1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:27 +0200
Subject: [PATCH v2 49/63] selftests/namespaces: fifth listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-49-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3512; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W101eyhrLICscf7roVQMEA8GrDRzuQACPaa4FbASft0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHiec9F1gdKt5JLq/mudy/ILO/4tVtNT3WRas3lPx
 q6IpRIzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyeiXD/+qqV88K63l1n/DM
 CZ++of+ommnin+y8q3NE1vqLdqqU6jMC7VU3rpn0SGvpq+ln2bsnWy59KDZl2s42gWfte5eW/7L
 mAAA=
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


