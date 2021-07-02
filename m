Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4071E3B9E1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 11:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhGBJ0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 05:26:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2107 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231285AbhGBJ0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 05:26:38 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATAgGmqHrrfRX+8I3pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.83,316,1616428800"; 
   d="scan'208";a="110542296"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Jul 2021 17:24:05 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4692A4C369E8;
        Fri,  2 Jul 2021 17:24:00 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 2 Jul 2021 17:24:01 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 2 Jul 2021 17:24:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <hch@lst.de>, <riteshh@linux.ibm.com>
Subject: [RESEND PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Date:   Fri, 2 Jul 2021 17:23:55 +0800
Message-ID: <20210702092357.262744-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702092357.262744-1-ruansy.fnst@fujitsu.com>
References: <20210702092357.262744-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4692A4C369E8.A06E0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dax page fault code is too long and a bit difficult to read. And it
is hard to understand when we trying to add new features. Some of the
PTE/PMD codes have similar logic. So, factor them as helper functions to
simplify the code.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 153 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 69 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 62352cbcf0f4..1fdd0b8dca0a 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1255,6 +1255,53 @@ static bool dax_fault_is_synchronous(unsigned long flags,
 		&& (iomap->flags & IOMAP_F_DIRTY);
 }
 
+/*
+ * If we are doing synchronous page fault and inode needs fsync, we can insert
+ * PTE/PMD into page tables only after that happens. Skip insertion for now and
+ * return the pfn so that caller can insert it after fsync is done.
+ */
+static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
+{
+	if (WARN_ON_ONCE(!pfnp))
+		return VM_FAULT_SIGBUS;
+
+	*pfnp = pfn;
+	return VM_FAULT_NEEDDSYNC;
+}
+
+static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
+		loff_t pos)
+{
+	int error = 0;
+	vm_fault_t ret;
+	unsigned long vaddr = vmf->address;
+	sector_t sector = dax_iomap_sector(iomap, pos);
+
+	switch (iomap->type) {
+	case IOMAP_HOLE:
+	case IOMAP_UNWRITTEN:
+		clear_user_highpage(vmf->cow_page, vaddr);
+		break;
+	case IOMAP_MAPPED:
+		error = copy_cow_page_dax(iomap->bdev, iomap->dax_dev,
+						sector, vmf->cow_page, vaddr);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		error = -EIO;
+		break;
+	}
+
+	if (error)
+		return dax_fault_return(error);
+
+	__SetPageUptodate(vmf->cow_page);
+	ret = finish_fault(vmf);
+	if (!ret)
+		ret = VM_FAULT_DONE_COW;
+	return ret;
+}
+
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
@@ -1323,30 +1370,7 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	}
 
 	if (vmf->cow_page) {
-		sector_t sector = dax_iomap_sector(&iomap, pos);
-
-		switch (iomap.type) {
-		case IOMAP_HOLE:
-		case IOMAP_UNWRITTEN:
-			clear_user_highpage(vmf->cow_page, vaddr);
-			break;
-		case IOMAP_MAPPED:
-			error = copy_cow_page_dax(iomap.bdev, iomap.dax_dev,
-						  sector, vmf->cow_page, vaddr);
-			break;
-		default:
-			WARN_ON_ONCE(1);
-			error = -EIO;
-			break;
-		}
-
-		if (error)
-			goto error_finish_iomap;
-
-		__SetPageUptodate(vmf->cow_page);
-		ret = finish_fault(vmf);
-		if (!ret)
-			ret = VM_FAULT_DONE_COW;
+		ret = dax_fault_cow_page(vmf, &iomap, pos);
 		goto finish_iomap;
 	}
 
@@ -1366,19 +1390,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
 						 0, write && !sync);
 
-		/*
-		 * If we are doing synchronous page fault and inode needs fsync,
-		 * we can insert PTE into page tables only after that happens.
-		 * Skip insertion for now and return the pfn so that caller can
-		 * insert it after fsync is done.
-		 */
 		if (sync) {
-			if (WARN_ON_ONCE(!pfnp)) {
-				error = -EIO;
-				goto error_finish_iomap;
-			}
-			*pfnp = pfn;
-			ret = VM_FAULT_NEEDDSYNC | major;
+			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
 			goto finish_iomap;
 		}
 		trace_dax_insert_mapping(inode, vmf, entry);
@@ -1477,13 +1490,45 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 	return VM_FAULT_FALLBACK;
 }
 
+static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
+		pgoff_t max_pgoff)
+{
+	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+
+	/*
+	 * Make sure that the faulting address's PMD offset (color) matches
+	 * the PMD offset from the start of the file.  This is necessary so
+	 * that a PMD range in the page table overlaps exactly with a PMD
+	 * range in the page cache.
+	 */
+	if ((vmf->pgoff & PG_PMD_COLOUR) !=
+	    ((vmf->address >> PAGE_SHIFT) & PG_PMD_COLOUR))
+		return true;
+
+	/* Fall back to PTEs if we're going to COW */
+	if (write && !(vmf->vma->vm_flags & VM_SHARED))
+		return true;
+
+	/* If the PMD would extend outside the VMA */
+	if (pmd_addr < vmf->vma->vm_start)
+		return true;
+	if ((pmd_addr + PMD_SIZE) > vmf->vma->vm_end)
+		return true;
+
+	/* If the PMD would extend beyond the file size */
+	if ((xas->xa_index | PG_PMD_COLOUR) >= max_pgoff)
+		return true;
+
+	return false;
+}
+
 static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			       const struct iomap_ops *ops)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool sync;
 	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
@@ -1506,33 +1551,12 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 
 	trace_dax_pmd_fault(inode, vmf, max_pgoff, 0);
 
-	/*
-	 * Make sure that the faulting address's PMD offset (color) matches
-	 * the PMD offset from the start of the file.  This is necessary so
-	 * that a PMD range in the page table overlaps exactly with a PMD
-	 * range in the page cache.
-	 */
-	if ((vmf->pgoff & PG_PMD_COLOUR) !=
-	    ((vmf->address >> PAGE_SHIFT) & PG_PMD_COLOUR))
-		goto fallback;
-
-	/* Fall back to PTEs if we're going to COW */
-	if (write && !(vma->vm_flags & VM_SHARED))
-		goto fallback;
-
-	/* If the PMD would extend outside the VMA */
-	if (pmd_addr < vma->vm_start)
-		goto fallback;
-	if ((pmd_addr + PMD_SIZE) > vma->vm_end)
-		goto fallback;
-
 	if (xas.xa_index >= max_pgoff) {
 		result = VM_FAULT_SIGBUS;
 		goto out;
 	}
 
-	/* If the PMD would extend beyond the file size */
-	if ((xas.xa_index | PG_PMD_COLOUR) >= max_pgoff)
+	if (dax_fault_check_fallback(vmf, &xas, max_pgoff))
 		goto fallback;
 
 	/*
@@ -1584,17 +1608,8 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
 						DAX_PMD, write && !sync);
 
-		/*
-		 * If we are doing synchronous page fault and inode needs fsync,
-		 * we can insert PMD into page tables only after that happens.
-		 * Skip insertion for now and return the pfn so that caller can
-		 * insert it after fsync is done.
-		 */
 		if (sync) {
-			if (WARN_ON_ONCE(!pfnp))
-				goto finish_iomap;
-			*pfnp = pfn;
-			result = VM_FAULT_NEEDDSYNC;
+			result = dax_fault_synchronous_pfnp(pfnp, pfn);
 			goto finish_iomap;
 		}
 
-- 
2.32.0



