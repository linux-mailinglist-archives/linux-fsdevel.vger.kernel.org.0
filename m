Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C15522588
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiEJUc6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiEJUcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:54 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170801E59EE;
        Tue, 10 May 2022 13:32:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e24so270694pjt.2;
        Tue, 10 May 2022 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9bzLXPvJlgXInWKC0z0h8GbSnE9t748YFrNrW9sv0OI=;
        b=WjvoN+m7G642VMfbU7y7zcodnFSwJKNI8fyCg6WKeEpTIH/equCwbRBnEtxhSsnJhg
         fhCoCrPsm4pYIXuNj1z4bsDWzM1z8+S6z0dYtRLwGekuSs8oaOxcdHyymd7RavAg4K9e
         ks12ff48l1DYz9LgyOrWAHZrwDGsVuuNXj86JpBJqraJrwv/Rc/5b8V3NEBh2qCkT/JZ
         n3XtXcyIzKwY2C4SrHnXZ5V2TftIlEcpTLUMa+N7Q6q0+ciTlOD0PAXBUxaikpG6NLvW
         O4QPt4JKd025ddS0y8luVYzS+aX6rU7lvUlo6sGJpPvf4BRNxZPDPbXUCYoSdnRbIGBn
         C0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bzLXPvJlgXInWKC0z0h8GbSnE9t748YFrNrW9sv0OI=;
        b=3CmvNrLuBCQBjGYaKATsaEyrLoMHSpM0IcE2ElBMXNGNqDnYvgIM86EvP87kVOy9Xj
         CLzH/J6SRTLSg5AwDNxtx63LSUyIK1pSkNy06hfCHVFFKmcmOqIN+1RleuwyVygw4Zcx
         0ssXG9yL62amNDDbXHBxJNsRiFDjZ90LFuyYfJZUUV5J3VVhGBznT7pVCdHyAPZHKHdb
         H8X/rjxP+AaGjARfe5KsjFetKMys9MNhIsLuPcCMuidGWFgFq/Rvg7Tk6negfzBde35O
         wwD6g1d3YH45sHYWcOxNYVa+0D/OZxIuDyG68Dv0yt8fl+6+qqWt0DtvbLMsfqhl9EJ6
         BbXw==
X-Gm-Message-State: AOAM53142AEglB4/77CGTu9OGPcgPAL5hM9+obdH418ebt4MKbA/y0q/
        OtOnkxymMn8sqR6bXwz5KDs=
X-Google-Smtp-Source: ABdhPJzetWxUglmKPTIJxEKFg5ditoKwCl0dD+Zohh3huaS4wvuUbDFl6MB0fZWj/K2+e7s1mXtubw==
X-Received: by 2002:a17:90a:bd95:b0:1d9:6735:e9ef with SMTP id z21-20020a17090abd9500b001d96735e9efmr1618657pjr.157.1652214765595;
        Tue, 10 May 2022 13:32:45 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:45 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 5/8] mm: khugepaged: make khugepaged_enter() void function
Date:   Tue, 10 May 2022 13:32:19 -0700
Message-Id: <20220510203222.24246-6-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220510203222.24246-1-shy828301@gmail.com>
References: <20220510203222.24246-1-shy828301@gmail.com>
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

Acked-by: Song Liu <song@kernel.org>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
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
index 536dc3289734..6692f5d78371 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -608,9 +608,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	retval = ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
-	retval = khugepaged_fork(mm, oldmm);
-	if (retval)
-		goto out;
+	khugepaged_fork(mm, oldmm);
 
 	retval = mas_expected_entries(&mas, oldmm->map_count);
 	if (retval)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 82434a9d4499..80e8b58b4f39 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -726,8 +726,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
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
index c0d3215008ba..7815218ab960 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -365,8 +365,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 		 * register it here without waiting a page fault that
 		 * may not happen any time soon.
 		 */
-		if (khugepaged_enter_vma_merge(vma, *vm_flags))
-			return -ENOMEM;
+		khugepaged_enter_vma_merge(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
@@ -475,20 +474,20 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
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
@@ -504,11 +503,9 @@ int __khugepaged_enter(struct mm_struct *mm)
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
@@ -519,13 +516,12 @@ int khugepaged_enter_vma_merge(struct vm_area_struct *vma,
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

