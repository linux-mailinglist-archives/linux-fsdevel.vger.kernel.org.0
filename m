Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B367B37B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjAYNfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjAYNfS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:35:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940E53E43;
        Wed, 25 Jan 2023 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5e3umRwOKACXFKw82QaWO4SWjP0rM/pbj8DPbGZpua8=; b=HbM04clQ1tr1H4+Fsuq4fwwRDr
        BR3RaFyH5ACZMGS8ouq+xMWOJRmcTGO9gU27KDtTnGpiOXvOiJi7m50oIzEXOmoeTS9nBev3VcbPt
        UK3z/Ug2vtctMFcCxVVFyyhGknUvg8rIpcpXNZ2yoIpvfFQSJ1etXKiG2IjYyZewqnPcYrDZXdNPl
        qVuW+PKfjWdalrcHBZX+KfUcuKUldfz3JJGXV267Pw15umOs3kzU6X2HXmkECCtMllgl8CZcmg8xk
        CAQciVZ2kwsUL9nBtVzdU86xxsUKFTRdnonWJprknyXjh5Z81bERiAbC73dYTyvtR9xAM2W64lJvP
        hmkPEhfw==;
Received: from [2001:4bb8:19a:27af:c78f:9b0d:b95c:d248] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKfvd-007P9D-SE; Wed, 25 Jan 2023 13:35:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 7/7] block: remove ->rw_page
Date:   Wed, 25 Jan 2023 14:34:36 +0100
Message-Id: <20230125133436.447864-8-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
References: <20230125133436.447864-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ->rw_page method is a special purpose bypass of the usual bio
handling path that is limited to single-page reads and writes and
synchronous which causes a lot of extra code in the drivers, callers
and the block layer.

The only remaining user is the MM swap code.  Switch that swap code to
simply submit a single-vec on-stack bio an synchronously wait on it
based on a newly added QUEUE_FLAG_SYNCHRONOUS flag set by the drivers
that currently implement ->rw_page instead.  While this touches one
extra cache line and executes extra code, it simplifies the block
layer and drivers and ensures that all feastures are properly supported
by all drivers, e.g. right now ->rw_page bypassed cgroup writeback
entirely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c                  | 78 -----------------------------------
 drivers/block/brd.c           | 15 +------
 drivers/block/zram/zram_drv.c | 61 +--------------------------
 drivers/nvdimm/btt.c          | 16 +------
 drivers/nvdimm/pmem.c         | 24 +----------
 include/linux/blkdev.h        | 12 +++---
 mm/page_io.c                  | 53 ++++++++++++++----------
 mm/swapfile.c                 |  2 +-
 8 files changed, 44 insertions(+), 217 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df404..1795c7d4b99efa 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -304,84 +304,6 @@ int thaw_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(thaw_bdev);
 
-/**
- * bdev_read_page() - Start reading a page from a block device
- * @bdev: The device to read the page from
- * @sector: The offset on the device to read the page to (need not be aligned)
- * @page: The page to read
- *
- * On entry, the page should be locked.  It will be unlocked when the page
- * has been read.  If the block driver implements rw_page synchronously,
- * that will be true on exit from this function, but it need not be.
- *
- * Errors returned by this function are usually "soft", eg out of memory, or
- * queue full; callers should try a different route to read this page rather
- * than propagate an error back up the stack.
- *
- * Return: negative errno if an error occurs, 0 if submission was successful.
- */
-int bdev_read_page(struct block_device *bdev, sector_t sector,
-			struct page *page)
-{
-	const struct block_device_operations *ops = bdev->bd_disk->fops;
-	int result = -EOPNOTSUPP;
-
-	if (!ops->rw_page || bdev_get_integrity(bdev))
-		return result;
-
-	result = blk_queue_enter(bdev_get_queue(bdev), 0);
-	if (result)
-		return result;
-	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
-			      REQ_OP_READ);
-	blk_queue_exit(bdev_get_queue(bdev));
-	return result;
-}
-
-/**
- * bdev_write_page() - Start writing a page to a block device
- * @bdev: The device to write the page to
- * @sector: The offset on the device to write the page to (need not be aligned)
- * @page: The page to write
- * @wbc: The writeback_control for the write
- *
- * On entry, the page should be locked and not currently under writeback.
- * On exit, if the write started successfully, the page will be unlocked and
- * under writeback.  If the write failed already (eg the driver failed to
- * queue the page to the device), the page will still be locked.  If the
- * caller is a ->writepage implementation, it will need to unlock the page.
- *
- * Errors returned by this function are usually "soft", eg out of memory, or
- * queue full; callers should try a different route to write this page rather
- * than propagate an error back up the stack.
- *
- * Return: negative errno if an error occurs, 0 if submission was successful.
- */
-int bdev_write_page(struct block_device *bdev, sector_t sector,
-			struct page *page, struct writeback_control *wbc)
-{
-	int result;
-	const struct block_device_operations *ops = bdev->bd_disk->fops;
-
-	if (!ops->rw_page || bdev_get_integrity(bdev))
-		return -EOPNOTSUPP;
-	result = blk_queue_enter(bdev_get_queue(bdev), 0);
-	if (result)
-		return result;
-
-	set_page_writeback(page);
-	result = ops->rw_page(bdev, sector + get_start_sect(bdev), page,
-			      REQ_OP_WRITE);
-	if (result) {
-		end_page_writeback(page);
-	} else {
-		clean_page_buffers(page);
-		unlock_page(page);
-	}
-	blk_queue_exit(bdev_get_queue(bdev));
-	return result;
-}
-
 /*
  * pseudo-fs
  */
diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 20acc4a1fd6def..37dce184eb56c6 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -309,23 +309,9 @@ static void brd_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int brd_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, enum req_op op)
-{
-	struct brd_device *brd = bdev->bd_disk->private_data;
-	int err;
-
-	if (PageTransHuge(page))
-		return -ENOTSUPP;
-	err = brd_do_bvec(brd, page, PAGE_SIZE, 0, op, sector);
-	page_endio(page, op_is_write(op), err);
-	return err;
-}
-
 static const struct block_device_operations brd_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		brd_submit_bio,
-	.rw_page =		brd_rw_page,
 };
 
 /*
@@ -411,6 +397,7 @@ static int brd_alloc(int i)
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
 	err = add_disk(disk);
 	if (err)
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e290d6d970474e..4d5af9bbbea649 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1453,10 +1453,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		/* Slot should be unlocked before the function call */
 		zram_slot_unlock(zram, index);
 
-		/* A null bio means rw_page was used, we must fallback to bio */
-		if (!bio)
-			return -EOPNOTSUPP;
-
 		ret = zram_bvec_read_from_bdev(zram, page, index, bio,
 					       partial_io);
 	}
@@ -2081,61 +2077,6 @@ static void zram_slot_free_notify(struct block_device *bdev,
 	zram_slot_unlock(zram, index);
 }
 
-static int zram_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, enum req_op op)
-{
-	int offset, ret;
-	u32 index;
-	struct zram *zram;
-	struct bio_vec bv;
-	unsigned long start_time;
-
-	if (PageTransHuge(page))
-		return -ENOTSUPP;
-	zram = bdev->bd_disk->private_data;
-
-	if (!valid_io_request(zram, sector, PAGE_SIZE)) {
-		atomic64_inc(&zram->stats.invalid_io);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	index = sector >> SECTORS_PER_PAGE_SHIFT;
-	offset = (sector & (SECTORS_PER_PAGE - 1)) << SECTOR_SHIFT;
-
-	bv.bv_page = page;
-	bv.bv_len = PAGE_SIZE;
-	bv.bv_offset = 0;
-
-	start_time = bdev_start_io_acct(bdev->bd_disk->part0,
-			SECTORS_PER_PAGE, op, jiffies);
-	ret = zram_bvec_rw(zram, &bv, index, offset, op, NULL);
-	bdev_end_io_acct(bdev->bd_disk->part0, op, start_time);
-out:
-	/*
-	 * If I/O fails, just return error(ie, non-zero) without
-	 * calling page_endio.
-	 * It causes resubmit the I/O with bio request by upper functions
-	 * of rw_page(e.g., swap_readpage, __swap_writepage) and
-	 * bio->bi_end_io does things to handle the error
-	 * (e.g., SetPageError, set_page_dirty and extra works).
-	 */
-	if (unlikely(ret < 0))
-		return ret;
-
-	switch (ret) {
-	case 0:
-		page_endio(page, op_is_write(op), 0);
-		break;
-	case 1:
-		ret = 0;
-		break;
-	default:
-		WARN_ON(1);
-	}
-	return ret;
-}
-
 static void zram_destroy_comps(struct zram *zram)
 {
 	u32 prio;
@@ -2290,7 +2231,6 @@ static const struct block_device_operations zram_devops = {
 	.open = zram_open,
 	.submit_bio = zram_submit_bio,
 	.swap_slot_free_notify = zram_slot_free_notify,
-	.rw_page = zram_rw_page,
 	.owner = THIS_MODULE
 };
 
@@ -2389,6 +2329,7 @@ static int zram_add(void)
 	set_capacity(zram->disk, 0);
 	/* zram devices sort of resembles non-rotational disks */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, zram->disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, zram->disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, zram->disk->queue);
 
 	/*
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0297b7882e33bd..d5593b0dc7009c 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1482,20 +1482,6 @@ static void btt_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int btt_rw_page(struct block_device *bdev, sector_t sector,
-		struct page *page, enum req_op op)
-{
-	struct btt *btt = bdev->bd_disk->private_data;
-	int rc;
-
-	rc = btt_do_bvec(btt, NULL, page, thp_size(page), 0, op, sector);
-	if (rc == 0)
-		page_endio(page, op_is_write(op), 0);
-
-	return rc;
-}
-
-
 static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
 	/* some standard values */
@@ -1508,7 +1494,6 @@ static int btt_getgeo(struct block_device *bd, struct hd_geometry *geo)
 static const struct block_device_operations btt_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		btt_submit_bio,
-	.rw_page =		btt_rw_page,
 	.getgeo =		btt_getgeo,
 };
 
@@ -1530,6 +1515,7 @@ static int btt_blk_init(struct btt *btt)
 	blk_queue_logical_block_size(btt->btt_disk->queue, btt->sector_size);
 	blk_queue_max_hw_sectors(btt->btt_disk->queue, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, btt->btt_disk->queue);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, btt->btt_disk->queue);
 
 	if (btt_meta_size(btt)) {
 		rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 96e6e9a5f235d8..ceea55f621cc7f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -238,28 +238,6 @@ static void pmem_submit_bio(struct bio *bio)
 	bio_endio(bio);
 }
 
-static int pmem_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, enum req_op op)
-{
-	struct pmem_device *pmem = bdev->bd_disk->private_data;
-	blk_status_t rc;
-
-	if (op_is_write(op))
-		rc = pmem_do_write(pmem, page, 0, sector, thp_size(page));
-	else
-		rc = pmem_do_read(pmem, page, 0, sector, thp_size(page));
-	/*
-	 * The ->rw_page interface is subtle and tricky.  The core
-	 * retries on any error, so we can only invoke page_endio() in
-	 * the successful completion case.  Otherwise, we'll see crashes
-	 * caused by double completion.
-	 */
-	if (rc == 0)
-		page_endio(page, op_is_write(op), 0);
-
-	return blk_status_to_errno(rc);
-}
-
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, enum dax_access_mode mode, void **kaddr,
@@ -310,7 +288,6 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
-	.rw_page =		pmem_rw_page,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
@@ -565,6 +542,7 @@ static int pmem_attach_disk(struct device *dev,
 	blk_queue_logical_block_size(q, pmem_sector_size(ndns));
 	blk_queue_max_hw_sectors(q, UINT_MAX);
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
 	if (pmem->pfn_flags & PFN_MAP)
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 89f51d68c68ad6..1bffe8f44ae9a8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -555,6 +555,7 @@ struct request_queue {
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
+#define QUEUE_FLAG_SYNCHRONOUS	11	/* always complets in submit context */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
 #define QUEUE_FLAG_STABLE_WRITES 15	/* don't modify blks until WB is done */
@@ -1252,6 +1253,12 @@ static inline bool bdev_nonrot(struct block_device *bdev)
 	return blk_queue_nonrot(bdev_get_queue(bdev));
 }
 
+static inline bool bdev_synchronous(struct block_device *bdev)
+{
+	return test_bit(QUEUE_FLAG_SYNCHRONOUS,
+			&bdev_get_queue(bdev)->queue_flags);
+}
+
 static inline bool bdev_stable_writes(struct block_device *bdev)
 {
 	return test_bit(QUEUE_FLAG_STABLE_WRITES,
@@ -1396,7 +1403,6 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-	int (*rw_page)(struct block_device *, sector_t, struct page *, enum req_op);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
@@ -1431,10 +1437,6 @@ extern int blkdev_compat_ptr_ioctl(struct block_device *, fmode_t,
 #define blkdev_compat_ptr_ioctl NULL
 #endif
 
-extern int bdev_read_page(struct block_device *, sector_t, struct page *);
-extern int bdev_write_page(struct block_device *, sector_t, struct page *,
-						struct writeback_control *);
-
 static inline void blk_wake_io_task(struct task_struct *waiter)
 {
 	/*
diff --git a/mm/page_io.c b/mm/page_io.c
index 2ee2bfe5de0386..69931fcbe7ce6e 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -28,7 +28,7 @@
 #include <linux/delayacct.h>
 #include "swap.h"
 
-static void end_swap_bio_write(struct bio *bio)
+static void __end_swap_bio_write(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
 
@@ -49,6 +49,11 @@ static void end_swap_bio_write(struct bio *bio)
 		ClearPageReclaim(page);
 	}
 	end_page_writeback(page);
+}
+
+static void end_swap_bio_write(struct bio *bio)
+{
+	__end_swap_bio_write(bio);
 	bio_put(bio);
 }
 
@@ -327,15 +332,31 @@ static void swap_writepage_fs(struct page *page, struct writeback_control *wbc)
 		*wbc->swap_plug = sio;
 }
 
-static void swap_writepage_bdev(struct page *page,
+static void swap_writepage_bdev_sync(struct page *page,
 		struct writeback_control *wbc, struct swap_info_struct *sis)
 {
-	struct bio *bio;
+	struct bio_vec bv;
+	struct bio bio;
 
-	if (!bdev_write_page(sis->bdev, swap_page_sector(page), page, wbc)) {
-		count_swpout_vm_event(page);
-		return;
-	}
+	bio_init(&bio, sis->bdev, &bv, 1,
+		 REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc));
+	bio.bi_iter.bi_sector = swap_page_sector(page);
+	bio_add_page(&bio, page, thp_size(page), 0);
+
+	bio_associate_blkg_from_page(&bio, page);
+	count_swpout_vm_event(page);
+
+	set_page_writeback(page);
+	unlock_page(page);
+
+	submit_bio_wait(&bio);
+	__end_swap_bio_write(&bio);
+}
+
+static void swap_writepage_bdev_async(struct page *page,
+		struct writeback_control *wbc, struct swap_info_struct *sis)
+{
+	struct bio *bio;
 
 	bio = bio_alloc(sis->bdev, 1,
 			REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc),
@@ -363,8 +384,10 @@ void __swap_writepage(struct page *page, struct writeback_control *wbc)
 	 */
 	if (data_race(sis->flags & SWP_FS_OPS))
 		swap_writepage_fs(page, wbc);
+	else if (sis->flags & SWP_SYNCHRONOUS_IO)
+		swap_writepage_bdev_sync(page, wbc, sis);
 	else
-		swap_writepage_bdev(page, wbc, sis);
+		swap_writepage_bdev_async(page, wbc, sis);
 }
 
 void swap_write_unplug(struct swap_iocb *sio)
@@ -448,12 +471,6 @@ static void swap_readpage_bdev_sync(struct page *page,
 	struct bio_vec bv;
 	struct bio bio;
 
-	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
-	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
-		count_vm_event(PSWPIN);
-		return;
-	}
-
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = swap_page_sector(page);
 	bio_add_page(&bio, page, thp_size(page), 0);
@@ -473,12 +490,6 @@ static void swap_readpage_bdev_async(struct page *page,
 {
 	struct bio *bio;
 
-	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
-	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
-		count_vm_event(PSWPIN);
-		return;
-	}
-
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
@@ -514,7 +525,7 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 		unlock_page(page);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_readpage_fs(page, plug);
-	} else if (synchronous) {
+	} else if (synchronous || (sis->flags & SWP_SYNCHRONOUS_IO)) {
 		swap_readpage_bdev_sync(page, sis);
 	} else {
 		swap_readpage_bdev_async(page, sis);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 908a529bca12c9..dc61050a46d8ef 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3069,7 +3069,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
-	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
+	if (p->bdev && bdev_synchronous(p->bdev))
 		p->flags |= SWP_SYNCHRONOUS_IO;
 
 	if (p->bdev && bdev_nonrot(p->bdev)) {
-- 
2.39.0

