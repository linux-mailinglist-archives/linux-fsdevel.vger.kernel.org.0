Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5331304A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 12:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhBHLL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 06:11:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:37633 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232774AbhBHLHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:07:01 -0500
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="104328073"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 18:55:47 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 2C8424CE6F81;
        Mon,  8 Feb 2021 18:55:41 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 8 Feb 2021 18:55:43 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 18:55:42 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH v3 07/11] pmem: Implement ->corrupted_range() for pmem driver
Date:   Mon, 8 Feb 2021 18:55:26 +0800
Message-ID: <20210208105530.3072869-8-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 2C8424CE6F81.ABF51
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Obtain the superblock of a pmem disk, and call filesystem's
->corrupted_range() to handle the corrupted data.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 block/genhd.c         |  6 ++++++
 drivers/nvdimm/pmem.c | 19 +++++++++++++++++++
 include/linux/genhd.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 419548e92d82..fd7cf03b65a8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -936,6 +936,12 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 	return bdev;
 }
 
+struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
+{
+	return disk_map_sector_rcu(disk, sector);
+}
+EXPORT_SYMBOL(bdget_disk_sector);
+
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index c77c80e3d155..e38b9f9c7d97 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -253,6 +253,24 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
 	return blk_status_to_errno(rc);
 }
 
+static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
+				loff_t disk_offset, size_t len, void *data)
+{
+	loff_t bdev_offset;
+	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
+	int rc = -ENODEV;
+
+	bdev = bdget_disk_sector(disk, disk_sector);
+	if (!bdev)
+		return rc;
+
+	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
+	rc = bd_corrupted_range(bdev, bdev_offset, bdev_offset, len, data);
+
+	bdput(bdev);
+	return rc;
+}
+
 /* see "strong" declaration in tools/testing/nvdimm/pmem-dax.c */
 __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
@@ -281,6 +299,7 @@ static const struct block_device_operations pmem_fops = {
 	.owner =		THIS_MODULE,
 	.submit_bio =		pmem_submit_bio,
 	.rw_page =		pmem_rw_page,
+	.corrupted_range =	pmem_corrupted_range,
 };
 
 static int pmem_dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 751cbd559bba..996f91b08d48 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -248,6 +248,7 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
+extern struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector);
 
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
-- 
2.30.0



