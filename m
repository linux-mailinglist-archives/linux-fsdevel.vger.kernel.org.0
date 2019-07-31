Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B95A7BB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGaIZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 04:25:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59402 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGaIZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:25:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6V8NuDV080720;
        Wed, 31 Jul 2019 08:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=+3r1yiP70zWmJq5VevhL++/wKR0nwjYG0RDz/6WAF4A=;
 b=S6nuWsKXGh84XDvM/VtvIUljFuG9jmrrZAgcwa4yKSL900Lnw9X2eE9xI76nBM7jOaTi
 HfW23rKOKn4RHIBh8rYU9U88KRoOcVWEYNVyLdpMNz/KwMou1JUtPt6GDPUtwEz75bPd
 +YQFQN5znrTF62EfZCcoqRTKPuu4/1b+9Iz+GZtMZUI5u3XMH+pJN9LY8Ob34oJJ8ZUf
 dU/iMmvMW+DGmCK8E0REwYv5BM552kPS8mR9dyLKHN4QkKH0ak8nuU5EpjNpVkn2U326
 iNEx5HW3GwOYJzVL63wVVL2n1ujec1M7NEL+zVr79dty7ziqsMYgg0bVN11yUsmnZ5Pw 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2u0ejpkkuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 08:25:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6V8MsdV013418;
        Wed, 31 Jul 2019 08:25:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u349cnm25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 08:25:22 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6V8PLSx007180;
        Wed, 31 Jul 2019 08:25:21 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 01:25:20 -0700
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
Subject: [PATCH v3 2/2] mm,thp: Add experimental config option RO_EXEC_FILEMAP_HUGE_FAULT_THP
Date:   Wed, 31 Jul 2019 02:25:13 -0600
Message-Id: <20190731082513.16957-3-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731082513.16957-1-william.kucharski@oracle.com>
References: <20190731082513.16957-1-william.kucharski@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add filemap_huge_fault() to attempt to satisfy page
faults on memory-mapped read-only text pages using THP when possible.

Signed-off-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/huge_mm.h |  16 ++-
 include/linux/mm.h      |   6 +
 mm/Kconfig              |  15 ++
 mm/filemap.c            | 300 +++++++++++++++++++++++++++++++++++++++-
 mm/huge_memory.c        |   3 +
 mm/mmap.c               |  36 ++++-
 mm/rmap.c               |   8 ++
 7 files changed, 374 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 45ede62aa85b..b1e5fd3179fd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -79,13 +79,15 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define HPAGE_PMD_SHIFT PMD_SHIFT
-#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
-#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
-
-#define HPAGE_PUD_SHIFT PUD_SHIFT
-#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
-#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
+#define HPAGE_PMD_SHIFT		PMD_SHIFT
+#define HPAGE_PMD_SIZE		((1UL) << HPAGE_PMD_SHIFT)
+#define HPAGE_PMD_OFFSET	(HPAGE_PMD_SIZE - 1)
+#define HPAGE_PMD_MASK		(~(HPAGE_PMD_OFFSET))
+
+#define HPAGE_PUD_SHIFT		PUD_SHIFT
+#define HPAGE_PUD_SIZE		((1UL) << HPAGE_PUD_SHIFT)
+#define HPAGE_PUD_OFFSET	(HPAGE_PUD_SIZE - 1)
+#define HPAGE_PUD_MASK		(~(HPAGE_PUD_OFFSET))
 
 extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..ba24b515468a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2433,6 +2433,12 @@ extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern vm_fault_t filemap_fault(struct vm_fault *vmf);
+
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+extern vm_fault_t filemap_huge_fault(struct vm_fault *vmf,
+			enum page_entry_size pe_size);
+#endif
+
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
index 38b46fc00855..db1d8df20367 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -199,6 +199,8 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	nr = hpage_nr_pages(page);
 
 	__mod_node_page_state(page_pgdat(page), NR_FILE_PAGES, -nr);
+
+#ifndef	CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
 	if (PageSwapBacked(page)) {
 		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
 		if (PageTransHuge(page))
@@ -206,6 +208,13 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 	} else {
 		VM_BUG_ON_PAGE(PageTransHuge(page), page);
 	}
+#else
+	if (PageSwapBacked(page))
+		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
+
+	if (PageTransHuge(page))
+		__dec_node_page_state(page, NR_SHMEM_THPS);
+#endif
 
 	/*
 	 * At this point page must be either written or cleaned by
@@ -1663,7 +1672,8 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
 no_page:
 	if (!page && (fgp_flags & FGP_CREAT)) {
 		int err;
-		if ((fgp_flags & FGP_WRITE) && mapping_cap_account_dirty(mapping))
+		if ((fgp_flags & FGP_WRITE) &&
+			mapping_cap_account_dirty(mapping))
 			gfp_mask |= __GFP_WRITE;
 		if (fgp_flags & FGP_NOFS)
 			gfp_mask &= ~__GFP_FS;
@@ -2643,6 +2653,291 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
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
+		 *	+ the enbry is a page page with an order other than
+		 *	  HPAGE_PMD_ORDER
+		 *	+ the page's index is not what we expect it to be
+		 *	+ the page is not up-to-date
+		 *	+ the page is unlocked
+		 */
+		if ((page) && (xa_is_value(page) || xa_is_internal(page) ||
+			(!PageCompound(page)) || (PageHuge(page)) ||
+			(!PageTransCompound(page)) ||
+			page != compound_head(page) ||
+			compound_order(page) != HPAGE_PMD_ORDER ||
+			page->index != hindex || (!PageUptodate(page)) ||
+			(!PageLocked(page))))
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
+	xas_lock_irq(&xas);
+
+retry_xas_locked:
+	if (!filemap_huge_check_pagecache_usable(&xas, &cached_page, hindex,
+		hindex_max)) {
+		/* found a conflicting entry in the page cache, so fallback */
+		goto unlock;
+	} else if (cached_page) {
+		/* found a valid cached page, so map it */
+		hugepage = cached_page;
+		goto map_huge;
+	}
+
+	xas_unlock_irq(&xas);
+
+	/* allocate huge THP page in VMA */
+	new_page = __page_cache_alloc(vmf->gfp_mask | __GFP_COMP |
+		__GFP_NOWARN | __GFP_NORETRY, HPAGE_PMD_ORDER);
+
+	if (unlikely(!new_page))
+		return ret;
+
+	if (unlikely(!(PageCompound(new_page)))) {
+		put_page(new_page);
+		return ret;
+	}
+
+	prep_transhuge_page(new_page);
+	new_page->index = hindex;
+	new_page->mapping = mapping;
+
+	__SetPageLocked(new_page);
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
+	do {
+		xas_lock_irq(&xas);
+		xas_set(&xas, hindex);
+		xas_create_range(&xas);
+
+		if (!(xas_error(&xas)))
+			break;
+
+		if (!xas_nomem(&xas, GFP_KERNEL)) {
+			if (new_page) {
+				new_page->mapping = NULL;
+				put_page(new_page);
+			}
+
+			goto unlock;
+		}
+
+		xas_unlock_irq(&xas);
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
+		new_page->mapping = NULL;
+		put_page(new_page);
+		goto unlock;
+	} else if (cached_page) {
+		/*
+		 * A valid large page was found in the page cache, so free the
+		 * newly allocated page and map the cached page instead.
+		 */
+		new_page->mapping = NULL;
+		put_page(new_page);
+		new_page = NULL;
+		hugepage = cached_page;
+		goto map_huge;
+	}
+
+	__SetPageLocked(new_page);
+
+	/* did it get truncated? */
+	if (unlikely(new_page->mapping != mapping)) {
+		unlock_page(new_page);
+		put_page(new_page);
+		goto retry_xas_locked;
+	}
+
+	hugepage = new_page;
+
+map_huge:
+	/* map hugepage at the PMD level */
+	ret = alloc_set_pte(vmf, NULL, hugepage);
+
+	VM_BUG_ON_PAGE((!(pmd_trans_huge(*vmf->pmd))), hugepage);
+
+	if (likely(!(ret & VM_FAULT_ERROR))) {
+		/*
+		 * The alloc_set_pte() succeeded without error, so
+		 * add the page to the page cache if it is new, and
+		 * increment page statistics accordingly.
+		 */
+		if (new_page) {
+			unsigned long nr;
+
+			xas_set(&xas, hindex);
+
+			for (nr = 0; nr < HPAGE_PMD_NR; nr++) {
+#ifndef	COMPOUND_PAGES_HEAD_ONLY
+				xas_store(&xas, new_page + nr);
+#else
+				xas_store(&xas, new_page);
+#endif
+				xas_next(&xas);
+			}
+
+			count_vm_event(THP_FILE_ALLOC);
+			__inc_node_page_state(new_page, NR_SHMEM_THPS);
+			__mod_node_page_state(page_pgdat(new_page),
+				NR_FILE_PAGES, HPAGE_PMD_NR);
+			__mod_node_page_state(page_pgdat(new_page),
+				NR_SHMEM, HPAGE_PMD_NR);
+		}
+
+		vmf->address = haddr;
+		vmf->page = hugepage;
+
+		page_ref_add(hugepage, HPAGE_PMD_NR);
+		count_vm_event(THP_FILE_MAPPED);
+	} else if (new_page) {
+		/* there was an error mapping the new page, so release it */
+		new_page->mapping = NULL;
+		put_page(new_page);
+	}
+
+unlock:
+	xas_unlock_irq(&xas);
+	return ret;
+}
+EXPORT_SYMBOL(filemap_huge_fault);
+#endif
+
 void filemap_map_pages(struct vm_fault *vmf,
 		pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -2925,7 +3220,8 @@ struct page *read_cache_page(struct address_space *mapping,
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
index 7e8c3e8ae75f..96ff80d2a8fb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1391,6 +1391,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+	unsigned long vm_maywrite = VM_MAYWRITE;
+#endif
+
 	*populate = 0;
 
 	if (!len)
@@ -1429,7 +1433,33 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	/* Obtain the address to map to. we verify (or select) it and ensure
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
+		(!(prot & PROT_WRITE)) && (flags & MAP_PRIVATE) &&
+		(!(flags & MAP_FIXED)) && len >= HPAGE_PMD_SIZE &&
+		(!(addr & HPAGE_PMD_OFFSET))) {
+		addr = thp_get_unmapped_area(file, addr, len, pgoff, flags);
+
+		if (addr && (!(addr & HPAGE_PMD_OFFSET)))
+			vm_maywrite = 0;
+		else
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
 
@@ -1451,7 +1481,11 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * of the memory object, so we don't do any here.
 	 */
 	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+#ifdef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
+			mm->def_flags | VM_MAYREAD | vm_maywrite | VM_MAYEXEC;
+#else
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
+#endif
 
 	if (flags & MAP_LOCKED)
 		if (!can_do_mlock())
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..503612d3b52b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1192,7 +1192,11 @@ void page_add_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
+
+#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
 		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+#endif
+
 		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
@@ -1232,7 +1236,11 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			goto out;
+
+#ifndef CONFIG_RO_EXEC_FILEMAP_HUGE_FAULT_THP
 		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+#endif
+
 		__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
-- 
2.21.0

