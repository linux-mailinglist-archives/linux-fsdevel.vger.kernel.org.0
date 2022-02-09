Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAE54AFE3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiBIUWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiBIUWY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43578E03A553
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n4pyzT9zKmGRMsJAQPJ+oXmajTysTT1D0klOEo41H1I=; b=Y8DtDcBjUhZCXNSSngzf5vqOq7
        1JVWv4P7bfBYZQhsMX/fimaOxJQi4Ly6Tf4UBZGyXYnwCeKPvYN0/q4eZfhb3DSsnUTZAWmQlZv+1
        rbNogAZjFz4KkLfZd3vfpSZurKHM5gzg3YCKssero12RsOuBdmUzUcObOVkRuTVlvYXAAiupaR7p0
        HOxaLRcdkPMHyv6XJcipY5bYvSRzP9te4pPyZBstAmqLatsQgZ4ty8+qZJe67H634ZP+t9ey9PJBm
        CY9yhQdXVBBE24IkjinfxAAhVD1AH+1shp/VBmO3+kgtAbX+5SMP1ca8ypc1+GlgSX0nOHMlGht+V
        pUQRNWgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTr-008cpQ-Ez; Wed, 09 Feb 2022 20:22:23 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 08/56] fs: Convert is_partially_uptodate to folios
Date:   Wed,  9 Feb 2022 20:21:27 +0000
Message-Id: <20220209202215.2055748-9-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
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

Since the uptodate property is maintained on a per-folio basis, the
is_partially_uptodate method should also take a folio.  Fix the types
at the same time so it's clear that it returns true/false and takes
the count in bytes, not blocks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     | 10 ++++----
 fs/buffer.c                           | 26 +++++++++----------
 fs/iomap/buffered-io.c                | 36 ++++++++++++---------------
 include/linux/buffer_head.h           |  3 +--
 include/linux/fs.h                    |  4 +--
 include/linux/iomap.h                 |  3 +--
 mm/filemap.c                          |  4 +--
 8 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 3f9b1497ebb8..88b33524687f 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -258,7 +258,7 @@ prototypes::
 	int (*migratepage)(struct address_space *, struct page *, struct page *);
 	void (*putback_page) (struct page *);
 	int (*launder_page)(struct page *);
-	int (*is_partially_uptodate)(struct page *, unsigned long, unsigned long);
+	bool (*is_partially_uptodate)(struct folio *, size_t from, size_t count);
 	int (*error_remove_page)(struct address_space *, struct page *);
 	int (*swap_activate)(struct file *);
 	int (*swap_deactivate)(struct file *);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bf5c48066fac..da3e7b470f0a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -747,8 +747,8 @@ cache in your filesystem.  The following members are defined:
 		void (*putback_page) (struct page *);
 		int (*launder_page) (struct page *);
 
-		int (*is_partially_uptodate) (struct page *, unsigned long,
-					      unsigned long);
+		bool (*is_partially_uptodate) (struct folio *, size_t from,
+					       size_t count);
 		void (*is_dirty_writeback) (struct page *, bool *, bool *);
 		int (*error_remove_page) (struct mapping *mapping, struct page *page);
 		int (*swap_activate)(struct file *);
@@ -937,9 +937,9 @@ cache in your filesystem.  The following members are defined:
 
 ``is_partially_uptodate``
 	Called by the VM when reading a file through the pagecache when
-	the underlying blocksize != pagesize.  If the required block is
-	up to date then the read can complete without needing the IO to
-	bring the whole page up to date.
+	the underlying blocksize is smaller than the size of the folio.
+	If the required block is up to date then the read can complete
+	without needing I/O to bring the whole page up to date.
 
 ``is_dirty_writeback``
 	Called by the VM when attempting to reclaim a page.  The VM uses
diff --git a/fs/buffer.c b/fs/buffer.c
index 8e112b6bd371..929061995cf8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2206,29 +2206,27 @@ int generic_write_end(struct file *file, struct address_space *mapping,
 EXPORT_SYMBOL(generic_write_end);
 
 /*
- * block_is_partially_uptodate checks whether buffers within a page are
+ * block_is_partially_uptodate checks whether buffers within a folio are
  * uptodate or not.
  *
- * Returns true if all buffers which correspond to a file portion
- * we want to read are uptodate.
+ * Returns true if all buffers which correspond to the specified part
+ * of the folio are uptodate.
  */
-int block_is_partially_uptodate(struct page *page, unsigned long from,
-					unsigned long count)
+bool block_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
 	unsigned block_start, block_end, blocksize;
 	unsigned to;
 	struct buffer_head *bh, *head;
-	int ret = 1;
-
-	if (!page_has_buffers(page))
-		return 0;
+	bool ret = true;
 
-	head = page_buffers(page);
+	head = folio_buffers(folio);
+	if (!head)
+		return false;
 	blocksize = head->b_size;
-	to = min_t(unsigned, PAGE_SIZE - from, count);
+	to = min_t(unsigned, folio_size(folio) - from, count);
 	to = from + to;
-	if (from < blocksize && to > PAGE_SIZE - blocksize)
-		return 0;
+	if (from < blocksize && to > folio_size(folio) - blocksize)
+		return false;
 
 	bh = head;
 	block_start = 0;
@@ -2236,7 +2234,7 @@ int block_is_partially_uptodate(struct page *page, unsigned long from,
 		block_end = block_start + blocksize;
 		if (block_end > from && block_start < to) {
 			if (!buffer_uptodate(bh)) {
-				ret = 0;
+				ret = false;
 				break;
 			}
 			if (block_end >= to)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d020a2e81a24..da0a7b15a64e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -424,37 +424,33 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
 /*
- * iomap_is_partially_uptodate checks whether blocks within a page are
+ * iomap_is_partially_uptodate checks whether blocks within a folio are
  * uptodate or not.
  *
- * Returns true if all blocks which correspond to a file portion
- * we want to read within the page are uptodate.
+ * Returns true if all blocks which correspond to the specified part
+ * of the folio are uptodate.
  */
-int
-iomap_is_partially_uptodate(struct page *page, unsigned long from,
-		unsigned long count)
+bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_page *iop = to_iomap_page(folio);
-	struct inode *inode = page->mapping->host;
-	unsigned len, first, last;
-	unsigned i;
+	struct inode *inode = folio->mapping->host;
+	size_t len;
+	unsigned first, last, i;
 
-	/* Limit range to one page */
-	len = min_t(unsigned, PAGE_SIZE - from, count);
+	if (!iop)
+		return false;
+
+	/* Limit range to this folio */
+	len = min(folio_size(folio) - from, count);
 
 	/* First and last blocks in range within page */
 	first = from >> inode->i_blkbits;
 	last = (from + len - 1) >> inode->i_blkbits;
 
-	if (iop) {
-		for (i = first; i <= last; i++)
-			if (!test_bit(i, iop->uptodate))
-				return 0;
-		return 1;
-	}
-
-	return 0;
+	for (i = first; i <= last; i++)
+		if (!test_bit(i, iop->uptodate))
+			return false;
+	return true;
 }
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 3451f1fcda12..79d465057889 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -225,8 +225,7 @@ int __block_write_full_page(struct inode *inode, struct page *page,
 			get_block_t *get_block, struct writeback_control *wbc,
 			bh_end_io_t *handler);
 int block_read_full_page(struct page*, get_block_t*);
-int block_is_partially_uptodate(struct page *page, unsigned long from,
-				unsigned long count);
+bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		unsigned flags, struct page **pagep, get_block_t *get_block);
 int __block_write_begin(struct page *page, loff_t pos, unsigned len,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..5939e6694ada 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -400,8 +400,8 @@ struct address_space_operations {
 	bool (*isolate_page)(struct page *, isolate_mode_t);
 	void (*putback_page)(struct page *);
 	int (*launder_page) (struct page *);
-	int (*is_partially_uptodate) (struct page *, unsigned long,
-					unsigned long);
+	bool (*is_partially_uptodate) (struct folio *, size_t from,
+			size_t count);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
 	int (*error_remove_page)(struct address_space *, struct page *);
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 97a3a2edb585..3bcbb264f83f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -227,8 +227,7 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
-int iomap_is_partially_uptodate(struct page *page, unsigned long from,
-		unsigned long count);
+bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
 void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len);
 void iomap_invalidatepage(struct page *page, unsigned int offset,
diff --git a/mm/filemap.c b/mm/filemap.c
index ad8c39d90bf9..9639b844dd31 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2452,7 +2452,7 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 		pos -= folio_pos(folio);
 	}
 
-	return mapping->a_ops->is_partially_uptodate(&folio->page, pos, count);
+	return mapping->a_ops->is_partially_uptodate(folio, pos, count);
 }
 
 static int filemap_update_page(struct kiocb *iocb,
@@ -2844,7 +2844,7 @@ static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 	offset = offset_in_folio(folio, start) & ~(bsz - 1);
 
 	do {
-		if (ops->is_partially_uptodate(&folio->page, offset, bsz) ==
+		if (ops->is_partially_uptodate(folio, offset, bsz) ==
 							seek_data)
 			break;
 		start = (start + bsz) & ~(bsz - 1);
-- 
2.34.1

