Return-Path: <linux-fsdevel+bounces-72309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA8CED042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 13:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB4F1300F5A1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39926256C70;
	Thu,  1 Jan 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byq9l3f9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5420F067;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767272242; cv=none; b=jHQ6T2UiNJLsO5+jwlWc8Ie2vnZ1RlfTEeH5mvji6921rmP28x/eia+V0YptRcfITDZ6FsQ/g2k9rKK0v/fDi8DM4w3aRBgEQAC4nyuEwihJFbdDheUQG/c4GUIMMEnq0P2d+l0ZowUzCwcm5ylBt/C/B19KY/hRzCa6WZXDcIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767272242; c=relaxed/simple;
	bh=AS+0+hi2/RnLpQAf0P3Ce+cd66SedZRdJi+05mh0ssw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKrzyqEpu17zgKWVm8lm8yu3eMexpK4vFfZIYSZVHGTPG7ok1lQWKl8GedTQIChnCT8TCc7nXQVRNVawj2Qf5SndqzKu/70f8jx1DAguGA8W0MVdSMVrci8CkWUX2ehBN6MslKGIJTUiMInLdIm1b0g7vUsG00CUw2+CYZ+ZHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byq9l3f9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2686DC19423;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767272242;
	bh=AS+0+hi2/RnLpQAf0P3Ce+cd66SedZRdJi+05mh0ssw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=byq9l3f9lZAPogKndUZTQlcIX1tBiscxpUVajQyHbcw6AqeJ/8eo0uVJ5rXev9Va9
	 11ors+5FMFrMzCGd35tK3Kqp8HVrYkeuGUWUoLyFHWwLj637Oj5gLXmdufJaAVd/Jq
	 ffGZvoOyP2EXpY7ZjouukKouTMmg/nOLDbQ9+7w4de9gc/ovHiZXg4+7Eh2cysKmr4
	 LU7NIPzJm8bAby/WG6fgbVGn+C9VeLeXTUAMv8/gXBr9EZvc5b/Tou/uutJ0FF3zCc
	 9pe43FHr3zpN8jNXr4LWIGxA5ULS2xksD/GGB2WWxhT6NBkP98exrqYDipN93Hejk+
	 XhEbC905s0lLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582DEED602;
	Thu,  1 Jan 2026 12:57:22 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 01 Jan 2026 13:57:07 +0100
Subject: [PATCH v2 3/9] sysctl: Generate do_proc_doulongvec_minmax with
 do_proc_dotypevec macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-jag-dovec_consolidate-v2-3-ff918f753ba9@kernel.org>
References: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
In-Reply-To: <20260101-jag-dovec_consolidate-v2-0-ff918f753ba9@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12050;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=AS+0+hi2/RnLpQAf0P3Ce+cd66SedZRdJi+05mh0ssw=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGlWbyu2V5VcKuZ8imOqnzOhwCm68yMhCo1MS
 Djm/lcQA+WGJIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJpVm8rAAoJELqXzVK3
 lkFP55cL/RRdx6d8bbN2wwDMr/+zbqqsgGxTrF3p3DSGWRRF1ioWN68a7wYPT/DSO63/MM6CzGO
 ZbTFpkH+CmsY+AJj71EyfYmDU2WlKSVJCiHVcJHFdo8bvLwO0m29cGiYPIQbykIzmNaiI9Au9Wy
 0o6Z+t7ACBGW7b/EbkAYO+lIr3gxw4IlpCoJVZ+3piSY1hZrqLcPAGlo7r/a2Wj9TjZPNDDqAJ1
 zssLJaUGSMSacy9HdlUEY6TCaLpMCCVGQJ6dtUMh31iwq3v3/Shs1W0zqNvncuafgwLr+MRL+la
 mmZM0uy5uPZZSpf7z2KOvLmxV2FduUbciv1qCYB61J1JEPds2W5AwaXgPxhMZhbS2/EVvAlY4pL
 ToAhWxxAzkSdAJTxRkcd9uG+e7K2/OLKouxGHZq4vWfO5Eg6LOTpiqEqYYoZrb3McdBexA6ciWU
 78lptGkv0bxr1nPAXYVIwXJ2nCMHMlFL0TWFC/yxSkr8R/Re15SQ/DN2K0Pa6P7hUWUVuwM+zj5
 Eg=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

The existing do_proc_doulongvec_minmax conversions (based on conv{mul,div})
are replaced with a call to a converter callback that is passed by the
caller.

Replace the values (HZ, 1000l) passed to proc_doulongvec_minmax_conv in
jiffies.c with a new callback containing millisecond to jiffie
conversion (do_proc_ulong_conv_ms_jiffies). This effectively changes the
simple calculation based on HZ and 1000l to a more robust conversion
based on  {_,}_msecs_to_jiffies.

Change specifics
================
* sysctl.h API
 - Implement new ulong uni & bi-directional converters (proc_ulong_*);
   export them so they can be used in proc_doulongvec_ms_jiffies_minmax
   (jiffies.c).
 - Replace two arguments (conv{mul,div}) in proc_doulongvec_minmax_conv
   with a general converter callback function that will be forwarded to
   do_proc_doulongvec.

* do_proc_doulongvec
 - Replace the hardcoded uni-directional converters with a call to the
   call back converter function
 - Generate do_proc_doulongvec with do_proc_dotypevec macro
 - Rename do_proc_doulongvec_minmax to do_proc_doulongvec

* jiffies
 - Create uni and bi-directional converters for milliseconds to jiffies
   (sysctl_{u2k,k2u}_ulong_conv_ms, do_proc_ulong_conv_ms_jiffies)
 - Pass the new bi-directional converter to proc_doulongvec_minmax_conv.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/linux/sysctl.h |  11 ++-
 kernel/sysctl.c        | 182 ++++++++++++++++++++++++++++++-------------------
 kernel/time/jiffies.c  |  26 ++++++-
 3 files changed, 148 insertions(+), 71 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2886fbceb5d635fc7e0282c7467dcf82708919fe..5c8c17f98513983a459c54eae99d1cc8bd63b011 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -117,11 +117,20 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write, void *buffer,
 int proc_doulongvec_minmax(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
-				unsigned long convmul, unsigned long convdiv);
+				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					    int dir, const struct ctl_table *table));
 int proc_do_large_bitmap(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_do_static_key(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
+int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
+			    ulong (*u_ptr_op)(const ulong));
+int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
+			    ulong (*k_ptr_op)(const ulong));
+int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
+		    const struct ctl_table *tbl, bool k_ptr_range_check,
+		    int (*user_to_kern)(const ulong *u_ptr, ulong *k_ptr),
+		    int (*kern_to_user)(ulong *u_ptr, const ulong *k_ptr));
 /*
  * Register a set of sysctl names by calling register_sysctl
  * with an initialised array of struct ctl_table's.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 64f88c0338987ac9568713dd15db99f14553e82b..53babebd65f401244d15dc53a8b7e7b2f73473b3 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -650,6 +650,7 @@ out: \
 }
 
 do_proc_dotypevec(int)
+do_proc_dotypevec(ulong)
 
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
@@ -971,87 +972,128 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-static int do_proc_doulongvec_minmax(const struct ctl_table *table, int dir,
-				     void *buffer, size_t *lenp, loff_t *ppos,
-				     unsigned long convmul,
-				     unsigned long convdiv)
+/**
+ * proc_ulong_conv - Change user or kernel pointer based on direction
+ *
+ * @u_ptr: pointer to user variable
+ * @k_ptr: pointer to kernel variable
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @tbl: the sysctl table
+ * @k_ptr_range_check: Check range for k_ptr when %TRUE
+ * @user_to_kern: Callback used to assign value from user to kernel var
+ * @kern_to_user: Callback used to assign value from kernel to user var
+ *
+ * When direction is kernel to user, then the u_ptr is modified.
+ * When direction is user to kernel, then the k_ptr is modified.
+ *
+ * Returns: 0 on success
+ */
+int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
+		    const struct ctl_table *tbl, bool k_ptr_range_check,
+		    int (*user_to_kern)(const ulong *u_ptr, ulong *k_ptr),
+		    int (*kern_to_user)(ulong *u_ptr, const ulong *k_ptr))
 {
-	unsigned long *i, *min, *max;
-	int vleft, first = 1, err = 0;
-	size_t left;
-	char *p;
+	if (SYSCTL_KERN_TO_USER(dir))
+		return kern_to_user(u_ptr, k_ptr);
 
-	if (!table->data || !table->maxlen || !*lenp ||
-	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
-		*lenp = 0;
-		return 0;
-	}
+	if (k_ptr_range_check) {
+		ulong tmp_k;
+		int ret;
 
-	i = table->data;
-	min = table->extra1;
-	max = table->extra2;
-	vleft = table->maxlen / sizeof(unsigned long);
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
+		if (!tbl)
+			return -EINVAL;
+		ret = user_to_kern(u_ptr, &tmp_k);
+		if (ret)
+			return ret;
+		if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
+		    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
+			return -ERANGE;
+		WRITE_ONCE(*k_ptr, tmp_k);
+	} else
+		return user_to_kern(u_ptr, k_ptr);
+	return 0;
+}
 
-	for (; left && vleft--; i++, first = 0) {
-		unsigned long val;
+/**
+ * proc_ulong_u2k_conv_uop - Assign user value to a kernel pointer
+ *
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ * @u_ptr_op: execute this function before assigning to k_ptr
+ *
+ * Uses WRITE_ONCE to assign value to k_ptr. Executes u_ptr_op if
+ * not NULL.
+ *
+ * returns: 0 on success.
+ */
+int proc_ulong_u2k_conv_uop(const ulong *u_ptr, ulong *k_ptr,
+			    ulong (*u_ptr_op)(const ulong))
+{
+	ulong u = u_ptr_op ? u_ptr_op(*u_ptr) : *u_ptr;
 
-		if (SYSCTL_USER_TO_KERN(dir)) {
-			bool neg;
+	WRITE_ONCE(*k_ptr, u);
+	return 0;
+}
 
-			proc_skip_spaces(&p, &left);
-			if (!left)
-				break;
+static int proc_ulong_u2k_conv(const ulong *u_ptr, ulong *k_ptr)
+{
+	return proc_ulong_u2k_conv_uop(u_ptr, k_ptr, NULL);
+}
 
-			err = proc_get_long(&p, &left, &val, &neg,
-					     proc_wspace_sep,
-					     sizeof(proc_wspace_sep), NULL);
-			if (err || neg) {
-				err = -EINVAL;
-				break;
-			}
+/**
+ * proc_ulong_k2u_conv_kop - Assign kernel value to a user space pointer
+ *
+ * @u_ptr: pointer to user space variable
+ * @k_ptr: pointer to kernel variable
+ * @k_ptr_op: Operation applied to k_ptr before assignment
+ *
+ * Uses READ_ONCE to assign value to u_ptr. Executes k_ptr_op if
+ * not NULL.
+ *
+ * returns: 0 on success.
+ */
+int proc_ulong_k2u_conv_kop(ulong *u_ptr, const ulong *k_ptr,
+			    ulong (*k_ptr_op)(const ulong))
+{
+	ulong val = k_ptr_op ? k_ptr_op(READ_ONCE(*k_ptr)) : READ_ONCE(*k_ptr);
+	*u_ptr = (ulong)val;
+	return 0;
+}
 
-			val = convmul * val / convdiv;
-			if ((min && val < *min) || (max && val > *max)) {
-				err = -EINVAL;
-				break;
-			}
-			WRITE_ONCE(*i, val);
-		} else {
-			val = convdiv * READ_ONCE(*i) / convmul;
-			if (!first)
-				proc_put_char(&buffer, &left, '\t');
-			proc_put_long(&buffer, &left, val, false);
-		}
-	}
+static int proc_ulong_k2u_conv(ulong *u_ptr, const ulong *k_ptr)
+{
+	return proc_ulong_k2u_conv_kop(u_ptr, k_ptr, NULL);
+}
 
-	if (SYSCTL_KERN_TO_USER(dir) && !first && left && !err)
-		proc_put_char(&buffer, &left, '\n');
-	if (SYSCTL_USER_TO_KERN(dir) && !err)
-		proc_skip_spaces(&p, &left);
-	if (SYSCTL_USER_TO_KERN(dir) && first)
-		return err ? : -EINVAL;
-	*lenp -= left;
-out:
-	*ppos += *lenp;
-	return err;
+static int do_proc_ulong_conv(bool *negp, ulong *u_ptr, ulong *k_ptr, int dir,
+			      const struct ctl_table *tbl)
+{
+	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, true,
+			       proc_ulong_u2k_conv, proc_ulong_k2u_conv);
 }
 
+/**
+ * proc_doulongvec_minmax_conv - read a vector of unsigned longs with a custom converter
+ *
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ * @conv: Custom converter call back
+ *
+ * Reads/writes up to table->maxlen/sizeof(unsigned long) unsigned long
+ * values from/to the user buffer, treated as an ASCII string. Negative
+ * strings are not allowed.
+ *
+ * Returns: 0 on success
+ */
 int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
-				unsigned long convmul, unsigned long convdiv)
+				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					    int dir, const struct ctl_table *table))
 {
-	return do_proc_doulongvec_minmax(table, dir, buffer, lenp, ppos,
-					 convmul, convdiv);
+	return do_proc_doulongvec(table, dir, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -1073,7 +1115,8 @@ int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos, 1l, 1l);
+	return do_proc_doulongvec(table, dir, buffer, lenp, ppos,
+				  do_proc_ulong_conv);
 }
 
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
@@ -1312,7 +1355,8 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 
 int proc_doulongvec_minmax_conv(const struct ctl_table *table, int dir,
 				void *buffer, size_t *lenp, loff_t *ppos,
-				unsigned long convmul, unsigned long convdiv)
+				int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					    int dir, const struct ctl_table *table))
 {
 	return -ENOSYS;
 }
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index a5c7d15fce72fd2c8c8a0e0b9e40901534152124..57ed5f363f94bd566aa53c061f20d3f4f2a05944 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -187,6 +187,24 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
 			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);
 }
 
+static int sysctl_u2k_ulong_conv_ms(const ulong *u_ptr, ulong *k_ptr)
+{
+	return proc_ulong_u2k_conv_uop(u_ptr, k_ptr, sysctl_msecs_to_jiffies);
+}
+
+static int sysctl_k2u_ulong_conv_ms(ulong *u_ptr, const ulong *k_ptr)
+{
+	return proc_ulong_k2u_conv_kop(u_ptr, k_ptr, sysctl_jiffies_to_msecs);
+}
+
+static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					 int dir, const struct ctl_table *tbl)
+{
+	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, false,
+			       sysctl_u2k_ulong_conv_ms, sysctl_k2u_ulong_conv_ms);
+}
+
+
 #else // CONFIG_PROC_SYSCTL
 static int do_proc_int_conv_jiffies(bool *negp, ulong *u_ptr, int *k_ptr,
 				    int dir, const struct ctl_table *tbl)
@@ -213,6 +231,12 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
 {
 	return -ENOSYS;
 }
+
+static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong *k_ptr,
+					 int dir, const struct ctl_table *tbl)
+{
+	return -ENOSYS;
+}
 #endif
 
 /**
@@ -314,7 +338,7 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_doulongvec_minmax_conv(table, dir, buffer, lenp, ppos,
-					   HZ, 1000l);
+					   do_proc_ulong_conv_ms_jiffies);
 }
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 

-- 
2.50.1



