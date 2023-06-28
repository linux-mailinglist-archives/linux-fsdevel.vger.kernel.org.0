Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9B8741541
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjF1Pdt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjF1PdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:33:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21730D3;
        Wed, 28 Jun 2023 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3Vs6HRFrG4S3aq9C96+j6uLPDbL41Vn9nahZIdhyzu4=; b=E6WNPevrPJqOks5BVluWFc33BF
        1eRE6ZnxBzV/CFDaBVopI0jmhucFqnPb8yGpmqkUac5ae33RVn03YqTkJin5cYq0/qQfNvP88TCp8
        kLlNSnlh1UyIbuGYHSXg7nm30j66a5bZwPyWt4k8r5UOzp7o1oskl4KwAAnbkN0OxZ3VQXs/XHwB+
        Ucky5nYrCLlGt1s8+UAEAmr90AKQBlwNYa5KKJZ80DkRwbRWveqmoEvm5+uQ060rHUurJnvAu8fTX
        Isw1b9cYLKQopAVHTIjgyzlqX6JyQrkC7szjsy+Ti7cD3HKTfBretetxNGawDR3EyA4D9YT0v9RpH
        30op/yIw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEXA7-00G0G9-1l;
        Wed, 28 Jun 2023 15:32:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/23] btrfs: don't redirty locked_page in run_delalloc_zoned
Date:   Wed, 28 Jun 2023 17:31:42 +0200
Message-Id: <20230628153144.22834-22-hch@lst.de>
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

extent_write_locked_range currently expects that either all or no
pages are dirty when it is called.  Bur run_delalloc_zoned is called
directly in the writepages path, and has the dirty bit cleared only
for locked_page and which the extent_write_cache_pages currently
operates.  It currently works around this by redirtying locked_page,
but that is a bit inefficient and cumbersome.  Pass a locked_page
argument to run_delalloc_zoned so that clearing the dirty bit can
be skipped on just that page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c |  7 ++++---
 fs/btrfs/extent_io.h |  5 +++--
 fs/btrfs/inode.c     | 13 ++++---------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e74153c02d84c7..efcac0b56b8252 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2133,8 +2133,9 @@ static int extent_write_cache_pages(struct address_space *mapping,
  * already been ran (aka, ordered extent inserted) and all pages are still
  * locked.
  */
-void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			       struct writeback_control *wbc, bool pages_dirty)
+void extent_write_locked_range(struct inode *inode, struct page *locked_page,
+			       u64 start, u64 end, struct writeback_control *wbc,
+			       bool pages_dirty)
 {
 	bool found_error = false;
 	int ret = 0;
@@ -2161,7 +2162,7 @@ void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
-		if (pages_dirty) {
+		if (pages_dirty && page != locked_page) {
 			ASSERT(PageDirty(page));
 			clear_page_dirty_for_io(page);
 		}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2678906e87c506..c01f9c5ddc13c0 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -177,8 +177,9 @@ int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int btrfs_read_folio(struct file *file, struct folio *folio);
-void extent_write_locked_range(struct inode *inode, u64 start, u64 end,
-			       struct writeback_control *wbc, bool pages_dirty);
+void extent_write_locked_range(struct inode *inode, struct page *locked_page,
+			       u64 start, u64 end, struct writeback_control *wbc,
+			       bool pages_dirty);
 int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2a4b62398ee7a3..ae5166d33253a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1105,7 +1105,8 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 
 	/* All pages will be unlocked, including @locked_page */
 	wbc_attach_fdatawrite_inode(&wbc, &inode->vfs_inode);
-	extent_write_locked_range(&inode->vfs_inode, start, end, &wbc, false);
+	extent_write_locked_range(&inode->vfs_inode, NULL, start, end, &wbc,
+				  false);
 	wbc_detach_inode(&wbc);
 }
 
@@ -1720,7 +1721,6 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 {
 	u64 done_offset = end;
 	int ret;
-	bool locked_page_done = false;
 
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end,
@@ -1728,13 +1728,8 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 		if (ret)
 			return ret;
 
-		if (!locked_page_done) {
-			__set_page_dirty_nobuffers(locked_page);
-			account_page_redirty(locked_page);
-		}
-		locked_page_done = true;
-		extent_write_locked_range(&inode->vfs_inode, start, done_offset,
-					  wbc, true);
+		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
+					  done_offset, wbc, true);
 		start = done_offset + 1;
 	}
 
-- 
2.39.2

