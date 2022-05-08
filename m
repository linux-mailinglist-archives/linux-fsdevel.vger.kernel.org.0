Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77A51F171
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiEHUgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiEHUfg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E95D10EC
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JjSBvqXioFat+k9nej9A9hxsku2dzX1ixwNpMvQ6+/c=; b=ZP9EHBk0huSXJx5jai5i1hNSWX
        6JeUPxzgDjkIMbOP5bllGGa56JtTSUC4dwvmrngcYzQPzJ52znZ3BqUS48T9sFTjOOt5aSEdnt66+
        C20Em8Emm93mRyPpbDH8tEnmplHmIDKF3s7z4IQyaDuBUUN0eJ176qgNq9dUi2P9JwA8+Q5Kl7YpE
        ElCPn+AwUUs7Y+wlGDWRHf2xr5+4ZMaGECHfYP0EeV4GyzdoacGu1MiJlXfhet565UsnUijNCSgVy
        vP2IBM7UZrfu3gjEZrLBp63nnMNizLWYoWSZjzuIg7Ib5LjLaTOCI0BabLVmdNXjFNh1NC7eVdheA
        epH6fR5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ6-002npP-Ex; Sun, 08 May 2022 20:31:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 28/37] ntfs: Convert ntfs to read_folio
Date:   Sun,  8 May 2022 21:31:22 +0100
Message-Id: <20220508203131.667959-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a "weak" conversion which converts straight back to using pages.
A full conversion should be performed at some point, hopefully by
someone familiar with the filesystem.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs/aops.c   | 40 +++++++++++++++++++++-------------------
 fs/ntfs/aops.h   |  6 +++---
 fs/ntfs/attrib.c |  2 +-
 fs/ntfs/file.c   |  4 ++--
 fs/ntfs/inode.c  |  4 ++--
 fs/ntfs/mft.h    |  2 +-
 6 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 90e3dad8ee45..9e3964ea2ea0 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -159,7 +159,7 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
  *
  * Return 0 on success and -errno on error.
  *
- * Contains an adapted version of fs/buffer.c::block_read_full_page().
+ * Contains an adapted version of fs/buffer.c::block_read_full_folio().
  */
 static int ntfs_read_block(struct page *page)
 {
@@ -358,16 +358,16 @@ static int ntfs_read_block(struct page *page)
 }
 
 /**
- * ntfs_readpage - fill a @page of a @file with data from the device
- * @file:	open file to which the page @page belongs or NULL
- * @page:	page cache page to fill with data
+ * ntfs_read_folio - fill a @folio of a @file with data from the device
+ * @file:	open file to which the folio @folio belongs or NULL
+ * @folio:	page cache folio to fill with data
  *
- * For non-resident attributes, ntfs_readpage() fills the @page of the open
- * file @file by calling the ntfs version of the generic block_read_full_page()
+ * For non-resident attributes, ntfs_read_folio() fills the @folio of the open
+ * file @file by calling the ntfs version of the generic block_read_full_folio()
  * function, ntfs_read_block(), which in turn creates and reads in the buffers
- * associated with the page asynchronously.
+ * associated with the folio asynchronously.
  *
- * For resident attributes, OTOH, ntfs_readpage() fills @page by copying the
+ * For resident attributes, OTOH, ntfs_read_folio() fills @folio by copying the
  * data from the mft record (which at this stage is most likely in memory) and
  * fills the remainder with zeroes. Thus, in this case, I/O is synchronous, as
  * even if the mft record is not cached at this point in time, we need to wait
@@ -375,8 +375,9 @@ static int ntfs_read_block(struct page *page)
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	loff_t i_size;
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
@@ -458,7 +459,7 @@ static int ntfs_readpage(struct file *file, struct page *page)
 	}
 	/*
 	 * If a parallel write made the attribute non-resident, drop the mft
-	 * record and retry the readpage.
+	 * record and retry the read_folio.
 	 */
 	if (unlikely(NInoNonResident(ni))) {
 		unmap_mft_record(base_ni);
@@ -637,10 +638,11 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 		if (unlikely((block >= iblock) &&
 				(initialized_size < i_size))) {
 			/*
-			 * If this page is fully outside initialized size, zero
-			 * out all pages between the current initialized size
-			 * and the current page. Just use ntfs_readpage() to do
-			 * the zeroing transparently.
+			 * If this page is fully outside initialized
+			 * size, zero out all pages between the current
+			 * initialized size and the current page. Just
+			 * use ntfs_read_folio() to do the zeroing
+			 * transparently.
 			 */
 			if (block > iblock) {
 				// TODO:
@@ -798,7 +800,7 @@ static int ntfs_write_block(struct page *page, struct writeback_control *wbc)
 	/* For the error case, need to reset bh to the beginning. */
 	bh = head;
 
-	/* Just an optimization, so ->readpage() is not called later. */
+	/* Just an optimization, so ->read_folio() is not called later. */
 	if (unlikely(!PageUptodate(page))) {
 		int uptodate = 1;
 		do {
@@ -1329,7 +1331,7 @@ static int ntfs_write_mst_block(struct page *page,
  * vfs inode dirty code path for the inode the mft record belongs to or via the
  * vm page dirty code path for the page the mft record is in.
  *
- * Based on ntfs_readpage() and fs/buffer.c::block_write_full_page().
+ * Based on ntfs_read_folio() and fs/buffer.c::block_write_full_page().
  *
  * Return 0 on success and -errno on error.
  */
@@ -1651,7 +1653,7 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
  * attributes.
  */
 const struct address_space_operations ntfs_normal_aops = {
-	.readpage	= ntfs_readpage,
+	.read_folio	= ntfs_read_folio,
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,
 	.dirty_folio	= block_dirty_folio,
@@ -1666,7 +1668,7 @@ const struct address_space_operations ntfs_normal_aops = {
  * ntfs_compressed_aops - address space operations for compressed inodes
  */
 const struct address_space_operations ntfs_compressed_aops = {
-	.readpage	= ntfs_readpage,
+	.read_folio	= ntfs_read_folio,
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,
 	.dirty_folio	= block_dirty_folio,
@@ -1681,7 +1683,7 @@ const struct address_space_operations ntfs_compressed_aops = {
  *		   and attributes
  */
 const struct address_space_operations ntfs_mst_aops = {
-	.readpage	= ntfs_readpage,	/* Fill page with data. */
+	.read_folio	= ntfs_read_folio,	/* Fill page with data. */
 #ifdef NTFS_RW
 	.writepage	= ntfs_writepage,	/* Write dirty page to disk. */
 	.dirty_folio	= filemap_dirty_folio,
diff --git a/fs/ntfs/aops.h b/fs/ntfs/aops.h
index f0962d46bd67..934d5f79b9e7 100644
--- a/fs/ntfs/aops.h
+++ b/fs/ntfs/aops.h
@@ -37,9 +37,9 @@ static inline void ntfs_unmap_page(struct page *page)
  * Read a page from the page cache of the address space @mapping at position
  * @index, where @index is in units of PAGE_SIZE, and not in bytes.
  *
- * If the page is not in memory it is loaded from disk first using the readpage
- * method defined in the address space operations of @mapping and the page is
- * added to the page cache of @mapping in the process.
+ * If the page is not in memory it is loaded from disk first using the
+ * read_folio method defined in the address space operations of @mapping
+ * and the page is added to the page cache of @mapping in the process.
  *
  * If the page belongs to an mst protected attribute and it is marked as such
  * in its ntfs inode (NInoMstProtected()) the mst fixups are applied but no
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 2911c04a33e0..4de597a83b88 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1719,7 +1719,7 @@ int ntfs_attr_make_non_resident(ntfs_inode *ni, const u32 data_size)
 		vi->i_blocks = ni->allocated_size >> 9;
 	write_unlock_irqrestore(&ni->size_lock, flags);
 	/*
-	 * This needs to be last since the address space operations ->readpage
+	 * This needs to be last since the address space operations ->read_folio
 	 * and ->writepage can run concurrently with us as they are not
 	 * serialized on i_mutex.  Note, we are not allowed to fail once we flip
 	 * this switch, which is another reason to do this last.
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 2ae25e48a41a..e1392a9b8ceb 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -251,14 +251,14 @@ static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size)
 		 *
 		 * TODO: For sparse pages could optimize this workload by using
 		 * the FsMisc / MiscFs page bit as a "PageIsSparse" bit.  This
-		 * would be set in readpage for sparse pages and here we would
+		 * would be set in read_folio for sparse pages and here we would
 		 * not need to mark dirty any pages which have this bit set.
 		 * The only caveat is that we have to clear the bit everywhere
 		 * where we allocate any clusters that lie in the page or that
 		 * contain the page.
 		 *
 		 * TODO: An even greater optimization would be for us to only
-		 * call readpage() on pages which are not in sparse regions as
+		 * call read_folio() on pages which are not in sparse regions as
 		 * determined from the runlist.  This would greatly reduce the
 		 * number of pages we read and make dirty in the case of sparse
 		 * files.
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index efe0602b4e51..db0f1995aedd 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1832,7 +1832,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 	/* Need this to sanity check attribute list references to $MFT. */
 	vi->i_generation = ni->seq_no = le16_to_cpu(m->sequence_number);
 
-	/* Provides readpage() for map_mft_record(). */
+	/* Provides read_folio() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mst_aops;
 
 	ctx = ntfs_attr_get_search_ctx(ni, m);
@@ -2503,7 +2503,7 @@ int ntfs_truncate(struct inode *vi)
 		 * between the old data_size, i.e. old_size, and the new_size
 		 * has not been zeroed.  Fortunately, we do not need to zero it
 		 * either since on one hand it will either already be zero due
-		 * to both readpage and writepage clearing partial page data
+		 * to both read_folio and writepage clearing partial page data
 		 * beyond i_size in which case there is nothing to do or in the
 		 * case of the file being mmap()ped at the same time, POSIX
 		 * specifies that the behaviour is unspecified thus we do not
diff --git a/fs/ntfs/mft.h b/fs/ntfs/mft.h
index 17bfefc30271..49c001af16ed 100644
--- a/fs/ntfs/mft.h
+++ b/fs/ntfs/mft.h
@@ -79,7 +79,7 @@ extern int write_mft_record_nolock(ntfs_inode *ni, MFT_RECORD *m, int sync);
  * paths and via the page cache write back code paths or between writing
  * neighbouring mft records residing in the same page.
  *
- * Locking the page also serializes us against ->readpage() if the page is not
+ * Locking the page also serializes us against ->read_folio() if the page is not
  * uptodate.
  *
  * On success, clean the mft record and return 0.  On error, leave the mft
-- 
2.34.1

