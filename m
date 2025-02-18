Return-Path: <linux-fsdevel+bounces-41960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17D1A3933E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CDC18924AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3C41D5AD3;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aL190dfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F91B6CEF
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857933; cv=none; b=sWQYO4xhXulFkruZIghBknHWfEQDjBBJYgl6cEn1JLon1sQDsTulu+ZaVf4K8hjY8tUjZJkay+acpa4x9IMQkNyNRF24MNNKrwHingSXjuF4EDNAQgTpVesUBAvDsn5cAKR9kS7wx27Db6CG/Kz7OrqfD1QMYFeSIHIuzy6Ve5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857933; c=relaxed/simple;
	bh=ZQ5JZWHZMlhqSH5+j3pOdD2tvWU6Pifjgnz21zgmNBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBISh0UAhm44G/ydyPlDEg4HnIJvbIv/waYXJEAtraNLiYLtxxU/nURSi44aMUGNh6l6ZIfwQ5s3OutRwQ1qJ5C2VdFgO4eBud9fiFmevVl+YSEMoxqFB8U9mmLO9dtHyzDNtzNIIIT+1n0+Rfk94zeHTGd3jVRg8Sd0G6oYJt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aL190dfJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s3c7AWPy08doWb2YiUJsZUuX3HKazlJ1Pyn3H6oNhmo=; b=aL190dfJeede3TxaHZlFtG85bQ
	ymLD1EIYtytc7E5a/Wb1RSSvx2QXoQdKym07WGr2yfOxTM71bz/Zz1R9UV/1ClNuWHUORu3UXR4bN
	wAOSiWfW0u6ZVIHtiegFvLcriGJc25I+OuzVcdvRTb4CQ+CzlVoT46ys/iFcdDeRyCbKSJkfFPZL5
	jz+U9phrbfU0QvBcr2LhEmlDfGmx+/3qq9vfzg/y8STZl0yElIRebH1raDw9Hfd44ehtJHQsIaHTg
	klw24VEp/Uuxb2Ub2m9CXtl1CJNXGAqYHufq7s0tpB2l+PXv2FnsuNufQiuMzTxpYRBkc573KqS1u
	X53JZBIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002TtF-1GeZ;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/27] f2fs: Add f2fs_get_read_data_folio()
Date: Tue, 18 Feb 2025 05:51:55 +0000
Message-ID: <20250218055203.591403-22-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert f2fs_get_read_data_page() into f2fs_get_read_data_folio() and
add a compatibility wrapper.  Saves seven hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 35 +++++++++++++++++------------------
 fs/f2fs/f2fs.h | 14 ++++++++++++--
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fe7fa08b20c7..f0747c7f669d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1203,18 +1203,17 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 	return err;
 }
 
-struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-				     blk_opf_t op_flags, bool for_write,
-				     pgoff_t *next_pgofs)
+struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
+		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
-	page = f2fs_grab_cache_page(mapping, index, for_write);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	folio = f2fs_grab_cache_folio(mapping, index, for_write);
+	if (IS_ERR(folio))
+		return folio;
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
 						&dn.data_blkaddr)) {
@@ -1249,9 +1248,9 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 		goto put_err;
 	}
 got_it:
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		return page;
+	if (folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		return folio;
 	}
 
 	/*
@@ -1262,21 +1261,21 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 	 * f2fs_init_inode_metadata.
 	 */
 	if (dn.data_blkaddr == NEW_ADDR) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		if (!PageUptodate(page))
-			SetPageUptodate(page);
-		unlock_page(page);
-		return page;
+		folio_zero_segment(folio, 0, folio_size(folio));
+		if (!folio_test_uptodate(folio))
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
+		return folio;
 	}
 
-	err = f2fs_submit_page_read(inode, page_folio(page), dn.data_blkaddr,
+	err = f2fs_submit_page_read(inode, folio, dn.data_blkaddr,
 						op_flags, for_write);
 	if (err)
 		goto put_err;
-	return page;
+	return folio;
 
 put_err:
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8f23bb082c6f..3e02df63499e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3895,8 +3895,8 @@ int f2fs_reserve_new_blocks(struct dnode_of_data *dn, blkcnt_t count);
 int f2fs_reserve_new_block(struct dnode_of_data *dn);
 int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
-struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
-			blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
+struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
+		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
 struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
 							pgoff_t *next_pgofs);
 struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
@@ -3926,6 +3926,16 @@ int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
 extern const struct iomap_ops f2fs_iomap_ops;
 
+static inline struct page *f2fs_get_read_data_page(struct inode *inode,
+		pgoff_t index, blk_opf_t op_flags, bool for_write,
+		pgoff_t *next_pgofs)
+{
+	struct folio *folio = f2fs_get_read_data_folio(inode, index, op_flags,
+			for_write, next_pgofs);
+
+	return &folio->page;
+}
+
 /*
  * gc.c
  */
-- 
2.47.2


