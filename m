Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F585BA558
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiIPDgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIPDgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:36:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6631895CE;
        Thu, 15 Sep 2022 20:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299368; x=1694835368;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTs/4dIxqdixjfZltzlbEEuflTOzT+TWXRHIgDMaAds=;
  b=jVKhW6ulwMdPMvE0jGhxOS3FB3E0aZiykNK0fmAnLILX0w4tfkAEWp22
   8787s4Z7WfXt8GgBL74ZLf6pHwbAlhMSdXrFvOMYFvLd+Df8XAop1ilSK
   O7ZSLJYJcZAqcFBgs2FmPod4J+GuFfObCUf1Qo9Co+fzmxQ2phxHbHUT5
   FmPMw02IIzKnasFGS+2Kj8XVITAg+y92SrCLuzhUs7/NvNanFz8q2VC2u
   1KskvjTbVGFohu5IrGh5u11ip/d8w3axVafFgZSempIlD++7vzKZDOPUh
   jBQbaCMn114wacL/pIKSZBYT2SNNww1IpNaDgAt2KCQMvd4OV5Gys30aA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325170396"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="325170396"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:08 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="648099943"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:07 -0700
Subject: [PATCH v2 10/18] fsdax: Manage pgmap references at entry insertion
 and deletion
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
Date:   Thu, 15 Sep 2022 20:36:07 -0700
Message-ID: <166329936739.2786261.14035402420254589047.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The percpu_ref in 'struct dev_pagemap' is used to coordinate active
mappings of device-memory with the device-removal / unbind path. It
enables the semantic that initiating device-removal (or
device-driver-unbind) blocks new mapping and DMA attempts, and waits for
mapping revocation or inflight DMA to complete.

Expand the scope of the reference count to pin the DAX device active at
mapping time and not later at the first gup event. With a device
reference being held while any page on that device is mapped the need to
manage pgmap reference counts in the gup code is eliminated. That
cleanup is saved for a follow-on change.

For now, teach dax_insert_entry() and dax_delete_mapping_entry() to take
and drop pgmap references respectively. Where dax_insert_entry() is
called to take the initial reference on the page, and
dax_delete_mapping_entry() is called once there are no outstanding
references to the given page(s).

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c                 |   34 ++++++++++++++++++++++++++++------
 include/linux/memremap.h |   18 ++++++++++++++----
 mm/memremap.c            |   13 ++++++++-----
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5d9f30105db4..ee2568c8b135 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -376,14 +376,26 @@ static inline void dax_mapping_set_cow(struct page *page)
  * whether this entry is shared by multiple files.  If so, set the page->mapping
  * FS_DAX_MAPPING_COW, and use page->index as refcount.
  */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-				struct vm_fault *vmf, unsigned long flags)
+static vm_fault_t dax_associate_entry(void *entry,
+				      struct address_space *mapping,
+				      struct vm_fault *vmf, unsigned long flags)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
+	struct dev_pagemap *pgmap;
 	int i = 0;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
+		return 0;
+
+	if (!size)
+		return 0;
+
+	if (!(flags & DAX_COW)) {
+		pfn = dax_to_pfn(entry);
+		pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
+		if (!pgmap)
+			return VM_FAULT_SIGBUS;
+	}
 
 	index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
 	for_each_mapped_pfn(entry, pfn) {
@@ -398,19 +410,24 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 			page_ref_inc(page);
 		}
 	}
+
+	return 0;
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		bool trunc)
 {
-	unsigned long pfn;
+	unsigned long size = dax_entry_size(entry), pfn;
+	struct page *page;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
+	if (!size)
+		return;
 
+	for_each_mapped_pfn(entry, pfn) {
+		page = pfn_to_page(pfn);
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
 			if (page->index-- > 0)
@@ -423,6 +440,11 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		page->mapping = NULL;
 		page->index = 0;
 	}
+
+	if (trunc && !dax_mapping_is_cow(page->mapping)) {
+		page = pfn_to_page(dax_to_pfn(entry));
+		put_dev_pagemap_many(page->pgmap, PHYS_PFN(size));
+	}
 }
 
 /*
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index c3b4cc84877b..fd57407e7f3d 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -191,8 +191,13 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
-struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap);
+struct dev_pagemap *get_dev_pagemap_many(unsigned long pfn,
+					 struct dev_pagemap *pgmap, int refs);
+static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
+						  struct dev_pagemap *pgmap)
+{
+	return get_dev_pagemap_many(pfn, pgmap, 1);
+}
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
@@ -244,10 +249,15 @@ static inline unsigned long memremap_compat_align(void)
 }
 #endif /* CONFIG_ZONE_DEVICE */
 
-static inline void put_dev_pagemap(struct dev_pagemap *pgmap)
+static inline void put_dev_pagemap_many(struct dev_pagemap *pgmap, int refs)
 {
 	if (pgmap)
-		percpu_ref_put(&pgmap->ref);
+		percpu_ref_put_many(&pgmap->ref, refs);
+}
+
+static inline void put_dev_pagemap(struct dev_pagemap *pgmap)
+{
+	put_dev_pagemap_many(pgmap, 1);
 }
 
 #endif /* _LINUX_MEMREMAP_H_ */
diff --git a/mm/memremap.c b/mm/memremap.c
index 95f6ffe9cb0f..83c5e6fafd84 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -430,15 +430,16 @@ void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns)
 }
 
 /**
- * get_dev_pagemap() - take a new live reference on the dev_pagemap for @pfn
+ * get_dev_pagemap_many() - take new live references(s) on the dev_pagemap for @pfn
  * @pfn: page frame number to lookup page_map
  * @pgmap: optional known pgmap that already has a reference
+ * @refs: number of references to take
  *
  * If @pgmap is non-NULL and covers @pfn it will be returned as-is.  If @pgmap
  * is non-NULL but does not cover @pfn the reference to it will be released.
  */
-struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap)
+struct dev_pagemap *get_dev_pagemap_many(unsigned long pfn,
+					 struct dev_pagemap *pgmap, int refs)
 {
 	resource_size_t phys = PFN_PHYS(pfn);
 
@@ -454,13 +455,15 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	/* fall back to slow path lookup */
 	rcu_read_lock();
 	pgmap = xa_load(&pgmap_array, PHYS_PFN(phys));
-	if (pgmap && !percpu_ref_tryget_live(&pgmap->ref))
+	if (pgmap && !percpu_ref_tryget_live_rcu(&pgmap->ref))
 		pgmap = NULL;
+	if (pgmap && refs > 1)
+		percpu_ref_get_many(&pgmap->ref, refs - 1);
 	rcu_read_unlock();
 
 	return pgmap;
 }
-EXPORT_SYMBOL_GPL(get_dev_pagemap);
+EXPORT_SYMBOL_GPL(get_dev_pagemap_many);
 
 void free_zone_device_page(struct page *page)
 {

