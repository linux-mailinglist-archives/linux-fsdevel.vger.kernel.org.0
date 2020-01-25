Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC701492AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbgAYBf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:35:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgAYBfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HHnoA5dlhyhneD6+Obykceh6U0fhtgzOm0Z80uarkuw=; b=F+6jSwd5w3xYt/eqTfmrV4G1O5
        n1Hp/wxUv5nlFPpKyBIJ7sAWu5aSuYikwpOTQBYk38RZGa+NPovOEXyenAMkxLMlJETHfJPr7GaQ8
        nGwH0CEKtEZ/zB82686JHeybpxdixbocJIKONd5GBoIL5dWemPivB3fFz6onPtGGrSYT3mI2K570J
        HspG26VYHDwRFNXMP6ZohqOmpwjoQmA3xKnSQFLzFFCIwNHzq5EfgBIspMZNuy/MQL6Noz3vYUSM1
        H1sJkK/f3tiDZJCl01yXtZftlJ+oRv/qPuRXc2Vq8a3BF388m516PTRwxfdsf+fiObg3f9HUwX3p9
        lF81g+Ew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006Va-CG; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 06/12] btrfs: Convert from readpages to readahead
Date:   Fri, 24 Jan 2020 17:35:47 -0800
Message-Id: <20200125013553.24899-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in btrfs

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: linux-btrfs@vger.kernel.org
---
 fs/btrfs/extent_io.c | 15 ++++-----------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 18 +++++++++---------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f4802f405a2..b1e2acbec165 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4283,7 +4283,7 @@ int extent_writepages(struct address_space *mapping,
 	return ret;
 }
 
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
 		     unsigned nr_pages)
 {
 	struct bio *bio = NULL;
@@ -4294,20 +4294,13 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 	int nr = 0;
 	u64 prev_em_start = (u64)-1;
 
-	while (!list_empty(pages)) {
+	while (nr_pages) {
 		u64 contig_end = 0;
 
-		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
-			struct page *page = lru_to_page(pages);
+		for (nr = 0; nr < ARRAY_SIZE(pagepool) && nr_pages--;) {
+			struct page *page = readahead_page(mapping, start++);
 
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-						readahead_gfp_mask(mapping))) {
-				put_page(page);
-				break;
-			}
-
 			pagepool[nr++] = page;
 			contig_end = page_offset(page) + PAGE_SIZE - 1;
 		}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a8551a1f56e2..d0f154766a02 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -200,7 +200,7 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
 		     unsigned nr_pages);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c70baafb2a39..4f223b4f7dff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5395,8 +5395,8 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 	/*
 	 * Keep looping until we have no more ranges in the io tree.
-	 * We can have ongoing bios started by readpages (called from readahead)
-	 * that have their endio callback (extent_io.c:end_bio_extent_readpage)
+	 * We can have ongoing bios started by readahead that have
+	 * their endio callback (extent_io.c:end_bio_extent_readpage)
 	 * still in progress (unlocked the pages in the bio but did not yet
 	 * unlocked the ranges in the io tree). Therefore this means some
 	 * ranges can still be locked and eviction started because before
@@ -7586,11 +7586,11 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 			 * for it to complete) and then invalidate the pages for
 			 * this range (through invalidate_inode_pages2_range()),
 			 * but that can lead us to a deadlock with a concurrent
-			 * call to readpages() (a buffered read or a defrag call
+			 * call to readahead (a buffered read or a defrag call
 			 * triggered a readahead) on a page lock due to an
 			 * ordered dio extent we created before but did not have
 			 * yet a corresponding bio submitted (whence it can not
-			 * complete), which makes readpages() wait for that
+			 * complete), which makes readahead wait for that
 			 * ordered extent to complete while holding a lock on
 			 * that page.
 			 */
@@ -8829,11 +8829,11 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
-static int
-btrfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static unsigned
+btrfs_readahead(struct file *file, struct address_space *mapping,
+		pgoff_t start, unsigned nr_pages)
 {
-	return extent_readpages(mapping, pages, nr_pages);
+	return extent_readahead(mapping, start, nr_pages);
 }
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
@@ -11045,7 +11045,7 @@ static const struct address_space_operations btrfs_aops = {
 	.readpage	= btrfs_readpage,
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
-	.readpages	= btrfs_readpages,
+	.readahead	= btrfs_readahead,
 	.direct_IO	= btrfs_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
-- 
2.24.1

