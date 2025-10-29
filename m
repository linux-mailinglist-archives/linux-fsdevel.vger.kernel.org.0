Return-Path: <linux-fsdevel+bounces-66258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D60C1A4AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 421503581EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE5381E4F;
	Wed, 29 Oct 2025 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ/hHN5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AF34CFB9;
	Wed, 29 Oct 2025 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740667; cv=none; b=Meu+wNofhZc4uU9WXvLMtZhCeQg263wp+ddZHIAYg/7q5he6FjntSzMjGPQFKaY/tfrWaU5ki89lMWGj1HHaPtjrEiQRkvVm8Y/1RkRu0gSFEZw6jKkAwDUwLdynPskt46BTPPiXHUyHB9piZHDqxEjm4xG1F6rv8XfPM4Nrhm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740667; c=relaxed/simple;
	bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKYTst1XGv+C6KgoghrE6bUO6gqKAVmbk/Ld6QhTW+T3KbM+vIHLz7dnCcppfaQgg3j1jGrHVcAwgsqlpV02xj3NzFbKPUDkCwV8oC00YAfRSnVbYWEkUDxLTmZbDKzf/bKwqs7lBHvPUmePAQb1WDOrqL4tOcsGaVxcwqyCzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ/hHN5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343D6C4CEFF;
	Wed, 29 Oct 2025 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740666;
	bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rQ/hHN5seJlN/J7XFSIS1mGMrL6/52yYcUdF2xi2nh4TpOEKwTTTAry4AYiQi51p8
	 frQ5DZVsp6SxC/PZx8pEIwBcST2PTkl8GxVe4LNGyVwQnzrYwg7pBE1twqsxlI6Re9
	 46XEa08DAitt+kV6mLOs8JgqU7BLkjDmd7uhWft/IQ/UmdMqUh2Av6bAjANHMzzZsy
	 X4qKVRgyH5JzxTwv9Nt+EB702nSyD1k+G+IuJCOMvoGaczTn8wEFFhto2zNVnLwTXw
	 Z2iYAfZ+I1RBezBEbjsAkO9y8GsP/LD0uweSdaRxA1D+fhSRHwSSKnQj+eJzm1LziG
	 RZSfe0KOu0NOw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:58 +0100
Subject: [PATCH v4 45/72] selftests/namespaces: seventh listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-45-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWJTbO5k1X+9Wxq9OfVih+Oz3L6+y2xNz5rV/z30
 LpAnel8HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxEWf4K7Ryf5z7uqLzaw5X
 hy+wLZsqxTp/zpQbf7KO7VuQKP82dxvD/zR+/kdbly594VLEw/9vu60P70bewv1TAz+Yf+LvML2
 1mw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() with multiple namespace types filter.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 31 ++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index f5b8bc5d111f..d73c2a2898cf 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -446,4 +446,35 @@ TEST(listns_specific_userns)
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


