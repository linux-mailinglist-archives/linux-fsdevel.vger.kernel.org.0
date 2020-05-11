Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CD1CDEDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgEKPYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 11:24:46 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:34491 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEKPYn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 11:24:43 -0400
Received: by mail-oo1-f68.google.com with SMTP id s139so1052447oos.1;
        Mon, 11 May 2020 08:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFOqYFe+JnxanB4tWXMEfN+/EOvlslN0N0IK+ztKBU4=;
        b=fP8/k7rDNKTzbltDIp3OM9w3etOibsx0IcU5V/Kzgtv8M0d1Y50KwHpaLub+5fVG1o
         nhoPw43PkAYU6WXpi6T/G5//l3iS83pR0En9Upu0LlXXYWNxfZyhUPBEwCPUcbwSeQwe
         DkOGysofB/OJA3hgKt2eeYTydwxJWXYZSM/LEynZwmRvyx7jctBtVEjy/IhvNYhQ9Rcm
         RZqwNKlO5ammGdJ4lnwc8ovhnzm+P1SgGF7i1vTHg7avslKh84Ywt8Y9l6ci06+YDhIl
         nFAuJGX6+AHaKRu+CkjNaLZqjqUrYbVkrB1pKYJjNZ0A5sjBzKek3TZrtvNN2qTcUn3D
         BwxQ==
X-Gm-Message-State: AGi0PuY9VicF4PpQ0VV65smujtjZdo3cFI3gbbdsHc24lUyfG4jxOdqK
        V4OOQa/u+Edc4hPbtjQ+A/LyeQW+KVnpi17UdA0=
X-Google-Smtp-Source: APiQypJasCN4yl8lWM1FRmzaz39ukL/iWbljLpcbY1TKIvOnIUfi1IKvTWCvzobh4HXgocJWo6GBkm5ORmsQ5s6pFSU=
X-Received: by 2002:a4a:d204:: with SMTP id c4mr2380562oos.1.1589210682093;
 Mon, 11 May 2020 08:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200510075510.987823-1-hch@lst.de> <20200510075510.987823-32-hch@lst.de>
 <CAMuHMdU_OxNoKfO=i903kx0mgk0-i2h4u2ase3m9_dn6oFh_5g@mail.gmail.com> <20200511151120.GA28634@lst.de>
In-Reply-To: <20200511151120.GA28634@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 May 2020 17:24:30 +0200
Message-ID: <CAMuHMdW1S91i3x0unNcJnypHse7ifynGb4dZcVhJaemR3GH1Pg@mail.gmail.com>
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

Hi Christoph,

On Mon, May 11, 2020 at 5:11 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, May 11, 2020 at 09:40:39AM +0200, Geert Uytterhoeven wrote:
> > On Sun, May 10, 2020 at 9:57 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > flush_icache_range generally operates on kernel addresses, but for some
> > > reason m68k needed a set_fs override.  Move that into the m68k code
> > > insted of keeping it in the module loader.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Btw, do you know what part of flush_icache_range relied on set_fs?
> Do any of the m68k maintainers have an idea how to handle that in
> a nicer way when we can split the implementations?

arch/m68k/mm/cache.c:virt_to_phys_slow()

All instructions that look up addresses in the page tables look at the
source/destination function codes (SFC/DFC) to know if they have to use
the supervisor or user page tables.
So the actual implementation is the same: set_fs() merely configures
SFC/DFC, to select the address space to use.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
