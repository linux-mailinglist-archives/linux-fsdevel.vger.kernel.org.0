Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D56200931
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgFSM7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbgFSM7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:59:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383FC06174E;
        Fri, 19 Jun 2020 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0nVwF4w4a0m/LCD6ACtxn6b6zW4k95mOi2/uHr4laEY=; b=d3+dxUXSa/axdAtzlVOAy5RB0R
        xN6kQqUnfWKN2Lcq2P3ga0mISk4VQU8W1AlzC2TY+JrDIUTKIY0SeqwOnWp8Wk9czZAhlda22eNEY
        +vHMKF8x5kMsHQbVFavrRFSEeXBtQnDeDtAA50aa9Zzl3RSQx76ysmdEfqBSURCsA5H+FGuPJTY+e
        naYgiy5KIzT+rP1EMuSkjPOsjPX4xJcaY3qhK4uOa5hoMb/expcNerc5qL/klox4Q0+6XG0aAeUxb
        d1lzckdvh5wENvQKwoMG+EF3+8RMk53d2r5ETFupntcW29OGRU0jRft1YwkjKOgOv1i59vq5dowQ8
        e+e52uTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmGc4-0000AF-GS; Fri, 19 Jun 2020 12:59:20 +0000
Date:   Fri, 19 Jun 2020 05:59:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] generic_file_buffered_read() refactoring &
 optimization
Message-ID: <20200619125920.GA29193@infradead.org>
References: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
 <20200619032049.2687598-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619032049.2687598-1-kent.overstreet@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After looking at v2 yesterday I noticed I few things in the structure
that I really didn't like:

 - using a struct page * return value just to communicate status codes
 - the extremely long function names
 - a generally somewhat non-intuitive split of the helpers

I then hacked on top of it for a bit while sitting in a telephone
conference.  Below is my result, which passes a quick xfstests run.
Note that this includes the refactoring and the batch lookup changes
as I did it on top of your series:

diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb4d..9e0aecd99950f4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1972,273 +1972,360 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
-/**
- * generic_file_buffered_read - generic file read routine
- * @iocb:	the iocb to read
- * @iter:	data destination
- * @written:	already copied
- *
- * This is a generic file read routine, and uses the
- * mapping->a_ops->readpage() function for the actual low-level stuff.
- *
- * This is really ugly. But the goto's actually try to clarify some
- * of the logic when it comes to error handling etc.
- *
- * Return:
- * * total number of bytes copied, including those the were already @written
- * * negative error code if nothing was copied
- */
-ssize_t generic_file_buffered_read(struct kiocb *iocb,
-		struct iov_iter *iter, ssize_t written)
+static inline pgoff_t filemap_last_index(struct kiocb *iocb,
+		struct iov_iter *iter)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct file_ra_state *ra = &filp->f_ra;
-	loff_t *ppos = &iocb->ki_pos;
-	pgoff_t index;
-	pgoff_t last_index;
-	pgoff_t prev_index;
-	unsigned long offset;      /* offset into pagecache page */
-	unsigned int prev_offset;
-	int error = 0;
-
-	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
-		return 0;
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
-
-	index = *ppos >> PAGE_SHIFT;
-	prev_index = ra->prev_pos >> PAGE_SHIFT;
-	prev_offset = ra->prev_pos & (PAGE_SIZE-1);
-	last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+	return (iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT;
+}
 
-	for (;;) {
-		struct page *page;
-		pgoff_t end_index;
-		loff_t isize;
-		unsigned long nr, ret;
+static inline unsigned long filemap_nr_pages(struct kiocb *iocb,
+		struct iov_iter *iter)
+{
+	return filemap_last_index(iocb, iter) - (iocb->ki_pos >> PAGE_SHIFT);
+}
 
-		cond_resched();
-find_page:
-		if (fatal_signal_pending(current)) {
-			error = -EINTR;
-			goto out;
-		}
+static int __filemap_read_not_uptodate(struct file *file, struct page *page)
+{
+	int error;
 
-		page = find_get_page(mapping, index);
-		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
-				goto would_block;
-			page_cache_sync_readahead(mapping,
-					ra, filp,
-					index, last_index - index);
-			page = find_get_page(mapping, index);
-			if (unlikely(page == NULL))
-				goto no_cached_page;
-		}
-		if (PageReadahead(page)) {
-			page_cache_async_readahead(mapping,
-					ra, filp, page,
-					index, last_index - index);
-		}
-		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
-				put_page(page);
-				goto would_block;
-			}
+	error = lock_page_killable(page);
+	if (error)
+		return error;
 
+	if (!PageUptodate(page)) {
+		if (!page->mapping) {
 			/*
-			 * See comment in do_read_cache_page on why
-			 * wait_on_page_locked is used to avoid unnecessarily
-			 * serialisations and why it's safe.
+			 * invalidate_mapping_pages got it
 			 */
-			error = wait_on_page_locked_killable(page);
-			if (unlikely(error))
-				goto readpage_error;
-			if (PageUptodate(page))
-				goto page_ok;
-
-			if (inode->i_blkbits == PAGE_SHIFT ||
-					!mapping->a_ops->is_partially_uptodate)
-				goto page_not_up_to_date;
-			/* pipes can't handle partially uptodate pages */
-			if (unlikely(iov_iter_is_pipe(iter)))
-				goto page_not_up_to_date;
-			if (!trylock_page(page))
-				goto page_not_up_to_date;
-			/* Did it get truncated before we got the lock? */
-			if (!page->mapping)
-				goto page_not_up_to_date_locked;
-			if (!mapping->a_ops->is_partially_uptodate(page,
-							offset, iter->count))
-				goto page_not_up_to_date_locked;
-			unlock_page(page);
+			error = AOP_TRUNCATED_PAGE;
+		} else {
+			error = -EIO;
 		}
-page_ok:
-		/*
-		 * i_size must be checked after we know the page is Uptodate.
-		 *
-		 * Checking i_size after the check allows us to calculate
-		 * the correct value for "nr", which means the zero-filled
-		 * part of the page is not copied back to userspace (unless
-		 * another truncate extends the file - this is desired though).
-		 */
+	}
 
-		isize = i_size_read(inode);
-		end_index = (isize - 1) >> PAGE_SHIFT;
-		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
-			goto out;
-		}
+	unlock_page(page);
+	if (error == -EIO)
+		shrink_readahead_size_eio(&file->f_ra);
+	return error;
+}
 
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = PAGE_SIZE;
-		if (index == end_index) {
-			nr = ((isize - 1) & ~PAGE_MASK) + 1;
-			if (nr <= offset) {
-				put_page(page);
-				goto out;
-			}
-		}
-		nr = nr - offset;
+static int __filemap_read_one_page(struct file *file, struct page *page)
+{
+	int error;
 
-		/* If users can be writing to this page using arbitrary
-		 * virtual addresses, take care about potential aliasing
-		 * before reading the page on the kernel side.
-		 */
-		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+	/*
+	 * A previous I/O error may have been due to temporary failures, e.g.
+	 * multipath errors. PG_error will be set again if readpage fails.
+	 */
+	ClearPageError(page);
 
-		/*
-		 * When a sequential read accesses a page several times,
-		 * only mark it as accessed the first time.
-		 */
-		if (prev_index != index || offset != prev_offset)
-			mark_page_accessed(page);
-		prev_index = index;
+	/*
+	 * Start the actual read. The read will unlock the page.
+	 */
+	error = file->f_mapping->a_ops->readpage(file, page);
+	if (!error && !PageUptodate(page))
+		return __filemap_read_not_uptodate(file, page);
+	return error;
+}
 
-		/*
-		 * Ok, we have the page, and it's up-to-date, so
-		 * now we can copy it to user space...
-		 */
+static int filemap_read_one_page(struct kiocb *iocb, struct iov_iter *iter,
+		struct page *page, pgoff_t index)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	loff_t pos = max(iocb->ki_pos, (loff_t)index << PAGE_SHIFT);
+	loff_t count = iocb->ki_pos + iter->count - pos;
+	int error;
 
-		ret = copy_page_to_iter(page, offset, nr, iter);
-		offset += ret;
-		index += offset >> PAGE_SHIFT;
-		offset &= ~PAGE_MASK;
-		prev_offset = offset;
+	/*
+	 * See comment in do_read_cache_page on why wait_on_page_locked is used
+	 * to avoid unnecessarily serialisations and why it's safe.
+	 */
+	error = wait_on_page_locked_killable(page);
+	if (unlikely(error))
+		goto out_put_page;
 
-		put_page(page);
-		written += ret;
-		if (!iov_iter_count(iter))
-			goto out;
-		if (ret < nr) {
-			error = -EFAULT;
-			goto out;
-		}
-		continue;
+	if (PageUptodate(page))
+		return 0;
+
+	if (mapping->host->i_blkbits == PAGE_SHIFT ||
+	    !mapping->a_ops->is_partially_uptodate)
+		goto page_not_up_to_date;
+	/* pipes can't handle partially uptodate pages */
+	if (unlikely(iov_iter_is_pipe(iter)))
+		goto page_not_up_to_date;
+	if (!trylock_page(page))
+		goto page_not_up_to_date;
+	/* Did it get truncated before we got the lock? */
+	if (!page->mapping)
+		goto page_not_up_to_date_locked;
+	if (!mapping->a_ops->is_partially_uptodate(page, pos & ~PAGE_MASK,
+			count))
+		goto page_not_up_to_date_locked;
+done:
+	unlock_page(page);
+	return 0;
 
 page_not_up_to_date:
-		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
-		if (unlikely(error))
-			goto readpage_error;
+	/* Get exclusive access to the page ... */
+	error = lock_page_killable(page);
+	if (unlikely(error))
+		goto out_put_page;
 
 page_not_up_to_date_locked:
-		/* Did it get truncated before we got the lock? */
-		if (!page->mapping) {
-			unlock_page(page);
-			put_page(page);
+	/* Did it get truncated before we got the lock? */
+	if (!page->mapping) {
+		error = AOP_TRUNCATED_PAGE;
+		unlock_page(page);
+		goto out_put_page;
+	}
+
+	/* Did somebody else fill it already? */
+	if (PageUptodate(page))
+		goto done;
+
+	error = __filemap_read_one_page(file, page);
+	if (error)
+		goto out_put_page;
+	return 0;
+
+out_put_page:
+	put_page(page);
+	return error;
+}
+
+static int filemap_read_get_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned long max_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	unsigned long nr = min(filemap_nr_pages(iocb, iter), max_pages);
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	int ret;
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	ret = find_get_pages_contig(mapping, index, nr, pages);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	page_cache_sync_readahead(mapping, &file->f_ra, file, index,
+				  filemap_nr_pages(iocb, iter));
+
+	ret = find_get_pages_contig(mapping, index, nr, pages);
+	if (ret)
+		return ret;
+
+	/*
+	 * Ok, it wasn't cached, so we need to create a new page..
+	 */
+	pages[0] = page_cache_alloc(mapping);
+	if (!pages[0])
+		return -ENOMEM;
+
+	ret = add_to_page_cache_lru(pages[0], mapping, index,
+			mapping_gfp_constraint(mapping, GFP_KERNEL));
+	if (ret) {
+		if (ret == -EEXIST)
+			ret = 0;
+		goto out_put_page;
+	}
+
+	ret = __filemap_read_one_page(file, pages[0]);
+	if (ret) {
+		if (ret == AOP_TRUNCATED_PAGE)
+			ret = 0;
+		goto out_put_page;
+	}
+
+	return 1;
+
+out_put_page:
+	put_page(pages[0]);
+	return ret;
+}
+
+static int filemap_read_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	pgoff_t last_index = filemap_last_index(iocb, iter);
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	unsigned int cur_page, j;
+	int err = 0;
+
+	for (cur_page = 0; cur_page < nr_pages; cur_page++, index++) {
+		struct page *page = pages[cur_page];
+
+		if (PageReadahead(page))
+			page_cache_async_readahead(mapping, &file->f_ra, file,
+					page, index, last_index - index);
+
+		if (PageUptodate(page))
 			continue;
-		}
 
-		/* Did somebody else fill it already? */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			goto page_ok;
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			put_page(page);
+			err = -EAGAIN;
+			goto out_put_pages;
 		}
 
-readpage:
-		/*
-		 * A previous I/O error may have been due to temporary
-		 * failures, eg. multipath errors.
-		 * PG_error will be set again if readpage fails.
-		 */
-		ClearPageError(page);
-		/* Start the actual read. The read will unlock the page. */
-		error = mapping->a_ops->readpage(filp, page);
+		err = filemap_read_one_page(iocb, iter, page, index);
+		if (err)
+			goto out_put_pages;
+	}
 
-		if (unlikely(error)) {
-			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
-				error = 0;
-				goto find_page;
-			}
-			goto readpage_error;
-		}
+	return cur_page;
 
-		if (!PageUptodate(page)) {
-			error = lock_page_killable(page);
-			if (unlikely(error))
-				goto readpage_error;
-			if (!PageUptodate(page)) {
-				if (page->mapping == NULL) {
-					/*
-					 * invalidate_mapping_pages got it
-					 */
-					unlock_page(page);
-					put_page(page);
-					goto find_page;
-				}
-				unlock_page(page);
-				shrink_readahead_size_eio(ra);
-				error = -EIO;
-				goto readpage_error;
-			}
-			unlock_page(page);
-		}
+out_put_pages:
+	for (j = cur_page + 1; j < nr_pages; j++)
+		put_page(pages[j]);
+	if (cur_page == 0) {
+		if (err == AOP_TRUNCATED_PAGE)
+			err = 0;
+		return err;
+	}
+	return cur_page;
+}
 
-		goto page_ok;
+static int filemap_do_read(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned long max_pages)
+{
+	struct file *filp = iocb->ki_filp;
+	struct address_space *mapping = filp->f_mapping;
+	struct file_ra_state *ra = &filp->f_ra;
+	loff_t isize, end_offset;
+	int nr_pages, i;
+	bool writably_mapped;
 
-readpage_error:
-		/* UHHUH! A synchronous read error occurred. Report it */
-		put_page(page);
-		goto out;
+	cond_resched();
+
+was_truncated:
+	nr_pages = filemap_read_get_pages(iocb, iter, pages, max_pages);
+	if (nr_pages > 0)
+		nr_pages = filemap_read_pages(iocb, iter, pages, nr_pages);
+	if (nr_pages == 0)
+		goto was_truncated;
+	if (nr_pages < 0)
+		return nr_pages;
+
+	/*
+	 * i_size must be checked after we know the pages are Uptodate.
+	 *
+	 * Checking i_size after the check allows us to calculate the correct
+	 * value for "nr_pages", which means the zero-filled part of the page is
+	 * not copied back to userspace (unless another truncate extends the
+	 * file - this is desired though).
+	 */
+	isize = i_size_read(mapping->host);
+	if (unlikely(iocb->ki_pos >= isize))
+		goto put_pages;
+
+	end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
+
+	while ((iocb->ki_pos >> PAGE_SHIFT) + nr_pages >
+	       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
+		put_page(pages[--nr_pages]);
+
+	/*
+	 * Once we start copying data, we don't want to be touching any
+	 * cachelines that might be contended:
+	 */
+	writably_mapped = mapping_writably_mapped(mapping);
+
+	/*
+	 * When a sequential read accesses a page several times, only mark it as
+	 * accessed the first time.
+	 */
+	if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
+		mark_page_accessed(pages[0]);
+	for (i = 1; i < nr_pages; i++)
+		mark_page_accessed(pages[i]);
+
+	for (i = 0; i < nr_pages; i++) {
+		unsigned offset = iocb->ki_pos & ~PAGE_MASK;
+		unsigned bytes = min_t(loff_t, end_offset - iocb->ki_pos,
+					       PAGE_SIZE - offset);
+		unsigned copied;
 
-no_cached_page:
 		/*
-		 * Ok, it wasn't cached, so we need to create a new
-		 * page..
+		 * If users can be writing to this page using arbitrary virtual
+		 * addresses, take care about potential aliasing before reading
+		 * the page on the kernel side.
 		 */
-		page = page_cache_alloc(mapping);
-		if (!page) {
-			error = -ENOMEM;
-			goto out;
-		}
-		error = add_to_page_cache_lru(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
-		if (error) {
-			put_page(page);
-			if (error == -EEXIST) {
-				error = 0;
-				goto find_page;
-			}
-			goto out;
-		}
-		goto readpage;
+		if (writably_mapped)
+			flush_dcache_page(pages[i]);
+
+		copied = copy_page_to_iter(pages[i], offset, bytes, iter);
+
+		iocb->ki_pos += copied;
+		ra->prev_pos = iocb->ki_pos;
+
+		if (copied < bytes)
+			return -EFAULT;
 	}
 
-would_block:
-	error = -EAGAIN;
-out:
-	ra->prev_pos = prev_index;
-	ra->prev_pos <<= PAGE_SHIFT;
-	ra->prev_pos |= prev_offset;
+put_pages:
+	for (i = 0; i < nr_pages; i++)
+		put_page(pages[i]);
+	return 0;
+}
+
+/**
+ * generic_file_buffered_read - generic file read routine
+ * @iocb:	the iocb to read
+ * @iter:	data destination
+ * @written:	already copied
+ *
+ * This is a generic file read routine, and uses the
+ * mapping->a_ops->readpage() function for the actual low-level stuff.
+ *
+ * Return:
+ * * total number of bytes copied, including those the were already @written
+ * * negative error code if nothing was copied
+ */
+ssize_t generic_file_buffered_read(struct kiocb *iocb,
+		struct iov_iter *iter, ssize_t written)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	size_t orig_count = iov_iter_count(iter);
+	struct inode *inode = mapping->host;
+	struct page *page_array[8], **pages = NULL;
+	unsigned max_pages = filemap_nr_pages(iocb, iter);
+	int error;
 
-	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
-	file_accessed(filp);
-	return written ? written : error;
+	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
+		return 0;
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+
+	if (max_pages > ARRAY_SIZE(page_array))
+		pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);
+
+	if (!pages) {
+		pages = page_array;
+		max_pages = ARRAY_SIZE(page_array);
+	}
+
+	do {
+		error = filemap_do_read(iocb, iter, pages, max_pages);
+		if (error)
+			break;
+	} while (iov_iter_count(iter) && iocb->ki_pos < i_size_read(inode));
+
+	file_accessed(iocb->ki_filp);
+	written += orig_count - iov_iter_count(iter);
+
+	if (pages != page_array)
+		kfree(pages);
+
+	if (unlikely(!written))
+		return error;
+	return written;
 }
 EXPORT_SYMBOL_GPL(generic_file_buffered_read);
 
