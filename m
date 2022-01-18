Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDEA3492025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 08:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244974AbiARHVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 02:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240195AbiARHVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:21:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0762C06174E;
        Mon, 17 Jan 2022 23:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ToFav9PariBrHKkyOiW5b01dl7TKFglZQPKYUGLBuHk=; b=uiqQDDbtwkLviA5zBkbcQf7c0C
        8zMivXfoJx9O83epl8nkpTjyhK1C3QIjQbfg0lWoIe48kZHlzJipX6Xh9namDbhlyux9oDBcxzjJT
        txNZ+2IdLk7WA0PWTKofOvXzEpJSx/bMPyDaXP7NrKbn+XXdGiR8VAyiRilVnDCWIWHmjR7cvK1wa
        JQh+vBrgdsQ5Gc7Z+TnAk6ScNXfWqgr+d5g0332M11w/kKR3ko6pQAq/JElHyaSvrhqFyl4Ouxmlm
        4khXxsrsLBt5D5jytOPss9ccEVrVVcGo0TzQ34INNLC8E+8zHmM4+yJXhHjGRd33942k0+QrbP8hM
        knDH9/AA==;
Received: from [2001:4bb8:184:72a4:a4a9:19c0:5242:7768] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9inK-000ZjR-B3; Tue, 18 Jan 2022 07:20:43 +0000
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
Subject: [PATCH 17/19] block: pass a block_device and opf to bio_alloc
Date:   Tue, 18 Jan 2022 08:19:50 +0100
Message-Id: <20220118071952.1243143-18-hch@lst.de>
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
bio_alloc to optimize the assigment.  NULL/0 can be passed, both for the
passthrough case on a raw request_queue and to temporarily avoid
refactoring some nasty code.

Also move the gfp_mask argument after the nr_vecs argument for a much
more logical calling convention matching what most of the kernel does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c                         |  5 +----
 block/fops.c                        |  4 +---
 drivers/block/drbd/drbd_receiver.c  | 10 ++++------
 drivers/block/rnbd/rnbd-srv.c       |  5 ++---
 drivers/block/xen-blkback/blkback.c | 11 +++++------
 drivers/block/zram/zram_drv.c       | 11 ++++-------
 drivers/md/dm-log-writes.c          | 21 ++++++++-------------
 drivers/md/dm-thin.c                |  9 ++++-----
 drivers/md/dm-zoned-metadata.c      | 15 ++++++---------
 drivers/nvdimm/nd_virtio.c          |  6 +++---
 drivers/nvme/target/io-cmd-bdev.c   | 12 ++++++------
 drivers/nvme/target/passthru.c      |  5 +++--
 drivers/nvme/target/zns.c           |  6 +++---
 drivers/scsi/ufs/ufshpb.c           |  4 ++--
 drivers/target/target_core_iblock.c |  5 ++---
 fs/btrfs/disk-io.c                  |  6 +++---
 fs/buffer.c                         | 14 ++++++--------
 fs/crypto/bio.c                     | 13 +++++++------
 fs/direct-io.c                      |  5 +----
 fs/erofs/zdata.c                    |  5 ++---
 fs/ext4/page-io.c                   |  3 +--
 fs/ext4/readpage.c                  |  8 ++++----
 fs/gfs2/lops.c                      |  8 +++-----
 fs/gfs2/meta_io.c                   |  4 +---
 fs/gfs2/ops_fstype.c                |  4 +---
 fs/hfsplus/wrapper.c                |  4 +---
 fs/iomap/buffered-io.c              | 16 ++++++++--------
 fs/iomap/direct-io.c                |  8 ++------
 fs/jfs/jfs_logmgr.c                 | 11 ++---------
 fs/jfs/jfs_metapage.c               |  9 +++------
 fs/mpage.c                          |  7 +++----
 fs/nfs/blocklayout/blocklayout.c    |  4 +---
 fs/nilfs2/segbuf.c                  |  4 ++--
 fs/ntfs3/fsntfs.c                   |  8 ++------
 fs/ocfs2/cluster/heartbeat.c        |  4 +---
 fs/squashfs/block.c                 | 11 ++++++-----
 fs/xfs/xfs_bio_io.c                 | 10 ++++------
 fs/xfs/xfs_buf.c                    |  4 +---
 fs/zonefs/super.c                   |  5 ++---
 include/linux/bio.h                 |  5 +++--
 kernel/power/swap.c                 |  5 ++---
 mm/page_io.c                        | 10 ++++------
 42 files changed, 130 insertions(+), 194 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8853ed6260cfd..5c97f56c1ee50 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -347,10 +347,7 @@ EXPORT_SYMBOL(bio_chain);
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, unsigned int opf, gfp_t gfp)
 {
-	struct bio *new = bio_alloc(gfp, nr_pages);
-
-	bio_set_dev(new, bdev);
-	new->bi_opf = opf;
+	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
 
 	if (bio) {
 		bio_chain(bio, new);
diff --git a/block/fops.c b/block/fops.c
index 3a62b8b912750..c683596847731 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -256,9 +256,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		atomic_inc(&dio->ref);
 		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
-		bio_set_dev(bio, bdev);
-		bio->bi_opf = opf;
+		bio = bio_alloc(bdev, nr_pages, opf, GFP_KERNEL);
 	}
 
 	blk_finish_plug(&plug);
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 90402abb77e93..6f589ed9fa0c5 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1279,7 +1279,8 @@ static void one_flush_endio(struct bio *bio)
 
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
-	struct bio *bio = bio_alloc(GFP_NOIO, 0);
+	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
+				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
 
 	if (!octx) {
@@ -1297,10 +1298,8 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 
 	octx->device = device;
 	octx->ctx = ctx;
-	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
@@ -1686,11 +1685,10 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * generated bio, but a bio allocated on behalf of the peer.
 	 */
 next_bio:
-	bio = bio_alloc(GFP_NOIO, nr_pages);
+	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, op | op_flags,
+			GFP_NOIO);
 	/* > peer_req->i.sector, unless this is the first bio */
 	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, device->ldev->backing_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
 	bio->bi_private = peer_req;
 	bio->bi_end_io = drbd_peer_request_endio;
 
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index b1ac1414b56d5..021532ab9dc30 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -149,7 +149,8 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(GFP_KERNEL, 1);
+	bio = bio_alloc(sess_dev->rnbd_dev->bdev, 1,
+			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data))) {
 		rnbd_srv_err(sess_dev, "Failed to map data to bio\n");
@@ -159,13 +160,11 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 
 	bio->bi_end_io = rnbd_dev_bi_end_io;
 	bio->bi_private = priv;
-	bio->bi_opf = rnbd_to_bio_flags(le32_to_cpu(msg->rw));
 	bio->bi_iter.bi_sector = le64_to_cpu(msg->sector);
 	bio->bi_iter.bi_size = le32_to_cpu(msg->bi_size);
 	prio = srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
 	       usrlen < sizeof(*msg) ? 0 : le16_to_cpu(msg->prio);
 	bio_set_prio(bio, prio);
-	bio_set_dev(bio, sess_dev->rnbd_dev->bdev);
 
 	submit_bio(bio);
 
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 6bb2ad7692065..d1e26461a64ed 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1326,13 +1326,13 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 				     pages[i]->page,
 				     seg[i].nsec << 9,
 				     seg[i].offset) == 0)) {
-			bio = bio_alloc(GFP_KERNEL, bio_max_segs(nseg - i));
+			bio = bio_alloc(preq.bdev, bio_max_segs(nseg - i),
+					operation | operation_flags,
+					GFP_KERNEL);
 			biolist[nbio++] = bio;
-			bio_set_dev(bio, preq.bdev);
 			bio->bi_private = pending_req;
 			bio->bi_end_io  = end_block_io_op;
 			bio->bi_iter.bi_sector  = preq.sector_number;
-			bio_set_op_attrs(bio, operation, operation_flags);
 		}
 
 		preq.sector_number += seg[i].nsec;
@@ -1342,12 +1342,11 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	if (!bio) {
 		BUG_ON(operation_flags != REQ_PREFLUSH);
 
-		bio = bio_alloc(GFP_KERNEL, 0);
+		bio = bio_alloc(preq.bdev, 0, operation | operation_flags,
+				GFP_KERNEL);
 		biolist[nbio++] = bio;
-		bio_set_dev(bio, preq.bdev);
 		bio->bi_private = pending_req;
 		bio->bi_end_io  = end_block_io_op;
-		bio_set_op_attrs(bio, operation, operation_flags);
 	}
 
 	atomic_set(&pending_req->pendcnt, nbio);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d72b9..d8dc7ed1c78fc 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -617,24 +617,21 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(zram->bdev, 1, parent ? parent->bi_opf : REQ_OP_READ,
+			GFP_NOIO);
 	if (!bio)
 		return -ENOMEM;
 
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	bio_set_dev(bio, zram->bdev);
 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len, bvec->bv_offset)) {
 		bio_put(bio);
 		return -EIO;
 	}
 
-	if (!parent) {
-		bio->bi_opf = REQ_OP_READ;
+	if (!parent)
 		bio->bi_end_io = zram_page_end_io;
-	} else {
-		bio->bi_opf = parent->bi_opf;
+	else
 		bio_chain(bio, parent);
-	}
 
 	submit_bio(bio);
 	return 1;
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index 25f5e8d2d417b..c9d036d6bb2ee 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -217,14 +217,12 @@ static int write_metadata(struct log_writes_c *lc, void *entry,
 	void *ptr;
 	size_t ret;
 
-	bio = bio_alloc(GFP_KERNEL, 1);
+	bio = bio_alloc(lc->logdev->bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
 	bio->bi_iter.bi_size = 0;
 	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = (sector == WRITE_LOG_SUPER_SECTOR) ?
 			  log_end_super : log_end_io;
 	bio->bi_private = lc;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page) {
@@ -271,13 +269,12 @@ static int write_inline_data(struct log_writes_c *lc, void *entry,
 
 		atomic_inc(&lc->io_blocks);
 
-		bio = bio_alloc(GFP_KERNEL, bio_pages);
+		bio = bio_alloc(lc->logdev->bdev, bio_pages, REQ_OP_WRITE,
+				GFP_KERNEL);
 		bio->bi_iter.bi_size = 0;
 		bio->bi_iter.bi_sector = sector;
-		bio_set_dev(bio, lc->logdev->bdev);
 		bio->bi_end_io = log_end_io;
 		bio->bi_private = lc;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		for (i = 0; i < bio_pages; i++) {
 			pg_datalen = min_t(int, datalen, PAGE_SIZE);
@@ -353,13 +350,12 @@ static int log_one_block(struct log_writes_c *lc,
 		goto out;
 
 	atomic_inc(&lc->io_blocks);
-	bio = bio_alloc(GFP_KERNEL, bio_max_segs(block->vec_cnt));
+	bio = bio_alloc(lc->logdev->bdev, bio_max_segs(block->vec_cnt),
+			REQ_OP_WRITE, GFP_KERNEL);
 	bio->bi_iter.bi_size = 0;
 	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, lc->logdev->bdev);
 	bio->bi_end_io = log_end_io;
 	bio->bi_private = lc;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 	for (i = 0; i < block->vec_cnt; i++) {
 		/*
@@ -371,14 +367,13 @@ static int log_one_block(struct log_writes_c *lc,
 		if (ret != block->vecs[i].bv_len) {
 			atomic_inc(&lc->io_blocks);
 			submit_bio(bio);
-			bio = bio_alloc(GFP_KERNEL,
-					bio_max_segs(block->vec_cnt - i));
+			bio = bio_alloc(lc->logdev->bdev,
+					bio_max_segs(block->vec_cnt - i),
+					REQ_OP_WRITE, GFP_KERNEL);
 			bio->bi_iter.bi_size = 0;
 			bio->bi_iter.bi_sector = sector;
-			bio_set_dev(bio, lc->logdev->bdev);
 			bio->bi_end_io = log_end_io;
 			bio->bi_private = lc;
-			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 			ret = bio_add_page(bio, block->vecs[i].bv_page,
 					   block->vecs[i].bv_len, 0);
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 411a3f56ed90c..f4234d615aa1b 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1177,13 +1177,12 @@ static void process_prepared_discard_passdown_pt1(struct dm_thin_new_mapping *m)
 		return;
 	}
 
-	discard_parent = bio_alloc(GFP_NOIO, 1);
+	discard_parent = bio_alloc(NULL, 1, 0, GFP_NOIO);
 	discard_parent->bi_end_io = passdown_endio;
 	discard_parent->bi_private = m;
-
-	if (m->maybe_shared)
-		passdown_double_checking_shared_status(m, discard_parent);
-	else {
+ 	if (m->maybe_shared)
+ 		passdown_double_checking_shared_status(m, discard_parent);
+ 	else {
 		struct discard_op op;
 
 		begin_discard(&op, tc, discard_parent);
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 5718b83cc7182..e5f1eb27ce2e9 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -550,7 +550,8 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 	if (!mblk)
 		return ERR_PTR(-ENOMEM);
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(dev->bdev, 1, REQ_OP_READ | REQ_META | REQ_PRIO,
+			GFP_NOIO);
 
 	spin_lock(&zmd->mblk_lock);
 
@@ -574,10 +575,8 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
 
 	/* Submit read BIO */
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
@@ -721,15 +720,14 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	if (dmz_bdev_is_dying(dev))
 		return -EIO;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(dev->bdev, 1, REQ_OP_WRITE | REQ_META | REQ_PRIO,
+			GFP_NOIO);
 
 	set_bit(DMZ_META_WRITING, &mblk->state);
 
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
@@ -751,10 +749,9 @@ static int dmz_rdwr_block(struct dmz_dev *dev, int op,
 	if (dmz_bdev_is_dying(dev))
 		return -EIO;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(dev->bdev, 1, op | REQ_SYNC | REQ_META | REQ_PRIO,
+			GFP_NOIO);
 	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
-	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
 	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
 	ret = submit_bio_wait(bio);
 	bio_put(bio);
diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 10351d5b49fac..c6a648fd8744a 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -105,12 +105,12 @@ int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
 	 * parent bio. Otherwise directly call nd_region flush.
 	 */
 	if (bio && bio->bi_iter.bi_sector != -1) {
-		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
+		struct bio *child = bio_alloc(bio->bi_bdev, 0, REQ_PREFLUSH,
+					      GFP_ATOMIC);
 
 		if (!child)
 			return -ENOMEM;
-		bio_copy_dev(child, bio);
-		child->bi_opf = REQ_PREFLUSH;
+		bio_clone_blkg_association(child, bio);
 		child->bi_iter.bi_sector = -1;
 		bio_chain(child, bio);
 		submit_bio(child);
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 70ca9dfc1771a..e092af3abc710 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -268,14 +268,15 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->b.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+		bio_set_dev(bio, req->ns->bdev);
+		bio->bi_opf = op;
 	} else {
-		bio = bio_alloc(GFP_KERNEL, bio_max_segs(sg_cnt));
+		bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt), op,
+				GFP_KERNEL);
 	}
-	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
-	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
 	if (req->metadata_len)
@@ -296,10 +297,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 				}
 			}
 
-			bio = bio_alloc(GFP_KERNEL, bio_max_segs(sg_cnt));
-			bio_set_dev(bio, req->ns->bdev);
+			bio = bio_alloc(req->ns->bdev, bio_max_segs(sg_cnt),
+					op, GFP_KERNEL);
 			bio->bi_iter.bi_sector = sector;
-			bio->bi_opf = op;
 
 			bio_chain(bio, prev);
 			submit_bio(prev);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9e5b89ae29dfe..38f72968c3fde 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -207,11 +207,12 @@ static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->p.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+		bio->bi_opf = req_op(rq);
 	} else {
-		bio = bio_alloc(GFP_KERNEL, bio_max_segs(req->sg_cnt));
+		bio = bio_alloc(NULL, bio_max_segs(req->sg_cnt), req_op(rq),
+				GFP_KERNEL);
 		bio->bi_end_io = bio_put;
 	}
-	bio->bi_opf = req_op(rq);
 
 	for_each_sg(req->sg, sg, req->sg_cnt, i) {
 		if (bio_add_pc_page(rq->q, bio, sg_page(sg), sg->length,
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 247de74247fab..62c53e8f26d35 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -522,6 +522,7 @@ static void nvmet_bdev_zone_append_bio_done(struct bio *bio)
 void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 {
 	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
+	const unsigned int op = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	u16 status = NVME_SC_SUCCESS;
 	unsigned int total_len = 0;
 	struct scatterlist *sg;
@@ -552,13 +553,12 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	if (nvmet_use_inline_bvec(req)) {
 		bio = &req->z.inline_bio;
 		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));
+		bio->bi_opf = op;
 	} else {
-		bio = bio_alloc(GFP_KERNEL, req->sg_cnt);
+		bio = bio_alloc(req->ns->bdev, req->sg_cnt, op, GFP_KERNEL);
 	}
 
-	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	bio->bi_end_io = nvmet_bdev_zone_append_bio_done;
-	bio_set_dev(bio, req->ns->bdev);
 	bio->bi_iter.bi_sector = sect;
 	bio->bi_private = req;
 	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 2d36a0715fca6..8970068314ef2 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -494,7 +494,7 @@ static struct ufshpb_req *ufshpb_get_map_req(struct ufshpb_lu *hpb,
 	if (!map_req)
 		return NULL;
 
-	bio = bio_alloc(GFP_KERNEL, hpb->pages_per_srgn);
+	bio = bio_alloc(NULL, hpb->pages_per_srgn, 0, GFP_KERNEL);
 	if (!bio) {
 		ufshpb_put_req(hpb, map_req);
 		return NULL;
@@ -2050,7 +2050,7 @@ static int ufshpb_pre_req_mempool_init(struct ufshpb_lu *hpb)
 		INIT_LIST_HEAD(&pre_req->list_req);
 		pre_req->req = NULL;
 
-		pre_req->bio = bio_alloc(GFP_KERNEL, 1);
+		pre_req->bio = bio_alloc(NULL, 1, 0, GFP_KERNEL);
 		if (!pre_req->bio)
 			goto release_mem;
 
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index f7c6e822f345a..0907fa3cf2b43 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -416,10 +416,9 @@ iblock_execute_sync_cache(struct se_cmd *cmd)
 	if (immed)
 		target_complete_cmd(cmd, SAM_STAT_GOOD);
 
-	bio = bio_alloc(GFP_KERNEL, 0);
+	bio = bio_alloc(ib_dev->ibd_bd, 0, REQ_OP_WRITE | REQ_PREFLUSH,
+			GFP_KERNEL);
 	bio->bi_end_io = iblock_end_io_flush;
-	bio_set_dev(bio, ib_dev->ibd_bd);
-	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	if (!immed)
 		bio->bi_private = cmd;
 	submit_bio(bio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87a5addbedf6d..f45aa506f9a6f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4029,8 +4029,9 @@ static int write_dev_supers(struct btrfs_device *device,
 		 * to do I/O, so we don't lose the ability to do integrity
 		 * checking.
 		 */
-		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, device->bdev);
+		bio = bio_alloc(device->bdev, 1,
+				REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO,
+				GFP_NOFS);
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
@@ -4042,7 +4043,6 @@ static int write_dev_supers(struct btrfs_device *device,
 		 * go down lazy and there's a short window where the on-disk
 		 * copies might still contain the older version.
 		 */
-		bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO;
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			bio->bi_opf |= REQ_FUA;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 8e112b6bd3719..a17c386a142c7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3024,12 +3024,16 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
 		clear_buffer_write_io_error(bh);
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	if (buffer_meta(bh))
+		op_flags |= REQ_META;
+	if (buffer_prio(bh))
+		op_flags |= REQ_PRIO;
+
+	bio = bio_alloc(bh->b_bdev, 1, op | op_flags, GFP_NOIO);
 
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_write_hint = write_hint;
 
 	bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
@@ -3038,12 +3042,6 @@ static int submit_bh_wbc(int op, int op_flags, struct buffer_head *bh,
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
 
-	if (buffer_meta(bh))
-		op_flags |= REQ_META;
-	if (buffer_prio(bh))
-		op_flags |= REQ_PRIO;
-	bio_set_op_attrs(bio, op, op_flags);
-
 	/* Take care of bh's that straddle the end of the device */
 	guard_bio_eod(bio);
 
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index bfc2a5b74ed39..755e985a42e0b 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -54,7 +54,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 	int num_pages = 0;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
+	bio = bio_alloc(inode->i_sb->s_bdev, BIO_MAX_VECS, REQ_OP_WRITE,
+			GFP_NOFS);
 
 	while (len) {
 		unsigned int blocks_this_page = min(len, blocks_per_page);
@@ -62,10 +63,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 
 		if (num_pages == 0) {
 			fscrypt_set_bio_crypt_ctx(bio, inode, lblk, GFP_NOFS);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
 			bio->bi_iter.bi_sector =
 					pblk << (blockbits - SECTOR_SHIFT);
-			bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 		}
 		ret = bio_add_page(bio, ZERO_PAGE(0), bytes_this_page, 0);
 		if (WARN_ON(ret != bytes_this_page)) {
@@ -82,6 +81,8 @@ static int fscrypt_zeroout_range_inline_crypt(const struct inode *inode,
 			if (err)
 				goto out;
 			bio_reset(bio);
+			bio_set_dev(bio, inode->i_sb->s_bdev);
+			bio->bi_opf = REQ_OP_WRITE;
 			num_pages = 0;
 		}
 	}
@@ -150,12 +151,10 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return -EINVAL;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(GFP_NOFS, nr_pages);
+	bio = bio_alloc(inode->i_sb->s_bdev, nr_pages, REQ_OP_WRITE, GFP_NOFS);
 
 	do {
-		bio_set_dev(bio, inode->i_sb->s_bdev);
 		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		i = 0;
 		offset = 0;
@@ -183,6 +182,8 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		if (err)
 			goto out;
 		bio_reset(bio);
+		bio_set_dev(bio, inode->i_sb->s_bdev);
+		bio->bi_opf = REQ_OP_WRITE;
 	} while (len != 0);
 	err = 0;
 out:
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 6544435580470..38bca4980a1ca 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -396,11 +396,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
 	 * we request a valid number of vectors.
 	 */
-	bio = bio_alloc(GFP_KERNEL, nr_vecs);
-
-	bio_set_dev(bio, bdev);
+	bio = bio_alloc(bdev, nr_vecs, dio->op | dio->op_flags, GFP_KERNEL);
 	bio->bi_iter.bi_sector = first_sector;
-	bio_set_op_attrs(bio, dio->op, dio->op_flags);
 	if (dio->is_async)
 		bio->bi_end_io = dio_bio_end_aio;
 	else
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 498b7666efe85..db7de2dbac739 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1371,15 +1371,14 @@ static void z_erofs_submit_queue(struct super_block *sb,
 			}
 
 			if (!bio) {
-				bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
+				bio = bio_alloc(mdev.m_bdev, BIO_MAX_VECS,
+						REQ_OP_READ, GFP_NOIO);
 				bio->bi_end_io = z_erofs_decompressqueue_endio;
 
-				bio_set_dev(bio, mdev.m_bdev);
 				last_bdev = mdev.m_bdev;
 				bio->bi_iter.bi_sector = (sector_t)cur <<
 					LOG_SECTORS_PER_BLOCK;
 				bio->bi_private = bi_private;
-				bio->bi_opf = REQ_OP_READ;
 				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
 				++nr_bios;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 1d370364230e8..1253982268730 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -398,10 +398,9 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 * bio_alloc will _always_ be able to allocate a bio if
 	 * __GFP_DIRECT_RECLAIM is set, see comments for bio_alloc_bioset().
 	 */
-	bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
+	bio = bio_alloc(bh->b_bdev, BIO_MAX_VECS, 0, GFP_NOIO);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio_set_dev(bio, bh->b_bdev);
 	bio->bi_end_io = ext4_end_bio;
 	bio->bi_private = ext4_get_io_end(io->io_end);
 	io->io_bio = bio;
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 3db9234035053..812b1871d8900 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -371,15 +371,15 @@ int ext4_mpage_readpages(struct inode *inode,
 			 * bio_alloc will _always_ be able to allocate a bio if
 			 * __GFP_DIRECT_RECLAIM is set, see bio_alloc_bioset().
 			 */
-			bio = bio_alloc(GFP_KERNEL, bio_max_segs(nr_pages));
+			bio = bio_alloc(bdev, bio_max_segs(nr_pages),
+					REQ_OP_READ, GFP_KERNEL);
 			fscrypt_set_bio_crypt_ctx(bio, inode, next_block,
 						  GFP_KERNEL);
 			ext4_set_bio_post_read_ctx(bio, inode, page->index);
-			bio_set_dev(bio, bdev);
 			bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 			bio->bi_end_io = mpage_end_io;
-			bio_set_op_attrs(bio, REQ_OP_READ,
-						rac ? REQ_RAHEAD : 0);
+			if (rac)
+				bio->bi_opf |= REQ_RAHEAD;
 		}
 
 		length = first_hole << blkbits;
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index ca0bb3a73912a..4ae1eefae616d 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -265,10 +265,9 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 				      bio_end_io_t *end_io)
 {
 	struct super_block *sb = sdp->sd_vfs;
-	struct bio *bio = bio_alloc(GFP_NOIO, BIO_MAX_VECS);
+	struct bio *bio = bio_alloc(sb->s_bdev, BIO_MAX_VECS, 0, GFP_NOIO);
 
 	bio->bi_iter.bi_sector = blkno << sdp->sd_fsb2bb_shift;
-	bio_set_dev(bio, sb->s_bdev);
 	bio->bi_end_io = end_io;
 	bio->bi_private = sdp;
 
@@ -489,10 +488,9 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 {
 	struct bio *new;
 
-	new = bio_alloc(GFP_NOIO, nr_iovecs);
-	bio_copy_dev(new, prev);
+	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
+	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_opf = prev->bi_opf;
 	new->bi_write_hint = prev->bi_write_hint;
 	bio_chain(new, prev);
 	submit_bio(prev);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 72d30a682ecec..a580b90b75222 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -222,9 +222,8 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 		struct buffer_head *bh = *bhs;
 		struct bio *bio;
 
-		bio = bio_alloc(GFP_NOIO, num);
+		bio = bio_alloc(bh->b_bdev, num, op | op_flags, GFP_NOIO);
 		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-		bio_set_dev(bio, bh->b_bdev);
 		while (num > 0) {
 			bh = *bhs;
 			if (!bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh))) {
@@ -235,7 +234,6 @@ static void gfs2_submit_bhs(int op, int op_flags, struct buffer_head *bhs[],
 			num--;
 		}
 		bio->bi_end_io = gfs2_meta_read_endio;
-		bio_set_op_attrs(bio, op, op_flags);
 		submit_bio(bio);
 	}
 }
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 7f8410d8fdc1d..c9b423c874a32 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -251,14 +251,12 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 	ClearPageDirty(page);
 	lock_page(page);
 
-	bio = bio_alloc(GFP_NOFS, 1);
+	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_READ | REQ_META, GFP_NOFS);
 	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_set_dev(bio, sb->s_bdev);
 	bio_add_page(bio, page, PAGE_SIZE, 0);
 
 	bio->bi_end_io = end_bio_io_page;
 	bio->bi_private = page;
-	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META);
 	submit_bio(bio);
 	wait_on_page_locked(page);
 	bio_put(bio);
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 51ae6f1eb4a55..6acce8563031d 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -64,10 +64,8 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	offset = start & (io_size - 1);
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_alloc(sb->s_bdev, 1, op | op_flags, GFP_NOIO);
 	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, sb->s_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
 
 	if (op != WRITE && data)
 		*data = (u8 *)buf + offset;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 340d373cb1bf9..70f3657a6ec06 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -290,19 +290,20 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
+		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+				     REQ_OP_READ, gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_readpage does.
 		 */
-		if (!ctx->bio)
-			ctx->bio = bio_alloc(orig_gfp, 1);
-		ctx->bio->bi_opf = REQ_OP_READ;
+		if (!ctx->bio) {
+			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+					     orig_gfp);
+		}
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
-		bio_set_dev(ctx->bio, iomap->bdev);
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio(ctx->bio, folio, plen, poff);
 	}
@@ -1226,10 +1227,9 @@ iomap_chain_bio(struct bio *prev)
 {
 	struct bio *new;
 
-	new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
-	bio_copy_dev(new, prev);/* also copies over blkcg information */
+	new = bio_alloc(prev->bi_bdev, BIO_MAX_VECS, prev->bi_opf, GFP_NOFS);
+	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	new->bi_opf = prev->bi_opf;
 	new->bi_write_hint = prev->bi_write_hint;
 
 	bio_chain(prev, new);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 03ea367df19a4..e2ba13645ef28 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -183,15 +183,13 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	int flags = REQ_SYNC | REQ_IDLE;
 	struct bio *bio;
 
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, iter->iomap.bdev);
+	bio = bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
 	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
-	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
 
@@ -309,14 +307,12 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 		}
 
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
-		bio_set_dev(bio, iomap->bdev);
+		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
-		bio->bi_opf = bio_opf;
 
 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
 		if (unlikely(ret)) {
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 78fd136ac13b9..997c81fcea349 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1980,17 +1980,13 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 
 	bp->l_flag |= lbmREAD;
 
-	bio = bio_alloc(GFP_NOFS, 1);
-
+	bio = bio_alloc(log->bdev, 1, REQ_OP_READ, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
-
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio->bi_opf = REQ_OP_READ;
 	/*check if journaling to disk has been disabled*/
 	if (log->no_integrity) {
 		bio->bi_iter.bi_size = 0;
@@ -2125,16 +2121,13 @@ static void lbmStartIO(struct lbuf * bp)
 
 	jfs_info("lbmStartIO");
 
-	bio = bio_alloc(GFP_NOFS, 1);
+	bio = bio_alloc(log->bdev, 1, REQ_OP_WRITE | REQ_SYNC, GFP_NOFS);
 	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
-	bio_set_dev(bio, log->bdev);
-
 	bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
 	BUG_ON(bio->bi_iter.bi_size != LOGPSIZE);
 
 	bio->bi_end_io = lbmIODone;
 	bio->bi_private = bp;
-	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
 
 	/* check if journaling to disk has been disabled */
 	if (log->no_integrity) {
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 104ae698443ed..fde1a9cf902e8 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -417,12 +417,10 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		}
 		len = min(xlen, (int)JFS_SBI(inode->i_sb)->nbperpage);
 
-		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, inode->i_sb->s_bdev);
+		bio = bio_alloc(inode->i_sb->s_bdev, 1, REQ_OP_WRITE, GFP_NOFS);
 		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		/* Don't call bio_add_page yet, we may add to this vec */
 		bio_offset = offset;
@@ -497,13 +495,12 @@ static int metapage_readpage(struct file *fp, struct page *page)
 			if (bio)
 				submit_bio(bio);
 
-			bio = bio_alloc(GFP_NOFS, 1);
-			bio_set_dev(bio, inode->i_sb->s_bdev);
+			bio = bio_alloc(inode->i_sb->s_bdev, 1, REQ_OP_READ,
+					GFP_NOFS);
 			bio->bi_iter.bi_sector =
 				pblock << (inode->i_blkbits - 9);
 			bio->bi_end_io = metapage_read_end_io;
 			bio->bi_private = page;
-			bio_set_op_attrs(bio, REQ_OP_READ, 0);
 			len = xlen << inode->i_blkbits;
 			offset = block_offset << inode->i_blkbits;
 			if (bio_add_page(bio, page, len, offset) < len)
diff --git a/fs/mpage.c b/fs/mpage.c
index c5817699b369b..12f41de78c539 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -280,10 +280,10 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
 								page))
 				goto out;
 		}
-		args->bio = bio_alloc(gfp, bio_max_segs(args->nr_pages));
+		args->bio = bio_alloc(bdev, bio_max_segs(args->nr_pages), 0,
+				      gfp);
 		if (args->bio == NULL)
 			goto confused;
-		bio_set_dev(args->bio, bdev);
 		args->bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 	}
 
@@ -593,8 +593,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 								page, wbc))
 				goto out;
 		}
-		bio = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
-		bio_set_dev(bio, bdev);
+		bio = bio_alloc(bdev, BIO_MAX_VECS, 0, GFP_NOFS);
 		bio->bi_iter.bi_sector = blocks[0] << (blkbits - 9);
 
 		wbc_init_bio(wbc, bio);
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 38e063af7e98a..79a8b451791f5 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -154,12 +154,10 @@ do_add_page_to_bio(struct bio *bio, int npg, int rw, sector_t isect,
 
 retry:
 	if (!bio) {
-		bio = bio_alloc(GFP_NOIO, bio_max_segs(npg));
+		bio = bio_alloc(map->bdev, bio_max_segs(npg), rw, GFP_NOIO);
 		bio->bi_iter.bi_sector = disk_addr >> SECTOR_SHIFT;
-		bio_set_dev(bio, map->bdev);
 		bio->bi_end_io = end_io;
 		bio->bi_private = par;
-		bio_set_op_attrs(bio, rw, 0);
 	}
 	if (bio_add_page(bio, page, *len, offset) < *len) {
 		bio = bl_submit_bio(bio);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 53b7c6d21cdd8..4f71faacd8253 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -391,8 +391,8 @@ static int nilfs_segbuf_submit_bh(struct nilfs_segment_buffer *segbuf,
 	BUG_ON(wi->nr_vecs <= 0);
  repeat:
 	if (!wi->bio) {
-		wi->bio = bio_alloc(GFP_NOIO, wi->nr_vecs);
-		bio_set_dev(wi->bio, wi->nilfs->ns_bdev);
+		wi->bio = bio_alloc(wi->nilfs->ns_bdev, wi->nr_vecs, 0,
+				    GFP_NOIO);
 		wi->bio->bi_iter.bi_sector = (wi->blocknr + wi->end) <<
 			(wi->nilfs->ns_blocksize_bits - 9);
 	}
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4a255e21ecf5f..0660a07c5a96e 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1485,15 +1485,13 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		lbo = ((u64)lcn << cluster_bits) + off;
 		len = ((u64)clen << cluster_bits) - off;
 new_bio:
-		new = bio_alloc(GFP_NOFS, nr_pages - page_idx);
+		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
 		if (bio) {
 			bio_chain(bio, new);
 			submit_bio(bio);
 		}
 		bio = new;
-		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = lbo >> 9;
-		bio->bi_opf = op;
 
 		while (len) {
 			off = vbo & (PAGE_SIZE - 1);
@@ -1584,14 +1582,12 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		lbo = (u64)lcn << cluster_bits;
 		len = (u64)clen << cluster_bits;
 new_bio:
-		new = bio_alloc(GFP_NOFS, BIO_MAX_VECS);
+		new = bio_alloc(bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOFS);
 		if (bio) {
 			bio_chain(bio, new);
 			submit_bio(bio);
 		}
 		bio = new;
-		bio_set_dev(bio, bdev);
-		bio->bi_opf = REQ_OP_WRITE;
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		for (;;) {
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index f89ffcbd585ff..5cef858264b60 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -518,7 +518,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(GFP_ATOMIC, 16);
+	bio = bio_alloc(reg->hr_bdev, 16, op | op_flags, GFP_ATOMIC);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -527,10 +527,8 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 
 	/* Must put everything in 512 byte sectors for the bio... */
 	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
-	bio_set_dev(bio, reg->hr_bdev);
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
-	bio_set_op_attrs(bio, op, op_flags);
 
 	vec_start = (cs << bits) % PAGE_SIZE;
 	while(cs < max_slots) {
diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 2db8bcf7ff859..622c844f6d118 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -86,16 +86,17 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
 	int error, i;
 	struct bio *bio;
 
-	if (page_count <= BIO_MAX_VECS)
-		bio = bio_alloc(GFP_NOIO, page_count);
-	else
+	if (page_count <= BIO_MAX_VECS) {
+		bio = bio_alloc(sb->s_bdev, page_count, REQ_OP_READ, GFP_NOIO);
+	} else {
 		bio = bio_kmalloc(GFP_NOIO, page_count);
+		bio_set_dev(bio, sb->s_bdev);
+		bio->bi_opf = REQ_OP_READ;
+	}
 
 	if (!bio)
 		return -ENOMEM;
 
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_opf = READ;
 	bio->bi_iter.bi_sector = block * (msblk->devblksize >> SECTOR_SHIFT);
 
 	for (i = 0; i < page_count; ++i) {
diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 667e297f59b16..eff4a9f21dcff 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -61,10 +61,9 @@ xfs_rw_bdev(
 	if (is_vmalloc && op == REQ_OP_WRITE)
 		flush_kernel_vmap_range(data, count);
 
-	bio = bio_alloc(GFP_KERNEL, bio_max_vecs(left));
-	bio_set_dev(bio, bdev);
+	bio = bio_alloc(bdev, bio_max_vecs(left), op | REQ_META | REQ_SYNC,
+			GFP_KERNEL);
 	bio->bi_iter.bi_sector = sector;
-	bio->bi_opf = op | REQ_META | REQ_SYNC;
 
 	do {
 		struct page	*page = kmem_to_page(data);
@@ -74,10 +73,9 @@ xfs_rw_bdev(
 		while (bio_add_page(bio, page, len, off) != len) {
 			struct bio	*prev = bio;
 
-			bio = bio_alloc(GFP_KERNEL, bio_max_vecs(left));
-			bio_copy_dev(bio, prev);
+			bio = bio_alloc(prev->bi_bdev, bio_max_vecs(left),
+					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio->bi_opf = prev->bi_opf;
 			bio_chain(prev, bio);
 
 			submit_bio(prev);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index b45e0d50a4052..ae87fd95b17e2 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1440,12 +1440,10 @@ xfs_buf_ioapply_map(
 	atomic_inc(&bp->b_io_remaining);
 	nr_pages = bio_max_segs(total_nr_pages);
 
-	bio = bio_alloc(GFP_NOIO, nr_pages);
-	bio_set_dev(bio, bp->b_target->bt_bdev);
+	bio = bio_alloc(bp->b_target->bt_bdev, nr_pages, op, GFP_NOIO);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = xfs_buf_bio_end_io;
 	bio->bi_private = bp;
-	bio->bi_opf = op;
 
 	for (; size && nr_pages; nr_pages--, page_index++) {
 		int	rbytes, nbytes = PAGE_SIZE - offset;
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b76dfb310ab65..c0fc2c326dcee 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -692,12 +692,11 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	if (!nr_pages)
 		return 0;
 
-	bio = bio_alloc(GFP_NOFS, nr_pages);
-	bio_set_dev(bio, bdev);
+	bio = bio_alloc(bdev, nr_pages,
+			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
 	bio->bi_iter.bi_sector = zi->i_zsector;
 	bio->bi_write_hint = iocb->ki_hint;
 	bio->bi_ioprio = iocb->ki_ioprio;
-	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5c5ada2ebb270..be6ac92913d48 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -418,9 +418,10 @@ extern struct bio *bio_clone_fast(struct bio *, gfp_t, struct bio_set *);
 
 extern struct bio_set fs_bio_set;
 
-static inline struct bio *bio_alloc(gfp_t gfp_mask, unsigned short nr_iovecs)
+static inline struct bio *bio_alloc(struct block_device *bdev,
+		unsigned short nr_vecs, unsigned int opf, gfp_t gfp_mask)
 {
-	return bio_alloc_bioset(NULL, nr_iovecs, 0, gfp_mask, &fs_bio_set);
+	return bio_alloc_bioset(bdev, nr_vecs, opf, gfp_mask, &fs_bio_set);
 }
 
 void submit_bio(struct bio *bio);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index ad10359030a4c..9bce177454b82 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -277,10 +277,9 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
 	struct bio *bio;
 	int error = 0;
 
-	bio = bio_alloc(GFP_NOIO | __GFP_HIGH, 1);
+	bio = bio_alloc(hib_resume_bdev, 1, op | op_flags,
+			GFP_NOIO | __GFP_HIGH);
 	bio->bi_iter.bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_set_dev(bio, hib_resume_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
 
 	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 		pr_err("Adding page to bio failed at %llu\n",
diff --git a/mm/page_io.c b/mm/page_io.c
index 9725c7e1eeea1..874f134d6d79c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -337,10 +337,10 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	bio = bio_alloc(GFP_NOIO, 1);
-	bio_set_dev(bio, sis->bdev);
+	bio = bio_alloc(sis->bdev, 1,
+			REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc),
+			GFP_NOIO);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
-	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
 	bio->bi_end_io = end_write_func;
 	bio_add_page(bio, page, thp_size(page), 0);
 
@@ -401,9 +401,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	}
 
 	ret = 0;
-	bio = bio_alloc(GFP_KERNEL, 1);
-	bio_set_dev(bio, sis->bdev);
-	bio->bi_opf = REQ_OP_READ;
+	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_page(bio, page, thp_size(page), 0);
-- 
2.30.2

