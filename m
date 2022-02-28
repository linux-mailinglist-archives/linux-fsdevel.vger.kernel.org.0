Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADE54C7EE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiB1X7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiB1X7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:59:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C92506D5;
        Mon, 28 Feb 2022 15:58:19 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4so12577442pjh.2;
        Mon, 28 Feb 2022 15:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PYzHG/r/zQJfX7Jqdvp+ttkJo6GETokQfZcD3GwLWs8=;
        b=SwTpvGt1o++d9q/YF6TkggxExOdqLIPnW6LotUSHwj+vou9wxNG/ApPWwYoJlBAb2L
         m2PII6WBUyNjfhBbIzPYAWKG+RWhIFep0dOuKK3KGRr5OWmi8bQrANDC7tFYVCXdyVOI
         jsiCyJg7Ryf02RqlLKWSWCnL8nqqg3b0obMQ6iibCh+FOGbuleLru+hTqPity+EQ2na9
         WVhYXH+dzGnZqQRqFuhwN5wV152RMgWgc31oOZd/DneDkFd//MADonXge+HZkWl+OSlW
         5ou5ygKDfNQz9WjWHxhdNO71sz4DZ/jSF2kgDEm5SHDE+Nc4qj9hjEDB6+4GQlaNtG+i
         KI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PYzHG/r/zQJfX7Jqdvp+ttkJo6GETokQfZcD3GwLWs8=;
        b=00FdCpvk+dFEwEHTxeOXYoCpdZMBz9SM7J0WaDXBTjwg2ujZuQe0cl+AyderYiSAWr
         45QlrD05hKrx6Pg//JdxTOwJD/nD0MvQ7GpZy+0BOoGnOMfDeRFVIgmHpwVphukUxCI0
         f8m/Ndhyt4MTxMwU7FdWlKnBHjm3O3RRQq41nOrfe/o3tp7O5bKxepttPC/C3BKrQdsI
         WOj7TalTUnD4k5ejgJsO3ELV1j+3WdzUu9EkRZfBPJ4ZANbUHA3eKPjVzuQhyIQHZU43
         mAqGwvGdNHjrAD0WbR/foUbtRtQxYgCtppD1Fo7gtZMqHh5Yk+KMc9913iAaRlLP/+eN
         n5xw==
X-Gm-Message-State: AOAM533HvVLTabUX113PWmOGJJmUswdHW9rl4s4Sr9psZq+tFLjyPblL
        caJ6L4ulsBVwfiEEHNmkQUc=
X-Google-Smtp-Source: ABdhPJyurHvAr5zzgjNeHZWTfLVrv7GL1aHUSkClbjW1FEdxYfjL1nZKILiili3ESpSsU8yJM0MUTQ==
X-Received: by 2002:a17:902:7296:b0:14f:2a67:b400 with SMTP id d22-20020a170902729600b0014f2a67b400mr23297170pll.172.1646092698866;
        Mon, 28 Feb 2022 15:58:18 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:18 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] mm: khugepaged: make khugepaged_enter() void function
Date:   Mon, 28 Feb 2022 15:57:38 -0800
Message-Id: <20220228235741.102941-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220228235741.102941-1-shy828301@gmail.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The most callers of khugepaged_enter() don't care about the return
value.  Only dup_mmap(), anonymous THP page fault and MADV_HUGEPAGE handle
the error by returning -ENOMEM.  Actually it is not harmful for them to
ignore the error case either.  It also sounds overkilling to fail fork()
and page fault early due to khugepaged_enter() error, and MADV_HUGEPAGE
does set VM_HUGEPAGE flag regardless of the error.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h | 30 ++++++++++++------------------
 kernel/fork.c              |  4 +---
 mm/huge_memory.c           |  4 ++--
 mm/khugepaged.c            | 18 +++++++-----------
 4 files changed, 22 insertions(+), 34 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 2fcc01891b47..0423d3619f26 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -12,10 +12,10 @@ extern struct attribute_group khugepaged_attr_group;
 extern int khugepaged_init(void);
 extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
-extern int __khugepaged_enter(struct mm_struct *mm);
+extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-				      unsigned long vm_flags);
+extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
+				       unsigned long vm_flags);
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
@@ -40,11 +40,10 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 	(transparent_hugepage_flags &				\
 	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
 
-static inline int khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
-		return __khugepaged_enter(mm);
-	return 0;
+		__khugepaged_enter(mm);
 }
 
 static inline void khugepaged_exit(struct mm_struct *mm)
@@ -53,7 +52,7 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 		__khugepaged_exit(mm);
 }
 
-static inline int khugepaged_enter(struct vm_area_struct *vma,
+static inline void khugepaged_enter(struct vm_area_struct *vma,
 				   unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
@@ -62,27 +61,22 @@ static inline int khugepaged_enter(struct vm_area_struct *vma,
 		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
 		    !(vm_flags & VM_NOHUGEPAGE) &&
 		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-			if (__khugepaged_enter(vma->vm_mm))
-				return -ENOMEM;
-	return 0;
+			__khugepaged_enter(vma->vm_mm);
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
-static inline int khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return 0;
 }
 static inline void khugepaged_exit(struct mm_struct *mm)
 {
 }
-static inline int khugepaged_enter(struct vm_area_struct *vma,
-				   unsigned long vm_flags)
+static inline void khugepaged_enter(struct vm_area_struct *vma,
+				    unsigned long vm_flags)
 {
-	return 0;
 }
-static inline int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-					     unsigned long vm_flags)
+static inline void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
+					      unsigned long vm_flags)
 {
-	return 0;
 }
 static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 					   unsigned long addr)
diff --git a/kernel/fork.c b/kernel/fork.c
index a024bf6254df..dc85418c426a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -523,9 +523,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	retval = ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
-	retval = khugepaged_fork(mm, oldmm);
-	if (retval)
-		goto out;
+	khugepaged_fork(mm, oldmm);
 
 	prev = NULL;
 	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a87b3df63209..ec2490d6af09 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -725,8 +725,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 		return VM_FAULT_FALLBACK;
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
-	if (unlikely(khugepaged_enter(vma, vma->vm_flags)))
-		return VM_FAULT_OOM;
+	khugepaged_enter(vma, vma->vm_flags);
+
 	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
 			!mm_forbids_zeropage(vma->vm_mm) &&
 			transparent_hugepage_use_zero_page()) {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3dbac3e23f43..b87af297e652 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -366,8 +366,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 		 * register it here without waiting a page fault that
 		 * may not happen any time soon.
 		 */
-		if (khugepaged_enter_vma_merge(vma, *vm_flags))
-			return -ENOMEM;
+		khugepaged_enter_vma_merge(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
@@ -476,20 +475,20 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	return true;
 }
 
-int __khugepaged_enter(struct mm_struct *mm)
+void __khugepaged_enter(struct mm_struct *mm)
 {
 	struct mm_slot *mm_slot;
 	int wakeup;
 
 	mm_slot = alloc_mm_slot();
 	if (!mm_slot)
-		return -ENOMEM;
+		return;
 
 	/* __khugepaged_exit() must not run from under us */
 	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
 	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags))) {
 		free_mm_slot(mm_slot);
-		return 0;
+		return;
 	}
 
 	spin_lock(&khugepaged_mm_lock);
@@ -505,11 +504,9 @@ int __khugepaged_enter(struct mm_struct *mm)
 	mmgrab(mm);
 	if (wakeup)
 		wake_up_interruptible(&khugepaged_wait);
-
-	return 0;
 }
 
-int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
+void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 			       unsigned long vm_flags)
 {
 	unsigned long hstart, hend;
@@ -520,13 +517,12 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 	 * file-private shmem THP is not supported.
 	 */
 	if (!hugepage_vma_check(vma, vm_flags))
-		return 0;
+		return;
 
 	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
 	hend = vma->vm_end & HPAGE_PMD_MASK;
 	if (hstart < hend)
-		return khugepaged_enter(vma, vm_flags);
-	return 0;
+		khugepaged_enter(vma, vm_flags);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
-- 
2.26.3

