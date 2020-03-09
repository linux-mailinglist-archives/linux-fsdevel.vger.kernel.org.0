Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0F17E450
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCIQJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 12:09:39 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50624 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgCIQJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4WJ6RRjRxj58Y2szEsveSp6vWyd/sdxRQxE7lizeTGg=; b=so5+iHtVgqSfai4qSOj1oxrE+
        ZsvzKP9v8gREGRl/MnOEHqraNdvdCgWnOR4VC4jLNIf/7y2C9mFNsqDRtsDKr2onOebVCCrwu+y2p
        k0cZmvafWm45Gll8Aq3YrRWOJMk6ofZPxt67qQRS96IiV0+eN63zp+4ZBbOkDRpfyA4NaJRn8kaED
        1rnbleBN1ggg6DBqfxzJKpODVEdtQ1uow9Z5bLvHLw/DzcNjV/t6BUJgi/4spPloXQZQqvY/I7kCu
        HZm5Fzt3WpbavxhUkfEVuZE4NRdpdtngH9REd60Rs3E5dGFSJqYiP0UrMN0L8ipP1n0cf4TZcmwOE
        UGvaPY97A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34200)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jBKy7-0007tm-Qi; Mon, 09 Mar 2020 16:09:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jBKxz-0003Vd-9p; Mon, 09 Mar 2020 16:09:19 +0000
Date:   Mon, 9 Mar 2020 16:09:19 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
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
Message-ID: <20200309160919.GM25745@shell.armlinux.org.uk>
References: <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309155945.GA4124965@arrakis.emea.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:59:45PM +0000, Catalin Marinas wrote:
> On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > - revisit CONFIG_VMSPLIT_4G_4G for arm32 (and maybe mips32)
> >   to see if it can be done, and what the overhead is. This is probably
> >   more work than the others combined, but also the most promising
> >   as it allows the most user address space and physical ram to be used.
> 
> A rough outline of such support (and likely to miss some corner cases):
> 
> 1. Kernel runs with its own ASID and non-global page tables.
> 
> 2. Trampoline code on exception entry/exit to handle the TTBR0 switching
>    between user and kernel.
> 
> 3. uaccess routines need to be reworked to pin the user pages in memory
>    (get_user_pages()) and access them via the kernel address space.
> 
> Point 3 is probably the ugliest and it would introduce a noticeable
> slowdown in certain syscalls.

We also need to consider that it has implications for the single-kernel
support; a kernel doing this kind of switching would likely be horrid
for a kernel supporting v6+ with VIPT aliasing caches.  Would we be
adding a new red line between kernels supporting VIPT-aliasing caches
(present in earlier v6 implementations) and kernels using this system?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
