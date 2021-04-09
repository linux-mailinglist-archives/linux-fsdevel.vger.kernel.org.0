Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A042359E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 13:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhDIL6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 07:58:24 -0400
Received: from mx2.veeam.com ([64.129.123.6]:33482 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233858AbhDIL6U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:58:20 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 1AD704097F;
        Fri,  9 Apr 2021 07:48:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1617968905; bh=/0FJV7PGShmCT9/Gt9blRIBWyR4rpnlYijwQsHarn80=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=DvPfBvtJWPUz/va++FT+XHbYw8KOjR7+xTL40F+pVLnSwDI0/vqCCGoSR0+Q7NeLi
         Rv4XDsW48ioDbByse+F2Zo/dXKEASSqiITiXVddSRWrdkAcIvwAeAUOq7OrmVQbYuy
         sHWzMaYrlo9cCr3vVSVyXtKWg5UYKgNuGJxO0ssc=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 9 Apr 2021 13:48:20 +0200
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
Subject: [PATCH v8 3/4] Adds blk_interposer to md.
Date:   Fri, 9 Apr 2021 14:48:03 +0300
Message-ID: <1617968884-15149-4-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
References: <1617968884-15149-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B59657262
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* The new flag DM_INTERPOSE_FLAG allows to specify that the dm target
will be attached using blk_interposer.
* The [interpose] option allows to specify which device will be
attached via the interposer.
* The connection and disconnection of the interrupter is performed in
the functions __dm_suspend() and __dm_resume(). The flag
DM_SUSPEND_DETACH_IP_FLAG was added for this purpose.
* dm_submit_bio() sets BIO_INTERPOSED for each bio from the interposer.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/md/dm-core.h          |   1 +
 drivers/md/dm-ioctl.c         |  95 ++++++++++---
 drivers/md/dm-table.c         |  68 ++++++++-
 drivers/md/dm.c               | 254 ++++++++++++++++++++++++++++++----
 drivers/md/dm.h               |   8 +-
 include/linux/device-mapper.h |   1 +
 include/uapi/linux/dm-ioctl.h |   6 +
 7 files changed, 375 insertions(+), 58 deletions(-)

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
index 1ca65b434f1f..7ec37526920b 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -294,11 +294,29 @@ static void dm_hash_remove_all(bool keep_open_devices, bool mark_deferred, bool
 			md = hc->md;
 			dm_get(md);
 
-			if (keep_open_devices &&
-			    dm_lock_for_deletion(md, mark_deferred, only_deferred)) {
-				dm_put(md);
-				dev_skipped++;
-				continue;
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
+			} else {
+				if (keep_open_devices &&
+				    dm_lock_for_deletion(md, mark_deferred, only_deferred)) {
+					dm_put(md);
+					dev_skipped++;
+					continue;
+				}
 			}
 
 			t = __hash_remove(hc);
@@ -732,6 +750,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
 	if (dm_test_deferred_remove_flag(md))
 		param->flags |= DM_DEFERRED_REMOVE;
 
+	if (dm_interposer_attached(md))
+		param->flags |= DM_INTERPOSE_FLAG;
+
 	param->dev = huge_encode_dev(disk_devt(disk));
 
 	/*
@@ -878,20 +899,37 @@ static int dev_remove(struct file *filp, struct dm_ioctl *param, size_t param_si
 
 	md = hc->md;
 
-	/*
-	 * Ensure the device is not open and nothing further can open it.
-	 */
-	r = dm_lock_for_deletion(md, !!(param->flags & DM_DEFERRED_REMOVE), false);
-	if (r) {
-		if (r == -EBUSY && param->flags & DM_DEFERRED_REMOVE) {
+	if (!md->interpose) {
+		/*
+		 * Ensure the device is not open and nothing further can open it.
+		 */
+		r = dm_lock_for_deletion(md, !!(param->flags & DM_DEFERRED_REMOVE), false);
+		if (r) {
+			if (r == -EBUSY && param->flags & DM_DEFERRED_REMOVE) {
+				up_write(&_hash_lock);
+				dm_put(md);
+				return 0;
+			}
+			DMDEBUG_LIMIT("unable to remove open device %s",
+					hc->name);
 			up_write(&_hash_lock);
 			dm_put(md);
-			return 0;
+			return r;
+		}
+	} else {
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
 		}
-		DMDEBUG_LIMIT("unable to remove open device %s", hc->name);
-		up_write(&_hash_lock);
-		dm_put(md);
-		return r;
 	}
 
 	t = __hash_remove(hc);
@@ -1050,6 +1088,7 @@ static int do_resume(struct dm_ioctl *param)
 
 	md = hc->md;
 
+
 	new_map = hc->new_map;
 	hc->new_map = NULL;
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
@@ -1063,8 +1102,14 @@ static int do_resume(struct dm_ioctl *param)
 			suspend_flags &= ~DM_SUSPEND_LOCKFS_FLAG;
 		if (param->flags & DM_NOFLUSH_FLAG)
 			suspend_flags |= DM_SUSPEND_NOFLUSH_FLAG;
-		if (!dm_suspended_md(md))
-			dm_suspend(md, suspend_flags);
+
+		if (md->interpose) {
+			if (!dm_suspended_md(md) || dm_interposer_attached(md))
+				dm_suspend(md, suspend_flags | DM_SUSPEND_DETACH_IP_FLAG);
+		} else {
+			if (!dm_suspended_md(md))
+				dm_suspend(md, suspend_flags);
+		}
 
 		old_map = dm_swap_table(md, new_map);
 		if (IS_ERR(old_map)) {
@@ -1267,6 +1312,11 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
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
@@ -1289,11 +1339,6 @@ static int populate_table(struct dm_table *table,
 	void *end = (void *) param + param_size;
 	char *target_params;
 
-	if (!param->target_count) {
-		DMWARN("populate_table: no targets specified");
-		return -EINVAL;
-	}
-
 	for (i = 0; i < param->target_count; i++) {
 
 		r = next_target(spec, next, end, &spec, &target_params);
@@ -1338,6 +1383,8 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	if (!md)
 		return -ENXIO;
 
+	md->interpose = get_interpose_flag(param);
+
 	r = dm_table_create(&t, get_mode(param), param->target_count, md);
 	if (r)
 		goto err;
@@ -2098,6 +2145,8 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_hash_remove;
 
+	md->interpose = get_interpose_flag(dmi);
+
 	/* add targets */
 	for (i = 0; i < dmi->target_count; i++) {
 		r = dm_table_add_target(t, spec_array[i]->target_type,
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..23574c727f2b 100644
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
@@ -367,6 +367,8 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 {
 	int r;
 	dev_t dev;
+	size_t ofs = 0;
+	bool interpose = false;
 	unsigned int major, minor;
 	char dummy;
 	struct dm_dev_internal *dd;
@@ -374,13 +376,40 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 
 	BUG_ON(!t);
 
-	if (sscanf(path, "%u:%u%c", &major, &minor, &dummy) == 2) {
+	/*
+	 * Extract extended options for device
+	 */
+	if (path[0] == '[') {
+		const char *interpose_opt = "interpose";
+		size_t opt_pos = 1;
+		size_t opt_len;
+
+		/*
+		 * Because only one option is supported yet, the parser
+		 * can be simplest.
+		 */
+		opt_len = strlen(interpose_opt);
+		if ((opt_pos + opt_len) < strlen(path) &&
+		    memcmp(&path[opt_pos], interpose_opt, opt_len) == 0) {
+			interpose = true;
+
+			if (!t->md->interpose)
+				t->md->interpose = true;
+		} else {
+			DMERR("Invalid devices extended options %s", path);
+			return -EINVAL;
+		}
+
+		ofs = opt_pos + opt_len + 1;
+	}
+
+	if (sscanf(&path[ofs], "%u:%u%c", &major, &minor, &dummy) == 2) {
 		/* Extract the major/minor numbers */
 		dev = MKDEV(major, minor);
 		if (MAJOR(dev) != major || MINOR(dev) != minor)
 			return -EOVERFLOW;
 	} else {
-		dev = dm_get_dev_t(path);
+		dev = dm_get_dev_t(&path[ofs]);
 		if (!dev)
 			return -ENODEV;
 	}
@@ -391,7 +420,8 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		if (!dd)
 			return -ENOMEM;
 
-		if ((r = dm_get_table_device(t->md, dev, mode, &dd->dm_dev))) {
+		r = dm_get_table_device(t->md, dev, mode, interpose, &dd->dm_dev);
+		if (r) {
 			kfree(dd);
 			return r;
 		}
@@ -401,14 +431,40 @@ int dm_get_device(struct dm_target *ti, const char *path, fmode_t mode,
 		goto out;
 
 	} else if (dd->dm_dev->mode != (mode | dd->dm_dev->mode)) {
-		r = upgrade_mode(dd, mode, t->md);
+		r = upgrade_mode(dd, mode, interpose, t->md);
 		if (r)
 			return r;
 	}
 	refcount_inc(&dd->count);
 out:
+	if (interpose) {
+		struct block_device *original = dd->dm_dev->bdev;
+		/*
+		 * Interposer target should cover all underlying device
+		 */
+		if (ti->begin != 0) {
+			DMERR("%s: target offset should be zero for dm interposer",
+			      dm_device_name(t->md));
+			r = -EINVAL;
+			goto fail;
+		}
+		if (bdev_nr_sectors(original) != ti->len) {
+			DMERR("%s: interposer and interposed block device size should be equal",
+			      dm_device_name(t->md));
+			r = -EINVAL;
+			goto fail;
+		}
+	}
+
 	*result = dd->dm_dev;
 	return 0;
+fail:
+	if (refcount_dec_and_test(&dd->count)) {
+		dm_put_table_device(t->md, dd->dm_dev);
+		list_del(&dd->list);
+		kfree(dd);
+	}
+	return r;
 }
 EXPORT_SYMBOL(dm_get_device);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3f3be9408afa..04142454c4ee 100644
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
@@ -1496,13 +1509,12 @@ static int __send_empty_flush(struct clone_info *ci)
 static int __clone_and_map_data_bio(struct clone_info *ci, struct dm_target *ti,
 				    sector_t sector, unsigned *len)
 {
-	struct bio *bio = ci->bio;
 	struct dm_target_io *tio;
 	int r;
 
 	tio = alloc_tio(ci, ti, 0, GFP_NOIO);
 	tio->len_ptr = len;
-	r = clone_bio(tio, bio, sector, *len);
+	r = clone_bio(tio, ci->bio, sector, *len);
 	if (r < 0) {
 		free_tio(tio);
 		return r;
@@ -1696,6 +1708,13 @@ static blk_qc_t dm_submit_bio(struct bio *bio)
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
@@ -2410,7 +2429,8 @@ static void dm_queue_flush(struct mapped_device *md)
  */
 struct dm_table *dm_swap_table(struct mapped_device *md, struct dm_table *table)
 {
-	struct dm_table *live_map = NULL, *map = ERR_PTR(-EINVAL);
+	struct dm_table *live_map = NULL;
+	struct dm_table *map = ERR_PTR(-EINVAL);
 	struct queue_limits limits;
 	int r;
 
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
@@ -2574,6 +2679,88 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	return r;
 }
 
+int __dm_attach_interposer(struct mapped_device *md)
+{
+	int r;
+	struct dm_table *map;
+	struct block_device *original_bdev = NULL;
+
+	if (dm_interposer_attached(md))
+		return 0;
+
+	map = rcu_dereference_protected(md->map,
+					lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		DMERR("%s: interposers table is not initialized",
+			dm_device_name(md));
+		return -EINVAL;
+	}
+
+	original_bdev = get_interposed_bdev(map);
+	if (!original_bdev) {
+		DMERR("%s: interposer cannot get interposed device from table",
+			dm_device_name(md));
+		return -EINVAL;
+	}
+
+	bdev_interposer_lock(original_bdev);
+
+	r = bdev_interposer_attach(original_bdev, dm_disk(md)->part0);
+	if (r)
+		DMERR("%s: failed to attach interposer",
+			dm_device_name(md));
+	else
+		set_bit(DMF_INTERPOSER_ATTACHED, &md->flags);
+
+	bdev_interposer_unlock(original_bdev);
+
+	unlock_bdev_fs(md, original_bdev);
+
+	bdput(original_bdev);
+
+	return r;
+}
+
+int __dm_detach_interposer(struct mapped_device *md)
+{
+	struct dm_table *map = NULL;
+	struct block_device *original_bdev;
+
+	if (!dm_interposer_attached(md))
+		return 0;
+	/*
+	 * If mapped device is suspended, but should be detached
+	 * we just detach without freeze fs on interposed device.
+	 */
+	map = rcu_dereference_protected(md->map,
+			lockdep_is_held(&md->suspend_lock));
+	if (!map) {
+		/*
+		 * If table is not initialized then interposed device
+		 * cannot be attached
+		 */
+		DMERR("%s: table is not initialized for device",
+			dm_device_name(md));
+		return -EINVAL;
+	}
+
+	original_bdev = get_interposed_bdev(map);
+	if (!original_bdev) {
+		DMERR("%s: interposer cannot get interposed device from table",
+			dm_device_name(md));
+		return -EINVAL;
+	}
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
@@ -2599,7 +2786,11 @@ int dm_suspend(struct mapped_device *md, unsigned suspend_flags)
 	mutex_lock_nested(&md->suspend_lock, SINGLE_DEPTH_NESTING);
 
 	if (dm_suspended_md(md)) {
-		r = -EINVAL;
+		if (suspend_flags & DM_SUSPEND_DETACH_IP_FLAG)
+			r = __dm_detach_interposer(md);
+		else
+			r = -EINVAL;
+
 		goto out_unlock;
 	}
 
@@ -2645,8 +2836,10 @@ static int __dm_resume(struct mapped_device *md, struct dm_table *map)
 	if (dm_request_based(md))
 		dm_start_queue(md->queue);
 
-	unlock_fs(md);
+	if (md->interpose)
+		return __dm_attach_interposer(md);
 
+	unlock_fs(md);
 	return 0;
 }
 
@@ -2880,6 +3073,11 @@ int dm_suspended_md(struct mapped_device *md)
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
index 5c641f930caf..3a7abb347702 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -159,6 +159,7 @@ struct dm_dev {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	fmode_t mode;
+	bool interpose;
 	char name[16];
 };
 
diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
index fcff6669137b..73a5b712cd0d 100644
--- a/include/uapi/linux/dm-ioctl.h
+++ b/include/uapi/linux/dm-ioctl.h
@@ -362,4 +362,10 @@ enum {
  */
 #define DM_INTERNAL_SUSPEND_FLAG	(1 << 18) /* Out */
 
+/*
+ * If set, the underlying device should open without FMODE_EXCL
+ * and attach mapped device via bdev_interposer.
+ */
+#define DM_INTERPOSE_FLAG		(1 << 19) /* In/Out */
+
 #endif				/* _LINUX_DM_IOCTL_H */
-- 
2.20.1

