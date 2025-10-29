Return-Path: <linux-fsdevel+bounces-66254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37837C1A5D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83122560863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739237FC53;
	Wed, 29 Oct 2025 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLdVo4E9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924A437EE33;
	Wed, 29 Oct 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740646; cv=none; b=hpKpkpeZpeQTAhA8vCwg/WIhESejZI9ga0gXPTinWkl7VyQ05/W2Ysb43zL1CG2YjjUBwejRYYC9eWaLpDc4u9Wp9PM/dJLgt90jB5NkscXFR/pQh7m2ka6nsCbq1qBzYEwS3CD8/z0HOgvbZ7onzrwAmpXrXmykkAUKdnX72u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740646; c=relaxed/simple;
	bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhRkqisLsiC9sPuj9TGGKaYiRGIuqZY0NzJmiQ0V7v+TsMZMeRBU+Sx0KkFwthSHkSVY0g+woJzsg/sOGgy2wUORyyffPJQbDsBClwL59LHdWhqudDpWJedt252Uayc5ZiNe9Udwn8EKXJ9ouQIgznowqJIt/ic7xjLuDHexWto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLdVo4E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1CFC4CEFD;
	Wed, 29 Oct 2025 12:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740646;
	bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLdVo4E9M/dqLQGToUZ6fWm1RRkYcoALofiF3C9/XuujKUBAnd7GSJIau/CkS3UVy
	 c3QSpEzcRW1J7PMXMOIeyrIw1d6xkuqS5KPty/dezN2ipxdMrL7jY1UKU5EO8+NE5U
	 eYAdV7cuhotX/6Yw5a5cbAdl6Gnb4GyjlXohCBTVt20MIrSGH8336zyJhROmLgF8tR
	 AqmKshp5w3vziVjBWvqbQDdwbrJ/Q1eUFaV/SQqMEIQhQJNdUmO3kNHFiz2xxDfbT6
	 tvd0pUwijDF5NsxSfnQg0+5O28O/JlaNXWe3NLCrBdl2ewM3PTMJal9HRiTeZm1Qzv
	 4V/LCxKg+O/zg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:54 +0100
Subject: [PATCH v4 41/72] selftests/namespaces: third listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-41-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2006; i=brauner@kernel.org;
 h=from:subject:message-id; bh=16wgRCEaRGE6KnaGWYUsE3X1jinLIZr1ZBK0aXw4RfM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWtL+jccsjOtda3ZU5I7ywrZf0awZigq3JFc+S/p
 qf/FEjrKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMiKdYwM26+4uz5auyhv/pSz
 MyfNkFx4TeWU277DETtibuxkm2+UtJHhv+eky07dRpYeG09O3HjN+bb95GeXavVdcorKmVf+aj+
 2lg0A
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


