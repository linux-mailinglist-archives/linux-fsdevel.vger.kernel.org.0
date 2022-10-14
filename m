Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6740D5FF745
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNX5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJNX5x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C49A3AAC
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791871; x=1697327871;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DzcvRRhSc/UKZtDBh8japCd9LbnnTSOaNgXJjR8jGE4=;
  b=fdsVV48iflk8srl4gZL8358uP+TWQxNN0CP0Zqn5euoNBT9TnE90qnzH
   MSKUxCC9zZXmarV4stgW/EBdY+9dg3bnckR5F8LROeKfBTt1LJtJihjlJ
   iTEDMJrqHi/lpao1sL1SH7UGE/5MFWJItbie7lpWhhUmcIf2E65xSzNen
   dilaJUnL4CxiGgTuy2KrOZxbk+KZREIQByDj/JPdXLaAHTldeCCvu9ddu
   gQkzYUAPnMJ91nhqKZ9+8/LxWiBJqQQU8afk1XyMV3Bm6mQUWuvkcyHnY
   WfMjcIw3JDFMzVf1LatKFBVcFVdGnjtpC7tWuOgsy+1LoBxxZ/UACjJki
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="332018596"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="332018596"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113310"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113310"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:49 -0700
Subject: [PATCH v3 09/25] fsdax: Rework for_each_mapped_pfn() to
 dax_for_each_folio()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:49 -0700
Message-ID: <166579186941.2236710.1345776454315696392.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for requesting folios from a pgmap, rework
for_each_mapped_pfn() to operate in terms of folios.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 .clang-format       |    1 +
 fs/dax.c            |  102 ++++++++++++++++++++++++++++++---------------------
 include/linux/dax.h |    5 +++
 3 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/.clang-format b/.clang-format
index 1247d54f9e49..767651ddc50c 100644
--- a/.clang-format
+++ b/.clang-format
@@ -136,6 +136,7 @@ ForEachMacros:
   - 'data__for_each_file'
   - 'data__for_each_file_new'
   - 'data__for_each_file_start'
+  - 'dax_for_each_folio'
   - 'device_for_each_child_node'
   - 'displayid_iter_for_each'
   - 'dma_fence_array_for_each'
diff --git a/fs/dax.c b/fs/dax.c
index 1f6c1abfe0c9..d03c7a952d02 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -327,18 +327,41 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
-static unsigned long dax_end_pfn(void *entry)
+/*
+ * Until fsdax constructs compound folios it needs to be prepared to
+ * support multiple folios per entry where each folio is a single page
+ */
+static struct folio *dax_entry_to_folio(void *entry, int idx)
 {
-	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
+	unsigned long pfn, size = dax_entry_size(entry);
+	struct page *page;
+	struct folio *folio;
+
+	if (!size)
+		return NULL;
+
+	pfn = dax_to_pfn(entry);
+	page = pfn_to_page(pfn);
+	folio = page_folio(page);
+
+	/*
+	 * Are there multiple folios per entry, and has the iterator
+	 * passed the end of that set?
+	 */
+	if (idx >= size / folio_size(folio))
+		return NULL;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(size, folio_size(folio)));
+
+	return page_folio(page + idx);
 }
 
 /*
- * Iterate through all mapped pfns represented by an entry, i.e. skip
- * 'empty' and 'zero' entries.
+ * Iterate through all folios associated with a given entry
  */
-#define for_each_mapped_pfn(entry, pfn) \
-	for (pfn = dax_to_pfn(entry); \
-			pfn < dax_end_pfn(entry); pfn++)
+#define dax_for_each_folio(entry, folio, i)                      \
+	for (i = 0, folio = dax_entry_to_folio(entry, i); folio; \
+	     folio = dax_entry_to_folio(entry, ++i))
 
 static inline bool dax_mapping_is_cow(struct address_space *mapping)
 {
@@ -348,18 +371,18 @@ static inline bool dax_mapping_is_cow(struct address_space *mapping)
 /*
  * Set the page->mapping with FS_DAX_MAPPING_COW flag, increase the refcount.
  */
-static inline void dax_mapping_set_cow(struct page *page)
+static inline void dax_mapping_set_cow(struct folio *folio)
 {
-	if ((uintptr_t)page->mapping != PAGE_MAPPING_DAX_COW) {
+	if ((uintptr_t)folio->mapping != PAGE_MAPPING_DAX_COW) {
 		/*
-		 * Reset the index if the page was already mapped
+		 * Reset the index if the folio was already mapped
 		 * regularly before.
 		 */
-		if (page->mapping)
-			page->index = 1;
-		page->mapping = (void *)PAGE_MAPPING_DAX_COW;
+		if (folio->mapping)
+			folio->index = 1;
+		folio->mapping = (void *)PAGE_MAPPING_DAX_COW;
 	}
-	page->index++;
+	folio->index++;
 }
 
 /*
@@ -370,48 +393,45 @@ static inline void dax_mapping_set_cow(struct page *page)
 static void dax_associate_entry(void *entry, struct address_space *mapping,
 		struct vm_area_struct *vma, unsigned long address, bool cow)
 {
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
+	unsigned long size = dax_entry_size(entry), index;
+	struct folio *folio;
+	int i;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
 	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
+	dax_for_each_folio(entry, folio, i)
 		if (cow) {
-			dax_mapping_set_cow(page);
+			dax_mapping_set_cow(folio);
 		} else {
-			WARN_ON_ONCE(page->mapping);
-			page->mapping = mapping;
-			page->index = index + i++;
+			WARN_ON_ONCE(folio->mapping);
+			folio->mapping = mapping;
+			folio->index = index + i;
 		}
-	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		bool trunc)
 {
-	unsigned long pfn;
+	struct folio *folio;
+	int i;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (dax_mapping_is_cow(page->mapping)) {
-			/* keep the CoW flag if this page is still shared */
-			if (page->index-- > 0)
+	dax_for_each_folio(entry, folio, i) {
+		if (dax_mapping_is_cow(folio->mapping)) {
+			/* keep the CoW flag if this folio is still shared */
+			if (folio->index-- > 0)
 				continue;
 		} else {
 			WARN_ON_ONCE(trunc && !dax_is_zapped(entry));
-			WARN_ON_ONCE(trunc && !dax_page_idle(page));
-			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+			WARN_ON_ONCE(trunc && !dax_folio_idle(folio));
+			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
 		}
-		page->mapping = NULL;
-		page->index = 0;
+		folio->mapping = NULL;
+		folio->index = 0;
 	}
 }
 
@@ -673,20 +693,18 @@ static void *dax_zap_entry(struct xa_state *xas, void *entry)
 static struct page *dax_zap_pages(struct xa_state *xas, void *entry)
 {
 	struct page *ret = NULL;
-	unsigned long pfn;
+	struct folio *folio;
 	bool zap;
+	int i;
 
 	if (!dax_entry_size(entry))
 		return NULL;
 
 	zap = !dax_is_zapped(entry);
 
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		if (!ret && !dax_page_idle(page))
-			ret = page;
-	}
+	dax_for_each_folio(entry, folio, i)
+		if (!ret && !dax_folio_idle(folio))
+			ret = folio_page(folio, 0);
 
 	if (zap)
 		dax_zap_entry(xas, entry);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6acb4ed73cb..12e15ca11bff 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -222,6 +222,11 @@ static inline bool dax_page_idle(struct page *page)
 	return page_ref_count(page) == 1;
 }
 
+static inline bool dax_folio_idle(struct folio *folio)
+{
+	return dax_page_idle(folio_page(folio, 0));
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);

