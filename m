Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EEC5AC211
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiIDCRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiIDCRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:17:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4402F4E858
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257825; x=1693793825;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2EY4uo7WnABwfrYvG4GUU1AXUkCpofKxrPSaAp/kYFc=;
  b=EyaWoVyfuUA8oTi+2aOalUFL85pIPsuksjQXh5XPiLSX0qqQGiMLkbQP
   n29EUZ1dwJ0oAR2+y1059571Y6VbNie8ANCydm93P8jRdea1iQcft5tcA
   uc2Xodv4AinOemBdQAMhcy9LDlg80aA4sITM063/IKXkUR2Ooqk4XIXX7
   Bqhrgshc/oDaipntxCk4pO/F0maR6UUxymwF8TrQwsCZhRtnIcYi+Fit9
   iK8LJAItKVEa8UDgnVFA70SRvKIs1rGKSvQb8+0+OyHkt3SX4rEago2TD
   8Zd2zEbZlPyhBOM8alyGRgRFJB/6LwmL+nx7rcIGXhuXsgjCWks80m8Y/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="283194137"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="283194137"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:17:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="616070245"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:17:04 -0700
Subject: [PATCH 11/13] devdax: add PUD support to the DAX mapping
 infrastructure
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:17:03 -0700
Message-ID: <166225782359.2351842.11436411972119201331.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In preparation for using the DAX mapping infrastructure for device-dax,
update the helpers to handle PUD entries.

In practice the code related to @size_downgrade will go unused for PUD
entries since only devdax creates DAX PUD entries and devdax enforces
aligned mappings. The conversion is included for completeness.

The addition of PUD support to dax_insert_pfn_mkwrite() requires a new
stub for vmf_insert_pfn_pud() in the
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=n case.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/mapping.c   |   50 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/dax.h     |   30 +++++++++++++++++++---------
 include/linux/huge_mm.h |   11 ++++++++--
 3 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index 6bd38ddba2cb..6eaa0fe33c16 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -13,6 +13,7 @@
 #include <linux/pfn_t.h>
 #include <linux/sizes.h>
 #include <linux/pagemap.h>
+#include <linux/huge_mm.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
@@ -51,6 +52,8 @@ static bool dax_is_locked(void *entry)
 
 static unsigned int dax_entry_order(void *entry)
 {
+	if (xa_to_value(entry) & DAX_PUD)
+		return PUD_ORDER;
 	if (xa_to_value(entry) & DAX_PMD)
 		return PMD_ORDER;
 	return 0;
@@ -61,9 +64,14 @@ static unsigned long dax_is_pmd_entry(void *entry)
 	return xa_to_value(entry) & DAX_PMD;
 }
 
+static unsigned long dax_is_pud_entry(void *entry)
+{
+	return xa_to_value(entry) & DAX_PUD;
+}
+
 static bool dax_is_pte_entry(void *entry)
 {
-	return !(xa_to_value(entry) & DAX_PMD);
+	return !(xa_to_value(entry) & (DAX_PMD|DAX_PUD));
 }
 
 static int dax_is_zero_entry(void *entry)
@@ -272,6 +280,8 @@ static unsigned long dax_entry_size(void *entry)
 		return 0;
 	else if (dax_is_pmd_entry(entry))
 		return PMD_SIZE;
+	else if (dax_is_pud_entry(entry))
+		return PUD_SIZE;
 	else
 		return PAGE_SIZE;
 }
@@ -572,11 +582,11 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 			     struct address_space *mapping, unsigned int order)
 {
 	unsigned long index = xas->xa_index;
-	bool pmd_downgrade; /* splitting PMD entry into PTE entries? */
+	bool size_downgrade; /* splitting entry into PTE entries? */
 	void *entry;
 
 retry:
-	pmd_downgrade = false;
+	size_downgrade = false;
 	xas_lock_irq(xas);
 	entry = get_unlocked_entry(xas, order);
 
@@ -589,15 +599,25 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 		}
 
 		if (order == 0) {
-			if (dax_is_pmd_entry(entry) &&
+			if (!dax_is_pte_entry(entry) &&
 			    (dax_is_zero_entry(entry) ||
 			     dax_is_empty_entry(entry))) {
-				pmd_downgrade = true;
+				size_downgrade = true;
 			}
 		}
 	}
 
-	if (pmd_downgrade) {
+	if (size_downgrade) {
+		unsigned long colour, nr;
+
+		if (dax_is_pmd_entry(entry)) {
+			colour = PG_PMD_COLOUR;
+			nr = PG_PMD_NR;
+		} else {
+			colour = PG_PUD_COLOUR;
+			nr = PG_PUD_NR;
+		}
+
 		/*
 		 * Make sure 'entry' remains valid while we drop
 		 * the i_pages lock.
@@ -611,9 +631,8 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 		 */
 		if (dax_is_zero_entry(entry)) {
 			xas_unlock_irq(xas);
-			unmap_mapping_pages(mapping,
-					    xas->xa_index & ~PG_PMD_COLOUR,
-					    PG_PMD_NR, false);
+			unmap_mapping_pages(mapping, xas->xa_index & ~colour,
+					    nr, false);
 			xas_reset(xas);
 			xas_lock_irq(xas);
 		}
@@ -621,7 +640,7 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL); /* undo the PMD join */
 		dax_wake_entry(xas, entry, WAKE_ALL);
-		mapping->nrpages -= PG_PMD_NR;
+		mapping->nrpages -= nr;
 		entry = NULL;
 		xas_set(xas, index);
 	}
@@ -631,7 +650,9 @@ void *dax_grab_mapping_entry(struct xa_state *xas,
 	} else {
 		unsigned long flags = DAX_EMPTY;
 
-		if (order > 0)
+		if (order == PUD_SHIFT - PAGE_SHIFT)
+			flags |= DAX_PUD;
+		else if (order == PMD_SHIFT - PAGE_SHIFT)
 			flags |= DAX_PMD;
 		entry = dax_make_entry(pfn_to_pfn_t(0), flags);
 		dax_lock_entry(xas, entry);
@@ -811,7 +832,10 @@ vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
-		if (dax_is_pmd_entry(entry))
+		if (dax_is_pud_entry(entry))
+			unmap_mapping_pages(mapping, index & ~PG_PUD_COLOUR,
+					    PG_PUD_NR, false);
+		else if (dax_is_pmd_entry(entry))
 			unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
 					    PG_PMD_NR, false);
 		else /* pte entry */
@@ -983,6 +1007,8 @@ vm_fault_t dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn,
 	else if (order == PMD_ORDER)
 		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
 #endif
+	else if (order == PUD_ORDER)
+		ret = vmf_insert_pfn_pud(vmf, pfn, FAULT_FLAG_WRITE);
 	else
 		ret = VM_FAULT_FALLBACK;
 	dax_unlock_entry(&xas, entry);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 05ce7992ac43..81fcc0e4a070 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -268,21 +268,24 @@ static inline bool dax_mapping(struct address_space *mapping)
 }
 
 /*
- * DAX pagecache entries use XArray value entries so they can't be mistaken
- * for pages.  We use one bit for locking, one bit for the entry size (PMD)
- * and two more to tell us if the entry is a zero page or an empty entry that
- * is just used for locking.  In total four special bits.
+ * DAX pagecache entries use XArray value entries so they can't be
+ * mistaken for pages.  We use one bit for locking, two bits for the
+ * entry size (PMD, PUD) and two more to tell us if the entry is a zero
+ * page or an empty entry that is just used for locking.  In total 5
+ * special bits which limits the max pfn that can be stored as:
+ * (1UL << 57 - PAGE_SHIFT). 63 - DAX_SHIFT - 1 (for xa_mk_value()).
  *
- * If the PMD bit isn't set the entry has size PAGE_SIZE, and if the ZERO_PAGE
- * and EMPTY bits aren't set the entry is a normal DAX entry with a filesystem
- * block allocation.
+ * If the P{M,U}D bits are not set the entry has size PAGE_SIZE, and if
+ * the ZERO_PAGE and EMPTY bits aren't set the entry is a normal DAX
+ * entry with a filesystem block allocation.
  */
-#define DAX_SHIFT (4)
+#define DAX_SHIFT (5)
 #define DAX_MASK ((1UL << DAX_SHIFT) - 1)
 #define DAX_LOCKED (1UL << 0)
 #define DAX_PMD (1UL << 1)
-#define DAX_ZERO_PAGE (1UL << 2)
-#define DAX_EMPTY (1UL << 3)
+#define DAX_PUD (1UL << 2)
+#define DAX_ZERO_PAGE (1UL << 3)
+#define DAX_EMPTY (1UL << 4)
 
 /*
  * These flags are not conveyed in Xarray value entries, they are just
@@ -304,6 +307,13 @@ int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 /* The order of a PMD entry */
 #define PMD_ORDER (PMD_SHIFT - PAGE_SHIFT)
 
+/* The 'colour' (ie low bits) within a PUD of a page offset.  */
+#define PG_PUD_COLOUR ((PUD_SIZE >> PAGE_SHIFT) - 1)
+#define PG_PUD_NR (PUD_SIZE >> PAGE_SHIFT)
+
+/* The order of a PUD entry */
+#define PUD_ORDER (PUD_SHIFT - PAGE_SHIFT)
+
 static inline unsigned int pe_order(enum page_entry_size pe_size)
 {
 	if (pe_size == PE_SIZE_PTE)
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 768e5261fdae..de73f5a16252 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -18,10 +18,19 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud);
+vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
+				   pgprot_t pgprot, bool write);
 #else
 static inline void huge_pud_set_accessed(struct vm_fault *vmf, pud_t orig_pud)
 {
 }
+
+static inline vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf,
+						 pfn_t pfn, pgprot_t pgprot,
+						 bool write)
+{
+	return VM_FAULT_SIGBUS;
+}
 #endif
 
 vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf);
@@ -58,8 +67,6 @@ static inline vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn,
 {
 	return vmf_insert_pfn_pmd_prot(vmf, pfn, vmf->vma->vm_page_prot, write);
 }
-vm_fault_t vmf_insert_pfn_pud_prot(struct vm_fault *vmf, pfn_t pfn,
-				   pgprot_t pgprot, bool write);
 
 /**
  * vmf_insert_pfn_pud - insert a pud size pfn

