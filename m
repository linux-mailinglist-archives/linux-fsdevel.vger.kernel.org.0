Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC870DE82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjEWOHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjEWOGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:06:51 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C624139
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:48 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so3762413e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850747; x=1687442747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZAVHnI0RnVaS/2VmTowQqEKdQQ5rGu0g+MysdOCzRE=;
        b=CndnVf4Wz0L7DCgFoh3Gq+YOBOn/KSBOCbH8YksJupr6UUPOhddHJUufNJpsGX6RPn
         rTDP0CIM0yfz0E9z2hoqsv+IrS9bNsKCIWeoIiAKo1FLM6IUrHeaw016T1O9DEAo7W0s
         lGILyoagX94XkZQ+8x2RQCqAZfYySvk+7OvtomiQ5PLGb7k8yRkB5FQhQ10QmX0bg6eL
         s7Ko5smzRaiFKzMutWbf/9ftcS5cdW7GP0A5ukP7k6S25BdkMtlB9BCM9AQmGDpbZGdM
         uxU1fALRef1aE+fzPPwRaMJZVm/kLgAfXQLWcvxYyYtb7qAOO8RA1O1GAaM+1Cd9JyCz
         y/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850747; x=1687442747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZAVHnI0RnVaS/2VmTowQqEKdQQ5rGu0g+MysdOCzRE=;
        b=hGv36aV9GdHheuxKRCU8BIC49P/B3fei0/sCopUiOFK+N1/8EqXaSCipTUGieuXOpq
         oOJYFxHIMwmc6lLHOf90SUc2JiPVK6qvHivpmG+d9ryFs6qKLY1FFDh+8VDrGt7/lwHw
         WibH8dkH0vkWeXV1LLQ7azIjm1Z18tJzJNvjr0lT4Y+VjefnLs9Bwr412frLui1LjKzT
         5OpYW//qPe7X6lA6tsNui73y5FrNkPPSwE5VAlkNizLmzyjYCDiuyBNDPP18PuzDm0f1
         no8UDaPhUz3fiQlRF8htSyq/ZcXqvtI/4w1AysCeR7iqKrPt/bam1NSbzzkux1QGjppn
         +xRA==
X-Gm-Message-State: AC+VfDw+vuAWaYCVZd9vbmco9dvwy/7z7nRIarttbx4+UHjZIKOSFjBj
        Diz4agVyeCnegdRD/qnYoqJ74Q==
X-Google-Smtp-Source: ACHHUZ65J8Z3/JvqtcArdgyxfAPz6sl81M4hzs4N3aTQHnJRtGcRDM0SdUGRMB6f5OBhCMlJco5Hlw==
X-Received: by 2002:ac2:4c39:0:b0:4f1:2986:3920 with SMTP id u25-20020ac24c39000000b004f129863920mr4308136lfq.41.1684850746806;
        Tue, 23 May 2023 07:05:46 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:26 +0200
Subject: [PATCH v3 02/12] m68k: Pass a pointer to virt_to_pfn()
 virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-2-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Functions that work on a pointer to virtual memory such as
virt_to_pfn() and users of that function such as
virt_to_page() are supposed to pass a pointer to virtual
memory, ideally a (void *) or other pointer. However since
many architectures implement virt_to_pfn() as a macro,
this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix up the offending calls in arch/m68k with explicit casts.

The page table include <asm/pgtable.h> will include different
variants of the defines depending on whether you build for
classic m68k, ColdFire or Sun3, so fix all variants.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Fix up versioning. This is v3.
- Let Coldfire __pte_page() return a (void *) instead of __va
- Delete Coldfire pte_pagenr() which was using unsigned long
  semantics from __pte_page()
- Drop ill-advised change to Coldfire pmd_page_vaddr()
ChangeLog v1->v2:
- Fix the sun3 pgtable macro to not cast to unsigned long.
- Make a similar change to the ColdFire include.
- Add an extra parens around the page argument to the
  PD_PTABLE() macro, as is normally required.
---
 arch/m68k/include/asm/mcf_pgtable.h  | 3 +--
 arch/m68k/include/asm/sun3_pgtable.h | 4 ++--
 arch/m68k/mm/mcfmmu.c                | 3 ++-
 arch/m68k/mm/motorola.c              | 4 ++--
 arch/m68k/mm/sun3mmu.c               | 2 +-
 arch/m68k/sun3/dvma.c                | 2 +-
 arch/m68k/sun3x/dvma.c               | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index d97fbb812f63..43e8da8465f9 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -115,7 +115,7 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 	pgd_val(*pgdp) = virt_to_phys(pmdp);
 }
 
-#define __pte_page(pte)	((unsigned long) (pte_val(pte) & PAGE_MASK))
+#define __pte_page(pte)	((void *) (pte_val(pte) & PAGE_MASK))
 #define pmd_page_vaddr(pmd)	((unsigned long) (pmd_val(pmd)))
 
 static inline int pte_none(pte_t pte)
@@ -134,7 +134,6 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 	pte_val(*ptep) = 0;
 }
 
-#define pte_pagenr(pte)	((__pte_page(pte) - PAGE_OFFSET) >> PAGE_SHIFT)
 #define pte_page(pte)	virt_to_page(__pte_page(pte))
 
 static inline int pmd_none2(pmd_t *pmd) { return !pmd_val(*pmd); }
diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
index e582b0484a55..f428f73125d5 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -91,7 +91,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define pmd_set(pmdp,ptep) do {} while (0)
 
 #define __pte_page(pte) \
-((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
+(__va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
 
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
@@ -111,7 +111,7 @@ static inline void pte_clear (struct mm_struct *mm, unsigned long addr, pte_t *p
 
 #define pte_page(pte)		virt_to_page(__pte_page(pte))
 #define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
-#define pmd_page(pmd)		virt_to_page(pmd_page_vaddr(pmd))
+#define pmd_page(pmd)		virt_to_page((void  *)pmd_page_vaddr(pmd))
 
 
 static inline int pmd_none2 (pmd_t *pmd) { return !pmd_val (*pmd); }
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 70aa0979e027..278e85fcecd4 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -69,7 +69,8 @@ void __init paging_init(void)
 
 		/* now change pg_table to kernel virtual addresses */
 		for (i = 0; i < PTRS_PER_PTE; ++i, ++pg_table) {
-			pte_t pte = pfn_pte(virt_to_pfn(address), PAGE_INIT);
+			pte_t pte = pfn_pte(virt_to_pfn((void *)address),
+					    PAGE_INIT);
 			if (address >= (unsigned long) high_memory)
 				pte_val(pte) = 0;
 
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 911301224078..c75984e2d86b 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -102,7 +102,7 @@ static struct list_head ptable_list[2] = {
 	LIST_HEAD_INIT(ptable_list[1]),
 };
 
-#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page(page)->lru))
+#define PD_PTABLE(page) ((ptable_desc *)&(virt_to_page((void *)(page))->lru))
 #define PD_PAGE(ptable) (list_entry(ptable, struct page, lru))
 #define PD_MARKBITS(dp) (*(unsigned int *)&PD_PAGE(dp)->index)
 
@@ -201,7 +201,7 @@ int free_pointer_table(void *table, int type)
 		list_del(dp);
 		mmu_page_dtor((void *)page);
 		if (type == TABLE_PTE)
-			pgtable_pte_page_dtor(virt_to_page(page));
+			pgtable_pte_page_dtor(virt_to_page((void *)page));
 		free_page (page);
 		return 1;
 	} else if (ptable_list[type].next != dp) {
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index b619d0d4319c..c5e6a23e0262 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -75,7 +75,7 @@ void __init paging_init(void)
 		/* now change pg_table to kernel virtual addresses */
 		pg_table = (pte_t *) __va ((unsigned long) pg_table);
 		for (i=0; i<PTRS_PER_PTE; ++i, ++pg_table) {
-			pte_t pte = pfn_pte(virt_to_pfn(address), PAGE_INIT);
+			pte_t pte = pfn_pte(virt_to_pfn((void *)address), PAGE_INIT);
 			if (address >= (unsigned long)high_memory)
 				pte_val (pte) = 0;
 			set_pte (pg_table, pte);
diff --git a/arch/m68k/sun3/dvma.c b/arch/m68k/sun3/dvma.c
index f15ff16b9997..83fcae6a0e79 100644
--- a/arch/m68k/sun3/dvma.c
+++ b/arch/m68k/sun3/dvma.c
@@ -29,7 +29,7 @@ static unsigned long dvma_page(unsigned long kaddr, unsigned long vaddr)
 	j = *(volatile unsigned long *)kaddr;
 	*(volatile unsigned long *)kaddr = j;
 
-	ptep = pfn_pte(virt_to_pfn(kaddr), PAGE_KERNEL);
+	ptep = pfn_pte(virt_to_pfn((void *)kaddr), PAGE_KERNEL);
 	pte = pte_val(ptep);
 //	pr_info("dvma_remap: addr %lx -> %lx pte %08lx\n", kaddr, vaddr, pte);
 	if(ptelist[(vaddr & 0xff000) >> PAGE_SHIFT] != pte) {
diff --git a/arch/m68k/sun3x/dvma.c b/arch/m68k/sun3x/dvma.c
index 08bb92113026..a6034ba05845 100644
--- a/arch/m68k/sun3x/dvma.c
+++ b/arch/m68k/sun3x/dvma.c
@@ -125,7 +125,7 @@ inline int dvma_map_cpu(unsigned long kaddr,
 			do {
 				pr_debug("mapping %08lx phys to %08lx\n",
 					 __pa(kaddr), vaddr);
-				set_pte(pte, pfn_pte(virt_to_pfn(kaddr),
+				set_pte(pte, pfn_pte(virt_to_pfn((void *)kaddr),
 						     PAGE_KERNEL));
 				pte++;
 				kaddr += PAGE_SIZE;

-- 
2.34.1

