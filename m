Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E921E7322
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbgE2DAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407349AbgE2C6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584EC00863B;
        Thu, 28 May 2020 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M+eQSJey4Mh4zmyhEKeFE7KAM2hn8YJnV8YuFTICd0o=; b=kLWS9gE4FOQqLAVSjJigpdmElO
        CRN5Mlc5wkroZ/IbUmGSZbSjFMywLDQgO93CmxrtG8bSDTc92uqYqadZC1J5HUVCfh9US0KJayTJd
        jU23Rcgc+/RXCfCbcYDLPN86u8V816TtGbz2ww+U+i74a29ODGKLxYpeQJpZBduf+eA+h+bVP0EA0
        dcPVcH9CMDQME8hD+FosMEIPyqL74JWmVPaHDHdxPKhPjg/B/xnYNRaskBHjzEcEGm3bosM4JfOSN
        3dPs2yIhYF6avd1z0k2Z1IUXzQqixEGcU9Mg/3QU7/4Q+nS8hXcNXsL2TBexeKMXS/delg0F+l3Zr
        Pnt2b7Xg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Tr-Vm; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 36/39] mm: Make __do_page_cache_readahead take a readahead_control
Date:   Thu, 28 May 2020 19:58:21 -0700
Message-Id: <20200529025824.32296-37-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
index 3090e22b984d..1cf8de5c66ff 100644
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

