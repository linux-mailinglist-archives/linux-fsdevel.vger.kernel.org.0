Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBD5BA575
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 05:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIPDhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 23:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIPDgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:36:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3079E682;
        Thu, 15 Sep 2022 20:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663299411; x=1694835411;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZO7eiqr8wx9WyqWIgXnO5hpkhzDCAJO+DedF+qkd8PM=;
  b=XuI08Z35nz2ZKEMAOCciIDOhCk6KW89eYv1P18yXt7ObtP4gQoxPsptg
   JbdwZTjkQt/E5BHQVU5GQa8uDTEBNAFxqmKsRqhQtioUp+PzmsqvnMy3Y
   hcY3GIs/TUhrOwz4Z2p0Z9FmQNtkBga2m6kyc+6tuya9+NgmFqb6/iVxE
   YvronUUUQjpyUMbloDNRBO037xoZwWej62j3mGhfAV9RsXijIbt9fofpz
   EB3K9C7dxCJqx0pfj40v/Ies6IJhiG+6O+N/bOhJZjujrmi8Mqprkq7MF
   G0kx2d4IEsNphq2Lh80AipJVNNDJr36QnSId9NIWMhuKPMIl5rJefRZB6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="300264140"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="300264140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="679809618"
Received: from colinlix-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.29.52])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 20:36:50 -0700
Subject: [PATCH v2 17/18] fsdax: Delete put_devmap_managed_page_refs()
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
Date:   Thu, 15 Sep 2022 20:36:49 -0700
Message-ID: <166329940976.2786261.12969674850633492781.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
References: <166329930818.2786261.6086109734008025807.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that fsdax DMA-idle detection no longer depends on catching
transitions of page->_refcount to 1, remove
put_devmap_managed_page_refs() and associated infrastructure.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h |   30 ------------------------------
 mm/gup.c           |    6 ++----
 mm/memremap.c      |   18 ------------------
 mm/swap.c          |    2 --
 4 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3bedc449c14d..182fe336a268 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1048,30 +1048,6 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
  *   back into memory.
  */
 
-#if defined(CONFIG_ZONE_DEVICE) && defined(CONFIG_FS_DAX)
-DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-
-bool __put_devmap_managed_page_refs(struct page *page, int refs);
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	if (!static_branch_unlikely(&devmap_managed_key))
-		return false;
-	if (!is_zone_device_page(page))
-		return false;
-	return __put_devmap_managed_page_refs(page, refs);
-}
-#else /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-static inline bool put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	return false;
-}
-#endif /* CONFIG_ZONE_DEVICE && CONFIG_FS_DAX */
-
-static inline bool put_devmap_managed_page(struct page *page)
-{
-	return put_devmap_managed_page_refs(page, 1);
-}
-
 /* 127: arbitrary random number, small enough to assemble well */
 #define folio_ref_zero_or_close_to_overflow(folio) \
 	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
@@ -1168,12 +1144,6 @@ static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	/*
-	 * For some devmap managed pages we need to catch refcount transition
-	 * from 2 to 1:
-	 */
-	if (put_devmap_managed_page(&folio->page))
-		return;
 	folio_put(folio);
 }
 
diff --git a/mm/gup.c b/mm/gup.c
index 732825157430..c6d060dee9e0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -87,8 +87,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	 * belongs to this folio.
 	 */
 	if (unlikely(page_folio(page) != folio)) {
-		if (!put_devmap_managed_page_refs(&folio->page, refs))
-			folio_put_refs(folio, refs);
+		folio_put_refs(folio, refs);
 		goto retry;
 	}
 
@@ -177,8 +176,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 			refs *= GUP_PIN_COUNTING_BIAS;
 	}
 
-	if (!put_devmap_managed_page_refs(&folio->page, refs))
-		folio_put_refs(folio, refs);
+	folio_put_refs(folio, refs);
 }
 
 /**
diff --git a/mm/memremap.c b/mm/memremap.c
index b6a7a95339b3..0f4a2e20c159 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -515,21 +515,3 @@ void free_zone_device_page(struct page *page)
 	if (pgmap->init_mode == INIT_PAGEMAP_BUSY)
 		set_page_count(page, 1);
 }
-
-#ifdef CONFIG_FS_DAX
-bool __put_devmap_managed_page_refs(struct page *page, int refs)
-{
-	if (page->pgmap->type != MEMORY_DEVICE_FS_DAX)
-		return false;
-
-	/*
-	 * fsdax page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (page_ref_sub_return(page, refs) == 1)
-		wake_up_var(page);
-	return true;
-}
-EXPORT_SYMBOL(__put_devmap_managed_page_refs);
-#endif /* CONFIG_FS_DAX */
diff --git a/mm/swap.c b/mm/swap.c
index 9cee7f6a3809..b346dd24cde8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -960,8 +960,6 @@ void release_pages(struct page **pages, int nr)
 				unlock_page_lruvec_irqrestore(lruvec, flags);
 				lruvec = NULL;
 			}
-			if (put_devmap_managed_page(&folio->page))
-				continue;
 			if (folio_put_testzero(folio))
 				free_zone_device_page(&folio->page);
 			continue;

