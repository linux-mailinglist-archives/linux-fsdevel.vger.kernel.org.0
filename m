Return-Path: <linux-fsdevel+bounces-65479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98954C05D87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37883189F6E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EF34B424;
	Fri, 24 Oct 2025 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhoNDm7M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83908314D15;
	Fri, 24 Oct 2025 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303378; cv=none; b=QoZGaUiGSCppLvVWQ1FsvJqacziKKwvS29zrxMOwSpIYOqcKKImeo0jMI9BIm0XkfMwyarZgnMsDpkjFdbAM/Z5ZJ613aXfTMQPnyAdHUctgm+2zeAwPehnZZk8GzQOuJiO7cljsojaj/oy0SLCQ5fbIBTmwykwt2/n1So7z0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303378; c=relaxed/simple;
	bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYG4P4tn+ff5OejqF1jR+pzmgnIHJjKAy+7FAEzxeb8cqSp4jVkIpmUIUFlrcdOrZLttfLn9pQhMWfD+KFpx6zRnIAvwwe/99qAPDm/NfCX8CtNYtEpyg4qaluFkCNiP10EuCJKgsrBlSrrErdE8kSkebKn3f8XyNIIdEuJfTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhoNDm7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC70C4CEF1;
	Fri, 24 Oct 2025 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303378;
	bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IhoNDm7MYHudlbkhVsfUx/mu4yPv3B7LpWedIbsFqk5feOJR2CRLTtpPfGU913rts
	 BnXsbhrrBG61BAiBz8SQXkZzz7CuVgVCCTVF338/JjHpWwS/EisV9aolFITdl8uOiV
	 NSPcpT3BSWvZci1xaqhHxKBZidz3LoPbdEAG4ILj+fNDqCeN9M0gfspQU3CRZE9whS
	 GhJDDxpOOdf9k4/VuTE+x2XBOam1W3CpgebRf2yw+btHZbTEbQajWit1RZzWe1YFkC
	 xJC9kpNKo6CZR+ucuRxGJ+6hR2XNPkcmTFPFiLoxPw3jPI1HNaMIpfpSFCdzIgORxh
	 6l1D+YC4t/kJQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:08 +0200
Subject: [PATCH v3 39/70] selftests/namespaces: third listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-39-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=brauner@kernel.org;
 h=from:subject:message-id; bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmqTFlukG3Fq7pS9f+ubJ933MD15XSttObNk0c+Vk
 7ZO05eI7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIeh+G/77Ns2ff05A9yVel
 /6T/xenyO87L9py7bcszsfjdmoieVTcZGRbntt+c4mIXu+6T60drrmXBx1sPHolevehw58v55uJ
 r29gA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test listns() pagination.
List namespaces in batches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 53 ++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index 64249502ac49..7dff63a00263 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -115,4 +115,57 @@ TEST(listns_filter_by_type)
 	}
 }
 
+/*
+ * Test listns() pagination.
+ * List namespaces in batches.
+ */
+TEST(listns_pagination)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 batch1[2], batch2[2];
+	ssize_t ret1, ret2;
+
+	/* Get first batch */
+	ret1 = sys_listns(&req, batch1, ARRAY_SIZE(batch1), 0);
+	if (ret1 < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "listns() not supported");
+		TH_LOG("listns failed: %s (errno=%d)", strerror(errno), errno);
+		ASSERT_TRUE(false);
+	}
+	ASSERT_GE(ret1, 0);
+
+	if (ret1 == 0)
+		SKIP(return, "No namespaces found");
+
+	TH_LOG("First batch: %zd namespaces", ret1);
+
+	/* Get second batch using last ID from first batch */
+	if (ret1 == ARRAY_SIZE(batch1)) {
+		req.ns_id = batch1[ret1 - 1];
+		ret2 = sys_listns(&req, batch2, ARRAY_SIZE(batch2), 0);
+		ASSERT_GE(ret2, 0);
+
+		TH_LOG("Second batch: %zd namespaces (after ns_id=%llu)",
+		       ret2, (unsigned long long)req.ns_id);
+
+		/* If we got more results, verify IDs are monotonically increasing */
+		if (ret2 > 0) {
+			ASSERT_GT(batch2[0], batch1[ret1 - 1]);
+			TH_LOG("Pagination working: %llu > %llu",
+			       (unsigned long long)batch2[0],
+			       (unsigned long long)batch1[ret1 - 1]);
+		}
+	} else {
+		TH_LOG("All namespaces fit in first batch");
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


