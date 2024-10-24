Return-Path: <linux-fsdevel+bounces-32799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B066A9AEDC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25DFFB272A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA24F1FAC51;
	Thu, 24 Oct 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fenF9Tje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149721FBF4F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790492; cv=none; b=uIiaBUk2Hkke1pBzRl6vBTvz7eSr6ydzuQAQ7ObMKasbuGcOaBmMBQY8Zj4UjBdI22QiR/wLcwfp7I2DwW0g/Bp6b/HCPtwDGx7jS6mUAVOS+mMzqdDLaxoARd+W4bEZ6wp4xArj7tNuGBh4dreSW5jUkxr2zuV56aMYB9xdCbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790492; c=relaxed/simple;
	bh=ioEojwyjzo508/cf3Oxu/mg0XMx+FgQ2Ivxxr+uviBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Kglr+EsKMCN0Li63MVOGpkEEQCcPN/M8LuUpl5y8tfFiKOk4Dn5dMEkhZH1+rYBUGXCJiV6jNeVcvw/MfBr0RvRNvUI28a+ntSWVZiPhvxmTLrq04qUJB6Qc+ndH5cZ3nx4/Hv3gZqi7FqaYaDfEMlOV7Jhpk8NuJXh6YX200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fenF9Tje; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso1322214276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790489; x=1730395289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pLChAthDKHO8hW8O7IV3CdRgH7581sXq9YBpmfyJv4=;
        b=fenF9TjeEh+lBiYRccStK1FOlP8uSQEIR9rnMtk8ZAiNh7NMAMAjcpzjeHxw0Jj0OG
         tIB2+qUMuJizPxHmCSO/cL/R+8K9w9LWUreL8U9kHFxnnAS6+PS8QG3r631asKNmQWoS
         S/jZaVtwrVFx43wJZhzcKExh2sJufm8WNJYUvZw0HFxBb7QY1b6g9mDFaW86qJzh/W2Z
         89aHRRnwT03sdFzUuxu7ALNJKkXSjmiyRK5Ipg2DyKcytE8GV4EhNBPSa9NGve9hu7hG
         4WvU2tqL/k+BS8uoekcDkI8ZEBGgzB6fnCmEIkGriAOsyexqFtMjD2Z6maEf0ntp2BBS
         YF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790489; x=1730395289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pLChAthDKHO8hW8O7IV3CdRgH7581sXq9YBpmfyJv4=;
        b=sUsUpJh2tVVPxUhTHIdBXYe75H+plijwjlrKj0EEuyqLyLB/wIVjbFmZEFfFPeAvD6
         IFZNrHaS8OR7qCRWq3LEeC0YPIf3SGqjQSRBbQ/CHAlcdILUSSIMVDgNLUwr2pHt1T6T
         ePdYMXS+6FeIwiOxXC1trJ27I1ALfbR2Ow6K5cZU/aXYut77sj6ssJqbcpzbUfyaZsCx
         0Fa9uO9rzd98fuqBjbjrn2FLOCU/UGk7BlXqr0M7S09KcML0vmT6cda3IF2sItfZpI0a
         ETSnwsWoyhL6OG3kolqMrXkL15qGGYeiJ3PHVB9ImMT63FG3hpTpub34Z1ihvCNroB6L
         mkHg==
X-Forwarded-Encrypted: i=1; AJvYcCWX+AwaWyCbmYeKaWbyYHyWT92+Q08aX7j1Mxbr53qYPb5Fp+BKscV3QGmSE5q6fD1rS/ZTwajUPN07lW57@vger.kernel.org
X-Gm-Message-State: AOJu0Yw051uB6PzGjMko+SEyqpgzgsGnhHN56W8fwBsWTRxL6ZbBRfEM
	XfosxFrkLKgyoohaUU/36vzxGsqK78FEfgt+M8Vmcaxfc642IgtX
X-Google-Smtp-Source: AGHT+IFkQ37vFL7A9ND5sRC6RQzQYgNiqHBRgmds9gNUEC3jO9cEF4tUU8e+yoNQcMeUnsy2+MbTBw==
X-Received: by 2002:a05:690c:660f:b0:6e2:c5d:4edf with SMTP id 00721157ae682-6e7f0dc17e6mr80327697b3.9.1729790489001;
        Thu, 24 Oct 2024 10:21:29 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ccb5c3sm20343277b3.102.2024.10.24.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:28 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 03/13] fuse: convert cuse to use folios
Date: Thu, 24 Oct 2024 10:17:59 -0700
Message-ID: <20241024171809.3142801-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241024171809.3142801-1-joannelkoong@gmail.com>
References: <20241024171809.3142801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert cuse requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/cuse.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 0b2da7b7e2ad..eed78e303139 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -303,8 +303,8 @@ struct cuse_init_args {
 	struct fuse_args_pages ap;
 	struct cuse_init_in in;
 	struct cuse_init_out out;
-	struct page *page;
-	struct fuse_page_desc desc;
+	struct folio *folio;
+	struct fuse_folio_desc desc;
 };
 
 /**
@@ -326,7 +326,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	struct fuse_args_pages *ap = &ia->ap;
 	struct cuse_conn *cc = fc_to_cc(fc), *pos;
 	struct cuse_init_out *arg = &ia->out;
-	struct page *page = ap->pages[0];
+	struct folio *folio = ap->folios[0];
 	struct cuse_devinfo devinfo = { };
 	struct device *dev;
 	struct cdev *cdev;
@@ -343,7 +343,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	/* parse init reply */
 	cc->unrestricted_ioctl = arg->flags & CUSE_UNRESTRICTED_IOCTL;
 
-	rc = cuse_parse_devinfo(page_address(page), ap->args.out_args[1].size,
+	rc = cuse_parse_devinfo(folio_address(folio), ap->args.out_args[1].size,
 				&devinfo);
 	if (rc)
 		goto err;
@@ -411,7 +411,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 out:
 	kfree(ia);
-	__free_page(page);
+	folio_put(folio);
 	return;
 
 err_cdev:
@@ -429,7 +429,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 static int cuse_send_init(struct cuse_conn *cc)
 {
 	int rc;
-	struct page *page;
+	struct folio *folio;
 	struct fuse_mount *fm = &cc->fm;
 	struct cuse_init_args *ia;
 	struct fuse_args_pages *ap;
@@ -437,13 +437,14 @@ static int cuse_send_init(struct cuse_conn *cc)
 	BUILD_BUG_ON(CUSE_INIT_INFO_MAX > PAGE_SIZE);
 
 	rc = -ENOMEM;
-	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
-	if (!page)
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!folio)
 		goto err;
 
 	ia = kzalloc(sizeof(*ia), GFP_KERNEL);
 	if (!ia)
-		goto err_free_page;
+		goto err_free_folio;
 
 	ap = &ia->ap;
 	ia->in.major = FUSE_KERNEL_VERSION;
@@ -459,18 +460,19 @@ static int cuse_send_init(struct cuse_conn *cc)
 	ap->args.out_args[1].size = CUSE_INIT_INFO_MAX;
 	ap->args.out_argvar = true;
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
-	ap->pages = &ia->page;
-	ap->descs = &ia->desc;
-	ia->page = page;
+	ap->uses_folios = true;
+	ap->num_folios = 1;
+	ap->folios = &ia->folio;
+	ap->folio_descs = &ia->desc;
+	ia->folio = folio;
 	ia->desc.length = ap->args.out_args[1].size;
 	ap->args.end = cuse_process_init_reply;
 
 	rc = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
 	if (rc) {
 		kfree(ia);
-err_free_page:
-		__free_page(page);
+err_free_folio:
+		folio_put(folio);
 	}
 err:
 	return rc;
-- 
2.43.5


