Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4FC3DB55D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbhG3IxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:53:16 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34388 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238122AbhG3IxO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:53:14 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQu22SKF0hAUbXW//pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620662400"; 
   d="scan'208";a="112070584"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jul 2021 16:53:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 6485B4D0D4A1;
        Fri, 30 Jul 2021 16:53:02 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 30 Jul 2021 16:53:04 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 30 Jul 2021 16:53:01 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <djwong@kernel.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <agk@redhat.com>,
        <snitzer@redhat.com>
Subject: [PATCH v6 3/9] mm: factor helpers for memory_failure_dev_pagemap
Date:   Fri, 30 Jul 2021 16:52:39 +0800
Message-ID: <20210730085245.3069812-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
References: <20210730085245.3069812-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6485B4D0D4A1.AF624
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
---
 mm/memory-failure.c | 101 +++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index eefd823deb67..3bdfcb45f66e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1423,6 +1423,60 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
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
+static int mf_generic_kill_procs(unsigned long long pfn, int flags)
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
@@ -1512,13 +1566,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
 	struct page *page = pfn_to_page(pfn);
-	const bool unmap_success = true;
-	unsigned long size = 0;
-	struct to_kill *tk;
 	LIST_HEAD(tokill);
 	int rc = -EBUSY;
-	loff_t start;
-	dax_entry_t cookie;
 
 	if (flags & MF_COUNT_INCREASED)
 		/*
@@ -1532,20 +1581,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		goto out;
 	}
 
-	/*
-	 * Prevent the inode from being freed while we are interrogating
-	 * the address_space, typically this would be handled by
-	 * lock_page(), but dax pages do not use the page lock. This
-	 * also prevents changes to the mapping of this pfn until
-	 * poison signaling is complete.
-	 */
-	cookie = dax_lock_page(page);
-	if (!cookie)
-		goto out;
-
 	if (hwpoison_filter(page)) {
 		rc = 0;
-		goto unlock;
+		goto out;
 	}
 
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
@@ -1553,7 +1591,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 		 * TODO: Handle HMM pages which may need coordination
 		 * with device-side memory.
 		 */
-		goto unlock;
+		goto out;
 	}
 
 	/*
@@ -1562,32 +1600,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	 */
 	SetPageHWPoison(page);
 
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
-	kill_procs(&tokill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
-	rc = 0;
-unlock:
-	dax_unlock_page(page, cookie);
+	mf_generic_kill_procs(pfn, flags);
 out:
 	/* drop pgmap ref acquired in caller */
 	put_dev_pagemap(pgmap);
-- 
2.32.0



