Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FC2000AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 05:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbgFSDVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbgFSDU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:20:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463BC0613EE;
        Thu, 18 Jun 2020 20:20:56 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so7787203qkl.0;
        Thu, 18 Jun 2020 20:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r2bkuAI1DD67DhYhXfCDN8jwDzsBFL0S7zXuPeGI0k0=;
        b=uopEQgiP0WvrEqm9kdrMJmVGua+jHl4vexjd/5cvbiuIQKZh4fmX6pUsLtkfFY27Pc
         aI5s4Igme0zJj46bxT0z7pIenXXUtSGYnTo0A2Vm8vO/w7tlq7flaHdeAnqR0eYhzq8k
         k5zWBR+OMRQdCTcCG2CEdZ+lMLPJjxFJtYztTpSwLNn4qd3OhuD2eRryIw3akv3rGtF6
         7NGaaClYYvpWihv6Xj2CgaWXwRCt/0dbcv28rZkc7ey7HFbTCtI+9glc7P+okkWgSY2/
         sHJ5Fs+IBsbau96786HOkdM4EUn9+2gnDyNc8EMNGixjI70Dy9lMRmQgEOi7pXhmkfd7
         InPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r2bkuAI1DD67DhYhXfCDN8jwDzsBFL0S7zXuPeGI0k0=;
        b=qDNYgrKf14/IzrScwtxMYP9pMA2HgX3AGNw1rkUJPP1xnlBfzJ9b+9+jkgbCOkkY8u
         2bi2BkMk4rIO9aXw6ZqNNV2456JAbIqaztM1KVkQwTo3COB6II53UspUlAtIcjb3kzlX
         JWR0OCqLq89sN75cTgpe33Nq/QQeT6Inm7c5BznzCFMmdAJO5DE+lE7eCs7l7PpF1TDD
         e196nlE8T3xV1vRlC2OV7ytr1Pa7bQlbrGki6CxQMo8cZ7upF7JRkfSK4GsiErc+Xf/s
         Y8w8vkfeoQTlmVsvF+9vwnRrmudZQgHvqJVySXqYgrEv+FfamN8Q/Kh4u5n+ARwCb+mn
         uH9g==
X-Gm-Message-State: AOAM530znn0mJTmUu/6Z0U/Nl2uVT0MXOHw0TxmfgWJ+kAmvfDt+4wlY
        C9ExRHsecxbKKr1LIuWrB/1C3zU=
X-Google-Smtp-Source: ABdhPJxyEtxrScZxwOyitYV/Vpyutv3iAI+Hbasi8q8a2qSUYatImvEK/DwGCXKl+mDEtYLeH4eTDg==
X-Received: by 2002:a37:6610:: with SMTP id a16mr1513381qkc.17.1592536854904;
        Thu, 18 Jun 2020 20:20:54 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id b185sm5081564qkg.86.2020.06.18.20.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:20:54 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/2] fs: Break generic_file_buffered_read up into multiple functions
Date:   Thu, 18 Jun 2020 23:20:48 -0400
Message-Id: <20200619032049.2687598-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
References: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is prep work for changing generic_file_buffered_read() to use
find_get_pages_contig() to batch up all the pagecache lookups.

This patch should be functionally identical to the existing code and
changes as little as of the flow control as possible. More refactoring
could be done, this patch is intended to be relatively minimal.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 418 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 228 insertions(+), 190 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 23a051a7ef..dc4a72042e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1975,6 +1975,210 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
+static int generic_file_buffered_read_page_ok(struct kiocb *iocb,
+			struct iov_iter *iter,
+			struct page *page)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct inode *inode = mapping->host;
+	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
+	unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
+	unsigned int bytes, copied;
+	loff_t isize, end_offset;
+
+	BUG_ON(iocb->ki_pos >> PAGE_SHIFT != page->index);
+
+	/*
+	 * i_size must be checked after we know the page is Uptodate.
+	 *
+	 * Checking i_size after the check allows us to calculate
+	 * the correct value for "bytes", which means the zero-filled
+	 * part of the page is not copied back to userspace (unless
+	 * another truncate extends the file - this is desired though).
+	 */
+
+	isize = i_size_read(inode);
+	if (unlikely(iocb->ki_pos >= isize))
+		return 1;
+
+	end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
+
+	bytes = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
+
+	/* If users can be writing to this page using arbitrary
+	 * virtual addresses, take care about potential aliasing
+	 * before reading the page on the kernel side.
+	 */
+	if (mapping_writably_mapped(mapping))
+		flush_dcache_page(page);
+
+	/*
+	 * Ok, we have the page, and it's up-to-date, so
+	 * now we can copy it to user space...
+	 */
+
+	copied = copy_page_to_iter(page, offset, bytes, iter);
+
+	iocb->ki_pos += copied;
+
+	/*
+	 * When a sequential read accesses a page several times,
+	 * only mark it as accessed the first time.
+	 */
+	if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
+		mark_page_accessed(page);
+
+	ra->prev_pos = iocb->ki_pos;
+
+	if (copied < bytes)
+		return -EFAULT;
+
+	return !iov_iter_count(iter) || iocb->ki_pos == isize;
+}
+
+static struct page *
+generic_file_buffered_read_readpage(struct file *filp,
+				    struct address_space *mapping,
+				    struct page *page)
+{
+	struct file_ra_state *ra = &filp->f_ra;
+	int error;
+
+	/*
+	 * A previous I/O error may have been due to temporary
+	 * failures, eg. multipath errors.
+	 * PG_error will be set again if readpage fails.
+	 */
+	ClearPageError(page);
+	/* Start the actual read. The read will unlock the page. */
+	error = mapping->a_ops->readpage(filp, page);
+
+	if (unlikely(error)) {
+		put_page(page);
+		return error != AOP_TRUNCATED_PAGE ? ERR_PTR(error) : NULL;
+	}
+
+	if (!PageUptodate(page)) {
+		error = lock_page_killable(page);
+		if (unlikely(error)) {
+			put_page(page);
+			return ERR_PTR(error);
+		}
+		if (!PageUptodate(page)) {
+			if (page->mapping == NULL) {
+				/*
+				 * invalidate_mapping_pages got it
+				 */
+				unlock_page(page);
+				put_page(page);
+				return NULL;
+			}
+			unlock_page(page);
+			shrink_readahead_size_eio(ra);
+			put_page(page);
+			return ERR_PTR(-EIO);
+		}
+		unlock_page(page);
+	}
+
+	return page;
+}
+
+static struct page *
+generic_file_buffered_read_pagenotuptodate(struct file *filp,
+					   struct iov_iter *iter,
+					   struct page *page,
+					   loff_t pos, loff_t count)
+{
+	struct address_space *mapping = filp->f_mapping;
+	struct inode *inode = mapping->host;
+	int error;
+
+	/*
+	 * See comment in do_read_cache_page on why
+	 * wait_on_page_locked is used to avoid unnecessarily
+	 * serialisations and why it's safe.
+	 */
+	error = wait_on_page_locked_killable(page);
+	if (unlikely(error)) {
+		put_page(page);
+		return ERR_PTR(error);
+	}
+
+	if (PageUptodate(page))
+		return page;
+
+	if (inode->i_blkbits == PAGE_SHIFT ||
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
+
+	if (!mapping->a_ops->is_partially_uptodate(page,
+				pos & ~PAGE_MASK, count))
+		goto page_not_up_to_date_locked;
+	unlock_page(page);
+	return page;
+
+page_not_up_to_date:
+	/* Get exclusive access to the page ... */
+	error = lock_page_killable(page);
+	if (unlikely(error)) {
+		put_page(page);
+		return ERR_PTR(error);
+	}
+
+page_not_up_to_date_locked:
+	/* Did it get truncated before we got the lock? */
+	if (!page->mapping) {
+		unlock_page(page);
+		put_page(page);
+		return NULL;
+	}
+
+	/* Did somebody else fill it already? */
+	if (PageUptodate(page)) {
+		unlock_page(page);
+		return page;
+	}
+
+	return generic_file_buffered_read_readpage(filp, mapping, page);
+}
+
+static struct page *
+generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
+					  struct iov_iter *iter)
+{
+	struct file *filp = iocb->ki_filp;
+	struct address_space *mapping = filp->f_mapping;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	struct page *page;
+	int error;
+
+	/*
+	 * Ok, it wasn't cached, so we need to create a new
+	 * page..
+	 */
+	page = page_cache_alloc(mapping);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	error = add_to_page_cache_lru(page, mapping, index,
+				      mapping_gfp_constraint(mapping, GFP_KERNEL));
+	if (error) {
+		put_page(page);
+		return error != -EEXIST ? ERR_PTR(error) : NULL;
+	}
+
+	return generic_file_buffered_read_readpage(filp, mapping, page);
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -1998,29 +2202,19 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
 	struct file_ra_state *ra = &filp->f_ra;
-	loff_t *ppos = &iocb->ki_pos;
-	pgoff_t index;
+	size_t orig_count = iov_iter_count(iter);
 	pgoff_t last_index;
-	pgoff_t prev_index;
-	unsigned long offset;      /* offset into pagecache page */
-	unsigned int prev_offset;
 	int error = 0;
 
-	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
+	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	index = *ppos >> PAGE_SHIFT;
-	prev_index = ra->prev_pos >> PAGE_SHIFT;
-	prev_offset = ra->prev_pos & (PAGE_SIZE-1);
-	last_index = (*ppos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
 
 	for (;;) {
+		pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 		struct page *page;
-		pgoff_t end_index;
-		loff_t isize;
-		unsigned long nr, ret;
 
 		cond_resched();
 find_page:
@@ -2037,8 +2231,15 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					ra, filp,
 					index, last_index - index);
 			page = find_get_page(mapping, index);
-			if (unlikely(page == NULL))
-				goto no_cached_page;
+			if (unlikely(page == NULL)) {
+				page = generic_file_buffered_read_no_cached_page(iocb, iter);
+				if (!page)
+					goto find_page;
+				if (IS_ERR(page)) {
+					error = PTR_ERR(page);
+					goto out;
+				}
+			}
 		}
 		if (PageReadahead(page)) {
 			page_cache_async_readahead(mapping,
@@ -2048,199 +2249,36 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		if (!PageUptodate(page)) {
 			if (iocb->ki_flags & IOCB_NOWAIT) {
 				put_page(page);
-				goto would_block;
-			}
-
-			/*
-			 * See comment in do_read_cache_page on why
-			 * wait_on_page_locked is used to avoid unnecessarily
-			 * serialisations and why it's safe.
-			 */
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
-		}
-page_ok:
-		/*
-		 * i_size must be checked after we know the page is Uptodate.
-		 *
-		 * Checking i_size after the check allows us to calculate
-		 * the correct value for "nr", which means the zero-filled
-		 * part of the page is not copied back to userspace (unless
-		 * another truncate extends the file - this is desired though).
-		 */
-
-		isize = i_size_read(inode);
-		end_index = (isize - 1) >> PAGE_SHIFT;
-		if (unlikely(!isize || index > end_index)) {
-			put_page(page);
-			goto out;
-		}
-
-		/* nr is the maximum number of bytes to copy from this page */
-		nr = PAGE_SIZE;
-		if (index == end_index) {
-			nr = ((isize - 1) & ~PAGE_MASK) + 1;
-			if (nr <= offset) {
-				put_page(page);
+				error = -EAGAIN;
 				goto out;
 			}
-		}
-		nr = nr - offset;
-
-		/* If users can be writing to this page using arbitrary
-		 * virtual addresses, take care about potential aliasing
-		 * before reading the page on the kernel side.
-		 */
-		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
-
-		/*
-		 * When a sequential read accesses a page several times,
-		 * only mark it as accessed the first time.
-		 */
-		if (prev_index != index || offset != prev_offset)
-			mark_page_accessed(page);
-		prev_index = index;
-
-		/*
-		 * Ok, we have the page, and it's up-to-date, so
-		 * now we can copy it to user space...
-		 */
-
-		ret = copy_page_to_iter(page, offset, nr, iter);
-		offset += ret;
-		index += offset >> PAGE_SHIFT;
-		offset &= ~PAGE_MASK;
-		prev_offset = offset;
 
-		put_page(page);
-		written += ret;
-		if (!iov_iter_count(iter))
-			goto out;
-		if (ret < nr) {
-			error = -EFAULT;
-			goto out;
-		}
-		continue;
-
-page_not_up_to_date:
-		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
-		if (unlikely(error))
-			goto readpage_error;
-
-page_not_up_to_date_locked:
-		/* Did it get truncated before we got the lock? */
-		if (!page->mapping) {
-			unlock_page(page);
-			put_page(page);
-			continue;
-		}
-
-		/* Did somebody else fill it already? */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			goto page_ok;
-		}
-
-readpage:
-		/*
-		 * A previous I/O error may have been due to temporary
-		 * failures, eg. multipath errors.
-		 * PG_error will be set again if readpage fails.
-		 */
-		ClearPageError(page);
-		/* Start the actual read. The read will unlock the page. */
-		error = mapping->a_ops->readpage(filp, page);
-
-		if (unlikely(error)) {
-			if (error == AOP_TRUNCATED_PAGE) {
-				put_page(page);
-				error = 0;
+			page = generic_file_buffered_read_pagenotuptodate(filp,
+					iter, page, iocb->ki_pos, iter->count);
+			if (!page)
 				goto find_page;
+			if (IS_ERR(page)) {
+				error = PTR_ERR(page);
+				goto out;
 			}
-			goto readpage_error;
-		}
-
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
 		}
 
-		goto page_ok;
-
-readpage_error:
-		/* UHHUH! A synchronous read error occurred. Report it */
+		error = generic_file_buffered_read_page_ok(iocb, iter, page);
 		put_page(page);
-		goto out;
 
-no_cached_page:
-		/*
-		 * Ok, it wasn't cached, so we need to create a new
-		 * page..
-		 */
-		page = page_cache_alloc(mapping);
-		if (!page) {
-			error = -ENOMEM;
-			goto out;
-		}
-		error = add_to_page_cache_lru(page, mapping, index,
-				mapping_gfp_constraint(mapping, GFP_KERNEL));
 		if (error) {
-			put_page(page);
-			if (error == -EEXIST) {
+			if (error > 0)
 				error = 0;
-				goto find_page;
-			}
 			goto out;
 		}
-		goto readpage;
 	}
 
 would_block:
 	error = -EAGAIN;
 out:
-	ra->prev_pos = prev_index;
-	ra->prev_pos <<= PAGE_SHIFT;
-	ra->prev_pos |= prev_offset;
-
-	*ppos = ((loff_t)index << PAGE_SHIFT) + offset;
 	file_accessed(filp);
+	written += orig_count - iov_iter_count(iter);
+
 	return written ? written : error;
 }
 
-- 
2.26.2

