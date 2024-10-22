Return-Path: <linux-fsdevel+bounces-32601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205639AB63F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CBEAB24797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82C1CCB30;
	Tue, 22 Oct 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0OwIpit"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674A1CB312
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623293; cv=none; b=u4BLXUDk7oPUUSO1zoOmpOsbnaOkoUBfFcmngyOFPKPZ4dPZJPkcz2Ut3dEAJFe61jXHYloPGa2+LX0bgONQwWx9wMuOr+wqfzOJThjYsv4JPTzX6QQxDdo5mGDIQZM9WNuaM9tfKgkKPM2kEaVsdF9OZrz15Mypizvxq9Tyryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623293; c=relaxed/simple;
	bh=ioEojwyjzo508/cf3Oxu/mg0XMx+FgQ2Ivxxr+uviBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb2PDRnHGRQIP3HVanpMqdL6KpVYqdHpJGvX6jrbbwnKFFGB7oUQwFU2T3+jmsGqwD8rh96otIMaDBeOjHCkif+VocdCeWbVS08D/kyu+jrwpxpBwn/kGyLthWtnTPtmFYqDJhvdBiK0bhB5tOnqFDFB7Tn1twgbfYaPJHlXnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0OwIpit; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e3c3da5bcdso62068087b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623291; x=1730228091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pLChAthDKHO8hW8O7IV3CdRgH7581sXq9YBpmfyJv4=;
        b=a0OwIpitpWVL5+a/RcMpTcaXMNzUz7UbB5SA/XWI2d6jiFHFoba9IwykkdbtoLgws1
         h5FAx9r+uJPeJQhxG6eVaJLNhgTVFgTOHFH8yhh57iYE24stzs1V/LhU4oIdfaNMeWmL
         nfAtCFVaGu/x9R0bbgdWDNqnBucdWyFaK2F1fgqBh3ryIUke53+GeSFh4OyTARXNOhsh
         RhaBWeCf+PFhAzn8j4fNLjzCC18ki45JbE2YQB3g8iLBQaa3vBLw5kD2mLfakhROX2C7
         SVqqQBzAjEC1NFJlNRagEhsBKlNogsU3Rwa/QfFo8YHfhviBp11ZmO5gTz3Jn7W4drOW
         SIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623291; x=1730228091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pLChAthDKHO8hW8O7IV3CdRgH7581sXq9YBpmfyJv4=;
        b=UzCL/E68Eth/mv9zQ/gJN8LvaXnHb+67dRaZY2WSoOXdWQGiOyO9e47iPUwLgSF72E
         9kDdrn0xrXL4TSwBM6eVdKkkOlfJAkM500T7DeBeYk9ok+8vIHpE3iQKEqsJd/F9t2Ps
         FxK4DvH0g+4+efXOVBkbrX5cUp6bbPw/pQsZSAUVnBiolibL/BVJD3nRjWNlQAzZoxFM
         xKLCUkSjPzGG/UvfZVFqSMSuB+xTND3gZbOFYqG4ZGw7lq9cB15Xq43I64y56pYm+R+I
         x0hw29ITZ11Eowf+4cQGaF0XzXGU7ow6PYrCNFpqbH7Zreh66Qysn+vc4j1MC0LgaRh9
         Cp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe4EprIJrCTEHlR6rLZHhNMgcNmy7egKH4v8zyqRJ9nHsuSLMC2zoof291vM52ofcSy7FKc7g6lEEvm65i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhe4sugebtA4jHJeVRHy6irXr5dND57xFpaKva7DwsLB83U/Ee
	TXTRFWqNQz2fdcsWzhZJrwUDmEHRhNWfH6Bm0t64xwnOGf7uLTCO
X-Google-Smtp-Source: AGHT+IHoE6Ik16UyhS67czcAR6kSjqAFuwdYbLlmUFuj78r8HwbzvQI0EeWnoGKHsZyjPrCs3nQJRQ==
X-Received: by 2002:a05:690c:91:b0:6e3:d4e3:b9b7 with SMTP id 00721157ae682-6e7d3b8455bmr40723897b3.35.1729623291025;
        Tue, 22 Oct 2024 11:54:51 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4f403sm11938047b3.41.2024.10.22.11.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 03/13] fuse: convert cuse to use folios
Date: Tue, 22 Oct 2024 11:54:33 -0700
Message-ID: <20241022185443.1891563-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241022185443.1891563-1-joannelkoong@gmail.com>
References: <20241022185443.1891563-1-joannelkoong@gmail.com>
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


