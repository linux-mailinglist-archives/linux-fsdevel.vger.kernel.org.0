Return-Path: <linux-fsdevel+bounces-64424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDCBE7303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7030B1AA108B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9922D3750;
	Fri, 17 Oct 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHbgBImI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348B29D27D;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=IrIDsuMV/E2uigHmMCHl8gdgy6MxgTrVcFxbNsPtQepNKzzt/+QNTYdUVs2Tfe1kedF8DqF32U4Xge42Y7PC337S90jK5ZbQDtNvZ8Z4xUl4/OR0cx2MNJVKUNWa+nld5aqtL3mYO8DWpDIVqkLbkg+QJ+4Qo8pbiLMz53KilXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=L/WNQp+cqTFMFR8GqruTG1ecQLPCHMDlMjBtlwWYPR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YQkFGs7YsJPP7XTlUx+2tNMKvgVfcPm53Zynjs8RXzKKrX9eLAqIWhlGgFlAjtYPRp+ftln2t+iHHOmZld+9BUbLzlxUfBdx/4MPySrUu5RtigCC0FfrTdKLK9RkRCOayCYsSHRK3T5Pa+ENjKHXz+ox+xZimH2WKOMclMb0zew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHbgBImI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECC3C19422;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689989;
	bh=L/WNQp+cqTFMFR8GqruTG1ecQLPCHMDlMjBtlwWYPR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lHbgBImINIa6ujW4J9eVQp10rGAn0P2wdkTCdu6Z+aQki0lQda+R5Id2GU2ic6JJ8
	 f7eKj+ieOHKw0AHozFSEUcQ6hBI3GtKYCBvVI8kzG5P4S+8Br5q72ZqZ5DYGNPxAKt
	 sgpbPQL5WG7IVlz8IVlG7mYtRnrZpI8YZ2QvHamsvI17rpcM9oR+5uwxb7z2398Raq
	 e4Yo9VdxqvrmvB/WkMYNSH93/SH9l3M14oS7S0xhv0e+fzJLqcJcov1P8jOqkvE+mm
	 KONXKqKNY9BVGITq28eGxHZlheBeTYtQM9CRwN438an6g5VNIqNGNEmeDL+sO8dP/c
	 Q0zfZVJ01ZTlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56B0CCD1A4;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 17 Oct 2025 10:32:14 +0200
Subject: [PATCH 4/7] sysctl: Move jiffies converters to
 kernel/time/jiffies.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-jag-sysctl_jiffies-v1-4-175d81dfdf82@kernel.org>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12841;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=L/WNQp+cqTFMFR8GqruTG1ecQLPCHMDlMjBtlwWYPR8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/0HQm7+FMboOkcASneud8CDpgPxTFRmlR
 uZ39AQwIhL9AIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f9BAAoJELqXzVK3
 lkFPK1sL/ihVRYc2Lhpd9Esx/7If8Ls1bU3rBkzwyIgHEiV70zks07H2uUhZHPonzgQVHUJaDQk
 uep7MywzcbCpyBWBW3vDZoAEfXGuRsQ72sEhFTKNMpkH7uzqzX2Q2gatpHE1JrSdunHVlldIzeC
 GyeOcu7MLTT4MDc41ubmrpx776DP+h8/H+cSG7sd7x9FLLy3TY19eOqAILoRPmV3pRo/0vULMKU
 fE+COsGx8OvwQn09skvoWV5HbMLJJqI/ODgdVyYKQv0D1vxIOz26lOHPoP5SkjtU/6jIgqQS/+x
 W5nonBesm923YenfD310En4vEKdZNyBzEO3w5oznFV5CUmCn/c0UO8pT6b04MBhrvWBxB9N5ylr
 2a4/Mid1fBKXc29wiUS85/ze5Zdi+Tv5/S8JUfyrvM0IIGXEygFeyXYn+bM57X5A2Kwy3BTl3Y4
 Dv3sHGVbWy/YUR6JsKA38wpJZtaVUd+vWT/oOX0Bbb19AZi9d4kUrr/S1FQCI82zO2cI9dlvXq7
 Lg=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move integer jiffies converters (proc_dointvec{_,_ms_,_userhz_}jiffies
and proc_dointvec_ms_jiffies_minmax) to kernel/time/jiffies.c. Error
stubs for when CONFIG_PRCO_SYSCTL is not defined are not reproduced
because all the jiffies converters go through proc_dointvec_conv which
is already stubbed. This is part of the greater effort to move sysctl
logic out of kernel/sysctl.c thereby reducing merge conflicts in
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/jiffies.h |   9 ++++
 include/linux/sysctl.h  |   7 ---
 kernel/sysctl.c         | 124 ------------------------------------------------
 kernel/time/jiffies.c   | 100 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 131 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 91b20788273dfa224d68fbc84388c297b335af47..09886dcbf718873adf3c24d7eb565f1849fcac04 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -611,4 +611,13 @@ extern unsigned long nsecs_to_jiffies(u64 n);
 
 #define TIMESTAMP_SIZE	30
 
+int proc_dointvec_jiffies(const struct ctl_table *table, int dir, void *buffer,
+			  size_t *lenp, loff_t *ppos);
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
+				    void *buffer, size_t *lenp, loff_t *ppos);
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
+				 void *buffer, size_t *lenp, loff_t *ppos);
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
+			     size_t *lenp, loff_t *ppos);
+
 #endif
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index faeeb2feefb83d5b57e67f5cbf2eadf79dd03fb2..4894244ade479a84d736e239e33e0a8d3a0f803d 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -192,13 +192,6 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer
 		size_t *lenp, loff_t *ppos);
 int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 			size_t *lenp, loff_t *ppos);
-int proc_dointvec_jiffies(const struct ctl_table *, int, void *, size_t *, loff_t *);
-int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos);
-int proc_dointvec_userhz_jiffies(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int proc_dointvec_ms_jiffies(const struct ctl_table *, int, void *, size_t *,
-		loff_t *);
 int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int, void *,
 		size_t *, loff_t *);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f3d2385f88494da1e5ba7ee1fbb575d2545d7d84..e00dd55487025fa159eac2f656104c0c843b0519 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -356,36 +356,14 @@ static void proc_put_char(void **buf, size_t *size, char c)
 }
 
 #define SYSCTL_CONV_IDENTITY(val) val
-#define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
-#define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)
 
 static SYSCTL_USER_TO_KERN_INT_CONV(, SYSCTL_CONV_IDENTITY)
 static SYSCTL_KERN_TO_USER_INT_CONV(, SYSCTL_CONV_IDENTITY)
 
-static SYSCTL_USER_TO_KERN_INT_CONV(_hz, SYSCTL_CONV_MULT_HZ)
-static SYSCTL_KERN_TO_USER_INT_CONV(_hz, SYSCTL_CONV_DIV_HZ)
-
-static SYSCTL_USER_TO_KERN_INT_CONV(_userhz, clock_t_to_jiffies)
-static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
-
-static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
-static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
-
 static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
 			      sysctl_kern_to_user_int_conv, false)
-static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_user_to_kern_int_conv_hz,
-			      sysctl_kern_to_user_int_conv_hz, false)
-static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
-			      sysctl_user_to_kern_int_conv_userhz,
-			      sysctl_kern_to_user_int_conv_userhz, false)
-static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_user_to_kern_int_conv_ms,
-			      sysctl_kern_to_user_int_conv_ms, false)
-
 static SYSCTL_INT_CONV_CUSTOM(_minmax, sysctl_user_to_kern_int_conv,
 			      sysctl_kern_to_user_int_conv, true)
-static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
-			      sysctl_user_to_kern_int_conv_ms,
-			      sysctl_kern_to_user_int_conv_ms, true)
 
 static SYSCTL_USER_TO_KERN_UINT_CONV(,SYSCTL_CONV_IDENTITY)
 
@@ -900,81 +878,6 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos, conv);
 }
 
-/**
- * proc_dointvec_jiffies - read a vector of integers as seconds
- * @table: the sysctl table
- * @dir: %TRUE if this is a write to the sysctl file
- * @buffer: the user buffer
- * @lenp: the size of the user buffer
- * @ppos: file position
- *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
- * The values read are assumed to be in seconds, and are converted into
- * jiffies.
- *
- * Returns 0 on success.
- */
-int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
-			  void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
-				  do_proc_int_conv_jiffies);
-}
-
-int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
-			  void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
-				  do_proc_int_conv_ms_jiffies_minmax);
-}
-
-/**
- * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ seconds
- * @table: the sysctl table
- * @dir: %TRUE if this is a write to the sysctl file
- * @buffer: the user buffer
- * @lenp: the size of the user buffer
- * @ppos: pointer to the file position
- *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
- * The values read are assumed to be in 1/USER_HZ seconds, and
- * are converted into jiffies.
- *
- * Returns 0 on success.
- */
-int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
-				 void *buffer, size_t *lenp, loff_t *ppos)
-{
-	if (USER_HZ < HZ)
-		return -EINVAL;
-	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
-				  do_proc_int_conv_userhz_jiffies);
-}
-
-/**
- * proc_dointvec_ms_jiffies - read a vector of integers as 1 milliseconds
- * @table: the sysctl table
- * @dir: %TRUE if this is a write to the sysctl file
- * @buffer: the user buffer
- * @lenp: the size of the user buffer
- * @ppos: the current position in the file
- *
- * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
- * values from/to the user buffer, treated as an ASCII string.
- * The values read are assumed to be in 1/1000 seconds, and
- * are converted into jiffies.
- *
- * Returns 0 on success.
- */
-int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
-		size_t *lenp, loff_t *ppos)
-{
-	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
-				  do_proc_int_conv_ms_jiffies);
-}
-
 /**
  * proc_do_large_bitmap - read/write from/to a large bitmap
  * @table: the sysctl table
@@ -1166,30 +1069,6 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
-int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
-		    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
-				    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
-		    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
-int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir,
-			     void *buffer, size_t *lenp, loff_t *ppos)
-{
-	return -ENOSYS;
-}
-
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1309,11 +1188,8 @@ int __init sysctl_init_bases(void)
 EXPORT_SYMBOL(proc_dobool);
 EXPORT_SYMBOL(proc_dointvec);
 EXPORT_SYMBOL(proc_douintvec);
-EXPORT_SYMBOL(proc_dointvec_jiffies);
 EXPORT_SYMBOL(proc_dointvec_minmax);
 EXPORT_SYMBOL_GPL(proc_douintvec_minmax);
-EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
-EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
 EXPORT_SYMBOL(proc_dostring);
 EXPORT_SYMBOL(proc_doulongvec_minmax);
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 34eeacac225391667e168ec4e1d7261175388d51..2289c11c8bfc218304a620a3541109e281b4e581 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -99,3 +99,103 @@ void __init register_refined_jiffies(long cycles_per_second)
 
 	__clocksource_register(&refined_jiffies);
 }
+
+#define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
+#define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)
+
+static SYSCTL_USER_TO_KERN_INT_CONV(_hz, SYSCTL_CONV_MULT_HZ)
+static SYSCTL_KERN_TO_USER_INT_CONV(_hz, SYSCTL_CONV_DIV_HZ)
+static SYSCTL_USER_TO_KERN_INT_CONV(_userhz, clock_t_to_jiffies)
+static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
+static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
+static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
+
+static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_user_to_kern_int_conv_hz,
+			      sysctl_kern_to_user_int_conv_hz, false)
+static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
+			      sysctl_user_to_kern_int_conv_userhz,
+			      sysctl_kern_to_user_int_conv_userhz, false)
+static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_user_to_kern_int_conv_ms,
+			      sysctl_kern_to_user_int_conv_ms, false)
+static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
+			      sysctl_user_to_kern_int_conv_ms,
+			      sysctl_kern_to_user_int_conv_ms, true)
+
+/**
+ * proc_dointvec_jiffies - read a vector of integers as seconds
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in seconds, and are converted into
+ * jiffies.
+ *
+ * Returns 0 on success.
+ */
+int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_jiffies);
+}
+EXPORT_SYMBOL(proc_dointvec_jiffies);
+
+/**
+ * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ seconds
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: pointer to the file position
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in 1/USER_HZ seconds, and
+ * are converted into jiffies.
+ *
+ * Returns 0 on success.
+ */
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
+				 void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (USER_HZ < HZ)
+		return -EINVAL;
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_userhz_jiffies);
+}
+EXPORT_SYMBOL(proc_dointvec_userhz_jiffies);
+
+/**
+ * proc_dointvec_ms_jiffies - read a vector of integers as 1 milliseconds
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: the current position in the file
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
+ * values from/to the user buffer, treated as an ASCII string.
+ * The values read are assumed to be in 1/1000 seconds, and
+ * are converted into jiffies.
+ *
+ * Returns 0 on success.
+ */
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_ms_jiffies);
+}
+
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
+			  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
+				  do_proc_int_conv_ms_jiffies_minmax);
+}
+EXPORT_SYMBOL(proc_dointvec_ms_jiffies);
+

-- 
2.50.1



