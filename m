Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2780070F3CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjEXKKx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEXKKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:10:51 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4BFFC;
        Wed, 24 May 2023 03:10:50 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-563b1e5f701so7005407b3.3;
        Wed, 24 May 2023 03:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923049; x=1687515049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjsS8fRbVoZU8c34Ms8NTam545AKBDbkDG6TRRcdYb4=;
        b=LjtrAJ8Z85MESZw25ozmK2IDUbJ9EQMNlRFB6a03PSPp4vRG2qSs1Xg2B0+QfdYUFh
         eVkflIxZznOABD692XTjfe1/1FPAUSBS3CRDVW9S01s3nQm5CuDOCfgujL6x5l9LqqGR
         lOUYTKkPrDTcXfxbg2lQC/G31quMWfuJYyS50PXfZecOBQ9XKvtwjnmejuX6M6ph9ifS
         YNdgRDaUkf+P2AGyiQyjctdX/K6TbSgtmfrYGBR1wySp7yPQDkJGrEOrPNtStAPzhB0a
         NeOznzVlGZBWO+yqYk9bBJkPvs/O5nETJXfFNWpdWYIaF+PfrpGORLnB7RjtSpbCyTTo
         ZjPQ==
X-Gm-Message-State: AC+VfDym/LE86ixzpJ1ERmgA30CdRPCAfKBsXebaWw40QH16Y8jR5SMI
        TVvob1fPlxCo0OsJu5CQ3Jt23SJ7iF53pg==
X-Google-Smtp-Source: ACHHUZ5iDHVW2SFTOZawBoCCVCzpPNS9w2ap/ITNnKDoHEGYnsZlsEJ+/es5jF9jSwYIutFcnmWOBw==
X-Received: by 2002:a81:a107:0:b0:55a:1f2:ef6 with SMTP id y7-20020a81a107000000b0055a01f20ef6mr16756863ywg.9.1684923049215;
        Wed, 24 May 2023 03:10:49 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id x11-20020a817c0b000000b0055aaccfa2c7sm3592626ywc.91.2023.05.24.03.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:10:48 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-564dc3dc075so7136977b3.1;
        Wed, 24 May 2023 03:10:48 -0700 (PDT)
X-Received: by 2002:a0d:c007:0:b0:560:ee0d:1d95 with SMTP id
 b7-20020a0dc007000000b00560ee0d1d95mr18669163ywd.3.1684923047913; Wed, 24 May
 2023 03:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org> <20230503-virt-to-pfn-v6-4-rc1-v3-2-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-2-a16c19c03583@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 12:10:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXafb3SYUgu=ZWFRSiqGdt5ahvPEa75v6jGPBPGARaBhw@mail.gmail.com>
Message-ID: <CAMuHMdXafb3SYUgu=ZWFRSiqGdt5ahvPEa75v6jGPBPGARaBhw@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] m68k: Pass a pointer to virt_to_pfn() virt_to_page()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
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

On Tue, May 23, 2023 at 4:05 PM Linus Walleij <linus.walleij@linaro.org> wrote:
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

Thanks for your patch!

> ---
> ChangeLog v2->v3:
> - Fix up versioning. This is v3.
> - Let Coldfire __pte_page() return a (void *) instead of __va
> - Delete Coldfire pte_pagenr() which was using unsigned long
>   semantics from __pte_page()

You may want to mention this removal in the patch descriptin.

> - Drop ill-advised change to Coldfire pmd_page_vaddr()

> --- a/arch/m68k/include/asm/sun3_pgtable.h
> +++ b/arch/m68k/include/asm/sun3_pgtable.h

> @@ -111,7 +111,7 @@ static inline void pte_clear (struct mm_struct *mm, unsigned long addr, pte_t *p
>
>  #define pte_page(pte)          virt_to_page(__pte_page(pte))
>  #define pmd_pfn(pmd)           (pmd_val(pmd) >> PAGE_SHIFT)
> -#define pmd_page(pmd)          virt_to_page(pmd_page_vaddr(pmd))
> +#define pmd_page(pmd)          virt_to_page((void  *)pmd_page_vaddr(pmd))

There's an extra space between "void" and "*".

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
