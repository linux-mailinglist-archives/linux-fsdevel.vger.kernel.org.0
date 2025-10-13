Return-Path: <linux-fsdevel+bounces-63963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E726ABD330C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36BA54F1DC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E6306B38;
	Mon, 13 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1nOwW7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8E83064AC;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=rYm8AjUu9Sii1CjLjGZb+WqRfeT5+Ua0sbHtchbBHxjvAbFVDra80LUTgsyg/OzEkL00f8gNT6jwtNYhEh5bAjsVdMy2Cb5vsdFZCVM/ec0RS4qDhUQffdDlX/A/pcP3p7zLG5eftJvCqAwL+q4jyxyTxlGTCX1D9m+mzDbckU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=UsZpr7tzJfURt5nWobiw5O5X9RgHQGws0QBptGLRrMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEfkW3jzLTcRzZaG19LhIlIA2tN3kF1JX8GJ/7wZxLHNvlLTkcgwUsbveD9rfGzoDJFm3jEfSt9ubDttFUaGqq7IbQW4Jgzl6FTHAYhm9eOiM+cmbnHuSwsNueZ1vMjN6oDhEdYnZDi+uYfR7AWIiMbQxHnP/sth9LHq73T5xRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1nOwW7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 230DAC19423;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=UsZpr7tzJfURt5nWobiw5O5X9RgHQGws0QBptGLRrMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b1nOwW7AfK9luogtTgs05zzCpml3/fzctXuhf1CFQNi8WAY51R0VvQf699LuSDsqm
	 hNTGbXzOKos93saoe1Jo4zLaSNrRjbN2DjwqnWsybV8iglqxRPXt0dAd5jmBYsDZDv
	 LtAwpRLIK66Hg2KAzfWG2az9q1ksV2BZ1VtuHUrvlQ/ohcNkdkdE1AuzSiPTaz/Krr
	 6Ij1xYLI+7F5EBqgQIdzRf6fCPPEHVZ5Ax3LhSVE3pTmrv6yBebQsWuhid1VbPtXUt
	 Agf1C1vWRqGqj73FFX1jSQI27KC8by4Ctk0MytP6Z0w6RU1qVI1uQM6d4QFqq0DX8R
	 RMP069X3y8TYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D2CCD190;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:54 +0200
Subject: [PATCH 4/8] sysctl: Indicate the direction of operation with macro
 names
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-4-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=30764;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=UsZpr7tzJfURt5nWobiw5O5X9RgHQGws0QBptGLRrMY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dTA1+41uAmQnJdi2KW5yI496ZT1He0aX
 FT0Q5POC0aDc4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3UAAoJELqXzVK3
 lkFPG3AL/30FerG4eudsbWgjEHJ6/n9EUtWM+r4RzxSER9a8jJ1tER5doCNmWl650Ec3Hty4BNr
 uzG1kEZAAsp3sV8h7bbPYut/x7I/YMs2IVZ0oi7h/CGieUrvo9HgNMtIN4AV2tDSj0K87FK/h9C
 ytY6onUqFccRMTIMHgYv+cSNnUCXu4XCverXnJCsmtIlODwA3le4/9Fx9UR/YkldAdYK22+8QH3
 3dkT4qVDDPxzzXr6TmdADLJpYwzMGBje6ZOOuMsnGd0bSM13F4yP8sgFB0ukrU4kIWC7z6TErQX
 RaWsRyLydbkAQfcTonPirYK468hiZXOXC4IDw+Xx5Y6L8gxC2ShU++n1GpB0zS/NUs6dOEM2Rmb
 W2eM5o9+ptvRELeGCpx8++Ia1OkDLk3RGScr71RbyaowcHX2OHfsZRvxpNZvqyQKCZGjrRmyL32
 mC+vTed1m2nOXuV1WRIAQR1w91Esha0Jmfk4zx84IVKk5kMqiY7y65p6TVABJSYjijb6xfuu0+8
 JY=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Replace the "write" integer parameter with SYSCTL_USER_TO_KERN() and
SYSCTL_KERN_TO_USER() that clearly indicate data flow direction in
sysctl operations.

"write" originates in proc_sysctl.c (proc_sys_{read,write}) and can take
one of two values: "0" or "1" when called from proc_sys_read and
proc_sys_write respectively. When write has a value of zero, data is
"written" to a user space buffer from a kernel variable (usually
ctl_table->data). Whereas when write has a value greater than zero, data
is "written" to an internal kernel variable from a user space buffer.
Remove this ambiguity by introducing macros that clearly indicate the
direction of the "write".

The write mode names in sysctl_writes_mode are left unchanged as these
directly relate to the sysctl_write_strict file in /proc/sys where the
word "write" unambiguously refers to writing to a file.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 252 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 136 insertions(+), 116 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b042d81fd1c6a32f60e2834a98d48c1bc348de0..69148fe7359994b85c076b7b6750792b2d1c751e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -30,6 +30,19 @@ EXPORT_SYMBOL(sysctl_vals);
 const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
 EXPORT_SYMBOL_GPL(sysctl_long_vals);
 
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
 #if defined(CONFIG_SYSCTL)
 
 /* Constants used for minimum and maximum */
@@ -55,7 +68,8 @@ static const int cap_last_cap = CAP_LAST_CAP;
  *	to the buffer.
  *
  * These write modes control how current file position affects the behavior of
- * updating sysctl values through the proc interface on each write.
+ * updating internal kernel (SYSCTL_USER_TO_KERN) sysctl values through the proc
+ * interface on each write.
  */
 enum sysctl_writes_mode {
 	SYSCTL_WRITES_LEGACY		= -1,
@@ -73,7 +87,7 @@ static enum sysctl_writes_mode sysctl_writes_strict = SYSCTL_WRITES_STRICT;
 
 #ifdef CONFIG_PROC_SYSCTL
 
-static int _proc_do_string(char *data, int maxlen, int write,
+static int _proc_do_string(char *data, int maxlen, int dir,
 		char *buffer, size_t *lenp, loff_t *ppos)
 {
 	size_t len;
@@ -84,7 +98,7 @@ static int _proc_do_string(char *data, int maxlen, int write,
 		return 0;
 	}
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (sysctl_writes_strict == SYSCTL_WRITES_STRICT) {
 			/* Only continue writes not past the end of buffer. */
 			len = strlen(data);
@@ -172,7 +186,7 @@ static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
 /**
  * proc_dostring - read a string sysctl
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -186,13 +200,13 @@ static bool proc_first_pos_non_zero_ignore(loff_t *ppos,
  *
  * Returns 0 on success.
  */
-int proc_dostring(const struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	if (write)
+	if (SYSCTL_USER_TO_KERN(dir))
 		proc_first_pos_non_zero_ignore(ppos, table);
 
-	return _proc_do_string(table->data, table->maxlen, write, buffer, lenp,
+	return _proc_do_string(table->data, table->maxlen, dir, buffer, lenp,
 			ppos);
 }
 
@@ -355,10 +369,10 @@ static void proc_put_char(void **buf, size_t *size, char c)
 }
 
 static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
-				 int *valp, int write,
+				 int *valp, int dir,
 				 const struct ctl_table *table)
 {
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (*negp) {
 			if (*lvalp > (unsigned long) INT_MAX + 1)
 				return -EINVAL;
@@ -382,10 +396,10 @@ static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_douintvec_conv(unsigned long *lvalp,
-				  unsigned int *valp, int write,
+				  unsigned int *valp, int dir,
 				  const struct ctl_table *table)
 {
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (*lvalp > UINT_MAX)
 			return -EINVAL;
 		WRITE_ONCE(*valp, *lvalp);
@@ -399,16 +413,17 @@ static int do_proc_douintvec_conv(unsigned long *lvalp,
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
 
-static int do_proc_dointvec(const struct ctl_table *table, int write,
+static int do_proc_dointvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
-			      int write, const struct ctl_table *table))
+			      int dir, const struct ctl_table *table))
 {
 	int *i, vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
 
-	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp ||
+	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
 		return 0;
 	}
@@ -420,7 +435,7 @@ static int do_proc_dointvec(const struct ctl_table *table, int write,
 	if (!conv)
 		conv = do_proc_dointvec_conv;
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
 			goto out;
 
@@ -433,7 +448,7 @@ static int do_proc_dointvec(const struct ctl_table *table, int write,
 		unsigned long lval;
 		bool neg;
 
-		if (write) {
+		if (SYSCTL_USER_TO_KERN(dir)) {
 			proc_skip_spaces(&p, &left);
 
 			if (!left)
@@ -458,11 +473,11 @@ static int do_proc_dointvec(const struct ctl_table *table, int write,
 		}
 	}
 
-	if (!write && !first && left && !err)
+	if (SYSCTL_KERN_TO_USER(dir) && !first && left && !err)
 		proc_put_char(&buffer, &left, '\n');
-	if (write && !err && left)
+	if (SYSCTL_USER_TO_KERN(dir) && !err && left)
 		proc_skip_spaces(&p, &left);
-	if (write && first)
+	if (SYSCTL_USER_TO_KERN(dir) && first)
 		return err ? : -EINVAL;
 	*lenp -= left;
 out:
@@ -473,7 +488,7 @@ static int do_proc_dointvec(const struct ctl_table *table, int write,
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp, int write,
+					   unsigned int *valp, int dir,
 					   const struct ctl_table *table))
 {
 	unsigned long lval;
@@ -526,7 +541,7 @@ static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp, int write,
+					   unsigned int *valp, int dir,
 					   const struct ctl_table *table))
 {
 	unsigned long lval;
@@ -553,14 +568,15 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 	return err;
 }
 
-int do_proc_douintvec(const struct ctl_table *table, int write, void *buffer,
+int do_proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		      size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp, unsigned int *valp,
-				  int write, const struct ctl_table *table))
+				  int dir, const struct ctl_table *table))
 {
 	unsigned int vleft;
 
-	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp ||
+	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
 		return 0;
 	}
@@ -579,7 +595,7 @@ int do_proc_douintvec(const struct ctl_table *table, int write, void *buffer,
 	if (!conv)
 		conv = do_proc_douintvec_conv;
 
-	if (write)
+	if (SYSCTL_USER_TO_KERN(dir))
 		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
 }
@@ -587,7 +603,7 @@ int do_proc_douintvec(const struct ctl_table *table, int write, void *buffer,
 /**
  * proc_dobool - read/write a bool
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -600,7 +616,7 @@ int do_proc_douintvec(const struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_dobool(const struct ctl_table *table, int write, void *buffer,
+int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
@@ -616,10 +632,10 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 	tmp.data = &val;
 
 	val = READ_ONCE(*data);
-	res = proc_dointvec(&tmp, write, buffer, lenp, ppos);
+	res = proc_dointvec(&tmp, dir, buffer, lenp, ppos);
 	if (res)
 		return res;
-	if (write)
+	if (SYSCTL_USER_TO_KERN(dir))
 		WRITE_ONCE(*data, val);
 	return 0;
 }
@@ -627,7 +643,7 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 /**
  * proc_dointvec - read a vector of integers
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -637,16 +653,16 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_dointvec(const struct ctl_table *table, int write, void *buffer,
+int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL);
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos, NULL);
 }
 
 /**
  * proc_douintvec - read a vector of unsigned integers
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -656,15 +672,15 @@ int proc_dointvec(const struct ctl_table *table, int write, void *buffer,
  *
  * Returns 0 on success.
  */
-int proc_douintvec(const struct ctl_table *table, int write, void *buffer,
+int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, write, buffer, lenp, ppos,
+	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
 				 do_proc_douintvec_conv);
 }
 
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
-					int *valp, int write,
+					int *valp, int dir,
 					const struct ctl_table *table)
 {
 	int tmp, ret, *min, *max;
@@ -672,13 +688,13 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
 	 */
-	int *ip = write ? &tmp : valp;
+	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
 
-	ret = do_proc_dointvec_conv(negp, lvalp, ip, write, table);
+	ret = do_proc_dointvec_conv(negp, lvalp, ip, dir, table);
 	if (ret)
 		return ret;
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		min = (int *) table->extra1;
 		max = (int *) table->extra2;
 		if ((min && *min > tmp) || (max && *max < tmp))
@@ -692,7 +708,7 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 /**
  * proc_dointvec_minmax - read a vector of integers with min/max values
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -703,29 +719,30 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success or -EINVAL on write when the range check fails.
+ * Returns 0 on success or -EINVAL when the range check fails and
+ * SYSCTL_USER_TO_KERN(dir) == true
  */
-int proc_dointvec_minmax(const struct ctl_table *table, int write,
+int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv);
 }
 
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
-					 unsigned int *valp, int write,
+					 unsigned int *valp, int dir,
 					 const struct ctl_table *table)
 {
 	int ret;
 	unsigned int tmp, *min, *max;
-	/* write via temporary local uint for bounds-checking */
-	unsigned int *up = write ? &tmp : valp;
+	/* When writing to the kernel use a temp local uint for bounds-checking */
+	unsigned int *up = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
 
-	ret = do_proc_douintvec_conv(lvalp, up, write, table);
+	ret = do_proc_douintvec_conv(lvalp, up, dir, table);
 	if (ret)
 		return ret;
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		min = (unsigned int *) table->extra1;
 		max = (unsigned int *) table->extra2;
 		if ((min && *min > tmp) || (max && *max < tmp))
@@ -740,7 +757,7 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 /**
  * proc_douintvec_minmax - read a vector of unsigned ints with min/max values
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -754,19 +771,20 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
  * check for UINT_MAX to avoid having to support wrap around uses from
  * userspace.
  *
- * Returns 0 on success or -ERANGE on write when the range check fails.
+ * Returns 0 on success or -ERANGE when range check failes and
+ * SYSCTL_USER_TO_KERN(dir) == true
  */
-int proc_douintvec_minmax(const struct ctl_table *table, int write,
+int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_douintvec(table, write, buffer, lenp, ppos,
+	return do_proc_douintvec(table, dir, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv);
 }
 
 /**
  * proc_dou8vec_minmax - read a vector of unsigned chars with min/max values
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -778,9 +796,10 @@ int proc_douintvec_minmax(const struct ctl_table *table, int write,
  * This routine will ensure the values are within the range specified by
  * table->extra1 (min) and table->extra2 (max).
  *
- * Returns 0 on success or an error on write when the range check fails.
+ * Returns 0 on success or an error on SYSCTL_USER_TO_KERN(dir) == true
+ * and the range check fails.
  */
-int proc_dou8vec_minmax(const struct ctl_table *table, int write,
+int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
@@ -802,17 +821,17 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 		tmp.extra2 = (unsigned int *) &max;
 
 	val = READ_ONCE(*data);
-	res = do_proc_douintvec(&tmp, write, buffer, lenp, ppos,
+	res = do_proc_douintvec(&tmp, dir, buffer, lenp, ppos,
 				do_proc_douintvec_minmax_conv);
 	if (res)
 		return res;
-	if (write)
+	if (SYSCTL_USER_TO_KERN(dir))
 		WRITE_ONCE(*data, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
+static int do_proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 				     void *buffer, size_t *lenp, loff_t *ppos,
 				     unsigned long convmul,
 				     unsigned long convdiv)
@@ -822,7 +841,8 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 	size_t left;
 	char *p;
 
-	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp ||
+	    (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
 		return 0;
 	}
@@ -833,7 +853,7 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (proc_first_pos_non_zero_ignore(ppos, table))
 			goto out;
 
@@ -845,7 +865,7 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 	for (; left && vleft--; i++, first = 0) {
 		unsigned long val;
 
-		if (write) {
+		if (SYSCTL_USER_TO_KERN(dir)) {
 			bool neg;
 
 			proc_skip_spaces(&p, &left);
@@ -874,11 +894,11 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		}
 	}
 
-	if (!write && !first && left && !err)
+	if (SYSCTL_KERN_TO_USER(dir) && !first && left && !err)
 		proc_put_char(&buffer, &left, '\n');
-	if (write && !err)
+	if (SYSCTL_USER_TO_KERN(dir) && !err)
 		proc_skip_spaces(&p, &left);
-	if (write && first)
+	if (SYSCTL_USER_TO_KERN(dir) && first)
 		return err ? : -EINVAL;
 	*lenp -= left;
 out:
@@ -889,7 +909,7 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 /**
  * proc_doulongvec_minmax - read a vector of long integers with min/max values
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -902,16 +922,16 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_minmax(const struct ctl_table *table, int write,
+int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos, 1l, 1l);
+	return do_proc_doulongvec_minmax(table, dir, buffer, lenp, ppos, 1l, 1l);
 }
 
 /**
  * proc_doulongvec_ms_jiffies_minmax - read a vector of millisecond values with min/max values
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -925,19 +945,19 @@ int proc_doulongvec_minmax(const struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_doulongvec_minmax(table, write, buffer,
-				     lenp, ppos, HZ, 1000l);
+	return do_proc_doulongvec_minmax(table, dir, buffer,
+					 lenp, ppos, HZ, 1000l);
 }
 
 
 static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
-					 int *valp, int write,
+					 int *valp, int dir,
 					 const struct ctl_table *table)
 {
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (*lvalp > INT_MAX / HZ)
 			return 1;
 		if (*negp)
@@ -960,10 +980,10 @@ static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp,
-						int *valp, int write,
+						int *valp, int dir,
 						const struct ctl_table *table)
 {
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		if (USER_HZ < HZ && *lvalp > (LONG_MAX / HZ) * USER_HZ)
 			return 1;
 		*valp = clock_t_to_jiffies(*negp ? -*lvalp : *lvalp);
@@ -983,10 +1003,10 @@ static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp
 }
 
 static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
-					    int *valp, int write,
+					    int *valp, int dir,
 					    const struct ctl_table *table)
 {
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		unsigned long jif = msecs_to_jiffies(*negp ? -*lvalp : *lvalp);
 
 		if (jif > INT_MAX)
@@ -1008,7 +1028,7 @@ static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lvalp,
-						int *valp, int write,
+						int *valp, int dir,
 						const struct ctl_table *table)
 {
 	int tmp, ret, *min, *max;
@@ -1016,13 +1036,13 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
 	 */
-	int *ip = write ? &tmp : valp;
+	int *ip = SYSCTL_USER_TO_KERN(dir) ? &tmp : valp;
 
-	ret = do_proc_dointvec_ms_jiffies_conv(negp, lvalp, ip, write, table);
+	ret = do_proc_dointvec_ms_jiffies_conv(negp, lvalp, ip, dir, table);
 	if (ret)
 		return ret;
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		min = (int *) table->extra1;
 		max = (int *) table->extra2;
 		if ((min && *min > tmp) || (max && *max < tmp))
@@ -1035,7 +1055,7 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
 /**
  * proc_dointvec_jiffies - read a vector of integers as seconds
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -1047,24 +1067,24 @@ static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lv
  *
  * Returns 0 on success.
  */
-int proc_dointvec_jiffies(const struct ctl_table *table, int write,
+int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-    return do_proc_dointvec(table,write,buffer,lenp,ppos,
-			    do_proc_dointvec_jiffies_conv);
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
+				do_proc_dointvec_jiffies_conv);
 }
 
-int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv);
 }
 
 /**
  * proc_dointvec_userhz_jiffies - read a vector of integers as 1/USER_HZ seconds
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: pointer to the file position
@@ -1076,17 +1096,17 @@ int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
 				do_proc_dointvec_userhz_jiffies_conv);
 }
 
 /**
  * proc_dointvec_ms_jiffies - read a vector of integers as 1 milliseconds
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: the current position in the file
@@ -1098,17 +1118,17 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
  *
  * Returns 0 on success.
  */
-int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buffer,
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos,
+	return do_proc_dointvec(table, dir, buffer, lenp, ppos,
 				do_proc_dointvec_ms_jiffies_conv);
 }
 
 /**
  * proc_do_large_bitmap - read/write from/to a large bitmap
  * @table: the sysctl table
- * @write: %TRUE if this is a write to the sysctl file
+ * @dir: %TRUE if this is a write to the sysctl file
  * @buffer: the user buffer
  * @lenp: the size of the user buffer
  * @ppos: file position
@@ -1122,7 +1142,7 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buf
  *
  * Returns 0 on success.
  */
-int proc_do_large_bitmap(const struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int err = 0;
@@ -1132,12 +1152,12 @@ int proc_do_large_bitmap(const struct ctl_table *table, int write,
 	unsigned long *tmp_bitmap = NULL;
 	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
 
-	if (!bitmap || !bitmap_len || !left || (*ppos && !write)) {
+	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;
 		return 0;
 	}
 
-	if (write) {
+	if (SYSCTL_USER_TO_KERN(dir)) {
 		char *p = buffer;
 		size_t skipped = 0;
 
@@ -1238,7 +1258,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int write,
 	}
 
 	if (!err) {
-		if (write) {
+		if (SYSCTL_USER_TO_KERN(dir)) {
 			if (*ppos)
 				bitmap_or(bitmap, bitmap, tmp_bitmap, bitmap_len);
 			else
@@ -1254,85 +1274,85 @@ int proc_do_large_bitmap(const struct ctl_table *table, int write,
 
 #else /* CONFIG_PROC_SYSCTL */
 
-int proc_dostring(const struct ctl_table *table, int write,
+int proc_dostring(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dobool(const struct ctl_table *table, int write,
+int proc_dobool(const struct ctl_table *table, int dir,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec(const struct ctl_table *table, int write,
+int proc_dointvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_douintvec(const struct ctl_table *table, int write,
+int proc_douintvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_minmax(const struct ctl_table *table, int write,
+int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_douintvec_minmax(const struct ctl_table *table, int write,
+int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dou8vec_minmax(const struct ctl_table *table, int write,
+int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_jiffies(const struct ctl_table *table, int write,
+int proc_dointvec_jiffies(const struct ctl_table *table, int dir,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
+int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write,
+int proc_dointvec_ms_jiffies(const struct ctl_table *table, int dir,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_doulongvec_minmax(const struct ctl_table *table, int write,
+int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
 		    void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
+int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
 }
 
-int proc_do_large_bitmap(const struct ctl_table *table, int write,
+int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return -ENOSYS;
@@ -1341,7 +1361,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int write,
 #endif /* CONFIG_PROC_SYSCTL */
 
 #if defined(CONFIG_SYSCTL)
-int proc_do_static_key(const struct ctl_table *table, int write,
+int proc_do_static_key(const struct ctl_table *table, int dir,
 		       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct static_key *key = (struct static_key *)table->data;
@@ -1355,13 +1375,13 @@ int proc_do_static_key(const struct ctl_table *table, int write,
 		.extra2 = SYSCTL_ONE,
 	};
 
-	if (write && !capable(CAP_SYS_ADMIN))
+	if (SYSCTL_USER_TO_KERN(dir) && !capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
 	mutex_lock(&static_key_mutex);
 	val = static_key_enabled(key);
-	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-	if (write && !ret) {
+	ret = proc_dointvec_minmax(&tmp, dir, buffer, lenp, ppos);
+	if (SYSCTL_USER_TO_KERN(dir) && !ret) {
 		if (val)
 			static_key_enable(key);
 		else

-- 
2.50.1



