Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F81700572
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 12:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjELK2U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbjELK2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 06:28:01 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF92E14E69;
        Fri, 12 May 2023 03:26:57 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-559e53d1195so140909517b3.2;
        Fri, 12 May 2023 03:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887188; x=1686479188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7oE+wnAwx9lWj1Dzx32p5gbR9ZsZdOiJLOsGIhtwMM=;
        b=Gdw89S0d94MLMQTfu+rWI0A/Vb9SX75M6/1QmlaWIQyxRWKvm7PNjbzgj6QxSieNm+
         fC2cSbrKeYTQ3k/pHPMp/x3DvtcAemMcW4FQuPfKxVCleSWVPnKdy4scY+OyO8XD2AtS
         ilFqpEGVkYgkmPoyu2+RuewMwfp0764V12vFeLbwo3KEpECSgv+UZ6v59eWrPV3teDv6
         W4lEgmP2C6RFnLvOakKGE7+z6N2Tgx4gtPj930OZtvvJL2LWuBrsJTi5lbAkTXA1V5bL
         YraVM9d0eggOhhTJUw2cOYkBJa8hYWVXK2z17BoJRTPXR4wGRU+bSi3Bmmk+drUQH2fE
         yjBA==
X-Gm-Message-State: AC+VfDwrXpAc3/P6ATfWX8R3BOMaPgihiO3iQ95GCL6yI7I1l3SUXLOz
        FZIa+rrHPLmBWFQdlxeYAuOpC5cYj6V+KQ==
X-Google-Smtp-Source: ACHHUZ5jCOqID/Xnrtcckf3j3udYN3KPPbW9smGWfnbOkI53lZyZYT3UXadPEbpFxOIWeB1hJsKojA==
X-Received: by 2002:a81:7586:0:b0:54f:b244:fef9 with SMTP id q128-20020a817586000000b0054fb244fef9mr23977199ywc.0.1683887187840;
        Fri, 12 May 2023 03:26:27 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id b133-20020a81678b000000b00557027bf788sm5584201ywc.74.2023.05.12.03.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 03:26:26 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-559de1d36a9so140726217b3.1;
        Fri, 12 May 2023 03:26:26 -0700 (PDT)
X-Received: by 2002:a0d:c281:0:b0:536:cb48:9059 with SMTP id
 e123-20020a0dc281000000b00536cb489059mr25024547ywd.50.1683887185987; Fri, 12
 May 2023 03:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
 <20230503-virt-to-pfn-v6-4-rc1-v1-2-6c4698dcf9c8@linaro.org> <CAMuHMdVJjjo9TMeow1-i27ybpQOu9-VZYnTkY5p8p_Cm6sW_GA@mail.gmail.com>
In-Reply-To: <CAMuHMdVJjjo9TMeow1-i27ybpQOu9-VZYnTkY5p8p_Cm6sW_GA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 12:26:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV5Aukxx+XyC-s2=CDa2BYqvc3uRvWBhD6ri5j09tXj3A@mail.gmail.com>
Message-ID: <CAMuHMdV5Aukxx+XyC-s2=CDa2BYqvc3uRvWBhD6ri5j09tXj3A@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 11:55 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, May 11, 2023 at 1:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > Functions that work on a pointer to virtual memory such as
> > virt_to_pfn() and users of that function such as
> > virt_to_page() are supposed to pass a pointer to virtual
> > memory, ideally a (void *) or other pointer. However since
> > many architectures implement virt_to_pfn() as a macro,
> > this function becomes polymorphic and accepts both a
> > (unsigned long) and a (void *).
> >
> > Fix up the offending calls in arch/m68k with explicit casts.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Add an extra parens around the page argument to the
> >   PD_PTABLE() macro, as is normally required.
>
> Thanks for the update!
>
> To build sun3_defconfig and m5475evb_defconfig cleanly, you need to
> include the (Gmail-whitespace-damaged) changes below.
> These were compile-tested only.

> --- a/arch/m68k/include/asm/sun3_pgtable.h
> +++ b/arch/m68k/include/asm/sun3_pgtable.h
> @@ -109,9 +109,9 @@ static inline void pte_clear (struct mm_struct
> *mm, unsigned long addr, pte_t *p
>  #define pfn_pte(pfn, pgprot) \
>  ({ pte_t __pte; pte_val(__pte) = pfn | pgprot_val(pgprot); __pte; })
>
> -#define pte_page(pte)          virt_to_page(__pte_page(pte))
> +#define pte_page(pte)          virt_to_page((void *)__pte_page(pte))

Much simpler to drop the cast in __pte_page() instead:

@@ -91,7 +91,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 #define pmd_set(pmdp,ptep) do {} while (0)

 #define __pte_page(pte) \
-((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))
+        (__va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))

 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {

>  #define pmd_pfn(pmd)           (pmd_val(pmd) >> PAGE_SHIFT)
> -#define pmd_page(pmd)          virt_to_page(pmd_page_vaddr(pmd))
> +#define pmd_page(pmd)          virt_to_page((void *)pmd_page_vaddr(pmd))

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
