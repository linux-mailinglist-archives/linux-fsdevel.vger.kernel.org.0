Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B549B8868F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfHIW7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:59:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:25557 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbfHIW7C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:59:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="186799457"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:00 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 12/19] mm/gup: Prep put_user_pages() to take an vaddr_pin struct
Date:   Fri,  9 Aug 2019 15:58:26 -0700
Message-Id: <20190809225833.6657-13-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Once callers start to use vaddr_pin the put_user_pages calls will need
to have access to this data coming in.  Prep put_user_pages() for this
data.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/mm.h |  20 +-------
 mm/gup.c           | 122 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 88 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index befe150d17be..9d37cafbef9a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1064,25 +1064,7 @@ static inline void put_page(struct page *page)
 		__put_page(page);
 }
 
-/**
- * put_user_page() - release a gup-pinned page
- * @page:            pointer to page to be released
- *
- * Pages that were pinned via get_user_pages*() must be released via
- * either put_user_page(), or one of the put_user_pages*() routines
- * below. This is so that eventually, pages that are pinned via
- * get_user_pages*() can be separately tracked and uniquely handled. In
- * particular, interactions with RDMA and filesystems need special
- * handling.
- *
- * put_user_page() and put_page() are not interchangeable, despite this early
- * implementation that makes them look the same. put_user_page() calls must
- * be perfectly matched up with get_user_page() calls.
- */
-static inline void put_user_page(struct page *page)
-{
-	put_page(page);
-}
+void put_user_page(struct page *page);
 
 void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 			       bool make_dirty);
diff --git a/mm/gup.c b/mm/gup.c
index a7a9d2f5278c..10cfd30ff668 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -24,30 +24,41 @@
 
 #include "internal.h"
 
-/**
- * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
- * @pages:  array of pages to be maybe marked dirty, and definitely released.
- * @npages: number of pages in the @pages array.
- * @make_dirty: whether to mark the pages dirty
- *
- * "gup-pinned page" refers to a page that has had one of the get_user_pages()
- * variants called on that page.
- *
- * For each page in the @pages array, make that page (or its head page, if a
- * compound page) dirty, if @make_dirty is true, and if the page was previously
- * listed as clean. In any case, releases all pages using put_user_page(),
- * possibly via put_user_pages(), for the non-dirty case.
- *
- * Please see the put_user_page() documentation for details.
- *
- * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
- * required, then the caller should a) verify that this is really correct,
- * because _lock() is usually required, and b) hand code it:
- * set_page_dirty_lock(), put_user_page().
- *
- */
-void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
-			       bool make_dirty)
+static void __put_user_page(struct vaddr_pin *vaddr_pin, struct page *page)
+{
+	page = compound_head(page);
+
+	/*
+	 * For devmap managed pages we need to catch refcount transition from
+	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
+	 * page is free and we need to inform the device driver through
+	 * callback. See include/linux/memremap.h and HMM for details.
+	 */
+	if (put_devmap_managed_page(page))
+		return;
+
+	if (put_page_testzero(page))
+		__put_page(page);
+}
+
+static void __put_user_pages(struct vaddr_pin *vaddr_pin, struct page **pages,
+			     unsigned long npages)
+{
+	unsigned long index;
+
+	/*
+	 * TODO: this can be optimized for huge pages: if a series of pages is
+	 * physically contiguous and part of the same compound page, then a
+	 * single operation to the head page should suffice.
+	 */
+	for (index = 0; index < npages; index++)
+		__put_user_page(vaddr_pin, pages[index]);
+}
+
+static void __put_user_pages_dirty_lock(struct vaddr_pin *vaddr_pin,
+					struct page **pages,
+					unsigned long npages,
+					bool make_dirty)
 {
 	unsigned long index;
 
@@ -58,7 +69,7 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 	 */
 
 	if (!make_dirty) {
-		put_user_pages(pages, npages);
+		__put_user_pages(vaddr_pin, pages, npages);
 		return;
 	}
 
@@ -86,9 +97,58 @@ void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
 		 */
 		if (!PageDirty(page))
 			set_page_dirty_lock(page);
-		put_user_page(page);
+		__put_user_page(vaddr_pin, page);
 	}
 }
+
+/**
+ * put_user_page() - release a gup-pinned page
+ * @page:            pointer to page to be released
+ *
+ * Pages that were pinned via get_user_pages*() must be released via
+ * either put_user_page(), or one of the put_user_pages*() routines
+ * below. This is so that eventually, pages that are pinned via
+ * get_user_pages*() can be separately tracked and uniquely handled. In
+ * particular, interactions with RDMA and filesystems need special
+ * handling.
+ *
+ * put_user_page() and put_page() are not interchangeable, despite this early
+ * implementation that makes them look the same. put_user_page() calls must
+ * be perfectly matched up with get_user_page() calls.
+ */
+void put_user_page(struct page *page)
+{
+	__put_user_page(NULL, page);
+}
+EXPORT_SYMBOL(put_user_page);
+
+/**
+ * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
+ * @pages:  array of pages to be maybe marked dirty, and definitely released.
+ * @npages: number of pages in the @pages array.
+ * @make_dirty: whether to mark the pages dirty
+ *
+ * "gup-pinned page" refers to a page that has had one of the get_user_pages()
+ * variants called on that page.
+ *
+ * For each page in the @pages array, make that page (or its head page, if a
+ * compound page) dirty, if @make_dirty is true, and if the page was previously
+ * listed as clean. In any case, releases all pages using put_user_page(),
+ * possibly via put_user_pages(), for the non-dirty case.
+ *
+ * Please see the put_user_page() documentation for details.
+ *
+ * set_page_dirty_lock() is used internally. If instead, set_page_dirty() is
+ * required, then the caller should a) verify that this is really correct,
+ * because _lock() is usually required, and b) hand code it:
+ * set_page_dirty_lock(), put_user_page().
+ *
+ */
+void put_user_pages_dirty_lock(struct page **pages, unsigned long npages,
+			       bool make_dirty)
+{
+	__put_user_pages_dirty_lock(NULL, pages, npages, make_dirty);
+}
 EXPORT_SYMBOL(put_user_pages_dirty_lock);
 
 /**
@@ -102,15 +162,7 @@ EXPORT_SYMBOL(put_user_pages_dirty_lock);
  */
 void put_user_pages(struct page **pages, unsigned long npages)
 {
-	unsigned long index;
-
-	/*
-	 * TODO: this can be optimized for huge pages: if a series of pages is
-	 * physically contiguous and part of the same compound page, then a
-	 * single operation to the head page should suffice.
-	 */
-	for (index = 0; index < npages; index++)
-		put_user_page(pages[index]);
+	__put_user_pages(NULL, pages, npages);
 }
 EXPORT_SYMBOL(put_user_pages);
 
-- 
2.20.1

