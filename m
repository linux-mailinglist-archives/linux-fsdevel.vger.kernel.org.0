Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABFF3370C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 12:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhCKLCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 06:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhCKLCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 06:02:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC6C061574;
        Thu, 11 Mar 2021 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bXu4ullxxriRwZQTRZva1z8RpPpLh8M8zqDMx8058UY=; b=Woefge1ojD22GbUNPBRIjloR1H
        M6aPEpFW8RR5BLuJK66bUU25BPri6oRYsOA7gZ08zsrcz8zH1FRDADm8fUmLY5ieI90qRi6wmVLHw
        Vxnc2BK5yM3Hsgsqbx8M4DKrb21XhyKf+I8fY+4cijojnTW+n5agj4a52E7wj/oEjqxuLNJA6WdZG
        1VJzR7SNkTOHK1xO/FzybhYo251cjRIMYUq3GawqeEAX78DMznKTvwj6oaZnEg92YzH/Z3jfoC65T
        /uBNqKCWdBmwqpu+gjTf3IbVzeiucwVXf5uwhoGgrIl1s2q1KlrKWn/1oUfjLq9dhLpVRPlr2B+ix
        QPn4PMuA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKJ4r-007Dlq-Nd; Thu, 11 Mar 2021 11:02:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] block: rename BIO_MAX_PAGES to BIO_MAX_VECS
Date:   Thu, 11 Mar 2021 12:01:37 +0100
Message-Id: <20210311110137.1132391-2-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311110137.1132391-1-hch@lst.de>
References: <20210311110137.1132391-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ever since the addition of multipage bio_vecs BIO_MAX_PAGES has been
horribly confusingly misnamed.  Rename it to BIO_MAX_VECS to stop
confusing users of the bio API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                    | 14 +++++++-------
 block/blk-crypto-fallback.c    |  2 +-
 block/blk-lib.c                |  2 +-
 block/blk-map.c                |  2 +-
 block/bounce.c                 |  6 +++---
 drivers/block/drbd/drbd_int.h  |  2 +-
 drivers/md/bcache/super.c      |  2 +-
 drivers/md/dm-crypt.c          |  8 ++++----
 drivers/md/dm-writecache.c     |  4 ++--
 drivers/md/raid5-cache.c       |  4 ++--
 drivers/md/raid5-ppl.c         |  2 +-
 drivers/nvme/target/passthru.c |  6 +++---
 fs/block_dev.c                 |  6 +++---
 fs/btrfs/extent_io.c           |  2 +-
 fs/btrfs/scrub.c               |  2 +-
 fs/crypto/bio.c                |  6 +++---
 fs/erofs/zdata.c               |  2 +-
 fs/ext4/page-io.c              |  2 +-
 fs/f2fs/checkpoint.c           |  2 +-
 fs/f2fs/data.c                 |  4 ++--
 fs/f2fs/segment.c              |  2 +-
 fs/f2fs/segment.h              |  4 ++--
 fs/f2fs/super.c                |  4 ++--
 fs/gfs2/lops.c                 |  2 +-
 fs/iomap/buffered-io.c         |  4 ++--
 fs/iomap/direct-io.c           |  4 ++--
 fs/mpage.c                     |  2 +-
 fs/nilfs2/segbuf.c             |  2 +-
 fs/squashfs/block.c            |  2 +-
 fs/zonefs/super.c              |  2 +-
 include/linux/bio.h            |  4 ++--
 31 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a83..26b7f721cda88b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -33,7 +33,7 @@ static struct biovec_slab {
 	{ .nr_vecs = 16, .name = "biovec-16" },
 	{ .nr_vecs = 64, .name = "biovec-64" },
 	{ .nr_vecs = 128, .name = "biovec-128" },
-	{ .nr_vecs = BIO_MAX_PAGES, .name = "biovec-max" },
+	{ .nr_vecs = BIO_MAX_VECS, .name = "biovec-max" },
 };
 
 static struct biovec_slab *biovec_slab(unsigned short nr_vecs)
@@ -46,7 +46,7 @@ static struct biovec_slab *biovec_slab(unsigned short nr_vecs)
 		return &bvec_slabs[1];
 	case 65 ... 128:
 		return &bvec_slabs[2];
-	case 129 ... BIO_MAX_PAGES:
+	case 129 ... BIO_MAX_VECS:
 		return &bvec_slabs[3];
 	default:
 		BUG();
@@ -151,9 +151,9 @@ static void bio_put_slab(struct bio_set *bs)
 
 void bvec_free(mempool_t *pool, struct bio_vec *bv, unsigned short nr_vecs)
 {
-	BIO_BUG_ON(nr_vecs > BIO_MAX_PAGES);
+	BIO_BUG_ON(nr_vecs > BIO_MAX_VECS);
 
-	if (nr_vecs == BIO_MAX_PAGES)
+	if (nr_vecs == BIO_MAX_VECS)
 		mempool_free(bv, pool);
 	else if (nr_vecs > BIO_INLINE_VECS)
 		kmem_cache_free(biovec_slab(nr_vecs)->slab, bv);
@@ -186,15 +186,15 @@ struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,
 	/*
 	 * Try a slab allocation first for all smaller allocations.  If that
 	 * fails and __GFP_DIRECT_RECLAIM is set retry with the mempool.
-	 * The mempool is sized to handle up to BIO_MAX_PAGES entries.
+	 * The mempool is sized to handle up to BIO_MAX_VECS entries.
 	 */
-	if (*nr_vecs < BIO_MAX_PAGES) {
+	if (*nr_vecs < BIO_MAX_VECS) {
 		struct bio_vec *bvl;
 
 		bvl = kmem_cache_alloc(bvs->slab, bvec_alloc_gfp(gfp_mask));
 		if (likely(bvl) || !(gfp_mask & __GFP_DIRECT_RECLAIM))
 			return bvl;
-		*nr_vecs = BIO_MAX_PAGES;
+		*nr_vecs = BIO_MAX_VECS;
 	}
 
 	return mempool_alloc(pool, gfp_mask);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c176b7af56a7a5..c322176a1e0995 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -219,7 +219,7 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 
 	bio_for_each_segment(bv, bio, iter) {
 		num_sectors += bv.bv_len >> SECTOR_SHIFT;
-		if (++i == BIO_MAX_PAGES)
+		if (++i == BIO_MAX_VECS)
 			break;
 	}
 	if (num_sectors < bio_sectors(bio)) {
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c7220622a..7b256131b20bbb 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -296,7 +296,7 @@ static unsigned int __blkdev_sectors_to_bio_pages(sector_t nr_sects)
 {
 	sector_t pages = DIV_ROUND_UP_SECTOR_T(nr_sects, PAGE_SIZE / 512);
 
-	return min(pages, (sector_t)BIO_MAX_PAGES);
+	return min(pages, (sector_t)BIO_MAX_VECS);
 }
 
 static int __blkdev_issue_zero_pages(struct block_device *bdev,
diff --git a/block/blk-map.c b/block/blk-map.c
index 369e204d14d013..1ffef782fcf2dd 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -249,7 +249,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return -EINVAL;
 
-	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_PAGES));
+	bio = bio_kmalloc(gfp_mask, iov_iter_npages(iter, BIO_MAX_VECS));
 	if (!bio)
 		return -ENOMEM;
 	bio->bi_opf |= req_op(rq);
diff --git a/block/bounce.c b/block/bounce.c
index 87983a35079c22..6c441f4f1cd4aa 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -229,10 +229,10 @@ static struct bio *bounce_clone_bio(struct bio *bio_src)
 	 *  - The point of cloning the biovec is to produce a bio with a biovec
 	 *    the caller can modify: bi_idx and bi_bvec_done should be 0.
 	 *
-	 *  - The original bio could've had more than BIO_MAX_PAGES biovecs; if
+	 *  - The original bio could've had more than BIO_MAX_VECS biovecs; if
 	 *    we tried to clone the whole thing bio_alloc_bioset() would fail.
 	 *    But the clone should succeed as long as the number of biovecs we
-	 *    actually need to allocate is fewer than BIO_MAX_PAGES.
+	 *    actually need to allocate is fewer than BIO_MAX_VECS.
 	 *
 	 *  - Lastly, bi_vcnt should not be looked at or relied upon by code
 	 *    that does not own the bio - reason being drivers don't use it for
@@ -299,7 +299,7 @@ static void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig,
 	int sectors = 0;
 
 	bio_for_each_segment(from, *bio_orig, iter) {
-		if (i++ < BIO_MAX_PAGES)
+		if (i++ < BIO_MAX_VECS)
 			sectors += from.bv_len >> 9;
 		if (page_to_pfn(from.bv_page) > q->limits.bounce_pfn)
 			bounce = true;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 7d9cc433b758ae..5d9181382ce190 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1324,7 +1324,7 @@ struct bm_extent {
  * A followup commit may allow even bigger BIO sizes,
  * once we thought that through. */
 #define DRBD_MAX_BIO_SIZE (1U << 20)
-#if DRBD_MAX_BIO_SIZE > (BIO_MAX_PAGES << PAGE_SHIFT)
+#if DRBD_MAX_BIO_SIZE > (BIO_MAX_VECS << PAGE_SHIFT)
 #error Architecture not supported: DRBD_MAX_BIO_SIZE > BIO_MAX_SIZE
 #endif
 #define DRBD_MAX_BIO_SIZE_SAFE (1U << 12)       /* Works always = 4k */
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 71691f32959b38..03e1fe4de53dea 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -965,7 +965,7 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	q->limits.max_hw_sectors	= UINT_MAX;
 	q->limits.max_sectors		= UINT_MAX;
 	q->limits.max_segment_size	= UINT_MAX;
-	q->limits.max_segments		= BIO_MAX_PAGES;
+	q->limits.max_segments		= BIO_MAX_VECS;
 	blk_queue_max_discard_sectors(q, UINT_MAX);
 	q->limits.discard_granularity	= 512;
 	q->limits.io_min		= block_size;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 11c105ecd165a0..b0ab080f256769 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -229,7 +229,7 @@ static DEFINE_SPINLOCK(dm_crypt_clients_lock);
 static unsigned dm_crypt_clients_n = 0;
 static volatile unsigned long dm_crypt_pages_per_client;
 #define DM_CRYPT_MEMORY_PERCENT			2
-#define DM_CRYPT_MIN_PAGES_PER_CLIENT		(BIO_MAX_PAGES * 16)
+#define DM_CRYPT_MIN_PAGES_PER_CLIENT		(BIO_MAX_VECS * 16)
 
 static void clone_init(struct dm_crypt_io *, struct bio *);
 static void kcryptd_queue_crypt(struct dm_crypt_io *io);
@@ -3246,7 +3246,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		ALIGN(sizeof(struct dm_crypt_io) + cc->dmreq_start + additional_req_size,
 		      ARCH_KMALLOC_MINALIGN);
 
-	ret = mempool_init(&cc->page_pool, BIO_MAX_PAGES, crypt_page_alloc, crypt_page_free, cc);
+	ret = mempool_init(&cc->page_pool, BIO_MAX_VECS, crypt_page_alloc, crypt_page_free, cc);
 	if (ret) {
 		ti->error = "Cannot allocate page mempool";
 		goto bad;
@@ -3373,9 +3373,9 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	/*
 	 * Check if bio is too large, split as needed.
 	 */
-	if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_PAGES << PAGE_SHIFT)) &&
+	if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
 	    (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
-		dm_accept_partial_bio(bio, ((BIO_MAX_PAGES << PAGE_SHIFT) >> SECTOR_SHIFT));
+		dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
 
 	/*
 	 * Ensure that bio is a multiple of internal sector encryption size
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 844c4be11768d3..4f72b6f66c3aeb 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -1892,10 +1892,10 @@ static void writecache_writeback(struct work_struct *work)
 			list_add(&g->lru, &wbl.list);
 			wbl.size++;
 			g->write_in_progress = true;
-			g->wc_list_contiguous = BIO_MAX_PAGES;
+			g->wc_list_contiguous = BIO_MAX_VECS;
 			f = g;
 			e->wc_list_contiguous++;
-			if (unlikely(e->wc_list_contiguous == BIO_MAX_PAGES)) {
+			if (unlikely(e->wc_list_contiguous == BIO_MAX_VECS)) {
 				if (unlikely(wc->writeback_all)) {
 					next_node = rb_next(&f->rb_node);
 					if (likely(next_node))
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 4337ae0e6af2e4..0b5dcaabbc1559 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -735,7 +735,7 @@ static void r5l_submit_current_io(struct r5l_log *log)
 
 static struct bio *r5l_bio_alloc(struct r5l_log *log)
 {
-	struct bio *bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_PAGES, &log->bs);
+	struct bio *bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_VECS, &log->bs);
 
 	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 	bio_set_dev(bio, log->rdev->bdev);
@@ -1634,7 +1634,7 @@ static int r5l_recovery_allocate_ra_pool(struct r5l_log *log,
 {
 	struct page *page;
 
-	ctx->ra_bio = bio_alloc_bioset(GFP_KERNEL, BIO_MAX_PAGES, &log->bs);
+	ctx->ra_bio = bio_alloc_bioset(GFP_KERNEL, BIO_MAX_VECS, &log->bs);
 	if (!ctx->ra_bio)
 		return -ENOMEM;
 
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index e8c118e05dfd46..3ddc2aa0b53064 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -496,7 +496,7 @@ static void ppl_submit_iounit(struct ppl_io_unit *io)
 		if (!bio_add_page(bio, sh->ppl_page, PAGE_SIZE, 0)) {
 			struct bio *prev = bio;
 
-			bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_PAGES,
+			bio = bio_alloc_bioset(GFP_NOIO, BIO_MAX_VECS,
 					       &ppl_conf->bs);
 			bio->bi_opf = prev->bi_opf;
 			bio->bi_write_hint = prev->bi_write_hint;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26c587ccd152c2..2798944899b736 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -50,9 +50,9 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 
 	/*
 	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
-	 * the mdts based on BIO_MAX_PAGES as well
+	 * the mdts based on BIO_MAX_VECS as well
 	 */
-	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << (PAGE_SHIFT - 9),
+	max_hw_sectors = min_not_zero(BIO_MAX_VECS << (PAGE_SHIFT - 9),
 				      max_hw_sectors);
 
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
@@ -191,7 +191,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	struct bio *bio;
 	int i;
 
-	if (req->sg_cnt > BIO_MAX_PAGES)
+	if (req->sg_cnt > BIO_MAX_VECS)
 		return -EINVAL;
 
 	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 03166b3dea4db2..92ed7d5df67744 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -432,7 +432,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_PAGES);
+		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
 		if (!nr_pages) {
 			bool polled = false;
 
@@ -500,8 +500,8 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (!iov_iter_count(iter))
 		return 0;
 
-	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_PAGES + 1);
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
+	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
+	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dfb3ead117572..db8cb98c020c75 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3048,7 +3048,7 @@ struct bio *btrfs_bio_alloc(u64 first_byte)
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &btrfs_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &btrfs_bioset);
 	bio->bi_iter.bi_sector = first_byte >> 9;
 	btrfs_io_bio_init(btrfs_io_bio(bio));
 	return bio;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 582df11d298af7..6daa4309c974d4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1428,7 +1428,7 @@ static void scrub_recheck_block_on_raid56(struct btrfs_fs_info *fs_info,
 	if (!first_page->dev->bdev)
 		goto out;
 
-	bio = btrfs_io_bio_alloc(BIO_MAX_PAGES);
+	bio = btrfs_io_bio_alloc(BIO_MAX_VECS);
 	bio_set_dev(bio, first_page->dev->bdev);
 
 	for (page_num = 0; page_num < sblock->page_count; page_num++) {
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index b048a0e3851629..68a2de6b5a9b13 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -52,7 +52,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 	int num_pages = 0;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
+	bio = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
 
 	while (len) {
 		unsigned int blocks_this_page = min(len, blocks_per_page);
@@ -74,7 +74,7 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 		len -= blocks_this_page;
 		lblk += blocks_this_page;
 		pblk += blocks_this_page;
-		if (num_pages == BIO_MAX_PAGES || !len ||
+		if (num_pages == BIO_MAX_VECS || !len ||
 		    !fscrypt_mergeable_bio(bio, inode, lblk)) {
 			err = submit_bio_wait(bio);
 			if (err)
@@ -126,7 +126,7 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return fscrypt_zeroout_range_inline_crypt(inode, lblk, pblk,
 							  len);
 
-	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_PAGES);
+	BUILD_BUG_ON(ARRAY_SIZE(pages) > BIO_MAX_VECS);
 	nr_pages = min_t(unsigned int, ARRAY_SIZE(pages),
 			 (len + blocks_per_page - 1) >> blocks_per_page_bits);
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b26..3851e1a64f730d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1235,7 +1235,7 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+				bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
 
 				bio->bi_end_io = z_erofs_decompressqueue_endio;
 				bio_set_dev(bio, sb->s_bdev);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 03a44a0de86add..f038d578d8d8ff 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -398,7 +398,7 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+	bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio_set_dev(bio, bh->b_bdev);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 174a0819ad967e..be5415a0dbbc6d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -292,7 +292,7 @@ void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
 	f2fs_put_page(page, 0);
 
 	if (readahead)
-		f2fs_ra_meta_pages(sbi, index, BIO_MAX_PAGES, META_POR, true);
+		f2fs_ra_meta_pages(sbi, index, BIO_MAX_VECS, META_POR, true);
 }
 
 static int __f2fs_write_meta_page(struct page *page,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7c95818639a630..4e5257c763d014 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -857,7 +857,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
-		bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		bio = __bio_alloc(fio, BIO_MAX_VECS);
 		__attach_io_flag(fio);
 		f2fs_set_bio_crypt_ctx(bio, fio->page->mapping->host,
 				       fio->page->index, fio, GFP_NOIO);
@@ -932,7 +932,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 			fio->retry = true;
 			goto skip;
 		}
-		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
+		io->bio = __bio_alloc(fio, BIO_MAX_VECS);
 		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
 				       bio_page->index, fio, GFP_NOIO);
 		io->fio = *fio;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 993004f06a772e..c2866561263e96 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4381,7 +4381,7 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	block_t total_node_blocks = 0;
 
 	do {
-		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
+		readed = f2fs_ra_meta_pages(sbi, start_blk, BIO_MAX_VECS,
 							META_SIT, true);
 
 		start = start_blk * sit_i->sents_per_block;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 229814b4f4a6cc..e9a7a637d68877 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -851,7 +851,7 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 	else if (type == NODE)
 		return 8 * sbi->blocks_per_seg;
 	else if (type == META)
-		return 8 * BIO_MAX_PAGES;
+		return 8 * BIO_MAX_VECS;
 	else
 		return 0;
 }
@@ -868,7 +868,7 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
 		return 0;
 
 	nr_to_write = wbc->nr_to_write;
-	desired = BIO_MAX_PAGES;
+	desired = BIO_MAX_VECS;
 	if (type == NODE)
 		desired <<= 1;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7069793752f114..82592b19b4e025 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -753,9 +753,9 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		case Opt_io_size_bits:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
+			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_VECS)) {
 				f2fs_warn(sbi, "Not support %d, larger than %d",
-					  1 << arg, BIO_MAX_PAGES);
+					  1 << arg, BIO_MAX_VECS);
 				return -EINVAL;
 			}
 			F2FS_OPTION(sbi).write_io_size_bits = arg;
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index dc1b93a877c6d3..a82f4747aa8d5e 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -267,7 +267,7 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 				      bio_end_io_t *end_io)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	struct bio *bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+	struct bio *bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
 
 	bio->bi_iter.bi_sector = blkno << sdp->sd_fsb2bb_shift;
 	bio_set_dev(bio, sb->s_bdev);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 7ffcd7ef33d4f5..414769a6ad113a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1221,7 +1221,7 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &iomap_ioend_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_VECS, &iomap_ioend_bioset);
 	bio_set_dev(bio, wpc->iomap.bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
@@ -1252,7 +1252,7 @@ iomap_chain_bio(struct bio *prev)
 {
 	struct bio *new;
 
-	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
+	new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
 	bio_copy_dev(new, prev);/* also copies over blkcg information */
 	new->bi_iter.bi_sector = bio_end_sector(prev);
 	new->bi_opf = prev->bi_opf;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index e2c4991833b8f9..bdd0d89bbf0a34 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -296,7 +296,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	 */
 	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
 
-	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_PAGES);
+	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
 		size_t n;
 		if (dio->error) {
@@ -338,7 +338,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter,
-						 BIO_MAX_PAGES);
+						 BIO_MAX_VECS);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
diff --git a/fs/mpage.c b/fs/mpage.c
index 961234d687792a..334e7d09aa6527 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -616,7 +616,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 				goto out;
 		}
 		bio = mpage_alloc(bdev, blocks[0] << (blkbits - 9),
-				BIO_MAX_PAGES, GFP_NOFS|__GFP_HIGH);
+				BIO_MAX_VECS, GFP_NOFS|__GFP_HIGH);
 		if (bio == NULL)
 			goto confused;
 
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 1e75417bfe6e52..56872e93823da0 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -399,7 +399,7 @@ static void nilfs_segbuf_prepare_write(struct nilfs_segment_buffer *segbuf,
 {
 	wi->bio = NULL;
 	wi->rest_blocks = segbuf->sb_sum.nblocks;
-	wi->max_pages = BIO_MAX_PAGES;
+	wi->max_pages = BIO_MAX_VECS;
 	wi->nr_vecs = min(wi->max_pages, wi->rest_blocks);
 	wi->start = wi->end = 0;
 	wi->blocknr = segbuf->sb_pseg_start;
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 45f44425d85601..b9e87ebb1060ee 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -87,7 +87,7 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	int error, i;
 	struct bio *bio;
 
-	if (page_count <= BIO_MAX_PAGES)
+	if (page_count <= BIO_MAX_VECS)
 		bio = bio_alloc(GFP_NOIO, page_count);
 	else
 		bio = bio_kmalloc(GFP_NOIO, page_count);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b6ff4a21abacc6..0fe76f376dee2e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -684,7 +684,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
-	nr_pages = iov_iter_npages(from, BIO_MAX_PAGES);
+	nr_pages = iov_iter_npages(from, BIO_MAX_VECS);
 	if (!nr_pages)
 		return 0;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 983ed2fe7c8504..d0246c92a6e865 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -20,11 +20,11 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_PAGES		256U
+#define BIO_MAX_VECS		256U
 
 static inline unsigned int bio_max_segs(unsigned int nr_segs)
 {
-	return min(nr_segs, BIO_MAX_PAGES);
+	return min(nr_segs, BIO_MAX_VECS);
 }
 
 #define bio_prio(bio)			(bio)->bi_ioprio
-- 
2.30.1

