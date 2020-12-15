Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D32DACD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgLOMQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 07:16:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:22820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728692AbgLOMQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:16:01 -0500
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="102420204"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:15:00 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B6B804CE5CCA;
        Tue, 15 Dec 2020 20:14:56 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:56 +0800
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 15 Dec 2020 20:14:55 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 15 Dec 2020 20:14:54 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH v3 5/9] mm, pmem: Implement ->memory_failure() in pmem driver
Date:   Tue, 15 Dec 2020 20:14:10 +0800
Message-ID: <20201215121414.253660-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B6B804CE5CCA.AFD4B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the ->memory_failure() which is implemented by pmem driver, in
order to finally notify filesystem to handle the corrupted data.  The
old collecting and killing processes are moved into
mf_dax_mapping_kill_procs(), which will be called by filesystem.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/nvdimm/pmem.c | 24 +++++++++++++++++
 mm/memory-failure.c   | 62 +++++++------------------------------------
 2 files changed, 34 insertions(+), 52 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..4a114937c43b 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -363,9 +363,33 @@ static void pmem_release_disk(void *__pmem)
 	put_disk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, int flags)
+{
+	struct pmem_device *pdev;
+	struct gendisk *disk;
+	loff_t disk_offset;
+	int rc = 0;
+	unsigned long size = page_size(pfn_to_page(pfn));
+
+	pdev = container_of(pgmap, struct pmem_device, pgmap);
+	disk = pdev->disk;
+	if (!disk)
+		return -ENXIO;
+
+	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
+	if (disk->fops->corrupted_range) {
+		rc = disk->fops->corrupted_range(disk, NULL, disk_offset, size, &flags);
+		if (rc == -ENODEV)
+			rc = -ENXIO;
+	}
+	return rc;
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 03a4f4c1b803..10b39b14b4d7 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1278,38 +1278,19 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	struct address_space *mapping = page->mapping;
-	pgoff_t index = page->index;
-	const bool unmap_success = true;
-	unsigned long size = 0, dummy_pfn;
-	struct to_kill *tk;
-	LIST_HEAD(to_kill);
-	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
-
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock(mapping, index, &dummy_pfn);
-	if (!cookie)
-		goto out;
-
-	if (hwpoison_filter(page)) {
-		rc = 0;
-		goto unlock;
-	}
+	int rc;
 
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		/*
 		 * TODO: Handle HMM pages which may need coordination
 		 * with device-side memory.
 		 */
-		goto unlock;
+		goto out;
+	}
+
+	if (hwpoison_filter(page)) {
+		rc = 0;
+		goto out;
 	}
 
 	/*
@@ -1318,33 +1299,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 */
 	SetPageHWPoison(page);
 
-	/*
-	 * Unlike System-RAM there is no possibility to swap in a
-	 * different physical page at a given virtual address, so all
-	 * userspace consumption of ZONE_DEVICE memory necessitates
-	 * SIGBUS (i.e. MF_MUST_KILL)
-	 */
-	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs_file(page, mapping, index, &to_kill,
-			   flags & MF_ACTION_REQUIRED);
+	/* call driver to handle the memory failure */
+	if (pgmap->ops->memory_failure)
+		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
 
-	list_for_each_entry(tk, &to_kill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
-		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
-		 */
-		start = (index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(mapping, start, start + size, 0);
-	}
-	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock(mapping, index, cookie);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.29.2



