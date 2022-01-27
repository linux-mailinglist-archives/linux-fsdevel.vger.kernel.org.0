Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89A849E280
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbiA0MlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35616 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241214AbiA0MlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:06 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A3kvy+K5pYNK7XuQIbfW+gQxRtEfGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShD0AmjFODGGBbPiCZjb8Loh1OYy19UsA6JGAz9RjTAE5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuOmV7a?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyDu6JfJkRWun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TqO8lqonfOJkS6TcIAbErD+/?=
 =?us-ascii?q?f53qFqJz2cXBVsdUl7Tif24jFOuHtxEJ0EK9y4Gs6c/7gqoQ8P7Uhn+p2SL1jY?=
 =?us-ascii?q?YWtxNA6g55RuLx678/QmUHC4HQyRHZdhgs9U5LRQu11mUj5b5CydHrrKYUzSe+?=
 =?us-ascii?q?62SoDf0PjIaRVLuzwdsoRAtuoGl+d9syEmUCIsLLUJ8tfWtcRmY/txAhHNWa20?=
 =?us-ascii?q?vsPM2?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALsWrpKpBNi6OyCv3wrlXmZ4aV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913260"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 45DE34D169C9;
        Thu, 27 Jan 2022 20:41:01 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:01 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:40:58 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 2/9] mm: factor helpers for memory_failure_dev_pagemap
Date:   Thu, 27 Jan 2022 20:40:51 +0800
Message-ID: <20220127124058.1172422-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 45DE34D169C9.A2AFD
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

memory_failure_dev_pagemap code is a bit complex before introduce RMAP
feature for fsdax.  So it is needed to factor some helper functions to
simplify these code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/memory-failure.c | 141 ++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 14ae5c18e776..98b6144e4b9b 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1500,6 +1500,80 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 	return 0;
 }
 
+static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
+		struct address_space *mapping, pgoff_t index, int flags)
+{
+	struct to_kill *tk;
+	unsigned long size = 0;
+
+	list_for_each_entry(tk, to_kill, nd)
+		if (tk->size_shift)
+			size = max(size, 1UL << tk->size_shift);
+
+	if (size) {
+		/*
+		 * Unmap the largest mapping to avoid breaking up device-dax
+		 * mappings which are constant size. The actual size of the
+		 * mapping being torn down is communicated in siginfo, see
+		 * kill_proc()
+		 */
+		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
+
+		unmap_mapping_range(mapping, start, size, 0);
+	}
+
+	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
+}
+
+static int mf_generic_kill_procs(unsigned long long pfn, int flags,
+		struct dev_pagemap *pgmap)
+{
+	struct page *page = pfn_to_page(pfn);
+	LIST_HEAD(to_kill);
+	dax_entry_t cookie;
+
+	/*
+	 * Prevent the inode from being freed while we are interrogating
+	 * the address_space, typically this would be handled by
+	 * lock_page(), but dax pages do not use the page lock. This
+	 * also prevents changes to the mapping of this pfn until
+	 * poison signaling is complete.
+	 */
+	cookie = dax_lock_page(page);
+	if (!cookie)
+		return -EBUSY;
+
+	if (hwpoison_filter(page))
+		return 0;
+
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+		/*
+		 * TODO: Handle HMM pages which may need coordination
+		 * with device-side memory.
+		 */
+		return -EBUSY;
+	}
+
+	/*
+	 * Use this flag as an indication that the dax page has been
+	 * remapped UC to prevent speculative consumption of poison.
+	 */
+	SetPageHWPoison(page);
+
+	/*
+	 * Unlike System-RAM there is no possibility to swap in a
+	 * different physical page at a given virtual address, so all
+	 * userspace consumption of ZONE_DEVICE memory necessitates
+	 * SIGBUS (i.e. MF_MUST_KILL)
+	 */
+	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
+	collect_procs(page, &to_kill, true);
+
+	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
+	dax_unlock_page(page, cookie);
+	return 0;
+}
+
 static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
@@ -1576,12 +1650,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	unsigned long size = 0;
-	struct to_kill *tk;
 	LIST_HEAD(tokill);
-	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
+	int rc = -ENXIO;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1590,67 +1660,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		put_page(page);
 
 	/* device metadata space is not recoverable */
-	if (!pgmap_pfn_valid(pgmap, pfn)) {
-		rc = -ENXIO;
-		goto out;
-	}
-
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
+	if (!pgmap_pfn_valid(pgmap, pfn))
 		goto out;
 
-	if (hwpoison_filter(page)) {
-		rc = 0;
-		goto unlock;
-	}
-
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
-		/*
-		 * TODO: Handle HMM pages which may need coordination
-		 * with device-side memory.
-		 */
-		goto unlock;
-	}
-
-	/*
-	 * Use this flag as an indication that the dax page has been
-	 * remapped UC to prevent speculative consumption of poison.
-	 */
-	SetPageHWPoison(page);
-
-	/*
-	 * Unlike System-RAM there is no possibility to swap in a
-	 * different physical page at a given virtual address, so all
-	 * userspace consumption of ZONE_DEVICE memory necessitates
-	 * SIGBUS (i.e. MF_MUST_KILL)
-	 */
-	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &tokill, flags & MF_ACTION_REQUIRED);
-
-	list_for_each_entry(tk, &tokill, nd)
-		if (tk->size_shift)
-			size = max(size, 1UL << tk->size_shift);
-	if (size) {
-		/*
-		 * Unmap the largest mapping to avoid breaking up
-		 * device-dax mappings which are constant size. The
-		 * actual size of the mapping being torn down is
-		 * communicated in siginfo, see kill_proc()
-		 */
-		start = (page->index << PAGE_SHIFT) & ~(size - 1);
-		unmap_mapping_range(page->mapping, start, size, 0);
-	}
-	kill_procs(&tokill, flags & MF_MUST_KILL, false, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+	rc = mf_generic_kill_procs(pfn, flags, pgmap);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.34.1



