Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D812B7928
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 09:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgKRIsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 03:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgKRIsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:48:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561FCC061A51;
        Wed, 18 Nov 2020 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6hkgUJ1mS3kvM7sA/4AN3atVruy32itd0ZGr9xe66Po=; b=L2td6RO7MBCM/6vXyAvSKM5bSN
        kbsKiO2NgeaEkpglWX1w8vEghix6mQar9pAu2yADmsBzvkLRTgKoAec3QJrOPR5K+0zGVdK9ljfi+
        hHEjWtOobuqj26E6G3m3rFBqnmew1lRpm+RtN6moeq3AnVFyzCv/NSfh48KrKPX5R7NIJTYZHeBJa
        9RpWbbygX8TogH7UlhxXizbevNvJ20t1ytuxUSVj8cfuJiQrnbMhiixy8syEwMBus9lqPOXDZ4yaV
        Xg7/w+XrbjFywKqWl/93+Xn66Ui5f5Ed6QJ9dc0m7NvVfnttDdO0KLT8Y7TGS5G981XWFBub3IoCl
        YAmHgubw==;
Received: from [2001:4bb8:18c:31ba:32b1:ec66:5459:36a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfJ8W-0007mG-H5; Wed, 18 Nov 2020 08:48:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 11/20] block: reference struct block_device from struct hd_struct
Date:   Wed, 18 Nov 2020 09:47:51 +0100
Message-Id: <20201118084800.2339180-12-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118084800.2339180-1-hch@lst.de>
References: <20201118084800.2339180-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To simplify block device lookup and a few other upcomdin areas, make sure
that we always have a struct block_device available for each disk and
each partition.  The only downside of this is that each device and
partition uses a little more memories.  The upside will be that a lot of
code can be simplified.

With that all we need to look up the block device is to lookup the inode
and do a few sanity checks on the gendisk, instead of the separate lookup
for the gendisk.

As part of the change switch bdget() to only find existing block devices,
given that we know that the block_device structure must be allocated at
probe / partition scan time.

blk-cgroup needed a bit of a special treatment as the only place that
wanted to lookup a gendisk outside of the normal blkdev_get path.  It is
switched to lookup using the block device hash now that this is the
primary lookup path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         |  42 ++++----
 block/blk-iocost.c         |  36 +++----
 block/blk.h                |   2 +-
 block/genhd.c              | 204 ++++---------------------------------
 block/partitions/core.c    |  28 ++---
 fs/block_dev.c             | 123 ++++++++++++----------
 include/linux/blk-cgroup.h |   4 +-
 include/linux/blkdev.h     |   3 +
 include/linux/genhd.h      |   4 +-
 9 files changed, 156 insertions(+), 290 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 54fbe1e80cc41a..4c0ae0f6bce02d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -556,22 +556,22 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 }
 
 /**
- * blkg_conf_prep - parse and prepare for per-blkg config update
+ * blkcg_conf_get_bdev - parse and open bdev for per-blkg config update
  * @inputp: input string pointer
  *
  * Parse the device node prefix part, MAJ:MIN, of per-blkg config update
- * from @input and get and return the matching gendisk.  *@inputp is
+ * from @input and get and return the matching bdev.  *@inputp is
  * updated to point past the device node prefix.  Returns an ERR_PTR()
  * value on error.
  *
  * Use this function iff blkg_conf_prep() can't be used for some reason.
  */
-struct gendisk *blkcg_conf_get_disk(char **inputp)
+struct block_device *blkcg_conf_get_bdev(char **inputp)
 {
 	char *input = *inputp;
 	unsigned int major, minor;
-	struct gendisk *disk;
-	int key_len, part;
+	struct block_device *bdev;
+	int key_len;
 
 	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
 		return ERR_PTR(-EINVAL);
@@ -581,16 +581,16 @@ struct gendisk *blkcg_conf_get_disk(char **inputp)
 		return ERR_PTR(-EINVAL);
 	input = skip_spaces(input);
 
-	disk = get_gendisk(MKDEV(major, minor), &part);
-	if (!disk)
+	bdev = bdget(MKDEV(major, minor));
+	if (!bdev)
 		return ERR_PTR(-ENODEV);
-	if (part) {
-		put_disk_and_module(disk);
+	if (bdev_is_partition(bdev)) {
+		bdput(bdev);
 		return ERR_PTR(-ENODEV);
 	}
 
 	*inputp = input;
-	return disk;
+	return bdev;
 }
 
 /**
@@ -607,18 +607,18 @@ struct gendisk *blkcg_conf_get_disk(char **inputp)
  */
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx)
-	__acquires(rcu) __acquires(&disk->queue->queue_lock)
+	__acquires(rcu) __acquires(&bdev->bd_disk->queue->queue_lock)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_get_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	q = disk->queue;
+	q = bdev->bd_disk->queue;
 
 	rcu_read_lock();
 	spin_lock_irq(&q->queue_lock);
@@ -689,7 +689,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 			goto success;
 	}
 success:
-	ctx->disk = disk;
+	ctx->bdev = bdev;
 	ctx->blkg = blkg;
 	ctx->body = input;
 	return 0;
@@ -700,7 +700,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	spin_unlock_irq(&q->queue_lock);
 	rcu_read_unlock();
 fail:
-	put_disk_and_module(disk);
+	bdput(bdev);
 	/*
 	 * If queue was bypassing, we should retry.  Do so after a
 	 * short msleep().  It isn't strictly necessary but queue
@@ -723,11 +723,11 @@ EXPORT_SYMBOL_GPL(blkg_conf_prep);
  * with blkg_conf_prep().
  */
 void blkg_conf_finish(struct blkg_conf_ctx *ctx)
-	__releases(&ctx->disk->queue->queue_lock) __releases(rcu)
+	__releases(&ctx->bdev->bd_disk->queue->queue_lock) __releases(rcu)
 {
-	spin_unlock_irq(&ctx->disk->queue->queue_lock);
+	spin_unlock_irq(&ctx->bdev->bd_disk->queue->queue_lock);
 	rcu_read_unlock();
-	put_disk_and_module(ctx->disk);
+	bdput(ctx->bdev);
 }
 EXPORT_SYMBOL_GPL(blkg_conf_finish);
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index bbe86d1199dc5b..bd8bfccf6b9ec3 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3120,23 +3120,23 @@ static const match_table_t qos_tokens = {
 static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *p;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_get_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(disk->queue);
+	ioc = q_to_ioc(bdev->bd_disk->queue);
 	if (!ioc) {
-		ret = blk_iocost_init(disk->queue);
+		ret = blk_iocost_init(bdev->bd_disk->queue);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(disk->queue);
+		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3231,12 +3231,12 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
-	put_disk_and_module(disk);
+	bdput(bdev);
 	return nbytes;
 einval:
 	ret = -EINVAL;
 err:
-	put_disk_and_module(disk);
+	bdput(bdev);
 	return ret;
 }
 
@@ -3287,23 +3287,23 @@ static const match_table_t i_lcoef_tokens = {
 static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 				    size_t nbytes, loff_t off)
 {
-	struct gendisk *disk;
+	struct block_device *bdev;
 	struct ioc *ioc;
 	u64 u[NR_I_LCOEFS];
 	bool user;
 	char *p;
 	int ret;
 
-	disk = blkcg_conf_get_disk(&input);
-	if (IS_ERR(disk))
-		return PTR_ERR(disk);
+	bdev = blkcg_conf_get_bdev(&input);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(disk->queue);
+	ioc = q_to_ioc(bdev->bd_disk->queue);
 	if (!ioc) {
-		ret = blk_iocost_init(disk->queue);
+		ret = blk_iocost_init(bdev->bd_disk->queue);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(disk->queue);
+		ioc = q_to_ioc(bdev->bd_disk->queue);
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3356,13 +3356,13 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 	ioc_refresh_params(ioc, true);
 	spin_unlock_irq(&ioc->lock);
 
-	put_disk_and_module(disk);
+	bdput(bdev);
 	return nbytes;
 
 einval:
 	ret = -EINVAL;
 err:
-	put_disk_and_module(disk);
+	bdput(bdev);
 	return ret;
 }
 
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9a5..c4839abcfa27eb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -352,7 +352,6 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector);
 
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt);
 void blk_free_devt(dev_t devt);
-void blk_invalidate_devt(dev_t devt);
 char *disk_name(struct gendisk *hd, int partno, char *buf);
 #define ADDPART_FLAG_NONE	0
 #define ADDPART_FLAG_RAID	1
@@ -384,6 +383,7 @@ static inline void hd_free_part(struct hd_struct *part)
 {
 	free_percpu(part->dkstats);
 	kfree(part->info);
+	bdput(part->bdev);
 	percpu_ref_exit(&part->ref);
 }
 
diff --git a/block/genhd.c b/block/genhd.c
index f46e89226fdf91..94de95287a6370 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,17 +27,9 @@
 
 static struct kobject *block_depr;
 
-static DEFINE_XARRAY(bdev_map);
-static DEFINE_MUTEX(bdev_map_lock);
-
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
-
-/* For extended devt allocation.  ext_devt_lock prevents look up
- * results from going away underneath its user.
- */
-static DEFINE_SPINLOCK(ext_devt_lock);
-static DEFINE_IDR(ext_devt_idr);
+static DEFINE_IDA(ext_devt_ida);
 
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr);
@@ -580,14 +572,7 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 		return 0;
 	}
 
-	/* allocate ext devt */
-	idr_preload(GFP_KERNEL);
-
-	spin_lock_bh(&ext_devt_lock);
-	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_NOWAIT);
-	spin_unlock_bh(&ext_devt_lock);
-
-	idr_preload_end();
+	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
 	if (idx < 0)
 		return idx == -ENOSPC ? -EBUSY : idx;
 
@@ -606,26 +591,8 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
  */
 void blk_free_devt(dev_t devt)
 {
-	if (devt == MKDEV(0, 0))
-		return;
-
-	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
-		idr_remove(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
-	}
-}
-
-/*
- * We invalidate devt by assigning NULL pointer for devt in idr.
- */
-void blk_invalidate_devt(dev_t devt)
-{
-	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
-		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
-	}
+	if (MAJOR(devt) == BLOCK_EXT_MAJOR)
+		ida_free(&ext_devt_ida, blk_mangle_minor(MINOR(devt)));
 }
 
 static char *bdevt_str(dev_t devt, char *buf)
@@ -640,28 +607,6 @@ static char *bdevt_str(dev_t devt, char *buf)
 	return buf;
 }
 
-static void blk_register_region(struct gendisk *disk)
-{
-	int i;
-
-	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < disk->minors; i++) {
-		if (xa_insert(&bdev_map, disk_devt(disk) + i, disk, GFP_KERNEL))
-			WARN_ON_ONCE(1);
-	}
-	mutex_unlock(&bdev_map_lock);
-}
-
-static void blk_unregister_region(struct gendisk *disk)
-{
-	int i;
-
-	mutex_lock(&bdev_map_lock);
-	for (i = 0; i < disk->minors; i++)
-		xa_erase(&bdev_map, disk_devt(disk) + i);
-	mutex_unlock(&bdev_map_lock);
-}
-
 static void disk_scan_partitions(struct gendisk *disk)
 {
 	struct block_device *bdev;
@@ -805,7 +750,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
 		WARN_ON(ret);
 		bdi_set_owner(bdi, dev);
-		blk_register_region(disk);
+		bdev_add(disk->part0.bdev, devt);
 	}
 	register_disk(parent, disk, groups);
 	if (register_queue)
@@ -916,16 +861,6 @@ void del_gendisk(struct gendisk *disk)
 	}
 
 	blk_unregister_queue(disk);
-	
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk);
-	/*
-	 * Remove gendisk pointer from idr so that it cannot be looked up
-	 * while RCU period before freeing gendisk is running to prevent
-	 * use-after-free issues. Note that the device number stays
-	 * "in-use" until we really free the gendisk.
-	 */
-	blk_invalidate_devt(disk_devt(disk));
 
 	kobject_put(disk->part0.holder_dir);
 	kobject_put(disk->slave_dir);
@@ -964,7 +899,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
-static void request_gendisk_module(dev_t devt)
+void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
@@ -984,84 +919,6 @@ static void request_gendisk_module(dev_t devt)
 		request_module("block-major-%d", MAJOR(devt));
 }
 
-static bool get_disk_and_module(struct gendisk *disk)
-{
-	struct module *owner;
-
-	if (!disk->fops)
-		return false;
-	owner = disk->fops->owner;
-	if (owner && !try_module_get(owner))
-		return false;
-	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
-		module_put(owner);
-		return false;
-	}
-	return true;
-
-}
-
-/**
- * get_gendisk - get partitioning information for a given device
- * @devt: device to get partitioning information for
- * @partno: returned partition index
- *
- * This function gets the structure containing partitioning
- * information for the given device @devt.
- *
- * Context: can sleep
- */
-struct gendisk *get_gendisk(dev_t devt, int *partno)
-{
-	struct gendisk *disk = NULL;
-
-	might_sleep();
-
-	if (MAJOR(devt) != BLOCK_EXT_MAJOR) {
-		mutex_lock(&bdev_map_lock);
-		disk = xa_load(&bdev_map, devt);
-		if (!disk) {
-			mutex_unlock(&bdev_map_lock);
-			request_gendisk_module(devt);
-			mutex_lock(&bdev_map_lock);
-			disk = xa_load(&bdev_map, devt);
-		}
-		if (disk && !get_disk_and_module(disk))
-			disk = NULL;
-		if (disk)
-			*partno = devt - disk_devt(disk);
-		mutex_unlock(&bdev_map_lock);
-	} else {
-		struct hd_struct *part;
-
-		spin_lock_bh(&ext_devt_lock);
-		part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		if (part && get_disk_and_module(part_to_disk(part))) {
-			*partno = part->partno;
-			disk = part_to_disk(part);
-		}
-		spin_unlock_bh(&ext_devt_lock);
-	}
-
-	if (!disk)
-		return NULL;
-
-	/*
-	 * Synchronize with del_gendisk() to not return disk that is being
-	 * destroyed.
-	 */
-	down_read(&disk->lookup_sem);
-	if (unlikely((disk->flags & GENHD_FL_HIDDEN) ||
-		     !(disk->flags & GENHD_FL_UP))) {
-		up_read(&disk->lookup_sem);
-		put_disk_and_module(disk);
-		disk = NULL;
-	} else {
-		up_read(&disk->lookup_sem);
-	}
-	return disk;
-}
-
 /**
  * bdget_disk - do bdget() by gendisk and partition number
  * @disk: gendisk of interest
@@ -1559,11 +1416,6 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
  *
  * This function releases all allocated resources of the gendisk.
  *
- * The struct gendisk refcount is incremented with get_gendisk() or
- * get_disk_and_module(), and its refcount is decremented with
- * put_disk_and_module() or put_disk(). Once the refcount reaches 0 this
- * function is called.
- *
  * Drivers which used __device_add_disk() have a gendisk with a request_queue
  * assigned. Since the request_queue sits on top of the gendisk for these
  * drivers we also call blk_put_queue() for them, and we expect the
@@ -1748,16 +1600,18 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	if (!disk)
 		return NULL;
 
+	disk->part0.bdev = bdev_alloc(disk, 0);
+	if (!disk->part0.bdev)
+		goto out_free_disk;
+
 	disk->part0.dkstats = alloc_percpu(struct disk_stats);
 	if (!disk->part0.dkstats)
-		goto out_free_disk;
+		goto out_bdput;
 
 	init_rwsem(&disk->lookup_sem);
 	disk->node_id = node_id;
-	if (disk_expand_part_tbl(disk, 0)) {
-		free_percpu(disk->part0.dkstats);
-		goto out_free_disk;
-	}
+	if (disk_expand_part_tbl(disk, 0))
+		goto out_free_bdstats;
 
 	ptbl = rcu_dereference_protected(disk->part_tbl, 1);
 	rcu_assign_pointer(ptbl->part[0], &disk->part0);
@@ -1772,8 +1626,10 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	 * converted to make use of bd_mutex and sequence counters.
 	 */
 	hd_sects_seq_init(&disk->part0);
-	if (hd_ref_init(&disk->part0))
-		goto out_free_part0;
+	if (hd_ref_init(&disk->part0)) {
+		hd_free_part(&disk->part0);
+		return NULL;
+	}
 
 	disk->minors = minors;
 	rand_initialize_disk(disk);
@@ -1782,8 +1638,10 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	device_initialize(disk_to_dev(disk));
 	return disk;
 
-out_free_part0:
-	hd_free_part(&disk->part0);
+out_free_bdstats:
+	free_percpu(disk->part0.dkstats);
+out_bdput:
+	bdput(disk->part0.bdev);
 out_free_disk:
 	kfree(disk);
 	return NULL;
@@ -1807,26 +1665,6 @@ void put_disk(struct gendisk *disk)
 }
 EXPORT_SYMBOL(put_disk);
 
-/**
- * put_disk_and_module - decrements the module and gendisk refcount
- * @disk: the struct gendisk to decrement the refcount for
- *
- * This is a counterpart of get_disk_and_module() and thus also of
- * get_gendisk().
- *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
- */
-void put_disk_and_module(struct gendisk *disk)
-{
-	if (disk) {
-		struct module *owner = disk->fops->owner;
-
-		put_disk(disk);
-		module_put(owner);
-	}
-}
-
 static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 {
 	char event[] = "DISK_RO=1";
diff --git a/block/partitions/core.c b/block/partitions/core.c
index a02e224115943d..0ba0bf44b88af3 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -340,12 +340,11 @@ void delete_partition(struct hd_struct *part)
 	device_del(part_to_dev(part));
 
 	/*
-	 * Remove gendisk pointer from idr so that it cannot be looked up
-	 * while RCU period before freeing gendisk is running to prevent
-	 * use-after-free issues. Note that the device number stays
-	 * "in-use" until we really free the gendisk.
+	 * Remove the block device from the inode hash, so that it cannot be
+	 * looked up while waiting for the RCU grace period.
 	 */
-	blk_invalidate_devt(part_devt(part));
+	remove_inode_hash(part->bdev->bd_inode);
+
 	percpu_ref_kill(&part->ref);
 }
 
@@ -402,11 +401,14 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	if (!p)
 		return ERR_PTR(-EBUSY);
 
+	err = -ENOMEM;
 	p->dkstats = alloc_percpu(struct disk_stats);
-	if (!p->dkstats) {
-		err = -ENOMEM;
+	if (!p->dkstats)
 		goto out_free;
-	}
+
+	p->bdev = bdev_alloc(disk, partno);
+	if (!p->bdev)
+		goto out_free_stats;
 
 	hd_sects_seq_init(p);
 	pdev = part_to_dev(p);
@@ -420,10 +422,8 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 		struct partition_meta_info *pinfo;
 
 		pinfo = kzalloc_node(sizeof(*pinfo), GFP_KERNEL, disk->node_id);
-		if (!pinfo) {
-			err = -ENOMEM;
-			goto out_free_stats;
-		}
+		if (!pinfo)
+			goto out_bdput;
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
@@ -470,6 +470,7 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 	}
 
 	/* everything is up and running, commence */
+	bdev_add(p->bdev, devt);
 	rcu_assign_pointer(ptbl->part[partno], p);
 
 	/* suppress uevent if the disk suppresses it */
@@ -479,11 +480,14 @@ static struct hd_struct *add_partition(struct gendisk *disk, int partno,
 
 out_free_info:
 	kfree(p->info);
+out_bdput:
+	bdput(p->bdev);
 out_free_stats:
 	free_percpu(p->dkstats);
 out_free:
 	kfree(p);
 	return ERR_PTR(err);
+
 out_remove_file:
 	device_remove_file(pdev, &dev_attr_whole_disk);
 out_del:
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4c4d6c30382c06..e94633dc6ad93b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -870,34 +870,50 @@ void __init bdev_cache_init(void)
 	blockdev_superblock = bd_mnt->mnt_sb;   /* For writeback */
 }
 
-static struct block_device *bdget(dev_t dev)
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 {
 	struct block_device *bdev;
 	struct inode *inode;
 
-	inode = iget_locked(blockdev_superblock, dev);
+	inode = new_inode(blockdev_superblock);
 	if (!inode)
 		return NULL;
 
-	bdev = &BDEV_I(inode)->bdev;
+	bdev = I_BDEV(inode);
+	spin_lock_init(&bdev->bd_size_lock);
+	bdev->bd_disk = disk;
+	bdev->bd_partno = partno;
+	bdev->bd_contains = NULL;
+	bdev->bd_super = NULL;
+	bdev->bd_inode = inode;
+	bdev->bd_part_count = 0;
+
+	inode->i_mode = S_IFBLK;
+	inode->i_rdev = 0;
+	inode->i_bdev = bdev;
+	inode->i_data.a_ops = &def_blk_aops;
 
-	if (inode->i_state & I_NEW) {
-		spin_lock_init(&bdev->bd_size_lock);
-		bdev->bd_contains = NULL;
-		bdev->bd_super = NULL;
-		bdev->bd_inode = inode;
-		bdev->bd_part_count = 0;
-		bdev->bd_dev = dev;
-		inode->i_mode = S_IFBLK;
-		inode->i_rdev = dev;
-		inode->i_bdev = bdev;
-		inode->i_data.a_ops = &def_blk_aops;
-		mapping_set_gfp_mask(&inode->i_data, GFP_USER);
-		unlock_new_inode(inode);
-	}
 	return bdev;
 }
 
+void bdev_add(struct block_device *bdev, dev_t dev)
+{
+	bdev->bd_dev = dev;
+	bdev->bd_inode->i_rdev = dev;
+	bdev->bd_inode->i_ino = dev;
+	insert_inode_hash(bdev->bd_inode);
+}
+
+struct block_device *bdget(dev_t dev)
+{
+	struct inode *inode;
+
+	inode = ilookup(blockdev_superblock, dev);
+	if (!inode)
+		return NULL;
+	return &BDEV_I(inode)->bdev;
+}
+
 /**
  * bdgrab -- Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
@@ -957,6 +973,10 @@ static struct block_device *bd_acquire(struct inode *inode)
 		bd_forget(inode);
 
 	bdev = bdget(inode->i_rdev);
+	if (!bdev) {
+		blk_request_module(inode->i_rdev);
+		bdev = bdget(inode->i_rdev);
+	}
 	if (bdev) {
 		spin_lock(&bdev_lock);
 		if (!inode->i_bdev) {
@@ -1067,27 +1087,6 @@ int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
 
-static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
-{
-	struct gendisk *disk = get_gendisk(bdev->bd_dev, partno);
-
-	if (!disk)
-		return NULL;
-	/*
-	 * Now that we hold gendisk reference we make sure bdev we looked up is
-	 * not stale. If it is, it means device got removed and created before
-	 * we looked up gendisk and we fail open in such case. Associating
-	 * unhashed bdev with newly created gendisk could lead to two bdevs
-	 * (and thus two independent caches) being associated with one device
-	 * which is bad.
-	 */
-	if (inode_unhashed(bdev->bd_inode)) {
-		put_disk_and_module(disk);
-		return NULL;
-	}
-	return disk;
-}
-
 static void bd_clear_claiming(struct block_device *whole, void *holder)
 {
 	lockdep_assert_held(&bdev_lock);
@@ -1404,6 +1403,27 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
  */
 EXPORT_SYMBOL_GPL(bdev_disk_changed);
 
+static bool get_disk_and_module(struct gendisk *disk)
+{
+	struct module *owner = disk->fops->owner;
+
+	if (!try_module_get(owner))
+		return false;
+	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj)) {
+		module_put(owner);
+		return false;
+	}
+	return true;
+}
+
+static void put_disk_and_module(struct gendisk *disk)
+{
+	struct module *owner = disk->fops->owner;
+
+	put_disk(disk);
+	module_put(owner);
+}
+
 /*
  * bd_mutex locking:
  *
@@ -1415,19 +1435,24 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 		int for_part)
 {
 	struct block_device *whole = NULL, *claiming = NULL;
-	struct gendisk *disk;
+	struct gendisk *disk = bdev->bd_disk;
 	int ret;
-	int partno;
 	bool first_open = false, unblock_events = true, need_restart;
 
  restart:
 	need_restart = false;
-	ret = -ENXIO;
-	disk = bdev_get_gendisk(bdev, &partno);
-	if (!disk)
+
+	down_read(&disk->lookup_sem);
+	if ((disk->flags & GENHD_FL_HIDDEN) ||
+	    !(disk->flags & GENHD_FL_UP) ||
+	    !get_disk_and_module(disk)) {
+		up_read(&disk->lookup_sem);
+		ret = -ENXIO;
 		goto out;
+	}
+	up_read(&disk->lookup_sem);
 
-	if (partno) {
+	if (bdev->bd_partno) {
 		whole = bdget_disk(disk, 0);
 		if (!whole) {
 			ret = -ENOMEM;
@@ -1450,13 +1475,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
 		first_open = true;
-		bdev->bd_disk = disk;
 		bdev->bd_contains = bdev;
-		bdev->bd_partno = partno;
 
-		if (!partno) {
+		if (!bdev->bd_partno) {
 			ret = -ENXIO;
-			bdev->bd_part = disk_get_part(disk, partno);
+			bdev->bd_part = disk_get_part(disk, 0);
 			if (!bdev->bd_part)
 				goto out_clear;
 
@@ -1494,7 +1517,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 			if (ret)
 				goto out_clear;
 			bdev->bd_contains = bdgrab(whole);
-			bdev->bd_part = disk_get_part(disk, partno);
+			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
 				ret = -ENXIO;
@@ -1550,7 +1573,6 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
 
  out_clear:
 	disk_put_part(bdev->bd_part);
-	bdev->bd_disk = NULL;
 	bdev->bd_part = NULL;
 	if (bdev != bdev->bd_contains)
 		__blkdev_put(bdev->bd_contains, mode, 1);
@@ -1752,7 +1774,6 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part)
 
 		disk_put_part(bdev->bd_part);
 		bdev->bd_part = NULL;
-		bdev->bd_disk = NULL;
 		if (bdev_is_partition(bdev))
 			victim = bdev->bd_contains;
 		bdev->bd_contains = NULL;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index c8fc9792ac776d..064f14daedebca 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -197,12 +197,12 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v);
 
 struct blkg_conf_ctx {
-	struct gendisk			*disk;
+	struct block_device		*bdev;
 	struct blkcg_gq			*blkg;
 	char				*body;
 };
 
-struct gendisk *blkcg_conf_get_disk(char **inputp);
+struct block_device *blkcg_conf_get_bdev(char **inputp);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2eee..044d9dd159d882 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1994,6 +1994,9 @@ void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 		void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
+struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
+void bdev_add(struct block_device *bdev, dev_t dev);
+struct block_device *bdget(dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdget_part(struct hd_struct *part);
 struct block_device *bdgrab(struct block_device *bdev);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ca5e356084c353..ab5fca99764e7a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -65,6 +65,7 @@ struct hd_struct {
 	struct disk_stats __percpu *dkstats;
 	struct percpu_ref ref;
 
+	struct block_device *bdev;
 	struct device __dev;
 	struct kobject *holder_dir;
 	int policy, partno;
@@ -300,7 +301,6 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 }
 
 extern void del_gendisk(struct gendisk *gp);
-extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
 extern void set_disk_ro(struct gendisk *disk, int flag);
@@ -338,7 +338,6 @@ int blk_drop_partitions(struct block_device *bdev);
 
 extern struct gendisk *__alloc_disk_node(int minors, int node_id);
 extern void put_disk(struct gendisk *disk);
-extern void put_disk_and_module(struct gendisk *disk);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
@@ -389,6 +388,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 #endif /* CONFIG_SYSFS */
 
 dev_t blk_lookup_devt(const char *name, int partno);
+void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
 void printk_all_partitions(void);
 #else /* CONFIG_BLOCK */
-- 
2.29.2

