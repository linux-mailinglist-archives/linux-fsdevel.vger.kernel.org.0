Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7011F4AF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFJBgv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 21:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJBgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:36:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9FCC03E96B;
        Tue,  9 Jun 2020 18:36:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c14so568622qka.11;
        Tue, 09 Jun 2020 18:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGyQhDfsfKTE8zMF+xX5eLjOgjMMyuE6tyL+hvFU80E=;
        b=Kjv8bDscOs9b2dudADin8KDhUPxg7+cJl59CPvDztOe6irGvFt+1E3uNK2fIAlrcMI
         ZUmkZK8e1HSO9H641IUrSzlY8IJAeiSbBGjkJxgeGsGfvS3Kbb5U2+YczVZpOxLJ2tM6
         I6goEkS0zhWkiuspD5zbFIJsZjOxAB3Z+5vv36dIECjHJiYniI60Z9vm1m6Si7EBwK2O
         y4v8G26NPOvaReTxT1j4z+1OwHxyMh/01VL8oWEx1fB7kl7Ht6kntzOwTo6ELBGSdO2X
         OjKGPgY3/IBYgYgNurn6OSD91ndeIKqkfMHqW2pP8CL3Zmeqvx9NcC9FkBuu+lIRV6uq
         2LLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGyQhDfsfKTE8zMF+xX5eLjOgjMMyuE6tyL+hvFU80E=;
        b=kygdieAujmQiZLZet71kw+JYlzagIZMN1eZ7luVOPkHQdxWf4GSCCn5zlw5gvmurSX
         3hY8ZTB2+eY7HzUnKFIeXz+NZ1aBcnQc6JQwzOjm3vzjDuS7ODYLTJbBlcsgcRiyxwJI
         arRak19TXorSDU02vZ61dL9r6JULJbWzS/z90GcF8YKeoyW65c1lg2oFXo/YNivxxVzK
         u4AkT3mSdNZ8NgjSbikMzKXYY9/cjzY1ohGJ69dwn7Lo/r3ufgrWjrfZ2Qly63FOB+NW
         mpME/YW/6nJJ+5OO4eLIfDZh/I2R9noVHxWQUdPzOP3ZA8dz3igxDff4k/xYMNy11AGW
         Ourw==
X-Gm-Message-State: AOAM5302cp1qgq6kg/BUTTnMPYUPU4b9TsDU0IzNDtfaqPeF7QfZqzA4
        TapbKXkhNr8FbmAjgn3r4UFgpvc=
X-Google-Smtp-Source: ABdhPJzUpzuiXcrrhf09Wdmpl0wXmUDx8LWdOS0lzy0GXqwt/P4aYX6Lfwrtvli0MEp+NgjnU8ArQg==
X-Received: by 2002:ae9:f80e:: with SMTP id x14mr775553qkh.314.1591753009481;
        Tue, 09 Jun 2020 18:36:49 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id d23sm11513406qtn.38.2020.06.09.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 18:36:48 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 2/2] fs: generic_file_buffered_read() now uses find_get_pages_contig
Date:   Tue,  9 Jun 2020 21:36:42 -0400
Message-Id: <20200610013642.4171512-2-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610001036.3904844-1-kent.overstreet@gmail.com>
References: <20200610001036.3904844-1-kent.overstreet@gmail.com>
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
 mm/filemap.c | 276 +++++++++++++++++++++++++++++----------------------
 1 file changed, 155 insertions(+), 121 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 206d51a1c9..4fb0e5a238 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2051,67 +2051,6 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 	ra->ra_pages /= 4;
 }
 
-static int generic_file_buffered_read_page_ok(struct kiocb *iocb,
-			struct iov_iter *iter,
-			struct page *page)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	struct inode *inode = mapping->host;
-	struct file_ra_state *ra = &iocb->ki_filp->f_ra;
-	unsigned offset = iocb->ki_pos & ~PAGE_MASK;
-	unsigned bytes, copied;
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
@@ -2255,6 +2194,79 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 	return generic_file_buffered_read_readpage(filp, mapping, page);
 }
 
+static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
+						struct iov_iter *iter,
+						struct page **pages,
+						unsigned nr)
+{
+	struct file *filp = iocb->ki_filp;
+	struct address_space *mapping = filp->f_mapping;
+	struct file_ra_state *ra = &filp->f_ra;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
+	int i, j, ret, err = 0;
+
+	nr = min_t(unsigned long, last_index - index, nr);
+find_page:
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	ret = find_get_pages_contig(mapping, index, nr, pages);
+	if (ret)
+		goto got_pages;
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
+
+	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
+
+	ret = find_get_pages_contig(mapping, index, nr, pages);
+	if (ret)
+		goto got_pages;
+
+	pages[0] = generic_file_buffered_read_no_cached_page(iocb, iter);
+	err = PTR_ERR_OR_ZERO(pages[0]);
+	ret = !IS_ERR_OR_NULL(pages[0]);
+got_pages:
+	for (i = 0; i < ret; i++) {
+		struct page *page = pages[i];
+		pgoff_t pg_index = index +i;
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
+				for (j = i; j < ret; j++)
+					put_page(pages[j]);
+				ret = i;
+				err = -EAGAIN;
+				break;
+			}
+
+			page = generic_file_buffered_read_pagenotuptodate(filp,
+						iter, page, pg_pos, pg_count);
+			if (IS_ERR_OR_NULL(page)) {
+				for (j = i + 1; j < ret; j++)
+					put_page(pages[j]);
+				ret = i;
+				err = PTR_ERR_OR_ZERO(page);
+				break;
+			}
+		}
+	}
+
+	if (likely(ret))
+		return ret;
+	if (err)
+		return err;
+	goto find_page;
+}
+
 /**
  * generic_file_buffered_read - generic file read routine
  * @iocb:	the iocb to read
@@ -2275,86 +2287,108 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
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
+	struct page *page_array[8], **pages;
+	unsigned nr_pages = ARRAY_SIZE(page_array);
+	unsigned read_nr_pages = ((iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT) -
+		(iocb->ki_pos >> PAGE_SHIFT);
+	int i, pg_nr, error = 0;
+	bool writably_mapped;
+	loff_t isize, end_offset;
 
 	if (unlikely(iocb->ki_pos >= inode->i_sb->s_maxbytes))
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
-	last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-
-	for (;;) {
-		pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-		struct page *page;
+	if (read_nr_pages > nr_pages &&
+	    (pages = kmalloc_array(read_nr_pages, sizeof(void *), GFP_KERNEL)))
+		nr_pages = read_nr_pages;
+	else
+		pages = page_array;
 
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
+			unsigned offset = iocb->ki_pos & ~PAGE_MASK;
+			unsigned bytes = min_t(loff_t, end_offset - iocb->ki_pos,
+					       PAGE_SIZE - offset);
+			unsigned copied;
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
 
+	if (pages != page_array)
+		kfree(pages);
+
 	return written ? written : error;
 }
 
-- 
2.27.0

