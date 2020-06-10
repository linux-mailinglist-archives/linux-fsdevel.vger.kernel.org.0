Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4E1F5C9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgFJUOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730593AbgFJUNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78FC0085C5;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=S8iTV89UZwBhFOKRSSgrXr6LwEGxyfVVQ8jpCAk+4T4=; b=tA0NucqILgtgEHPhR0QOz7pyrc
        zugbZGH0I3XvQq+j0ODT3muFUniByXxVfJLSRxJcvPAMz9m2bjaC/fRN1tNNET95jJMN4l1Jo6EbP
        zDUoM8IVmQhJ8A3sy7ZpcUR6deIKOxefOhQ6r6hr9fab4ulNboCcNY90y3WTGBHhF8yT1c5mKx2wo
        ZWpq0/whGdf/om/F+WMT5eITvlH4eqHcFu68r/6G+X+zyCg67O1AotBhoPTsfDvXb5DQ8N+4E+WvV
        skfW41Kd0LZiexsBMp+ievdcW71GYsTQb2ECzNtxJdb89Jp2D9OxUS9sz65vQx8W9g1uqSkE/i+Yv
        c6gTmipg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003YF-8X; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 48/51] mm: Make __do_page_cache_readahead take a readahead_control
Date:   Wed, 10 Jun 2020 13:13:42 -0700
Message-Id: <20200610201345.13273-49-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Also call __do_page_cache_readahead() directly from ondemand_readahead()
instead of indirecting via ra_submit().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 11 +++++------
 mm/readahead.c | 26 ++++++++++++++------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cd7038a36354..63c493f892e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -51,18 +51,17 @@ void unmap_page_range(struct mmu_gather *tlb,
 
 void force_page_cache_readahead(struct address_space *, struct file *,
 		pgoff_t index, unsigned long nr_to_read);
-void __do_page_cache_readahead(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size);
+void __do_page_cache_readahead(struct readahead_control *,
+		unsigned long nr_to_read, unsigned long lookahead_size);
 
 /*
  * Submit IO for the read-ahead request in file_ra_state.
  */
 static inline void ra_submit(struct file_ra_state *ra,
-		struct address_space *mapping, struct file *filp)
+		struct address_space *mapping, struct file *file)
 {
-	__do_page_cache_readahead(mapping, filp,
-			ra->start, ra->size, ra->async_size);
+	DEFINE_READAHEAD(rac, file, mapping, ra->start);
+	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
 }
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index 62da2d4beed1..74c7e1eff540 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -246,12 +246,11 @@ EXPORT_SYMBOL_GPL(page_cache_readahead_unbounded);
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+void __do_page_cache_readahead(struct readahead_control *rac,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
-	DEFINE_READAHEAD(rac, file, mapping, index);
-	struct inode *inode = mapping->host;
+	struct inode *inode = rac->mapping->host;
+	unsigned long index = readahead_index(rac);
 	loff_t isize = i_size_read(inode);
 	pgoff_t end_index;	/* The last page we want to read */
 
@@ -265,7 +264,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
 
-	page_cache_readahead_unbounded(&rac, nr_to_read, lookahead_size);
+	page_cache_readahead_unbounded(rac, nr_to_read, lookahead_size);
 }
 
 /*
@@ -273,10 +272,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
  * memory at once.
  */
 void force_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t index, unsigned long nr_to_read)
+		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &filp->f_ra;
+	struct file_ra_state *ra = &file->f_ra;
 	unsigned long max_pages;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
@@ -294,7 +294,7 @@ void force_page_cache_readahead(struct address_space *mapping,
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		__do_page_cache_readahead(mapping, filp, index, this_chunk, 0);
+		__do_page_cache_readahead(&rac, this_chunk, 0);
 
 		index += this_chunk;
 		nr_to_read -= this_chunk;
@@ -432,10 +432,11 @@ static int try_context_readahead(struct address_space *mapping,
  * A minimal readahead algorithm for trivial sequential/random reads.
  */
 static void ondemand_readahead(struct address_space *mapping,
-		struct file_ra_state *ra, struct file *filp,
+		struct file_ra_state *ra, struct file *file,
 		bool hit_readahead_marker, pgoff_t index,
 		unsigned long req_size)
 {
+	DEFINE_READAHEAD(rac, file, mapping, index);
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
@@ -516,7 +517,7 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	__do_page_cache_readahead(mapping, filp, index, req_size, 0);
+	__do_page_cache_readahead(&rac, req_size, 0);
 	return;
 
 initial_readahead:
@@ -542,7 +543,8 @@ static void ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	ra_submit(ra, mapping, filp);
+	rac._index = ra->start;
+	__do_page_cache_readahead(&rac, ra->size, ra->async_size);
 }
 
 /**
-- 
2.26.2

