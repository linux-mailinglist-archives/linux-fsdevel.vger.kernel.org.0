Return-Path: <linux-fsdevel+bounces-17064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C558A7259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689FC2843E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D07213540C;
	Tue, 16 Apr 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UHAhT7sw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70913342F;
	Tue, 16 Apr 2024 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288566; cv=none; b=geSfW6HZOlg+rk7Y3dzvOlkXh9XO38kZwttdsq7l88llJ36lyQxDtr82D+z5gS8KEwvEhcZRcxVYUErywpGV1lm9sWVdQIQGyW2F+Of1WDEE/J2vC4LeF4CnbFwqF5sn2SxcSxBTdMXswHONg38qA65bvCz7sUxF5ZRfmJgVFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288566; c=relaxed/simple;
	bh=Q7LFYGfdkEtm4IKg/rWzhUSmZUz1xqwbkQVOliIuHQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQwn3LfW+mitzaNtjjDJgiMTAgS8xkoUAcsylwpMkOCaXMOYCtFOKzocA847Xpy0J9JAel7jzBfeVdIJe4K1oVduG0e3r9huUUoFyAP8611ljX20R2Yd1LKR++kbnxXjzdSxZVYT7RwzmpdKpnL+ERbtW6PDrmKAg4eeX8Ca1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UHAhT7sw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=i4WVB0COrHyZf+iaDfjKL2JcPSSz6U9I5wWrwxTqUXQ=; b=UHAhT7swZqeWvegZd1LSKlgSHr
	/ErGFvVN/hDRcXzjiQ0mCNJoFAoIEnJian43NGJSP8TuyF3piUzl2txrAhEzvme6kVegtICezNWAf
	oBdXm6KtP+lGjRAuSsNFtdR5kLwRJ+V+huyBwX/yYZGBVVyXEY9GZI9fBUQ3agjQTde62kLoUaufs
	BjF1wT5dLfO5fazkUxmyb6aqC0v/f46Vf2P8Q6aGD98+ZEja9DBZkINpTSpiZBY2vpwDE+rGg6Poh
	ZzRUYYlHKze/LWHXcF1wL1fk3j9oBB3p1A9sdmG+NrNjfeMiLvND+LFCFU5gLKLaU6dwGy1ZIqcCj
	NoSJaqow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcE-000000011eT-3Zdb;
	Tue, 16 Apr 2024 17:29:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] ext4: Convert bd_buddy_page to bd_buddy_folio
Date: Tue, 16 Apr 2024 18:28:55 +0100
Message-ID: <20240416172900.244637-3-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416172900.244637-1-willy@infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to make this a multi-page folio, so leave all the
infrastructure around it in pages.  But since we're locking it, playing
with its refcount and checking whether it's uptodate, it needs to move
to the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/mballoc.c | 91 +++++++++++++++++++++++------------------------
 fs/ext4/mballoc.h |  2 +-
 2 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 91c015fda370..761d8d15b205 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1439,7 +1439,7 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
  * Lock the buddy and bitmap pages. This make sure other parallel init_group
  * on the same buddy page doesn't happen whild holding the buddy page lock.
  * Return locked buddy and bitmap pages on e4b struct. If buddy and bitmap
- * are on the same page e4b->bd_buddy_page is NULL and return value is 0.
+ * are on the same page e4b->bd_buddy_folio is NULL and return value is 0.
  */
 static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 		ext4_group_t group, struct ext4_buddy *e4b, gfp_t gfp)
@@ -1447,10 +1447,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	struct inode *inode = EXT4_SB(sb)->s_buddy_cache;
 	int block, pnum, poff;
 	int blocks_per_page;
-	struct page *page;
 	struct folio *folio;
 
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
@@ -1476,11 +1475,12 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	}
 
 	/* blocks_per_page == 1, hence we need another page for the buddy */
-	page = find_or_create_page(inode->i_mapping, block + 1, gfp);
-	if (!page)
-		return -ENOMEM;
-	BUG_ON(page->mapping != inode->i_mapping);
-	e4b->bd_buddy_page = page;
+	folio = __filemap_get_folio(inode->i_mapping, block + 1,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	BUG_ON(folio->mapping != inode->i_mapping);
+	e4b->bd_buddy_folio = folio;
 	return 0;
 }
 
@@ -1490,9 +1490,9 @@ static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
 		folio_unlock(e4b->bd_bitmap_folio);
 		folio_put(e4b->bd_bitmap_folio);
 	}
-	if (e4b->bd_buddy_page) {
-		unlock_page(e4b->bd_buddy_page);
-		put_page(e4b->bd_buddy_page);
+	if (e4b->bd_buddy_folio) {
+		folio_unlock(e4b->bd_buddy_folio);
+		folio_put(e4b->bd_buddy_folio);
 	}
 }
 
@@ -1507,7 +1507,6 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 
 	struct ext4_group_info *this_grp;
 	struct ext4_buddy e4b;
-	struct page *page;
 	struct folio *folio;
 	int ret = 0;
 
@@ -1544,7 +1543,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 
-	if (e4b.bd_buddy_page == NULL) {
+	if (e4b.bd_buddy_folio == NULL) {
 		/*
 		 * If both the bitmap and buddy are in
 		 * the same page we don't need to force
@@ -1554,11 +1553,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 	/* init buddy cache */
-	page = e4b.bd_buddy_page;
-	ret = ext4_mb_init_cache(page, e4b.bd_bitmap, gfp);
+	folio = e4b.bd_buddy_folio;
+	ret = ext4_mb_init_cache(&folio->page, e4b.bd_bitmap, gfp);
 	if (ret)
 		goto err;
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
@@ -1580,7 +1579,6 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	int block;
 	int pnum;
 	int poff;
-	struct page *page;
 	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
@@ -1599,7 +1597,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_info = grp;
 	e4b->bd_sb = sb;
 	e4b->bd_group = group;
-	e4b->bd_buddy_page = NULL;
+	e4b->bd_buddy_folio = NULL;
 	e4b->bd_bitmap_folio = NULL;
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -1665,7 +1663,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 		goto err;
 	}
 
-	/* Pages marked accessed already */
+	/* Folios marked accessed already */
 	e4b->bd_bitmap_folio = folio;
 	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
@@ -1673,48 +1671,49 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
 
-	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
-		if (page)
-			put_page(page);
-		page = find_or_create_page(inode->i_mapping, pnum, gfp);
-		if (page) {
-			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
-	"ext4: buddy bitmap's page->mapping != inode->i_mapping\n")) {
+	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		if (!IS_ERR(folio))
+			folio_put(folio);
+		folio = __filemap_get_folio(inode->i_mapping, pnum,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+		if (!IS_ERR(folio)) {
+			if (WARN_RATELIMIT(folio->mapping != inode->i_mapping,
+	"ext4: buddy bitmap's mapping != inode->i_mapping\n")) {
 				/* should never happen */
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = -EINVAL;
 				goto err;
 			}
-			if (!PageUptodate(page)) {
-				ret = ext4_mb_init_cache(page, e4b->bd_bitmap,
+			if (!folio_test_uptodate(folio)) {
+				ret = ext4_mb_init_cache(&folio->page, e4b->bd_bitmap,
 							 gfp);
 				if (ret) {
-					unlock_page(page);
+					folio_unlock(folio);
 					goto err;
 				}
 			}
-			unlock_page(page);
+			folio_unlock(folio);
 		}
 	}
-	if (page == NULL) {
-		ret = -ENOMEM;
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
 		goto err;
 	}
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
 
-	/* Pages marked accessed already */
-	e4b->bd_buddy_page = page;
-	e4b->bd_buddy = page_address(page) + (poff * sb->s_blocksize);
+	/* Folios marked accessed already */
+	e4b->bd_buddy_folio = folio;
+	e4b->bd_buddy = folio_address(folio) + (poff * sb->s_blocksize);
 
 	return 0;
 
 err:
-	if (page)
-		put_page(page);
+	if (folio)
+		folio_put(folio);
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
 
@@ -1733,8 +1732,8 @@ static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 {
 	if (e4b->bd_bitmap_folio)
 		folio_put(e4b->bd_bitmap_folio);
-	if (e4b->bd_buddy_page)
-		put_page(e4b->bd_buddy_page);
+	if (e4b->bd_buddy_folio)
+		folio_put(e4b->bd_buddy_folio);
 }
 
 
@@ -2155,7 +2154,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 */
 	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
 	get_page(ac->ac_bitmap_page);
-	ac->ac_buddy_page = e4b->bd_buddy_page;
+	ac->ac_buddy_page = &e4b->bd_buddy_folio->page;
 	get_page(ac->ac_buddy_page);
 	/* store last allocated for subsequent stream allocation */
 	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
@@ -3888,7 +3887,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
-		put_page(e4b.bd_buddy_page);
+		folio_put(e4b.bd_buddy_folio);
 		folio_put(e4b.bd_bitmap_folio);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
@@ -6312,7 +6311,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 
 	BUG_ON(!ext4_handle_valid(handle));
 	BUG_ON(e4b->bd_bitmap_folio == NULL);
-	BUG_ON(e4b->bd_buddy_page == NULL);
+	BUG_ON(e4b->bd_buddy_folio == NULL);
 
 	new_node = &new_entry->efd_node;
 	cluster = new_entry->efd_start_cluster;
@@ -6323,7 +6322,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		 * otherwise we'll refresh it from
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
-		get_page(e4b->bd_buddy_page);
+		folio_get(e4b->bd_buddy_folio);
 		folio_get(e4b->bd_bitmap_folio);
 	}
 	while (*n) {
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 4725e5c9e482..720fb277abd2 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -215,7 +215,7 @@ struct ext4_allocation_context {
 #define AC_STATUS_BREAK		3
 
 struct ext4_buddy {
-	struct page *bd_buddy_page;
+	struct folio *bd_buddy_folio;
 	void *bd_buddy;
 	struct folio *bd_bitmap_folio;
 	void *bd_bitmap;
-- 
2.43.0


