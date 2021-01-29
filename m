Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023DD3085CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jan 2021 07:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhA2G3x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 01:29:53 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32276 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232191AbhA2G3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:29:41 -0500
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="103973624"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jan 2021 14:28:11 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 78B854CE6019;
        Fri, 29 Jan 2021 14:28:08 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 29 Jan 2021 14:28:08 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 29 Jan 2021 14:28:08 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>, <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH RESEND v2 05/10] mm, pmem: Implement ->memory_failure() in pmem driver
Date:   Fri, 29 Jan 2021 14:27:52 +0800
Message-ID: <20210129062757.1594130-6-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
References: <20210129062757.1594130-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 78B854CE6019.ACD5C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the ->memory_failure() which is implemented by pmem driver, in
order to finally notify filesystem to handle the corrupted data.  The
handler which collects and kills processes are moved into
mf_dax_mapping_kill_procs(), which will be called by filesystem.

Keep the old handler in order to roll back if driver/device/filesystem
does not support ->memory_failure()/->corrupted_range().

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 drivers/nvdimm/pmem.c |  25 +++++++++++
 mm/memory-failure.c   | 102 +++++++++++++++++++++++++-----------------
 2 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 875076b0ea6c..c9e4fb38f94a 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -363,9 +363,34 @@ static void pmem_release_disk(void *__pmem)
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
+	} else
+		rc = -EOPNOTSUPP;
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
index 158fe0c8e602..670e29cd263e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1219,6 +1219,54 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+int mf_generic_kill_procs(unsigned long long pfn, int flags)
+{
+	struct page *page = pfn_to_page(pfn);
+	const bool unmap_success = true;
+	unsigned long size = 0;
+	struct to_kill *tk;
+	LIST_HEAD(to_kill);
+	loff_t start;
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
+	list_for_each_entry(tk, &to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up
+		 * device-dax mappings which are constant size. The
+		 * actual size of the mapping being torn down is
+		 * communicated in siginfo, see kill_proc()
+		 */
+		start = (page->index << PAGE_SHIFT) & ~(size - 1);
+		unmap_mapping_range(page->mapping, start, start + size, 0);
+	}
+	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
+
+	dax_unlock_page(page, cookie);
+	return 0;
+}
+
 int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)
 {
 	const bool unmap_success = true;
@@ -1343,13 +1391,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
-	LIST_HEAD(to_kill);
 	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1357,20 +1399,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 */
 		put_page(page);
 
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
@@ -1378,7 +1409,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * TODO: Handle HMM pages which may need coordination
 		 * with device-side memory.
 		 */
-		goto unlock;
+		goto out;
 	}
 
 	/*
@@ -1388,32 +1419,21 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
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
-
-	list_for_each_entry(tk, &to_kill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
 		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
+		 * Roll back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
 		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, start + size, 0);
+		if (rc != EOPNOTSUPP)
+			goto out;
 	}
-	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+
+	rc = mf_generic_kill_procs(pfn, flags);
+
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.30.0



