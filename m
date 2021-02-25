Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26DB3248C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhBYCPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 21:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbhBYCPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 21:15:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACEDC061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j4so4339896ybt.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Feb 2021 18:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gibWM86tJstEY74dmgqny8fiREx0nHwdhwJjOS9tlq4=;
        b=Y5GNE6PHQDw8utcHL1dQCGzKiBYZDmufayx/2gjBR0oztwCgsVsSeI1/39LBL0qhPT
         Y5PDOswkLrz6j80fcTo+wnF0ZrzwCdfc4XjTb5pnYdzBPb+LzCugeyXc8kp6Z74RJWLY
         v3aH50iEFNUmlCJDBzVGF/lkorC41ogVmAlN6vi8HZwAHYkxz//1GJA60DiFZgU+wu3B
         DnMywzDEsRvNfjoSKwiDZ0rBP8mDqIBuSVJUgKqrnx/GpO5YRoff/iuphwSQD5ABLBts
         g5tpRaYQV4bsTfz3763zOXDdENk7150+AvulZmJXLoVe6NV2mqksAUNIWas9W4rIpM0Y
         YH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gibWM86tJstEY74dmgqny8fiREx0nHwdhwJjOS9tlq4=;
        b=mIVPC1DaSlQvxkeyED5xwG1QljmwOhXiF3a8BLVp4yDQ8q1fTajWFRJTgFqQrsCXpM
         StGg25BDeaVEGnMac/sLFQdc4HFMUPWohWtm9qdRbge418Ro+EiJEj2JL2AiQqwiqkUk
         cWMTadfIcpTrFseO6+1ppIvLWPNQdDCpR9LBFb0WDvbVkJjuBF4s/La2YuQTo5isBV3e
         WVyxov6rZPV86ygKNBEZP+/9KsHQYPBs4BzzrihNb1pvnogXoGX68dbNBLxbPEwyZc2k
         nh77ERnL0uufoOS/y1IZhZCobyyK9ZxU7TZ7tUnI0rYqjnJhTcsyvTkEYJEzCifGlARN
         llVQ==
X-Gm-Message-State: AOAM532TWpBLe0ea+k4U4533+ZcTVwkPaEoTcJgMfRx6AaE/XZWOr+wz
        Cbo2gxostj5n4K7UdhKPstzdiqAFC3ow/rKhSMGc
X-Google-Smtp-Source: ABdhPJwIBxC+MtFq1A04Q3tbtvDOEThRghDQ/1pxxAMdm+p3NPxQ0UHvI0dNRCrompmU+htTcZOWSLv7fPg4sBWOJoeL
Sender: "axelrasmussen via sendgmr" <axelrasmussen@ajr0.svl.corp.google.com>
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:a5fd:f848:2fdf:4651])
 (user=axelrasmussen job=sendgmr) by 2002:a25:bc4a:: with SMTP id
 d10mr779313ybk.501.1614219282525; Wed, 24 Feb 2021 18:14:42 -0800 (PST)
Date:   Wed, 24 Feb 2021 18:14:16 -0800
In-Reply-To: <20210225021420.2290912-1-axelrasmussen@google.com>
Message-Id: <20210225021420.2290912-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210225021420.2290912-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH 1/5] userfaultfd: support minor fault handling for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michel Lespinasse <walken@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify the userfaultfd register API to allow registering shmem VMAs in
minor mode. Modify the shmem mcopy implementation to support
UFFDIO_CONTINUE in order to resolve such faults.

Combine the shmem mcopy handler functions into a single
shmem_mcopy_atomic_pte, which takes a mode parameter. This matches how
the hugetlbfs implementation is structured, and lets us remove a good
chunk of boilerplate.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c                 |  6 +--
 include/linux/shmem_fs.h         | 26 ++++------
 include/uapi/linux/userfaultfd.h |  4 +-
 mm/memory.c                      |  8 +--
 mm/shmem.c                       | 88 +++++++++++++++-----------------
 mm/userfaultfd.c                 | 27 +++++-----
 6 files changed, 77 insertions(+), 82 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 0311e9b8a8fc..aa6d584ae8c7 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_UFFD_MINOR) {
-		/* FIXME: Add minor fault interception for shmem. */
-		if (!is_vm_hugetlb_page(vma))
+		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
 			return false;
 	}
 
@@ -1941,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+	uffdio_api.features &=
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f396588..f0919c3722e7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -9,6 +9,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
+#include <linux/userfaultfd_k.h>
 
 /* inode in-kernel data */
 
@@ -122,21 +123,16 @@ static inline bool shmem_file(struct file *file)
 extern bool shmem_charge(struct inode *inode, long pages);
 extern void shmem_uncharge(struct inode *inode, long pages);
 
+#ifdef CONFIG_USERFAULTFD
 #ifdef CONFIG_SHMEM
-extern int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
-				  struct vm_area_struct *dst_vma,
-				  unsigned long dst_addr,
-				  unsigned long src_addr,
-				  struct page **pagep);
-extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
-				    pmd_t *dst_pmd,
-				    struct vm_area_struct *dst_vma,
-				    unsigned long dst_addr);
-#else
-#define shmem_mcopy_atomic_pte(dst_mm, dst_pte, dst_vma, dst_addr, \
-			       src_addr, pagep)        ({ BUG(); 0; })
-#define shmem_mfill_zeropage_pte(dst_mm, dst_pmd, dst_vma, \
-				 dst_addr)      ({ BUG(); 0; })
-#endif
+int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+			   struct vm_area_struct *dst_vma,
+			   unsigned long dst_addr, unsigned long src_addr,
+			   enum mcopy_atomic_mode mode, struct page **pagep);
+#else /* !CONFIG_SHMEM */
+#define shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr, \
+			       src_addr, mode, pagep)        ({ BUG(); 0; })
+#endif /* CONFIG_SHMEM */
+#endif /* CONFIG_USERFAULTFD */
 
 #endif
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a2624..47d9790d863d 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -31,7 +31,8 @@
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
-			   UFFD_FEATURE_MINOR_HUGETLBFS)
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -196,6 +197,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/memory.c b/mm/memory.c
index c8e357627318..a1e5ff55027e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3929,9 +3929,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * something).
 	 */
 	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		ret = do_fault_around(vmf);
-		if (ret)
-			return ret;
+		if (likely(!userfaultfd_minor(vmf->vma))) {
+			ret = do_fault_around(vmf);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = __do_fault(vmf);
diff --git a/mm/shmem.c b/mm/shmem.c
index 06c771d23127..d7847f6f696b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -77,7 +77,6 @@ static struct vfsmount *shm_mnt;
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <uapi/linux/memfd.h>
-#include <linux/userfaultfd_k.h>
 #include <linux/rmap.h>
 #include <linux/uuid.h>
 
@@ -1781,8 +1780,8 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * vmf and fault_type are only supplied by shmem_fault:
- * otherwise they are NULL.
+ * vma, vmf, and fault_type are only supplied by shmem_fault: otherwise they
+ * are NULL.
  */
 static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct page **pagep, enum sgp_type sgp, gfp_t gfp,
@@ -1826,6 +1825,12 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return error;
 	}
 
+	if (page && vma && userfaultfd_minor(vma)) {
+		unlock_page(page);
+		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		return 0;
+	}
+
 	if (page)
 		hindex = page->index;
 	if (page && sgp == SGP_WRITE)
@@ -2350,14 +2355,12 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	return inode;
 }
 
-static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
-				  pmd_t *dst_pmd,
-				  struct vm_area_struct *dst_vma,
-				  unsigned long dst_addr,
-				  unsigned long src_addr,
-				  bool zeropage,
-				  struct page **pagep)
+int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
+			   struct vm_area_struct *dst_vma,
+			   unsigned long dst_addr, unsigned long src_addr,
+			   enum mcopy_atomic_mode mode, struct page **pagep)
 {
+	bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
 	struct inode *inode = file_inode(dst_vma->vm_file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct address_space *mapping = inode->i_mapping;
@@ -2374,12 +2377,17 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!shmem_inode_acct_block(inode, 1))
 		goto out;
 
-	if (!*pagep) {
+	if (is_continue) {
+		ret = -EFAULT;
+		page = find_get_page(mapping, pgoff);
+		if (!page)
+			goto out_unacct_blocks;
+	} else if (!*pagep) {
 		page = shmem_alloc_page(gfp, info, pgoff);
 		if (!page)
 			goto out_unacct_blocks;
 
-		if (!zeropage) {	/* mcopy_atomic */
+		if (mode == MCOPY_ATOMIC_NORMAL) {	/* mcopy_atomic */
 			page_kaddr = kmap_atomic(page);
 			ret = copy_from_user(page_kaddr,
 					     (const void __user *)src_addr,
@@ -2393,7 +2401,7 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 				/* don't free the page */
 				return -ENOENT;
 			}
-		} else {		/* mfill_zeropage_atomic */
+		} else {		/* zeropage */
 			clear_highpage(page);
 		}
 	} else {
@@ -2401,9 +2409,12 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 		*pagep = NULL;
 	}
 
-	VM_BUG_ON(PageLocked(page) || PageSwapBacked(page));
+	if (!is_continue)
+		VM_BUG_ON(PageSwapBacked(page));
+	VM_BUG_ON(PageLocked(page));
 	__SetPageLocked(page);
-	__SetPageSwapBacked(page);
+	if (!is_continue || !PageSwapBacked(page))
+		__SetPageSwapBacked(page);
 	__SetPageUptodate(page);
 
 	ret = -EFAULT;
@@ -2412,10 +2423,13 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (unlikely(offset >= max_off))
 		goto out_release;
 
-	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_mm);
-	if (ret)
-		goto out_release;
+	/* If page wasn't already in the page cache, add it. */
+	if (!is_continue) {
+		ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
+					      gfp & GFP_RECLAIM_MASK, dst_mm);
+		if (ret)
+			goto out_release;
+	}
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
@@ -2442,13 +2456,15 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (!pte_none(*dst_pte))
 		goto out_release_unlock;
 
-	lru_cache_add(page);
+	if (!is_continue) {
+		lru_cache_add(page);
 
-	spin_lock_irq(&info->lock);
-	info->alloced++;
-	inode->i_blocks += BLOCKS_PER_PAGE;
-	shmem_recalc_inode(inode);
-	spin_unlock_irq(&info->lock);
+		spin_lock_irq(&info->lock);
+		info->alloced++;
+		inode->i_blocks += BLOCKS_PER_PAGE;
+		shmem_recalc_inode(inode);
+		spin_unlock_irq(&info->lock);
+	}
 
 	inc_mm_counter(dst_mm, mm_counter_file(page));
 	page_add_file_rmap(page, false);
@@ -2473,28 +2489,6 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	goto out;
 }
 
-int shmem_mcopy_atomic_pte(struct mm_struct *dst_mm,
-			   pmd_t *dst_pmd,
-			   struct vm_area_struct *dst_vma,
-			   unsigned long dst_addr,
-			   unsigned long src_addr,
-			   struct page **pagep)
-{
-	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, src_addr, false, pagep);
-}
-
-int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
-			     pmd_t *dst_pmd,
-			     struct vm_area_struct *dst_vma,
-			     unsigned long dst_addr)
-{
-	struct page *page = NULL;
-
-	return shmem_mfill_atomic_pte(dst_mm, dst_pmd, dst_vma,
-				      dst_addr, 0, true, &page);
-}
-
 #ifdef CONFIG_TMPFS
 static const struct inode_operations shmem_symlink_inode_operations;
 static const struct inode_operations shmem_short_symlink_operations;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index ce6cb4760d2c..6cd7ab531aec 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -415,7 +415,7 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 						unsigned long dst_addr,
 						unsigned long src_addr,
 						struct page **page,
-						bool zeropage,
+						enum mcopy_atomic_mode mode,
 						bool wp_copy)
 {
 	ssize_t err;
@@ -431,22 +431,24 @@ static __always_inline ssize_t mfill_atomic_pte(struct mm_struct *dst_mm,
 	 * and not in the radix tree.
 	 */
 	if (!(dst_vma->vm_flags & VM_SHARED)) {
-		if (!zeropage)
+		switch (mode) {
+		case MCOPY_ATOMIC_NORMAL:
 			err = mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma,
 					       dst_addr, src_addr, page,
 					       wp_copy);
-		else
+			break;
+		case MCOPY_ATOMIC_ZEROPAGE:
 			err = mfill_zeropage_pte(dst_mm, dst_pmd,
 						 dst_vma, dst_addr);
+			break;
+		case MCOPY_ATOMIC_CONTINUE:
+			err = -EINVAL;
+			break;
+		}
 	} else {
 		VM_WARN_ON_ONCE(wp_copy);
-		if (!zeropage)
-			err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd,
-						     dst_vma, dst_addr,
-						     src_addr, page);
-		else
-			err = shmem_mfill_zeropage_pte(dst_mm, dst_pmd,
-						       dst_vma, dst_addr);
+		err = shmem_mcopy_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
+					     src_addr, mode, page);
 	}
 
 	return err;
@@ -467,7 +469,6 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 	long copied;
 	struct page *page;
 	bool wp_copy;
-	bool zeropage = (mcopy_mode == MCOPY_ATOMIC_ZEROPAGE);
 
 	/*
 	 * Sanitize the command parameters:
@@ -530,7 +531,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (mcopy_mode == MCOPY_ATOMIC_CONTINUE)
+	if (!vma_is_shmem(dst_vma) && mcopy_mode == MCOPY_ATOMIC_CONTINUE)
 		goto out_unlock;
 
 	/*
@@ -578,7 +579,7 @@ static __always_inline ssize_t __mcopy_atomic(struct mm_struct *dst_mm,
 		BUG_ON(pmd_trans_huge(*dst_pmd));
 
 		err = mfill_atomic_pte(dst_mm, dst_pmd, dst_vma, dst_addr,
-				       src_addr, &page, zeropage, wp_copy);
+				       src_addr, &page, mcopy_mode, wp_copy);
 		cond_resched();
 
 		if (unlikely(err == -ENOENT)) {
-- 
2.30.0.617.g56c4b15f3c-goog

