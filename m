Return-Path: <linux-fsdevel+bounces-71537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7262CC67A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF597303BEA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CEB339B52;
	Wed, 17 Dec 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2/yKQcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A123358A0;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=uiHCLnF0uAyH1p6fTS7S0/vrE6Dga7qS3iioCbvHHMSYmbS+ifG9Fp6PfPue/+9AaMjxks2sA2sMllfyHkWxf/DFgaOceQgAUilFMRZEflvkQaeczCapNT7wBsmjd2pn7JkJAWFVGnTEXu3Qb1Hm5PQj4ggF/l/GggGWEY5V0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=zCmzNV2VgVZng0qHJyGMBWuMsBOjX52MVm3R4t8BiQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lDav5yTGY3HQ2kYxyq3jONs921YyU0JOLrnwk6MRTDexDwvdrP7NJNX0WTCoZ+PcP7TFRFkg+h+7qFJiTj1j8Jv1Sfp4iodOvsS69g8aHcscVJ3oPkqDPNGy0KNcRM4pr6CrddiO+dtfPnBbEBo7jaghhST894taFfLIYbTXSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2/yKQcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F28ADC19422;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958738;
	bh=zCmzNV2VgVZng0qHJyGMBWuMsBOjX52MVm3R4t8BiQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V2/yKQcOEVwqzDZLZYSI/JiYPOu4bs3wOJAUICqVxoAaDAd0Ub/tjaJLMp8KnSqmn
	 N1E6jYHyLOugcmI+EslxWPSXRdIV+sCrj764vcnvC9V96fFyaGTIZxoKe6rmnyjTes
	 WXeiNh6JB8Vpnq/pwj8q54ypugoMWaTkHn78KCbok/HJzYIKVYgXOKtTp67KYrNLDQ
	 VDOk8qg+fEnhU7UYwjd4VScO2ycqNR3oDs7cSe2GflT5aJp8fGHeq8pFlH2lrFssmu
	 gjFkxbWPmULVUhHrFo3r70++vDJmiCY2uPUiZgE+29WkhWgeoCO/5FTztwmhLYIYUY
	 i9o22g0IG93KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB3CD6408A;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:45 +0100
Subject: [PATCH 7/7] sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-7-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7713;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=zCmzNV2VgVZng0qHJyGMBWuMsBOjX52MVm3R4t8BiQA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZE3C8q5hCuRElgiy3Kz7bcRNx3Uslp5aM
 KKm7gXb8MU6aokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRNAAoJELqXzVK3
 lkFPY3sL/jDJ3XaDJoww/90pPcJ5qCUQr4MsAfKAeT13haWJxSgb8A0HJLVVUW4spVyvRa7mCzw
 bHC/HFmdN8ouGylANT7dYtEmmQSPOW9iBBl8Le1jHiN1seyZA6dKjoXrPpl01yCm3mnG7whlnlB
 jaZFPntdelQikij9KpJSDtOQ1qPXouBw+bTkcRE8f+s/e76XIeKAYpF6Yaam/dTECdV957rDiwm
 WfjMrYkcwHonur9LL3M3e812WmGsZX2OBm4FJXqZel6vEyo3HsLWS2H2j9oshdhAWA5n1CwBkoW
 01XaRqT2d8n8l0piVefpUmtGsYTL2k30Wyc6IIJTjx1I/U8QY7p942Zq+w3goS4Jz031He5Rccr
 YJIgBuUUfghh0KTELU/9SPHCA0K37y1oZFmr2Zi8VW2+2aVCZ4Q0/QTFEdKdh68t3O3KIsSG9Fc
 C8Ob+ibJ4AygwU1rqlcyQwUvPpWMk75dHr0CQDTYvHmRz/H0O0zWgrOiE1CyyBV346z+08Zccw4
 DM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove SYSCTL_INT_CONV_CUSTOM and replace it with proc_int_conv. This
converter function expects a negp argument as it can take on negative
values. Update all jiffies converters to use explicit function calls.
Remove SYSCTL_CONV_IDENTITY as it is no longer used.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 46 ++++------------------------------------------
 kernel/sysctl.c        | 47 +++++++++++++++++++++++++++++++++++++++++++----
 kernel/time/jiffies.c  | 39 +++++++++++++++++++++++++++++----------
 3 files changed, 76 insertions(+), 56 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 655fb85ec29278a3a268e363243c7f318bf0e75e..2886fbceb5d635fc7e0282c7467dcf82708919fe 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -59,7 +59,6 @@ extern const int sysctl_vals[];
 #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
 #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
 
-#define SYSCTL_CONV_IDENTITY(val) (val)
 /**
  *
  * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
@@ -73,47 +72,6 @@ extern const int sysctl_vals[];
 #define SYSCTL_USER_TO_KERN(dir) (!!(dir))
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
-#ifdef CONFIG_PROC_SYSCTL
-/**
- * To range check on a converted value, use a temp k_ptr
- * When checking range, value should be within (tbl->extra1, tbl->extra2)
- */
-#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
-			       k_ptr_range_check)			\
-int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
-			   int dir, const struct ctl_table *tbl)	\
-{									\
-	if (SYSCTL_KERN_TO_USER(dir))					\
-		return kern_to_user(negp, u_ptr, k_ptr);		\
-									\
-	if (k_ptr_range_check) {					\
-		int tmp_k, ret;						\
-		if (!tbl)						\
-			return -EINVAL;					\
-		ret = user_to_kern(negp, u_ptr, &tmp_k);		\
-		if (ret)						\
-			return ret;					\
-		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||	\
-		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))	\
-			return -EINVAL;					\
-		WRITE_ONCE(*k_ptr, tmp_k);				\
-	} else								\
-		return user_to_kern(negp, u_ptr, k_ptr);		\
-	return 0;							\
-}
-
-#else // CONFIG_PROC_SYSCTL
-
-#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
-			       k_ptr_range_check)			\
-int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
-			   int dir, const struct ctl_table *tbl)	\
-{									\
-	return -ENOSYS;							\
-}
-
-#endif // CONFIG_PROC_SYSCTL
-
 extern const unsigned long sysctl_long_vals[];
 
 typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
@@ -134,6 +92,10 @@ int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
 			  ulong (*k_ptr_op)(const ulong));
 int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
 			  ulong (*u_ptr_op)(const ulong));
+int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
+		  const struct ctl_table *tbl, bool k_ptr_range_check,
+		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
+		  int (*kern_to_user)(bool *negp, ulong *u_ptr, const int *k_ptr));
 
 int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c3946d7ee6f787855694a0a353c173194ccd5c4b..caee1bd8b2afc0927e0dcdd33c0db41c87518bfb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -515,6 +515,33 @@ int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
 	return 0;
 }
 
+int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
+		  const struct ctl_table *tbl, bool k_ptr_range_check,
+		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
+		  int (*kern_to_user)(bool *negp, ulong *u_ptr, const int *k_ptr))
+{
+	if (SYSCTL_KERN_TO_USER(dir))
+		return kern_to_user(negp, u_ptr, k_ptr);
+
+	if (k_ptr_range_check) {
+		int tmp_k, ret;
+
+		if (!tbl)
+			return -EINVAL;
+		ret = user_to_kern(negp, u_ptr, &tmp_k);
+		if (ret)
+			return ret;
+		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
+		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
+			return -EINVAL;
+		WRITE_ONCE(*k_ptr, tmp_k);
+	} else
+		return user_to_kern(negp, u_ptr, k_ptr);
+	return 0;
+}
+
+
+
 static int sysctl_user_to_kern_int_conv(const bool *negp, const ulong *u_ptr,
 					int *k_ptr)
 {
@@ -526,10 +553,22 @@ static int sysctl_kern_to_user_int_conv(bool *negp, ulong *u_ptr, const int *k_p
 	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, NULL);
 }
 
-static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
-			      sysctl_kern_to_user_int_conv, false)
-static SYSCTL_INT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_int_conv,
-			      sysctl_kern_to_user_int_conv, true)
+static int do_proc_int_conv(bool *negp, unsigned long *u_ptr, int *k_ptr,
+			    int dir, const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+			     sysctl_user_to_kern_int_conv,
+			     sysctl_kern_to_user_int_conv);
+
+}
+
+static int do_proc_int_conv_minmax(bool *negp, unsigned long *u_ptr, int *k_ptr,
+				   int dir, const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
+			     sysctl_user_to_kern_int_conv,
+			     sysctl_kern_to_user_int_conv);
+}
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 825e4c9fd26a2c8964b40509f3a5129c2b3b9f88..a5c7d15fce72fd2c8c8a0e0b9e40901534152124 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -156,17 +156,36 @@ static int sysctl_k2u_int_conv_ms(bool *negp, ulong *u_ptr, const int *k_ptr)
 	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, sysctl_jiffies_to_msecs);
 }
 
+static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
+				    int dir, const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+			     sysctl_u2k_int_conv_hz, sysctl_k2u_int_conv_hz);
+}
 
-static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_u2k_int_conv_hz,
-			      sysctl_k2u_int_conv_hz, false)
-static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
-			      sysctl_u2k_int_conv_userhz,
-			      sysctl_k2u_int_conv_userhz, false)
-static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_u2k_int_conv_ms,
-			      sysctl_k2u_int_conv_ms, false)
-static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
-			      sysctl_u2k_int_conv_ms,
-			      sysctl_k2u_int_conv_ms, true)
+static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
+					   int *k_ptr, int dir,
+					   const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+			     sysctl_u2k_int_conv_userhz,
+			     sysctl_k2u_int_conv_userhz);
+}
+
+static int do_proc_int_conv_ms_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
+				       int dir, const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);
+}
+
+static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
+					      int *k_ptr, int dir,
+					      const struct ctl_table *tbl)
+{
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);
+}
 
 #else // CONFIG_PROC_SYSCTL
 static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,

-- 
2.50.1



