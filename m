Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27CC4EAED3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiC2NwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbiC2NwA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:52:00 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA92186F9A
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w7so13266579pfu.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pquxx3qH2nuqmnC96VcgoZZu7sN0crimqByO4QYpxLI=;
        b=oQLhz53anwt4ILImkOxJ+rt/T/W68dglu9K98xYhD8rw+vwfthUTW0dlUF8vK73ffS
         Kv3IyJwBAManxnSc7qMd6HVrXGOcrmlEd9PUFM1/o4FKfPU7W/CIfqGtKeBwLXPu1Q4t
         rxxXG/rtme18YD+1HWkiEXrBu84RD8iXJNM00tyT9mm1bqKI5JGbw4yzwyfnFxAVrXbd
         Yk9O3W0irr+zwnhCLF3Xcvf/NWQURV1ee5Et+3KdaXBWcOjGFYjeMP2EgatcjC/6D/uG
         tQoLY1hSo0kNxBNJcz1UQn+rraUqyPegGACymxj/UrrDw/JhKQZPhtl4M52HOW6NNfsf
         RFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pquxx3qH2nuqmnC96VcgoZZu7sN0crimqByO4QYpxLI=;
        b=Z46dOQNfRQPJXHogJNh7wBIG+13ZPj8Y2gcY52H9Tc6QWre9uQoH86Dx+iViPZOQtw
         FxFt0E9M2IzlDX5HMO4y9Ib4iWFTLhtKIfYelSeBMaW5C+0eajwo8xgnshykopIZfzkS
         LTLzAmgQKqgsPRTT/jJ/xDYtzOUoTS/tEcpv54mod11CM49Z2KiAYlGxmNhrl9iteEWR
         o2BDHEVnazU3N3V4Zk+aWEPt/N2B8LVvhUFQl1PxaIxjasNwkxG8v8ZHXAGMMFXzkjmK
         H0Z4T6SO/j0tcpxrHKJ65aTxkJHBKwg8kbqItWNUPGayeifpNI97SsvOp/JJlQeQ9LaC
         qu7g==
X-Gm-Message-State: AOAM532IEAWpUfoGLOD8Nq69S6/7P0MCd9pSH1ciOizzMm/neZQJ3ZDS
        3F19hlXu6TzOuhjNlHdnN74Frw==
X-Google-Smtp-Source: ABdhPJyTEtUT0mAGxDz5bcPBQWC+tSTA07XI+vJ4sxeO4APu0XKS8tsBFbZC6aGY6wMBrL/C65Wt8Q==
X-Received: by 2002:a63:f418:0:b0:382:b4f6:5f95 with SMTP id g24-20020a63f418000000b00382b4f65f95mr2084659pgi.619.1648561817153;
        Tue, 29 Mar 2022 06:50:17 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm20911293pfu.205.2022.03.29.06.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:50:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org,
        hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 6/6] mm: simplify follow_invalidate_pte()
Date:   Tue, 29 Mar 2022 21:48:53 +0800
Message-Id: <20220329134853.68403-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220329134853.68403-1-songmuchun@bytedance.com>
References: <20220329134853.68403-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only user (DAX) of range and pmdpp parameters of follow_invalidate_pte()
is gone, it is safe to remove them and make it static to simlify the code.
This is revertant of the following commits:

  097963959594 ("mm: add follow_pte_pmd()")
  a4d1a8852513 ("dax: update to new mmu_notifier semantic")

There is only one caller of the follow_invalidate_pte().  So just fold it
into follow_pte() and remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/mm.h |  3 --
 mm/memory.c        | 81 ++++++++++++++++--------------------------------------
 2 files changed, 23 insertions(+), 61 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9bada4096ac..be7ec4c37ebe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1871,9 +1871,6 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
-int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
-			  struct mmu_notifier_range *range, pte_t **ptepp,
-			  pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
diff --git a/mm/memory.c b/mm/memory.c
index cc6968dc8e4e..84f7250e6cd1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4964,9 +4964,29 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
-			  struct mmu_notifier_range *range, pte_t **ptepp,
-			  pmd_t **pmdpp, spinlock_t **ptlp)
+/**
+ * follow_pte - look up PTE at a user virtual address
+ * @mm: the mm_struct of the target address space
+ * @address: user virtual address
+ * @ptepp: location to store found PTE
+ * @ptlp: location to store the lock for the PTE
+ *
+ * On a successful return, the pointer to the PTE is stored in @ptepp;
+ * the corresponding lock is taken and its location is stored in @ptlp.
+ * The contents of the PTE are only stable until @ptlp is released;
+ * any further use, if any, must be protected against invalidation
+ * with MMU notifiers.
+ *
+ * Only IO mappings and raw PFN mappings are allowed.  The mmap semaphore
+ * should be taken for read.
+ *
+ * KVM uses this function.  While it is arguably less bad than ``follow_pfn``,
+ * it is not a good general-purpose API.
+ *
+ * Return: zero on success, -ve otherwise.
+ */
+int follow_pte(struct mm_struct *mm, unsigned long address,
+	       pte_t **ptepp, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4989,35 +5009,9 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 	pmd = pmd_offset(pud, address);
 	VM_BUG_ON(pmd_trans_huge(*pmd));
 
-	if (pmd_huge(*pmd)) {
-		if (!pmdpp)
-			goto out;
-
-		if (range) {
-			mmu_notifier_range_init(range, MMU_NOTIFY_CLEAR, 0,
-						NULL, mm, address & PMD_MASK,
-						(address & PMD_MASK) + PMD_SIZE);
-			mmu_notifier_invalidate_range_start(range);
-		}
-		*ptlp = pmd_lock(mm, pmd);
-		if (pmd_huge(*pmd)) {
-			*pmdpp = pmd;
-			return 0;
-		}
-		spin_unlock(*ptlp);
-		if (range)
-			mmu_notifier_invalidate_range_end(range);
-	}
-
 	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
 		goto out;
 
-	if (range) {
-		mmu_notifier_range_init(range, MMU_NOTIFY_CLEAR, 0, NULL, mm,
-					address & PAGE_MASK,
-					(address & PAGE_MASK) + PAGE_SIZE);
-		mmu_notifier_invalidate_range_start(range);
-	}
 	ptep = pte_offset_map_lock(mm, pmd, address, ptlp);
 	if (!pte_present(*ptep))
 		goto unlock;
@@ -5025,38 +5019,9 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
-	if (range)
-		mmu_notifier_invalidate_range_end(range);
 out:
 	return -EINVAL;
 }
-
-/**
- * follow_pte - look up PTE at a user virtual address
- * @mm: the mm_struct of the target address space
- * @address: user virtual address
- * @ptepp: location to store found PTE
- * @ptlp: location to store the lock for the PTE
- *
- * On a successful return, the pointer to the PTE is stored in @ptepp;
- * the corresponding lock is taken and its location is stored in @ptlp.
- * The contents of the PTE are only stable until @ptlp is released;
- * any further use, if any, must be protected against invalidation
- * with MMU notifiers.
- *
- * Only IO mappings and raw PFN mappings are allowed.  The mmap semaphore
- * should be taken for read.
- *
- * KVM uses this function.  While it is arguably less bad than ``follow_pfn``,
- * it is not a good general-purpose API.
- *
- * Return: zero on success, -ve otherwise.
- */
-int follow_pte(struct mm_struct *mm, unsigned long address,
-	       pte_t **ptepp, spinlock_t **ptlp)
-{
-	return follow_invalidate_pte(mm, address, NULL, ptepp, NULL, ptlp);
-}
 EXPORT_SYMBOL_GPL(follow_pte);
 
 /**
-- 
2.11.0

