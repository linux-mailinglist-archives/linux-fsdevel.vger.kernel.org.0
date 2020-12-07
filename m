Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C422D0F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 12:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgLGLg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 06:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbgLGLfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:35:34 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF114C0613D1;
        Mon,  7 Dec 2020 03:35:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o5so8647982pgm.10;
        Mon, 07 Dec 2020 03:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpyAX8bjmgKWxsxprFNaku2nEJ5v4XWrim2WqmZHDpg=;
        b=eS4D42NrIJAv240gGh41rvA64V7u41KBS4tRtOuPLsuYqHzqarSS8/n7/tX9diZSle
         XcvHurUEWFhPNZhnW01+0VblwSa4+nqPfvuelH67hPrhQTsGl0xYiozhsfaNQdt9UcuU
         xTIW+q4n5aGxXZ9kufVbFlTvHWOCocxT0VIsxD+mL1ugo2Z2vjK6AUIMi/F+wUKrXguJ
         KblNy3cm9NJAk6ucQE5OjL/xyx5c3YMwL7Ulxvlteu0bTmPrUEiEIsIfNOYUO1n/oHDR
         4l0DL0eiG4Uvtj1Wdkd9w/kb6JwDma9v7EE8NNl/eVDjMBv/foOGibW+Nd/9kNb3U8bT
         M6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpyAX8bjmgKWxsxprFNaku2nEJ5v4XWrim2WqmZHDpg=;
        b=oSaccfZdFyLdXBIeBAG6Ibot2q6EgMd87UYNw5Lat6g69oxF4SDGoOnOyEF0HuZHxQ
         gE0O5NWbkwwTjUbwJMaGpKt0b542FhE2BaVBN6n5uPPy3i18IhFVqK+1qkXGVRRnRYmT
         EHw4kPUBga7a62an1fSWCGud60lqd54K1c9g3NgJElgNBI9VcZFiCJshTFo7zI9501P6
         G9voRHKeg3nHRxeLPCSzshmpquMXQLvxkpQy+8fYkx4wf4fSJkNLdhoLlrTcTxbO2fgF
         HU8qWIe57oTw2lhk8sdPJmOjhWm/tkdP74aZMEQaxPWahTqYSqObK18D+Lbtq+Rrxhlj
         C9Rg==
X-Gm-Message-State: AOAM532ANJSZ01dg9THtSdDHSz00u82/ab0xhfHfILYwAawxH1uC7Auj
        EC35AGPxPMtee6CokdVLTAI=
X-Google-Smtp-Source: ABdhPJwyNYWW30gHq9pOZotI8O5TvgnyfvtFboa27PYJJsWjcCMUClmt5pZogoHFcS4MUOgwfk1x+Q==
X-Received: by 2002:a63:7f03:: with SMTP id a3mr17930488pgd.313.1607340918580;
        Mon, 07 Dec 2020 03:35:18 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d4sm14219822pfo.127.2020.12.07.03.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 03:35:18 -0800 (PST)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [RFC V2 29/37] mm: add follow_pte_pud() to support huge pud look up
Date:   Mon,  7 Dec 2020 19:31:22 +0800
Message-Id: <43e14d8a452789e5321b93810a50acfe95672e99.1607332046.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 01f3b05..dfc95be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4698,9 +4698,9 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
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
@@ -4717,6 +4717,26 @@ static int __follow_pte_pmd(struct mm_struct *mm, unsigned long address,
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
 
@@ -4772,8 +4792,8 @@ static inline int follow_pte(struct mm_struct *mm, unsigned long address,
 
 	/* (void) is needed to make gcc happy */
 	(void) __cond_lock(*ptlp,
-			   !(res = __follow_pte_pmd(mm, address, NULL,
-						    ptepp, NULL, ptlp)));
+			   !(res = __follow_pte_pud(mm, address, NULL,
+						    ptepp, NULL, NULL, ptlp)));
 	return res;
 }
 
@@ -4785,12 +4805,24 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 
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
@@ -4808,15 +4840,19 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
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
1.8.3.1

