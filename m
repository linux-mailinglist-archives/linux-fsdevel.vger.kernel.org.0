Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6C2E7B6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgL3RBJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 12:01:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10914 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726469AbgL3RBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 12:01:09 -0500
X-IronPort-AV: E=Sophos;i="5.78,461,1599494400"; 
   d="scan'208";a="103085840"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Dec 2020 00:58:45 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 896D04CE6027;
        Thu, 31 Dec 2020 00:58:44 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 31 Dec 2020 00:58:44 +0800
Received: from irides.mr (10.167.225.141) by G08CNEXCHPEKD04.g08.fujitsu.local
 (10.167.33.209) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 31 Dec 2020 00:58:43 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-mm@kvack.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <song@kernel.org>,
        <rgoldwyn@suse.de>, <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [PATCH 10/10] fs/dax: remove useless functions
Date:   Thu, 31 Dec 2020 00:56:01 +0800
Message-ID: <20201230165601.845024-11-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 896D04CE6027.ABF58
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since owner tarcking is triggerred by pmem device, these functions are
useless.  So remove it.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c            | 112 --------------------------------------------
 include/linux/dax.h |   2 -
 2 files changed, 114 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 799210cfa687..4267de360d79 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -323,48 +323,6 @@ static unsigned long dax_end_pfn(void *entry)
 	for (pfn = dax_to_pfn(entry); \
 			pfn < dax_end_pfn(entry); pfn++)
 
-/*
- * TODO: for reflink+dax we need a way to associate a single page with
- * multiple address_space instances at different linear_page_index()
- * offsets.
- */
-static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
-{
-	unsigned long size = dax_entry_size(entry), pfn, index;
-	int i = 0;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	index = linear_page_index(vma, address & ~(size - 1));
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
-	}
-}
-
-static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
-{
-	unsigned long pfn;
-
-	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
-		return;
-
-	for_each_mapped_pfn(entry, pfn) {
-		struct page *page = pfn_to_page(pfn);
-
-		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
-	}
-}
-
 static struct page *dax_busy_page(void *entry)
 {
 	unsigned long pfn;
@@ -399,72 +357,6 @@ unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
 	return pfn;
 }
 
-/*
- * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
- * @page: The page whose entry we want to lock
- *
- * Context: Process context.
- * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
- * not be locked.
- */
-dax_entry_t dax_lock_page(struct page *page)
-{
-	XA_STATE(xas, NULL, 0);
-	void *entry;
-
-	/* Ensure page->mapping isn't freed while we look at it */
-	rcu_read_lock();
-	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
-
-		entry = NULL;
-		if (!mapping || !dax_mapping(mapping))
-			break;
-
-		/*
-		 * In the device-dax case there's no need to lock, a
-		 * struct dev_pagemap pin is sufficient to keep the
-		 * inode alive, and we assume we have dev_pagemap pin
-		 * otherwise we would not have a valid pfn_to_page()
-		 * translation.
-		 */
-		entry = (void *)~0UL;
-		if (S_ISCHR(mapping->host->i_mode))
-			break;
-
-		xas.xa = &mapping->i_pages;
-		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
-			xas_unlock_irq(&xas);
-			continue;
-		}
-		xas_set(&xas, page->index);
-		entry = xas_load(&xas);
-		if (dax_is_locked(entry)) {
-			rcu_read_unlock();
-			wait_entry_unlocked(&xas, entry);
-			rcu_read_lock();
-			continue;
-		}
-		dax_lock_entry(&xas, entry);
-		xas_unlock_irq(&xas);
-		break;
-	}
-	rcu_read_unlock();
-	return (dax_entry_t)entry;
-}
-
-void dax_unlock_page(struct page *page, dax_entry_t cookie)
-{
-	struct address_space *mapping = page->mapping;
-	XA_STATE(xas, &mapping->i_pages, page->index);
-
-	if (S_ISCHR(mapping->host->i_mode))
-		return;
-
-	dax_unlock_entry(&xas, (void *)cookie);
-}
-
 /*
  * Find page cache entry at given index. If it is a DAX entry, return it
  * with the entry locked. If the page cache doesn't contain an entry at
@@ -543,7 +435,6 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, true);
 		mapping->nrexceptional--;
@@ -680,7 +571,6 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
 	xas_store(&xas, NULL);
 	mapping->nrexceptional--;
 	ret = 1;
@@ -774,8 +664,6 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 89e56ceeffc7..c6b8dc094b26 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -151,8 +151,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
 unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
 static inline bool bdev_dax_supported(struct block_device *bdev,
 		int blocksize)
-- 
2.29.2



