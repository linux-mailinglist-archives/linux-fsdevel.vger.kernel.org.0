Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE917D424
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 15:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgCHOTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 10:19:55 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33316 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCHOTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 10:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IVcvIDGwJZYeIvUKfXFgN/rhffyZlyGXJDMHZ+yeVcA=; b=K5AdU8Ceyd0YtsCSwH4Hj1L38
        t2ufNPUr4XC7GAFtajzsm47ier9yjsvWFQFWu0mCa1G7QppuiMbitZqbvPb4aJTWZ6pJLLx5Vshe/
        v2GvvL//7hb/7KOIAClcoZKG+252QJOCA2dceM7z7uL5PQHeC+XBtuH35BLfESIsNh8UZSSXotv36
        IcQJ6QRe3rswhZLX5YD26pP6u/QHUOsyEf8Nxkcs4Mw2s76sw15OdagnLghnPml3AGrTEiVnAoOe0
        DrgNb5R9cwFl1AYqDm4dBYoVPLxS++dlkn7dtqHabMQYYxUTAnLekyjyDyNA/t5H9PRrwV9RJoYw7
        I5Ik0L//Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33732)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jAwmE-0000p8-0s; Sun, 08 Mar 2020 14:19:34 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jAwm3-0002Se-Bj; Sun, 08 Mar 2020 14:19:23 +0000
Date:   Sun, 8 Mar 2020 14:19:23 +0000
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
Message-ID: <20200308141923.GI25745@shell.armlinux.org.uk>
References: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
 <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> On Fri, Mar 6, 2020 at 9:36 PM Nishanth Menon <nm@ti.com> wrote:
> > On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
> 
> >
> > ~few 1000s still relevant spread between 4G and 8G (confirmed that both
> > are present, relevant and in use).
> >
> > I wish we could sunset, but unfortunately, I am told(and agree)
> > that we should'nt just leave products (and these are long term
> > products stuck in critical parts in our world) hanging in the air, and
> > migrations to newer kernel do still take place periodically (the best
> > I can talk in public forum at least).
> 
> Thank you for the clear answer!
> 
> I agree we should certainly not break any such use cases, and for the
> 8GB case there is not really a good replacement (using zram/zswap
> instead of highmem could work for some new workloads, but would be a
> rather risky change for an upgrade on already deployed systems).
> 
> I hope it's ok to ask the same question every few years until you are
> reasonably sure that the users are ready to stop upgrading kernels
> beyond the following LTS kernel version. We can also do the same
> thing for the other 32-bit platforms that exceed the maximum amount
> of lowmem, and document which ones are known.
> 
> In the meantime, it would seem useful to increase the amount of
> lowmem that can be used by default, using a combination of some
> of the changes mentioned earlier
> 
> - add a VMSPLIT_2G_OPT config option for non-LPAE ARM kernels
>   to handle the common i.MX6 case with 2GB of RAM without highmem
> 
> - make VMSPLIT_2G_OPT (without LPAE) or VMSPLIT_2G (with
>   LPAE) the default in most ARM defconfig files as well as distros,
>   and disable highmem where possible, to see what breaks.
> 
> - extend zswap to use all the available high memory for swap space
>   when highmem is disabled.

I don't think that's a good idea.  Running debian stable kernels on my
8GB laptop, I have problems when leaving firefox running long before
even half the 16GB of swap gets consumed - the entire machine slows
down very quickly when it starts swapping more than about 2 or so GB.
It seems either the kernel has become quite bad at selecting pages to
evict.

It gets to the point where any git operation has a battle to fight
for RAM, despite not touching anything else other than git.

The behaviour is much like firefox is locking memory into core, but
that doesn't seem to be what's actually going on.  I've never really
got to the bottom of it though.

This is with 64-bit kernel and userspace.

So, I'd suggest that trading off RAM available through highmem for VM
space available through zswap is likely a bad idea if you have a
workload that requires 4GB of RAM on a 32-bit machine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
