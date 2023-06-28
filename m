Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AAE74151C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF1Pc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjF1PcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA626AB;
        Wed, 28 Jun 2023 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Dg1yxeg5xlrkS1kEyPQLp/xQuMm+hYqoqp8Zg193E/s=; b=Ni5TN9nUC0JctF33Q+uoNVhB76
        BdmAwkfQuBVswApL+L6z5n5eG7J/b1rea+a067IpAqhH+glv2fZAGXciPXpCe9STJj0R4LADWXkEr
        /JssMBSTqKatFPjbxbdZrhtWnx8xhn5sPDluXwHa86zllTao7rgAIxOEDu0+wsmvb6KtIdkEvlGcD
        i+VJhk8vvf2OX4o6WLSMxo4p3Qc39YMm6w2ObUBENM5PXRPDBFSFuCbwwjNAXii5htuDODZrCW6lm
        wNLo3cPchK+lAhbgOJMpi9S1PM+N0HABtt/qAo6V9F+2MMXT04gyp58Pl89o5ZcZOE52xbaO+WoTs
        VSW9i99A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9H-00G04D-2m;
        Wed, 28 Jun 2023 15:32:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/23] btrfs: remove end_extent_writepage
Date:   Wed, 28 Jun 2023 17:31:26 +0200
Message-Id: <20230628153144.22834-6-hch@lst.de>
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

end_extent_writepage is a small helper that combines a call to
btrfs_mark_ordered_io_finished with conditional error-only calls to
btrfs_page_clear_uptodate and mapping_set_error with a somewhat
unfortunate calling convention that passes and inclusive end instead
of the len expected by the underlying functions.

Remove end_extent_writepage and open code it in the 4 callers. Out
of those two already are error-only and thus don't need the extra
conditional, and one already has the mapping_set_error, so a duplicate
call can be avoided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 44 +++++++++++++++-----------------------------
 fs/btrfs/extent_io.h |  2 --
 fs/btrfs/inode.c     | 42 ++++++++++++++++++++++--------------------
 3 files changed, 37 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index af05237dc2f186..5a4f5fc09a2354 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -466,29 +466,6 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_subpage_end_reader(fs_info, page, start, len);
 }
 
-/* lots and lots of room for performance fixes in the end_bio funcs */
-
-void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
-{
-	struct btrfs_inode *inode;
-	const bool uptodate = (err == 0);
-	int ret = 0;
-	u32 len = end + 1 - start;
-
-	ASSERT(end + 1 - start <= U32_MAX);
-	ASSERT(page && page->mapping);
-	inode = BTRFS_I(page->mapping->host);
-	btrfs_mark_ordered_io_finished(inode, page, start, len, uptodate);
-
-	if (!uptodate) {
-		const struct btrfs_fs_info *fs_info = inode->root->fs_info;
-
-		btrfs_page_clear_uptodate(fs_info, page, start, len);
-		ret = err < 0 ? err : -EIO;
-		mapping_set_error(page->mapping, ret);
-	}
-}
-
 /*
  * after a writepage IO is done, we need to:
  * clear the uptodate bits on error
@@ -1431,7 +1408,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	const u64 page_start = page_offset(page);
-	const u64 page_end = page_start + PAGE_SIZE - 1;
 	int ret;
 	int nr = 0;
 	size_t pg_offset;
@@ -1475,8 +1451,13 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 		set_page_writeback(page);
 		end_page_writeback(page);
 	}
-	if (ret)
-		end_extent_writepage(page, ret, page_start, page_end);
+	if (ret) {
+		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
+					       PAGE_SIZE, !ret);
+		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
+					  page_start, PAGE_SIZE);
+		mapping_set_error(page->mapping, ret);
+	}
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
@@ -2194,6 +2175,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
+		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
 		int nr = 0;
 
@@ -2217,9 +2199,13 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			set_page_writeback(page);
 			end_page_writeback(page);
 		}
-		if (ret)
-			end_extent_writepage(page, ret, cur, cur_end);
-		btrfs_page_unlock_writer(fs_info, page, cur, cur_end + 1 - cur);
+		if (ret) {
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
+						       cur, cur_len, !ret);
+			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
+			mapping_set_error(page->mapping, ret);
+		}
+		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
 		if (ret < 0) {
 			found_error = true;
 			first_error = ret;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 285754154fdc5c..8d11e17c0be9fa 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -276,8 +276,6 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
-void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b158db44b268a6..d746b0fe0f994b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -426,11 +426,10 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 
 	while (index <= end_index) {
 		/*
-		 * For locked page, we will call end_extent_writepage() on it
-		 * in run_delalloc_range() for the error handling.  That
-		 * end_extent_writepage() function will call
-		 * btrfs_mark_ordered_io_finished() to clear page Ordered and
-		 * run the ordered extent accounting.
+		 * For locked page, we will call btrfs_mark_ordered_io_finished
+		 * through btrfs_mark_ordered_io_finished() on it
+		 * in run_delalloc_range() for the error handling, which will
+		 * clear page Ordered and run the ordered extent accounting.
 		 *
 		 * Here we can't just clear the Ordered bit, or
 		 * btrfs_mark_ordered_io_finished() would skip the accounting
@@ -1160,11 +1159,16 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
 		if (locked_page) {
 			const u64 page_start = page_offset(locked_page);
-			const u64 page_end = page_start + PAGE_SIZE - 1;
 
 			set_page_writeback(locked_page);
 			end_page_writeback(locked_page);
-			end_extent_writepage(locked_page, ret, page_start, page_end);
+			btrfs_mark_ordered_io_finished(inode, locked_page,
+						       page_start, PAGE_SIZE,
+						       !ret);
+			btrfs_page_clear_uptodate(inode->root->fs_info,
+						  locked_page, page_start,
+						  PAGE_SIZE);
+			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
 		return ret;
@@ -2841,23 +2845,19 @@ struct btrfs_writepage_fixup {
 
 static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 {
-	struct btrfs_writepage_fixup *fixup;
+	struct btrfs_writepage_fixup *fixup =
+		container_of(work, struct btrfs_writepage_fixup, work);
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	struct page *page;
-	struct btrfs_inode *inode;
-	u64 page_start;
-	u64 page_end;
+	struct page *page = fixup->page;
+	struct btrfs_inode *inode = fixup->inode;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u64 page_start = page_offset(page);
+	u64 page_end = page_offset(page) + PAGE_SIZE - 1;
 	int ret = 0;
 	bool free_delalloc_space = true;
 
-	fixup = container_of(work, struct btrfs_writepage_fixup, work);
-	page = fixup->page;
-	inode = fixup->inode;
-	page_start = page_offset(page);
-	page_end = page_offset(page) + PAGE_SIZE - 1;
-
 	/*
 	 * This is similar to page_mkwrite, we need to reserve the space before
 	 * we take the page lock.
@@ -2950,10 +2950,12 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		 * to reflect the errors and clean the page.
 		 */
 		mapping_set_error(page->mapping, ret);
-		end_extent_writepage(page, ret, page_start, page_end);
+		btrfs_mark_ordered_io_finished(inode, page, page_start,
+					       PAGE_SIZE, !ret);
+		btrfs_page_clear_uptodate(fs_info, page, page_start, PAGE_SIZE);
 		clear_page_dirty_for_io(page);
 	}
-	btrfs_page_clear_checked(inode->root->fs_info, page, page_start, PAGE_SIZE);
+	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
 	unlock_page(page);
 	put_page(page);
 	kfree(fixup);
-- 
2.39.2

