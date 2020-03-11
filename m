Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D379B181B27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 15:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgCKO3L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 10:29:11 -0400
Received: from foss.arm.com ([217.140.110.172]:50372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgCKO3L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:29:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CF0F31B;
        Wed, 11 Mar 2020 07:29:10 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEA6A3F67D;
        Wed, 11 Mar 2020 07:29:07 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:29:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200311142905.GI3216816@arrakis.emea.arm.com>
References: <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com>
 <20200309160919.GM25745@shell.armlinux.org.uk>
 <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 08:46:18PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 9, 2020 at 5:09 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Mon, Mar 09, 2020 at 03:59:45PM +0000, Catalin Marinas wrote:
> > > On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > > > - revisit CONFIG_VMSPLIT_4G_4G for arm32 (and maybe mips32)
> > > >   to see if it can be done, and what the overhead is. This is probably
> > > >   more work than the others combined, but also the most promising
> > > >   as it allows the most user address space and physical ram to be used.
> > >
> > > A rough outline of such support (and likely to miss some corner cases):
> > >
> > > 1. Kernel runs with its own ASID and non-global page tables.
> > >
> > > 2. Trampoline code on exception entry/exit to handle the TTBR0 switching
> > >    between user and kernel.
> > >
> > > 3. uaccess routines need to be reworked to pin the user pages in memory
> > >    (get_user_pages()) and access them via the kernel address space.
> > >
> > > Point 3 is probably the ugliest and it would introduce a noticeable
> > > slowdown in certain syscalls.
> 
> There are probably a number of ways to do the basic design. The idea
> I had (again, probably missing more corner cases than either of you
> two that actually understand the details of the mmu):
> 
> - Assuming we have LPAE, run the kernel vmlinux and modules inside
>   the vmalloc space, in the top 256MB or 512MB on TTBR1
> 
> - Map all the physical RAM (up to 3.75GB) into a reserved ASID
>   with TTBR0
> 
> - Flip TTBR0 on kernel entry/exit, and again during user access.
> 
> This is probably more work to implement than your idea, but
> I would hope this has a lower overhead on most microarchitectures
> as it doesn't require pinning the pages. Depending on the
> microarchitecture, I'd hope the overhead would be comparable
> to that of ARM64_SW_TTBR0_PAN.

This still doesn't solve the copy_{from,to}_user() case where both
address spaces need to be available during copy. So you either pin the
user pages in memory and access them via the kernel mapping or you
temporarily map (kmap?) the destination/source kernel address. The
overhead I'd expect to be significantly greater than ARM64_SW_TTBR0_PAN
for the uaccess routines. For user entry/exit, your suggestion is
probably comparable with SW PAN.

-- 
Catalin
