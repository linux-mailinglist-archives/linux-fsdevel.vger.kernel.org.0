Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E847107C3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 02:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWBFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 20:05:44 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45371 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbfKWBFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 20:05:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TipYp-z_1574471132;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TipYp-z_1574471132)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Nov 2019 09:05:39 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     hughd@google.com, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm: shmem: allow split THP when truncating THP partially
Date:   Sat, 23 Nov 2019 09:05:32 +0800
Message-Id: <1574471132-55639-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently when truncating shmem file, if the range is partial of THP
(start or end is in the middle of THP), the pages actually will just get
cleared rather than being freed unless the range cover the whole THP.
Even though all the subpages are truncated (randomly or sequentially),
the THP may still be kept in page cache.  This might be fine for some
usecases which prefer preserving THP.

But, when doing balloon inflation in QEMU, QEMU actually does hole punch
or MADV_DONTNEED in base page size granulairty if hugetlbfs is not used.
So, when using shmem THP as memory backend QEMU inflation actually doesn't
work as expected since it doesn't free memory.  But, the inflation
usecase really needs get the memory freed.  Anonymous THP will not get
freed right away too but it will be freed eventually when all subpages are
unmapped, but shmem THP would still stay in page cache.

To protect the usecases which may prefer preserving THP, introduce a
new fallocate mode: FALLOC_FL_SPLIT_HPAGE, which means spltting THP is
preferred behavior if truncating partial THP.  This mode just makes
sense to tmpfs for the time being.

Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c    |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  3 +-
 include/linux/shmem_fs.h                  |  3 +-
 include/uapi/linux/falloc.h               |  7 +++
 mm/shmem.c                                | 99 +++++++++++++++++++++++++++----
 5 files changed, 99 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f591870..d44780e 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -408,7 +408,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_object *obj)
 	 * To do this we must instruct the shmfs to drop all of its
 	 * backing pages, *now*.
 	 */
-	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1);
+	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1, false);
 
 	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping,
 			0, (loff_t)-1);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 4c4954e..cdee286 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -222,7 +222,8 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	 * To do this we must instruct the shmfs to drop all of its
 	 * backing pages, *now*.
 	 */
-	shmem_truncate_range(file_inode(obj->base.filp), 0, (loff_t)-1);
+	shmem_truncate_range(file_inode(obj->base.filp), 0, (loff_t)-1,
+			     false);
 	obj->mm.madv = __I915_MADV_PURGED;
 	obj->mm.pages = ERR_PTR(-EFAULT);
 }
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index de8e4b7..42c6420 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -73,7 +73,8 @@ static inline bool shmem_mapping(struct address_space *mapping)
 extern void shmem_unlock_mapping(struct address_space *mapping);
 extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp_mask);
-extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
+extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end,
+				 bool split);
 extern int shmem_unuse(unsigned int type, bool frontswap,
 		       unsigned long *fs_pages_to_unuse);
 
diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
index 51398fa..26fd272 100644
--- a/include/uapi/linux/falloc.h
+++ b/include/uapi/linux/falloc.h
@@ -77,4 +77,11 @@
  */
 #define FALLOC_FL_UNSHARE_RANGE		0x40
 
+/*
+ * FALLOC_FL_SPLIT_HPAGE is used with FALLOC_FL_PUNCH_HOLE together to
+ * split huge page if the hole punch range is start or end in the middle
+ * of THP.  So far it only makes sense with tmpfs.
+ */
+#define FALLOC_FL_SPLIT_HPAGE		0x80
+
 #endif /* _UAPI_FALLOC_H_ */
diff --git a/mm/shmem.c b/mm/shmem.c
index 220be9f..66e2a82 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -793,7 +793,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
  * If !unfalloc, truncate or punch hole; if unfalloc, undo failed fallocate.
  */
 static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
-								 bool unfalloc)
+			     bool unfalloc, bool split)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -806,12 +806,14 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
+	struct page *page = NULL;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
 
 	pagevec_init(&pvec);
 	index = start;
+retry:
 	while (index < end) {
 		pvec.nr = find_get_entries(mapping, index,
 			min(end - index, (pgoff_t)PAGEVEC_SIZE),
@@ -819,7 +821,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		if (!pvec.nr)
 			break;
 		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+			page = pvec.pages[i];
 
 			index = indices[i];
 			if (index >= end)
@@ -839,9 +841,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				continue;
 
 			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
+				/*
+				 * Middle of THP: zero out the page. We
+				 * still need clear the page even though
+				 * the THP is going to be split since the
+				 * split may fail.
+				 */
 				clear_highpage(page);
 				unlock_page(page);
+				if (!unfalloc && split)
+					goto split;
 				continue;
 			} else if (PageTransHuge(page)) {
 				if (index == round_down(end, HPAGE_PMD_NR)) {
@@ -851,6 +860,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					 */
 					clear_highpage(page);
 					unlock_page(page);
+					if (!unfalloc && split)
+						goto split;
 					continue;
 				}
 				index += HPAGE_PMD_NR - 1;
@@ -866,9 +877,34 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			unlock_page(page);
 		}
+split:
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
 		cond_resched();
+
+		if (split && PageTransCompound(page)) {
+			/* The THP may get freed under us */
+			if (!get_page_unless_zero(compound_head(page)))
+				goto out;
+
+			if (!trylock_page(page))
+				goto out_put;
+
+			/*
+			 * The extra pins from page cache lookup have been
+			 * released by pagevec_release().
+			 */
+			if (!split_huge_page(page)) {
+				unlock_page(page);
+				put_page(page);
+				/* Re-look up page cache from current index */
+				goto retry;
+			}
+			unlock_page(page);
+out_put:
+			put_page(page);
+		}
+out:
 		index++;
 	}
 
@@ -901,6 +937,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		return;
 
 	index = start;
+again:
 	while (index < end) {
 		cond_resched();
 
@@ -937,7 +974,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			lock_page(page);
 
 			if (PageTransTail(page)) {
-				/* Middle of THP: zero out the page */
+				/*
+				 * Middle of THP: zero out the page.  We
+				 * still need clear the page even though the
+				 * THP is going to be split since the split
+				 * may fail.
+				 */
 				clear_highpage(page);
 				unlock_page(page);
 				/*
@@ -947,6 +989,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 				 */
 				if (index != round_down(end, HPAGE_PMD_NR))
 					start++;
+				if (!unfalloc && split)
+					goto rescan_split;
 				continue;
 			} else if (PageTransHuge(page)) {
 				if (index == round_down(end, HPAGE_PMD_NR)) {
@@ -956,6 +1000,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					 */
 					clear_highpage(page);
 					unlock_page(page);
+					if (!unfalloc && split)
+						goto rescan_split;
 					continue;
 				}
 				index += HPAGE_PMD_NR - 1;
@@ -976,8 +1022,31 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			}
 			unlock_page(page);
 		}
+rescan_split:
 		pagevec_remove_exceptionals(&pvec);
 		pagevec_release(&pvec);
+
+		if (split && PageTransCompound(page)) {
+			/* The THP may get freed under us */
+			if (!get_page_unless_zero(compound_head(page)))
+				goto rescan_out;
+
+			lock_page(page);
+
+			/*
+			 * The extra pins from page cache lookup have been
+			 * released by pagevec_release().
+			 */
+			if (!split_huge_page(page)) {
+				unlock_page(page);
+				put_page(page);
+				/* Re-look up page cache from current index */
+				goto again;
+			}
+			unlock_page(page);
+			put_page(page);
+		}
+rescan_out:
 		index++;
 	}
 
@@ -987,9 +1056,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	spin_unlock_irq(&info->lock);
 }
 
-void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
+void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend,
+			  bool split)
 {
-	shmem_undo_range(inode, lstart, lend, false);
+	shmem_undo_range(inode, lstart, lend, false, split);
 	inode->i_ctime = inode->i_mtime = current_time(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
@@ -1049,7 +1119,8 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 							holebegin, 0, 1);
 			if (info->alloced)
 				shmem_truncate_range(inode,
-							newsize, (loff_t)-1);
+							newsize, (loff_t)-1,
+							false);
 			/* unmap again to remove racily COWed private pages */
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
@@ -1089,7 +1160,7 @@ static void shmem_evict_inode(struct inode *inode)
 	if (inode->i_mapping->a_ops == &shmem_aops) {
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
-		shmem_truncate_range(inode, 0, (loff_t)-1);
+		shmem_truncate_range(inode, 0, (loff_t)-1, false);
 		if (!list_empty(&info->shrinklist)) {
 			spin_lock(&sbinfo->shrinklist_lock);
 			if (!list_empty(&info->shrinklist)) {
@@ -2724,12 +2795,14 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	pgoff_t start, index, end;
 	int error;
 
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+		     FALLOC_FL_SPLIT_HPAGE))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
 
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		bool split = mode & FALLOC_FL_SPLIT_HPAGE;
 		struct address_space *mapping = file->f_mapping;
 		loff_t unmap_start = round_up(offset, PAGE_SIZE);
 		loff_t unmap_end = round_down(offset + len, PAGE_SIZE) - 1;
@@ -2751,7 +2824,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		if ((u64)unmap_end > (u64)unmap_start)
 			unmap_mapping_range(mapping, unmap_start,
 					    1 + unmap_end - unmap_start, 0);
-		shmem_truncate_range(inode, offset, offset + len - 1);
+		shmem_truncate_range(inode, offset, offset + len - 1, split);
 		/* No need to unmap again: hole-punching leaves COWed pages */
 
 		spin_lock(&inode->i_lock);
@@ -2808,7 +2881,8 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 			if (index > start) {
 				shmem_undo_range(inode,
 				    (loff_t)start << PAGE_SHIFT,
-				    ((loff_t)index << PAGE_SHIFT) - 1, true);
+				    ((loff_t)index << PAGE_SHIFT) - 1, true,
+				    false);
 			}
 			goto undone;
 		}
@@ -4068,7 +4142,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 }
 #endif
 
-void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
+void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend,
+			  bool split)
 {
 	truncate_inode_pages_range(inode->i_mapping, lstart, lend);
 }
-- 
1.8.3.1

