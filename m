Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B170B59E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 09:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjEVHA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjEVHAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 03:00:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC027F4
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af2c7f2883so23470081fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738840; x=1687330840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1BV5+u3+iDQGG82NKA3Uk8CjUXjAl1NpVyNEDgtFOM=;
        b=OKP+r7By/j3u91/9pbO8LYHiGzCG6RttQtNhTdrGq4Bc89GgPOJ758rfRT5NXv/U8C
         PIpZ6whX3aG9EmmY+G4CvSY4mdbVzScibpiP4DlJLf8oDC+66K49hGw6FXvuZaohOrB6
         sXYdatLAKFRUiPQsB4RW5ZAeeIH5t9viv2Tl0aeDN6oE8DNR2Ocll/clZIhQiMfSvFNa
         NhsbrCGAJbfQDxzwE0BwV2FkvdfbjwofxwdtwSiRXAdrqZoTptDZ4pQFAJx6I1z3InPr
         aPVuNvgjpGcVRF1bKcf7k033n6y1BMp2C0HFtn5LNPpHBW/m7MYVreWkCwszb7jdSTaY
         pkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738840; x=1687330840;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1BV5+u3+iDQGG82NKA3Uk8CjUXjAl1NpVyNEDgtFOM=;
        b=alAIu3H2lyFby+mdxPz+8UBo1LaZ9e1jefs5XDjV+3VfPPGnYjQ56rqHxDj97eispL
         XA6M168XubIm8wyeGUUe9M4ktlU40+PRFNwPiaNKIVsLbuGf15aGL5hDoAK8nQmOJf7f
         9yWGJYXud5uch69ss5+2ZjioMWF7hwi2U/Nafw/FIVK1sLXzmgPapk4BjWil82zeDMm+
         EGxipkmUJlrIyXRJdRu76ExI95DsDTSqtfY285Tr2mf8HKTYo3i0MhLjw25MeFPmn2UL
         V1ATESSfPgkw5kt38hJFJNF2u0I1QzzJ+hlq1kwI2SvIXFEFtK4/gdyNsnFSYiJMZiA4
         yjBQ==
X-Gm-Message-State: AC+VfDxIMhFFeJUVcDm/QHMuPpw//yYluyiH3BXnycq5BmAIUwM97mYS
        0lneNlFJpjQ1zRXubg5T803Yxg==
X-Google-Smtp-Source: ACHHUZ6Zxe2RYIxypwI5O/4FXbCNlcSN0httZo1DFVA3XnqKZ7GjQKsG4dfxMe/Q0Mbfjd8ahNtYhw==
X-Received: by 2002:a2e:7811:0:b0:2ac:85d7:342b with SMTP id t17-20020a2e7811000000b002ac85d7342bmr3472578ljc.29.1684738840123;
        Mon, 22 May 2023 00:00:40 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:39 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:37 +0200
Subject: [PATCH v2 02/12] m68k: Pass a pointer to virt_to_pfn()
 virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-2-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
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
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
- Fix the sun3 pgtable macro to not cast to unsigned long.
- Make a similar change to the ColdFire include.
ChangeLog v1->v2:
- Add an extra parens around the page argument to the
  PD_PTABLE() macro, as is normally required.
---
 arch/m68k/include/asm/mcf_pgtable.h  | 4 ++--
 arch/m68k/include/asm/sun3_pgtable.h | 4 ++--
 arch/m68k/mm/mcfmmu.c                | 3 ++-
 arch/m68k/mm/motorola.c              | 4 ++--
 arch/m68k/mm/sun3mmu.c               | 2 +-
 arch/m68k/sun3/dvma.c                | 2 +-
 arch/m68k/sun3x/dvma.c               | 2 +-
 7 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
index d97fbb812f63..f67c59336ab4 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -115,8 +115,8 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
 	pgd_val(*pgdp) = virt_to_phys(pmdp);
 }
 
-#define __pte_page(pte)	((unsigned long) (pte_val(pte) & PAGE_MASK))
-#define pmd_page_vaddr(pmd)	((unsigned long) (pmd_val(pmd)))
+#define __pte_page(pte)	(__va (pte_val(pte) & PAGE_MASK))
+#define pmd_page_vaddr(pmd)	(__va (pmd_val(pmd)))
 
 static inline int pte_none(pte_t pte)
 {
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

