Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F2529DC07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390877AbgJ2ATB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:19:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44093 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbgJ1WpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:45:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id m26so630838otk.11;
        Wed, 28 Oct 2020 15:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XN02PSejXD+FeqWTrgwKvG1TTSDYTM2yrZb6ygptq8=;
        b=CVTjna5g2XVGfGso31JoRpR07nQGR1+pt3N1oUBEC3lOAK+ejuNtguI896SRlUKoEe
         OlTsqTpasI16TzoW4+oF7UhbhIlkiOFHiVz2HUPn7J1xOONJnRpB8fnC4j7zYrfXTvT7
         kamRM6QaiwLy5mNoE5XDdayATyai8Of5DS47OF9jhUkOtRqX4yTJI2XNH+rbJ1KE89/A
         sqlgmdSdRyJ4gMKXJnsLDwBOUOlvhaO0GpgHtH2dvWkwp9pWszdr4H+S1aVLHmxcthF+
         kQF3KJrVqm7w9vSYCVtT77kMiKHWr8JgYbcw1m806wTYPzDkkAx1VKhkPGCBJ3Mp9GLE
         +fTg==
X-Gm-Message-State: AOAM533RWsrc+p1DMUBcfN0cdBltY7Dc8+xwUahhPoFjpalh1aqdVeA3
        HzDJ+0QrthseXpLO4O/gZxIxMj49XxaMysz7OImzPIFzXYsMhQ==
X-Google-Smtp-Source: ABdhPJwVZzki+tgZs/Q8WXcxtVj9dxZr8/KAouxapBQlbbCT10SMVoqLjSjBsdSeiewzamwEvqLH3hEqv+123K4FYD8=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr4993384ooa.1.1603877160928;
 Wed, 28 Oct 2020 02:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201027112955.14157-1-rppt@kernel.org> <20201027112955.14157-12-rppt@kernel.org>
In-Reply-To: <20201027112955.14157-12-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Oct 2020 10:25:49 +0100
Message-ID: <CAMuHMdU4r4CJ1kBu7gx1jkputjDn2S8Lqkj7RPfa3XUnM1QOFg@mail.gmail.com>
Subject: Re: [PATCH 11/13] m68k/mm: make node data and node setup depend on CONFIG_DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux MM <linux-mm@kvack.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

On Tue, Oct 27, 2020 at 12:31 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The pg_data_t node structures and their initialization currently depends on
> !CONFIG_SINGLE_MEMORY_CHUNK. Since they are required only for DISCONTIGMEM
> make this dependency explicit and replace usage of
> CONFIG_SINGLE_MEMORY_CHUNK with CONFIG_DISCONTIGMEM where appropriate.
>
> The CONFIG_SINGLE_MEMORY_CHUNK was implicitly disabled on the ColdFire MMU
> variant, although it always presumed a single memory bank. As there is no
> actual need for DISCONTIGMEM in this case, make sure that ColdFire MMU
> systems set CONFIG_SINGLE_MEMORY_CHUNK to 'y'.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks for your patch!

> ---
>  arch/m68k/Kconfig.cpu           | 6 +++---
>  arch/m68k/include/asm/page_mm.h | 2 +-
>  arch/m68k/mm/init.c             | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Is there any specific reason you didn't convert the checks for
CONFIG_SINGLE_MEMORY_CHUNK in arch/m68k/kernel/setup_mm.c
and arch/m68k/include/asm/virtconvert.h?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
