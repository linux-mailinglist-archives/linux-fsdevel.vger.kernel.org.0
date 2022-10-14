Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799725FF74C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJNX6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJNX6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8212BC97DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791887; x=1697327887;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2k3kBI4gAM8OQoDfEoj4je6Hcxxjiy4NKP4rIBon+AA=;
  b=Ll+sSF3xg89gR9x7UwgtdvP9Ok4/18k+fHTXjHtDrQ3kia90VcY+u604
   6tsdaTvpX3KbLDhfeVeT5GZzK+0kl6emUBfk1ZP88tt9smw783OibrFR8
   ayNBRsI9YtPkYBnYJe/MjTrgUGpLCbIHP0P3aR2+h03CnG3357zNE4hwA
   rBZUFo0j8olkfp2nSUBP8sCtTBJtyz6vAULYSJeIVjfTnJ7NqC4qLrDn4
   h5F1ae4+C87cga3U06RmBP4v0om+WFmkpJVY7aDzOT2UkBGLkLa48jrwC
   IT5xlCy5RwvzkIhHDVayskijFdTFzCRSzysQrNv2O+BrKQdVg/ehLJqOn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="292862011"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="292862011"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113325"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113325"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:56 -0700
Subject: [PATCH v3 10/25] fsdax: Introduce pgmap_request_folios()
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
Date:   Fri, 14 Oct 2022 16:57:55 -0700
Message-ID: <166579187573.2236710.10151157417629496558.stgit@dwillia2-xfh.jf.intel.com>
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

The next step in sanitizing DAX page and pgmap lifetime is to take page
references when a pgmap user maps a page or otherwise puts it into use.
Unlike the page allocator where the it picks the page/folio, ZONE_DEVICE
users know in advance which folio they want to access.  Additionally,
ZONE_DEVICE implementations know when the pgmap is alive. Introduce
pgmap_request_folios() that pins @nr_folios folios at a time provided
they are contiguous and of the same folio_order().

Some WARN assertions are added to document expectations and catch bugs
in future kernel work, like a potential conversion of fsdax to use
multi-page folios, but they otherwise are not expected to fire.

Note that the paired pgmap_release_folios() implementation temporarily,
in this path, takes an @pgmap argument to drop pgmap references. A
follow-on patch arranges for free_zone_device_page() to drop pgmap
references in all cases. In other words, the intent is that only
put_folio() (on each folio requested pgmap_request_folio()) is needed to
to undo pgmap_request_folios().

The intent is that this also replaces zone_device_page_init(), but that
too requires some more preparatory reworks to unify the various
MEMORY_DEVICE_* types.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c                 |   32 ++++++++++++++++-----
 include/linux/memremap.h |   17 +++++++++++
 mm/memremap.c            |   70 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 8 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d03c7a952d02..095c9d7b4a1d 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -385,20 +385,27 @@ static inline void dax_mapping_set_cow(struct folio *folio)
 	folio->index++;
 }
 
+static struct dev_pagemap *folio_pgmap(struct folio *folio)
+{
+	return folio_page(folio, 0)->pgmap;
+}
+
 /*
  * When it is called in dax_insert_entry(), the cow flag will indicate that
  * whether this entry is shared by multiple files.  If so, set the page->mapping
  * FS_DAX_MAPPING_COW, and use page->index as refcount.
  */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address, bool cow)
+static vm_fault_t dax_associate_entry(void *entry,
+				      struct address_space *mapping,
+				      struct vm_area_struct *vma,
+				      unsigned long address, bool cow)
 {
 	unsigned long size = dax_entry_size(entry), index;
 	struct folio *folio;
 	int i;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
+		return 0;
 
 	index = linear_page_index(vma, address & ~(size - 1));
 	dax_for_each_folio(entry, folio, i)
@@ -406,9 +413,13 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 			dax_mapping_set_cow(folio);
 		} else {
 			WARN_ON_ONCE(folio->mapping);
+			if (!pgmap_request_folios(folio_pgmap(folio), folio, 1))
+				return VM_FAULT_SIGBUS;
 			folio->mapping = mapping;
 			folio->index = index + i;
 		}
+
+	return 0;
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
@@ -702,9 +713,12 @@ static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
 
 	zap = !dax_is_zapped(entry);
 
-	dax_for_each_folio(entry, folio, i)
+	dax_for_each_folio(entry, folio, i) {
+		if (zap)
+			pgmap_release_folios(folio_pgmap(folio), folio, 1);
 		if (!ret && !dax_folio_idle(folio))
 			ret = folio_page(folio, 0);
+	}
 
 	if (zap)
 		dax_zap_entry(xas, entry);
@@ -934,6 +948,7 @@ static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
 	bool cow = dax_fault_is_cow(iter);
 	void *entry = *pentry;
+	vm_fault_t ret = 0;
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -954,8 +969,10 @@ static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+		ret = dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
 				cow);
+		if (ret)
+			goto out;
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -978,10 +995,11 @@ static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (cow)
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
 
+	*pentry = entry;
+out:
 	xas_unlock_irq(xas);
 
-	*pentry = entry;
-	return 0;
+	return ret;
 }
 
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 7fcaf3180a5b..b87c16577af1 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -193,7 +193,11 @@ void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
 void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
-		struct dev_pagemap *pgmap);
+				    struct dev_pagemap *pgmap);
+bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
+			  int nr_folios);
+void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio,
+			  int nr_folios);
 bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
@@ -223,6 +227,17 @@ static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 	return NULL;
 }
 
+static inline bool pgmap_request_folios(struct dev_pagemap *pgmap,
+					struct folio *folio, int nr_folios)
+{
+	return false;
+}
+
+static inline void pgmap_release_folios(struct dev_pagemap *pgmap,
+					struct folio *folio, int nr_folios)
+{
+}
+
 static inline bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn)
 {
 	return false;
diff --git a/mm/memremap.c b/mm/memremap.c
index f9287babb3ce..87a649ecdc54 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -530,6 +530,76 @@ void zone_device_page_init(struct page *page)
 }
 EXPORT_SYMBOL_GPL(zone_device_page_init);
 
+static bool folio_span_valid(struct dev_pagemap *pgmap, struct folio *folio,
+			     int nr_folios)
+{
+	unsigned long pfn_start, pfn_end;
+
+	pfn_start = page_to_pfn(folio_page(folio, 0));
+	pfn_end = pfn_start + (1 << folio_order(folio)) * nr_folios - 1;
+
+	if (pgmap != xa_load(&pgmap_array, pfn_start))
+		return false;
+
+	if (pfn_end > pfn_start && pgmap != xa_load(&pgmap_array, pfn_end))
+		return false;
+
+	return true;
+}
+
+/**
+ * pgmap_request_folios - activate an contiguous span of folios in @pgmap
+ * @pgmap: host page map for the folio array
+ * @folio: start of the folio list, all subsequent folios have same folio_size()
+ *
+ * Caller is responsible for @pgmap remaining live for the duration of
+ * this call. Caller is also responsible for not racing requests for the
+ * same folios.
+ */
+bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
+			  int nr_folios)
+{
+	struct folio *iter;
+	int i;
+
+	/*
+	 * All of the WARNs below are for catching bugs in future
+	 * development that changes the assumptions of:
+	 * 1/ uniform folios in @pgmap
+	 * 2/ @pgmap death does not race this routine.
+	 */
+	VM_WARN_ON_ONCE(!folio_span_valid(pgmap, folio, nr_folios));
+
+	if (WARN_ON_ONCE(percpu_ref_is_dying(&pgmap->ref)))
+		return false;
+
+	for (iter = folio_next(folio), i = 1; i < nr_folios;
+	     iter = folio_next(folio), i++)
+		if (WARN_ON_ONCE(folio_order(iter) != folio_order(folio)))
+			return false;
+
+	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
+		folio_ref_inc(iter);
+		if (folio_ref_count(iter) == 1)
+			percpu_ref_tryget(&pgmap->ref);
+	}
+
+	return true;
+}
+
+void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio, int nr_folios)
+{
+	struct folio *iter;
+	int i;
+
+	for (iter = folio, i = 0; i < nr_folios; iter = folio_next(iter), i++) {
+		if (!put_devmap_managed_page(&iter->page))
+			folio_put(iter);
+		if (!folio_ref_count(iter))
+			put_dev_pagemap(pgmap);
+	}
+}
+
 #ifdef CONFIG_FS_DAX
 bool __put_devmap_managed_page_refs(struct page *page, int refs)
 {

