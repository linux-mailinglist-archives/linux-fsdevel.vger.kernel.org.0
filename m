Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7021E39C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgE0HDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 03:03:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37083 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgE0HDE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 03:03:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id m67so10517784oif.4;
        Wed, 27 May 2020 00:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UmrgkNrS7YJyoX//CVVX8i/eCGz9CaA9GDfJeRj6hok=;
        b=rVkoQMULJ+OZ9x5kHBlqLqq5f6KYD2w/b0J2IyVB3B8JqMpW7sk7jWcZvEC5z4I2s5
         /U9W/KEo/Y0TtJyaeao2lGFjLsMlHwKhCVKd1qhJhCmI2CQIjKHlv8PVmI2lUKM3QZRr
         2D1V50FJZ4yZ/OeBxvwn0ssUHavgw4LuXbyG6F6NOPolLGAjObfPDMUaHo2Mvo84seuA
         FsRFyThXciFbJZqkE7uUHt5mAGaemkWh4a679yUz7gAb7MGqkY0h+vTo19twyS+wAfqW
         Gtn6fZ3nk46IIj9BzuRvbNyEk2QkxkVtDnw7461N395/Y8Ae32oTLe7aCgRAsV7yfGPi
         8N+g==
X-Gm-Message-State: AOAM530Bd2DKOIivzsOKO6SM1T90eRAGz073UiEVlgCtGaeKwl3Entoj
        gTl066CUVLamfgoBh6FVIykXMF9GUG6MNNZcXQ8=
X-Google-Smtp-Source: ABdhPJyJItgq7CbQXJlF6MFLLk/+bu/fSz/XUZ+gwTEqMYOT9P6OwO82+92+P3alNyNfXtW65E6GNWlSoFsc0hwoXsQ=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr1778697oic.54.1590562983010;
 Wed, 27 May 2020 00:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200515143646.3857579-7-hch@lst.de> <20200527043426.3242439-1-natechancellor@gmail.com>
In-Reply-To: <20200527043426.3242439-1-natechancellor@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 May 2020 09:02:51 +0200
Message-ID: <CAMuHMdVSduTOi5bUgF9sLQdGADwyL1+qALWsKgin1TeOLGhAKQ@mail.gmail.com>
Subject: Re: [PATCH] media: omap3isp: Shuffle cacheflush.h and include mm.h
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nathan,

CC Laurent

On Wed, May 27, 2020 at 6:37 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:
>
> In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
>                  from drivers/media/platform/omap3isp/isp.c:42:
> ./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
> declared inside parameter list will not be visible outside of this
> definition or declaration
>
> cacheflush.h does not include mm.h nor does it include any forward
> declaration of these structures hence the warning. To avoid this,
> include mm.h explicitly in this file and shuffle cacheflush.h below it.
>
> Fixes: 19c0054597a0 ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for your patch!

> I am aware the fixes tag is kind of irrelevant because that SHA will
> change in the next linux-next revision and this will probably get folded
> into the original patch anyways but still.
>
> The other solution would be to add forward declarations of these structs
> to the top of cacheflush.h, I just chose to do what Christoph did in the
> original patch. I am happy to do that instead if you all feel that is
> better.

That actually looks like a better solution to me, as it would address the
problem for all users.

>  drivers/media/platform/omap3isp/isp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index a4ee6b86663e..54106a768e54 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -39,8 +39,6 @@
>   *     Troy Laramy <t-laramy@ti.com>
>   */
>
> -#include <asm/cacheflush.h>
> -
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
> @@ -49,6 +47,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/omap-iommu.h>
>  #include <linux/platform_device.h>
> @@ -58,6 +57,8 @@
>  #include <linux/sched.h>
>  #include <linux/vmalloc.h>
>
> +#include <asm/cacheflush.h>
> +
>  #ifdef CONFIG_ARM_DMA_USE_IOMMU
>  #include <asm/dma-iommu.h>
>  #endif

Why does this file need <asm/cacheflush.h> at all?
It doesn't call any of the flush_*() functions, and seems to compile fine
without (on arm32).

Perhaps it was included at the top intentionally, to override the definitions
of copy_{to,from}_user_page()? Fortunately that doesn't seem to be the
case, from a quick look at the assembler output.

So let's just remove the #include instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
