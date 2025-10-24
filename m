Return-Path: <linux-fsdevel+bounces-65480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3149AC05D9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC26189F2D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5334034C820;
	Fri, 24 Oct 2025 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0+PQ7VR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFCA314D24;
	Fri, 24 Oct 2025 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303383; cv=none; b=cCzzxnvIIup0iwIb+stE5QBhA4OazGB2MgnEYPT38ir/2O7zc6nIM/AP3U44Ugpj54NCXOnaJvv5yoZvw2Cwk1HqPe+04y9fPuOk1sIcJPNJVFA9y9gOYretu162gxaQ0wGoT4WrZ+HZJMp251ROCuW7unBvxHRxFjV17Jh52RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303383; c=relaxed/simple;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2HuiAMNT87t6iH4kaiWXHHmFL1xody/L+Fe50EEVCj3qe957CmBf5lRWZEAD0IT70BfxO4I0deXdmsMwYmMBNa6+AWOZTPOcR7DisqaYtn4F6r2YSWvupxQtzQSqOgrjbQ8gbmtccqNUxrbgmYMja31XnnLPKF/kpVIZBobZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0+PQ7VR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD267C4CEF5;
	Fri, 24 Oct 2025 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303383;
	bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o0+PQ7VRpTPf1RoflNfIYBzi4NN2upfzZd4YOiX9pG9/MW1Cg5W2+DbhfDwbWMVUo
	 ysiuojmhoCXqCa5YIJihEy/23arASAhoc/EKl+ke30/RvpM9FBQydhpg+qUft9KK/y
	 GspxwRaoLGQVa9Fas1FSOQW73AUAOivTp7tMuBmjARqMvPBhmERuyYca5uvL8OLYWw
	 xsdR6r7ZO1u4rj07za7aYxM4hkyEUBjE9bz8/gwXzXEzeDq2W7C0c1bKXppcH9J9r0
	 Z3gLygpAqNY7S2bV0VYB0uw+R5iGxf6VQohncdB/eFNZY0ESyx5yPLKAmvVkVR1gLC
	 XUlzS3xU1CAiA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:09 +0200
Subject: [PATCH v3 40/70] selftests/namespaces: fourth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-40-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UxNNzwwfXU08oQlPAvQ0Gj3cx0fWVzo9FwN6OUP3IWE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpzvhzw8pziInXpH87zF2xWP6op23jjoJ2HH+v1x
 UITNnGu6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI1gVGhi636ReOlyz6F3+b
 daevx2dLOxGFtC9pZosac8U21nCG72H4pxao1b5H73vDI/GSryzndDc/WzzBcG3etKAMjZ/pzKu
 eMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with LISTNS_CURRENT_USER.
List namespaces owned by current user namespace.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 7dff63a00263..457298cb4c64 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -168,4 +168,37 @@ TEST(listns_pagination)
 	}
 }
 
+/*
+ * Test listns() with LISTNS_CURRENT_USER.
+ * List namespaces owned by current user namespace.
+ */
+TEST(listns_current_user)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = LISTNS_CURRENT_USER,
+	};
+	__u64 ns_ids[100];
+	ssize_t ret;
+
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+	ASSERT_GE(ret, 0);
+
+	/* Should find at least the initial namespaces if we're in init_user_ns */
+	TH_LOG("Found %zd namespaces owned by current user namespace", ret);
+
+	for (ssize_t i = 0; i < ret; i++)
+		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


