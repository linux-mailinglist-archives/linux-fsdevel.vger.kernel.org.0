Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A374151D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjF1PcU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjF1PcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89472110;
        Wed, 28 Jun 2023 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bO9tOc0j9/dZluOR3Y1G+XOqcPGQ2FwtMsXfQlry8Vw=; b=AjnFoZ0dkGsHEAkJhiS6CYT0C3
        JoRKdUPSi4ODap8ki5muKE0Z5J2btOAqKXfqwBVob0AAtcG35zvJG8sb/BItdiFuGBjZi41j8qPhW
        XqgW5i946yJAE9ynIvY5cYLiB/24rLua5CtstCxMqk9GXL9veYp1aQ1ceEzovFCtfSeKYNf6Kwj+U
        kUoBi7WjAx19VJn0xETJrAS2EP2Xh7ybBRbzNonJhxIpDsD8NYpUjL4LBMFcTyDJXECIySsyvrXXP
        BYBZuxpDo+wH/PtoMSgbpJ3+Qdgm/Qz180BkIBCQiFJZY+E5jEvmqVv+jN/XxrNWy0bF+RWRNOVBh
        uSPvIbpg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9E-00G03q-38;
        Wed, 28 Jun 2023 15:32:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/23] btrfs: remove btrfs_writepage_endio_finish_ordered
Date:   Wed, 28 Jun 2023 17:31:25 +0200
Message-Id: <20230628153144.22834-5-hch@lst.de>
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

btrfs_writepage_endio_finish_ordered is a small wrapper around
btrfs_mark_ordered_io_finished that just changs the argument passing
slightly, and adds a tracepoint.

Move the tracpoint to btrfs_mark_ordered_io_finished, which means
it now also covers the error handling in btrfs_cleanup_ordered_extent
and switch all callers to just call btrfs_mark_ordered_io_finished
directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h  |  3 ---
 fs/btrfs/extent_io.c    | 17 ++++++++---------
 fs/btrfs/inode.c        |  9 ---------
 fs/btrfs/ordered-data.c |  4 ++++
 4 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d47a927b3504d6..90e60ad9db6200 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -501,9 +501,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 			     u64 start, u64 end, int *page_started,
 			     unsigned long *nr_written, struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page);
-void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
-					  struct page *page, u64 start,
-					  u64 end, bool uptodate);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type);
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 36c3ae947ae8e0..af05237dc2f186 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -473,17 +473,15 @@ void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 	struct btrfs_inode *inode;
 	const bool uptodate = (err == 0);
 	int ret = 0;
+	u32 len = end + 1 - start;
 
+	ASSERT(end + 1 - start <= U32_MAX);
 	ASSERT(page && page->mapping);
 	inode = BTRFS_I(page->mapping->host);
-	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate);
+	btrfs_mark_ordered_io_finished(inode, page, start, len, uptodate);
 
 	if (!uptodate) {
 		const struct btrfs_fs_info *fs_info = inode->root->fs_info;
-		u32 len;
-
-		ASSERT(end + 1 - start <= U32_MAX);
-		len = end + 1 - start;
 
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 		ret = err < 0 ? err : -EIO;
@@ -1328,6 +1326,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 	bio_ctrl->end_io_func = end_bio_extent_writepage;
 	while (cur <= end) {
+		u32 len = end - cur + 1;
 		u64 disk_bytenr;
 		u64 em_end;
 		u64 dirty_range_start = cur;
@@ -1335,8 +1334,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		u32 iosize;
 
 		if (cur >= i_size) {
-			btrfs_writepage_endio_finish_ordered(inode, page, cur,
-							     end, true);
+			btrfs_mark_ordered_io_finished(inode, page, cur, len,
+						       true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1345,7 +1344,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_page_clear_dirty(fs_info, page, cur, end + 1 - cur);
+			btrfs_page_clear_dirty(fs_info, page, cur, len);
 			break;
 		}
 
@@ -1356,7 +1355,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			continue;
 		}
 
-		em = btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
+		em = btrfs_get_extent(inode, NULL, 0, cur, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR_OR_ZERO(em);
 			goto out_error;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cddf54bc330c44..b158db44b268a6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3385,15 +3385,6 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 	return btrfs_finish_one_ordered(ordered);
 }
 
-void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
-					  struct page *page, u64 start,
-					  u64 end, bool uptodate)
-{
-	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
-
-	btrfs_mark_ordered_io_finished(inode, page, start, end + 1 - start, uptodate);
-}
-
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index a629532283bc33..109e80ed25b669 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -410,6 +410,10 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 	unsigned long flags;
 	u64 cur = file_offset;
 
+	trace_btrfs_writepage_end_io_hook(inode, file_offset,
+					  file_offset + num_bytes - 1,
+					  uptodate);
+
 	spin_lock_irqsave(&tree->lock, flags);
 	while (cur < file_offset + num_bytes) {
 		u64 entry_end;
-- 
2.39.2

