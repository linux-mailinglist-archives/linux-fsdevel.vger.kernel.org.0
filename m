Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B1C13B7C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAOCir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgAOCiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R5s7E+fDNMsmJ/ZtIC98sZK+AORG+F7O0ns/rNwbsl0=; b=EgrmhkcR/yjDI7OqkOXZNvgj8i
        t4lXpRcAlZpgyU/7bgXTxjnCeOOUX+N9qds89jX0ZFKKwdzIOJsX9eDwPUMts4c1tQjhtsZvnVzeQ
        yKChgvFCVBKDbG0wcvIiYAmKvP0OcdO2Dhzk3qMj1hY4LOsD6yPrgBHYtOATfO91bTL27L3MkrOHN
        3t47yBo5GeSPzUIQR61xT2NtFSCrl1rYh8Avo6NaflsIAC03UJ87sXXmFbQRpj45Vi+pz4vrDmYPn
        hqP29jiEr45cpWuh0U3CK2jsKiHwAzPf0CtG8Oe6K5S+eYZcVROC8Gl/9CUGXLhbCFo9ZL/aE+XzW
        Z7F646eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008Az-7T; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 7/9] cifs: Convert from readpages to readahead
Date:   Tue, 14 Jan 2020 18:38:41 -0800
Message-Id: <20200115023843.31325-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in CIFS

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/cifs/file.c | 143 +++++++++----------------------------------------
 1 file changed, 25 insertions(+), 118 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 043288b5c728..c9162380ad22 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4280,70 +4280,11 @@ cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
 	return readpages_fill_pages(server, rdata, iter, iter->count);
 }
 
-static int
-readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
-		    unsigned int rsize, struct list_head *tmplist,
-		    unsigned int *nr_pages, loff_t *offset, unsigned int *bytes)
-{
-	struct page *page, *tpage;
-	unsigned int expected_index;
-	int rc;
-	gfp_t gfp = readahead_gfp_mask(mapping);
-
-	INIT_LIST_HEAD(tmplist);
-
-	page = lru_to_page(page_list);
-
-	/*
-	 * Lock the page and put it in the cache. Since no one else
-	 * should have access to this page, we're safe to simply set
-	 * PG_locked without checking it first.
-	 */
-	__SetPageLocked(page);
-	rc = add_to_page_cache_locked(page, mapping,
-				      page->index, gfp);
-
-	/* give up if we can't stick it in the cache */
-	if (rc) {
-		__ClearPageLocked(page);
-		return rc;
-	}
-
-	/* move first page to the tmplist */
-	*offset = (loff_t)page->index << PAGE_SHIFT;
-	*bytes = PAGE_SIZE;
-	*nr_pages = 1;
-	list_move_tail(&page->lru, tmplist);
-
-	/* now try and add more pages onto the request */
-	expected_index = page->index + 1;
-	list_for_each_entry_safe_reverse(page, tpage, page_list, lru) {
-		/* discontinuity ? */
-		if (page->index != expected_index)
-			break;
-
-		/* would this page push the read over the rsize? */
-		if (*bytes + PAGE_SIZE > rsize)
-			break;
-
-		__SetPageLocked(page);
-		if (add_to_page_cache_locked(page, mapping, page->index, gfp)) {
-			__ClearPageLocked(page);
-			break;
-		}
-		list_move_tail(&page->lru, tmplist);
-		(*bytes) += PAGE_SIZE;
-		expected_index++;
-		(*nr_pages)++;
-	}
-	return rc;
-}
-
-static int cifs_readpages(struct file *file, struct address_space *mapping,
-	struct list_head *page_list, unsigned num_pages)
+static unsigned cifs_readahead(struct file *file,
+		struct address_space *mapping, pgoff_t start,
+		unsigned num_pages)
 {
 	int rc;
-	struct list_head tmplist;
 	struct cifsFileInfo *open_file = file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(file);
 	struct TCP_Server_Info *server;
@@ -4358,11 +4299,10 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	 * After this point, every page in the list might have PG_fscache set,
 	 * so we will need to clean that up off of every page we don't use.
 	 */
-	rc = cifs_readpages_from_fscache(mapping->host, mapping, page_list,
-					 &num_pages);
+	rc = -ENOBUFS;
 	if (rc == 0) {
 		free_xid(xid);
-		return rc;
+		return num_pages;
 	}
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
@@ -4373,24 +4313,11 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	rc = 0;
 	server = tlink_tcon(open_file->tlink)->ses->server;
 
-	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
-		 __func__, file, mapping, num_pages);
+	cifs_dbg(FYI, "%s: file=%p mapping=%p start=%lu num_pages=%u\n",
+		 __func__, file, mapping, start, num_pages);
 
-	/*
-	 * Start with the page at end of list and move it to private
-	 * list. Do the same with any following pages until we hit
-	 * the rsize limit, hit an index discontinuity, or run out of
-	 * pages. Issue the async read and then start the loop again
-	 * until the list is empty.
-	 *
-	 * Note that list order is important. The page_list is in
-	 * the order of declining indexes. When we put the pages in
-	 * the rdata->pages, then we want them in increasing order.
-	 */
-	while (!list_empty(page_list)) {
-		unsigned int i, nr_pages, bytes, rsize;
-		loff_t offset;
-		struct page *page, *tpage;
+	while (num_pages) {
+		unsigned int i, nr_pages, rsize;
 		struct cifs_readdata *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
@@ -4408,21 +4335,14 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		if (rc)
 			break;
 
+		nr_pages = min_t(unsigned, rsize / PAGE_SIZE, num_pages);
 		/*
 		 * Give up immediately if rsize is too small to read an entire
 		 * page. The VFS will fall back to readpage. We should never
-		 * reach this point however since we set ra_pages to 0 when the
-		 * rsize is smaller than a cache page.
+		 * reach this point however since we set ra_pages to 0 when
+		 * the rsize is smaller than a cache page.
 		 */
-		if (unlikely(rsize < PAGE_SIZE)) {
-			add_credits_and_wake_if(server, credits, 0);
-			free_xid(xid);
-			return 0;
-		}
-
-		rc = readpages_get_pages(mapping, page_list, rsize, &tmplist,
-					 &nr_pages, &offset, &bytes);
-		if (rc) {
+		if (unlikely(nr_pages < 1)) {
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
@@ -4430,21 +4350,15 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		rdata = cifs_readdata_alloc(nr_pages, cifs_readv_complete);
 		if (!rdata) {
 			/* best to give up if we're out of mem */
-			list_for_each_entry_safe(page, tpage, &tmplist, lru) {
-				list_del(&page->lru);
-				lru_cache_add_file(page);
-				unlock_page(page);
-				put_page(page);
-			}
-			rc = -ENOMEM;
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
 
 		rdata->cfile = cifsFileInfo_get(open_file);
 		rdata->mapping = mapping;
-		rdata->offset = offset;
-		rdata->bytes = bytes;
+		rdata->offset = start;
+		rdata->nr_pages = nr_pages;
+		rdata->bytes = nr_pages * PAGE_SIZE;
 		rdata->pid = pid;
 		rdata->pagesz = PAGE_SIZE;
 		rdata->tailsz = PAGE_SIZE;
@@ -4452,10 +4366,8 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
 		rdata->credits = credits_on_stack;
 
-		list_for_each_entry_safe(page, tpage, &tmplist, lru) {
-			list_del(&page->lru);
-			rdata->pages[rdata->nr_pages++] = page;
-		}
+		for (i = 0; i < nr_pages; i++)
+			rdata->pages[i] = readahead_page(mapping, start++);
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 
@@ -4468,27 +4380,22 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			for (i = 0; i < rdata->nr_pages; i++) {
-				page = rdata->pages[i];
-				lru_cache_add_file(page);
-				unlock_page(page);
-				put_page(page);
-			}
-			/* Fallback to the readpage in error/reconnect cases */
 			kref_put(&rdata->refcount, cifs_readdata_release);
 			break;
 		}
 
 		kref_put(&rdata->refcount, cifs_readdata_release);
+		num_pages -= nr_pages;
 	}
 
 	/* Any pages that have been shown to fscache but didn't get added to
 	 * the pagecache must be uncached before they get returned to the
 	 * allocator.
 	 */
-	cifs_fscache_readpages_cancel(mapping->host, page_list);
+//	cifs_fscache_readpages_cancel(mapping->host, page_list);
 	free_xid(xid);
-	return rc;
+
+	return num_pages;
 }
 
 /*
@@ -4806,7 +4713,7 @@ cifs_direct_io(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
-	.readpages = cifs_readpages,
+	.readahead = cifs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
@@ -4819,9 +4726,9 @@ const struct address_space_operations cifs_addr_ops = {
 };
 
 /*
- * cifs_readpages requires the server to support a buffer large enough to
+ * cifs_readahead requires the server to support a buffer large enough to
  * contain the header plus one complete page of data.  Otherwise, we need
- * to leave cifs_readpages out of the address space operations.
+ * to leave cifs_readahead out of the address space operations.
  */
 const struct address_space_operations cifs_addr_ops_smallbuf = {
 	.readpage = cifs_readpage,
-- 
2.24.1

