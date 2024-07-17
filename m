Return-Path: <linux-fsdevel+bounces-23852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A30933FF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9EA281973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2414183063;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MbEkG+1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA1918133B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=iUAUY/A9mqRKM9uZ8g/0gZM3+G7PKQ71BQvkqJ0OwDsCA+W/w2sxf3bRLRg6nxzGxoA7TiM5OOl9ec/Vuz5SOXSg3njxCA2eHnd7RNvmrnOHDYdgcnIZD0WaCv3GNMwwjOr2FPB/K+onbAwRx7Mqg4kW51dziARwpUK57c4swrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=mWPtPpzpOf43/5Yr2zNx8cZk3q0pxOdI3dStZJSdDPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWi/bpUJ2eRbhB6blgQr8JpszSQz+L1Mm2dGyNUt7i3bO6zJT8RLnCWpQTcGpX7sMVTIfafhfG3Nh2R9GJr7UMxL9Pyr+aKiaxt8CwpHFoPq984O2LiPPg0D/0LnugHSVIgLWS2fZdHWFx14bG3/wmXmXzBOxQTyNicUxtdyMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MbEkG+1y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=aef8FJqXGD355SHDsxKowSYu5YdFotXjosVVETHR/OU=; b=MbEkG+1yyY2V8ciTsoitgo5/7F
	euT2/yVYZIiouLmS3QLRLAULeNd1jpP9JBZBwHvNiCgS5kjeDfhdhUfy/6AFOFPPRXxCFGj9zQF7T
	XRSnF3P4QoV+42Ed/6P+hRHZGX7iKNQ6L3jpZxqlpioSQUfF3TugC9EpmkldrHjb6ib+wg6ZwAH+2
	Ns/XBpdd04LWpVPgljxlF3rOKYI4Ptvk4edKtKj+zcZEcpaNwUkVKut3wjjC6GW5eodRQsFySwOXh
	HxritHMgZZOafqEwfP+JwmFP2EIyBY7Xbk48qiEzQ55SIbfbUVfZv7yWmIgOuPSPC0Z1HqdBij7n+
	vnbmiyAg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sD-00000000zun-1Wn9;
	Wed, 17 Jul 2024 15:47:21 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 11/23] f2fs: Convert f2fs_write_begin() to use a folio
Date: Wed, 17 Jul 2024 16:47:01 +0100
Message-ID: <20240717154716.237943-12-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717154716.237943-1-willy@infradead.org>
References: <20240717154716.237943-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fetch a folio from the page cache instead of a page and use it
throughout.  We still have to convert back to a page for calling
internal f2fs functions, but hopefully they will be converted soon.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 66 ++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 58ac23e124a5..9a45f9fb8a64 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3556,8 +3556,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct page *page = NULL;
-	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
+	struct folio *folio;
+	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	bool use_cow = false;
 	block_t blkaddr = NULL_ADDR;
@@ -3573,7 +3573,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 	/*
 	 * We should check this at this moment to avoid deadlock on inode page
 	 * and #0 page. The locking rule for inline_data conversion should be:
-	 * lock_page(page #0) -> lock_page(inode_page)
+	 * folio_lock(folio #0) -> folio_lock(inode_page)
 	 */
 	if (index != 0) {
 		err = f2fs_convert_inline_inode(inode);
@@ -3603,81 +3603,85 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 
 repeat:
 	/*
-	 * Do not use grab_cache_page_write_begin() to avoid deadlock due to
-	 * wait_for_stable_page. Will wait that below with our IO control.
+	 * Do not use FGP_STABLE to avoid deadlock.
+	 * Will wait that below with our IO control.
 	 */
-	page = f2fs_pagecache_get_page(mapping, index,
+	folio = __filemap_get_folio(mapping, index,
 				FGP_LOCK | FGP_WRITE | FGP_CREAT, GFP_NOFS);
-	if (!page) {
-		err = -ENOMEM;
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
 		goto fail;
 	}
 
 	/* TODO: cluster can be compressed due to race with .writepage */
 
-	*pagep = page;
+	*pagep = &folio->page;
 
 	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, page, pos, len,
+		err = prepare_atomic_write_begin(sbi, &folio->page, pos, len,
 					&blkaddr, &need_balance, &use_cow);
 	else
-		err = prepare_write_begin(sbi, page, pos, len,
+		err = prepare_write_begin(sbi, &folio->page, pos, len,
 					&blkaddr, &need_balance);
 	if (err)
-		goto fail;
+		goto put_folio;
 
 	if (need_balance && !IS_NOQUOTA(inode) &&
 			has_not_enough_free_secs(sbi, 0, 0)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		f2fs_balance_fs(sbi, true);
-		lock_page(page);
-		if (page->mapping != mapping) {
-			/* The page got truncated from under us */
-			f2fs_put_page(page, 1);
+		folio_lock(folio);
+		if (folio->mapping != mapping) {
+			/* The folio got truncated from under us */
+			folio_unlock(folio);
+			folio_put(folio);
 			goto repeat;
 		}
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, false, true);
+	f2fs_wait_on_page_writeback(&folio->page, DATA, false, true);
 
-	if (len == PAGE_SIZE || PageUptodate(page))
+	if (len == folio_size(folio) || folio_test_uptodate(folio))
 		return 0;
 
 	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
 	    !f2fs_verity_in_progress(inode)) {
-		zero_user_segment(page, len, PAGE_SIZE);
+		folio_zero_segment(folio, len, PAGE_SIZE);
 		return 0;
 	}
 
 	if (blkaddr == NEW_ADDR) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+		folio_zero_segment(folio, 0, folio_size(folio));
+		folio_mark_uptodate(folio);
 	} else {
 		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
 				DATA_GENERIC_ENHANCE_READ)) {
 			err = -EFSCORRUPTED;
-			goto fail;
+			goto put_folio;
 		}
 		err = f2fs_submit_page_read(use_cow ?
-				F2FS_I(inode)->cow_inode : inode, page,
+				F2FS_I(inode)->cow_inode : inode, &folio->page,
 				blkaddr, 0, true);
 		if (err)
-			goto fail;
+			goto put_folio;
 
-		lock_page(page);
-		if (unlikely(page->mapping != mapping)) {
-			f2fs_put_page(page, 1);
+		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			goto repeat;
 		}
-		if (unlikely(!PageUptodate(page))) {
+		if (unlikely(!folio_test_uptodate(folio))) {
 			err = -EIO;
-			goto fail;
+			goto put_folio;
 		}
 	}
 	return 0;
 
+put_folio:
+	folio_unlock(folio);
+	folio_put(folio);
 fail:
-	f2fs_put_page(page, 1);
 	f2fs_write_failed(inode, pos + len);
 	return err;
 }
-- 
2.43.0


