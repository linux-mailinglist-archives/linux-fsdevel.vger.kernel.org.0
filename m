Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81C2000B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 05:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgFSDVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgFSDU5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 23:20:57 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F27BC0613EF;
        Thu, 18 Jun 2020 20:20:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y9so3838926qvs.4;
        Thu, 18 Jun 2020 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnUfbvlo6VWVeTxggebcHeUPQYZ34awyGqPoT8f5tdQ=;
        b=OJuQucSmDdDvbOQcYkT+Ro6wkZ3iJz3UrZJ5HM7ZR9Y4J2jkjdpw4leyns3gtdrUPx
         bH/ouzayC90Why4ZjZoaoTEwTTsbirer2VJ4+Heeh463rbyQNH8jC+PpOhGW3CdcUcRw
         TMZafBNx/rP31D9TqOQtkJIJTcSxWyZg7+huphZldFacXmKRLw9TbQQ1wazvPqdcX3uk
         kppaEzu+oPvXJ17YA2ggPm7R1NZKCbJT2gjTF7KHVE2YO/duFrAcLOeMgLBmkBVoX/gU
         4iIDG1aO0eTw8JEi8KST+IXYkjzQlLC2RVPyFqjrxaBFTG8LHl6B7efXGhl2wFjgWR75
         3FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnUfbvlo6VWVeTxggebcHeUPQYZ34awyGqPoT8f5tdQ=;
        b=r+3NAoR7uwVPRBSC3Q6qcaFfrGgTqv0Mnj3uIzfHKbRUYhquJH+hzTyUEvn8SjGEE5
         mGFHdLlQn+PCDeFxpRhbjq2iFD0RIEYvQU+RLjI+CanZJ3KU5Oa+pUiNyevMrM1etwE8
         W2uGqeSI7PBgpOluhVCtA4fLzsAeP4HgUr+eJ5p1aV+qEZRne6yKWCPAg+PwUuPdSjom
         2aRS9OqI+rW1pFaigu0f4RTehaoikuV+AMgGiYsb3a+z+BbACGZ596ECZFzZtPk6OLTp
         qMy5b/hfdoBQjeFsa+8DRbAz8GZ1HHJ6F/T9b8HmVyfq8QRj5+XDU/bfoIMWR/pHsczu
         3HRg==
X-Gm-Message-State: AOAM53122dXTK7PEVMLBSX8vX2wyq2yBYCk+LVZTAEWTdf95WkqxXQ8g
        78jWi846bpUS/I1GgXG44zo8qOM=
X-Google-Smtp-Source: ABdhPJy+EfSaOu8Mo+jIyi+YcEIQVyfbwbbz7mX9ijnSYkiqU1flKHPnSyK+y2I8fzGI0HVu00hEoA==
X-Received: by 2002:a0c:ffca:: with SMTP id h10mr6948986qvv.238.1592536855903;
        Thu, 18 Jun 2020 20:20:55 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id b185sm5081564qkg.86.2020.06.18.20.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:20:55 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/2] fs: generic_file_buffered_read() now uses find_get_pages_contig
Date:   Thu, 18 Jun 2020 23:20:49 -0400
Message-Id: <20200619032049.2687598-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
References: <20200617180558.9722e7337cbe3b88c4767126@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
 mm/filemap.c | 279 +++++++++++++++++++++++++++++----------------------
 1 file changed, 159 insertions(+), 120 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dc4a72042e..d8bd5e9647 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1975,67 +1975,6 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
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
 generic_file_buffered_read_readpage(struct file *filp,
 				    struct address_space *mapping,
@@ -2179,6 +2118,83 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	return generic_file_buffered_read_readpage(filp, mapping, page);
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
+	if (iocb->ki_flags & IOCB_NOWAIT)
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
+		if (PageReadahead(page))
+			page_cache_async_readahead(mapping, ra, filp, page,
+					pg_index, last_index - pg_index);
+
+		if (!PageUptodate(page)) {
+			if (iocb->ki_flags & IOCB_NOWAIT) {
+				for (j = i; j < nr_got; j++)
+					put_page(pages[j]);
+				nr_got = i;
+				err = -EAGAIN;
+				break;
+			}
+
+			page = generic_file_buffered_read_pagenotuptodate(filp,
+						iter, page, pg_pos, pg_count);
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
@@ -2199,86 +2215,109 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		struct iov_iter *iter, ssize_t written)
 {
 	struct file *filp = iocb->ki_filp;
+	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct file_ra_state *ra = &filp->f_ra;
 	size_t orig_count = iov_iter_count(iter);
-	pgoff_t last_index;
-	int error = 0;
+	struct page *pages_onstack[8], **pages = NULL;
+	unsigned int nr_pages = ((iocb->ki_pos + iter->count + PAGE_SIZE - 1) >> PAGE_SHIFT) -
+		(iocb->ki_pos >> PAGE_SHIFT);
+	int i, pg_nr, error = 0;
+	bool writably_mapped;
+	loff_t isize, end_offset;
 
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	if (nr_pages > ARRAY_SIZE(pages_onstack))
+		pages = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
 
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
 
-		page = find_get_page(mapping, index);
-		if (!page) {
-			if (iocb->ki_flags & IOCB_NOWAIT)
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
-			page_cache_async_readahead(mapping,
-					ra, filp, page,
-					index, last_index - index);
+		i = 0;
+		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
+							 pages, nr_pages);
+		if (pg_nr < 0) {
+			error = pg_nr;
+			break;
 		}
-		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
-				put_page(page);
-				error = -EAGAIN;
-				goto out;
-			}
 
-			page = generic_file_buffered_read_pagenotuptodate(filp,
-					iter, page, iocb->ki_pos, iter->count);
-			if (!page)
-				goto find_page;
-			if (IS_ERR(page)) {
-				error = PTR_ERR(page);
-				goto out;
-			}
-		}
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
 
-		error = generic_file_buffered_read_page_ok(iocb, iter, page);
-		put_page(page);
+		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
 
-		if (error) {
-			if (error > 0)
-				error = 0;
-			goto out;
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
 	written += orig_count - iov_iter_count(iter);
 
+	if (pages != pages_onstack)
+		kfree(pages);
+
 	return written ? written : error;
 }
 
-- 
2.26.2

