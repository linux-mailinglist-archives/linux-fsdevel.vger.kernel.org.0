Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1677E17E22C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCIOFB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 10:05:01 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49144 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCIOFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d26Ye+vMRYj5g5ykorwl/W5eqkd9joFbNEWspN4ENAs=; b=Xl4UNnGtpQtUvm2BgVXiCnesn
        7sfNE6HTuF5M1sEiacWYVtLUj7JcKknJbqaOlmfa4Uc1uchICRc2UPtoZKgJ0Z4TIX9KenW7nmUtk
        jmKticzXy8ktdt2H4UZBTcBKr1oqKdgzkaVXoyOHbYCTnXmzv7j7ETY8ebK4+jq9qBgW1p3TbEVdp
        iMM3SFdsMiP7+ayIeGrD3Lh5qVn0R0EmfK9Ubo8B0qSyLSX6K+7nW1r6FIzw6VM/1qJeGmbKeg0bK
        f1I3tsqkvGx8S3xga4Nb3k3LYM0BLa3gIM5rWVU8XT09RkrZFk5zOv1Eqy34iooGn9DOWutdB77v4
        BXyB9MVUQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:50736)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jBJ1T-0007Ja-5X; Mon, 09 Mar 2020 14:04:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jBJ1L-0003Qb-Vi; Mon, 09 Mar 2020 14:04:40 +0000
Date:   Mon, 9 Mar 2020 14:04:39 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Message-ID: <20200309140439.GL25745@shell.armlinux.org.uk>
References: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200308141923.GI25745@shell.armlinux.org.uk>
 <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 09, 2020 at 02:33:26PM +0100, Arnd Bergmann wrote:
> On Sun, Mar 8, 2020 at 3:20 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > > On Fri, Mar 6, 2020 at 9:36 PM Nishanth Menon <nm@ti.com> wrote:
> > > > On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
> >
> > > - extend zswap to use all the available high memory for swap space
> > >   when highmem is disabled.
> >
> > I don't think that's a good idea.  Running debian stable kernels on my
> > 8GB laptop, I have problems when leaving firefox running long before
> > even half the 16GB of swap gets consumed - the entire machine slows
> > down very quickly when it starts swapping more than about 2 or so GB.
> > It seems either the kernel has become quite bad at selecting pages to
> > evict.
> >
> > It gets to the point where any git operation has a battle to fight
> > for RAM, despite not touching anything else other than git.
> >
> > The behaviour is much like firefox is locking memory into core, but
> > that doesn't seem to be what's actually going on.  I've never really
> > got to the bottom of it though.
> >
> > This is with 64-bit kernel and userspace.
> 
> I agree there is something going wrong on your machine, but I
> don't really see how that relates to my suggestion.

You are suggesting for a 4GB machine to use 2GB of RAM for normal
usage via an optimised virtual space layout, and 2GB of RAM for
swap using ZSWAP, rather than having 4GB of RAM available via the
present highmem / lowmem system.

I'm saying that is quite risky given the behaviours I'm seeing,
where modern Linux seems to be struggling to work out what pages
it should be evicting.

I think Linux performs way better when it doesn't have to use
swap.

> > So, I'd suggest that trading off RAM available through highmem for VM
> > space available through zswap is likely a bad idea if you have a
> > workload that requires 4GB of RAM on a 32-bit machine.
> 
> Aside from every workload being different, I was thinking of
> these general observations:
> 
> - If we are looking at a future without highmem, then it's better to use
>   the extra memory for something than not using it. zswap seems like
>   a reasonable use.

I think that's still a very open question, one which hasn't been
answered yet.

> - A lot of embedded systems are configured to have no swap at all,
>   which can be for good or not-so-good reasons. Having some
>   swap space available often improves things, even if it comes
>   out of RAM.

How do you come up with that assertion?  What is the evidence behind
it?

This is kind of the crux of my point in the previous email: Linux
with swap performs way worse for me - if I had 16GB of RAM in my
laptop, I bet it would perform better than my current 8GB with a
16GB swap file - where, when the swap file gets around 8GB full,
the system as a whole starts to struggle.

That's about a 50/50 split of VM space between RAM and swap.

Proposing 2GB+ swap 2GB RAM would potentially place these machines
into the same situation as my laptop, and if it also results in
a loss of performance, we could end up with regression reports.

> - A particularly important case to optimize for is 2GB of RAM with
>   LPAE enabled. With CONFIG_VMSPLIT_2G and highmem, this
>   leads to the paradox -ENOMEM when 256MB of highmem are
>   full while plenty of lowmem is available. With highmem disabled,
>   you avoid that at the cost of losing 12% of RAM.

What happened to requests for memory from highmem being able to be
sourced from lowmem if highmem wasn't available?  That used to be
standard kernel behaviour.

> - With 4GB+ of RAM and CONFIG_VMSPLIT_2G or
>   CONFIG_VMSPLIT_3G, using gigabytes of RAM for swap
>   space would usually be worse than highmem, but once
>   we have VMSPLIT_4G_4G, it's the same situation as above
>   with 6% of RAM used for zswap instead of highmem.

I think the chances of that happening are very slim - I doubt there
is the will to invest the energy amongst what is left of the 32-bit
ARM community.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
