Return-Path: <linux-fsdevel+bounces-64369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB7BE38B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EEFC4F5B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E0B3375A5;
	Thu, 16 Oct 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftZkmP5i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA30334393;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619499; cv=none; b=ujPaQM7NTEzDHXBCwnRJw4WzeRBJwddl0pMKlRbMGdCwsTYWDK3piDYtmFYXQXIPCzREXw9jM2XOXTx7ONxcC9kSdQYCDtiNmLbmhpkgsdFEcCBDtTLI7Xu2+YbjItPbBiBOo7tVe9pCaT3VjxwcU9DWUO+7boDnmxRfI9GLq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619499; c=relaxed/simple;
	bh=xhYBn//i7aNfh3cHC6GieFmJFdKrx9dZXxNHLeNVBSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJ83eqbScHcJZZVygRkDf0nPVu9rxNKKPzn8IRwGepT8BM69ykgZXFeT1fHF3DaTvVa1fL9QuCxiSkR9BGnwd2cRoA7yF3O8Mt7pxuippfJ2Ph4A6JCZitkmS2hVSsfEgjbeQTpZc6tQxqg0yYXzrq5L7zTK37B76jwVD3Kd4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftZkmP5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A9A7C113D0;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=xhYBn//i7aNfh3cHC6GieFmJFdKrx9dZXxNHLeNVBSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ftZkmP5ity1FNH0WB0Jr1IQ/Py5VujM3BF/8VEhqCzCrwO7CAiel9u8ry97s7xaRG
	 g4C+ywli5aK5lux5LvLGMURl0tqcjBB4ny9OhlTgxwsIjaksT6cbY4pl/3Fua/IEOE
	 97bFfptrhS69frm62Z9OTsGUGuDLp8SeEsKXkishP/z4Rg2vrwZ70H8tWPEznFlBA2
	 bUg2WATsfX7yy5QgY3I49uX1/Pw2IYFkwTrx++OPov2tQfnmSDfod4WFqlIQ9dhK4F
	 4tuEWgmEbIbmqt1R/i4y9k30lu6v+Ov9vW2cN0JvWAUWpNmhUdi9/twMfJmC5p3FEG
	 7/kPSPCBE4LHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27907CCD183;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:47 +0200
Subject: [PATCH v2 01/11] sysctl: Replace void pointer with const pointer
 to ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-1-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16261;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=xhYBn//i7aNfh3cHC6GieFmJFdKrx9dZXxNHLeNVBSo=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+LWrVllGc+KDl2poCDQhw1suA4i1uuur
 5zTsITSaPVXPYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OviAAoJELqXzVK3
 lkFPdgML/2U0UVjjAbJYRA2fNRLNQJpx4Y3e9QgonmeSu1beWFC4ZgpGZzEQWH3ao8bZUUlmjJ4
 k6Sa7LITF8GiL8PbXqix3Vgmsx3XFVQZwneJPJCCZ9YUyNeJm1eQnyn0HKoUgYsLPZlEbXfEHq2
 pErPVCvOriafPdHPpQvuafOT1jhYRQoKKaCtK4oNEgKxHf69sgtijIDFbF7eW2b1XmHkCBZwEX2
 00jS7lA04jw1NYARSQAka7FHgdNGPFUCdVb5WB8S6tBlc0XfS/Xr1f3DFsdlWO+aCs2BZPNovqS
 miQlv77Ycwl6Qqjp4/dCrbRp1moHg5SuqgIU+u7BmZ1igmdrGp9sKXYrCx0wiTTu59hD51WKp1p
 2Fwv3UdjmbwC6qiDRKJFsUxjj/3uvIGscVYPObr7CfjNgXP8wcfoztl/lT1daDAy9MlQaiBoV+t
 L3Exk+kq3bi6o40GCLR3El0GvZq8vEbCJbhgfSHw0Ox8sv3Wrh1tpoTCeylz4I1VBfIGHVKCW/6
 CA=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

* Replace void* data in the converter functions with a const struct
  ctl_table* table as it was only getting forwarding values from
  ctl_table->extra{1,2}.
* Remove the void* data in the do_proc_* functions as they already had a
  pointer to the ctl_table.
* Remove min/max structures do_proc_do{uint,int}vec_minmax_conv_param;
  the min/max values get passed directly in ctl_table.
* Keep min/max initialization in extra{1,2} in proc_dou8vec_minmax.
* The do_proc_douintvec was adjusted outside sysctl.c as it is exported
  to fs/pipe.c.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 fs/pipe.c              |   6 +-
 include/linux/sysctl.h |   5 +-
 kernel/sysctl.c        | 180 ++++++++++++++++++-------------------------------
 3 files changed, 71 insertions(+), 120 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 731622d0738d41a9d918dc5048e95e38b3b0e049..2431f05cb788f5bd89660f0fc6f4c4696e17d5dd 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1480,8 +1480,8 @@ static struct file_system_type pipe_fs_type = {
 
 #ifdef CONFIG_SYSCTL
 static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
-					unsigned int *valp,
-					int write, void *data)
+					unsigned int *valp, int write,
+					const struct ctl_table *table)
 {
 	if (write) {
 		unsigned int val;
@@ -1503,7 +1503,7 @@ static int proc_dopipe_max_size(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-				 do_proc_dopipe_max_size_conv, NULL);
+				 do_proc_dopipe_max_size_conv);
 }
 
 static const struct ctl_table fs_pipe_sysctls[] = {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 92e9146b1104123d3dc0ff004bd681861e297581..2d3d6c141b0b0aee21f2708450b7b41d8041a8cb 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -238,9 +238,8 @@ bool sysctl_is_alias(char *param);
 int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
-				  unsigned int *valp,
-				  int write, void *data),
-		      void *data);
+				  unsigned int *valp, int write,
+				  const struct ctl_table *table));
 
 extern int unaligned_enabled;
 extern int no_unaligned_warning;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb6196e3fa993daa21704d190baf366084e014f7..f0a691ffb29067a019a857a62fa56185aab06c61 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -355,8 +355,8 @@ static void proc_put_char(void **buf, size_t *size, char c)
 }
 
 static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
-				 int *valp,
-				 int write, void *data)
+				 int *valp, int write,
+				 const struct ctl_table *table)
 {
 	if (write) {
 		if (*negp) {
@@ -382,8 +382,8 @@ static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_douintvec_conv(unsigned long *lvalp,
-				  unsigned int *valp,
-				  int write, void *data)
+				  unsigned int *valp, int write,
+				  const struct ctl_table *table)
 {
 	if (write) {
 		if (*lvalp > UINT_MAX)
@@ -402,8 +402,7 @@ static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
 		  int write, void *buffer,
 		  size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
-			      int write, void *data),
-		  void *data)
+			      int write, const struct ctl_table *table))
 {
 	int *i, vleft, first = 1, err = 0;
 	size_t left;
@@ -444,12 +443,12 @@ static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
 					     sizeof(proc_wspace_sep), NULL);
 			if (err)
 				break;
-			if (conv(&neg, &lval, i, 1, data)) {
+			if (conv(&neg, &lval, i, 1, table)) {
 				err = -EINVAL;
 				break;
 			}
 		} else {
-			if (conv(&neg, &lval, i, 0, data)) {
+			if (conv(&neg, &lval, i, 0, table)) {
 				err = -EINVAL;
 				break;
 			}
@@ -474,11 +473,10 @@ static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
 static int do_proc_dointvec(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
-			      int write, void *data),
-		  void *data)
+			      int write, const struct ctl_table *table))
 {
 	return __do_proc_dointvec(table->data, table, write,
-			buffer, lenp, ppos, conv, data);
+			buffer, lenp, ppos, conv);
 }
 
 static int do_proc_douintvec_w(unsigned int *tbl_data,
@@ -486,9 +484,8 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 			       void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp,
-					   int write, void *data),
-			       void *data)
+					   unsigned int *valp, int write,
+					   const struct ctl_table *table))
 {
 	unsigned long lval;
 	int err = 0;
@@ -518,7 +515,7 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 		goto out_free;
 	}
 
-	if (conv(&lval, tbl_data, 1, data)) {
+	if (conv(&lval, tbl_data, 1, table)) {
 		err = -EINVAL;
 		goto out_free;
 	}
@@ -538,12 +535,12 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 	return err;
 }
 
-static int do_proc_douintvec_r(unsigned int *tbl_data, void *buffer,
+static int do_proc_douintvec_r(unsigned int *tbl_data,
+			       const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp,
-					   int write, void *data),
-			       void *data)
+					   unsigned int *valp, int write,
+					   const struct ctl_table *table))
 {
 	unsigned long lval;
 	int err = 0;
@@ -551,7 +548,7 @@ static int do_proc_douintvec_r(unsigned int *tbl_data, void *buffer,
 
 	left = *lenp;
 
-	if (conv(&lval, tbl_data, 0, data)) {
+	if (conv(&lval, tbl_data, 0, table)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -573,9 +570,8 @@ static int __do_proc_douintvec(void *tbl_data, const struct ctl_table *table,
 			       int write, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp,
-					   int write, void *data),
-			       void *data)
+					   unsigned int *valp, int write,
+					   const struct ctl_table *table))
 {
 	unsigned int *i, vleft;
 
@@ -601,19 +597,18 @@ static int __do_proc_douintvec(void *tbl_data, const struct ctl_table *table,
 
 	if (write)
 		return do_proc_douintvec_w(i, table, buffer, lenp, ppos,
-					   conv, data);
-	return do_proc_douintvec_r(i, buffer, lenp, ppos, conv, data);
+					   conv);
+	return do_proc_douintvec_r(i, table, buffer, lenp, ppos, conv);
 }
 
 int do_proc_douintvec(const struct ctl_table *table, int write,
 		      void *buffer, size_t *lenp, loff_t *ppos,
 		      int (*conv)(unsigned long *lvalp,
-				  unsigned int *valp,
-				  int write, void *data),
-		      void *data)
+				  unsigned int *valp, int write,
+				  const struct ctl_table *table))
 {
-	return __do_proc_douintvec(table->data, table, write,
-				   buffer, lenp, ppos, conv, data);
+	return __do_proc_douintvec(table->data, table, write, buffer, lenp,
+				   ppos, conv);
 }
 
 /**
@@ -672,7 +667,7 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 int proc_dointvec(const struct ctl_table *table, int write, void *buffer,
 		  size_t *lenp, loff_t *ppos)
 {
-	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
+	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL);
 }
 
 /**
@@ -692,42 +687,28 @@ int proc_douintvec(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-				 do_proc_douintvec_conv, NULL);
+				 do_proc_douintvec_conv);
 }
 
-/**
- * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
- *
- * The do_proc_dointvec_minmax_conv_param structure provides the
- * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_dointvec_minmax() handler.
- */
-struct do_proc_dointvec_minmax_conv_param {
-	int *min;
-	int *max;
-};
-
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
-					int *valp,
-					int write, void *data)
+					int *valp, int write,
+					const struct ctl_table *table)
 {
-	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	int tmp, ret, *min, *max;
 	/*
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
 	 */
 	int *ip = write ? &tmp : valp;
 
-	ret = do_proc_dointvec_conv(negp, lvalp, ip, write, data);
+	ret = do_proc_dointvec_conv(negp, lvalp, ip, write, table);
 	if (ret)
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		min = (int *) table->extra1;
+		max = (int *) table->extra2;
+		if ((min && *min > tmp) || (max && *max < tmp))
 			return -EINVAL;
 		WRITE_ONCE(*valp, tmp);
 	}
@@ -754,45 +735,27 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(const struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dointvec_minmax_conv, &param);
+				do_proc_dointvec_minmax_conv);
 }
 
-/**
- * struct do_proc_douintvec_minmax_conv_param - proc_douintvec_minmax() range checking structure
- * @min: pointer to minimum allowable value
- * @max: pointer to maximum allowable value
- *
- * The do_proc_douintvec_minmax_conv_param structure provides the
- * minimum and maximum values for doing range checking for those sysctl
- * parameters that use the proc_douintvec_minmax() handler.
- */
-struct do_proc_douintvec_minmax_conv_param {
-	unsigned int *min;
-	unsigned int *max;
-};
-
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
-					 unsigned int *valp,
-					 int write, void *data)
+					 unsigned int *valp, int write,
+					 const struct ctl_table *table)
 {
 	int ret;
-	unsigned int tmp;
-	struct do_proc_douintvec_minmax_conv_param *param = data;
+	unsigned int tmp, *min, *max;
 	/* write via temporary local uint for bounds-checking */
 	unsigned int *up = write ? &tmp : valp;
 
-	ret = do_proc_douintvec_conv(lvalp, up, write, data);
+	ret = do_proc_douintvec_conv(lvalp, up, write, table);
 	if (ret)
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-		    (param->max && *param->max < tmp))
+		min = (unsigned int *) table->extra1;
+		max = (unsigned int *) table->extra2;
+		if ((min && *min > tmp) || (max && *max < tmp))
 			return -ERANGE;
 
 		WRITE_ONCE(*valp, tmp);
@@ -823,12 +786,8 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
-	};
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
-				 do_proc_douintvec_minmax_conv, &param);
+				 do_proc_douintvec_minmax_conv);
 }
 
 /**
@@ -854,28 +813,24 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 	struct ctl_table tmp;
 	unsigned int min = 0, max = 255U, val;
 	u8 *data = table->data;
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = &min,
-		.max = &max,
-	};
 	int res;
 
 	/* Do not support arrays yet. */
 	if (table->maxlen != sizeof(u8))
 		return -EINVAL;
 
-	if (table->extra1)
-		min = *(unsigned int *) table->extra1;
-	if (table->extra2)
-		max = *(unsigned int *) table->extra2;
-
 	tmp = *table;
 
 	tmp.maxlen = sizeof(val);
 	tmp.data = &val;
+	if (!tmp.extra1)
+		tmp.extra1 = (unsigned int *) &min;
+	if (!tmp.extra2)
+		tmp.extra2 = (unsigned int *) &max;
+
 	val = READ_ONCE(*data);
 	res = do_proc_douintvec(&tmp, write, buffer, lenp, ppos,
-				do_proc_douintvec_minmax_conv, &param);
+				do_proc_douintvec_minmax_conv);
 	if (res)
 		return res;
 	if (write)
@@ -1014,8 +969,8 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 
 
 static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
-					 int *valp,
-					 int write, void *data)
+					 int *valp, int write,
+					 const struct ctl_table *table)
 {
 	if (write) {
 		if (*lvalp > INT_MAX / HZ)
@@ -1040,8 +995,8 @@ static int do_proc_dointvec_jiffies_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp,
-						int *valp,
-						int write, void *data)
+						int *valp, int write,
+						const struct ctl_table *table)
 {
 	if (write) {
 		if (USER_HZ < HZ && *lvalp > (LONG_MAX / HZ) * USER_HZ)
@@ -1063,8 +1018,8 @@ static int do_proc_dointvec_userhz_jiffies_conv(bool *negp, unsigned long *lvalp
 }
 
 static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
-					    int *valp,
-					    int write, void *data)
+					    int *valp, int write,
+					    const struct ctl_table *table)
 {
 	if (write) {
 		unsigned long jif = msecs_to_jiffies(*negp ? -*lvalp : *lvalp);
@@ -1088,23 +1043,24 @@ static int do_proc_dointvec_ms_jiffies_conv(bool *negp, unsigned long *lvalp,
 }
 
 static int do_proc_dointvec_ms_jiffies_minmax_conv(bool *negp, unsigned long *lvalp,
-						int *valp, int write, void *data)
+						int *valp, int write,
+						const struct ctl_table *table)
 {
-	int tmp, ret;
-	struct do_proc_dointvec_minmax_conv_param *param = data;
+	int tmp, ret, *min, *max;
 	/*
 	 * If writing, first do so via a temporary local int so we can
 	 * bounds-check it before touching *valp.
 	 */
 	int *ip = write ? &tmp : valp;
 
-	ret = do_proc_dointvec_ms_jiffies_conv(negp, lvalp, ip, write, data);
+	ret = do_proc_dointvec_ms_jiffies_conv(negp, lvalp, ip, write, table);
 	if (ret)
 		return ret;
 
 	if (write) {
-		if ((param->min && *param->min > tmp) ||
-				(param->max && *param->max < tmp))
+		min = (int *) table->extra1;
+		max = (int *) table->extra2;
+		if ((min && *min > tmp) || (max && *max < tmp))
 			return -EINVAL;
 		*valp = tmp;
 	}
@@ -1130,18 +1086,14 @@ int proc_dointvec_jiffies(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
     return do_proc_dointvec(table,write,buffer,lenp,ppos,
-		    	    do_proc_dointvec_jiffies_conv,NULL);
+			    do_proc_dointvec_jiffies_conv);
 }
 
 int proc_dointvec_ms_jiffies_minmax(const struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
+			do_proc_dointvec_ms_jiffies_minmax_conv);
 }
 
 /**
@@ -1163,7 +1115,7 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dointvec_userhz_jiffies_conv, NULL);
+				do_proc_dointvec_userhz_jiffies_conv);
 }
 
 /**
@@ -1185,7 +1137,7 @@ int proc_dointvec_ms_jiffies(const struct ctl_table *table, int write, void *buf
 		size_t *lenp, loff_t *ppos)
 {
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
-				do_proc_dointvec_ms_jiffies_conv, NULL);
+				do_proc_dointvec_ms_jiffies_conv);
 }
 
 /**

-- 
2.50.1



