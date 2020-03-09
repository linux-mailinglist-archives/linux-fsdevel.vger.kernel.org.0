Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7717E907
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 20:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCITqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 15:46:38 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46091 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCITqi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:46:38 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMGZS-1isD500wxK-00JM4f; Mon, 09 Mar 2020 20:46:36 +0100
Received: by mail-qk1-f181.google.com with SMTP id c145so4695230qke.12;
        Mon, 09 Mar 2020 12:46:35 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3rq6yzydjwfH0UH1dKg+FjDRwxNNz1MOIEGKZue9mEMqQln0ao
        MvGgtLDZC+DAzcC1iQE1mJ6Li6ZvtnQs/WBOCCc=
X-Google-Smtp-Source: ADFU+vvmBvMz+V6RDUU++ZwSagdLLK5RIhqNTJ7v8Q8rLCrbads695yLqa65IiOBHxFXCnfQzEWO8L12fWPy8qQjUb0=
X-Received: by 2002:a37:6455:: with SMTP id y82mr7117037qkb.286.1583783194930;
 Mon, 09 Mar 2020 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com> <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com> <20200309160919.GM25745@shell.armlinux.org.uk>
In-Reply-To: <20200309160919.GM25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 20:46:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
Message-ID: <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bBz45YywharMfMeD3eAylez7Ounvj65HPQEEQib3QyJAizH9t4T
 +vrg8YPRfP/wkc3x9uVrXC2fg1vn05X8acW5S8uqkcfR611JV6haZdbjIhjZOb5VXAEIU7T
 fybLcm2xzaHPSwnjc1kRg9m+mHJtEcSLp71hOXsnfW8NT9ZsZ+77b5tzERPVbdF5887rNI9
 R/z93tWt8v4tBo0ketAlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3oD3vabjtEQ=:uf5dhXYr9zoCuZp/lYOLA5
 PMvgD5mIkR064YxlKT9lB+1ZGq9kjrwQgLDsImiD6z35fFl31b+HKsYetkDDL1KgDNsGs8M7k
 R1oaj4voGgjyPF+t/AH1FC1GG21eGzAlGvdYZUA/ttauCDUVjk4pmuHZ6VyeRnl1Ot+RJfeOw
 TQOmSiRDpq3XKzdxVLTEWSaViFdPTlimJ3fkutFcsSgBQGiZfOqrpOl8TT8JCl1pqupugg9hQ
 rwCyvTyDjnvaZ7XwMjJN9ItTabaTDn9Vx7UCDraGDVCoBZfxJTNaIGABGpOlw7SUXZUK2IxXc
 i6cNH6p26cVgZE4vSvRteQJI2n7d69OjCsdybhGfx9TyRi5lJO0DpPdPYu9zEETpKU4chZ4f4
 +Y5zL0Sj11hxzvJB7WJ3HNTrjQ36RqNHQJyOk0+BBS8G4lmd+vCsfx0escAzCknKVz+GllMtD
 T2krPnnyoNH29/Jjzj9+YogN+uuV0TtadjHmXr81PmSab1wmnbQd+PDVzQIBjEdF8Ylv8pHZP
 T4vscLw+V3j6KzvOhE8jqoOo/Cc915U/2we96med5LcBIDZWVPfqIw9EktqpjyiCb4B6dYrqE
 UUN260UVYq2b+emfbsHeXhR89Zb9G6y8DkaL4LdlNHbRS4tdEVL/LRBSE7NKbx2IVtICC/I+4
 CSNaLWcxGUeMYw8bu9a70dy5x8VswT8xhcLEIApDzhChO/frkrPgWvK8tn3qVK6Of5/a865PQ
 EMNJbhkUIdHZM31hdABugNVrNCiucPw4T7qtSeT/8yrURvJj/oag3CwyRAN6QBCto4EHOrCdc
 Hb4ckkyulIukGhi2eVQv4bNmqFLqSnIhrJrsDbsFMERWMa2DQQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 9, 2020 at 5:09 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Mon, Mar 09, 2020 at 03:59:45PM +0000, Catalin Marinas wrote:
> > On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > > - revisit CONFIG_VMSPLIT_4G_4G for arm32 (and maybe mips32)
> > >   to see if it can be done, and what the overhead is. This is probably
> > >   more work than the others combined, but also the most promising
> > >   as it allows the most user address space and physical ram to be used.
> >
> > A rough outline of such support (and likely to miss some corner cases):
> >
> > 1. Kernel runs with its own ASID and non-global page tables.
> >
> > 2. Trampoline code on exception entry/exit to handle the TTBR0 switching
> >    between user and kernel.
> >
> > 3. uaccess routines need to be reworked to pin the user pages in memory
> >    (get_user_pages()) and access them via the kernel address space.
> >
> > Point 3 is probably the ugliest and it would introduce a noticeable
> > slowdown in certain syscalls.

There are probably a number of ways to do the basic design. The idea
I had (again, probably missing more corner cases than either of you
two that actually understand the details of the mmu):

- Assuming we have LPAE, run the kernel vmlinux and modules inside
  the vmalloc space, in the top 256MB or 512MB on TTBR1

- Map all the physical RAM (up to 3.75GB) into a reserved ASID
  with TTBR0

- Flip TTBR0 on kernel entry/exit, and again during user access.

This is probably more work to implement than your idea, but
I would hope this has a lower overhead on most microarchitectures
as it doesn't require pinning the pages. Depending on the
microarchitecture, I'd hope the overhead would be comparable
to that of ARM64_SW_TTBR0_PAN.

> We also need to consider that it has implications for the single-kernel
> support; a kernel doing this kind of switching would likely be horrid
> for a kernel supporting v6+ with VIPT aliasing caches.  Would we be
> adding a new red line between kernels supporting VIPT-aliasing caches
> (present in earlier v6 implementations) and kernels using this system?

I would initially do it for LPAE only, given that this is already an
incompatible config option. I don't think there are any v6 machines with
more than 1GB of RAM (the maximum for AST2500), and the only distro
that ships a v6+ multiplatform kernel is Raspbian, which in turn needs
a separate LPAE kernel for the large-memory machines anyway.

Only doing it for LPAE would still cover the vast majority of systems that
actually shipped with more than 2GB. There are a couple of exceptions,
i.e. early  Cubox i4x4, the Calxeda Highbank developer system and the
Novena Laptop, which I would guess have a limited life expectancy
(before users stop updating kernels) no longer than the 8GB
Keystone-2.

Based on that, I would hope that the ARMv7 distros can keep shipping
the two kernel images they already ship:

- The non-LPAE kernel modified to VMSPLIT_2G_OPT, not using highmem
  on anything up to 2GB, but still supporting the handful of remaining
  Cortex-A9s with 4GB using highmem until they are completely obsolete.

- The LPAE kernel modified to use a newly added VMSPLIT_4G_4G,
   with details to be worked out.

Most new systems tend to be based on Cortex-A7 with no more than 2GB,
so those could run either configuration well.  If we find the 2GB of user
address space too limiting for the non-LPAE config, or I missed some
important pre-LPAE systems with 4GB that need to be supported for longer
than other highmem systems, that can probably be added later.

    Arnd
