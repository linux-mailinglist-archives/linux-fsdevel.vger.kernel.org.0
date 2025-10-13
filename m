Return-Path: <linux-fsdevel+bounces-63967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A8DBD332D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 352324F1D14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77036307AE5;
	Mon, 13 Oct 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeDK6DC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7F307AD0;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361949; cv=none; b=OJk0QV5zyuW5PDTA/V5IX4ZgXwifYAlrfqB37idb8Tvxz7h+ykHcRWhdGH2g4VObJiOmpmQwENhMz3LcC2jn1fmT/RvpkruR64x2+yCbWpM2emxE2ngIu2yIl3qJkFcuf+9uV8YiLBGTSmGR3PPYzgYZRTMmWejBi6cuRCLJvB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361949; c=relaxed/simple;
	bh=KD+2NkFaHlPghXWKYGaZ79Eguljp8JHhe47tIb8ZfcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aSv6YInVgv7XLFHSzhz0dS1FjZ/YanvdZxM4jtaWl7AHUhJG+mPAouoJfgTyDS+SKqYPN+MllHneMHtKSdFmSLlYQAdoHlLYZsJsMO1vG+Kmdz6PV7x8/77ScYsFtiUgMNZ9kOmpMh4migB6bajH8UNi5g6Gl/C0TG6cZpGRwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeDK6DC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 489E8C2BCB3;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=KD+2NkFaHlPghXWKYGaZ79Eguljp8JHhe47tIb8ZfcQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UeDK6DC0DyPaw3I6Hdo/23Q1HeGZDKuzanQsJXMe15mONoT2vq10yxaUovt5Hv4sz
	 F+iZLqQ8VKifF+OXv0ESHIQYz5w/OesfB8KAKobowqlk5RaLHobT50CZ28qhgFra9O
	 9SPlRmJ54P0oFwqRSUF6l+WF8sRmeHR9egFYhQXBhTA+wPccgIv4r8hzDNSeic50Hf
	 95q+7hyFQcno1FKnpGJQ9BfpgKI/jUETr5eD2dZpxH+UzsvrXAHazkU/qMK4BFDODx
	 clPxZA186oNKodgEkWXdoE7nlAPnHrKANn9GET5OWxa7yizmMfm//0apiwggDEfiWW
	 RcX7UIhRN0IQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F568CCD183;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:57 +0200
Subject: [PATCH 7/8] sysctl: Create integer converters with one macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-7-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5636;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=KD+2NkFaHlPghXWKYGaZ79Eguljp8JHhe47tIb8ZfcQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dZ4z6dKRy2SnciVVaoN23htdr/J/6Gjp
 G+LGXNRlUS+zYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3WAAoJELqXzVK3
 lkFP2hoMAIfK8UBYrYgEhDWMM1XXpWxQzBIvdpBOZfKVhIuEfKeJ4dJiq4gCeVX2J2xTWkqtol1
 HhOmrSO61bRFsrLpqzd9QU6Eg/tXW6qawjjhvnXuKMlM5t1+NjxgGrOOWcI0sKlqluAwvlnZsgI
 Pr+a7XjVRHCHOP/XsvWZhImvqpemjvCz1Zq2+1P0TP3IBOJf8fEvnrPyWj5wBx8Z5y7TxjIoUi4
 ev/Uu1U+XJ2uCpiNkBAcwZgc+1E9EmkmpNq0J68LIbGgwgrO1fOm0T/ou8pngzWO+MQIxmpkcYv
 VFQHQYuKitc3bo7ATbCJZO60CVP4lCyExs9rDwJ1+oyTuNzGbSKEdFPS6E3y6H3n1l2g7vpvmdf
 59XkG879Q+sBVSKJlnn+6U/k2l4YW9G2MwFnoVFxoCsolEEF5H2uYDNjtFJykYJuW58r1IxMGK3
 yyDKHMRonXn23Qe85STRlDUGfwwKBeb+C6GMBtbaxwaqQnkzJBY4l4W8Q0Mj9kZ9TR9NEfovxk8
 Y4=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

New SYSCTL_INT_CONV_CUSTOM macro creates "bi-directional" converters
from a user-to-kernel and a kernel-to-user functions. Replace integer
versions of do_proc_*_conv functions with the ones from the new macro.
Rename "_dointvec_" to just "_int_" as these converters are not applied
to vectors and the "do" is already in the name.

Move the USER_HZ validation directly into proc_dointvec_userhz_jiffies()

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 72 ++++++++++++++++++++-------------------------------------
 1 file changed, 25 insertions(+), 47 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f47bb8af33fb1d2d1a2a7c13d7ca093af82c6400..e7dc4b79e93ea9ab929ce0465143aed74be444e5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -418,17 +418,25 @@ static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
 static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
 static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
 
-static int do_proc_dointvec_conv(bool *negp, unsigned long *u_ptr,
-				 int *k_ptr, int dir,
-				 const struct ctl_table *table)
-{
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		return sysctl_user_to_kern_int_conv(negp, u_ptr, k_ptr);
-	}
-
-	return sysctl_kern_to_user_int_conv(negp, u_ptr, k_ptr);
+#define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user)	\
+int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
+			   int dir, const struct ctl_table *table)	\
+{									\
+	if (SYSCTL_USER_TO_KERN(dir))					\
+		return user_to_kern(negp, u_ptr, k_ptr);		\
+	return kern_to_user(negp, u_ptr, k_ptr);			\
 }
 
+static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
+			      sysctl_kern_to_user_int_conv)
+static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_user_to_kern_int_conv_hz,
+			      sysctl_kern_to_user_int_conv_hz)
+static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
+			      sysctl_user_to_kern_int_conv_userhz,
+			      sysctl_kern_to_user_int_conv_userhz)
+static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_user_to_kern_int_conv_ms,
+			      sysctl_kern_to_user_int_conv_ms)
+
 static int do_proc_douintvec_conv(unsigned long *u_ptr,
 				  unsigned int *k_ptr, int dir,
 				  const struct ctl_table *table)
@@ -467,7 +475,7 @@ static int do_proc_dointvec(const struct ctl_table *table, int dir,
 	left = *lenp;
 
 	if (!conv)
-		conv = do_proc_dointvec_conv;
+		conv = do_proc_int_conv;
 
 	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
@@ -724,7 +732,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *u_ptr,
 	 */
 	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_dointvec_conv(negp, u_ptr, ip, dir, table);
+	ret = do_proc_int_conv(negp, u_ptr, ip, dir, table);
 	if (ret)
 		return ret;
 
@@ -986,38 +994,6 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 					 lenp, ppos, HZ, 1000l);
 }
 
-static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *u_ptr,
-					 int *k_ptr, int dir,
-					 const struct ctl_table *table)
-{
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		return sysctl_user_to_kern_int_conv_hz(negp, u_ptr, k_ptr);
-	}
-	return sysctl_kern_to_user_int_conv_hz(negp, u_ptr, k_ptr);
-}
-
-static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *u_ptr,
-						int *k_ptr, int dir,
-						const struct ctl_table *table)
-{
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		if (USER_HZ < HZ)
-			return -EINVAL;
-		return sysctl_user_to_kern_int_conv_userhz(negp, u_ptr, k_ptr);
-	}
-	return sysctl_kern_to_user_int_conv_userhz(negp, u_ptr, k_ptr);
-}
-
-static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *u_ptr,
-					    int *k_ptr, int dir,
-					    const struct ctl_table *table)
-{
-	if (SYSCTL_USER_TO_KERN(dir)) {
-		return sysctl_user_to_kern_int_conv_ms(negp, u_ptr, k_ptr);
-	}
-	return sysctl_kern_to_user_int_conv_ms(negp, u_ptr, k_ptr);
-}
-
 static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *u_ptr,
 						int *k_ptr, int dir,
 						const struct ctl_table *table)
@@ -1029,7 +1005,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *u_
 	 */
 	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : k_ptr;
 
-	ret = do_proc_dointvec_ms_jiffies_conv(negp, u_ptr, ip, dir, table);
+	ret = do_proc_int_conv_ms_jiffies(negp, u_ptr, ip, dir, table);
 	if (ret)
 		return ret;
 
@@ -1062,7 +1038,7 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_dointvec_jiffies_conv);
+				do_proc_int_conv_jiffies);
 }
 
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
@@ -1090,8 +1066,10 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
+	if (USER_HZ < HZ)
+		return -EINVAL;
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_dointvec_userhz_jiffies_conv);
+				do_proc_int_conv_userhz_jiffies);
 }
 
 /**
@@ -1113,7 +1091,7 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffe
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
-				do_proc_dointvec_ms_jiffies_conv);
+				do_proc_int_conv_ms_jiffies);
 }
 
 /**

-- 
2.50.1



