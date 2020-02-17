Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32C7161A56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgBQSqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:46:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730047AbgBQSqe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DP26YoHmQVKFeLAP9Bhl6lTFH6pmN1Lp+nkcg7gbG1k=; b=ED0OnjLTGnEOOo2CZefh2G88KH
        3jrEzs4VHYd1wXeUpU6HsfbK77yiq/5cy+zhME6scGgUb7JxdN+7S2/GOG2Z/qiKlQ9PPNooPIlDL
        OybRjdLpztJcOs3levap4q/E2MTBAw6qzkCsJmjdII63L2Pli1xrIi6t1XVfm74+zw3q/HKqpqI92
        ku/YMLp3rt2u0Ir0YBDD5xB8VqqHbl17yEZkNT0jKFY8WYkS3lRvPHPHpHSy5cUS26ajALVTZAmnr
        JlLOA3WaW8WbFQ9Nk1AytNed39mHzG9AvcRmp2ibIg6GFMUg+LpBV8EZtkxY4LD7oQACkug45a17s
        61imUM/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-00058e-AJ; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 01/19] mm: Return void from various readahead functions
Date:   Mon, 17 Feb 2020 10:45:42 -0800
Message-Id: <20200217184613.19668-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

ondemand_readahead has two callers, neither of which use the return value.
That means that both ra_submit and __do_page_cache_readahead() can return
void, and we don't need to worry that a present page in the readahead
window causes us to return a smaller nr_pages than we ought to have.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  |  8 ++++----
 mm/readahead.c | 24 ++++++++++--------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3cf20ab3ca01..f779f058118b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,18 +49,18 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
+extern void __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size);
 
 /*
  * Submit IO for the read-ahead request in file_ra_state.
  */
-static inline unsigned long ra_submit(struct file_ra_state *ra,
+static inline void ra_submit(struct file_ra_state *ra,
 		struct address_space *mapping, struct file *filp)
 {
-	return __do_page_cache_readahead(mapping, filp,
-					ra->start, ra->size, ra->async_size);
+	__do_page_cache_readahead(mapping, filp,
+			ra->start, ra->size, ra->async_size);
 }
 
 /*
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..8ce46d69e6ae 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -149,10 +149,8 @@ static int read_pages(struct address_space *mapping, struct file *filp,
  * the pages first, then submits them for I/O. This avoids the very bad
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
- *
- * Returns the number of pages requested, or the maximum amount of I/O allowed.
  */
-unsigned int __do_page_cache_readahead(struct address_space *mapping,
+void __do_page_cache_readahead(struct address_space *mapping,
 		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
 		unsigned long lookahead_size)
 {
@@ -166,7 +164,7 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 	gfp_t gfp_mask = readahead_gfp_mask(mapping);
 
 	if (isize == 0)
-		goto out;
+		return;
 
 	end_index = ((isize - 1) >> PAGE_SHIFT);
 
@@ -211,8 +209,6 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_pages)
 		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
 	BUG_ON(!list_empty(&page_pool));
-out:
-	return nr_pages;
 }
 
 /*
@@ -378,11 +374,10 @@ static int try_context_readahead(struct address_space *mapping,
 /*
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
-static unsigned long
-ondemand_readahead(struct address_space *mapping,
-		   struct file_ra_state *ra, struct file *filp,
-		   bool hit_readahead_marker, pgoff_t offset,
-		   unsigned long req_size)
+static void ondemand_readahead(struct address_space *mapping,
+		struct file_ra_state *ra, struct file *filp,
+		bool hit_readahead_marker, pgoff_t offset,
+		unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
@@ -428,7 +423,7 @@ ondemand_readahead(struct address_space *mapping,
 		rcu_read_unlock();
 
 		if (!start || start - offset > max_pages)
-			return 0;
+			return;
 
 		ra->start = start;
 		ra->size = start - offset;	/* old async_size */
@@ -464,7 +459,8 @@ ondemand_readahead(struct address_space *mapping,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	return __do_page_cache_readahead(mapping, filp, offset, req_size, 0);
+	__do_page_cache_readahead(mapping, filp, offset, req_size, 0);
+	return;
 
 initial_readahead:
 	ra->start = offset;
@@ -489,7 +485,7 @@ ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	return ra_submit(ra, mapping, filp);
+	ra_submit(ra, mapping, filp);
 }
 
 /**
-- 
2.25.0

