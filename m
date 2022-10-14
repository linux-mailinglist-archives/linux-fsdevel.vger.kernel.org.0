Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77665FF762
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJNX7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNX7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:59:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAF6C7865
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791949; x=1697327949;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hhzc7wFZ8F4D0mvPNxZZeth8IDrOfZkOP4UxlVQ4LJg=;
  b=SKJPHlALUSeyOae2PkFeys3tpuqLZHhliEu822WwmrByqYOgi6hfYBKy
   s6U2g5YVtyeYvGOXTEfaWDRsbqF+wT5uQo4s5FPsf0le+U6t51nkDNHU7
   zRGSrJAQsSMtM29mfo3lfA+iVthT+tvtmoHUpLDyVLRdzclQEojV8Nte/
   pyS8yn0DLUr77AfLE/4kzNE94FDI+9jGdMUPJZSN66bwSyIu3Yo9GcVMp
   ipgQ7mI+iTWK9v3CcMqkyBhrnttja1pIIYv0G5CqEGdZf7gt4H5mhj/SE
   zFERPCN0st8aUXV31WwCmnEq18ELiI7z7ojK8BPOOpYKXqOXNkKUjq52r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="288791500"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="288791500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="802798973"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="802798973"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:00 -0700
Subject: [PATCH v3 21/25] devdax: Use dax_insert_entry() +
 dax_delete_mapping_entry()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:59:00 -0700
Message-ID: <166579194049.2236710.10922460534153863415.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Track entries and take pgmap references at mapping insertion time.
Revoke mappings (dax_zap_mappings()) and drop the associated pgmap
references at device destruction or inode eviction time. With this in
place, and the fsdax equivalent already in place, the gup code no longer
needs to consider PTE_DEVMAP as an indicator to get a pgmap reference
before taking a page reference.

In other words, GUP takes additional references on mapped pages. Until
now, DAX in all its forms was failing to take references at mapping
time. With that fixed there is no longer a requirement for gup to manage
@pgmap references. However, that cleanup is saved for a follow-on patch.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/Kconfig   |    1 +
 drivers/dax/bus.c     |    9 +++++-
 drivers/dax/device.c  |   73 +++++++++++++++++++++++++++++--------------------
 drivers/dax/mapping.c |   19 +++++++++----
 include/linux/dax.h   |    3 +-
 5 files changed, 68 insertions(+), 37 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index 205e9dda8928..2eddd32c51f4 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -9,6 +9,7 @@ if DAX
 config DEV_DAX
 	tristate "Device DAX: direct access mapping device"
 	depends on TRANSPARENT_HUGEPAGE
+	depends on !FS_DAX_LIMITED
 	help
 	  Support raw access to differentiated (persistence, bandwidth,
 	  latency...) memory via an mmap(2) capable character
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..f2a8b8c3776f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -382,9 +382,16 @@ void kill_dev_dax(struct dev_dax *dev_dax)
 {
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct inode *inode = dax_inode(dax_dev);
+	struct address_space *mapping = inode->i_mapping;
 
 	kill_dax(dax_dev);
-	unmap_mapping_range(inode->i_mapping, 0, 0, 1);
+
+	/*
+	 * The dax device inode can outlive the next reuse of the memory
+	 * fronted by this device, force it idle now.
+	 */
+	dax_break_layouts(mapping, 0, ULONG_MAX >> PAGE_SHIFT);
+	truncate_inode_pages(mapping, 0);
 
 	/*
 	 * Dynamic dax region have the pgmap allocated via dev_kzalloc()
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 5494d745ced5..022d4ba9c336 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -73,38 +73,15 @@ __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
 	return -1;
 }
 
-static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
-			      unsigned long fault_size)
-{
-	unsigned long i, nr_pages = fault_size / PAGE_SIZE;
-	struct file *filp = vmf->vma->vm_file;
-	struct dev_dax *dev_dax = filp->private_data;
-	pgoff_t pgoff;
-
-	/* mapping is only set on the head */
-	if (dev_dax->pgmap->vmemmap_shift)
-		nr_pages = 1;
-
-	pgoff = linear_page_index(vmf->vma,
-			ALIGN(vmf->address, fault_size));
-
-	for (i = 0; i < nr_pages; i++) {
-		struct page *page = pfn_to_page(pfn_t_to_pfn(pfn) + i);
-
-		page = compound_head(page);
-		if (page->mapping)
-			continue;
-
-		page->mapping = filp->f_mapping;
-		page->index = pgoff + i;
-	}
-}
-
 static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
+	vm_fault_t ret;
+	void *entry;
 	pfn_t pfn;
 	unsigned int fault_size = PAGE_SIZE;
 
@@ -128,7 +105,16 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 
 	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	entry = dax_grab_mapping_entry(&xas, mapping, 0);
+	if (is_dax_err(entry))
+		return dax_err_to_vmfault(entry);
+
+	ret = dax_insert_entry(&xas, vmf, &entry, pfn, 0);
+
+	dax_unlock_entry(&xas, entry);
+
+	if (ret)
+		return ret;
 
 	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
 }
@@ -136,10 +122,14 @@ static vm_fault_t __dev_dax_pte_fault(struct dev_dax *dev_dax,
 static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
+	vm_fault_t ret;
 	pgoff_t pgoff;
+	void *entry;
 	pfn_t pfn;
 	unsigned int fault_size = PMD_SIZE;
 
@@ -171,7 +161,16 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 
 	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	entry = dax_grab_mapping_entry(&xas, mapping, PMD_ORDER);
+	if (is_dax_err(entry))
+		return dax_err_to_vmfault(entry);
+
+	ret = dax_insert_entry(&xas, vmf, &entry, pfn, DAX_PMD);
+
+	dax_unlock_entry(&xas, entry);
+
+	if (ret)
+		return ret;
 
 	return vmf_insert_pfn_pmd(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
@@ -180,10 +179,14 @@ static vm_fault_t __dev_dax_pmd_fault(struct dev_dax *dev_dax,
 static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 				struct vm_fault *vmf)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pud_addr = vmf->address & PUD_MASK;
+	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
 	struct device *dev = &dev_dax->dev;
 	phys_addr_t phys;
+	vm_fault_t ret;
 	pgoff_t pgoff;
+	void *entry;
 	pfn_t pfn;
 	unsigned int fault_size = PUD_SIZE;
 
@@ -216,7 +219,16 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 
 	pfn = phys_to_pfn_t(phys, PFN_DEV|PFN_MAP);
 
-	dax_set_mapping(vmf, pfn, fault_size);
+	entry = dax_grab_mapping_entry(&xas, mapping, PUD_ORDER);
+	if (xa_is_internal(entry))
+		return xa_to_internal(entry);
+
+	ret = dax_insert_entry(&xas, vmf, &entry, pfn, DAX_PUD);
+
+	dax_unlock_entry(&xas, entry);
+
+	if (ret)
+		return ret;
 
 	return vmf_insert_pfn_pud(vmf, pfn, vmf->flags & FAULT_FLAG_WRITE);
 }
@@ -494,3 +506,4 @@ MODULE_LICENSE("GPL v2");
 module_init(dax_init);
 module_exit(dax_exit);
 MODULE_ALIAS_DAX_DEVICE(0);
+MODULE_IMPORT_NS(DAX);
diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index ba01c1cf4b51..07caaa23d476 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -266,6 +266,7 @@ void dax_unlock_entry(struct xa_state *xas, void *entry)
 	WARN_ON(!dax_is_locked(old));
 	dax_wake_entry(xas, entry, WAKE_NEXT);
 }
+EXPORT_SYMBOL_NS_GPL(dax_unlock_entry, DAX);
 
 /*
  * Return: The entry stored at this location before it was locked.
@@ -663,6 +664,7 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 	xas_unlock_irq(xas);
 	return vmfault_to_dax_err(VM_FAULT_FALLBACK);
 }
+EXPORT_SYMBOL_NS_GPL(dax_grab_mapping_entry, DAX);
 
 static void *dax_zap_entry(struct xa_state *xas, void *entry)
 {
@@ -814,15 +816,21 @@ static int __dax_invalidate_entry(struct address_space *mapping,
  * wait indefinitely for all pins to drop, the alternative to waiting is
  * a potential use-after-free scenario
  */
-static void dax_break_layout(struct address_space *mapping, pgoff_t index)
+void dax_break_layouts(struct address_space *mapping, pgoff_t index,
+		       pgoff_t end)
 {
-	/* To do this without locks, the inode needs to be unreferenced */
-	WARN_ON(atomic_read(&mapping->host->i_count));
+	struct inode *inode = mapping->host;
+
+	/*
+	 * To do this without filesystem locks, the inode needs to be
+	 * unreferenced, or device-dax.
+	 */
+	WARN_ON(atomic_read(&inode->i_count) && !S_ISCHR(inode->i_mode));
 	do {
 		struct page *page;
 
 		page = dax_zap_mappings_range(mapping, index << PAGE_SHIFT,
-					      (index + 1) << PAGE_SHIFT);
+					      end << PAGE_SHIFT);
 		if (!page)
 			return;
 		wait_var_event(page, dax_page_idle(page));
@@ -838,7 +846,7 @@ int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index)
 	int ret;
 
 	if (mapping_exiting(mapping))
-		dax_break_layout(mapping, index);
+		dax_break_layouts(mapping, index, index + 1);
 
 	ret = __dax_invalidate_entry(mapping, index, true);
 
@@ -932,6 +940,7 @@ vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(dax_insert_entry, DAX);
 
 int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 		      struct address_space *mapping, void *entry) __must_hold(xas)
diff --git a/include/linux/dax.h b/include/linux/dax.h
index a61df43921a3..f2fbb5746ffa 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -181,7 +181,6 @@ dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 		unsigned long index, struct page **page);
 void dax_unlock_mapping_entry(struct address_space *mapping,
 		unsigned long index, dax_entry_t cookie);
-void dax_break_layouts(struct inode *inode);
 struct page *dax_zap_mappings(struct address_space *mapping);
 struct page *dax_zap_mappings_range(struct address_space *mapping, loff_t start,
 				    loff_t end);
@@ -286,6 +285,8 @@ void dax_unlock_entry(struct xa_state *xas, void *entry);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
+void dax_break_layouts(struct address_space *mapping, pgoff_t index,
+		       pgoff_t end);
 int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 				  struct inode *dest, loff_t destoff,
 				  loff_t len, bool *is_same,

