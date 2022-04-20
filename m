Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BD5508B37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379812AbiDTOzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379801AbiDTOzI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:55:08 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0F41AF17;
        Wed, 20 Apr 2022 07:52:22 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id dw17so1471246qvb.9;
        Wed, 20 Apr 2022 07:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEzFnCq+BQP5/7i1OwdP+xfd73rvdn4Cf2EKhcjMDFo=;
        b=qYh6vV01wqcKW0V6JFdi5DW4RNTeNP1ERshevegIjbCtjbSI1RBPzy/CwRjGjhK7ql
         pw+5iUvYPYVCx6rYB0N/+G7qZX4x1JntNM5UoQ710Y+a0P0FPBtyxb7sGY6AdILleq4x
         eOVH95e3/aSFoNJX+rCnVcKSTkEV/yG7tFP5r/nSXVeGxju0Of7j4+CCYI1rJHfG4xxv
         /pONflR8I1vEr396DNzBJ9uPYJbtJoyqOgMPhuiZgW9v4tvOuNzRgw5TdUR+kA6AQQ6S
         E/rBYcjPYkqdjYreo4Mw1+QnVAmJKtAeqwx1uXRljGTLHxovkgc8gT/TQbQjTC8EV+di
         DJrg==
X-Gm-Message-State: AOAM530HhAG0q+AqmgYccETjh5zH7XPzFFoU9KNLN1JVMFlbDrFNECT2
        ML9y1Ck/T9soo+sgieEU3kUDt4vu7cBrOw==
X-Google-Smtp-Source: ABdhPJz4Gb75QVFtXGPmyYfq+P50BWXGi4Av9rZBZEB5daMdRDOwoyTt4rqC0UnqD/M9yB1reiH75w==
X-Received: by 2002:ad4:5dca:0:b0:44a:9617:b86a with SMTP id m10-20020ad45dca000000b0044a9617b86amr1817664qvh.14.1650466341601;
        Wed, 20 Apr 2022 07:52:21 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id b22-20020a05620a0f9600b0069e8ab5034dsm1545745qkn.1.2022.04.20.07.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 07:52:21 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id h8so3277720ybj.11;
        Wed, 20 Apr 2022 07:52:21 -0700 (PDT)
X-Received: by 2002:a81:4f0d:0:b0:2ec:1556:815 with SMTP id
 d13-20020a814f0d000000b002ec15560815mr21306644ywb.256.1650465859173; Wed, 20
 Apr 2022 07:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
 <95a0d1dd-bcce-76c7-97b9-8374c9913321@google.com> <7f2993a9-adc5-2b90-9218-c4ca8239c3e@google.com>
 <3695dc2a-7518-dee4-a647-821c7cda4a0f@foss.st.com> <2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com>
 <6f56d0d6-6d0d-f0c9-87df-f3ff25b26fc5@linux-m68k.org>
In-Reply-To: <6f56d0d6-6d0d-f0c9-87df-f3ff25b26fc5@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Apr 2022 16:44:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWA7n588XUKy2yondnZpAw_afFBz8DHxH0Q3Tt53HHsHg@mail.gmail.com>
Message-ID: <CAMuHMdWA7n588XUKy2yondnZpAw_afFBz8DHxH0Q3Tt53HHsHg@mail.gmail.com>
Subject: Re: Regression with v5.18-rc1 tag on STM32F7 and STM32H7 based boards
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>, zkabelac@redhat.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Wed, Apr 20, 2022 at 3:53 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 16/4/22 10:58, Hugh Dickins wrote:
> > Just to wrap up this thread: the tentative arch/ patches below did not
> > go into 5.18-rc2, but 5.18-rc3 will contain
> > 1bdec44b1eee ("tmpfs: fix regressions from wider use of ZERO_PAGE")
> > which fixes a further issue, and deletes the line which gave you trouble.
> >
> > With arch/h8300 removed from linux-next, and arch/arm losing a page by
> > the patch below, I don't think it's worth my arguing for those changes.
> > I'd still prefer arch/m68k to expose its empty_zero_page in ZERO_PAGE(),
> > or else not allocate it; but I won't be pursuing this further.
>
> Thanks for pointing this out. It certainly does look wrong to me for
> the m68k nommu case. I am not aware of any existing issues caused by
> this - but there is no good reason not to fix it.
>
> So I propose this change. Build and run tested on my m68knommu targets.
>
> Regards
> Greg
>
>
>  From f809fb8fbca9e5e637b8fda380955bd799bb3926 Mon Sep 17 00:00:00 2001
> From: Greg Ungerer <gerg@linux-m68k.org>
> Date: Wed, 20 Apr 2022 23:27:47 +1000
> Subject: [PATCH] m68knommu: set ZERO_PAGE() allocated zeroed page
>
> The non-MMU m68k pagetable ZERO_PAGE() macro is being set to the
> somewhat non-sensical value of "virt_to_page(0)". The zeroth page
> is not in any way guaranteed to be a page full of "0". So the result
> is that ZERO_PAGE() will almost certainly contain random values.
>
> We already allocate a real "empty_zero_page" in the mm setup code shared
> between MMU m68k and non-MMU m68k. It is just not hooked up to the
> ZERO_PAGE() macro for the non-MMU m68k case.
>
> Fix ZERO_PAGE() to use the allocated "empty_zero_page" pointer.
>
> I am not aware of any specific issues caused by the old code.
>
> Link: https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#t
> Reported-by: Hugh Dickens <hughd@google.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
> ---
>   arch/m68k/include/asm/pgtable_no.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
> index 87151d67d91e..bce5ca56c388 100644
> --- a/arch/m68k/include/asm/pgtable_no.h
> +++ b/arch/m68k/include/asm/pgtable_no.h
> @@ -42,7 +42,8 @@ extern void paging_init(void);
>    * ZERO_PAGE is a global shared page that is always zero: used
>    * for zero-mapped memory areas etc..
>    */
> -#define ZERO_PAGE(vaddr)       (virt_to_page(0))
> +extern void *empty_zero_page;
> +#define ZERO_PAGE(vaddr)       (virt_to_page(empty_zero_page))
>
>   /*
>    * All 32bit addresses are effectively valid for vmalloc...

And after that (or combined with this?), this can be factored
out from arch/m68k/include/asm/pgtable_{mm,no}.h into
arch/m68k/include/asm/pgtable.h.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
