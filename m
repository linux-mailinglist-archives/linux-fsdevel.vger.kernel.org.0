Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD785FF744
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJNX5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJNX5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:57:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2609AA3AA0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791865; x=1697327865;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRBEo+va9LdTaMALBHzem55il8qhSDS6I2rVZ6WlqEM=;
  b=aWEe+rGGKrom9/vSW2Kxk1rUPIlUE0VC86ZWruKrLcN9Kyv+oGBgEPlH
   CRezIZbe3UX3SvU/XHbE5hf46DjQBwXcENyKCHEbwZVKLIlZT8LubTygq
   OBPEqykXbr7pibAG2SwIbfL20FiaIzRMiyXtj5EbID58ySyTMwiRZloDC
   NVVzToIB1NBF1haShYefrqtCh3nfPvL9JaNEtXVjqMRuXBrGGegJd3epS
   Gp44Fwo1WkaW0IssXLrw7PeJ9br4sSTwr9RZCDgBuH79fJ+48yQYFrjYI
   pKvOVevajxaBqGzNR2Coo/TdkdRq2xve3TKttpZytPQYCwmZvDXvRbztI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="369693752"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="369693752"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113300"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113300"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:43 -0700
Subject: [PATCH v3 08/25] fsdax: Update dax_insert_entry() calling
 convention to return an error
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:43 -0700
Message-ID: <166579186334.2236710.388332274317019999.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for teaching dax_insert_entry() to take live @pgmap
references, enable it to return errors. Given the observation that all
callers overwrite the passed in entry with the return value, just update
@entry in place and convert the return code to a vm_fault_t status.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6990a6e7df9f..1f6c1abfe0c9 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -907,14 +907,15 @@ static bool dax_fault_is_cow(const struct iomap_iter *iter)
  * already in the tree, we will skip the insertion and just dirty the PMD as
  * appropriate.
  */
-static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap_iter *iter, void *entry, pfn_t pfn,
-		unsigned long flags)
+static vm_fault_t dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
+				   const struct iomap_iter *iter, void **pentry,
+				   pfn_t pfn, unsigned long flags)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
 	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
 	bool cow = dax_fault_is_cow(iter);
+	void *entry = *pentry;
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
@@ -960,7 +961,9 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
 
 	xas_unlock_irq(xas);
-	return entry;
+
+	*pentry = entry;
+	return 0;
 }
 
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
@@ -1206,9 +1209,12 @@ static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, DAX_ZERO_PAGE);
+	if (ret)
+		goto out;
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
+out:
 	trace_dax_load_hole(inode, vmf, ret);
 	return ret;
 }
@@ -1225,6 +1231,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	struct page *zero_page;
 	spinlock_t *ptl;
 	pmd_t pmd_entry;
+	vm_fault_t ret;
 	pfn_t pfn;
 
 	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
@@ -1233,8 +1240,10 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
-				  DAX_PMD | DAX_ZERO_PAGE);
+	ret = dax_insert_entry(xas, vmf, iter, entry, pfn,
+			       DAX_PMD | DAX_ZERO_PAGE);
+	if (ret)
+		return ret;
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1587,6 +1596,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0, id;
+	vm_fault_t ret;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1613,8 +1623,10 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 	}
 
-	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
+	ret = dax_insert_entry(xas, vmf, iter, entry, pfn, entry_flags);
 	dax_read_unlock(id);
+	if (ret)
+		return ret;
 
 	if (write &&
 	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {

