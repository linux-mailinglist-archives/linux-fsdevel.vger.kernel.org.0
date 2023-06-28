Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B826374151A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjF1Pcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjF1Pck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C826E2690;
        Wed, 28 Jun 2023 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D+Oa6Jx9+3YAgFpxJAjbhlYziAbEOo8V8qTVMG1/XKE=; b=IHYwHm+vjVHFYDPFr4A4s6eUol
        N5vxZKqfsc4SYiq4wJI9WsYERZwS4Qfgphc472y6V4ou7xyDdsuHuDPIu7agIQceg7q75CXaz8KLn
        YDjbPsH6MKWbf38NPKPM3EF7s0pwRkLu4lyICUbU4sQ3W1ANtHNi0Lz6muDPp5yWMoxOChd0NpIgZ
        tSwGMKi7TGuVkpQHIWAW7oBNuh2zl9XAB9usYuPtU/2r+IHH8QYi7CaKknxadyfyDGMPgUrZPIPNa
        G+1rvjqBVev/xg70H93lSlYu2nA1bwxh3rST08mIdNXuYsuEisYUnPflKmOVFin3gzKjfweJca4Fi
        cn9kKI2g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9o-00G0AW-0x;
        Wed, 28 Jun 2023 15:32:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/23] btrfs: streamline compress_file_range
Date:   Wed, 28 Jun 2023 17:31:36 +0200
Message-Id: <20230628153144.22834-16-hch@lst.de>
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

Reorder compress_file_range so that the main compression flow happens
straight line and not in branches.  To do this ensure that pages is
always zeroed before a page allocation happens, which allows the
cleanup_and_bail_uncompressed label to clean up the page allocations
as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 165 +++++++++++++++++++++++------------------------
 1 file changed, 81 insertions(+), 84 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09f8c6f2f4bf88..e7c05d07ff50f8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -841,10 +841,11 @@ static void compress_file_range(struct btrfs_work *work)
 	u64 actual_end;
 	u64 i_size;
 	int ret = 0;
-	struct page **pages = NULL;
+	struct page **pages;
 	unsigned long nr_pages;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
+	unsigned int poff;
 	int i;
 	int will_compress;
 	int compress_type = fs_info->compress_type;
@@ -867,6 +868,7 @@ static void compress_file_range(struct btrfs_work *work)
 	actual_end = min_t(u64, i_size, end + 1);
 again:
 	will_compress = 0;
+	pages = NULL;
 	nr_pages = (end >> PAGE_SHIFT) - (start >> PAGE_SHIFT) + 1;
 	nr_pages = min_t(unsigned long, nr_pages, BTRFS_MAX_COMPRESSED_PAGES);
 
@@ -910,66 +912,62 @@ static void compress_file_range(struct btrfs_work *work)
 	ret = 0;
 
 	/*
-	 * we do compression for mount -o compress and when the
-	 * inode has not been flagged as nocompress.  This flag can
-	 * change at any time if we discover bad compression ratios.
+	 * We do compression for mount -o compress and when the inode has not
+	 * been flagged as nocompress.  This flag can change at any time if we
+	 * discover bad compression ratios.
 	 */
-	if (inode_need_compress(inode, start, end)) {
-		WARN_ON(pages);
-		pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
-		if (!pages) {
-			/* just bail out to the uncompressed code */
-			nr_pages = 0;
-			goto cont;
-		}
+	if (!inode_need_compress(inode, start, end))
+		goto cont;
 
-		if (inode->defrag_compress)
-			compress_type = inode->defrag_compress;
-		else if (inode->prop_compress)
-			compress_type = inode->prop_compress;
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
+	if (!pages) {
+		/* just bail out to the uncompressed code */
+		nr_pages = 0;
+		goto cont;
+	}
 
-		/*
-		 * we need to call clear_page_dirty_for_io on each
-		 * page in the range.  Otherwise applications with the file
-		 * mmap'd can wander in and change the page contents while
-		 * we are compressing them.
-		 *
-		 * If the compression fails for any reason, we set the pages
-		 * dirty again later on.
-		 *
-		 * Note that the remaining part is redirtied, the start pointer
-		 * has moved, the end is the original one.
-		 */
-		if (!redirty) {
-			extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
-			redirty = 1;
-		}
+	if (inode->defrag_compress)
+		compress_type = inode->defrag_compress;
+	else if (inode->prop_compress)
+		compress_type = inode->prop_compress;
+
+	/*
+	 * We need to call clear_page_dirty_for_io on each page in the range.
+	 * Otherwise applications with the file mmap'd can wander in and change
+	 * the page contents while we are compressing them.
+	 *
+	 * If the compression fails for any reason, we set the pages dirty again
+	 * later on.
+	 *
+	 * Note that the remaining part is redirtied, the start pointer has
+	 * moved, the end is the original one.
+	 */
+	if (!redirty) {
+		extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+		redirty = 1;
+	}
 
-		/* Compression level is applied here and only here */
-		ret = btrfs_compress_pages(
-			compress_type | (fs_info->compress_level << 4),
-					   mapping, start,
-					   pages,
-					   &nr_pages,
-					   &total_in,
-					   &total_compressed);
+	/* Compression level is applied here and only here */
+	ret = btrfs_compress_pages(compress_type |
+				   (fs_info->compress_level << 4),
+				   mapping, start, pages, &nr_pages, &total_in,
+				   &total_compressed);
+	if (ret)
+		goto cont;
 
-		if (!ret) {
-			unsigned long offset = offset_in_page(total_compressed);
-			struct page *page = pages[nr_pages - 1];
+	/*
+	 * Zero the tail end of the last page, as we might be sending it down
+	 * to disk.
+	 */
+	poff = offset_in_page(total_compressed);
+	if (poff)
+		memzero_page(pages[nr_pages - 1], poff, PAGE_SIZE - poff);
+	will_compress = 1;
 
-			/* zero the tail end of the last page, we might be
-			 * sending it down to disk
-			 */
-			if (offset)
-				memzero_page(page, offset, PAGE_SIZE - offset);
-			will_compress = 1;
-		}
-	}
 cont:
 	/*
 	 * Check cow_file_range() for why we don't even try to create inline
-	 * extent for subpage case.
+	 * extent for the subpage case.
 	 */
 	if (start == 0 && fs_info->sectorsize == PAGE_SIZE) {
 		/* lets try to make an inline extent */
@@ -1028,39 +1026,38 @@ static void compress_file_range(struct btrfs_work *work)
 		}
 	}
 
-	if (will_compress) {
-		/*
-		 * we aren't doing an inline extent round the compressed size
-		 * up to a block size boundary so the allocator does sane
-		 * things
-		 */
-		total_compressed = ALIGN(total_compressed, blocksize);
+	if (!will_compress)
+		goto cleanup_and_bail_uncompressed;
 
-		/*
-		 * one last check to make sure the compression is really a
-		 * win, compare the page count read with the blocks on disk,
-		 * compression must free at least one sector size
-		 */
-		total_in = round_up(total_in, fs_info->sectorsize);
-		if (total_compressed + blocksize <= total_in) {
-			/*
-			 * The async work queues will take care of doing actual
-			 * allocation on disk for these compressed pages, and
-			 * will submit them to the elevator.
-			 */
-			add_async_extent(async_chunk, start, total_in,
-					total_compressed, pages, nr_pages,
-					compress_type);
-
-			if (start + total_in < end) {
-				start += total_in;
-				pages = NULL;
-				cond_resched();
-				goto again;
-			}
-			return;
-		}
+	/*
+	 * We aren't doing an inline extent. Round the compressed size up to a
+	 * block size boundary so the allocator does sane things.
+	 */
+	total_compressed = ALIGN(total_compressed, blocksize);
+
+	/*
+	 * One last check to make sure the compression is really a win, compare
+	 * the page count read with the blocks on disk, compression must free at
+	 * least one sector.
+	 */
+	total_in = round_up(total_in, fs_info->sectorsize);
+	if (total_compressed + blocksize > total_in)
+		goto cleanup_and_bail_uncompressed;
+
+	/*
+	 * The async work queues will take care of doing actual allocation on
+	 * disk for these compressed pages, and will submit the bios.
+	 */
+	add_async_extent(async_chunk, start, total_in, total_compressed, pages,
+			 nr_pages, compress_type);
+	if (start + total_in < end) {
+		start += total_in;
+		cond_resched();
+		goto again;
 	}
+	return;
+
+cleanup_and_bail_uncompressed:
 	if (pages) {
 		/*
 		 * the compression code ran but failed to make things smaller,
@@ -1081,7 +1078,7 @@ static void compress_file_range(struct btrfs_work *work)
 			inode->flags |= BTRFS_INODE_NOCOMPRESS;
 		}
 	}
-cleanup_and_bail_uncompressed:
+
 	/*
 	 * No compression, but we still need to write the pages in the file
 	 * we've been given so far.  redirty the locked page if it corresponds
-- 
2.39.2

