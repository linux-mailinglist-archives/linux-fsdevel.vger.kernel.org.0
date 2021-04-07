Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E875E356D79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbhDGNi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 09:38:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:46708 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344743AbhDGNiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:38:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ap7OVk6v2CUM0Vi0QRqMvF4j97skDltV00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le6A/shF8qKRUdsP2jGI3Fe3PT8pZp/ZIcVI3OYCDKsH?=
 =?us-ascii?q?alRbsN0aLMzzHsECX19Kp8+M5bGZRWJ8b3CTFB7PrSxCmdP5IezMKc8Kau7N2u?=
 =?us-ascii?q?qktFaQ1xcalv40NYJ2+gYy5LbTJLD5Y4C5aQj/Avz1WdUE4KZce2DGRtZZmgm/?=
 =?us-ascii?q?T3kvvdASIuNloO7QmiqXeS4qfmLh7w5HwjegIK7bA80WWtqWDE2pk=3D?=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="106746640"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 07 Apr 2021 21:38:43 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 307DC4D0B8A2;
        Wed,  7 Apr 2021 21:38:41 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 7 Apr 2021 21:38:35 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 7 Apr 2021 21:38:28 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <david@fromorbit.com>, <hch@lst.de>,
        <rgoldwyn@suse.de>, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v2 2/3] fsdax: Factor helper: dax_fault_actor()
Date:   Wed, 7 Apr 2021 21:38:22 +0800
Message-ID: <20210407133823.828176-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 307DC4D0B8A2.A3951
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The core logic in the two dax page fault functions is similar. So, move
the logic into a common helper function. Also, to facilitate the
addition of new features, such as CoW, switch-case is no longer used to
handle different iomap types.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/dax.c | 294 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 148 insertions(+), 146 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index f843fb8fbbf1..6dea1fc11b46 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1054,6 +1054,66 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 	return ret;
 }
 
+#ifdef CONFIG_FS_DAX_PMD
+static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
+		struct iomap *iomap, void **entry)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	unsigned long pmd_addr = vmf->address & PMD_MASK;
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = mapping->host;
+	pgtable_t pgtable = NULL;
+	struct page *zero_page;
+	spinlock_t *ptl;
+	pmd_t pmd_entry;
+	pfn_t pfn;
+
+	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
+
+	if (unlikely(!zero_page))
+		goto fallback;
+
+	pfn = page_to_pfn_t(zero_page);
+	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
+			DAX_PMD | DAX_ZERO_PAGE, false);
+
+	if (arch_needs_pgtable_deposit()) {
+		pgtable = pte_alloc_one(vma->vm_mm);
+		if (!pgtable)
+			return VM_FAULT_OOM;
+	}
+
+	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
+	if (!pmd_none(*(vmf->pmd))) {
+		spin_unlock(ptl);
+		goto fallback;
+	}
+
+	if (pgtable) {
+		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		mm_inc_nr_ptes(vma->vm_mm);
+	}
+	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
+	pmd_entry = pmd_mkhuge(pmd_entry);
+	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
+	spin_unlock(ptl);
+	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
+	return VM_FAULT_NOPAGE;
+
+fallback:
+	if (pgtable)
+		pte_free(vma->vm_mm, pgtable);
+	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
+	return VM_FAULT_FALLBACK;
+}
+#else
+static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
+		struct iomap *iomap, void **entry)
+{
+	return VM_FAULT_FALLBACK;
+}
+#endif /* CONFIG_FS_DAX_PMD */
+
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
@@ -1291,6 +1351,64 @@ static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
 	return ret;
 }
 
+/**
+ * dax_fault_actor - Common actor to handle pfn insertion in PTE/PMD fault.
+ * @vmf:	vm fault instance
+ * @pfnp:	pfn to be returned
+ * @xas:	the dax mapping tree of a file
+ * @entry:	an unlocked dax entry to be inserted
+ * @pmd:	distinguish whether it is a pmd fault
+ * @flags:	iomap flags
+ * @iomap:	from iomap_begin()
+ * @srcmap:	from iomap_begin(), not equal to iomap if it is a CoW
+ */
+static vm_fault_t dax_fault_actor(struct vm_fault *vmf, pfn_t *pfnp,
+		struct xa_state *xas, void **entry, bool pmd,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
+	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
+	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
+	bool write = vmf->flags & FAULT_FLAG_WRITE;
+	bool sync = dax_fault_is_synchronous(flags, vmf->vma, iomap);
+	unsigned long entry_flags = pmd ? DAX_PMD : 0;
+	int err = 0;
+	pfn_t pfn;
+
+	/* if we are reading UNWRITTEN and HOLE, return a hole. */
+	if (!write &&
+	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
+		if (!pmd)
+			return dax_load_hole(xas, mapping, entry, vmf);
+		else
+			return dax_pmd_load_hole(xas, vmf, iomap, entry);
+	}
+
+	if (iomap->type != IOMAP_MAPPED) {
+		WARN_ON_ONCE(1);
+		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
+	}
+
+	err = dax_iomap_pfn(iomap, pos, size, &pfn);
+	if (err)
+		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
+
+	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
+				  write && !sync);
+
+	if (sync)
+		return dax_fault_synchronous_pfnp(pfnp, pfn);
+
+	/* insert PMD pfn */
+	if (pmd)
+		return vmf_insert_pfn_pmd(vmf, pfn, write);
+
+	/* insert PTE pfn */
+	if (write)
+		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
+	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);
+}
+
 static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 			       int *iomap_errp, const struct iomap_ops *ops)
 {
@@ -1298,17 +1416,14 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	XA_STATE(xas, &mapping->i_pages, vmf->pgoff);
 	struct inode *inode = mapping->host;
-	unsigned long vaddr = vmf->address;
 	loff_t pos = (loff_t)vmf->pgoff << PAGE_SHIFT;
 	struct iomap iomap = { .type = IOMAP_HOLE };
 	struct iomap srcmap = { .type = IOMAP_HOLE };
 	unsigned flags = IOMAP_FAULT;
 	int error, major = 0;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool sync;
 	vm_fault_t ret = 0;
 	void *entry;
-	pfn_t pfn;
 
 	trace_dax_pte_fault(inode, vmf, ret);
 	/*
@@ -1354,8 +1469,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		goto unlock_entry;
 	}
 	if (WARN_ON_ONCE(iomap.offset + iomap.length < pos + PAGE_SIZE)) {
-		error = -EIO;	/* fs corruption? */
-		goto error_finish_iomap;
+		ret = VM_FAULT_SIGBUS;	/* fs corruption? */
+		goto finish_iomap;
 	}
 
 	if (vmf->cow_page) {
@@ -1363,49 +1478,19 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		goto finish_iomap;
 	}
 
-	sync = dax_fault_is_synchronous(flags, vma, &iomap);
-
-	switch (iomap.type) {
-	case IOMAP_MAPPED:
-		if (iomap.flags & IOMAP_F_NEW) {
-			count_vm_event(PGMAJFAULT);
-			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
-			major = VM_FAULT_MAJOR;
-		}
-		error = dax_iomap_pfn(&iomap, pos, PAGE_SIZE, &pfn);
-		if (error < 0)
-			goto error_finish_iomap;
-
-		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						 0, write && !sync);
-
-		if (sync) {
-			ret = dax_fault_synchronous_pfnp(pfnp, pfn);
-			goto finish_iomap;
-		}
-		trace_dax_insert_mapping(inode, vmf, entry);
-		if (write)
-			ret = vmf_insert_mixed_mkwrite(vma, vaddr, pfn);
-		else
-			ret = vmf_insert_mixed(vma, vaddr, pfn);
-
+	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, false, flags,
+			      &iomap, &srcmap);
+	if (ret == VM_FAULT_SIGBUS)
 		goto finish_iomap;
-	case IOMAP_UNWRITTEN:
-	case IOMAP_HOLE:
-		if (!write) {
-			ret = dax_load_hole(&xas, mapping, &entry, vmf);
-			goto finish_iomap;
-		}
-		fallthrough;
-	default:
-		WARN_ON_ONCE(1);
-		error = -EIO;
-		break;
+
+	/* read/write MAPPED, CoW UNWRITTEN */
+	if (iomap.flags & IOMAP_F_NEW) {
+		count_vm_event(PGMAJFAULT);
+		count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
+		major = VM_FAULT_MAJOR;
 	}
 
- error_finish_iomap:
-	ret = dax_fault_return(error);
- finish_iomap:
+finish_iomap:
 	if (ops->iomap_end) {
 		int copied = PAGE_SIZE;
 
@@ -1419,66 +1504,14 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		 */
 		ops->iomap_end(inode, pos, PAGE_SIZE, copied, flags, &iomap);
 	}
- unlock_entry:
+unlock_entry:
 	dax_unlock_entry(&xas, entry);
- out:
+out:
 	trace_dax_pte_fault_done(inode, vmf, ret);
 	return ret | major;
 }
 
 #ifdef CONFIG_FS_DAX_PMD
-static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		struct iomap *iomap, void **entry)
-{
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	unsigned long pmd_addr = vmf->address & PMD_MASK;
-	struct vm_area_struct *vma = vmf->vma;
-	struct inode *inode = mapping->host;
-	pgtable_t pgtable = NULL;
-	struct page *zero_page;
-	spinlock_t *ptl;
-	pmd_t pmd_entry;
-	pfn_t pfn;
-
-	zero_page = mm_get_huge_zero_page(vmf->vma->vm_mm);
-
-	if (unlikely(!zero_page))
-		goto fallback;
-
-	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
-
-	if (arch_needs_pgtable_deposit()) {
-		pgtable = pte_alloc_one(vma->vm_mm);
-		if (!pgtable)
-			return VM_FAULT_OOM;
-	}
-
-	ptl = pmd_lock(vmf->vma->vm_mm, vmf->pmd);
-	if (!pmd_none(*(vmf->pmd))) {
-		spin_unlock(ptl);
-		goto fallback;
-	}
-
-	if (pgtable) {
-		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
-		mm_inc_nr_ptes(vma->vm_mm);
-	}
-	pmd_entry = mk_pmd(zero_page, vmf->vma->vm_page_prot);
-	pmd_entry = pmd_mkhuge(pmd_entry);
-	set_pmd_at(vmf->vma->vm_mm, pmd_addr, vmf->pmd, pmd_entry);
-	spin_unlock(ptl);
-	trace_dax_pmd_load_hole(inode, vmf, zero_page, *entry);
-	return VM_FAULT_NOPAGE;
-
-fallback:
-	if (pgtable)
-		pte_free(vma->vm_mm, pgtable);
-	trace_dax_pmd_load_hole_fallback(inode, vmf, zero_page, *entry);
-	return VM_FAULT_FALLBACK;
-}
-
 static bool dax_fault_check_fallback(struct vm_fault *vmf, struct xa_state *xas,
 		pgoff_t max_pgoff)
 {
@@ -1519,17 +1552,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	struct address_space *mapping = vma->vm_file->f_mapping;
 	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool sync;
-	unsigned int iomap_flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
+	unsigned int flags = (write ? IOMAP_WRITE : 0) | IOMAP_FAULT;
 	struct inode *inode = mapping->host;
-	vm_fault_t result = VM_FAULT_FALLBACK;
+	vm_fault_t ret = VM_FAULT_FALLBACK;
 	struct iomap iomap = { .type = IOMAP_HOLE };
 	struct iomap srcmap = { .type = IOMAP_HOLE };
 	pgoff_t max_pgoff;
 	void *entry;
 	loff_t pos;
 	int error;
-	pfn_t pfn;
 
 	/*
 	 * Check whether offset isn't beyond end of file now. Caller is
@@ -1541,7 +1572,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	trace_dax_pmd_fault(inode, vmf, max_pgoff, 0);
 
 	if (xas.xa_index >= max_pgoff) {
-		result = VM_FAULT_SIGBUS;
+		ret = VM_FAULT_SIGBUS;
 		goto out;
 	}
 
@@ -1556,7 +1587,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 */
 	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
 	if (xa_is_internal(entry)) {
-		result = xa_to_internal(entry);
+		ret = xa_to_internal(entry);
 		goto fallback;
 	}
 
@@ -1568,7 +1599,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 */
 	if (!pmd_none(*vmf->pmd) && !pmd_trans_huge(*vmf->pmd) &&
 			!pmd_devmap(*vmf->pmd)) {
-		result = 0;
+		ret = 0;
 		goto unlock_entry;
 	}
 
@@ -1578,49 +1609,21 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 	 * to look up our filesystem block.
 	 */
 	pos = (loff_t)xas.xa_index << PAGE_SHIFT;
-	error = ops->iomap_begin(inode, pos, PMD_SIZE, iomap_flags, &iomap,
-			&srcmap);
+	error = ops->iomap_begin(inode, pos, PMD_SIZE, flags, &iomap, &srcmap);
 	if (error)
 		goto unlock_entry;
 
 	if (iomap.offset + iomap.length < pos + PMD_SIZE)
 		goto finish_iomap;
 
-	sync = dax_fault_is_synchronous(iomap_flags, vma, &iomap);
-
-	switch (iomap.type) {
-	case IOMAP_MAPPED:
-		error = dax_iomap_pfn(&iomap, pos, PMD_SIZE, &pfn);
-		if (error < 0)
-			goto finish_iomap;
+	ret = dax_fault_actor(vmf, pfnp, &xas, &entry, true, flags,
+			      &iomap, &srcmap);
 
-		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
-						DAX_PMD, write && !sync);
-
-		if (sync) {
-			result = dax_fault_synchronous_pfnp(pfnp, pfn);
-			goto finish_iomap;
-		}
-
-		trace_dax_pmd_insert_mapping(inode, vmf, PMD_SIZE, pfn, entry);
-		result = vmf_insert_pfn_pmd(vmf, pfn, write);
-		break;
-	case IOMAP_UNWRITTEN:
-	case IOMAP_HOLE:
-		if (WARN_ON_ONCE(write))
-			break;
-		result = dax_pmd_load_hole(&xas, vmf, &iomap, &entry);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-
- finish_iomap:
+finish_iomap:
 	if (ops->iomap_end) {
 		int copied = PMD_SIZE;
 
-		if (result == VM_FAULT_FALLBACK)
+		if (ret == VM_FAULT_FALLBACK)
 			copied = 0;
 		/*
 		 * The fault is done by now and there's no way back (other
@@ -1628,19 +1631,18 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 		 * Just ignore error from ->iomap_end since we cannot do much
 		 * with it.
 		 */
-		ops->iomap_end(inode, pos, PMD_SIZE, copied, iomap_flags,
-				&iomap);
+		ops->iomap_end(inode, pos, PMD_SIZE, copied, flags, &iomap);
 	}
- unlock_entry:
+unlock_entry:
 	dax_unlock_entry(&xas, entry);
- fallback:
-	if (result == VM_FAULT_FALLBACK) {
+fallback:
+	if (ret == VM_FAULT_FALLBACK) {
 		split_huge_pmd(vma, vmf->pmd, vmf->address);
 		count_vm_event(THP_FAULT_FALLBACK);
 	}
 out:
-	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, result);
-	return result;
+	trace_dax_pmd_fault_done(inode, vmf, max_pgoff, ret);
+	return ret;
 }
 #else
 static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
-- 
2.31.0



