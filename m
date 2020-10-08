Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAE28703D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgJHH4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbgJHHzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED9AC0613D2;
        Thu,  8 Oct 2020 00:55:52 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so3331909pfk.2;
        Thu, 08 Oct 2020 00:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LyBV6N3gjq3MiLxBfZ3JOHalx3ds96tA29NRwEvbdoI=;
        b=vd9Dnz8emLxl2V0MxRbRE8ukBDhBRtccJzUehh/zwzrFX58KybIlfgmtQJ04bVTuD+
         ChU852jZS1a6muWTlmD2z4byGPamv02s2TKdjDlLGQy5EVqnySrqDzcIdw4LVN+Ivd9a
         P1fICw3poYzu1PShO70s1IICT6lDQRwMQK8uS7ciPRkKvtxfpAARUfgpgu9pGqqv7cEz
         FOrM4hjxUiagkjqFMEfNipPJK35UQv3aLfUDWT49eQJaUBdHZhoPBuhoMHK3eAzd/KkU
         3KSWL1JK2UvxDtZn8qCXmvMK5oaix3Q89m+VHUSKRYDHZKTZBqnCwjmZUkRrP5CnhZ8r
         LUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LyBV6N3gjq3MiLxBfZ3JOHalx3ds96tA29NRwEvbdoI=;
        b=iXidjNyXOJamFenCey8QfO9crVNwrEHpOU3htr9351ifcf/PIX9wDBDR8v1r6/jzuq
         zyphTJLDh3jSe68ZxCle5azr/YwIKe+711/Y7Gi1TuHNNGhKhBzfi1Y3Gzn0mrUTzWv+
         qH3T+JRREGnoNkCDPhhpYMq7k/MAJaCXSWoxNJVoeNvhiPeXlLgQV/PcfdWRM4m8/7dH
         naA3SS7ohkbhlVeDJVxFr9EZo0/bfPH936rmMS2ELIqjUX9n96/R7sAyjlGoBDomLnsY
         RHAPa64vSEsxrLVh26DBzwB+gHFa6RaH5naQikz9oeAET2zAf5FCYyji+Aw6TL67v76K
         Dtdg==
X-Gm-Message-State: AOAM532BdkJgEQrCyPedwpCMYokAahaik46Vh0R7MZghEErwgvLDgmFQ
        7bQN3oXHMUB7dqx1LIWTdAs=
X-Google-Smtp-Source: ABdhPJzchyQcPfaxUgFQfXjYWLFWkCzMJoJcb2OICRAl5QnyfvZRb6BniUxZb6dGsJpVC7oewwtwAQ==
X-Received: by 2002:a63:d65:: with SMTP id 37mr6412097pgn.139.1602143752415;
        Thu, 08 Oct 2020 00:55:52 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:51 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 29/35] mm: add follow_pte_pud()
Date:   Thu,  8 Oct 2020 15:54:19 +0800
Message-Id: <71f27b2b03471adbbacccb9a5107b6533a18a957.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Since we had supported dmem huge pud, here support dmem huge pud for
hva_to_pfn().

Similar to follow_pte_pmd(), follow_pte_pud() allows a PTE lead or a
huge page PMD or huge page PUD to be found and returned.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 mm/memory.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3748fab7cc2a..f831ab4b7ccd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4535,9 +4535,9 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
+static int __follow_pte_pud(struct mm_struct *mm, unsigned long address,
 			    struct mmu_notifier_range *range,
-			    pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp)
+			    pte_t **ptepp, pmd_t **pmdpp, pud_t **pudpp, spinlock_t **ptlp)
 {
 	pgd_t *pgd;
 	p4d_t *p4d;
@@ -4554,6 +4554,26 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		goto out;
 
 	pud = pud_offset(p4d, address);
+	VM_BUG_ON(pud_trans_huge(*pud));
+	if (pud_huge(*pud)) {
+		if (!pudpp)
+			goto out;
+
+		if (range) {
+			mmu_notifier_range_init(range, MMU_NOTIFY_CLEAR, 0,
+						NULL, mm, address & PUD_MASK,
+						(address & PUD_MASK) + PUD_SIZE);
+			mmu_notifier_invalidate_range_start(range);
+		}
+		*ptlp = pud_lock(mm, pud);
+		if (pud_huge(*pud)) {
+			*pudpp = pud;
+			return 0;
+		}
+		spin_unlock(*ptlp);
+		if (range)
+			mmu_notifier_invalidate_range_end(range);
+	}
 	if (pud_none(*pud) || unlikely(pud_bad(*pud)))
 		goto out;
 
@@ -4609,8 +4629,8 @@ static inline int follow_pte(struct mm_struct *mm, unsigned long address,
 
 	/* (void) is needed to make gcc happy */
 	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, NULL,
-						    ptepp, NULL, ptlp)));
+			   !(res = __follow_pte_pud(mm, address, NULL,
+						    ptepp, NULL, NULL, ptlp)));
 	return res;
 }
 
@@ -4622,12 +4642,24 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 
 	/* (void) is needed to make gcc happy */
 	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, range,
-						    ptepp, pmdpp, ptlp)));
+			   !(res = __follow_pte_pud(mm, address, range,
+						    ptepp, pmdpp, NULL, ptlp)));
 	return res;
 }
 EXPORT_SYMBOL(follow_pte_pmd);
 
+int follow_pte_pud(struct mm_struct *mm, unsigned long address,
+		   struct mmu_notifier_range *range,
+		   pte_t **ptepp, pmd_t **pmdpp, pud_t **pudpp, spinlock_t **ptlp)
+{
+	int res;
+
+	/* (void) is needed to make gcc happy */
+	(void) __cond_lock(*ptlp,
+			   !(res = __follow_pte_pud(mm, address, range,
+						    ptepp, pmdpp, pudpp, ptlp)));
+	return res;
+}
 /**
  * follow_pfn - look up PFN at a user virtual address
  * @vma: memory mapping
@@ -4645,15 +4677,19 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	spinlock_t *ptl;
 	pte_t *ptep;
 	pmd_t *pmdp = NULL;
+	pud_t *pudp = NULL;
 
 	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
 		return ret;
 
-	ret = follow_pte_pmd(vma->vm_mm, address, NULL, &ptep, &pmdp, &ptl);
+	ret = follow_pte_pud(vma->vm_mm, address, NULL, &ptep, &pmdp, &pudp, &ptl);
 	if (ret)
 		return ret;
 
-	if (pmdp) {
+	if (pudp) {
+		*pfn = pud_pfn(*pudp) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
+		spin_unlock(ptl);
+	} else if (pmdp) {
 		*pfn = pmd_pfn(*pmdp) + ((address & ~PMD_MASK) >> PAGE_SHIFT);
 		spin_unlock(ptl);
 	} else {
-- 
2.28.0

