Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A974151E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjF1Pcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjF1Pc0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD862D62;
        Wed, 28 Jun 2023 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=llA+f4Ies2XcDGVW7SotkLbLtRt6F36tThJQhL/EIUg=; b=ipXZUKMyUGAwTlFWNEQQPcO2We
        OrSZe4i5lYW8qM0LCswqVDcWL8VCYgVfNNm7KwezBf6OAq4/f9HfDGWopUXIO0J9F0dVbSpNz9z8f
        hBOX8YveuajWDOBNwJeXKi2aFYXUCoi4rFktPiSy5t2IW4+wrVAon5p3OK1pHyoRWmPQ4+t/EsSBT
        10/WqjFhoBbSP8i2ZyTqCBbpYQRnKNzWBU5q5CgbCyQehnCv9X6Q27STHDhSLTZPDyYlgaq58pni3
        RLXlTelLOjhzKUDPLrTM94h7lebmhX1n6w4Y//qjwaF2aUIk3VU8u9jZAd7uLJHN3MqvSgxF4QCE0
        C25XWquw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9Y-00G07o-1N;
        Wed, 28 Jun 2023 15:32:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/23] btrfs: reduce the number of arguments to btrfs_run_delalloc_range
Date:   Wed, 28 Jun 2023 17:31:31 +0200
Message-Id: <20230628153144.22834-11-hch@lst.de>
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

Instead of a separate page_started argument that tells the callers that
btrfs_run_delalloc_range already started writeback by itself, overload
the return value with a positive 1 in additio to 0 and a negative error
code to indicate that is has already started writeback, and remove the
nr_written argument as that caller can calculate it directly based on
the range, and in fact already does so for the case where writeback
wasn't started yet.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  3 +-
 fs/btrfs/extent_io.c   | 30 +++++++--------
 fs/btrfs/inode.c       | 87 ++++++++++++++----------------------------
 3 files changed, 44 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 90e60ad9db6200..bda1fdbba666aa 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -498,8 +498,7 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 				    u64 start, u64 num_bytes, u64 min_size,
 				    loff_t actual_len, u64 *alloc_hint);
 int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
-			     u64 start, u64 end, int *page_started,
-			     unsigned long *nr_written, struct writeback_control *wbc);
+			     u64 start, u64 end, struct writeback_control *wbc);
 int btrfs_writepage_cow_fixup(struct page *page);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa2f88365ad05a..6befffd76e8808 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1169,10 +1169,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
-	/* How many pages are started by btrfs_run_delalloc_range() */
-	unsigned long nr_written = 0;
-	int ret;
-	int page_started = 0;
+	int ret = 0;
 
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
@@ -1181,9 +1178,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
+
 		ret = btrfs_run_delalloc_range(inode, page, delalloc_start,
-				delalloc_end, &page_started, &nr_written, wbc);
-		if (ret)
+					       delalloc_end, wbc);
+		if (ret < 0)
 			return ret;
 
 		delalloc_start = delalloc_end + 1;
@@ -1195,6 +1193,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 */
 	delalloc_to_write +=
 		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
+
+	/*
+	 * If btrfs_run_dealloc_range() already started I/O and unlocked
+	 * the pages, we just need to account for them here.
+	 */
+	if (ret == 1) {
+		wbc->nr_to_write -= delalloc_to_write;
+		return 1;
+	}
+
 	if (wbc->nr_to_write < delalloc_to_write) {
 		int thresh = 8192;
 
@@ -1204,16 +1212,6 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 					 thresh);
 	}
 
-	/* Did btrfs_run_dealloc_range() already unlock and start the IO? */
-	if (page_started) {
-		/*
-		 * We've unlocked the page, so we can't update the mapping's
-		 * writeback index, just update nr_to_write.
-		 */
-		wbc->nr_to_write -= nr_written;
-		return 1;
-	}
-
 	return 0;
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c6845b0591b77e..8185e95ad12a19 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -129,8 +129,7 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
 #define CFR_NOINLINE		(1 << 1)
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
-				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, u64 *done_offset,
+				   u64 start, u64 end, u64 *done_offset,
 				   u32 flags);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
@@ -1132,8 +1131,6 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 {
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
-	unsigned long nr_written = 0;
-	int page_started = 0;
 	int ret;
 	struct writeback_control wbc = {
 		.sync_mode		= WB_SYNC_ALL,
@@ -1149,10 +1146,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	 * Also we call cow_file_range() with @unlock_page == 0, so that we
 	 * can directly submit them without interruption.
 	 */
-	ret = cow_file_range(inode, locked_page, start, end, &page_started,
-			     &nr_written, NULL, CFR_KEEP_LOCKED);
+	ret = cow_file_range(inode, locked_page, start, end, NULL,
+			     CFR_KEEP_LOCKED);
 	/* Inline extent inserted, page gets unlocked and everything is done */
-	if (page_started)
+	if (ret == 1)
 		return;
 
 	if (ret < 0) {
@@ -1363,8 +1360,8 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  *
  * When this function fails, it unlocks all pages except @locked_page.
  *
- * When this function successfully creates an inline extent, it sets page_started
- * to 1 and unlocks all pages including locked_page and starts I/O on them.
+ * When this function successfully creates an inline extent, it returns 1 and
+ * unlocks all pages including locked_page and starts I/O on them.
  * (In reality inline extents are limited to a single page, so locked_page is
  * the only page handled anyway).
  *
@@ -1381,10 +1378,8 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * example.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
-				   struct page *locked_page,
-				   u64 start, u64 end, int *page_started,
-				   unsigned long *nr_written, u64 *done_offset,
-				   u32 flags)
+				   struct page *locked_page, u64 start, u64 end,
+				   u64 *done_offset, u32 flags)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1444,9 +1439,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
 				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
-			*nr_written = *nr_written +
-			     (end - start + PAGE_SIZE) / PAGE_SIZE;
-			*page_started = 1;
 			/*
 			 * locked_page is locked by the caller of
 			 * writepage_delalloc(), not locked by
@@ -1456,11 +1448,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * as it doesn't have any subpage::writers recorded.
 			 *
 			 * Here we manually unlock the page, since the caller
-			 * can't use page_started to determine if it's an
-			 * inline extent or a compressed extent.
+			 * can't determine if it's an inline extent or a
+			 * compressed extent.
 			 */
 			unlock_page(locked_page);
-			goto out;
+			return 1;
 		} else if (ret < 0) {
 			goto out_unlock;
 		}
@@ -1574,7 +1566,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
-out:
 	return ret;
 
 out_drop_extent_cache:
@@ -1725,10 +1716,8 @@ static noinline void async_cow_free(struct btrfs_work *work)
 }
 
 static bool run_delalloc_compressed(struct btrfs_inode *inode,
-				    struct writeback_control *wbc,
-				    struct page *locked_page,
-				    u64 start, u64 end, int *page_started,
-				    unsigned long *nr_written)
+				    struct page *locked_page, u64 start,
+				    u64 end, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
@@ -1810,34 +1799,25 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 
 		btrfs_queue_work(fs_info->delalloc_workers, &async_chunk[i].work);
 
-		*nr_written += nr_pages;
 		start = cur_end + 1;
 	}
-	*page_started = 1;
 	return true;
 }
 
 static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 				       struct page *locked_page, u64 start,
-				       u64 end, int *page_started,
-				       unsigned long *nr_written,
-				       struct writeback_control *wbc)
+				       u64 end, struct writeback_control *wbc)
 {
 	u64 done_offset = end;
 	int ret;
 	bool locked_page_done = false;
 
 	while (start <= end) {
-		ret = cow_file_range(inode, locked_page, start, end, page_started,
-				     nr_written, &done_offset, CFR_KEEP_LOCKED);
+		ret = cow_file_range(inode, locked_page, start, end,
+				     &done_offset, CFR_KEEP_LOCKED);
 		if (ret && ret != -EAGAIN)
 			return ret;
 
-		if (*page_started) {
-			ASSERT(ret == 0);
-			return 0;
-		}
-
 		if (ret == 0)
 			done_offset = end;
 
@@ -1858,9 +1838,7 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 		start = done_offset + 1;
 	}
 
-	*page_started = 1;
-
-	return 0;
+	return 1;
 }
 
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
@@ -1893,8 +1871,6 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	const bool is_reloc_ino = btrfs_is_data_reloc_root(inode->root);
 	const u64 range_bytes = end + 1 - start;
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	int page_started = 0;
-	unsigned long nr_written;
 	u64 range_start = start;
 	u64 count;
 	int ret;
@@ -1955,9 +1931,9 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	 * is written out and unlocked directly and a normal nocow extent
 	 * doesn't work.
 	 */
-	ret = cow_file_range(inode, locked_page, start, end, &page_started,
-			     &nr_written, NULL, CFR_NOINLINE);
-	ASSERT(!page_started);
+	ret = cow_file_range(inode, locked_page, start, end, NULL,
+			     CFR_NOINLINE);
+	ASSERT(ret != 1);
 	return ret;
 }
 
@@ -2393,15 +2369,14 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
  * being touched for the first time.
  */
 int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page,
-		u64 start, u64 end, int *page_started, unsigned long *nr_written,
-		struct writeback_control *wbc)
+			     u64 start, u64 end, struct writeback_control *wbc)
 {
-	int ret = 0;
 	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
+	int ret;
 
 	/*
-	 * The range must cover part of the @locked_page, or the returned
-	 * @page_started can confuse the caller.
+	 * The range must cover part of the @locked_page, or a return of 1
+	 * can confuse the caller.
 	 */
 	ASSERT(!(end <= page_offset(locked_page) ||
 		 start >= page_offset(locked_page) + PAGE_SIZE));
@@ -2421,20 +2396,16 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
-	    run_delalloc_compressed(inode, wbc, locked_page, start,
-				    end, page_started, nr_written))
-		goto out;
+	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
+		return 1;
 
 	if (zoned)
-		ret = run_delalloc_zoned(inode, locked_page, start, end,
-					 page_started, nr_written, wbc);
+		ret = run_delalloc_zoned(inode, locked_page, start, end, wbc);
 	else
-		ret = cow_file_range(inode, locked_page, start, end,
-				     page_started, nr_written, NULL, 0);
+		ret = cow_file_range(inode, locked_page, start, end, NULL, 0);
 
 out:
-	ASSERT(ret <= 0);
-	if (ret)
+	if (ret < 0)
 		btrfs_cleanup_ordered_extents(inode, locked_page, start,
 					      end - start + 1);
 	return ret;
-- 
2.39.2

