Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700CE2E7B63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgL3RAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 12:00:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50482 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgL3RAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:00:51 -0500
X-IronPort-AV: E=Sophos;i="5.78,461,1599494400"; 
   d="scan'208";a="103085836"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Dec 2020 00:58:45 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 2EE7E4CE6024;
        Thu, 31 Dec 2020 00:58:42 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 31 Dec 2020 00:58:41 +0800
Received: from irides.mr (10.167.225.141) by G08CNEXCHPEKD04.g08.fujitsu.local
 (10.167.33.209) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Dec 2020 00:58:41 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [PATCH 08/10] md: Implement ->corrupted_range()
Date:   Thu, 31 Dec 2020 00:55:59 +0800
Message-ID: <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2EE7E4CE6024.AC3E1
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
 drivers/md/dm.c       | 54 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c | 11 +++------
 fs/block_dev.c        | 37 +++++++++++++++++++++++++++++
 include/linux/genhd.h |  2 ++
 4 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4e0cbfe3f14d..f9955be7afeb 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -507,6 +507,59 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
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
+	int srcu_idx, i, rc = -ENODEV;
+	bool found = false;
+	sector_t disk_sect, target_sect = to_sector(target_offset);
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map)
+		return rc;
+
+	for (i = 0; i < dm_table_get_num_targets(map); i++) {
+		ti = dm_table_get_target(map, i);
+		if (ti->type->iterate_devices && ti->type->rmap) {
+			struct dm_blk_corrupt bc = {target_bdev, target_sect};
+
+			found = ti->type->iterate_devices(ti, dm_blk_corrupt_fn, &bc);
+			if (!found)
+				continue;
+			disk_sect = ti->type->rmap(ti, target_sect);
+			break;
+		}
+	}
+
+	if (found) {
+		loff_t disk_off = to_bytes(disk_sect);
+		loff_t bdev_off = to_bytes(disk_sect - get_start_sect(md_bdev));
+		rc = bd_corrupted_range(md_bdev, disk_off, bdev_off, len, data);
+	}
+
+	dm_put_live_table(md, srcu_idx);
+	return rc;
+}
+
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
@@ -3084,6 +3137,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.getgeo = dm_blk_getgeo,
 	.report_zones = dm_blk_report_zones,
 	.pr_ops = &dm_pr_ops,
+	.corrupted_range = dm_blk_corrupted_range,
 	.owner = THIS_MODULE
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 4688bff19c20..9f9a2f3bf73b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -256,21 +256,16 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
 				loff_t disk_offset, size_t len, void *data)
 {
-	struct super_block *sb;
 	loff_t bdev_offset;
 	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
-	int rc = 0;
+	int rc = -ENODEV;
 
 	bdev = bdget_disk_sector(disk, disk_sector);
 	if (!bdev)
-		return -ENODEV;
+		return rc;
 
 	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
-	sb = get_super(bdev);
-	if (sb && sb->s_op->corrupted_range) {
-		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
-		drop_super(sb);
-	}
+	rc = bd_corrupted_range(bdev, bdev_offset, bdev_offset, len, data);
 
 	bdput(bdev);
 	return rc;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..0e50f0e8e8af 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1171,6 +1171,27 @@ struct bd_holder_disk {
 	int			refcnt;
 };
 
+static int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
+					  size_t len, void *data)
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
+
 static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
 						  struct gendisk *disk)
 {
@@ -1378,6 +1399,22 @@ void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 }
 EXPORT_SYMBOL(bd_set_nr_sectors);
 
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off, loff_t bdev_off, size_t len, void *data)
+{
+	struct super_block *sb = get_super(bdev);
+	int rc = 0;
+
+	if (!sb) {
+		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
+		return rc;
+	} else if (sb->s_op->corrupted_range)
+		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
+	drop_super(sb);
+
+	return rc;
+}
+EXPORT_SYMBOL(bd_corrupted_range);
+
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 int bdev_disk_changed(struct block_device *bdev, bool invalidate)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index ed06209008b8..42290470810d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -376,6 +376,8 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose);
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
+		       loff_t bdev_off, size_t len, void *data);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.29.2



