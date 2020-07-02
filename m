Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15C212A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jul 2020 18:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGBQvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jul 2020 12:51:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726941AbgGBQvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593708693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGS7zmuOCpOiRp7/K1lHThQp3FMTr/Ps3bbcjzSZ3xc=;
        b=PYPm+A7ulCIxP+PqFGrmqvTbaj9PORSNq1XKrqCs0f0BXATNP3+8tfvTbvu5EHURyfoeW7
        LwsBhjRPt7UYNHFrWvkFY7WlHi9hrMajxPlqnCaZoWhgSCCJTVeP6hqq/biZpGZrCzx/iO
        kAPgiWUOfrYyfzmNrm3/mS2R0onlNdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-kTjKHIsVP9KWCXN-TygWfA-1; Thu, 02 Jul 2020 12:51:28 -0400
X-MC-Unique: kTjKHIsVP9KWCXN-TygWfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B61EB8018AB;
        Thu,  2 Jul 2020 16:51:26 +0000 (UTC)
Received: from max.home.com (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F02EB79231;
        Thu,  2 Jul 2020 16:51:24 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC 1/4] gfs2: Revert readahead conversion
Date:   Thu,  2 Jul 2020 18:51:17 +0200
Message-Id: <20200702165120.1469875-2-agruenba@redhat.com>
In-Reply-To: <20200702165120.1469875-1-agruenba@redhat.com>
References: <20200702165120.1469875-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit d4388340ae0b ("fs: convert mpage_readpages to mpage_readahead")
converted gfs2 and other filesystems from the ->readpages to the
->readahead address space operation.  Other than ->readpages,
->readahead is passed the pages to readahead locked.  Due to problems in
the current page locking strategy, this is now causing deadlocks in
gfs2.

Fix this by reinstating mpage_readpages from before commit d4388340ae0b
and by converting gfs2 back to ->readpages.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c        | 23 ++++++++-----
 fs/mpage.c            | 75 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mpage.h |  2 ++
 3 files changed, 92 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 72c9560f4467..786c1ce8f030 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -577,7 +577,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 }
 
 /**
- * gfs2_readahead - Read a bunch of pages at once
+ * gfs2_readpages - Read a bunch of pages at once
  * @file: The file to read from
  * @mapping: Address space info
  * @pages: List of pages to read
@@ -590,24 +590,31 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
  *    obviously not something we'd want to do on too regular a basis.
  *    Any I/O we ignore at this time will be done via readpage later.
  * 2. We don't handle stuffed files here we let readpage do the honours.
- * 3. mpage_readahead() does most of the heavy lifting in the common case.
+ * 3. mpage_readpages() does most of the heavy lifting in the common case.
  * 4. gfs2_block_map() is relied upon to set BH_Boundary in the right places.
  */
 
-static void gfs2_readahead(struct readahead_control *rac)
+static int gfs2_readpages(struct file *file, struct address_space *mapping,
+			  struct list_head *pages, unsigned nr_pages)
 {
-	struct inode *inode = rac->mapping->host;
+	struct inode *inode = mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder gh;
+	int ret;
 
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-	if (gfs2_glock_nq(&gh))
+	ret = gfs2_glock_nq(&gh);
+	if (unlikely(ret))
 		goto out_uninit;
 	if (!gfs2_is_stuffed(ip))
-		mpage_readahead(rac, gfs2_block_map);
+		ret = mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
 	gfs2_glock_dq(&gh);
 out_uninit:
 	gfs2_holder_uninit(&gh);
+	if (unlikely(gfs2_withdrawn(sdp)))
+		ret = -EIO;
+	return ret;
 }
 
 /**
@@ -826,7 +833,7 @@ static const struct address_space_operations gfs2_aops = {
 	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
 	.readpage = gfs2_readpage,
-	.readahead = gfs2_readahead,
+	.readpages = gfs2_readpages,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
 	.releasepage = gfs2_releasepage,
@@ -840,7 +847,7 @@ static const struct address_space_operations gfs2_jdata_aops = {
 	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
 	.readpage = gfs2_readpage,
-	.readahead = gfs2_readahead,
+	.readpages = gfs2_readpages,
 	.set_page_dirty = jdata_set_page_dirty,
 	.bmap = gfs2_bmap,
 	.invalidatepage = gfs2_invalidatepage,
diff --git a/fs/mpage.c b/fs/mpage.c
index 830e6cc2a9e7..5243a065a062 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -396,6 +396,81 @@ void mpage_readahead(struct readahead_control *rac, get_block_t get_block)
 }
 EXPORT_SYMBOL(mpage_readahead);
 
+/**
+ * mpage_readpages - populate an address space with some pages & start reads against them
+ * @mapping: the address_space
+ * @pages: The address of a list_head which contains the target pages.  These
+ *   pages have their ->index populated and are otherwise uninitialised.
+ *   The page at @pages->prev has the lowest file offset, and reads should be
+ *   issued in @pages->prev to @pages->next order.
+ * @nr_pages: The number of pages at *@pages
+ * @get_block: The filesystem's block mapper function.
+ *
+ * This function walks the pages and the blocks within each page, building and
+ * emitting large BIOs.
+ *
+ * If anything unusual happens, such as:
+ *
+ * - encountering a page which has buffers
+ * - encountering a page which has a non-hole after a hole
+ * - encountering a page with non-contiguous blocks
+ *
+ * then this code just gives up and calls the buffer_head-based read function.
+ * It does handle a page which has holes at the end - that is a common case:
+ * the end-of-file on blocksize < PAGE_SIZE setups.
+ *
+ * BH_Boundary explanation:
+ *
+ * There is a problem.  The mpage read code assembles several pages, gets all
+ * their disk mappings, and then submits them all.  That's fine, but obtaining
+ * the disk mappings may require I/O.  Reads of indirect blocks, for example.
+ *
+ * So an mpage read of the first 16 blocks of an ext2 file will cause I/O to be
+ * submitted in the following order:
+ *
+ * 	12 0 1 2 3 4 5 6 7 8 9 10 11 13 14 15 16
+ *
+ * because the indirect block has to be read to get the mappings of blocks
+ * 13,14,15,16.  Obviously, this impacts performance.
+ *
+ * So what we do it to allow the filesystem's get_block() function to set
+ * BH_Boundary when it maps block 11.  BH_Boundary says: mapping of the block
+ * after this one will require I/O against a block which is probably close to
+ * this one.  So you should push what I/O you have currently accumulated.
+ *
+ * This all causes the disk requests to be issued in the correct order.
+ */
+int
+mpage_readpages(struct address_space *mapping, struct list_head *pages,
+				unsigned nr_pages, get_block_t get_block)
+{
+	struct mpage_readpage_args args = {
+		.get_block = get_block,
+		.is_readahead = true,
+	};
+	unsigned page_idx;
+
+	for (page_idx = 0; page_idx < nr_pages; page_idx++) {
+		struct page *page = lru_to_page(pages);
+
+		prefetchw(&page->flags);
+		list_del(&page->lru);
+		if (!add_to_page_cache_lru(page, mapping,
+					page->index,
+					readahead_gfp_mask(mapping))) {
+			args.page = page;
+			args.nr_pages = nr_pages - page_idx;
+			args.bio = do_mpage_readpage(&args);
+		}
+		put_page(page);
+	}
+	BUG_ON(!list_empty(pages));
+	if (args.bio)
+		mpage_bio_submit(REQ_OP_READ, REQ_RAHEAD, args.bio);
+	return 0;
+}
+EXPORT_SYMBOL(mpage_readpages);
+
 /*
  * This isn't called much at all
  */
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index f4f5e90a6844..181f1b0fbd83 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -16,6 +16,8 @@ struct writeback_control;
 struct readahead_control;
 
 void mpage_readahead(struct readahead_control *, get_block_t get_block);
+int mpage_readpages(struct address_space *, struct list_head *, unsigned,
+		    get_block_t);
 int mpage_readpage(struct page *page, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
-- 
2.26.2

