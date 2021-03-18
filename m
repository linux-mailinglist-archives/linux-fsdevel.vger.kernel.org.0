Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518233FE14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 05:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCREIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 00:08:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:24885 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhCREI3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:08:29 -0400
IronPort-SDR: 1AV+VjFvpQaL7RcIgGtJm4yborjSoy1ExRqpNijYFyltjiX78/wn8FLvQ9jaWpdbYTd9Mgdj90
 G/N6Lmpe149A==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="176726686"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="176726686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:28 -0700
IronPort-SDR: hjXuI57s6BARQ8VjuN98OWw1m7Xbz+qmz7WFsT7KZ0Of7ZJkksW36XRaJlvxof+m/4aP+GrUyb
 uP7k9VGqpFwA==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="372572789"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:28 -0700
Subject: [PATCH 3/3] mm/devmap: Remove pgmap accounting in the
 get_user_pages_fast() path
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org, linux-nvdimm@lists.01.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Date:   Wed, 17 Mar 2021 21:08:28 -0700
Message-ID: <161604050866.1463742.7759521510383551055.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that device-dax and filesystem-dax are guaranteed to unmap all user
mappings of devmap / DAX pages before tearing down the 'struct page'
array, get_user_pages_fast() can rely on its traditional synchronization
method "validate_pte(); get_page(); revalidate_pte()" to catch races with
device shutdown. Specifically the unmap guarantee ensures that gup-fast
either succeeds in taking a page reference (lock-less), or it detects a
need to fall back to the slow path where the device presence can be
revalidated with locks held.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/gup.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..dfeb47e4e8d4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1996,9 +1996,8 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			 unsigned int flags, struct page **pages, int *nr)
 {
-	struct dev_pagemap *pgmap = NULL;
-	int nr_start = *nr, ret = 0;
 	pte_t *ptep, *ptem;
+	int ret = 0;
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
@@ -2015,16 +2014,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
 			goto pte_unmap;
 
-		if (pte_devmap(pte)) {
-			if (unlikely(flags & FOLL_LONGTERM))
-				goto pte_unmap;
+		if (pte_devmap(pte) && (flags & FOLL_LONGTERM))
+			goto pte_unmap;
 
-			pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
-			if (unlikely(!pgmap)) {
-				undo_dev_pagemap(nr, nr_start, flags, pages);
-				goto pte_unmap;
-			}
-		} else if (pte_special(pte))
+		if (pte_special(pte))
 			goto pte_unmap;
 
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
@@ -2063,8 +2056,6 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 	ret = 1;
 
 pte_unmap:
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	pte_unmap(ptem);
 	return ret;
 }
@@ -2087,21 +2078,26 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
 #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
 static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 			     unsigned long end, unsigned int flags,
 			     struct page **pages, int *nr)
 {
 	int nr_start = *nr;
-	struct dev_pagemap *pgmap = NULL;
 
 	do {
-		struct page *page = pfn_to_page(pfn);
+		struct page *page;
+
+		/*
+		 * Typically pfn_to_page() on a devmap pfn is not safe
+		 * without holding a live reference on the hosting
+		 * pgmap. In the gup-fast path it is safe because any
+		 * races will be resolved by either gup-fast taking a
+		 * reference or the shutdown path unmapping the pte to
+		 * trigger gup-fast to fall back to the slow path.
+		 */
+		page = pfn_to_page(pfn);
 
-		pgmap = get_dev_pagemap(pfn, pgmap);
-		if (unlikely(!pgmap)) {
-			undo_dev_pagemap(nr, nr_start, flags, pages);
-			return 0;
-		}
 		SetPageReferenced(page);
 		pages[*nr] = page;
 		if (unlikely(!try_grab_page(page, flags))) {
@@ -2112,8 +2108,6 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		pfn++;
 	} while (addr += PAGE_SIZE, addr != end);
 
-	if (pgmap)
-		put_dev_pagemap(pgmap);
 	return 1;
 }
 

