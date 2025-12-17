Return-Path: <linux-fsdevel+bounces-71536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B181CC67A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A077E303BDFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 08:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A405339B4D;
	Wed, 17 Dec 2025 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Vsut5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698F335569;
	Wed, 17 Dec 2025 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958738; cv=none; b=KA6wD/gy5Spla1EvgRdrhlhFGmfncNCUpHKjdk18nC+IffjUeLsgM4uDPHk/Sp8eKD2CbVPvAUiNxIO0vfGiphc4Kg6QS+2uyq6hz2ISVC+GDhmcP7k5CEp1TTGRyMGmx3oOzU0iaPv0kntPqQ8OwFJrdxN3tTBFsUMHvKlqzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958738; c=relaxed/simple;
	bh=73JBxcdK+wB5zYmzl+V497DJlRPRsqK8N8cyhwP4DE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=krDCJ0/IpEw9Gx07w4svThfqG50PvOYCQhQCFdXVrPF4CiZGTE8uwzYKbs/oD9+BKymJn8NqVTuxFNMo6JwPl1b43Y4igfJc1CQ6TXLzz85u2oLdxlBPVPaag9sa3TARSPRM4Ut4MGe8fh7cTJlGsXKKVEFmu2ZwpzXy1dubrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Vsut5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2A83C2BCB2;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958737;
	bh=73JBxcdK+wB5zYmzl+V497DJlRPRsqK8N8cyhwP4DE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V1Vsut5t/csEQeRhL8gtmtJ0c1lRgeaiuGgjbw/HXypov8ujve+5IJxAWMHqggX/E
	 LFmRzVFueKZbv6ylvKemk2fBDZXmxeSiJeSM0W+RM+7D76/1fQTsms64/FX/lieM0n
	 bdObEUmmtde+zLyyUesMy7xe0ZfbR7zEt07fcmPIplmJseg3e4+6afP3aFE+0SkA2H
	 SLlgMPX3QDwXoB0LU+8OEqQXPVtbbiOFPcqEr3Hqf74xZIkwshcsggKeNNc9lRg/CX
	 fj565F+KKB8EA8aliyaDpd0XkOlw5yqc+/f+mijOaDKmBNSoZXkE8E5tpnUOB/nOL7
	 dBda1zZw3+BQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD02D637A5;
	Wed, 17 Dec 2025 08:05:37 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Wed, 17 Dec 2025 09:04:44 +0100
Subject: [PATCH 6/7] sysctl: Replace unidirectional INT converter macros
 with functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-jag-no-macro-conv-v1-6-6e4252687915@kernel.org>
References: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
In-Reply-To: <20251217-jag-no-macro-conv-v1-0-6e4252687915@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10734;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=73JBxcdK+wB5zYmzl+V497DJlRPRsqK8N8cyhwP4DE8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlCZEzWlszy4uAIDY0G3A3OqiYm01Qm+r+OQ
 K/viQ8RYgXtFIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpQmRMAAoJELqXzVK3
 lkFPjl0L/RfURY6GXnUC65eeRYapeR6ZGEgCznKr6z5XLMnbcWICluPPYDDLKseSUO0+k+toatx
 dRrUwOs0p0YWRx7UxK+enWgcoD5aMRROWvXpNyCBeZKlVCbx+c0tiwvtgmv2vOwyBwH7ww0RzbT
 ynWUqu6WnjHElfc359xen9vHrTb6KmkYfpiw/uNWsRes483Ita9S/HPZbkCoAKTUWo/kd2IhJrU
 JICum29wqHqMwqnUvWKWn2nqArlPX3Y1kBJkLT/U4sv43EFBNMkSJLNVghco75+EAsXOuXYe0yX
 LEnsjmfBnLQo+Yb3J6hCrXCeH8zra8z/qWMspRQ/cyF+BZEC3KTWfr3iOxbJfHdgH73kn9ghF3m
 l4FlgIQMpa8GiizVw/3sONs+fr7DY+ow0mOG89fb8lOiHhEg9tsitel3JTg4lsN7UyBRhyn0OtK
 9XdSPxdXpInQz4U0mdv4Ayya69aDrxgGuaE72K1C/Tq9biHcUXczMCZLlwZDvqzxxCcA9bYAPk6
 Zk=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replace SYSCTL_USER_TO_KERN_INT_CONV and SYSCTL_KERN_TO_USER_INT_CONV
macros with function implementing the same logic.This makes debugging
easier and aligns with the functions preference described in
coding-style.rst. Update all jiffies converters to use explicit function
implementations instead of macro-generated versions.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h |  56 ++++---------------------
 kernel/sysctl.c        |  69 +++++++++++++++++++++++++++++-
 kernel/time/jiffies.c  | 111 +++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 167 insertions(+), 69 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index d712992789f0f2f3fe4cec10fb14907b7fd61a7e..655fb85ec29278a3a268e363243c7f318bf0e75e 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -74,40 +74,6 @@ extern const int sysctl_vals[];
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
 #ifdef CONFIG_PROC_SYSCTL
-#define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
-int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
-				       const unsigned long *u_ptr,\
-				       int *k_ptr)		\
-{								\
-	unsigned long u = u_ptr_op(*u_ptr);			\
-	if (*negp) {						\
-		if (u > (unsigned long) INT_MAX + 1)		\
-			return -EINVAL;				\
-		WRITE_ONCE(*k_ptr, -u);				\
-	} else {						\
-		if (u > (unsigned long) INT_MAX)		\
-			return -EINVAL;				\
-		WRITE_ONCE(*k_ptr, u);				\
-	}							\
-	return 0;						\
-}
-
-#define SYSCTL_KERN_TO_USER_INT_CONV(name, k_ptr_op)		\
-int sysctl_kern_to_user_int_conv##name(bool *negp,		\
-				       unsigned long *u_ptr,	\
-				       const int *k_ptr)	\
-{								\
-	int val = READ_ONCE(*k_ptr);				\
-	if (val < 0) {						\
-		*negp = true;					\
-		*u_ptr = -k_ptr_op((unsigned long)val);		\
-	} else {						\
-		*negp = false;					\
-		*u_ptr = k_ptr_op((unsigned long)val);		\
-	}							\
-	return 0;						\
-}
-
 /**
  * To range check on a converted value, use a temp k_ptr
  * When checking range, value should be within (tbl->extra1, tbl->extra2)
@@ -135,22 +101,8 @@ int do_proc_int_conv##name(bool *negp, unsigned long *u_ptr, int *k_ptr,\
 		return user_to_kern(negp, u_ptr, k_ptr);		\
 	return 0;							\
 }
+
 #else // CONFIG_PROC_SYSCTL
-#define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
-int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
-				       const unsigned long *u_ptr,\
-				       int *k_ptr)		\
-{								\
-	return -ENOSYS;						\
-}
-
-#define SYSCTL_KERN_TO_USER_INT_CONV(name, k_ptr_op)		\
-int sysctl_kern_to_user_int_conv##name(bool *negp,		\
-				       unsigned long *u_ptr,	\
-				       const int *k_ptr)	\
-{								\
-	return -ENOSYS;						\
-}
 
 #define SYSCTL_INT_CONV_CUSTOM(name, user_to_kern, kern_to_user,	\
 			       k_ptr_range_check)			\
@@ -170,6 +122,7 @@ typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
 int proc_dostring(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
+
 int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(const struct ctl_table *table, int dir, void *buffer,
 			 size_t *lenp, loff_t *ppos);
@@ -177,6 +130,11 @@ int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
 				   int dir, const struct ctl_table *table));
+int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
+			  ulong (*k_ptr_op)(const ulong));
+int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
+			  ulong (*u_ptr_op)(const ulong));
+
 int proc_douintvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_douintvec_minmax(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ed2701acc89821e724b5697665f8a795dff8097d..c3946d7ee6f787855694a0a353c173194ccd5c4b 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -458,8 +458,73 @@ static int do_proc_uint_conv_minmax(ulong *u_ptr, uint *k_ptr, int dir,
 			      proc_uint_u2k_conv, proc_uint_k2u_conv);
 }
 
-static SYSCTL_USER_TO_KERN_INT_CONV(, SYSCTL_CONV_IDENTITY)
-static SYSCTL_KERN_TO_USER_INT_CONV(, SYSCTL_CONV_IDENTITY)
+/**
+ * proc_int_k2u_conv_kop - Assign kernel value to a user space pointer
+ * @u_ptr - pointer to user space variable
+ * @k_ptr - pointer to kernel variable
+ * @negp - assigned %TRUE if the converted kernel value is negative;
+ *         %FALSE otherweise
+ * @k_ptr_op - execute this function before assigning to u_ptr
+ *
+ * Uses READ_ONCE to get value from k_ptr. Executes k_ptr_op before assigning
+ * to u_ptr if not NULL. Does **not** check for overflow.
+ *
+ * returns 0 on success.
+ */
+int proc_int_k2u_conv_kop(ulong *u_ptr, const int *k_ptr, bool *negp,
+			  ulong (*k_ptr_op)(const ulong))
+{
+	int val = READ_ONCE(*k_ptr);
+
+	if (val < 0) {
+		*negp = true;
+		*u_ptr = k_ptr_op ? -k_ptr_op((ulong)val) : -(ulong)val;
+	} else {
+		*negp = false;
+		*u_ptr = k_ptr_op ? k_ptr_op((ulong)val) : (ulong) val;
+	}
+	return 0;
+}
+
+/**
+ * proc_int_u2k_conv_uop - Assign user value to a kernel pointer
+ * @u_ptr - pointer to user space variable
+ * @k_ptr - pointer to kernel variable
+ * @negp - If %TRUE, the converted user value is made negative.
+ * @u_ptr_op - execute this function before assigning to k_ptr
+ *
+ * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
+ * not NULL. Check for overflow with UINT_MAX.
+ *
+ * returns 0 on success.
+ */
+int proc_int_u2k_conv_uop(const ulong *u_ptr, int *k_ptr, const bool *negp,
+			  ulong (*u_ptr_op)(const ulong))
+{
+	ulong u = u_ptr_op ? u_ptr_op(*u_ptr) : *u_ptr;
+
+	if (*negp) {
+		if (u > (ulong) INT_MAX + 1)
+			return -EINVAL;
+		WRITE_ONCE(*k_ptr, -u);
+	} else {
+		if (u > (ulong) INT_MAX)
+			return -EINVAL;
+		WRITE_ONCE(*k_ptr, u);
+	}
+	return 0;
+}
+
+static int sysctl_user_to_kern_int_conv(const bool *negp, const ulong *u_ptr,
+					int *k_ptr)
+{
+	return proc_int_u2k_conv_uop(u_ptr, k_ptr, negp, NULL);
+}
+
+static int sysctl_kern_to_user_int_conv(bool *negp, ulong *u_ptr, const int *k_ptr)
+{
+	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, NULL);
+}
 
 static SYSCTL_INT_CONV_CUSTOM(, sysctl_user_to_kern_int_conv,
 			      sysctl_kern_to_user_int_conv, false)
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d31a6d40d38dc4db696f0bbe205121d73c242177..825e4c9fd26a2c8964b40509f3a5129c2b3b9f88 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -100,26 +100,101 @@ void __init register_refined_jiffies(long cycles_per_second)
 	__clocksource_register(&refined_jiffies);
 }
 
-#define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
-#define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)
-
-static SYSCTL_USER_TO_KERN_INT_CONV(_hz, SYSCTL_CONV_MULT_HZ)
-static SYSCTL_KERN_TO_USER_INT_CONV(_hz, SYSCTL_CONV_DIV_HZ)
-static SYSCTL_USER_TO_KERN_INT_CONV(_userhz, clock_t_to_jiffies)
-static SYSCTL_KERN_TO_USER_INT_CONV(_userhz, jiffies_to_clock_t)
-static SYSCTL_USER_TO_KERN_INT_CONV(_ms, msecs_to_jiffies)
-static SYSCTL_KERN_TO_USER_INT_CONV(_ms, jiffies_to_msecs)
-
-static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_user_to_kern_int_conv_hz,
-			      sysctl_kern_to_user_int_conv_hz, false)
+#ifdef CONFIG_PROC_SYSCTL
+static ulong mult_hz(const ulong val)
+{
+	return val * HZ;
+}
+
+static ulong div_hz(const ulong val)
+{
+	return val / HZ;
+}
+
+static int sysctl_u2k_int_conv_hz(const bool *negp, const ulong *u_ptr, int *k_ptr)
+{
+	return proc_int_u2k_conv_uop(u_ptr, k_ptr, negp, mult_hz);
+}
+
+static int sysctl_k2u_int_conv_hz(bool *negp, ulong *u_ptr, const int *k_ptr)
+{
+	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, div_hz);
+}
+
+static int sysctl_u2k_int_conv_userhz(const bool *negp, const ulong *u_ptr, int *k_ptr)
+{
+	return proc_int_u2k_conv_uop(u_ptr, k_ptr, negp, clock_t_to_jiffies);
+}
+
+static ulong sysctl_jiffies_to_clock_t(const ulong val)
+{
+	return jiffies_to_clock_t(val);
+}
+
+static int sysctl_k2u_int_conv_userhz(bool *negp, ulong *u_ptr, const int *k_ptr)
+{
+	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, sysctl_jiffies_to_clock_t);
+}
+
+static ulong sysctl_msecs_to_jiffies(const ulong val)
+{
+	return msecs_to_jiffies(val);
+}
+
+static int sysctl_u2k_int_conv_ms(const bool *negp, const ulong *u_ptr, int *k_ptr)
+{
+	return proc_int_u2k_conv_uop(u_ptr, k_ptr, negp, sysctl_msecs_to_jiffies);
+}
+
+static ulong sysctl_jiffies_to_msecs(const ulong val)
+{
+	return jiffies_to_msecs(val);
+}
+
+static int sysctl_k2u_int_conv_ms(bool *negp, ulong *u_ptr, const int *k_ptr)
+{
+	return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, sysctl_jiffies_to_msecs);
+}
+
+
+static SYSCTL_INT_CONV_CUSTOM(_jiffies, sysctl_u2k_int_conv_hz,
+			      sysctl_k2u_int_conv_hz, false)
 static SYSCTL_INT_CONV_CUSTOM(_userhz_jiffies,
-			      sysctl_user_to_kern_int_conv_userhz,
-			      sysctl_kern_to_user_int_conv_userhz, false)
-static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_user_to_kern_int_conv_ms,
-			      sysctl_kern_to_user_int_conv_ms, false)
+			      sysctl_u2k_int_conv_userhz,
+			      sysctl_k2u_int_conv_userhz, false)
+static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies, sysctl_u2k_int_conv_ms,
+			      sysctl_k2u_int_conv_ms, false)
 static SYSCTL_INT_CONV_CUSTOM(_ms_jiffies_minmax,
-			      sysctl_user_to_kern_int_conv_ms,
-			      sysctl_kern_to_user_int_conv_ms, true)
+			      sysctl_u2k_int_conv_ms,
+			      sysctl_k2u_int_conv_ms, true)
+
+#else // CONFIG_PROC_SYSCTL
+static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
+				    int dir, const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
+
+static int do_proc_int_conv_userhz_jiffies(bool *negp, ulong *u_ptr,
+					   int *k_ptr, int dir,
+					   const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
+
+static int do_proc_int_conv_ms_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
+				       int dir, const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
+
+static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
+					      int *k_ptr, int dir,
+					      const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
+#endif
 
 /**
  * proc_dointvec_jiffies - read a vector of integers as seconds

-- 
2.50.1



