Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E3C15BC0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 10:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgBMJuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 04:50:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42629 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbgBMJuq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:50:46 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j2B8i-00040c-JK; Thu, 13 Feb 2020 10:50:32 +0100
Message-ID: <38b3a9d683932ebe9fdb4c8f5100a408b7a9a425.camel@pengutronix.de>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 13 Feb 2020 10:50:29 +0100
In-Reply-To: <20200212085004.GL25745@shell.armlinux.org.uk>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
         <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
         <20200211193101.GA178975@cmpxchg.org>
         <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
         <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
         <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
         <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
         <20200212085004.GL25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 2020-02-12 at 08:50 +0000, Russell King - ARM Linux admin wrote:
> On Tue, Feb 11, 2020 at 05:03:02PM -0800, Linus Torvalds wrote:
> > On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
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
> > 
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

I know of quite a few embedded ARMv7 systems that will need to be
supported for at least 10 years from now, with RAM sizes between 1GB
and even the full 4GB (well 3.75GB due to MMIO needing some address
space). Deprecating highmem would severely cripple our ability to
support those platforms with new kernels.

Regards,
Lucas

