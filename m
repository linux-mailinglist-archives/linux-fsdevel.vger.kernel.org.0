Return-Path: <linux-fsdevel+bounces-32603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E719AB641
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46BD1C230A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C91CB314;
	Tue, 22 Oct 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfpnnO9W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD71CC89B
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623294; cv=none; b=RKf54RYVNSDC0nWgbfMFoMOrFnIBuXs8ZK+8JsfqEeFscNuMcCqOJLnyFZxe7nBYdAzr0a9FeOF3pZOPfbxZRLc04sivTtq/SukfNQ9DYLXte3ddPZJHim7KyL2fi60x9Ntxiz7/4pKJDwZlgvP4qd2NfMg346Pv0TEFIU/T+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623294; c=relaxed/simple;
	bh=mXnBpqKiRVmhwxcDZZR85Sp7SEzxNvCFukeXW0p4gvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJ5WlqLhBKILQ1058b+i6Jih4JV8LGnk3Z6fMB8uDxzdiqq0vE2F2ZsWiz9ltfMSqvZ9ot5nloz1KjYe2jl3DedkIlL4U3RDloUdjSgTrCmDQCthv/qg+kWmmWpTDAwDbsW8msvA01a24Z6bdRSOOuwyoFJb0SNtM9dEdRUbZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfpnnO9W; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e35fb3792eso59921507b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729623292; x=1730228092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc/+LRnlXGharux7jo9tP8eHIQUBzqZeR7LIDCREooQ=;
        b=ZfpnnO9W2CswWEg7EgV378e0fHwgI3NlRXbEljqpgG0lLt8jV/xeCVH51SS323LS1I
         jGqryk2ALCbmhIHAQDwj4GIks6k2FUnS0OQ1dEYyyIx/Rpvkdwdwe2FIe9JRk0FEcObe
         Ifye7Nyw4k2O/i3YtNmgMUfyfOIQ7FaF7UcMwY54uNC02QXSq84tn/X1GgWLNeVRFWOI
         nV5RZ4ZvIOuEI0v3bI7nAzm5XfMENub4ilaor2G6OcR+85xV5M0hYVC7xNXOQBV8/mxa
         NsEuiWnBkOyr6pMt14AarY3WXjPsDp/gJQg5Ccpwdjnf+taIFJgRIMNCO3oTLkT8qWSh
         Ef5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729623292; x=1730228092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc/+LRnlXGharux7jo9tP8eHIQUBzqZeR7LIDCREooQ=;
        b=OPndBTJ9I5eOIoS3b80ldlgL3dUS0idDrTCNr4d1cZ6CvaJOi+NNcOPGEipuunjL8M
         3l6jKNq0QhfLr4MtX4bgAYzN5lsPBNoava1oFDruBXO3M0dFh2WIvUahg0tQrkD8jEEe
         mkjIll24lGBDO4VeO7aaLiNBtEjbtqw/xrz8IYdxBP+FprZRgpEzgnkG2O9v0wDh8/9f
         yiZAD95yZQ+d2Zyx66GQq1yo3zyGRhsDpuHuMUWP1uNaOGddSxj67uE/OkoOWVs4Uyqm
         J+nnq+Schi+hkcAf3PKZTtZCf8pVxMuDoWZYUSy/fRwukMnvVDuWR+Ayr0OYaWb8XBAV
         6kIg==
X-Forwarded-Encrypted: i=1; AJvYcCVPNkVhLZ4vr+5aaWKkiOOp8xZYTDd/rS7Y6UuliYFDEvld6oMCH5LmYcNeW9fP0j84bI0FVipqS7LrlLip@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOEqKBPkyYUdx3uNtW9dKa7mc5KpgqeIF6taTIm5FDPQJaTh8
	fed7vWpYxWaHvbf0cB+Wh+bvyQL1Ke60kiUk+472Z07K2atzJmMq
X-Google-Smtp-Source: AGHT+IGV1qIMbsGFxDVCESmRaqZCUr211s2OD6byOXEHMtcMWha6rmFEpfUCQL1laIDIUJyDTK53mA==
X-Received: by 2002:a05:690c:6a02:b0:6db:c847:c8c5 with SMTP id 00721157ae682-6e7f0e3ea38mr34867b3.16.1729623292310;
        Tue, 22 Oct 2024 11:54:52 -0700 (PDT)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e7e06fe05esm3309177b3.12.2024.10.22.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 11:54:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v2 05/13] fuse: convert readdir to use folios
Date: Tue, 22 Oct 2024 11:54:35 -0700
Message-ID: <20241022185443.1891563-6-joannelkoong@gmail.com>
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

Convert readdir requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/readdir.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..fd0eff1b9f2d 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -331,24 +331,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 {
 	int plus;
 	ssize_t res;
-	struct page *page;
+	struct folio *folio;
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
 	u64 attr_version = 0;
 	bool locked;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
 		return -ENOMEM;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
-	ap->pages = &page;
-	ap->descs = &desc;
+	ap->uses_folios = true;
+	ap->num_folios = 1;
+	ap->folios = &folio;
+	ap->folio_descs = &desc;
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
 		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
@@ -367,15 +368,15 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
-			res = parse_dirplusfile(page_address(page), res,
+			res = parse_dirplusfile(folio_address(folio), res,
 						file, ctx, attr_version);
 		} else {
-			res = parse_dirfile(page_address(page), res, file,
+			res = parse_dirfile(folio_address(folio), res, file,
 					    ctx);
 		}
 	}
 
-	__free_page(page);
+	folio_put(folio);
 	fuse_invalidate_atime(inode);
 	return res;
 }
-- 
2.43.5


