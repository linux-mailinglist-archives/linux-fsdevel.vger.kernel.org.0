Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949847EC14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbhLXGXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbhLXGXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3FC061757;
        Thu, 23 Dec 2021 22:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2Qvg19ABRkEjG0icMTYZaPgGjGzCwiBx2r+pyLRWArs=; b=RE3UuaMOoXmjn1Vj/qXob7dnIj
        TKc3DeNAc9zKLHrCfPETn74UHPebqcWlBkjSQ+RRfShp4Gs4+sX/lri2KGt7kvYIzFCVWxY9TqD5n
        WL7p7bXVBp4b0gs5rBiOSRINHSS1P5SYFHmXsSZ5QEpZ/YK9CAEj+UKdv2OLrob+fbPY8ofcivC08
        6thSjG40RCilPFr6ih6bPqlYNhwG9qAWJsPicVEoJ1sR4lt5HcNXO7dXME23pH2S5f8BslawLZno8
        Xae8AlSSpXaGFMgbotqOfAX4xpeK1UeI7ZVHF6HQTL4IB5MHzU+nPb8AVQdBMLPF79//4hMGfsseV
        HVS1grmA==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dyy-00Dn58-LE; Fri, 24 Dec 2021 06:23:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 08/13] mm: simplify try_to_unuse
Date:   Fri, 24 Dec 2021 07:22:41 +0100
Message-Id: <20211224062246.1258487-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the unused frontswap and pages_to_unuse arguments, and mark
the function static now that the caller in frontswap is gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h |  7 ----
 include/linux/shmem_fs.h  |  3 +-
 include/linux/swapfile.h  |  1 -
 mm/shmem.c                | 33 +++-------------
 mm/swapfile.c             | 83 +++++++++++----------------------------
 5 files changed, 30 insertions(+), 97 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index 73d7beb44f2b7..a9817d4fa74c1 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -7,13 +7,6 @@
 #include <linux/bitops.h>
 #include <linux/jump_label.h>
 
-/*
- * Return code to denote that requested number of
- * frontswap pages are unused(moved to page cache).
- * Used in shmem_unuse and try_to_unuse.
- */
-#define FRONTSWAP_PAGES_UNUSED	2
-
 struct frontswap_ops {
 	void (*init)(unsigned); /* this swap type was just swapon'ed */
 	int (*store)(unsigned, pgoff_t, struct page *); /* store a page */
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 166158b6e917a..e65b80ed09e77 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -83,8 +83,7 @@ extern void shmem_unlock_mapping(struct address_space *mapping);
 extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp_mask);
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
-extern int shmem_unuse(unsigned int type, bool frontswap,
-		       unsigned long *fs_pages_to_unuse);
+int shmem_unuse(unsigned int type);
 
 extern bool shmem_is_huge(struct vm_area_struct *vma,
 			  struct inode *inode, pgoff_t index);
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index e06febf629788..809cd01ef2c57 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,7 +9,6 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
-extern int try_to_unuse(unsigned int, bool, unsigned long);
 extern unsigned long generic_max_swapfile_size(void);
 extern unsigned long max_swapfile_size(void);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index eb0fd90011308..421b2459929a2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -36,7 +36,6 @@
 #include <linux/uio.h>
 #include <linux/khugepaged.h>
 #include <linux/hugetlb.h>
-#include <linux/frontswap.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 
@@ -1146,7 +1145,7 @@ static void shmem_evict_inode(struct inode *inode)
 static int shmem_find_swap_entries(struct address_space *mapping,
 				   pgoff_t start, unsigned int nr_entries,
 				   struct page **entries, pgoff_t *indices,
-				   unsigned int type, bool frontswap)
+				   unsigned int type)
 {
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct page *page;
@@ -1167,9 +1166,6 @@ static int shmem_find_swap_entries(struct address_space *mapping,
 		entry = radix_to_swp_entry(page);
 		if (swp_type(entry) != type)
 			continue;
-		if (frontswap &&
-		    !frontswap_test(swap_info[type], swp_offset(entry)))
-			continue;
 
 		indices[ret] = xas.xa_index;
 		entries[ret] = page;
@@ -1222,26 +1218,20 @@ static int shmem_unuse_swap_entries(struct inode *inode, struct pagevec pvec,
 /*
  * If swap found in inode, free it and move page from swapcache to filecache.
  */
-static int shmem_unuse_inode(struct inode *inode, unsigned int type,
-			     bool frontswap, unsigned long *fs_pages_to_unuse)
+static int shmem_unuse_inode(struct inode *inode, unsigned int type)
 {
 	struct address_space *mapping = inode->i_mapping;
 	pgoff_t start = 0;
 	struct pagevec pvec;
 	pgoff_t indices[PAGEVEC_SIZE];
-	bool frontswap_partial = (frontswap && *fs_pages_to_unuse > 0);
 	int ret = 0;
 
 	pagevec_init(&pvec);
 	do {
 		unsigned int nr_entries = PAGEVEC_SIZE;
 
-		if (frontswap_partial && *fs_pages_to_unuse < PAGEVEC_SIZE)
-			nr_entries = *fs_pages_to_unuse;
-
 		pvec.nr = shmem_find_swap_entries(mapping, start, nr_entries,
-						  pvec.pages, indices,
-						  type, frontswap);
+						  pvec.pages, indices, type);
 		if (pvec.nr == 0) {
 			ret = 0;
 			break;
@@ -1251,14 +1241,6 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type,
 		if (ret < 0)
 			break;
 
-		if (frontswap_partial) {
-			*fs_pages_to_unuse -= ret;
-			if (*fs_pages_to_unuse == 0) {
-				ret = FRONTSWAP_PAGES_UNUSED;
-				break;
-			}
-		}
-
 		start = indices[pvec.nr - 1];
 	} while (true);
 
@@ -1270,8 +1252,7 @@ static int shmem_unuse_inode(struct inode *inode, unsigned int type,
  * device 'type' back into memory, so the swap device can be
  * unused.
  */
-int shmem_unuse(unsigned int type, bool frontswap,
-		unsigned long *fs_pages_to_unuse)
+int shmem_unuse(unsigned int type)
 {
 	struct shmem_inode_info *info, *next;
 	int error = 0;
@@ -1294,8 +1275,7 @@ int shmem_unuse(unsigned int type, bool frontswap,
 		atomic_inc(&info->stop_eviction);
 		mutex_unlock(&shmem_swaplist_mutex);
 
-		error = shmem_unuse_inode(&info->vfs_inode, type, frontswap,
-					  fs_pages_to_unuse);
+		error = shmem_unuse_inode(&info->vfs_inode, type);
 		cond_resched();
 
 		mutex_lock(&shmem_swaplist_mutex);
@@ -4009,8 +3989,7 @@ int __init shmem_init(void)
 	return 0;
 }
 
-int shmem_unuse(unsigned int type, bool frontswap,
-		unsigned long *fs_pages_to_unuse)
+int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
 {
 	return 0;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index df5930ccd93dd..82342c77791bb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1923,8 +1923,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 
 static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			unsigned long addr, unsigned long end,
-			unsigned int type, bool frontswap,
-			unsigned long *fs_pages_to_unuse)
+			unsigned int type)
 {
 	struct page *page;
 	swp_entry_t entry;
@@ -1945,9 +1944,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			continue;
 
 		offset = swp_offset(entry);
-		if (frontswap && !frontswap_test(si, offset))
-			continue;
-
 		pte_unmap(pte);
 		swap_map = &si->swap_map[offset];
 		page = lookup_swap_cache(entry, vma, addr);
@@ -1979,11 +1975,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		try_to_free_swap(page);
 		unlock_page(page);
 		put_page(page);
-
-		if (*fs_pages_to_unuse && !--(*fs_pages_to_unuse)) {
-			ret = FRONTSWAP_PAGES_UNUSED;
-			goto out;
-		}
 try_next:
 		pte = pte_offset_map(pmd, addr);
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -1996,8 +1987,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 				unsigned long addr, unsigned long end,
-				unsigned int type, bool frontswap,
-				unsigned long *fs_pages_to_unuse)
+				unsigned int type)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -2009,8 +1999,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 			continue;
-		ret = unuse_pte_range(vma, pmd, addr, next, type,
-				      frontswap, fs_pages_to_unuse);
+		ret = unuse_pte_range(vma, pmd, addr, next, type);
 		if (ret)
 			return ret;
 	} while (pmd++, addr = next, addr != end);
@@ -2019,8 +2008,7 @@ static inline int unuse_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 
 static inline int unuse_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
 				unsigned long addr, unsigned long end,
-				unsigned int type, bool frontswap,
-				unsigned long *fs_pages_to_unuse)
+				unsigned int type)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -2031,8 +2019,7 @@ static inline int unuse_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		ret = unuse_pmd_range(vma, pud, addr, next, type,
-				      frontswap, fs_pages_to_unuse);
+		ret = unuse_pmd_range(vma, pud, addr, next, type);
 		if (ret)
 			return ret;
 	} while (pud++, addr = next, addr != end);
@@ -2041,8 +2028,7 @@ static inline int unuse_pud_range(struct vm_area_struct *vma, p4d_t *p4d,
 
 static inline int unuse_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
 				unsigned long addr, unsigned long end,
-				unsigned int type, bool frontswap,
-				unsigned long *fs_pages_to_unuse)
+				unsigned int type)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -2053,16 +2039,14 @@ static inline int unuse_p4d_range(struct vm_area_struct *vma, pgd_t *pgd,
 		next = p4d_addr_end(addr, end);
 		if (p4d_none_or_clear_bad(p4d))
 			continue;
-		ret = unuse_pud_range(vma, p4d, addr, next, type,
-				      frontswap, fs_pages_to_unuse);
+		ret = unuse_pud_range(vma, p4d, addr, next, type);
 		if (ret)
 			return ret;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
 }
 
-static int unuse_vma(struct vm_area_struct *vma, unsigned int type,
-		     bool frontswap, unsigned long *fs_pages_to_unuse)
+static int unuse_vma(struct vm_area_struct *vma, unsigned int type)
 {
 	pgd_t *pgd;
 	unsigned long addr, end, next;
@@ -2076,16 +2060,14 @@ static int unuse_vma(struct vm_area_struct *vma, unsigned int type,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		ret = unuse_p4d_range(vma, pgd, addr, next, type,
-				      frontswap, fs_pages_to_unuse);
+		ret = unuse_p4d_range(vma, pgd, addr, next, type);
 		if (ret)
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 	return 0;
 }
 
-static int unuse_mm(struct mm_struct *mm, unsigned int type,
-		    bool frontswap, unsigned long *fs_pages_to_unuse)
+static int unuse_mm(struct mm_struct *mm, unsigned int type)
 {
 	struct vm_area_struct *vma;
 	int ret = 0;
@@ -2093,8 +2075,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type,
 	mmap_read_lock(mm);
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma->anon_vma) {
-			ret = unuse_vma(vma, type, frontswap,
-					fs_pages_to_unuse);
+			ret = unuse_vma(vma, type);
 			if (ret)
 				break;
 		}
@@ -2110,7 +2091,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type,
  * if there are no inuse entries after prev till end of the map.
  */
 static unsigned int find_next_to_unuse(struct swap_info_struct *si,
-					unsigned int prev, bool frontswap)
+					unsigned int prev)
 {
 	unsigned int i;
 	unsigned char count;
@@ -2124,8 +2105,7 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	for (i = prev + 1; i < si->max; i++) {
 		count = READ_ONCE(si->swap_map[i]);
 		if (count && swap_count(count) != SWAP_MAP_BAD)
-			if (!frontswap || frontswap_test(si, i))
-				break;
+			break;
 		if ((i % LATENCY_LIMIT) == 0)
 			cond_resched();
 	}
@@ -2136,12 +2116,7 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	return i;
 }
 
-/*
- * If the boolean frontswap is true, only unuse pages_to_unuse pages;
- * pages_to_unuse==0 means all pages; ignored if frontswap is false
- */
-int try_to_unuse(unsigned int type, bool frontswap,
-		 unsigned long pages_to_unuse)
+static int try_to_unuse(unsigned int type)
 {
 	struct mm_struct *prev_mm;
 	struct mm_struct *mm;
@@ -2155,13 +2130,10 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	if (!READ_ONCE(si->inuse_pages))
 		return 0;
 
-	if (!frontswap)
-		pages_to_unuse = 0;
-
 retry:
-	retval = shmem_unuse(type, frontswap, &pages_to_unuse);
+	retval = shmem_unuse(type);
 	if (retval)
-		goto out;
+		return retval;
 
 	prev_mm = &init_mm;
 	mmget(prev_mm);
@@ -2178,11 +2150,10 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		spin_unlock(&mmlist_lock);
 		mmput(prev_mm);
 		prev_mm = mm;
-		retval = unuse_mm(mm, type, frontswap, &pages_to_unuse);
-
+		retval = unuse_mm(mm, type);
 		if (retval) {
 			mmput(prev_mm);
-			goto out;
+			return retval;
 		}
 
 		/*
@@ -2199,7 +2170,7 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	i = 0;
 	while (READ_ONCE(si->inuse_pages) &&
 	       !signal_pending(current) &&
-	       (i = find_next_to_unuse(si, i, frontswap)) != 0) {
+	       (i = find_next_to_unuse(si, i)) != 0) {
 
 		entry = swp_entry(type, i);
 		page = find_get_page(swap_address_space(entry), i);
@@ -2217,14 +2188,6 @@ int try_to_unuse(unsigned int type, bool frontswap,
 		try_to_free_swap(page);
 		unlock_page(page);
 		put_page(page);
-
-		/*
-		 * For frontswap, we just need to unuse pages_to_unuse, if
-		 * it was specified. Need not check frontswap again here as
-		 * we already zeroed out pages_to_unuse if not frontswap.
-		 */
-		if (pages_to_unuse && --pages_to_unuse == 0)
-			goto out;
 	}
 
 	/*
@@ -2242,10 +2205,10 @@ int try_to_unuse(unsigned int type, bool frontswap,
 	if (READ_ONCE(si->inuse_pages)) {
 		if (!signal_pending(current))
 			goto retry;
-		retval = -EINTR;
+		return -EINTR;
 	}
-out:
-	return (retval == FRONTSWAP_PAGES_UNUSED) ? 0 : retval;
+
+	return 0;
 }
 
 /*
@@ -2577,7 +2540,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	disable_swap_slots_cache_lock();
 
 	set_current_oom_origin();
-	err = try_to_unuse(p->type, false, 0); /* force unuse all pages */
+	err = try_to_unuse(p->type);
 	clear_current_oom_origin();
 
 	if (err) {
-- 
2.30.2

