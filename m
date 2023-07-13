Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104467522F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjGMNGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbjGMNFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:05:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6E3A91;
        Thu, 13 Jul 2023 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=F/VojWwpMX68AyePR5SCL18Oq3RJWNWzyJlzVpGjdsA=; b=p73ZwbZsGYOfpfT+wt+Plw806e
        KZmv9DhYnzt2Dau4Ipy1peLCSDGT05pTi3Gd3PR8YcEqumwoSYmgXouPitKWVvjEmAbIUeaeNnbwf
        OZDldiBIE7QHO373+Aj13s3FaXWLuQVuya8Tsz7AzSg+0aWfDnIfaC4h/GBT2zddQo2M4glzrXLiT
        z1JLQ0ZSIJOgz6GzM6MyKDk6IJ5sAg2CCwdqaiLowHEYqBvmYNOTduif0ayoc1blbGYHww5K+hgd8
        /53+B3zeN0mMwSfRyXzb0f+4aRairi4/1L4tGWUL4ZuNI4TtmR1l7s4iDJzTwKr1L/ZC8734debvz
        0qyrVIZA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJvzy-003LZH-30;
        Thu, 13 Jul 2023 13:04:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] btrfs: fix handling of errors from __extent_writepage_io
Date:   Thu, 13 Jul 2023 15:04:27 +0200
Message-Id: <20230713130431.4798-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713130431.4798-1-hch@lst.de>
References: <20230713130431.4798-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When __extent_writepage_io fails, the callers complete the ordered range
for the entire page, including the range for which bios have been
submitted already, leading to a double completion for those ranges.

Fix this by pulling the error handling into __extent_writepage_io, and
only apply it to the ranges not submitted yet.

This also means that the remaining error handling in __extent_writepage
never needs to complete the ordered extent, as there won't be one before
writepage_delalloc is called, or when writepage_delalloc returns an
error.

Fixes: 61391d562229 ("Btrfs: fix hang on error (such as ENOSPC) when writing extent pages")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 78 +++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d8185582b9f4b0..0c5e540eb2ebea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1278,12 +1278,11 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
  */
 static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				 struct page *page,
-				 struct btrfs_bio_ctrl *bio_ctrl,
-				 loff_t i_size,
-				 int *nr_ret)
+				 struct btrfs_bio_ctrl *bio_ctrl, loff_t i_size)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 cur = page_offset(page);
+	u64 start = page_offset(page);
+	u64 cur = start;
 	u64 end = cur + PAGE_SIZE - 1;
 	u64 extent_offset;
 	u64 block_start;
@@ -1325,7 +1324,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		em = btrfs_get_extent(inode, NULL, 0, cur, len);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR_OR_ZERO(em);
-			goto out_error;
+			goto out;
 		}
 
 		extent_offset = cur - em->start;
@@ -1372,15 +1371,21 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	}
 
 	btrfs_page_assert_not_dirty(fs_info, page);
-	*nr_ret = nr;
-	return 0;
+	ret = 0;
+out:
+	/* Make sure the mapping tag for page dirty gets cleared. */
+	if (nr == 0) {
+		set_page_writeback(page);
+		end_page_writeback(page);
+	}
+	if (ret) {
+		u32 remaining = end + 1 - cur;
 
-out_error:
-	/*
-	 * If we finish without problem, we should not only clear page dirty,
-	 * but also empty subpage dirty bits
-	 */
-	*nr_ret = nr;
+		btrfs_mark_ordered_io_finished(inode, page, cur, remaining,
+					       false);
+		btrfs_page_clear_uptodate(fs_info, page, cur, remaining);
+		mapping_set_error(page->mapping, ret);
+	}
 	return ret;
 }
 
@@ -1399,7 +1404,6 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	struct inode *inode = page->mapping->host;
 	const u64 page_start = page_offset(page);
 	int ret;
-	int nr = 0;
 	size_t pg_offset;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
@@ -1421,30 +1425,27 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 
 	ret = set_page_extent_mapped(page);
 	if (ret < 0)
-		goto done;
+		goto error;
 
 	ret = writepage_delalloc(BTRFS_I(inode), page, bio_ctrl->wbc);
 	if (ret == 1)
 		return 0;
 	if (ret)
-		goto done;
+		goto error;
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
+	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size);
+	/* __extent_writepage_io cleans up by itself on error. */
 	bio_ctrl->wbc->nr_to_write--;
-
-done:
-	if (nr == 0) {
-		/* make sure the mapping tag for page dirty gets cleared */
-		set_page_writeback(page);
-		end_page_writeback(page);
-	}
-	if (ret) {
-		btrfs_mark_ordered_io_finished(BTRFS_I(inode), page, page_start,
-					       PAGE_SIZE, !ret);
-		btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
-					  page_start, PAGE_SIZE);
-		mapping_set_error(page->mapping, ret);
-	}
+	goto unlock_page;
+
+error:
+	/* Make sure the mapping tag for page dirty gets cleared. */
+	set_page_writeback(page);
+	end_page_writeback(page);
+	btrfs_page_clear_uptodate(btrfs_sb(inode->i_sb), page,
+				  page_start, PAGE_SIZE);
+	mapping_set_error(page->mapping, ret);
+unlock_page:
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
@@ -2171,7 +2172,6 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
-		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
@@ -2181,19 +2181,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
-					    i_size, &nr);
-
-		/* Make sure the mapping tag for page dirty gets cleared. */
-		if (nr == 0) {
-			set_page_writeback(page);
-			end_page_writeback(page);
-		}
-		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
-						       cur, cur_len, !ret);
-			btrfs_page_clear_uptodate(fs_info, page, cur, cur_len);
-			mapping_set_error(page->mapping, ret);
-		}
+					    i_size);
 		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
-- 
2.39.2

