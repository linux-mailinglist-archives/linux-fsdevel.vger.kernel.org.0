Return-Path: <linux-fsdevel+bounces-65492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD7C05E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B1619A1992
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A8315D5B;
	Fri, 24 Oct 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKaD/dhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C4357A25;
	Fri, 24 Oct 2025 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303444; cv=none; b=ZpcY5PBK4JzJ1XzmGDTlmrrwImXRHmNdecDofA5t3itZJ2+UrkfaJY1Q2pDQB2bEa+D2/sgC0MP/eunHueWXEnUmq+2cT4nHvru+2sVVom5cDQHGFoqmvdgQmpgei2ZduZPeyXBgIujaf3/UV6Af8XuwDLKgygGx960UOah6or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303444; c=relaxed/simple;
	bh=lxk3HyfGnG2LzFtd9uD08385YY9HWIbP9txgILZ5aFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9kMcPazL1cmahp1L1yFBc60mQGx06jhsOSsSFVS2kEKc/vACLkh5u1RfMz0KCl/PLjTWJWYn50isG6TseXY9rc0nRhypr488HM3bs2zzYJpETIiKT6mvNiCMm8DRZ4lm0fCOXY/HByH/BgzPKS4RXVeKzcXV5IPw+8JdwDQ5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKaD/dhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B148C4CEF5;
	Fri, 24 Oct 2025 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303444;
	bh=lxk3HyfGnG2LzFtd9uD08385YY9HWIbP9txgILZ5aFQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fKaD/dhSXHJfBpSm7rd2BGc5mSjkqujo7rCWjxmDGP9hkBA8yFClgyPZpqVB8KCEi
	 3Np7MlSfdwhQOmz1uh2jpK65XkSyuahWdsGRtvNavXWOFv3QdIxa4KNH3M8A7zgniq
	 ucFY3fFe4JpTu4h5Xm/ZggeRP0MIPNpX5P2Ttj0Wgf+kgTNy154Ax8inFsjE6N+dC1
	 E5fa7Fzd6GD2kCKGC+owyG/JJGRmfCxz++RbdfCbyadJc1PUTpkCBhIf24+zRhNE2E
	 BXPVMTIwQILDIMh9Y6KphRtGQcdf3DeBjxit79BQIBwJGeu3DBB82Cug5FtmZOJQvq
	 wOiAILQFP7F8g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:21 +0200
Subject: [PATCH v3 52/70] selftests/namespaces: seventh listns() permission
 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-52-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3491; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lxk3HyfGnG2LzFtd9uD08385YY9HWIbP9txgILZ5aFQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmr3uGsoc2b2i/6a9qn3Gmrm6C0ysHDXLs1szYl7Y
 XP7j5dfRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQeGTIy7P632urKvIwVVXvO
 cSnHX3N++WNCjNH+Vo9nYeWnX07wNGX4p6ew4gNXXX5s/6dtzq/zLp+acyoxo3GG5fFXp5VvCd2
 fxAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test that dropping CAP_SYS_ADMIN restricts what we can see.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/namespaces/listns_permissions_test.c | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_permissions_test.c b/tools/testing/selftests/namespaces/listns_permissions_test.c
index 9aa06ff76333..82d818751a5f 100644
--- a/tools/testing/selftests/namespaces/listns_permissions_test.c
+++ b/tools/testing/selftests/namespaces/listns_permissions_test.c
@@ -648,4 +648,112 @@ TEST(listns_cap_sys_admin_inside_userns)
 	TH_LOG("Process can see user namespace it has CAP_SYS_ADMIN inside of");
 }
 
+/*
+ * Test that dropping CAP_SYS_ADMIN restricts what we can see.
+ */
+TEST(listns_drop_cap_sys_admin)
+{
+	cap_t caps;
+	cap_value_t cap_list[1] = { CAP_SYS_ADMIN };
+
+	/* This test needs to start with CAP_SYS_ADMIN */
+	caps = cap_get_proc();
+	if (!caps) {
+		SKIP(return, "Cannot get capabilities");
+	}
+
+	cap_flag_value_t cap_val;
+	if (cap_get_flag(caps, CAP_SYS_ADMIN, CAP_EFFECTIVE, &cap_val) < 0) {
+		cap_free(caps);
+		SKIP(return, "Cannot check CAP_SYS_ADMIN");
+	}
+
+	if (cap_val != CAP_SET) {
+		cap_free(caps);
+		SKIP(return, "Test needs CAP_SYS_ADMIN to start");
+	}
+	cap_free(caps);
+
+	int pipefd[2];
+	pid_t pid;
+	int status;
+	bool correct;
+	ssize_t count_before, count_after;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		struct ns_id_req req = {
+			.size = sizeof(req),
+			.spare = 0,
+			.ns_id = 0,
+			.ns_type = CLONE_NEWNET,
+			.spare2 = 0,
+			.user_ns_id = LISTNS_CURRENT_USER,
+		};
+		__u64 ns_ids_before[100];
+		ssize_t count_before;
+		__u64 ns_ids_after[100];
+		ssize_t count_after;
+		bool correct;
+
+		close(pipefd[0]);
+
+		/* Create user namespace */
+		if (setup_userns() < 0) {
+			close(pipefd[1]);
+			exit(1);
+		}
+
+		/* Count namespaces with CAP_SYS_ADMIN */
+		count_before = sys_listns(&req, ns_ids_before, ARRAY_SIZE(ns_ids_before), 0);
+
+		/* Drop CAP_SYS_ADMIN */
+		caps = cap_get_proc();
+		if (caps) {
+			cap_set_flag(caps, CAP_EFFECTIVE, 1, cap_list, CAP_CLEAR);
+			cap_set_flag(caps, CAP_PERMITTED, 1, cap_list, CAP_CLEAR);
+			cap_set_proc(caps);
+			cap_free(caps);
+		}
+
+		/* Ensure we can't regain the capability */
+		prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+
+		/* Count namespaces without CAP_SYS_ADMIN */
+		count_after = sys_listns(&req, ns_ids_after, ARRAY_SIZE(ns_ids_after), 0);
+
+		/* Without CAP_SYS_ADMIN, we should see same or fewer namespaces */
+		correct = (count_after <= count_before);
+
+		write(pipefd[1], &correct, sizeof(correct));
+		write(pipefd[1], &count_before, sizeof(count_before));
+		write(pipefd[1], &count_after, sizeof(count_after));
+		close(pipefd[1]);
+		exit(0);
+	}
+
+	/* Parent */
+	close(pipefd[1]);
+
+	correct = false;
+	count_before = 0;
+	count_after = 0;
+	read(pipefd[0], &correct, sizeof(correct));
+	read(pipefd[0], &count_before, sizeof(count_before));
+	read(pipefd[0], &count_after, sizeof(count_after));
+	close(pipefd[0]);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFEXITED(status));
+	ASSERT_EQ(WEXITSTATUS(status), 0);
+
+	ASSERT_TRUE(correct);
+	TH_LOG("With CAP_SYS_ADMIN: %zd namespaces, without: %zd namespaces",
+			count_before, count_after);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


