Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E367078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbhDUQq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:46:59 -0400
Received: from mx2.veeam.com ([64.129.123.6]:42206 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244412AbhDUQqt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:46:49 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id D101D424BD;
        Wed, 21 Apr 2021 12:46:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1619023566; bh=/pJWDW+n29Aj+YyhXjSRTxSErchO67fEDFfCRLX90IM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iBZd8S1Xb80Iu9wd7U2f+C0DAtzRlgv8NUGGGC7UwXg+BhSAsGKFz4SL7wmeSD68V
         mnzJtSHB7Q2b6vJsUr7NNF9RevnlE6lc8eqPBw3fJ/uQvwRHon6Y2XG+B/Kt8Verq+
         SxYBAFsA8X747YiOH99HlvX3Jo2TdoJiv/b6wgcE=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Wed, 21 Apr 2021 18:45:58 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v9 3/4] Add blk_interposer in DM
Date:   Wed, 21 Apr 2021 19:45:44 +0300
Message-ID: <1619023545-23431-4-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
References: <1619023545-23431-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59677566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new 'DM_INTERPOSE_FLAG' flag allows to specify that a DM target should
be attached via blk_interposer. This flag defines the value of the
'interpose' flag in a mapped_device structure. The 'interpose' flag in
the dm_dev structure indicates which device in the device table is
attached via blk_interposer.

To safely attach a DM target to blk_interposer, the DM target must be
fully initialized. Immediately after attaching to blk_interposer,
the DM device can receive bio requests and those must be processed.
Therefore, the connection is performed in the __dm_resume() function.

To safely detach a DM target from blk_interposer, the DM target must be
suspended. Only in this case we can be sure that all DM target requests
have been processed. Therefore, detaching from blk_interposer is called
from the __dm_suspend() function. However, we must lock the request queue
from the original device before calling __dm_suspend(). That is why
the locking of the queue of the original device is made as a separate
function.

A new dm_get_device_ex() function can be used instead of
dm_get_device() if we need to specify the 'interposer' flag for dm_dev.
The old dm_get_device() function sets the 'interposer' flag to false.
It allows to not change every DM target. At the same time, the new
function allows to explicitly specify which block devices and in which
DM targets can be attached via blk_interposer.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-core.h          |   1 +
 drivers/md/dm-ioctl.c         |  59 ++++++++-
 drivers/md/dm-table.c         |  21 ++-
 drivers/md/dm.c               | 242 ++++++++++++++++++++++++++++++----
 drivers/md/dm.h               |   8 +-
 include/linux/device-mapper.h |  11 +-
 include/uapi/linux/dm-ioctl.h |   6 +
 7 files changed, 309 insertions(+), 39 deletions(-)

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 5953ff2bd260..431b82461eae 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -112,6 +112,7 @@ struct mapped_device {
 	/* for blk-mq request-based DM support */
 	struct blk_mq_tag_set *tag_set;
 	bool init_tio_pdu:1;
+	bool interpose:1;
 
 	struct srcu_struct io_barrier;
 };
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 1ca65b434f1f..cd36fa3cb627 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -301,6 +301,24 @@ static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool
 				continue;
 			}
 
+			if (md->interpose) {
+				int r;
+
+				/*
+				 * Interposer should be suspended and detached
+				 * from the interposed block device.
+				 */
+				r = dm_suspend(md, DM_SUSPEND_DETACH_IP_FLAG |
+						   DM_SUSPEND_LOCKFS_FLAG);
+				if (r) {
+					DMERR("%s: unable to suspend and detach interposer",
+						dm_device_name(md));
+					dm_put(md);
+					dev_skipped++;
+					continue;
+				}
+			}
+
 			t = __hash_remove(hc);
 
 			up_write(&_hash_lock);
@@ -732,6 +750,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 	if (dm_test_deferred_remove_flag(md))
 		param->flags |= DM_DEFERRED_REMOVE;
 
+	if (dm_interposer_attached(md))
+		param->flags |= DM_INTERPOSE_FLAG;
+
 	param->dev = huge_encode_dev(disk_devt(disk));
 
 	/*
@@ -893,6 +914,21 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 		dm_put(md);
 		return r;
 	}
+	if (md->interpose) {
+		/*
+		 * Interposer should be suspended and detached from
+		 * the interposed block device.
+		 */
+		r = dm_suspend(md, DM_SUSPEND_DETACH_IP_FLAG |
+				   DM_SUSPEND_LOCKFS_FLAG);
+		if (r) {
+			DMERR("%s: unable to suspend and detach interposer",
+				dm_device_name(md));
+			up_write(&_hash_lock);
+			dm_put(md);
+			return r;
+		}
+	}
 
 	t = __hash_remove(hc);
 	up_write(&_hash_lock);
@@ -1063,8 +1099,18 @@ static int do_resume(struct dm_ioctl *param)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+
+		if (md->interpose) {
+			/*
+			 * Interposer should be detached before loading
+			 * a new table
+			 */
+			if (!dm_suspended_md(md) || dm_interposer_attached(md))
+				dm_suspend(md, suspend_flags | DM_SUSPEND_DETACH_IP_FLAG);
+		} else {
+			if (!dm_suspended_md(md))
+				dm_suspend(md, suspend_flags);
+		}
 
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1267,6 +1313,11 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 	return mode;
 }
 
+static inline bool get_interpose_flag(struct dm_ioctl *param)
+{
+	return (param->flags & DM_INTERPOSE_FLAG);
+}
+
 static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
@@ -1338,6 +1389,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (!md)
 		return -ENXIO;
 
+	md->interpose = get_interpose_flag(param);
+
 	r = dm_table_create(&t, get_mode(param), param->target_count, md);
 	if (r)
 		goto err;
@@ -2098,6 +2151,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_hash_remove;
 
+	md->interpose = get_interpose_flag(dmi);
+
 	/* add targets */
 	for (i = 0; i < dmi->target_count; i++) {
 		r = dm_table_add_target(t, spec_array[i]->target_type,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..cc6b852cc967 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -327,14 +327,14 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
  * it is accessed concurrently.
  */
 static int upgrade_mode(struct dm_dev_internal *dd, fmode_t new_mode,
-			struct mapped_device *md)
+			bool interpose, struct mapped_device *md)
 {
 	int r;
 	struct dm_dev *old_dev, *new_dev;
 
 	old_dev = dd->dm_dev;
 
-	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev,
+	r = dm_get_table_device(md, dd->dm_dev->bdev->bd_dev, interpose,
 				dd->dm_dev->mode | new_mode, &new_dev);
 	if (r)
 		return r;
@@ -362,8 +362,8 @@ EXPORT_SYMBOL_GPL(dm_get_dev_t);
  * Add a device to the list, or just increment the usage count if
  * it's already present.
  */
-int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
-		  struct dm_dev **result)
+int dm_get_device_ex(struct dm_target *ti, const char *path, fmode_t mode,
+		     bool interpose, struct dm_dev **result)
 {
 	int r;
 	dev_t dev;
@@ -391,7 +391,8 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (!dd)
 			return -ENOMEM;
 
-		if ((r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {
+		r = dm_get_table_device(t->md, dev, mode, interpose, &dd->dm_dev);
+		if (r) {
 			kfree(dd);
 			return r;
 		}
@@ -401,7 +402,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		goto out;
 
 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
+		r = upgrade_mode(dd, mode, interpose, t->md);
 		if (r)
 			return r;
 	}
@@ -410,7 +411,7 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 	*result = dd->dm_dev;
 	return 0;
 }
-EXPORT_SYMBOL(dm_get_device);
+EXPORT_SYMBOL(dm_get_device_ex);
 
 static int dm_set_device_limits(struct dm_target *ti, struct dm_dev *dev,
 				sector_t start, sector_t len, void *data)
@@ -2206,6 +2207,12 @@ struct mapped_device *dm_table_get_md(struct dm_table *t)
 }
 EXPORT_SYMBOL(dm_table_get_md);
 
+bool dm_table_is_interposer(struct dm_table *t)
+{
+	return t->md->interpose;
+}
+EXPORT_SYMBOL(dm_table_is_interposer);
+
 const char *dm_table_device_name(struct dm_table *t)
 {
 	return dm_device_name(t->md);
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3f3be9408afa..818462b46c91 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(dm_bio_get_target_bio_nr);
 #define DMF_DEFERRED_REMOVE 6
 #define DMF_SUSPENDED_INTERNALLY 7
 #define DMF_POST_SUSPENDING 8
+#define DMF_INTERPOSER_ATTACHED 9
 
 #define DM_NUMA_NODE NUMA_NO_NODE
 static int dm_numa_node = DM_NUMA_NODE;
@@ -757,18 +758,24 @@ static int open_table_device(struct table_device *td, dev_t dev,
 			     struct mapped_device *md)
 {
 	struct block_device *bdev;
-
+	fmode_t mode = td->dm_dev.mode;
+	void *holder = NULL;
 	int r;
 
 	BUG_ON(td->dm_dev.bdev);
 
-	bdev = blkdev_get_by_dev(dev, td->dm_dev.mode | FMODE_EXCL, _dm_claim_ptr);
+	if (!td->dm_dev.interpose) {
+		mode |= FMODE_EXCL;
+		holder = _dm_claim_ptr;
+	}
+
+	bdev = blkdev_get_by_dev(dev, mode, holder);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
 	r = bd_link_disk_holder(bdev, dm_disk(md));
 	if (r) {
-		blkdev_put(bdev, td->dm_dev.mode | FMODE_EXCL);
+		blkdev_put(bdev, mode);
 		return r;
 	}
 
@@ -782,11 +789,16 @@ static int open_table_device(struct table_device *td, dev_t dev,
  */
 static void close_table_device(struct table_device *td, struct mapped_device *md)
 {
+	fmode_t mode = td->dm_dev.mode;
+
 	if (!td->dm_dev.bdev)
 		return;
 
 	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
-	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
+	if (!td->dm_dev.interpose)
+		mode |= FMODE_EXCL;
+	blkdev_put(td->dm_dev.bdev, mode);
+
 	put_dax(td->dm_dev.dax_dev);
 	td->dm_dev.bdev = NULL;
 	td->dm_dev.dax_dev = NULL;
@@ -805,7 +817,7 @@ static struct table_device *find_table_device(struct list_head *l, dev_t dev,
 }
 
 int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
-			struct dm_dev **result)
+			bool interpose, struct dm_dev **result)
 {
 	int r;
 	struct table_device *td;
@@ -821,6 +833,7 @@ int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
 
 		td->dm_dev.mode = mode;
 		td->dm_dev.bdev = NULL;
+		td->dm_dev.interpose = interpose;
 
 		if ((r = open_table_device(td, dev, md))) {
 			mutex_unlock(&md->table_devices_lock);
@@ -1696,6 +1709,13 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
 		goto out;
 	}
 
+	/*
+	 * If md is an interposer, then we must set the BIO_INTERPOSE flag
+	 * so that the request is not re-interposed.
+	 */
+	if (md->interpose)
+		bio_set_flag(bio, BIO_INTERPOSED);
+
 	/* If suspended, queue this IO for later */
 	if (unlikely(test_bit(DMF_BLOCK_IO_FOR_SUSPEND, &md->flags))) {
 		if (bio->bi_opf & REQ_NOWAIT)
@@ -2453,26 +2473,50 @@ struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
  * Functions to lock and unlock any filesystem running on the
  * device.
  */
-static int lock_fs(struct mapped_device *md)
+static int lock_bdev_fs(struct mapped_device *md, struct block_device *bdev)
 {
 	int r;
 
 	WARN_ON(test_bit(DMF_FROZEN, &md->flags));
 
-	r = freeze_bdev(md->disk->part0);
+	r = freeze_bdev(bdev);
 	if (!r)
 		set_bit(DMF_FROZEN, &md->flags);
 	return r;
 }
 
-static void unlock_fs(struct mapped_device *md)
+static void unlock_bdev_fs(struct mapped_device *md, struct block_device *bdev)
 {
 	if (!test_bit(DMF_FROZEN, &md->flags))
 		return;
-	thaw_bdev(md->disk->part0);
+	thaw_bdev(bdev);
 	clear_bit(DMF_FROZEN, &md->flags);
 }
 
+static inline int lock_fs(struct mapped_device *md)
+{
+	return lock_bdev_fs(md, md->disk->part0);
+}
+
+static inline void unlock_fs(struct mapped_device *md)
+{
+	unlock_bdev_fs(md, md->disk->part0);
+}
+
+static inline struct block_device *get_interposed_bdev(struct dm_table *t)
+{
+	struct dm_dev_internal *dd;
+
+	/*
+	 * For interposer should be only one device in dm table
+	 */
+	list_for_each_entry(dd, dm_table_get_devices(t), list)
+		if (dd->dm_dev->interpose)
+			return bdgrab(dd->dm_dev->bdev);
+
+	return NULL;
+}
+
 /*
  * @suspend_flags: DM_SUSPEND_LOCKFS_FLAG and/or DM_SUSPEND_NOFLUSH_FLAG
  * @task_state: e.g. TASK_INTERRUPTIBLE or TASK_UNINTERRUPTIBLE
@@ -2488,7 +2532,10 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	bool detach_ip = suspend_flags & DM_SUSPEND_DETACH_IP_FLAG
+			 && md->interpose;
+	struct block_device *original_bdev = NULL;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2507,18 +2554,50 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 */
 	dm_table_presuspend_targets(map);
 
+	if (!md->interpose) {
+		/*
+		 * Flush I/O to the device.
+		 * Any I/O submitted after lock_fs() may not be flushed.
+		 * noflush takes precedence over do_lockfs.
+		 * (lock_fs() flushes I/Os and waits for them to complete.)
+		 */
+		if (!noflush && do_lockfs)
+			r = lock_fs(md);
+	} else if (map) {
+		/*
+		 * Interposer should not lock mapped device, but
+		 * should freeze interposed device and lock it.
+		 */
+		original_bdev = get_interposed_bdev(map);
+		if (!original_bdev) {
+			r = -EINVAL;
+			DMERR("%s: interposer cannot get interposed device from table",
+				dm_device_name(md));
+			goto presuspend_undo;
+		}
+
+		if (!noflush && do_lockfs) {
+			r = lock_bdev_fs(md, original_bdev);
+			if (r) {
+				DMERR("%s: interposer cannot freeze interposed device",
+					dm_device_name(md));
+				goto presuspend_undo;
+			}
+		}
+
+		bdev_interposer_lock(original_bdev);
+	}
 	/*
-	 * Flush I/O to the device.
-	 * Any I/O submitted after lock_fs() may not be flushed.
-	 * noflush takes precedence over do_lockfs.
-	 * (lock_fs() flushes I/Os and waits for them to complete.)
+	 * If map is not initialized, then we cannot suspend
+	 * interposed device
 	 */
-	if (!noflush && do_lockfs) {
-		r = lock_fs(md);
-		if (r) {
-			dm_table_presuspend_undo_targets(map);
-			return r;
-		}
+
+presuspend_undo:
+	if (r) {
+		if (original_bdev)
+			bdput(original_bdev);
+		dm_table_presuspend_undo_targets(map);
+		return r;
 	}
 
 	/*
@@ -2559,14 +2638,40 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	if (map)
 		synchronize_srcu(&md->io_barrier);
 
-	/* were we interrupted ? */
-	if (r < 0) {
+	if (r == 0) { /* the wait ended successfully */
+		if (md->interpose && original_bdev) {
+			if (detach_ip) {
+				bdev_interposer_detach(original_bdev);
+				clear_bit(DMF_INTERPOSER_ATTACHED, &md->flags);
+			}
+
+			bdev_interposer_unlock(original_bdev);
+
+			if (detach_ip) {
+				/*
+				 * If th interposer is detached, then there is
+				 * no reason in keeping the queue of the
+				 * interposed device stopped.
+				 */
+				unlock_bdev_fs(md, original_bdev);
+			}
+
+			bdput(original_bdev);
+		}
+	} else { /* were we interrupted ? */
 		dm_queue_flush(md);
 
 		if (dm_request_based(md))
 			dm_start_queue(md->queue);
 
-		unlock_fs(md);
+		if (md->interpose && original_bdev) {
+			bdev_interposer_unlock(original_bdev);
+			unlock_bdev_fs(md, original_bdev);
+
+			bdput(original_bdev);
+		} else
+			unlock_fs(md);
+
 		dm_table_presuspend_undo_targets(map);
 		/* pushback list is already flushed, so skip flush */
 	}
@@ -2574,6 +2679,47 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	return r;
 }
 
+static struct block_device *__dm_get_original_bdev(struct mapped_device *md)
+{
+	struct dm_table *map;
+	struct block_device *original_bdev = NULL;
+
+	map = rcu_dereference_protected(md->map,
+					lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		DMERR("%s: interposers table is not initialized",
+			dm_device_name(md));
+		return ERR_PTR(-EINVAL);
+	}
+
+	original_bdev = get_interposed_bdev(map);
+	if (!original_bdev) {
+		DMERR("%s: interposer cannot get interposed device from table",
+			dm_device_name(md));
+		return ERR_PTR(-EINVAL);
+	}
+
+	return original_bdev;
+}
+
+static int __dm_detach_interposer(struct mapped_device *md)
+{
+	struct block_device *original_bdev;
+
+	original_bdev = __dm_get_original_bdev(md);
+	if (IS_ERR(original_bdev))
+		return PTR_ERR(original_bdev);
+
+	bdev_interposer_lock(original_bdev);
+
+	bdev_interposer_detach(original_bdev);
+	clear_bit(DMF_INTERPOSER_ATTACHED, &md->flags);
+
+	bdev_interposer_unlock(original_bdev);
+
+	bdput(original_bdev);
+	return 0;
+}
 /*
  * We need to be able to change a mapping table under a mounted
  * filesystem.  For example we might want to move some data in
@@ -2599,7 +2745,17 @@ int dm_suspend(struct mapped_device *md, unsigned suspend_flags)
 	mutex_lock_nested(&md->suspend_lock, SINGLE_DEPTH_NESTING);
 
 	if (dm_suspended_md(md)) {
-		r = -EINVAL;
+		if (suspend_flags & DM_SUSPEND_DETACH_IP_FLAG) {
+			/*
+			 * If mapped device is suspended, but should be
+			 * detached we just detach without freeze fs on
+			 * interposed device.
+			 */
+			if (dm_interposer_attached(md))
+				r = __dm_detach_interposer(md);
+		} else
+			r = -EINVAL;
+
 		goto out_unlock;
 	}
 
@@ -2629,8 +2785,11 @@ int dm_suspend(struct mapped_device *md, unsigned suspend_flags)
 
 static int __dm_resume(struct mapped_device *md, struct dm_table *map)
 {
+	int r = 0;
+	struct block_device *original_bdev;
+
 	if (map) {
-		int r = dm_table_resume_targets(map);
+		r = dm_table_resume_targets(map);
 		if (r)
 			return r;
 	}
@@ -2645,9 +2804,33 @@ static int __dm_resume(struct mapped_device *md, struct dm_table *map)
 	if (dm_request_based(md))
 		dm_start_queue(md->queue);
 
-	unlock_fs(md);
+	if (!md->interpose) {
+		unlock_fs(md);
+		return 0;
+	}
 
-	return 0;
+	original_bdev = __dm_get_original_bdev(md);
+	if (IS_ERR(original_bdev))
+		return PTR_ERR(original_bdev);
+
+	if (dm_interposer_attached(md)) {
+		bdev_interposer_lock(original_bdev);
+
+		r = bdev_interposer_attach(original_bdev, dm_disk(md)->part0);
+		if (r)
+			DMERR("%s: failed to attach interposer",
+				dm_device_name(md));
+		else
+			set_bit(DMF_INTERPOSER_ATTACHED, &md->flags);
+
+		bdev_interposer_unlock(original_bdev);
+	}
+
+	unlock_bdev_fs(md, original_bdev);
+
+	bdput(original_bdev);
+
+	return r;
 }
 
 int dm_resume(struct mapped_device *md)
@@ -2880,6 +3063,11 @@ int dm_suspended_md(struct mapped_device *md)
 	return test_bit(DMF_SUSPENDED, &md->flags);
 }
 
+int dm_interposer_attached(struct mapped_device *md)
+{
+	return test_bit(DMF_INTERPOSER_ATTACHED, &md->flags);
+}
+
 static int dm_post_suspending_md(struct mapped_device *md)
 {
 	return test_bit(DMF_POST_SUSPENDING, &md->flags);
diff --git a/drivers/md/dm.h b/drivers/md/dm.h
index b441ad772c18..35f71e48abd1 100644
--- a/drivers/md/dm.h
+++ b/drivers/md/dm.h
@@ -28,6 +28,7 @@
  */
 #define DM_SUSPEND_LOCKFS_FLAG		(1 << 0)
 #define DM_SUSPEND_NOFLUSH_FLAG		(1 << 1)
+#define DM_SUSPEND_DETACH_IP_FLAG	(1 << 2)
 
 /*
  * Status feature flags
@@ -122,6 +123,11 @@ int dm_deleting_md(struct mapped_device *md);
  */
 int dm_suspended_md(struct mapped_device *md);
 
+/*
+ * Is the interposer of this mapped_device is attached?
+ */
+int dm_interposer_attached(struct mapped_device *md);
+
 /*
  * Internal suspend and resume methods.
  */
@@ -180,7 +186,7 @@ int dm_lock_for_deletion(struct mapped_device *md, bool mark_deferred, bool only
 int dm_cancel_deferred_remove(struct mapped_device *md);
 int dm_request_based(struct mapped_device *md);
 int dm_get_table_device(struct mapped_device *md, dev_t dev, fmode_t mode,
-			struct dm_dev **result);
+			bool interpose, struct dm_dev **result);
 void dm_put_table_device(struct mapped_device *md, struct dm_dev *d);
 
 int dm_kobject_uevent(struct mapped_device *md, enum kobject_action action,
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 5c641f930caf..aa94c7e10ecc 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -159,6 +159,7 @@ struct dm_dev {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	fmode_t mode;
+	bool interpose;
 	char name[16];
 };
 
@@ -168,8 +169,13 @@ dev_t dm_get_dev_t(const char *path);
  * Constructors should call these functions to ensure destination devices
  * are opened/closed correctly.
  */
-int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
-		  struct dm_dev **result);
+int dm_get_device_ex(struct dm_target *ti, const char *path, fmode_t mode,
+		     bool interpose, struct dm_dev **result);
+static inline int dm_get_device(struct dm_target *ti, const char *path,
+				fmode_t mode, struct dm_dev **result)
+{
+	return dm_get_device_ex(ti, path, mode, false, result);
+};
 void dm_put_device(struct dm_target *ti, struct dm_dev *d);
 
 /*
@@ -550,6 +556,7 @@ sector_t dm_table_get_size(struct dm_table *t);
 unsigned int dm_table_get_num_targets(struct dm_table *t);
 fmode_t dm_table_get_mode(struct dm_table *t);
 struct mapped_device *dm_table_get_md(struct dm_table *t);
+bool dm_table_is_interposer(struct dm_table *t);
 const char *dm_table_device_name(struct dm_table *t);
 
 /*
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index fcff6669137b..7f88f3d2d852 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -362,4 +362,10 @@ enum {
  */
 #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
 
+/*
+ * If set, the underlying device should open without FMODE_EXCL
+ * and attach mapped device via blk_interposer.
+ */
+#define DM_INTERPOSE_FLAG		(1 << 19) /* In/Out */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.20.1

