Return-Path: <linux-fsdevel+bounces-64418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009EFBE7331
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186075E2CE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 08:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BE52BE058;
	Fri, 17 Oct 2025 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYnEbO00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093E296BB4;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689990; cv=none; b=SrNFhgqFxkSEmYS2mWibMwMlc62NLM68G9hDyvYaXebDYPIvoupvu+Xt214UX91CzDrgMgtL2iHd8RGfweA+a/Uj1Kx7U/guR4kA81DV+M/va4IoqB26rjHMdasLAiE+Bwr0E6UVPUD+sBrTOXhDAktCUKVM/3sPWCT00+YQ/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689990; c=relaxed/simple;
	bh=q9gCEt3TobxYIVG/KkXiEJcB2H0/1WMYfGIpn+5weUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vd7sIx/MzCGcGAZkWgILMvC1R8iXWfDzGcRby8w/1E9pMJnMBblHYh3XX8Yh7g0lWy+acBITGuHonYOiPtXJwXqIt2jngCpsbfbm0hNYaUK9wsGx31x8jact1wC3R86oycCtdArfGfv4T0PlH3VvJyDPRo7HdtE8q3apJCtQ8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYnEbO00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E0BC4AF0B;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760689989;
	bh=q9gCEt3TobxYIVG/KkXiEJcB2H0/1WMYfGIpn+5weUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZYnEbO005LHWApfem2/aQ2uxZb2K8u/Lq7gEyVG/z3eu47EMZJdsb2XuCzbSZ6yhB
	 WSZ93P/VH+C6c0KTO2KMz1+YNPsNNcX2LhUfLx/Z851GxOtnroZ/C/B26uv/BqsaYs
	 7Rgj8iWSR2B1S4JhS3JGDTIyeXwhvKPQnDuPdt1l8tLZe3EA4pzP0VMEfy2WYzemFF
	 xJaNL8ZG24KW9a5mG3MiGHhgGqY55S1PqPdsO1XnvV9FzuXMYksMElRrbqx8/39uF/
	 EnN8jsEzBbywPBcFz2VeYaUiH3ZvKXWfMrWuF/xTyDHoTsyo4vUDTDn7IAWzOD3Ifb
	 atp8DaDasIukQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD0CCD1A2;
	Fri, 17 Oct 2025 08:33:09 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 17 Oct 2025 10:32:12 +0200
Subject: [PATCH 2/7] sysctl: Move INT converter macros to sysctl header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-jag-sysctl_jiffies-v1-2-175d81dfdf82@kernel.org>
References: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
In-Reply-To: <20251017-jag-sysctl_jiffies-v1-0-175d81dfdf82@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6756;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=q9gCEt3TobxYIVG/KkXiEJcB2H0/1WMYfGIpn+5weUg=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjx/z/0VfSrjs8ZqAKxT/Y+E4PCmvOw6GQNu
 ejTJLH8jMKR/4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8f8/AAoJELqXzVK3
 lkFPWN0L/ApKAqufgi2A8tK0k/fE1WyNBqIg6r3rpZiwzAr+CWfMLXdsWpBPmghF1W8X5jRjL9F
 IrzSWsPN/VIvu3Vak73VDgzyc7JsjAkaT3s+bD1sjjz2zaIs2ZVG4R+y9muSLIvkfTGXqqEyO3T
 trdthVFKLhrpLjmSzBnGCz5+wuHk5cVJfYbsa9BRh1bOxO2WZtw/bNT8KTjxUMIUVkbnQuCtcW2
 LrzsUqd6hidWEPn3BQ91FIq6DjWaMJxV/H4OPauJpUo5sX00ubuzIOt+DqKf2pSvYkaXPC3hWN6
 sA5hxz6zjy+Bp0iBgwNR5Y/7xi/4AO66q6rzAYRscPAJXtvsBG0mJ5e/7R6YyRc66Pgf4z9kMqJ
 opB5PzBdo0IBbZtWJmyScipVRbKxIzx2pDMkMqwzZ2hLposPrLEpCtPYfwHeFOfiwno6rRCm/+J
 ShLTGkiR66ddGtxfIA2ioWXv0u/mIh4pJ8MSX4aDDQwziho1z3+M7n4C2AoviWR/ugX05sFuW3+
 PM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move direction macros (SYSCTL_{USER_TO_KERN,KERN_TO_USER}) and the
integer converter macros (SYSCTL_{USER_TO_KERN,KERN_TO_USER}_INT_CONV,
SYSCTL_INT_CONV_CUSTOM) into include/linux/sysctl.h. This is a
preparation commit to enable jiffies converter creation outside
kernel/sysctl.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c        | 75 --------------------------------------------------
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ecc8d2345006ab12520f2f6ec37379419e9295d4..967a9ad6b4200266e2d9c6cfa9ee58fb8bf51090 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -59,6 +59,81 @@ extern const int sysctl_vals[];
 #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
 #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
 
+/**
+ *
+ * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
+ * in the file_operations struct at proc/proc_sysctl.c. Its value means
+ * one of two things for sysctl:
+ * 1. SYSCTL_USER_TO_KERN(dir) Writing to an internal kernel variable from user
+ *                             space (dir > 0)
+ * 2. SYSCTL_KERN_TO_USER(dir) Writing to a user space buffer from a kernel
+ *                             variable (dir == 0).
+ */
+#define SYSCTL_USER_TO_KERN(dir) (!!(dir))
+#define SYSCTL_KERN_TO_USER(dir) (!dir)
+
+#define SYSCTL_USER_TO_KERN_INT_CONV(name, u_ptr_op)		\
+int sysctl_user_to_kern_int_conv##name(const bool *negp,	\
+				       const unsigned long *u_ptr,\
+				       int *k_ptr)		\
+{								\
+	unsigned long u = u_ptr_op(*u_ptr);			\
+	if (*negp) {						\
+		if (u > (unsigned long) INT_MAX + 1)		\
+			return -EINVAL;				\
+		WRITE_ONCE(*k_ptr, -u);				\
+	} else {						\
+		if (u > (unsigned long) INT_MAX)		\
+			return -EINVAL;				\
+		WRITE_ONCE(*k_ptr, u);				\
+	}							\
+	return 0;						\
+}
+
+#define SYSCTL_KERN_TO_USER_INT_CONV(name, k_ptr_op)		\
+int sysctl_kern_to_user_int_conv##name(bool *negp,		\
+				       unsigned long *u_ptr,	\
+				       const int *k_ptr)	\
+{								\
+	int val = READ_ONCE(*k_ptr);				\
+	if (val < 0) {						\
+		*negp = true;					\
+		*u_ptr = -k_ptr_op((unsigned long)val);		\
+	} else {						\
+		*negp = false;					\
+		*u_ptr = k_ptr_op((unsigned long)val);		\
+	}							\
+	return 0;						\
+}
+
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
 extern const unsigned long sysctl_long_vals[];
 
 typedef int proc_handler(const struct ctl_table *ctl, int write, void *buffer,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6a6a2a6421f8debf75089548c82374619af32d61..70cf23d9834ef4e6b95ab80a3dc7a06237742793 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -30,19 +30,6 @@ EXPORT_SYMBOL(sysctl_vals);
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
 EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
-/**
- *
- * "dir" originates from read_iter (dir = 0) or write_iter (dir = 1)
- * in the file_operations struct at proc/proc_sysctl.c. Its value means
- * one of two things for sysctl:
- * 1. SYSCTL_USER_TO_KERN(dir) Writing to an internal kernel variable from user
- *                             space (dir > 0)
- * 2. SYSCTL_KERN_TO_USER(dir) Writing to a user space buffer from a kernel
- *                             variable (dir == 0).
- */
-#define SYSCTL_USER_TO_KERN(dir) (!!(dir))
-#define SYSCTL_KERN_TO_USER(dir) (!dir)
-
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
@@ -368,68 +355,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
 	}
 }
 
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
 #define SYSCTL_CONV_IDENTITY(val) val
 #define SYSCTL_CONV_MULT_HZ(val) ((val) * HZ)
 #define SYSCTL_CONV_DIV_HZ(val) ((val) / HZ)

-- 
2.50.1



