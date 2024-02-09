Return-Path: <linux-fsdevel+bounces-10978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4D84F926
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDD91C21735
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F77B3D8;
	Fri,  9 Feb 2024 16:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hpns/wvn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687D77B3F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494619; cv=none; b=bsmt/H+LMe+rL/LW0hMPsmIzuIFx+B4qlRMlQlQCcswFS82NalPs9rKWCgGKKvG/Q24cZKZ9n7Gb9YPYZ9IqOl05DUh8gLLdHR4P+Rpz4M6bvL+I1SPAJLtytT0IF3lpUe3/YFs/w8jJvcgv58O1FgNuIDpiPiHbdYFJG63vOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494619; c=relaxed/simple;
	bh=1NVQQIKd06bGyHoMQfFBWYxUMoacBulRqc9Oq8KYyw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MqulS6kkoa+wuMMOFQsM104pHMxH56vKgn66uQxt4OYmy9DPRuNch5VyUyKnyP9CdFWnfcy4Wnq4WAV9j9CdiTvfm9ZB0bddrZX8vPkM3fIZPmob7/e+YXJHW15y/vpcK/o8JE+ZFHSozwskgNUt+0fS+m1km5KaoqBZa7sS7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hpns/wvn; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707494615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAj+o/7mElqTzYyTV54D7VA2S2hFW3PhpTk9kuFxUKs=;
	b=Hpns/wvn4b5MZ8mbU/LlGRsQNLn4lVMF6Z8DwH2L87/h7AbCGMo8qRTAfxW5AuFmi0jPjP
	/NLFh/rejnVfX0fqWDBSFfqw4sRbum5aaGQLsA8SA8V9GJT1JmuRu8sRM/YqhyrVebpj3I
	aSHTamuliYuMR9AyEnYpWgv60zqOy0s=
From: Sergei Shtepa <sergei.shtepa@linux.dev>
To: axboe@kernel.dk,
	hch@infradead.org,
	corbet@lwn.net,
	snitzer@kernel.org
Cc: linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 2/8] block: filtering of a block devices
Date: Fri,  9 Feb 2024 17:01:58 +0100
Message-Id: <20240209160204.1471421-3-sergei.shtepa@linux.dev>
In-Reply-To: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
References: <20240209160204.1471421-1-sergei.shtepa@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The block device filtering mechanism allows to attach block device
filters. Block device filters allow perform additional processing for
I/O units.

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
Signed-off-by: Sergei Shtepa <sergei.shtepa@linux.dev>
---
 block/Makefile                  |   3 +-
 block/bdev.c                    |   2 +
 block/blk-core.c                |  26 +++-
 block/blk-filter.c              | 257 ++++++++++++++++++++++++++++++++
 block/blk-mq.c                  |   7 +-
 block/blk-mq.h                  |   2 +-
 block/blk.h                     |  11 ++
 block/genhd.c                   |  10 ++
 block/ioctl.c                   |   7 +
 block/partitions/core.c         |   9 ++
 include/linux/blk-filter.h      |  72 +++++++++
 include/linux/blk_types.h       |   1 +
 include/linux/sched.h           |   1 +
 include/uapi/linux/blk-filter.h |  35 +++++
 include/uapi/linux/fs.h         |   3 +
 15 files changed, 441 insertions(+), 5 deletions(-)
 create mode 100644 block/blk-filter.c
 create mode 100644 include/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blk-filter.h

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
index e9f1b12bd75c..518677ef09dd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -418,6 +418,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+	bdev->bd_filter = NULL;
 	return bdev;
 }
 
@@ -1055,6 +1056,7 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 	}
 
 	invalidate_bdev(bdev);
+	blkfilter_detach(bdev);
 }
 /*
  * New drivers should not use this directly.  There are some drivers however
diff --git a/block/blk-core.c b/block/blk-core.c
index de771093b526..c4cbfe272091 100644
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
@@ -599,17 +600,38 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+/**
+ * resubmit_filtered_bio() - Resubmit the bio after processing by the filter.
+ * @bio:	The I/O unit.
+ *
+ * The filter can skip or postpone the processing of the I/O unit.
+ * This function allows to return the I/O unit for processing again.
+ */
+void resubmit_filtered_bio(struct bio *bio)
+{
+	if (!bio->bi_bdev->bd_has_submit_bio) {
+		blk_mq_submit_bio(bio, true);
+	} else if (likely(bio_queue_enter(bio) == 0)) {
+		struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+		disk->fops->submit_bio(bio);
+		blk_queue_exit(disk->queue);
+	}
+}
+EXPORT_SYMBOL_GPL(resubmit_filtered_bio);
+
 static void __submit_bio(struct bio *bio)
 {
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
 	if (!bio->bi_bdev->bd_has_submit_bio) {
-		blk_mq_submit_bio(bio);
+		blk_mq_submit_bio(bio, false);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-		disk->fops->submit_bio(bio);
+		if (!blkfilter_bio(bio))
+			disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
 }
diff --git a/block/blk-filter.c b/block/blk-filter.c
new file mode 100644
index 000000000000..00cbcb27edcd
--- /dev/null
+++ b/block/blk-filter.c
@@ -0,0 +1,257 @@
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
+static inline int is_disk_alive(struct gendisk *disk)
+{
+	int ret = 0;
+
+	mutex_lock(&disk->open_mutex);
+	if (!disk_live(disk))
+		ret = -ENODEV;
+	mutex_unlock(&disk->open_mutex);
+	return ret;
+}
+
+int blkfilter_ioctl_attach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp)
+{
+	struct blkfilter_name name;
+	struct blkfilter_operations *ops;
+	struct blkfilter *flt;
+	int ret = 0;
+
+	if (copy_from_user(&name, argp, sizeof(name)))
+		return -EFAULT;
+
+	spin_lock(&blkfilters_lock);
+	ops = __blkfilter_find(name.name);
+	if (ops && !try_module_get(ops->owner))
+		ops = NULL;
+	spin_unlock(&blkfilters_lock);
+	if (!ops)
+		return -ENOENT;
+
+	ret = is_disk_alive(bdev->bd_disk);
+	if (ret)
+		goto out_module_put;
+
+	ret = bdev_freeze(bdev);
+	if (ret)
+		goto out_module_put;
+	blk_mq_freeze_queue(bdev->bd_queue);
+
+	spin_lock(&blkfilters_lock);
+	if (bdev->bd_filter) {
+		if (bdev->bd_filter->ops == ops)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+	}
+	spin_unlock(&blkfilters_lock);
+	if (ret)
+		goto out_unfreeze;
+
+	flt = ops->attach(bdev);
+	if (IS_ERR(flt)) {
+		ret = PTR_ERR(flt);
+		goto out_unfreeze;
+	}
+	flt->ops = ops;
+
+	spin_lock(&blkfilters_lock);
+	if (bdev->bd_filter)
+		if (bdev->bd_filter->ops == ops)
+			ret = -EALREADY;
+		else
+			ret = -EBUSY;
+	else
+		bdev->bd_filter = flt;
+	spin_unlock(&blkfilters_lock);
+
+	if (ret)
+		ops->detach(flt);
+
+out_unfreeze:
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+	bdev_thaw(bdev);
+	if (ret)
+out_module_put:
+		module_put(ops->owner);
+	return ret;
+}
+
+static inline void __blkfilter_detach(struct blkfilter *flt)
+{
+	if (flt) {
+		const struct blkfilter_operations *ops = flt->ops;
+
+		ops->detach(flt);
+		module_put(ops->owner);
+	}
+}
+
+void blkfilter_detach(struct block_device *bdev)
+{
+	struct blkfilter *flt;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+
+	spin_lock(&blkfilters_lock);
+	flt = bdev->bd_filter;
+	if (flt)
+		bdev->bd_filter = NULL;
+	spin_unlock(&blkfilters_lock);
+
+	__blkfilter_detach(flt);
+
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+}
+
+int blkfilter_ioctl_detach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp)
+{
+	struct blkfilter_name name;
+	struct blkfilter *flt = NULL;
+	int ret = 0;
+
+	if (copy_from_user(&name, argp, sizeof(name)))
+		return -EFAULT;
+
+	ret = is_disk_alive(bdev->bd_disk);
+	if (ret)
+		return ret;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+
+	spin_lock(&blkfilters_lock);
+	if (bdev->bd_filter) {
+		if (strncmp(bdev->bd_filter->ops->name,
+			    name.name, BLKFILTER_NAME_LENGTH))
+			ret = -EINVAL;
+		else {
+			flt = bdev->bd_filter;
+			bdev->bd_filter = NULL;
+		}
+	} else
+		ret = -ENOENT;
+	spin_unlock(&blkfilters_lock);
+
+	__blkfilter_detach(flt);
+	blk_mq_unfreeze_queue(bdev->bd_queue);
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
+	ret = is_disk_alive(bdev->bd_disk);
+	if (ret)
+		return ret;
+
+	ret = blk_queue_enter(bdev_get_queue(bdev), 0);
+	if (ret)
+		return ret;
+
+	spin_lock(&blkfilters_lock);
+	flt = bdev->bd_filter;
+	if (!flt || strncmp(flt->ops->name, ctl.name, BLKFILTER_NAME_LENGTH))
+		ret = -ENOENT;
+	else if (!flt->ops->ctl)
+		ret = -ENOTTY;
+	spin_unlock(&blkfilters_lock);
+
+	if (!ret)
+		ret = flt->ops->ctl(flt, ctl.cmd, u64_to_user_ptr(ctl.opt),
+								&ctl.optlen);
+	blk_queue_exit(bdev_get_queue(bdev));
+	return ret;
+}
+
+ssize_t blkfilter_show(struct block_device *bdev, char *buf)
+{
+	int ret = 0;
+	const char *name = NULL;
+
+	ret = is_disk_alive(bdev->bd_disk);
+	if (ret)
+		goto out;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+	spin_lock(&blkfilters_lock);
+	if (bdev->bd_filter)
+		name = bdev->bd_filter->ops->name;
+	spin_unlock(&blkfilters_lock);
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+
+	if (name)
+		return sprintf(buf, "%s\n", name);
+out:
+	return sprintf(buf, "\n");
+}
+
+/**
+ * blkfilter_register() - Register block device filter operations.
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
+ * blkfilter_unregister() - Unregister block device filter operations.
+ * @ops:	The operations to unregister.
+ *
+ * Recommended to detach the filter from all block devices before
+ * unregistering block device filter operations.
+ */
+void blkfilter_unregister(struct blkfilter_operations *ops)
+{
+	spin_lock(&blkfilters_lock);
+	list_del(&ops->link);
+	spin_unlock(&blkfilters_lock);
+}
+EXPORT_SYMBOL_GPL(blkfilter_unregister);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c53a196f579e..e109f2dd05a0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -11,6 +11,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
+#include <linux/blk-filter.h>
 #include <linux/kmemleak.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -2951,6 +2952,7 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
+ * @is_filtered: Indicates that the bio has been processed by the filter.
  *
  * Builds up a request structure from @q and @bio and send to the device. The
  * request may not be queued directly to hardware if:
@@ -2961,7 +2963,7 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
  * It will not queue the request if there is an error with the bio, or at the
  * request creation.
  */
-void blk_mq_submit_bio(struct bio *bio)
+void blk_mq_submit_bio(struct bio *bio, bool is_filtered)
 {
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = blk_mq_plug(bio);
@@ -2990,6 +2992,9 @@ void blk_mq_submit_bio(struct bio *bio)
 		if (!bio)
 			goto queue_exit;
 	}
+	if (!is_filtered)
+		if (blkfilter_bio(bio))
+			goto queue_exit;
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index f75a9ecfebde..8ef909e295bc 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -39,7 +39,7 @@ enum {
 typedef unsigned int __bitwise blk_insert_t;
 #define BLK_MQ_INSERT_AT_HEAD		((__force blk_insert_t)0x01)
 
-void blk_mq_submit_bio(struct bio *bio);
+void blk_mq_submit_bio(struct bio *bio, bool is_filtered);
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp_batch *iob,
 		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
diff --git a/block/blk.h b/block/blk.h
index 1ef920f72e0f..0846135b6d89 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,6 +7,8 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
+struct blkfilter_ctl;
+struct blkfilter_name;
 struct elevator_type;
 
 /* Max future timer expiry for timeouts */
@@ -472,6 +474,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
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
index d74fb5b4ae68..f62bf6229d7a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -26,6 +26,7 @@
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
 #include <linux/blktrace_api.h>
+#include <linux/blk-filter.h>
 
 #include "blk-throttle.h"
 #include "blk.h"
@@ -657,6 +658,7 @@ void del_gendisk(struct gendisk *disk)
 	mutex_lock(&disk->open_mutex);
 	xa_for_each(&disk->part_tbl, idx, part)
 		remove_inode_hash(part->bd_inode);
+	blkfilter_detach(disk->part0);
 	mutex_unlock(&disk->open_mutex);
 
 	/*
@@ -1047,6 +1049,12 @@ static ssize_t diskseq_show(struct device *dev,
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
@@ -1060,6 +1068,7 @@ static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
 static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
+static DEVICE_ATTR(filter, 0444, disk_filter_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1106,6 +1115,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
 	&dev_attr_diskseq.attr,
+	&dev_attr_filter.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
diff --git a/block/ioctl.c b/block/ioctl.c
index 438f79c564cf..8755eeab2488 100644
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
@@ -573,6 +574,12 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
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
index 5f5ed5c75f04..8426e524100e 100644
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
index 000000000000..86125122562c
--- /dev/null
+++ b/include/linux/blk-filter.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Veeam Software Group GmbH */
+#ifndef _LINUX_BLK_FILTER_H
+#define _LINUX_BLK_FILTER_H
+
+#include <uapi/linux/blk-filter.h>
+#include <linux/bio.h>
+
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
+/*
+ * The internal function for the block layer.
+ * Executes a call to the filter handler for the I/O unit.
+ */
+static inline bool blkfilter_bio(struct bio *bio)
+{
+	bool skip_bio = false;
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
+	return skip_bio;
+};
+
+void resubmit_filtered_bio(struct bio *bio);
+
+#endif /* _UAPI_LINUX_BLK_FILTER_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f288c94374b3..8fdb086a1cd5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -74,6 +74,7 @@ struct block_device {
 	 * path
 	 */
 	struct device		bd_device;
+	struct blkfilter	*bd_filter;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..175e13d0c0b0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1193,6 +1193,7 @@ struct task_struct {
 
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
index 48ad69f7722e..19a83c3e05c5 100644
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
2.34.1


