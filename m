Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD29B2A4887
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKCOrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgKCOqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:46:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67001C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z4uVBcAlQdISddYOmQ2kaWCG25CjOfNddtZovi4WqOI=; b=mkdhgFxPlwCRiQhdqovLAvuX4B
        6admtkerjvZF7aN+FWz8sjB/97Auo3B7NcJE4C4NIMnUFI4fwHZFaWBK52ZzuNbDcR6kVJ8GBRpkQ
        cW22f9ozMRwPXeiO03H495aq3O6rdJGINa9uvxAkux5MsKjP3SyWAp23L2lTYBuzoyT65RtZ3ejAA
        UdEdxINpk3Wjq87M+Y2XMQBiOFXWqv+lX9gQyDOPOnIzOv3azzWjR7E/SdzpBOjXQg4SPRkEyydYS
        F9ZhDU81z2DMPPjvSgfv21e0hRrHPD66UZDQV6zwFcGscIC6kUu9iZ6RaitBchS3MNK2CpePnuPUO
        7XOOx8QQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZxZj-0003Mz-NH; Tue, 03 Nov 2020 14:46:19 +0000
Date:   Tue, 3 Nov 2020 14:46:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 14/17] mm/filemap: Restructure filemap_get_pages
Message-ID: <20201103144619.GW27442@casper.infradead.org>
References: <20201102184312.25926-1-willy@infradead.org>
 <20201102184312.25926-15-willy@infradead.org>
 <20201103075736.GM8389@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103075736.GM8389@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 08:57:36AM +0100, Christoph Hellwig wrote:
> On Mon, Nov 02, 2020 at 06:43:09PM +0000, Matthew Wilcox (Oracle) wrote:
> > Avoid a goto, and by the time we get to calling filemap_update_page(),
> > we definitely have at least one page.
> 
> I find the error handling flow hard to follow and the existing but
> heavily touched naming of the nr_got variable and the find_pages label
> not helpful.  I'd do the following on top of this patch:

I've removed nr_got entirely in my current tree ...

diff --git a/mm/filemap.c b/mm/filemap.c
index 8264bcdb99f4..ea0cd0df638b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2166,21 +2166,17 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
-static unsigned mapping_get_read_thps(struct address_space *mapping,
-		pgoff_t index, unsigned int nr_pages, struct page **pages)
+static void mapping_get_read_thps(struct address_space *mapping,
+		pgoff_t index, pgoff_t max, struct pagevec *pvec)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct page *head;
-	unsigned int ret = 0;
-
-	if (unlikely(!nr_pages))
-		return 0;
 
 	rcu_read_lock();
 	for (head = xas_load(&xas); head; head = xas_next(&xas)) {
 		if (xas_retry(&xas, head))
 			continue;
-		if (xa_is_value(head))
+		if (xas.xa_index > max || xa_is_value(head))
 			break;
 		if (!page_cache_get_speculative(head))
 			goto retry;
@@ -2189,8 +2185,7 @@ static unsigned mapping_get_read_thps(struct address_space *mapping,
 		if (unlikely(head != xas_reload(&xas)))
 			goto put_page;
 
-		pages[ret++] = head;
-		if (ret == nr_pages)
+		if (!pagevec_add(pvec, head))
 			break;
 		if (!PageUptodate(head))
 			break;
@@ -2205,7 +2200,6 @@ static unsigned mapping_get_read_thps(struct address_space *mapping,
 		xas_reset(&xas);
 	}
 	rcu_read_unlock();
-	return ret;
 }
 
 static int filemap_read_page(struct file *file, struct address_space *mapping,
@@ -2343,52 +2337,53 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 }
 
 static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct page **pages, unsigned int nr)
+		struct pagevec *pvec)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
 	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	pgoff_t maxindex = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
 	struct page *page;
-	int nr_got, err = 0;
+	int err = 0;
 
-	nr = min_t(unsigned long, last_index - index, nr);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
-	if (!nr_got) {
+	pagevec_init(pvec);
+	mapping_get_read_thps(mapping, index, maxindex, pvec);
+	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
-		nr_got = mapping_get_read_thps(mapping, index, nr, pages);
+				maxindex - index);
+		mapping_get_read_thps(mapping, index, maxindex, pvec);
 	}
-	if (!nr_got) {
+	if (!pagevec_count(pvec)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
-		pages[0] = filemap_create_page(filp, mapping,
+		page = filemap_create_page(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT);
-		if (!pages[0])
+		if (!page)
 			goto find_page;
-		if (IS_ERR(pages[0]))
-			return PTR_ERR(pages[0]);
-		return 1;
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+		pagevec_add(pvec, page);
+		return 0;
 	}
 
-	page = pages[nr_got - 1];
+	page = pvec->pages[pagevec_count(pvec) - 1];
 	if (PageReadahead(page))
-		err = filemap_readahead(iocb, filp, mapping, page, last_index);
+		err = filemap_readahead(iocb, filp, mapping, page, maxindex);
 	if (!err && !PageUptodate(page))
 		err = filemap_update_page(iocb, mapping, iter, page,
-				nr_got == 1);
+				pagevec_count(pvec) == 1);
 
 	if (err)
-		nr_got--;
-	if (likely(nr_got))
-		return nr_got;
+		pvec->nr--;
+	if (likely(pagevec_count(pvec)))
+		return 0;
 	if (err < 0)
 		return err;
 	err = 0;
@@ -2418,11 +2413,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
-	unsigned int nr_pages = min_t(unsigned int, 512,
-			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
-			(iocb->ki_pos >> PAGE_SHIFT));
-	int i, pg_nr, error = 0;
+	struct pagevec pvec;
+	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
 
@@ -2430,14 +2422,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	if (nr_pages > ARRAY_SIZE(pages_onstack))
-		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
-
-	if (!pages) {
-		pages = pages_onstack;
-		nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
-	}
-
 	do {
 		cond_resched();
 
@@ -2449,12 +2433,9 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		i = 0;
-		pg_nr = filemap_get_pages(iocb, iter, pages, nr_pages);
-		if (pg_nr < 0) {
-			error = pg_nr;
+		error = filemap_get_pages(iocb, iter, &pvec);
+		if (error < 0)
 			break;
-		}
 
 		/*
 		 * i_size must be checked after we know the pages are Uptodate.
@@ -2467,13 +2448,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		isize = i_size_read(inode);
 		if (unlikely(iocb->ki_pos >= isize))
 			goto put_pages;
-
 		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
-		while ((iocb->ki_pos >> PAGE_SHIFT) + pg_nr >
-		       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
-			put_page(pages[--pg_nr]);
-
 		/*
 		 * Once we start copying data, we don't want to be touching any
 		 * cachelines that might be contended:
@@ -2486,18 +2462,20 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		if (iocb->ki_pos >> PAGE_SHIFT !=
 		    ra->prev_pos >> PAGE_SHIFT)
-			mark_page_accessed(pages[0]);
-		for (i = 1; i < pg_nr; i++)
-			mark_page_accessed(pages[i]);
+			mark_page_accessed(pvec.pages[0]);
 
-		for (i = 0; i < pg_nr; i++) {
-			struct page *page = pages[i];
+		for (i = 0; i < pagevec_count(&pvec); i++) {
+			struct page *page = pvec.pages[i];
 			size_t page_size = thp_size(page);
 			size_t offset = iocb->ki_pos & (page_size - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
 					     page_size - offset);
 			size_t copied;
 
+			if (end_offset < page_offset(page))
+				break;
+			if (i > 0)
+				mark_page_accessed(page);
 			/*
 			 * If users can be writing to this page using arbitrary
 			 * virtual addresses, take care about potential aliasing
@@ -2522,15 +2500,11 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_pages:
-		for (i = 0; i < pg_nr; i++)
-			put_page(pages[i]);
+		pagevec_release(&pvec);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
 
-	if (pages != pages_onstack)
-		kfree(pages);
-
 	return already_read ? already_read : error;
 }
 EXPORT_SYMBOL_GPL(filemap_read);

I like a lot of the restructuring you did there.  I'll incorporate it.

