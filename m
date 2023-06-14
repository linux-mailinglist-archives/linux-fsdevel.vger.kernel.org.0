Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E784B72999D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 14:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbjFIMVq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbjFIMVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:21:42 -0400
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F930CD;
        Fri,  9 Jun 2023 05:21:36 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 0057742543;
        Fri,  9 Jun 2023 08:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1686312373;
        bh=w41iDVc5LKMZ73O5cZY/nfU0O2QCnXg1jdgooADFqMk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=tjdqmr0SeuRcez0d7Vsxm/JvxE6XxmYIgDESdbSeoR7s2ZAlF5JXS/73XaBe+HYfr
         LI/T2qw4erfKLr/Q0/ER2K0BOevdoOUJ4ctYi+iWTPNdr+h607FQzPk/51yg13sBm8
         aBQBsqujWahKuQFP9eI/GIQ2hi/aM9UerlY/F6iMKSSGVwOjghGp4f1XMhVITIWwSm
         E9Ccqvx6AMpgjma5rpelhOF5GmcR1I48B7Z1YkeZey8YPJbvfVvwFibXUiQWQV6bJr
         gidLDXrJt+0vs2ttQVjJXoVz/VqKGwVSC3LZD+/79k2/tkS86dX2Uyjpa96MP6XmDU
         0lBeRmqJxFmyA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 14:06:10 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <dlemoal@kernel.org>, <wsa@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <ming.lei@redhat.com>,
        <gregkh@linuxfoundation.org>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <sergei.shtepa@veeam.com>
Subject: [PATCH v4 08/11] blksnap: difference storage
Date:   Fri, 9 Jun 2023 13:58:55 +0200
Message-ID: <20230609115858.4737-8-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230609115858.4737-1-sergei.shtepa@veeam.com>
References: <20230609115858.4737-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554627C6B
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provides management of difference blocks of block devices. Storing
difference blocks, and reading them to get a snapshot images.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/diff_area.c    | 554 +++++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 144 +++++++
 drivers/block/blksnap/diff_buffer.c  | 127 ++++++
 drivers/block/blksnap/diff_buffer.h  |  37 ++
 drivers/block/blksnap/diff_storage.c | 315 +++++++++++++++
 drivers/block/blksnap/diff_storage.h | 111 ++++++
 6 files changed, 1288 insertions(+)
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h

diff --git a/drivers/block/blksnap/diff_area.c b/drivers/block/blksnap/diff_area.c
new file mode 100644
index 000000000000..831505689dfd
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-area: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "chunk.h"
+#include "diff_buffer.h"
+#include "diff_storage.h"
+#include "params.h"
+
+static inline sector_t diff_area_chunk_offset(struct diff_area *diff_area,
+					      sector_t sector)
+{
+	return sector & ((1ull << (diff_area->chunk_shift - SECTOR_SHIFT)) - 1);
+}
+
+static inline unsigned long diff_area_chunk_number(struct diff_area *diff_area,
+						   sector_t sector)
+{
+	return (unsigned long)(sector >>
+			       (diff_area->chunk_shift - SECTOR_SHIFT));
+}
+
+static inline sector_t chunk_sector(struct chunk *chunk)
+{
+	return (sector_t)(chunk->number)
+	       << (chunk->diff_area->chunk_shift - SECTOR_SHIFT);
+}
+
+static inline sector_t last_chunk_size(sector_t sector_count, sector_t capacity)
+{
+	sector_t capacity_rounded = round_down(capacity, sector_count);
+
+	if (capacity > capacity_rounded)
+		sector_count = capacity - capacity_rounded;
+
+	return sector_count;
+}
+
+static inline unsigned long long count_by_shift(sector_t capacity,
+						unsigned long long shift)
+{
+	unsigned long long shift_sector = (shift - SECTOR_SHIFT);
+
+	return round_up(capacity, (1ull << shift_sector)) >> shift_sector;
+}
+
+static inline struct chunk *chunk_alloc(struct diff_area *diff_area,
+					unsigned long number)
+{
+	struct chunk *chunk;
+
+	chunk = kzalloc(sizeof(struct chunk), GFP_NOIO);
+	if (!chunk)
+		return NULL;
+
+	INIT_LIST_HEAD(&chunk->link);
+	sema_init(&chunk->lock, 1);
+	chunk->diff_area = NULL;
+	chunk->number = number;
+	chunk->state = CHUNK_ST_NEW;
+
+	chunk->sector_count = diff_area_chunk_sectors(diff_area);
+	/*
+	 * The last chunk has a special size.
+	 */
+	if (unlikely((number + 1) == diff_area->chunk_count)) {
+		chunk->sector_count = bdev_nr_sectors(diff_area->orig_bdev) -
+					(chunk->sector_count * number);
+	}
+
+	return chunk;
+}
+
+static inline void chunk_free(struct diff_area *diff_area, struct chunk *chunk)
+{
+	down(&chunk->lock);
+	if (chunk->diff_buffer)
+		diff_buffer_release(diff_area, chunk->diff_buffer);
+	diff_storage_free_region(chunk->diff_region);
+	up(&chunk->lock);
+	kfree(chunk);
+}
+
+static void diff_area_calculate_chunk_size(struct diff_area *diff_area)
+{
+	unsigned long count;
+	unsigned long shift = get_chunk_minimum_shift();
+	sector_t capacity;
+	sector_t min_io_sect;
+
+	min_io_sect = (sector_t)(bdev_io_min(diff_area->orig_bdev) >>
+		SECTOR_SHIFT);
+	capacity = bdev_nr_sectors(diff_area->orig_bdev);
+	pr_debug("Minimal IO block %llu sectors\n", min_io_sect);
+	pr_debug("Device capacity %llu sectors\n", capacity);
+
+	count = count_by_shift(capacity, shift);
+	pr_debug("Chunks count %lu\n", count);
+	while ((count > get_chunk_maximum_count()) ||
+		((1ul << (shift - SECTOR_SHIFT)) < min_io_sect)) {
+		shift++;
+		count = count_by_shift(capacity, shift);
+		pr_debug("Chunks count %lu\n", count);
+	}
+
+	diff_area->chunk_shift = shift;
+	diff_area->chunk_count = (unsigned long)DIV_ROUND_UP_ULL(capacity,
+					(1ul << (shift - SECTOR_SHIFT)));
+}
+
+void diff_area_free(struct kref *kref)
+{
+	unsigned long inx = 0;
+	struct chunk *chunk;
+	struct diff_area *diff_area =
+		container_of(kref, struct diff_area, kref);
+
+	might_sleep();
+
+	flush_work(&diff_area->store_queue_work);
+	xa_for_each(&diff_area->chunk_map, inx, chunk)
+		if (chunk)
+			chunk_free(diff_area, chunk);
+	xa_destroy(&diff_area->chunk_map);
+
+	if (diff_area->orig_bdev) {
+		blkdev_put(diff_area->orig_bdev, FMODE_READ | FMODE_WRITE);
+		diff_area->orig_bdev = NULL;
+	}
+
+	/* Clean up free_diff_buffers */
+	diff_buffer_cleanup(diff_area);
+
+	kfree(diff_area);
+}
+
+static inline bool diff_area_store_one(struct diff_area *diff_area)
+{
+	struct chunk *iter, *chunk = NULL;
+
+	spin_lock(&diff_area->store_queue_lock);
+	list_for_each_entry(iter, &diff_area->store_queue, link) {
+		if (!down_trylock(&iter->lock)) {
+			chunk = iter;
+			atomic_dec(&diff_area->store_queue_count);
+			list_del_init(&chunk->link);
+			chunk->diff_area = diff_area_get(diff_area);
+			break;
+		}
+		/*
+		 * If it is not possible to lock a chunk for writing,
+		 * then it is currently in use, and we try to clean up the
+		 * next chunk.
+		 */
+	}
+	spin_unlock(&diff_area->store_queue_lock);
+	if (!chunk)
+		return false;
+
+	if (chunk->state != CHUNK_ST_IN_MEMORY) {
+		/*
+		 * There cannot be a chunk in the store queue whose buffer has
+		 * not been read into memory.
+		 */
+		chunk_up(chunk);
+		pr_warn("Cannot release empty buffer for chunk #%ld",
+			chunk->number);
+		return true;
+	}
+
+	if (diff_area_is_corrupted(diff_area)) {
+		chunk_store_failed(chunk, 0);
+		return true;
+	}
+
+	if (!chunk->diff_region) {
+		struct diff_region *diff_region;
+
+		diff_region = diff_storage_new_region(
+			diff_area->diff_storage,
+			diff_area_chunk_sectors(diff_area),
+			diff_area->logical_blksz);
+
+		if (IS_ERR(diff_region)) {
+			pr_debug("Cannot get store for chunk #%ld\n",
+				 chunk->number);
+			chunk_store_failed(chunk, PTR_ERR(diff_region));
+			return true;
+		}
+		chunk->diff_region = diff_region;
+	}
+	chunk_store(chunk);
+	return true;
+}
+
+static void diff_area_store_queue_work(struct work_struct *work)
+{
+	struct diff_area *diff_area = container_of(
+		work, struct diff_area, store_queue_work);
+
+	while (diff_area_store_one(diff_area))
+		;
+}
+
+struct diff_area *diff_area_new(dev_t dev_id, struct diff_storage *diff_storage)
+{
+	int ret = 0;
+	struct diff_area *diff_area = NULL;
+	struct block_device *bdev;
+
+	pr_debug("Open device [%u:%u]\n", MAJOR(dev_id), MINOR(dev_id));
+
+	bdev = blkdev_get_by_dev(dev_id, FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(bdev)) {
+		int err = PTR_ERR(bdev);
+
+		pr_err("Failed to open device. errno=%d\n", abs(err));
+		return ERR_PTR(err);
+	}
+
+	diff_area = kzalloc(sizeof(struct diff_area), GFP_KERNEL);
+	if (!diff_area) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&diff_area->kref);
+	diff_area->orig_bdev = bdev;
+	diff_area->diff_storage = diff_storage;
+
+	diff_area_calculate_chunk_size(diff_area);
+	if (diff_area->chunk_shift > get_chunk_maximum_shift()) {
+		pr_info("The maximum allowable chunk size has been reached.\n");
+		return ERR_PTR(-EFAULT);
+	}
+	pr_debug("The optimal chunk size was calculated as %llu bytes for device [%d:%d]\n",
+		 (1ull << diff_area->chunk_shift),
+		 MAJOR(diff_area->orig_bdev->bd_dev),
+		 MINOR(diff_area->orig_bdev->bd_dev));
+
+	xa_init(&diff_area->chunk_map);
+
+	spin_lock_init(&diff_area->store_queue_lock);
+	INIT_LIST_HEAD(&diff_area->store_queue);
+	atomic_set(&diff_area->store_queue_count, 0);
+	INIT_WORK(&diff_area->store_queue_work, diff_area_store_queue_work);
+
+	spin_lock_init(&diff_area->free_diff_buffers_lock);
+	INIT_LIST_HEAD(&diff_area->free_diff_buffers);
+	atomic_set(&diff_area->free_diff_buffers_count, 0);
+
+	diff_area->physical_blksz = bdev->bd_queue->limits.physical_block_size;
+	diff_area->logical_blksz = bdev->bd_queue->limits.logical_block_size;
+	diff_area->corrupt_flag = 0;
+
+	if (!diff_storage->capacity) {
+		pr_err("Difference storage is empty\n");
+		pr_err("In-memory difference storage is not supported\n");
+		ret = -EFAULT;
+	}
+
+	if (ret) {
+		diff_area_put(diff_area);
+		return ERR_PTR(ret);
+	}
+
+	return diff_area;
+}
+
+static inline unsigned int chunk_limit(struct chunk *chunk,
+				       struct bvec_iter *iter)
+{
+	sector_t chunk_ofs = iter->bi_sector - chunk_sector(chunk);
+	sector_t chunk_left = chunk->sector_count - chunk_ofs;
+
+	return min(iter->bi_size, (unsigned int)(chunk_left << SECTOR_SHIFT));
+}
+
+/*
+ * Implements the copy-on-write mechanism.
+ */
+bool diff_area_cow(struct bio *bio, struct diff_area *diff_area,
+		   struct bvec_iter *iter)
+{
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	struct bio *chunk_bio = NULL;
+	LIST_HEAD(chunks);
+	int ret = 0;
+
+	while (iter->bi_size) {
+		unsigned long nr = diff_area_chunk_number(diff_area,
+							  iter->bi_sector);
+		struct chunk *chunk = xa_load(&diff_area->chunk_map, nr);
+		unsigned int len;
+
+		if (!chunk) {
+			chunk = chunk_alloc(diff_area, nr);
+			if (!chunk) {
+				diff_area_set_corrupted(diff_area, -EINVAL);
+				ret = -ENOMEM;
+				goto fail;
+			}
+
+			ret = xa_insert(&diff_area->chunk_map, nr, chunk,
+					GFP_NOIO);
+			if (likely(!ret)) {
+				/* new chunk has been added */
+			} else if (ret == -EBUSY) {
+				/* another chunk has just been created */
+				chunk_free(diff_area, chunk);
+				chunk = xa_load(&diff_area->chunk_map, nr);
+				WARN_ON_ONCE(!chunk);
+				if (unlikely(!chunk)) {
+					ret = -EINVAL;
+					diff_area_set_corrupted(diff_area, ret);
+					goto fail;
+				}
+			} else if (ret) {
+				pr_err("Failed insert chunk to chunk map\n");
+				chunk_free(diff_area, chunk);
+				diff_area_set_corrupted(diff_area, ret);
+				goto fail;
+			}
+		}
+
+		if (nowait) {
+			if (down_trylock(&chunk->lock)) {
+				ret = -EAGAIN;
+				goto fail;
+			}
+		} else {
+			ret = down_killable(&chunk->lock);
+			if (unlikely(ret))
+				goto fail;
+		}
+		chunk->diff_area = diff_area_get(diff_area);
+
+		len = chunk_limit(chunk, iter);
+		if (chunk->state == CHUNK_ST_NEW) {
+			if (nowait) {
+				/*
+				 * If the data of this chunk has not yet been
+				 * copied to the difference storage, then it is
+				 * impossible to process the I/O write unit with
+				 * the NOWAIT flag.
+				 */
+				chunk_up(chunk);
+				ret = -EAGAIN;
+				goto fail;
+			}
+
+			/*
+			 * Load the chunk asynchronously.
+			 */
+			ret = chunk_load_and_postpone_io(chunk, &chunk_bio);
+			if (ret) {
+				chunk_up(chunk);
+				goto fail;
+			}
+			list_add_tail(&chunk->link, &chunks);
+		} else {
+			/*
+			 * The chunk has already been:
+			 *   - failed, when the snapshot is corrupted
+			 *   - read into the buffer
+			 *   - stored into the diff storage
+			 * In this case, we do not change the chunk.
+			 */
+			chunk_up(chunk);
+		}
+		bio_advance_iter_single(bio, iter, len);
+	}
+
+	if (chunk_bio) {
+		/* Postpone bio processing in a callback. */
+		chunk_load_and_postpone_io_finish(&chunks, chunk_bio, bio);
+		return true;
+	}
+	/* Pass bio to the low level */
+	return false;
+
+fail:
+	if (chunk_bio) {
+		chunk_bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(chunk_bio);
+	}
+
+	if (ret == -EAGAIN) {
+		/*
+		 * The -EAGAIN error code means that it is not possible to
+		 * process a I/O unit with a flag REQ_NOWAIT.
+		 * I/O unit processing is being completed with such error.
+		 */
+		bio->bi_status = BLK_STS_AGAIN;
+		bio_endio(bio);
+		return true;
+	}
+	/* In any other case, the processing of the I/O unit continues.	*/
+	return false;
+}
+
+static void orig_clone_endio(struct bio *bio)
+{
+	struct bio *orig_bio = bio->bi_private;
+
+	if (unlikely(bio->bi_status != BLK_STS_OK))
+		bio_io_error(orig_bio);
+	else
+		bio_endio(orig_bio);
+}
+
+static void orig_clone_bio(struct diff_area *diff_area, struct bio *bio)
+{
+	struct bio *new_bio;
+	struct block_device *bdev = diff_area->orig_bdev;
+	sector_t chunk_limit;
+
+	new_bio = chunk_alloc_clone(bdev, bio);
+	WARN_ON(!new_bio);
+
+	chunk_limit = diff_area_chunk_sectors(diff_area) -
+		      diff_area_chunk_offset(diff_area, bio->bi_iter.bi_sector);
+
+	new_bio->bi_iter.bi_sector = bio->bi_iter.bi_sector;
+	new_bio->bi_iter.bi_size = min_t(unsigned int,
+			bio->bi_iter.bi_size, chunk_limit << SECTOR_SHIFT);
+
+	bio_set_flag(new_bio, BIO_FILTERED);
+	new_bio->bi_end_io = orig_clone_endio;
+	new_bio->bi_private = bio;
+
+	bio_advance(bio, new_bio->bi_iter.bi_size);
+	bio_inc_remaining(bio);
+
+	submit_bio_noacct(new_bio);
+}
+
+bool diff_area_submit_chunk(struct diff_area *diff_area, struct bio *bio)
+{
+	int ret;
+	struct chunk *chunk;
+	unsigned long nr = diff_area_chunk_number(diff_area,
+						  bio->bi_iter.bi_sector);
+
+	chunk = xa_load(&diff_area->chunk_map, nr);
+	/*
+	 * If this chunk is not in the chunk map, then the COW algorithm did
+	 * not access this part of the disk space, and writing to the snapshot
+	 * in this part was also not performed.
+	 */
+	if (!chunk) {
+		if (op_is_write(bio_op(bio))) {
+			/*
+			 * To process a write bio, we need to allocate a new
+			 * chunk.
+			 */
+			chunk = chunk_alloc(diff_area, nr);
+			WARN_ON_ONCE(!chunk);
+			if (unlikely(!chunk))
+				return false;
+
+			ret = xa_insert(&diff_area->chunk_map, nr, chunk,
+					GFP_NOIO);
+			if (likely(!ret)) {
+				/* new chunk has been added */
+			} else if (ret == -EBUSY) {
+				/* another chunk has just been created */
+				chunk_free(diff_area, chunk);
+				chunk = xa_load(&diff_area->chunk_map, nr);
+				WARN_ON_ONCE(!chunk);
+				if (unlikely(!chunk))
+					return false;
+			} else if (ret) {
+				pr_err("Failed insert chunk to chunk map\n");
+				chunk_free(diff_area, chunk);
+				return false;
+			}
+		} else {
+			/*
+			 * To read, we simply redirect the bio to the original
+			 * block device.
+			 */
+			orig_clone_bio(diff_area, bio);
+			return true;
+		}
+	}
+
+	if (down_killable(&chunk->lock))
+		return false;
+	chunk->diff_area = diff_area_get(diff_area);
+
+	if (unlikely(chunk->state == CHUNK_ST_FAILED)) {
+		pr_err("Chunk #%ld corrupted\n", chunk->number);
+		chunk_up(chunk);
+		return false;
+	}
+	if (chunk->state == CHUNK_ST_IN_MEMORY) {
+		/*
+		 * Directly copy data from the in-memory chunk or
+		 * copy to the in-memory chunk for write operation.
+		 */
+		chunk_copy_bio(chunk, bio, &bio->bi_iter);
+		chunk_up(chunk);
+		return true;
+	}
+	if ((chunk->state == CHUNK_ST_STORED) || !op_is_write(bio_op(bio))) {
+		/*
+		 * Read data from the chunk on difference storage.
+		 */
+		chunk_clone_bio(chunk, bio);
+		chunk_up(chunk);
+		return true;
+	}
+	/*
+	 * Starts asynchronous loading of a chunk from the original block device
+	 * or difference storage and schedule copying data to (or from) the
+	 * in-memory chunk.
+	 */
+	if (chunk_load_and_schedule_io(chunk, bio)) {
+		chunk_up(chunk);
+		return false;
+	}
+	return true;
+}
+
+static inline void diff_area_event_corrupted(struct diff_area *diff_area)
+{
+	struct blksnap_event_corrupted data = {
+		.dev_id_mj = MAJOR(diff_area->orig_bdev->bd_dev),
+		.dev_id_mn = MINOR(diff_area->orig_bdev->bd_dev),
+		.err_code = abs(diff_area->error_code),
+	};
+
+	event_gen(&diff_area->diff_storage->event_queue, GFP_NOIO,
+		  blksnap_event_code_corrupted, &data,
+		  sizeof(struct blksnap_event_corrupted));
+}
+
+void diff_area_set_corrupted(struct diff_area *diff_area, int err_code)
+{
+	if (test_and_set_bit(0, &diff_area->corrupt_flag))
+		return;
+
+	diff_area->error_code = err_code;
+	diff_area_event_corrupted(diff_area);
+
+	pr_err("Set snapshot device is corrupted for [%u:%u] with error code %d\n",
+	       MAJOR(diff_area->orig_bdev->bd_dev),
+	       MINOR(diff_area->orig_bdev->bd_dev), abs(err_code));
+}
diff --git a/drivers/block/blksnap/diff_area.h b/drivers/block/blksnap/diff_area.h
new file mode 100644
index 000000000000..6ecec9390282
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_DIFF_AREA_H
+#define __BLKSNAP_DIFF_AREA_H
+
+#include <linux/slab.h>
+#include <linux/uio.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/blkdev.h>
+#include <linux/xarray.h>
+#include "event_queue.h"
+
+struct diff_storage;
+struct chunk;
+
+/**
+ * struct diff_area - Describes the difference area for one original device.
+ *
+ * @kref:
+ *	The reference counter allows to manage the lifetime of an object.
+ * @orig_bdev:
+ *	A pointer to the structure of an opened block device.
+ * @diff_storage:
+ *	Pointer to difference storage for storing difference data.
+ * @chunk_shift:
+ *	Power of 2 used to specify the chunk size. This allows to set different
+ *	chunk sizes for huge and small block devices.
+ * @chunk_count:
+ *	Count of chunks. The number of chunks into which the block device
+ *	is divided.
+ * @chunk_map:
+ *	A map of chunks.
+ * @store_queue_lock:
+ *	This spinlock guarantees consistency of the linked lists of chunks
+ *	queue.
+ * @store_queue:
+ *	The queue of chunks waiting to be stored to the difference storage.
+ * @store_queue_count:
+ *	The number of chunks in the store queue.
+ * @store_queue_work:
+ *	The workqueue work item. This worker limits the number of chunks
+ *	that store their data in RAM.
+ * @free_diff_buffers_lock:
+ *	This spinlock guarantees consistency of the linked lists of
+ *	free difference buffers.
+ * @free_diff_buffers:
+ *	Linked list of free difference buffers allows to reduce the number
+ *	of buffer allocation and release operations.
+ * @physical_blksz:
+ *	The physical block size for the snapshot image is equal to the
+ *	physical block size of the original device.
+ * @logical_blksz:
+ *	The logical block size for the snapshot image is equal to the
+ *	logical block size of the original device.
+ * @free_diff_buffers_count:
+ *	The number of free difference buffers in the linked list.
+ * @corrupt_flag:
+ *	The flag is set if an error occurred in the operation of the data
+ *	saving mechanism in the diff area. In this case, an error will be
+ *	generated when reading from the snapshot image.
+ * @error_code:
+ *	The error code that caused the snapshot to be corrupted.
+ *
+ * The &struct diff_area is created for each block device in the snapshot.
+ * It is used to save the differences between the original block device and
+ * the snapshot image. That is, when writing data to the original device,
+ * the differences are copied as chunks to the difference storage.
+ * Reading and writing from the snapshot image is also performed using
+ * &struct diff_area.
+ *
+ * The xarray has a limit on the maximum size. This can be especially
+ * noticeable on 32-bit systems. This creates a limit in the size of
+ * supported disks.
+ *
+ * For example, for a 256 TiB disk with a block size of 65536 bytes, the
+ * number of elements in the chunk map will be equal to 2 with a power of 32.
+ * Therefore, the number of chunks into which the block device is divided is
+ * limited.
+ *
+ * The store queue allows to postpone the operation of storing a chunks data
+ * to the difference storage and perform it later in the worker thread.
+ *
+ * The linked list of difference buffers allows to have a certain number of
+ * "hot" buffers. This allows to reduce the number of allocations and releases
+ * of memory.
+ *
+ *
+ */
+struct diff_area {
+	struct kref kref;
+	struct block_device *orig_bdev;
+	struct diff_storage *diff_storage;
+
+	unsigned long chunk_shift;
+	unsigned long chunk_count;
+	struct xarray chunk_map;
+
+	spinlock_t store_queue_lock;
+	struct list_head store_queue;
+	atomic_t store_queue_count;
+	struct work_struct store_queue_work;
+
+	spinlock_t free_diff_buffers_lock;
+	struct list_head free_diff_buffers;
+	atomic_t free_diff_buffers_count;
+
+	unsigned int physical_blksz;
+	unsigned int logical_blksz;
+
+	unsigned long corrupt_flag;
+	int error_code;
+};
+
+struct diff_area *diff_area_new(dev_t dev_id,
+				struct diff_storage *diff_storage);
+void diff_area_free(struct kref *kref);
+static inline struct diff_area *diff_area_get(struct diff_area *diff_area)
+{
+	kref_get(&diff_area->kref);
+	return diff_area;
+};
+static inline void diff_area_put(struct diff_area *diff_area)
+{
+	kref_put(&diff_area->kref, diff_area_free);
+};
+
+void diff_area_set_corrupted(struct diff_area *diff_area, int err_code);
+static inline bool diff_area_is_corrupted(struct diff_area *diff_area)
+{
+	return !!diff_area->corrupt_flag;
+};
+static inline sector_t diff_area_chunk_sectors(struct diff_area *diff_area)
+{
+	return (sector_t)(1ull << (diff_area->chunk_shift - SECTOR_SHIFT));
+};
+bool diff_area_cow(struct bio *bio, struct diff_area *diff_area,
+		   struct bvec_iter *iter);
+
+bool diff_area_submit_chunk(struct diff_area *diff_area, struct bio *bio);
+void diff_area_rw_chunk(struct kref *kref);
+
+#endif /* __BLKSNAP_DIFF_AREA_H */
diff --git a/drivers/block/blksnap/diff_buffer.c b/drivers/block/blksnap/diff_buffer.c
new file mode 100644
index 000000000000..77ad59cc46b3
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-buffer: " fmt
+
+#include "diff_buffer.h"
+#include "diff_area.h"
+#include "params.h"
+
+static void diff_buffer_free(struct diff_buffer *diff_buffer)
+{
+	size_t inx = 0;
+
+	if (unlikely(!diff_buffer))
+		return;
+
+	for (inx = 0; inx < diff_buffer->page_count; inx++) {
+		struct page *page = diff_buffer->pages[inx];
+
+		if (page)
+			__free_page(page);
+	}
+
+	kfree(diff_buffer);
+}
+
+static struct diff_buffer *
+diff_buffer_new(size_t page_count, size_t buffer_size, gfp_t gfp_mask)
+{
+	struct diff_buffer *diff_buffer;
+	size_t inx = 0;
+	struct page *page;
+
+	if (unlikely(page_count <= 0))
+		return NULL;
+
+	/*
+	 * In case of overflow, it is better to get a null pointer
+	 * than a pointer to some memory area. Therefore + 1.
+	 */
+	diff_buffer = kzalloc(sizeof(struct diff_buffer) +
+				      (page_count + 1) * sizeof(struct page *),
+			      gfp_mask);
+	if (!diff_buffer)
+		return NULL;
+
+	INIT_LIST_HEAD(&diff_buffer->link);
+	diff_buffer->size = buffer_size;
+	diff_buffer->page_count = page_count;
+
+	for (inx = 0; inx < page_count; inx++) {
+		page = alloc_page(gfp_mask);
+		if (!page)
+			goto fail;
+
+		diff_buffer->pages[inx] = page;
+	}
+	return diff_buffer;
+fail:
+	diff_buffer_free(diff_buffer);
+	return NULL;
+}
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area)
+{
+	struct diff_buffer *diff_buffer = NULL;
+	sector_t chunk_sectors;
+	size_t page_count;
+	size_t buffer_size;
+
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	diff_buffer = list_first_entry_or_null(&diff_area->free_diff_buffers,
+					       struct diff_buffer, link);
+	if (diff_buffer) {
+		list_del(&diff_buffer->link);
+		atomic_dec(&diff_area->free_diff_buffers_count);
+	}
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+
+	/* Return free buffer if it was found in a pool */
+	if (diff_buffer)
+		return diff_buffer;
+
+	/* Allocate new buffer */
+	chunk_sectors = diff_area_chunk_sectors(diff_area);
+	page_count = round_up(chunk_sectors, PAGE_SECTORS) / PAGE_SECTORS;
+	buffer_size = chunk_sectors << SECTOR_SHIFT;
+
+	diff_buffer =
+		diff_buffer_new(page_count, buffer_size, GFP_NOIO);
+	if (unlikely(!diff_buffer))
+		return ERR_PTR(-ENOMEM);
+	return diff_buffer;
+}
+
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer)
+{
+	if (atomic_read(&diff_area->free_diff_buffers_count) >
+	    get_free_diff_buffer_pool_size()) {
+		diff_buffer_free(diff_buffer);
+		return;
+	}
+	spin_lock(&diff_area->free_diff_buffers_lock);
+	list_add_tail(&diff_buffer->link, &diff_area->free_diff_buffers);
+	atomic_inc(&diff_area->free_diff_buffers_count);
+	spin_unlock(&diff_area->free_diff_buffers_lock);
+}
+
+void diff_buffer_cleanup(struct diff_area *diff_area)
+{
+	struct diff_buffer *diff_buffer = NULL;
+
+	do {
+		spin_lock(&diff_area->free_diff_buffers_lock);
+		diff_buffer =
+			list_first_entry_or_null(&diff_area->free_diff_buffers,
+						 struct diff_buffer, link);
+		if (diff_buffer) {
+			list_del(&diff_buffer->link);
+			atomic_dec(&diff_area->free_diff_buffers_count);
+		}
+		spin_unlock(&diff_area->free_diff_buffers_lock);
+
+		if (diff_buffer)
+			diff_buffer_free(diff_buffer);
+	} while (diff_buffer);
+}
diff --git a/drivers/block/blksnap/diff_buffer.h b/drivers/block/blksnap/diff_buffer.h
new file mode 100644
index 000000000000..f81e56cf4b9a
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_DIFF_BUFFER_H
+#define __BLKSNAP_DIFF_BUFFER_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/blkdev.h>
+
+struct diff_area;
+
+/**
+ * struct diff_buffer - Difference buffer.
+ * @link:
+ *	The list header allows to create a pool of the diff_buffer structures.
+ * @size:
+ *	Count of bytes in the buffer.
+ * @page_count:
+ *	The number of pages reserved for the buffer.
+ * @pages:
+ *	An array of pointers to pages.
+ *
+ * Describes the memory buffer for a chunk in the memory.
+ */
+struct diff_buffer {
+	struct list_head link;
+	size_t size;
+	size_t page_count;
+	struct page *pages[0];
+};
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area);
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer);
+void diff_buffer_cleanup(struct diff_area *diff_area);
+#endif /* __BLKSNAP_DIFF_BUFFER_H */
diff --git a/drivers/block/blksnap/diff_storage.c b/drivers/block/blksnap/diff_storage.c
new file mode 100644
index 000000000000..47690bea2e6e
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-storage: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "chunk.h"
+#include "diff_buffer.h"
+#include "diff_storage.h"
+#include "params.h"
+
+/**
+ * struct storage_bdev - Information about the opened block device.
+ *
+ * @link:
+ *	Allows to combine structures into a linked list.
+ * @bdev:
+ *	A pointer to an open block device.
+ */
+struct storage_bdev {
+	struct list_head link;
+	struct block_device *bdev;
+};
+
+/**
+ * struct storage_block - A storage unit reserved for storing differences.
+ *
+ * @link:
+ *	Allows to combine structures into a linked list.
+ * @bdev:
+ *	A pointer to a block device.
+ * @sector:
+ *	The number of the first sector of the range of allocated space for
+ *	storing the difference.
+ * @count:
+ *	The count of sectors in the range of allocated space for storing the
+ *	difference.
+ * @used:
+ *	The count of used sectors in the range of allocated space for storing
+ *	the difference.
+ */
+struct storage_block {
+	struct list_head link;
+	struct block_device *bdev;
+	sector_t sector;
+	sector_t count;
+	sector_t used;
+};
+
+static inline void diff_storage_event_low(struct diff_storage *diff_storage)
+{
+	struct blksnap_event_low_free_space data = {
+		.requested_nr_sect = get_diff_storage_minimum(),
+	};
+
+	diff_storage->requested += data.requested_nr_sect;
+	pr_debug("Diff storage low free space. Portion: %llu sectors, requested: %llu\n",
+		data.requested_nr_sect, diff_storage->requested);
+	event_gen(&diff_storage->event_queue, GFP_NOIO,
+		  blksnap_event_code_low_free_space, &data, sizeof(data));
+}
+
+struct diff_storage *diff_storage_new(void)
+{
+	struct diff_storage *diff_storage;
+
+	diff_storage = kzalloc(sizeof(struct diff_storage), GFP_KERNEL);
+	if (!diff_storage)
+		return NULL;
+
+	kref_init(&diff_storage->kref);
+	spin_lock_init(&diff_storage->lock);
+	INIT_LIST_HEAD(&diff_storage->storage_bdevs);
+	INIT_LIST_HEAD(&diff_storage->empty_blocks);
+	INIT_LIST_HEAD(&diff_storage->filled_blocks);
+
+	event_queue_init(&diff_storage->event_queue);
+	diff_storage_event_low(diff_storage);
+
+	return diff_storage;
+}
+
+static inline struct storage_block *
+first_empty_storage_block(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->empty_blocks,
+					struct storage_block, link);
+};
+
+static inline struct storage_block *
+first_filled_storage_block(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->filled_blocks,
+					struct storage_block, link);
+};
+
+static inline struct storage_bdev *
+first_storage_bdev(struct diff_storage *diff_storage)
+{
+	return list_first_entry_or_null(&diff_storage->storage_bdevs,
+					struct storage_bdev, link);
+};
+
+void diff_storage_free(struct kref *kref)
+{
+	struct diff_storage *diff_storage =
+		container_of(kref, struct diff_storage, kref);
+	struct storage_block *blk;
+	struct storage_bdev *storage_bdev;
+
+	while ((blk = first_empty_storage_block(diff_storage))) {
+		list_del(&blk->link);
+		kfree(blk);
+	}
+
+	while ((blk = first_filled_storage_block(diff_storage))) {
+		list_del(&blk->link);
+		kfree(blk);
+	}
+
+	while ((storage_bdev = first_storage_bdev(diff_storage))) {
+		blkdev_put(storage_bdev->bdev, FMODE_READ | FMODE_WRITE);
+		list_del(&storage_bdev->link);
+		kfree(storage_bdev);
+	}
+	event_queue_done(&diff_storage->event_queue);
+
+	kfree(diff_storage);
+}
+
+static struct block_device *diff_storage_add_storage_bdev(
+		struct diff_storage *diff_storage, const char *bdev_path)
+{
+	struct storage_bdev *storage_bdev, *existing_bdev = NULL;
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_path(bdev_path, FMODE_READ | FMODE_WRITE, NULL);
+	if (IS_ERR(bdev)) {
+		pr_err("Failed to open device. errno=%ld\n", PTR_ERR(bdev));
+		return bdev;
+	}
+
+	spin_lock(&diff_storage->lock);
+	list_for_each_entry(existing_bdev, &diff_storage->storage_bdevs, link) {
+		if (existing_bdev->bdev == bdev)
+			break;
+	}
+	spin_unlock(&diff_storage->lock);
+
+	if (existing_bdev->bdev == bdev) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		return existing_bdev->bdev;
+	}
+
+	storage_bdev = kzalloc(sizeof(struct storage_bdev) +
+			       strlen(bdev_path) + 1, GFP_KERNEL);
+	if (!storage_bdev) {
+		blkdev_put(bdev, FMODE_READ | FMODE_WRITE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_LIST_HEAD(&storage_bdev->link);
+	storage_bdev->bdev = bdev;
+
+	spin_lock(&diff_storage->lock);
+	list_add_tail(&storage_bdev->link, &diff_storage->storage_bdevs);
+	spin_unlock(&diff_storage->lock);
+
+	return bdev;
+}
+
+static inline int diff_storage_add_range(struct diff_storage *diff_storage,
+					 struct block_device *bdev,
+					 sector_t sector, sector_t count)
+{
+	struct storage_block *storage_block;
+
+	pr_debug("Add range to diff storage: [%u:%u] %llu:%llu\n",
+		 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev), sector, count);
+
+	storage_block = kzalloc(sizeof(struct storage_block), GFP_KERNEL);
+	if (!storage_block)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&storage_block->link);
+	storage_block->bdev = bdev;
+	storage_block->sector = sector;
+	storage_block->count = count;
+
+	spin_lock(&diff_storage->lock);
+	list_add_tail(&storage_block->link, &diff_storage->empty_blocks);
+	diff_storage->capacity += count;
+	spin_unlock(&diff_storage->lock);
+
+	return 0;
+}
+
+int diff_storage_append_block(struct diff_storage *diff_storage,
+			      const char *bdev_path,
+			      struct blksnap_sectors __user *ranges,
+			      unsigned int range_count)
+{
+	int ret;
+	int inx;
+	struct block_device *bdev;
+	struct blksnap_sectors range;
+
+	pr_debug("Append %u blocks\n", range_count);
+
+	bdev = diff_storage_add_storage_bdev(diff_storage, bdev_path);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	for (inx = 0; inx < range_count; inx++) {
+		if (unlikely(copy_from_user(&range, ranges+inx, sizeof(range))))
+			return -EINVAL;
+
+		ret = diff_storage_add_range(diff_storage, bdev,
+					     range.offset,
+					     range.count);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	if (atomic_read(&diff_storage->low_space_flag) &&
+	    (diff_storage->capacity >= diff_storage->requested))
+		atomic_set(&diff_storage->low_space_flag, 0);
+
+	return 0;
+}
+
+static inline bool is_halffull(const sector_t sectors_left)
+{
+	return sectors_left <=
+		((get_diff_storage_minimum() >> 1) & ~(PAGE_SECTORS - 1));
+}
+
+struct diff_region *diff_storage_new_region(struct diff_storage *diff_storage,
+					   sector_t count,
+					   unsigned int logical_blksz)
+{
+	int ret = 0;
+	struct diff_region *diff_region;
+	sector_t sectors_left;
+
+	if (atomic_read(&diff_storage->overflow_flag))
+		return ERR_PTR(-ENOSPC);
+
+	diff_region = kzalloc(sizeof(struct diff_region), GFP_NOIO);
+	if (!diff_region)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock(&diff_storage->lock);
+	do {
+		struct storage_block *storage_block;
+		sector_t available;
+		struct request_queue *q;
+
+		storage_block = first_empty_storage_block(diff_storage);
+		if (unlikely(!storage_block)) {
+			atomic_inc(&diff_storage->overflow_flag);
+			ret = -ENOSPC;
+			break;
+		}
+
+		q = storage_block->bdev->bd_queue;
+		if (logical_blksz < q->limits.logical_block_size) {
+			pr_err("Incompatibility of block sizes was detected.");
+			ret = -ENOTBLK;
+			break;
+		}
+
+		available = storage_block->count - storage_block->used;
+		if (likely(available >= count)) {
+			diff_region->bdev = storage_block->bdev;
+			diff_region->sector =
+				storage_block->sector + storage_block->used;
+			diff_region->count = count;
+
+			storage_block->used += count;
+			diff_storage->filled += count;
+			break;
+		}
+
+		list_del(&storage_block->link);
+		list_add_tail(&storage_block->link,
+			      &diff_storage->filled_blocks);
+		/*
+		 * If there is still free space in the storage block, but
+		 * it is not enough to store a piece, then such a block is
+		 * considered used.
+		 * We believe that the storage blocks are large enough
+		 * to accommodate several pieces entirely.
+		 */
+		diff_storage->filled += available;
+	} while (1);
+	sectors_left = diff_storage->requested - diff_storage->filled;
+	spin_unlock(&diff_storage->lock);
+
+	if (ret) {
+		pr_err("Cannot get empty storage block\n");
+		diff_storage_free_region(diff_region);
+		return ERR_PTR(ret);
+	}
+
+	if (is_halffull(sectors_left) &&
+	    (atomic_inc_return(&diff_storage->low_space_flag) == 1))
+		diff_storage_event_low(diff_storage);
+
+	return diff_region;
+}
diff --git a/drivers/block/blksnap/diff_storage.h b/drivers/block/blksnap/diff_storage.h
new file mode 100644
index 000000000000..0913a0114ac0
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_DIFF_STORAGE_H
+#define __BLKSNAP_DIFF_STORAGE_H
+
+#include "event_queue.h"
+
+struct blksnap_sectors;
+
+/**
+ * struct diff_region - Describes the location of the chunks data on
+ *	difference storage.
+ * @bdev:
+ *	The target block device.
+ * @sector:
+ *	The sector offset of the region's first sector.
+ * @count:
+ *	The count of sectors in the region.
+ */
+struct diff_region {
+	struct block_device *bdev;
+	sector_t sector;
+	sector_t count;
+};
+
+/**
+ * struct diff_storage - Difference storage.
+ *
+ * @kref:
+ *	The reference counter.
+ * @lock:
+ *	Spinlock allows to guarantee the safety of linked lists.
+ * @storage_bdevs:
+ *	List of opened block devices. Blocks for storing snapshot data can be
+ *	located on different block devices. So, all opened block devices are
+ *	located in this list. Blocks on opened block devices are allocated for
+ *	storing the chunks data.
+ * @empty_blocks:
+ *	List of empty blocks on storage. This list can be updated while
+ *	holding a snapshot. This allows us to dynamically increase the
+ *	storage size for these snapshots.
+ * @filled_blocks:
+ *	List of filled blocks. When the blocks from the list of empty blocks are filled,
+ *	we move them to the list of filled blocks.
+ * @capacity:
+ *	Total amount of available storage space.
+ * @filled:
+ *	The number of sectors already filled in.
+ * @requested:
+ *	The number of sectors already requested from user space.
+ * @low_space_flag:
+ *	The flag is set if the number of free regions available in the
+ *	difference storage is less than the allowed minimum.
+ * @overflow_flag:
+ *	The request for a free region failed due to the absence of free
+ *	regions in the difference storage.
+ * @event_queue:
+ *	A queue of events to pass events to user space. Diff storage and its
+ *	owner can notify its snapshot about events like snapshot overflow,
+ *	low free space and snapshot terminated.
+ *
+ * The difference storage manages the regions of block devices that are used
+ * to store the data of the original block devices in the snapshot.
+ * The difference storage is created one per snapshot and is used to store
+ * data from all the original snapshot block devices. At the same time, the
+ * difference storage itself can contain regions on various block devices.
+ */
+struct diff_storage {
+	struct kref kref;
+	spinlock_t lock;
+
+	struct list_head storage_bdevs;
+	struct list_head empty_blocks;
+	struct list_head filled_blocks;
+
+	sector_t capacity;
+	sector_t filled;
+	sector_t requested;
+
+	atomic_t low_space_flag;
+	atomic_t overflow_flag;
+
+	struct event_queue event_queue;
+};
+
+struct diff_storage *diff_storage_new(void);
+void diff_storage_free(struct kref *kref);
+
+static inline void diff_storage_get(struct diff_storage *diff_storage)
+{
+	kref_get(&diff_storage->kref);
+};
+static inline void diff_storage_put(struct diff_storage *diff_storage)
+{
+	if (likely(diff_storage))
+		kref_put(&diff_storage->kref, diff_storage_free);
+};
+
+int diff_storage_append_block(struct diff_storage *diff_storage,
+			      const char *bdev_path,
+			      struct blksnap_sectors __user *ranges,
+			      unsigned int range_count);
+struct diff_region *diff_storage_new_region(struct diff_storage *diff_storage,
+					    sector_t count,
+					    unsigned int logical_blksz);
+
+static inline void diff_storage_free_region(struct diff_region *region)
+{
+	kfree(region);
+}
+#endif /* __BLKSNAP_DIFF_STORAGE_H */
--
2.20.1

