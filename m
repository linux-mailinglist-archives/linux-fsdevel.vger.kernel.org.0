Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14565C1A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfGARCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59300 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGARCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnUIk089740;
        Mon, 1 Jul 2019 17:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=avzHZUdRCXW2OAOhM04+5qk/N2zMzEyIzf4RCBT+NmQ=;
 b=nlW76py78mA8D+E3JQ/X5Ps/CWupASxXS2ayrlwcXDsyIcXpTjjfuFoYqsWiCHVnW6U8
 8m89UuhS1AsGBhgoYus9YGrI/8QUSytIJ1inhQ3gMc3Ep4WpYuXiP3kvlatJmm3UzXDC
 hkZQIUX0kiomREMMjP0oRswYcMJC2+30vvbuW/Rv9l0JCQzDyvoR7vtXj+G6gDWIroQh
 37F8WMrew6DCxWxR8WoU+lnOG3RAFIBrBxjFxXpPSxtJHcHRBhWrhEwDzgRWbjxIrQOh
 YvvQaQcGoyLPkAEmLkcunxYoyOqsRvQaeV8hX9vSmCM/pMVW/EVpG87dkLkQeO9LJX+7 Nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2te5tbevhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmMrL154190;
        Mon, 1 Jul 2019 17:02:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tebqg1h1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:41 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H2eqs030387;
        Mon, 1 Jul 2019 17:02:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:39 -0700
Subject: [PATCH 06/11] iomap: move the buffered write code into a separate
 file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:38 -0700
Message-ID: <156200055882.1790352.17262705352412179415.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the buffered write code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c                |  529 --------------------------------------------
 fs/iomap/Makefile         |    3 
 fs/iomap/iomap_internal.h |    6 
 fs/iomap/write.c          |  542 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 554 insertions(+), 526 deletions(-)
 create mode 100644 fs/iomap/write.c


diff --git a/fs/iomap.c b/fs/iomap.c
index 550bde00ae34..72db8a6c0292 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -97,7 +97,7 @@ iomap_sector(struct iomap *iomap, loff_t pos)
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
 }
 
-static struct iomap_page *
+struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
@@ -138,7 +138,7 @@ iomap_page_release(struct page *page)
 /*
  * Calculate the range inside the page that we actually need to read.
  */
-static void
+void
 iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
 {
@@ -195,7 +195,7 @@ iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
 	*lenp = plen;
 }
 
-static void
+void
 iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
 	struct iomap_page *iop = to_iomap_page(page);
@@ -261,7 +261,7 @@ struct iomap_readpage_ctx {
 	struct list_head	*pages;
 };
 
-static void
+void
 iomap_read_inline_data(struct inode *inode, struct page *page,
 		struct iomap *iomap)
 {
@@ -585,124 +585,6 @@ iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 EXPORT_SYMBOL_GPL(iomap_migrate_page);
 #endif /* CONFIG_MIGRATION */
 
-static void
-iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
-{
-	loff_t i_size = i_size_read(inode);
-
-	/*
-	 * Only truncate newly allocated pages beyoned EOF, even if the
-	 * write started inside the existing inode size.
-	 */
-	if (pos + len > i_size)
-		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
-}
-
-static int
-iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
-		unsigned poff, unsigned plen, unsigned from, unsigned to,
-		struct iomap *iomap)
-{
-	struct bio_vec bvec;
-	struct bio bio;
-
-	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
-		zero_user_segments(page, poff, from, to, poff + plen);
-		iomap_set_range_uptodate(page, poff, plen);
-		return 0;
-	}
-
-	bio_init(&bio, &bvec, 1);
-	bio.bi_opf = REQ_OP_READ;
-	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
-	bio_set_dev(&bio, iomap->bdev);
-	__bio_add_page(&bio, page, plen, poff);
-	return submit_bio_wait(&bio);
-}
-
-static int
-__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
-		struct page *page, struct iomap *iomap)
-{
-	struct iomap_page *iop = iomap_page_create(inode, page);
-	loff_t block_size = i_blocksize(inode);
-	loff_t block_start = pos & ~(block_size - 1);
-	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
-	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
-	int status = 0;
-
-	if (PageUptodate(page))
-		return 0;
-
-	do {
-		iomap_adjust_read_range(inode, iop, &block_start,
-				block_end - block_start, &poff, &plen);
-		if (plen == 0)
-			break;
-
-		if ((from > poff && from < poff + plen) ||
-		    (to > poff && to < poff + plen)) {
-			status = iomap_read_page_sync(inode, block_start, page,
-					poff, plen, from, to, iomap);
-			if (status)
-				break;
-		}
-
-	} while ((block_start += plen) < block_end);
-
-	return status;
-}
-
-static int
-iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, struct iomap *iomap)
-{
-	const struct iomap_page_ops *page_ops = iomap->page_ops;
-	pgoff_t index = pos >> PAGE_SHIFT;
-	struct page *page;
-	int status = 0;
-
-	BUG_ON(pos + len > iomap->offset + iomap->length);
-
-	if (fatal_signal_pending(current))
-		return -EINTR;
-
-	if (page_ops && page_ops->page_prepare) {
-		status = page_ops->page_prepare(inode, pos, len, iomap);
-		if (status)
-			return status;
-	}
-
-	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
-	if (!page) {
-		status = -ENOMEM;
-		goto out_no_page;
-	}
-
-	if (iomap->type == IOMAP_INLINE)
-		iomap_read_inline_data(inode, page, iomap);
-	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
-		status = __block_write_begin_int(page, pos, len, NULL, iomap);
-	else
-		status = __iomap_write_begin(inode, pos, len, page, iomap);
-
-	if (unlikely(status))
-		goto out_unlock;
-
-	*pagep = page;
-	return 0;
-
-out_unlock:
-	unlock_page(page);
-	put_page(page);
-	iomap_write_failed(inode, pos, len);
-
-out_no_page:
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, 0, NULL, iomap);
-	return status;
-}
-
 int
 iomap_set_page_dirty(struct page *page)
 {
@@ -728,347 +610,6 @@ iomap_set_page_dirty(struct page *page)
 }
 EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
-static int
-__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page, struct iomap *iomap)
-{
-	flush_dcache_page(page);
-
-	/*
-	 * The blocks that were entirely written will now be uptodate, so we
-	 * don't have to worry about a readpage reading them and overwriting a
-	 * partial write.  However if we have encountered a short write and only
-	 * partially written into a block, it will not be marked uptodate, so a
-	 * readpage might come in and destroy our partial write.
-	 *
-	 * Do the simplest thing, and just treat any short write to a non
-	 * uptodate page as a zero-length write, and force the caller to redo
-	 * the whole thing.
-	 */
-	if (unlikely(copied < len && !PageUptodate(page)))
-		return 0;
-	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
-	return copied;
-}
-
-static int
-iomap_write_end_inline(struct inode *inode, struct page *page,
-		struct iomap *iomap, loff_t pos, unsigned copied)
-{
-	void *addr;
-
-	WARN_ON_ONCE(!PageUptodate(page));
-	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
-
-	addr = kmap_atomic(page);
-	memcpy(iomap->inline_data + pos, addr + pos, copied);
-	kunmap_atomic(addr);
-
-	mark_inode_dirty(inode);
-	return copied;
-}
-
-static int
-iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page, struct iomap *iomap)
-{
-	const struct iomap_page_ops *page_ops = iomap->page_ops;
-	loff_t old_size = inode->i_size;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
-	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
-				page, NULL);
-	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
-	}
-
-	/*
-	 * Update the in-memory inode size after copying the data into the page
-	 * cache.  It's up to the file system to write the updated size to disk,
-	 * preferably after I/O completion so that no stale data is exposed.
-	 */
-	if (pos + ret > old_size) {
-		i_size_write(inode, pos + ret);
-		iomap->flags |= IOMAP_F_SIZE_CHANGED;
-	}
-	unlock_page(page);
-
-	if (old_size < pos)
-		pagecache_isize_extended(inode, old_size, pos);
-	if (page_ops && page_ops->page_done)
-		page_ops->page_done(inode, pos, ret, page, iomap);
-	put_page(page);
-
-	if (ret < len)
-		iomap_write_failed(inode, pos, len);
-	return ret;
-}
-
-static loff_t
-iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap)
-{
-	struct iov_iter *i = data;
-	long status = 0;
-	ssize_t written = 0;
-	unsigned int flags = AOP_FLAG_NOFS;
-
-	do {
-		struct page *page;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
-		size_t copied;		/* Bytes copied from user */
-
-		offset = offset_in_page(pos);
-		bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_count(i));
-again:
-		if (bytes > length)
-			bytes = length;
-
-		/*
-		 * Bring in the user page that we will copy from _first_.
-		 * Otherwise there's a nasty deadlock on copying from the
-		 * same page as we're writing to, without it being marked
-		 * up-to-date.
-		 *
-		 * Not only is this an optimisation, but it is also required
-		 * to check that the address is actually valid, when atomic
-		 * usercopies are used, below.
-		 */
-		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
-			status = -EFAULT;
-			break;
-		}
-
-		status = iomap_write_begin(inode, pos, bytes, flags, &page,
-				iomap);
-		if (unlikely(status))
-			break;
-
-		if (mapping_writably_mapped(inode->i_mapping))
-			flush_dcache_page(page);
-
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
-
-		flush_dcache_page(page);
-
-		status = iomap_write_end(inode, pos, bytes, copied, page,
-				iomap);
-		if (unlikely(status < 0))
-			break;
-		copied = status;
-
-		cond_resched();
-
-		iov_iter_advance(i, copied);
-		if (unlikely(copied == 0)) {
-			/*
-			 * If we were unable to copy any data at all, we must
-			 * fall back to a single segment length write.
-			 *
-			 * If we didn't fallback here, we could livelock
-			 * because not all segments in the iov can be copied at
-			 * once without a pagefault.
-			 */
-			bytes = min_t(unsigned long, PAGE_SIZE - offset,
-						iov_iter_single_seg_count(i));
-			goto again;
-		}
-		pos += copied;
-		written += copied;
-		length -= copied;
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
-	} while (iov_iter_count(i) && length);
-
-	return written ? written : status;
-}
-
-ssize_t
-iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
-		const struct iomap_ops *ops)
-{
-	struct inode *inode = iocb->ki_filp->f_mapping->host;
-	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
-
-	while (iov_iter_count(iter)) {
-		ret = iomap_apply(inode, pos, iov_iter_count(iter),
-				IOMAP_WRITE, ops, iter, iomap_write_actor);
-		if (ret <= 0)
-			break;
-		pos += ret;
-		written += ret;
-	}
-
-	return written ? written : ret;
-}
-EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
-
-static struct page *
-__iomap_read_page(struct inode *inode, loff_t offset)
-{
-	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
-
-	page = read_mapping_page(mapping, offset >> PAGE_SHIFT, NULL);
-	if (IS_ERR(page))
-		return page;
-	if (!PageUptodate(page)) {
-		put_page(page);
-		return ERR_PTR(-EIO);
-	}
-	return page;
-}
-
-static loff_t
-iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap)
-{
-	long status = 0;
-	ssize_t written = 0;
-
-	do {
-		struct page *page, *rpage;
-		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long bytes;	/* Bytes to write to page */
-
-		offset = offset_in_page(pos);
-		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
-
-		rpage = __iomap_read_page(inode, pos);
-		if (IS_ERR(rpage))
-			return PTR_ERR(rpage);
-
-		status = iomap_write_begin(inode, pos, bytes,
-					   AOP_FLAG_NOFS, &page, iomap);
-		put_page(rpage);
-		if (unlikely(status))
-			return status;
-
-		WARN_ON_ONCE(!PageUptodate(page));
-
-		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
-		if (unlikely(status <= 0)) {
-			if (WARN_ON_ONCE(status == 0))
-				return -EIO;
-			return status;
-		}
-
-		cond_resched();
-
-		pos += status;
-		written += status;
-		length -= status;
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
-	} while (length);
-
-	return written;
-}
-
-int
-iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
-		const struct iomap_ops *ops)
-{
-	loff_t ret;
-
-	while (len) {
-		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
-				iomap_dirty_actor);
-		if (ret <= 0)
-			return ret;
-		pos += ret;
-		len -= ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_file_dirty);
-
-static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap)
-{
-	struct page *page;
-	int status;
-
-	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
-				   iomap);
-	if (status)
-		return status;
-
-	zero_user(page, offset, bytes);
-	mark_page_accessed(page);
-
-	return iomap_write_end(inode, pos, bytes, bytes, page, iomap);
-}
-
-static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
-		struct iomap *iomap)
-{
-	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
-			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
-}
-
-static loff_t
-iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
-		void *data, struct iomap *iomap)
-{
-	bool *did_zero = data;
-	loff_t written = 0;
-	int status;
-
-	/* already zeroed?  we're done. */
-	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
-	    	return count;
-
-	do {
-		unsigned offset, bytes;
-
-		offset = offset_in_page(pos);
-		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
-
-		if (IS_DAX(inode))
-			status = iomap_dax_zero(pos, offset, bytes, iomap);
-		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap);
-		if (status < 0)
-			return status;
-
-		pos += bytes;
-		count -= bytes;
-		written += bytes;
-		if (did_zero)
-			*did_zero = true;
-	} while (count > 0);
-
-	return written;
-}
-
-int
-iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops)
-{
-	loff_t ret;
-
-	while (len > 0) {
-		ret = iomap_apply(inode, pos, len, IOMAP_ZERO,
-				ops, did_zero, iomap_zero_range_actor);
-		if (ret <= 0)
-			return ret;
-
-		pos += ret;
-		len -= ret;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_zero_range);
-
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops)
@@ -1083,65 +624,3 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-static loff_t
-iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap)
-{
-	struct page *page = data;
-	int ret;
-
-	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
-		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
-		if (ret)
-			return ret;
-		block_commit_write(page, 0, length);
-	} else {
-		WARN_ON_ONCE(!PageUptodate(page));
-		iomap_page_create(inode, page);
-		set_page_dirty(page);
-	}
-
-	return length;
-}
-
-vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
-{
-	struct page *page = vmf->page;
-	struct inode *inode = file_inode(vmf->vma->vm_file);
-	unsigned long length;
-	loff_t offset, size;
-	ssize_t ret;
-
-	lock_page(page);
-	size = i_size_read(inode);
-	if ((page->mapping != inode->i_mapping) ||
-	    (page_offset(page) > size)) {
-		/* We overload EFAULT to mean page got truncated */
-		ret = -EFAULT;
-		goto out_unlock;
-	}
-
-	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_SHIFT) > size)
-		length = offset_in_page(size);
-	else
-		length = PAGE_SIZE;
-
-	offset = page_offset(page);
-	while (length > 0) {
-		ret = iomap_apply(inode, offset, length,
-				IOMAP_WRITE | IOMAP_FAULT, ops, page,
-				iomap_page_mkwrite_actor);
-		if (unlikely(ret <= 0))
-			goto out_unlock;
-		offset += ret;
-		length -= ret;
-	}
-
-	wait_for_stable_page(page);
-	return VM_FAULT_LOCKED;
-out_unlock:
-	unlock_page(page);
-	return block_page_mkwrite_return(ret);
-}
-EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index 3e158f38b8e2..c6859e19a9ef 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 iomap-y				+= \
 					direct-io.o \
 					fiemap.o \
-					seek.o
+					seek.o \
+					write.o
 
 iomap-$(CONFIG_SWAP)		+= swapfile.o
diff --git a/fs/iomap/iomap_internal.h b/fs/iomap/iomap_internal.h
index 2e811ca8b8ed..defaa4d4b9e6 100644
--- a/fs/iomap/iomap_internal.h
+++ b/fs/iomap/iomap_internal.h
@@ -7,5 +7,11 @@
 #define _IOMAP_INTERNAL_H_
 
 sector_t iomap_sector(struct iomap *iomap, loff_t pos);
+void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len);
+struct iomap_page *iomap_page_create(struct inode *inode, struct page *page);
+void iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
+		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp);
+void iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap);
 
 #endif /* _IOMAP_INTERNAL_H_ */
diff --git a/fs/iomap/write.c b/fs/iomap/write.c
new file mode 100644
index 000000000000..8626bb3f1b01
--- /dev/null
+++ b/fs/iomap/write.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include <linux/uio.h>
+#include <linux/buffer_head.h>
+#include <linux/dax.h>
+#include <linux/writeback.h>
+#include <linux/swap.h>
+#include <linux/bio.h>
+#include <linux/sched/signal.h>
+
+#include "internal.h"
+#include "iomap_internal.h"
+
+static void
+iomap_write_failed(struct inode *inode, loff_t pos, unsigned len)
+{
+	loff_t i_size = i_size_read(inode);
+
+	/*
+	 * Only truncate newly allocated pages beyoned EOF, even if the
+	 * write started inside the existing inode size.
+	 */
+	if (pos + len > i_size)
+		truncate_pagecache_range(inode, max(pos, i_size), pos + len);
+}
+
+static int
+iomap_read_page_sync(struct inode *inode, loff_t block_start, struct page *page,
+		unsigned poff, unsigned plen, unsigned from, unsigned to,
+		struct iomap *iomap)
+{
+	struct bio_vec bvec;
+	struct bio bio;
+
+	if (iomap->type != IOMAP_MAPPED || block_start >= i_size_read(inode)) {
+		zero_user_segments(page, poff, from, to, poff + plen);
+		iomap_set_range_uptodate(page, poff, plen);
+		return 0;
+	}
+
+	bio_init(&bio, &bvec, 1);
+	bio.bi_opf = REQ_OP_READ;
+	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
+	bio_set_dev(&bio, iomap->bdev);
+	__bio_add_page(&bio, page, plen, poff);
+	return submit_bio_wait(&bio);
+}
+
+static int
+__iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
+		struct page *page, struct iomap *iomap)
+{
+	struct iomap_page *iop = iomap_page_create(inode, page);
+	loff_t block_size = i_blocksize(inode);
+	loff_t block_start = pos & ~(block_size - 1);
+	loff_t block_end = (pos + len + block_size - 1) & ~(block_size - 1);
+	unsigned from = offset_in_page(pos), to = from + len, poff, plen;
+	int status = 0;
+
+	if (PageUptodate(page))
+		return 0;
+
+	do {
+		iomap_adjust_read_range(inode, iop, &block_start,
+				block_end - block_start, &poff, &plen);
+		if (plen == 0)
+			break;
+
+		if ((from > poff && from < poff + plen) ||
+		    (to > poff && to < poff + plen)) {
+			status = iomap_read_page_sync(inode, block_start, page,
+					poff, plen, from, to, iomap);
+			if (status)
+				break;
+		}
+
+	} while ((block_start += plen) < block_end);
+
+	return status;
+}
+
+static int
+iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
+		struct page **pagep, struct iomap *iomap)
+{
+	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	pgoff_t index = pos >> PAGE_SHIFT;
+	struct page *page;
+	int status = 0;
+
+	BUG_ON(pos + len > iomap->offset + iomap->length);
+
+	if (fatal_signal_pending(current))
+		return -EINTR;
+
+	if (page_ops && page_ops->page_prepare) {
+		status = page_ops->page_prepare(inode, pos, len, iomap);
+		if (status)
+			return status;
+	}
+
+	page = grab_cache_page_write_begin(inode->i_mapping, index, flags);
+	if (!page) {
+		status = -ENOMEM;
+		goto out_no_page;
+	}
+
+	if (iomap->type == IOMAP_INLINE)
+		iomap_read_inline_data(inode, page, iomap);
+	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
+		status = __block_write_begin_int(page, pos, len, NULL, iomap);
+	else
+		status = __iomap_write_begin(inode, pos, len, page, iomap);
+
+	if (unlikely(status))
+		goto out_unlock;
+
+	*pagep = page;
+	return 0;
+
+out_unlock:
+	unlock_page(page);
+	put_page(page);
+	iomap_write_failed(inode, pos, len);
+
+out_no_page:
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(inode, pos, 0, NULL, iomap);
+	return status;
+}
+
+static int
+__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
+		unsigned copied, struct page *page, struct iomap *iomap)
+{
+	flush_dcache_page(page);
+
+	/*
+	 * The blocks that were entirely written will now be uptodate, so we
+	 * don't have to worry about a readpage reading them and overwriting a
+	 * partial write.  However if we have encountered a short write and only
+	 * partially written into a block, it will not be marked uptodate, so a
+	 * readpage might come in and destroy our partial write.
+	 *
+	 * Do the simplest thing, and just treat any short write to a non
+	 * uptodate page as a zero-length write, and force the caller to redo
+	 * the whole thing.
+	 */
+	if (unlikely(copied < len && !PageUptodate(page)))
+		return 0;
+	iomap_set_range_uptodate(page, offset_in_page(pos), len);
+	iomap_set_page_dirty(page);
+	return copied;
+}
+
+static int
+iomap_write_end_inline(struct inode *inode, struct page *page,
+		struct iomap *iomap, loff_t pos, unsigned copied)
+{
+	void *addr;
+
+	WARN_ON_ONCE(!PageUptodate(page));
+	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
+
+	addr = kmap_atomic(page);
+	memcpy(iomap->inline_data + pos, addr + pos, copied);
+	kunmap_atomic(addr);
+
+	mark_inode_dirty(inode);
+	return copied;
+}
+
+static int
+iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
+		unsigned copied, struct page *page, struct iomap *iomap)
+{
+	const struct iomap_page_ops *page_ops = iomap->page_ops;
+	loff_t old_size = inode->i_size;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+	} else if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
+		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
+				page, NULL);
+	} else {
+		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
+	}
+
+	/*
+	 * Update the in-memory inode size after copying the data into the page
+	 * cache.  It's up to the file system to write the updated size to disk,
+	 * preferably after I/O completion so that no stale data is exposed.
+	 */
+	if (pos + ret > old_size) {
+		i_size_write(inode, pos + ret);
+		iomap->flags |= IOMAP_F_SIZE_CHANGED;
+	}
+	unlock_page(page);
+
+	if (old_size < pos)
+		pagecache_isize_extended(inode, old_size, pos);
+	if (page_ops && page_ops->page_done)
+		page_ops->page_done(inode, pos, ret, page, iomap);
+	put_page(page);
+
+	if (ret < len)
+		iomap_write_failed(inode, pos, len);
+	return ret;
+}
+
+static loff_t
+iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+		struct iomap *iomap)
+{
+	struct iov_iter *i = data;
+	long status = 0;
+	ssize_t written = 0;
+	unsigned int flags = AOP_FLAG_NOFS;
+
+	do {
+		struct page *page;
+		unsigned long offset;	/* Offset into pagecache page */
+		unsigned long bytes;	/* Bytes to write to page */
+		size_t copied;		/* Bytes copied from user */
+
+		offset = offset_in_page(pos);
+		bytes = min_t(unsigned long, PAGE_SIZE - offset,
+						iov_iter_count(i));
+again:
+		if (bytes > length)
+			bytes = length;
+
+		/*
+		 * Bring in the user page that we will copy from _first_.
+		 * Otherwise there's a nasty deadlock on copying from the
+		 * same page as we're writing to, without it being marked
+		 * up-to-date.
+		 *
+		 * Not only is this an optimisation, but it is also required
+		 * to check that the address is actually valid, when atomic
+		 * usercopies are used, below.
+		 */
+		if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
+			status = -EFAULT;
+			break;
+		}
+
+		status = iomap_write_begin(inode, pos, bytes, flags, &page,
+				iomap);
+		if (unlikely(status))
+			break;
+
+		if (mapping_writably_mapped(inode->i_mapping))
+			flush_dcache_page(page);
+
+		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
+
+		flush_dcache_page(page);
+
+		status = iomap_write_end(inode, pos, bytes, copied, page,
+				iomap);
+		if (unlikely(status < 0))
+			break;
+		copied = status;
+
+		cond_resched();
+
+		iov_iter_advance(i, copied);
+		if (unlikely(copied == 0)) {
+			/*
+			 * If we were unable to copy any data at all, we must
+			 * fall back to a single segment length write.
+			 *
+			 * If we didn't fallback here, we could livelock
+			 * because not all segments in the iov can be copied at
+			 * once without a pagefault.
+			 */
+			bytes = min_t(unsigned long, PAGE_SIZE - offset,
+						iov_iter_single_seg_count(i));
+			goto again;
+		}
+		pos += copied;
+		written += copied;
+		length -= copied;
+
+		balance_dirty_pages_ratelimited(inode->i_mapping);
+	} while (iov_iter_count(i) && length);
+
+	return written ? written : status;
+}
+
+ssize_t
+iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *iter,
+		const struct iomap_ops *ops)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	loff_t pos = iocb->ki_pos, ret = 0, written = 0;
+
+	while (iov_iter_count(iter)) {
+		ret = iomap_apply(inode, pos, iov_iter_count(iter),
+				IOMAP_WRITE, ops, iter, iomap_write_actor);
+		if (ret <= 0)
+			break;
+		pos += ret;
+		written += ret;
+	}
+
+	return written ? written : ret;
+}
+EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
+
+static struct page *
+__iomap_read_page(struct inode *inode, loff_t offset)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page;
+
+	page = read_mapping_page(mapping, offset >> PAGE_SHIFT, NULL);
+	if (IS_ERR(page))
+		return page;
+	if (!PageUptodate(page)) {
+		put_page(page);
+		return ERR_PTR(-EIO);
+	}
+	return page;
+}
+
+static loff_t
+iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+		struct iomap *iomap)
+{
+	long status = 0;
+	ssize_t written = 0;
+
+	do {
+		struct page *page, *rpage;
+		unsigned long offset;	/* Offset into pagecache page */
+		unsigned long bytes;	/* Bytes to write to page */
+
+		offset = offset_in_page(pos);
+		bytes = min_t(loff_t, PAGE_SIZE - offset, length);
+
+		rpage = __iomap_read_page(inode, pos);
+		if (IS_ERR(rpage))
+			return PTR_ERR(rpage);
+
+		status = iomap_write_begin(inode, pos, bytes,
+					   AOP_FLAG_NOFS, &page, iomap);
+		put_page(rpage);
+		if (unlikely(status))
+			return status;
+
+		WARN_ON_ONCE(!PageUptodate(page));
+
+		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap);
+		if (unlikely(status <= 0)) {
+			if (WARN_ON_ONCE(status == 0))
+				return -EIO;
+			return status;
+		}
+
+		cond_resched();
+
+		pos += status;
+		written += status;
+		length -= status;
+
+		balance_dirty_pages_ratelimited(inode->i_mapping);
+	} while (length);
+
+	return written;
+}
+
+int
+iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
+		const struct iomap_ops *ops)
+{
+	loff_t ret;
+
+	while (len) {
+		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
+				iomap_dirty_actor);
+		if (ret <= 0)
+			return ret;
+		pos += ret;
+		len -= ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_file_dirty);
+
+static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
+		unsigned bytes, struct iomap *iomap)
+{
+	struct page *page;
+	int status;
+
+	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
+				   iomap);
+	if (status)
+		return status;
+
+	zero_user(page, offset, bytes);
+	mark_page_accessed(page);
+
+	return iomap_write_end(inode, pos, bytes, bytes, page, iomap);
+}
+
+static int iomap_dax_zero(loff_t pos, unsigned offset, unsigned bytes,
+		struct iomap *iomap)
+{
+	return __dax_zero_page_range(iomap->bdev, iomap->dax_dev,
+			iomap_sector(iomap, pos & PAGE_MASK), offset, bytes);
+}
+
+static loff_t
+iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
+		void *data, struct iomap *iomap)
+{
+	bool *did_zero = data;
+	loff_t written = 0;
+	int status;
+
+	/* already zeroed?  we're done. */
+	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
+		return count;
+
+	do {
+		unsigned offset, bytes;
+
+		offset = offset_in_page(pos);
+		bytes = min_t(loff_t, PAGE_SIZE - offset, count);
+
+		if (IS_DAX(inode))
+			status = iomap_dax_zero(pos, offset, bytes, iomap);
+		else
+			status = iomap_zero(inode, pos, offset, bytes, iomap);
+		if (status < 0)
+			return status;
+
+		pos += bytes;
+		count -= bytes;
+		written += bytes;
+		if (did_zero)
+			*did_zero = true;
+	} while (count > 0);
+
+	return written;
+}
+
+int
+iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops)
+{
+	loff_t ret;
+
+	while (len > 0) {
+		ret = iomap_apply(inode, pos, len, IOMAP_ZERO,
+				ops, did_zero, iomap_zero_range_actor);
+		if (ret <= 0)
+			return ret;
+
+		pos += ret;
+		len -= ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_zero_range);
+
+static loff_t
+iomap_page_mkwrite_actor(struct inode *inode, loff_t pos, loff_t length,
+		void *data, struct iomap *iomap)
+{
+	struct page *page = data;
+	int ret;
+
+	if (iomap->flags & IOMAP_F_BUFFER_HEAD) {
+		ret = __block_write_begin_int(page, pos, length, NULL, iomap);
+		if (ret)
+			return ret;
+		block_commit_write(page, 0, length);
+	} else {
+		WARN_ON_ONCE(!PageUptodate(page));
+		iomap_page_create(inode, page);
+		set_page_dirty(page);
+	}
+
+	return length;
+}
+
+vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
+{
+	struct page *page = vmf->page;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	unsigned long length;
+	loff_t offset, size;
+	ssize_t ret;
+
+	lock_page(page);
+	size = i_size_read(inode);
+	if ((page->mapping != inode->i_mapping) ||
+	    (page_offset(page) > size)) {
+		/* We overload EFAULT to mean page got truncated */
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
+	/* page is wholly or partially inside EOF */
+	if (((page->index + 1) << PAGE_SHIFT) > size)
+		length = offset_in_page(size);
+	else
+		length = PAGE_SIZE;
+
+	offset = page_offset(page);
+	while (length > 0) {
+		ret = iomap_apply(inode, offset, length,
+				IOMAP_WRITE | IOMAP_FAULT, ops, page,
+				iomap_page_mkwrite_actor);
+		if (unlikely(ret <= 0))
+			goto out_unlock;
+		offset += ret;
+		length -= ret;
+	}
+
+	wait_for_stable_page(page);
+	return VM_FAULT_LOCKED;
+out_unlock:
+	unlock_page(page);
+	return block_page_mkwrite_return(ret);
+}
+EXPORT_SYMBOL_GPL(iomap_page_mkwrite);

