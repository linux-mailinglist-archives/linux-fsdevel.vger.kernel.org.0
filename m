Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BE212A5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgGBQvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:51:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbgGBQvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593708695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sRvSqiA63kUIbg8TR2a10APphiMEzUJywUYKdk62Smo=;
        b=ff3t1jgrlMLSeoH2sjtO6nlxwpqqbxjli+eEbQ72eRalJEDEq+WBPl38VDc1G2cTdnuyZ6
        ws0pmk8G4TGmpPiG7J1BqcCTFGwVYkPWjtA3/xOCp3/cwEw1nLp0jqAOcVgvWMeY6dGcgz
        UB/HFA/pEuTsVTmYAugKi+SL2blTgjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-SKvVqmjYNAKsXvMS_sg_TQ-1; Thu, 02 Jul 2020 12:51:34 -0400
X-MC-Unique: SKvVqmjYNAKsXvMS_sg_TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 326B813E9C2;
        Thu,  2 Jul 2020 16:51:33 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697C379231;
        Thu,  2 Jul 2020 16:51:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC 4/4] gfs2: Reinstate readahead conversion
Date:   Thu,  2 Jul 2020 18:51:20 +0200
Message-Id: <20200702165120.1469875-5-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-1-agruenba@redhat.com>
References: <20200702165120.1469875-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that the locking order in gfs2 is fixed, switch back to using the
->readahead address space operation.  With that, mpage_readpages is
unused and can be removed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c        | 19 +++++------
 fs/mpage.c            | 75 -------------------------------------------
 include/linux/mpage.h |  2 --
 3 files changed, 10 insertions(+), 86 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 28f097636e78..68cd700a2719 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -541,7 +541,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 }
 
 /**
- * gfs2_readpages - Read a bunch of pages at once
+ * gfs2_readahead - Read a bunch of pages at once
  * @file: The file to read from
  * @mapping: Address space info
  * @pages: List of pages to read
@@ -554,16 +554,17 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
  *    obviously not something we'd want to do on too regular a basis.
  *    Any I/O we ignore at this time will be done via readpage later.
  * 2. We don't handle stuffed files here we let readpage do the honours.
- * 3. mpage_readpages() does most of the heavy lifting in the common case.
+ * 3. mpage_readahead() does most of the heavy lifting in the common case.
  * 4. gfs2_block_map() is relied upon to set BH_Boundary in the right places.
  */
 
-static int gfs2_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *pages, unsigned nr_pages)
+static void gfs2_readahead(struct readahead_control *rac)
 {
-	if (!gfs2_is_stuffed(GFS2_I(mapping->host)))
-		return mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
-	return 0;
+	struct inode *inode = rac->mapping->host;
+	struct gfs2_inode *ip = GFS2_I(inode);
+
+	if (!gfs2_is_stuffed(ip))
+		mpage_readahead(rac, gfs2_block_map);
 }
 
 /**
@@ -782,7 +783,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
-	.readpages = gfs2_readpages,
+	.readahead = gfs2_readahead,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
 	.releasepage = gfs2_releasepage,
@@ -796,7 +797,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
 	.readpage = gfs2_readpage,
-	.readpages = gfs2_readpages,
+	.readahead = gfs2_readahead,
 	.set_page_dirty = jdata_set_page_dirty,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
diff --git a/fs/mpage.c b/fs/mpage.c
index 5243a065a062..830e6cc2a9e7 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -396,81 +396,6 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 }
 EXPORT_SYMBOL(mpage_readahead);
 
-/**
- * mpage_readpages - populate an address space with some pages & start reads against them
- * @mapping: the address_space
- * @pages: The address of a list_head which contains the target pages.  These
- *   pages have their ->index populated and are otherwise uninitialised.
- *   The page at @pages->prev has the lowest file offset, and reads should be
- *   issued in @pages->prev to @pages->next order.
- * @nr_pages: The number of pages at *@pages
- * @get_block: The filesystem's block mapper function.
- *
- * This function walks the pages and the blocks within each page, building and
- * emitting large BIOs.
- *
- * If anything unusual happens, such as:
- *
- * - encountering a page which has buffers
- * - encountering a page which has a non-hole after a hole
- * - encountering a page with non-contiguous blocks
- *
- * then this code just gives up and calls the buffer_head-based read function.
- * It does handle a page which has holes at the end - that is a common case:
- * the end-of-file on blocksize < PAGE_SIZE setups.
- *
- * BH_Boundary explanation:
- *
- * There is a problem.  The mpage read code assembles several pages, gets all
- * their disk mappings, and then submits them all.  That's fine, but obtaining
- * the disk mappings may require I/O.  Reads of indirect blocks, for example.
- *
- * So an mpage read of the first 16 blocks of an ext2 file will cause I/O to be
- * submitted in the following order:
- *
- * 	12 0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16
- *
- * because the indirect block has to be read to get the mappings of blocks
- * 13,14,15,16.  Obviously, this impacts performance.
- *
- * So what we do it to allow the filesystem's get_block() function to set
- * BH_Boundary when it maps block 11.  BH_Boundary says: mapping of the block
- * after this one will require I/O against a block which is probably close to
- * this one.  So you should push what I/O you have currently accumulated.
- *
- * This all causes the disk requests to be issued in the correct order.
- */
-int
-mpage_readpages(struct address_space *mapping, struct list_head *pages,
-				unsigned nr_pages, get_block_t get_block)
-{
-	struct mpage_readpage_args args = {
-		.get_block = get_block,
-		.is_readahead = true,
-	};
-	unsigned page_idx;
-
-	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
-		struct page *page = lru_to_page(pages);
-
-		prefetchw(&page->flags);
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, mapping,
-					page->index,
-					readahead_gfp_mask(mapping))) {
-			args.page = page;
-			args.nr_pages = nr_pages - page_idx;
-			args.bio = do_mpage_readpage(&args);
-		}
-		put_page(page);
-	}
-	BUG_ON(!list_empty(pages));
-	if (args.bio)
-		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
-	return 0;
-}
-EXPORT_SYMBOL(mpage_readpages);
-
 /*
  * This isn't called much at all
  */
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index 181f1b0fbd83..f4f5e90a6844 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -16,8 +16,6 @@ struct writeback_control;
 struct readahead_control;
 
 void mpage_readahead(struct readahead_control *, get_block_t get_block);
-int mpage_readpages(struct address_space *, struct list_head *, unsigned,
-		    get_block_t);
 int mpage_readpage(struct page *page, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
-- 
2.26.2

