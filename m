Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81A1CD2D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEKHlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 03:41:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43469 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgEKHlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 03:41:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id g14so6759418otg.10;
        Mon, 11 May 2020 00:41:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VS2fk1JcC03oZxkfqvBGknuVzDopGVbMhfQjjlcRALA=;
        b=ILqja3Dq36MXQ8lFuQq2JCpcnw3RBo+OG1PPqGmjzQqwrJWz1ZXK2qT0cxUMtoJC91
         X6X7vUxSTgRgV1fDhFNkS3lQgkpFbLLG8XKg4GdWqHo6NKdcRtoD7NKOvd6ytxr4Gwvt
         xDvYgeOn5sDI7fxr7d04Ih1WY7KlV09GCMr32bq3BDXVnvM0Xsg0U2VWimRwhzwVQYYv
         8B++jdIxL2HCcU07HBqbT1lUnzsJPevL7Ti/Zm7QGwXwrPQsWGFIJIwE0UKpavqSlYWL
         vi1m8GdeH4BV/3iQ2IgyePBgE/7pRq5AhiAWIebpM52dcRFxafDvvKOHu14EDveSprlF
         1gSA==
X-Gm-Message-State: AGi0PuZOGd7H10ajd/Ev2EsNTwCy3z4oDCBinFm2LMfLrRAlX2JaZQ4w
        zbMs0vHS7Xjk9wo7Zldy2ZYxULrJRjmFjdKpwog=
X-Google-Smtp-Source: APiQypLrnA3x0TQgcu4GbQXkWDUyTXgEK7R9Byl6mAxrtqxgZZGXhJd6czCyilOQXM5O9JA2CdYzbDyIV5/QIHKRb9A=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr10878643otl.107.1589182859874;
 Mon, 11 May 2020 00:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200510075510.987823-1-hch@lst.de> <20200510075510.987823-32-hch@lst.de>
In-Reply-To: <20200510075510.987823-32-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 May 2020 09:40:39 +0200
Message-ID: <CAMuHMdU_OxNoKfO=i903kx0mgk0-i2h4u2ase3m9_dn6oFh_5g@mail.gmail.com>
Subject: Re: [PATCH 31/31] module: move the set_fs hack for flush_icache_range
 to m68k
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>,
        Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 9:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> flush_icache_range generally operates on kernel addresses, but for some
> reason m68k needed a set_fs override.  Move that into the m68k code
> insted of keeping it in the module loader.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
