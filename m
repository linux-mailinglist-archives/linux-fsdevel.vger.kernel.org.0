Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4CE440F06
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhJaPXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:23:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24365 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230080AbhJaPXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:23:36 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AgwcrcKhCyqfxEd9cQW2kvjhYX161HxEKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUBzzEXUWHXbK2PNmaje9h2Otm09E5Su5+BxoVmTQo+r3w8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlULW?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm75LMkByWKRMAxN0rVinaJ7Yw9u9pAG1?=
 =?us-ascii?q?m++YfLTcXZBGfwemxxdqTSuJsrsUlItPiMI4Wtjdn1z6xJfovR9bBBbrL4dtZ1?=
 =?us-ascii?q?TIrrsFIAfvaIcEebFJHYBbfZBtAElQaEpQzmKGvnHaXWzlZrk+F4K8yy2vNxQd?=
 =?us-ascii?q?ylr/3P7L9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8nmsruvUgWX3Veo6FrS++?=
 =?us-ascii?q?7hhgEC7wXYaAxkbE1C8pJGRjk+4RsIaJVcY9zQjqYAs+0GxCNrwRRu1pDiDpBF?=
 =?us-ascii?q?0c95RFfAqrQKA0KzZ5y6HCWUeCD1MctorsIkxXzNC/luImc75QCxhq5WLRn+Hs?=
 =?us-ascii?q?LSZtzW/PW4SN2BqWMOuZWPp+PG6+Mdq0E2JFY0lTcaIYhTOMWmY61i3QOIW2t3?=
 =?us-ascii?q?/VfI26pg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A03MvpK7tK0qt6MM1RwPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116677982"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:20:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 008734D0F910;
        Sun, 31 Oct 2021 23:20:55 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:20:56 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:52 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 4/8] pagemap,pmem: Introduce ->memory_failure()
Date:   Sun, 31 Oct 2021 23:20:24 +0800
Message-ID: <20211031152028.3724121-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 008734D0F910.A42BD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When memory-failure occurs, we call this function which is implemented
by each kind of devices.  For the fsdax case, pmem device driver
implements it.  Pmem device driver will find out the filesystem in which
the corrupted page located in.

With dax_holder notify support, we are able to notify the memory failure
from pmem driver to upper layers.  If there is something not support in
the notify routine, memory_failure will fall back to the generic hanlder.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvdimm/pmem.c    | 11 +++++++++++
 include/linux/memremap.h |  9 +++++++++
 mm/memory-failure.c      | 14 ++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index ef4950f80832..55ca7233f0a9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -362,9 +362,20 @@ static void pmem_release_disk(void *__pmem)
 	del_gendisk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, u64 len, int mf_flags)
+{
+	struct pmem_device *pmem =
+			container_of(pgmap, struct pmem_device, pgmap);
+	loff_t offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
+
+	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c0e9d35889e8..820c2f33b163 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -87,6 +87,15 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Handle the memory failure happens on a range of pfns.  Notify the
+	 * processes who are using these pfns, and try to recover the data on
+	 * them if necessary.  The mf_flags is finally passed to the recover
+	 * function through the whole notify routine.
+	 */
+	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
+			      u64 len, int mf_flags);
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 07b452585938..8bf6f54b5705 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1606,6 +1606,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	if (!pgmap_pfn_valid(pgmap, pfn))
 		goto out;
 
+	/*
+	 * Call driver's implementation to handle the memory failure, otherwise
+	 * fall back to generic handler.
+	 */
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, PAGE_SIZE, flags);
+		/*
+		 * Fall back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
+		 */
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	}
+
 	rc = mf_generic_kill_procs(pfn, flags, pgmap);
 out:
 	/* drop pgmap ref acquired in caller */
-- 
2.33.0



