Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7E50232A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 06:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350223AbiDOFAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349861AbiDOE6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:58:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44FD5B;
        Thu, 14 Apr 2022 21:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=JEp+Ydky4hX/95I7Lm2zDDRxFAsMkADcWxP2d9kmm+k=; b=qsTDfotmtIWHWraU2dgGVjIKy/
        C8gTlmi51yWMclX54ORFg7Xna22avP3VcyiXLYBC6nR19lbVENNopVJ9tQGKgQy04iWEaJit4uDtN
        KQhTJamDnRgtj1KkFNuR9gefCo+gNrgNnOWwTkGS9hkFTQu7vnpYzsSyXBC1wEK5I+vUB41wYHdql
        4XWbh8XjCfzVsn8dXva3n3BSPwQT7BQDgyMt4id2YqsEF5oM+pQUbkIbjwYtgr1GpPU7BSmSRTPF+
        FYEjAb9JYAnCoiewCCJgGkFfvJ0Vto4uuR3qScpniY79wd9YisLWyxKpjL/zI/YKfvEqQHCtRnFM/
        wD74URHg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfDyJ-008PkB-3y; Fri, 15 Apr 2022 04:54:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
        Coly Li <colyli@suse.de>, David Sterba <dsterba@suse.com>
Subject: [PATCH 24/27] block: remove QUEUE_FLAG_DISCARD
Date:   Fri, 15 Apr 2022 06:52:55 +0200
Message-Id: <20220415045258.199825-25-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just use a non-zero max_discard_sectors as an indicator for discard
support, similar to what is done for write zeroes.

The only places where needs special attention is the RAID5 driver,
which must clear discard support for security reasons by default,
even if the default stacking rules would allow for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [drbd]
Acked-by: Jan Höppner <hoeppner@linux.ibm.com> [s390]
Acked-by: Coly Li <colyli@suse.de> [bcache]
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 arch/um/drivers/ubd_kern.c          |  2 --
 block/blk-core.c                    |  2 +-
 block/blk-lib.c                     |  2 +-
 block/blk-mq-debugfs.c              |  1 -
 block/ioctl.c                       |  3 +--
 drivers/block/drbd/drbd_main.c      |  2 +-
 drivers/block/drbd/drbd_nl.c        | 19 ++-----------------
 drivers/block/drbd/drbd_receiver.c  |  3 +--
 drivers/block/loop.c                | 11 +++--------
 drivers/block/nbd.c                 |  5 +----
 drivers/block/null_blk/main.c       |  1 -
 drivers/block/rbd.c                 |  1 -
 drivers/block/rnbd/rnbd-clt.c       |  2 --
 drivers/block/rnbd/rnbd-srv-dev.h   |  3 ---
 drivers/block/virtio_blk.c          |  2 --
 drivers/block/xen-blkback/xenbus.c  |  2 +-
 drivers/block/xen-blkfront.c        |  3 +--
 drivers/block/zram/zram_drv.c       |  1 -
 drivers/md/bcache/request.c         |  4 ++--
 drivers/md/bcache/super.c           |  3 +--
 drivers/md/bcache/sysfs.c           |  2 +-
 drivers/md/dm-cache-target.c        |  9 +--------
 drivers/md/dm-clone-target.c        |  9 +--------
 drivers/md/dm-log-writes.c          |  3 +--
 drivers/md/dm-raid.c                |  9 ++-------
 drivers/md/dm-table.c               |  9 ++-------
 drivers/md/dm-thin.c                | 11 +----------
 drivers/md/dm.c                     |  3 +--
 drivers/md/md-linear.c              | 11 +----------
 drivers/md/raid0.c                  |  7 -------
 drivers/md/raid1.c                  | 16 +---------------
 drivers/md/raid10.c                 | 18 ++----------------
 drivers/md/raid5-cache.c            |  2 +-
 drivers/md/raid5.c                  | 12 ++++--------
 drivers/mmc/core/queue.c            |  1 -
 drivers/mtd/mtd_blkdevs.c           |  1 -
 drivers/nvme/host/core.c            |  4 ++--
 drivers/s390/block/dasd_fba.c       |  1 -
 drivers/scsi/sd.c                   |  2 --
 drivers/target/target_core_device.c |  2 +-
 fs/btrfs/extent-tree.c              |  4 ++--
 fs/btrfs/ioctl.c                    |  2 +-
 fs/exfat/file.c                     |  2 +-
 fs/exfat/super.c                    | 10 +++-------
 fs/ext4/ioctl.c                     | 10 +++-------
 fs/ext4/super.c                     | 10 +++-------
 fs/f2fs/f2fs.h                      |  3 +--
 fs/fat/file.c                       |  2 +-
 fs/fat/inode.c                      | 10 +++-------
 fs/gfs2/rgrp.c                      |  2 +-
 fs/jbd2/journal.c                   |  7 ++-----
 fs/jfs/ioctl.c                      |  2 +-
 fs/jfs/super.c                      |  8 ++------
 fs/nilfs2/ioctl.c                   |  2 +-
 fs/ntfs3/file.c                     |  2 +-
 fs/ntfs3/super.c                    |  2 +-
 fs/ocfs2/ioctl.c                    |  2 +-
 fs/xfs/xfs_discard.c                |  2 +-
 fs/xfs/xfs_super.c                  | 12 ++++--------
 include/linux/blkdev.h              |  2 --
 mm/swapfile.c                       | 17 ++---------------
 61 files changed, 73 insertions(+), 244 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index b03269faef714..085ffdf98e57e 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -483,7 +483,6 @@ static void ubd_handler(void)
 			if ((io_req->error == BLK_STS_NOTSUPP) && (req_op(io_req->req) == REQ_OP_DISCARD)) {
 				blk_queue_max_discard_sectors(io_req->req->q, 0);
 				blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
-				blk_queue_flag_clear(QUEUE_FLAG_DISCARD, io_req->req->q);
 			}
 			blk_mq_end_request(io_req->req, io_req->error);
 			kfree(io_req);
@@ -803,7 +802,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		ubd_dev->queue->limits.discard_alignment = SECTOR_SIZE;
 		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, ubd_dev->queue);
 	}
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b863317..b5c3a8049134c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -820,7 +820,7 @@ void submit_bio_noacct(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
-		if (!blk_queue_discard(q))
+		if (!bdev_max_discard_sectors(bdev))
 			goto not_supported;
 		break;
 	case REQ_OP_SECURE_ERASE:
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 2ae32a722851c..8b4b66d3a9bfc 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -53,7 +53,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			return -EOPNOTSUPP;
 		op = REQ_OP_SECURE_ERASE;
 	} else {
-		if (!blk_queue_discard(q))
+		if (!bdev_max_discard_sectors(bdev))
 			return -EOPNOTSUPP;
 		op = REQ_OP_DISCARD;
 	}
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index aa0349e9f083b..fd111c5001256 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -113,7 +113,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(FAIL_IO),
 	QUEUE_FLAG_NAME(NONROT),
 	QUEUE_FLAG_NAME(IO_STAT),
-	QUEUE_FLAG_NAME(DISCARD),
 	QUEUE_FLAG_NAME(NOXMERGES),
 	QUEUE_FLAG_NAME(ADD_RANDOM),
 	QUEUE_FLAG_NAME(SECERASE),
diff --git a/block/ioctl.c b/block/ioctl.c
index ad3771b268b81..c2cd3ba5290ce 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -87,14 +87,13 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 {
 	uint64_t range[2];
 	uint64_t start, len;
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(bdev))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(range, (void __user *)arg, sizeof(range)))
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7b501c8d59928..912560f611c35 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -942,7 +942,7 @@ int drbd_send_sizes(struct drbd_peer_device *peer_device, int trigger_reply, enu
 			cpu_to_be32(bdev_alignment_offset(bdev));
 		p->qlim->io_min = cpu_to_be32(bdev_io_min(bdev));
 		p->qlim->io_opt = cpu_to_be32(bdev_io_opt(bdev));
-		p->qlim->discard_enabled = blk_queue_discard(q);
+		p->qlim->discard_enabled = !!bdev_max_discard_sectors(bdev);
 		put_ldev(device);
 	} else {
 		struct request_queue *q = device->rq_queue;
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index a0a06e238e917..0678ceb505799 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1210,7 +1210,7 @@ static void decide_on_discard_support(struct drbd_device *device,
 		first_peer_device(device)->connection;
 	struct request_queue *q = device->rq_queue;
 
-	if (bdev && !blk_queue_discard(bdev->backing_bdev->bd_disk->queue))
+	if (bdev && !bdev_max_discard_sectors(bdev->backing_bdev))
 		goto not_supported;
 
 	if (connection->cstate >= C_CONNECTED &&
@@ -1230,30 +1230,16 @@ static void decide_on_discard_support(struct drbd_device *device,
 	 */
 	blk_queue_discard_granularity(q, 512);
 	q->limits.max_discard_sectors = drbd_max_discard_sectors(connection);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	q->limits.max_write_zeroes_sectors =
 		drbd_max_discard_sectors(connection);
 	return;
 
 not_supported:
-	blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 	blk_queue_discard_granularity(q, 0);
 	q->limits.max_discard_sectors = 0;
 	q->limits.max_write_zeroes_sectors = 0;
 }
 
-static void fixup_discard_if_not_supported(struct request_queue *q)
-{
-	/* To avoid confusion, if this queue does not support discard, clear
-	 * max_discard_sectors, which is what lsblk -D reports to the user.
-	 * Older kernels got this wrong in "stack limits".
-	 * */
-	if (!blk_queue_discard(q)) {
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_discard_granularity(q, 0);
-	}
-}
-
 static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
 {
 	/* Fixup max_write_zeroes_sectors after blk_stack_limits():
@@ -1300,7 +1286,6 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 		blk_stack_limits(&q->limits, &b->limits, 0);
 		disk_update_readahead(device->vdisk);
 	}
-	fixup_discard_if_not_supported(q);
 	fixup_write_zeroes(device, q);
 }
 
@@ -1447,7 +1432,7 @@ static void sanitize_disk_conf(struct drbd_device *device, struct disk_conf *dis
 	if (disk_conf->al_extents > drbd_al_extents_max(nbc))
 		disk_conf->al_extents = drbd_al_extents_max(nbc);
 
-	if (!blk_queue_discard(q)) {
+	if (!bdev_max_discard_sectors(bdev)) {
 		if (disk_conf->rs_discard_granularity) {
 			disk_conf->rs_discard_granularity = 0; /* disable feature */
 			drbd_info(device, "rs_discard_granularity feature disabled\n");
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0b4c7de463989..8a4a47da56fe9 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1575,11 +1575,10 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 
 static bool can_do_reliable_discards(struct drbd_device *device)
 {
-	struct request_queue *q = bdev_get_queue(device->ldev->backing_bdev);
 	struct disk_conf *dc;
 	bool can_do;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(device->ldev->backing_bdev))
 		return false;
 
 	rcu_read_lock();
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8d800d46e4985..0e061c9896eff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -314,15 +314,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(lo->lo_queue)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	if (!bdev_max_discard_sectors(lo->lo_device))
+		return -EOPNOTSUPP;
 
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
-		ret = -EIO;
- out:
+		return -EIO;
 	return ret;
 }
 
@@ -787,12 +784,10 @@ static void loop_config_discard(struct loop_device *lo)
 		q->limits.discard_granularity = granularity;
 		blk_queue_max_discard_sectors(q, max_discard_sectors);
 		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	} else {
 		q->limits.discard_granularity = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 	}
 	q->limits.discard_alignment = 0;
 }
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a1f98494dddf..4729aef8c6462 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1231,8 +1231,6 @@ static void nbd_parse_flags(struct nbd_device *nbd)
 		set_disk_ro(nbd->disk, true);
 	else
 		set_disk_ro(nbd->disk, false);
-	if (config->flags & NBD_FLAG_SEND_TRIM)
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, nbd->disk->queue);
 	if (config->flags & NBD_FLAG_SEND_FLUSH) {
 		if (config->flags & NBD_FLAG_SEND_FUA)
 			blk_queue_write_cache(nbd->disk->queue, true, true);
@@ -1319,8 +1317,7 @@ static void nbd_config_put(struct nbd_device *nbd)
 		nbd->tag_set.timeout = 0;
 		nbd->disk->queue->limits.discard_granularity = 0;
 		nbd->disk->queue->limits.discard_alignment = 0;
-		blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, nbd->disk->queue);
+		blk_queue_max_discard_sectors(nbd->disk->queue, 0);
 
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e66234..f6493a9e85ed3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1767,7 +1767,6 @@ static void null_config_discard(struct nullb *nullb)
 	nullb->q->limits.discard_granularity = nullb->dev->blocksize;
 	nullb->q->limits.discard_alignment = nullb->dev->blocksize;
 	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
 static const struct block_device_operations null_bio_ops = {
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index b844432bad20b..2b21f717cce1a 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4942,7 +4942,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	blk_queue_io_opt(q, rbd_dev->opts->alloc_size);
 
 	if (rbd_dev->opts->trim) {
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 		q->limits.discard_granularity = rbd_dev->opts->alloc_size;
 		blk_queue_max_discard_sectors(q, objset_bytes >> SECTOR_SHIFT);
 		blk_queue_max_write_zeroes_sectors(q, objset_bytes >> SECTOR_SHIFT);
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b66e8840b94b8..efa99a3884507 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1364,8 +1364,6 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	blk_queue_max_discard_sectors(dev->queue, dev->max_discard_sectors);
 	dev->queue->limits.discard_granularity	= dev->discard_granularity;
 	dev->queue->limits.discard_alignment	= dev->discard_alignment;
-	if (dev->max_discard_sectors)
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, dev->queue);
 	if (dev->secure_discard)
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, dev->queue);
 
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index f82fbb4bbda8e..1f7e1c8fd4d9b 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -49,9 +49,6 @@ static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
 
 static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
 {
-	if (!blk_queue_discard(bdev_get_queue(dev->bdev)))
-		return 0;
-
 	return bdev_max_discard_sectors(dev->bdev);
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a8bcf3f664af1..6ccf15253dee1 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -888,8 +888,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 			v = sg_elems;
 		blk_queue_max_discard_segments(q,
 					       min(v, MAX_DISCARD_SEGMENTS));
-
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_WRITE_ZEROES)) {
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 8b691fe50475f..83cd08041e6b3 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -583,7 +583,7 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (!xenbus_read_unsigned(dev->nodename, "discard-enable", 1))
 		return;
 
-	if (blk_queue_discard(q)) {
+	if (bdev_max_discard_sectors(bdev)) {
 		err = xenbus_printf(xbt, dev->nodename,
 			"discard-granularity", "%u",
 			q->limits.discard_granularity);
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 003056d4f7f5f..e13cb4d48f1ea 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -944,7 +944,6 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 	blk_queue_flag_set(QUEUE_FLAG_VIRT, rq);
 
 	if (info->feature_discard) {
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, rq);
 		blk_queue_max_discard_sectors(rq, get_capacity(gd));
 		rq->limits.discard_granularity = info->discard_granularity ?:
 						 info->physical_sector_size;
@@ -1606,7 +1605,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
-				blk_queue_flag_clear(QUEUE_FLAG_DISCARD, rq);
+				blk_queue_max_discard_sectors(rq, 0);
 				blk_queue_flag_clear(QUEUE_FLAG_SECERASE, rq);
 			}
 			break;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012de..59ff444bf6c76 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1952,7 +1952,6 @@ static int zram_add(void)
 	blk_queue_io_opt(zram->disk->queue, PAGE_SIZE);
 	zram->disk->queue->limits.discard_granularity = PAGE_SIZE;
 	blk_queue_max_discard_sectors(zram->disk->queue, UINT_MAX);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
 	/*
 	 * zram_bio_discard() will clear all logical blocks if logical block
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index fdd0194f84dd0..e27f67f06a428 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1005,7 +1005,7 @@ static void cached_dev_write(struct cached_dev *dc, struct search *s)
 		bio_get(s->iop.bio);
 
 		if (bio_op(bio) == REQ_OP_DISCARD &&
-		    !blk_queue_discard(bdev_get_queue(dc->bdev)))
+		    !bdev_max_discard_sectors(dc->bdev))
 			goto insert_data;
 
 		/* I/O request sent to backing device */
@@ -1115,7 +1115,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	bio->bi_private = ddip;
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
-	    !blk_queue_discard(bdev_get_queue(dc->bdev)))
+	    !bdev_max_discard_sectors(dc->bdev))
 		bio->bi_end_io(bio);
 	else
 		submit_bio_noacct(bio);
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index bf3de149d3c9f..2f49e31142f62 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -973,7 +973,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, d->disk->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, d->disk->queue);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, d->disk->queue);
 
 	blk_queue_write_cache(q, true, true);
 
@@ -2350,7 +2349,7 @@ static int register_cache(struct cache_sb *sb, struct cache_sb_disk *sb_disk,
 	ca->bdev->bd_holder = ca;
 	ca->sb_disk = sb_disk;
 
-	if (blk_queue_discard(bdev_get_queue(bdev)))
+	if (bdev_max_discard_sectors((bdev)))
 		ca->discard = CACHE_DISCARD(&ca->sb);
 
 	ret = cache_alloc(ca);
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index d1029d71ff3bc..c6f677059214d 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -1151,7 +1151,7 @@ STORE(__bch_cache)
 	if (attr == &sysfs_discard) {
 		bool v = strtoul_or_return(buf);
 
-		if (blk_queue_discard(bdev_get_queue(ca->bdev)))
+		if (bdev_max_discard_sectors(ca->bdev))
 			ca->discard = v;
 
 		if (v != CACHE_DISCARD(&ca->sb)) {
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 780a61bc6cc03..28c5de8eca4a0 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3329,13 +3329,6 @@ static int cache_iterate_devices(struct dm_target *ti,
 	return r;
 }
 
-static bool origin_dev_supports_discard(struct block_device *origin_bdev)
-{
-	struct request_queue *q = bdev_get_queue(origin_bdev);
-
-	return blk_queue_discard(q);
-}
-
 /*
  * If discard_passdown was enabled verify that the origin device
  * supports discards.  Disable discard_passdown if not.
@@ -3349,7 +3342,7 @@ static void disable_passdown_if_not_supported(struct cache *cache)
 	if (!cache->features.discard_passdown)
 		return;
 
-	if (!origin_dev_supports_discard(origin_bdev))
+	if (!bdev_max_discard_sectors(origin_bdev))
 		reason = "discard unsupported";
 
 	else if (origin_limits->max_discard_sectors < cache->sectors_per_block)
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 128316a73d016..811b0a5379d03 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2016,13 +2016,6 @@ static void clone_resume(struct dm_target *ti)
 	do_waker(&clone->waker.work);
 }
 
-static bool bdev_supports_discards(struct block_device *bdev)
-{
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return (q && blk_queue_discard(q));
-}
-
 /*
  * If discard_passdown was enabled verify that the destination device supports
  * discards. Disable discard_passdown if not.
@@ -2036,7 +2029,7 @@ static void disable_passdown_if_not_supported(struct clone *clone)
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags))
 		return;
 
-	if (!bdev_supports_discards(dest_dev))
+	if (!bdev_max_discard_sectors(dest_dev))
 		reason = "discard unsupported";
 	else if (dest_limits->max_discard_sectors < clone->region_size)
 		reason = "max discard sectors smaller than a region";
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index c9d036d6bb2ee..e194226c89e54 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -866,9 +866,8 @@ static int log_writes_message(struct dm_target *ti, unsigned argc, char **argv,
 static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limits)
 {
 	struct log_writes_c *lc = ti->private;
-	struct request_queue *q = bdev_get_queue(lc->dev->bdev);
 
-	if (!q || !blk_queue_discard(q)) {
+	if (!bdev_max_discard_sectors(lc->dev->bdev)) {
 		lc->device_supports_discard = false;
 		limits->discard_granularity = lc->sectorsize;
 		limits->max_discard_sectors = (UINT_MAX >> SECTOR_SHIFT);
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 2b26435a6946e..9526ccbedafba 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2963,13 +2963,8 @@ static void configure_discard_support(struct raid_set *rs)
 	raid456 = rs_is_raid456(rs);
 
 	for (i = 0; i < rs->raid_disks; i++) {
-		struct request_queue *q;
-
-		if (!rs->dev[i].rdev.bdev)
-			continue;
-
-		q = bdev_get_queue(rs->dev[i].rdev.bdev);
-		if (!q || !blk_queue_discard(q))
+		if (!rs->dev[i].rdev.bdev ||
+		    !bdev_max_discard_sectors(rs->dev[i].rdev.bdev))
 			return;
 
 		if (raid456) {
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index d46839faa0ca5..0dff6907fd00d 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1888,9 +1888,7 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return !blk_queue_discard(q);
+	return !bdev_max_discard_sectors(dev->bdev);
 }
 
 static bool dm_table_supports_discards(struct dm_table *t)
@@ -1970,15 +1968,12 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, q);
 
 	if (!dm_table_supports_discards(t)) {
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		/* Must also clear discard limits... */
 		q->limits.max_discard_sectors = 0;
 		q->limits.max_hw_discard_sectors = 0;
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		q->limits.discard_misaligned = 0;
-	} else
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	}
 
 	if (dm_table_supports_secure_erase(t))
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 4d25d0e270313..eded4bcc4545f 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2802,13 +2802,6 @@ static void requeue_bios(struct pool *pool)
 /*----------------------------------------------------------------
  * Binding of control targets to a pool object
  *--------------------------------------------------------------*/
-static bool data_dev_supports_discard(struct pool_c *pt)
-{
-	struct request_queue *q = bdev_get_queue(pt->data_dev->bdev);
-
-	return blk_queue_discard(q);
-}
-
 static bool is_factor(sector_t block_size, uint32_t n)
 {
 	return !sector_div(block_size, n);
@@ -2828,7 +2821,7 @@ static void disable_passdown_if_not_supported(struct pool_c *pt)
 	if (!pt->adjusted_pf.discard_passdown)
 		return;
 
-	if (!data_dev_supports_discard(pt))
+	if (!bdev_max_discard_sectors(pt->data_dev->bdev))
 		reason = "discard unsupported";
 
 	else if (data_limits->max_discard_sectors < pool->sectors_per_block)
@@ -4057,8 +4050,6 @@ static void pool_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		/*
 		 * Must explicitly disallow stacking discard limits otherwise the
 		 * block layer will stack them if pool's data device has support.
-		 * QUEUE_FLAG_DISCARD wouldn't be set but there is no way for the
-		 * user to see that, so make sure to set all discard limits to 0.
 		 */
 		limits->discard_granularity = 0;
 		return;
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3c5fad7c4ee68..dbbf64ce7e927 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -955,7 +955,6 @@ void disable_discard(struct mapped_device *md)
 
 	/* device doesn't really support DISCARD, disable it */
 	limits->max_discard_sectors = 0;
-	blk_queue_flag_clear(QUEUE_FLAG_DISCARD, md->queue);
 }
 
 void disable_write_zeroes(struct mapped_device *md)
@@ -982,7 +981,7 @@ static void clone_endio(struct bio *bio)
 
 	if (unlikely(error == BLK_STS_TARGET)) {
 		if (bio_op(bio) == REQ_OP_DISCARD &&
-		    !q->limits.max_discard_sectors)
+		    !bdev_max_discard_sectors(bio->bi_bdev))
 			disable_discard(md);
 		else if (bio_op(bio) == REQ_OP_WRITE_ZEROES &&
 			 !q->limits.max_write_zeroes_sectors)
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 0f55b079371b1..138a3b25c5c82 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -64,7 +64,6 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 	struct linear_conf *conf;
 	struct md_rdev *rdev;
 	int i, cnt;
-	bool discard_supported = false;
 
 	conf = kzalloc(struct_size(conf, disks, raid_disks), GFP_KERNEL);
 	if (!conf)
@@ -96,9 +95,6 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 
 		conf->array_sectors += rdev->sectors;
 		cnt++;
-
-		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
-			discard_supported = true;
 	}
 	if (cnt != raid_disks) {
 		pr_warn("md/linear:%s: not enough drives present. Aborting!\n",
@@ -106,11 +102,6 @@ static struct linear_conf *linear_conf(struct mddev *mddev, int raid_disks)
 		goto out;
 	}
 
-	if (!discard_supported)
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, mddev->queue);
-	else
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
-
 	/*
 	 * Here we calculate the device offsets.
 	 */
@@ -252,7 +243,7 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		start_sector + data_offset;
 
 	if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
-		     !blk_queue_discard(bio->bi_bdev->bd_disk->queue))) {
+		     !bdev_max_discard_sectors(bio->bi_bdev))) {
 		/* Just ignore it */
 		bio_endio(bio);
 	} else {
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index b21e101183f44..7231f5e1eaa73 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -399,7 +399,6 @@ static int raid0_run(struct mddev *mddev)
 	conf = mddev->private;
 	if (mddev->queue) {
 		struct md_rdev *rdev;
-		bool discard_supported = false;
 
 		blk_queue_max_hw_sectors(mddev->queue, mddev->chunk_sectors);
 		blk_queue_max_write_zeroes_sectors(mddev->queue, mddev->chunk_sectors);
@@ -412,13 +411,7 @@ static int raid0_run(struct mddev *mddev)
 		rdev_for_each(rdev, mddev) {
 			disk_stack_limits(mddev->gendisk, rdev->bdev,
 					  rdev->data_offset << 9);
-			if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
-				discard_supported = true;
 		}
-		if (!discard_supported)
-			blk_queue_flag_clear(QUEUE_FLAG_DISCARD, mddev->queue);
-		else
-			blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
 	}
 
 	/* calculate array device size */
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d81b896855f9f..3da749d150a17 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -802,7 +802,7 @@ static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 		if (test_bit(Faulty, &rdev->flags)) {
 			bio_io_error(bio);
 		} else if (unlikely((bio_op(bio) == REQ_OP_DISCARD) &&
-				    !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
+				    !bdev_max_discard_sectors(bio->bi_bdev)))
 			/* Just ignore it */
 			bio_endio(bio);
 		else
@@ -1826,8 +1826,6 @@ static int raid1_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 			break;
 		}
 	}
-	if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
 	print_conf(conf);
 	return err;
 }
@@ -3106,7 +3104,6 @@ static int raid1_run(struct mddev *mddev)
 	int i;
 	struct md_rdev *rdev;
 	int ret;
-	bool discard_supported = false;
 
 	if (mddev->level != 1) {
 		pr_warn("md/raid1:%s: raid level not set to mirroring (%d)\n",
@@ -3141,8 +3138,6 @@ static int raid1_run(struct mddev *mddev)
 			continue;
 		disk_stack_limits(mddev->gendisk, rdev->bdev,
 				  rdev->data_offset << 9);
-		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
-			discard_supported = true;
 	}
 
 	mddev->degraded = 0;
@@ -3179,15 +3174,6 @@ static int raid1_run(struct mddev *mddev)
 
 	md_set_array_sectors(mddev, raid1_size(mddev, 0, 0));
 
-	if (mddev->queue) {
-		if (discard_supported)
-			blk_queue_flag_set(QUEUE_FLAG_DISCARD,
-						mddev->queue);
-		else
-			blk_queue_flag_clear(QUEUE_FLAG_DISCARD,
-						  mddev->queue);
-	}
-
 	ret = md_integrity_register(mddev);
 	if (ret) {
 		md_unregister_thread(&mddev->thread);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7816c8b2e8087..36a460015cf58 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -888,7 +888,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			if (test_bit(Faulty, &rdev->flags)) {
 				bio_io_error(bio);
 			} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-					    !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
+					    !bdev_max_discard_sectors(bio->bi_bdev)))
 				/* Just ignore it */
 				bio_endio(bio);
 			else
@@ -1083,7 +1083,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		if (test_bit(Faulty, &rdev->flags)) {
 			bio_io_error(bio);
 		} else if (unlikely((bio_op(bio) ==  REQ_OP_DISCARD) &&
-				    !blk_queue_discard(bio->bi_bdev->bd_disk->queue)))
+				    !bdev_max_discard_sectors(bio->bi_bdev)))
 			/* Just ignore it */
 			bio_endio(bio);
 		else
@@ -2144,8 +2144,6 @@ static int raid10_add_disk(struct mddev *mddev, struct md_rdev *rdev)
 		rcu_assign_pointer(p->rdev, rdev);
 		break;
 	}
-	if (mddev->queue && blk_queue_discard(bdev_get_queue(rdev->bdev)))
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, mddev->queue);
 
 	print_conf(conf);
 	return err;
@@ -4069,7 +4067,6 @@ static int raid10_run(struct mddev *mddev)
 	sector_t size;
 	sector_t min_offset_diff = 0;
 	int first = 1;
-	bool discard_supported = false;
 
 	if (mddev_init_writes_pending(mddev) < 0)
 		return -ENOMEM;
@@ -4140,20 +4137,9 @@ static int raid10_run(struct mddev *mddev)
 					  rdev->data_offset << 9);
 
 		disk->head_position = 0;
-
-		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
-			discard_supported = true;
 		first = 0;
 	}
 
-	if (mddev->queue) {
-		if (discard_supported)
-			blk_queue_flag_set(QUEUE_FLAG_DISCARD,
-						mddev->queue);
-		else
-			blk_queue_flag_clear(QUEUE_FLAG_DISCARD,
-						  mddev->queue);
-	}
 	/* need to check that every block has at least one working mirror */
 	if (!enough(conf, -1)) {
 		pr_err("md/raid10:%s: not enough operational mirrors.\n",
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index a7d50ff9020a8..c3cbf9a574a39 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1318,7 +1318,7 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
 
 	r5l_write_super(log, end);
 
-	if (!blk_queue_discard(bdev_get_queue(bdev)))
+	if (!bdev_max_discard_sectors(bdev))
 		return;
 
 	mddev = log->rdev->mddev;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 0bbae0e638666..59f91e392a2ae 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7776,14 +7776,10 @@ static int raid5_run(struct mddev *mddev)
 		 * A better idea might be to turn DISCARD into WRITE_ZEROES
 		 * requests, as that is required to be safe.
 		 */
-		if (devices_handle_discard_safely &&
-		    mddev->queue->limits.max_discard_sectors >= (stripe >> 9) &&
-		    mddev->queue->limits.discard_granularity >= stripe)
-			blk_queue_flag_set(QUEUE_FLAG_DISCARD,
-						mddev->queue);
-		else
-			blk_queue_flag_clear(QUEUE_FLAG_DISCARD,
-						mddev->queue);
+		if (!devices_handle_discard_safely ||
+		    mddev->queue->limits.max_discard_sectors < (stripe >> 9) ||
+		    mddev->queue->limits.discard_granularity < stripe)
+			blk_queue_max_discard_sectors(mddev->queue, 0);
 
 		blk_queue_max_hw_sectors(mddev->queue, UINT_MAX);
 	}
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c69b2d9df6f16..cac6315010a3d 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -183,7 +183,6 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	if (!max_discard)
 		return;
 
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	blk_queue_max_discard_sectors(q, max_discard);
 	q->limits.discard_granularity = card->pref_erase << 9;
 	/* granularity must not be greater than max. discard */
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 64d2b093f114b..f731721114655 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -377,7 +377,6 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, new->rq);
 
 	if (tr->discard) {
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, new->rq);
 		blk_queue_max_discard_sectors(new->rq, UINT_MAX);
 		new->rq->limits.discard_granularity = tr->blksize;
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efb85c6d8e2d5..b01300d9cd372 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1608,7 +1608,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	u32 size = queue_logical_block_size(queue);
 
 	if (ctrl->max_discard_sectors == 0) {
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
+		blk_queue_max_discard_sectors(queue, 0);
 		return;
 	}
 
@@ -1619,7 +1619,7 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	queue->limits.discard_granularity = size;
 
 	/* If discard is already enabled, don't reset queue limits */
-	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
+	if (queue->limits.max_discard_sectors)
 		return;
 
 	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index e084f4deddddd..8bd5665db9198 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -791,7 +791,6 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 
 	blk_queue_max_discard_sectors(q, max_discard_sectors);
 	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
 static int dasd_fba_pe_handler(struct dasd_device *device,
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dc6e55761fd1f..9694e2cfaf9a6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -797,7 +797,6 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	case SD_LBP_FULL:
 	case SD_LBP_DISABLE:
 		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 		return;
 
 	case SD_LBP_UNMAP:
@@ -830,7 +829,6 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 	}
 
 	blk_queue_max_discard_sectors(q, max_blocks * (logical_block_size >> 9));
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 }
 
 static blk_status_t sd_setup_unmap_cmnd(struct scsi_cmnd *cmd)
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index c3e25bac90d59..6cb9f87843278 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -838,7 +838,7 @@ bool target_configure_unmap_from_queue(struct se_dev_attrib *attrib,
 	struct request_queue *q = bdev_get_queue(bdev);
 	int block_size = bdev_logical_block_size(bdev);
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(bdev))
 		return false;
 
 	attrib->max_unmap_lba_count =
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac23..efd8deb3ab7e8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1291,7 +1291,7 @@ static int do_discard_extent(struct btrfs_io_stripe *stripe, u64 *bytes)
 		ret = btrfs_reset_device_zone(dev_replace->tgtdev, phys, len,
 					      &discarded);
 		discarded += src_disc;
-	} else if (blk_queue_discard(bdev_get_queue(stripe->dev->bdev))) {
+	} else if (bdev_max_discard_sectors(stripe->dev->bdev)) {
 		ret = btrfs_issue_discard(dev->bdev, phys, len, &discarded);
 	} else {
 		ret = 0;
@@ -5987,7 +5987,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 	*trimmed = 0;
 
 	/* Discard not supported = nothing to do. */
-	if (!blk_queue_discard(bdev_get_queue(device->bdev)))
+	if (!bdev_max_discard_sectors(device->bdev))
 		return 0;
 
 	/* Not writable = nothing to do. */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f46e71061942d..096bb0da03f1c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -501,7 +501,7 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 		if (!device->bdev)
 			continue;
 		q = bdev_get_queue(device->bdev);
-		if (blk_queue_discard(q)) {
+		if (bdev_max_discard_sectors(device->bdev)) {
 			num_devices++;
 			minlen = min_t(u64, q->limits.discard_granularity,
 				     minlen);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 2f51300592366..765e4f63dd18d 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -358,7 +358,7 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(inode->i_sb->s_bdev))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8ca21e7917d16..be0788ecaf20e 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -627,13 +627,9 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (opts->allow_utime == (unsigned short)-1)
 		opts->allow_utime = ~opts->fs_dmask & 0022;
 
-	if (opts->discard) {
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-
-		if (!blk_queue_discard(q)) {
-			exfat_warn(sb, "mounting with \"discard\" option, but the device does not support discard");
-			opts->discard = 0;
-		}
+	if (opts->discard && !bdev_max_discard_sectors(sb->s_bdev)) {
+		exfat_warn(sb, "mounting with \"discard\" option, but the device does not support discard");
+		opts->discard = 0;
 	}
 
 	sb->s_flags |= SB_NODIRATIME;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 992229ca2d830..6e3b9eea126f4 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1044,7 +1044,6 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	__u32 flags = 0;
 	unsigned int flush_flags = 0;
 	struct super_block *sb = file_inode(filp)->i_sb;
-	struct request_queue *q;
 
 	if (copy_from_user(&flags, (__u32 __user *)arg,
 				sizeof(__u32)))
@@ -1065,10 +1064,8 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID)
 		return -EINVAL;
 
-	q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
-	if (!q)
-		return -ENXIO;
-	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
+	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
+	    !bdev_max_discard_sectors(EXT4_SB(sb)->s_journal->j_dev))
 		return -EOPNOTSUPP;
 
 	if (flags & EXT4_IOC_CHECKPOINT_FLAG_DRY_RUN)
@@ -1393,14 +1390,13 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case FITRIM:
 	{
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 		struct fstrim_range range;
 		int ret = 0;
 
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		if (!blk_queue_discard(q))
+		if (!bdev_max_discard_sectors(sb->s_bdev))
 			return -EOPNOTSUPP;
 
 		/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c1..93f4e4e9e2631 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5458,13 +5458,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount9;
 	}
 
-	if (test_opt(sb, DISCARD)) {
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-		if (!blk_queue_discard(q))
-			ext4_msg(sb, KERN_WARNING,
-				 "mounting with \"discard\" option, but "
-				 "the device does not support discard");
-	}
+	if (test_opt(sb, DISCARD) && !bdev_max_discard_sectors(sb->s_bdev))
+		ext4_msg(sb, KERN_WARNING,
+			 "mounting with \"discard\" option, but the device does not support discard");
 
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cd1e65bcf0b04..0ea9a5fa7c1dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4381,8 +4381,7 @@ static inline bool f2fs_hw_should_discard(struct f2fs_sb_info *sbi)
 
 static inline bool f2fs_bdev_support_discard(struct block_device *bdev)
 {
-	return blk_queue_discard(bdev_get_queue(bdev)) ||
-	       bdev_is_zoned(bdev);
+	return bdev_max_discard_sectors(bdev) || bdev_is_zoned(bdev);
 }
 
 static inline bool f2fs_hw_support_discard(struct f2fs_sb_info *sbi)
diff --git a/fs/fat/file.c b/fs/fat/file.c
index a5a309fcc7faf..e4c7d10e80129 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -133,7 +133,7 @@ static int fat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(sb->s_bdev))
 		return -EOPNOTSUPP;
 
 	user_range = (struct fstrim_range __user *)arg;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bf6051bdf1d1d..3d1afb95a925a 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1872,13 +1872,9 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 		goto out_fail;
 	}
 
-	if (sbi->options.discard) {
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-		if (!blk_queue_discard(q))
-			fat_msg(sb, KERN_WARNING,
-					"mounting with \"discard\" option, but "
-					"the device does not support discard");
-	}
+	if (sbi->options.discard && !bdev_max_discard_sectors(sb->s_bdev))
+		fat_msg(sb, KERN_WARNING,
+			"mounting with \"discard\" option, but the device does not support discard");
 
 	fat_set_state(sb, 1, 0);
 	return 0;
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 801ad9f4f2bef..7f20ac9133bc6 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -1405,7 +1405,7 @@ int gfs2_fitrim(struct file *filp, void __user *argp)
 	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
 		return -EROFS;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(sdp->sd_vfs->s_bdev))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&r, argp, sizeof(r)))
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fcacafa4510d1..19d226cd4ff4d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1762,7 +1762,6 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 	unsigned long block, log_offset; /* logical */
 	unsigned long long phys_block, block_start, block_stop; /* physical */
 	loff_t byte_start, byte_stop, byte_count;
-	struct request_queue *q = bdev_get_queue(journal->j_dev);
 
 	/* flags must be set to either discard or zeroout */
 	if ((flags & ~JBD2_JOURNAL_FLUSH_VALID) || !flags ||
@@ -1770,10 +1769,8 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 			(flags & JBD2_JOURNAL_FLUSH_ZEROOUT)))
 		return -EINVAL;
 
-	if (!q)
-		return -ENXIO;
-
-	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
+	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) &&
+	    !bdev_max_discard_sectors(journal->j_dev))
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 03a845ab4f009..357ae6e5c36ec 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -117,7 +117,7 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		if (!blk_queue_discard(q)) {
+		if (!bdev_max_discard_sectors(sb->s_bdev)) {
 			jfs_warn("FITRIM not supported on device");
 			return -EOPNOTSUPP;
 		}
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index f1a13a74cddf3..85d4f44f2ac4d 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -372,19 +372,16 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 		}
 
 		case Opt_discard:
-		{
-			struct request_queue *q = bdev_get_queue(sb->s_bdev);
 			/* if set to 1, even copying files will cause
 			 * trimming :O
 			 * -> user has more control over the online trimming
 			 */
 			sbi->minblks_trim = 64;
-			if (blk_queue_discard(q))
+			if (bdev_max_discard_sectors(sb->s_bdev))
 				*flag |= JFS_DISCARD;
 			else
 				pr_err("JFS: discard option not supported on device\n");
 			break;
-		}
 
 		case Opt_nodiscard:
 			*flag &= ~JFS_DISCARD;
@@ -392,10 +389,9 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 
 		case Opt_discard_minblk:
 		{
-			struct request_queue *q = bdev_get_queue(sb->s_bdev);
 			char *minblks_trim = args[0].from;
 			int rc;
-			if (blk_queue_discard(q)) {
+			if (bdev_max_discard_sectors(sb->s_bdev)) {
 				*flag |= JFS_DISCARD;
 				rc = kstrtouint(minblks_trim, 0,
 						&sbi->minblks_trim);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index fec194a666f4b..52b73f558fcb1 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1059,7 +1059,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(nilfs->ns_bdev))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&range, argp, sizeof(range)))
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 787b53b984ee1..e763236169331 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -28,7 +28,7 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(sbi->sb->s_bdev))
 		return -EOPNOTSUPP;
 
 	user_range = (struct fstrim_range __user *)arg;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cd30e81abbce0..c734085bcce4a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -913,7 +913,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	rq = bdev_get_queue(bdev);
-	if (blk_queue_discard(rq) && rq->limits.discard_granularity) {
+	if (bdev_max_discard_sectors(bdev) && rq->limits.discard_granularity) {
 		sbi->discard_granularity = rq->limits.discard_granularity;
 		sbi->discard_granularity_mask_inv =
 			~(u64)(sbi->discard_granularity - 1);
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index f59461d85da45..9b78ef103ada6 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -910,7 +910,7 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		if (!blk_queue_discard(q))
+		if (!bdev_max_discard_sectors(sb->s_bdev))
 			return -EOPNOTSUPP;
 
 		if (copy_from_user(&range, argp, sizeof(range)))
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 0191de8ce9ced..a4e6609d616b7 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -162,7 +162,7 @@ xfs_ioc_trim(
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!blk_queue_discard(q))
+	if (!bdev_max_discard_sectors(mp->m_ddev_targp->bt_bdev))
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 54be9d64093ed..a276b8111f636 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1608,14 +1608,10 @@ xfs_fs_fill_super(
 			goto out_filestream_unmount;
 	}
 
-	if (xfs_has_discard(mp)) {
-		struct request_queue *q = bdev_get_queue(sb->s_bdev);
-
-		if (!blk_queue_discard(q)) {
-			xfs_warn(mp, "mounting with \"discard\" option, but "
-					"the device does not support discard");
-			mp->m_features &= ~XFS_FEAT_DISCARD;
-		}
+	if (xfs_has_discard(mp) && !bdev_max_discard_sectors(sb->s_bdev)) {
+		xfs_warn(mp,
+	"mounting with \"discard\" option, but the device does not support discard");
+		mp->m_features &= ~XFS_FEAT_DISCARD;
 	}
 
 	if (xfs_has_reflink(mp)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ce16247d3afab..767ab22e1052a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -540,7 +540,6 @@ struct request_queue {
 #define QUEUE_FLAG_NONROT	6	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT		QUEUE_FLAG_NONROT /* paravirt device */
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
-#define QUEUE_FLAG_DISCARD	8	/* supports DISCARD */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
 #define QUEUE_FLAG_SECERASE	11	/* supports secure erase */
@@ -582,7 +581,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
 #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
-#define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
 #define blk_queue_secure_erase(q) \
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4069f17a82c8e..5d9cedf9e7b84 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2957,20 +2957,6 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	return nr_extents;
 }
 
-/*
- * Helper to sys_swapon determining if a given swap
- * backing device queue supports DISCARD operations.
- */
-static bool swap_discardable(struct swap_info_struct *si)
-{
-	struct request_queue *q = bdev_get_queue(si->bdev);
-
-	if (!blk_queue_discard(q))
-		return false;
-
-	return true;
-}
-
 SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 {
 	struct swap_info_struct *p;
@@ -3132,7 +3118,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 					 sizeof(long),
 					 GFP_KERNEL);
 
-	if (p->bdev && (swap_flags & SWAP_FLAG_DISCARD) && swap_discardable(p)) {
+	if ((swap_flags & SWAP_FLAG_DISCARD) &&
+	    p->bdev && bdev_max_discard_sectors(p->bdev)) {
 		/*
 		 * When discard is enabled for swap with no particular
 		 * policy flagged, we set all swap discard flags here in
-- 
2.30.2

