Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5C31394F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMPhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:37:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/YqWOqUUs8RSFa3ffU4BQTUKpG67TjfYQGjVpA3xoSU=; b=pfVJyi71Ce4BNn0c+BJ3P99nBw
        3hbi7tvkAjeU/zLTNVnpi9PuXEsJYZnwVxGSHUmqLpVT6KVvXPvCzfSSDVHxIHacmX0TZvScsSPyO
        +i+kbHASx3yTaEKq9VHRsgJbFEt9rC6MA55I0o0mNeVcVk+JIgfp2IF8lwJK9npNDneW/yzlfBeHT
        vszeYJIXp0r/SBUCz/0K3g7p463EKtIh5ccANObOLM9/8SbAYfI2vFdOQW+Jxf0tqmaTaiA1uGlBM
        BE8gfdee00kt0INiZMvRXNH5h2AKjAeeeGX3/Eaov56gqocWPn+VIVrKaDLMAxC+wDlLVCSH/U7TT
        oFCRpCKQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00076j-9X; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [PATCH 6/8] cifs: Convert from readpages to readahead
Date:   Mon, 13 Jan 2020 07:37:44 -0800
Message-Id: <20200113153746.26654-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
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
 fs/cifs/file.c | 125 ++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 106 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 043288b5c728..816670b501d8 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4280,70 +4280,10 @@ cifs_readpages_copy_into_pages(struct TCP_Server_Info *server,
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
+static void cifs_readahead(struct file *file, struct address_space *mapping,
+		struct pagevec *pages, pgoff_t index)
 {
 	int rc;
-	struct list_head tmplist;
 	struct cifsFileInfo *open_file = file->private_data;
 	struct cifs_sb_info *cifs_sb = CIFS_FILE_SB(file);
 	struct TCP_Server_Info *server;
@@ -4358,11 +4298,10 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	 * After this point, every page in the list might have PG_fscache set,
 	 * so we will need to clean that up off of every page we don't use.
 	 */
-	rc = cifs_readpages_from_fscache(mapping->host, mapping, page_list,
-					 &num_pages);
+	rc = -ENOBUFS;
 	if (rc == 0) {
 		free_xid(xid);
-		return rc;
+		return;
 	}
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
@@ -4373,24 +4312,12 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	rc = 0;
 	server = tlink_tcon(open_file->tlink)->ses->server;
 
-	cifs_dbg(FYI, "%s: file=%p mapping=%p num_pages=%u\n",
-		 __func__, file, mapping, num_pages);
+	cifs_dbg(FYI, "%s: file=%p mapping=%p index=%lu\n",
+		 __func__, file, mapping, index);
 
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
+	while (pages->first < pages->nr) {
+		unsigned int i, nr_pages, rsize;
+		struct page *page;
 		struct cifs_readdata *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
@@ -4408,6 +4335,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		if (rc)
 			break;
 
+		nr_pages = rsize / PAGE_SIZE;
 		/*
 		 * Give up immediately if rsize is too small to read an entire
 		 * page. The VFS will fall back to readpage. We should never
@@ -4415,36 +4343,23 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		 * rsize is smaller than a cache page.
 		 */
 		if (unlikely(rsize < PAGE_SIZE)) {
-			add_credits_and_wake_if(server, credits, 0);
-			free_xid(xid);
-			return 0;
-		}
-
-		rc = readpages_get_pages(mapping, page_list, rsize, &tmplist,
-					 &nr_pages, &offset, &bytes);
-		if (rc) {
 			add_credits_and_wake_if(server, credits, 0);
 			break;
 		}
 
+		if (nr_pages > pagevec_count(pages))
+			nr_pages = pagevec_count(pages);
+
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
+		rdata->offset = index;
 		rdata->pid = pid;
 		rdata->pagesz = PAGE_SIZE;
 		rdata->tailsz = PAGE_SIZE;
@@ -4452,9 +4367,10 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 		rdata->copy_into_pages = cifs_readpages_copy_into_pages;
 		rdata->credits = credits_on_stack;
 
-		list_for_each_entry_safe(page, tpage, &tmplist, lru) {
-			list_del(&page->lru);
-			rdata->pages[rdata->nr_pages++] = page;
+		for (i = 0; i < rdata->nr_pages; i++) {
+			rdata->pages[rdata->nr_pages++] = pagevec_next(pages);
+			index++;
+			rdata->bytes += PAGE_SIZE;
 		}
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
@@ -4470,7 +4386,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 			add_credits_and_wake_if(server, &rdata->credits, 0);
 			for (i = 0; i < rdata->nr_pages; i++) {
 				page = rdata->pages[i];
-				lru_cache_add_file(page);
 				unlock_page(page);
 				put_page(page);
 			}
@@ -4486,9 +4401,7 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	 * the pagecache must be uncached before they get returned to the
 	 * allocator.
 	 */
-	cifs_fscache_readpages_cancel(mapping->host, page_list);
 	free_xid(xid);
-	return rc;
 }
 
 /*
@@ -4806,7 +4719,7 @@ cifs_direct_io(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations cifs_addr_ops = {
 	.readpage = cifs_readpage,
-	.readpages = cifs_readpages,
+	.readahead = cifs_readahead,
 	.writepage = cifs_writepage,
 	.writepages = cifs_writepages,
 	.write_begin = cifs_write_begin,
-- 
2.24.1

