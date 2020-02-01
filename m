Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2DC14F859
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgBAPMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51870 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgBAPMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AsVOh91gi/2Ld/EfqBNlMyY/ZrCMfPz2+/lz/gfCdpw=; b=MBrxoQXtUvy8vWHQ3XAweprjhV
        tiYtG3J6A6nnhKyc9Z+LC9yr/9LTS1M7W6UuRWcP250YINSxrdnppzWLvnS64GmblAIYmr3GHoyKa
        cS18kXvn2dq8Dn6ZmNxSay0CVSfYAo/NuwsUzkOjNpGhYPQT6+6C2OXa01PFnp8WeEce/ndx837Sq
        w2JmNkZLCnnhvzVhe3bU9W0seTvgZ+OenrncJ1GqCYhvFSYxnmo4HviXXgV86zMKgL83odgIKwARF
        mCSyXZrK7AHtA57CwUWvEpo7xmwlfy43RwcqC0Z9HOWSQBDprLMpEWDd6qYm2ceJmXSgpHGeSELp+
        lFE1U3Zg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006Hb-8R; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH v4 06/12] btrfs: Convert from readpages to readahead
Date:   Sat,  1 Feb 2020 07:12:34 -0800
Message-Id: <20200201151240.24082-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201151240.24082-1-willy@infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
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
 fs/btrfs/extent_io.c | 19 +++++++------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     | 18 +++++++++---------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e2d30287e2d5..18b1fbfdcab2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4269,7 +4269,7 @@ int extent_writepages(struct address_space *mapping,
 	return ret;
 }
 
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
 		     unsigned nr_pages)
 {
 	struct bio *bio = NULL;
@@ -4280,22 +4280,17 @@ int extent_readpages(struct address_space *mapping, struct list_head *pages,
 	int nr = 0;
 	u64 prev_em_start = (u64)-1;
 
-	while (!list_empty(pages)) {
+	while (nr_pages) {
 		u64 contig_end = 0;
 
-		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
-			struct page *page = lru_to_page(pages);
+		for (nr = 0; nr < ARRAY_SIZE(pagepool); nr++) {
+			struct page *page = readahead_page(mapping, start++);
 
 			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-						readahead_gfp_mask(mapping))) {
-				put_page(page);
-				break;
-			}
-
-			pagepool[nr++] = page;
+			pagepool[nr] = page;
 			contig_end = page_offset(page) + PAGE_SIZE - 1;
+			if (--nr_pages == 0)
+				break;
 		}
 
 		if (nr) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5d205bbaafdc..4fd9dc05592b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -198,7 +198,7 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
+unsigned extent_readahead(struct address_space *mapping, pgoff_t start,
 		     unsigned nr_pages);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d2bb58d277a..7622918d7624 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4723,8 +4723,8 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 	/*
 	 * Keep looping until we have no more ranges in the io tree.
-	 * We can have ongoing bios started by readpages (called from readahead)
-	 * that have their endio callback (extent_io.c:end_bio_extent_readpage)
+	 * We can have ongoing bios started by readahead that have
+	 * their endio callback (extent_io.c:end_bio_extent_readpage)
 	 * still in progress (unlocked the pages in the bio but did not yet
 	 * unlocked the ranges in the io tree). Therefore this means some
 	 * ranges can still be locked and eviction started because before
@@ -6925,11 +6925,11 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
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
@@ -8168,11 +8168,11 @@ static int btrfs_writepages(struct address_space *mapping,
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
@@ -10377,7 +10377,7 @@ static const struct address_space_operations btrfs_aops = {
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

