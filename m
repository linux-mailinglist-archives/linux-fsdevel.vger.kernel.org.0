Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0446C39AF84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFDBU7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:20:59 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12817 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230046AbhFDBUz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:20:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AciOndaGMdrd53wsKpLqEjceALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKKSC9Hfb0qynDpp4mPHzP6Qr5OktOpTnoAsDpKk80naQFgrX5Vo3PYOCJgg?=
 =?us-ascii?q?WVEL0=3D?=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="109209802"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2021 09:19:06 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D3F604C36A00;
        Fri,  4 Jun 2021 09:19:01 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:19:02 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:18:55 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Jun 2021 09:18:54 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>
Subject: [PATCH v4 05/10] mm, pmem: Implement ->memory_failure() in pmem driver
Date:   Fri, 4 Jun 2021 09:18:39 +0800
Message-ID: <20210604011844.1756145-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D3F604C36A00.A0E01
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the ->memory_failure() which is implemented by pmem driver, in
order to finally notify filesystem to handle the corrupted data.  The
handler which collects and kills processes are moved into
mf_dax_kill_procs(), which will be called by filesystem.

Keep the old handler in order to roll back if driver or filesystem
does not support ->memory_failure()/->corrupted_range().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 block/genhd.c         | 30 ++++++++++++++++++
 drivers/nvdimm/pmem.c | 14 +++++++++
 include/linux/genhd.h |  1 +
 mm/memory-failure.c   | 71 +++++++++++++++++++++++++++----------------
 4 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..75834bd057df 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -718,6 +718,36 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 	return bdev;
 }
 
+/**
+ * bdget_disk_sector - get block device by given sector number
+ * @disk: gendisk of interest
+ * @sector: sector number
+ *
+ * RETURNS: the found block device where sector locates in
+ */
+struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector)
+{
+	struct block_device *part = NULL, *p;
+	unsigned long idx;
+
+	rcu_read_lock();
+	xa_for_each(&disk->part_tbl, idx, p) {
+		if (p->bd_partno == 0)
+			continue;
+		if (p->bd_start_sect <= sector &&
+			sector < p->bd_start_sect + bdev_nr_sectors(p)) {
+			part = p;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	if (!part)
+		part = disk->part0;
+
+	return bdget_disk(disk, part->bd_partno);
+}
+EXPORT_SYMBOL(bdget_disk_sector);
+
 /*
  * print a full list of all partitions - intended for places where the root
  * filesystem can't be mounted and thus to give the victim some idea of what
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ed10a8b66068..98349e7d0a28 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -364,9 +364,23 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, int flags)
+{
+	struct pmem_device *pdev =
+			container_of(pgmap, struct pmem_device, pgmap);
+	loff_t offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
+	struct block_device *bdev =
+			bdget_disk_sector(pdev->disk, offset >> SECTOR_SHIFT);
+
+	return dax_corrupted_range(pdev->dax_dev, bdev, offset,
+				   page_size(pfn_to_page(pfn)), &flags);
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 6fc26f7bdf71..2ad70c02c343 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -219,6 +219,7 @@ static inline void add_disk_no_queue_reg(struct gendisk *disk)
 
 extern void del_gendisk(struct gendisk *gp);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
+extern struct block_device *bdget_disk_sector(struct gendisk *disk, sector_t sector);
 
 void set_disk_ro(struct gendisk *disk, bool read_only);
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4377e727d478..43017d7f3918 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1247,6 +1247,36 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
 }
 
+static int mf_generic_kill_procs(unsigned long long pfn, int flags)
+{
+	struct page *page = pfn_to_page(pfn);
+	LIST_HEAD(to_kill);
+	dax_entry_t cookie;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	cookie = dax_lock_page(page);
+	if (!cookie)
+		return -EBUSY;
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs(page, &to_kill, flags & MF_ACTION_REQUIRED);
+
+	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
+	dax_unlock_page(page, cookie);
+	return 0;
+}
+
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
 {
 	LIST_HEAD(to_kill);
@@ -1348,9 +1378,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	LIST_HEAD(to_kill);
 	int rc = -EBUSY;
-	dax_entry_t cookie;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1364,20 +1392,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 	}
 
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
-		goto out;
-
 	if (hwpoison_filter(page)) {
 		rc = 0;
-		goto unlock;
+		goto out;
 	}
 
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
@@ -1385,7 +1402,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * TODO: Handle HMM pages which may need coordination
 		 * with device-side memory.
 		 */
-		goto unlock;
+		goto out;
 	}
 
 	/*
@@ -1395,19 +1412,21 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	SetPageHWPoison(page);
 
 	/*
-	 * Unlike System-RAM there is no possibility to swap in a
-	 * different physical page at a given virtual address, so all
-	 * userspace consumption of ZONE_DEVICE memory necessitates
-	 * SIGBUS (i.e. MF_MUST_KILL)
+	 * Call driver's implementation to handle the memory failure,
+	 * otherwise roll back to generic handler.
 	 */
-	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs_file(page, page->mapping, page->index, &to_kill,
-			   flags & MF_ACTION_REQUIRED);
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
+		/*
+		 * Roll back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
+		 */
+		if (rc != EOPNOTSUPP)
+			goto out;
+	}
+
+	rc = mf_generic_kill_procs(pfn, flags);
 
-	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.31.1



