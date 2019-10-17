Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C739DB524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 19:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441173AbfJQR5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 13:57:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441168AbfJQR5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kigmJdtvep/vyRzVSMF2sWVl9wWbvXJ9aE1aCzjzVlU=; b=WZB/dFZpVlUyiul5xkDaBB8Yis
        rilQAscZuFM+3TkrqNEGR/CRvBlkVZGSS7hIDjDdfxARt2nYIC84aOIQLgKxpTsxhGr80HpVpNNgi
        faGVquaeI7crLe994ZUdWBoLPxqJiLlJdKr8EGk2MK0lV5HkcIdt1zSn4zi1aremmJPJzPjcX4EuG
        WXFb7v4WTc5kibnRrjeY8RYm0rDvIUPXwNPKAZIDPMWsOEptXjzv94riEep/kjikLjhHcidxkidUe
        Mtr1oxtKmuQvZlVX/az5yfouwk2WDEN30gwVSHerhjeYr6igWgulvU/x/UgYAQYSgeR8mVudtNG76
        /7kAnUSQ==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iLA18-0001B9-Pt; Thu, 17 Oct 2019 17:56:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] iomap: lift the xfs writeback code to iomap
Date:   Thu, 17 Oct 2019 19:56:20 +0200
Message-Id: <20191017175624.30305-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017175624.30305-1-hch@lst.de>
References: <20191017175624.30305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Take the xfs writeback code and move it to fs/iomap.  A new structure
with three methods is added as the abstraction from the generic writeback
code to the file system.  These methods are used to map blocks, submit an
ioend, and cancel a page that encountered an error before it was added to
an ioend.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 551 ++++++++++++++++++++++++++++++++++-
 fs/iomap/trace.h       |   1 +
 fs/xfs/xfs_aops.c      | 637 ++++-------------------------------------
 fs/xfs/xfs_aops.h      |  17 --
 fs/xfs/xfs_super.c     |  11 +-
 fs/xfs/xfs_trace.h     |  39 ---
 include/linux/iomap.h  |  59 ++++
 7 files changed, 668 insertions(+), 647 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 55e514899b8c..a8db706d59cb 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (c) 2016-2018 Christoph Hellwig.
+ * Copyright (C) 2016-2019 Christoph Hellwig.
  */
 #include <linux/module.h>
 #include <linux/compiler.h>
@@ -12,6 +12,7 @@
 #include <linux/buffer_head.h>
 #include <linux/dax.h>
 #include <linux/writeback.h>
+#include <linux/list_sort.h>
 #include <linux/swap.h>
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
@@ -20,6 +21,8 @@
 
 #include "../internal.h"
 
+static struct bio_set iomap_ioend_bioset;
+
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
@@ -1088,3 +1091,549 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
 	return block_page_mkwrite_return(ret);
 }
 EXPORT_SYMBOL_GPL(iomap_page_mkwrite);
+
+static void
+iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
+		int error)
+{
+	struct iomap_page *iop = to_iomap_page(bvec->bv_page);
+
+	if (error) {
+		SetPageError(bvec->bv_page);
+		mapping_set_error(inode->i_mapping, -EIO);
+	}
+
+	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
+
+	if (!iop || atomic_dec_and_test(&iop->write_count))
+		end_page_writeback(bvec->bv_page);
+}
+
+/*
+ * We're now finished for good with this ioend structure.  Update the page
+ * state, release holds on bios, and finally free up memory.  Do not use the
+ * ioend after this.
+ */
+static void
+iomap_finish_ioend(struct iomap_ioend *ioend, int error)
+{
+	struct inode *inode = ioend->io_inode;
+	struct bio *bio = &ioend->io_inline_bio;
+	struct bio *last = ioend->io_bio, *next;
+	u64 start = bio->bi_iter.bi_sector;
+	bool quiet = bio_flagged(bio, BIO_QUIET);
+
+	for (bio = &ioend->io_inline_bio; bio; bio = next) {
+		struct bio_vec *bv;
+		struct bvec_iter_all iter_all;
+
+		/*
+		 * For the last bio, bi_private points to the ioend, so we
+		 * need to explicitly end the iteration here.
+		 */
+		if (bio == last)
+			next = NULL;
+		else
+			next = bio->bi_private;
+
+		/* walk each page on bio, ending page IO on them */
+		bio_for_each_segment_all(bv, bio, iter_all)
+			iomap_finish_page_writeback(inode, bv, error);
+		bio_put(bio);
+	}
+
+	if (unlikely(error && !quiet)) {
+		printk_ratelimited(KERN_ERR
+			"%s: writeback error on sector %llu",
+			inode->i_sb->s_id, start);
+	}
+}
+
+void
+iomap_finish_ioends(struct iomap_ioend *ioend, int error)
+{
+	struct list_head tmp;
+
+	list_replace_init(&ioend->io_list, &tmp);
+	iomap_finish_ioend(ioend, error);
+
+	while (!list_empty(&tmp)) {
+		ioend = list_first_entry(&tmp, struct iomap_ioend, io_list);
+		list_del_init(&ioend->io_list);
+		iomap_finish_ioend(ioend, error);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_finish_ioends);
+
+/*
+ * We can merge two adjacent ioends if they have the same set of work to do.
+ */
+static bool
+iomap_ioend_can_merge(struct iomap_ioend *ioend, struct iomap_ioend *next)
+{
+	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
+		return false;
+	if ((ioend->io_flags & IOMAP_F_SHARED) ^
+	    (next->io_flags & IOMAP_F_SHARED))
+		return false;
+	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
+	    (next->io_type == IOMAP_UNWRITTEN))
+		return false;
+	if (ioend->io_offset + ioend->io_size != next->io_offset)
+		return false;
+	return true;
+}
+
+void
+iomap_ioend_try_merge(struct iomap_ioend *ioend, struct list_head *more_ioends,
+		void (*merge_private)(struct iomap_ioend *ioend,
+				struct iomap_ioend *next))
+{
+	struct iomap_ioend *next;
+
+	INIT_LIST_HEAD(&ioend->io_list);
+
+	while ((next = list_first_entry_or_null(more_ioends, struct iomap_ioend,
+			io_list))) {
+		if (!iomap_ioend_can_merge(ioend, next))
+			break;
+		list_move_tail(&next->io_list, &ioend->io_list);
+		ioend->io_size += next->io_size;
+		if (next->io_private && merge_private)
+			merge_private(ioend, next);
+	}
+}
+EXPORT_SYMBOL_GPL(iomap_ioend_try_merge);
+
+static int
+iomap_ioend_compare(void *priv, struct list_head *a, struct list_head *b)
+{
+	struct iomap_ioend *ia, *ib;
+
+	ia = container_of(a, struct iomap_ioend, io_list);
+	ib = container_of(b, struct iomap_ioend, io_list);
+	if (ia->io_offset < ib->io_offset)
+		return -1;
+	else if (ia->io_offset > ib->io_offset)
+		return 1;
+	return 0;
+}
+
+void
+iomap_sort_ioends(struct list_head *ioend_list)
+{
+	list_sort(NULL, ioend_list, iomap_ioend_compare);
+}
+EXPORT_SYMBOL_GPL(iomap_sort_ioends);
+
+static void iomap_writepage_end_bio(struct bio *bio)
+{
+	struct iomap_ioend *ioend = bio->bi_private;
+
+	iomap_finish_ioend(ioend, blk_status_to_errno(bio->bi_status));
+}
+
+/*
+ * Submit the final bio for an ioend.
+ *
+ * If @error is non-zero, it means that we have a situation where some part of
+ * the submission process has failed after we have marked paged for writeback
+ * and unlocked them.  In this situation, we need to fail the bio instead of
+ * submitting it.  This typically only happens on a filesystem shutdown.
+ */
+static int
+iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
+		int error)
+{
+	ioend->io_bio->bi_private = ioend;
+	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
+
+	if (wpc->ops->submit_ioend)
+		error = wpc->ops->submit_ioend(ioend, error);
+	if (error) {
+		/*
+		 * If we are failing the IO now, just mark the ioend with an
+		 * error and finish it.  This will run IO completion immediately
+		 * as there is only one reference to the ioend at this point in
+		 * time.
+		 */
+		ioend->io_bio->bi_status = errno_to_blk_status(error);
+		bio_endio(ioend->io_bio);
+		return error;
+	}
+
+	submit_bio(ioend->io_bio);
+	return 0;
+}
+
+static struct iomap_ioend *
+iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
+		loff_t offset, sector_t sector, struct writeback_control *wbc)
+{
+	struct iomap_ioend *ioend;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &iomap_ioend_bioset);
+	bio_set_dev(bio, wpc->iomap.bdev);
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
+	bio->bi_write_hint = inode->i_write_hint;
+	wbc_init_bio(wbc, bio);
+
+	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
+	INIT_LIST_HEAD(&ioend->io_list);
+	ioend->io_type = wpc->iomap.type;
+	ioend->io_flags = wpc->iomap.flags;
+	ioend->io_inode = inode;
+	ioend->io_size = 0;
+	ioend->io_offset = offset;
+	ioend->io_private = NULL;
+	ioend->io_bio = bio;
+	return ioend;
+}
+
+/*
+ * Allocate a new bio, and chain the old bio to the new one.
+ *
+ * Note that we have to do perform the chaining in this unintuitive order
+ * so that the bi_private linkage is set up in the right direction for the
+ * traversal in iomap_finish_ioend().
+ */
+static struct bio *
+iomap_chain_bio(struct bio *prev)
+{
+	struct bio *new;
+
+	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
+	bio_copy_dev(new, prev);/* also copies over blkcg information */
+	new->bi_iter.bi_sector = bio_end_sector(prev);
+	new->bi_opf = prev->bi_opf;
+	new->bi_write_hint = prev->bi_write_hint;
+
+	bio_chain(prev, new);
+	bio_get(prev);		/* for iomap_finish_ioend */
+	submit_bio(prev);
+	return new;
+}
+
+static bool
+iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
+		sector_t sector)
+{
+	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
+	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
+		return false;
+	if (wpc->iomap.type != wpc->ioend->io_type)
+		return false;
+	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
+		return false;
+	if (sector != bio_end_sector(wpc->ioend->io_bio))
+		return false;
+	return true;
+}
+
+/*
+ * Test to see if we have an existing ioend structure that we could append to
+ * first, otherwise finish off the current ioend and start another.
+ */
+static void
+iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
+		struct iomap_page *iop, struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct list_head *iolist)
+{
+	sector_t sector = iomap_sector(&wpc->iomap, offset);
+	unsigned len = i_blocksize(inode);
+	unsigned poff = offset & (PAGE_SIZE - 1);
+	bool merged, same_page = false;
+
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
+		if (wpc->ioend)
+			list_add(&wpc->ioend->io_list, iolist);
+		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
+	}
+
+	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
+			&same_page);
+	if (iop && !same_page)
+		atomic_inc(&iop->write_count);
+
+	if (!merged) {
+		if (bio_full(wpc->ioend->io_bio, len)) {
+			wpc->ioend->io_bio =
+				iomap_chain_bio(wpc->ioend->io_bio);
+		}
+		bio_add_page(wpc->ioend->io_bio, page, len, poff);
+	}
+
+	wpc->ioend->io_size += len;
+	wbc_account_cgroup_owner(wbc, page, len);
+}
+
+/*
+ * We implement an immediate ioend submission policy here to avoid needing to
+ * chain multiple ioends and hence nest mempool allocations which can violate
+ * forward progress guarantees we need to provide. The current ioend we are
+ * adding blocks to is cached on the writepage context, and if the new block
+ * does not append to the cached ioend it will create a new ioend and cache that
+ * instead.
+ *
+ * If a new ioend is created and cached, the old ioend is returned and queued
+ * locally for submission once the entire page is processed or an error has been
+ * detected.  While ioends are submitted immediately after they are completed,
+ * batching optimisations are provided by higher level block plugging.
+ *
+ * At the end of a writeback pass, there will be a cached ioend remaining on the
+ * writepage context that the caller will need to submit.
+ */
+static int
+iomap_writepage_map(struct iomap_writepage_ctx *wpc,
+		struct writeback_control *wbc, struct inode *inode,
+		struct page *page, u64 end_offset)
+{
+	struct iomap_page *iop = to_iomap_page(page);
+	struct iomap_ioend *ioend, *next;
+	unsigned len = i_blocksize(inode);
+	u64 file_offset; /* file offset of page */
+	int error = 0, count = 0, i;
+	LIST_HEAD(submit_list);
+
+	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
+
+	/*
+	 * Walk through the page to find areas to write back. If we run off the
+	 * end of the current map or find the current map invalid, grab a new
+	 * one.
+	 */
+	for (i = 0, file_offset = page_offset(page);
+	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
+	     i++, file_offset += len) {
+		if (iop && !test_bit(i, iop->uptodate))
+			continue;
+
+		error = wpc->ops->map_blocks(wpc, inode, file_offset);
+		if (error)
+			break;
+		if (wpc->iomap.type == IOMAP_HOLE)
+			continue;
+		iomap_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
+				 &submit_list);
+		count++;
+	}
+
+	WARN_ON_ONCE(!wpc->ioend && !list_empty(&submit_list));
+	WARN_ON_ONCE(!PageLocked(page));
+	WARN_ON_ONCE(PageWriteback(page));
+
+	/*
+	 * We cannot cancel the ioend directly here on error.  We may have
+	 * already set other pages under writeback and hence we have to run I/O
+	 * completion to mark the error state of the pages under writeback
+	 * appropriately.
+	 */
+	if (unlikely(error)) {
+		if (!count) {
+			/*
+			 * If the current page hasn't been added to ioend, it
+			 * won't be affected by I/O completions and we must
+			 * discard and unlock it right here.
+			 */
+			if (wpc->ops->discard_page)
+				wpc->ops->discard_page(page);
+			ClearPageUptodate(page);
+			unlock_page(page);
+			goto done;
+		}
+
+		/*
+		 * If the page was not fully cleaned, we need to ensure that the
+		 * higher layers come back to it correctly.  That means we need
+		 * to keep the page dirty, and for WB_SYNC_ALL writeback we need
+		 * to ensure the PAGECACHE_TAG_TOWRITE index mark is not removed
+		 * so another attempt to write this page in this writeback sweep
+		 * will be made.
+		 */
+		set_page_writeback_keepwrite(page);
+	} else {
+		clear_page_dirty_for_io(page);
+		set_page_writeback(page);
+	}
+
+	unlock_page(page);
+
+	/*
+	 * Preserve the original error if there was one, otherwise catch
+	 * submission errors here and propagate into subsequent ioend
+	 * submissions.
+	 */
+	list_for_each_entry_safe(ioend, next, &submit_list, io_list) {
+		int error2;
+
+		list_del_init(&ioend->io_list);
+		error2 = iomap_submit_ioend(wpc, ioend, error);
+		if (error2 && !error)
+			error = error2;
+	}
+
+	/*
+	 * We can end up here with no error and nothing to write only if we race
+	 * with a partial page truncate on a sub-page block sized filesystem.
+	 */
+	if (!count)
+		end_page_writeback(page);
+done:
+	mapping_set_error(page->mapping, error);
+	return error;
+}
+
+/*
+ * Write out a dirty page.
+ *
+ * For delalloc space on the page we need to allocate space and flush it.
+ * For unwritten space on the page we need to start the conversion to
+ * regular allocated space.
+ */
+static int
+iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
+{
+	struct iomap_writepage_ctx *wpc = data;
+	struct inode *inode = page->mapping->host;
+	pgoff_t end_index;
+	u64 end_offset;
+	loff_t offset;
+
+	trace_iomap_writepage(inode, page, 0, 0);
+
+	/*
+	 * Refuse to write the page out if we are called from reclaim context.
+	 *
+	 * This avoids stack overflows when called from deeply used stacks in
+	 * random callers for direct reclaim or memcg reclaim.  We explicitly
+	 * allow reclaim from kswapd as the stack usage there is relatively low.
+	 *
+	 * This should never happen except in the case of a VM regression so
+	 * warn about it.
+	 */
+	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
+			PF_MEMALLOC))
+		goto redirty;
+
+	/*
+	 * Given that we do not allow direct reclaim to call us, we should
+	 * never be called in a recursive filesystem reclaim context.
+	 */
+	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
+		goto redirty;
+
+	/*
+	 * Is this page beyond the end of the file?
+	 *
+	 * The page index is less than the end_index, adjust the end_offset
+	 * to the highest offset that this page should represent.
+	 * -----------------------------------------------------
+	 * |			file mapping	       | <EOF> |
+	 * -----------------------------------------------------
+	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
+	 * ^--------------------------------^----------|--------
+	 * |     desired writeback range    |      see else    |
+	 * ---------------------------------^------------------|
+	 */
+	offset = i_size_read(inode);
+	end_index = offset >> PAGE_SHIFT;
+	if (page->index < end_index)
+		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
+	else {
+		/*
+		 * Check whether the page to write out is beyond or straddles
+		 * i_size or not.
+		 * -------------------------------------------------------
+		 * |		file mapping		        | <EOF>  |
+		 * -------------------------------------------------------
+		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
+		 * ^--------------------------------^-----------|---------
+		 * |				    |      Straddles     |
+		 * ---------------------------------^-----------|--------|
+		 */
+		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+
+		/*
+		 * Skip the page if it is fully outside i_size, e.g. due to a
+		 * truncate operation that is in progress. We must redirty the
+		 * page so that reclaim stops reclaiming it. Otherwise
+		 * iomap_vm_releasepage() is called on it and gets confused.
+		 *
+		 * Note that the end_index is unsigned long, it would overflow
+		 * if the given offset is greater than 16TB on 32-bit system
+		 * and if we do check the page is fully outside i_size or not
+		 * via "if (page->index >= end_index + 1)" as "end_index + 1"
+		 * will be evaluated to 0.  Hence this page will be redirtied
+		 * and be written out repeatedly which would result in an
+		 * infinite loop, the user program that perform this operation
+		 * will hang.  Instead, we can verify this situation by checking
+		 * if the page to write is totally beyond the i_size or if it's
+		 * offset is just equal to the EOF.
+		 */
+		if (page->index > end_index ||
+		    (page->index == end_index && offset_into_page == 0))
+			goto redirty;
+
+		/*
+		 * The page straddles i_size.  It must be zeroed out on each
+		 * and every writepage invocation because it may be mmapped.
+		 * "A file is mapped in multiples of the page size.  For a file
+		 * that is not a multiple of the page size, the remaining
+		 * memory is zeroed when mapped, and writes to that region are
+		 * not written out to the file."
+		 */
+		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+
+		/* Adjust the end_offset to the end of file */
+		end_offset = offset;
+	}
+
+	return iomap_writepage_map(wpc, wbc, inode, page, end_offset);
+
+redirty:
+	redirty_page_for_writepage(wbc, page);
+	unlock_page(page);
+	return 0;
+}
+
+int
+iomap_writepage(struct page *page, struct writeback_control *wbc,
+		struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops)
+{
+	int ret;
+
+	wpc->ops = ops;
+	ret = iomap_do_writepage(page, wbc, wpc);
+	if (!wpc->ioend)
+		return ret;
+	return iomap_submit_ioend(wpc, wpc->ioend, ret);
+}
+EXPORT_SYMBOL_GPL(iomap_writepage);
+
+int
+iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
+		struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops)
+{
+	int			ret;
+
+	wpc->ops = ops;
+	ret = write_cache_pages(mapping, wbc, iomap_do_writepage, wpc);
+	if (!wpc->ioend)
+		return ret;
+	return iomap_submit_ioend(wpc, wpc->ioend, ret);
+}
+EXPORT_SYMBOL_GPL(iomap_writepages);
+
+static int __init iomap_init(void)
+{
+	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+			   offsetof(struct iomap_ioend, io_inline_bio),
+			   BIOSET_NEED_BVECS);
+}
+fs_initcall(iomap_init);
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 63a98ad01b0f..4ca1aa2f3f6e 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -76,6 +76,7 @@ DEFINE_EVENT(iomap_page_class, name,	\
 	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
 		 unsigned int len),	\
 	TP_ARGS(inode, page, off, len))
+DEFINE_PAGE_EVENT(iomap_writepage);
 DEFINE_PAGE_EVENT(iomap_releasepage);
 DEFINE_PAGE_EVENT(iomap_invalidatepage);
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f08563e2bd9f..546bd8a48cad 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -18,16 +18,18 @@
 #include "xfs_bmap_util.h"
 #include "xfs_reflink.h"
 
-/*
- * structure owned by writepages passed to individual writepage calls
- */
 struct xfs_writepage_ctx {
-	struct iomap		iomap;
+	struct iomap_writepage_ctx ctx;
 	unsigned int		data_seq;
 	unsigned int		cow_seq;
-	struct xfs_ioend	*ioend;
 };
 
+static inline struct xfs_writepage_ctx *
+XFS_WPC(struct iomap_writepage_ctx *ctx)
+{
+	return container_of(ctx, struct xfs_writepage_ctx, ctx);
+}
+
 struct block_device *
 xfs_find_bdev_for_inode(
 	struct inode		*inode)
@@ -54,87 +56,10 @@ xfs_find_daxdev_for_inode(
 		return mp->m_ddev_targp->bt_daxdev;
 }
 
-static void
-xfs_finish_page_writeback(
-	struct inode		*inode,
-	struct bio_vec	*bvec,
-	int			error)
-{
-	struct iomap_page	*iop = to_iomap_page(bvec->bv_page);
-
-	if (error) {
-		SetPageError(bvec->bv_page);
-		mapping_set_error(inode->i_mapping, -EIO);
-	}
-
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
-	ASSERT(!iop || atomic_read(&iop->write_count) > 0);
-
-	if (!iop || atomic_dec_and_test(&iop->write_count))
-		end_page_writeback(bvec->bv_page);
-}
-
-/*
- * We're now finished for good with this ioend structure.  Update the page
- * state, release holds on bios, and finally free up memory.  Do not use the
- * ioend after this.
- */
-STATIC void
-xfs_destroy_ioend(
-	struct xfs_ioend	*ioend,
-	int			error)
-{
-	struct inode		*inode = ioend->io_inode;
-	struct bio		*bio = &ioend->io_inline_bio;
-	struct bio		*last = ioend->io_bio, *next;
-	u64			start = bio->bi_iter.bi_sector;
-	bool			quiet = bio_flagged(bio, BIO_QUIET);
-
-	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct bio_vec	*bvec;
-		struct bvec_iter_all iter_all;
-
-		/*
-		 * For the last bio, bi_private points to the ioend, so we
-		 * need to explicitly end the iteration here.
-		 */
-		if (bio == last)
-			next = NULL;
-		else
-			next = bio->bi_private;
-
-		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bvec, bio, iter_all)
-			xfs_finish_page_writeback(inode, bvec, error);
-		bio_put(bio);
-	}
-
-	if (unlikely(error && !quiet)) {
-		xfs_err_ratelimited(XFS_I(inode)->i_mount,
-			"writeback error on sector %llu", start);
-	}
-}
-
-static void
-xfs_destroy_ioends(
-	struct xfs_ioend	*ioend,
-	int			error)
-{
-	struct list_head	tmp;
-
-	list_replace_init(&ioend->io_list, &tmp);
-	xfs_destroy_ioend(ioend, error);
-	while ((ioend = list_first_entry_or_null(&tmp, struct xfs_ioend,
-			io_list))) {
-		list_del_init(&ioend->io_list);
-		xfs_destroy_ioend(ioend, error);
-	}
-}
-
 /*
  * Fast and loose check if this write could update the on-disk inode size.
  */
-static inline bool xfs_ioend_is_append(struct xfs_ioend *ioend)
+static inline bool xfs_ioend_is_append(struct iomap_ioend *ioend)
 {
 	return ioend->io_offset + ioend->io_size >
 		XFS_I(ioend->io_inode)->i_d.di_size;
@@ -142,7 +67,7 @@ static inline bool xfs_ioend_is_append(struct xfs_ioend *ioend)
 
 STATIC int
 xfs_setfilesize_trans_alloc(
-	struct xfs_ioend	*ioend)
+	struct iomap_ioend	*ioend)
 {
 	struct xfs_mount	*mp = XFS_I(ioend->io_inode)->i_mount;
 	struct xfs_trans	*tp;
@@ -215,7 +140,7 @@ xfs_setfilesize(
 
 STATIC int
 xfs_setfilesize_ioend(
-	struct xfs_ioend	*ioend,
+	struct iomap_ioend	*ioend,
 	int			error)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
@@ -243,7 +168,7 @@ xfs_setfilesize_ioend(
  */
 STATIC void
 xfs_end_ioend(
-	struct xfs_ioend	*ioend)
+	struct iomap_ioend	*ioend)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
 	xfs_off_t		offset = ioend->io_offset;
@@ -289,31 +214,10 @@ xfs_end_ioend(
 done:
 	if (ioend->io_private)
 		error = xfs_setfilesize_ioend(ioend, error);
-	xfs_destroy_ioends(ioend, error);
+	iomap_finish_ioends(ioend, error);
 	memalloc_nofs_restore(nofs_flag);
 }
 
-/*
- * We can merge two adjacent ioends if they have the same set of work to do.
- */
-static bool
-xfs_ioend_can_merge(
-	struct xfs_ioend	*ioend,
-	struct xfs_ioend	*next)
-{
-	if (ioend->io_bio->bi_status != next->io_bio->bi_status)
-		return false;
-	if ((ioend->io_flags & IOMAP_F_SHARED) ^
-	    (next->io_flags & IOMAP_F_SHARED))
-		return false;
-	if ((ioend->io_type == IOMAP_UNWRITTEN) ^
-	    (next->io_type == IOMAP_UNWRITTEN))
-		return false;
-	if (ioend->io_offset + ioend->io_size != next->io_offset)
-		return false;
-	return true;
-}
-
 /*
  * If the to be merged ioend has a preallocated transaction for file
  * size updates we need to ensure the ioend it is merged into also
@@ -322,8 +226,8 @@ xfs_ioend_can_merge(
  */
 static void
 xfs_ioend_merge_private(
-	struct xfs_ioend	*ioend,
-	struct xfs_ioend	*next)
+	struct iomap_ioend	*ioend,
+	struct iomap_ioend	*next)
 {
 	if (!ioend->io_private) {
 		ioend->io_private = next->io_private;
@@ -333,53 +237,6 @@ xfs_ioend_merge_private(
 	}
 }
 
-/* Try to merge adjacent completions. */
-STATIC void
-xfs_ioend_try_merge(
-	struct xfs_ioend	*ioend,
-	struct list_head	*more_ioends)
-{
-	struct xfs_ioend	*next;
-
-	INIT_LIST_HEAD(&ioend->io_list);
-
-	while ((next = list_first_entry_or_null(more_ioends, struct xfs_ioend,
-			io_list))) {
-		if (!xfs_ioend_can_merge(ioend, next))
-			break;
-		list_move_tail(&next->io_list, &ioend->io_list);
-		ioend->io_size += next->io_size;
-		if (next->io_private)
-			xfs_ioend_merge_private(ioend, next);
-	}
-}
-
-/* list_sort compare function for ioends */
-static int
-xfs_ioend_compare(
-	void			*priv,
-	struct list_head	*a,
-	struct list_head	*b)
-{
-	struct xfs_ioend	*ia;
-	struct xfs_ioend	*ib;
-
-	ia = container_of(a, struct xfs_ioend, io_list);
-	ib = container_of(b, struct xfs_ioend, io_list);
-	if (ia->io_offset < ib->io_offset)
-		return -1;
-	else if (ia->io_offset > ib->io_offset)
-		return 1;
-	return 0;
-}
-
-static void
-xfs_sort_ioends(
-	struct list_head	*ioend_list)
-{
-	list_sort(NULL, ioend_list, xfs_ioend_compare);
-}
-
 /* Finish all pending io completions. */
 void
 xfs_end_io(
@@ -387,7 +244,7 @@ xfs_end_io(
 {
 	struct xfs_inode	*ip =
 		container_of(work, struct xfs_inode, i_ioend_work);
-	struct xfs_ioend	*ioend;
+	struct iomap_ioend	*ioend;
 	struct list_head	tmp;
 	unsigned long		flags;
 
@@ -395,16 +252,16 @@ xfs_end_io(
 	list_replace_init(&ip->i_ioend_list, &tmp);
 	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 
-	xfs_sort_ioends(&tmp);
-	while ((ioend = list_first_entry_or_null(&tmp, struct xfs_ioend,
+	iomap_sort_ioends(&tmp);
+	while ((ioend = list_first_entry_or_null(&tmp, struct iomap_ioend,
 			io_list))) {
 		list_del_init(&ioend->io_list);
-		xfs_ioend_try_merge(ioend, &tmp);
+		iomap_ioend_try_merge(ioend, &tmp, xfs_ioend_merge_private);
 		xfs_end_ioend(ioend);
 	}
 }
 
-static inline bool xfs_ioend_needs_workqueue(struct xfs_ioend *ioend)
+static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
 {
 	return ioend->io_private ||
 		ioend->io_type == IOMAP_UNWRITTEN ||
@@ -415,20 +272,18 @@ STATIC void
 xfs_end_bio(
 	struct bio		*bio)
 {
-	struct xfs_ioend	*ioend = bio->bi_private;
+	struct iomap_ioend	*ioend = bio->bi_private;
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_mount	*mp = ip->i_mount;
 	unsigned long		flags;
 
-	if (xfs_ioend_needs_workqueue(ioend)) {
-		spin_lock_irqsave(&ip->i_ioend_lock, flags);
-		if (list_empty(&ip->i_ioend_list))
-			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
-						 &ip->i_ioend_work));
-		list_add_tail(&ioend->io_list, &ip->i_ioend_list);
-		spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
-	} else
-		xfs_destroy_ioend(ioend, blk_status_to_errno(bio->bi_status));
+	ASSERT(xfs_ioend_needs_workqueue(ioend));
+
+	spin_lock_irqsave(&ip->i_ioend_lock, flags);
+	if (list_empty(&ip->i_ioend_list))
+		WARN_ON_ONCE(!queue_work(ip->i_mount->m_unwritten_workqueue,
+					 &ip->i_ioend_work));
+	list_add_tail(&ioend->io_list, &ip->i_ioend_list);
+	spin_unlock_irqrestore(&ip->i_ioend_lock, flags);
 }
 
 /*
@@ -437,7 +292,7 @@ xfs_end_bio(
  */
 static bool
 xfs_imap_valid(
-	struct xfs_writepage_ctx	*wpc,
+	struct iomap_writepage_ctx	*wpc,
 	struct xfs_inode		*ip,
 	loff_t				offset)
 {
@@ -459,10 +314,10 @@ xfs_imap_valid(
 	 * checked (and found nothing at this offset) could have added
 	 * overlapping blocks.
 	 */
-	if (wpc->data_seq != READ_ONCE(ip->i_df.if_seq))
+	if (XFS_WPC(wpc)->data_seq != READ_ONCE(ip->i_df.if_seq))
 		return false;
 	if (xfs_inode_has_cow_data(ip) &&
-	    wpc->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
+	    XFS_WPC(wpc)->cow_seq != READ_ONCE(ip->i_cowfp->if_seq))
 		return false;
 	return true;
 }
@@ -477,12 +332,18 @@ xfs_imap_valid(
  */
 static int
 xfs_convert_blocks(
-	struct xfs_writepage_ctx *wpc,
+	struct iomap_writepage_ctx *wpc,
 	struct xfs_inode	*ip,
 	int			whichfork,
 	loff_t			offset)
 {
 	int			error;
+	unsigned		*seq;
+
+	if (whichfork == XFS_COW_FORK)
+		seq = &XFS_WPC(wpc)->cow_seq;
+	else
+		seq = &XFS_WPC(wpc)->data_seq;
 
 	/*
 	 * Attempt to allocate whatever delalloc extent currently backs offset
@@ -492,8 +353,7 @@ xfs_convert_blocks(
 	 */
 	do {
 		error = xfs_bmapi_convert_delalloc(ip, whichfork, offset,
-				&wpc->iomap, whichfork == XFS_COW_FORK ?
-					&wpc->cow_seq : &wpc->data_seq);
+				&wpc->iomap, seq);
 		if (error)
 			return error;
 	} while (wpc->iomap.offset + wpc->iomap.length <= offset);
@@ -501,9 +361,9 @@ xfs_convert_blocks(
 	return 0;
 }
 
-STATIC int
+static int
 xfs_map_blocks(
-	struct xfs_writepage_ctx *wpc,
+	struct iomap_writepage_ctx *wpc,
 	struct inode		*inode,
 	loff_t			offset)
 {
@@ -559,7 +419,7 @@ xfs_map_blocks(
 	    xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &imap))
 		cow_fsb = imap.br_startoff;
 	if (cow_fsb != NULLFILEOFF && cow_fsb <= offset_fsb) {
-		wpc->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
+		XFS_WPC(wpc)->cow_seq = READ_ONCE(ip->i_cowfp->if_seq);
 		xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
 		whichfork = XFS_COW_FORK;
@@ -582,7 +442,7 @@ xfs_map_blocks(
 	 */
 	if (!xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap))
 		imap.br_startoff = end_fsb;	/* fake a hole past EOF */
-	wpc->data_seq = READ_ONCE(ip->i_df.if_seq);
+	XFS_WPC(wpc)->data_seq = READ_ONCE(ip->i_df.if_seq);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
 	/* landed in a hole or beyond EOF? */
@@ -645,24 +505,9 @@ xfs_map_blocks(
 	return 0;
 }
 
-/*
- * Submit the bio for an ioend. We are passed an ioend with a bio attached to
- * it, and we submit that bio. The ioend may be used for multiple bio
- * submissions, so we only want to allocate an append transaction for the ioend
- * once. In the case of multiple bio submission, each bio will take an IO
- * reference to the ioend to ensure that the ioend completion is only done once
- * all bios have been submitted and the ioend is really done.
- *
- * If @status is non-zero, it means that we have a situation where some part of
- * the submission process has failed after we have marked paged for writeback
- * and unlocked them. In this situation, we need to fail the bio and ioend
- * rather than submit it to IO. This typically only happens on a filesystem
- * shutdown.
- */
-STATIC int
+static int
 xfs_submit_ioend(
-	struct writeback_control *wbc,
-	struct xfs_ioend	*ioend,
+	struct iomap_ioend	*ioend,
 	int			status)
 {
 	unsigned int		nofs_flag;
@@ -690,137 +535,9 @@ xfs_submit_ioend(
 
 	memalloc_nofs_restore(nofs_flag);
 
-	ioend->io_bio->bi_private = ioend;
-	ioend->io_bio->bi_end_io = xfs_end_bio;
-
-	/*
-	 * If we are failing the IO now, just mark the ioend with an
-	 * error and finish it. This will run IO completion immediately
-	 * as there is only one reference to the ioend at this point in
-	 * time.
-	 */
-	if (status) {
-		ioend->io_bio->bi_status = errno_to_blk_status(status);
-		bio_endio(ioend->io_bio);
-		return status;
-	}
-
-	submit_bio(ioend->io_bio);
-	return 0;
-}
-
-static struct xfs_ioend *
-xfs_alloc_ioend(
-	struct inode		*inode,
-	struct xfs_writepage_ctx *wpc,
-	xfs_off_t		offset,
-	sector_t		sector,
-	struct writeback_control *wbc)
-{
-	struct xfs_ioend	*ioend;
-	struct bio		*bio;
-
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
-	bio_set_dev(bio, wpc->iomap.bdev);
-	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
-	bio->bi_write_hint = inode->i_write_hint;
-	wbc_init_bio(wbc, bio);
-
-	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
-	INIT_LIST_HEAD(&ioend->io_list);
-	ioend->io_type = wpc->iomap.type;
-	ioend->io_flags = wpc->iomap.flags;
-	ioend->io_inode = inode;
-	ioend->io_size = 0;
-	ioend->io_offset = offset;
-	ioend->io_private = NULL;
-	ioend->io_bio = bio;
-	return ioend;
-}
-
-/*
- * Allocate a new bio, and chain the old bio to the new one.
- *
- * Note that we have to do perform the chaining in this unintuitive order
- * so that the bi_private linkage is set up in the right direction for the
- * traversal in xfs_destroy_ioend().
- */
-static struct bio *
-xfs_chain_bio(
-	struct bio		*prev)
-{
-	struct bio *new;
-
-	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
-	bio_copy_dev(new, prev);/* also copies over blkcg information */
-	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_opf = prev->bi_opf;
-	new->bi_write_hint = prev->bi_write_hint;
-
-	bio_chain(prev, new);
-	bio_get(prev);		/* for xfs_destroy_ioend */
-	submit_bio(prev);
-	return new;
-}
-
-static bool
-xfs_can_add_to_ioend(
-	struct xfs_writepage_ctx *wpc,
-	xfs_off_t		offset,
-	sector_t		sector)
-{
-	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
-	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
-		return false;
-	if (wpc->iomap.type != wpc->ioend->io_type)
-		return false;
-	if (offset != wpc->ioend->io_offset + wpc->ioend->io_size)
-		return false;
-	if (sector != bio_end_sector(wpc->ioend->io_bio))
-		return false;
-	return true;
-}
-
-/*
- * Test to see if we have an existing ioend structure that we could append to
- * first, otherwise finish off the current ioend and start another.
- */
-STATIC void
-xfs_add_to_ioend(
-	struct inode		*inode,
-	xfs_off_t		offset,
-	struct page		*page,
-	struct iomap_page	*iop,
-	struct xfs_writepage_ctx *wpc,
-	struct writeback_control *wbc,
-	struct list_head	*iolist)
-{
-	sector_t		sector = iomap_sector(&wpc->iomap, offset);
-	unsigned		len = i_blocksize(inode);
-	unsigned		poff = offset & (PAGE_SIZE - 1);
-	bool			merged, same_page = false;
-
-	if (!wpc->ioend || !xfs_can_add_to_ioend(wpc, offset, sector)) {
-		if (wpc->ioend)
-			list_add(&wpc->ioend->io_list, iolist);
-		wpc->ioend = xfs_alloc_ioend(inode, wpc, offset, sector, wbc);
-	}
-
-	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
-			&same_page);
-
-	if (iop && !same_page)
-		atomic_inc(&iop->write_count);
-
-	if (!merged) {
-		if (bio_full(wpc->ioend->io_bio, len))
-			wpc->ioend->io_bio = xfs_chain_bio(wpc->ioend->io_bio);
-		bio_add_page(wpc->ioend->io_bio, page, len, poff);
-	}
-
-	wpc->ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, page, len);
+	if (xfs_ioend_needs_workqueue(ioend))
+		ioend->io_bio->bi_end_io = xfs_end_bio;
+	return status;
 }
 
 /*
@@ -834,8 +551,8 @@ xfs_add_to_ioend(
  * transaction as there is no space left for block reservation (typically why we
  * see a ENOSPC in writeback).
  */
-STATIC void
-xfs_aops_discard_page(
+static void
+xfs_discard_page(
 	struct page		*page)
 {
 	struct inode		*inode = page->mapping->host;
@@ -860,243 +577,11 @@ xfs_aops_discard_page(
 	iomap_invalidatepage(page, 0, PAGE_SIZE);
 }
 
-/*
- * We implement an immediate ioend submission policy here to avoid needing to
- * chain multiple ioends and hence nest mempool allocations which can violate
- * forward progress guarantees we need to provide. The current ioend we are
- * adding blocks to is cached on the writepage context, and if the new block
- * does not append to the cached ioend it will create a new ioend and cache that
- * instead.
- *
- * If a new ioend is created and cached, the old ioend is returned and queued
- * locally for submission once the entire page is processed or an error has been
- * detected.  While ioends are submitted immediately after they are completed,
- * batching optimisations are provided by higher level block plugging.
- *
- * At the end of a writeback pass, there will be a cached ioend remaining on the
- * writepage context that the caller will need to submit.
- */
-static int
-xfs_writepage_map(
-	struct xfs_writepage_ctx *wpc,
-	struct writeback_control *wbc,
-	struct inode		*inode,
-	struct page		*page,
-	uint64_t		end_offset)
-{
-	LIST_HEAD(submit_list);
-	struct iomap_page	*iop = to_iomap_page(page);
-	unsigned		len = i_blocksize(inode);
-	struct xfs_ioend	*ioend, *next;
-	uint64_t		file_offset;	/* file offset of page */
-	int			error = 0, count = 0, i;
-
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
-	ASSERT(!iop || atomic_read(&iop->write_count) == 0);
-
-	/*
-	 * Walk through the page to find areas to write back. If we run off the
-	 * end of the current map or find the current map invalid, grab a new
-	 * one.
-	 */
-	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
-	     i++, file_offset += len) {
-		if (iop && !test_bit(i, iop->uptodate))
-			continue;
-
-		error = xfs_map_blocks(wpc, inode, file_offset);
-		if (error)
-			break;
-		if (wpc->iomap.type == IOMAP_HOLE)
-			continue;
-		xfs_add_to_ioend(inode, file_offset, page, iop, wpc, wbc,
-				 &submit_list);
-		count++;
-	}
-
-	ASSERT(wpc->ioend || list_empty(&submit_list));
-	ASSERT(PageLocked(page));
-	ASSERT(!PageWriteback(page));
-
-	/*
-	 * On error, we have to fail the ioend here because we may have set
-	 * pages under writeback, we have to make sure we run IO completion to
-	 * mark the error state of the IO appropriately, so we can't cancel the
-	 * ioend directly here.  That means we have to mark this page as under
-	 * writeback if we included any blocks from it in the ioend chain so
-	 * that completion treats it correctly.
-	 *
-	 * If we didn't include the page in the ioend, the on error we can
-	 * simply discard and unlock it as there are no other users of the page
-	 * now.  The caller will still need to trigger submission of outstanding
-	 * ioends on the writepage context so they are treated correctly on
-	 * error.
-	 */
-	if (unlikely(error)) {
-		if (!count) {
-			xfs_aops_discard_page(page);
-			ClearPageUptodate(page);
-			unlock_page(page);
-			goto done;
-		}
-
-		/*
-		 * If the page was not fully cleaned, we need to ensure that the
-		 * higher layers come back to it correctly.  That means we need
-		 * to keep the page dirty, and for WB_SYNC_ALL writeback we need
-		 * to ensure the PAGECACHE_TAG_TOWRITE index mark is not removed
-		 * so another attempt to write this page in this writeback sweep
-		 * will be made.
-		 */
-		set_page_writeback_keepwrite(page);
-	} else {
-		clear_page_dirty_for_io(page);
-		set_page_writeback(page);
-	}
-
-	unlock_page(page);
-
-	/*
-	 * Preserve the original error if there was one, otherwise catch
-	 * submission errors here and propagate into subsequent ioend
-	 * submissions.
-	 */
-	list_for_each_entry_safe(ioend, next, &submit_list, io_list) {
-		int error2;
-
-		list_del_init(&ioend->io_list);
-		error2 = xfs_submit_ioend(wbc, ioend, error);
-		if (error2 && !error)
-			error = error2;
-	}
-
-	/*
-	 * We can end up here with no error and nothing to write only if we race
-	 * with a partial page truncate on a sub-page block sized filesystem.
-	 */
-	if (!count)
-		end_page_writeback(page);
-done:
-	mapping_set_error(page->mapping, error);
-	return error;
-}
-
-/*
- * Write out a dirty page.
- *
- * For delalloc space on the page we need to allocate space and flush it.
- * For unwritten space on the page we need to start the conversion to
- * regular allocated space.
- */
-STATIC int
-xfs_do_writepage(
-	struct page		*page,
-	struct writeback_control *wbc,
-	void			*data)
-{
-	struct xfs_writepage_ctx *wpc = data;
-	struct inode		*inode = page->mapping->host;
-	loff_t			offset;
-	uint64_t              end_offset;
-	pgoff_t                 end_index;
-
-	trace_xfs_writepage(inode, page, 0, 0);
-
-	/*
-	 * Refuse to write the page out if we are called from reclaim context.
-	 *
-	 * This avoids stack overflows when called from deeply used stacks in
-	 * random callers for direct reclaim or memcg reclaim.  We explicitly
-	 * allow reclaim from kswapd as the stack usage there is relatively low.
-	 *
-	 * This should never happen except in the case of a VM regression so
-	 * warn about it.
-	 */
-	if (WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD)) ==
-			PF_MEMALLOC))
-		goto redirty;
-
-	/*
-	 * Given that we do not allow direct reclaim to call us, we should
-	 * never be called while in a filesystem transaction.
-	 */
-	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC_NOFS))
-		goto redirty;
-
-	/*
-	 * Is this page beyond the end of the file?
-	 *
-	 * The page index is less than the end_index, adjust the end_offset
-	 * to the highest offset that this page should represent.
-	 * -----------------------------------------------------
-	 * |			file mapping	       | <EOF> |
-	 * -----------------------------------------------------
-	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
-	 * ^--------------------------------^----------|--------
-	 * |     desired writeback range    |      see else    |
-	 * ---------------------------------^------------------|
-	 */
-	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (xfs_off_t)(page->index + 1) << PAGE_SHIFT;
-	else {
-		/*
-		 * Check whether the page to write out is beyond or straddles
-		 * i_size or not.
-		 * -------------------------------------------------------
-		 * |		file mapping		        | <EOF>  |
-		 * -------------------------------------------------------
-		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
-		 * ^--------------------------------^-----------|---------
-		 * |				    |      Straddles     |
-		 * ---------------------------------^-----------|--------|
-		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
-
-		/*
-		 * Skip the page if it is fully outside i_size, e.g. due to a
-		 * truncate operation that is in progress. We must redirty the
-		 * page so that reclaim stops reclaiming it. Otherwise
-		 * xfs_vm_releasepage() is called on it and gets confused.
-		 *
-		 * Note that the end_index is unsigned long, it would overflow
-		 * if the given offset is greater than 16TB on 32-bit system
-		 * and if we do check the page is fully outside i_size or not
-		 * via "if (page->index >= end_index + 1)" as "end_index + 1"
-		 * will be evaluated to 0.  Hence this page will be redirtied
-		 * and be written out repeatedly which would result in an
-		 * infinite loop, the user program that perform this operation
-		 * will hang.  Instead, we can verify this situation by checking
-		 * if the page to write is totally beyond the i_size or if it's
-		 * offset is just equal to the EOF.
-		 */
-		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
-			goto redirty;
-
-		/*
-		 * The page straddles i_size.  It must be zeroed out on each
-		 * and every writepage invocation because it may be mmapped.
-		 * "A file is mapped in multiples of the page size.  For a file
-		 * that is not a multiple of the page size, the remaining
-		 * memory is zeroed when mapped, and writes to that region are
-		 * not written out to the file."
-		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
-
-		/* Adjust the end_offset to the end of file */
-		end_offset = offset;
-	}
-
-	return xfs_writepage_map(wpc, wbc, inode, page, end_offset);
-
-redirty:
-	redirty_page_for_writepage(wbc, page);
-	unlock_page(page);
-	return 0;
-}
+static const struct iomap_writeback_ops xfs_writeback_ops = {
+	.map_blocks		= xfs_map_blocks,
+	.submit_ioend		= xfs_submit_ioend,
+	.discard_page		= xfs_discard_page,
+};
 
 STATIC int
 xfs_vm_writepage(
@@ -1104,12 +589,8 @@ xfs_vm_writepage(
 	struct writeback_control *wbc)
 {
 	struct xfs_writepage_ctx wpc = { };
-	int			ret;
 
-	ret = xfs_do_writepage(page, wbc, &wpc);
-	if (wpc.ioend)
-		ret = xfs_submit_ioend(wbc, wpc.ioend, ret);
-	return ret;
+	return iomap_writepage(page, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
 STATIC int
@@ -1118,13 +599,9 @@ xfs_vm_writepages(
 	struct writeback_control *wbc)
 {
 	struct xfs_writepage_ctx wpc = { };
-	int			ret;
 
 	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
-	ret = write_cache_pages(mapping, wbc, xfs_do_writepage, &wpc);
-	if (wpc.ioend)
-		ret = xfs_submit_ioend(wbc, wpc.ioend, ret);
-	return ret;
+	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
 }
 
 STATIC int
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 4a0226cdad4f..687b11f34fa2 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -6,23 +6,6 @@
 #ifndef __XFS_AOPS_H__
 #define __XFS_AOPS_H__
 
-extern struct bio_set xfs_ioend_bioset;
-
-/*
- * Structure for buffered I/O completions.
- */
-struct xfs_ioend {
-	struct list_head	io_list;	/* next ioend in chain */
-	u16			io_type;
-	u16			io_flags;	/* IOMAP_F_* */
-	struct inode		*io_inode;	/* file being written to */
-	size_t			io_size;	/* size of the extent */
-	xfs_off_t		io_offset;	/* offset in the file */
-	void			*io_private;	/* file system private data */
-	struct bio		*io_bio;	/* bio being built */
-	struct bio		io_inline_bio;	/* MUST BE LAST! */
-};
-
 extern const struct address_space_operations xfs_address_space_operations;
 extern const struct address_space_operations xfs_dax_aops;
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8d1df9f8be07..0a8cf6b87a21 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -40,7 +40,6 @@
 #include <linux/parser.h>
 
 static const struct super_operations xfs_super_operations;
-struct bio_set xfs_ioend_bioset;
 
 static struct kset *xfs_kset;		/* top-level xfs sysfs dir */
 #ifdef DEBUG
@@ -1853,15 +1852,10 @@ MODULE_ALIAS_FS("xfs");
 STATIC int __init
 xfs_init_zones(void)
 {
-	if (bioset_init(&xfs_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
-			offsetof(struct xfs_ioend, io_inline_bio),
-			BIOSET_NEED_BVECS))
-		goto out;
-
 	xfs_log_ticket_zone = kmem_zone_init(sizeof(xlog_ticket_t),
 						"xfs_log_ticket");
 	if (!xfs_log_ticket_zone)
-		goto out_free_ioend_bioset;
+		goto out;
 
 	xfs_bmap_free_item_zone = kmem_zone_init(
 			sizeof(struct xfs_extent_free_item),
@@ -1996,8 +1990,6 @@ xfs_init_zones(void)
 	kmem_zone_destroy(xfs_bmap_free_item_zone);
  out_destroy_log_ticket_zone:
 	kmem_zone_destroy(xfs_log_ticket_zone);
- out_free_ioend_bioset:
-	bioset_exit(&xfs_ioend_bioset);
  out:
 	return -ENOMEM;
 }
@@ -2028,7 +2020,6 @@ xfs_destroy_zones(void)
 	kmem_zone_destroy(xfs_btree_cur_zone);
 	kmem_zone_destroy(xfs_bmap_free_item_zone);
 	kmem_zone_destroy(xfs_log_ticket_zone);
-	bioset_exit(&xfs_ioend_bioset);
 }
 
 STATIC int __init
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index eae4b29c174e..cbb23d7a3554 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1158,45 +1158,6 @@ DEFINE_RW_EVENT(xfs_file_buffered_write);
 DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 
-DECLARE_EVENT_CLASS(xfs_page_class,
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off,
-		 unsigned int len),
-	TP_ARGS(inode, page, off, len),
-	TP_STRUCT__entry(
-		__field(dev_t, dev)
-		__field(xfs_ino_t, ino)
-		__field(pgoff_t, pgoff)
-		__field(loff_t, size)
-		__field(unsigned long, offset)
-		__field(unsigned int, length)
-	),
-	TP_fast_assign(
-		__entry->dev = inode->i_sb->s_dev;
-		__entry->ino = XFS_I(inode)->i_ino;
-		__entry->pgoff = page_offset(page);
-		__entry->size = i_size_read(inode);
-		__entry->offset = off;
-		__entry->length = len;
-	),
-	TP_printk("dev %d:%d ino 0x%llx pgoff 0x%lx size 0x%llx offset %lx "
-		  "length %x",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->ino,
-		  __entry->pgoff,
-		  __entry->size,
-		  __entry->offset,
-		  __entry->length)
-)
-
-#define DEFINE_PAGE_EVENT(name)		\
-DEFINE_EVENT(xfs_page_class, name,	\
-	TP_PROTO(struct inode *inode, struct page *page, unsigned long off, \
-		 unsigned int len),	\
-	TP_ARGS(inode, page, off, len))
-DEFINE_PAGE_EVENT(xfs_writepage);
-DEFINE_PAGE_EVENT(xfs_releasepage);
-DEFINE_PAGE_EVENT(xfs_invalidatepage);
-
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 24bd227d59f9..71fd12ee5616 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -4,6 +4,7 @@
 
 #include <linux/atomic.h>
 #include <linux/bitmap.h>
+#include <linux/blk_types.h>
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <linux/mm_types.h>
@@ -12,6 +13,7 @@
 struct address_space;
 struct fiemap_extent_info;
 struct inode;
+struct iomap_writepage_ctx;
 struct iov_iter;
 struct kiocb;
 struct page;
@@ -185,6 +187,63 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
 
+/*
+ * Structure for writeback I/O completions.
+ */
+struct iomap_ioend {
+	struct list_head	io_list;	/* next ioend in chain */
+	u16			io_type;
+	u16			io_flags;	/* IOMAP_F_* */
+	struct inode		*io_inode;	/* file being written to */
+	size_t			io_size;	/* size of the extent */
+	loff_t			io_offset;	/* offset in the file */
+	void			*io_private;	/* file system private data */
+	struct bio		*io_bio;	/* bio being built */
+	struct bio		io_inline_bio;	/* MUST BE LAST! */
+};
+
+struct iomap_writeback_ops {
+	/*
+	 * Required, maps the blocks so that writeback can be performed on
+	 * the range starting at offset.
+	 */
+	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
+				loff_t offset);
+
+	/*
+	 * Optional, allows the file systems to perform actions just before
+	 * submitting the bio and/or override the bio end_io handler for complex
+	 * operations like copy on write extent manipulation or unwritten extent
+	 * conversions.
+	 */
+	int (*submit_ioend)(struct iomap_ioend *ioend, int status);
+
+	/*
+	 * Optional, allows the file system to discard state on a page where
+	 * we failed to submit any I/O.
+	 */
+	void (*discard_page)(struct page *page);
+};
+
+struct iomap_writepage_ctx {
+	struct iomap		iomap;
+	struct iomap_ioend	*ioend;
+	const struct iomap_writeback_ops *ops;
+};
+
+void iomap_finish_ioends(struct iomap_ioend *ioend, int error);
+void iomap_ioend_try_merge(struct iomap_ioend *ioend,
+		struct list_head *more_ioends,
+		void (*merge_private)(struct iomap_ioend *ioend,
+				struct iomap_ioend *next));
+void iomap_sort_ioends(struct list_head *ioend_list);
+int iomap_writepage(struct page *page, struct writeback_control *wbc,
+		struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops);
+int iomap_writepages(struct address_space *mapping,
+		struct writeback_control *wbc, struct iomap_writepage_ctx *wpc,
+		const struct iomap_writeback_ops *ops);
+
 /*
  * Flags for direct I/O ->end_io:
  */
-- 
2.20.1

