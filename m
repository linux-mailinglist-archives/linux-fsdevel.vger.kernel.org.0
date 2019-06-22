Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAA4F25A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 02:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFVAFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 20:05:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10884 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727054AbfFVAFc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 20:05:32 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LNpvSW023807
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=IWV65r5U1l3yQ4pVTe+jKPIu04iDbUqXRbQ4VzDCPdU=;
 b=kxf8MJM9a4RH8AW/c2NAHkpyDFMaiI5wyyll6HN4NpTI/rFcowgVM8Ntx5pmkOA3HA7h
 gdDMqg6elkrpPdhnmZsSOYtmut/7JeewSYDBL8Csk7GZgD0HuqEdB6x50foKxYNxN5tX
 cr2YN8BBnLhlXOoCCgmrVt2f1NQRdE2tBB4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2t8yv1a4vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 17:05:30 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Jun 2019 17:05:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5593B62E2D56; Fri, 21 Jun 2019 17:05:29 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v6 5/6] mm,thp: add read-only THP support for (non-shmem) FS
Date:   Fri, 21 Jun 2019 17:05:11 -0700
Message-ID: <20190622000512.923867-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190622000512.923867-1-songliubraving@fb.com>
References: <20190622000512.923867-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210182
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch is (hopefully) the first step to enable THP for non-shmem
filesystems.

This patch enables an application to put part of its text sections to THP
via madvise, for example:

    madvise((void *)0x600000, 0x200000, MADV_HUGEPAGE);

We tried to reuse the logic for THP on tmpfs.

Currently, write is not supported for non-shmem THP. khugepaged will only
process vma with VM_DENYWRITE. The next patch will handle writes, which
would only happen when the vma with VM_DENYWRITE is unmapped.

An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
feature.

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/Kconfig      | 11 ++++++
 mm/filemap.c    |  4 +--
 mm/khugepaged.c | 91 +++++++++++++++++++++++++++++++++++++++++--------
 mm/rmap.c       | 12 ++++---
 4 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..0a8fd589406d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -762,6 +762,17 @@ config GUP_BENCHMARK
 
 	  See tools/testing/selftests/vm/gup_benchmark.c
 
+config READ_ONLY_THP_FOR_FS
+	bool "Read-only THP for filesystems (EXPERIMENTAL)"
+	depends on TRANSPARENT_HUGE_PAGECACHE && SHMEM
+
+	help
+	  Allow khugepaged to put read-only file-backed pages in THP.
+
+	  This is marked experimental because it is a new feature. Write
+	  support of file THPs will be developed in the next few release
+	  cycles.
+
 config ARCH_HAS_PTE_SPECIAL
 	bool
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 5f072a113535..e79ceccdc6df 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -203,8 +203,8 @@ static void unaccount_page_cache_page(struct address_space *mapping,
 		__mod_node_page_state(page_pgdat(page), NR_SHMEM, -nr);
 		if (PageTransHuge(page))
 			__dec_node_page_state(page, NR_SHMEM_THPS);
-	} else {
-		VM_BUG_ON_PAGE(PageTransHuge(page), page);
+	} else if (PageTransHuge(page)) {
+		__dec_node_page_state(page, NR_FILE_THPS);
 	}
 
 	/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index dde8e45552b3..fbcff5a1d65a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -48,6 +48,7 @@ enum scan_result {
 	SCAN_CGROUP_CHARGE_FAIL,
 	SCAN_EXCEED_SWAP_PTE,
 	SCAN_TRUNCATED,
+	SCAN_PAGE_HAS_PRIVATE,
 };
 
 #define CREATE_TRACE_POINTS
@@ -404,7 +405,11 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	    (vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
 		return false;
-	if (shmem_file(vma->vm_file)) {
+
+	if (shmem_file(vma->vm_file) ||
+	    (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	     vma->vm_file &&
+	     (vm_flags & VM_DENYWRITE))) {
 		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE))
 			return false;
 		return IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
@@ -456,8 +461,9 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 	unsigned long hstart, hend;
 
 	/*
-	 * khugepaged does not yet work on non-shmem files or special
-	 * mappings. And file-private shmem THP is not supported.
+	 * khugepaged only supports read-only files for non-shmem files.
+	 * khugepaged does not yet work on special mappings. And
+	 * file-private shmem THP is not supported.
 	 */
 	if (!hugepage_vma_check(vma, vm_flags))
 		return 0;
@@ -1287,12 +1293,12 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 }
 
 /**
- * collapse_file - collapse small tmpfs/shmem pages into huge one.
+ * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
  *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
- *    + swap in pages if necessary;
+ *    + swap/gup in pages if necessary;
  *    + fill in gaps;
  *    + keep old pages around in case rollback is required;
  *  - if replacing succeeds:
@@ -1316,7 +1322,11 @@ static void collapse_file(struct vm_area_struct *vma,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
+	bool is_shmem = shmem_file(vma->vm_file);
 
+#ifndef CONFIG_READ_ONLY_THP_FOR_FS
+	VM_BUG_ON(!is_shmem);
+#endif
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
 	/* Only allocate from the target node */
@@ -1348,7 +1358,8 @@ static void collapse_file(struct vm_area_struct *vma,
 	} while (1);
 
 	__SetPageLocked(new_page);
-	__SetPageSwapBacked(new_page);
+	if (is_shmem)
+		__SetPageSwapBacked(new_page);
 	new_page->index = start;
 	new_page->mapping = mapping;
 
@@ -1363,7 +1374,7 @@ static void collapse_file(struct vm_area_struct *vma,
 		struct page *page = xas_next(&xas);
 
 		VM_BUG_ON(index != xas.xa_index);
-		if (!page) {
+		if (is_shmem && !page) {
 			/*
 			 * Stop if extent has been truncated or hole-punched,
 			 * and is now completely empty.
@@ -1384,7 +1395,7 @@ static void collapse_file(struct vm_area_struct *vma,
 			continue;
 		}
 
-		if (xa_is_value(page) || !PageUptodate(page)) {
+		if (is_shmem && (xa_is_value(page) || !PageUptodate(page))) {
 			xas_unlock_irq(&xas);
 			/* swap in or instantiate fallocated page */
 			if (shmem_getpage(mapping->host, index, &page,
@@ -1392,6 +1403,24 @@ static void collapse_file(struct vm_area_struct *vma,
 				result = SCAN_FAIL;
 				goto xa_unlocked;
 			}
+		} else if (!page || xa_is_value(page)) {
+			unsigned long vaddr;
+
+			VM_BUG_ON(is_shmem);
+
+			vaddr = vma->vm_start +
+				((index - vma->vm_pgoff) << PAGE_SHIFT);
+			xas_unlock_irq(&xas);
+			if (get_user_pages_remote(NULL, mm, vaddr, 1,
+					FOLL_FORCE, &page, NULL, NULL) != 1) {
+				result = SCAN_FAIL;
+				goto xa_unlocked;
+			}
+			lru_add_drain();
+			lock_page(page);
+		} else if (!PageUptodate(page) || PageDirty(page)) {
+			result = SCAN_FAIL;
+			goto xa_locked;
 		} else if (trylock_page(page)) {
 			get_page(page);
 			xas_unlock_irq(&xas);
@@ -1426,6 +1455,12 @@ static void collapse_file(struct vm_area_struct *vma,
 			goto out_unlock;
 		}
 
+		if (page_has_private(page) &&
+		    !try_to_release_page(page, GFP_KERNEL)) {
+			result = SCAN_PAGE_HAS_PRIVATE;
+			break;
+		}
+
 		if (page_mapped(page))
 			unmap_mapping_pages(mapping, index, 1, false);
 
@@ -1463,12 +1498,18 @@ static void collapse_file(struct vm_area_struct *vma,
 		goto xa_unlocked;
 	}
 
-	__inc_node_page_state(new_page, NR_SHMEM_THPS);
+	if (is_shmem)
+		__inc_node_page_state(new_page, NR_SHMEM_THPS);
+	else
+		__inc_node_page_state(new_page, NR_FILE_THPS);
+
 	if (nr_none) {
 		struct zone *zone = page_zone(new_page);
 
 		__mod_node_page_state(zone->zone_pgdat, NR_FILE_PAGES, nr_none);
-		__mod_node_page_state(zone->zone_pgdat, NR_SHMEM, nr_none);
+		if (is_shmem)
+			__mod_node_page_state(zone->zone_pgdat,
+					      NR_SHMEM, nr_none);
 	}
 
 xa_locked:
@@ -1506,10 +1547,15 @@ static void collapse_file(struct vm_area_struct *vma,
 
 		SetPageUptodate(new_page);
 		page_ref_add(new_page, HPAGE_PMD_NR - 1);
-		set_page_dirty(new_page);
 		mem_cgroup_commit_charge(new_page, memcg, false, true);
+
+		if (is_shmem) {
+			set_page_dirty(new_page);
+			lru_cache_add_anon(new_page);
+		} else {
+			lru_cache_add_file(new_page);
+		}
 		count_memcg_events(memcg, THP_COLLAPSE_ALLOC, 1);
-		lru_cache_add_anon(new_page);
 
 		/*
 		 * Remove pte page tables, so we can re-fault the page as huge.
@@ -1524,7 +1570,9 @@ static void collapse_file(struct vm_area_struct *vma,
 		/* Something went wrong: roll back page cache changes */
 		xas_lock_irq(&xas);
 		mapping->nrpages -= nr_none;
-		shmem_uncharge(mapping->host, nr_none);
+
+		if (is_shmem)
+			shmem_uncharge(mapping->host, nr_none);
 
 		xas_set(&xas, start);
 		xas_for_each(&xas, page, end - 1) {
@@ -1607,6 +1655,17 @@ static void khugepaged_scan_file(struct vm_area_struct *vma,
 			break;
 		}
 
+		if (page_has_private(page) && trylock_page(page)) {
+			int ret;
+
+			ret = try_to_release_page(page, GFP_KERNEL);
+			unlock_page(page);
+			if (!ret) {
+				result = SCAN_PAGE_HAS_PRIVATE;
+				break;
+			}
+		}
+
 		if (page_count(page) != 1 + page_mapcount(page)) {
 			result = SCAN_PAGE_COUNT;
 			break;
@@ -1714,11 +1773,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
 				  khugepaged_scan.address + HPAGE_PMD_SIZE >
 				  hend);
-			if (shmem_file(vma->vm_file)) {
+			if (vma->vm_file) {
 				struct file *file;
 				pgoff_t pgoff = linear_page_index(vma,
 						khugepaged_scan.address);
-				if (!shmem_huge_enabled(vma))
+
+				if (shmem_file(vma->vm_file)
+				    && !shmem_huge_enabled(vma))
 					goto skip;
 				file = get_file(vma->vm_file);
 				up_read(&mm->mmap_sem);
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..87cfa2c19eda 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1192,8 +1192,10 @@ void page_add_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
-		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
-		__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+		if (PageSwapBacked(page))
+			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+		else
+			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1232,8 +1234,10 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		}
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			goto out;
-		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
-		__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+		if (PageSwapBacked(page))
+			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+		else
+			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			goto out;
-- 
2.17.1

