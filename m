Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD2070B9AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEVKLu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEVKLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 06:11:47 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681ABA;
        Mon, 22 May 2023 03:11:41 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-b9a7e639656so11281156276.0;
        Mon, 22 May 2023 03:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684750300; x=1687342300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQATq2c9SwOWOfQ7A10Go9afc2yqePz2ONTwzgTVwBU=;
        b=HMNoACtjhaL05NyjEU7JbeJEenr+k/VHRbi1cwrZfF6rZbHm9vyrVzI7dJ0QsCg2AG
         EObhL9ns7LMmApxizZ2Msid0pFInovzXbS1gOyy8t5BwPnprR8Y+6u1SrwfO2KvDL7qG
         YYlkDPfEDG2CBc/tsEkpDxeudei0mYFpVT5marSqnMlAJoBHpa8tEuYDgrP2Q3ZIuc8C
         jIBfkPQwSskuiE4QtH7FGfG54bxSaRBtgr1tsYkFG0TJj9Kbu2YoECAy3aWXrDA4nLwt
         frfJ3ZH75DZmIVKYl2LnNLnESVRPFHcxStHQpaYAQXvNwcwMnoi2cCg2C7Q0j/PZzZ7D
         2qtQ==
X-Gm-Message-State: AC+VfDwr30X3+8w9lqYXFRTemNQZ+ZPrjH0P3LAbn5xVV0COwbsPjYUq
        iSd+cBSz7nRYdh2Pmuqdv2Y16FBqWEUTRQ==
X-Google-Smtp-Source: ACHHUZ4OTp/TAUrcrASJZd+ro+JTTxKVVPt2Wf3bQrRCrvgzVdMgq7osCwf8P99L2q7V0p37kVvTYw==
X-Received: by 2002:a0d:e60c:0:b0:561:9622:bf74 with SMTP id p12-20020a0de60c000000b005619622bf74mr10393791ywe.37.1684750300565;
        Mon, 22 May 2023 03:11:40 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id m5-20020a817105000000b00545a08184bbsm1970867ywc.75.2023.05.22.03.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 03:11:39 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-b9a7e639656so11281074276.0;
        Mon, 22 May 2023 03:11:38 -0700 (PDT)
X-Received: by 2002:a81:5247:0:b0:561:c5c3:9d79 with SMTP id
 g68-20020a815247000000b00561c5c39d79mr9161977ywb.45.1684750298756; Mon, 22
 May 2023 03:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org> <20230503-virt-to-pfn-v6-4-rc1-v2-2-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-2-0948d38bddab@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 May 2023 12:11:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXB1fK_G=QZ59qkJWXhb61TyLRMwH3qo_0sSmW0Cfv8hA@mail.gmail.com>
Message-ID: <CAMuHMdXB1fK_G=QZ59qkJWXhb61TyLRMwH3qo_0sSmW0Cfv8hA@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] m68k: Pass a pointer to virt_to_pfn() virt_to_page()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mm@vger.kernel.org,
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

On Mon, May 22, 2023 at 9:00 AM Linus Walleij <linus.walleij@linaro.org> wrote:
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
> The page table include <asm/pgtable.h> will include different
> variants of the defines depending on whether you build for
> classic m68k, ColdFire or Sun3, so fix all variants.
>
> Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the update!

> ---
> ChangeLog v2->v3:

v3?

> - Fix the sun3 pgtable macro to not cast to unsigned long.
> - Make a similar change to the ColdFire include.

The ColdFire change is not correct, cfr. below...

> ChangeLog v1->v2:
> - Add an extra parens around the page argument to the
>   PD_PTABLE() macro, as is normally required.
> ---
>  arch/m68k/include/asm/mcf_pgtable.h  | 4 ++--
>  arch/m68k/include/asm/sun3_pgtable.h | 4 ++--
>  arch/m68k/mm/mcfmmu.c                | 3 ++-
>  arch/m68k/mm/motorola.c              | 4 ++--
>  arch/m68k/mm/sun3mmu.c               | 2 +-
>  arch/m68k/sun3/dvma.c                | 2 +-
>  arch/m68k/sun3x/dvma.c               | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> index d97fbb812f63..f67c59336ab4 100644
> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -115,8 +115,8 @@ static inline void pgd_set(pgd_t *pgdp, pmd_t *pmdp)
>         pgd_val(*pgdp) = virt_to_phys(pmdp);
>  }
>
> -#define __pte_page(pte)        ((unsigned long) (pte_val(pte) & PAGE_MASK))
> -#define pmd_page_vaddr(pmd)    ((unsigned long) (pmd_val(pmd)))
> +#define __pte_page(pte)        (__va (pte_val(pte) & PAGE_MASK))

I guess "__va(...)" should be "(void *)..." instead?

However, that will cause an issue below, as

    #define pte_pagenr(pte)        ((__pte_page(pte) - PAGE_OFFSET) >>
PAGE_SHIFT)

does depend on __pte_page() returning "unsigned long".
Fortunately pte_pagenr() appears unused, so it can be removed.

So for now, it might be simpler to add the cast to the caller.


> +#define pmd_page_vaddr(pmd)    (__va (pmd_val(pmd)))

This looks bogus, too, as it should return "unsigned long".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
