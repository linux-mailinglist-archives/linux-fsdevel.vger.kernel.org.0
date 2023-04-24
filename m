Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168936D8363
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjDEQQQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjDEQPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:15:52 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98727DAC;
        Wed,  5 Apr 2023 09:15:09 -0700 (PDT)
Received: from mx1.veeam.com (mx1.veeam.com [172.18.34.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 601D440FFD;
        Wed,  5 Apr 2023 12:13:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1680711222;
        bh=3UR7des7d1SNvYKVMBIh+qNln+2BT+04uvAOd7yuI2M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RIn3+U5jfhLQPg7zRfvsc7fK79NALYNvCq4O6/oPagmitiWZ7B2wDCCLFlXAP+LR+
         z2uKPTyIUEEdZfx/9JeZlVdmA9RJVJhtO2IZ99bG8jQZSqa0ct/Mh1G8MUyfGEvPRk
         MKIRN+m7/95OUFkeL5gKOAubKH34DQHNY82brfnxaOToZO/FsHRll99hx7rW8WVCcl
         +FK7hNt54IxmfOxlZu2YPHPRd/zNxbrJ3Ka8miSsvrXjRQ0vPO5h0bv++yX97cnYqg
         PnYEiXSISZcIX8fSGK+KuaHxdbuT0QImTaOk0KbUvT7ngJCEE6qSuQU29LsNkOFPtk
         mr6GLnSZrsE/A==
Received: from mx4.veeam.com (mx4.amust.local [172.31.224.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id 5664A42411;
        Wed,  5 Apr 2023 06:09:16 -0400 (EDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 65A047D65D;
        Tue,  4 Apr 2023 17:09:03 +0300 (MSK)
Received: from ssh-deb10-ssd-vb.amust.local (172.24.10.107) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 4 Apr 2023 16:08:59 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <hch@infradead.org>, <corbet@lwn.net>,
        <snitzer@kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <willy@infradead.org>, <kch@nvidia.com>,
        <martin.petersen@oracle.com>, <vkoul@kernel.org>,
        <ming.lei@redhat.com>, <gregkh@linuxfoundation.org>,
        <linux-block@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <sergei.shtepa@veeam.com>
Subject: [PATCH v3 02/11] block: Block Device Filtering Mechanism
Date:   Tue, 4 Apr 2023 16:08:26 +0200
Message-ID: <20230404140835.25166-3-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230404140835.25166-1-sergei.shtepa@veeam.com>
References: <20230404140835.25166-1-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.128.103) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A2924031554657367
X-Veeam-MMEX: True
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 MAINTAINERS                     |   3 +
 block/Makefile                  |   2 +-
 block/bdev.c                    |   1 +
 block/blk-core.c                |  40 ++++++-
 block/blk-filter.c              | 199 ++++++++++++++++++++++++++++++++
 block/blk.h                     |  10 ++
 block/genhd.c                   |   2 +
 block/ioctl.c                   |   7 ++
 block/partitions/core.c         |   2 +
 include/linux/blk-filter.h      |  51 ++++++++
 include/linux/blk_types.h       |   2 +
 include/linux/blkdev.h          |   1 +
 include/uapi/linux/blk-filter.h |  35 ++++++
 include/uapi/linux/fs.h         |   5 +
 14 files changed, 357 insertions(+), 3 deletions(-)
 create mode 100644 block/blk-filter.c
 create mode 100644 include/linux/blk-filter.h
 create mode 100644 include/uapi/linux/blk-filter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cbe4331ac97..fb6b7abe83e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3576,6 +3576,9 @@ M:	Sergei Shtepa <sergei.shtepa@veeam.com>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	Documentation/block/blkfilter.rst
+F:	block/blk-filter.c
+F:	include/linux/blk-filter.h
+F:	include/uapi/linux/blk-filter.h
 
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
diff --git a/block/Makefile b/block/Makefile
index 4e01bb71ad6e..d4671c7e499c 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -9,7 +9,7 @@ obj-y		:= bdev.o fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o ioprio.o badblocks.o partitions/ blk-rq-qos.o \
-			disk-events.o blk-ia-ranges.o
+			disk-events.o blk-ia-ranges.o blk-filter.o
 
 obj-$(CONFIG_BOUNCE)		+= bounce.o
 obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
diff --git a/block/bdev.c b/block/bdev.c
index 1795c7d4b99e..e290020810dd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -424,6 +424,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 		return NULL;
 	}
 	bdev->bd_disk = disk;
+	bdev->bd_filter = NULL;
 	return bdev;
 }
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 42926e6cb83c..179a1c9ecc90 100644
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
@@ -591,10 +592,32 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
+static bool submit_bio_filter(struct bio *bio)
+{
+	/*
+	 * If this bio came from the filter driver, send it straight down to the
+	 * actual device and clear the filtered flag, as the bio could be passed
+	 * on to another device that might have a filter attached again.
+	 */
+	if (bio_flagged(bio, BIO_FILTERED)) {
+		bio_clear_flag(bio, BIO_FILTERED);
+		return false;
+	}
+	bio_set_flag(bio, BIO_FILTERED);
+	return bio->bi_bdev->bd_filter->ops->submit_bio(bio);
+}
+
 static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
+	/*
+	 * If there is a filter driver attached, check if the BIO needs to go to
+	 * the filter driver first, which can then pass on the bio or consume it.
+	 */
+	if (bio->bi_bdev->bd_filter && submit_bio_filter(bio))
+		return;
+
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
@@ -682,6 +705,15 @@ static void __submit_bio_noacct_mq(struct bio *bio)
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
@@ -702,13 +734,17 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 * to collect a list of requests submited by a ->submit_bio method while
 	 * it is active, and then process them after it returned.
 	 */
-	if (current->bio_list)
+	if (current->bio_list) {
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_disk->fops->submit_bio)
+		return;
+	}
+
+	if (!bio->bi_bdev->bd_disk->fops->submit_bio)
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
 }
+EXPORT_SYMBOL_GPL(submit_bio_noacct_nocheck);
 
 /**
  * submit_bio_noacct - re-submit a bio to the block device layer for I/O
diff --git a/block/blk-filter.c b/block/blk-filter.c
new file mode 100644
index 000000000000..5e9d884fad4d
--- /dev/null
+++ b/block/blk-filter.c
@@ -0,0 +1,199 @@
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
+	ret = freeze_bdev(bdev);
+	if (ret)
+		goto out_put_module;
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
+out_put_module:
+	if (ret)
+		module_put(ops->owner);
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
+	module_put(ops->owner);
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
+	int error = 0;
+
+	if (copy_from_user(&name, argp, sizeof(name)))
+		return -EFAULT;
+
+	blk_mq_freeze_queue(bdev->bd_queue);
+	if (!bdev->bd_filter) {
+		error = -ENOENT;
+		goto out_unfreeze;
+	}
+	if (strncmp(bdev->bd_filter->ops->name, name.name,
+			BLKFILTER_NAME_LENGTH)) {
+		error = -EINVAL;
+		goto out_unfreeze;
+	}
+
+	__blkfilter_detach(bdev);
+out_unfreeze:
+	blk_mq_unfreeze_queue(bdev->bd_queue);
+	return error;
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
+	ret = blk_queue_enter(bdev_get_queue(bdev), 0);
+	if (ret)
+		return ret;
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
index cc4e8873dfde..3500e46368e3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,6 +7,8 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 
+struct blkfilter_ctl;
+struct blkfilter_name;
 struct elevator_type;
 
 /* Max future timer expiry for timeouts */
@@ -454,6 +456,14 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
 
+int blkfilter_ioctl_attach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp);
+int blkfilter_ioctl_detach(struct block_device *bdev,
+		    struct blkfilter_name __user *argp);
+int blkfilter_ioctl_ctl(struct block_device *bdev,
+		    struct blkfilter_ctl __user *argp);
+void blkfilter_detach(struct block_device *bdev);
+
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
diff --git a/block/genhd.c b/block/genhd.c
index 02d9cfb9e077..b23ceea895de 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
 #include <linux/part_stat.h>
+#include <linux/blk-filter.h>
 #include "blk-throttle.h"
 
 #include "blk.h"
@@ -625,6 +626,7 @@ void del_gendisk(struct gendisk *disk)
 
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
+	blkfilter_detach(disk->part0);
 
 	/*
 	 * Fail any new I/O.
diff --git a/block/ioctl.c b/block/ioctl.c
index 9c5f637ff153..e840150e1aa8 100644
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
@@ -545,6 +546,12 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		return blkdev_pr_preempt(bdev, argp, true);
 	case IOC_PR_CLEAR:
 		return blkdev_pr_clear(bdev, argp);
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
index 7b8ef6296abd..0b5e3a3f7c31 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -10,6 +10,7 @@
 #include <linux/ctype.h>
 #include <linux/vmalloc.h>
 #include <linux/raid/detect.h>
+#include <linux/blk-filter.h>
 #include "check.h"
 
 static int (*check_part[])(struct parsed_partitions *) = {
@@ -277,6 +278,7 @@ static void delete_partition(struct block_device *part)
 
 	fsync_bdev(part);
 	__invalidate_device(part, true);
+	blkfilter_detach(part);
 
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
 	kobject_put(part->bd_holder_dir);
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
index 99be590f952f..b140ddd9b7ab 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -68,6 +68,7 @@ struct block_device {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
 #endif
+	struct blkfilter	*bd_filter;
 } __randomize_layout;
 
 #define bdev_whole(_bdev) \
@@ -333,6 +334,7 @@ enum {
 	BIO_QOS_MERGED,		/* but went through rq_qos merge path */
 	BIO_REMAPPED,
 	BIO_ZONE_WRITE_LOCKED,	/* Owns a zoned device zone write lock */
+	BIO_FILTERED,		/* bio has already been filtered */
 	BIO_FLAG_LAST
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 941304f17492..25ebbf296f35 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -854,6 +854,7 @@ void blk_request_module(dev_t devt);
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
+void submit_bio_noacct_nocheck(struct bio *bio);
 void submit_bio_noacct(struct bio *bio);
 struct bio *bio_split_to_limits(struct bio *bio);
 
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
index b7b56871029c..1848d62979a4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -185,6 +185,11 @@ struct fsxattr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+/* 13* is defined in linux/blkzoned.h */
+#define BLKFILTER_ATTACH	_IOWR(0x12, 140, struct blkfilter_name)
+#define BLKFILTER_DETACH	_IOWR(0x12, 141, struct blkfilter_name)
+#define BLKFILTER_CTL		_IOWR(0x12, 142, struct blkfilter_ctl)
+
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.20.1

