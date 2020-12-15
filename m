Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4152DACDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgLOMQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:16:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22826 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728909AbgLOMQX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:16:23 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420201"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:15:00 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A79BC4CE1505;
        Tue, 15 Dec 2020 20:14:59 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:58 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:58 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 8/9] md: Implement ->corrupted_range()
Date:   Tue, 15 Dec 2020 20:14:13 +0800
Message-ID: <20201215121414.253660-9-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A79BC4CE1505.AD69D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With the support of ->rmap(), it is possible to obtain the superblock on
a mapped device.

If a pmem device is used as one target of mapped device, we cannot
obtain its superblock directly.  With the help of SYSFS, the mapped
device can be found on the target devices.  So, we iterate the
bdev->bd_holder_disks to obtain its mapped device.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/md/dm.c       | 66 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c |  9 ++++--
 fs/block_dev.c        | 21 ++++++++++++++
 include/linux/genhd.h |  7 +++++
 4 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4e0cbfe3f14d..9da1f9322735 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -507,6 +507,71 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 #define dm_blk_report_zones		NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+struct dm_blk_corrupt {
+	struct block_device *bdev;
+	sector_t offset;
+};
+
+static int dm_blk_corrupt_fn(struct dm_target *ti, struct dm_dev *dev,
+				sector_t start, sector_t len, void *data)
+{
+	struct dm_blk_corrupt *bc = data;
+
+	return bc->bdev == (void *)dev->bdev &&
+			(start <= bc->offset && bc->offset < start + len);
+}
+
+static int dm_blk_corrupted_range(struct gendisk *disk,
+				  struct block_device *target_bdev,
+				  loff_t target_offset, size_t len, void *data)
+{
+	struct mapped_device *md = disk->private_data;
+	struct block_device *md_bdev = md->bdev;
+	struct dm_table *map;
+	struct dm_target *ti;
+	struct super_block *sb;
+	int srcu_idx, i, rc = 0;
+	bool found = false;
+	sector_t disk_sec, target_sec = to_sector(target_offset);
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map)
+		return -ENODEV;
+
+	for (i = 0; i < dm_table_get_num_targets(map); i++) {
+		ti = dm_table_get_target(map, i);
+		if (ti->type->iterate_devices && ti->type->rmap) {
+			struct dm_blk_corrupt bc = {target_bdev, target_sec};
+
+			found = ti->type->iterate_devices(ti, dm_blk_corrupt_fn, &bc);
+			if (!found)
+				continue;
+			disk_sec = ti->type->rmap(ti, target_sec);
+			break;
+		}
+	}
+
+	if (!found) {
+		rc = -ENODEV;
+		goto out;
+	}
+
+	sb = get_super(md_bdev);
+	if (!sb) {
+		rc = bd_disk_holder_corrupted_range(md_bdev, to_bytes(disk_sec), len, data);
+		goto out;
+	} else if (sb->s_op->corrupted_range) {
+		loff_t off = to_bytes(disk_sec - get_start_sect(md_bdev));
+
+		rc = sb->s_op->corrupted_range(sb, md_bdev, off, len, data);
+	}
+	drop_super(sb);
+
+out:
+	dm_put_live_table(md, srcu_idx);
+	return rc;
+}
+
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
@@ -3084,6 +3149,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.getgeo = dm_blk_getgeo,
 	.report_zones = dm_blk_report_zones,
 	.pr_ops = &dm_pr_ops,
+	.corrupted_range = dm_blk_corrupted_range,
 	.owner = THIS_MODULE
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4688bff19c20..e8cfaf860149 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -267,11 +267,14 @@ static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
 
 	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
 	sb = get_super(bdev);
-	if (sb && sb->s_op->corrupted_range) {
+	if (!sb) {
+		rc = bd_disk_holder_corrupted_range(bdev, bdev_offset, len, data);
+		goto out;
+	} else if (sb->s_op->corrupted_range)
 		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
-		drop_super(sb);
-	}
+	drop_super(sb);
 
+out:
 	bdput(bdev);
 	return rc;
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..d3e6bddb8041 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1171,6 +1171,27 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off, size_t len, void *data)
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
+		if (disk->fops->corrupted_range) {
+			rc = disk->fops->corrupted_range(disk, bdev, off, len, data);
+			if (rc != -ENODEV)
+				break;
+		}
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(bd_disk_holder_corrupted_range);
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ed06209008b8..fba247b852fa 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -382,9 +382,16 @@ int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
 long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 
 #ifdef CONFIG_SYSFS
+int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
+				   size_t len, void *data);
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
 #else
+int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
+				   size_t len, void *data)
+{
+	return 0;
+}
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
 {
-- 
2.29.2



