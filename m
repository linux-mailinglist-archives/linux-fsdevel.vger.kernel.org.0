Return-Path: <linux-fsdevel+bounces-72306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624ECED03C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43C230173AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33A23B62B;
	Thu,  1 Jan 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktwUgJWW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4421D3CC;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=IfSJX6qDu8BmP1N3OWkjfLxCnxnE/Gc+kS9m769YqYvRybcbaBTYoGlqxczN2bUTcadYW7MZLHfE4ilbDCIGtxE31qjDP5qIoTQefzpC/5DGqBjvsQqhbvISp9xy3tA6TGk8DzNI/q+7Z/2YZN4TXbTdXE1sOLRkzL4yTfCMl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIk8RoWAkXIciF7jjO+o3+WPC3G3HBabBOPo0RB1AlA8f49usegbG+3VWGn8NXrmauFjfgy5W25mB8EiNJU2pOdt1cD8puP2LbbkkItM4X0zTCzPz7D+N640GAOkpc9ooZZXhoLgoWJ2xj9s6LOe33pzbRyEx7wPCoMu878Juq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktwUgJWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11FF7C19421;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ktwUgJWWL25+fFa7Br3ubgCx8jyngNlwvZrkcycu31IK25hAkKzDxq1o8CDy/q8LH
	 Oeadh6aB05lvSD/g3BgZbg6fGMF7BM2iK2EO5PfkKmIqEOhl8UedT2yUDBu/q+8Yy3
	 cxaIwGj1HjNXSOnxjWGe2fz2hbzlBnXlwwJik0sONrlwDQ3+F8nArzlqTHVoP0OUSZ
	 jbfBXYl1C92sZ5DgtayxauaoE6r4HoOvqDfMVnDOqZf4CJm78VUFaTaRqHNVnGmBez
	 TSu9D1W2Lsp0uzbavQixoFa/majQLknm+VkPFiddmnPEyDaxne/j6Ok6+7NXHoy3MQ
	 qE0kpl3hVI+Iw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B1EEB599;
	Thu,  1 Jan 2026 12:57:21 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:05 +0100
Subject: [PATCH v2 1/9] sysctl: Move default converter assignment out of
 do_proc_dointvec
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-1-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BttYzFF+xjDCiXPSwOn5xmsY105yRYbvY3nWA/ZGsJo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWbyopSbpjacVeuho9vpVpKianahjMT25EN
 y0uNhNJdmNEj4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8qAAoJELqXzVK3
 lkFPBUML/0D4SkMtKjl6Dt82vq7nvCRL7oKLZjkRsAuqCeOgUNgWjCV2IdQsp/4Lwa1Mw8LZSfq
 9lO/4624pX9vJeQ9xDtxl3ZmYFLP8wQU+BtyV6+mM+647Exdvaoof2qt7bg5vtF5YmQ7bStBMPu
 udREwH3xwKWttbRbHDuNlsQb4OX+ILbRKn3gXgROmpqOErid/8cmYsZwZAXR9ioJbgXevY79MSW
 7S6xc72zaHU5k2vaSUFvXuTPByEpfYbTsCVRAbfmcAIwqDMqNc7JtP+xUWrLsu8B4P+NXOxqTKm
 sMME7pe1zCM5X0Lub2wtqf55OqFlan1tEMKvQM8rqq3usIV18zQxLIk3v98gaIjvtZhZPnF/BLC
 hSV1/pbu151ObTOFCaLLjjHtL7G1XcrcCoi7LE77LSs570Vh6ZFYVsAsSOGzJkn2VFWTtCy7cM1
 n1tb7Z6f/gSMLH+xiKgG3j4FxzQIjukVYQe5I8Z1+ELsRwt1u/qSPS7oZ/WRYb2LFDRlMiKaDS6
 Vo=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move the converter assignment out of do_proc_dointvec into the caller.
Both the test for NULL and the assignment are meant to stay within the
sysctl.c context. This is in preparation of using a typed macro to for
the integer proc vector function.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index caee1bd8b2afc0927e0dcdd33c0db41c87518bfb..284ad6c277e8b52177cca3153acf02ff39de17f0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -591,9 +591,6 @@ static int do_proc_dointvec(const struct ctl_table *table, int dir,
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
 
-	if (!conv)
-		conv = do_proc_int_conv;
-
 	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
 			goto out;
@@ -840,7 +837,7 @@ int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, dir, buffer, lenp, ppos, NULL);
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos, do_proc_int_conv);
 }
 
 /**
@@ -1074,6 +1071,8 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 				   int dir, const struct ctl_table *table))
 {
+	if (!conv)
+		conv = do_proc_int_conv;
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
 }
 

-- 
2.50.1



