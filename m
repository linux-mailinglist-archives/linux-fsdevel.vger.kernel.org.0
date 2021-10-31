Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BDE440F1A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Oct 2021 16:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJaPYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Oct 2021 11:24:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24386 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230409AbhJaPYE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Oct 2021 11:24:04 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Ae9Apf67tO1ATjGDKYUXl0gxRtFPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShWQAmGEfWzvUb6vfMGH9KtgnPYm090MO6MDXn9NgTQQ5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9bdANkVEmjfvRH+KnUba?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeCbh7pzLlhSun3zEhq8G4FsNFYER5Od7KW9?=
 =?us-ascii?q?U8vkfMjoMclaIgOfe6LKwSsFtgMo5JcXmNY9ZvWtvpRnVBPBgQ9bcQqHO5NZdx?=
 =?us-ascii?q?x8xgNxDGbDVYM9xQTZtcxPGbDVMN00RBZZ4m/2n7lH7cjtFuBeQoII0/WHYz0p?=
 =?us-ascii?q?2yreFGNzLdt2PQO1Rn12EvSTC/mLkElcWOcL34TiM9H/qje/StSThUYkWGfuz8?=
 =?us-ascii?q?fsCqFmSwHEDTRMNWValrP2RlEGzQZRcJlYS9y5oqrI9nGSvT9/gT1i7rWSCsxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJk2utQeWzMnzBmKksnvCDgpt6eaIU9xX?=
 =?us-ascii?q?J/8QSiaYHBTdDFdI3RfC1Zt3jUqm6lr5jqnczqpOPLdYgXJJAzN?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A5EirjaiuCW+F451mwdZbVwy6D3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.87,197,1631548800"; 
   d="scan'208";a="116678011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Oct 2021 23:21:11 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 4CF1C4D0F90F;
        Sun, 31 Oct 2021 23:21:09 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 31 Oct 2021 23:21:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 31 Oct 2021 23:20:57 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 8/8] fsdax: add exception for reflinked files
Date:   Sun, 31 Oct 2021 23:20:28 +0800
Message-ID: <20211031152028.3724121-9-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
References: <20211031152028.3724121-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4CF1C4D0F90F.A4FE0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For reflinked files, one dax page may be associated more than once with
different fime mapping and index.  It will report warning.  Now, since
we have introduced dax-RMAP for this case and also have to keep its
functionality for other filesystems who are not support rmap, we add a
is cow flag, which is set true when it is CoW operation, for reflink
case.  Normal cases work as before.

We will get the cow flag in the dax-reflink(v10) patchset.  So, always
set false here for now.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 7e46569c6129..bc269852d91a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -340,7 +340,7 @@ static unsigned long dax_end_pfn(void *entry)
  * offsets.
  */
 static void dax_associate_entry(void *entry, struct address_space *mapping,
-		struct vm_area_struct *vma, unsigned long address)
+		struct vm_area_struct *vma, unsigned long address, bool cow)
 {
 	unsigned long size = dax_entry_size(entry), pfn, index;
 	int i = 0;
@@ -352,14 +352,21 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
+		if (cow) {
+			if (!page->mapping) {
+				page->mapping = mapping;
+				page->index = index + i++;
+			}
+		} else {
+			WARN_ON_ONCE(page->mapping);
+			page->mapping = mapping;
+			page->index = index + i++;
+		}
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+		bool trunc, bool cow)
 {
 	unsigned long pfn;
 
@@ -370,9 +377,16 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
+		if (cow) {
+			if (page->mapping == mapping) {
+				page->mapping = NULL;
+				page->index = 0;
+			}
+		} else {
+			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
+			page->mapping = NULL;
+			page->index = 0;
+		}
 	}
 }
 
@@ -597,7 +611,7 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
+		dax_disassociate_entry(entry, mapping, false, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, WAKE_ALL);
 		mapping->nrpages -= PG_PMD_NR;
@@ -734,7 +748,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
+	dax_disassociate_entry(entry, mapping, trunc, false);
 	xas_store(&xas, NULL);
 	mapping->nrpages -= 1UL << dax_entry_order(entry);
 	ret = 1;
@@ -827,8 +841,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
-		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
+		dax_disassociate_entry(entry, mapping, false, false);
+		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
+				false);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
-- 
2.33.0



