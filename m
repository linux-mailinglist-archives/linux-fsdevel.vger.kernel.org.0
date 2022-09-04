Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2645AC206
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Sep 2022 04:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIDCQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 22:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDCQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 22:16:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA84E840
        for <linux-fsdevel@vger.kernel.org>; Sat,  3 Sep 2022 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662257797; x=1693793797;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EnM0U6h0FiH1zuPhxkY+qtc5p+6YtcYvmyrCE3m68d8=;
  b=O0ONI5RcpYrhw+DP3QN2oXIdexknneA21JCUDUFxlKuZaeK/5WEts5Qa
   KIZ1IR9Evzq1USLnWprsSp7y39tOa4s1IrZ8cOxyNqASg5p1unH3ND0UP
   R88kymxZN+lXh4zwvBcQr/36mtLOLc9QHnTKF9PKR7F5vvixcri6P/5S9
   MLaXM8wpE9qUTWMtq/g09OhIP4npGSBWYrXKU22Y5yw7a7LrZnETPywH1
   0yKttFeaQ2m2vqA2+PjX1p4m2dM3ZUgnbsvn7VnG2mdA8g87xAGyIVP4h
   XwH/cQ/sxZEIAJRQbx2h9fy8txm8vZdUbDR2wGvoJUsUD0Yo+ZU0uWBC9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="283194044"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="283194044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="681682267"
Received: from pg4-mobl3.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.132.198])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 19:16:35 -0700
Subject: [PATCH 06/13] fsdax: Rework dax_insert_entry() calling convention
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org
Date:   Sat, 03 Sep 2022 19:16:34 -0700
Message-ID: <166225779478.2351842.2371440980289644924.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
References: <166225775968.2351842.11156458342486082012.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the determination of @dirty and @cow in dax_insert_entry() to flags
(DAX_DIRTY and DAX_COW) that are passed in. This allows the iomap
related code to remain fs/dax.c in preparation for the Xarray
infrastructure to move to drivers/dax/mapping.c.

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
index fad1c8a1d913..65d55c5ecdef 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -75,11 +75,19 @@ fs_initcall(init_dax_wait_table);
  * block allocation.
  */
 #define DAX_SHIFT	(4)
+#define DAX_MASK	((1UL << DAX_SHIFT) - 1)
 #define DAX_LOCKED	(1UL << 0)
 #define DAX_PMD		(1UL << 1)
 #define DAX_ZERO_PAGE	(1UL << 2)
 #define DAX_EMPTY	(1UL << 3)
 
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
@@ -87,7 +95,8 @@ static unsigned long dax_to_pfn(void *entry)
 
 static void *dax_make_entry(pfn_t pfn, unsigned long flags)
 {
-	return xa_mk_value(flags | (pfn_t_to_pfn(pfn) << DAX_SHIFT));
+	return xa_mk_value((flags & DAX_MASK) |
+			   (pfn_t_to_pfn(pfn) << DAX_SHIFT));
 }
 
 static bool dax_is_locked(void *entry)
@@ -846,6 +855,20 @@ static bool dax_fault_is_cow(const struct iomap_iter *iter)
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
@@ -854,13 +877,13 @@ static bool dax_fault_is_cow(const struct iomap_iter *iter)
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
 
 	if (dirty)
@@ -1155,7 +1178,8 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       DAX_ZERO_PAGE | dax_iter_flags(iter, vmf));
 	if (ret)
 		goto out;
 
@@ -1186,8 +1210,9 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn,
-			       DAX_PMD | DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       DAX_PMD | DAX_ZERO_PAGE |
+				       dax_iter_flags(iter, vmf));
 	if (ret)
 		return ret;
 
@@ -1566,7 +1591,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, entry_flags);
+	ret = dax_insert_entry(xas, vmf, entry, pfn,
+			       entry_flags | dax_iter_flags(iter, vmf));
 	if (ret)
 		return ret;
 

