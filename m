Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF185C1A5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfGARC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:02:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59338 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfGARC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:02:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnU0G089739;
        Mon, 1 Jul 2019 17:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3xOcv+7veIk4vFckbspHB9McMHyqB3EBVgJSuyHND/s=;
 b=vyuZHJyWxZ50dizR3G5Nu+HqC0QDCDEe4SCd5IPmqoWk4a4VxxaRotms2hgoZqs9SuWd
 7lB5vgiEpSFWZvRfJy2Jr0a6O5WiwU16mt/WRNoG4i90jxdulCaubdnajcEJ1fJtPQyO
 ujFHyxDZc+WUzOiSshP5dsRk9O6elx9HPsEcjKjC80sLCP88wRblwzoUFXhDLT9sN7MP
 WYhMOrZdlT3TLwyMmHSc56678s1tfLsckVEzcTnvLDZRN4mxRxFqFYQyeR1xYLuig0uI
 iBQ3yWYe7woEKIsRrpX5BL/Srz9YVnPho4jYyvfiWzPrVBGdPrEJhq3FLVizjdSbre1i 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2te5tbevj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmLrK183063;
        Mon, 1 Jul 2019 17:02:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tebktsp55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:02:46 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x61H2kJL009968;
        Mon, 1 Jul 2019 17:02:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:02:46 -0700
Subject: [PATCH 07/11] iomap: move the buffered read code into a separate
 file
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:02:45 -0700
Message-ID: <156200056526.1790352.14957019009981662003.stgit@magnolia>
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

Move the buffered read code into a separate file so that we can group
related functions in a single file instead of having a single enormous
source file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap.c        |  335 ---------------------------------------------------
 fs/iomap/Makefile |    1 
 fs/iomap/read.c   |  349 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 350 insertions(+), 335 deletions(-)
 create mode 100644 fs/iomap/read.c


diff --git a/fs/iomap.c b/fs/iomap.c
index 72db8a6c0292..f339fb5fde43 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -135,66 +135,6 @@ iomap_page_release(struct page *page)
 	kfree(iop);
 }
 
-/*
- * Calculate the range inside the page that we actually need to read.
- */
-void
-iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
-		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
-{
-	loff_t orig_pos = *pos;
-	loff_t isize = i_size_read(inode);
-	unsigned block_bits = inode->i_blkbits;
-	unsigned block_size = (1 << block_bits);
-	unsigned poff = offset_in_page(*pos);
-	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
-	unsigned first = poff >> block_bits;
-	unsigned last = (poff + plen - 1) >> block_bits;
-
-	/*
-	 * If the block size is smaller than the page size we need to check the
-	 * per-block uptodate status and adjust the offset and length if needed
-	 * to avoid reading in already uptodate ranges.
-	 */
-	if (iop) {
-		unsigned int i;
-
-		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
-			if (!test_bit(i, iop->uptodate))
-				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
-		}
-
-		/* truncate len if we find any trailing uptodate block(s) */
-		for ( ; i <= last; i++) {
-			if (test_bit(i, iop->uptodate)) {
-				plen -= (last - i + 1) * block_size;
-				last = i - 1;
-				break;
-			}
-		}
-	}
-
-	/*
-	 * If the extent spans the block that contains the i_size we need to
-	 * handle both halves separately so that we properly zero data in the
-	 * page cache for blocks that are entirely outside of i_size.
-	 */
-	if (orig_pos <= isize && orig_pos + length > isize) {
-		unsigned end = offset_in_page(isize - 1) >> block_bits;
-
-		if (first <= end && last > end)
-			plen -= (last - end) * block_size;
-	}
-
-	*offp = poff;
-	*lenp = plen;
-}
-
 void
 iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
@@ -218,280 +158,6 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 		SetPageUptodate(page);
 }
 
-static void
-iomap_read_finish(struct iomap_page *iop, struct page *page)
-{
-	if (!iop || atomic_dec_and_test(&iop->read_count))
-		unlock_page(page);
-}
-
-static void
-iomap_read_page_end_io(struct bio_vec *bvec, int error)
-{
-	struct page *page = bvec->bv_page;
-	struct iomap_page *iop = to_iomap_page(page);
-
-	if (unlikely(error)) {
-		ClearPageUptodate(page);
-		SetPageError(page);
-	} else {
-		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
-	}
-
-	iomap_read_finish(iop, page);
-}
-
-static void
-iomap_read_end_io(struct bio *bio)
-{
-	int error = blk_status_to_errno(bio->bi_status);
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all)
-		iomap_read_page_end_io(bvec, error);
-	bio_put(bio);
-}
-
-struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	bool			is_readahead;
-	struct bio		*bio;
-	struct list_head	*pages;
-};
-
-void
-iomap_read_inline_data(struct inode *inode, struct page *page,
-		struct iomap *iomap)
-{
-	size_t size = i_size_read(inode);
-	void *addr;
-
-	if (PageUptodate(page))
-		return;
-
-	BUG_ON(page->index);
-	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
-
-	addr = kmap_atomic(page);
-	memcpy(addr, iomap->inline_data, size);
-	memset(addr + size, 0, PAGE_SIZE - size);
-	kunmap_atomic(addr);
-	SetPageUptodate(page);
-}
-
-static loff_t
-iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
-		struct iomap *iomap)
-{
-	struct iomap_readpage_ctx *ctx = data;
-	struct page *page = ctx->cur_page;
-	struct iomap_page *iop = iomap_page_create(inode, page);
-	bool is_contig = false;
-	loff_t orig_pos = pos;
-	unsigned poff, plen;
-	sector_t sector;
-
-	if (iomap->type == IOMAP_INLINE) {
-		WARN_ON_ONCE(pos);
-		iomap_read_inline_data(inode, page, iomap);
-		return PAGE_SIZE;
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
-		zero_user(page, poff, plen);
-		iomap_set_range_uptodate(page, poff, plen);
-		goto done;
-	}
-
-	ctx->cur_page_in_bio = true;
-
-	/*
-	 * Try to merge into a previous segment if we can.
-	 */
-	sector = iomap_sector(iomap, pos);
-	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
-		if (__bio_try_merge_page(ctx->bio, page, plen, poff, true))
-			goto done;
-		is_contig = true;
-	}
-
-	/*
-	 * If we start a new segment we need to increase the read count, and we
-	 * need to do so before submitting any previous full bio to make sure
-	 * that we don't prematurely unlock the page.
-	 */
-	if (iop)
-		atomic_inc(&iop->read_count);
-
-	if (!ctx->bio || !is_contig || bio_full(ctx->bio)) {
-		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
-		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-		if (ctx->bio)
-			submit_bio(ctx->bio);
-
-		if (ctx->is_readahead) /* same as readahead_gfp_mask */
-			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
-		ctx->bio->bi_opf = REQ_OP_READ;
-		if (ctx->is_readahead)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		bio_set_dev(ctx->bio, iomap->bdev);
-		ctx->bio->bi_end_io = iomap_read_end_io;
-	}
-
-	bio_add_page(ctx->bio, page, plen, poff);
-done:
-	/*
-	 * Move the caller beyond our range so that it keeps making progress.
-	 * For that we have to include any leading non-uptodate ranges, but
-	 * we can skip trailing ones as they will be handled in the next
-	 * iteration.
-	 */
-	return pos - orig_pos + plen;
-}
-
-int
-iomap_readpage(struct page *page, const struct iomap_ops *ops)
-{
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
-	struct inode *inode = page->mapping->host;
-	unsigned poff;
-	loff_t ret;
-
-	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
-		ret = iomap_apply(inode, page_offset(page) + poff,
-				PAGE_SIZE - poff, 0, ops, &ctx,
-				iomap_readpage_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			SetPageError(page);
-			break;
-		}
-	}
-
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_page_in_bio);
-	} else {
-		WARN_ON_ONCE(ctx.cur_page_in_bio);
-		unlock_page(page);
-	}
-
-	/*
-	 * Just like mpage_readpages and block_read_full_page we always
-	 * return 0 and just mark the page as PageError on errors.  This
-	 * should be cleaned up all through the stack eventually.
-	 */
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iomap_readpage);
-
-static struct page *
-iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
-		loff_t length, loff_t *done)
-{
-	while (!list_empty(pages)) {
-		struct page *page = lru_to_page(pages);
-
-		if (page_offset(page) >= (u64)pos + length)
-			break;
-
-		list_del(&page->lru);
-		if (!add_to_page_cache_lru(page, inode->i_mapping, page->index,
-				GFP_NOFS))
-			return page;
-
-		/*
-		 * If we already have a page in the page cache at index we are
-		 * done.  Upper layers don't care if it is uptodate after the
-		 * readpages call itself as every page gets checked again once
-		 * actually needed.
-		 */
-		*done += PAGE_SIZE;
-		put_page(page);
-	}
-
-	return NULL;
-}
-
-static loff_t
-iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
-		void *data, struct iomap *iomap)
-{
-	struct iomap_readpage_ctx *ctx = data;
-	loff_t done, ret;
-
-	for (done = 0; done < length; done += ret) {
-		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
-			if (!ctx->cur_page_in_bio)
-				unlock_page(ctx->cur_page);
-			put_page(ctx->cur_page);
-			ctx->cur_page = NULL;
-		}
-		if (!ctx->cur_page) {
-			ctx->cur_page = iomap_next_page(inode, ctx->pages,
-					pos, length, &done);
-			if (!ctx->cur_page)
-				break;
-			ctx->cur_page_in_bio = false;
-		}
-		ret = iomap_readpage_actor(inode, pos + done, length - done,
-				ctx, iomap);
-	}
-
-	return done;
-}
-
-int
-iomap_readpages(struct address_space *mapping, struct list_head *pages,
-		unsigned nr_pages, const struct iomap_ops *ops)
-{
-	struct iomap_readpage_ctx ctx = {
-		.pages		= pages,
-		.is_readahead	= true,
-	};
-	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
-	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
-	loff_t length = last - pos + PAGE_SIZE, ret = 0;
-
-	while (length > 0) {
-		ret = iomap_apply(mapping->host, pos, length, 0, ops,
-				&ctx, iomap_readpages_actor);
-		if (ret <= 0) {
-			WARN_ON_ONCE(ret == 0);
-			goto done;
-		}
-		pos += ret;
-		length -= ret;
-	}
-	ret = 0;
-done:
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_page) {
-		if (!ctx.cur_page_in_bio)
-			unlock_page(ctx.cur_page);
-		put_page(ctx.cur_page);
-	}
-
-	/*
-	 * Check that we didn't lose a page due to the arcance calling
-	 * conventions..
-	 */
-	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iomap_readpages);
-
 /*
  * iomap_is_partially_uptodate checks whether blocks within a page are
  * uptodate or not.
@@ -623,4 +289,3 @@ iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
-
diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
index c6859e19a9ef..651bd66bfce7 100644
--- a/fs/iomap/Makefile
+++ b/fs/iomap/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
 iomap-y				+= \
 					direct-io.o \
 					fiemap.o \
+					read.o \
 					seek.o \
 					write.o
 
diff --git a/fs/iomap/read.c b/fs/iomap/read.c
new file mode 100644
index 000000000000..237516d0af8b
--- /dev/null
+++ b/fs/iomap/read.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2010 Red Hat, Inc.
+ * Copyright (c) 2016-2018 Christoph Hellwig.
+ */
+#include <linux/module.h>
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/iomap.h>
+#include <linux/bio.h>
+#include <linux/pagemap.h>
+#include <linux/blkdev.h>
+
+#include "internal.h"
+#include "iomap_internal.h"
+
+/*
+ * Calculate the range inside the page that we actually need to read.
+ */
+void
+iomap_adjust_read_range(struct inode *inode, struct iomap_page *iop,
+		loff_t *pos, loff_t length, unsigned *offp, unsigned *lenp)
+{
+	loff_t orig_pos = *pos;
+	loff_t isize = i_size_read(inode);
+	unsigned block_bits = inode->i_blkbits;
+	unsigned block_size = (1 << block_bits);
+	unsigned poff = offset_in_page(*pos);
+	unsigned plen = min_t(loff_t, PAGE_SIZE - poff, length);
+	unsigned first = poff >> block_bits;
+	unsigned last = (poff + plen - 1) >> block_bits;
+
+	/*
+	 * If the block size is smaller than the page size we need to check the
+	 * per-block uptodate status and adjust the offset and length if needed
+	 * to avoid reading in already uptodate ranges.
+	 */
+	if (iop) {
+		unsigned int i;
+
+		/* move forward for each leading block marked uptodate */
+		for (i = first; i <= last; i++) {
+			if (!test_bit(i, iop->uptodate))
+				break;
+			*pos += block_size;
+			poff += block_size;
+			plen -= block_size;
+			first++;
+		}
+
+		/* truncate len if we find any trailing uptodate block(s) */
+		for ( ; i <= last; i++) {
+			if (test_bit(i, iop->uptodate)) {
+				plen -= (last - i + 1) * block_size;
+				last = i - 1;
+				break;
+			}
+		}
+	}
+
+	/*
+	 * If the extent spans the block that contains the i_size we need to
+	 * handle both halves separately so that we properly zero data in the
+	 * page cache for blocks that are entirely outside of i_size.
+	 */
+	if (orig_pos <= isize && orig_pos + length > isize) {
+		unsigned end = offset_in_page(isize - 1) >> block_bits;
+
+		if (first <= end && last > end)
+			plen -= (last - end) * block_size;
+	}
+
+	*offp = poff;
+	*lenp = plen;
+}
+
+static void
+iomap_read_finish(struct iomap_page *iop, struct page *page)
+{
+	if (!iop || atomic_dec_and_test(&iop->read_count))
+		unlock_page(page);
+}
+
+static void
+iomap_read_page_end_io(struct bio_vec *bvec, int error)
+{
+	struct page *page = bvec->bv_page;
+	struct iomap_page *iop = to_iomap_page(page);
+
+	if (unlikely(error)) {
+		ClearPageUptodate(page);
+		SetPageError(page);
+	} else {
+		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
+	}
+
+	iomap_read_finish(iop, page);
+}
+
+static void
+iomap_read_end_io(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	bio_for_each_segment_all(bvec, bio, iter_all)
+		iomap_read_page_end_io(bvec, error);
+	bio_put(bio);
+}
+
+struct iomap_readpage_ctx {
+	struct page		*cur_page;
+	bool			cur_page_in_bio;
+	bool			is_readahead;
+	struct bio		*bio;
+	struct list_head	*pages;
+};
+
+void
+iomap_read_inline_data(struct inode *inode, struct page *page,
+		struct iomap *iomap)
+{
+	size_t size = i_size_read(inode);
+	void *addr;
+
+	if (PageUptodate(page))
+		return;
+
+	BUG_ON(page->index);
+	BUG_ON(size > PAGE_SIZE - offset_in_page(iomap->inline_data));
+
+	addr = kmap_atomic(page);
+	memcpy(addr, iomap->inline_data, size);
+	memset(addr + size, 0, PAGE_SIZE - size);
+	kunmap_atomic(addr);
+	SetPageUptodate(page);
+}
+
+static loff_t
+iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
+		struct iomap *iomap)
+{
+	struct iomap_readpage_ctx *ctx = data;
+	struct page *page = ctx->cur_page;
+	struct iomap_page *iop = iomap_page_create(inode, page);
+	bool is_contig = false;
+	loff_t orig_pos = pos;
+	unsigned poff, plen;
+	sector_t sector;
+
+	if (iomap->type == IOMAP_INLINE) {
+		WARN_ON_ONCE(pos);
+		iomap_read_inline_data(inode, page, iomap);
+		return PAGE_SIZE;
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	iomap_adjust_read_range(inode, iop, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap->type != IOMAP_MAPPED || pos >= i_size_read(inode)) {
+		zero_user(page, poff, plen);
+		iomap_set_range_uptodate(page, poff, plen);
+		goto done;
+	}
+
+	ctx->cur_page_in_bio = true;
+
+	/*
+	 * Try to merge into a previous segment if we can.
+	 */
+	sector = iomap_sector(iomap, pos);
+	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
+		if (__bio_try_merge_page(ctx->bio, page, plen, poff, true))
+			goto done;
+		is_contig = true;
+	}
+
+	/*
+	 * If we start a new segment we need to increase the read count, and we
+	 * need to do so before submitting any previous full bio to make sure
+	 * that we don't prematurely unlock the page.
+	 */
+	if (iop)
+		atomic_inc(&iop->read_count);
+
+	if (!ctx->bio || !is_contig || bio_full(ctx->bio)) {
+		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
+		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		if (ctx->bio)
+			submit_bio(ctx->bio);
+
+		if (ctx->is_readahead) /* same as readahead_gfp_mask */
+			gfp |= __GFP_NORETRY | __GFP_NOWARN;
+		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
+		ctx->bio->bi_opf = REQ_OP_READ;
+		if (ctx->is_readahead)
+			ctx->bio->bi_opf |= REQ_RAHEAD;
+		ctx->bio->bi_iter.bi_sector = sector;
+		bio_set_dev(ctx->bio, iomap->bdev);
+		ctx->bio->bi_end_io = iomap_read_end_io;
+	}
+
+	bio_add_page(ctx->bio, page, plen, poff);
+done:
+	/*
+	 * Move the caller beyond our range so that it keeps making progress.
+	 * For that we have to include any leading non-uptodate ranges, but
+	 * we can skip trailing ones as they will be handled in the next
+	 * iteration.
+	 */
+	return pos - orig_pos + plen;
+}
+
+int
+iomap_readpage(struct page *page, const struct iomap_ops *ops)
+{
+	struct iomap_readpage_ctx ctx = { .cur_page = page };
+	struct inode *inode = page->mapping->host;
+	unsigned poff;
+	loff_t ret;
+
+	for (poff = 0; poff < PAGE_SIZE; poff += ret) {
+		ret = iomap_apply(inode, page_offset(page) + poff,
+				PAGE_SIZE - poff, 0, ops, &ctx,
+				iomap_readpage_actor);
+		if (ret <= 0) {
+			WARN_ON_ONCE(ret == 0);
+			SetPageError(page);
+			break;
+		}
+	}
+
+	if (ctx.bio) {
+		submit_bio(ctx.bio);
+		WARN_ON_ONCE(!ctx.cur_page_in_bio);
+	} else {
+		WARN_ON_ONCE(ctx.cur_page_in_bio);
+		unlock_page(page);
+	}
+
+	/*
+	 * Just like mpage_readpages and block_read_full_page we always
+	 * return 0 and just mark the page as PageError on errors.  This
+	 * should be cleaned up all through the stack eventually.
+	 */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_readpage);
+
+static struct page *
+iomap_next_page(struct inode *inode, struct list_head *pages, loff_t pos,
+		loff_t length, loff_t *done)
+{
+	while (!list_empty(pages)) {
+		struct page *page = lru_to_page(pages);
+
+		if (page_offset(page) >= (u64)pos + length)
+			break;
+
+		list_del(&page->lru);
+		if (!add_to_page_cache_lru(page, inode->i_mapping, page->index,
+				GFP_NOFS))
+			return page;
+
+		/*
+		 * If we already have a page in the page cache at index we are
+		 * done.  Upper layers don't care if it is uptodate after the
+		 * readpages call itself as every page gets checked again once
+		 * actually needed.
+		 */
+		*done += PAGE_SIZE;
+		put_page(page);
+	}
+
+	return NULL;
+}
+
+static loff_t
+iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
+		void *data, struct iomap *iomap)
+{
+	struct iomap_readpage_ctx *ctx = data;
+	loff_t done, ret;
+
+	for (done = 0; done < length; done += ret) {
+		if (ctx->cur_page && offset_in_page(pos + done) == 0) {
+			if (!ctx->cur_page_in_bio)
+				unlock_page(ctx->cur_page);
+			put_page(ctx->cur_page);
+			ctx->cur_page = NULL;
+		}
+		if (!ctx->cur_page) {
+			ctx->cur_page = iomap_next_page(inode, ctx->pages,
+					pos, length, &done);
+			if (!ctx->cur_page)
+				break;
+			ctx->cur_page_in_bio = false;
+		}
+		ret = iomap_readpage_actor(inode, pos + done, length - done,
+				ctx, iomap);
+	}
+
+	return done;
+}
+
+int
+iomap_readpages(struct address_space *mapping, struct list_head *pages,
+		unsigned nr_pages, const struct iomap_ops *ops)
+{
+	struct iomap_readpage_ctx ctx = {
+		.pages		= pages,
+		.is_readahead	= true,
+	};
+	loff_t pos = page_offset(list_entry(pages->prev, struct page, lru));
+	loff_t last = page_offset(list_entry(pages->next, struct page, lru));
+	loff_t length = last - pos + PAGE_SIZE, ret = 0;
+
+	while (length > 0) {
+		ret = iomap_apply(mapping->host, pos, length, 0, ops,
+				&ctx, iomap_readpages_actor);
+		if (ret <= 0) {
+			WARN_ON_ONCE(ret == 0);
+			goto done;
+		}
+		pos += ret;
+		length -= ret;
+	}
+	ret = 0;
+done:
+	if (ctx.bio)
+		submit_bio(ctx.bio);
+	if (ctx.cur_page) {
+		if (!ctx.cur_page_in_bio)
+			unlock_page(ctx.cur_page);
+		put_page(ctx.cur_page);
+	}
+
+	/*
+	 * Check that we didn't lose a page due to the arcance calling
+	 * conventions..
+	 */
+	WARN_ON_ONCE(!ret && !list_empty(ctx.pages));
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iomap_readpages);

