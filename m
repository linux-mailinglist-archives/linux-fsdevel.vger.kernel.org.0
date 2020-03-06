Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6722517C720
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFUgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:36:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55320 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFUgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:36:43 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 026Ka7Hn058030;
        Fri, 6 Mar 2020 14:36:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583526967;
        bh=o+1IFuyLDbDuWvnpCYuEdjJOg2H1UP3RcQMpweJwXak=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=W5k9WQHTbZ4awgznu9fP3n7r7zBIdjOE7FgvfEItxvGcIKh0frlrkunDbSWDnI+wF
         ws5Tgl2NF3ayEajTnad/ne/VyFCnkGxeFeKeyFg8Rhafjdpd8eZdfpWHDiSVZ2HYW7
         jenkN3URxcXpuRKwoHl58TCd/bqipDN9f2rqqJKs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 026Ka6St006522
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Mar 2020 14:36:06 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Mar
 2020 14:36:06 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Mar 2020 14:36:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 026Ka6Ys032053;
        Fri, 6 Mar 2020 14:36:06 -0600
Date:   Fri, 6 Mar 2020 14:34:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <santosh.shilimkar@oracle.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200306203439.peytghdqragjfhdx@kahuna>
References: <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk>
 <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
> +Nishant, Tero
> 
> On 2/26/20 1:01 PM, Arnd Bergmann wrote:
> > On Wed, Feb 26, 2020 at 7:04 PM <santosh.shilimkar@oracle.com> wrote:
> > > 
> > > On 2/13/20 8:52 AM, Arnd Bergmann wrote:
> > > > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > 
> > > The Keystone generations of SOCs have been used in different areas and
> > > they will be used for long unless says otherwise.
> > > 
> > > Apart from just split of lowmem and highmem, one of the peculiar thing
> > > with Keystome family of SOCs is the DDR is addressable from two
> > > addressing ranges. The lowmem address range is actually non-cached
> > > range and the higher range is the cacheable.
> > 
> > I'm aware of Keystone's special physical memory layout, but for the
> > discussion here, this is actually irrelevant for the discussion about
> > highmem here, which is only about the way we map all or part of the
> > available physical memory into the 4GB of virtual address space.
> > 
> > The far more important question is how much memory any users
> > (in particular the subset that are going to update their kernels
> > several years from now) actually have installed. Keystone-II is
> > one of the rare 32-bit chips with fairly wide memory interfaces,
> > having two 72-bit (with ECC) channels rather than the usual one
> >   or two channels of 32-bit DDR3. This means a relatively cheap
> > 4GB configuration using eight 256Mx16 chips is possible, or
> > even a 8GB using sixteen or eighteen 512Mx8.
> > 
> > Do you have an estimate on how common these 4GB and 8GB
> > configurations are in practice outside of the TI evaluation
> > board?
> > 
> From my TI memories, many K2 customers were going to install
> more than 2G memory. Don't remember 8G, but 4G was the dominant
> one afair. Will let Nishant/Tero elaborate latest on this.
> 

Thanks for the headsup, it took a little to dig up the current
situation:

~few 1000s still relevant spread between 4G and 8G (confirmed that both
are present, relevant and in use).

I wish we could sunset, but unfortunately, I am told(and agree)
that we should'nt just leave products (and these are long term
products stuck in critical parts in our world) hanging in the air, and
migrations to newer kernel do still take place periodically (the best
I can talk in public forum at least).

-- 
Regards,
Nishanth Menon
