Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24B2983B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418915AbgJYVaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 17:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418890AbgJYVaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 17:30:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC9CC061755;
        Sun, 25 Oct 2020 14:30:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z33so5384394qth.8;
        Sun, 25 Oct 2020 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kGdtnjCAvf0Iq+Bue3UeGKF21sgOzrGsHxS54xhzcE=;
        b=Bf0tuLI35vfE13HcwHZ+wcQkUwhAU7Ye+UG/JsUuuTjcyOlkGuRoPwiHLKqkVO+qDY
         LZ/vIiAltiUegA7q3C8zR/ap+ylG5/6J/FOS5NY2PDRZUaQ2BYOAvbd4Xn2BKOGx3aBs
         sG9AhE5k2tmCQBq0WacvrJbIJorBhBEisXmSEqrwPorhZTnvdMihqXk57filU1EqC4hc
         taDKZEq/Sa2rQAqi/qOKgqzYEIVcP0cvrpN5ympsBGu5Ca7Q/3G1bJXo9Yhq6hqcXOMd
         Or8ZzndrlvE2gROJ8WMXA3ezPXsOcc+K6F/5VUc9ka9J6u1PWiaV3JDBjjH3YZiIXPmI
         MDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4kGdtnjCAvf0Iq+Bue3UeGKF21sgOzrGsHxS54xhzcE=;
        b=LwLagAJLlc+ai/m14ps0SMT+opC59CpMmhjSx64sCq+eJO4RnvXczBzgbPXxkRetx6
         XedC3kKWDxGSovIzWbUDi19eXihnvdepiSevMD2g64HJ1Rh8KXFoQF2yd8i0YarYq/cH
         28smWK2VABZ3N/7148d7vfk+Zq3dhZaINPJ1PCXXwX0YUAfDO0mGr38G9MucR1CMa2e9
         BRnEEh12bKbeB1YLnCTuFmyyTRbGGSzIp7GAXgkOWe0Z1xHU5Bne9T6xTIyaeU2qcku8
         nKraghDuAhjV+kmJoDgKdlZG767WfVsenoezBiquch3LZdSpAimmBk32Gh2LDW8oBIlm
         khQQ==
X-Gm-Message-State: AOAM531JLP2XX0sTnV2EQu8brct9/sCt0ZPqMwW2244aIdaSi6MFhQr6
        Aoo1HZ9UgKGfIU7v5bKG7Ab41LFblg==
X-Google-Smtp-Source: ABdhPJymJDytMZTG0YvtnjADpMF91BDQFmLh5f/zgHBwXqWQwbT5/EFRFG5AelBCIE5xf5r6X2jeKA==
X-Received: by 2002:ac8:5cc8:: with SMTP id s8mr13103034qta.58.1603661405610;
        Sun, 25 Oct 2020 14:30:05 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id a200sm5352221qkb.66.2020.10.25.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:30:03 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, axboe@kernel.dk,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fs: generic_file_buffered_read() now uses find_get_pages_contig
Date:   Sun, 25 Oct 2020 17:29:49 -0400
Message-Id: <20201025212949.602194-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025212949.602194-1-kent.overstreet@gmail.com>
References: <20201025212949.602194-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert generic_file_buffered_read() to get pages to read from in
batches, and then copy data to userspace from many pages at once - in
particular, we now don't touch any cachelines that might be contended
while we're in the loop to copy data to userspace.

This is is a performance improvement on workloads that do buffered reads
with large blocksizes, and a very large performance improvement if that
file is also being accessed concurrently by different threads.

On smaller reads (512 bytes), there's a very small performance
improvement (1%, within the margin of error).

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 mm/filemap.c | 313 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 175 insertions(+), 138 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index cc0f58a249..1bf1f424cb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2168,67 +2168,6 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static int generic_file_buffered_read_page_ok(struct kiocb *iocb,
-			struct iov_iter *iter,
-			struct page *page)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
-	unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
-	unsigned int bytes, copied;
-	loff_t isize, end_offset;
-
-	BUG_ON(iocb->ki_pos >> PAGE_SHIFT != page->index);
-
-	/*
-	 * i_size must be checked after we know the page is Uptodate.
-	 *
-	 * Checking i_size after the check allows us to calculate
-	 * the correct value for "bytes", which means the zero-filled
-	 * part of the page is not copied back to userspace (unless
-	 * another truncate extends the file - this is desired though).
-	 */
-
-	isize = i_size_read(inode);
-	if (unlikely(iocb->ki_pos >= isize))
-		return 1;
-
-	end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
-
-	bytes = min_t(loff_t, end_offset - iocb->ki_pos, PAGE_SIZE - offset);
-
-	/* If users can be writing to this page using arbitrary
-	 * virtual addresses, take care about potential aliasing
-	 * before reading the page on the kernel side.
-	 */
-	if (mapping_writably_mapped(mapping))
-		flush_dcache_page(page);
-
-	/*
-	 * Ok, we have the page, and it's up-to-date, so
-	 * now we can copy it to user space...
-	 */
-
-	copied = copy_page_to_iter(page, offset, bytes, iter);
-
-	iocb->ki_pos += copied;
-
-	/*
-	 * When a sequential read accesses a page several times,
-	 * only mark it as accessed the first time.
-	 */
-	if (iocb->ki_pos >> PAGE_SHIFT != ra->prev_pos >> PAGE_SHIFT)
-		mark_page_accessed(page);
-
-	ra->prev_pos = iocb->ki_pos;
-
-	if (copied < bytes)
-		return -EFAULT;
-
-	return !iov_iter_count(iter) || iocb->ki_pos == isize;
-}
-
 static struct page *
 generic_file_buffered_read_readpage(struct kiocb *iocb,
 				    struct file *filp,
@@ -2386,6 +2325,92 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
 }
 
+static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
+						struct iov_iter *iter,
+						struct page **pages,
+						unsigned int nr)
+{
+	struct file *filp = iocb->ki_filp;
+	struct address_space *mapping = filp->f_mapping;
+	struct file_ra_state *ra = &filp->f_ra;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	int i, j, nr_got, err = 0;
+
+	nr = min_t(unsigned long, last_index - index, nr);
+find_page:
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	if (nr_got)
+		goto got_pages;
+
+	if (iocb->ki_flags & IOCB_NOIO)
+		return -EAGAIN;
+
+	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
+
+	nr_got = find_get_pages_contig(mapping, index, nr, pages);
+	if (nr_got)
+		goto got_pages;
+
+	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	err = PTR_ERR_OR_ZERO(pages[0]);
+	if (!IS_ERR_OR_NULL(pages[0]))
+		nr_got = 1;
+got_pages:
+	for (i = 0; i < nr_got; i++) {
+		struct page *page = pages[i];
+		pgoff_t pg_index = index + i;
+		loff_t pg_pos = max(iocb->ki_pos,
+				    (loff_t) pg_index << PAGE_SHIFT);
+		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
+
+		if (PageReadahead(page)) {
+			if (iocb->ki_flags & IOCB_NOIO) {
+				for (j = i; j < nr_got; j++)
+					put_page(pages[j]);
+				nr_got = i;
+				err = -EAGAIN;
+				break;
+			}
+			page_cache_async_readahead(mapping, ra, filp, page,
+					pg_index, last_index - pg_index);
+		}
+
+		if (!PageUptodate(page)) {
+			if ((iocb->ki_flags & IOCB_NOWAIT) ||
+			    ((iocb->ki_flags & IOCB_WAITQ) && i)) {
+				for (j = i; j < nr_got; j++)
+					put_page(pages[j]);
+				nr_got = i;
+				err = -EAGAIN;
+				break;
+			}
+
+			page = generic_file_buffered_read_pagenotuptodate(iocb,
+					filp, iter, page, pg_pos, pg_count);
+			if (IS_ERR_OR_NULL(page)) {
+				for (j = i + 1; j < nr_got; j++)
+					put_page(pages[j]);
+				nr_got = i;
+				err = PTR_ERR_OR_ZERO(page);
+				break;
+			}
+		}
+	}
+
+	if (likely(nr_got))
+		return nr_got;
+	if (err)
+		return err;
+	/*
+	 * No pages and no error means we raced and should retry:
+	 */
+	goto find_page;
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2406,104 +2431,116 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *iter, ssize_t written)
 {
 	struct file *filp = iocb->ki_filp;
+	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct file_ra_state *ra = &filp->f_ra;
-	size_t orig_count = iov_iter_count(iter);
-	pgoff_t last_index;
-	int error = 0;
+	struct page *pages_onstack[PAGEVEC_SIZE], **pages = NULL;
+	unsigned int nr_pages = min_t(unsigned int, 512,
+			((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
+			(iocb->ki_pos >> PAGE_SHIFT));
+	int i, pg_nr, error = 0;
+	bool writably_mapped;
+	loff_t isize, end_offset;
 
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	if (nr_pages > ARRAY_SIZE(pages_onstack))
+		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
 
-	/*
-	 * If we've already successfully copied some data, then we
-	 * can no longer safely return -EIOCBQUEUED. Hence mark
-	 * an async read NOWAIT at that point.
-	 */
-	if (written && (iocb->ki_flags & IOCB_WAITQ))
-		iocb->ki_flags |= IOCB_NOWAIT;
-
-	for (;;) {
-		pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-		struct page *page;
+	if (!pages) {
+		pages = pages_onstack;
+		nr_pages = min_t(unsigned int, nr_pages, ARRAY_SIZE(pages_onstack));
+	}
 
+	do {
 		cond_resched();
-find_page:
-		if (fatal_signal_pending(current)) {
-			error = -EINTR;
-			goto out;
-		}
 
 		/*
-		 * We can't return -EIOCBQUEUED once we've done some work, so
-		 * ensure we don't block:
+		 * If we've already successfully copied some data, then we
+		 * can no longer safely return -EIOCBQUEUED. Hence mark
+		 * an async read NOWAIT at that point.
 		 */
-		if ((iocb->ki_flags & IOCB_WAITQ) &&
-		    (written + orig_count - iov_iter_count(iter)))
+		if ((iocb->ki_flags & IOCB_WAITQ) && written)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		page = find_get_page(mapping, index);
-		if (!page) {
-			if (iocb->ki_flags & IOCB_NOIO)
-				goto would_block;
-			page_cache_sync_readahead(mapping,
-					ra, filp,
-					index, last_index - index);
-			page = find_get_page(mapping, index);
-			if (unlikely(page == NULL)) {
-				page = generic_file_buffered_read_no_cached_page(iocb, iter);
-				if (!page)
-					goto find_page;
-				if (IS_ERR(page)) {
-					error = PTR_ERR(page);
-					goto out;
-				}
-			}
-		}
-		if (PageReadahead(page)) {
-			if (iocb->ki_flags & IOCB_NOIO) {
-				put_page(page);
-				goto out;
-			}
-			page_cache_async_readahead(mapping,
-					ra, filp, page,
-					index, last_index - index);
-		}
-		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
-				put_page(page);
-				error = -EAGAIN;
-				goto out;
-			}
-			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, iocb->ki_pos, iter->count);
-			if (!page)
-				goto find_page;
-			if (IS_ERR(page)) {
-				error = PTR_ERR(page);
-				goto out;
-			}
+		i = 0;
+		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
+							     pages, nr_pages);
+		if (pg_nr < 0) {
+			error = pg_nr;
+			break;
 		}
 
-		error = generic_file_buffered_read_page_ok(iocb, iter, page);
-		put_page(page);
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize = i_size_read(inode);
+		if (unlikely(iocb->ki_pos >= isize))
+			goto put_pages;
 
-		if (error) {
-			if (error > 0)
-				error = 0;
-			goto out;
+		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
+
+		while ((iocb->ki_pos >> PAGE_SHIFT) + pg_nr >
+		       (end_offset + PAGE_SIZE - 1) >> PAGE_SHIFT)
+			put_page(pages[--pg_nr]);
+
+		/*
+		 * Once we start copying data, we don't want to be touching any
+		 * cachelines that might be contended:
+		 */
+		writably_mapped = mapping_writably_mapped(mapping);
+
+		/*
+		 * When a sequential read accesses a page several times, only
+		 * mark it as accessed the first time.
+		 */
+		if (iocb->ki_pos >> PAGE_SHIFT !=
+		    ra->prev_pos >> PAGE_SHIFT)
+			mark_page_accessed(pages[0]);
+		for (i = 1; i < pg_nr; i++)
+			mark_page_accessed(pages[i]);
+
+		for (i = 0; i < pg_nr; i++) {
+			unsigned int offset = iocb->ki_pos & ~PAGE_MASK;
+			unsigned int bytes = min_t(loff_t, end_offset - iocb->ki_pos,
+						   PAGE_SIZE - offset);
+			unsigned int copied;
+
+			/*
+			 * If users can be writing to this page using arbitrary
+			 * virtual addresses, take care about potential aliasing
+			 * before reading the page on the kernel side.
+			 */
+			if (writably_mapped)
+				flush_dcache_page(pages[i]);
+
+			copied = copy_page_to_iter(pages[i], offset, bytes, iter);
+
+			written += copied;
+			iocb->ki_pos += copied;
+			ra->prev_pos = iocb->ki_pos;
+
+			if (copied < bytes) {
+				error = -EFAULT;
+				break;
+			}
 		}
-	}
+put_pages:
+		for (i = 0; i < pg_nr; i++)
+			put_page(pages[i]);
+	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
-would_block:
-	error = -EAGAIN;
-out:
 	file_accessed(filp);
-	written += orig_count - iov_iter_count(iter);
+
+	if (pages != pages_onstack)
+		kfree(pages);
 
 	return written ? written : error;
 }
-- 
2.28.0

