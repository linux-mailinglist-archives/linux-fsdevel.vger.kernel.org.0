Return-Path: <linux-fsdevel+bounces-26571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5C95A825
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636B7281B36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9C917C9FA;
	Wed, 21 Aug 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYFWu9/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF14170A1A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282720; cv=none; b=UfIdNQ3SByZjjm8v3yaeaKBsvKSJvfyNkffF5Q069F2pUhbHu9W8M/xhMul6oRMlf1YggQ95GGj+SK4oOwZ4BFG+A31c7tLkBQa53E90yjcVzQ7zXm5rndMG/jwYKwFbGNqwMeh27o0UwObnPBRlJ9QJ05+LhkrZJ7vYRPEAsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282720; c=relaxed/simple;
	bh=HWmEGAi1o/pVlJjLY2yfC12lSn6kHGJSjR+sKLPRtpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPnWUoZ/n4C8aBF74U1XalGUIw6E+58iEEfWyvBVt9xJfxPzGMHujCaxqeQtWKdopoRdJafcA8PFkdeTkVU5GGUBmKglj/2TNhYSo5rsq8/DK06kL7KrS0MZAWc7VVUiIuQqjR/bkaEGinL9Fi4NTLrQs5DORT4mq9Uqdtg3z9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYFWu9/B; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6b44dd520ceso2874427b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282718; x=1724887518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJj+pqgKJn3s2nA/qlOtlmtIPaAKsgqF3PoVVIX/LxM=;
        b=hYFWu9/B+n0+tNtp7+c0mFNXPLFcirmvmpagDyxWWXafG0ETuPi6JvWkFAFfhTBuEM
         KUsDKixHv9E5H/VN0Ql5vpSvsjBBKnUNSD+mC46AOEmbl8lFL3b/Ce6rtqF2+GPRQ1Hv
         c877vS7Iy8YDjU4o3wKq0l5og3QKQHfdktERPEpzLCCaZt71rYN3iy9Way2nbfSleWe9
         gNxLcBn/au4D//qM1rCAljV5XscObNWH2X+4SzPVbG6gH86UNUULXVEVbQogaPP8VXJV
         xLfhaja2OjgRDg8LopEvkJJFh7KQ0aSQOvgNTiXv1s1+zqaMryJmk+gG+BRti2lQRdj6
         KIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282718; x=1724887518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJj+pqgKJn3s2nA/qlOtlmtIPaAKsgqF3PoVVIX/LxM=;
        b=jwojKISGKvkpDszZGFbLm0UXuxuY+SU9+da+1D2WCRTxcJsSGKT8wG6jUPhLrI+v9H
         Tj+GyxAjOdG2GYhVPNb6aB73SBHK5xXmQ4AZU2tkzdyQiRW0crJ7LnaqM3mnDqM+s4hD
         2gRD8M+junKfRh+h4hHQadtjgXjYBbdjYQyQVNmyfiHHt8gFdg02LW3pmVt0gm1L1hUm
         bu0tkFAj09PAW4q/Mc+YJDyAFNeE+QYfK/ix6I30f7r/IfuvR25hk0IEYf3zVawCH2mV
         r9drbuaj4szIEWlL3xWom7/e8sfrGp1RKkAiKESI5AXeyTMM4oV9YgLyL+0dznZXshrr
         Js8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBhJAGnplx1C2TgRo9krfgu/reRPxsw3v52EJeGDORTAiWxnmJxBA3RbTreRcNTnXaNFSy8IlzejK5z0DY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsz9zSYJ/rlp3r0wd1VnEVpQxB/xfwk04hxDK4CGZQExvHBdsq
	dhYI7yC06vg4YWEml+GrsscNcfQXtxKfvi9pDfT+ObERmktrqKuQ
X-Google-Smtp-Source: AGHT+IGLbQ4G+vFKlURbt4IMDQML2+2i/X2dzMj2Vabd65s2nS+7qbrouMW453zSlmQyOZ0Ixo4TAA==
X-Received: by 2002:a05:690c:d91:b0:6ac:f8ac:7296 with SMTP id 00721157ae682-6c0faba0ademr47087027b3.1.1724282718037;
        Wed, 21 Aug 2024 16:25:18 -0700 (PDT)
Received: from localhost (fwdproxy-nha-007.fbsv.net. [2a03:2880:25ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007afcsm383887b3.72.2024.08.21.16.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 6/9] fuse: convert fuse_writepages_fill() to use a folio for its tmp page
Date: Wed, 21 Aug 2024 16:22:38 -0700
Message-ID: <20240821232241.3573997-7-joannelkoong@gmail.com>
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

To pave the way for refactoring out the shared logic in
fuse_writepages_fill() and fuse_writepage_locked(), this change converts
the temporary page in fuse_writepages_fill() to use the folio API.

This is similar to the change in e0887e095a80 ("fuse: Convert
fuse_writepage_locked to take a folio"), which converted the tmp page in
fuse_writepage_locked() to use the folio API.

inc_node_page_state() is intentionally preserved here instead of
converting to node_stat_add_folio() since it is updating the stat of the
underlying page and to better maintain API symmetry with
dec_node_page_stat() in fuse_writepage_finish_stat().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 147645d7e5d9..113b7429a818 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct page *tmp_page;
+	struct folio *tmp_folio;
 	int err;
 
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
@@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 
 	err = -ENOMEM;
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
+	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
+	if (!tmp_folio)
 		goto out_unlock;
 
 	/*
@@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *folio,
 		err = -ENOMEM;
 		wpa = fuse_writepage_args_alloc();
 		if (!wpa) {
-			__free_page(tmp_page);
+			folio_put(tmp_folio);
 			goto out_unlock;
 		}
 		fuse_writepage_add_to_bucket(fc, wpa);
@@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 	folio_start_writeback(folio);
 
-	copy_highpage(tmp_page, &folio->page);
-	ap->pages[ap->num_pages] = tmp_page;
+	folio_copy(tmp_folio, folio);
+	ap->pages[ap->num_pages] = &tmp_folio->page;
 	ap->descs[ap->num_pages].offset = 0;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	data->orig_pages[ap->num_pages] = &folio->page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
 
 	err = 0;
 	if (data->wpa) {
-- 
2.43.5


