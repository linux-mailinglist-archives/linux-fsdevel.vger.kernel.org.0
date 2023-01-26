Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33067D601
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjAZUNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjAZUNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:13:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037A19F03
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t0A8wOKvaxrst2mVs1ZAI9ZA4QTUUo/XXggbrHRoOo0=; b=jLWO4o3dIJG80P0aoBcdBkcnMX
        hndfjZDIGFFMvwC1p5H1T5YfEsdSkgp5Lkt7RDsp01iONXPo+zA5MU/igXBAOab1ye3et8/aVP89W
        9guQC551EOdzqYXGAwvt1+MZ/C1C0EybqX8AgqGk6VGWAWtSAbBaq5QMXwY/NBLRA4Y+GUlNediX5
        FQzBRs2naRyx1CQHH/3cRJUIpSvtLAoc70byW39ag4ey3pww56y9eAsE/6okdYgJjB7HA3lZQvdLs
        qqy2zd4mgRm8AZZHpeoLBLJORm41U6PLICHWPjJMDX4T2aszbbWya5M+udcp4AUzv7po0ixaQ5N4w
        PpVUVemg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8cD-0073MA-KG; Thu, 26 Jan 2023 20:12:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] mpage: Convert __mpage_writepage() to use a folio more fully
Date:   Thu, 26 Jan 2023 20:12:55 +0000
Message-Id: <20230126201255.1681189-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126201255.1681189-1-willy@infradead.org>
References: <20230126201255.1681189-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is just a conversion to the folio API.  While there are some nods
towards supporting multi-page folios in here, the blocks array is
still sized for one page's worth of blocks, and there are other
assumptions such as the blocks_per_page variable.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/mpage.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 840f57ed2542..2efa393f0db7 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -448,13 +448,11 @@ void clean_page_buffers(struct page *page)
 static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		      void *data)
 {
-	struct page *page = &folio->page;
 	struct mpage_data *mpd = data;
 	struct bio *bio = mpd->bio;
-	struct address_space *mapping = page->mapping;
-	struct inode *inode = page->mapping->host;
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = mapping->host;
 	const unsigned blkbits = inode->i_blkbits;
-	unsigned long end_index;
 	const unsigned blocks_per_page = PAGE_SIZE >> blkbits;
 	sector_t last_block;
 	sector_t block_in_file;
@@ -465,13 +463,13 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	int boundary = 0;
 	sector_t boundary_block = 0;
 	struct block_device *boundary_bdev = NULL;
-	int length;
+	size_t length;
 	struct buffer_head map_bh;
 	loff_t i_size = i_size_read(inode);
 	int ret = 0;
+	struct buffer_head *head = folio_buffers(folio);
 
-	if (page_has_buffers(page)) {
-		struct buffer_head *head = page_buffers(page);
+	if (head) {
 		struct buffer_head *bh = head;
 
 		/* If they're all mapped and dirty, do it */
@@ -523,8 +521,8 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	/*
 	 * The page has no buffers: map it to disk
 	 */
-	BUG_ON(!PageUptodate(page));
-	block_in_file = (sector_t)page->index << (PAGE_SHIFT - blkbits);
+	BUG_ON(!folio_test_uptodate(folio));
+	block_in_file = (sector_t)folio->index << (PAGE_SHIFT - blkbits);
 	/*
 	 * Whole page beyond EOF? Skip allocating blocks to avoid leaking
 	 * space.
@@ -532,7 +530,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (block_in_file >= (i_size + (1 << blkbits) - 1) >> blkbits)
 		goto page_is_mapped;
 	last_block = (i_size - 1) >> blkbits;
-	map_bh.b_page = page;
+	map_bh.b_folio = folio;
 	for (page_block = 0; page_block < blocks_per_page; ) {
 
 		map_bh.b_state = 0;
@@ -561,8 +559,8 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	first_unmapped = page_block;
 
 page_is_mapped:
-	end_index = i_size >> PAGE_SHIFT;
-	if (page->index >= end_index) {
+	length = folio_size(folio);
+	if (folio_pos(folio) + length > i_size) {
 		/*
 		 * The page straddles i_size.  It must be zeroed out on each
 		 * and every writepage invocation because it may be mmapped.
@@ -571,11 +569,10 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 		 * is zeroed when mapped, and writes to that region are not
 		 * written out to the file."
 		 */
-		unsigned offset = i_size & (PAGE_SIZE - 1);
-
-		if (page->index > end_index || !offset)
+		length = i_size - folio_pos(folio);
+		if (WARN_ON_ONCE(folio_pos(folio) >= i_size))
 			goto confused;
-		zero_user_segment(page, offset, PAGE_SIZE);
+		folio_zero_segment(folio, length, folio_size(folio));
 	}
 
 	/*
@@ -588,7 +585,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	if (bio == NULL) {
 		if (first_unmapped == blocks_per_page) {
 			if (!bdev_write_page(bdev, blocks[0] << (blkbits - 9),
-								page, wbc))
+						&folio->page, wbc))
 				goto out;
 		}
 		bio = bio_alloc(bdev, BIO_MAX_VECS,
@@ -603,18 +600,18 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * the confused fail path above (OOM) will be very confused when
 	 * it finds all bh marked clean (i.e. it will not write anything)
 	 */
-	wbc_account_cgroup_owner(wbc, page, PAGE_SIZE);
+	wbc_account_cgroup_owner(wbc, &folio->page, folio_size(folio));
 	length = first_unmapped << blkbits;
-	if (bio_add_page(bio, page, length, 0) < length) {
+	if (!bio_add_folio(bio, folio, length, 0)) {
 		bio = mpage_bio_submit(bio);
 		goto alloc_new;
 	}
 
-	clean_buffers(page, first_unmapped);
+	clean_buffers(&folio->page, first_unmapped);
 
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
-	unlock_page(page);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
+	folio_unlock(folio);
 	if (boundary || (first_unmapped != blocks_per_page)) {
 		bio = mpage_bio_submit(bio);
 		if (boundary_block) {
@@ -633,7 +630,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	/*
 	 * The caller has a ref on the inode, so *mapping is stable
 	 */
-	ret = block_write_full_page(page, mpd->get_block, wbc);
+	ret = block_write_full_page(&folio->page, mpd->get_block, wbc);
 	mapping_set_error(mapping, ret);
 out:
 	mpd->bio = bio;
-- 
2.35.1

