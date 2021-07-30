Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099F93DB564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhG3IxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:53:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34380 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238215AbhG3IxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:53:18 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ah8OWZK51DeltvZEXvwPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620662400"; 
   d="scan'208";a="112070611"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2021 16:53:12 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 122854D0D4B9;
        Fri, 30 Jul 2021 16:53:09 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 30 Jul 2021 16:53:02 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 30 Jul 2021 16:53:02 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <djwong@kernel.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>
Subject: [PATCH v6 4/9] pmem,mm: Implement ->memory_failure in pmem driver
Date:   Fri, 30 Jul 2021 16:52:40 +0800
Message-ID: <20210730085245.3069812-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
References: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 122854D0D4B9.A4972
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With dax_holder notify support, we are able to notify the memory failure
from pmem driver to upper layers.  If there is something not support in
the notify routine, memory_failure will fall back to the generic hanlder.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/nvdimm/pmem.c | 13 +++++++++++++
 mm/memory-failure.c   | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1e0615b8565e..fea4ffc333b8 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -362,9 +362,22 @@ static void pmem_release_disk(void *__pmem)
 	del_gendisk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, unsigned long nr_pfns, int flags)
+{
+	struct pmem_device *pmem =
+			container_of(pgmap, struct pmem_device, pgmap);
+	loff_t offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
+
+	return dax_holder_notify_failure(pmem->dax_dev, offset,
+					 page_size(pfn_to_page(pfn)) * nr_pfns,
+					 &flags);
+}
+
 static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.kill			= pmem_pagemap_kill,
 	.cleanup		= pmem_pagemap_cleanup,
+	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
 static int pmem_attach_disk(struct device *dev,
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3bdfcb45f66e..ab3eda335acd 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1600,6 +1600,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 */
 	SetPageHWPoison(page);
 
+	/*
+	 * Call driver's implementation to handle the memory failure, otherwise
+	 * fall back to generic handler.
+	 */
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
+		/*
+		 * Fall back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
+		 */
+		if (rc != EOPNOTSUPP)
+			goto out;
+	}
+
 	mf_generic_kill_procs(pfn, flags);
 out:
 	/* drop pgmap ref acquired in caller */
-- 
2.32.0



