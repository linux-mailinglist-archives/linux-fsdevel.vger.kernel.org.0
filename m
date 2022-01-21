Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2C495B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 08:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379265AbiAUH5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 02:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379212AbiAUH4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:56:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA64C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:54 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so9875244pjj.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 23:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfAXAcV/wZ+uHO6JBR1mzR4k32V5m276WxyzPLvNLTE=;
        b=tsCSqk1SwZfKiz4ejFhGZDtmCqw1BaXmIG8GnY1LmOqW6W34x7ZWmogKVCWpUEv+ED
         c/rvCRFm6ZFzNHCApLvlhG28OHe4IG/cw7kTVwnGWxQ//EN/1JNbHyZkalCAXATmuqpV
         NsjevRa91/GcIqUtSYviL9C3VbU5COEXDSB/w81ygjvpB14LbyXqvqrB71bfm/zRZsne
         h6PY30/T83gzrCY7cvBcDPJNQvJv5e/k6m3HbpZJPNQV9/qiikBXS3exSFVsMq5qMe/j
         59qq4m+Kw5pJJAFd4Wwdt4Lpn7k//nWZG/wIWhg4LU7poy/H6IRz/+KH599kO8n7+pnc
         iE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfAXAcV/wZ+uHO6JBR1mzR4k32V5m276WxyzPLvNLTE=;
        b=n/UYIAkYrinuZPGiEE/MxK3ar1Dd+4j9JAV6Exza+lTCUGz5BBvl4IMyTMvXt4+YzL
         IhfZEpzjfwhUcZc5xQERQU5be5F9LeqK/cbmlHtDYFsuRHVGnBRbsKHbul+xTk3DXXTi
         Xkv1oGqCTPsLk5QnUf/Q+GVIZDIumkJDeKjTYymzHsOijox67yEIM13Z+ijUjPABNUXt
         sjArHo1ka2E/Gh0bfw99lP/V/5hicXSNGSBWGi2ytzJBAJIW8MPfjpUbakUn4Q83Tdoi
         muy+UCXs5j0XiL1/6V5e/23v4GStnX+nHcA+dsIHvWaBy5YVzOaGoaOu9RoBnMEskuYr
         01aQ==
X-Gm-Message-State: AOAM533bXRLqBO4f6VzMqF/47CWxDf82H2OxAjicFog5xDJfwaJBaM0x
        BISmKw5bRYTy5GM6SbNCpJ2MFZrqSGeGWcWo
X-Google-Smtp-Source: ABdhPJyF+AFCIJwh5y14gbJR641hVBi2LRzmSf89BfdP8AWEWYlQZY5kaMYEvUoNkqJgILGBmJjr3w==
X-Received: by 2002:a17:90b:248f:: with SMTP id nt15mr3418448pjb.137.1642751813587;
        Thu, 20 Jan 2022 23:56:53 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id t15sm10778178pjy.17.2022.01.20.23.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 23:56:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        apopple@nvidia.com, shy828301@gmail.com, rcampbell@nvidia.com,
        hughd@google.com, xiyuyang19@fudan.edu.cn,
        kirill.shutemov@linux.intel.com, zwisler@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/5] mm: remove range parameter from follow_invalidate_pte()
Date:   Fri, 21 Jan 2022 15:55:15 +0800
Message-Id: <20220121075515.79311-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220121075515.79311-1-songmuchun@bytedance.com>
References: <20220121075515.79311-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index d211a06784d5..7895b17f6847 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1814,9 +1814,6 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
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
index 514a81cdd1ae..e8ce066be5f2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4869,9 +4869,8 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
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
@@ -4898,31 +4897,17 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
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
@@ -4930,8 +4915,6 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, *ptlp);
-	if (range)
-		mmu_notifier_invalidate_range_end(range);
 out:
 	return -EINVAL;
 }
@@ -4960,7 +4943,7 @@ int follow_invalidate_pte(struct mm_struct *mm, unsigned long address,
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp)
 {
-	return follow_invalidate_pte(mm, address, NULL, ptepp, NULL, ptlp);
+	return follow_invalidate_pte(mm, address, ptepp, NULL, ptlp);
 }
 EXPORT_SYMBOL_GPL(follow_pte);
 
-- 
2.11.0

