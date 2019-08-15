Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B08E487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 07:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfHOFpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 01:45:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42130 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHOFpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 01:45:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F5iAe5049970;
        Thu, 15 Aug 2019 05:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=VM3MSEvvNsr+IZyUTEXcn8hrhAY2Pc3Ap74hFS2s7bU=;
 b=MyrUQEtGGhVZgR2pMwUf+Y3P8EoXHPFRlc347wX00DbY7o2sXYXQD3QqeTFftksyvlNn
 IVoDnCt9Ugh/8/lC3waqE5C0ZXPMTAbfiA0h6Ys5qnFTqp2AN30crxeTWEikzcSvZITg
 sUe3M86EBFiPPfqtQKzFdsKwPrVVkZ0FjYuPRO+hInQl9uU6CIwT60jSkYQr2xXD1+y/
 bHqKev0OthEyX6AW3rQvhc+E5e15WYPAgukytEu70Xj9WQMgAt4lEkTxGUgpa5H/Napy
 JVQOohJNbAINTkwr8oYcqYD6E1J5oUm+gE3NYSGpisEFJtVZhoi/YEMwvq9vhhOmEmW7 eQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u9nbtrwsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 05:44:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F5iU5H057446;
        Thu, 15 Aug 2019 05:44:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2ucpys17sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 05:44:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7F5iOmE010880;
        Thu, 15 Aug 2019 05:44:24 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Aug 2019 22:44:24 -0700
From:   William Kucharski <william.kucharski@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Bob Kasten <robert.a.kasten@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Chad Mynhier <chad.mynhier@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <jweiner@fb.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 2/2] mm,thp: Add experimental config option RO_EXEC_FILEMAP_HUGE_FAULT_THP
Date:   Wed, 14 Aug 2019 23:44:12 -0600
Message-Id: <20190815054412.26713-3-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815054412.26713-1-william.kucharski@oracle.com>
References: <20190815054412.26713-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150059
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add filemap_huge_fault() to attempt to satisfy page
faults on memory-mapped read-only text pages using THP when possible.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/mm.h |   2 +
 mm/Kconfig         |  15 ++
 mm/filemap.c       | 337 +++++++++++++++++++++++++++++++++++++++++++--
 mm/huge_memory.c   |   3 +
 mm/mmap.c          |  38 ++++-
 mm/rmap.c          |   4 +-
 6 files changed, 386 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..2a5311721739 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2433,6 +2433,8 @@ extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
+extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+			enum page_entry_size pe_size);
 extern void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff);
 extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
diff --git a/mm/Kconfig b/mm/Kconfig
index 56cec636a1fc..2debaded0e4d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,19 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config RO_EXEC_FILEMAP_HUGE_FAULT_THP
+	bool "read-only exec filemap_huge_fault THP support (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
+
+	help
+	    Introduce filemap_huge_fault() to automatically map executable
+	    read-only pages of mapped files of suitable size and alignment
+	    using THP if possible.
+
+	    This is marked experimental because it is a new feature and is
+	    dependent upon filesystmes implementing readpages() in a way
+	    that will recognize large THP pages and read file content to
+	    them without polluting the pagecache with PAGESIZE pages due
+	    to readahead.
+
 endmenu
diff --git a/mm/filemap.c b/mm/filemap.c
index 38b46fc00855..aebf2f54f52e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -199,13 +199,12 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	nr = hpage_nr_pages(page);
 
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
-	if (PageSwapBacked(page)) {
+
+	if (PageSwapBacked(page))
 		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
-		if (PageTransHuge(page))
-			__dec_node_page_state(page, NR_SHMEM_THPS);
-	} else {
-		VM_BUG_ON_PAGE(PageTransHuge(page), page);
-	}
+
+	if (PageTransHuge(page))
+		__dec_node_page_state(page, NR_SHMEM_THPS);
 
 	/*
 	 * At this point page must be either written or cleaned by
@@ -1663,7 +1662,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 no_page:
 	if (!page && (fgp_flags & FGP_CREAT)) {
 		int err;
-		if ((fgp_flags & FGP_WRITE) && mapping_cap_account_dirty(mapping))
+		if ((fgp_flags & FGP_WRITE) &&
+			mapping_cap_account_dirty(mapping))
 			gfp_mask |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
 			gfp_mask &= ~__GFP_FS;
@@ -2643,6 +2643,326 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+/*
+ * Check for an entry in the page cache which would conflict with the address
+ * range we wish to map using a THP or is otherwise unusable to map a large
+ * cached page.
+ *
+ * The routine will return true if a usable page is found in the page cache
+ * (and *pagep will be set to the address of the cached page), or if no
+ * cached page is found (and *pagep will be set to NULL).
+ */
+static bool
+filemap_huge_check_pagecache_usable(struct xa_state *xas,
+	struct page **pagep, pgoff_t hindex, pgoff_t hindex_max)
+{
+	struct page *page;
+
+	while (1) {
+		page = xas_find(xas, hindex_max);
+
+		if (xas_retry(xas, page)) {
+			xas_set(xas, hindex);
+			continue;
+		}
+
+		/*
+		 * A found entry is unusable if:
+		 *	+ the entry is an Xarray value, not a pointer
+		 *	+ the entry is an internal Xarray node
+		 *	+ the entry is not a Transparent Huge Page
+		 *	+ the entry is not a compound page
+		 *	+ the entry is not the head of a compound page
+		 *	+ the entry is a page page with an order other than
+		 *	  HPAGE_PMD_ORDER
+		 *	+ the page's index is not what we expect it to be
+		 *	+ the page is not up-to-date
+		 */
+		if (!page)
+			break;
+
+		if (xa_is_value(page) || xa_is_internal(page))
+			return false;
+
+		VM_BUG_ON_PAGE(PageHuge(page), page);
+
+		if ((!PageCompound(page)) || (page != compound_head(page)))
+			return false;
+
+		VM_BUG_ON_PAGE(compound_order(page) != HPAGE_PMD_ORDER, page);
+
+		if (page->index != hindex || !PageUptodate(page))
+			return false;
+
+		break;
+	}
+
+	xas_set(xas, hindex);
+	*pagep = page;
+	return true;
+}
+
+/*
+ * There is a change coming to store only the head page of a compound page in
+ * the head cache.
+ *
+ * When that change is present in the kernel, remove this #define
+ */
+#define	PAGE_CACHE_STORE_COMPOUND_TAIL_PAGES
+
+/**
+ * filemap_huge_fault - read in file data for page fault handling to THP
+ * @vmf:	struct vm_fault containing details of the fault
+ * @pe_size:	large page size to map, currently this must be PE_SIZE_PMD
+ *
+ * filemap_huge_fault() is invoked via the vma operations vector for a
+ * mapped memory region to read in file data to a transparent huge page during
+ * a page fault.
+ *
+ * If for any reason we can't allocate a THP, map it or add it to the page
+ * cache, VM_FAULT_FALLBACK will be returned which will cause the fault
+ * handler to try mapping the page using a PAGESIZE page, usually via
+ * filemap_fault() if so speicifed in the vma operations vector.
+ *
+ * Returns either VM_FAULT_FALLBACK or the result of calling allcc_set_pte()
+ * to map the new THP.
+ *
+ * NOTE: This routine depends upon the file system's readpage routine as
+ *       specified in the address space operations vector to recognize when it
+ *	 is being passed a large page and to read the approprate amount of data
+ *	 in full and without polluting the page cache for the large page itself
+ *	 with PAGESIZE pages to perform a buffered read or to pollute what
+ *	 would be the page cache space for any succeeding pages with PAGESIZE
+ *	 pages due to readahead.
+ *
+ *	 It is VITAL that this routine not be enabled without such filesystem
+ *	 support. As there is no way to determine how many bytes were read by
+ *	 the readpage() operation, if only a PAGESIZE page is read, this routine
+ *	 will map the THP containing only the first PAGESIZE bytes of file data
+ *	 to satisfy the fault, which is never the result desired.
+ */
+vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+		enum page_entry_size pe_size)
+{
+	struct file *filp = vmf->vma->vm_file;
+	struct address_space *mapping = filp->f_mapping;
+	struct vm_area_struct *vma = vmf->vma;
+
+	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
+	pgoff_t hindex = round_down(vmf->pgoff, HPAGE_PMD_NR);
+	pgoff_t hindex_max = hindex + HPAGE_PMD_NR;
+
+	struct page *cached_page, *hugepage;
+	struct page *new_page = NULL;
+
+	vm_fault_t ret = VM_FAULT_FALLBACK;
+	unsigned long nr;
+
+	int error;
+
+	XA_STATE_ORDER(xas, &mapping->i_pages, hindex, HPAGE_PMD_ORDER);
+
+	/*
+	 * Return VM_FAULT_FALLBACK if:
+	 *
+	 *	+ pe_size != PE_SIZE_PMD
+	 *	+ FAULT_FLAG_WRITE is set in vmf->flags
+	 *	+ vma isn't aligned to allow a PMD mapping
+	 *	+ PMD would extend beyond the end of the vma
+	 */
+	if (pe_size != PE_SIZE_PMD || (vmf->flags & FAULT_FLAG_WRITE) ||
+		(haddr < vma->vm_start ||
+		(haddr + HPAGE_PMD_SIZE > vma->vm_end)))
+		return ret;
+
+	rcu_read_lock();
+
+	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
+		hindex_max)) {
+		/* found a conflicting entry in the page cache, so fallback */
+		rcu_read_unlock();
+		return ret;
+	} else if (cached_page) {
+		/* found a valid cached page, so map it */
+		lock_page(cached_page);
+
+		/* was the cached page truncated while waiting for the lock? */
+		if (unlikely(page_mapping(cached_page) != mapping)) {
+			unlock_page(cached_page);
+			rcu_read_unlock();
+			return ret;
+		}
+
+		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
+
+		hugepage = cached_page;
+		goto map_huge;
+	}
+
+	rcu_read_unlock();
+
+	/* allocate huge THP page in VMA */
+	new_page = __page_cache_alloc(vmf->gfp_mask | __GFP_COMP |
+		__GFP_NOWARN | __GFP_NORETRY, HPAGE_PMD_ORDER);
+
+	if (unlikely(!new_page))
+		return ret;
+
+	do {
+		xas_lock_irq(&xas);
+		xas_set(&xas, hindex);
+		xas_create_range(&xas);
+
+		if (!(xas_error(&xas)))
+			break;
+
+		xas_unlock_irq(&xas);
+
+		if (!xas_nomem(&xas, GFP_KERNEL)) {
+			/* error creating range, so free THP and fallback */
+			if (new_page)
+				put_page(new_page);
+
+			return ret;
+		}
+	} while (1);
+
+	/*
+	 * Double check that an entry did not sneak into the page cache while
+	 * creating Xarray entries for the new page.
+	 */
+	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
+		hindex_max)) {
+		/*
+		 * An unusable entry was found, so delete the newly allocated
+		 * page and fallback.
+		 */
+		put_page(new_page);
+		xas_unlock_irq(&xas);
+		return ret;
+	} else if (cached_page) {
+		/*
+		 * A valid large page was found in the page cache, so free the
+		 * newly allocated page and map the cached page instead.
+		 */
+		put_page(new_page);
+		new_page = NULL;
+		lock_page(cached_page);
+
+		/* was the cached page truncated while waiting for the lock? */
+		if (unlikely(page_mapping(cached_page) != mapping)) {
+			unlock_page(cached_page);
+			xas_unlock_irq(&xas);
+			return ret;
+		}
+
+		VM_BUG_ON_PAGE(cached_page->index != hindex, cached_page);
+
+		hugepage = cached_page;
+		goto map_huge;
+	}
+
+	get_page(new_page);
+	prep_transhuge_page(new_page);
+	new_page->mapping = mapping;
+	new_page->index = hindex;
+	__SetPageLocked(new_page);
+
+	count_vm_event(THP_FILE_ALLOC);
+	xas_set(&xas, hindex);
+
+	for (nr = 0; nr < HPAGE_PMD_NR; nr++) {
+#ifdef PAGE_CACHE_STORE_COMPOUND_TAIL_PAGES
+		/*
+		 * Store pointers to both head and tail pages of a compound
+		 * page in the page cache.
+		 */
+		xas_store(&xas, new_page + nr);
+#else
+		/*
+		 * All entries for a compound page in the page cache should
+		 * point to the head page.
+		 */
+		xas_store(&xas, new_page);
+#endif
+		xas_next(&xas);
+	}
+
+	xas_unlock_irq(&xas);
+
+	/*
+	 * The readpage() operation below is expected to fill the large
+	 * page with data without polluting the page cache with
+	 * PAGESIZE entries due to a buffered read and/or readahead().
+	 *
+	 * A filesystem's vm_operations_struct huge_fault field should
+	 * never point to this routine without such a capability, and
+	 * without it a call to this routine would eventually just
+	 * fall through to the normal fault op anyway.
+	 */
+	error = mapping->a_ops->readpage(vmf->vma->vm_file, new_page);
+
+	if (unlikely(error)) {
+		new_page->mapping = NULL;
+		put_page(new_page);
+		return ret;
+	}
+
+	/* XXX - use wait_on_page_locked_killable() instead? */
+	wait_on_page_locked(new_page);
+
+	if (!PageUptodate(new_page)) {
+		/* EIO */
+		new_page->mapping = NULL;
+		put_page(new_page);
+		return ret;
+	}
+
+	lock_page(new_page);
+
+	/* did the page get truncated while waiting for the lock? */
+	if (unlikely(new_page->mapping != mapping)) {
+		unlock_page(new_page);
+		put_page(new_page);
+		return ret;
+	}
+
+	__inc_node_page_state(new_page, NR_SHMEM_THPS);
+	__mod_node_page_state(page_pgdat(new_page),
+		NR_FILE_PAGES, HPAGE_PMD_NR);
+	__mod_node_page_state(page_pgdat(new_page),
+		NR_SHMEM, HPAGE_PMD_NR);
+
+	hugepage = new_page;
+
+map_huge:
+	/* map hugepage at the PMD level */
+
+	ret = alloc_set_pte(vmf, vmf->memcg, hugepage);
+
+	VM_BUG_ON_PAGE((!(pmd_trans_huge(*vmf->pmd))), hugepage);
+
+	if (likely(!(ret & VM_FAULT_ERROR))) {
+		vmf->address = haddr;
+		vmf->page = hugepage;
+
+		page_ref_add(hugepage, HPAGE_PMD_NR);
+		count_vm_event(THP_FILE_MAPPED);
+	} else {
+		if (new_page) {
+			unlock_page(new_page);
+			put_page(new_page);
+			return ret;
+		}
+	}
+
+	unlock_page(hugepage);
+	return ret;
+}
+EXPORT_SYMBOL(filemap_huge_fault);
+#endif
+
 void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -2925,7 +3245,8 @@ struct page *read_cache_page(struct address_space *mapping,
 EXPORT_SYMBOL(read_cache_page);
 
 /**
- * read_cache_page_gfp - read into page cache, using specified page allocation flags.
+ * read_cache_page_gfp - read into page cache, using specified page allocation
+ *			 flags.
  * @mapping:	the page's address_space
  * @index:	the page index
  * @gfp:	the page allocator flags to use if allocating
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1334ede667a8..26d74466d1f7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -543,8 +543,11 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 
 	if (addr)
 		goto out;
+
+#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
 	if (!IS_DAX(filp->f_mapping->host) || !IS_ENABLED(CONFIG_FS_DAX_PMD))
 		goto out;
+#endif
 
 	addr = __thp_get_unmapped_area(filp, len, off, flags, PMD_SIZE);
 	if (addr)
diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..7d213373d54c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1391,6 +1391,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
+	unsigned long vm_maywrite = VM_MAYWRITE;
+
 	*populate = 0;
 
 	if (!len)
@@ -1426,10 +1428,40 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-	/* Obtain the address to map to. we verify (or select) it and ensure
+	/*
+	 * Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
-	addr = get_unmapped_area(file, addr, len, pgoff, flags);
+
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+	/*
+	 * If THP is enabled, it's a read-only executable that is
+	 * MAP_PRIVATE mapped, the length is larger than a PMD page
+	 * and either it's not a MAP_FIXED mapping or the passed address is
+	 * properly aligned for a PMD page, attempt to get an appropriate
+	 * address at which to map a PMD-sized THP page, otherwise call the
+	 * normal routine.
+	 */
+	if ((prot & PROT_READ) && (prot & PROT_EXEC) &&
+		(!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE)) {
+		addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
+
+		if (addr && (!(addr & ~HPAGE_PMD_MASK))) {
+			/*
+			 * If we got a suitable THP mapping address, shut off
+			 * VM_MAYWRITE for the region, since it's never what
+			 * we would want.
+			 */
+			vm_maywrite = 0;
+		} else
+			addr = get_unmapped_area(file, addr, len, pgoff, flags);
+	} else {
+#endif
+		addr = get_unmapped_area(file, addr, len, pgoff, flags);
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+	}
+#endif
+
 	if (offset_in_page(addr))
 		return addr;
 
@@ -1451,7 +1483,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * of the memory object, so we don't do any here.
 	 */
 	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
-			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+			mm->def_flags | VM_MAYREAD | vm_maywrite | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
 		if (!can_do_mlock())
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..1a51008a22bf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1192,7 +1192,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
-		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+
 		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
@@ -1232,7 +1232,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			goto out;
-		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+
 		__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
-- 
2.21.0

