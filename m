Return-Path: <linux-fsdevel+bounces-3733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194637F79CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3711F20F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D31235F04;
	Fri, 24 Nov 2023 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7Wu5Iyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692B219BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 08:59:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700845189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0AFCXYWnD8+A9LPjk6gYMyLJ/8u6+TPPOfbw4VMVDQ=;
	b=f7Wu5IycjO2EE+7ouCpR3Y+28+DL4N8xoXRkBcmvW6bxQIYs73tO7mwb/gQF0lnxlkoW2s
	Z/PzPN8XwgJA76uhohIwTu4YhzndRaPD2aLdLDBaGcDmKNmrbRFRedNKLzsjg26yw7foXQ
	WrWRvPpSQBWMS8p9TRVXMWPmRMWNcvs=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Sergei Shtepa <sergei.shtepa@veeam.com>,
	Donald Buczek <buczek@molgen.mpg.de>,
	Fabio Fantoni <fantonifabio@tiscali.it>
Subject: [PATCH v6 02/11] block: Block Device Filtering Mechanism
Date: Fri, 24 Nov 2023 17:59:24 +0100
Message-Id: <20231124165933.27580-3-sergei.shtepa@linux.dev>
In-Reply-To: <20231124165933.27580-1-sergei.shtepa@linux.dev>
References: <20231124165933.27580-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sergei Shtepa <sergei.shtepa@veeam.com>

The block device filtering mechanism is an API that allows to attach
block device filters. Block device filters allow perform additional
processing for I/O units.

The idea of handling I/O units on block devices is not new. Back in the
2.6 kernel, there was an undocumented possibility of handling I/O units
by substituting the make_request_fn() function, which belonged to the
request_queue structure. But none of the in-tree kernel modules used
this feature, and it was eliminated in the 5.10 kernel.

The block device filtering mechanism returns the ability to handle I/O
units. It is possible to safely attach filter to a block device "on the
fly" without changing the structure of block devices stack.

Co-developed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Christoph Hellwig <hch@infradead.org>
Tested-by: Donald Buczek <buczek@molgen.mpg.de>
Tested-by: Fabio Fantoni <fantonifabio@tiscali.it>
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 MAINTAINERS                     |   3 +
 block/Makefile                  |   3 +-
 block/bdev.c                    |   2 +
 block/blk-core.c                |  35 ++++-
 block/blk-filter.c              | 238 ++++++++++++++++++++++++++++++++
 block/blk.h                     |  11 ++
 block/genhd.c                   |  10 ++
 block/ioctl.c                   |   7 +
 block/partitions/core.c         |   9 ++
 include/linux/blk-filter.h      |  51 +++++++
 include/linux/blk_types.h       |   1 +
 include/linux/blkdev.h          |   1 +
 include/linux/sched.h           |   1 +
 include/uapi/linux/blk-filter.h |  35 +++++
 include/uapi/linux/fs.h         |   3 +
 15 files changed, 408 insertions(+), 2 deletions(-)
 create mode 100644 block/blk-filter.c
 create mode 100644 include/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blk-filter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c20cbec81b58..ef90cd0fec9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3589,6 +3589,9 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	Documentation/block/blkfilter.rst
+F:	block/blk-filter.c
+F:	include/linux/blk-filter.h
+F:	include/uapi/linux/blk-filter.h
 
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
diff --git a/block/Makefile b/block/Makefile
index 46ada9dc8bbf..041c54eb0240 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,8 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
-			disk-events.o blk-ia-ranges.o early-lookup.o
+			disk-events.o blk-ia-ranges.o early-lookup.o \
+			blk-filter.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
diff --git a/block/bdev.c b/block/bdev.c
index e4cfb7adb645..6039d99b3a75 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -412,6 +412,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+	bdev->bd_filter = NULL;
 	return bdev;
 }
 
@@ -1018,6 +1019,7 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 	}
 
 	invalidate_bdev(bdev);
+	blkfilter_detach(bdev);
 }
 /*
  * New drivers should not use this directly.  There are some drivers however
diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..1de74240892a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -18,6 +18,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-pm.h>
 #include <linux/blk-integrity.h>
+#include <linux/blk-filter.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -592,12 +593,34 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+	bool skip_bio = false;
+
+	if (unlikely(bio_queue_enter(bio)))
+		return;
+
+	if (bio->bi_bdev->bd_filter &&
+	    bio->bi_bdev->bd_filter != current->blk_filter) {
+		struct blkfilter *prev = current->blk_filter;
+
+		current->blk_filter = bio->bi_bdev->bd_filter;
+		skip_bio = bio->bi_bdev->bd_filter->ops->submit_bio(bio);
+		current->blk_filter = prev;
+	}
+
+	blk_queue_exit(q);
+	if (skip_bio)
+		return;
+
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
 	if (!bio->bi_bdev->bd_has_submit_bio) {
 		blk_mq_submit_bio(bio);
-	} else if (likely(bio_queue_enter(bio) == 0)) {
+		return;
+	}
+
+	if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
 
 		disk->fops->submit_bio(bio);
@@ -681,6 +704,15 @@ static void __submit_bio_noacct_mq(struct bio *bio)
 	current->bio_list = NULL;
 }
 
+/**
+ * submit_bio_noacct_nocheck - re-submit a bio to the block device layer for I/O
+ *	from block device filter.
+ * @bio:  The bio describing the location in memory and on the device.
+ *
+ * This is a version of submit_bio() that shall only be used for I/O that is
+ * resubmitted to lower level by block device filters.  All file  systems and
+ * other upper level users of the block layer should use submit_bio() instead.
+ */
 void submit_bio_noacct_nocheck(struct bio *bio)
 {
 	blk_cgroup_bio_start(bio);
@@ -708,6 +740,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	else
 		__submit_bio_noacct(bio);
 }
+EXPORT_SYMBOL_GPL(submit_bio_noacct_nocheck);
 
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
diff --git a/block/blk-filter.c b/block/blk-filter.c
new file mode 100644
index 000000000000..8e2550bed0c5
--- /dev/null
+++ b/block/blk-filter.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#include <linux/blk-filter.h>
+#include <linux/blk-mq.h>
+#include <linux/module.h>
+
+#include "blk.h"
+
+static LIST_HEAD(blkfilters);
+static DEFINE_SPINLOCK(blkfilters_lock);
+
+static inline struct blkfilter_operations *__blkfilter_find(const char *name)
+{
+	struct blkfilter_operations *ops;
+
+	list_for_each_entry(ops, &blkfilters, link)
+		if (strncmp(ops->name, name, BLKFILTER_NAME_LENGTH) == 0)
+			return ops;
+
+	return NULL;
+}
+
+static inline struct blkfilter_operations *blkfilter_find_get(const char *name)
+{
+	struct blkfilter_operations *ops;
+
+	spin_lock(&blkfilters_lock);
+	ops = __blkfilter_find(name);
+	if (ops && !try_module_get(ops->owner))
+		ops = NULL;
+	spin_unlock(&blkfilters_lock);
+
+	return ops;
+}
+
+static inline void blkfilter_put(const struct blkfilter_operations *ops)
+{
+	module_put(ops->owner);
+}
+
+int blkfilter_ioctl_attach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp)
+{
+	struct blkfilter_name name;
+	struct blkfilter_operations *ops;
+	struct blkfilter *flt;
+	int ret;
+
+	if (copy_from_user(&name, argp, sizeof(name)))
+		return -EFAULT;
+
+	ops = blkfilter_find_get(name.name);
+	if (!ops)
+		return -ENOENT;
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!disk_live(bdev->bd_disk)) {
+		ret = -ENODEV;
+		goto out_mutex_unlock;
+	}
+	ret = freeze_bdev(bdev);
+	if (ret)
+		goto out_mutex_unlock;
+	blk_mq_freeze_queue(bdev->bd_queue);
+
+	if (bdev->bd_filter) {
+		if (bdev->bd_filter->ops == ops)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+		goto out_unfreeze;
+	}
+
+	flt = ops->attach(bdev);
+	if (IS_ERR(flt)) {
+		ret = PTR_ERR(flt);
+		goto out_unfreeze;
+	}
+
+	flt->ops = ops;
+	bdev->bd_filter = flt;
+
+out_unfreeze:
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+	thaw_bdev(bdev);
+out_mutex_unlock:
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	if (ret)
+		blkfilter_put(ops);
+	return ret;
+}
+
+static void __blkfilter_detach(struct block_device *bdev)
+{
+	struct blkfilter *flt = bdev->bd_filter;
+	const struct blkfilter_operations *ops = flt->ops;
+
+	bdev->bd_filter = NULL;
+	ops->detach(flt);
+	blkfilter_put(ops);
+}
+
+void blkfilter_detach(struct block_device *bdev)
+{
+	if (bdev->bd_filter) {
+		blk_mq_freeze_queue(bdev->bd_queue);
+		__blkfilter_detach(bdev);
+		blk_mq_unfreeze_queue(bdev->bd_queue);
+	}
+}
+
+int blkfilter_ioctl_detach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp)
+{
+	struct blkfilter_name name;
+	int ret = 0;
+
+	if (copy_from_user(&name, argp, sizeof(name)))
+		return -EFAULT;
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!disk_live(bdev->bd_disk)) {
+		ret = -ENODEV;
+		goto out_mutex_unlock;
+	}
+	blk_mq_freeze_queue(bdev->bd_queue);
+	if (!bdev->bd_filter) {
+		ret = -ENOENT;
+		goto out_unfreeze;
+	}
+	if (strncmp(bdev->bd_filter->ops->name, name.name,
+			BLKFILTER_NAME_LENGTH)) {
+		ret = -EINVAL;
+		goto out_unfreeze;
+	}
+
+	__blkfilter_detach(bdev);
+out_unfreeze:
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+out_mutex_unlock:
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	return ret;
+}
+
+int blkfilter_ioctl_ctl(struct block_device *bdev,
+		    struct blkfilter_ctl __user *argp)
+{
+	struct blkfilter_ctl ctl;
+	struct blkfilter *flt;
+	int ret;
+
+	if (copy_from_user(&ctl, argp, sizeof(ctl)))
+		return -EFAULT;
+
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!disk_live(bdev->bd_disk)) {
+		ret = -ENODEV;
+		goto out_mutex_unlock;
+	}
+	ret = blk_queue_enter(bdev_get_queue(bdev), 0);
+	if (ret)
+		goto out_mutex_unlock;
+
+	flt = bdev->bd_filter;
+	if (!flt || strncmp(flt->ops->name, ctl.name, BLKFILTER_NAME_LENGTH)) {
+		ret = -ENOENT;
+		goto out_queue_exit;
+	}
+
+	if (!flt->ops->ctl) {
+		ret = -ENOTTY;
+		goto out_queue_exit;
+	}
+
+	ret = flt->ops->ctl(flt, ctl.cmd, u64_to_user_ptr(ctl.opt),
+			    &ctl.optlen);
+out_queue_exit:
+	blk_queue_exit(bdev_get_queue(bdev));
+out_mutex_unlock:
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	return ret;
+}
+
+ssize_t blkfilter_show(struct block_device *bdev, char *buf)
+{
+	ssize_t ret = 0;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+	if (bdev->bd_filter)
+		ret = sprintf(buf, "%s\n", bdev->bd_filter->ops->name);
+	else
+		ret = sprintf(buf, "\n");
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+
+	return ret;
+}
+
+/**
+ * blkfilter_register() - Register block device filter operations
+ * @ops:	The operations to register.
+ *
+ * Return:
+ *	0 if succeeded,
+ *	-EBUSY if a block device filter with the same name is already
+ *	registered.
+ */
+int blkfilter_register(struct blkfilter_operations *ops)
+{
+	struct blkfilter_operations *found;
+	int ret = 0;
+
+	spin_lock(&blkfilters_lock);
+	found = __blkfilter_find(ops->name);
+	if (found)
+		ret = -EBUSY;
+	else
+		list_add_tail(&ops->link, &blkfilters);
+	spin_unlock(&blkfilters_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkfilter_register);
+
+/**
+ * blkfilter_unregister() - Unregister block device filter operations
+ * @ops:	The operations to unregister.
+ *
+ * Important: before unloading, it is necessary to detach the filter from all
+ * block devices.
+ *
+ */
+void blkfilter_unregister(struct blkfilter_operations *ops)
+{
+	spin_lock(&blkfilters_lock);
+	list_del(&ops->link);
+	spin_unlock(&blkfilters_lock);
+}
+EXPORT_SYMBOL_GPL(blkfilter_unregister);
diff --git a/block/blk.h b/block/blk.h
index 08a358bc0919..1f104f4865c3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,6 +7,8 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
+struct blkfilter_ctl;
+struct blkfilter_name;
 struct elevator_type;
 
 /* Max future timer expiry for timeouts */
@@ -474,6 +476,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
 
+int blkfilter_ioctl_attach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp);
+int blkfilter_ioctl_detach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp);
+int blkfilter_ioctl_ctl(struct block_device *bdev,
+		    struct blkfilter_ctl __user *argp);
+void blkfilter_detach(struct block_device *bdev);
+ssize_t blkfilter_show(struct block_device *bdev, char *buf);
+
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
diff --git a/block/genhd.c b/block/genhd.c
index c9d06f72c587..ba744e3fd581 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -26,6 +26,7 @@
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
 #include <linux/blktrace_api.h>
+#include <linux/blk-filter.h>
 
 #include "blk-throttle.h"
 #include "blk.h"
@@ -654,6 +655,7 @@ void del_gendisk(struct gendisk *disk)
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
 		remove_inode_hash(part->bd_inode);
+	blkfilter_detach(disk->part0);
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -1044,6 +1046,12 @@ static ssize_t diskseq_show(struct device *dev,
 	return sprintf(buf, "%llu\n", disk->diskseq);
 }
 
+static ssize_t disk_filter_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return blkfilter_show(dev_to_bdev(dev), buf);
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -1057,6 +1065,7 @@ static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
+static DEVICE_ATTR(filter, 0444, disk_filter_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1103,6 +1112,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
+	&dev_attr_filter.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
diff --git a/block/ioctl.c b/block/ioctl.c
index 4160f4e6bd5b..1b11303e213b 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -2,6 +2,7 @@
 #include <linux/capability.h>
 #include <linux/compat.h>
 #include <linux/blkdev.h>
+#include <linux/blk-filter.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/blkpg.h>
@@ -572,6 +573,12 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return blkdev_pr_preempt(bdev, mode, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, mode, argp);
+	case BLKFILTER_ATTACH:
+		return blkfilter_ioctl_attach(bdev, argp);
+	case BLKFILTER_DETACH:
+		return blkfilter_ioctl_detach(bdev, argp);
+	case BLKFILTER_CTL:
+		return blkfilter_ioctl_ctl(bdev, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f47ffcfdfcec..19c69dc23d2c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
+#include <linux/blk-filter.h>
 #include "check.h"
 
 static int (*const check_part[])(struct parsed_partitions *) = {
@@ -200,6 +201,12 @@ static ssize_t part_discard_alignment_show(struct device *dev,
 	return sprintf(buf, "%u\n", bdev_discard_alignment(dev_to_bdev(dev)));
 }
 
+static ssize_t part_filter_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return blkfilter_show(dev_to_bdev(dev), buf);
+}
+
 static DEVICE_ATTR(partition, 0444, part_partition_show, NULL);
 static DEVICE_ATTR(start, 0444, part_start_show, NULL);
 static DEVICE_ATTR(size, 0444, part_size_show, NULL);
@@ -208,6 +215,7 @@ static DEVICE_ATTR(alignment_offset, 0444, part_alignment_offset_show, NULL);
 static DEVICE_ATTR(discard_alignment, 0444, part_discard_alignment_show, NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
+static DEVICE_ATTR(filter, 0444, part_filter_show, NULL);
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 static struct device_attribute dev_attr_fail =
 	__ATTR(make-it-fail, 0644, part_fail_show, part_fail_store);
@@ -222,6 +230,7 @@ static struct attribute *part_attrs[] = {
 	&dev_attr_discard_alignment.attr,
 	&dev_attr_stat.attr,
 	&dev_attr_inflight.attr,
+	&dev_attr_filter.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
diff --git a/include/linux/blk-filter.h b/include/linux/blk-filter.h
new file mode 100644
index 000000000000..0afdb40f3bab
--- /dev/null
+++ b/include/linux/blk-filter.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef _LINUX_BLK_FILTER_H
+#define _LINUX_BLK_FILTER_H
+
+#include <uapi/linux/blk-filter.h>
+
+struct bio;
+struct block_device;
+struct blkfilter_operations;
+
+/**
+ * struct blkfilter - Block device filter.
+ *
+ * @ops:	Block device filter operations.
+ *
+ * For each filtered block device, the filter creates a data structure
+ * associated with this device. The data in this structure is specific to the
+ * filter, but it must contain a pointer to the block device filter account.
+ */
+struct blkfilter {
+	const struct blkfilter_operations *ops;
+};
+
+/**
+ * struct blkfilter_operations - Block device filter operations.
+ *
+ * @link:	Entry in the global list of filter drivers
+ *		(must not be accessed by the driver).
+ * @owner:	Module implementing the filter driver.
+ * @name:	Name of the filter driver.
+ * @attach:	Attach the filter driver to the block device.
+ * @detach:	Detach the filter driver from the block device.
+ * @ctl:	Send a control command to the filter driver.
+ * @submit_bio:	Handle bio submissions to the filter driver.
+ */
+struct blkfilter_operations {
+	struct list_head link;
+	struct module *owner;
+	const char *name;
+	struct blkfilter *(*attach)(struct block_device *bdev);
+	void (*detach)(struct blkfilter *flt);
+	int (*ctl)(struct blkfilter *flt, const unsigned int cmd,
+		   __u8 __user *buf, __u32 *plen);
+	bool (*submit_bio)(struct bio *bio);
+};
+
+int blkfilter_register(struct blkfilter_operations *ops);
+void blkfilter_unregister(struct blkfilter_operations *ops);
+
+#endif /* _UAPI_LINUX_BLK_FILTER_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d5c5e59ddbd2..490865292fde 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -74,6 +74,7 @@ struct block_device {
 	 * path
 	 */
 	struct device		bd_device;
+	struct blkfilter	*bd_filter;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..6a0754007d1d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -834,6 +834,7 @@ void blk_request_module(dev_t devt);
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
+void submit_bio_noacct_nocheck(struct bio *bio);
 void submit_bio_noacct(struct bio *bio);
 struct bio *bio_split_to_limits(struct bio *bio);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..e7c3cd490a80 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1190,6 +1190,7 @@ struct task_struct {
 
 	/* Stack plugging: */
 	struct blk_plug			*plug;
+	struct blkfilter		*blk_filter;
 
 	/* VM state: */
 	struct reclaim_state		*reclaim_state;
diff --git a/include/uapi/linux/blk-filter.h b/include/uapi/linux/blk-filter.h
new file mode 100644
index 000000000000..18885dc1b717
--- /dev/null
+++ b/include/uapi/linux/blk-filter.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef _UAPI_LINUX_BLK_FILTER_H
+#define _UAPI_LINUX_BLK_FILTER_H
+
+#include <linux/types.h>
+
+#define BLKFILTER_NAME_LENGTH	32
+
+/**
+ * struct blkfilter_name - parameter for BLKFILTER_ATTACH and BLKFILTER_DETACH
+ *      ioctl.
+ *
+ * @name:       Name of block device filter.
+ */
+struct blkfilter_name {
+	__u8 name[BLKFILTER_NAME_LENGTH];
+};
+
+/**
+ * struct blkfilter_ctl - parameter for BLKFILTER_CTL ioctl
+ *
+ * @name:	Name of block device filter.
+ * @cmd:	The filter-specific operation code of the command.
+ * @optlen:	Size of data at @opt.
+ * @opt:	Userspace buffer with options.
+ */
+struct blkfilter_ctl {
+	__u8 name[BLKFILTER_NAME_LENGTH];
+	__u32 cmd;
+	__u32 optlen;
+	__u64 opt;
+};
+
+#endif /* _UAPI_LINUX_BLK_FILTER_H */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index da43810b7485..f96809cd2f50 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -189,6 +189,9 @@ struct fsxattr {
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
  */
+#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
+#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
+#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
-- 
2.20.1


