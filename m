Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D626A2F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgIOKN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 06:13:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32367 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgIOKNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:13:23 -0400
X-IronPort-AV: E=Sophos;i="5.76,429,1592841600"; 
   d="scan'208";a="99252002"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Sep 2020 18:13:18 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 60C5548990ED;
        Tue, 15 Sep 2020 18:13:17 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Sep 2020 18:13:15 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Sep 2020 18:13:15 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <darrick.wong@oracle.com>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 2/4] pagemap: introduce ->memory_failure()
Date:   Tue, 15 Sep 2020 18:13:09 +0800
Message-ID: <20200915101311.144269-3-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
References: <20200915101311.144269-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 60C5548990ED.AC46D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When memory-failure occurs, we call this function which is implemented
by each devices.  For fsdax, pmem device implements it.  Pmem device
will find out the block device where the error page located in, gets the
filesystem on this block device, and finally call ->storage_lost() to
handle the error in filesystem layer.

Normally, a pmem device may contain one or more partitions, each
partition contains a block device, each block device contains a
filesystem.  So we are able to find out the filesystem by one offset on
this pmem device.  However, in other cases, such as mapped device, I
didn't find a way to obtain the filesystem laying on it.  It is a
problem need to be fixed.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 block/genhd.c            | 12 ++++++++++++
 drivers/nvdimm/pmem.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/genhd.h    |  2 ++
 include/linux/memremap.h |  3 +++
 4 files changed, 48 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..e7442b60683e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1063,6 +1063,18 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 }
 EXPORT_SYMBOL(bdget_disk);
 
+struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
+{
+	struct block_device *bdev = NULL;
+	struct hd_struct *part = disk_map_sector_rcu(disk, sector);
+
+	if (part)
+		bdev = bdget(part_devt(part));
+
+	return bdev;
+}
+EXPORT_SYMBOL(bdget_disk_sector);
+
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index fab29b514372..3ed96486c883 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -364,9 +364,40 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		struct mf_recover_controller *mfrc)
+{
+	struct pmem_device *pdev;
+	struct block_device *bdev;
+	sector_t disk_sector;
+	loff_t bdev_offset;
+
+	pdev = container_of(pgmap, struct pmem_device, pgmap);
+	if (!pdev->disk)
+		return -ENXIO;
+
+	disk_sector = (PFN_PHYS(mfrc->pfn) - pdev->phys_addr) >> SECTOR_SHIFT;
+	bdev = bdget_disk_sector(pdev->disk, disk_sector);
+	if (!bdev)
+		return -ENXIO;
+
+	// TODO what if block device contains a mapped device
+	if (!bdev->bd_super)
+		goto out;
+
+	bdev_offset = ((disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT) -
+			pdev->data_offset;
+	bdev->bd_super->s_op->storage_lost(bdev->bd_super, bdev_offset, mfrc);
+
+out:
+	bdput(bdev);
+	return 0;
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff..16e9e13e0841 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -303,6 +303,8 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
+extern struct block_device *bdget_disk_sector(struct gendisk *disk,
+			sector_t sector);
 
 extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 5f5b2df06e61..efebefa70d00 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -6,6 +6,7 @@
 
 struct resource;
 struct device;
+struct mf_recover_controller;
 
 /**
  * struct vmem_altmap - pre-allocated storage for vmemmap_populate
@@ -87,6 +88,8 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+	int (*memory_failure)(struct dev_pagemap *pgmap,
+			      struct mf_recover_controller *mfrc);
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
-- 
2.28.0



