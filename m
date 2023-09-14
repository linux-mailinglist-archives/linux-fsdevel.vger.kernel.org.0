Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BDD7A0918
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbjINP0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbjINP0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:26:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BB31FDA
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so1384958276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694705189; x=1695309989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKvQQhsOnQPOzJh/frUZToIv42f95olTu0FEXWLe57U=;
        b=EkeMQtBC2V3M1EHGoKBKOeB250FOVr2Pm9njPhlfN9DQ3NCEvGYyE+FnqxK86xhrMB
         ZZI7jDKXvIMF2ffcZq7+euiT6g7pJVDqscwSyNa3He5EY6pBgkizXehmsG/eKvsz/z+g
         KsqoFnG3r2P4oIIpOHJbmXctkjqt6EG8Wwd3jdA3CfQZ5vMVQQ/uH8vfKnSgAMXwkghA
         RHeV/h9qn9j0OHpNpVKNv4Vo1o28FWtC5uNWEUVqiqRnZeWt6fIfAcp4GEGA+agWIX3g
         hsDf1BwQKsK1MXq+rVVVxT9vA4zRbAB7U2pFKoAIO/gbAJgLb8MbADt4UhyGrguN8nKl
         RbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705189; x=1695309989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKvQQhsOnQPOzJh/frUZToIv42f95olTu0FEXWLe57U=;
        b=LsOOHBl4O+X4Ss9pnJkabMv2rJ2D+E3vuHOCFPr+XbU1Ml0qqnWA7/exqCugRkmaQQ
         +iNZsSKMfQVFo5gGhjm5rLgHK0SdOxiges4E4zymOSnGVXhP08jf7YqoGgMNLitm8Tk4
         75fbQCpTbrk24F2nQhPG5dOEFJhQ6YZBJyxFJsRpP6fOLonu7hkPqlkckWqyU4uh9LAS
         Ywh6LNHIUMbzEiyWbGvZNOcPzUk6eMSRiDQW0ENHD/aG0ADXv+4MtPMUHTiMa/bFoTo8
         ATeX79q6nQkanXQ8BfwMQPQ4fSOXDKd0oX52fq/MHaMqZVaGJGuUQQf+rqocekNy3++s
         dq+A==
X-Gm-Message-State: AOJu0YzRGign8/mBclVDz7PN/iOX7M+l0LFRB5L5yuCBst6OvnC8zkA2
        Wce4R2A8ZQgYGalt7X3VinQMnRuKIfw=
X-Google-Smtp-Source: AGHT+IErdl3j36auryaEBKVPOGsZPU+Tafg4HOMgPdqMXZU76tdGjcbI+FRFD2o1NozLAqa0MWiVrErJLoU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:405c:ba64:810f:5fee])
 (user=surenb job=sendgmr) by 2002:a25:aa83:0:b0:d77:984e:c770 with SMTP id
 t3-20020a25aa83000000b00d77984ec770mr131612ybi.5.1694705189263; Thu, 14 Sep
 2023 08:26:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 08:26:12 -0700
In-Reply-To: <20230914152620.2743033-1-surenb@google.com>
Mime-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914152620.2743033-3-surenb@google.com>
Subject: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

This implements the uABI of UFFDIO_REMAP.

Notably one mode bitflag is also forwarded (and in turn known) by the
lowlevel remap_pages method.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/userfaultfd.c                 |  49 +++
 include/linux/rmap.h             |   5 +
 include/linux/userfaultfd_k.h    |  17 +
 include/uapi/linux/userfaultfd.h |  22 ++
 mm/huge_memory.c                 | 118 +++++++
 mm/khugepaged.c                  |   3 +
 mm/userfaultfd.c                 | 586 +++++++++++++++++++++++++++++++
 7 files changed, 800 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 56eaae9dac1a..7bf64e7541c1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2027,6 +2027,52 @@ static inline unsigned int uffd_ctx_features(__u64 user_features)
 	return (unsigned int)user_features | UFFD_FEATURE_INITIALIZED;
 }
 
+static int userfaultfd_remap(struct userfaultfd_ctx *ctx,
+			     unsigned long arg)
+{
+	__s64 ret;
+	struct uffdio_remap uffdio_remap;
+	struct uffdio_remap __user *user_uffdio_remap;
+	struct userfaultfd_wake_range range;
+
+	user_uffdio_remap = (struct uffdio_remap __user *) arg;
+
+	ret = -EFAULT;
+	if (copy_from_user(&uffdio_remap, user_uffdio_remap,
+			   /* don't copy "remap" last field */
+			   sizeof(uffdio_remap)-sizeof(__s64)))
+		goto out;
+
+	ret = validate_range(ctx->mm, uffdio_remap.dst, uffdio_remap.len);
+	if (ret)
+		goto out;
+	ret = validate_range(current->mm, uffdio_remap.src, uffdio_remap.len);
+	if (ret)
+		goto out;
+	ret = -EINVAL;
+	if (uffdio_remap.mode & ~(UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES|
+				  UFFDIO_REMAP_MODE_DONTWAKE))
+		goto out;
+
+	ret = remap_pages(ctx->mm, current->mm,
+			  uffdio_remap.dst, uffdio_remap.src,
+			  uffdio_remap.len, uffdio_remap.mode);
+	if (unlikely(put_user(ret, &user_uffdio_remap->remap)))
+		return -EFAULT;
+	if (ret < 0)
+		goto out;
+	/* len == 0 would wake all */
+	BUG_ON(!ret);
+	range.len = ret;
+	if (!(uffdio_remap.mode & UFFDIO_REMAP_MODE_DONTWAKE)) {
+		range.start = uffdio_remap.dst;
+		wake_userfault(ctx, &range);
+	}
+	ret = range.len == uffdio_remap.len ? 0 : -EAGAIN;
+out:
+	return ret;
+}
+
 /*
  * userland asks for a certain API version and we return which bits
  * and ioctl commands are implemented in this kernel for such API
@@ -2113,6 +2159,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_ZEROPAGE:
 		ret = userfaultfd_zeropage(ctx, arg);
 		break;
+	case UFFDIO_REMAP:
+		ret = userfaultfd_remap(ctx, arg);
+		break;
 	case UFFDIO_WRITEPROTECT:
 		ret = userfaultfd_writeprotect(ctx, arg);
 		break;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 51cc21ebb568..614c4b439907 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -121,6 +121,11 @@ static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 	down_write(&anon_vma->root->rwsem);
 }
 
+static inline int anon_vma_trylock_write(struct anon_vma *anon_vma)
+{
+	return down_write_trylock(&anon_vma->root->rwsem);
+}
+
 static inline void anon_vma_unlock_write(struct anon_vma *anon_vma)
 {
 	up_write(&anon_vma->root->rwsem);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac8c6854097c..2bc807dc390b 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *dst_mm,
 extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
 
+/* remap_pages */
+extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
+extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
+extern ssize_t remap_pages(struct mm_struct *dst_mm,
+			   struct mm_struct *src_mm,
+			   unsigned long dst_start,
+			   unsigned long src_start,
+			   unsigned long len, __u64 flags);
+extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
+				struct mm_struct *src_mm,
+				pmd_t *dst_pmd, pmd_t *src_pmd,
+				pmd_t dst_pmdval,
+				struct vm_area_struct *dst_vma,
+				struct vm_area_struct *src_vma,
+				unsigned long dst_addr,
+				unsigned long src_addr);
+
 /* mm helpers */
 static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 					struct vm_userfaultfd_ctx vm_ctx)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 62151706c5a3..22d1c43e39f9 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -49,6 +49,7 @@
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
+	 (__u64)1 << _UFFDIO_REMAP |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
 	 (__u64)1 << _UFFDIO_POISON)
@@ -72,6 +73,7 @@
 #define _UFFDIO_WAKE			(0x02)
 #define _UFFDIO_COPY			(0x03)
 #define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_REMAP			(0x05)
 #define _UFFDIO_WRITEPROTECT		(0x06)
 #define _UFFDIO_CONTINUE		(0x07)
 #define _UFFDIO_POISON			(0x08)
@@ -91,6 +93,8 @@
 				      struct uffdio_copy)
 #define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
 				      struct uffdio_zeropage)
+#define UFFDIO_REMAP		_IOWR(UFFDIO, _UFFDIO_REMAP,	\
+				      struct uffdio_remap)
 #define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
 				      struct uffdio_writeprotect)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
@@ -340,6 +344,24 @@ struct uffdio_poison {
 	__s64 updated;
 };
 
+struct uffdio_remap {
+	__u64 dst;
+	__u64 src;
+	__u64 len;
+	/*
+	 * Especially if used to atomically remove memory from the
+	 * address space the wake on the dst range is not needed.
+	 */
+#define UFFDIO_REMAP_MODE_DONTWAKE		((__u64)1<<0)
+#define UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES	((__u64)1<<1)
+	__u64 mode;
+	/*
+	 * "remap" is written by the ioctl and must be at the end: the
+	 * copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 remap;
+};
+
 /*
  * Flags for the userfaultfd(2) system call itself.
  */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 064fbd90822b..c7a9880a1f6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1932,6 +1932,124 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	return ret;
 }
 
+#ifdef CONFIG_USERFAULTFD
+/*
+ * The PT lock for src_pmd and the mmap_lock for reading are held by
+ * the caller, but it must return after releasing the
+ * page_table_lock. We're guaranteed the src_pmd is a pmd_trans_huge
+ * until the PT lock of the src_pmd is released. Just move the page
+ * from src_pmd to dst_pmd if possible. Return zero if succeeded in
+ * moving the page, -EAGAIN if it needs to be repeated by the caller,
+ * or other errors in case of failure.
+ */
+int remap_pages_huge_pmd(struct mm_struct *dst_mm,
+			 struct mm_struct *src_mm,
+			 pmd_t *dst_pmd, pmd_t *src_pmd,
+			 pmd_t dst_pmdval,
+			 struct vm_area_struct *dst_vma,
+			 struct vm_area_struct *src_vma,
+			 unsigned long dst_addr,
+			 unsigned long src_addr)
+{
+	pmd_t _dst_pmd, src_pmdval;
+	struct page *src_page;
+	struct anon_vma *src_anon_vma, *dst_anon_vma;
+	spinlock_t *src_ptl, *dst_ptl;
+	pgtable_t pgtable;
+	struct mmu_notifier_range range;
+
+	src_pmdval = *src_pmd;
+	src_ptl = pmd_lockptr(src_mm, src_pmd);
+
+	BUG_ON(!pmd_trans_huge(src_pmdval));
+	BUG_ON(!pmd_none(dst_pmdval));
+	BUG_ON(!spin_is_locked(src_ptl));
+	mmap_assert_locked(src_mm);
+	mmap_assert_locked(dst_mm);
+	BUG_ON(src_addr & ~HPAGE_PMD_MASK);
+	BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
+
+	src_page = pmd_page(src_pmdval);
+	BUG_ON(!PageHead(src_page));
+	BUG_ON(!PageAnon(src_page));
+	if (unlikely(page_mapcount(src_page) != 1)) {
+		spin_unlock(src_ptl);
+		return -EBUSY;
+	}
+
+	get_page(src_page);
+	spin_unlock(src_ptl);
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm, src_addr,
+				src_addr + HPAGE_PMD_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	/* block all concurrent rmap walks */
+	lock_page(src_page);
+
+	/*
+	 * split_huge_page walks the anon_vma chain without the page
+	 * lock. Serialize against it with the anon_vma lock, the page
+	 * lock is not enough.
+	 */
+	src_anon_vma = folio_get_anon_vma(page_folio(src_page));
+	if (!src_anon_vma) {
+		unlock_page(src_page);
+		put_page(src_page);
+		mmu_notifier_invalidate_range_end(&range);
+		return -EAGAIN;
+	}
+	anon_vma_lock_write(src_anon_vma);
+
+	dst_ptl = pmd_lockptr(dst_mm, dst_pmd);
+	double_pt_lock(src_ptl, dst_ptl);
+	if (unlikely(!pmd_same(*src_pmd, src_pmdval) ||
+		     !pmd_same(*dst_pmd, dst_pmdval) ||
+		     page_mapcount(src_page) != 1)) {
+		double_pt_unlock(src_ptl, dst_ptl);
+		anon_vma_unlock_write(src_anon_vma);
+		put_anon_vma(src_anon_vma);
+		unlock_page(src_page);
+		put_page(src_page);
+		mmu_notifier_invalidate_range_end(&range);
+		return -EAGAIN;
+	}
+
+	BUG_ON(!PageHead(src_page));
+	BUG_ON(!PageAnon(src_page));
+	/* the PT lock is enough to keep the page pinned now */
+	put_page(src_page);
+
+	dst_anon_vma = (void *) dst_vma->anon_vma + PAGE_MAPPING_ANON;
+	WRITE_ONCE(src_page->mapping, (struct address_space *) dst_anon_vma);
+	WRITE_ONCE(src_page->index, linear_page_index(dst_vma, dst_addr));
+
+	if (!pmd_same(pmdp_huge_clear_flush(src_vma, src_addr, src_pmd),
+		      src_pmdval))
+		BUG_ON(1);
+	_dst_pmd = mk_huge_pmd(src_page, dst_vma->vm_page_prot);
+	_dst_pmd = maybe_pmd_mkwrite(pmd_mkdirty(_dst_pmd), dst_vma);
+	set_pmd_at(dst_mm, dst_addr, dst_pmd, _dst_pmd);
+
+	pgtable = pgtable_trans_huge_withdraw(src_mm, src_pmd);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (dst_mm != src_mm) {
+		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+		add_mm_counter(src_mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	}
+	double_pt_unlock(src_ptl, dst_ptl);
+
+	anon_vma_unlock_write(src_anon_vma);
+	put_anon_vma(src_anon_vma);
+
+	/* unblock rmap walks */
+	unlock_page(src_page);
+
+	mmu_notifier_invalidate_range_end(&range);
+	return 0;
+}
+#endif /* CONFIG_USERFAULTFD */
+
 /*
  * Returns page table lock pointer if a given pmd maps a thp, NULL otherwise.
  *
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 88433cc25d8a..af23248b3551 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1135,6 +1135,9 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	 * Prevent all access to pagetables with the exception of
 	 * gup_fast later handled by the ptep_clear_flush and the VM
 	 * handled by the anon_vma lock + PG_lock.
+	 *
+	 * UFFDIO_REMAP is prevented to race as well thanks to the
+	 * mmap_lock.
 	 */
 	mmap_write_lock(mm);
 	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 96d9eae5c7cc..0cca60dfa8f8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -842,3 +842,589 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	mmap_read_unlock(dst_mm);
 	return err;
 }
+
+
+void double_pt_lock(spinlock_t *ptl1,
+		    spinlock_t *ptl2)
+	__acquires(ptl1)
+	__acquires(ptl2)
+{
+	spinlock_t *ptl_tmp;
+
+	if (ptl1 > ptl2) {
+		/* exchange ptl1 and ptl2 */
+		ptl_tmp = ptl1;
+		ptl1 = ptl2;
+		ptl2 = ptl_tmp;
+	}
+	/* lock in virtual address order to avoid lock inversion */
+	spin_lock(ptl1);
+	if (ptl1 != ptl2)
+		spin_lock_nested(ptl2, SINGLE_DEPTH_NESTING);
+	else
+		__acquire(ptl2);
+}
+
+void double_pt_unlock(spinlock_t *ptl1,
+		      spinlock_t *ptl2)
+	__releases(ptl1)
+	__releases(ptl2)
+{
+	spin_unlock(ptl1);
+	if (ptl1 != ptl2)
+		spin_unlock(ptl2);
+	else
+		__release(ptl2);
+}
+
+/*
+ * The mmap_lock for reading is held by the caller. Just move the page
+ * from src_pmd to dst_pmd if possible, and return true if succeeded
+ * in moving the page.
+ */
+static int remap_pages_pte(struct mm_struct *dst_mm,
+			   struct mm_struct *src_mm,
+			   pmd_t *dst_pmd,
+			   pmd_t *src_pmd,
+			   struct vm_area_struct *dst_vma,
+			   struct vm_area_struct *src_vma,
+			   unsigned long dst_addr,
+			   unsigned long src_addr,
+			   __u64 mode)
+{
+	swp_entry_t entry;
+	pte_t orig_src_pte, orig_dst_pte;
+	spinlock_t *src_ptl, *dst_ptl;
+	pte_t *src_pte = NULL;
+	pte_t *dst_pte = NULL;
+
+	struct folio *src_folio = NULL;
+	struct anon_vma *src_anon_vma = NULL;
+	struct anon_vma *dst_anon_vma;
+	struct mmu_notifier_range range;
+	int err = 0;
+
+retry:
+	dst_pte = pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, &dst_ptl);
+
+	/* If an huge pmd materialized from under us fail */
+	if (unlikely(!dst_pte)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	src_pte = pte_offset_map_nolock(src_mm, src_pmd, src_addr, &src_ptl);
+
+	/*
+	 * We held the mmap_lock for reading so MADV_DONTNEED
+	 * can zap transparent huge pages under us, or the
+	 * transparent huge page fault can establish new
+	 * transparent huge pages under us.
+	 */
+	if (unlikely(!src_pte)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	BUG_ON(pmd_none(*dst_pmd));
+	BUG_ON(pmd_none(*src_pmd));
+	BUG_ON(pmd_trans_huge(*dst_pmd));
+	BUG_ON(pmd_trans_huge(*src_pmd));
+
+	spin_lock(dst_ptl);
+	orig_dst_pte = *dst_pte;
+	spin_unlock(dst_ptl);
+	if (!pte_none(orig_dst_pte)) {
+		err = -EEXIST;
+		goto out;
+	}
+
+	spin_lock(src_ptl);
+	orig_src_pte = *src_pte;
+	spin_unlock(src_ptl);
+	if (pte_none(orig_src_pte)) {
+		if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES))
+			err = -ENOENT;
+		else /* nothing to do to remap a hole */
+			err = 0;
+		goto out;
+	}
+
+	if (pte_present(orig_src_pte)) {
+		if (!src_folio) {
+			struct folio *folio;
+
+			/*
+			 * Pin the page while holding the lock to be sure the
+			 * page isn't freed under us
+			 */
+			spin_lock(src_ptl);
+			if (!pte_same(orig_src_pte, *src_pte)) {
+				spin_unlock(src_ptl);
+				err = -EAGAIN;
+				goto out;
+			}
+
+			folio = vm_normal_folio(src_vma, src_addr, orig_src_pte);
+			if (!folio || !folio_test_anon(folio) ||
+			    folio_estimated_sharers(folio) != 1) {
+				spin_unlock(src_ptl);
+				err = -EBUSY;
+				goto out;
+			}
+
+			src_folio = folio;
+			folio_get(src_folio);
+			spin_unlock(src_ptl);
+
+			/* try to block all concurrent rmap walks */
+			if (!folio_trylock(src_folio)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte = dst_pte = NULL;
+				folio_lock(src_folio);
+				goto retry;
+			}
+		}
+
+		if (!src_anon_vma) {
+			/*
+			 * folio_referenced walks the anon_vma chain
+			 * without the folio lock. Serialize against it with
+			 * the anon_vma lock, the folio lock is not enough.
+			 */
+			src_anon_vma = folio_get_anon_vma(src_folio);
+			if (!src_anon_vma) {
+				/* page was unmapped from under us */
+				err = -EAGAIN;
+				goto out;
+			}
+			if (!anon_vma_trylock_write(src_anon_vma)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte = dst_pte = NULL;
+				anon_vma_lock_write(src_anon_vma);
+				goto retry;
+			}
+		}
+
+		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
+					src_addr, src_addr + PAGE_SIZE);
+		mmu_notifier_invalidate_range_start_nonblock(&range);
+
+		double_pt_lock(dst_ptl, src_ptl);
+
+		if (!pte_same(*src_pte, orig_src_pte) ||
+		    !pte_same(*dst_pte, orig_dst_pte) ||
+		    folio_estimated_sharers(src_folio) != 1) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			err = -EAGAIN;
+			goto out;
+		}
+
+		BUG_ON(!folio_test_anon(src_folio));
+		/* the PT lock is enough to keep the page pinned now */
+		folio_put(src_folio);
+
+		dst_anon_vma = (void *) dst_vma->anon_vma + PAGE_MAPPING_ANON;
+		WRITE_ONCE(src_folio->mapping,
+			   (struct address_space *) dst_anon_vma);
+		WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
+							      dst_addr));
+
+		if (!pte_same(ptep_clear_flush(src_vma, src_addr, src_pte),
+			      orig_src_pte))
+			BUG_ON(1);
+
+		orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
+		orig_dst_pte = maybe_mkwrite(pte_mkdirty(orig_dst_pte),
+					     dst_vma);
+
+		set_pte_at(dst_mm, dst_addr, dst_pte, orig_dst_pte);
+
+		if (dst_mm != src_mm) {
+			inc_mm_counter(dst_mm, MM_ANONPAGES);
+			dec_mm_counter(src_mm, MM_ANONPAGES);
+		}
+
+		double_pt_unlock(dst_ptl, src_ptl);
+
+		anon_vma_unlock_write(src_anon_vma);
+		mmu_notifier_invalidate_range_end(&range);
+		put_anon_vma(src_anon_vma);
+		src_anon_vma = NULL;
+
+		/* unblock rmap walks */
+		folio_unlock(src_folio);
+		src_folio = NULL;
+
+	} else {
+		struct swap_info_struct *si;
+		int swap_count;
+
+		entry = pte_to_swp_entry(orig_src_pte);
+		if (non_swap_entry(entry)) {
+			if (is_migration_entry(entry)) {
+				pte_unmap(&orig_src_pte);
+				pte_unmap(&orig_dst_pte);
+				src_pte = dst_pte = NULL;
+				migration_entry_wait(src_mm, src_pmd,
+						     src_addr);
+				err = -EAGAIN;
+			} else
+				err = -EFAULT;
+			goto out;
+		}
+
+		/*
+		 * COUNT_CONTINUE to be returned is fine here, no need
+		 * of follow all swap continuation to check against
+		 * number 1.
+		 */
+		si = get_swap_device(entry);
+		if (!si) {
+			err = -EBUSY;
+			goto out;
+		}
+
+		swap_count = swap_swapcount(si, entry);
+		put_swap_device(si);
+		if (swap_count != 1) {
+			err = -EBUSY;
+			goto out;
+		}
+
+		double_pt_lock(dst_ptl, src_ptl);
+
+		if (!pte_same(*src_pte, orig_src_pte) ||
+		    !pte_same(*dst_pte, orig_dst_pte) ||
+		    swp_swapcount(entry) != 1) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			err = -EAGAIN;
+			goto out;
+		}
+
+		if (pte_val(ptep_get_and_clear(src_mm, src_addr, src_pte)) !=
+		    pte_val(orig_src_pte))
+			BUG_ON(1);
+		set_pte_at(dst_mm, dst_addr, dst_pte, orig_src_pte);
+
+		if (dst_mm != src_mm) {
+			inc_mm_counter(dst_mm, MM_ANONPAGES);
+			dec_mm_counter(src_mm, MM_ANONPAGES);
+		}
+
+		double_pt_unlock(dst_ptl, src_ptl);
+	}
+
+out:
+	if (src_anon_vma) {
+		anon_vma_unlock_write(src_anon_vma);
+		put_anon_vma(src_anon_vma);
+	}
+	if (src_folio) {
+		folio_unlock(src_folio);
+		folio_put(src_folio);
+	}
+	if (dst_pte)
+		pte_unmap(dst_pte);
+	if (src_pte)
+		pte_unmap(src_pte);
+
+	return err;
+}
+
+/**
+ * remap_pages - remap arbitrary anonymous pages of an existing vma
+ * @dst_start: start of the destination virtual memory range
+ * @src_start: start of the source virtual memory range
+ * @len: length of the virtual memory range
+ *
+ * remap_pages() remaps arbitrary anonymous pages atomically in zero
+ * copy. It only works on non shared anonymous pages because those can
+ * be relocated without generating non linear anon_vmas in the rmap
+ * code.
+ *
+ * It provides a zero copy mechanism to handle userspace page faults.
+ * The source vma pages should have mapcount == 1, which can be
+ * enforced by using madvise(MADV_DONTFORK) on src vma.
+ *
+ * The thread receiving the page during the userland page fault
+ * will receive the faulting page in the source vma through the network,
+ * storage or any other I/O device (MADV_DONTFORK in the source vma
+ * avoids remap_pages() to fail with -EBUSY if the process forks before
+ * remap_pages() is called), then it will call remap_pages() to map the
+ * page in the faulting address in the destination vma.
+ *
+ * This userfaultfd command works purely via pagetables, so it's the
+ * most efficient way to move physical non shared anonymous pages
+ * across different virtual addresses. Unlike mremap()/mmap()/munmap()
+ * it does not create any new vmas. The mapping in the destination
+ * address is atomic.
+ *
+ * It only works if the vma protection bits are identical from the
+ * source and destination vma.
+ *
+ * It can remap non shared anonymous pages within the same vma too.
+ *
+ * If the source virtual memory range has any unmapped holes, or if
+ * the destination virtual memory range is not a whole unmapped hole,
+ * remap_pages() will fail respectively with -ENOENT or -EEXIST. This
+ * provides a very strict behavior to avoid any chance of memory
+ * corruption going unnoticed if there are userland race conditions.
+ * Only one thread should resolve the userland page fault at any given
+ * time for any given faulting address. This means that if two threads
+ * try to both call remap_pages() on the same destination address at the
+ * same time, the second thread will get an explicit error from this
+ * command.
+ *
+ * The command retval will return "len" is successful. The command
+ * however can be interrupted by fatal signals or errors. If
+ * interrupted it will return the number of bytes successfully
+ * remapped before the interruption if any, or the negative error if
+ * none. It will never return zero. Either it will return an error or
+ * an amount of bytes successfully moved. If the retval reports a
+ * "short" remap, the remap_pages() command should be repeated by
+ * userland with src+retval, dst+reval, len-retval if it wants to know
+ * about the error that interrupted it.
+ *
+ * The UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES flag can be specified to
+ * prevent -ENOENT errors to materialize if there are holes in the
+ * source virtual range that is being remapped. The holes will be
+ * accounted as successfully remapped in the retval of the
+ * command. This is mostly useful to remap hugepage naturally aligned
+ * virtual regions without knowing if there are transparent hugepage
+ * in the regions or not, but preventing the risk of having to split
+ * the hugepmd during the remap.
+ *
+ * If there's any rmap walk that is taking the anon_vma locks without
+ * first obtaining the folio lock (for example split_huge_page and
+ * folio_referenced), they will have to verify if the folio->mapping
+ * has changed after taking the anon_vma lock. If it changed they
+ * should release the lock and retry obtaining a new anon_vma, because
+ * it means the anon_vma was changed by remap_pages() before the lock
+ * could be obtained. This is the only additional complexity added to
+ * the rmap code to provide this anonymous page remapping functionality.
+ */
+ssize_t remap_pages(struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		    unsigned long dst_start, unsigned long src_start,
+		    unsigned long len, __u64 mode)
+{
+	struct vm_area_struct *src_vma, *dst_vma;
+	long err = -EINVAL;
+	pmd_t *src_pmd, *dst_pmd;
+	unsigned long src_addr, dst_addr;
+	int thp_aligned = -1;
+	ssize_t moved = 0;
+
+	/*
+	 * Sanitize the command parameters:
+	 */
+	BUG_ON(src_start & ~PAGE_MASK);
+	BUG_ON(dst_start & ~PAGE_MASK);
+	BUG_ON(len & ~PAGE_MASK);
+
+	/* Does the address range wrap, or is the span zero-sized? */
+	BUG_ON(src_start + len <= src_start);
+	BUG_ON(dst_start + len <= dst_start);
+
+	/*
+	 * Because these are read sempahores there's no risk of lock
+	 * inversion.
+	 */
+	mmap_read_lock(dst_mm);
+	if (dst_mm != src_mm)
+		mmap_read_lock(src_mm);
+
+	/*
+	 * Make sure the vma is not shared, that the src and dst remap
+	 * ranges are both valid and fully within a single existing
+	 * vma.
+	 */
+	src_vma = find_vma(src_mm, src_start);
+	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
+		goto out;
+	if (src_start < src_vma->vm_start ||
+	    src_start + len > src_vma->vm_end)
+		goto out;
+
+	dst_vma = find_vma(dst_mm, dst_start);
+	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
+		goto out;
+	if (dst_start < dst_vma->vm_start ||
+	    dst_start + len > dst_vma->vm_end)
+		goto out;
+
+	if (pgprot_val(src_vma->vm_page_prot) !=
+	    pgprot_val(dst_vma->vm_page_prot))
+		goto out;
+
+	/* only allow remapping if both are mlocked or both aren't */
+	if ((src_vma->vm_flags & VM_LOCKED) ^ (dst_vma->vm_flags & VM_LOCKED))
+		goto out;
+
+	/*
+	 * Be strict and only allow remap_pages if either the src or
+	 * dst range is registered in the userfaultfd to prevent
+	 * userland errors going unnoticed. As far as the VM
+	 * consistency is concerned, it would be perfectly safe to
+	 * remove this check, but there's no useful usage for
+	 * remap_pages ouside of userfaultfd registered ranges. This
+	 * is after all why it is an ioctl belonging to the
+	 * userfaultfd and not a syscall.
+	 *
+	 * Allow both vmas to be registered in the userfaultfd, just
+	 * in case somebody finds a way to make such a case useful.
+	 * Normally only one of the two vmas would be registered in
+	 * the userfaultfd.
+	 */
+	if (!dst_vma->vm_userfaultfd_ctx.ctx &&
+	    !src_vma->vm_userfaultfd_ctx.ctx)
+		goto out;
+
+	/*
+	 * FIXME: only allow remapping across anonymous vmas,
+	 * tmpfs should be added.
+	 */
+	if (src_vma->vm_ops || dst_vma->vm_ops)
+		goto out;
+
+	/*
+	 * Ensure the dst_vma has a anon_vma or this page
+	 * would get a NULL anon_vma when moved in the
+	 * dst_vma.
+	 */
+	err = -ENOMEM;
+	if (unlikely(anon_vma_prepare(dst_vma)))
+		goto out;
+
+	for (src_addr = src_start, dst_addr = dst_start;
+	     src_addr < src_start + len;) {
+		spinlock_t *ptl;
+		pmd_t dst_pmdval;
+
+		BUG_ON(dst_addr >= dst_start + len);
+		src_pmd = mm_find_pmd(src_mm, src_addr);
+		if (unlikely(!src_pmd)) {
+			if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES)) {
+				err = -ENOENT;
+				break;
+			}
+			src_pmd = mm_alloc_pmd(src_mm, src_addr);
+			if (unlikely(!src_pmd)) {
+				err = -ENOMEM;
+				break;
+			}
+		}
+		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
+		if (unlikely(!dst_pmd)) {
+			err = -ENOMEM;
+			break;
+		}
+
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		/*
+		 * If the dst_pmd is mapped as THP don't
+		 * override it and just be strict.
+		 */
+		if (unlikely(pmd_trans_huge(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
+		ptl = pmd_trans_huge_lock(src_pmd, src_vma);
+		if (ptl) {
+			/*
+			 * Check if we can move the pmd without
+			 * splitting it. First check the address
+			 * alignment to be the same in src/dst.  These
+			 * checks don't actually need the PT lock but
+			 * it's good to do it here to optimize this
+			 * block away at build time if
+			 * CONFIG_TRANSPARENT_HUGEPAGE is not set.
+			 */
+			if (thp_aligned == -1)
+				thp_aligned = ((src_addr & ~HPAGE_PMD_MASK) ==
+					       (dst_addr & ~HPAGE_PMD_MASK));
+			if (!thp_aligned || (src_addr & ~HPAGE_PMD_MASK) ||
+			    !pmd_none(dst_pmdval) ||
+			    src_start + len - src_addr < HPAGE_PMD_SIZE) {
+				spin_unlock(ptl);
+				/* Fall through */
+				split_huge_pmd(src_vma, src_pmd, src_addr);
+			} else {
+				err = remap_pages_huge_pmd(dst_mm,
+							   src_mm,
+							   dst_pmd,
+							   src_pmd,
+							   dst_pmdval,
+							   dst_vma,
+							   src_vma,
+							   dst_addr,
+							   src_addr);
+				cond_resched();
+
+				if (!err) {
+					dst_addr += HPAGE_PMD_SIZE;
+					src_addr += HPAGE_PMD_SIZE;
+					moved += HPAGE_PMD_SIZE;
+				}
+
+				if ((!err || err == -EAGAIN) &&
+				    fatal_signal_pending(current))
+					err = -EINTR;
+
+				if (err && err != -EAGAIN)
+					break;
+
+				continue;
+			}
+		}
+
+		if (pmd_none(*src_pmd)) {
+			if (!(mode & UFFDIO_REMAP_MODE_ALLOW_SRC_HOLES)) {
+				err = -ENOENT;
+				break;
+			}
+			if (unlikely(__pte_alloc(src_mm, src_pmd))) {
+				err = -ENOMEM;
+				break;
+			}
+		}
+
+		if (unlikely(pmd_none(dst_pmdval)) &&
+		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+			err = -ENOMEM;
+			break;
+		}
+
+		err = remap_pages_pte(dst_mm, src_mm,
+				      dst_pmd, src_pmd,
+				      dst_vma, src_vma,
+				      dst_addr, src_addr,
+				      mode);
+
+		cond_resched();
+
+		if (!err) {
+			dst_addr += PAGE_SIZE;
+			src_addr += PAGE_SIZE;
+			moved += PAGE_SIZE;
+		}
+
+		if ((!err || err == -EAGAIN) &&
+		    fatal_signal_pending(current))
+			err = -EINTR;
+
+		if (err && err != -EAGAIN)
+			break;
+	}
+
+out:
+	mmap_read_unlock(dst_mm);
+	if (dst_mm != src_mm)
+		mmap_read_unlock(src_mm);
+	BUG_ON(moved < 0);
+	BUG_ON(err > 0);
+	BUG_ON(!moved && !err);
+	return moved ? moved : err;
+}
-- 
2.42.0.283.g2d96d420d3-goog

