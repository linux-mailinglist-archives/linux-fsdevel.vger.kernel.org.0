Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45076259633
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgIAP77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbgIAP6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99636C061246;
        Tue,  1 Sep 2020 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LCcuCSBOWzTZR3L36Z4teH3hguC0YRk5e9B06CtwpM4=; b=LG/NOf2vrc6lYei/L+Z1eIthrC
        Za7US4iSKJ/WbIV7qWmAJ4Zu1f8kKzD4dm8IzfowUCXLWl2I6CnTcjAYKNXubYJJWog9OQzVKNgQU
        JKQDJU8aOtSTbsbcLVBwrAsrpV6hzAKa7q6dA/KOwR9PS0JPpwrDP1f7JfI4olB8rlAhi95L7rcKs
        8CZnpd3idN3ZzmwJXd2ljKFmNBf+bkl4mvPHkeXR9GUdRubRYSpy4bItm3vyPzEv5RUdxXiTabkno
        fQzNt+/AYYrnyHlQd3b9AyQHRPscfouXB92OUylsk0dDYPodZbsybBY2fYyHseMPXSzaZnVYZu8k2
        Ht1LyIFQ==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fS-0004Ov-PT; Tue, 01 Sep 2020 15:57:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] block: rename bd_invalidated
Date:   Tue,  1 Sep 2020 17:57:42 +0200
Message-Id: <20200901155748.2884-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace bd_invalidate with a new BDEV_NEED_PART_SCAN flag in a bd_flags
variable to better describe the condition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c             |  2 +-
 drivers/block/nbd.c       |  8 ++++----
 fs/block_dev.c            | 10 +++++-----
 include/linux/blk_types.h |  4 +++-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c3148c..a2c0ec694918e5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -734,7 +734,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	if (!bdev)
 		goto exit;
 
-	bdev->bd_invalidated = 1;
+	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	err = blkdev_get(bdev, FMODE_READ, NULL);
 	if (err < 0)
 		goto exit;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a54f2d155a31a5..15eed210feeff4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -315,7 +315,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 			bd_set_nr_sectors(bdev, nr_sectors);
 			set_blocksize(bdev, config->blksize);
 		} else
-			bdev->bd_invalidated = 1;
+			set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 		bdput(bdev);
 	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
@@ -1322,7 +1322,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 		return ret;
 
 	if (max_part)
-		bdev->bd_invalidated = 1;
+		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
@@ -1500,9 +1500,9 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
-		bdev->bd_invalidated = 1;
+		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	} else if (nbd_disconnected(nbd->config)) {
-		bdev->bd_invalidated = 1;
+		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	}
 out:
 	mutex_unlock(&nbd_index_mutex);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2760292045c082..0207623769715d 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -881,7 +881,7 @@ struct block_device *bdget(dev_t dev)
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
 		bdev->bd_part_count = 0;
-		bdev->bd_invalidated = 0;
+		bdev->bd_flags = 0;
 		inode->i_mode = S_IFBLK;
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
@@ -1365,7 +1365,7 @@ int check_disk_change(struct block_device *bdev)
 	if (__invalidate_device(bdev, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			disk->disk_name);
-	bdev->bd_invalidated = 1;
+	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 	if (bdops->revalidate_disk)
 		bdops->revalidate_disk(bdev->bd_disk);
 	return 1;
@@ -1390,7 +1390,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	bdev->bd_invalidated = 0;
+	clear_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
 
 rescan:
 	ret = blk_drop_partitions(bdev);
@@ -1528,7 +1528,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			 * The latter is necessary to prevent ghost
 			 * partitions on a removed medium.
 			 */
-			if (bdev->bd_invalidated &&
+			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
 			    (!ret || ret == -ENOMEDIUM))
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
@@ -1558,7 +1558,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 			/* the same as first opener case, read comment there */
-			if (bdev->bd_invalidated &&
+			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
 			    (!ret || ret == -ENOMEDIUM))
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 			if (ret)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 63a39e47fc6047..c21eff7efda237 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -19,6 +19,8 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
+#define BDEV_NEED_PART_SCAN		0
+
 struct block_device {
 	dev_t			bd_dev;  /* not a kdev_t - it's a search key */
 	int			bd_openers;
@@ -37,7 +39,7 @@ struct block_device {
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
-	int			bd_invalidated;
+	unsigned long		bd_flags;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
-- 
2.28.0

