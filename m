Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615B951F19B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbiEHUh0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiEHUgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B346425
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Y4hu4v/TmZtwQx6CqXoO2cuOX9AqzmgaelwKlS4XTrs=; b=LmvtGdpzWb3zpYM7UhqN10o/T2
        iw2Mze1izNnWwBLOZK9viL5l17MUkeQ8UAzU1G3haoWXpUWBFDvB4GI77rexj1zqSLkKgP/QrM6Xf
        CNATndh74ppMV21MKK6URdfxZvDftk1BrkEmpAVidiq1ciFj15kQ/E0te1jDKXnWTMvC2HZ/CCh4K
        EcOm6W/i9VuJqwGVIyOFxfb5UFlOsQGaM6rhpGVfJF4uH5xxrtQvYlUt7yBAwePe6+bfgDtnQF/IQ
        PZyawH9iVDf6jnURoNuSUezuert4cIP3sIve5rM2WjLuLhHwV2ojmJClKS6ZPipFakiJU09hYrycV
        pXd4QxUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnna0-002ny6-MP; Sun, 08 May 2022 20:32:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/4] fs: Change the type of filler_t
Date:   Sun,  8 May 2022 21:32:33 +0100
Message-Id: <20220508203234.668623-4-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203234.668623-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203234.668623-1-willy@infradead.org>
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

By making filler_t the same as read_folio, we can use the same function
for both in gfs2.  We can push the use of folios down one more level
in jffs2 and nfs.  We also increase type safety for future users of the
various read_cache_page() family of functions by forcing the parameter
to be a pointer to struct file (or NULL).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c          | 29 +++++++++++-----------------
 fs/jffs2/file.c         |  9 ++++-----
 fs/jffs2/gc.c           |  2 +-
 fs/jffs2/os-linux.h     |  2 +-
 fs/nfs/symlink.c        | 14 +++++++-------
 include/linux/pagemap.h |  6 +++---
 mm/filemap.c            | 42 ++++++++++++++++++++---------------------
 7 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 340bf5d0e835..1016631bcbdc 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -464,21 +464,24 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 	return 0;
 }
 
-
-static int __gfs2_readpage(void *file, struct page *page)
+/**
+ * gfs2_read_folio - read a folio from a file
+ * @file: The file to read
+ * @folio: The folio in the file
+ */
+static int gfs2_read_folio(struct file *file, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
 
 	if (!gfs2_is_jdata(ip) ||
-	    (i_blocksize(inode) == PAGE_SIZE && !page_has_buffers(page))) {
+	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
 		error = iomap_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
-		error = stuffed_readpage(ip, page);
-		unlock_page(page);
+		error = stuffed_readpage(ip, &folio->page);
+		folio_unlock(folio);
 	} else {
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
@@ -489,16 +492,6 @@ static int __gfs2_readpage(void *file, struct page *page)
 	return error;
 }
 
-/**
- * gfs2_read_folio - read a folio from a file
- * @file: The file to read
- * @folio: The folio in the file
- */
-static int gfs2_read_folio(struct file *file, struct folio *folio)
-{
-	return __gfs2_readpage(file, &folio->page);
-}
-
 /**
  * gfs2_internal_read - read an internal file
  * @ip: The gfs2 inode
@@ -523,7 +516,7 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
 		amt = size - copied;
 		if (offset + size > PAGE_SIZE)
 			amt = PAGE_SIZE - offset;
-		page = read_cache_page(mapping, index, __gfs2_readpage, NULL);
+		page = read_cache_page(mapping, index, gfs2_read_folio, NULL);
 		if (IS_ERR(page))
 			return PTR_ERR(page);
 		p = kmap_atomic(page);
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 492fb2da0403..ba86acbe12d3 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -110,21 +110,20 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	return ret;
 }
 
-int jffs2_do_readpage_unlock(void *data, struct page *pg)
+int __jffs2_read_folio(struct file *file, struct folio *folio)
 {
-	int ret = jffs2_do_readpage_nolock(pg->mapping->host, pg);
-	unlock_page(pg);
+	int ret = jffs2_do_readpage_nolock(folio->mapping->host, &folio->page);
+	folio_unlock(folio);
 	return ret;
 }
 
-
 static int jffs2_read_folio(struct file *file, struct folio *folio)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(folio->mapping->host);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(file, &folio->page);
+	ret = __jffs2_read_folio(file, folio);
 	mutex_unlock(&f->sem);
 	return ret;
 }
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index a53bac7569b6..5c6602f3c189 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -1327,7 +1327,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 	 * trying to write out, read_cache_page() will not deadlock. */
 	mutex_unlock(&f->sem);
 	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
-			       jffs2_do_readpage_unlock, NULL);
+			       __jffs2_read_folio, NULL);
 	if (IS_ERR(page)) {
 		pr_warn("read_cache_page() returned error: %ld\n",
 			PTR_ERR(page));
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index 173eccac691d..921d782583d6 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -155,7 +155,7 @@ extern const struct file_operations jffs2_file_operations;
 extern const struct inode_operations jffs2_file_inode_operations;
 extern const struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, loff_t, loff_t, int);
-int jffs2_do_readpage_unlock(void *data, struct page *pg);
+int __jffs2_read_folio(struct file *file, struct folio *folio);
 
 /* ioctl.c */
 long jffs2_ioctl(struct file *, unsigned int, unsigned long);
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 8b53538bcc75..0e27a2e4e68b 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -26,21 +26,21 @@
  * and straight-forward than readdir caching.
  */
 
-static int nfs_symlink_filler(void *data, struct page *page)
+static int nfs_symlink_filler(struct file *file, struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	int error;
 
-	error = NFS_PROTO(inode)->readlink(inode, page, 0, PAGE_SIZE);
+	error = NFS_PROTO(inode)->readlink(inode, &folio->page, 0, PAGE_SIZE);
 	if (error < 0)
 		goto error;
-	SetPageUptodate(page);
-	unlock_page(page);
+	folio_mark_uptodate(folio);
+	folio_unlock(folio);
 	return 0;
 
 error:
-	SetPageError(page);
-	unlock_page(page);
+	folio_set_error(folio);
+	folio_unlock(folio);
 	return -EIO;
 }
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b70192f56454..831b28dab01a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -492,7 +492,7 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
 	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-typedef int filler_t(void *, struct page *);
+typedef int filler_t(struct file *, struct folio *);
 
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan);
@@ -747,9 +747,9 @@ static inline struct page *grab_cache_page(struct address_space *mapping,
 }
 
 struct folio *read_cache_folio(struct address_space *, pgoff_t index,
-		filler_t *filler, void *data);
+		filler_t *filler, struct file *file);
 struct page *read_cache_page(struct address_space *, pgoff_t index,
-		filler_t *filler, void *data);
+		filler_t *filler, struct file *file);
 extern struct page * read_cache_page_gfp(struct address_space *mapping,
 				pgoff_t index, gfp_t gfp_mask);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 6ede3ab76a5a..81a0ed08a82c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3483,7 +3483,7 @@ EXPORT_SYMBOL(generic_file_mmap);
 EXPORT_SYMBOL(generic_file_readonly_mmap);
 
 static struct folio *do_read_cache_folio(struct address_space *mapping,
-		pgoff_t index, filler_t filler, void *data, gfp_t gfp)
+		pgoff_t index, filler_t filler, struct file *file, gfp_t gfp)
 {
 	struct folio *folio;
 	int err;
@@ -3504,11 +3504,9 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 
 filler:
 		if (filler)
-			err = filler(data, &folio->page);
-		else if (mapping->a_ops->read_folio)
-			err = mapping->a_ops->read_folio(data, folio);
+			err = filler(file, folio);
 		else
-			err = mapping->a_ops->readpage(data, &folio->page);
+			err = mapping->a_ops->read_folio(file, folio);
 
 		if (err < 0) {
 			folio_put(folio);
@@ -3559,44 +3557,44 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 }
 
 /**
- * read_cache_folio - read into page cache, fill it if needed
- * @mapping:	the page's address_space
- * @index:	the page index
- * @filler:	function to perform the read
- * @data:	first arg to filler(data, page) function, often left as NULL
- *
- * Read into the page cache. If a page already exists, and PageUptodate() is
- * not set, try to fill the page and wait for it to become unlocked.
+ * read_cache_folio - Read into page cache, fill it if needed.
+ * @mapping: The address_space to read from.
+ * @index: The index to read.
+ * @filler: Function to perform the read, or NULL to use aops->read_folio().
+ * @file: Passed to filler function, may be NULL if not required.
  *
- * If the page does not get brought uptodate, return -EIO.
+ * Read one page into the page cache.  If it succeeds, the folio returned
+ * will contain @index, but it may not be the first page of the folio.
  *
- * The function expects mapping->invalidate_lock to be already held.
+ * If the filler function returns an error, it will be returned to the
+ * caller.
  *
- * Return: up to date page on success, ERR_PTR() on failure.
+ * Context: May sleep.  Expects mapping->invalidate_lock to be held.
+ * Return: An uptodate folio on success, ERR_PTR() on failure.
  */
 struct folio *read_cache_folio(struct address_space *mapping, pgoff_t index,
-		filler_t filler, void *data)
+		filler_t filler, struct file *file)
 {
-	return do_read_cache_folio(mapping, index, filler, data,
+	return do_read_cache_folio(mapping, index, filler, file,
 			mapping_gfp_mask(mapping));
 }
 EXPORT_SYMBOL(read_cache_folio);
 
 static struct page *do_read_cache_page(struct address_space *mapping,
-		pgoff_t index, filler_t *filler, void *data, gfp_t gfp)
+		pgoff_t index, filler_t *filler, struct file *file, gfp_t gfp)
 {
 	struct folio *folio;
 
-	folio = do_read_cache_folio(mapping, index, filler, data, gfp);
+	folio = do_read_cache_folio(mapping, index, filler, file, gfp);
 	if (IS_ERR(folio))
 		return &folio->page;
 	return folio_file_page(folio, index);
 }
 
 struct page *read_cache_page(struct address_space *mapping,
-				pgoff_t index, filler_t *filler, void *data)
+			pgoff_t index, filler_t *filler, struct file *file)
 {
-	return do_read_cache_page(mapping, index, filler, data,
+	return do_read_cache_page(mapping, index, filler, file,
 			mapping_gfp_mask(mapping));
 }
 EXPORT_SYMBOL(read_cache_page);
-- 
2.34.1

