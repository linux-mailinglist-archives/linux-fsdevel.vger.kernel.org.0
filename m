Return-Path: <linux-fsdevel+bounces-63960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0859ABD3306
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AFE189CE1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07093306B20;
	Mon, 13 Oct 2025 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kw5RkbAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C83064A7;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=PMFd5tgbXtieXJhvwCtGmnDhSbtBA7wZ0dCcMDfh/8WngtEpVBpnStB3IW0ZXJPj7bIvvco5gYEKaykhSIRx5EY869dw3wsEjAP0wcUruUHLrlPwGfJVyn7s48Sa1zDgijyPJg90BTpcnLY6bCUlWxXl3XnNAj2U4ZTM53g51v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CovfcPUNkrbhiYW+sf2defhSvaMYhIG8QMaWlscPzljvj98KO4o+LOYp8aUC1LLgCHHDfAYcrUleImCg6bxQkA9Ol8zUXlHHEw9UTxEMpMBAbPHqS5MZCkJ96t37FjjziX0RoQfqlFjForQ6H2M0YSmj6DN2qBrrSGdhmOwtXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kw5RkbAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10798C116C6;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kw5RkbAQ4Gfef2PXPI6ko3ypYWUvz9u7gn7Ukp/O/1wqgVc0Fnm/8fuZHIWI31hTP
	 mHV9l04/zghdbfmqWdohgB0K3ECSNnlT+Kgmt2ePXGAJVfRKVzKRYpwK3bLuD5z6Bk
	 Ilkz5WZV2jcxvy/LS/lp4GWyzF8R8ElWfRdL/he209qpiNMagytO70B56I2DZ+m4/z
	 N/tg1dGeRBm6UtWXbxjytX1zliZmtne223jOvz4/9R9EY96aVJF736t232YllkLyYM
	 ypz8HrTViH+TRWx4OXbH5CLf0yJAznCzc2xRxGGmtHIN3HNr/yyxZpKirrQ9ntwhW5
	 S/SxDog8/jAFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F206CCCD183;
	Mon, 13 Oct 2025 13:25:45 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:52 +0200
Subject: [PATCH 2/8] sysctl: Remove superfluous tbl_data param from "dovec"
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-2-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6367;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=Yb7SCKMM9yyjHxvSmVCws0zzI54RVCOIkVV6fK8yIW8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dPkczHhpnasOkJdj1xEHRrDVUE7lRQrG
 FGPm0A+4HVSO4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3TAAoJELqXzVK3
 lkFPYBsL/RPScYsGMJU32qtKU5mXjKnko3sBib7y+rJ5pvSQ3UvnTtofkDDmLV1xPcmjup+7JlT
 WIPxFud+QRPxVVTZub2zLxuE+7c7EHRoDH+Y4GG/9L7oGhyiOsrRmuB7XcMQAyjf7kWQtXtlk+v
 9D8WJk+FsTk5RI62ntH5Vb8lsdblCoHv6KTGXKSOVBt5fHkh0RK9mwNKD01MuvcSpgZsZkNR3tZ
 new29VWrD4WsGtwQBVMABHXkHrFLHEvDt62GpyAO8i0M4EOQyFJJmuH2YAv2WGZ1X+vtqXteLsr
 42Yb06+AnrXhILQARfZKsTs2U4/AhVMnNhVzXu1UItnChvaTVlm3Mc5mWX3iQdPoif7GbSU1Z88
 2PAZ7wTpNnKx3K0uPlF4XuK+HJhCZxTw+wYT2SgkXwxGR0I6YKAskWDGsLS5itlcLMyH0D4hEGV
 rT/hPgr2wsQWASRZ5/NbR+A96oYFKvknqv7SC/mnMLdpUaEGvKV0FyfBuGCMIby+zaeKOSSh6R4
 +U=
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



