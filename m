Return-Path: <linux-fsdevel+bounces-71734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21F0CCFC28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63B3130E3140
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6533A71F;
	Fri, 19 Dec 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn14jkGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D03337B84;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766146572; cv=none; b=j3EyK9/BijjvDJy4vnSqIrIa1om9QM4XcXpy2kkIXtVONyXEYxuDlnKH34Zg923OFZxqa6neerTrEoYojY//BjHg2Yi8s9/R1bb2lr+1iUXXHe4aKc3kkjDzXiJe4zok7D79bXr2hAWKNFjr6HJWE0WAJqDsFlClrPPl9wvWZ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766146572; c=relaxed/simple;
	bh=C2CiSX+3NOlsc9EOUTFYNZR5sIzoS6WVYi1ixR9Wg44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGUO/5LZNh2qjC1yu759OZMOarSdpRL3YVWTcGCvqQ/t9EYnBAqqxMrQacvSLfe4wS9l68TzW0YZZJ9TCHfPwNqOdhQHPPs5l9WqtnkBDiVE355nO9iNh4aqt4lzas3JcuK3+TSlUBbApKYN8XGgxTxe7IIxKkhAsaKN/wh4XR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn14jkGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CF10C116D0;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766146571;
	bh=C2CiSX+3NOlsc9EOUTFYNZR5sIzoS6WVYi1ixR9Wg44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fn14jkGZKoTjFWyXoZIZG6hNTCWgDW9PZq6l4zjWQzN3nHaAZWLdFUkEqWd7P2qOw
	 jI4qMX5xKDj5wK52FDwaIH1a62SOy2zSpCozNJkAccxjzfw7Ktxy4OuHeSYAwjtJVK
	 aOLsBEgJUYDDyVl3QIB9vrE3lRYQlrjPDSyMScGfNi5ETgOZQvbAmzDyNVx7cY7gEM
	 kzKYikMYxE+91qfPQUydFT40BtO0reodwtOXH5bi+18yhQtuTS1ptE+0bqkKXyS59R
	 HTNOfyI/2XXfUgri7y2tpZYZgpdvoGeWTcTg3FXs1FpT483U8P/O5XC/7l3Qr+/yFd
	 /IRbzUsRwmFfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A956D78761;
	Fri, 19 Dec 2025 12:16:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 19 Dec 2025 13:15:53 +0100
Subject: [PATCH 2/9] sysctl: Replace do_proc_dointvec with a type-generic
 macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-jag-dovec_consolidate-v1-2-1413b92c6040@kernel.org>
References: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
In-Reply-To: <20251219-jag-dovec_consolidate-v1-0-1413b92c6040@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4959;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=C2CiSX+3NOlsc9EOUTFYNZR5sIzoS6WVYi1ixR9Wg44=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlFQgVv4z9XDuX1mY5xQRjIopXVim68ykErq
 95+2gBockDcrIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpRUIFAAoJELqXzVK3
 lkFP2lEMAJUgaWSzGeFvf8UYl30vF9V7ekLPEMAKE0htODrEJoJCKpJBAlv6Abj7VbKR772RFje
 1HWOO6M8IxNZrsQ0iBSayj1SiSrfvcwx8FYJxlywSr5Wr3BwfeclN0dWbgI3tVHVfW1ymdwDEuA
 +TZtN/COJZRaGck4Kd/GYYqf95SgoUKhV96tnhhDzGh2xML4jfBItN4O2DK2YZkoiWlTNfUTVpt
 FOrc1kSl4C3UrCCRiYu5vg6kGsVkl33hWxVmPkvsn7qeRBmxZ/oEjB0Hq1s/+o2g9m87QcuEjsh
 WnLK8N4I1oA5nUy3XwL9mlb+5oDa1B8FT+IQs26bc4RjnD8cZlZ92n+QTs88KwkYJj710u33a7n
 R+MaW3Qp2jvMKRw+GcgQu8pkemfEEqP0Zzl9aewvTU1biFMfJBxCaknqJllvIr6FKWcGK7JQcgl
 iNAVCPDbUpHiWcOIXcdAcIG3CUYfV9dAQmeRLIcyMICjZz5fhChubyJJ5FlYq3mpJ3sesjxGHS3
 0g=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replaces do_proc_dointvec with do_proc_dotypevec macro. For now, it only
generates the integer function, but it will bring together the logic for
int, uint and ulong proc vector functions. It is parametrized on the
kernel pointer type being processed and generates a "do_proc_do##T##vec"
(where T is the type) function. The parametrization is needed for
advancing the for loop with "++" and affects the type of the k_ptr
argument in the converter call back function. Add a comment to clarify
that the macro is **not** designed to be exported outside of sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 142 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 75 insertions(+), 67 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 284ad6c277e8b52177cca3153acf02ff39de17f0..66db2ac69a91ac4b200cb8906dcb76209bee28bb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -572,75 +572,83 @@ static int do_proc_int_conv_minmax(bool *negp, unsigned long *u_ptr, int *k_ptr,
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
-static int do_proc_dointvec(const struct ctl_table *table, int dir,
-		  void *buffer, size_t *lenp, loff_t *ppos,
-		  int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
-			      int dir, const struct ctl_table *table))
-{
-	int *i, vleft, first = 1, err = 0;
-	size_t left;
-	char *p;
-
-	if (!table->data || !table->maxlen || !*lenp ||
-	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
-		*lenp = 0;
-		return 0;
-	}
-
-	i = (int *) table->data;
-	vleft = table->maxlen / sizeof(*i);
-	left = *lenp;
-
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (proc_first_pos_non_zero_ignore(ppos, table))
-			goto out;
-
-		if (left > PAGE_SIZE - 1)
-			left = PAGE_SIZE - 1;
-		p = buffer;
-	}
-
-	for (; left && vleft--; i++, first=0) {
-		unsigned long lval;
-		bool neg;
-
-		if (SYSCTL_USER_TO_KERN(dir)) {
-			proc_skip_spaces(&p, &left);
-
-			if (!left)
-				break;
-			err = proc_get_long(&p, &left, &lval, &neg,
-					     proc_wspace_sep,
-					     sizeof(proc_wspace_sep), NULL);
-			if (err)
-				break;
-			if (conv(&neg, &lval, i, 1, table)) {
-				err = -EINVAL;
-				break;
-			}
-		} else {
-			if (conv(&neg, &lval, i, 0, table)) {
-				err = -EINVAL;
-				break;
-			}
-			if (!first)
-				proc_put_char(&buffer, &left, '\t');
-			proc_put_long(&buffer, &left, lval, neg);
-		}
-	}
-
-	if (SYSCTL_KERN_TO_USER(dir) && !first && left && !err)
-		proc_put_char(&buffer, &left, '\n');
-	if (SYSCTL_USER_TO_KERN(dir) && !err && left)
-		proc_skip_spaces(&p, &left);
-	if (SYSCTL_USER_TO_KERN(dir) && first)
-		return err ? : -EINVAL;
-	*lenp -= left;
-out:
-	*ppos += *lenp;
-	return err;
+/*
+ * Do not export this macro outside the sysctl subsys.
+ * It is meant to generate static functions only
+ */
+#define do_proc_dotypevec(T) \
+static int do_proc_do##T##vec(const struct ctl_table *table, int dir, \
+		  void *buffer, size_t *lenp, loff_t *ppos, \
+		  int (*conv)(bool *negp, ulong *u_ptr, T *k_ptr, \
+			      int dir, const struct ctl_table *table)) \
+{ \
+	T *i; \
+	int vleft, first = 1, err = 0; \
+	size_t left; \
+	char *p; \
+\
+	if (!table->data || !table->maxlen || !*lenp || \
+	    (*ppos && SYSCTL_KERN_TO_USER(dir))) { \
+		*lenp = 0; \
+		return 0; \
+	} \
+\
+	i = (typeof(i)) table->data; \
+	vleft = table->maxlen / sizeof(*i); \
+	left = *lenp; \
+\
+	if (SYSCTL_USER_TO_KERN(dir)) { \
+		if (proc_first_pos_non_zero_ignore(ppos, table)) \
+			goto out; \
+\
+		if (left > PAGE_SIZE - 1) \
+			left = PAGE_SIZE - 1; \
+		p = buffer; \
+	} \
+\
+	for (; left && vleft--; i++, first = 0) { \
+		unsigned long lval; \
+		bool neg; \
+\
+		if (SYSCTL_USER_TO_KERN(dir)) { \
+			proc_skip_spaces(&p, &left); \
+\
+			if (!left) \
+				break; \
+			err = proc_get_long(&p, &left, &lval, &neg, \
+					     proc_wspace_sep, \
+					     sizeof(proc_wspace_sep), NULL); \
+			if (err) \
+				break; \
+			if (conv(&neg, &lval, i, dir, table)) { \
+				err = -EINVAL; \
+				break; \
+			} \
+		} else { \
+			if (conv(&neg, &lval, i, dir, table)) { \
+				err = -EINVAL; \
+				break; \
+			} \
+			if (!first) \
+				proc_put_char(&buffer, &left, '\t'); \
+			proc_put_long(&buffer, &left, lval, neg); \
+		} \
+	} \
+\
+	if (SYSCTL_KERN_TO_USER(dir) && !first && left && !err) \
+		proc_put_char(&buffer, &left, '\n'); \
+	if (SYSCTL_USER_TO_KERN(dir) && !err && left) \
+		proc_skip_spaces(&p, &left); \
+	if (SYSCTL_USER_TO_KERN(dir) && first) \
+		return err ? : -EINVAL; \
+	*lenp -= left; \
+out: \
+	*ppos += *lenp; \
+	return err; \
 }
 
+do_proc_dotypevec(int)
+
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *u_ptr,

-- 
2.50.1



