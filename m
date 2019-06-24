Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2731251E4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 00:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfFXWaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 18:30:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfFXWaN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:30:13 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OMHotY006248
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 15:30:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Rw3bF3LLOPMJXUJryh7BDppGG/fMUSMU6vd9No970FE=;
 b=Jwy8GSjCz6tJtVLMP/bG6sFn79YOWcADOe0SRp8LclM0hhi3eG6FIfrSe8iemnvpARZy
 7SLA5+O8EE+P8fhmk3TdESYxAa2FiASuNEvp3wTBEZ0EG3bz/yqV185Gqh9mnLxpnaC9
 wTanwUphnm4zgE8p15zr82gdyuFFazGrWF0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2tb56ughb3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 15:30:12 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 15:30:11 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 2EFAF62E206E; Mon, 24 Jun 2019 15:30:09 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <kernel-team@fb.com>, <william.kucharski@oracle.com>,
        <akpm@linux-foundation.org>, <hdanton@sina.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v8 5/6] mm,thp: add read-only THP support for (non-shmem) FS
Date:   Mon, 24 Jun 2019 15:29:50 -0700
Message-ID: <20190624222951.37076-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624222951.37076-1-songliubraving@fb.com>
References: <20190624222951.37076-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240176
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
process vma with VM_DENYWRITE. sys_mmap() ignores VM_DENYWRITE requests
(see ksys_mmap_pgoff). The only way to create vma with VM_DENYWRITE is
execve(). This requirement limits non-shmem THP to text sections.

The next patch will handle writes, which would only happen when the all
the vmas with VM_DENYWRITE are unmapped.

An EXPERIMENTAL config, READ_ONLY_THP_FOR_FS, is added to gate this
feature.

Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 mm/Kconfig      | 11 ++++++
 mm/filemap.c    |  4 +--
 mm/khugepaged.c | 94 +++++++++++++++++++++++++++++++++++++++++--------
 mm/rmap.c       | 12 ++++---
 4 files changed, 100 insertions(+), 21 deletions(-)

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
index 158cad542627..acbbbeaa083c 100644
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
@@ -1316,7 +1322,9 @@ static void collapse_file(struct mm_struct *mm,
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
+	bool is_shmem = shmem_file(file);
 
+	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
 	/* Only allocate from the target node */
@@ -1348,7 +1356,8 @@ static void collapse_file(struct mm_struct *mm,
 	} while (1);
 
 	__SetPageLocked(new_page);
-	__SetPageSwapBacked(new_page);
+	if (is_shmem)
+		__SetPageSwapBacked(new_page);
 	new_page->index = start;
 	new_page->mapping = mapping;
 
@@ -1363,7 +1372,7 @@ static void collapse_file(struct mm_struct *mm,
 		struct page *page = xas_next(&xas);
 
 		VM_BUG_ON(index != xas.xa_index);
-		if (!page) {
+		if (is_shmem && !page) {
 			/*
 			 * Stop if extent has been truncated or hole-punched,
 			 * and is now completely empty.
@@ -1384,7 +1393,7 @@ static void collapse_file(struct mm_struct *mm,
 			continue;
 		}
 
-		if (xa_is_value(page) || !PageUptodate(page)) {
+		if (is_shmem && (xa_is_value(page) || !PageUptodate(page))) {
 			xas_unlock_irq(&xas);
 			/* swap in or instantiate fallocated page */
 			if (shmem_getpage(mapping->host, index, &page,
@@ -1392,6 +1401,29 @@ static void collapse_file(struct mm_struct *mm,
 				result = SCAN_FAIL;
 				goto xa_unlocked;
 			}
+		} else if (!page || xa_is_value(page)) {
+			xas_unlock_irq(&xas);
+			page_cache_sync_readahead(mapping, &file->f_ra, file,
+						  index, PAGE_SIZE);
+			/* drain pagevecs to help isolate_lru_page() */
+			lru_add_drain();
+			page = find_lock_page(mapping, index);
+			if (unlikely(page == NULL)) {
+				result = SCAN_FAIL;
+				goto xa_unlocked;
+			}
+		} else if (!PageUptodate(page)) {
+			VM_BUG_ON(is_shmem);
+			xas_unlock_irq(&xas);
+			wait_on_page_locked(page);
+			if (!trylock_page(page)) {
+				result = SCAN_PAGE_LOCK;
+				goto xa_unlocked;
+			}
+			get_page(page);
+		} else if (!is_shmem && PageDirty(page)) {
+			result = SCAN_FAIL;
+			goto xa_locked;
 		} else if (trylock_page(page)) {
 			get_page(page);
 			xas_unlock_irq(&xas);
@@ -1426,6 +1458,12 @@ static void collapse_file(struct mm_struct *mm,
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
 
@@ -1463,12 +1501,18 @@ static void collapse_file(struct mm_struct *mm,
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
@@ -1506,10 +1550,15 @@ static void collapse_file(struct mm_struct *mm,
 
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
@@ -1524,7 +1573,9 @@ static void collapse_file(struct mm_struct *mm,
 		/* Something went wrong: roll back page cache changes */
 		xas_lock_irq(&xas);
 		mapping->nrpages -= nr_none;
-		shmem_uncharge(mapping->host, nr_none);
+
+		if (is_shmem)
+			shmem_uncharge(mapping->host, nr_none);
 
 		xas_set(&xas, start);
 		xas_for_each(&xas, page, end - 1) {
@@ -1607,6 +1658,17 @@ static void khugepaged_scan_file(struct mm_struct *mm,
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
@@ -1713,11 +1775,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages,
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

