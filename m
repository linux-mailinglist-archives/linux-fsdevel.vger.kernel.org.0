Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C5741521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjF1Pdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjF1PdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8E2713;
        Wed, 28 Jun 2023 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=chok8CbnygTGU4+BjwiSJTAKUtXt5cAc3nHU6IX1dKg=; b=Qxpb1SBjrS351UEWgPXEytbDNy
        SEPDU5Ofxd2zEnVIQ4QJnOm6KOqYH3qnaWVTlqAMOMZ+lWtnqDfHWUvwzQ7gucS4RPNwrEaMTs1Cx
        atGM9xLrKJ3r9FuAcj+2yioOjUA4UeZdjySQo0+FzekRA4hmilXPlszUEOCEPIvgU69RDWYqtcwyZ
        lnEE4mwHxWpn+2c2gd4wm79lsJl/DWtVMolaVlTEj50Dxlsnggt8aW3vPhmtM3zNfgyziqQOtvQh1
        yJr6GVPDXHWrYe2oFOY+8I+5rWENvWVkNHtIy+/4cdjuSVNxK+txdkUMqtWFIT3glEfKiDxsbylPM
        hbLUW1cw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEXAA-00G0H0-37;
        Wed, 28 Jun 2023 15:32:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/23] btrfs: fix zoned handling in submit_uncompressed_range
Date:   Wed, 28 Jun 2023 17:31:43 +0200
Message-Id: <20230628153144.22834-23-hch@lst.de>
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

For zoned file systems we need to use run_delalloc_zoned to submit
writeback, as we need to write out partial allocations when running into
zone active limits.

submit_uncompressed_range currently always calls cow_file_range to
allocate blocks and thus misses the active zone limits handling.  Fix
this by passing the pages_dirty argument to run_delalloc_zoned and always
using it from submit_uncompressed_range as it does the right thing for
zoned and non-zone file systems.

To account for the fact that run_delalloc_zoned is now also used for
non-zoned file systems rename it to run_delalloc_cow, and add comment
describing it.

Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path for zoned filesystems")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 52 +++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae5166d33253a5..2079bf48629b59 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -125,12 +125,10 @@ static struct kmem_cache *btrfs_inode_cachep;
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
 static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
 
-#define CFR_KEEP_LOCKED		(1 << 0)
-#define CFR_NOINLINE		(1 << 1)
-static noinline int cow_file_range(struct btrfs_inode *inode,
-				   struct page *locked_page,
-				   u64 start, u64 end, u64 *done_offset,
-				   u32 flags);
+static noinline int run_delalloc_cow(struct btrfs_inode *inode,
+				     struct page *locked_page, u64 start,
+				     u64 end, struct writeback_control *wbc,
+				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
 				       u64 block_len, u64 orig_block_len,
@@ -1071,19 +1069,9 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 		.no_cgroup_owner	= 1,
 	};
 
-	/*
-	 * Call cow_file_range() to run the delalloc range directly, since we
-	 * won't go to NOCOW or async path again.
-	 *
-	 * Also we call cow_file_range() with @unlock_page == 0, so that we
-	 * can directly submit them without interruption.
-	 */
-	ret = cow_file_range(inode, locked_page, start, end, NULL,
-			     CFR_KEEP_LOCKED);
-	/* Inline extent inserted, page gets unlocked and everything is done */
-	if (ret == 1)
-		return;
-
+	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
+	ret = run_delalloc_cow(inode, locked_page, start, end, &wbc, false);
+	wbc_detach_inode(&wbc);
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
 		if (locked_page) {
@@ -1100,14 +1088,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			mapping_set_error(locked_page->mapping, ret);
 			unlock_page(locked_page);
 		}
-		return;
 	}
-
-	/* All pages will be unlocked, including @locked_page */
-	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	extent_write_locked_range(&inode->vfs_inode, NULL, start, end, &wbc,
-				  false);
-	wbc_detach_inode(&wbc);
 }
 
 static void submit_one_async_extent(struct async_chunk *async_chunk,
@@ -1290,6 +1271,8 @@ static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
  * example.
  */
+#define CFR_KEEP_LOCKED		(1 << 0)
+#define CFR_NOINLINE		(1 << 1)
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page, u64 start, u64 end,
 				   u64 *done_offset, u32 flags)
@@ -1715,9 +1698,14 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 	return true;
 }
 
-static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
-				       struct page *locked_page, u64 start,
-				       u64 end, struct writeback_control *wbc)
+/*
+ * Run the delalloc range from start to end, and write back any dirty pages
+ * covered by the range.
+ */
+static noinline int run_delalloc_cow(struct btrfs_inode *inode,
+				     struct page *locked_page, u64 start,
+				     u64 end, struct writeback_control *wbc,
+				     bool pages_dirty)
 {
 	u64 done_offset = end;
 	int ret;
@@ -1727,9 +1715,8 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 				     &done_offset, CFR_KEEP_LOCKED);
 		if (ret)
 			return ret;
-
 		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
-					  done_offset, wbc, true);
+					  done_offset, wbc, pages_dirty);
 		start = done_offset + 1;
 	}
 
@@ -2295,7 +2282,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		return 1;
 
 	if (zoned)
-		ret = run_delalloc_zoned(inode, locked_page, start, end, wbc);
+		ret = run_delalloc_cow(inode, locked_page, start, end, wbc,
+				       true);
 	else
 		ret = cow_file_range(inode, locked_page, start, end, NULL, 0);
 
-- 
2.39.2

