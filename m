Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58F4C631E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 07:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbiB1Gha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 01:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiB1Gh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:37:28 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0CB66F89
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:38 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a5so9362972pfv.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Feb 2022 22:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hzepAOQTsZTnVcr4QPZkWOiCoYklQmYHIbKFxu1/40=;
        b=6HLgk72Kdglyxsw+8BlARvezx741uWUej3+BnNBrAZfWtuioeXLnCZw+qyBFJRBK+m
         B/IsH1CvI0L08PqX7H7DvZ8vijJppm4uGyOD/GyeVzlZn2M3vR/G6fysXE2TfEv8e50J
         3SN77OfLp05Re90/fV2IVGp39pqSfAcY6XapPh81hqbgrd/+qsxV5w+MjnulORgnDBd9
         LTslegwrEHzpQVz5ZS/HPDqlRyhFvu3Ez/v1XqbF4dIMbYVDAQryr+wl2iYb3MX2oLQ4
         c7GHk+VsgfesZ1iveu5a6GVroAqH4FT0xKFMAMgkm4eJkrLsvbb2EdUuRNtaFgCYP2qr
         zZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hzepAOQTsZTnVcr4QPZkWOiCoYklQmYHIbKFxu1/40=;
        b=BwGax2iEdKDmsIrUw6DFYNlc0HgGyZzdTeOCm+lqlvqpJ35NqJCFaT7I41r1yIacpK
         Rf1rGjWqW3RDXtP5CjMs17zvPrMyFh0W+ElcM/9pVo/UcgkJAg8apTO1NMS+oajJr494
         oruGbR5rT6jUmvDfy/G/8xX0Dlzy39l/xbyEEqXgrdgc5ehQuAqaoLzcYHAyimsR+iVB
         T3UGY8d1/racqKtqjsSfM0Zsi70iVCEqbRuz90OgWI++RcmbOUYwGc2mQUu8IBokyhwT
         hUlWhuuUcj++iDiKOPCDqjWVYg1GPsGi0AncTVz5DT9wSdatn2QDQ8PNyeApoxdntTDY
         g9qg==
X-Gm-Message-State: AOAM532XQTe8noXad1qnao4u35I0aFfLsiz9gH5iMgkgi6U2ArqdnFBm
        wnhJd3NxRVwE/OJULoTuBU94Fg==
X-Google-Smtp-Source: ABdhPJzCQ653yZEIMrePVZZJFf43neOT6NZL3StlhvT4ynURMlRYilCnkzsv6UTG5+zZqXW071qNng==
X-Received: by 2002:a05:6a00:248c:b0:4ce:1932:80dd with SMTP id c12-20020a056a00248c00b004ce193280ddmr20084253pfv.48.1646030197701;
        Sun, 27 Feb 2022 22:36:37 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q13-20020aa7960d000000b004f13804c100sm11126472pfg.165.2022.02.27.22.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 22:36:37 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 6/6] mm: remove range parameter from follow_invalidate_pte()
Date:   Mon, 28 Feb 2022 14:35:36 +0800
Message-Id: <20220228063536.24911-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228063536.24911-1-songmuchun@bytedance.com>
References: <20220228063536.24911-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only user (DAX) of range parameter of follow_invalidate_pte()
is gone, it safe to remove the range paramter and make it static
to simlify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mm.h |  3 ---
 mm/memory.c        | 23 +++--------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

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
index cc6968dc8e4e..278ab6d62b54 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4964,9 +4964,8 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
-			  struct mmu_notifier_range *range, pte_t **ptepp,
-			  pmd_t **pmdpp, spinlock_t **ptlp)
+static int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
+				 pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4993,31 +4992,17 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 		if (!pmdpp)
 			goto out;
 
-		if (range) {
-			mmu_notifier_range_init(range, MMU_NOTIFY_CLEAR, 0,
-						NULL, mm, address & PMD_MASK,
-						(address & PMD_MASK) + PMD_SIZE);
-			mmu_notifier_invalidate_range_start(range);
-		}
 		*ptlp = pmd_lock(mm, pmd);
 		if (pmd_huge(*pmd)) {
 			*pmdpp = pmd;
 			return 0;
 		}
 		spin_unlock(*ptlp);
-		if (range)
-			mmu_notifier_invalidate_range_end(range);
 	}
 
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
@@ -5025,8 +5010,6 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
-	if (range)
-		mmu_notifier_invalidate_range_end(range);
 out:
 	return -EINVAL;
 }
@@ -5055,7 +5038,7 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp)
 {
-	return follow_invalidate_pte(mm, address, NULL, ptepp, NULL, ptlp);
+	return follow_invalidate_pte(mm, address, ptepp, NULL, ptlp);
 }
 EXPORT_SYMBOL_GPL(follow_pte);
 
-- 
2.11.0

