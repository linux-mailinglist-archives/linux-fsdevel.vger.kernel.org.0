Return-Path: <linux-fsdevel+bounces-65170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACDBFD28D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A28419C1323
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D3358D07;
	Wed, 22 Oct 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWuMwFcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BB3587CD;
	Wed, 22 Oct 2025 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149390; cv=none; b=iDR//icmcKSc3LztYSeNG41Y3sI/SaIwhAf5fbH0UcAAiEY49TXpK26fHODL2QFn8tgP38/GukV4GKt5cuehNAiUUQqE+b7kLfrOZ2ImpRN5CWBQrSopf57nsr5VtsnAUPwWEpjPfpqbmlOGvyq5aMLMTeV3Ailm6FbqyPoBZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149390; c=relaxed/simple;
	bh=zSBiD0DmDYcPFHCmh4S9YgYEBZCkP3T4DUO3iD7+Aw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sF7C/qLwD6EXaQl0GLX6eKeBCWwcLlP8gfgpqjaJmFxLDtEWOYgU1Bh68uanAlni9rCgUcN48FHVHRj773uqtnllhQyvoPBCN1mC1XquZyT7Z+8nXp4Uv5SkRcqbmYI771qsLTS6WcjqUcNiSNS5Ox4B1uGFHvIDVwuDJyRn4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWuMwFcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DF5C4CEE7;
	Wed, 22 Oct 2025 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761149389;
	bh=zSBiD0DmDYcPFHCmh4S9YgYEBZCkP3T4DUO3iD7+Aw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JWuMwFcfFVHeohkDUR7yKhVbNjItZsw7rpK1Fg8MObxzX+C+i1Vvnf4ghdAty6TIv
	 JhlqZS3z5NUEV56kHwkN8L5daIlecaMhX3RQk89Y7hUddeVmDqQpa67dDw4FutnnhZ
	 tGy9gI8oYjq9UCTv2XgbR4cxma4N4DPVkS/LSKsxUQf1y5ACjqSYGR6pgparv3C1BR
	 0qbD5m5vqEZ8m2l3QA/MDaV/MPv4vD3iu0BNjU70/oT5VHLb2TW31sD52bZ6jwMMEr
	 OgtSoR0OLns/YnwNhgNkiBE9eb9di8UvFLVLNIewwLgw5f1yE8T7NjNz+2XWS23CVz
	 iyxfM3z51xeSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 22 Oct 2025 18:06:20 +0200
Subject: [PATCH v2 42/63] selftests/namespaces: seventh listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-work-namespace-nstree-listns-v2-42-71a588572371@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zSBiD0DmDYcPFHCmh4S9YgYEBZCkP3T4DUO3iD7+Aw0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8ZHh27XyDevCyzhX1fhkcfj6LKvdob1qQ9e3cr7zY1
 mdMsqzyHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORnsbIsKdg+um162OzBYRu
 zXx0YfO9BaJZ03TWlmzWz1RbE3YjeC0jw5HOL8rfn5loR+x4foJznUU/T62J9roz61kWJ7Cs89o
 8gREA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with multiple namespace types filter.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index e1e90ef933cf..6afffddf9764 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -436,4 +436,35 @@ TEST(listns_specific_userns)
 	waitpid(pid, &status, 0);
 }
 
+/*
+ * Test listns() with multiple namespace types filter.
+ */
+TEST(listns_multiple_types)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = CLONE_NEWNET | CLONE_NEWUTS,  /* Network and UTS */
+		.spare2 = 0,
+		.user_ns_id = 0,
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
+	TH_LOG("Found %zd active network/UTS namespaces", ret);
+
+	for (ssize_t i = 0; i < ret; i++)
+		TH_LOG("  [%zd] ns_id: %llu", i, (unsigned long long)ns_ids[i]);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


