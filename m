Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B544FA458
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 06:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiDIE4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Apr 2022 00:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241315AbiDIEzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Apr 2022 00:55:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C712BCB4B;
        Fri,  8 Apr 2022 21:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description;
        bh=MR1dBREWEzr7uhm77WcgVZfNn+irLPCXxWfbv0Y8Fx8=; b=g1JrWZZU7gXqi54KSSq2td5NGg
        JTv8uprg5injPH7nKkeNRWdn6oTNLWZZnzaHqHhPeHQKztSOiA4sj9FfMAEZJ7/a9B/nIKLTwqwGB
        PuDRNI4dm2AH1PLgWy6G6WT6g3S55JW0fBof3tJZn4+4Uz4tLd0IKxpSOJszbSZ5S5fhGHf6HQiq8
        tfOI2qhlZHSzdLNHIOgkox+DFYK8KmZY72c/I/6yjiFdBqWpjKEKpQemLV7RLvoqpLXmpYDnm9R+M
        6+YRTeKl4k0OAcFvjw1Z1NHUh/0kBaNpv9L8pEjsBLMomqJ9Ip1F1RfoaNm2SYWGY95WZH5q/4P5S
        xDXG8m/A==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nd35C-0021lf-95; Sat, 09 Apr 2022 04:52:23 +0000
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
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Coly Li <colyli@suse.de>, David Sterba <dsterba@suse.com>
Subject: [PATCH 26/27] block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD
Date:   Sat,  9 Apr 2022 06:50:42 +0200
Message-Id: <20220409045043.23593-27-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
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

Secure erase is a very different operation from discard in that it is
a data integrity operation vs hint.  Fully split the limits and helper
infrastructure to make the separation more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com> [drbd]
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com> [nifs2]
Acked-by: Coly Li <colyli@suse.de> [drbd]
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
---
 block/blk-core.c                    |  2 +-
 block/blk-lib.c                     | 64 ++++++++++++++++++++---------
 block/blk-mq-debugfs.c              |  1 -
 block/blk-settings.c                | 16 +++++++-
 block/fops.c                        |  2 +-
 block/ioctl.c                       | 43 +++++++++++++++----
 drivers/block/drbd/drbd_receiver.c  |  5 ++-
 drivers/block/rnbd/rnbd-clt.c       |  4 +-
 drivers/block/rnbd/rnbd-srv-dev.h   |  2 +-
 drivers/block/xen-blkback/blkback.c | 15 +++----
 drivers/block/xen-blkback/xenbus.c  |  5 +--
 drivers/block/xen-blkfront.c        |  5 ++-
 drivers/md/bcache/alloc.c           |  2 +-
 drivers/md/dm-table.c               |  8 ++--
 drivers/md/dm-thin.c                |  4 +-
 drivers/md/md.c                     |  2 +-
 drivers/md/raid5-cache.c            |  6 +--
 drivers/mmc/core/queue.c            |  2 +-
 drivers/nvme/target/io-cmd-bdev.c   |  2 +-
 drivers/target/target_core_file.c   |  2 +-
 drivers/target/target_core_iblock.c |  2 +-
 fs/btrfs/extent-tree.c              |  4 +-
 fs/ext4/mballoc.c                   |  2 +-
 fs/f2fs/file.c                      | 16 ++++----
 fs/f2fs/segment.c                   |  2 +-
 fs/jbd2/journal.c                   |  2 +-
 fs/nilfs2/sufile.c                  |  4 +-
 fs/nilfs2/the_nilfs.c               |  4 +-
 fs/ntfs3/super.c                    |  2 +-
 fs/xfs/xfs_discard.c                |  2 +-
 fs/xfs/xfs_log_cil.c                |  2 +-
 include/linux/blkdev.h              | 27 +++++++-----
 mm/swapfile.c                       |  6 +--
 33 files changed, 168 insertions(+), 99 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b5c3a8049134c..ee18b6a699bdf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -824,7 +824,7 @@ void submit_bio_noacct(struct bio *bio)
 			goto not_supported;
 		break;
 	case REQ_OP_SECURE_ERASE:
-		if (!blk_queue_secure_erase(q))
+		if (!bdev_max_secure_erase_sectors(bdev))
 			goto not_supported;
 		break;
 	case REQ_OP_ZONE_APPEND:
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 43aa4d7fe859f..09b7e1200c0f4 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -36,26 +36,15 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 }
 
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, int flags,
-		struct bio **biop)
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
-	unsigned int op;
 	sector_t bs_mask;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
-
-	if (flags & BLKDEV_DISCARD_SECURE) {
-		if (!blk_queue_secure_erase(q))
-			return -EOPNOTSUPP;
-		op = REQ_OP_SECURE_ERASE;
-	} else {
-		if (!bdev_max_discard_sectors(bdev))
-			return -EOPNOTSUPP;
-		op = REQ_OP_DISCARD;
-	}
+	if (!bdev_max_discard_sectors(bdev))
+		return -EOPNOTSUPP;
 
 	/* In case the discard granularity isn't set by buggy device driver */
 	if (WARN_ON_ONCE(!bdev_discard_granularity(bdev))) {
@@ -77,7 +66,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t req_sects =
 			min(nr_sects, bio_discard_limit(bdev, sector));
 
-		bio = blk_next_bio(bio, bdev, 0, op, gfp_mask);
+		bio = blk_next_bio(bio, bdev, 0, REQ_OP_DISCARD, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -103,21 +92,19 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
  * @sector:	start sector
  * @nr_sects:	number of sectors to discard
  * @gfp_mask:	memory allocation flags (for bio_alloc)
- * @flags:	BLKDEV_DISCARD_* flags to control behaviour
  *
  * Description:
  *    Issue a discard request for the sectors in question.
  */
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
+		sector_t nr_sects, gfp_t gfp_mask)
 {
 	struct bio *bio = NULL;
 	struct blk_plug plug;
 	int ret;
 
 	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, flags,
-			&bio);
+	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
 	if (!ret && bio) {
 		ret = submit_bio_wait(bio);
 		if (ret == -EOPNOTSUPP)
@@ -314,3 +301,42 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_zeroout);
+
+int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp)
+{
+	sector_t bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
+	unsigned int max_sectors = bdev_max_secure_erase_sectors(bdev);
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret = 0;
+
+	if (max_sectors == 0)
+		return -EOPNOTSUPP;
+	if ((sector | nr_sects) & bs_mask)
+		return -EINVAL;
+	if (bdev_read_only(bdev))
+		return -EPERM;
+
+	blk_start_plug(&plug);
+	for (;;) {
+		unsigned int len = min_t(sector_t, nr_sects, max_sectors);
+
+		bio = blk_next_bio(bio, bdev, 0, REQ_OP_SECURE_ERASE, gfp);
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_iter.bi_size = len;
+
+		sector += len << SECTOR_SHIFT;
+		nr_sects -= len << SECTOR_SHIFT;
+		if (!nr_sects) {
+			ret = submit_bio_wait(bio);
+			bio_put(bio);
+			break;
+		}
+		cond_resched();
+	}
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+EXPORT_SYMBOL(blkdev_issue_secure_erase);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index fd111c5001256..7e4136a60e1cc 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -115,7 +115,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(IO_STAT),
 	QUEUE_FLAG_NAME(NOXMERGES),
 	QUEUE_FLAG_NAME(ADD_RANDOM),
-	QUEUE_FLAG_NAME(SECERASE),
 	QUEUE_FLAG_NAME(SAME_FORCE),
 	QUEUE_FLAG_NAME(DEAD),
 	QUEUE_FLAG_NAME(INIT_DONE),
diff --git a/block/blk-settings.c b/block/blk-settings.c
index fd83d674afd0a..6ccceb421ed2f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -46,6 +46,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_zone_append_sectors = 0;
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
+	lim->max_secure_erase_sectors = 0;
 	lim->discard_granularity = 0;
 	lim->discard_alignment = 0;
 	lim->discard_misaligned = 0;
@@ -176,6 +177,18 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
+ * @q:  the request queue for the device
+ * @max_sectors: maximum number of sectors to secure_erase
+ **/
+void blk_queue_max_secure_erase_sectors(struct request_queue *q,
+		unsigned int max_sectors)
+{
+	q->limits.max_secure_erase_sectors = max_sectors;
+}
+EXPORT_SYMBOL(blk_queue_max_secure_erase_sectors);
+
 /**
  * blk_queue_max_write_zeroes_sectors - set max sectors for a single
  *                                      write zeroes
@@ -661,7 +674,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->discard_alignment = lcm_not_zero(t->discard_alignment, alignment) %
 			t->discard_granularity;
 	}
-
+	t->max_secure_erase_sectors = min_not_zero(t->max_secure_erase_sectors,
+						   b->max_secure_erase_sectors);
 	t->zone_write_granularity = max(t->zone_write_granularity,
 					b->zone_write_granularity);
 	t->zoned = max(t->zoned, b->zoned);
diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b04..c0ca3254d38cf 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -672,7 +672,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 		break;
 	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
 		error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					     len >> SECTOR_SHIFT, GFP_KERNEL, 0);
+					     len >> SECTOR_SHIFT, GFP_KERNEL);
 		break;
 	default:
 		error = -EOPNOTSUPP;
diff --git a/block/ioctl.c b/block/ioctl.c
index c2cd3ba5290ce..5b5027fa78f7e 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -83,7 +83,7 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 #endif
 
 static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
-		unsigned long arg, unsigned long flags)
+		unsigned long arg)
 {
 	uint64_t range[2];
 	uint64_t start, len;
@@ -114,15 +114,43 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
-
-	err = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-				   GFP_KERNEL, flags);
-
+	err = blkdev_issue_discard(bdev, start >> 9, len >> 9, GFP_KERNEL);
 fail:
 	filemap_invalidate_unlock(inode->i_mapping);
 	return err;
 }
 
+static int blk_ioctl_secure_erase(struct block_device *bdev, fmode_t mode,
+		void __user *argp)
+{
+	uint64_t start, len;
+	uint64_t range[2];
+	int err;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+	if (!bdev_max_secure_erase_sectors(bdev))
+		return -EOPNOTSUPP;
+	if (copy_from_user(range, argp, sizeof(range)))
+		return -EFAULT;
+
+	start = range[0];
+	len = range[1];
+	if ((start & 511) || (len & 511))
+		return -EINVAL;
+	if (start + len > bdev_nr_bytes(bdev))
+		return -EINVAL;
+
+	filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
+	if (!err)
+		err = blkdev_issue_secure_erase(bdev, start >> 9, len >> 9,
+						GFP_KERNEL);
+	filemap_invalidate_unlock(bdev->bd_inode->i_mapping);
+	return err;
+}
+
+
 static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
@@ -450,10 +478,9 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKROSET:
 		return blkdev_roset(bdev, mode, cmd, arg);
 	case BLKDISCARD:
-		return blk_ioctl_discard(bdev, mode, arg, 0);
+		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
-		return blk_ioctl_discard(bdev, mode, arg,
-				BLKDEV_DISCARD_SECURE);
+		return blk_ioctl_secure_erase(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 275c53c7b629e..2957b0b68d600 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1547,7 +1547,8 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 		start = tmp;
 	}
 	while (nr_sectors >= max_discard_sectors) {
-		err |= blkdev_issue_discard(bdev, start, max_discard_sectors, GFP_NOIO, 0);
+		err |= blkdev_issue_discard(bdev, start, max_discard_sectors,
+					    GFP_NOIO);
 		nr_sectors -= max_discard_sectors;
 		start += max_discard_sectors;
 	}
@@ -1559,7 +1560,7 @@ int drbd_issue_discard_or_zero_out(struct drbd_device *device, sector_t start, u
 		nr = nr_sectors;
 		nr -= (unsigned int)nr % granularity;
 		if (nr) {
-			err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO, 0);
+			err |= blkdev_issue_discard(bdev, start, nr, GFP_NOIO);
 			nr_sectors -= nr;
 			start += nr;
 		}
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index efa99a3884507..d178be175ad99 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1365,8 +1365,8 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	dev->queue->limits.discard_granularity	= dev->discard_granularity;
 	dev->queue->limits.discard_alignment	= dev->discard_alignment;
 	if (dev->secure_discard)
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, dev->queue);
-
+		blk_queue_max_secure_erase_sectors(dev->queue,
+				dev->max_discard_sectors);
 	blk_queue_flag_set(QUEUE_FLAG_SAME_COMP, dev->queue);
 	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, dev->queue);
 	blk_queue_max_segments(dev->queue, dev->max_segments);
diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 1f7e1c8fd4d9b..d080a0de59225 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -44,7 +44,7 @@ static inline int rnbd_dev_get_max_hw_sects(const struct rnbd_dev *dev)
 
 static inline int rnbd_dev_get_secure_discard(const struct rnbd_dev *dev)
 {
-	return blk_queue_secure_erase(bdev_get_queue(dev->bdev));
+	return bdev_max_secure_erase_sectors(dev->bdev);
 }
 
 static inline int rnbd_dev_get_max_discard_sects(const struct rnbd_dev *dev)
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index de42458195bc1..a97f2bf5b01b9 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -970,7 +970,6 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	int status = BLKIF_RSP_OKAY;
 	struct xen_blkif *blkif = ring->blkif;
 	struct block_device *bdev = blkif->vbd.bdev;
-	unsigned long secure;
 	struct phys_req preq;
 
 	xen_blkif_get(blkif);
@@ -987,13 +986,15 @@ static int dispatch_discard_io(struct xen_blkif_ring *ring,
 	}
 	ring->st_ds_req++;
 
-	secure = (blkif->vbd.discard_secure &&
-		 (req->u.discard.flag & BLKIF_DISCARD_SECURE)) ?
-		 BLKDEV_DISCARD_SECURE : 0;
+	if (blkif->vbd.discard_secure &&
+	    (req->u.discard.flag & BLKIF_DISCARD_SECURE))
+		err = blkdev_issue_secure_erase(bdev,
+				req->u.discard.sector_number,
+				req->u.discard.nr_sectors, GFP_KERNEL);
+	else
+		err = blkdev_issue_discard(bdev, req->u.discard.sector_number,
+				req->u.discard.nr_sectors, GFP_KERNEL);
 
-	err = blkdev_issue_discard(bdev, req->u.discard.sector_number,
-				   req->u.discard.nr_sectors,
-				   GFP_KERNEL, secure);
 fail_response:
 	if (err == -EOPNOTSUPP) {
 		pr_debug("discard op failed, not supported\n");
diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 83cd08041e6b3..b21bffc9c50bc 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -484,7 +484,6 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 {
 	struct xen_vbd *vbd;
 	struct block_device *bdev;
-	struct request_queue *q;
 
 	vbd = &blkif->vbd;
 	vbd->handle   = handle;
@@ -516,11 +515,9 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 	if (vbd->bdev->bd_disk->flags & GENHD_FL_REMOVABLE)
 		vbd->type |= VDISK_REMOVABLE;
 
-	q = bdev_get_queue(bdev);
 	if (bdev_write_cache(bdev))
 		vbd->flush_support = true;
-
-	if (q && blk_queue_secure_erase(q))
+	if (bdev_max_secure_erase_sectors(bdev))
 		vbd->discard_secure = true;
 
 	vbd->feature_gnt_persistent = feature_persistent;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 253bf835aca1f..9fb7c69f72b2d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -949,7 +949,8 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 						 info->physical_sector_size;
 		rq->limits.discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
-			blk_queue_flag_set(QUEUE_FLAG_SECERASE, rq);
+			blk_queue_max_secure_erase_sectors(rq,
+							   get_capacity(gd));
 	}
 
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
@@ -1605,7 +1606,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				blkif_req(req)->error = BLK_STS_NOTSUPP;
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
-				blk_queue_flag_clear(QUEUE_FLAG_SECERASE, rq);
+				blk_queue_max_secure_erase_sectors(rq, 0);
 			}
 			break;
 		case BLKIF_OP_FLUSH_DISKCACHE:
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 097577ae3c471..ce13c272c3872 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -336,7 +336,7 @@ static int bch_allocator_thread(void *arg)
 				mutex_unlock(&ca->set->bucket_lock);
 				blkdev_issue_discard(ca->bdev,
 					bucket_to_sector(ca->set, bucket),
-					ca->sb.bucket_size, GFP_KERNEL, 0);
+					ca->sb.bucket_size, GFP_KERNEL);
 				mutex_lock(&ca->set->bucket_lock);
 			}
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0dff6907fd00d..e7d42f6335a2a 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1920,9 +1920,7 @@ static int device_not_secure_erase_capable(struct dm_target *ti,
 					   struct dm_dev *dev, sector_t start,
 					   sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return !blk_queue_secure_erase(q);
+	return !bdev_max_secure_erase_sectors(dev->bdev);
 }
 
 static bool dm_table_supports_secure_erase(struct dm_table *t)
@@ -1975,8 +1973,8 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
-	if (dm_table_supports_secure_erase(t))
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
+	if (!dm_table_supports_secure_erase(t))
+		q->limits.max_secure_erase_sectors = 0;
 
 	if (dm_table_supports_flush(t, (1UL << QUEUE_FLAG_WC))) {
 		wc = true;
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index eded4bcc4545f..84c083f766736 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -398,8 +398,8 @@ static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_block_t da
 	sector_t s = block_to_sectors(tc->pool, data_b);
 	sector_t len = block_to_sectors(tc->pool, data_e - data_b);
 
-	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len,
-				      GFP_NOWAIT, 0, &op->bio);
+	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOWAIT,
+				      &op->bio);
 }
 
 static void end_discard(struct discard_op *op, int r)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 19636c2f2cda4..2587f872c0884 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8584,7 +8584,7 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, 0,
+	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
 			&discard_bio) || !discard_bio)
 		return;
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index c3cbf9a574a39..094a4042589eb 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1344,14 +1344,14 @@ static void r5l_write_super_and_discard_space(struct r5l_log *log,
 	if (log->last_checkpoint < end) {
 		blkdev_issue_discard(bdev,
 				log->last_checkpoint + log->rdev->data_offset,
-				end - log->last_checkpoint, GFP_NOIO, 0);
+				end - log->last_checkpoint, GFP_NOIO);
 	} else {
 		blkdev_issue_discard(bdev,
 				log->last_checkpoint + log->rdev->data_offset,
 				log->device_size - log->last_checkpoint,
-				GFP_NOIO, 0);
+				GFP_NOIO);
 		blkdev_issue_discard(bdev, log->rdev->data_offset, end,
-				GFP_NOIO, 0);
+				GFP_NOIO);
 	}
 }
 
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index cac6315010a3d..a3d4460055716 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -189,7 +189,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = SECTOR_SIZE;
 	if (mmc_can_secure_erase_trim(card))
-		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
+		blk_queue_max_secure_erase_sectors(q, max_discard);
 }
 
 static unsigned short mmc_get_max_segments(struct mmc_host *host)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index d886c2c59554f..27a72504d31ce 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -360,7 +360,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 	ret = __blkdev_issue_discard(ns->bdev,
 			nvmet_lba_to_sect(ns, range->slba),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
-			GFP_KERNEL, 0, bio);
+			GFP_KERNEL, bio);
 	if (ret && ret != -EOPNOTSUPP) {
 		req->error_slba = le64_to_cpu(range->slba);
 		return errno_to_nvme_status(req, ret);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index b6ba582b06775..e68f1cc8ef98b 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -558,7 +558,7 @@ fd_execute_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
 		ret = blkdev_issue_discard(bdev,
 					   target_to_linux_sector(dev, lba),
 					   target_to_linux_sector(dev,  nolb),
-					   GFP_KERNEL, 0);
+					   GFP_KERNEL);
 		if (ret < 0) {
 			pr_warn("FILEIO: blkdev_issue_discard() failed: %d\n",
 				ret);
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index c4a903b8a47fc..378c80313a0f2 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -434,7 +434,7 @@ iblock_execute_unmap(struct se_cmd *cmd, sector_t lba, sector_t nolb)
 	ret = blkdev_issue_discard(bdev,
 				   target_to_linux_sector(dev, lba),
 				   target_to_linux_sector(dev,  nolb),
-				   GFP_KERNEL, 0);
+				   GFP_KERNEL);
 	if (ret < 0) {
 		pr_err("blkdev_issue_discard() failed: %d\n", ret);
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index efd8deb3ab7e8..5c1d3a564da5a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1239,7 +1239,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 
 		if (size) {
 			ret = blkdev_issue_discard(bdev, start >> 9, size >> 9,
-						   GFP_NOFS, 0);
+						   GFP_NOFS);
 			if (!ret)
 				*discarded_bytes += size;
 			else if (ret != -EOPNOTSUPP)
@@ -1256,7 +1256,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 
 	if (bytes_left) {
 		ret = blkdev_issue_discard(bdev, start >> 9, bytes_left >> 9,
-					   GFP_NOFS, 0);
+					   GFP_NOFS);
 		if (!ret)
 			*discarded_bytes += bytes_left;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 6d1820536d88d..ea653d19f9ec7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3629,7 +3629,7 @@ static inline int ext4_issue_discard(struct super_block *sb,
 		return __blkdev_issue_discard(sb->s_bdev,
 			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
 			(sector_t)count << (sb->s_blocksize_bits - 9),
-			GFP_NOFS, 0, biop);
+			GFP_NOFS, biop);
 	} else
 		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8053d99f3920b..35b6c720c2bc1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3685,18 +3685,18 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 static int f2fs_secure_erase(struct block_device *bdev, struct inode *inode,
 		pgoff_t off, block_t block, block_t len, u32 flags)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
 	sector_t sector = SECTOR_FROM_BLOCK(block);
 	sector_t nr_sects = SECTOR_FROM_BLOCK(len);
 	int ret = 0;
 
-	if (!q)
-		return -ENXIO;
-
-	if (flags & F2FS_TRIM_FILE_DISCARD)
-		ret = blkdev_issue_discard(bdev, sector, nr_sects, GFP_NOFS,
-						blk_queue_secure_erase(q) ?
-						BLKDEV_DISCARD_SECURE : 0);
+	if (flags & F2FS_TRIM_FILE_DISCARD) {
+		if (bdev_max_secure_erase_sectors(bdev))
+			ret = blkdev_issue_secure_erase(bdev, sector, nr_sects,
+					GFP_NOFS);
+		else
+			ret = blkdev_issue_discard(bdev, sector, nr_sects,
+					GFP_NOFS);
+	}
 
 	if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
 		if (IS_ENCRYPTED(inode))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 71f09adbcba86..e433c61e64b93 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1244,7 +1244,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		err = __blkdev_issue_discard(bdev,
 					SECTOR_FROM_BLOCK(start),
 					SECTOR_FROM_BLOCK(len),
-					GFP_NOFS, 0, &bio);
+					GFP_NOFS, &bio);
 submit:
 		if (err) {
 			spin_lock_irqsave(&dc->lock, flags);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 19d226cd4ff4d..c0cbeeaec2d1a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1825,7 +1825,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 			err = blkdev_issue_discard(journal->j_dev,
 					byte_start >> SECTOR_SHIFT,
 					byte_count >> SECTOR_SHIFT,
-					GFP_NOFS, 0);
+					GFP_NOFS);
 		} else if (flags & JBD2_JOURNAL_FLUSH_ZEROOUT) {
 			err = blkdev_issue_zeroout(journal->j_dev,
 					byte_start >> SECTOR_SHIFT,
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index e385cca2004a7..77ff8e95421fa 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -1100,7 +1100,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 				ret = blkdev_issue_discard(nilfs->ns_bdev,
 						start * sects_per_block,
 						nblocks * sects_per_block,
-						GFP_NOFS, 0);
+						GFP_NOFS);
 				if (ret < 0) {
 					put_bh(su_bh);
 					goto out_sem;
@@ -1134,7 +1134,7 @@ int nilfs_sufile_trim_fs(struct inode *sufile, struct fstrim_range *range)
 			ret = blkdev_issue_discard(nilfs->ns_bdev,
 					start * sects_per_block,
 					nblocks * sects_per_block,
-					GFP_NOFS, 0);
+					GFP_NOFS);
 			if (!ret)
 				ndiscarded += nblocks;
 		}
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index dd48a8f74d577..3b4a079c9617c 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -672,7 +672,7 @@ int nilfs_discard_segments(struct the_nilfs *nilfs, __u64 *segnump,
 			ret = blkdev_issue_discard(nilfs->ns_bdev,
 						   start * sects_per_block,
 						   nblocks * sects_per_block,
-						   GFP_NOFS, 0);
+						   GFP_NOFS);
 			if (ret < 0)
 				return ret;
 			nblocks = 0;
@@ -682,7 +682,7 @@ int nilfs_discard_segments(struct the_nilfs *nilfs, __u64 *segnump,
 		ret = blkdev_issue_discard(nilfs->ns_bdev,
 					   start * sects_per_block,
 					   nblocks * sects_per_block,
-					   GFP_NOFS, 0);
+					   GFP_NOFS);
 	return ret;
 }
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 5f2e414cfa79b..5781b9e8e3d85 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1333,7 +1333,7 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 		return 0;
 
 	err = blkdev_issue_discard(sb->s_bdev, start >> 9, (end - start) >> 9,
-				   GFP_NOFS, 0);
+				   GFP_NOFS);
 
 	if (err == -EOPNOTSUPP)
 		sbi->flags |= NTFS_FLAGS_NODISCARD;
diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index e2ada115c23f9..c6fe3f6ebb6b0 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -114,7 +114,7 @@ xfs_trim_extents(
 		}
 
 		trace_xfs_discard_extent(mp, agno, fbno, flen);
-		error = blkdev_issue_discard(bdev, dbno, dlen, GFP_NOFS, 0);
+		error = blkdev_issue_discard(bdev, dbno, dlen, GFP_NOFS);
 		if (error)
 			goto out_del_cursor;
 		*blocks_trimmed += flen;
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index ba57323bfdcea..c9f55e4f09571 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -605,7 +605,7 @@ xlog_discard_busy_extents(
 		error = __blkdev_issue_discard(mp->m_ddev_targp->bt_bdev,
 				XFS_AGB_TO_DADDR(mp, busyp->agno, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
-				GFP_NOFS, 0, &bio);
+				GFP_NOFS, &bio);
 		if (error && error != -EOPNOTSUPP) {
 			xfs_info(mp,
 	 "discard failed for extent [0x%llx,%u], error %d",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f1cf557ea20ef..c9b5925af5a3b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -248,6 +248,7 @@ struct queue_limits {
 	unsigned int		io_opt;
 	unsigned int		max_discard_sectors;
 	unsigned int		max_hw_discard_sectors;
+	unsigned int		max_secure_erase_sectors;
 	unsigned int		max_write_zeroes_sectors;
 	unsigned int		max_zone_append_sectors;
 	unsigned int		discard_granularity;
@@ -542,7 +543,6 @@ struct request_queue {
 #define QUEUE_FLAG_IO_STAT	7	/* do disk/partitions IO accounting */
 #define QUEUE_FLAG_NOXMERGES	9	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
-#define QUEUE_FLAG_SECERASE	11	/* supports secure erase */
 #define QUEUE_FLAG_SAME_FORCE	12	/* force complete on same CPU */
 #define QUEUE_FLAG_DEAD		13	/* queue tear-down finished */
 #define QUEUE_FLAG_INIT_DONE	14	/* queue is initialized */
@@ -583,8 +583,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
 #define blk_queue_zone_resetall(q)	\
 	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
-#define blk_queue_secure_erase(q) \
-	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
@@ -947,6 +945,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
 extern void blk_queue_max_segments(struct request_queue *, unsigned short);
 extern void blk_queue_max_discard_segments(struct request_queue *,
 		unsigned short);
+void blk_queue_max_secure_erase_sectors(struct request_queue *q,
+		unsigned int max_sectors);
 extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
 extern void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors);
@@ -1087,13 +1087,12 @@ static inline long nr_blockdev_pages(void)
 
 extern void blk_io_schedule(void);
 
-#define BLKDEV_DISCARD_SECURE	(1 << 0)	/* issue a secure erase */
-
-extern int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags);
-extern int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, int flags,
-		struct bio **biop);
+int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask);
+int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
+int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
@@ -1112,7 +1111,7 @@ static inline int sb_issue_discard(struct super_block *sb, sector_t block,
 					      SECTOR_SHIFT),
 				    nr_blocks << (sb->s_blocksize_bits -
 						  SECTOR_SHIFT),
-				    gfp_mask, flags);
+				    gfp_mask);
 }
 static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 		sector_t nr_blocks, gfp_t gfp_mask)
@@ -1262,6 +1261,12 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 	return bdev_get_queue(bdev)->limits.discard_granularity;
 }
 
+static inline unsigned int
+bdev_max_secure_erase_sectors(struct block_device *bdev)
+{
+	return bdev_get_queue(bdev)->limits.max_secure_erase_sectors;
+}
+
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5d9cedf9e7b84..a2b31fea0c42e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -179,7 +179,7 @@ static int discard_swap(struct swap_info_struct *si)
 	nr_blocks = ((sector_t)se->nr_pages - 1) << (PAGE_SHIFT - 9);
 	if (nr_blocks) {
 		err = blkdev_issue_discard(si->bdev, start_block,
-				nr_blocks, GFP_KERNEL, 0);
+				nr_blocks, GFP_KERNEL);
 		if (err)
 			return err;
 		cond_resched();
@@ -190,7 +190,7 @@ static int discard_swap(struct swap_info_struct *si)
 		nr_blocks = (sector_t)se->nr_pages << (PAGE_SHIFT - 9);
 
 		err = blkdev_issue_discard(si->bdev, start_block,
-				nr_blocks, GFP_KERNEL, 0);
+				nr_blocks, GFP_KERNEL);
 		if (err)
 			break;
 
@@ -254,7 +254,7 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 		start_block <<= PAGE_SHIFT - 9;
 		nr_blocks <<= PAGE_SHIFT - 9;
 		if (blkdev_issue_discard(si->bdev, start_block,
-					nr_blocks, GFP_NOIO, 0))
+					nr_blocks, GFP_NOIO))
 			break;
 
 		se = next_se(se);
-- 
2.30.2

