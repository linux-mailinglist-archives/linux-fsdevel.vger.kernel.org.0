Return-Path: <linux-fsdevel+bounces-6908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AF81E379
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 01:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC66C287D62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CE456399;
	Tue, 26 Dec 2023 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8oIyvgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7775C96;
	Tue, 26 Dec 2023 00:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B85C433C9;
	Tue, 26 Dec 2023 00:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550135;
	bh=INCFmxnzVcno2G0uByDm+uObuNwYrETLxoR9bzDGLNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8oIyvgvfnQwlB4oHLhVV/XkivkBINuim6lbQljfJ1RkoilpNgDhP8Ub5MUurJEqZ
	 3YANEztfB9K5jpk8WBL7soFqBvEuNVeL7UKxJwSzCynT3vN9+Zmy9sTh79JVd4kjhW
	 UKWxvRFh9MbcDjbO6UtFhY83ERK0wC3yhFY2EbBIiqJ8IucsZBfYK9TD/s483w8WG8
	 cVfj8HjPw56BWGwP7b8LhMkj6E6lXxEnItm/4LbCbi/Jc+GrS4pH9ynf7hOKai3Hdy
	 jolGT6UWSZaoN+igRe7F8b6KqkuG91HNoexCjpayvhHTTFFOj53Yu0lHXuyK/6Lbki
	 QiaBJnXIkvo5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zhenghan Wang <wzhmmmmm@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 39/39] ida: Fix crash in ida_free when the bitmap is empty
Date: Mon, 25 Dec 2023 19:19:29 -0500
Message-ID: <20231226002021.4776-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit af73483f4e8b6f5c68c9aa63257bdd929a9c194a ]

The IDA usually detects double-frees, but that detection failed to
consider the case when there are no nearby IDs allocated and so we have a
NULL bitmap rather than simply having a clear bit.  Add some tests to the
test-suite to be sure we don't inadvertently reintroduce this problem.
Unfortunately they're quite noisy so include a message to disregard
the warnings.

Reported-by: Zhenghan Wang <wzhmmmmm@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/idr.c      |  2 +-
 lib/test_ida.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index 13f2758c23773..da36054c3ca02 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -508,7 +508,7 @@ void ida_free(struct ida *ida, unsigned int id)
 			goto delete;
 		xas_store(&xas, xa_mk_value(v));
 	} else {
-		if (!test_bit(bit, bitmap->bitmap))
+		if (!bitmap || !test_bit(bit, bitmap->bitmap))
 			goto err;
 		__clear_bit(bit, bitmap->bitmap);
 		xas_set_mark(&xas, XA_FREE_MARK);
diff --git a/lib/test_ida.c b/lib/test_ida.c
index b068806259615..55105baa19da9 100644
--- a/lib/test_ida.c
+++ b/lib/test_ida.c
@@ -150,6 +150,45 @@ static void ida_check_conv(struct ida *ida)
 	IDA_BUG_ON(ida, !ida_is_empty(ida));
 }
 
+/*
+ * Check various situations where we attempt to free an ID we don't own.
+ */
+static void ida_check_bad_free(struct ida *ida)
+{
+	unsigned long i;
+
+	printk("vvv Ignore \"not allocated\" warnings\n");
+	/* IDA is empty; all of these will fail */
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single value entry */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 3, GFP_KERNEL) != 3);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a single bitmap */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, 1023, GFP_KERNEL) != 1023);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+
+	/* IDA contains a tree */
+	IDA_BUG_ON(ida, ida_alloc_min(ida, (1 << 20) - 1, GFP_KERNEL) != (1 << 20) - 1);
+	ida_free(ida, 0);
+	for (i = 0; i < 31; i++)
+		ida_free(ida, 1 << i);
+	printk("^^^ \"not allocated\" warnings over\n");
+
+	ida_free(ida, 3);
+	ida_free(ida, 1023);
+	ida_free(ida, (1 << 20) - 1);
+
+	IDA_BUG_ON(ida, !ida_is_empty(ida));
+}
+
 static DEFINE_IDA(ida);
 
 static int ida_checks(void)
@@ -162,6 +201,7 @@ static int ida_checks(void)
 	ida_check_leaf(&ida, 1024 * 64);
 	ida_check_max(&ida);
 	ida_check_conv(&ida);
+	ida_check_bad_free(&ida);
 
 	printk("IDA: %u of %u tests passed\n", tests_passed, tests_run);
 	return (tests_run != tests_passed) ? 0 : -EINVAL;
-- 
2.43.0


