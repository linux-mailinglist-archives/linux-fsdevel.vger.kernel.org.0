Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445335BA56F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiIPDhh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiIPDgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:36:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0D9DB62;
        Thu, 15 Sep 2022 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299404; x=1694835404;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R5iLP9zAHTpb9OkjwMC0Bw2xXqlB6pFYCCoagiNt1Hw=;
  b=hK8BkB3sxn2JUZhAgf/GNrgpRzyFSwppBTX4Ggryi3x++DtQ2/wsR6ix
   kqOiWdCQSelMJeXDpua5As2IEdR8KqIlTkoMb7jb5ji4GNTKZKbnfvBU+
   FvjLZcXQAKywJzxrNErQe5QhfYkbUkrzD4wTx36R3qUgkwOROWdvPmdac
   g+e2dmVInEea/tb1hGVDra0vw3I7rX916/CfsDxuGQ66RZTq4m7ZUDFZC
   rgfciB4SlSWBcMWLA9Api4lkjC6YG9r+zGWCV9mFE5kxa52dN/kaudDNt
   DbqZHSh1SXUQqFFEsp82MXQzWBRpM9rkHC0OAmdv1Apx635QMQIh8PXoV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="298895594"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="298895594"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="679809589"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:43 -0700
Subject: [PATCH v2 16/18] mm/memremap_pages: Support initializing pages to a
 zero reference count
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org
Date:   Thu, 15 Sep 2022 20:36:43 -0700
Message-ID: <166329940343.2786261.6047770378829215962.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
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

The initial memremap_pages() implementation inherited the
__init_single_page() default of pages starting life with an elevated
reference count. This originally allowed for the page->pgmap pointer to
alias with the storage for page->lru since a page was only allowed to be
on an lru list when its reference count was zero.

Since then, 'struct page' definition cleanups have arranged for
dedicated space for the ZONE_DEVICE page metadata, and the
MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
page->_refcount transition to route the page to free_zone_device_page()
and not the core-mm page-free. With those cleanups in place and with
filesystem-dax and device-dax now converted to take and drop references
at map and truncate time, it is possible to start MEMORY_DEVICE_FS_DAX
and MEMORY_DEVICE_GENERIC reference counts at 0.

MEMORY_DEVICE_{PRIVATE,COHERENT} still expect that their ZONE_DEVICE
pages start life at _refcount 1, so make that the default if
pgmap->init_mode is left at zero.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/device.c     |    1 +
 drivers/nvdimm/pmem.c    |    2 ++
 include/linux/dax.h      |    2 +-
 include/linux/memremap.h |    5 +++++
 mm/memremap.c            |   15 ++++++++++-----
 mm/page_alloc.c          |    2 ++
 6 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 7f306939807e..8a7281d16c99 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -460,6 +460,7 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	}
 
 	pgmap->type = MEMORY_DEVICE_GENERIC;
+	pgmap->init_mode = INIT_PAGEMAP_IDLE;
 	if (dev_dax->align > PAGE_SIZE)
 		pgmap->vmemmap_shift =
 			order_base_2(dev_dax->align >> PAGE_SHIFT);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 7e88cd242380..9c98dcb9f33d 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -529,6 +529,7 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.init_mode = INIT_PAGEMAP_IDLE;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
@@ -543,6 +544,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.init_mode = INIT_PAGEMAP_IDLE;
 		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 3a27fecf072a..b9fdd8951e06 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -235,7 +235,7 @@ static inline void dax_unlock_mapping_entry(struct address_space *mapping,
  */
 static inline bool dax_page_idle(struct page *page)
 {
-	return page_ref_count(page) == 1;
+	return page_ref_count(page) == 0;
 }
 
 bool dax_alive(struct dax_device *dax_dev);
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index e5d30eec3bf1..9f1a57efd371 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -116,6 +116,7 @@ struct dev_pagemap_ops {
  *	representation. A bigger value will set up compound struct pages
  *	of the requested order value.
  * @ops: method table
+ * @init_mode: initial reference count mode
  * @owner: an opaque pointer identifying the entity that manages this
  *	instance.  Used by various helpers to make sure that no
  *	foreign ZONE_DEVICE memory is accessed.
@@ -131,6 +132,10 @@ struct dev_pagemap {
 	unsigned int flags;
 	unsigned long vmemmap_shift;
 	const struct dev_pagemap_ops *ops;
+	enum {
+		INIT_PAGEMAP_BUSY = 0, /* default / historical */
+		INIT_PAGEMAP_IDLE,
+	} init_mode;
 	void *owner;
 	int nr_range;
 	union {
diff --git a/mm/memremap.c b/mm/memremap.c
index 83c5e6fafd84..b6a7a95339b3 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -467,8 +467,10 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap_many);
 
 void free_zone_device_page(struct page *page)
 {
-	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
-		return;
+	struct dev_pagemap *pgmap = page->pgmap;
+
+	/* wake filesystem 'break dax layouts' waiters */
+	wake_up_var(page);
 
 	mem_cgroup_uncharge(page_folio(page));
 
@@ -503,12 +505,15 @@ void free_zone_device_page(struct page *page)
 	 * to clear page->mapping.
 	 */
 	page->mapping = NULL;
-	page->pgmap->ops->page_free(page);
+	if (pgmap->ops && pgmap->ops->page_free)
+		pgmap->ops->page_free(page);
 
 	/*
-	 * Reset the page count to 1 to prepare for handing out the page again.
+	 * Reset the page count to the @init_mode value to prepare for
+	 * handing out the page again.
 	 */
-	set_page_count(page, 1);
+	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
+		set_page_count(page, 1);
 }
 
 #ifdef CONFIG_FS_DAX
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e5486d47406e..8ee52992055b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6719,6 +6719,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 {
 
 	__init_single_page(page, pfn, zone_idx, nid);
+	if (pgmap->init_mode == INIT_PAGEMAP_IDLE)
+		set_page_count(page, 0);
 
 	/*
 	 * Mark page reserved as it will need to wait for onlining

