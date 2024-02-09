Return-Path: <linux-fsdevel+bounces-10982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD684F93A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579CE1C25E01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329682D76;
	Fri,  9 Feb 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ypor93tq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4258287B
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494645; cv=none; b=iybYQZwRQluaHdNdIscq6Lu5IGAvs9Woqet1IdDOGskfgJRdfQZsNXU2xR0GkRZMLSYQAMJPRcLfqd6GsLCXVENIy8PqupEu8whE84uyWtxK+a/iffjFvSE+138rt00MyDsAILZd+r6ZGnxBuwDkWr6Whfcl20UPEhhWPPJrE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494645; c=relaxed/simple;
	bh=LJyiPgH+uosK2V+eMCGFgA2RlScgYXuTqIOHfb4YdFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YemNMH2wuaAxu7O0+moTrhgtYAZN70X/8JWHooBDaVqo+bHW2ARkNOz5KiqciGorK3WsLUriGk51/RQAk7+U+jcCN3gTHdUaIB+1VzrlW00zm+CBwFgd8wbQZRGbWYrQ6iVUGiLXoZvPYXdTDH1d6LR5ucISZHifnfjdDZ3byV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ypor93tq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707494640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7DY+h/oOmfPbA9lDWc9L+2CXQ4g3U2ZEBcnbi6dfmGQ=;
	b=Ypor93tq1mB0ExGS25XOskW0olyctKo0H9Y+GGdw4EjvhRZN51175M9FJaIWYLcEu/Zg9E
	YHeNBAgsXu4UUASxdWommGL9eSO4f04AaNjuasyLbQQpXNk20FnATb8A0Ssmg0khtDzulR
	9p4UhFcPWP8hRlE/Jl9LSGHOsuAkR/w=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 6/8] block: difference storage implementation
Date: Fri,  9 Feb 2024 17:02:02 +0100
Message-Id: <20240209160204.1471421-7-sergei.shtepa@linux.dev>
In-Reply-To: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
References: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The struct diff_storage manages the block device or file that are used
to store the data of the original block devices in the snapshot.
The difference storage is created one per snapshot and is used to store
data from all block devices.

The struct diff_area provides management of the difference blocks of
a single block device. Storing difference blocks, and reading them to
get a snapshot images.

The struct chunk describes the minimum data storage unit of the original
block device. Functions for working with these minimal blocks implement
algorithms for reading and writing blocks.

The struct diff_buffer describes the buffer in memory for a chunk.

Signed-off-by: Sergei Shtepa <sergei.shtepa@linux.dev>
---
 drivers/block/blksnap/chunk.c        | 631 +++++++++++++++++++++++++++
 drivers/block/blksnap/chunk.h        | 134 ++++++
 drivers/block/blksnap/diff_area.c    | 577 ++++++++++++++++++++++++
 drivers/block/blksnap/diff_area.h    | 175 ++++++++
 drivers/block/blksnap/diff_buffer.c  | 114 +++++
 drivers/block/blksnap/diff_buffer.h  |  37 ++
 drivers/block/blksnap/diff_storage.c | 290 ++++++++++++
 drivers/block/blksnap/diff_storage.h | 103 +++++
 8 files changed, 2061 insertions(+)
 create mode 100644 drivers/block/blksnap/chunk.c
 create mode 100644 drivers/block/blksnap/chunk.h
 create mode 100644 drivers/block/blksnap/diff_area.c
 create mode 100644 drivers/block/blksnap/diff_area.h
 create mode 100644 drivers/block/blksnap/diff_buffer.c
 create mode 100644 drivers/block/blksnap/diff_buffer.h
 create mode 100644 drivers/block/blksnap/diff_storage.c
 create mode 100644 drivers/block/blksnap/diff_storage.h

diff --git a/drivers/block/blksnap/chunk.c b/drivers/block/blksnap/chunk.c
new file mode 100644
index 000000000000..96a219149636
--- /dev/null
+++ b/drivers/block/blksnap/chunk.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-chunk: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/slab.h>
+#include <linux/blk-filter.h>
+#include "chunk.h"
+#include "diff_buffer.h"
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
+static struct bio_set chunk_io_bioset;
+static struct bio_set chunk_clone_bioset;
+static struct workqueue_struct *chunk_wq;
+
+static inline sector_t chunk_sector(struct chunk *chunk)
+{
+	return (sector_t)(chunk->number) <<
+		(chunk->diff_area->chunk_shift - SECTOR_SHIFT);
+}
+
+static inline sector_t chunk_sector_end(struct chunk *chunk)
+{
+	return chunk_sector(chunk) + chunk->sector_count;
+}
+
+void chunk_store_failed(struct chunk *chunk, int error)
+{
+	struct diff_area *diff_area = diff_area_get(chunk->diff_area);
+
+	WARN_ON_ONCE(chunk->state != CHUNK_ST_NEW &&
+		     chunk->state != CHUNK_ST_IN_MEMORY);
+	chunk->state = CHUNK_ST_FAILED;
+
+	if (likely(chunk->diff_buffer)) {
+		diff_buffer_release(diff_area, chunk->diff_buffer);
+		chunk->diff_buffer = NULL;
+	}
+
+	chunk_up(chunk);
+	if (error)
+		diff_area_set_corrupted(diff_area, error);
+	diff_area_put(diff_area);
+};
+
+static inline void chunk_io_failed(struct chunk *chunk)
+{
+	if (likely(chunk->diff_buffer)) {
+		diff_buffer_release(chunk->diff_area, chunk->diff_buffer);
+		chunk->diff_buffer = NULL;
+	}
+
+	chunk_up(chunk);
+}
+
+static void chunk_schedule_storing(struct chunk *chunk)
+{
+	struct diff_area *diff_area = diff_area_get(chunk->diff_area);
+	bool need_work = false;
+
+	WARN_ON_ONCE(chunk->state != CHUNK_ST_NEW &&
+		     chunk->state != CHUNK_ST_STORED);
+	chunk->state = CHUNK_ST_IN_MEMORY;
+
+	spin_lock(&diff_area->store_queue_lock);
+	list_add_tail(&chunk->link, &diff_area->store_queue);
+
+	need_work = (atomic_inc_return(&diff_area->store_queue_count) >
+		     get_chunk_maximum_in_queue()) &&
+		     !diff_area->store_queue_processing;
+	if (need_work)
+		diff_area->store_queue_processing = true;
+	spin_unlock(&diff_area->store_queue_lock);
+
+	chunk_up(chunk);
+
+	if (need_work) {
+		/* Initiate the queue clearing process */
+		queue_work(chunk_wq, &diff_area->store_queue_work);
+	}
+	diff_area_put(diff_area);
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
+		unsigned int inx = chunk_ofs >> PAGE_SHIFT;
+		struct page *page = chunk->diff_buffer->bvec[inx].bv_page;
+		unsigned int len;
+
+		len = min3(bvec.bv_len,
+			   chunk_left,
+			   (unsigned int)PAGE_SIZE - page_ofs);
+
+		if (op_is_write(bio_op(bio))) {
+			/* from bio to buffer */
+			memcpy_page(page, page_ofs,
+				    bvec.bv_page, bvec.bv_offset, len);
+		} else {
+			/* from buffer to bio */
+			memcpy_page(bvec.bv_page, bvec.bv_offset,
+				    page, page_ofs, len);
+		}
+
+		chunk_ofs += len;
+		chunk_left -= len;
+		bio_advance_iter_single(bio, iter, len);
+	}
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
+struct bio *chunk_alloc_clone(struct block_device *bdev, struct bio *bio)
+{
+	return bio_alloc_clone(bdev, bio, GFP_KERNEL, &chunk_clone_bioset);
+}
+
+void chunk_diff_bio_tobdev(struct chunk *chunk, struct bio *bio)
+{
+	struct bio *new_bio;
+
+	new_bio = chunk_alloc_clone(chunk->diff_bdev, bio);
+	chunk_limit_iter(chunk, bio, chunk->diff_ofs_sect, &new_bio->bi_iter);
+
+	bio_advance(bio, new_bio->bi_iter.bi_size);
+	bio_chain(new_bio, bio);
+
+	submit_bio_noacct(new_bio);
+}
+
+static inline void chunk_io_ctx_free(struct chunk_io_ctx *io_ctx, long ret)
+{
+	if (ret < 0) {
+		bio_io_error(io_ctx->bio);
+		chunk_io_failed(io_ctx->chunk);
+	} else {
+		bio_endio(io_ctx->bio);
+		chunk_up(io_ctx->chunk);
+	}
+	kfree(io_ctx);
+}
+
+static void chunk_diff_bio_complete_read(struct kiocb *iocb, long ret)
+{
+	struct chunk_io_ctx *io_ctx;
+
+	io_ctx = container_of(iocb, struct chunk_io_ctx, iocb);
+	chunk_io_ctx_free(io_ctx, ret);
+}
+
+static void chunk_diff_bio_complete_write(struct kiocb *iocb, long ret)
+{
+	struct chunk_io_ctx *io_ctx;
+
+	io_ctx = container_of(iocb, struct chunk_io_ctx, iocb);
+	chunk_io_ctx_free(io_ctx, ret);
+}
+
+static inline void chunk_diff_bio_execute_write(struct chunk_io_ctx *io_ctx)
+{
+	struct file *diff_file = io_ctx->chunk->diff_file;
+	ssize_t len;
+
+	len = vfs_iocb_iter_write(diff_file, &io_ctx->iocb,  &io_ctx->iov_iter);
+
+	if (len != -EIOCBQUEUED) {
+		if (unlikely(len < 0))
+			pr_err("Failed to write data to difference storage\n");
+		chunk_io_ctx_free(io_ctx, len);
+	}
+}
+
+static inline void chunk_diff_bio_execute_read(struct chunk_io_ctx *io_ctx)
+{
+	struct file *diff_file = io_ctx->chunk->diff_file;
+	ssize_t len;
+
+	len = vfs_iocb_iter_read(diff_file, &io_ctx->iocb, &io_ctx->iov_iter);
+	if (len != -EIOCBQUEUED) {
+		if (unlikely(len < 0))
+			pr_err("Failed to read data from difference storage\n");
+		chunk_io_ctx_free(io_ctx, len);
+	}
+}
+
+void chunk_diff_bio_execute(struct chunk_io_ctx *io_ctx)
+{
+	if (io_ctx->iov_iter.data_source)
+		chunk_diff_bio_execute_write(io_ctx);
+	else
+		chunk_diff_bio_execute_read(io_ctx);
+}
+
+static inline void chunk_diff_bio_schedule(struct diff_area *diff_area,
+					   struct chunk_io_ctx *io_ctx)
+{
+	spin_lock(&diff_area->image_io_queue_lock);
+	list_add_tail(&io_ctx->link, &diff_area->image_io_queue);
+	spin_unlock(&diff_area->image_io_queue_lock);
+	queue_work(chunk_wq, &diff_area->image_io_work);
+}
+
+/*
+ * The data from bio is write to the diff file or read from it.
+ */
+int chunk_diff_bio(struct chunk *chunk, struct bio *bio)
+{
+	bool is_write = op_is_write(bio_op(bio));
+	loff_t chunk_ofs, chunk_left;
+	struct bio_vec iter_bvec, *bio_bvec;
+	struct bvec_iter iter;
+	unsigned long nr_segs = 0;
+	size_t nbytes = 0;
+	struct chunk_io_ctx *io_ctx;
+
+	io_ctx = kzalloc(sizeof(struct chunk_io_ctx), GFP_KERNEL);
+	if (!io_ctx)
+		return -ENOMEM;
+
+	chunk_ofs = (bio->bi_iter.bi_sector - chunk_sector(chunk))
+			<< SECTOR_SHIFT;
+	chunk_left = (chunk->sector_count << SECTOR_SHIFT) - chunk_ofs;
+	bio_for_each_segment(iter_bvec, bio, iter) {
+		if (chunk_left == 0)
+			break;
+
+		if (chunk_left > iter_bvec.bv_len) {
+			chunk_left -= iter_bvec.bv_len;
+			nbytes += iter_bvec.bv_len;
+		} else {
+			nbytes += chunk_left;
+			chunk_left = 0;
+		}
+		nr_segs++;
+	}
+	bio_bvec = __bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
+	iov_iter_bvec(&io_ctx->iov_iter, is_write ? WRITE : READ,
+		      bio_bvec, nr_segs, nbytes);
+	io_ctx->iov_iter.iov_offset = bio->bi_iter.bi_bvec_done;
+
+	init_sync_kiocb(&io_ctx->iocb, chunk->diff_file);
+	io_ctx->iocb.ki_filp = chunk->diff_file;
+	io_ctx->iocb.ki_pos = (chunk->diff_ofs_sect << SECTOR_SHIFT) +
+								chunk_ofs;
+	if (is_write)
+		io_ctx->iocb.ki_flags |= IOCB_WRITE;
+	io_ctx->iocb.ki_complete = is_write ? chunk_diff_bio_complete_write
+					    : chunk_diff_bio_complete_read;
+	io_ctx->chunk = chunk;
+	io_ctx->bio = bio;
+	bio_inc_remaining(bio);
+	bio_advance(bio, nbytes);
+
+	chunk_diff_bio_schedule(chunk->diff_area, io_ctx);
+
+	return 0;
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
+			chunk_up(chunk);
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
+			chunk_up(chunk);
+			continue;
+		}
+
+		chunk_schedule_storing(chunk);
+	}
+
+	/* re submit filtered original bio */
+	resubmit_filtered_bio(cbio->orig_bio);
+	bio_put(&cbio->bio);
+}
+
+static void chunk_notify_store(struct chunk *chunk, int err)
+{
+	if (err) {
+		chunk_store_failed(chunk, err);
+		return;
+	}
+
+	WARN_ON_ONCE(chunk->state != CHUNK_ST_IN_MEMORY);
+	chunk->state = CHUNK_ST_STORED;
+
+	if (chunk->diff_buffer) {
+		diff_buffer_release(chunk->diff_area,
+				    chunk->diff_buffer);
+		chunk->diff_buffer = NULL;
+	}
+	chunk_up(chunk);
+}
+
+static void chunk_notify_store_tobdev(struct work_struct *work)
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
+		if (chunk->diff_buffer) {
+			diff_buffer_release(chunk->diff_area,
+					    chunk->diff_buffer);
+			chunk->diff_buffer = NULL;
+		}
+		chunk_up(chunk);
+	}
+
+	bio_put(&cbio->bio);
+}
+
+static void chunk_io_endio(struct bio *bio)
+{
+	struct chunk_bio *cbio = container_of(bio, struct chunk_bio, bio);
+
+	queue_work(chunk_wq, &cbio->work);
+}
+
+static inline void chunk_submit_bio(struct bio *bio)
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
+void chunk_store_tobdev(struct chunk *chunk)
+{
+	struct block_device *bdev = chunk->diff_bdev;
+	sector_t sector = chunk->diff_ofs_sect;
+	sector_t count = chunk->sector_count;
+	unsigned int inx = 0;
+	struct bio *bio;
+	struct chunk_bio *cbio;
+
+	bio = bio_alloc_bioset(bdev, calc_max_vecs(count),
+			       REQ_OP_WRITE | REQ_SYNC | REQ_FUA,
+			       GFP_KERNEL, &chunk_io_bioset);
+	bio->bi_iter.bi_sector = sector;
+
+	while (count) {
+		struct bio *next;
+		sector_t portion = min_t(sector_t, count, PAGE_SECTORS);
+		unsigned int bytes = portion << SECTOR_SHIFT;
+
+		if (bio_add_page(bio, chunk->diff_buffer->bvec[inx].bv_page,
+				 bytes, 0) == bytes) {
+			inx++;
+			count -= portion;
+			continue;
+		}
+
+		/* Create next bio */
+		next = bio_alloc_bioset(bdev, calc_max_vecs(count),
+					REQ_OP_WRITE | REQ_SYNC | REQ_FUA,
+					GFP_KERNEL, &chunk_io_bioset);
+		next->bi_iter.bi_sector = bio_end_sector(bio);
+		bio_chain(bio, next);
+		submit_bio_noacct(bio);
+		bio = next;
+	}
+
+	cbio = container_of(bio, struct chunk_bio, bio);
+	INIT_WORK(&cbio->work, chunk_notify_store_tobdev);
+	INIT_LIST_HEAD(&cbio->chunks);
+	list_add_tail(&chunk->link, &cbio->chunks);
+	cbio->orig_bio = NULL;
+	chunk_submit_bio(bio);
+}
+
+/*
+ * Synchronously store chunk to diff file.
+ */
+void chunk_diff_write(struct chunk *chunk)
+{
+	loff_t pos = chunk->diff_ofs_sect << SECTOR_SHIFT;
+	size_t length = chunk->sector_count << SECTOR_SHIFT;
+	struct iov_iter iov_iter;
+	ssize_t len;
+	int err = 0;
+
+	iov_iter_bvec(&iov_iter, ITER_SOURCE, chunk->diff_buffer->bvec,
+		      chunk->diff_buffer->nr_pages, length);
+	while (length) {
+		len = vfs_iter_write(chunk->diff_file, &iov_iter, &pos, 0);
+		if (len < 0) {
+			err = (int)len;
+			pr_debug("vfs_iter_write complete with error code %zd",
+				 len);
+			break;
+		}
+		length -= len;
+	}
+	chunk_notify_store(chunk, err);
+}
+
+static struct bio *chunk_origin_load_async(struct chunk *chunk)
+{
+	struct block_device *bdev;
+	struct bio *bio = NULL;
+	struct diff_buffer *diff_buffer;
+	unsigned int inx = 0;
+	sector_t sector, count = chunk->sector_count;
+
+	diff_buffer = diff_buffer_take(chunk->diff_area);
+	if (IS_ERR(diff_buffer))
+		return ERR_CAST(diff_buffer);
+	chunk->diff_buffer = diff_buffer;
+
+	bdev = chunk->diff_area->orig_bdev;
+	sector = chunk_sector(chunk);
+
+	bio = bio_alloc_bioset(bdev, calc_max_vecs(count), REQ_OP_READ,
+			       GFP_KERNEL, &chunk_io_bioset);
+	bio->bi_iter.bi_sector = sector;
+
+	while (count) {
+		struct bio *next;
+		sector_t portion = min_t(sector_t, count, PAGE_SECTORS);
+		unsigned int bytes = portion << SECTOR_SHIFT;
+		struct page *pg = chunk->diff_buffer->bvec[inx].bv_page;
+
+		if (bio_add_page(bio, pg, bytes, 0) == bytes) {
+			inx++;
+			count -= portion;
+			continue;
+		}
+
+		/* Create next bio */
+		next = bio_alloc_bioset(bdev, calc_max_vecs(count), REQ_OP_READ,
+					GFP_KERNEL, &chunk_io_bioset);
+		next->bi_iter.bi_sector = bio_end_sector(bio);
+		bio_chain(bio, next);
+		submit_bio_noacct(bio);
+		bio = next;
+	}
+
+	return bio;
+}
+
+/*
+ * Load the chunk asynchronously.
+ */
+int chunk_load_and_postpone_io(struct chunk *chunk, struct bio **chunk_bio)
+{
+	struct bio *prev = *chunk_bio, *bio;
+
+	bio = chunk_origin_load_async(chunk);
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
+bool chunk_load_and_schedule_io(struct chunk *chunk, struct bio *orig_bio)
+{
+	struct chunk_bio *cbio;
+	struct bio *bio;
+
+	bio = chunk_origin_load_async(chunk);
+	if (IS_ERR(bio)) {
+		chunk_up(chunk);
+		return false;
+	}
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
+	return true;
+}
+
+int __init chunk_init(void)
+{
+	int ret;
+
+	ret = bioset_init(&chunk_io_bioset, 64,
+			  offsetof(struct chunk_bio, bio),
+			  BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+	if (ret)
+		return ret;
+
+	ret = bioset_init(&chunk_clone_bioset, 64, 0,
+			  BIOSET_NEED_BVECS | BIOSET_NEED_RESCUER);
+	if (ret)
+		goto fail_bioset_init;
+
+	chunk_wq = create_workqueue("blksnap");
+	if (!chunk_wq) {
+		ret = -ENOMEM;
+		goto fail_alloc_wq;
+	}
+	return 0;
+
+fail_alloc_wq:
+	bioset_exit(&chunk_clone_bioset);
+fail_bioset_init:
+	bioset_exit(&chunk_io_bioset);
+
+	return ret;
+}
+
+void chunk_done(void)
+{
+	bioset_exit(&chunk_io_bioset);
+	bioset_exit(&chunk_clone_bioset);
+	destroy_workqueue(chunk_wq);
+}
diff --git a/drivers/block/blksnap/chunk.h b/drivers/block/blksnap/chunk.h
new file mode 100644
index 000000000000..7cc140e344ba
--- /dev/null
+++ b/drivers/block/blksnap/chunk.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef __BLKSNAP_CHUNK_H
+#define __BLKSNAP_CHUNK_H
+
+#include <linux/blk_types.h>
+#include <linux/blkdev.h>
+#include <linux/rwsem.h>
+#include <linux/atomic.h>
+#include "diff_area.h"
+
+struct blkfilter;
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
+ * @number:
+ *	Sequential number of the chunk.
+ * @sector_count:
+ *	Number of sectors in the current chunk. This is especially true
+ *	for the	last chunk.
+ * @lock:
+ *	Binary semaphore. Syncs access to the chunks fields: state,
+ *	diff_buffer, diff_file and diff_ofs_sect.
+ * @diff_area:
+ *	Pointer to the difference area - the difference storage area for a
+ *	specific device. This field is only available when the chunk is locked.
+ *	Allows to protect the difference area from early release.
+ * @state:
+ *	Defines the state of a chunk.
+ * @diff_bdev:
+ *      The difference storage block device.
+ * @diff_file:
+ *	The difference storage file.
+ * @diff_ofs_sect:
+ *	The sector offset of the region's first sector.
+ * @diff_buffer:
+ *	Pointer to &struct diff_buffer. Describes a buffer in the memory
+ *	for storing the chunk data.
+ *	on the difference storage.
+ *
+ * This structure describes the block of data that the module operates
+ * with when executing the copy-on-write algorithm and when performing I/O
+ * to snapshot images.
+ *
+ * If the data of the chunk has been changed, then the chunk gets into store
+ * queue. The queue provides caching of chunks. Saving chunks to the storage is
+ * performed in a separate working thread. This ensures the best system
+ * performance.
+ *
+ * The semaphore is blocked for writing if there is no actual data in the
+ * buffer, since a block of data is being read from the original device or
+ * from a difference storage. If data is being read from or written to the
+ * diff_buffer, the semaphore must be locked.
+ */
+struct chunk {
+	struct list_head link;
+	unsigned long number;
+	sector_t sector_count;
+
+	struct semaphore lock;
+	struct diff_area *diff_area;
+
+	enum chunk_st state;
+
+	struct block_device *diff_bdev;
+	struct file *diff_file;
+	sector_t diff_ofs_sect;
+
+	struct diff_buffer *diff_buffer;
+};
+
+static inline void chunk_up(struct chunk *chunk)
+{
+	struct diff_area *diff_area = chunk->diff_area;
+
+	chunk->diff_area = NULL;
+	up(&chunk->lock);
+	diff_area_put(diff_area);
+};
+
+struct chunk_io_ctx {
+	struct list_head link;
+	struct kiocb iocb;
+	struct iov_iter iov_iter;
+	struct chunk *chunk;
+	struct bio *bio;
+};
+void chunk_diff_bio_execute(struct chunk_io_ctx *io_ctx);
+
+void chunk_store_failed(struct chunk *chunk, int error);
+struct bio *chunk_alloc_clone(struct block_device *bdev, struct bio *bio);
+
+void chunk_copy_bio(struct chunk *chunk, struct bio *bio,
+		    struct bvec_iter *iter);
+void chunk_diff_bio_tobdev(struct chunk *chunk, struct bio *bio);
+void chunk_store_tobdev(struct chunk *chunk);
+int chunk_diff_bio(struct chunk *chunk, struct bio *bio);
+void chunk_diff_write(struct chunk *chunk);
+bool chunk_load_and_schedule_io(struct chunk *chunk, struct bio *orig_bio);
+int chunk_load_and_postpone_io(struct chunk *chunk, struct bio **chunk_bio);
+void chunk_load_and_postpone_io_finish(struct list_head *chunks,
+				struct bio *chunk_bio, struct bio *orig_bio);
+
+int __init chunk_init(void);
+void chunk_done(void);
+#endif /* __BLKSNAP_CHUNK_H */
diff --git a/drivers/block/blksnap/diff_area.c b/drivers/block/blksnap/diff_area.c
new file mode 100644
index 000000000000..d18cffe51f7a
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.c
@@ -0,0 +1,577 @@
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
+#include "tracker.h"
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
+	chunk = kzalloc(sizeof(struct chunk), GFP_KERNEL);
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
+	if (unlikely((number + 1) == diff_area->chunk_count))
+		chunk->sector_count = bdev_nr_sectors(diff_area->orig_bdev) -
+						(chunk->sector_count * number);
+	return chunk;
+}
+
+static inline void chunk_free(struct diff_area *diff_area, struct chunk *chunk)
+{
+	down(&chunk->lock);
+	if (chunk->diff_buffer)
+		diff_buffer_release(diff_area, chunk->diff_buffer);
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
+								SECTOR_SHIFT);
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
+	struct diff_area *diff_area;
+
+	might_sleep();
+	diff_area = container_of(kref, struct diff_area, kref);
+
+	xa_for_each(&diff_area->chunk_map, inx, chunk) {
+		if (chunk)
+			chunk_free(diff_area, chunk);
+	}
+	xa_destroy(&diff_area->chunk_map);
+
+	diff_buffer_cleanup(diff_area);
+	tracker_put(diff_area->tracker);
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
+		 * If it is not possible to lock a chunk for writing, then it is
+		 * currently in use, and we try to clean up the next chunk.
+		 */
+	}
+	if (!chunk)
+		diff_area->store_queue_processing = false;
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
+	if (!chunk->diff_file && !chunk->diff_bdev) {
+		int ret;
+
+		ret = diff_storage_alloc(diff_area->diff_storage,
+					 diff_area_chunk_sectors(diff_area),
+					 &chunk->diff_bdev,
+					 &chunk->diff_file,
+					 &chunk->diff_ofs_sect);
+		if (ret) {
+			pr_debug("Cannot get store for chunk #%ld\n",
+				 chunk->number);
+			chunk_store_failed(chunk, ret);
+			return true;
+		}
+	}
+	if (chunk->diff_bdev) {
+		chunk_store_tobdev(chunk);
+		return true;
+	}
+	chunk_diff_write(chunk);
+	return true;
+}
+
+static void diff_area_store_queue_work(struct work_struct *work)
+{
+	struct diff_area *diff_area = container_of(
+		work, struct diff_area, store_queue_work);
+	unsigned int old_nofs;
+	struct blkfilter *prev_filter = current->blk_filter;
+
+	current->blk_filter = &diff_area->tracker->filter;
+	old_nofs = memalloc_nofs_save();
+	while (diff_area_store_one(diff_area))
+		;
+	memalloc_nofs_restore(old_nofs);
+	current->blk_filter = prev_filter;
+}
+
+static inline struct chunk_io_ctx *chunk_io_ctx_take(
+						struct diff_area *diff_area)
+{
+	struct chunk_io_ctx *io_ctx;
+
+	spin_lock(&diff_area->image_io_queue_lock);
+	io_ctx = list_first_entry_or_null(&diff_area->image_io_queue,
+						  struct chunk_io_ctx, link);
+	if (io_ctx)
+		list_del(&io_ctx->link);
+	spin_unlock(&diff_area->image_io_queue_lock);
+
+	return io_ctx;
+}
+
+static void diff_area_image_io_work(struct work_struct *work)
+{
+	struct diff_area *diff_area = container_of(
+		work, struct diff_area, image_io_work);
+	struct chunk_io_ctx *io_ctx;
+	unsigned int old_nofs;
+	struct blkfilter *prev_filter = current->blk_filter;
+
+	current->blk_filter = &diff_area->tracker->filter;
+	old_nofs = memalloc_nofs_save();
+	while ((io_ctx = chunk_io_ctx_take(diff_area)))
+		chunk_diff_bio_execute(io_ctx);
+	memalloc_nofs_restore(old_nofs);
+	current->blk_filter = prev_filter;
+}
+
+struct diff_area *diff_area_new(struct tracker *tracker,
+				struct diff_storage *diff_storage)
+{
+	int ret = 0;
+	struct diff_area *diff_area = NULL;
+	struct block_device *bdev = tracker->orig_bdev;
+
+	diff_area = kzalloc(sizeof(struct diff_area), GFP_KERNEL);
+	if (!diff_area)
+		return ERR_PTR(-ENOMEM);
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
+		 MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
+
+	xa_init(&diff_area->chunk_map);
+
+	tracker_get(tracker);
+	diff_area->tracker = tracker;
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
+	spin_lock_init(&diff_area->image_io_queue_lock);
+	INIT_LIST_HEAD(&diff_area->image_io_queue);
+	INIT_WORK(&diff_area->image_io_work, diff_area_image_io_work);
+
+	diff_area->physical_blksz = bdev_physical_block_size(bdev);
+	diff_area->logical_blksz = bdev_logical_block_size(bdev);
+	diff_area->corrupt_flag = 0;
+	diff_area->store_queue_processing = false;
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
+bool diff_area_cow(struct diff_area *diff_area, struct bio *bio,
+		   struct bvec_iter *iter)
+{
+	bool skip_bio = false;
+	bool nowait = bio->bi_opf & REQ_NOWAIT;
+	struct bio *chunk_bio = NULL;
+	LIST_HEAD(chunks);
+	int ret = 0;
+	unsigned int flags;
+
+	flags = memalloc_noio_save();
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
+					GFP_KERNEL);
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
+		bio_advance_iter_single(bio, iter, len);
+
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
+	}
+
+	if (chunk_bio) {
+		/* Postpone bio processing in a callback. */
+		chunk_load_and_postpone_io_finish(&chunks, chunk_bio, bio);
+		skip_bio = true;
+
+	}
+	/* Pass bio to the low level */
+	goto out;
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
+		skip_bio = true;
+	}
+
+out:
+	memalloc_noio_restore(flags);
+	return skip_bio;
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
+	bio_advance(bio, new_bio->bi_iter.bi_size);
+	bio_chain(new_bio, bio);
+
+	submit_bio_noacct(new_bio);
+}
+
+bool diff_area_submit_chunk(struct diff_area *diff_area, struct bio *bio)
+{
+	int ret;
+	unsigned long nr;
+	struct chunk *chunk;
+
+	nr = diff_area_chunk_number(diff_area, bio->bi_iter.bi_sector);
+	chunk = xa_load(&diff_area->chunk_map, nr);
+	/*
+	 * If this chunk is not in the chunk map, then the COW algorithm did
+	 * not access this part of the disk space, and writing to the snapshot
+	 * in this part was also not performed.
+	 */
+	if (!chunk) {
+		if (!op_is_write(bio_op(bio))) {
+			/*
+			 * To read, we simply redirect the bio to the original
+			 * block device.
+			 */
+			orig_clone_bio(diff_area, bio);
+			return true;
+		}
+
+		/*
+		 * To process a write bio, we need to allocate a new chunk.
+		 */
+		chunk = chunk_alloc(diff_area, nr);
+		WARN_ON_ONCE(!chunk);
+		if (unlikely(!chunk))
+			return false;
+
+		ret = xa_insert(&diff_area->chunk_map, nr, chunk, GFP_KERNEL);
+		if (likely(!ret)) {
+			/* new chunk has been added */
+		} else if (ret == -EBUSY) {
+			/* another chunk has just been created */
+			chunk_free(diff_area, chunk);
+			chunk = xa_load(&diff_area->chunk_map, nr);
+			WARN_ON_ONCE(!chunk);
+			if (unlikely(!chunk))
+				return false;
+		} else if (ret) {
+			pr_err("Failed insert chunk to chunk map\n");
+			chunk_free(diff_area, chunk);
+			return false;
+		}
+	}
+
+	if (down_killable(&chunk->lock))
+		return false;
+	chunk->diff_area = diff_area_get(diff_area);
+
+	switch (chunk->state) {
+	case CHUNK_ST_IN_MEMORY:
+		/*
+		 * Directly copy data from the in-memory chunk or
+		 * copy to the in-memory chunk for write operation.
+		 */
+		chunk_copy_bio(chunk, bio, &bio->bi_iter);
+		chunk_up(chunk);
+		return true;
+	case CHUNK_ST_STORED:
+		/*
+		 * Data is read from the difference storage or written to it.
+		 */
+		if (chunk->diff_bdev) {
+			chunk_diff_bio_tobdev(chunk, bio);
+			chunk_up(chunk);
+			return true;
+		}
+		ret = chunk_diff_bio(chunk, bio);
+		return (ret == 0);
+	case CHUNK_ST_NEW:
+		if (!op_is_write(bio_op(bio))) {
+			/*
+			 * Read from original block device
+			 */
+			orig_clone_bio(diff_area, bio);
+			chunk_up(chunk);
+			return true;
+		}
+
+		/*
+		 * Starts asynchronous loading of a chunk from the original
+		 * block device and schedule copying data to (or from) the
+		 * in-memory chunk.
+		 */
+		return chunk_load_and_schedule_io(chunk, bio);
+	default: /* CHUNK_ST_FAILED */
+		pr_err("Chunk #%ld corrupted\n", chunk->number);
+		chunk_up(chunk);
+		return false;
+	}
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
+	event_gen(&diff_area->diff_storage->event_queue,
+		  blksnap_event_code_corrupted,
+		  &data,
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
index 000000000000..86dac4379289
--- /dev/null
+++ b/drivers/block/blksnap/diff_area.h
@@ -0,0 +1,175 @@
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
+struct tracker;
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
+ * @tracker:
+ *	Back pointer to the tracker for this &struct diff_area
+ * @chunk_shift:
+ *	Power of 2 used to specify the chunk size. This allows to set different
+ *	chunk sizes for huge and small block devices.
+ * @chunk_count:
+ *	Count of chunks. The number of chunks into which the block device
+ *	is divided.
+ * @chunk_map:
+ *	A map of chunks. The map stores only chunks of differences. Chunks are
+ *	added to the map if this data block was overwritten on the original
+ *	device, or was overwritten on the snapshot. If there is no chunk in the
+ *	map, then when accessing the snapshot, I/O units are redirected to the
+ *	original device.
+ * @store_queue_lock:
+ *	The spinlock guarantees consistency of the linked lists of chunks
+ *	queue.
+ * @store_queue:
+ *	The queue of chunks waiting to be stored to the difference storage.
+ * @store_queue_count:
+ *	The number of chunks in the store queue.
+ * @store_queue_work:
+ *	The workqueue work item. This worker stores chunks to the difference
+ *	storage freeing up the cache. It's limits the number of chunks that
+ *	store their data in RAM.
+ * @store_queue_processing:
+ *	The flag is an indication that the &diff_area.store_queue_work is
+ *	running or has been scheduled to run.
+ * @free_diff_buffers_lock:
+ *	The spinlock guarantees consistency of the linked lists of free
+ *	difference buffers.
+ * @free_diff_buffers:
+ *	Linked list of free difference buffers allows to reduce the number
+ *	of buffer allocation and release operations.
+ * @free_diff_buffers_count:
+ *	The number of free difference buffers in the linked list.
+ * @image_io_queue_lock:
+ *	The spinlock guarantees consistency of the linked lists of I/O
+ *	requests to image.
+ * @image_io_queue:
+ *	A linked list of I/O units for the snapshot image that need to be read
+ *	from the difference storage to process.
+ * @image_io_work:
+ *	A worker who maintains the I/O units for reading or writing data to the
+ *	difference storage file. If the difference storage is a block device,
+ *	then this worker is not	used to process the I/O units of the snapshot
+ *	image.
+ * @physical_blksz:
+ *	The physical block size for the snapshot image is equal to the
+ *	physical block size of the original device.
+ * @logical_blksz:
+ *	The logical block size for the snapshot image is equal to the
+ *	logical block size of the original device.
+ * @corrupt_flag:
+ *	The flag is set if an error occurred in the operation of the data
+ *	saving mechanism in the diff area. In this case, an error will be
+ *	generated when reading from the snapshot image.
+ * @error_code:
+ *	The error code that caused the snapshot to be corrupted.
+ *
+ * The &struct diff_area is created for each block device in the snapshot. It
+ * is used to store the differences between the original block device and the
+ * snapshot image. That is, when writing data to the original device, the
+ * differences are copied as chunks to the difference storage. Reading and
+ * writing from the snapshot image is also performed using &struct diff_area.
+ *
+ * The map of chunks is a xarray. It has a capacity limit. This can be
+ * especially noticeable on 32-bit systems. The maximum number of chunks for
+ * 32-bit systems cannot be equal or more than 2^32.
+ *
+ * For example, for a 256 TiB disk and a chunk size of 65536 bytes, the number
+ * of chunks in the chunk map will be equal to 2^32. This number already goes
+ * beyond the 32-bit number. Therefore, for large disks, it is required to
+ * increase the size of the chunk.
+ *
+ * The store queue allows to postpone the operation of storing a chunks data
+ * to the difference storage and perform it later in the worker thread.
+ *
+ * The linked list of difference buffers allows to have a certain number of
+ * "hot" buffers. This allows to reduce the number of allocations and releases
+ * of memory.
+ *
+ * If it is required to read or write to the difference storage file to process
+ * I/O unit from snapshot image, then this operation is performed in a separate
+ * thread. To do this, a worker &diff_area.image_io_work and a queue
+ * &diff_area.image_io_queue are used. An attempt to read a file from the same
+ * thread that initiated the block I/O can lead to a deadlock state.
+ */
+struct diff_area {
+	struct kref kref;
+	struct block_device *orig_bdev;
+	struct diff_storage *diff_storage;
+	struct tracker *tracker;
+
+	unsigned long chunk_shift;
+	unsigned long chunk_count;
+	struct xarray chunk_map;
+
+	spinlock_t store_queue_lock;
+	struct list_head store_queue;
+	atomic_t store_queue_count;
+	struct work_struct store_queue_work;
+	bool store_queue_processing;
+
+	spinlock_t free_diff_buffers_lock;
+	struct list_head free_diff_buffers;
+	atomic_t free_diff_buffers_count;
+
+	spinlock_t image_io_queue_lock;
+	struct list_head image_io_queue;
+	struct work_struct image_io_work;
+
+	unsigned int physical_blksz;
+	unsigned int logical_blksz;
+
+	unsigned long corrupt_flag;
+	int error_code;
+};
+
+struct diff_area *diff_area_new(struct tracker *tracker,
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
+bool diff_area_cow(struct diff_area *diff_area, struct bio *bio,
+		   struct bvec_iter *iter);
+
+bool diff_area_submit_chunk(struct diff_area *diff_area, struct bio *bio);
+void diff_area_rw_chunk(struct kref *kref);
+
+#endif /* __BLKSNAP_DIFF_AREA_H */
diff --git a/drivers/block/blksnap/diff_buffer.c b/drivers/block/blksnap/diff_buffer.c
new file mode 100644
index 000000000000..fe17ed12a6e3
--- /dev/null
+++ b/drivers/block/blksnap/diff_buffer.c
@@ -0,0 +1,114 @@
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
+	for (inx = 0; inx < diff_buffer->nr_pages; inx++)
+		__free_page(diff_buffer->bvec[inx].bv_page);
+
+	kfree(diff_buffer);
+}
+
+static struct diff_buffer *diff_buffer_new(size_t nr_pages, size_t size)
+{
+	struct diff_buffer *diff_buffer;
+	size_t inx = 0;
+
+	if (unlikely(nr_pages <= 0))
+		return NULL;
+
+	diff_buffer = kzalloc(sizeof(struct diff_buffer) +
+			      nr_pages * sizeof(struct bio_vec),
+			      GFP_KERNEL);
+	if (!diff_buffer)
+		return NULL;
+
+	INIT_LIST_HEAD(&diff_buffer->link);
+	diff_buffer->size = size;
+	diff_buffer->nr_pages = nr_pages;
+
+	for (inx = 0; inx < nr_pages; inx++) {
+		struct page *page = alloc_page(GFP_KERNEL);
+
+		if (!page)
+			goto fail;
+		bvec_set_page(&diff_buffer->bvec[inx], page, PAGE_SIZE, 0);
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
+	diff_buffer = diff_buffer_new(page_count,
+				      chunk_sectors << SECTOR_SHIFT);
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
index 000000000000..02f2da6c4620
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
+ * @nr_pages:
+ *	The number of pages reserved for the buffer.
+ * @bvec:
+ *	An array of pages in bio_vec form.
+ *
+ * Describes the buffer in memory for a chunk.
+ */
+struct diff_buffer {
+	struct list_head link;
+	size_t size;
+	unsigned long nr_pages;
+	struct bio_vec bvec[];
+};
+
+struct diff_buffer *diff_buffer_take(struct diff_area *diff_area);
+void diff_buffer_release(struct diff_area *diff_area,
+			 struct diff_buffer *diff_buffer);
+void diff_buffer_cleanup(struct diff_area *diff_area);
+#endif /* __BLKSNAP_DIFF_BUFFER_H */
diff --git a/drivers/block/blksnap/diff_storage.c b/drivers/block/blksnap/diff_storage.c
new file mode 100644
index 000000000000..2493836a9c82
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#define pr_fmt(fmt) KBUILD_MODNAME "-diff-storage: " fmt
+
+#include <linux/slab.h>
+#include <linux/sched/mm.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/file.h>
+#include <linux/blkdev.h>
+#include <linux/build_bug.h>
+#include <uapi/linux/blksnap.h>
+#include "chunk.h"
+#include "diff_buffer.h"
+#include "diff_storage.h"
+#include "params.h"
+
+static void diff_storage_reallocate_work(struct work_struct *work)
+{
+	int ret;
+	sector_t req_sect;
+	struct diff_storage *diff_storage = container_of(
+		work, struct diff_storage, reallocate_work);
+	bool complete = false;
+
+	do {
+		spin_lock(&diff_storage->lock);
+		req_sect = diff_storage->requested;
+		spin_unlock(&diff_storage->lock);
+
+		ret = vfs_fallocate(diff_storage->file, 0, 0,
+				    (loff_t)(req_sect << SECTOR_SHIFT));
+		if (ret) {
+			pr_err("Failed to fallocate difference storage file\n");
+			break;
+		}
+
+		spin_lock(&diff_storage->lock);
+		diff_storage->capacity = req_sect;
+		complete = (diff_storage->capacity >= diff_storage->requested);
+		if (complete)
+			atomic_set(&diff_storage->low_space_flag, 0);
+		spin_unlock(&diff_storage->lock);
+
+		pr_debug("Diff storage reallocate. Capacity: %llu sectors\n",
+			 req_sect);
+	} while (!complete);
+}
+
+static bool diff_storage_calculate_requested(struct diff_storage *diff_storage)
+{
+	bool ret = false;
+
+	spin_lock(&diff_storage->lock);
+	if (diff_storage->capacity < diff_storage->limit) {
+		diff_storage->requested += min(get_diff_storage_minimum(),
+				diff_storage->limit - diff_storage->capacity);
+		ret = true;
+	}
+	pr_debug("The size of the difference storage was %llu MiB\n",
+		 diff_storage->capacity >> (20 - SECTOR_SHIFT));
+	pr_debug("The limit is %llu MiB\n",
+		 diff_storage->limit >> (20 - SECTOR_SHIFT));
+	spin_unlock(&diff_storage->lock);
+
+	return ret;
+}
+
+static inline bool is_halffull(const sector_t sectors_left)
+{
+	return sectors_left <= (get_diff_storage_minimum() / 2);
+}
+
+static inline void check_halffull(struct diff_storage *diff_storage,
+				  const sector_t sectors_left)
+{
+	if (is_halffull(sectors_left) &&
+	    (atomic_inc_return(&diff_storage->low_space_flag) == 1)) {
+		if (diff_storage->bdev) {
+			pr_warn("Reallocating is allowed only for a regular file\n");
+			return;
+		}
+		if (!diff_storage_calculate_requested(diff_storage)) {
+			pr_info("The limit size of the difference storage has been reached\n");
+			return;
+		}
+
+		pr_debug("Diff storage low free space.\n");
+		queue_work(system_highpri_wq, &diff_storage->reallocate_work);
+	}
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
+	diff_storage->limit = 0;
+
+	INIT_WORK(&diff_storage->reallocate_work, diff_storage_reallocate_work);
+	event_queue_init(&diff_storage->event_queue);
+
+	return diff_storage;
+}
+
+void diff_storage_free(struct kref *kref)
+{
+	struct diff_storage *diff_storage;
+
+	diff_storage = container_of(kref, struct diff_storage, kref);
+	flush_work(&diff_storage->reallocate_work);
+
+	if (diff_storage->bdev_handle)
+		bdev_release(diff_storage->bdev_handle);
+	if (diff_storage->file)
+		filp_close(diff_storage->file, NULL);
+	event_queue_done(&diff_storage->event_queue);
+	kfree(diff_storage);
+}
+
+static inline int diff_storage_set_bdev(struct diff_storage *diff_storage,
+					const char *devpath)
+{
+	struct bdev_handle *bdev_handle;
+
+	bdev_handle = bdev_open_by_path(devpath,
+				BLK_OPEN_EXCL | BLK_OPEN_READ | BLK_OPEN_WRITE,
+				diff_storage, NULL);
+	if (IS_ERR(bdev_handle)) {
+		pr_err("Failed to open a block device '%s'\n", devpath);
+		return PTR_ERR(bdev_handle);
+	}
+
+	pr_debug("A block device is selected for difference storage\n");
+	diff_storage->bdev_handle = bdev_handle;
+	diff_storage->dev_id = bdev_handle->bdev->bd_dev;
+	diff_storage->capacity = bdev_nr_sectors(bdev_handle->bdev);
+	diff_storage->bdev = bdev_handle->bdev;
+	return 0;
+}
+
+static inline void ___set_file(struct diff_storage *diff_storage,
+			       struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	diff_storage->dev_id = inode->i_sb->s_dev;
+	diff_storage->capacity = i_size_read(inode) >> SECTOR_SHIFT;
+	diff_storage->file = file;
+}
+
+static inline int diff_storage_set_tmpfile(struct diff_storage *diff_storage,
+					   const char *dirname)
+{
+	struct file *file;
+	int flags = O_EXCL | O_RDWR | O_LARGEFILE | O_NOATIME | O_DIRECT |
+		    O_TMPFILE;
+
+	file = filp_open(dirname, flags, 00600);
+	if (IS_ERR(file)) {
+		pr_err("Failed to create a temp file in directory '%s'\n",
+			dirname);
+		return PTR_ERR(file);
+	}
+
+	pr_debug("A temp file is selected for difference storage\n");
+	___set_file(diff_storage, file);
+	return 0;
+}
+
+static inline int diff_storage_set_regfile(struct diff_storage *diff_storage,
+					   const char *filename)
+{
+	struct file *file;
+	int flags = O_EXCL | O_RDWR | O_LARGEFILE | O_NOATIME | O_DIRECT;
+
+	file = filp_open(filename, flags, 00600);
+	if (IS_ERR(file)) {
+		pr_err("Failed to open a regular file '%s'\n", filename);
+		return PTR_ERR(file);
+	}
+
+	pr_debug("A regular file is selected for difference storage\n");
+	___set_file(diff_storage, file);
+	return 0;
+}
+
+int diff_storage_set_diff_storage(struct diff_storage *diff_storage,
+				  const char *filename, sector_t limit)
+{
+	int ret = 0;
+	struct file *file;
+	umode_t mode;
+	sector_t req_sect;
+
+	file = filp_open(filename, O_RDONLY, 00400);
+	if (IS_ERR(file)) {
+		pr_err("Failed to open '%s'\n", filename);
+		return PTR_ERR(file);
+	}
+	mode = file_inode(file)->i_mode;
+	filp_close(file, NULL);
+
+	if (S_ISBLK(mode))
+		ret = diff_storage_set_bdev(diff_storage, filename);
+	else if (S_ISDIR(mode))
+		ret = diff_storage_set_tmpfile(diff_storage, filename);
+	else if (S_ISREG(mode))
+		ret = diff_storage_set_regfile(diff_storage, filename);
+	else {
+		pr_err("The difference storage should be a block device, directory or regular file\n");
+		ret = -EINVAL;
+	}
+	if (ret)
+		return ret;
+
+	diff_storage->requested = diff_storage->capacity;
+	diff_storage->limit = limit;
+
+	if (!is_halffull(diff_storage->requested))
+		return 0;
+
+	if (diff_storage->capacity == diff_storage->limit) {
+		pr_info("The limit size of the difference storage has been reached\n");
+		return 0;
+	}
+	if (diff_storage->capacity > diff_storage->limit) {
+		pr_err("The limit size of the difference storage has been exceeded\n");
+		return -ENOSPC;
+	}
+
+	diff_storage->requested +=
+		min(get_diff_storage_minimum(),
+		    diff_storage->limit - diff_storage->capacity);
+	req_sect = diff_storage->requested;
+
+	if (diff_storage->bdev) {
+		pr_warn("Difference storage on block device is not large enough\n");
+		pr_warn("Requested: %llu sectors\n", req_sect);
+		return 0;
+	}
+
+	pr_debug("Difference storage is not large enough\n");
+	pr_debug("Requested: %llu sectors\n", req_sect);
+
+	ret = vfs_fallocate(diff_storage->file, 0, 0,
+			    (loff_t)(req_sect << SECTOR_SHIFT));
+	if (ret) {
+		pr_err("Failed to fallocate difference storage file\n");
+		pr_warn("The difference storage is not large enough\n");
+		return ret;
+	}
+	diff_storage->capacity = req_sect;
+	return 0;
+}
+
+int diff_storage_alloc(struct diff_storage *diff_storage, sector_t count,
+			struct block_device **bdev, struct file **file,
+			sector_t *sector)
+
+{
+	sector_t sectors_left;
+
+	if (atomic_read(&diff_storage->overflow_flag))
+		return -ENOSPC;
+
+	spin_lock(&diff_storage->lock);
+	if ((diff_storage->filled + count) > diff_storage->requested) {
+		atomic_inc(&diff_storage->overflow_flag);
+		spin_unlock(&diff_storage->lock);
+		return -ENOSPC;
+	}
+
+	*bdev = diff_storage->bdev;
+	*file = diff_storage->file;
+	*sector = diff_storage->filled;
+
+	diff_storage->filled += count;
+	sectors_left = diff_storage->requested - diff_storage->filled;
+
+	spin_unlock(&diff_storage->lock);
+
+	check_halffull(diff_storage, sectors_left);
+	return 0;
+}
diff --git a/drivers/block/blksnap/diff_storage.h b/drivers/block/blksnap/diff_storage.h
new file mode 100644
index 000000000000..5a273db0b070
--- /dev/null
+++ b/drivers/block/blksnap/diff_storage.h
@@ -0,0 +1,103 @@
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
+ * struct diff_storage - Difference storage.
+ *
+ * @kref:
+ *	The reference counter.
+ * @lock:
+ *	Spinlock allows to safely change structure fields in a multithreaded
+ *	environment.
+ * @dev_id:
+ *	ID of the block device on which the difference storage file is located.
+ * @bdev_handle:
+ *	A pointer to the block device handle. This handle allows to keep the
+ *	block device open.
+ * @bdev:
+ *	A pointer to the block device that has been selected for the
+ *	difference storage.
+ * @file:
+ *	A pointer to the file that was selected for the difference storage.
+ * @capacity:
+ *	Total amount of available difference storage space.
+ * @limit:
+ *	The limit to which the difference storage can be allowed to grow.
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
+ * @reallocate_work:
+ *	The working thread in which the difference storage file is growing.
+ * @event_queue:
+ *	A queue of events to pass events to user space.
+ *
+ * The difference storage manages the block device or file that are used
+ * to store the data of the original block devices in the snapshot.
+ * The difference storage is created one per snapshot and is used to store
+ * data from all block devices.
+ *
+ * The difference storage file has the ability to increase while holding the
+ * snapshot as needed within the specified limits. This is done using the
+ * function vfs_fallocate().
+ *
+ * Changing the file size leads to a change in the file metadata in the file
+ * system, which leads to the generation of I/O units for the block device.
+ * Using a separate working thread ensures that metadata changes will be
+ * handled and correctly processed by the block-level filters.
+ *
+ * The event queue allows to inform the user land about changes in the state
+ * of the difference storage.
+ */
+struct diff_storage {
+	struct kref kref;
+	spinlock_t lock;
+
+	dev_t dev_id;
+	struct bdev_handle *bdev_handle;
+	struct block_device *bdev;
+	struct file *file;
+	sector_t capacity;
+	sector_t limit;
+	sector_t filled;
+	sector_t requested;
+
+	atomic_t low_space_flag;
+	atomic_t overflow_flag;
+
+	struct work_struct reallocate_work;
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
+int diff_storage_set_diff_storage(struct diff_storage *diff_storage,
+				  const char *filename, sector_t limit);
+
+int diff_storage_alloc(struct diff_storage *diff_storage, sector_t count,
+		       struct block_device **bdev, struct file **file,
+		       sector_t *sector);
+#endif /* __BLKSNAP_DIFF_STORAGE_H */
-- 
2.34.1


