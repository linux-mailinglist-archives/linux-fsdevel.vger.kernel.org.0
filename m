Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7279DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfG3BSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:18:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfG3BSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:18:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18bdo095522;
        Tue, 30 Jul 2019 01:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pyv5kZjJGs+A8eGMeQTU//Tm1tDH8Oc/39OFSGKv+Cg=;
 b=2MudFwkdI2Z5Z336euhRuuxDtl+cyNuOhJdNecSsKgzVsGcWj7vfzLgxV4c71hILxJDr
 fqGnp0jW1/kTIYJxUApURcoH8nw0qVLK0qD84OCoEd2my6JxPeQY51OL5UkdvJf0Iscz
 S8MAfCL7Mj6Ntba5EIINsgZiAQaEuEloPC73QOel+tcMHCdMpHErvywnLDZe2MUrRgA6
 R+SWF7pe+bO6EmgT1MUrOc9qzCyyDXIkH1Q9rreZLK9Colua3z8KH8HDL75BIvBKKOXK
 Z5wjvQo6v3SnSpmhU9SHCz4nlGHNgRtdrGVOwZBLMlJPUP8UxHrguZYXbHOYdi0iWpT5 rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u0ejpb0f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1DEbn003528;
        Tue, 30 Jul 2019 01:17:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u0ee4nb8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:17:55 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U1Hrqm010844;
        Tue, 30 Jul 2019 01:17:54 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:17:53 -0700
Subject: [PATCH 2/6] iomap: copy the xfs writeback code to iomap.c
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:17:52 -0700
Message-ID: <156444947277.2682261.14371480217831737439.stgit@magnolia>
In-Reply-To: <156444945993.2682261.3926017251626679029.stgit@magnolia>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Takes the xfs writeback code and copies it to iomap.c.  A new structure
with three methods is added as the abstraction from the generic
writeback code to the file system.  These methods are used to map
blocks, submit an ioend, and cancel a page that encountered an error
before it was added to an ioend.

Note that we temporarily lose the writepage tracing, but that will
be added back soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[darrick: create the new iomap code, we'll delete the xfs code separately]
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c |  548 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h  |   43 ++++
 2 files changed, 590 insertions(+), 1 deletion(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..ff1f7d2b4d7a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2010 Red Hat, Inc.
- * Copyright (c) 2016-2018 Christoph Hellwig.
+ * Copyright (c) 2016-2019 Christoph Hellwig.
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
@@ -19,6 +20,8 @@
 
 #include "../internal.h"
 
+static struct bio_set iomap_ioend_bioset;
+
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
@@ -1071,3 +1074,546 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, const struct iomap_ops *ops)
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
+		struct bio_vec	*bvec;
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
+		bio_for_each_segment_all(bvec, bio, iter_all)
+			iomap_finish_page_writeback(inode, bvec, error);
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
+	while ((ioend = list_pop_entry(&tmp, struct iomap_ioend, io_list)))
+		iomap_finish_ioend(ioend, error);
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
+ * Submit the bio for an ioend. We are passed an ioend with a bio attached to
+ * it, and we submit that bio. The ioend may be used for multiple bio
+ * submissions, so we only want to allocate an append transaction for the ioend
+ * once. In the case of multiple bio submission, each bio will take an IO
+ * reference to the ioend to ensure that the ioend completion is only done once
+ * all bios have been submitted and the ioend is really done.
+ *
+ * If @error is non-zero, it means that we have a situation where some part of
+ * the submission process has failed after we have marked paged for writeback
+ * and unlocked them. In this situation, we need to fail the bio and ioend
+ * rather than submit it to IO. This typically only happens on a filesystem
+ * shutdown.
+ */
+static int
+iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
+		int error)
+{
+	ioend->io_bio->bi_private = ioend;
+	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
+
+	/*
+	 * File systems can perform actions at submit time and/or override
+	 * the end_io handler here for complex operations like copy on write
+	 * extent manipulation or unwritten extent conversions.
+	 */
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
+	if (!wpc->ioend ||
+	    (wpc->iomap.flags & IOMAP_F_SHARED) !=
+	    (wpc->ioend->io_flags & IOMAP_F_SHARED) ||
+	    wpc->iomap.type != wpc->ioend->io_type ||
+	    sector != bio_end_sector(wpc->ioend->io_bio) ||
+	    offset != wpc->ioend->io_offset + wpc->ioend->io_size) {
+		if (wpc->ioend)
+			list_add(&wpc->ioend->io_list, iolist);
+		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
+	}
+
+	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
+			&same_page);
+
+	if (iop && !same_page)
+		atomic_inc(&iop->write_count);
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
+	 * On error, we have to fail the ioend here because we may have set
+	 * pages under writeback, we have to make sure we run IO completion to
+	 * mark the error state of the IO appropriately, so we can't cancel the
+	 * ioend directly here.  That means we have to mark this page as under
+	 * writeback if we included any blocks from it in the ioend chain so
+	 * that completion treats it correctly.
+	 *
+	 * If we didn't include the page in the ioend, the on error we can
+	 * simply discard and unlock it as there are no other users of the page
+	 * now.  The caller will still need to trigger submission of outstanding
+	 * ioends on the writepage context so they are treated correctly on
+	 * error.
+	 */
+	if (unlikely(error)) {
+		if (!count) {
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
+	 * never be called while in a filesystem transaction.
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
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bc499ceae392..834d3923e2f2 100644
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
@@ -183,6 +185,47 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
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
+	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
+				loff_t offset);
+	int (*submit_ioend)(struct iomap_ioend *ioend, int status);
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

