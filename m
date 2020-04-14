Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5571A811B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406974AbgDNPEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405650AbgDNPCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:02:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81650C08C5F2;
        Tue, 14 Apr 2020 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rMBXZbDYF8tp6nGbl0mbz6hZ/ZqPkO4pir8qA4KqtBk=; b=n9VR2R1RA944jIP+xrBEaKZtyI
        Hwf3Q6zOKZqRC84+ZHXYc0PipvygySH9sVRaGdH52MVayG50xZ1BCg5AOxb+41gLSfJb8hwQMbX5A
        MFautTkAEs+hII5p9TB6W6Y3CyjJah4ZIqJK4AqIFoPv+vjB93aUVGOAkLBDrF7NkwZyXi3GT17Lc
        UxjvtjTfr/FGbYbMd/IZiD47Qy7omD74xF2L/KdCmtgAQIk9BMjrCPYQY9ze87SZmDpGHlXRIhI1x
        JnGpQZy/moadZVL8v8wR+FNej7T6Yj1cmLXwXIXJMXnJk0tVwfobMyGrmN0dUDiKHtbEcr0hujcYd
        WWunU1wQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jON5A-0006PB-Ai; Tue, 14 Apr 2020 15:02:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 17/25] btrfs: Convert from readpages to readahead
Date:   Tue, 14 Apr 2020 08:02:25 -0700
Message-Id: <20200414150233.24495-18-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414150233.24495-1-willy@infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Implement the new readahead method in btrfs using the new
readahead_page_batch() function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 fs/btrfs/extent_io.c | 43 ++++++++++++-------------------------------
 fs/btrfs/extent_io.h |  3 +--
 fs/btrfs/inode.c     | 16 +++++++---------
 3 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39e45b8a5031..fc46adf2f5bf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4367,51 +4367,32 @@ int extent_writepages(struct address_space *mapping,
 	return ret;
 }
 
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
-		     unsigned nr_pages)
+void extent_readahead(struct readahead_control *rac)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
-	int nr = 0;
 	u64 prev_em_start = (u64)-1;
+	int nr;
 
-	while (!list_empty(pages)) {
-		u64 contig_end = 0;
-
-		for (nr = 0; nr < ARRAY_SIZE(pagepool) && !list_empty(pages);) {
-			struct page *page = lru_to_page(pages);
-
-			prefetchw(&page->flags);
-			list_del(&page->lru);
-			if (add_to_page_cache_lru(page, mapping, page->index,
-						readahead_gfp_mask(mapping))) {
-				put_page(page);
-				break;
-			}
-
-			pagepool[nr++] = page;
-			contig_end = page_offset(page) + PAGE_SIZE - 1;
-		}
-
-		if (nr) {
-			u64 contig_start = page_offset(pagepool[0]);
+	while ((nr = readahead_page_batch(rac, pagepool))) {
+		u64 contig_start = page_offset(pagepool[0]);
+		u64 contig_end = page_offset(pagepool[nr - 1]) + PAGE_SIZE - 1;
 
-			ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
+		ASSERT(contig_start + nr * PAGE_SIZE - 1 == contig_end);
 
-			contiguous_readpages(pagepool, nr, contig_start,
-				     contig_end, &em_cached, &bio, &bio_flags,
-				     &prev_em_start);
-		}
+		contiguous_readpages(pagepool, nr, contig_start, contig_end,
+				&em_cached, &bio, &bio_flags, &prev_em_start);
 	}
 
 	if (em_cached)
 		free_extent_map(em_cached);
 
-	if (bio)
-		return submit_one_bio(bio, 0, bio_flags);
-	return 0;
+	if (bio) {
+		if (submit_one_bio(bio, 0, bio_flags))
+			return;
+	}
 }
 
 /*
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2ed65bd0760e..25594e09fdcd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -198,8 +198,7 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc);
 int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
-int extent_readpages(struct address_space *mapping, struct list_head *pages,
-		     unsigned nr_pages);
+void extent_readahead(struct readahead_control *rac);
 int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
 void set_page_extent_mapped(struct page *page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 320d1062068d..ba0aa8b4ad09 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4856,8 +4856,8 @@ static void evict_inode_truncate_pages(struct inode *inode)
 
 	/*
 	 * Keep looping until we have no more ranges in the io tree.
-	 * We can have ongoing bios started by readpages (called from readahead)
-	 * that have their endio callback (extent_io.c:end_bio_extent_readpage)
+	 * We can have ongoing bios started by readahead that have
+	 * their endio callback (extent_io.c:end_bio_extent_readpage)
 	 * still in progress (unlocked the pages in the bio but did not yet
 	 * unlocked the ranges in the io tree). Therefore this means some
 	 * ranges can still be locked and eviction started because before
@@ -7050,11 +7050,11 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
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
@@ -8293,11 +8293,9 @@ static int btrfs_writepages(struct address_space *mapping,
 	return extent_writepages(mapping, wbc);
 }
 
-static int
-btrfs_readpages(struct file *file, struct address_space *mapping,
-		struct list_head *pages, unsigned nr_pages)
+static void btrfs_readahead(struct readahead_control *rac)
 {
-	return extent_readpages(mapping, pages, nr_pages);
+	extent_readahead(rac);
 }
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
@@ -10553,7 +10551,7 @@ static const struct address_space_operations btrfs_aops = {
 	.readpage	= btrfs_readpage,
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
-	.readpages	= btrfs_readpages,
+	.readahead	= btrfs_readahead,
 	.direct_IO	= btrfs_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
-- 
2.25.1

