Return-Path: <linux-fsdevel+bounces-64368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DCDBE38B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B65104EECA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD8E3375A1;
	Thu, 16 Oct 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlcP+TCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B4334391;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619499; cv=none; b=NF9OC9XFjjOsfWTF97GBSDQQabsYOq+CsXrXo2gb6yPRUq58OTcRfy0lT+42RjMtzudPlWmSCqWcBMBJB+P8gEjsMrlaA5cahu6vdB1nTW+FBYxz6g509vvQTFbk1M0gaw4f1+PmixRBJPwz3h1+5lm0jeYdmR1eAxMyyTo5R8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619499; c=relaxed/simple;
	bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rku7IeK0C1PpZRtcha8+LAf5lBhECKJCjSMM9Lx2TC1/VJ5LHSMr4uHrVj5X4nIR5bc+FSzktr8Wf0590utJXuwIAep3NDepk97NDF1bavW2SC4IRmAj82Yg9ykybxKHTqCt7xBBIRJZNiuS9CoTdREIT7Fz/rdhCwm8IndNAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlcP+TCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F517C4CEF1;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IlcP+TCZ94Pw+woBWTB/4GQngfIVtxJpitJjiefrAkK9KXt0UwyvbnBxyT9xU/yxl
	 hLM9bN/746FleusLj85o+9sQsR81KhcQ7l+o77eqidFdT8pdWNH9tbTJjsyBsyCXQh
	 Gh6puYim1nZpIttCi4WlLoBGUhx9TCrW+CLfAbQA1t2kB5cxr2Nf4YNni+sjOdryBt
	 WgX9ApHHTyxGZmQj+j21QCy0c3mGn5nok+F6RQsaELdcIK6Qz7pnrG0R5+9tkNX3l2
	 DVoRZZ0+clKiOkqTScJFZv/RTqfm6nuYwa1P5W+QSOYNOFxD1JnVTK4iYgONw+sRh2
	 CCKSmcQPtbH4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3951FCCD19A;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:48 +0200
Subject: [PATCH v2 02/11] sysctl: Remove superfluous tbl_data param from
 "dovec" functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-2-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6367;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+OSwnAXSecEofoSJdhYwp4eSvfkdDhS8
 C24y4JH6ghvjokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvjAAoJELqXzVK3
 lkFP5/MMAITRsBv4MBXKnGnO2Ka7asmGMwePdBHETEaYo+hnr7RtplAW3NcxcvgAWsKChiVEInh
 yXYX00joNa1hElqQHlQJkOhcdDNosbtvAAR2J3SuLUebXnt7Y41HF2RP/h6z8GCBEddkgsybQcd
 xB2cJhyuSJZrSM76Gov1A72YPgWFCHHfctlQB3NiPhRuO9fAYbACCAvlUbwkG9ySK2XngyuGcdJ
 XQ8dXNGKV1HlMQ8P3wRmEgbavP0cu8kzo4qqlgpi/O0HA8dyTW9FOg+2EFL160ai8Eg14Hju2dp
 MaSLNRRAZUgKP+aYeB9M2ncOirGZiMFZJKC+LcWvfOZqLuQwrxadUbE8uIfEwvLAe2joA73LUqZ
 ZzSg+vbM1MA0ZqsLTNY2PgUwwGCwti6tXUlX6aSxnkZKjYIi3rYDX4SsaFzRGtIybiwQbJKzpwV
 ok4bGt/NH4dTT5+GSIBIUhvPeWghcaRsnfZ5gqVyj2TIldgieSGkXn5kjVweS5GUDJLY++kitw5
 +w=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove superfluous tbl_data param from do_proc_douintvec{,_r,_w}
and __do_proc_do{intvec,uintvec,ulongvec_minmax}. There is no need to
pass it as it is always contained within the ctl_table struct.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 61 ++++++++++++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f0a691ffb29067a019a857a62fa56185aab06c61..0e249a1f99fec084db649782f5ef8b37e40c6a7c 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -398,22 +398,22 @@ static int do_proc_douintvec_conv(unsigned long *lvalp,
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
-static int __do_proc_dointvec(void *tbl_data, const struct ctl_table *table,
-		  int write, void *buffer,
-		  size_t *lenp, loff_t *ppos,
-		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
-			      int write, const struct ctl_table *table))
+static int __do_proc_dointvec(const struct ctl_table *table, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos,
+			      int (*conv)(bool *negp, unsigned long *lvalp,
+					  int *valp, int write,
+					  const struct ctl_table *table))
 {
 	int *i, vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
 
-	if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
 
-	i = (int *) tbl_data;
+	i = (int *) table->data;
 	vleft = table->maxlen / sizeof(*i);
 	left = *lenp;
 
@@ -475,13 +475,10 @@ static int do_proc_dointvec(const struct ctl_table *table, int write,
 		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
 			      int write, const struct ctl_table *table))
 {
-	return __do_proc_dointvec(table->data, table, write,
-			buffer, lenp, ppos, conv);
+	return __do_proc_dointvec(table, write, buffer, lenp, ppos, conv);
 }
 
-static int do_proc_douintvec_w(unsigned int *tbl_data,
-			       const struct ctl_table *table,
-			       void *buffer,
+static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
 					   unsigned int *valp, int write,
@@ -515,7 +512,7 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 		goto out_free;
 	}
 
-	if (conv(&lval, tbl_data, 1, table)) {
+	if (conv(&lval, (unsigned int *) table->data, 1, table)) {
 		err = -EINVAL;
 		goto out_free;
 	}
@@ -535,8 +532,7 @@ static int do_proc_douintvec_w(unsigned int *tbl_data,
 	return err;
 }
 
-static int do_proc_douintvec_r(unsigned int *tbl_data,
-			       const struct ctl_table *table, void *buffer,
+static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
 					   unsigned int *valp, int write,
@@ -548,7 +544,7 @@ static int do_proc_douintvec_r(unsigned int *tbl_data,
 
 	left = *lenp;
 
-	if (conv(&lval, tbl_data, 0, table)) {
+	if (conv(&lval, (unsigned int *) table->data, 0, table)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -566,22 +562,20 @@ static int do_proc_douintvec_r(unsigned int *tbl_data,
 	return err;
 }
 
-static int __do_proc_douintvec(void *tbl_data, const struct ctl_table *table,
-			       int write, void *buffer,
-			       size_t *lenp, loff_t *ppos,
+static int __do_proc_douintvec(const struct ctl_table *table, int write,
+			       void *buffer, size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
 					   unsigned int *valp, int write,
 					   const struct ctl_table *table))
 {
-	unsigned int *i, vleft;
+	unsigned int vleft;
 
-	if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
 
-	i = (unsigned int *) tbl_data;
-	vleft = table->maxlen / sizeof(*i);
+	vleft = table->maxlen / sizeof(unsigned int);
 
 	/*
 	 * Arrays are not supported, keep this simple. *Do not* add
@@ -596,9 +590,8 @@ static int __do_proc_douintvec(void *tbl_data, const struct ctl_table *table,
 		conv = do_proc_douintvec_conv;
 
 	if (write)
-		return do_proc_douintvec_w(i, table, buffer, lenp, ppos,
-					   conv);
-	return do_proc_douintvec_r(i, table, buffer, lenp, ppos, conv);
+		return do_proc_douintvec_w(table, buffer, lenp, ppos, conv);
+	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
 }
 
 int do_proc_douintvec(const struct ctl_table *table, int write,
@@ -607,8 +600,7 @@ int do_proc_douintvec(const struct ctl_table *table, int write,
 				  unsigned int *valp, int write,
 				  const struct ctl_table *table))
 {
-	return __do_proc_douintvec(table->data, table, write, buffer, lenp,
-				   ppos, conv);
+	return __do_proc_douintvec(table, write, buffer, lenp, ppos, conv);
 }
 
 /**
@@ -839,9 +831,8 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-static int __do_proc_doulongvec_minmax(void *data,
-		const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos,
+static int __do_proc_doulongvec_minmax(const struct ctl_table *table,
+		int write, void *buffer, size_t *lenp, loff_t *ppos,
 		unsigned long convmul, unsigned long convdiv)
 {
 	unsigned long *i, *min, *max;
@@ -849,12 +840,12 @@ static int __do_proc_doulongvec_minmax(void *data,
 	size_t left;
 	char *p;
 
-	if (!data || !table->maxlen || !*lenp || (*ppos && !write)) {
+	if (!table->data || !table->maxlen || !*lenp || (*ppos && !write)) {
 		*lenp = 0;
 		return 0;
 	}
 
-	i = data;
+	i = table->data;
 	min = table->extra1;
 	max = table->extra2;
 	vleft = table->maxlen / sizeof(unsigned long);
@@ -917,8 +908,8 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos, unsigned long convmul,
 		unsigned long convdiv)
 {
-	return __do_proc_doulongvec_minmax(table->data, table, write,
-			buffer, lenp, ppos, convmul, convdiv);
+	return __do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos,
+					   convmul, convdiv);
 }
 
 /**

-- 
2.50.1



