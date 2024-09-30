Return-Path: <linux-fsdevel+bounces-30373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BB98A5BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16AC1F2397B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD5618FC74;
	Mon, 30 Sep 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ObiyKQxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831317DFEB
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703952; cv=none; b=p5LpbiuSM+7p+/o64fnAxg3Y50WQ+B680T/VnmqfbvoTF70jPBAyPd9e7E4DynbFXKxejP47GE+KeMtGPkg/tef962fBFFY+cj/oEDhg2lHWBsfzNxe+1TplCITAVKOXdonTgAbbK2bZHMO1RtA4QbyCzsqYWDGWNL7sLXKdhAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703952; c=relaxed/simple;
	bh=qZlCjnZHu78Ye80wR+W/hA25QQcmF5a5SCKL/DpTXZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfRdUc1aKSIz9psx/NGAxVvAeCWhPIwOcmbUi28cS41VKPVFlw0YSDqsQhYSFN5gKLJ+m2n4fpN5y/krljPrZ/9aL1ulsMES5dSwCKtuABfnSsZvdilf5EaSHNlkdhT9bFdqf5bgrC0PGBU/jX8xH7sgcQ4L8xHNHErreAAcEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ObiyKQxk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a9b72749bcso394688185a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703950; x=1728308750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5PR4giWp5I+DKzF9GTBZufPl+DFduV88fR38nmYw1c=;
        b=ObiyKQxkbYyhk4tyoUZq1VRegE/d5xy1LeqqZRlfeQrdcSLIB/x1NTqoRM2zh7dg6T
         Mdkn51G4APRZundRocuqxF0ZvzwPGZYUBAKRt4mNLybvU4TIvv8uZNoDn8OhVdNTIw9w
         gzRmLfxaA9wfcN/3JiSNzrRZBZtnYpOhmrWtqGPcOzD2O83wthf5IhptL8z8eOWnw9kx
         YGeRQ1QRDiilSG7a8RZoP+HnRQn5tSlDBz/MVR3HTgLrAaz3z2afX3s6FTMSEBX/yzWD
         l51KJlcyj/xhmmX4cSZimEfuwTHyrU1nZeV0Q6pd6f5xUPLetrNHpGcDCH3gvn+7k3kH
         T3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703950; x=1728308750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5PR4giWp5I+DKzF9GTBZufPl+DFduV88fR38nmYw1c=;
        b=OO9aBoUy7htEmT+4bgaHcNuIdkCW5E4gvj9UG2W3bITy9UvGJC4PW+jh1FGYBK6Q5h
         62h8C/lVeJta3clV8EdDkDZYc1ybq7OuajYw2r0dzRw3q+t6yEgujYoHwBObz6j5NLFt
         K/eATavfYMXdVxJgEdT9rZ7YTW7fsoQVYcl3vF/OSsHLeNNPrfQSbUpCVvQe+L1IL6VI
         exzUhGxNXSDwnlkrGWOzJeUvTiDiCLN1JL1w7mfAYHM5prkC8FjeOIYditXNys/QU+Hl
         Po5HUqare1gOA1u9HPMUc2R4Ozzxz9N4hpfdSN/up2qxdENc9x4zphyWTJVgkyEz44Mi
         42kw==
X-Gm-Message-State: AOJu0Yxk5de3+lS57F41NwpLJ127zsqL9L6kC1j23pREqo3VAE3crK65
	3wD+ZsMw1IastXeJjKmKKeWTJRcqAX3TUu9NphG2bkfExIKlBy13ouU2N2XwbQ2gNSSF1Cwcbah
	q
X-Google-Smtp-Source: AGHT+IHwvH5WwzaI/3zOkYFgiISfNqwSz60DrK7nvmT/gYx+SmHeyDnETMxE8czAqOFJRiGfgJidXQ==
X-Received: by 2002:a05:620a:444c:b0:7a9:bf2a:d7c8 with SMTP id af79cd13be357-7ae378b4f50mr1867804285a.41.1727703949648;
        Mon, 30 Sep 2024 06:45:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae37841c2fsm412466185a.125.2024.09.30.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 08/10] fuse: use the folio based vmstat helpers
Date: Mon, 30 Sep 2024 09:45:16 -0400
Message-ID: <44643d2bd0fa21575d9d7aba1355ac88bc02944f.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make it easier to switch to folios in the fuse_args_pages
update the places where we update the vmstat counters for writeback to
use the folio related helpers.  On the inc side this is easy as we
already have the folio, on the dec side we have to page_folio() the
pages for now.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 33f98cd27e09..dc701fa94c58 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1795,12 +1795,12 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
+static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
 	wb_writeout_inc(&bdi->wb);
 }
 
@@ -1812,7 +1812,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	int i;
 
 	for (i = 0; i < ap->num_pages; i++)
-		fuse_writepage_finish_stat(inode, ap->pages[i]);
+		fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]));
 
 	wake_up(&fi->page_waitq);
 }
@@ -1867,7 +1867,8 @@ __acquires(fi->lock)
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
-		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
+		fuse_writepage_finish_stat(aux->inode,
+					   page_folio(aux->ia.ap.pages[0]));
 		fuse_writepage_free(aux);
 	}
 
@@ -2087,7 +2088,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[page_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2261,7 +2262,8 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
+		fuse_writepage_finish_stat(new_wpa->inode,
+					   page_folio(new_ap->pages[0]));
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.0


