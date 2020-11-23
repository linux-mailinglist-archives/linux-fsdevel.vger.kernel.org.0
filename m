Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB22BFDAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKWAlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Nov 2020 19:41:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44470 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgKWAlq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Nov 2020 19:41:46 -0500
X-IronPort-AV: E=Sophos;i="5.78,361,1599494400"; 
   d="scan'208";a="101635235"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Nov 2020 08:41:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5390A48990F9;
        Mon, 23 Nov 2020 08:41:41 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 23 Nov 2020 08:41:42 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 23 Nov 2020 08:41:41 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v2 2/6] blk: introduce ->block_lost() to handle memory-failure
Date:   Mon, 23 Nov 2020 08:41:12 +0800
Message-ID: <20201123004116.2453-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5390A48990F9.A8C41
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fsdax mode, the memory failure happens on block device.  So, it is
needed to introduce an interface for block devices.  Each kind of block
device can handle the memory failure in ther own ways.

Usually, a block device is used directly to mkfs on it.  The filesystem
on it is easily to obtain by 'get_super()'.  The block device can also
be divided into several partitions, or used as a target by mapped
device.  It is hard to get filesystem's superblock in this two ways.
So, add 'bdget_disk_sector()' to get the block device of a partition
where the broken sector located in.  And add
'bd_disk_holder_block_lost()' iterate the mapped devices on it.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 block/genhd.c          | 12 ++++++++++++
 drivers/nvdimm/pmem.c  | 27 +++++++++++++++++++++++++++
 fs/block_dev.c         | 23 +++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 include/linux/genhd.h  |  9 +++++++++
 5 files changed, 73 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..2c7304f123fa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1055,6 +1055,18 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 }
 EXPORT_SYMBOL(bdget_disk);
 
+struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
+{
+	struct block_device *bdev = NULL;
+	struct hd_struct *part = disk_map_sector_rcu(disk, sector);
+
+	if (part)
+		bdev = bdget_part(part);
+
+	return bdev;
+}
+EXPORT_SYMBOL(bdget_disk_sector);
+
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..d75a3f370f3c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -253,6 +253,32 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	return blk_status_to_errno(rc);
 }
 
+int pmem_block_lost(struct gendisk *disk, struct block_device *bdev,
+		    loff_t disk_offset, void *data)
+{
+	struct super_block *sb;
+	sector_t bdev_sector, disk_sector = disk_offset >> SECTOR_SHIFT;
+	int rc = 0;
+
+	bdev = bdget_disk_sector(disk, disk_sector);
+	if (!bdev)
+		return -ENODEV;
+
+	bdev_sector = disk_sector - get_start_sect(bdev);
+	sb = get_super(bdev);
+	if (!sb) {
+		rc = bd_disk_holder_block_lost(bdev, bdev_sector, data);
+		goto out;
+	} else if (sb->s_op->storage_lost)
+		rc = sb->s_op->storage_lost(sb, bdev,
+					    bdev_sector << SECTOR_SHIFT, data);
+	drop_super(sb);
+
+out:
+	bdput(bdev);
+	return rc;
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
@@ -281,6 +307,7 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.block_lost =		pmem_block_lost,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..e1e30828fb9f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1171,6 +1171,29 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+int bd_disk_holder_block_lost(struct block_device *bdev, sector_t offset,
+			      void *data)
+{
+	struct bd_holder_disk *holder;
+	struct gendisk *disk;
+	int rc = 0;
+
+	if (list_empty(&(bdev->bd_holder_disks)))
+		return -ENODEV;
+
+	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
+		disk = holder->disk;
+		if (disk->fops->block_lost) {
+			rc = disk->fops->block_lost(disk, bdev,
+					       offset << SECTOR_SHIFT, data);
+			if (rc != -ENODEV)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(bd_disk_holder_block_lost);
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b..ddeb268cc938 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1855,6 +1855,8 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	int (*block_lost)(struct gendisk *disk, struct block_device *bdev,
+			  loff_t offset, void *data);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 };
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 38f23d757013..9d8f5b5dab9f 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -303,6 +303,8 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
+extern struct block_device *bdget_disk_sector(struct gendisk *disk,
+					      sector_t sector);
 
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
@@ -381,9 +383,16 @@ int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
 long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 
 #ifdef CONFIG_SYSFS
+int bd_disk_holder_block_lost(struct block_device *bdev, sector_t offset,
+			      void *data);
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
 #else
+static inline int bd_disk_holder_block_lost(struct block_device *bdev,
+					    sector_t offset, void *data)
+{
+	return 0;
+}
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
 {
-- 
2.29.2



