Return-Path: <linux-fsdevel+bounces-63959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F96FBD330F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 15:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC553B67D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B4306B1A;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgOobKQi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC45261B9C;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361946; cv=none; b=Zjf6IGnvmwXbOjCNWyaoTdAZQbToCyCbrFnLls6r4pb257xHRkia3L12fGMeF1a7wJeNRgHNS+qzfbl1/toGrtJnXdoKhNMoimRhLNMAODf3p62lvn8MMk8CTTOQjAxPQMr880Lm8VAt7tfB40yFKTDW9nnKn68rEQhEKCjs4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361946; c=relaxed/simple;
	bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNbTW9AG/XU8oLFIOMY7bWGLLe6KIGoPEFkZWx2TwZ/w0KDVbO1LJk59prlbsWC20Z1oPxeHuDGsmp4FNr0ZGolffeys+ouGkJuTmN1D7kXfLZv22DUnS22azsDBVEEP8gq72MNxnR9rXp7ZQQjcklF8Aakv0iuboNlRVBsWmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgOobKQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18E54C19421;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361946;
	bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IgOobKQiAWtd06+nvuNu1BE8tWqjH+alYEUwIA5C67adImCY6gCweacCkWg6DiZG+
	 NEJUQb1GIM61HMHSczkkZOg/fnh91H37QmWd8Hfeg46U5i0vAKDrnV1NR/2uettHDl
	 SaNM9TpSYOtTeSyMedWMKknJwKrX6O8rRBAQ83dFX/zLweny2SXauNJctSodi5ONHz
	 GMwhmd5KTExHVLNbNcX+ehJuZQ4G8fL8X1aJvXkk1aNkWkCQ5+XSf+JF3bS0SSDXGH
	 mjK3/flqVbN2ISWMyn4XHr5KgkL6KkL2hkIoN78zK76TYZMQg5QfAP8OKAkJRrfmKw
	 sDnsgRS7AVdYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23FCCD18E;
	Mon, 13 Oct 2025 13:25:46 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Oct 2025 15:24:53 +0200
Subject: [PATCH 3/8] sysctl: Remove superfluous __do_proc_* indirection
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-jag-sysctl_conv-v1-3-4dc35ceae733@kernel.org>
References: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
In-Reply-To: <20251013-jag-sysctl_conv-v1-0-4dc35ceae733@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4478;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=UfEJu7bUmeezVz/Pc8RnUq8eKehGxWWFgOSUQwSlJQQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjs/dMVrutsg30XpZDtsv/9tp+bDd6s5ipvr
 uLjKffqjVLldYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo7P3TAAoJELqXzVK3
 lkFP+E8L/2/b91K+4SuffVWeBi4OvbzW9camfH9Ei79wJfiO1NolpNZgbxdO9zt+2cCicaqoYfY
 Im8YOTkCb4ugAwkN/03E+9CwEx368J+JVdM2CnXrdgndkwB+dSEfOTjQE0kuWWfdhb1qEiE+SxB
 eSq9KZUO64YJ+QrebiX17M9PdInH8yeeOay0SORLpddVYFbmePzhnshLZk1qaBJGKrS3zrO0B0I
 dLbymIctCUSO5TZ9DqocF/EGc33iQnlKvgAbeCnq0GM7rny0ISwAOST/0BEKqg/AKf1zDXHLcaS
 P3Z+cAqT13wFvYiu0aLKxoAgrmBim5aWGteaOKZ53KYHKrEa2mg6OcVa0iPps7xX2DFX2KF9ce5
 O1XVCEsV9wPnkMb6EkgC0wZkHJF5e8BUcm1A/JFnhiehcA8ALkAs6P+Hiz/41H+MW/SyEEju2TW
 7QZUP0wdsOoXRHoZkhOarjUve3f61u9T94znMCibAAlfcefzxlAGIbHlfgWKYuVGYffpNYAFRY9
 Tw=
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



