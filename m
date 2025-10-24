Return-Path: <linux-fsdevel+bounces-65485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 482B1C05E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1294ED6C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF43502B6;
	Fri, 24 Oct 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro+lCC5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B231579F;
	Fri, 24 Oct 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303409; cv=none; b=OBFK6oTvcDlISfqx1JDup/XnGr+m2WlmNsb8k8gPCyZG0PCu7DEnqUh7H7riM5nippi2zcI3VvnTqa8QCRE7yx4xWTMkuOaMFNWEStCJBeXtxzQ3FUZqRrU4FicY834E7ifl7S2acD8CR+6Lsm8MqjHZRZ/JsHf4qw9xjisDheo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303409; c=relaxed/simple;
	bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9ues161jS5XHDN3EV4YbR91w1Sy2o26y1Da8YILTe+JKCOYpUSABMh+OI3OL31RbKM8hd3XY4Jn9W9RPsegf2Xr/BWg/52g9kssyfO9Ws7ZyrssEFiDDhxE1hiywvA1KANAdQslDcNB6DtIo7BoNZym3Br8eW3tBcZIw9VS8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro+lCC5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F32C4CEFF;
	Fri, 24 Oct 2025 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303408;
	bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ro+lCC5Yf7Hlct+M1M8L4C0hoBhxgozPARPCSXSmVQ/DS6KgSJqTNia0jJ0s5hXdQ
	 HzDoVMclkyOge60jAoeVQZM3BkYO+UAMtvVcoDQ0wnD6mDxo6CjqSsSo4/VEFAmEo1
	 J+oQrxW5xzZ3ZsdFWiNTRmXhFNqnlbzn2odbsBDIV12QlzLaQ1+XmspvsR88qEAv4+
	 ajYs29y5vI92uTrV3woQObuWl4U7zSH2D7W1ta1v9uKWsAmp27bMrLAjdESIe4VUuQ
	 z7eBDpQYorGDdYcoj4Gg7mS8R0dDLK1mMeDco9mMoYgpka1s2y9yUAzO2Sbn3I8/JJ
	 DVAm1cejzYyKw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:53:14 +0200
Subject: [PATCH v3 45/70] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-45-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrjsXrsLrFwTqyUz2S/1ae9H7fHtE2sfb7F2iCs4
 NmMw6pmHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRdGb4H5V5LWPn3t6TK6W3
 hnEZ+572D0me9nLC30Nd51dnzTuzJIjhn2acwo99OisbfN76CxxYnMJjUrtxxiczRaHzVyPf3TK
 Q4QUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test error cases for listns().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/namespaces/listns_test.c | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/namespaces/listns_test.c b/tools/testing/selftests/namespaces/listns_test.c
index d3be6f97d34e..8a95789d6a87 100644
--- a/tools/testing/selftests/namespaces/listns_test.c
+++ b/tools/testing/selftests/namespaces/listns_test.c
@@ -627,4 +627,53 @@ TEST(listns_hierarchical_visibility)
 	waitpid(pid, &status, 0);
 }
 
+/*
+ * Test error cases for listns().
+ */
+TEST(listns_error_cases)
+{
+	struct ns_id_req req = {
+		.size = sizeof(req),
+		.spare = 0,
+		.ns_id = 0,
+		.ns_type = 0,
+		.spare2 = 0,
+		.user_ns_id = 0,
+	};
+	__u64 ns_ids[10];
+	int ret;
+
+	/* Test with invalid flags */
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0xFFFF);
+	if (errno == ENOSYS) {
+		/* listns() not supported, skip this check */
+	} else {
+		ASSERT_LT(ret, 0);
+		ASSERT_EQ(errno, EINVAL);
+	}
+
+	/* Test with NULL ns_ids array */
+	ret = sys_listns(&req, NULL, 10, 0);
+	ASSERT_LT(ret, 0);
+
+	/* Test with invalid spare field */
+	req.spare = 1;
+	ret = sys_listns(&req, ns_ids, ARRAY_SIZE(ns_ids), 0);
+	if (errno == ENOSYS) {
+		/* listns() not supported, skip this check */
+	} else {
+		ASSERT_LT(ret, 0);
+		ASSERT_EQ(errno, EINVAL);
+	}
+	req.spare = 0;
+
+	/* Test with huge nr_ns_ids */
+	ret = sys_listns(&req, ns_ids, 2000000, 0);
+	if (errno == ENOSYS) {
+		/* listns() not supported, skip this check */
+	} else {
+		ASSERT_LT(ret, 0);
+	}
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3


