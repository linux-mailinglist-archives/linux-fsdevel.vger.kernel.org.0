Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B993125C239
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgICOJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgICOJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEBC06123E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eTwGtgPGcBumRp8Hea4BdT+Mx8Gt3M//B82u6fGGQ6c=; b=rNBaXP6NVLGcexEYZ63yUqlOBo
        XFjzBn5wmiOhufSy4PfLo9QT3AJuR44gzSHBWGRglvScyPGnYK2lJI6zFUbYqgnDh/k7FxLuVmwTB
        xV0q4leRzsTDGZG43UidhdRLPAv8wyWgrNDt6R2I5B2WCvgTw1lTW5cVeGce0VlGtXNiFPDKBxCGh
        /BpV/h4sQ4ONey0o/CY/ynPm7TuCsAz0Na6+evQ3KstXNSNTAWED/yOdU55ORaZsazxOGUksFDWlB
        MbeSlgfogup5l0+VRvzzYA1dEt9xU9b7U+yH0Z8EIwHzMYP2URZQbjQL06sM8jovvAj/jgliNePnn
        gSPO2yTg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv2-0003iE-56; Thu, 03 Sep 2020 14:08:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4/9] mm/readahead: Make do_page_cache_ra take a readahead_control
Date:   Thu,  3 Sep 2020 15:08:39 +0100
Message-Id: <20200903140844.14194-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903140844.14194-1-willy@infradead.org>
References: <20200903140844.14194-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename __do_page_cache_readahead() to do_page_cache_ra() and call it
directly from ondemand_readahead() instead of indirecting via ra_submit().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/internal.h  | 11 +++++------
 mm/readahead.c | 28 +++++++++++++++-------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 10c677655912..6aef85f62b9d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -51,18 +51,17 @@ void unmap_page_range(struct mmu_gather *tlb,
 
 void force_page_cache_readahead(struct address_space *, struct file *,
 		pgoff_t index, unsigned long nr_to_read);
-void __do_page_cache_readahead(struct address_space *, struct file *,
-		pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size);
+void do_page_cache_ra(struct readahead_control *,
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
+	DEFINE_READAHEAD(ractl, file, mapping, ra->start);
+	do_page_cache_ra(&ractl, ra->size, ra->async_size);
 }
 
 /**
diff --git a/mm/readahead.c b/mm/readahead.c
index a444943781bb..577f180d9252 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -241,17 +241,16 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
 
 /*
- * __do_page_cache_readahead() actually reads a chunk of disk.  It allocates
+ * do_page_cache_ra() actually reads a chunk of disk.  It allocates
  * the pages first, then submits them for I/O. This avoids the very bad
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void __do_page_cache_readahead(struct address_space *mapping,
-		struct file *file, pgoff_t index, unsigned long nr_to_read,
-		unsigned long lookahead_size)
+void do_page_cache_ra(struct readahead_control *ractl,
+		unsigned long nr_to_read, unsigned long lookahead_size)
 {
-	DEFINE_READAHEAD(ractl, file, mapping, index);
-	struct inode *inode = mapping->host;
+	struct inode *inode = ractl->mapping->host;
+	unsigned long index = readahead_index(ractl);
 	loff_t isize = i_size_read(inode);
 	pgoff_t end_index;	/* The last page we want to read */
 
@@ -265,7 +264,7 @@ void __do_page_cache_readahead(struct address_space *mapping,
 	if (nr_to_read > end_index - index)
 		nr_to_read = end_index - index + 1;
 
-	page_cache_ra_unbounded(&ractl, nr_to_read, lookahead_size);
+	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
 }
 
 /*
@@ -273,10 +272,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
  * memory at once.
  */
 void force_page_cache_readahead(struct address_space *mapping,
-		struct file *filp, pgoff_t index, unsigned long nr_to_read)
+		struct file *file, pgoff_t index, unsigned long nr_to_read)
 {
+	DEFINE_READAHEAD(ractl, file, mapping, index);
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	struct file_ra_state *ra = &filp->f_ra;
+	struct file_ra_state *ra = &file->f_ra;
 	unsigned long max_pages;
 
 	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
@@ -294,7 +294,7 @@ void force_page_cache_readahead(struct address_space *mapping,
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		__do_page_cache_readahead(mapping, filp, index, this_chunk, 0);
+		do_page_cache_ra(&ractl, this_chunk, 0);
 
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
+	DEFINE_READAHEAD(ractl, file, mapping, index);
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages = ra->ra_pages;
 	unsigned long add_pages;
@@ -516,7 +517,7 @@ static void ondemand_readahead(struct address_space *mapping,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	__do_page_cache_readahead(mapping, filp, index, req_size, 0);
+	do_page_cache_ra(&ractl, req_size, 0);
 	return;
 
 initial_readahead:
@@ -542,7 +543,8 @@ static void ondemand_readahead(struct address_space *mapping,
 		}
 	}
 
-	ra_submit(ra, mapping, filp);
+	ractl._index = ra->start;
+	do_page_cache_ra(&ractl, ra->size, ra->async_size);
 }
 
 /**
-- 
2.28.0

