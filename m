Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118B86D7FE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 16:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbjDEOpU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238609AbjDEOpR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:45:17 -0400
X-Greylist: delayed 86403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Apr 2023 07:45:08 PDT
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1652961BF;
        Wed,  5 Apr 2023 07:45:07 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 809C840BF9;
        Tue,  4 Apr 2023 10:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1680617351;
        bh=tUm7DOrHRp+K+tSfPBr7QoBxiVRHWTWmNaR/i6++U48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fQZf96b346t2YcvgSOjTJoYW8bfluU99LSdw2+u6mLo++9sCmSLT4dxohbq72+Jxm
         GuqhRYvacshtkKZxTRvpLUAjs60IIncLkU3NzNXGIsxjlrI9lcLqEYyvwDME/QMeO2
         Y7POFk2bu15n74Us90yahFDwHGqVy4Mj25CNFlAvYdV1j2x33U7UVUoi6OfYwQ86MX
         hCmOjuSFp7gApuy2Vy77CDgxjkW18xUAdMsLGLcRoXaxVJvSVeF9hSUfJ3/5zmMAk7
         xl3URRn/qANYHLIFgkH+4RFF+ltu8GWWlPbpnzKGhn7com5xtGn0p7lHeywwH7CFEh
         GpUJqy13EO7UA==
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 16:09:07 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v3 07/11] blksnap: minimum data storage unit of the original block device
Date:   Tue, 4 Apr 2023 16:08:31 +0200
Message-ID: <20230404140835.25166-8-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404140835.25166-1-sergei.shtepa@veeam.com>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554657367
X-Veeam-MMEX: True
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The struct chunk describes the minimum data storage unit of the original
block device. Functions for working with these minimal blocks implement
algorithms for reading and writing blocks.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/chunk.c | 470 ++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/chunk.h | 106 ++++++++
 2 files changed, 576 insertions(+)
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h

diff --git a/drivers/block/blksnap/chunk.c b/drivers/block/blksnap/chunk.c
new file mode 100644
index 000000000000..83222863d348
--- /dev/null
+++ b/drivers/block/blksnap/chunk.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-chunk: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include "chunk.h"
+#include "diff_buffer.h"
+#include "diff_area.h"
+#include "diff_storage.h"
+#include "params.h"
+
+struct chunk_bio {
+	struct work_struct work;
+	struct list_head chunks;
+	struct bio *orig_bio;
+	struct bvec_iter orig_iter;
+	struct bio bio;
+};
+
+struct bio_set chunk_io_bioset;
+struct bio_set chunk_clone_bioset;
+
+static inline sector_t chunk_sector(struct chunk *chunk)
+{
+	return (sector_t)(chunk->number)
+	       << (chunk->diff_area->chunk_shift - SECTOR_SHIFT);
+}
+
+void chunk_diff_buffer_release(struct chunk *chunk)
+{
+	if (unlikely(!chunk->diff_buffer))
+		return;
+
+	diff_buffer_release(chunk->diff_area, chunk->diff_buffer);
+	chunk->diff_buffer = NULL;
+}
+
+void chunk_store_failed(struct chunk *chunk, int error)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	WARN_ON_ONCE(chunk->state != CHUNK_ST_NEW &&
+		     chunk->state != CHUNK_ST_IN_MEMORY);
+	chunk->state = CHUNK_ST_FAILED;
+
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	chunk->diff_region = NULL;
+
+	up(&chunk->lock);
+	if (error)
+		diff_area_set_corrupted(diff_area, error);
+};
+
+static void chunk_schedule_storing(struct chunk *chunk)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+	int queue_count;
+
+	WARN_ON_ONCE(chunk->state != CHUNK_ST_NEW &&
+		     chunk->state != CHUNK_ST_STORED);
+	chunk->state = CHUNK_ST_IN_MEMORY;
+
+	spin_lock(&diff_area->store_queue_lock);
+	list_add_tail(&chunk->link, &diff_area->store_queue);
+	queue_count = atomic_inc_return(&diff_area->store_queue_count);
+	spin_unlock(&diff_area->store_queue_lock);
+
+	up(&chunk->lock);
+
+	/* Initiate the queue clearing process */
+	if (queue_count > get_chunk_maximum_in_queue())
+		queue_work(system_wq, &diff_area->store_queue_work);
+}
+
+void chunk_copy_bio(struct chunk *chunk, struct bio *bio,
+		    struct bvec_iter *iter)
+{
+	unsigned int chunk_ofs, chunk_left;
+
+	chunk_ofs = (iter->bi_sector - chunk_sector(chunk)) << SECTOR_SHIFT;
+	chunk_left = chunk->diff_buffer->size - chunk_ofs;
+	while (chunk_left && iter->bi_size) {
+		struct bio_vec bvec = bio_iter_iovec(bio, *iter);
+		unsigned int page_ofs = offset_in_page(chunk_ofs);
+		struct page *page;
+		unsigned int len;
+
+		page = chunk->diff_buffer->pages[chunk_ofs >> PAGE_SHIFT];
+		len = min3(bvec.bv_len,
+			   chunk_left,
+			   (unsigned int)PAGE_SIZE - page_ofs);
+
+		if (op_is_write(bio_op(bio))) {
+			/* from bio to buffer */
+			memcpy_page(page, page_ofs,
+				    bvec.bv_page, bvec.bv_offset,
+				    len);
+		} else {
+			/* from buffer to bio */
+			memcpy_page(bvec.bv_page, bvec.bv_offset,
+				    page, page_ofs,
+				    len);
+		}
+
+		chunk_ofs += len;
+		chunk_left -= len;
+		bio_advance_iter_single(bio, iter, len);
+	}
+}
+
+static void chunk_clone_endio(struct bio *bio)
+{
+	struct bio *orig_bio = bio->bi_private;
+
+	if (unlikely(bio->bi_status != BLK_STS_OK))
+		bio_io_error(orig_bio);
+	else
+		bio_endio(orig_bio);
+}
+
+static inline sector_t chunk_offset(struct chunk *chunk, struct bio *bio)
+{
+	return bio->bi_iter.bi_sector - chunk_sector(chunk);
+}
+
+static inline void chunk_limit_iter(struct chunk *chunk, struct bio *bio,
+				    sector_t sector, struct bvec_iter *iter)
+{
+	sector_t chunk_ofs = chunk_offset(chunk, bio);
+
+	iter->bi_sector = sector + chunk_ofs;
+	iter->bi_size = min_t(unsigned int,
+			bio->bi_iter.bi_size,
+			(chunk->sector_count - chunk_ofs) << SECTOR_SHIFT);
+}
+
+static inline unsigned int chunk_limit(struct chunk *chunk, struct bio *bio)
+{
+	unsigned int chunk_ofs, chunk_left;
+
+	chunk_ofs = (unsigned int)chunk_offset(chunk, bio) << SECTOR_SHIFT;
+	chunk_left = chunk->diff_buffer->size - chunk_ofs;
+
+	return min(bio->bi_iter.bi_size, chunk_left);
+}
+
+void chunk_clone_bio(struct chunk *chunk, struct bio *bio)
+{
+	struct bio *new_bio;
+	struct block_device *bdev;
+	sector_t sector;
+
+	if (chunk->state == CHUNK_ST_STORED) {
+		bdev = chunk->diff_region->bdev;
+		sector = chunk->diff_region->sector;
+	} else {
+		bdev = chunk->diff_area->orig_bdev;
+		sector = chunk_sector(chunk);
+	}
+
+	new_bio = bio_alloc_clone(bdev, bio, GFP_NOIO, &chunk_clone_bioset);
+	chunk_limit_iter(chunk, bio, sector, &new_bio->bi_iter);
+	bio_set_flag(new_bio, BIO_FILTERED);
+	new_bio->bi_end_io = chunk_clone_endio;
+	new_bio->bi_private = bio;
+
+	bio_advance(bio, new_bio->bi_iter.bi_size);
+	bio_inc_remaining(bio);
+
+	submit_bio_noacct(new_bio);
+}
+
+static inline struct chunk *get_chunk_from_cbio(struct chunk_bio *cbio)
+{
+	struct chunk *chunk = list_first_entry_or_null(&cbio->chunks,
+						       struct chunk, link);
+
+	if (chunk)
+		list_del_init(&chunk->link);
+	return chunk;
+}
+
+static void notify_load_and_schedule_io(struct work_struct *work)
+{
+	struct chunk_bio *cbio = container_of(work, struct chunk_bio, work);
+	struct chunk *chunk;
+
+	while ((chunk = get_chunk_from_cbio(cbio))) {
+		if (unlikely(cbio->bio.bi_status != BLK_STS_OK)) {
+			chunk_store_failed(chunk, -EIO);
+			continue;
+		}
+		if (chunk->state == CHUNK_ST_FAILED) {
+			up(&chunk->lock);
+			continue;
+		}
+
+		chunk_copy_bio(chunk, cbio->orig_bio, &cbio->orig_iter);
+		bio_endio(cbio->orig_bio);
+
+		chunk_schedule_storing(chunk);
+	}
+
+	bio_put(&cbio->bio);
+}
+
+static void notify_load_and_postpone_io(struct work_struct *work)
+{
+	struct chunk_bio *cbio = container_of(work, struct chunk_bio, work);
+	struct chunk *chunk;
+
+	while ((chunk = get_chunk_from_cbio(cbio))) {
+		if (unlikely(cbio->bio.bi_status != BLK_STS_OK)) {
+			chunk_store_failed(chunk, -EIO);
+			continue;
+		}
+		if (chunk->state == CHUNK_ST_FAILED) {
+			up(&chunk->lock);
+			continue;
+		}
+
+		chunk_schedule_storing(chunk);
+	}
+
+	/* submit the original bio fed into the tracker */
+	submit_bio_noacct_nocheck(cbio->orig_bio);
+	bio_put(&cbio->bio);
+}
+
+static void chunk_notify_store(struct work_struct *work)
+{
+	struct chunk_bio *cbio = container_of(work, struct chunk_bio, work);
+	struct chunk *chunk;
+
+	while ((chunk = get_chunk_from_cbio(cbio))) {
+		if (unlikely(cbio->bio.bi_status != BLK_STS_OK)) {
+			chunk_store_failed(chunk, -EIO);
+			continue;
+		}
+
+		WARN_ON_ONCE(chunk->state != CHUNK_ST_IN_MEMORY);
+		chunk->state = CHUNK_ST_STORED;
+
+		chunk_diff_buffer_release(chunk);
+		up(&chunk->lock);
+	}
+
+	bio_put(&cbio->bio);
+}
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number)
+{
+	struct chunk *chunk;
+
+	chunk = kzalloc(sizeof(struct chunk), GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	INIT_LIST_HEAD(&chunk->link);
+	sema_init(&chunk->lock, 1);
+	chunk->diff_area = diff_area;
+	chunk->number = number;
+	chunk->state = CHUNK_ST_NEW;
+	return chunk;
+}
+
+void chunk_free(struct chunk *chunk)
+{
+	if (unlikely(!chunk))
+		return;
+	chunk_diff_buffer_release(chunk);
+	diff_storage_free_region(chunk->diff_region);
+	kfree(chunk);
+}
+
+static void chunk_io_endio(struct bio *bio)
+{
+	struct chunk_bio *cbio = container_of(bio, struct chunk_bio, bio);
+
+	queue_work(system_wq, &cbio->work);
+}
+
+static void chunk_submit_bio(struct bio *bio)
+{
+	bio->bi_end_io = chunk_io_endio;
+	submit_bio_noacct(bio);
+}
+
+static inline unsigned short calc_max_vecs(sector_t left)
+{
+	return bio_max_segs(round_up(left, PAGE_SECTORS) / PAGE_SECTORS);
+}
+
+void chunk_store(struct chunk *chunk)
+{
+	struct block_device *bdev = chunk->diff_region->bdev;
+	sector_t sector = chunk->diff_region->sector;
+	sector_t count = chunk->diff_region->count;
+	unsigned int page_idx = 0;
+	struct bio *bio;
+	struct chunk_bio *cbio;
+
+	bio = bio_alloc_bioset(bdev, calc_max_vecs(count),
+			       REQ_OP_WRITE | REQ_SYNC | REQ_FUA, GFP_NOIO,
+			       &chunk_io_bioset);
+	bio->bi_iter.bi_sector = sector;
+	bio_set_flag(bio, BIO_FILTERED);
+
+	while (count) {
+		sector_t portion = min_t(sector_t, count, PAGE_SECTORS);
+		unsigned int bytes = portion << SECTOR_SHIFT;
+
+		if (bio_add_page(bio, chunk->diff_buffer->pages[page_idx],
+				 bytes, 0) != bytes) {
+			struct bio *next;
+
+			next = bio_alloc_bioset(bdev,
+					calc_max_vecs(count),
+					REQ_OP_WRITE | REQ_SYNC | REQ_FUA,
+					GFP_NOIO, &chunk_io_bioset);
+			next->bi_iter.bi_sector = bio_end_sector(bio);
+			bio_set_flag(next, BIO_FILTERED);
+			bio_chain(bio, next);
+			submit_bio_noacct(bio);
+			bio = next;
+		}
+		page_idx++;
+		count -= portion;
+	}
+
+	cbio = container_of(bio, struct chunk_bio, bio);
+
+	INIT_WORK(&cbio->work, chunk_notify_store);
+	INIT_LIST_HEAD(&cbio->chunks);
+	list_add_tail(&chunk->link, &cbio->chunks);
+	cbio->orig_bio = NULL;
+	chunk_submit_bio(bio);
+}
+
+static struct bio *__chunk_load(struct chunk *chunk)
+{
+	struct diff_buffer *diff_buffer;
+	unsigned int page_idx = 0;
+	struct bio *bio;
+	struct block_device *bdev;
+	sector_t sector, count;
+
+	diff_buffer = diff_buffer_take(chunk->diff_area);
+	if (IS_ERR(diff_buffer))
+		return ERR_CAST(diff_buffer);
+	chunk->diff_buffer = diff_buffer;
+
+	if (chunk->state == CHUNK_ST_STORED) {
+		bdev = chunk->diff_region->bdev;
+		sector = chunk->diff_region->sector;
+		count = chunk->diff_region->count;
+	} else {
+		bdev = chunk->diff_area->orig_bdev;
+		sector = chunk_sector(chunk);
+		count = chunk->sector_count;
+	}
+
+	bio = bio_alloc_bioset(bdev, calc_max_vecs(count),
+			       REQ_OP_READ, GFP_NOIO, &chunk_io_bioset);
+	bio->bi_iter.bi_sector = sector;
+	bio_set_flag(bio, BIO_FILTERED);
+
+	while (count) {
+		sector_t portion = min_t(sector_t, count, PAGE_SECTORS);
+		unsigned int bytes = portion << SECTOR_SHIFT;
+
+		if (bio_add_page(bio, chunk->diff_buffer->pages[page_idx],
+				 bytes, 0) != bytes) {
+			struct bio *next;
+
+			next = bio_alloc_bioset(bdev, calc_max_vecs(count),
+						REQ_OP_READ, GFP_NOIO,
+						&chunk_io_bioset);
+			next->bi_iter.bi_sector = bio_end_sector(bio);
+			bio_set_flag(next, BIO_FILTERED);
+			bio_chain(bio, next);
+			submit_bio_noacct(bio);
+			bio = next;
+		}
+		page_idx++;
+		count -= portion;
+	}
+	return bio;
+}
+
+int chunk_load_and_postpone_io(struct chunk *chunk, struct bio **chunk_bio)
+{
+	struct bio *prev = *chunk_bio, *bio;
+
+	bio = __chunk_load(chunk);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	if (prev) {
+		bio_chain(prev, bio);
+		submit_bio_noacct(prev);
+	}
+
+	*chunk_bio = bio;
+	return 0;
+}
+
+void chunk_load_and_postpone_io_finish(struct list_head *chunks,
+				struct bio *chunk_bio, struct bio *orig_bio)
+{
+	struct chunk_bio *cbio;
+
+	cbio = container_of(chunk_bio, struct chunk_bio, bio);
+	INIT_LIST_HEAD(&cbio->chunks);
+	while (!list_empty(chunks)) {
+		struct chunk *it;
+
+		it = list_first_entry(chunks, struct chunk, link);
+		list_del_init(&it->link);
+
+		list_add_tail(&it->link, &cbio->chunks);
+	}
+	INIT_WORK(&cbio->work, notify_load_and_postpone_io);
+	cbio->orig_bio = orig_bio;
+	chunk_submit_bio(chunk_bio);
+}
+
+int chunk_load_and_schedule_io(struct chunk *chunk, struct bio *orig_bio)
+{
+	struct chunk_bio *cbio;
+	struct bio *bio;
+
+	bio = __chunk_load(chunk);
+	if (IS_ERR(bio))
+		return PTR_ERR(bio);
+
+	cbio = container_of(bio, struct chunk_bio, bio);
+	INIT_LIST_HEAD(&cbio->chunks);
+	list_add_tail(&chunk->link, &cbio->chunks);
+	INIT_WORK(&cbio->work, notify_load_and_schedule_io);
+	cbio->orig_bio = orig_bio;
+	cbio->orig_iter = orig_bio->bi_iter;
+	bio_advance_iter_single(orig_bio, &orig_bio->bi_iter,
+				chunk_limit(chunk, orig_bio));
+	bio_inc_remaining(orig_bio);
+
+	chunk_submit_bio(bio);
+	return 0;
+}
+
+int __init chunk_init(void)
+{
+	int ret;
+
+	ret = bioset_init(&chunk_io_bioset, 64,
+			  offsetof(struct chunk_bio, bio),
+			  BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+	if (!ret)
+		ret = bioset_init(&chunk_clone_bioset, 64, 0,
+				  BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+	return ret;
+}
+
+void chunk_done(void)
+{
+	bioset_exit(&chunk_io_bioset);
+	bioset_exit(&chunk_clone_bioset);
+}
diff --git a/drivers/block/blksnap/chunk.h b/drivers/block/blksnap/chunk.h
new file mode 100644
index 000000000000..f68bf4f0572f
--- /dev/null
+++ b/drivers/block/blksnap/chunk.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_CHUNK_H
+#define __BLKSNAP_CHUNK_H
+
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+
+struct diff_area;
+struct diff_region;
+
+/**
+ * enum chunk_st - Possible states for a chunk.
+ *
+ * @CHUNK_ST_NEW:
+ *	No data is associated with the chunk.
+ * @CHUNK_ST_IN_MEMORY:
+ *	The data of the chunk is ready to be read from the RAM buffer.
+ *	The flag is removed when a chunk is removed from the store queue
+ *	and its buffer is released.
+ * @CHUNK_ST_STORED:
+ *	The data of the chunk has been written to the difference storage.
+ * @CHUNK_ST_FAILED:
+ *	An error occurred while processing the chunk data.
+ *
+ * Chunks life circle:
+ *	CHUNK_ST_NEW -> CHUNK_ST_IN_MEMORY <-> CHUNK_ST_STORED
+ */
+
+enum chunk_st {
+	CHUNK_ST_NEW,
+	CHUNK_ST_IN_MEMORY,
+	CHUNK_ST_STORED,
+	CHUNK_ST_FAILED,
+};
+
+/**
+ * struct chunk - Minimum data storage unit.
+ *
+ * @link:
+ *	The list header allows to create queue of chunks.
+ * @diff_area:
+ *	Pointer to the difference area - the storage of changes for a specific device.
+ * @number:
+ *	Sequential number of the chunk.
+ * @sector_count:
+ *	Number of sectors in the current chunk. This is especially true
+ *	for the	last chunk.
+ * @lock:
+ *	Binary semaphore. Syncs access to the chunks fields: state,
+ *	diff_buffer and diff_region.
+ * @state:
+ *	Defines the state of a chunk.
+ * @diff_buffer:
+ *	Pointer to &struct diff_buffer. Describes a buffer in the memory
+ *	for storing the chunk data.
+ * @diff_region:
+ *	Pointer to &struct diff_region. Describes a copy of the chunk data
+ *	on the difference storage.
+ *
+ * This structure describes the block of data that the module operates
+ * with when executing the copy-on-write algorithm and when performing I/O
+ * to snapshot images.
+ *
+ * If the data of the chunk has been changed or has just been read, then
+ * the chunk gets into store queue.
+ *
+ * The semaphore is blocked for writing if there is no actual data in the
+ * buffer, since a block of data is being read from the original device or
+ * from a diff storage. If data is being read from or written to the
+ * diff_buffer, the semaphore must be locked.
+ */
+struct chunk {
+	struct list_head link;
+	struct diff_area *diff_area;
+
+	unsigned long number;
+	sector_t sector_count;
+
+	struct semaphore lock;
+
+	enum chunk_st state;
+	struct diff_buffer *diff_buffer;
+	struct diff_region *diff_region;
+};
+
+struct chunk *chunk_alloc(struct diff_area *diff_area, unsigned long number);
+void chunk_free(struct chunk *chunk);
+
+void chunk_diff_buffer_release(struct chunk *chunk);
+void chunk_store_failed(struct chunk *chunk, int error);
+
+void chunk_copy_bio(struct chunk *chunk, struct bio *bio,
+		    struct bvec_iter *iter);
+void chunk_clone_bio(struct chunk *chunk, struct bio *bio);
+void chunk_store(struct chunk *chunk);
+int chunk_load_and_schedule_io(struct chunk *chunk, struct bio *orig_bio);
+int chunk_load_and_postpone_io(struct chunk *chunk, struct bio **chunk_bio);
+void chunk_load_and_postpone_io_finish(struct list_head *chunks,
+				struct bio *chunk_bio, struct bio *orig_bio);
+
+int __init chunk_init(void);
+void chunk_done(void);
+#endif /* __BLKSNAP_CHUNK_H */
-- 
2.20.1

