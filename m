Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17A974153B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjF1Pdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjF1PdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FD268F;
        Wed, 28 Jun 2023 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4HETsFJ8ye30gs+F7MRgBcVCM5W6d7BFL975DNKYFJM=; b=B8kzV0fM6jGe6h9dhVdSCwnD6l
        Mo+pIBZ5HjCvNJorW5sPA5Xi8h/UzPxih7Fo0zEpqQCQofGFP2lEw8lEMqSvzretn+B5XHBLcTz9g
        2GmtMK6gebzOjd7xMipJY/iHdwZdYLBwaXev05BPeSNJwaxPQ0HGW+FeSVqFvqhKf4byPJeaVcJPQ
        LCgr4cXVVk9aYAEsS/1CiuKsgbMduiKS53zLrRdKJIts436+P/IntqsuuZ6b8WVqxbgYNvSrCzD4v
        IfZluOAr0GIaloTnYiy+DAKTLQn5d9WFyYShQJ/OuHPm5FXvUUbcybkL2YkNTuw/YhsCBNSzdlppt
        007/QyFg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEXA0-00G0Ed-3C;
        Wed, 28 Jun 2023 15:32:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/23] btrfs: don't redirty pages in compress_file_range
Date:   Wed, 28 Jun 2023 17:31:40 +0200
Message-Id: <20230628153144.22834-20-hch@lst.de>
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

compress_file_range needs to clear the dirty bit before handing off work
to the compression worker threads to prevent processes coming in through
mmap and changing the file contents while the compression is accessing
the data (See commit 4adaa611020f ("Btrfs: fix race between mmap writes
and compression").

But when compress_file_range decides to not compress the data, it falls
back to submit_uncompressed_range which uses extent_write_locked_range
to write the uncompressed data.  extent_write_locked_range currently
expects all pages to be marked dirty so that it can clear the dirty
bit itself, and thus compress_file_range has to redirty the page range.

Redirtying the page range is rather inefficient and also pointless,
so instead pass a pages_dirty parameter to extent_write_locked_range
and skip the redirty game entirely.

Note that compress_file_range was even redirtying the locked_page twice
given that extent_range_clear_dirty_for_io already redirties all pages
in the range, which must include locked_page if there is one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 29 +++++------------------------
 fs/btrfs/extent_io.h |  3 +--
 fs/btrfs/inode.c     | 43 +++++++++----------------------------------
 3 files changed, 15 insertions(+), 60 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6befffd76e8808..e74153c02d84c7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -181,22 +181,6 @@ void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 	}
 }
 
-void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
-{
-	struct address_space *mapping = inode->i_mapping;
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
-	struct folio *folio;
-
-	while (index <= end_index) {
-		folio = filemap_get_folio(mapping, index);
-		filemap_dirty_folio(mapping, folio);
-		folio_account_redirty(folio);
-		index += folio_nr_pages(folio);
-		folio_put(folio);
-	}
-}
-
 static void process_one_page(struct btrfs_fs_info *fs_info,
 			     struct page *page, struct page *locked_page,
 			     unsigned long page_ops, u64 start, u64 end)
@@ -2150,7 +2134,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * locked.
  */
 void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			       struct writeback_control *wbc)
+			       struct writeback_control *wbc, bool pages_dirty)
 {
 	bool found_error = false;
 	int ret = 0;
@@ -2176,14 +2160,11 @@ void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
-		/*
-		 * All pages in the range are locked since
-		 * btrfs_run_delalloc_range(), thus there is no way to clear
-		 * the page dirty flag.
-		 */
 		ASSERT(PageLocked(page));
-		ASSERT(PageDirty(page));
-		clear_page_dirty_for_io(page);
+		if (pages_dirty) {
+			ASSERT(PageDirty(page));
+			clear_page_dirty_for_io(page);
+		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
 					    i_size, &nr);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0312022bbf4b7a..2678906e87c506 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -178,7 +178,7 @@ int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
 void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			       struct writeback_control *wbc);
+			       struct writeback_control *wbc, bool pages_dirty);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
@@ -265,7 +265,6 @@ void set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
-void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  u32 bits_to_clear, unsigned long page_ops);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f3a72f3f897a1..556f63e8496ff8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -848,10 +848,16 @@ static void compress_file_range(struct btrfs_work *work)
 	unsigned int poff;
 	int i;
 	int compress_type = fs_info->compress_type;
-	int redirty = 0;
 
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
+	/*
+	 * We need to call clear_page_dirty_for_io on each page in the range.
+	 * Otherwise applications with the file mmap'd can wander in and change
+	 * the page contents while we are compressing them.
+	 */
+	extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+
 	/*
 	 * We need to save i_size before now because it could change in between
 	 * us evaluating the size and assigning it.  This is because we lock and
@@ -927,22 +933,6 @@ static void compress_file_range(struct btrfs_work *work)
 	else if (inode->prop_compress)
 		compress_type = inode->prop_compress;
 
-	/*
-	 * We need to call clear_page_dirty_for_io on each page in the range.
-	 * Otherwise applications with the file mmap'd can wander in and change
-	 * the page contents while we are compressing them.
-	 *
-	 * If the compression fails for any reason, we set the pages dirty again
-	 * later on.
-	 *
-	 * Note that the remaining part is redirtied, the start pointer has
-	 * moved, the end is the original one.
-	 */
-	if (!redirty) {
-		extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
-		redirty = 1;
-	}
-
 	/* Compression level is applied here and only here */
 	ret = btrfs_compress_pages(compress_type |
 				   (fs_info->compress_level << 4),
@@ -1039,21 +1029,6 @@ static void compress_file_range(struct btrfs_work *work)
 	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compress)
 		inode->flags |= BTRFS_INODE_NOCOMPRESS;
 cleanup_and_bail_uncompressed:
-	/*
-	 * No compression, but we still need to write the pages in the file
-	 * we've been given so far.  redirty the locked page if it corresponds
-	 * to our extent and set things up for the async work queue to run
-	 * cow_file_range to do the normal delalloc dance.
-	 */
-	if (async_chunk->locked_page &&
-	    (page_offset(async_chunk->locked_page) >= start &&
-	     page_offset(async_chunk->locked_page)) <= end) {
-		__set_page_dirty_nobuffers(async_chunk->locked_page);
-		/* unlocked later on in the async handlers */
-	}
-
-	if (redirty)
-		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
 free_pages:
@@ -1130,7 +1105,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 
 	/* All pages will be unlocked, including @locked_page */
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	extent_write_locked_range(&inode->vfs_inode, start, end, &wbc);
+	extent_write_locked_range(&inode->vfs_inode, start, end, &wbc, false);
 	wbc_detach_inode(&wbc);
 }
 
@@ -1755,7 +1730,7 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 		}
 		locked_page_done = true;
 		extent_write_locked_range(&inode->vfs_inode, start, done_offset,
-					  wbc);
+					  wbc, true);
 		start = done_offset + 1;
 	}
 
-- 
2.39.2

