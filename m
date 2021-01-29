Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876913085DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbhA2Gax (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:30:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:4875 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232220AbhA2GaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:30:16 -0500
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="103973639"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jan 2021 14:28:18 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A9D694CE6019;
        Fri, 29 Jan 2021 14:28:12 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 29 Jan 2021 14:28:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 14:28:12 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH RESEND v2 08/10] md: Implement ->corrupted_range()
Date:   Fri, 29 Jan 2021 14:27:55 +0800
Message-ID: <20210129062757.1594130-9-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
References: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A9D694CE6019.ADD8D
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
 drivers/md/dm.c       | 61 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvdimm/pmem.c | 11 +++-----
 fs/block_dev.c        | 42 ++++++++++++++++++++++++++++-
 include/linux/genhd.h |  2 ++
 4 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7bac564f3faa..31b0c340b695 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -507,6 +507,66 @@ static int dm_blk_report_zones(struct gendisk *disk, sector_t sector,
 #define dm_blk_report_zones		NULL
 #endif /* CONFIG_BLK_DEV_ZONED */
 
+struct corrupted_hit_info {
+	struct block_device *bdev;
+	sector_t offset;
+};
+
+static int dm_blk_corrupted_hit(struct dm_target *ti, struct dm_dev *dev,
+				sector_t start, sector_t count, void *data)
+{
+	struct corrupted_hit_info *bc = data;
+
+	return bc->bdev == (void *)dev->bdev &&
+			(start <= bc->offset && bc->offset < start + count);
+}
+
+struct corrupted_do_info {
+	size_t length;
+	void *data;
+};
+
+static int dm_blk_corrupted_do(struct dm_target *ti, struct block_device *bdev,
+			       sector_t disk_sect, void *data)
+{
+	struct corrupted_do_info *bc = data;
+	loff_t disk_off = to_bytes(disk_sect);
+	loff_t bdev_off = to_bytes(disk_sect - get_start_sect(bdev));
+
+	return bd_corrupted_range(bdev, disk_off, bdev_off, bc->length, bc->data);
+}
+
+static int dm_blk_corrupted_range(struct gendisk *disk,
+				  struct block_device *target_bdev,
+				  loff_t target_offset, size_t len, void *data)
+{
+	struct mapped_device *md = disk->private_data;
+	struct dm_table *map;
+	struct dm_target *ti;
+	sector_t target_sect = to_sector(target_offset);
+	struct corrupted_hit_info hi = {target_bdev, target_sect};
+	struct corrupted_do_info di = {len, data};
+	int srcu_idx, i, rc = -ENODEV;
+
+	map = dm_get_live_table(md, &srcu_idx);
+	if (!map)
+		return rc;
+
+	for (i = 0; i < dm_table_get_num_targets(map); i++) {
+		ti = dm_table_get_target(map, i);
+		if (!(ti->type->iterate_devices && ti->type->rmap))
+			continue;
+		if (!ti->type->iterate_devices(ti, dm_blk_corrupted_hit, &hi))
+			continue;
+
+		rc = ti->type->rmap(ti, target_sect, dm_blk_corrupted_do, &di);
+		break;
+	}
+
+	dm_put_live_table(md, srcu_idx);
+	return rc;
+}
+
 static int dm_prepare_ioctl(struct mapped_device *md, int *srcu_idx,
 			    struct block_device **bdev)
 {
@@ -3062,6 +3122,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.getgeo = dm_blk_getgeo,
 	.report_zones = dm_blk_report_zones,
 	.pr_ops = &dm_pr_ops,
+	.corrupted_range = dm_blk_corrupted_range,
 	.owner = THIS_MODULE
 };
 
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 501959947d48..3d9f4ccbbd9e 100644
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
index 3b8963e228a1..3cc2b2911e3a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1079,6 +1079,27 @@ struct bd_holder_disk {
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
@@ -1212,7 +1233,26 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
 	mutex_unlock(&bdev->bd_mutex);
 }
 EXPORT_SYMBOL_GPL(bd_unlink_disk_holder);
-#endif
+#endif /* CONFIG_SYSFS */
+
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
+		       loff_t bdev_off, size_t len, void *data)
+{
+	struct super_block *sb = get_super(bdev);
+	int rc = -EOPNOTSUPP;
+
+	if (!sb) {
+#ifdef CONFIG_SYSFS
+		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
+#endif /* CONFIG_SYSFS */
+		return rc;
+	} else if (sb->s_op->corrupted_range)
+		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
+	drop_super(sb);
+
+	return rc;
+}
+EXPORT_SYMBOL(bd_corrupted_range);
 
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4da480798955..996f91b08d48 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,6 +315,8 @@ void unregister_blkdev(unsigned int major, const char *name);
 bool bdev_check_media_change(struct block_device *bdev);
 int __invalidate_device(struct block_device *bdev, bool kill_dirty);
 void set_capacity(struct gendisk *disk, sector_t size);
+int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
+		       loff_t bdev_off, size_t len, void *data);
 
 /* for drivers/char/raw.c: */
 int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
-- 
2.30.0



