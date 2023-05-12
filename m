Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFAB70045F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbjELJ41 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 05:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240576AbjELJ4R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 05:56:17 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217D5E70B;
        Fri, 12 May 2023 02:56:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-b9daef8681fso8318324276.1;
        Fri, 12 May 2023 02:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885368; x=1686477368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G26aphgD58tBa5cm3UBUurmWT+f5Rv1D2HQTBHZMzO8=;
        b=MstuOBtGoWvN9ULpvx/fDT1WNIButquFg8dv372BFQsdwA7hRiu4fvgP8zjNQ1X9wh
         PajQR2QUUPIp55/mmj7JFBPRkT5EO4MgDnP3VqeQC24uu2HBu7yNpAOlw1DXxu4ovOZd
         5IfTf/MWC7PNXEMPFZKE4DVfr7SKN7R16sm7M/LcEj0nS6oCuJfGiQ5CKtdM6wuLrlAR
         DiiART5TbnuQbwQtWG2VbRwpUzSQlFYcG/LVCb13x6UIBlFXVhCz7jEsZj2OEZ7VGCw3
         Tnyi87Mz71/k7jiafDnYbG3U+OEhqDlLikTJ/3IrbmcL8S038aCPtJ5aPlOWNT5q1jDi
         XA4Q==
X-Gm-Message-State: AC+VfDwV7SWien3A0ekJKboMoU6M4cJFjzjcOtmOfRO6BYxCP6ub3r7R
        KdFlCKV7uMGwUYOQQS4167HtN6Vo2JJzFg==
X-Google-Smtp-Source: ACHHUZ7f7Uyc2ohd3naO9s+qBA8XY05u54CJNbwylSt8gO2t9gCAj2uxfsNLfKHDOSIpKWH836U5ag==
X-Received: by 2002:a25:16c5:0:b0:ba2:16b6:b128 with SMTP id 188-20020a2516c5000000b00ba216b6b128mr12085378ybw.4.1683885367881;
        Fri, 12 May 2023 02:56:07 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id w9-20020a0dd409000000b0054f50f71834sm5547073ywd.124.2023.05.12.02.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 02:56:06 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-55a1462f9f6so94882417b3.3;
        Fri, 12 May 2023 02:56:06 -0700 (PDT)
X-Received: by 2002:a81:a012:0:b0:555:f33e:e32e with SMTP id
 x18-20020a81a012000000b00555f33ee32emr22884527ywg.51.1683885366474; Fri, 12
 May 2023 02:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org> <20230503-virt-to-pfn-v6-4-rc1-v1-2-6c4698dcf9c8@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-2-6c4698dcf9c8@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 11:55:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJjjo9TMeow1-i27ybpQOu9-VZYnTkY5p8p_Cm6sW_GA@mail.gmail.com>
Message-ID: <CAMuHMdVJjjo9TMeow1-i27ybpQOu9-VZYnTkY5p8p_Cm6sW_GA@mail.gmail.com>
Subject: Re: [PATCH 02/12] m68k: Pass a pointer to virt_to_pfn() virt_to_page()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Thu, May 11, 2023 at 1:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> Functions that work on a pointer to virtual memory such as
> virt_to_pfn() and users of that function such as
> virt_to_page() are supposed to pass a pointer to virtual
> memory, ideally a (void *) or other pointer. However since
> many architectures implement virt_to_pfn() as a macro,
> this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
>
> Fix up the offending calls in arch/m68k with explicit casts.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Add an extra parens around the page argument to the
>   PD_PTABLE() macro, as is normally required.

Thanks for the update!

To build sun3_defconfig and m5475evb_defconfig cleanly, you need to
include the (Gmail-whitespace-damaged) changes below.
These were compile-tested only.

diff --git a/arch/m68k/include/asm/mcf_pgtable.h
b/arch/m68k/include/asm/mcf_pgtable.h
index 96d069829803505c..46ae379bb14d5e05 100644
--- a/arch/m68k/include/asm/mcf_pgtable.h
+++ b/arch/m68k/include/asm/mcf_pgtable.h
@@ -135,7 +135,7 @@ static inline void pte_clear(struct mm_struct *mm,
unsigned long addr,
 }

 #define pte_pagenr(pte)        ((__pte_page(pte) - PAGE_OFFSET) >> PAGE_SHIFT)
-#define pte_page(pte)  virt_to_page(__pte_page(pte))
+#define pte_page(pte)  virt_to_page((void *)__pte_page(pte))

 static inline int pmd_none2(pmd_t *pmd) { return !pmd_val(*pmd); }
 #define pmd_none(pmd) pmd_none2(&(pmd))
diff --git a/arch/m68k/include/asm/sun3_pgtable.h
b/arch/m68k/include/asm/sun3_pgtable.h
index e582b0484a55cd82..f3e7728f58cd9dd0 100644
--- a/arch/m68k/include/asm/sun3_pgtable.h
+++ b/arch/m68k/include/asm/sun3_pgtable.h
@@ -109,9 +109,9 @@ static inline void pte_clear (struct mm_struct
*mm, unsigned long addr, pte_t *p
 #define pfn_pte(pfn, pgprot) \
 ({ pte_t __pte; pte_val(__pte) = pfn | pgprot_val(pgprot); __pte; })

-#define pte_page(pte)          virt_to_page(__pte_page(pte))
+#define pte_page(pte)          virt_to_page((void *)__pte_page(pte))
 #define pmd_pfn(pmd)           (pmd_val(pmd) >> PAGE_SHIFT)
-#define pmd_page(pmd)          virt_to_page(pmd_page_vaddr(pmd))
+#define pmd_page(pmd)          virt_to_page((void *)pmd_page_vaddr(pmd))


 static inline int pmd_none2 (pmd_t *pmd) { return !pmd_val (*pmd); }
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 70aa0979e02710a8..a4c552c7e2c8ca12 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -69,7 +69,7 @@ void __init paging_init(void)

                /* now change pg_table to kernel virtual addresses */
                for (i = 0; i < PTRS_PER_PTE; ++i, ++pg_table) {
-                       pte_t pte = pfn_pte(virt_to_pfn(address), PAGE_INIT);
+                       pte_t pte = pfn_pte(virt_to_pfn((void
*)address), PAGE_INIT);
                        if (address >= (unsigned long) high_memory)
                                pte_val(pte) = 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
