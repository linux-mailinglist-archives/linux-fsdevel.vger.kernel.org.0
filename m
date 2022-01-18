Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC549201D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiARHVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245138AbiARHUq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:20:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DACC06173F;
        Mon, 17 Jan 2022 23:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2tJLPdED4SGW7vJ+FwaWFHXC0m4BTaKxi6F9pfd4VTw=; b=Iyoh+Rz2uIOTM/jdoHtisuE4MS
        1lMaLS2Gx18JfZpvcTj6vRtv8q0hizPNrgXSN4AeLB632Naqe/uHKRAzP+ft0o4tRmGx7WnA7zovL
        uvfA8fZG7T/OM2S0se5fT6ySrM4db6TLCqncJKE1zfD9Gi4Uxa9Dr4ODgkf33zu0zb94/NCHtUHU3
        aqx42oON5Unsqj6PvSH+7AkFJQR6XHPnV0Q7WQr/1eibQAw3c877Hpb/7xp6f4h7+nyAuKGQE/dxF
        6rUG/MSeN1Ydc5mjbpl18/4yxnBnoZJrRG1MmFbdfcxBIvxdujM/Ch6/YT+fuBG8gNSnu4QYt3dp1
        Ua1CpJDw==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9inE-000Zg8-Lu; Tue, 18 Jan 2022 07:20:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal " <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        xen-devel@lists.xenproject.org, drbd-dev@lists.linbit.com
Subject: [PATCH 15/19] block: pass a block_device and opf to bio_alloc_bioset
Date:   Tue, 18 Jan 2022 08:19:48 +0100
Message-Id: <20220118071952.1243143-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220118071952.1243143-1-hch@lst.de>
References: <20220118071952.1243143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pass the block_device and operation that we plan to use this bio for to
bio_alloc_bioset to optimize the assigment.  NULL/0 can be passed, both
for the passthrough case on a raw request_queue and to temporarily avoid
refactoring some nasty code.

Also move the gfp_mask argument after the nr_vecs argument for a much
more logical calling convention matching what most of the kernel does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                         | 29 +++++++++++++++++------------
 block/bounce.c                      |  6 ++----
 drivers/block/drbd/drbd_actlog.c    |  5 ++---
 drivers/block/drbd/drbd_bitmap.c    |  7 +++----
 drivers/md/bcache/request.c         | 12 +++++-------
 drivers/md/dm-crypt.c               |  5 ++---
 drivers/md/dm-io.c                  |  5 ++---
 drivers/md/dm-writecache.c          |  7 ++++---
 drivers/md/dm.c                     |  5 +++--
 drivers/md/md.c                     | 16 ++++++++--------
 drivers/md/raid1.c                  |  3 ++-
 drivers/md/raid10.c                 |  6 ++----
 drivers/md/raid5-cache.c            |  8 ++++----
 drivers/md/raid5-ppl.c              | 11 +++++------
 drivers/target/target_core_iblock.c |  6 ++----
 fs/btrfs/extent_io.c                |  2 +-
 fs/f2fs/data.c                      |  7 +++----
 fs/iomap/buffered-io.c              |  6 +++---
 include/linux/bio.h                 |  7 ++++---
 19 files changed, 74 insertions(+), 79 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 52c99bfa8008d..a58bc82d3c85f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -417,8 +417,10 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
 
 /**
  * bio_alloc_bioset - allocate a bio for I/O
+ * @bdev:	block device to allocate the bio for (can be %NULL)
+ * @nr_vecs:	number of bvecs to pre-allocate
+ * @opf:	operation and flags for bio
  * @gfp_mask:   the GFP_* mask given to the slab allocator
- * @nr_iovecs:	number of iovecs to pre-allocate
  * @bs:		the bio_set to allocate from.
  *
  * Allocate a bio from the mempools in @bs.
@@ -447,15 +449,16 @@ static void punt_bios_to_rescuer(struct bio_set *bs)
  *
  * Returns: Pointer to new bio on success, NULL on failure.
  */
-struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned short nr_iovecs,
+struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
+			     unsigned int opf, gfp_t gfp_mask,
 			     struct bio_set *bs)
 {
 	gfp_t saved_gfp = gfp_mask;
 	struct bio *bio;
 	void *p;
 
-	/* should not use nobvec bioset for nr_iovecs > 0 */
-	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_iovecs > 0))
+	/* should not use nobvec bioset for nr_vecs > 0 */
+	if (WARN_ON_ONCE(!mempool_initialized(&bs->bvec_pool) && nr_vecs > 0))
 		return NULL;
 
 	/*
@@ -492,26 +495,28 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned short nr_iovecs,
 		return NULL;
 
 	bio = p + bs->front_pad;
-	if (nr_iovecs > BIO_INLINE_VECS) {
+	if (nr_vecs > BIO_INLINE_VECS) {
 		struct bio_vec *bvl = NULL;
 
-		bvl = bvec_alloc(&bs->bvec_pool, &nr_iovecs, gfp_mask);
+		bvl = bvec_alloc(&bs->bvec_pool, &nr_vecs, gfp_mask);
 		if (!bvl && gfp_mask != saved_gfp) {
 			punt_bios_to_rescuer(bs);
 			gfp_mask = saved_gfp;
-			bvl = bvec_alloc(&bs->bvec_pool, &nr_iovecs, gfp_mask);
+			bvl = bvec_alloc(&bs->bvec_pool, &nr_vecs, gfp_mask);
 		}
 		if (unlikely(!bvl))
 			goto err_free;
 
-		bio_init(bio, bvl, nr_iovecs);
-	} else if (nr_iovecs) {
+		bio_init(bio, bvl, nr_vecs);
+	} else if (nr_vecs) {
 		bio_init(bio, bio->bi_inline_vecs, BIO_INLINE_VECS);
 	} else {
 		bio_init(bio, NULL, 0);
 	}
 
 	bio->bi_pool = bs;
+	bio_set_dev(bio, bdev);
+	bio->bi_opf = opf;
 	return bio;
 
 err_free:
@@ -766,7 +771,7 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 {
 	struct bio *b;
 
-	b = bio_alloc_bioset(gfp_mask, 0, bs);
+	b = bio_alloc_bioset(NULL, 0, 0, gfp_mask, bs);
 	if (!b)
 		return NULL;
 
@@ -1742,7 +1747,7 @@ struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
 	struct bio *bio;
 
 	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE) || nr_vecs > BIO_INLINE_VECS)
-		return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
+		return bio_alloc_bioset(NULL, nr_vecs, 0, GFP_KERNEL, bs);
 
 	cache = per_cpu_ptr(bs->cache, get_cpu());
 	if (cache->free_list) {
@@ -1756,7 +1761,7 @@ struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
 		return bio;
 	}
 	put_cpu();
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
+	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_KERNEL, bs);
 	bio_set_flag(bio, BIO_PERCPU_CACHE);
 	return bio;
 }
diff --git a/block/bounce.c b/block/bounce.c
index 7af1a72835b99..330ddde25b460 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -165,12 +165,10 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	 *    asking for trouble and would force extra work on
 	 *    __bio_clone_fast() anyways.
 	 */
-	bio = bio_alloc_bioset(GFP_NOIO, bio_segments(bio_src),
-			       &bounce_bio_set);
-	bio->bi_bdev		= bio_src->bi_bdev;
+	bio = bio_alloc_bioset(bio_src->bi_bdev, bio_segments(bio_src),
+			       bio_src->bi_opf, GFP_NOIO, &bounce_bio_set);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
-	bio->bi_opf		= bio_src->bi_opf;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 72cf7603d51fc..f5bcded3640da 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -138,15 +138,14 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 		op_flags |= REQ_FUA | REQ_PREFLUSH;
 	op_flags |= REQ_SYNC;
 
-	bio = bio_alloc_bioset(GFP_NOIO, 1, &drbd_md_io_bio_set);
-	bio_set_dev(bio, bdev->md_bdev);
+	bio = bio_alloc_bioset(bdev->md_bdev, 1, op | op_flags, GFP_NOIO,
+			       &drbd_md_io_bio_set);
 	bio->bi_iter.bi_sector = sector;
 	err = -EIO;
 	if (bio_add_page(bio, device->md_io.page, size, 0) != size)
 		goto out;
 	bio->bi_private = device;
 	bio->bi_end_io = drbd_md_endio;
-	bio_set_op_attrs(bio, op, op_flags);
 
 	if (op != REQ_OP_WRITE && device->state.disk == D_DISKLESS && device->ldev == NULL)
 		/* special case, drbd_md_read() during drbd_adm_attach(): no get_ldev */
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index c1f816f896a89..df25eecf80af0 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -976,12 +976,13 @@ static void drbd_bm_endio(struct bio *bio)
 
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
-	struct bio *bio = bio_alloc_bioset(GFP_NOIO, 1, &drbd_md_io_bio_set);
 	struct drbd_device *device = ctx->device;
+	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
+	struct bio *bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op,
+					   GFP_NOIO, &drbd_md_io_bio_set);
 	struct drbd_bitmap *b = device->bitmap;
 	struct page *page;
 	unsigned int len;
-	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
 
 	sector_t on_disk_sector =
 		device->ldev->md.md_offset + device->ldev->md.bm_offset;
@@ -1006,14 +1007,12 @@ static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_ho
 		bm_store_page_idx(page, page_nr);
 	} else
 		page = b->bm_pages[page_nr];
-	bio_set_dev(bio, device->ldev->md_bdev);
 	bio->bi_iter.bi_sector = on_disk_sector;
 	/* bio_add_page of a single page to an empty bio will always succeed,
 	 * according to api.  Do we want to assert that? */
 	bio_add_page(bio, page, len, 0);
 	bio->bi_private = ctx;
 	bio->bi_end_io = drbd_bm_endio;
-	bio_set_op_attrs(bio, op, 0);
 
 	if (drbd_insert_fault(device, (op == REQ_OP_WRITE) ? DRBD_FAULT_MD_WR : DRBD_FAULT_MD_RD)) {
 		bio_io_error(bio);
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index d15aae6c51c13..c4b7e434de8ac 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -913,14 +913,13 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	/* btree_search_recurse()'s btree iterator is no good anymore */
 	ret = miss == bio ? MAP_DONE : -EINTR;
 
-	cache_bio = bio_alloc_bioset(GFP_NOWAIT,
+	cache_bio = bio_alloc_bioset(miss->bi_bdev,
 			DIV_ROUND_UP(s->insert_bio_sectors, PAGE_SECTORS),
-			&dc->disk.bio_split);
+			0, GFP_NOWAIT, &dc->disk.bio_split);
 	if (!cache_bio)
 		goto out_submit;
 
 	cache_bio->bi_iter.bi_sector	= miss->bi_iter.bi_sector;
-	bio_copy_dev(cache_bio, miss);
 	cache_bio->bi_iter.bi_size	= s->insert_bio_sectors << 9;
 
 	cache_bio->bi_end_io	= backing_request_endio;
@@ -1025,16 +1024,15 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
 			 */
 			struct bio *flush;
 
-			flush = bio_alloc_bioset(GFP_NOIO, 0,
-						 &dc->disk.bio_split);
+			flush = bio_alloc_bioset(bio->bi_bdev, 0,
+						 REQ_OP_WRITE | REQ_PREFLUSH,
+						 GFP_NOIO, &dc->disk.bio_split);
 			if (!flush) {
 				s->iop.status = BLK_STS_RESOURCE;
 				goto insert_data;
 			}
-			bio_copy_dev(flush, bio);
 			flush->bi_end_io = backing_request_endio;
 			flush->bi_private = cl;
-			flush->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 			/* I/O request sent to backing device */
 			closure_bio_submit(s->iop.c, flush, cl);
 		}
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 3c5ecd35d3483..f7e4435b7439a 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1672,11 +1672,10 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
 	if (unlikely(gfp_mask & __GFP_DIRECT_RECLAIM))
 		mutex_lock(&cc->bio_alloc_lock);
 
-	clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &cc->bs);
+	clone = bio_alloc_bioset(cc->dev->bdev, nr_iovecs, io->base_bio->bi_opf,
+				 GFP_NOIO, &cc->bs);
 	clone->bi_private = io;
 	clone->bi_end_io = crypt_endio;
-	bio_set_dev(clone, cc->dev->bdev);
-	clone->bi_opf = io->base_bio->bi_opf;
 
 	remaining_size = size;
 
diff --git a/drivers/md/dm-io.c b/drivers/md/dm-io.c
index 2d3cda0acacb6..23e038f8dc845 100644
--- a/drivers/md/dm-io.c
+++ b/drivers/md/dm-io.c
@@ -345,11 +345,10 @@ static void do_region(int op, int op_flags, unsigned region,
 						(PAGE_SIZE >> SECTOR_SHIFT)));
 		}
 
-		bio = bio_alloc_bioset(GFP_NOIO, num_bvecs, &io->client->bios);
+		bio = bio_alloc_bioset(where->bdev, num_bvecs, op | op_flags,
+				       GFP_NOIO, &io->client->bios);
 		bio->bi_iter.bi_sector = where->sector + (where->count - remaining);
-		bio_set_dev(bio, where->bdev);
 		bio->bi_end_io = endio;
-		bio_set_op_attrs(bio, op, op_flags);
 		store_io_and_region_in_bio(bio, io, region);
 
 		if (op == REQ_OP_DISCARD || op == REQ_OP_WRITE_ZEROES) {
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4f31591d2d25e..5630b470ba429 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1821,11 +1821,11 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 
 		max_pages = e->wc_list_contiguous;
 
-		bio = bio_alloc_bioset(GFP_NOIO, max_pages, &wc->bio_set);
+		bio = bio_alloc_bioset(wc->dev->bdev, max_pages, REQ_OP_WRITE,
+				       GFP_NOIO, &wc->bio_set);
 		wb = container_of(bio, struct writeback_struct, bio);
 		wb->wc = wc;
 		bio->bi_end_io = writecache_writeback_endio;
-		bio_set_dev(bio, wc->dev->bdev);
 		bio->bi_iter.bi_sector = read_original_sector(wc, e);
 		if (max_pages <= WB_LIST_INLINE ||
 		    unlikely(!(wb->wc_list = kmalloc_array(max_pages, sizeof(struct wc_entry *),
@@ -1852,7 +1852,8 @@ static void __writecache_writeback_pmem(struct dm_writecache *wc, struct writeba
 			wb->wc_list[wb->wc_list_n++] = f;
 			e = f;
 		}
-		bio_set_op_attrs(bio, REQ_OP_WRITE, WC_MODE_FUA(wc) * REQ_FUA);
+		if (WC_MODE_FUA(wc))
+			bio->bi_opf |= REQ_FUA;
 		if (writecache_has_error(wc)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 81449cbdafa81..84f3dd58d1a16 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -519,7 +519,7 @@ static struct dm_io *alloc_io(struct mapped_device *md, struct bio *bio)
 	struct dm_target_io *tio;
 	struct bio *clone;
 
-	clone = bio_alloc_bioset(GFP_NOIO, 0, &md->io_bs);
+	clone = bio_alloc_bioset(NULL, 0, 0, GFP_NOIO, &md->io_bs);
 
 	tio = container_of(clone, struct dm_target_io, clone);
 	tio->inside_dm_io = true;
@@ -552,7 +552,8 @@ static struct dm_target_io *alloc_tio(struct clone_info *ci, struct dm_target *t
 		/* the dm_target_io embedded in ci->io is available */
 		tio = &ci->io->tio;
 	} else {
-		struct bio *clone = bio_alloc_bioset(gfp_mask, 0, &ci->io->md->bs);
+		struct bio *clone = bio_alloc_bioset(NULL, 0, 0, gfp_mask,
+						     &ci->io->md->bs);
 		if (!clone)
 			return NULL;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5881d05a76ebc..40fc1f7e65c5d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -562,11 +562,11 @@ static void submit_flushes(struct work_struct *ws)
 			atomic_inc(&rdev->nr_pending);
 			atomic_inc(&rdev->nr_pending);
 			rcu_read_unlock();
-			bi = bio_alloc_bioset(GFP_NOIO, 0, &mddev->bio_set);
+			bi = bio_alloc_bioset(rdev->bdev, 0,
+					      REQ_OP_WRITE | REQ_PREFLUSH,
+					      GFP_NOIO, &mddev->bio_set);
 			bi->bi_end_io = md_end_flush;
 			bi->bi_private = rdev;
-			bio_set_dev(bi, rdev->bdev);
-			bi->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 			atomic_inc(&mddev->flush_pending);
 			submit_bio(bi);
 			rcu_read_lock();
@@ -955,7 +955,6 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	 * If an error occurred, call md_error
 	 */
 	struct bio *bio;
-	int ff = 0;
 
 	if (!page)
 		return;
@@ -963,11 +962,13 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	if (test_bit(Faulty, &rdev->flags))
 		return;
 
-	bio = bio_alloc_bioset(GFP_NOIO, 1, &mddev->sync_set);
+	bio = bio_alloc_bioset(rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev,
+			       1,
+			       REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA,
+			       GFP_NOIO, &mddev->sync_set);
 
 	atomic_inc(&rdev->nr_pending);
 
-	bio_set_dev(bio, rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
@@ -976,8 +977,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	if (test_bit(MD_FAILFAST_SUPPORTED, &mddev->flags) &&
 	    test_bit(FailFast, &rdev->flags) &&
 	    !test_bit(LastDev, &rdev->flags))
-		ff = MD_FAILFAST;
-	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA | ff;
+		bio->bi_opf |= MD_FAILFAST;
 
 	atomic_inc(&mddev->pending_writes);
 	submit_bio(bio);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e2d8acb1e9881..43276f8fdc815 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1126,7 +1126,8 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 	int i = 0;
 	struct bio *behind_bio = NULL;
 
-	behind_bio = bio_alloc_bioset(GFP_NOIO, vcnt, &r1_bio->mddev->bio_set);
+	behind_bio = bio_alloc_bioset(NULL, vcnt, 0, GFP_NOIO,
+				      &r1_bio->mddev->bio_set);
 	if (!behind_bio)
 		return;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 2b969f70a31fb..cb7c58050708e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4892,14 +4892,12 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 		return sectors_done;
 	}
 
-	read_bio = bio_alloc_bioset(GFP_KERNEL, RESYNC_PAGES, &mddev->bio_set);
-
-	bio_set_dev(read_bio, rdev->bdev);
+	read_bio = bio_alloc_bioset(rdev->bdev, RESYNC_PAGES, REQ_OP_READ,
+				    GFP_KERNEL, &mddev->bio_set);
 	read_bio->bi_iter.bi_sector = (r10_bio->devs[r10_bio->read_slot].addr
 			       + rdev->data_offset);
 	read_bio->bi_private = r10_bio;
 	read_bio->bi_end_io = end_reshape_read;
-	bio_set_op_attrs(read_bio, REQ_OP_READ, 0);
 	r10_bio->master_bio = read_bio;
 	r10_bio->read_slot = r10_bio->devs[r10_bio->read_slot].devnum;
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0b5dcaabbc155..66313adf99875 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -735,10 +735,9 @@ static void r5l_submit_current_io(struct r5l_log *log)
 
 static struct bio *r5l_bio_alloc(struct r5l_log *log)
 {
-	struct bio *bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_VECS, &log->bs);
+	struct bio *bio = bio_alloc_bioset(log->rdev->bdev, BIO_MAX_VECS,
+					   REQ_OP_WRITE, GFP_NOIO, &log->bs);
 
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
-	bio_set_dev(bio, log->rdev->bdev);
 	bio->bi_iter.bi_sector = log->rdev->data_offset + log->log_start;
 
 	return bio;
@@ -1634,7 +1633,8 @@ static int r5l_recovery_allocate_ra_pool(struct r5l_log *log,
 {
 	struct page *page;
 
-	ctx->ra_bio = bio_alloc_bioset(GFP_KERNEL, BIO_MAX_VECS, &log->bs);
+	ctx->ra_bio = bio_alloc_bioset(NULL, BIO_MAX_VECS, 0, GFP_KERNEL,
+				       &log->bs);
 	if (!ctx->ra_bio)
 		return -ENOMEM;
 
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index 4ab417915d7f1..054d3bb252d48 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -496,11 +496,10 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 		if (!bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0)) {
 			struct bio *prev = bio;
 
-			bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_VECS,
+			bio = bio_alloc_bioset(prev->bi_bdev, BIO_MAX_VECS,
+					       prev->bi_opf, GFP_NOIO,
 					       &ppl_conf->bs);
-			bio->bi_opf = prev->bi_opf;
 			bio->bi_write_hint = prev->bi_write_hint;
-			bio_copy_dev(bio, prev);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
 			bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0);
 
@@ -637,10 +636,10 @@ static void ppl_do_flush(struct ppl_io_unit *io)
 			struct bio *bio;
 			char b[BDEVNAME_SIZE];
 
-			bio = bio_alloc_bioset(GFP_NOIO, 0, &ppl_conf->flush_bs);
-			bio_set_dev(bio, bdev);
+			bio = bio_alloc_bioset(bdev, 0, GFP_NOIO,
+					       REQ_OP_WRITE | REQ_PREFLUSH,
+					       &ppl_conf->flush_bs);
 			bio->bi_private = io;
-			bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 			bio->bi_end_io = ppl_flush_endio;
 
 			pr_debug("%s: dev: %s\n", __func__,
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index bf8ae4825a06e..f7c6e822f345a 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -353,18 +353,16 @@ static struct bio *iblock_get_bio(struct se_cmd *cmd, sector_t lba, u32 sg_num,
 	 * Only allocate as many vector entries as the bio code allows us to,
 	 * we'll loop later on until we have handled the whole request.
 	 */
-	bio = bio_alloc_bioset(GFP_NOIO, bio_max_segs(sg_num),
-				&ib_dev->ibd_bio_set);
+	bio = bio_alloc_bioset(ib_dev->ibd_bd, bio_max_segs(sg_num), opf,
+			       GFP_NOIO, &ib_dev->ibd_bio_set);
 	if (!bio) {
 		pr_err("Unable to allocate memory for bio\n");
 		return NULL;
 	}
 
-	bio_set_dev(bio, ib_dev->ibd_bd);
 	bio->bi_private = cmd;
 	bio->bi_end_io = &iblock_bio_done;
 	bio->bi_iter.bi_sector = lba;
-	bio->bi_opf = opf;
 
 	return bio;
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d6d48ecf823c9..f982687c5b00d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3144,7 +3144,7 @@ struct bio *btrfs_bio_alloc(unsigned int nr_iovecs)
 	struct bio *bio;
 
 	ASSERT(0 < nr_iovecs && nr_iovecs <= BIO_MAX_VECS);
-	bio = bio_alloc_bioset(GFP_NOFS, nr_iovecs, &btrfs_bioset);
+	bio = bio_alloc_bioset(NULL, nr_iovecs, 0, GFP_NOFS, &btrfs_bioset);
 	btrfs_bio_init(btrfs_bio(bio));
 	return bio;
 }
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aacf5e4dcc576..5cb07ca7c4f52 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -394,7 +394,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	struct f2fs_sb_info *sbi = fio->sbi;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOIO, npages, &f2fs_bioset);
+	bio = bio_alloc_bioset(NULL, npages, 0, GFP_NOIO, &f2fs_bioset);
 
 	f2fs_target_device(sbi, fio->new_blkaddr, bio);
 	if (is_read_io(fio->op)) {
@@ -985,8 +985,8 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 	struct bio_post_read_ctx *ctx = NULL;
 	unsigned int post_read_steps = 0;
 
-	bio = bio_alloc_bioset(for_write ? GFP_NOIO : GFP_KERNEL,
-			       bio_max_segs(nr_pages), &f2fs_bioset);
+	bio = bio_alloc_bioset(NULL, bio_max_segs(nr_pages), REQ_OP_READ,
+			       for_write ? GFP_NOIO : GFP_KERNEL, &f2fs_bioset);
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
@@ -994,7 +994,6 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
 
 	f2fs_target_device(sbi, blkaddr, bio);
 	bio->bi_end_io = f2fs_read_end_io;
-	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
 	if (fscrypt_inode_uses_fs_layer_crypto(inode))
 		post_read_steps |= STEP_DECRYPT;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c938bbad075e1..340d373cb1bf9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1196,10 +1196,10 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
-	bio_set_dev(bio, wpc->iomap.bdev);
+	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
+			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
 	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index edeae54074ede..2f63ae9a71e1a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -405,8 +405,9 @@ extern void bioset_exit(struct bio_set *);
 extern int biovec_init_pool(mempool_t *pool, int pool_entries);
 extern int bioset_init_from_src(struct bio_set *bs, struct bio_set *src);
 
-struct bio *bio_alloc_bioset(gfp_t gfp, unsigned short nr_iovecs,
-		struct bio_set *bs);
+struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
+			     unsigned int opf, gfp_t gfp_mask,
+			     struct bio_set *bs);
 struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
 		struct bio_set *bs);
 struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned short nr_iovecs);
@@ -419,7 +420,7 @@ extern struct bio_set fs_bio_set;
 
 static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned short nr_iovecs)
 {
-	return bio_alloc_bioset(gfp_mask, nr_iovecs, &fs_bio_set);
+	return bio_alloc_bioset(NULL, nr_iovecs, 0, gfp_mask, &fs_bio_set);
 }
 
 void submit_bio(struct bio *bio);
-- 
2.30.2

