Return-Path: <linux-fsdevel+bounces-66260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A151C1A609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32BA3580A53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B958A38288A;
	Wed, 29 Oct 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji+buok9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5842E339B;
	Wed, 29 Oct 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740677; cv=none; b=cHWvFgJufqpMABzLOpkugYE2OenR5+bzcbqtPMqoENtCu1QOuF9w6xrLyt/fUPr45d6/boPFHOg9WUp7t0tVoz7NAmxHZB7PR8C0a+5sUUyErb8UoWRi5ff+SAF1kDbeowyl6CDGVzulrVix/SbWxpOOCBsoAuJ2FbFdVaTkzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740677; c=relaxed/simple;
	bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jUDmfM638DFEPIWcOy77GYo60sVYEdj6N0SoX0D6fiNf4Ss289l53UIGjkkvbilELwXBN1BgcmqrYS0odxP9iIo8c9umLQiC+hWIdCM/A/rqNkbcb3NzQrNSDq0LbnBYP0jgtb8etxLm2SJxxGljnWeXcYJsUbRhjmJt4mB+H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji+buok9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDA2C4CEFD;
	Wed, 29 Oct 2025 12:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740676;
	bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ji+buok9FQwu3sc6mKYwAtx20blAq5aaOZcuG5QpgZtUMfmAd9TNkyeYdIfhuD5e3
	 9FfuGgyUzYIC5WxfWN/4imol0BSg6ImUtV1A/+69ht75FYpeYJd0Pb9SKAy0EiDXPv
	 Kcy9wMOAbThoP5yGzc67hxHMg6K6jVKcKGYDGo5SWL/EoXL6XL4UaqZJPWnSI9rCLn
	 B0OFO+xbX3ReF1Y3dfQxKWYVvyJevF7X2qOz3RhoO1D5MhVtzklc0f/74bsAEBwDfI
	 9+4SQKPKFlJ0GxZaxkwE6LsvEkuKC4B1s6NnsbxUZ8sw7kV2X/De9P21CKGbLeOoVF
	 hecfYN+nK2jLg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:21:00 +0100
Subject: [PATCH v4 47/72] selftests/namespaces: ninth listns() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-47-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EesZuqsIPfrlBbuqThECgtbHVtp6afgnRdhVk6MbMkE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfXJHRS+s8Fv5f2vLx9LTK3MftnPkRpuzzmp6Ipq8
 v77EpwbOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS9p/hv4v9xhYusad+b1tf
 ML4s+hI1aXFb6UOrB5v/nbxguFTOZz4jw+ytbbZRbzUVJr/Qt07Sf8ejb/JchPVaQ3BmS0Bx6Kz
 5bAA=
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


