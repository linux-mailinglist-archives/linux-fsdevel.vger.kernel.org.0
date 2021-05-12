Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1537B636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 08:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhELGgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 02:36:16 -0400
Received: from verein.lst.de ([213.95.11.211]:39900 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhELGgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 02:36:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB5B967373; Wed, 12 May 2021 08:35:05 +0200 (CEST)
Date:   Wed, 12 May 2021 08:35:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>, viro@zeniv.linux.org.uk,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, martin.petersen@oracle.com, junxiao.bi@oracle.com
Subject: Re: [PATCH V1 1/1] Fix race between iscsi logout and systemd-udevd
Message-ID: <20210512063505.GA18367@lst.de>
References: <20210511181558.380764-1-gulam.mohamed@oracle.com> <YJtKT7rLi2CFqDsV@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJtKT7rLi2CFqDsV@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 12, 2021 at 11:23:59AM +0800, Ming Lei wrote:
> 
> 1) code path BLKRRPART:
> 	mutex_lock(bdev->bd_mutex)
> 	down_read(&bdev_lookup_sem);
> 
> 2) del_gendisk():
> 	down_write(&bdev_lookup_sem);
> 	mutex_lock(&disk->part0->bd_mutex);
> 
> Given GENHD_FL_UP is only checked when opening one bdev, and
> fsync_bdev() and __invalidate_device() needn't to open bdev, so
> the following way may work for your issue:

If we move the clearing of GENHD_FL_UP earlier we can do away with
bdev_lookup_sem entirely I think.  Something like this untested patch:

diff --git a/block/genhd.c b/block/genhd.c
index a5847560719c..ef717084b343 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,8 +29,6 @@
 
 static struct kobject *block_depr;
 
-DECLARE_RWSEM(bdev_lookup_sem);
-
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
@@ -609,13 +607,8 @@ void del_gendisk(struct gendisk *disk)
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
-	/*
-	 * Block lookups of the disk until all bdevs are unhashed and the
-	 * disk is marked as dead (GENHD_FL_UP cleared).
-	 */
-	down_write(&bdev_lookup_sem);
-
 	mutex_lock(&disk->open_mutex);
+	disk->flags &= ~GENHD_FL_UP;
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->open_mutex);
 
@@ -627,10 +620,7 @@ void del_gendisk(struct gendisk *disk)
 	 * up any more even if openers still hold references to it.
 	 */
 	remove_inode_hash(disk->part0->bd_inode);
-
 	set_capacity(disk, 0);
-	disk->flags &= ~GENHD_FL_UP;
-	up_write(&bdev_lookup_sem);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8dd8e2fd1401..bde23940190f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1377,33 +1377,24 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	struct block_device *bdev;
 	struct gendisk *disk;
 
-	down_read(&bdev_lookup_sem);
 	bdev = bdget(dev);
 	if (!bdev) {
-		up_read(&bdev_lookup_sem);
 		blk_request_module(dev);
-		down_read(&bdev_lookup_sem);
-
 		bdev = bdget(dev);
 		if (!bdev)
-			goto unlock;
+			return NULL;
 	}
 
 	disk = bdev->bd_disk;
 	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
 		goto bdput;
-	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
-		goto put_disk;
 	if (!try_module_get(bdev->bd_disk->fops->owner))
 		goto put_disk;
-	up_read(&bdev_lookup_sem);
 	return bdev;
 put_disk:
 	put_disk(disk);
 bdput:
 	bdput(bdev);
-unlock:
-	up_read(&bdev_lookup_sem);
 	return NULL;
 }
 
@@ -1462,7 +1453,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 
 	disk_block_events(disk);
 
+	ret = -ENXIO;
 	mutex_lock(&disk->open_mutex);
+	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+		goto abort_claiming;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
