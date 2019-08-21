Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5BB98211
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfHUR60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:58:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729793AbfHUR5j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 105E87F768;
        Wed, 21 Aug 2019 17:57:39 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE1FC17D29;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CD458223D0C; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 16/19] dax: Create a range version of dax_layout_busy_page()
Date:   Wed, 21 Aug 2019 13:57:17 -0400
Message-Id: <20190821175720.25901-17-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Wed, 21 Aug 2019 17:57:39 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While reclaiming a dax range, we do not want to unamap whole file instead
want to make sure pages in a certain range do not have references taken
on them. Hence create a version of the function which allows to pass in
a range.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c            | 66 ++++++++++++++++++++++++++++++++-------------
 include/linux/dax.h |  6 +++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 60620a37030c..435f5b67e828 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -557,27 +557,20 @@ static void *grab_mapping_entry(struct xa_state *xas,
 	return xa_mk_internal(VM_FAULT_FALLBACK);
 }
 
-/**
- * dax_layout_busy_page - find first pinned page in @mapping
- * @mapping: address space to scan for a page with ref count > 1
- *
- * DAX requires ZONE_DEVICE mapped pages. These pages are never
- * 'onlined' to the page allocator so they are considered idle when
- * page->count == 1. A filesystem uses this interface to determine if
- * any page in the mapping is busy, i.e. for DMA, or other
- * get_user_pages() usages.
- *
- * It is expected that the filesystem is holding locks to block the
- * establishment of new mappings in this address_space. I.e. it expects
- * to be able to run unmap_mapping_range() and subsequently not race
- * mapping_mapped() becoming true.
+/*
+ * Partial pages are included. If end is 0, pages in the range from start
+ * to end of the file are inluded.
  */
-struct page *dax_layout_busy_page(struct address_space *mapping)
+struct page *dax_layout_busy_page_range(struct address_space *mapping,
+					loff_t start, loff_t end)
 {
-	XA_STATE(xas, &mapping->i_pages, 0);
 	void *entry;
 	unsigned int scanned = 0;
 	struct page *page = NULL;
+	pgoff_t start_idx = start >> PAGE_SHIFT;
+	pgoff_t end_idx = end >> PAGE_SHIFT;
+	XA_STATE(xas, &mapping->i_pages, start_idx);
+	loff_t len, lstart = round_down(start, PAGE_SIZE);
 
 	/*
 	 * In the 'limited' case get_user_pages() for dax is disabled.
@@ -588,6 +581,22 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	if (!dax_mapping(mapping) || !mapping_mapped(mapping))
 		return NULL;
 
+	/* If end == 0, all pages from start to till end of file */
+	if (!end) {
+		end_idx = ULONG_MAX;
+		len = 0;
+	} else {
+		/* length is being calculated from lstart and not start.
+		 * This is due to behavior of unmap_mapping_range(). If
+		 * start is say 4094 and end is on 4093 then want to
+		 * unamp two pages, idx 0 and 1. But unmap_mapping_range()
+		 * will unmap only page at idx 0. If we calculate len
+		 * from the rounded down start, this problem should not
+		 * happen.
+		 */
+		len = end - lstart + 1;
+	}
+
 	/*
 	 * If we race get_user_pages_fast() here either we'll see the
 	 * elevated page count in the iteration and wait, or
@@ -600,10 +609,10 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	 * guaranteed to either see new references or prevent new
 	 * references from being established.
 	 */
-	unmap_mapping_range(mapping, 0, 0, 0);
+	unmap_mapping_range(mapping, start, len, 0);
 
 	xas_lock_irq(&xas);
-	xas_for_each(&xas, entry, ULONG_MAX) {
+	xas_for_each(&xas, entry, end_idx) {
 		if (WARN_ON_ONCE(!xa_is_value(entry)))
 			continue;
 		if (unlikely(dax_is_locked(entry)))
@@ -624,6 +633,27 @@ struct page *dax_layout_busy_page(struct address_space *mapping)
 	xas_unlock_irq(&xas);
 	return page;
 }
+EXPORT_SYMBOL_GPL(dax_layout_busy_page_range);
+
+/**
+ * dax_layout_busy_page - find first pinned page in @mapping
+ * @mapping: address space to scan for a page with ref count > 1
+ *
+ * DAX requires ZONE_DEVICE mapped pages. These pages are never
+ * 'onlined' to the page allocator so they are considered idle when
+ * page->count == 1. A filesystem uses this interface to determine if
+ * any page in the mapping is busy, i.e. for DMA, or other
+ * get_user_pages() usages.
+ *
+ * It is expected that the filesystem is holding locks to block the
+ * establishment of new mappings in this address_space. I.e. it expects
+ * to be able to run unmap_mapping_range() and subsequently not race
+ * mapping_mapped() becoming true.
+ */
+struct page *dax_layout_busy_page(struct address_space *mapping)
+{
+	return dax_layout_busy_page_range(mapping, 0, 0);
+}
 EXPORT_SYMBOL_GPL(dax_layout_busy_page);
 
 static int __dax_invalidate_entry(struct address_space *mapping,
diff --git a/include/linux/dax.h b/include/linux/dax.h
index e7f40108f2c9..3ef6686c080b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -145,6 +145,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 		struct writeback_control *wbc);
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 dax_entry_t dax_lock_page(struct page *page);
 void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
@@ -180,6 +181,11 @@ static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 	return NULL;
 }
 
+static inline struct page *dax_layout_busy_page_range(struct address_space *mapping, pgoff_t start, pgoff_t nr_pages)
+{
+	return NULL;
+}
+
 static inline int dax_writeback_mapping_range(struct address_space *mapping,
 		struct block_device *bdev, struct dax_device *dax_dev,
 		struct writeback_control *wbc)
-- 
2.20.1

