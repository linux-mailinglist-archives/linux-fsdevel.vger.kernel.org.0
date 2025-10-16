Return-Path: <linux-fsdevel+bounces-64367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13966BE38B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DC558524C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CA335BDA;
	Thu, 16 Oct 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAuIECk2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8634033438E;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619499; cv=none; b=pr7Bn/bgaeIS63uQR/3Bz+YntHkZoKtyEii4bmiG4gLjagrkNpE48DxX5yNFtDfDlnc0gCVpW7duV0bgNaqNeYWjhVwY4Vnv2tU6BV2UPiQTChfiUAxTY2rE6riB/Yr3+ZxzXFS3/B5EE7zPaWWVYQPlfnil/H6M+oQ7orLpNVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619499; c=relaxed/simple;
	bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKzUp72mRHJBJF/iTDI83o+c9QKtcwYMCb9jh3us9t6n1CQ3G2eMs/yAUqBuEK9sxc1zjly/25ognryu7bDBW8iqZG53Xp8WwaGfuoMSGY5JJ8L8SMZMXqqHHus7pRZ3GZeDGOJIwtF0pTazNcqaLxuv9eG2myCpXLCHuk2A4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAuIECk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D61CC19422;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619499;
	bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OAuIECk22iGEwatBNEtK6TzLItdkhZ0Xw1GYw8zfTHQjGAKPv34+5xvkDwSARho4D
	 qZ2+P/g0Vt1YttC4ZtiPHQFnMAnGlexJ+x0WuZ3uUxhWNq30xwZLZ9+NS58pOx8Y7N
	 NMNwWeHUyoMdrbNVrhIU3xNZbJ9M7MYGIG9m8QmRo7sFUjGGqXk/XkGBOi0DMJRoa3
	 eQC9g7VPT/ot6G15nROlvGiTCgLCGlgg+6QzPPqM93wYk2b+GyxAO5QpmcCkH9A5KT
	 Vg+Ue17UM/C93NVdP0bfNkckTbv4MjRBUX/PVuVIykhybYS7DUWyuQedVl0E5hUeYr
	 nfOwJEAKrbbjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FD8CCD194;
	Thu, 16 Oct 2025 12:58:19 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 16 Oct 2025 14:57:49 +0200
Subject: [PATCH v2 03/11] sysctl: Remove superfluous __do_proc_*
 indirection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jag-sysctl_conv-v2-3-a2f16529acc4@kernel.org>
References: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
In-Reply-To: <20251016-jag-sysctl_conv-v2-0-a2f16529acc4@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjw6+MIGEYxSaaph0qVHOhefHfkfDKmlBKnb
 QH5OaC8vGlEm4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo8OvjAAoJELqXzVK3
 lkFPtNYMAIjhKuRUY3vIWDeR+bScXo5UDL4ltfdcia2UE/je/MHiMvVu7s68UMnpn5tZLP9WuMO
 hxp9k5U5XJxzQVotVkxnOQ/8Aw11UXmti2Wnw6mVuB47PmVbRkCgCJOo/szMJq6oetjB/AvOEhm
 qhzGsC3nIHiHHS/8CBf/UBSv2/dGml80Hy5Ls6z917Yw2OueWGJjQIn/iRH7l60EGnijzVpsaIG
 YdkO2TrrBiaT/WSWWVEmq9abNvkCjfyy0X29ZS1zarluZxbBVZMHka6TbyyxFWoSbbwyG2YZLLH
 synccm/s7hKCHN9g0i9HttTbheiQDERVBzZ12v0ZFOM2M+8/D61Qo0CTXK4EMsbLsSEftZXVb7d
 mZLOTlMnqynwW2ZSugLT7aKk8ghA7QOuZLGCUzLmbkBp3aMTHV0rnorj/kqHJgyyb2ZkzOPYpMn
 mBLrKqlRkLsSpatiUoOAY2s8AvAPwMcGraS9ESR3SAs6lbm5d3/XWRNbyWZPF3F+NKheNQsiji9
 IQ=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Remove "__" from __do_proc_do{intvec,uintvec,ulongvec_minmax} internal
functions and delete their corresponding do_proc_do* wrappers. These
indirections are unnecessary as they do not add extra logic nor do they
indicate a layer separation.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/sysctl.c | 52 +++++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 0e249a1f99fec084db649782f5ef8b37e40c6a7c..9b042d81fd1c6a32f60e2834a98d48c1bc348de0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -398,11 +398,11 @@ static int do_proc_douintvec_conv(unsigned long *lvalp,
 
 static const char proc_wspace_sep[] = { ' ', '\t', '\n' };
 
-static int __do_proc_dointvec(const struct ctl_table *table, int write,
-			      void *buffer, size_t *lenp, loff_t *ppos,
-			      int (*conv)(bool *negp, unsigned long *lvalp,
-					  int *valp, int write,
-					  const struct ctl_table *table))
+
+static int do_proc_dointvec(const struct ctl_table *table, int write,
+		  void *buffer, size_t *lenp, loff_t *ppos,
+		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
+			      int write, const struct ctl_table *table))
 {
 	int *i, vleft, first = 1, err = 0;
 	size_t left;
@@ -470,14 +470,6 @@ static int __do_proc_dointvec(const struct ctl_table *table, int write,
 	return err;
 }
 
-static int do_proc_dointvec(const struct ctl_table *table, int write,
-		  void *buffer, size_t *lenp, loff_t *ppos,
-		  int (*conv)(bool *negp, unsigned long *lvalp, int *valp,
-			      int write, const struct ctl_table *table))
-{
-	return __do_proc_dointvec(table, write, buffer, lenp, ppos, conv);
-}
-
 static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 			       size_t *lenp, loff_t *ppos,
 			       int (*conv)(unsigned long *lvalp,
@@ -526,7 +518,6 @@ static int do_proc_douintvec_w(const struct ctl_table *table, void *buffer,
 
 	return 0;
 
-	/* This is in keeping with old __do_proc_dointvec() */
 bail_early:
 	*ppos += *lenp;
 	return err;
@@ -562,11 +553,10 @@ static int do_proc_douintvec_r(const struct ctl_table *table, void *buffer,
 	return err;
 }
 
-static int __do_proc_douintvec(const struct ctl_table *table, int write,
-			       void *buffer, size_t *lenp, loff_t *ppos,
-			       int (*conv)(unsigned long *lvalp,
-					   unsigned int *valp, int write,
-					   const struct ctl_table *table))
+int do_proc_douintvec(const struct ctl_table *table, int write, void *buffer,
+		      size_t *lenp, loff_t *ppos,
+		      int (*conv)(unsigned long *lvalp, unsigned int *valp,
+				  int write, const struct ctl_table *table))
 {
 	unsigned int vleft;
 
@@ -594,15 +584,6 @@ static int __do_proc_douintvec(const struct ctl_table *table, int write,
 	return do_proc_douintvec_r(table, buffer, lenp, ppos, conv);
 }
 
-int do_proc_douintvec(const struct ctl_table *table, int write,
-		      void *buffer, size_t *lenp, loff_t *ppos,
-		      int (*conv)(unsigned long *lvalp,
-				  unsigned int *valp, int write,
-				  const struct ctl_table *table))
-{
-	return __do_proc_douintvec(table, write, buffer, lenp, ppos, conv);
-}
-
 /**
  * proc_dobool - read/write a bool
  * @table: the sysctl table
@@ -831,9 +812,10 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int write,
 }
 EXPORT_SYMBOL_GPL(proc_dou8vec_minmax);
 
-static int __do_proc_doulongvec_minmax(const struct ctl_table *table,
-		int write, void *buffer, size_t *lenp, loff_t *ppos,
-		unsigned long convmul, unsigned long convdiv)
+static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
+				     void *buffer, size_t *lenp, loff_t *ppos,
+				     unsigned long convmul,
+				     unsigned long convdiv)
 {
 	unsigned long *i, *min, *max;
 	int vleft, first = 1, err = 0;
@@ -904,14 +886,6 @@ static int __do_proc_doulongvec_minmax(const struct ctl_table *table,
 	return err;
 }
 
-static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos, unsigned long convmul,
-		unsigned long convdiv)
-{
-	return __do_proc_doulongvec_minmax(table, write, buffer, lenp, ppos,
-					   convmul, convdiv);
-}
-
 /**
  * proc_doulongvec_minmax - read a vector of long integers with min/max values
  * @table: the sysctl table

-- 
2.50.1



