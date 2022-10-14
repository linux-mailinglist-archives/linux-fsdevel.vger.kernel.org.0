Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F35FF74A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Oct 2022 01:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNX6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJNX6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:58:13 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82042C97D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Oct 2022 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665791887; x=1697327887;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yd85VDxCtKyxeZdpNqoca3KmUlvyPqntXffUSxCk3NA=;
  b=XgtHRTLXJk04WrAZdccuKFQVVG2xaffHb+hhpZ1IrcKy6AGXYtm/g7fI
   C9U0Xu1qmtkVsKU3m7bvPNXa4w5rPAykzkj65JLOikeZ/S1VVDkYu79Y6
   qHda8qsdK8Qxr/jlScQjHvAqzRIjQg+oXQXNYFIcQNN6iqEScI6NJ3mBg
   G7XcoGcswJW66d0AsisiGPraMnEErs8N41jID/OIH15borLGonUumSLIC
   +WNG5r0DJLkHL0Ua8xRXu4pYIODNE70+7tgezPAqpOCgAAaXgEOzdba+1
   QbYcGfWZxV79KddoDb6jjcGiCo65kXLJVWZwalYDlsricsKa2UMXhE+o3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="367523109"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="367523109"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="630113270"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="630113270"
Received: from uyoon-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.90.112])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 16:57:37 -0700
Subject: [PATCH v3 07/25] fsdax: Hold dax lock over mapping insertion
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, david@fromorbit.com,
        nvdimm@lists.linux.dev, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 14 Oct 2022 16:57:37 -0700
Message-ID: <166579185727.2236710.8711235794537270051.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for dax_insert_entry() to start taking page and pgmap
references ensure that page->pgmap is valid by holding the
dax_read_lock() over both dax_direct_access() and dax_insert_entry().

I.e. the code that wants to elevate the reference count of a pgmap page
from 0 -> 1 must ensure that the pgmap is not exiting and will not start
exiting until the proper references have been taken.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/dax.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1d4f0072e58d..6990a6e7df9f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1107,10 +1107,9 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 		size_t size, void **kaddr, pfn_t *pfnp)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
-	int id, rc = 0;
 	long length;
+	int rc = 0;
 
-	id = dax_read_lock();
 	length = dax_direct_access(iomap->dax_dev, pgoff, PHYS_PFN(size),
 				   DAX_ACCESS, kaddr, pfnp);
 	if (length < 0) {
@@ -1135,7 +1134,6 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	if (!*kaddr)
 		rc = -EFAULT;
 out:
-	dax_read_unlock(id);
 	return rc;
 }
 
@@ -1588,7 +1586,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
-	int err = 0;
+	int err = 0, id;
 	pfn_t pfn;
 	void *kaddr;
 
@@ -1608,11 +1606,15 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
+	id = dax_read_lock();
 	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
-	if (err)
+	if (err) {
+		dax_read_unlock(id);
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
+	}
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
+	dax_read_unlock(id);
 
 	if (write &&
 	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {

