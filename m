Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B05FF754
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJNX6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiJNX6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245EDE070C
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791908; x=1697327908;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C/qZLnXcKAFdw6v16/JSbSW5MEboRqnBqKQbL8OhQjQ=;
  b=Pcok9azHciWzoDwk5sKElNCiUZYxFoHLS58m6ztL6WJuX3tRiDQU6V7W
   BZIEl9z/kmYzMBN2XyAEkD2kTRN5LJpM1y4gtkiuZ+/nQFdPfRaw2za/Y
   5nCC4FJRaeNWm82p3f2TX1JrYWUWoskZqRZXOOhW0ld0Im/wwVTWtfq2c
   Fyqy77W/clyE8/ZPfLJ2UBmEIfzAsSSnEWG1PRWTCEzT5n8a1kNoaX3Xh
   ZWNqjMdwCHYhTK7fz54NiYEiYTKcMBkW0EZ+XCGoKbzVI01PlXmaoK/h8
   WrvZl/kACqG7BfBJcofNzrdII0RColqb4GoeARDSWmuLRfDYh5Zs4z2zN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="305485762"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="305485762"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113510"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113510"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:26 -0700
Subject: [PATCH v3 15/25] libnvdimm/pmem: Support pmem block devices without
 dax
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     david@fromorbit.com, hch@lst.de, nvdimm@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:58:26 -0700
Message-ID: <166579190607.2236710.1230996282258115812.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for CONFIG_DAX growing a CONFIG_MMU dependency add
support for pmem to skip dax-device registration in the CONFIG_DAX=n
case.

alloc_dax() returns NULL in the CONFIG_DAX=n case, ERR_PTR() in the
failure case, and a dax-device in the success case.

dax_remove_host(), kill_dax() and put_dax() are safe to call if
setup_dax() returns 0 because it suceeded, or 0 because CONFIG_DAX=n.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/Kconfig |    2 +-
 drivers/nvdimm/pmem.c  |   47 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 5a29046e3319..027acca1bac4 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -19,7 +19,7 @@ if LIBNVDIMM
 config BLK_DEV_PMEM
 	tristate "PMEM: Persistent memory block device support"
 	default LIBNVDIMM
-	select DAX
+	select DAX if MMU
 	select ND_BTT if BTT
 	select ND_PFN if NVDIMM_PFN
 	help
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7e88cd242380..068183ee9bf6 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -468,6 +468,32 @@ static const struct dev_pagemap_ops fsdax_pagemap_ops = {
 	.memory_failure		= pmem_pagemap_memory_failure,
 };
 
+static int setup_dax(struct pmem_device *pmem, struct gendisk *disk,
+		     struct nd_region *nd_region)
+{
+	struct dax_device *dax_dev;
+	int rc;
+
+	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
+	if (IS_ERR(dax_dev))
+		return PTR_ERR(dax_dev);
+	if (!dax_dev)
+		return 0;
+	set_dax_nocache(dax_dev);
+	set_dax_nomc(dax_dev);
+	if (is_nvdimm_sync(nd_region))
+		set_dax_synchronous(dax_dev);
+	rc = dax_add_host(dax_dev, disk);
+	if (rc) {
+		kill_dax(dax_dev);
+		put_dax(dax_dev);
+		return rc;
+	}
+	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
+	pmem->dax_dev = dax_dev;
+	return 0;
+}
+
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
 {
@@ -477,7 +503,6 @@ static int pmem_attach_disk(struct device *dev,
 	struct resource *res = &nsio->res;
 	struct range bb_range;
 	struct nd_pfn *nd_pfn = NULL;
-	struct dax_device *dax_dev;
 	struct nd_pfn_sb *pfn_sb;
 	struct pmem_device *pmem;
 	struct request_queue *q;
@@ -578,24 +603,13 @@ static int pmem_attach_disk(struct device *dev,
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_range);
 	disk->bb = &pmem->bb;
 
-	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
-	if (IS_ERR(dax_dev)) {
-		rc = PTR_ERR(dax_dev);
-		goto out;
-	}
-	set_dax_nocache(dax_dev);
-	set_dax_nomc(dax_dev);
-	if (is_nvdimm_sync(nd_region))
-		set_dax_synchronous(dax_dev);
-	rc = dax_add_host(dax_dev, disk);
+	rc = setup_dax(pmem, disk, nd_region);
 	if (rc)
-		goto out_cleanup_dax;
-	dax_write_cache(dax_dev, nvdimm_has_cache(nd_region));
-	pmem->dax_dev = dax_dev;
+		goto out;
 
 	rc = device_add_disk(dev, disk, pmem_attribute_groups);
 	if (rc)
-		goto out_remove_host;
+		goto out_dax;
 	if (devm_add_action_or_reset(dev, pmem_release_disk, pmem))
 		return -ENOMEM;
 
@@ -607,9 +621,8 @@ static int pmem_attach_disk(struct device *dev,
 		dev_warn(dev, "'badblocks' notification disabled\n");
 	return 0;
 
-out_remove_host:
+out_dax:
 	dax_remove_host(pmem->disk);
-out_cleanup_dax:
 	kill_dax(pmem->dax_dev);
 	put_dax(pmem->dax_dev);
 out:

