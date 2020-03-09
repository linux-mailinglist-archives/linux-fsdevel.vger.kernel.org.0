Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0AB17E30F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCIPFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 11:05:17 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgCIPFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:05:16 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MnJdE-1janPi1KtA-00jEZ9; Mon, 09 Mar 2020 16:05:14 +0100
Received: by mail-qt1-f177.google.com with SMTP id l20so5557303qtp.4;
        Mon, 09 Mar 2020 08:05:14 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3HqHeMHH9TihrNmzLLFYCfnATsDJSD+IKTVqXxyMWleNEB0Gmt
        MVWowcjrJVomitqs/+ntcrH6J4G1L09Sr+pPL9M=
X-Google-Smtp-Source: ADFU+vvxWhD4Ku1IfT+mUmY/AeB1CS0OqCZ/jtDyF/dQT9uwneeJb7AmmSc5NwwGRV+bP0xVJ9xB9rGipT01taiUGkg=
X-Received: by 2002:ac8:7381:: with SMTP id t1mr14598317qtp.142.1583766312944;
 Mon, 09 Mar 2020 08:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com> <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200308141923.GI25745@shell.armlinux.org.uk> <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
 <20200309140439.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20200309140439.GL25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 16:04:54 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1HEhwie1uUObQMJyGcs_WSwz4Gj81tAWXZX4d2ff77XA@mail.gmail.com>
Message-ID: <CAK8P3a1HEhwie1uUObQMJyGcs_WSwz4Gj81tAWXZX4d2ff77XA@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dmgsuHQCUIzYa0I7DN5xfdcgt5Nq7Iah49tOapDoqpRZpxpAaXv
 7/kkwoJZZ+Y+m3JLVaKVx8fo5io5Z9o10Dtr0QaW4IwZIevdJieL0WWlZMPTfYJ+NOHhs+/
 Oh9qqYE7VuAIBumyBprWWcvu2I1SM1vfFio1P7zjdhUPEsxuSYaMQdZr9BjW7mI9bQaZsd5
 GNwoFPDSAxbEUubr3yCgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Vfh85SduTs=:o07GddFM5AX/0D26sVOJMD
 20aYEUAczgqPDNhbX+xoYrb8kvAyfuV820RioC/SOWQ2Ad6nkHQ//vmPFuVxo8nC9eszt70NI
 tJUiNhux12zK1NrV9W9jW8XvxCMQuVdaayLFww9i1MPsu0hq8PPeZcDmixex2fPNNkUpvTBey
 7UM9YVtU/FjE+kBHgt7FDXvWDwjWJbeWV0VEl9vvPfIAplqIE7e8nO6dZQv5++PNBbnCIU7nI
 ouoANgLfqOak2drUP689ZpilUOQOPgbiC70bfj00dP7TACd9VQs1px+3rulO7dDHp362Jucrk
 iui5iHeDkgnhfHTMicFcSQDh5QqHNwFnLS3lye/pAiSR/RcXiM8JOFiz04d7Dpo1aX5h/66aE
 gpXSL3RpG2SBGXxqbQQBAsksq2Y7q8Ad6jnnOkUryIbWV8l5ShDTtpdV21Oqp/+XVWx+MM9Oe
 Ob+eU1nQMVFh7iuXqaLUSpj873JYejV9jZ/r5MvhvPzE5LV1MvuWJkZIj3CyJYSnUvlLz+u/0
 g+qiPpm70gEKUlFrTK7Wscx/mWpCTshsEw6XtWbqUUliD+DdQTaCTVmbRY0fcQazeD599dO/n
 aT1G03zBIfNrB1+SH4GRThPiSuA1vzlfnLaplouCDbuIYrVN1pie7b+iIuKJcmDLLTg/mwNgz
 Bo7VBpyShFG8vuVFRdZkw0wh5jhWaq7RTZQyKXvjV+6byD+TEy+4o53KuRBpeadiZK9Nnv8Et
 7sj+N4qtzTs0OoEc031H5CGjLMYJQLubot+CVq0E8oE9VTNLDd5dYAaEQELHsgfN34OWWfZe/
 vFGtDVTnAta/vpSU+c4F/aN/KTy25NDMjEY/9CLXqIgYGbjXRU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:05 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Mar 09, 2020 at 02:33:26PM +0100, Arnd Bergmann wrote:
> > On Sun, Mar 8, 2020 at 3:20 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > > On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > > > On Fri, Mar 6, 2020 at 9:36 PM Nishanth Menon <nm@ti.com> wrote:
> > > > > On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
> > >
> > > > - extend zswap to use all the available high memory for swap space
> > > >   when highmem is disabled.
> > >
> > > I don't think that's a good idea.  Running debian stable kernels on my
> > > 8GB laptop, I have problems when leaving firefox running long before
> > > even half the 16GB of swap gets consumed - the entire machine slows
> > > down very quickly when it starts swapping more than about 2 or so GB.
> > > It seems either the kernel has become quite bad at selecting pages to
> > > evict.
> > >
> > > It gets to the point where any git operation has a battle to fight
> > > for RAM, despite not touching anything else other than git.
> > >
> > > The behaviour is much like firefox is locking memory into core, but
> > > that doesn't seem to be what's actually going on.  I've never really
> > > got to the bottom of it though.
> > >
> > > This is with 64-bit kernel and userspace.
> >
> > I agree there is something going wrong on your machine, but I
> > don't really see how that relates to my suggestion.
>
> You are suggesting for a 4GB machine to use 2GB of RAM for normal
> usage via an optimised virtual space layout, and 2GB of RAM for
> swap using ZSWAP, rather than having 4GB of RAM available via the
> present highmem / lowmem system.

No, that would not be good. The cases where I would hope
to get improvements out of zswap are:

- 1GB of RAM with VMSPLIT_3G, when VMSPLIT_3G_OPT
  and VMSPLIT_2G don't work because of user address space
  requirements

- 2GB of RAM with VMSPLIT_2G

- 4GB of RAM if we add VMSPLIT_4G_4G

> > - A lot of embedded systems are configured to have no swap at all,
> >   which can be for good or not-so-good reasons. Having some
> >   swap space available often improves things, even if it comes
> >   out of RAM.
>
> How do you come up with that assertion?  What is the evidence behind
> it?

The idea of zswap is that it's faster to compress/uncompress
data than to actually access a slow disk. So if you already have
a swap space, it gives you another performance tier inbetween
direct-mapped pages and the slow swap.

If you don't have a physical swap space, then reserving a little
bit of RAM for compressed swap means that rarely used pages
take up less space and you end up with more RAM available
for the workload you want to run.

> This is kind of the crux of my point in the previous email: Linux
> with swap performs way worse for me - if I had 16GB of RAM in my
> laptop, I bet it would perform better than my current 8GB with a
> 16GB swap file - where, when the swap file gets around 8GB full,
> the system as a whole starts to struggle.
>
> That's about a 50/50 split of VM space between RAM and swap.

As I said above I agree that very few workloads would behave
better from using using 1.75GB RAM plus 2.25GB zswap (storing
maybe 6GB of data) compared to highmem. To deal with 4GB
systems, we probably need either highmem or VMSPLIT_4G_4G.

> > - A particularly important case to optimize for is 2GB of RAM with
> >   LPAE enabled. With CONFIG_VMSPLIT_2G and highmem, this
> >   leads to the paradox -ENOMEM when 256MB of highmem are
> >   full while plenty of lowmem is available. With highmem disabled,
> >   you avoid that at the cost of losing 12% of RAM.
>
> What happened to requests for memory from highmem being able to be
> sourced from lowmem if highmem wasn't available?  That used to be
> standard kernel behaviour.

AFAICT this is how it's supposed to work, but for some reason it
doesn't always. I don't know the details, but have heard of recent
complaints about it. I don't think it's the actual get_free_pages
failing, but rather some heuristic looking at the number of free pages.

> > - With 4GB+ of RAM and CONFIG_VMSPLIT_2G or
> >   CONFIG_VMSPLIT_3G, using gigabytes of RAM for swap
> >   space would usually be worse than highmem, but once
> >   we have VMSPLIT_4G_4G, it's the same situation as above
> >   with 6% of RAM used for zswap instead of highmem.
>
> I think the chances of that happening are very slim - I doubt there
> is the will to invest the energy amongst what is left of the 32-bit
> ARM community.

Right. But I think it makes sense to discuss what it would take
to do it anyway, and to see who would be interested in funding or
implementing VMSPLIT_4G_4G. Whether it happens or not comes
down to another tradeoff: Without it, we have to keep highmem
around for a much long timer to support systems with 4GB of
RAM along with systems that need both 2GB of physical RAM
and 3GB of user address space, while adding VMSPLIT_4G_4G
soon means we can probably kill off highmem after everybody
with more 8GB of RAM or more has stopped upgrading kernels.
Unlike the 2GB case, this is something we can realistically
plan for.

What is going to be much harder I fear is to find someone to
implement it on MIPS32, which seems to be a decade ahead
of 32-bit ARM in its decline, and also has a small number of users
with 4GB or more, and architecturally it seems harder to
implement or impossible depending on the type of MIPS
MMU.

        Arnd
