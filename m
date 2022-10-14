Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4696D5FF74D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJNX6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJNX6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82358D0194
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791887; x=1697327887;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MBvS7Cxj+AIc8d1loS44lpMvVCT4iCj1AXq9hKJEVYM=;
  b=KE9L+FmpCKMFSXeokuIwW4MQyRR/dtzZUcot851uXCPKmdGxt6+whCdJ
   Xo0OrBaCNdtm6S5HhxSA8jdpdbYhU7jI/z5LMnhV1K+fIxyeNGKAsTpu/
   0WLdQEnsNmZZb5uY8JfnEB1ZRaMJLtCRnulYfd+FYbiujLcvkiVBoX9Mq
   PNzht2d39KeP8XKt74n+eqEvalNHVaH0pQ2SBmMIkBygWPFAmt2hGWLzu
   yY94hxly8WTRMbZOwkQqHbsynmtteK/V+ZIZdkg3kY9XRvM/e4FU5fjyx
   S1MYxkXIerdCpmLGhdlJ9fL57pihuY/aicRcnX6uISccWVZh3q3KnwfEm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="367523181"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="367523181"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113365"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113365"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:58:02 -0700
Subject: [PATCH v3 11/25] fsdax: Rework dax_insert_entry() calling convention
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:58:01 -0700
Message-ID: <166579188180.2236710.6959794790871279054.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
References: <166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com>
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

Move the determination of @dirty and @cow in dax_insert_entry() to flags
(DAX_DIRTY and DAX_COW) that are passed in. This allows
dax_insert_entry() to not require a 'struct iomap' which is a
pre-requisitie for reusing dax_insert_entry() for device-dax.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 095c9d7b4a1d..73e510ca5a70 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -75,12 +75,20 @@ fs_initcall(init_dax_wait_table);
  * block allocation.
  */
 #define DAX_SHIFT	(5)
+#define DAX_MASK	((1UL << DAX_SHIFT) - 1)
 #define DAX_LOCKED	(1UL << 0)
 #define DAX_PMD		(1UL << 1)
 #define DAX_ZERO_PAGE	(1UL << 2)
 #define DAX_EMPTY	(1UL << 3)
 #define DAX_ZAP		(1UL << 4)
 
+/*
+ * These flags are not conveyed in Xarray value entries, they are just
+ * modifiers to dax_insert_entry().
+ */
+#define DAX_DIRTY (1UL << (DAX_SHIFT + 0))
+#define DAX_COW   (1UL << (DAX_SHIFT + 1))
+
 static unsigned long dax_to_pfn(void *entry)
 {
 	return xa_to_value(entry) >> DAX_SHIFT;
@@ -88,7 +96,8 @@ static unsigned long dax_to_pfn(void *entry)
 
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value((flags & DAX_MASK) |
+			   (pfn_t_to_pfn(pfn) << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -932,6 +941,20 @@ static bool dax_fault_is_cow(const struct iomap_iter *iter)
 		(iter->iomap.flags & IOMAP_F_SHARED);
 }
 
+static unsigned long dax_iter_flags(const struct iomap_iter *iter,
+				    struct vm_fault *vmf)
+{
+	unsigned long flags = 0;
+
+	if (!dax_fault_is_synchronous(iter, vmf->vma))
+		flags |= DAX_DIRTY;
+
+	if (dax_fault_is_cow(iter))
+		flags |= DAX_COW;
+
+	return flags;
+}
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -940,13 +963,13 @@ static bool dax_fault_is_cow(const struct iomap_iter *iter)
  * appropriate.
  */
 static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-				   const struct iomap_iter *iter, void **pentry,
-				   pfn_t pfn, unsigned long flags)
+				   void **pentry, pfn_t pfn,
+				   unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
-	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
-	bool cow = dax_fault_is_cow(iter);
+	bool dirty = flags & DAX_DIRTY;
+	bool cow = flags & DAX_COW;
 	void *entry = *pentry;
 	vm_fault_t ret = 0;
 
@@ -1245,7 +1268,8 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       DAX_ZERO_PAGE | dax_iter_flags(iter, vmf));
 	if (ret)
 		goto out;
 
@@ -1276,8 +1300,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn,
-			       DAX_PMD | DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       DAX_PMD | DAX_ZERO_PAGE |
+				       dax_iter_flags(iter, vmf));
 	if (ret)
 		return ret;
 
@@ -1659,7 +1684,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 	}
 
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, entry_flags);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       entry_flags | dax_iter_flags(iter, vmf));
 	dax_read_unlock(id);
 	if (ret)
 		return ret;

