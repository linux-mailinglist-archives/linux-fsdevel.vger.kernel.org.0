Return-Path: <linux-fsdevel+bounces-63964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAABD3321
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44B4189D5E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AA6307492;
	Mon, 13 Oct 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZNHLTiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6DD3064B5;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=XipFsE8r+9AwWiQ/CZ6EuTxo4U8b2C1nbUhRMVMjo1OGdz6H45qdxo1MdUA2ZDokiJdsj4A+CWQpK1b2Em8NkwmCGadFOiu7v5WDQX0uarZ9G1atVYIWUFETRp2A4KM/Hj4GDLFU41m3T0fXyMYrtlLdkjtQLhXKR3Od7gcRmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=WFmYwNqRtEEV71HErtXjnELu0hh+bKYykNpfWVGpcO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=II5nzJo5TebGNhu5FYKi8wfe3al+gjK9CIgWlbzXGRF3LsFkYhfjELhsScse27mueGWmy92t4t9tVUECbPPNvpDplOUnRs2mnT/jf+HlJN64YE0R8l+74KkYYnUAgA//l9nOkfHqTUKfvesc8CumSiSbS8MhGbS/Tn/OWSaMtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZNHLTiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55C98C19424;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=WFmYwNqRtEEV71HErtXjnELu0hh+bKYykNpfWVGpcO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YZNHLTiqwdKK3nithG9TiIiULn/p8sdDGbmWMp1YV2/hgLPwSQStiyW1vl5TWpJNF
	 mtJpo5bbq6pZwKkSx9FnWNZAmQZWqMm3bbve3Y/bQazXWSPsQnIcXQGPDVJDUqidpG
	 +q2C/PIRnYuOizFdGDd0xNyoXzJ2GWXEjG9UZEjuOMdUud2rGchSSMUm/E8xchaP3j
	 mX571tNiaWVJg2Og/u4JQRqxobXVLlxOi9P0o81o0Rryo0xNGGojNKr+BkqrBTrE58
	 YfAZMFa6BEUW40G03sXHfsISEL6DwoMxt3sjFnfqSVBUQzzLbwhlUnoWfK4DE/3buV
	 qOn1dnOVfc2vg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6FCCD190;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:58 +0200
Subject: [PATCH 8/8] sysctl: Add optional range checking to
 SYSCTL_INT_CONV_CUSTOM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-8-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6108;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=WFmYwNqRtEEV71HErtXjnELu0hh+bKYykNpfWVGpcO8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/df2qPSmaNQsmWp35kE3R6r63EL/tLd3D
 jxjLSoMwd++h4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3XAAoJELqXzVK3
 lkFPJi8MAIsUkiq0T8pTVzJVdJ/BJTkqWnf5Um2Na/zccXAaszr1sCjtpLDsIvXs+lUxaBiARZE
 P4eq/fFNTFmaT4sq4jYdC3EPtORgZ61iyjZzGI3553loRzVKs46qzAs3U9XToNARkYbLxaEpNg8
 WLzOrqMC0opJtspwPgs2utluKOs9GALRizcUaGF32CatM8H02sG4G3wF3Fz3eY1bYTe6TvtvYKc
 96LMMkjvkG6mPQ3DGXyq5JYJ8ZHyDfv+JgIIHIuGzEKnhB/Zpu0DR2AJGLQOUnmMXJvwA/LNqyt
 74asicQIoxXhTItx6XsxZOoQyegEakioEs033CKM80g4mcMuOpwwU5cp+hT3OtNIGMcOFjg6SAL
 vC+LrNATNM6heKtwR6O9Ps4v+kKafUcVoPvsqYwSPhiG+BFcGp+sxdx55R9x7WXXbKljQryrr1r
 DQSqbHwsg+grMOmu+zyAfPiNyBTJILnJM+CsNIgzRfUe3ed6Yx6Qnik6BNyUkxpL5FrNrOgWz57
 Ro=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Extend the SYSCTL_INT_CONV_CUSTOM macro with a k_ptr_range_check
parameter to conditionally generate range validation code. When enabled,
validation is done against table->extra1 (min) and table->extra2 (max)
bounds before assignment. Add base minmax and ms_jiffies_minmax
converter instances that utilize the range checking functionality.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 106 +++++++++++++++++++++-----------------------------------
 1 file changed, 40 insertions(+), 66 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e7dc4b79e93ea9ab929ce0465143aed74be444e5..60f7618083516a24530f46f6eabccd108e90c74f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -402,6 +402,34 @@ int sysctl_kern_to_user_int_conv##name(bool *negp,		\
 	return 0;						\
 }
 
+/**
+ * To range check on a converted value, use a temp k_ptr
+ * When checking range, value should be within (tbl->extra1, tbl->extra2)
+ */
+#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
+			       k_ptr_range_check)			\
+int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
+			   int dir, const struct ctl_table *tbl)	\
+{									\
+	if (SYSCTL_KERN_TO_USER(dir))					\
+		return kern_to_user(negp, u_ptr, k_ptr);		\
+									\
+	if (k_ptr_range_check) {					\
+		int tmp_k, ret;						\
+		if (!tbl)						\
+			return -EINVAL;					\
+		ret = user_to_kern(negp, u_ptr, &tmp_k);		\
+		if (ret)						\
+			return ret;					\
+		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||	\
+		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))	\
+			return -EINVAL;					\
+		WRITE_ONCE(*k_ptr, tmp_k);				\
+	} else								\
+		return user_to_kern(negp, u_ptr, k_ptr);		\
+	return 0;							\
+}
+
 #define SYSCTL_CONV_IDENTITY(val) val
 #define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
 #define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)
@@ -418,24 +446,21 @@ static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
 static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
 static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
 
-#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user)	\
-int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
-			   int dir, const struct ctl_table *table)	\
-{									\
-	if (SYSCTL_USER_TO_KERN(dir))					\
-		return user_to_kern(negp, u_ptr, k_ptr);		\
-	return kern_to_user(negp, u_ptr, k_ptr);			\
-}
-
 static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
-			      sysctl_kern_to_user_int_conv)
+			      sysctl_kern_to_user_int_conv, false)
 static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_user_to_kern_int_conv_hz,
-			      sysctl_kern_to_user_int_conv_hz)
+			      sysctl_kern_to_user_int_conv_hz, false)
 static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
 			      sysctl_user_to_kern_int_conv_userhz,
-			      sysctl_kern_to_user_int_conv_userhz)
+			      sysctl_kern_to_user_int_conv_userhz, false)
 static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_user_to_kern_int_conv_ms,
-			      sysctl_kern_to_user_int_conv_ms)
+			      sysctl_kern_to_user_int_conv_ms, false)
+
+static SYSCTL_INT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_int_conv,
+			      sysctl_kern_to_user_int_conv, true)
+static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
+			      sysctl_user_to_kern_int_conv_ms,
+			      sysctl_kern_to_user_int_conv_ms, true)
 
 static int do_proc_douintvec_conv(unsigned long *u_ptr,
 				  unsigned int *k_ptr, int dir,
@@ -721,32 +746,6 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 				 do_proc_douintvec_conv);
 }
 
-static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *u_ptr,
-					int *k_ptr, int dir,
-					const struct ctl_table *table)
-{
-	int tmp, ret, *min, *max;
-	/*
-	 * If writing to a kernel variable, first do so via a temporary
-	 * local int so we can bounds-check it before touching *k_ptr.
-	 */
-	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
-
-	ret = do_proc_int_conv(negp, u_ptr, ip, dir, table);
-	if (ret)
-		return ret;
-
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		min = (int *) table->extra1;
-		max = (int *) table->extra2;
-		if ((min && *min > tmp) || (max && *max < tmp))
-			return -EINVAL;
-		WRITE_ONCE(*k_ptr, tmp);
-	}
-
-	return 0;
-}
-
 /**
  * proc_dointvec_minmax - read a vector of integers with min/max values
  * @table: the sysctl table
@@ -768,7 +767,7 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_dointvec_minmax_conv);
+				do_proc_int_conv_minmax);
 }
 
 static int do_proc_douintvec_minmax_conv(unsigned long *u_ptr,
@@ -994,31 +993,6 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 					 lenp, ppos, HZ, 1000l);
 }
 
-static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *u_ptr,
-						int *k_ptr, int dir,
-						const struct ctl_table *table)
-{
-	int tmp, ret, *min, *max;
-	/*
-	 * If writing to a kernel var, first do so via a temporary local
-	 * int so we can bounds-check it before touching *k_ptr.
-	 */
-	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
-
-	ret = do_proc_int_conv_ms_jiffies(negp, u_ptr, ip, dir, table);
-	if (ret)
-		return ret;
-
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		min = (int *) table->extra1;
-		max = (int *) table->extra2;
-		if ((min && *min > tmp) || (max && *max < tmp))
-			return -EINVAL;
-		*k_ptr = tmp;
-	}
-	return 0;
-}
-
 /**
  * proc_dointvec_jiffies - read a vector of integers as seconds
  * @table: the sysctl table
@@ -1045,7 +1019,7 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-			do_proc_dointvec_ms_jiffies_minmax_conv);
+			do_proc_int_conv_ms_jiffies_minmax);
 }
 
 /**

-- 
2.50.1



