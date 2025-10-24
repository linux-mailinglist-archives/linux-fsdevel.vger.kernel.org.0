Return-Path: <linux-fsdevel+bounces-65483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D1C05E2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFEF45675A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6334EEF6;
	Fri, 24 Oct 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvpIkok8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD53126A8;
	Fri, 24 Oct 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303399; cv=none; b=QzR6sCfXdtjkIGzJN2EQt6V1DOSLLjjbLIvmR117xXOyiGZiuolI//qZ/k9ZcDKPzmZIqDEFA2hQS2kI38ZuUi07qD5x0g5mP9AqE9UOzyADTQrUII74EZNNnFBTECjBMvviETEMmqp4qs94smuahfpca51byypPdeR6UnmtzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303399; c=relaxed/simple;
	bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxKQp6HOoP2cw8hOt1smYmNsEnYc5WfjrGzhLnW6116h0NRVcK1zcNSwHmxWb7Y/gCDCnJL6kPGET3VjA7i3lf64hPj/Fld/mfiTZIu3EwDCH2Xn23rNSlP6rlz78tpIvUxUftTo3etdb4jqsn+UdbSL+szT7ze/5zzlzbW6FWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvpIkok8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E11AC4CEF1;
	Fri, 24 Oct 2025 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303398;
	bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jvpIkok8dAE/P7o2XKUnM32XFAmVvIu0rCu65fgvuQjX6YE68qqqDyK3+ci+wOdUy
	 BvU4Z/EaFb/4fa7jjCrmFwmctAAgbgUdzXxVighJlY27m8Qh5kClB4LjWNn0HTro+Y
	 SRVqJNLPChCTLQnd8roNnrN8f+oYVfzytEtnLzFwvtqY+w7NPbTRjV19Xa4snWlImY
	 amfGuIAMAk7Iy1jaaHboSDWK5/KJXLZm6oRuoE6U53c9DDWX9g1qcnDDyZ/fIVSJt0
	 tDOl2py0adtzQ+k/FAjuD7JR4pGaXb5+8zrKAbQaF19tPzxH1IiqekcsC23PrgtpyD
	 wg+JhBSstSyXw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:12 +0200
Subject: [PATCH v3 43/70] selftests/namespaces: seventh listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-43-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QzUkya/eQ/QDDIuBeLk9Y5q5aIl9eBXy2tswIGkyHaQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmpbtniNGtfE5zvPzv+3aPWCiilHReu/+W0q13636
 apoS+LcjR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT+XKZkeEhZ+pJI9ljwlc/
 BXy1Z+RdfshA+Zd10ZQjsdfFbd9XzFVh+O8SwvZ3xdqnxgtfbok405Oxs0ZA5NbWVfpJeRx+dh1
 MWSwA
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


