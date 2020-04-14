Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC61A8280
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438652AbgDNPVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405589AbgDNPCj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:02:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC4C061A0E;
        Tue, 14 Apr 2020 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vyElWKU1zfCiLUTPH8gs8z9Mck1LnRKWxy/aI6BlYH8=; b=q470B9tgV2J9uf4Ht34DKyaYey
        gND9aWN1jMIz8qi0LIvC5dgb3ywaqARw6r6WTS3RA0ESPGGnu/a0JGPGaI1QyiYlEjl6wK9ldPMvW
        S+qMR/ErV7s1Dvwcu2OxBpFASLTlhmOEDr4vH6rzM1wn6ZC/soGwkU41sHib018BXBxVdyUcBrAqb
        gXGx9LG8wHRlVW+F+KihhQPwYljRHquEodSd3jGc5WBmNlOr1uDNZX/OkCwwzQJ1MN174v80xQmZO
        15WuH4ExvCLpQyZ7Z+zil0vwnhfE/F4PdbNC8b/ohMMjxrA3XTgIk6/VwdLNUuOFK6zOyy0/u4Npm
        5E9PwWUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jON59-0006Nz-Ou; Tue, 14 Apr 2020 15:02:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 02/25] mm: Return void from various readahead functions
Date:   Tue, 14 Apr 2020 08:02:10 -0700
Message-Id: <20200414150233.24495-3-willy@infradead.org>
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

ondemand_readahead has two callers, neither of which use the return value.
That means that both ra_submit and __do_page_cache_readahead() can return
void, and we don't need to worry that a present page in the readahead
window causes us to return a smaller nr_pages than we ought to have.

Similarly, no caller uses the return value from force_page_cache_readahead().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 mm/fadvise.c   |  4 ----
 mm/internal.h  | 12 ++++++------
 mm/readahead.c | 31 +++++++++++++------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/mm/fadvise.c b/mm/fadvise.c
index 3efebfb9952c..0e66f2aaeea3 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -104,10 +104,6 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		if (!nrpages)
 			nrpages = ~0UL;
 
-		/*
-		 * Ignore return value because fadvise() shall return
-		 * success even if filesystem can't retrieve a hint,
-		 */
 		force_page_cache_readahead(mapping, file, start_index, nrpages);
 		break;
 	case POSIX_FADV_NOREUSE:
diff --git a/mm/internal.h b/mm/internal.h
index 25fee17c7334..f762a34b0c57 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,20 +49,20 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-int force_page_cache_readahead(struct address_space *, struct file *,
+void force_page_cache_readahead(struct address_space *, struct file *,
 		pgoff_t index, unsigned long nr_to_read);
-extern unsigned int __do_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t offset, unsigned long nr_to_read,
+void __do_page_cache_readahead(struct address_space *, struct file *,
+		pgoff_t index, unsigned long nr_to_read,
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
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index 2fe72cd29b47..41a592886da7 100644
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
 
@@ -211,23 +209,21 @@ unsigned int __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_pages)
 		read_pages(mapping, filp, &page_pool, nr_pages, gfp_mask);
 	BUG_ON(!list_empty(&page_pool));
-out:
-	return nr_pages;
 }
 
 /*
  * Chunk the readahead into 2 megabyte units, so that we don't pin too much
  * memory at once.
  */
-int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			       pgoff_t offset, unsigned long nr_to_read)
+void force_page_cache_readahead(struct address_space *mapping,
+		struct file *filp, pgoff_t offset, unsigned long nr_to_read)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	struct file_ra_state *ra = &filp->f_ra;
 	unsigned long max_pages;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages))
-		return -EINVAL;
+		return;
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -245,7 +241,6 @@ int force_page_cache_readahead(struct address_space *mapping, struct file *filp,
 		offset += this_chunk;
 		nr_to_read -= this_chunk;
 	}
-	return 0;
 }
 
 /*
@@ -378,11 +373,10 @@ static int try_context_readahead(struct address_space *mapping,
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
@@ -428,7 +422,7 @@ ondemand_readahead(struct address_space *mapping,
 		rcu_read_unlock();
 
 		if (!start || start - offset > max_pages)
-			return 0;
+			return;
 
 		ra->start = start;
 		ra->size = start - offset;	/* old async_size */
@@ -464,7 +458,8 @@ ondemand_readahead(struct address_space *mapping,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	return __do_page_cache_readahead(mapping, filp, offset, req_size, 0);
+	__do_page_cache_readahead(mapping, filp, offset, req_size, 0);
+	return;
 
 initial_readahead:
 	ra->start = offset;
@@ -489,7 +484,7 @@ ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	return ra_submit(ra, mapping, filp);
+	ra_submit(ra, mapping, filp);
 }
 
 /**
-- 
2.25.1

