Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEA741512
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjF1PcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF1PcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D132713;
        Wed, 28 Jun 2023 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/4LhoYS1a46Ypg0rLbmBV6jQxcERRkdLSBppKY3OP2k=; b=AfQSP5MnIyK8y404njG+aVVs8y
        Ow1utPln33dlQfuZljzUafZZBcFti1Yv9hiGawAOW7go48tSf5RuBPyRsOCuzny/57EvqvGR252nV
        bCTYODM+OV19mSxbicTGueCvw3DcCX28uqGRqmpDCnEASvcc9URCTyMQ6hioeHDT1klIqfv6BdM0u
        6Ytx23q2bUf8qxqoGmiwqO7cWhWWAQSBEA4x2JtGYF1GK9b4NyFKnYqIoOFiMRqOItu7f4vXBxrWw
        H4bqsumkZ1L7Lu0naWXgI1ofDGgDGKvPiIxVXapRLKgtG5/VykmR+6InYnGsINnNo6tHzC3K6inP4
        g1FnBruQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9B-00G03d-1I;
        Wed, 28 Jun 2023 15:31:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/23] btrfs: split page locking out of __process_pages_contig
Date:   Wed, 28 Jun 2023 17:31:24 +0200
Message-Id: <20230628153144.22834-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a lot of complexity in __process_pages_contig to deal with the
PAGE_LOCK case that can return an error unlike all the other actions.

Open code the page iteration for page locking in lock_delalloc_pages and
remove all the now unused code from __process_pages_contig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 149 +++++++++++++++++--------------------------
 fs/btrfs/extent_io.h |   1 -
 2 files changed, 59 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a91d5ad2798428..36c3ae947ae8e0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -197,18 +197,9 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 	}
 }
 
-/*
- * Process one page for __process_pages_contig().
- *
- * Return >0 if we hit @page == @locked_page.
- * Return 0 if we updated the page status.
- * Return -EGAIN if the we need to try again.
- * (For PAGE_LOCK case but got dirty page or page not belong to mapping)
- */
-static int process_one_page(struct btrfs_fs_info *fs_info,
-			    struct address_space *mapping,
-			    struct page *page, struct page *locked_page,
-			    unsigned long page_ops, u64 start, u64 end)
+static void process_one_page(struct btrfs_fs_info *fs_info,
+			     struct page *page, struct page *locked_page,
+			     unsigned long page_ops, u64 start, u64 end)
 {
 	u32 len;
 
@@ -224,29 +215,13 @@ static int process_one_page(struct btrfs_fs_info *fs_info,
 	if (page_ops & PAGE_END_WRITEBACK)
 		btrfs_page_clamp_clear_writeback(fs_info, page, start, len);
 
-	if (page == locked_page)
-		return 1;
-
-	if (page_ops & PAGE_LOCK) {
-		int ret;
-
-		ret = btrfs_page_start_writer_lock(fs_info, page, start, len);
-		if (ret)
-			return ret;
-		if (!PageDirty(page) || page->mapping != mapping) {
-			btrfs_page_end_writer_lock(fs_info, page, start, len);
-			return -EAGAIN;
-		}
-	}
-	if (page_ops & PAGE_UNLOCK)
+	if (page != locked_page && (page_ops & PAGE_UNLOCK))
 		btrfs_page_end_writer_lock(fs_info, page, start, len);
-	return 0;
 }
 
-static int __process_pages_contig(struct address_space *mapping,
-				  struct page *locked_page,
-				  u64 start, u64 end, unsigned long page_ops,
-				  u64 *processed_end)
+static void __process_pages_contig(struct address_space *mapping,
+				   struct page *locked_page, u64 start, u64 end,
+				   unsigned long page_ops)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
 	pgoff_t start_index = start >> PAGE_SHIFT;
@@ -254,64 +229,24 @@ static int __process_pages_contig(struct address_space *mapping,
 	pgoff_t index = start_index;
 	unsigned long pages_processed = 0;
 	struct folio_batch fbatch;
-	int err = 0;
 	int i;
 
-	if (page_ops & PAGE_LOCK) {
-		ASSERT(page_ops == PAGE_LOCK);
-		ASSERT(processed_end && *processed_end == start);
-	}
-
 	folio_batch_init(&fbatch);
 	while (index <= end_index) {
 		int found_folios;
 
 		found_folios = filemap_get_folios_contig(mapping, &index,
 				end_index, &fbatch);
-
-		if (found_folios == 0) {
-			/*
-			 * Only if we're going to lock these pages, we can find
-			 * nothing at @index.
-			 */
-			ASSERT(page_ops & PAGE_LOCK);
-			err = -EAGAIN;
-			goto out;
-		}
-
 		for (i = 0; i < found_folios; i++) {
-			int process_ret;
 			struct folio *folio = fbatch.folios[i];
-			process_ret = process_one_page(fs_info, mapping,
-					&folio->page, locked_page, page_ops,
-					start, end);
-			if (process_ret < 0) {
-				err = -EAGAIN;
-				folio_batch_release(&fbatch);
-				goto out;
-			}
+
+			process_one_page(fs_info, &folio->page, locked_page,
+					 page_ops, start, end);
 			pages_processed += folio_nr_pages(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
-out:
-	if (err && processed_end) {
-		/*
-		 * Update @processed_end. I know this is awful since it has
-		 * two different return value patterns (inclusive vs exclusive).
-		 *
-		 * But the exclusive pattern is necessary if @start is 0, or we
-		 * underflow and check against processed_end won't work as
-		 * expected.
-		 */
-		if (pages_processed)
-			*processed_end = min(end,
-			((u64)(start_index + pages_processed) << PAGE_SHIFT) - 1);
-		else
-			*processed_end = start;
-	}
-	return err;
 }
 
 static noinline void __unlock_for_delalloc(struct inode *inode,
@@ -326,29 +261,63 @@ static noinline void __unlock_for_delalloc(struct inode *inode,
 		return;
 
 	__process_pages_contig(inode->i_mapping, locked_page, start, end,
-			       PAGE_UNLOCK, NULL);
+			       PAGE_UNLOCK);
 }
 
 static noinline int lock_delalloc_pages(struct inode *inode,
 					struct page *locked_page,
-					u64 delalloc_start,
-					u64 delalloc_end)
+					u64 start,
+					u64 end)
 {
-	unsigned long index = delalloc_start >> PAGE_SHIFT;
-	unsigned long end_index = delalloc_end >> PAGE_SHIFT;
-	u64 processed_end = delalloc_start;
-	int ret;
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	pgoff_t index = start_index;
+	u64 processed_end = start;
+	struct folio_batch fbatch;
 
-	ASSERT(locked_page);
 	if (index == locked_page->index && index == end_index)
 		return 0;
 
-	ret = __process_pages_contig(inode->i_mapping, locked_page, delalloc_start,
-				     delalloc_end, PAGE_LOCK, &processed_end);
-	if (ret == -EAGAIN && processed_end > delalloc_start)
-		__unlock_for_delalloc(inode, locked_page, delalloc_start,
-				      processed_end);
-	return ret;
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		unsigned int found_folios, i;
+
+		found_folios = filemap_get_folios_contig(mapping, &index,
+				end_index, &fbatch);
+		if (found_folios == 0)
+			goto out;
+
+		for (i = 0; i < found_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
+			u32 len = end + 1 - start;
+
+			if (page == locked_page)
+				continue;
+
+			if (btrfs_page_start_writer_lock(fs_info, page, start,
+							 len))
+				goto out;
+
+			if (!PageDirty(page) || page->mapping != mapping) {
+				btrfs_page_end_writer_lock(fs_info, page, start,
+							   len);
+				goto out;
+			}
+
+			processed_end = page_offset(page) + PAGE_SIZE - 1;
+		}
+		folio_batch_release(&fbatch);
+		cond_resched();
+	}
+
+	return 0;
+out:
+	folio_batch_release(&fbatch);
+	if (processed_end > start)
+		__unlock_for_delalloc(inode, locked_page, start, processed_end);
+	return -EAGAIN;
 }
 
 /*
@@ -467,7 +436,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, NULL);
 
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
-			       start, end, page_ops, NULL);
+			       start, end, page_ops);
 }
 
 static bool btrfs_verify_page(struct page *page, u64 start)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c5fae3a7d911bf..285754154fdc5c 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -40,7 +40,6 @@ enum {
 	ENUM_BIT(PAGE_START_WRITEBACK),
 	ENUM_BIT(PAGE_END_WRITEBACK),
 	ENUM_BIT(PAGE_SET_ORDERED),
-	ENUM_BIT(PAGE_LOCK),
 };
 
 /*
-- 
2.39.2

