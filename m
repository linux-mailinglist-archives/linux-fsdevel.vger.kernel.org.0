Return-Path: <linux-fsdevel+bounces-26574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD395A828
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739C91F227F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4017E006;
	Wed, 21 Aug 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSqjjf7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A5017DFF5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282724; cv=none; b=Ae/sZYedeM7Lln5CPr4BcJ5x2Sohy4QV9yg5kyPNl+4SuS+1ng2dsPHN28kGOcrlz15EaG6HMKHi6q6KpBFwSw91kzV7t3xeLvP48FLcCSX97L1GCdiagEW107+IcmHIxsK9ZZNZjHKdNBpLAr55ltTHA4d5ZGDHQr9tLcoN+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282724; c=relaxed/simple;
	bh=lERsL6LkPPQ014nwXvX1HSh1cU8jVK+4wBePK1uTwhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqdPX1mHfE8YbYC+wMEmgqtk1wPtSjsCLpJXutz4R4mRM2URYcsVwcWdRDf1imT79MrzxGiDbEhZnT1YYGGBjH0+HS8ETT8uPCOn5E2++kV5Xvis6iJLP1sG4+qC5utQ35YExHdOuQ6bm7owHdtGKF708Hw80gCicU9ItUteHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSqjjf7m; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6bada443ffeso1815807b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282722; x=1724887522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEFkCyqEoXxF4y5ZXBA9AJG35frZNevBbqzx0TwmkRw=;
        b=SSqjjf7mDLYhnq1Pgzd5kRG+B4DtEjwMxyq2woMmnjyO78sfHqeNIvB/Z6nuR4Hz7i
         uRXzerEvoUYZ87cCTow8vT5Jqxs1H/R0EBurY2kEOufmdv6wEP/Q3U1e5v54qa7xMZ9x
         bmloNgkQowgUOjgCEHpL0mQzJTOlUhbUx1m1gEGlDgf7mQf2ipoFHjoaYOL1U566HH0l
         5dPvb3CeUZM1dTN5Cr/biL9g12S9jnZz7GeJ+c2mUsiQtmgRgtt89Yk2QP23InKIJT8F
         20VAoT5XRQzYBzKk/uEM4qKJH4UH2FMyQPAynqbdmkC3qvOySqv5dtW9lHehru98zytq
         kYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282722; x=1724887522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wEFkCyqEoXxF4y5ZXBA9AJG35frZNevBbqzx0TwmkRw=;
        b=fAPgQSoQ25eGi+KpynvfdrPkWyoGUpGFoz2MJfj6TNQaNWGgCK/61NIZSqtkwwZ7ux
         xExlmvZ3OalphKKVjpUQQOdqKAkHojIclZwaSnbd1H7GXhEaQ07+BIyujvlaQamzRVQm
         AAn0cvyLyQi4I9KB0wTYpLR5znqgBl2EXSEyCfDvxvrn1VIdiif1wkesDyB5dtZCxF5I
         Ans74BR8JutE6IJFHc417rM6EXLjw8zTgupzRidK2f8+SBR2VatwGqLrljoIZ9wEzWOG
         dLb3lemo5P90aX4qjOzQUwDYBxnLh/CctO8tPmpry57rkzudiEazv/x6FYt3UianPAHI
         5Yvg==
X-Forwarded-Encrypted: i=1; AJvYcCXrKMHuZCqiwvp/nZEh3EG774HmhJAl5nmM1SmlHE5VQawWyfRWdQc4tFHz5cY58nmtbtKIdcWaEYhdhBjt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+ZTpEuVyxx597g/CYj5yYH/+Bm3ga3Yz/c4uVLqagtxBmUIc
	sVBv103RZ5KUGa7G2rgSnTHGdWK6e+TWwiRAnMopE0cniSLU1SfJ
X-Google-Smtp-Source: AGHT+IEVLHvayz078/bhAZwZskLXMUx/oFfQNWeWxpEJ4LRzpHt8k9etaXVeQabLVYrVM+UFW/sEzw==
X-Received: by 2002:a05:690c:2d09:b0:63b:ba95:c8b3 with SMTP id 00721157ae682-6c3040cdf13mr10031507b3.6.1724282721919;
        Wed, 21 Aug 2024 16:25:21 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a7527a4sm389227b3.32.2024.08.21.16.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 9/9] fuse: tidy up error paths in fuse_writepages_fill() and fuse_writepage_locked()
Date: Wed, 21 Aug 2024 16:22:41 -0700
Message-ID: <20240821232241.3573997-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tidy up the error paths in fuse_writepages_fill() and
fuse_writepage_locked() to be easier to read / less cluttered.

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index fe8ae19587fb..0a3a92ef645d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2098,16 +2098,19 @@ static int fuse_writepage_locked(struct folio *folio)
 	struct fuse_args_pages *ap;
 	struct folio *tmp_folio;
 	struct fuse_file *ff;
-	int error = -ENOMEM;
+	int error;
 
 	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
-	if (!tmp_folio)
+	if (!tmp_folio) {
+		error = -ENOMEM;
 		goto err;
+	}
 
-	error = -EIO;
 	ff = fuse_write_file_get(fi);
-	if (!ff)
+	if (!ff) {
+		error = -EIO;
 		goto err_nofile;
+	}
 
 	wpa = fuse_writepage_args_setup(folio, ff);
 	if (!wpa) {
@@ -2287,17 +2290,18 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct folio *tmp_folio;
-	int err;
+	int err = 0;
 
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
 	}
 
-	err = -ENOMEM;
 	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
-	if (!tmp_folio)
+	if (!tmp_folio) {
+		err = -ENOMEM;
 		goto out_unlock;
+	}
 
 	/*
 	 * The page must not be redirtied until the writeout is completed
@@ -2313,10 +2317,10 @@ static int fuse_writepages_fill(struct folio *folio,
 	 * under writeback, so we can release the page lock.
 	 */
 	if (data->wpa == NULL) {
-		err = -ENOMEM;
 		wpa = fuse_writepage_args_setup(folio, data->ff);
 		if (!wpa) {
 			folio_put(tmp_folio);
+			err = -ENOMEM;
 			goto out_unlock;
 		}
 		fuse_file_get(wpa->ia.ff);
@@ -2329,7 +2333,6 @@ static int fuse_writepages_fill(struct folio *folio,
 
 	data->orig_pages[ap->num_pages] = &folio->page;
 
-	err = 0;
 	if (data->wpa) {
 		/*
 		 * Protected by fi->lock against concurrent access by
-- 
2.43.5


