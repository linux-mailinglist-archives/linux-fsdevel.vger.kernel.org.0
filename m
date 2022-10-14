Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8455FF760
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJNX7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJNX7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:59:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906CEC7865
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791947; x=1697327947;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtNMf37ZvlWFUlBN5phg2oXwEnFZD9IVJ73UXHkz864=;
  b=GftkRWWqIHDaOd99UkcaDFCm9qZvKcRy40a7A2FgUr1Brh1cA7tc93Zg
   WDFp+CSM97hp4bV9viHQUh6bEHPEljV/umpDU/NanQA8dDSuoeooX5wki
   mztX2FtAKnPW3XFe+pgclk9VNA1a9jWoofA8B24pyttljMtdOfmE+DqhV
   VfCnvZYQtpaZ8jho2c6u+/01gPlqrf364OoiPc2aNv4m27V/BrL6DptfY
   FO0ySqQ6GbFy/hjqfZHtx8NxVxegkeji7IUQcxcYEUjQrBhPn7OZOiAi7
   /K2thVSEdXo2rP1igktbKVzsq31z95+BLfIV/QQpGBoiVUAL3PExSbkMK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="367523341"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="367523341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="605541354"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="605541354"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:59:06 -0700
Subject: [PATCH v3 22/25] mm/memremap_pages: Replace zone_device_page_init()
 with pgmap_request_folios()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        david@fromorbit.com, nvdimm@lists.linux.dev,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:59:06 -0700
Message-ID: <166579194621.2236710.8168919102434295671.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch to the common method, shared across all MEMORY_DEVICE_* types,
for requesting access to a ZONE_DEVICE page. The
MEMORY_DEVICE_{PRIVATE,COHERENT} specific expectation that newly
requested pages are locked is moved to the callers.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c       |    3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |    3 ++-
 drivers/gpu/drm/nouveau/nouveau_dmem.c   |    3 ++-
 include/linux/memremap.h                 |    1 -
 lib/test_hmm.c                           |    3 ++-
 mm/memremap.c                            |   13 +------------
 6 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index e2f11f9c3f2a..884ec112ad43 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -718,7 +718,8 @@ static struct page *kvmppc_uvmem_get_page(unsigned long gpa, struct kvm *kvm)
 
 	dpage = pfn_to_page(uvmem_pfn);
 	dpage->zone_device_data = pvt;
-	zone_device_page_init(dpage);
+	pgmap_request_folios(dpage->pgmap, page_folio(dpage), 1);
+	lock_page(dpage);
 	return dpage;
 out_clear:
 	spin_lock(&kvmppc_uvmem_bitmap_lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 97a684568ae0..8cf97060122b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -223,7 +223,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	page = pfn_to_page(pfn);
 	svm_range_bo_ref(prange->svm_bo);
 	page->zone_device_data = prange->svm_bo;
-	zone_device_page_init(page);
+	pgmap_request_folios(page->pgmap, page_folio(page), 1);
+	lock_page(page);
 }
 
 static void
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 5fe209107246..1482533c7ca0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -324,7 +324,8 @@ nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
 			return NULL;
 	}
 
-	zone_device_page_init(page);
+	pgmap_request_folios(page->pgmap, page_folio(page), 1);
+	lock_page(page);
 	return page;
 }
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 98196b8d3172..3fb3809d71f3 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -187,7 +187,6 @@ static inline bool folio_is_device_coherent(const struct folio *folio)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-void zone_device_page_init(struct page *page);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 67e6f83fe0f8..e4f7219ae3bb 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -632,7 +632,8 @@ static struct page *dmirror_devmem_alloc_page(struct dmirror_device *mdevice)
 			goto error;
 	}
 
-	zone_device_page_init(dpage);
+	pgmap_request_folios(dpage->pgmap, page_folio(dpage), 1);
+	lock_page(dpage);
 	dpage->zone_device_data = rpage;
 	return dpage;
 
diff --git a/mm/memremap.c b/mm/memremap.c
index 87a649ecdc54..c46e700f5245 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -518,18 +518,6 @@ void free_zone_device_page(struct page *page)
 		put_dev_pagemap(page->pgmap);
 }
 
-void zone_device_page_init(struct page *page)
-{
-	/*
-	 * Drivers shouldn't be allocating pages after calling
-	 * memunmap_pages().
-	 */
-	WARN_ON_ONCE(!percpu_ref_tryget_live(&page->pgmap->ref));
-	set_page_count(page, 1);
-	lock_page(page);
-}
-EXPORT_SYMBOL_GPL(zone_device_page_init);
-
 static bool folio_span_valid(struct dev_pagemap *pgmap, struct folio *folio,
 			     int nr_folios)
 {
@@ -586,6 +574,7 @@ bool pgmap_request_folios(struct dev_pagemap *pgmap, struct folio *folio,
 
 	return true;
 }
+EXPORT_SYMBOL_GPL(pgmap_request_folios);
 
 void pgmap_release_folios(struct dev_pagemap *pgmap, struct folio *folio, int nr_folios)
 {

