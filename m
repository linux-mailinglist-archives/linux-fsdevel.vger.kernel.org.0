Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9391E181F61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgCKR0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:26:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730193AbgCKR0h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:26:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FC8C1FB;
        Wed, 11 Mar 2020 10:26:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0166D3F6CF;
        Wed, 11 Mar 2020 10:26:33 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:26:31 +0000
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
Message-ID: <20200311172631.GN3216816@arrakis.emea.arm.com>
References: <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com>
 <20200309160919.GM25745@shell.armlinux.org.uk>
 <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
 <20200311142905.GI3216816@arrakis.emea.arm.com>
 <CAK8P3a2RC+sg2Tz4M8mkQ_d78FTFdES+YsucUzDFx=UK+L8Oww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2RC+sg2Tz4M8mkQ_d78FTFdES+YsucUzDFx=UK+L8Oww@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:59:53PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 11, 2020 at 3:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > > - Flip TTBR0 on kernel entry/exit, and again during user access.
> > >
> > > This is probably more work to implement than your idea, but
> > > I would hope this has a lower overhead on most microarchitectures
> > > as it doesn't require pinning the pages. Depending on the
> > > microarchitecture, I'd hope the overhead would be comparable
> > > to that of ARM64_SW_TTBR0_PAN.
> >
> > This still doesn't solve the copy_{from,to}_user() case where both
> > address spaces need to be available during copy. So you either pin the
> > user pages in memory and access them via the kernel mapping or you
> > temporarily map (kmap?) the destination/source kernel address. The
> > overhead I'd expect to be significantly greater than ARM64_SW_TTBR0_PAN
> > for the uaccess routines. For user entry/exit, your suggestion is
> > probably comparable with SW PAN.
> 
> Good point, that is indeed a larger overhead. The simplest implementation
> I had in mind would use the code from arch/arm/lib/copy_from_user.S and
> flip ttbr0 between each ldm and stm (up to 32 bytes), but I have no idea
> of the cost of storing to ttbr0, so this might be even more expensive. Do you
> have an estimate of how long writing to TTBR0_64 takes on Cortex-A7
> and A15, respectively?

I don't have numbers but it's usually not cheap since you need an ISB to
synchronise the context after TTBR0 update (basically flushing the
pipeline).

> Another way might be to use a use a temporary buffer that is already
> mapped, and add a memcpy() through L1-cache to reduce the number
> of ttbr0 changes. The buffer would probably have to be on the stack,
> which limits the size, but for large copies get_user_pages()+memcpy()
> may end up being faster anyway.

IIRC, the x86 attempt from Ingo some years ago was using
get_user_pages() for uaccess. Depending on the size of the buffer, this
may be faster than copying twice.

-- 
Catalin
