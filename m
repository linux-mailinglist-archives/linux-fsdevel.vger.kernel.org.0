Return-Path: <linux-fsdevel+bounces-17062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC898A7255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C20283D12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4E13280C;
	Tue, 16 Apr 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4yKnHxc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81234133987;
	Tue, 16 Apr 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288562; cv=none; b=CNOiSa/Pa6HTsoI+aVDnMnm4UigWT1ZEfs/+IPCXcJMD94jmEy/zweF2BqUbXsOeOg5BY+HCdekXdvyTZwNATkzemzbqWLP+8ggdC8el+3eW5U8CG2jaUWwCSXyhDPK38xrfr+O4EfgNywFLWpsHdJACGHsX2xo43Lv0Tvoct4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288562; c=relaxed/simple;
	bh=cXpNFHLgu4b23t0oxZjm+L93+uiHslfyQR12Lhtk6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fA5xzmbb4CxFsR8mWpaZwGEALVlTHRPaTgMBmlVKyqmI3weuaXPSwkW6H1mBxV+C7d1Fmqfv2FrKOid/Q9j7ac6JNAW+G5eg326spBaFkQjEIOnSa9WnsFa6euszG4yTHO6O1MIqzfya79mCdK+Brnz571MgYk7PCstvfPx1Jg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A4yKnHxc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UNQKf7CAws6rOzdQhJajWUlkzY64Zefr2j010tr9dJQ=; b=A4yKnHxc0ymfv6GoE/2YNWtTbX
	RxP4xGnTpV44sr7VHq34FIta3XK5CbySzmJcxCKrJdZL2iwrvcZfLsqZtjpd2pYWRe+5P+EbcToUD
	gjKI/PJyi+kMQZs1rPtvtHwxOXxMmZV/Td7UeDAd4BB1o4yVPsucqlVrce2x+jUBUOzcsNsb4ZzTg
	5Vga+1znWJgLfiO07L7gH+4lgg4/HM/S9sFoni+NjRyPV/oUmASAX7BUwuFHZnKpHLA42BtzSu08M
	1JZOqNylCmrMawzLOvqHPPRINIxZgUYN5ZSEkSdscEHYrh+V2Chp/FW6qD9dkrmtbp8a/BtN3LMBM
	TTngZeQw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwmcE-000000011eR-3Fw3;
	Tue, 16 Apr 2024 17:29:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] ext4: Convert bd_bitmap_page to bd_bitmap_folio
Date: Tue, 16 Apr 2024 18:28:54 +0100
Message-ID: <20240416172900.244637-2-willy@infradead.org>
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
 fs/ext4/mballoc.c | 98 ++++++++++++++++++++++++-----------------------
 fs/ext4/mballoc.h |  2 +-
 2 files changed, 52 insertions(+), 48 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 12b3f196010b..91c015fda370 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1448,9 +1448,10 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	int block, pnum, poff;
 	int blocks_per_page;
 	struct page *page;
+	struct folio *folio;
 
 	e4b->bd_buddy_page = NULL;
-	e4b->bd_bitmap_page = NULL;
+	e4b->bd_bitmap_folio = NULL;
 
 	blocks_per_page = PAGE_SIZE / sb->s_blocksize;
 	/*
@@ -1461,12 +1462,13 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 	block = group * 2;
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
-	page = find_or_create_page(inode->i_mapping, pnum, gfp);
-	if (!page)
-		return -ENOMEM;
-	BUG_ON(page->mapping != inode->i_mapping);
-	e4b->bd_bitmap_page = page;
-	e4b->bd_bitmap = page_address(page) + (poff * sb->s_blocksize);
+	folio = __filemap_get_folio(inode->i_mapping, pnum,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	BUG_ON(folio->mapping != inode->i_mapping);
+	e4b->bd_bitmap_folio = folio;
+	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
 	if (blocks_per_page >= 2) {
 		/* buddy and bitmap are on the same page */
@@ -1484,9 +1486,9 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
 
 static void ext4_mb_put_buddy_page_lock(struct ext4_buddy *e4b)
 {
-	if (e4b->bd_bitmap_page) {
-		unlock_page(e4b->bd_bitmap_page);
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio) {
+		folio_unlock(e4b->bd_bitmap_folio);
+		folio_put(e4b->bd_bitmap_folio);
 	}
 	if (e4b->bd_buddy_page) {
 		unlock_page(e4b->bd_buddy_page);
@@ -1506,6 +1508,7 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 	struct ext4_group_info *this_grp;
 	struct ext4_buddy e4b;
 	struct page *page;
+	struct folio *folio;
 	int ret = 0;
 
 	might_sleep();
@@ -1532,11 +1535,11 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
 		goto err;
 	}
 
-	page = e4b.bd_bitmap_page;
-	ret = ext4_mb_init_cache(page, NULL, gfp);
+	folio = e4b.bd_bitmap_folio;
+	ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
 	if (ret)
 		goto err;
-	if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
 		ret = -EIO;
 		goto err;
 	}
@@ -1578,6 +1581,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	int pnum;
 	int poff;
 	struct page *page;
+	struct folio *folio;
 	int ret;
 	struct ext4_group_info *grp;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1596,7 +1600,7 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	e4b->bd_sb = sb;
 	e4b->bd_group = group;
 	e4b->bd_buddy_page = NULL;
-	e4b->bd_bitmap_page = NULL;
+	e4b->bd_bitmap_folio = NULL;
 
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
 		/*
@@ -1617,53 +1621,53 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 	pnum = block / blocks_per_page;
 	poff = block % blocks_per_page;
 
-	/* we could use find_or_create_page(), but it locks page
-	 * what we'd like to avoid in fast path ... */
-	page = find_get_page_flags(inode->i_mapping, pnum, FGP_ACCESSED);
-	if (page == NULL || !PageUptodate(page)) {
-		if (page)
+	/* Avoid locking the folio in the fast path ... */
+	folio = __filemap_get_folio(inode->i_mapping, pnum, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		if (!IS_ERR(folio))
 			/*
-			 * drop the page reference and try
-			 * to get the page with lock. If we
+			 * drop the folio reference and try
+			 * to get the folio with lock. If we
 			 * are not uptodate that implies
-			 * somebody just created the page but
-			 * is yet to initialize the same. So
+			 * somebody just created the folio but
+			 * is yet to initialize it. So
 			 * wait for it to initialize.
 			 */
-			put_page(page);
-		page = find_or_create_page(inode->i_mapping, pnum, gfp);
-		if (page) {
-			if (WARN_RATELIMIT(page->mapping != inode->i_mapping,
-	"ext4: bitmap's paging->mapping != inode->i_mapping\n")) {
+			folio_put(folio);
+		folio = __filemap_get_folio(inode->i_mapping, pnum,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+		if (!IS_ERR(folio)) {
+			if (WARN_RATELIMIT(folio->mapping != inode->i_mapping,
+	"ext4: bitmap's mapping != inode->i_mapping\n")) {
 				/* should never happen */
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = -EINVAL;
 				goto err;
 			}
-			if (!PageUptodate(page)) {
-				ret = ext4_mb_init_cache(page, NULL, gfp);
+			if (!folio_test_uptodate(folio)) {
+				ret = ext4_mb_init_cache(&folio->page, NULL, gfp);
 				if (ret) {
-					unlock_page(page);
+					folio_unlock(folio);
 					goto err;
 				}
-				mb_cmp_bitmaps(e4b, page_address(page) +
+				mb_cmp_bitmaps(e4b, folio_address(folio) +
 					       (poff * sb->s_blocksize));
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
 
 	/* Pages marked accessed already */
-	e4b->bd_bitmap_page = page;
-	e4b->bd_bitmap = page_address(page) + (poff * sb->s_blocksize);
+	e4b->bd_bitmap_folio = folio;
+	e4b->bd_bitmap = folio_address(folio) + (poff * sb->s_blocksize);
 
 	block++;
 	pnum = block / blocks_per_page;
@@ -1711,8 +1715,8 @@ ext4_mb_load_buddy_gfp(struct super_block *sb, ext4_group_t group,
 err:
 	if (page)
 		put_page(page);
-	if (e4b->bd_bitmap_page)
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio)
+		folio_put(e4b->bd_bitmap_folio);
 
 	e4b->bd_buddy = NULL;
 	e4b->bd_bitmap = NULL;
@@ -1727,8 +1731,8 @@ static int ext4_mb_load_buddy(struct super_block *sb, ext4_group_t group,
 
 static void ext4_mb_unload_buddy(struct ext4_buddy *e4b)
 {
-	if (e4b->bd_bitmap_page)
-		put_page(e4b->bd_bitmap_page);
+	if (e4b->bd_bitmap_folio)
+		folio_put(e4b->bd_bitmap_folio);
 	if (e4b->bd_buddy_page)
 		put_page(e4b->bd_buddy_page);
 }
@@ -2149,7 +2153,7 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
 	 * double allocate blocks. The reference is dropped
 	 * in ext4_mb_release_context
 	 */
-	ac->ac_bitmap_page = e4b->bd_bitmap_page;
+	ac->ac_bitmap_page = &e4b->bd_bitmap_folio->page;
 	get_page(ac->ac_bitmap_page);
 	ac->ac_buddy_page = e4b->bd_buddy_page;
 	get_page(ac->ac_buddy_page);
@@ -3885,7 +3889,7 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 		 * balance refcounts from ext4_mb_free_metadata()
 		 */
 		put_page(e4b.bd_buddy_page);
-		put_page(e4b.bd_bitmap_page);
+		folio_put(e4b.bd_bitmap_folio);
 	}
 	ext4_unlock_group(sb, entry->efd_group);
 	ext4_mb_unload_buddy(&e4b);
@@ -6307,7 +6311,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	struct rb_node *parent = NULL, *new_node;
 
 	BUG_ON(!ext4_handle_valid(handle));
-	BUG_ON(e4b->bd_bitmap_page == NULL);
+	BUG_ON(e4b->bd_bitmap_folio == NULL);
 	BUG_ON(e4b->bd_buddy_page == NULL);
 
 	new_node = &new_entry->efd_node;
@@ -6320,7 +6324,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		 * on-disk bitmap and lose not-yet-available
 		 * blocks */
 		get_page(e4b->bd_buddy_page);
-		get_page(e4b->bd_bitmap_page);
+		folio_get(e4b->bd_bitmap_folio);
 	}
 	while (*n) {
 		parent = *n;
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 56938532b4ce..4725e5c9e482 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -217,7 +217,7 @@ struct ext4_allocation_context {
 struct ext4_buddy {
 	struct page *bd_buddy_page;
 	void *bd_buddy;
-	struct page *bd_bitmap_page;
+	struct folio *bd_bitmap_folio;
 	void *bd_bitmap;
 	struct ext4_group_info *bd_info;
 	struct super_block *bd_sb;
-- 
2.43.0


