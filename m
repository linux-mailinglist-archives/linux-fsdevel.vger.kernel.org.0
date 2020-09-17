Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8026E198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgIQRB7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgIQRB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:01:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CABC061756;
        Thu, 17 Sep 2020 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ezfq9/HhvT27qSext7o43eb8FqswuribWTEc7lyTkRU=; b=HbhEn3C/BsFhAWRE+2fvVuiSAe
        kpapO+cEjw0GcpsmvKwJkPyeWa9w/4H1RaNf+clTI4z9YRICdP8HH8LeNQ1KU75oaBXBA9w++hfPo
        MM44EqtfWhH97hK0SYWBvNMEf7hxEhH92MxbW2AsOIKCCfTB6jPmqc+YlKlTH/SH4B1vzhmj0xcDc
        QroGG5MUhHZ7lEszHcqqsJC8Jkp6NB95QP8tCZG+qLdfWyqnlNe7jvAL+2sDfXJojmPriX0PAR8ze
        8j5wQHB+yMvKwaPIS+bnIAMvhgMHNqnc7cXtdrbLPhm9BO40ymzy3LtVKBqVurPCI3B6wFxH1a3dL
        Y7xMTp3g==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxHz-0000Or-RK; Thu, 17 Sep 2020 17:01:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH 01/14] block: move the NEED_PART_SCAN flag to struct gendisk
Date:   Thu, 17 Sep 2020 18:57:07 +0200
Message-Id: <20200917165720.3285256-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can only scan for partitions on the whole disk, so move the flag
from struct block_device to struct gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c             | 4 ++--
 drivers/block/nbd.c       | 8 ++++----
 drivers/ide/ide-gd.c      | 2 +-
 fs/block_dev.c            | 7 +++----
 include/linux/blk_types.h | 4 +---
 include/linux/genhd.h     | 2 ++
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9d060e79eb31d8..7b56203c90a303 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -731,7 +731,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 	if (!bdev)
 		goto exit;
 
-	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	err = blkdev_get(bdev, FMODE_READ, NULL);
 	if (err < 0)
 		goto exit;
@@ -2112,7 +2112,7 @@ bool bdev_check_media_change(struct block_device *bdev)
 	if (__invalidate_device(bdev, true))
 		pr_warn("VFS: busy inodes on changed media %s\n",
 			bdev->bd_disk->disk_name);
-	set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	return true;
 }
 EXPORT_SYMBOL(bdev_check_media_change);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 15eed210feeff4..2dca0aab0a9a25 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -315,7 +315,7 @@ static void nbd_size_update(struct nbd_device *nbd)
 			bd_set_nr_sectors(bdev, nr_sectors);
 			set_blocksize(bdev, config->blksize);
 		} else
-			set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+			set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 		bdput(bdev);
 	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
@@ -1322,7 +1322,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
 		return ret;
 
 	if (max_part)
-		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+		set_bit(GD_NEED_PART_SCAN, &nbd->disk->state);
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
@@ -1500,9 +1500,9 @@ static int nbd_open(struct block_device *bdev, fmode_t mode)
 		refcount_set(&nbd->config_refs, 1);
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
-		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	} else if (nbd_disconnected(nbd->config)) {
-		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+		set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	}
 out:
 	mutex_unlock(&nbd_index_mutex);
diff --git a/drivers/ide/ide-gd.c b/drivers/ide/ide-gd.c
index 661e2aa9c96784..e2b6c82586ce8b 100644
--- a/drivers/ide/ide-gd.c
+++ b/drivers/ide/ide-gd.c
@@ -230,7 +230,7 @@ static int ide_gd_open(struct block_device *bdev, fmode_t mode)
 				bdev->bd_disk->disk_name);
 		drive->disk_ops->get_capacity(drive);
 		set_capacity(disk, ide_gd_capacity(drive));
-		set_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+		set_bit(GD_NEED_PART_SCAN, &disk->state);
 	} else if (drive->dev_flags & IDE_DFLAG_FORMAT_IN_PROGRESS) {
 		ret = -EBUSY;
 		goto out_put_idkp;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0b34955b9e360f..1a9325f4315769 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -910,7 +910,6 @@ struct block_device *bdget(dev_t dev)
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
 		bdev->bd_part_count = 0;
-		bdev->bd_flags = 0;
 		inode->i_mode = S_IFBLK;
 		inode->i_rdev = dev;
 		inode->i_bdev = bdev;
@@ -1385,7 +1384,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-	clear_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags);
+	clear_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 
 rescan:
 	ret = blk_drop_partitions(bdev);
@@ -1509,7 +1508,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			 * The latter is necessary to prevent ghost
 			 * partitions on a removed medium.
 			 */
-			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
+			if (test_bit(GD_NEED_PART_SCAN, &disk->state) &&
 			    (!ret || ret == -ENOMEDIUM))
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 
@@ -1539,7 +1538,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			if (bdev->bd_disk->fops->open)
 				ret = bdev->bd_disk->fops->open(bdev, mode);
 			/* the same as first opener case, read comment there */
-			if (test_bit(BDEV_NEED_PART_SCAN, &bdev->bd_flags) &&
+			if (test_bit(GD_NEED_PART_SCAN, &disk->state) &&
 			    (!ret || ret == -ENOMEDIUM))
 				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
 			if (ret)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 6ffa783e16335e..eb20e28184ab19 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -19,8 +19,6 @@ struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 struct bio_crypt_ctx;
 
-#define BDEV_NEED_PART_SCAN		0
-
 struct block_device {
 	dev_t			bd_dev;
 	int			bd_openers;
@@ -39,7 +37,7 @@ struct block_device {
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
 	unsigned		bd_part_count;
-	unsigned long		bd_flags;
+
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
 	struct backing_dev_info *bd_bdi;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1c97cf84f011a7..38f23d75701379 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -191,6 +191,8 @@ struct gendisk {
 	void *private_data;
 
 	int flags;
+	unsigned long state;
+#define GD_NEED_PART_SCAN		0
 	struct rw_semaphore lookup_sem;
 	struct kobject *slave_dir;
 
-- 
2.28.0

