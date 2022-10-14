Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E85FF763
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJNX7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJNX7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:59:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D9EE9856
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791953; x=1697327953;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJkGyA2USCATPfeLAvbcj+LxFwO3lVwTXahzZIEoOwI=;
  b=AYFKQXFFkmvgPYfsI8Dq1I7uAzcMFFuOw/IPUnFDF+IPU2s1bHKSVU/Q
   beuEBghDONO1XAFJz2nPGGnuKrQIIDVht3H23DW6oAE4xi/1Ckp0M3o/f
   Bu3LjHq+V5jzd/WuMBxrtighJnJdlUr4N3ZTYGa9GVynyEdFa3lOkmTEu
   lVYVpwO82POBBXTsk6pTyr6x9PIqt3VpRtoDmCoE1D6aC0x2TRwwBF9yu
   bfA7evTB1+BBS0zAJxgX290iKhgK/xf2zDHvcx0gF2SzUQGXVBk3OuxKC
   e9xbMVAqT9/78Asi+SH3pg/bxd1AM/0pGDDZM8j3C03XRs7bHSOnPuXmq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="306580753"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="306580753"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605541373"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="605541373"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:12 -0700
Subject: [PATCH v3 23/25] mm/memremap_pages: Initialize all ZONE_DEVICE
 pages to start at refcount 0
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:59:12 -0700
Message-ID: <166579195218.2236710.8731183545033177929.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
dedicated space for the ZONE_DEVICE page metadata, the
MEMORY_DEVICE_{PRIVATE,COHERENT} work has arranged for the 1 -> 0
page->_refcount transition to route the page to free_zone_device_page()
and not the core-mm page-free, and MEMORY_DEVICE_{PRIVATE,COHERENT} now
arranges for its ZONE_DEVICE pages to start at _refcount 0. With those
cleanups in place and with filesystem-dax and device-dax now converted
to take and drop references at map and truncate time, it is possible to
start MEMORY_DEVICE_FS_DAX and MEMORY_DEVICE_GENERIC reference counts at
0 as well.

This conversion also unifies all @pgmap accounting to be relative to
pgmap_request_folio() and the paired folio_put() calls for those
requested folios. This allows pgmap_release_folios() to be simplified to
just a folio_put() helper.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/mapping.c    |    2 +-
 include/linux/dax.h      |    2 +-
 include/linux/memremap.h |    6 ++----
 mm/memremap.c            |   36 ++++++++++++++++--------------------
 mm/page_alloc.c          |    9 +--------
 5 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/drivers/dax/mapping.c b/drivers/dax/mapping.c
index 07caaa23d476..ca06f2515644 100644
--- a/drivers/dax/mapping.c
+++ b/drivers/dax/mapping.c
@@ -691,7 +691,7 @@ static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
 
 	dax_for_each_folio(entry, folio, i) {
 		if (zap)
-			pgmap_release_folios(folio_pgmap(folio), folio, 1);
+			pgmap_release_folios(folio, 1);
 		if (!ret && !dax_folio_idle(folio))
 			ret = folio_page(folio, 0);
 	}
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f2fbb5746ffa..f4fc37933fc2 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -235,7 +235,7 @@ static inline void dax_unlock_mapping_entry(struct address_space *mapping,
  */
 static inline bool dax_page_idle(struct page *page)
 {
-	return page_ref_count(page) == 1;
+	return page_ref_count(page) == 0;
 }
 
 static inline bool dax_folio_idle(struct folio *folio)
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 3fb3809d71f3..ddb196ae0696 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -195,8 +195,7 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 				    struct dev_pagemap *pgmap);
 bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
 			  int nr_folios);
-void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio,
-			  int nr_folios);
+void pgmap_release_folios(struct folio *folio, int nr_folios);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
@@ -238,8 +237,7 @@ static inline bool pgmap_request_folios(struct dev_pagemap *pgmap,
 	return false;
 }
 
-static inline void pgmap_release_folios(struct dev_pagemap *pgmap,
-					struct folio *folio, int nr_folios)
+static inline void pgmap_release_folios(struct folio *folio, int nr_folios)
 {
 }
 
diff --git a/mm/memremap.c b/mm/memremap.c
index c46e700f5245..368ff41c560b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -469,8 +469,10 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_page(struct page *page)
 {
-	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
-		return;
+	struct dev_pagemap *pgmap = page->pgmap;
+
+	/* wake filesystem 'break dax layouts' waiters */
+	wake_up_var(page);
 
 	mem_cgroup_uncharge(page_folio(page));
 
@@ -505,17 +507,9 @@ void free_zone_device_page(struct page *page)
 	 * to clear page->mapping.
 	 */
 	page->mapping = NULL;
-	page->pgmap->ops->page_free(page);
-
-	if (page->pgmap->type != MEMORY_DEVICE_PRIVATE &&
-	    page->pgmap->type != MEMORY_DEVICE_COHERENT)
-		/*
-		 * Reset the page count to 1 to prepare for handing out the page
-		 * again.
-		 */
-		set_page_count(page, 1);
-	else
-		put_dev_pagemap(page->pgmap);
+	if (pgmap->ops && pgmap->ops->page_free)
+		pgmap->ops->page_free(page);
+	put_dev_pagemap(page->pgmap);
 }
 
 static bool folio_span_valid(struct dev_pagemap *pgmap, struct folio *folio,
@@ -576,17 +570,19 @@ bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(pgmap_request_folios);
 
-void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio, int nr_folios)
+/*
+ * A symmetric helper to undo the page references acquired by
+ * pgmap_request_folios(), but the caller can also just arrange
+ * folio_put() on all the folios it acquired previously for the same
+ * effect.
+ */
+void pgmap_release_folios(struct folio *folio, int nr_folios)
 {
 	struct folio *iter;
 	int i;
 
-	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
-		if (!put_devmap_managed_page(&iter->page))
-			folio_put(iter);
-		if (!folio_ref_count(iter))
-			put_dev_pagemap(pgmap);
-	}
+	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(folio), i++)
+		folio_put(iter);
 }
 
 #ifdef CONFIG_FS_DAX
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e9b7f08a32c..e35d1eb3308d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6787,6 +6787,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 {
 
 	__init_single_page(page, pfn, zone_idx, nid);
+	set_page_count(page, 0);
 
 	/*
 	 * Mark page reserved as it will need to wait for onlining
@@ -6819,14 +6820,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 		cond_resched();
 	}
-
-	/*
-	 * ZONE_DEVICE pages are released directly to the driver page allocator
-	 * which will set the page count to 1 when allocating the page.
-	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE ||
-	    pgmap->type == MEMORY_DEVICE_COHERENT)
-		set_page_count(page, 0);
 }
 
 /*

