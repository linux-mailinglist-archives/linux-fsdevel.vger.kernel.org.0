Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5DE15C8DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 17:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBMQxJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 11:53:09 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:54821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBMQxJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:53:09 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N5mSj-1jZZ3g2UR9-017H58; Thu, 13 Feb 2020 17:53:07 +0100
Received: by mail-qt1-f181.google.com with SMTP id e21so4841150qtp.13;
        Thu, 13 Feb 2020 08:53:07 -0800 (PST)
X-Gm-Message-State: APjAAAUFnk+9CdLaeCrmBl4EjKOXaaXbZjyONt7haFYOX1zLN4ALW1Cd
        Z1DvKEIMgTFYq1IvUNVim7uHuFReuo/S4gb9WJk=
X-Google-Smtp-Source: APXvYqy4gfD4gDOo3l2kqBaxaneA3Mxd3sL9iK2C79jzJxJBs1MCO7MsBN5MK3tSaslTWwKsP/R7oVEhM2+rnrndMy0=
X-Received: by 2002:ac8:669a:: with SMTP id d26mr5640059qtp.304.1581612786288;
 Thu, 13 Feb 2020 08:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com> <20200212085004.GL25745@shell.armlinux.org.uk>
In-Reply-To: <20200212085004.GL25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Feb 2020 17:52:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
Message-ID: <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, kernel-team@fb.com,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EclmwEE9SmZcXxxr7DlYxo3CLjauKnvZQEhwJDlgJsEOcZs6NmZ
 PuSkreKNIwmWpRbJmtTJ1hQGvP0avOPS8OWgcaEiRrRePx14epwFSa+lOoxxXAqv//USFb4
 7fi1956J1PfI0AXNm+W63LHpxRrpFUTb+BVX9o/vMkyTyyAktzeN4fdYXptTbDlZaFkEP2t
 Tq7+quiINSxLe9j1d1enw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:92ve0G3h8N0=:UfJVsMRo1yh19qw5q5p6tb
 kuxI+/rPBoSnofKN1GNBnSeH7CE/rdPSuh8TZycv8CaWQQlyRy2/PhgahW9gr1KDMKX4zNdMY
 juXyKuST67nvmnnIBOaFr/gqy+GJW5YXRBZtf+hV23WzkbkT45KvKlvVMVv4BzXcsSzzZmt8Q
 xIkFvwIZmrqvZLyG3i7f3ojIQ2lJBRsrw0prp9vVmdBN86l44TpqyrWENzhAZr2FM2EaDPWNN
 euWtb0V6odrDgpBqdoOZz42ahwMKZQ87HEC0pqvob0QKMAO2yj4Xwcw68MV9CUBM+9ZVKTljb
 T+oOs9sbTWsBjtX/7uunDwBI+eLA+1zDqdvUPbX8tWAwRIvsEfj2n5toOStbIQ7nHmpwc+bGt
 Eg4ifEphQVeSu3fdrRLCsql2FofpBfpEEsUCbk/LPItzQIAy3yzJ24dR07vKhpoFkrdtegSE1
 ylVdCTo3RnxFPuS2HSW4q+BIiUsBflzNY5k1PkAQuDLLeBAo5lN5n+lB8ARBLm2SeFuKfjMbM
 7/bOxwIG7YMffOqIR+OGO5WSDKlbnZUpliiPWaHvygzG3eSZFDbSW5LVUV4GS/Bi9t1oRETBx
 dI2kSBTIGOCck4me2JxIbB5QZPY1aH7jZbNDK+IUcjuKwdszQMrPOkGaQI2/FxcBrFv6tk9fM
 d8msPbhi3tx3Q7qc0iQweANEy/715ZSKbIJSIq82EtY+MnwIcfFhZCkO6ntyXd5T2x4ThQi0Q
 w3V2ioWDbUtz01UfOsPd39UJ/y96gPN2dL5KZfSFIZ/Ni53X6DNvhVvVH+3qiw+5HCk9NTZoO
 VLtaUP8CbD9ipX9KXsVxKgYyUarOY/ib9UmwT/kdlqqWb58wQ8=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Feb 11, 2020 at 05:03:02PM -0800, Linus Torvalds wrote:
> > On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > What's the situation with highmem on ARM?
> >
> > Afaik it's exactly the same as highmem on x86 - only 32-bit ARM ever
> > needed it, and I was ranting at some people for repeating all the
> > mistakes Intel did.
> >
> > But arm64 doesn't need it, and while 32-bit arm is obviosuly still
> > selling, I think that in many ways the switch-over to 64-bit has been
> > quicker on ARM than it was on x86. Partly because it happened later
> > (so all the 64-bit teething pains were dealt with), but largely
> > because everybody ended up actively discouraging 32-bit on the Android
> > side.
> >
> > There were a couple of unfortunate early 32-bit arm server attempts,
> > but they were - predictably - complete garbage and nobody bought them.
> > They don't exist any more.

I'd generally agree with that, the systems with more than 4GB tended to
be high-end systems predating the Cortex-A53/A57 that quickly got
replaced once there were actual 64-bit parts, this would include axm5516
(replaced with x86-64 cores after sale to Intel), hip04 (replaced
with arm64), or ecx-2000 (Calxeda bankruptcy).

The one 32-bit SoC that I can think of that can actually drive lots of
RAM and is still actively marketed is TI Keystone-2/AM5K2.
The embedded AM5K2 is listed supporting up to 8GB of RAM, but
the verison in the HPE ProLiant m800 server could take up to 32GB (!).

I added Santosh and Kishon to Cc, they can probably comment on how
long they think users will upgrade kernels on these. I suspect these
devices can live for a very long time in things like wireless base stations,
but it's possible that they all run on old kernels anyway by now (and are
not worried about y2038).

> > So at least my gut feel is that the arm people don't have any big
> > reason to push for maintaining HIGHMEM support either.
> >
> > But I'm adding a couple of arm people and the arm list just in case
> > they have some input.
> >
> > [ Obvious background for newly added people: we're talking about
> > making CONFIG_HIGHMEM a deprecated feature and saying that if you want
> > to run with lots of memory on a 32-bit kernel, you're doing legacy
> > stuff and can use a legacy kernel ]
>
> Well, the recent 32-bit ARM systems generally have more than 1G
> of memory, so make use of highmem as a rule.  You're probably
> talking about crippling support for any 32-bit ARM system produced
> in the last 8 to 10 years.

What I'm observing in the newly added board support is that memory
configurations are actually going down, driven by component cost.
512MB is really cheap (~$4) these days with a single 256Mx16 DDR3
chip or two 128Mx16. Going beyond 1GB is where things get expensive
with either 4+ chips or LPDDR3/LPDDR4 memory.

For designs with 1GB, we're probably better off just using
CONFIG_VMSPLIT_3G_OPT (without LPAE) anyway, completely
avoiding highmem. That is particularly true on systems with a custom
kernel configuration.

2GB machines are less common, but are definitely important, e.g.
MT6580 based Android phones and some industrial embedded machines
that will live a long time. I've recently seen reports of odd behavior
with CONFIG_VMSPLIT_2G and plus CONFIG_HIGHMEM and a 7:1
ratio of lowmem to highmem that apparently causes OOM despite lots
of lowmem being free. I suspect a lot of those workloads would still be
better off with a CONFIG_VMSPLIT_2G_OPT (1.75 GB user, 2GB
linear map). That config unfortunately has a few problems, too:
- nobody has implemented it
- it won't work with LPAE and therefore cannot support hardware
  that relies on high physical addresses for RAM or MMIO
  (those could run CONFIG_VMSPLIT_2G at the cost of wasting
  12.5% of RAM).
- any workload that requires the full 3GB of virtual address space won't
  work at all. This might be e.g. MAP_FIXED users, or build servers
  linking large binaries.
It will take a while to find out what kinds of workloads suffer the most
from a different vmsplit and what can be done to address that, but we
could start by changing the kernel defconfig and distro builds to see
who complains ;-)

I think 32-bit ARM machines with 3GB or more are getting very rare,
but some still exist:
- The Armada XP development board had a DIMM slot that could take
  large memory (possibly up to 8GB with LPAE). This never shipped as
  a commercial product, but distro build servers sometimes still run on
  this, or on the old Calxeda or Keystone server systems.
- a few early i.MX6 boards  (e.g. HummingBoard) came had 4GB of
  RAM, though none of these seem to be available any more.
- High-end phones from 2013/2014 had 3GB LPDDR3 before getting
  obsoleted by 64-bit phones. Presumably none of these ever ran
  Linux-4.x or newer.
- My main laptop is a RK3288 based Chromebook with 4GB that just
  got updated to linux-4.19 by Google. Official updates apparently
  stop this summer, but it could easily run Debian later on.
- Some people run 32-bit kernels on a 64-bit Raspberry Pi 4 or on
  arm64 KVM with lots of RAM. These should probably all
  migrate to 64-bit kernels with compat user space anyway.
In theory these could also run on a VMSPLIT_4G_4G-like setup,
but I don't think anyone wants to go there. Deprecating highmem
definitely impacts any such users significantly, though staying on
an LTS kernel may be an option if there are only few of them.

           Arnd
