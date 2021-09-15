Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCF340C9DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhIOQQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 12:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhIOQQa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:16:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E69EC60FED;
        Wed, 15 Sep 2021 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631722511;
        bh=OR95WQryOxqyDGGQxatbwcebZkxzHzVsgPwQh9NaKDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PwstDstV7bOHvJAm+r4Q8mBJvEfj9RsXWQ8A+/5muktg/NdHD8csLidgBn+j9LTKl
         q2VQ7Wr7Nsf02xocvqEEk+U0UblMVI3V0/J49bcpS2Agwo0UcaRFUGoT3iSf9HXnJI
         Fygf5xc61Baf9FKAZ5yrVBJ1lxG4M7SyoU6quZDsN7CCv+8/75Slmq624AkSRnU/4T
         ahY8/jpClUqF0IcL8MvDRYbxsX/JsYM2MsQ4asAwoR2Z9xfoRu5/kFdOOOfxeLLhdO
         bBIRDiYjg6xoUx4Yv1n3Ucg0ZAZLq5dzF5b61VnNaCUdtNQmQ1u/WyC2iOIYWuQttb
         2lHRL35vjK7KQ==
Date:   Wed, 15 Sep 2021 09:15:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
Message-ID: <20210915161510.GA34830@magnolia>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 12:22:05AM -0700, Jane Chu wrote:
> Hi, Dan,
> 
> On 9/14/2021 9:44 PM, Dan Williams wrote:
> > On Tue, Sep 14, 2021 at 4:32 PM Jane Chu <jane.chu@oracle.com> wrote:
> > > 
> > > If pwrite(2) encounters poison in a pmem range, it fails with EIO.
> > > This is unecessary if hardware is capable of clearing the poison.
> > > 
> > > Though not all dax backend hardware has the capability of clearing
> > > poison on the fly, but dax backed by Intel DCPMEM has such capability,
> > > and it's desirable to, first, speed up repairing by means of it;
> > > second, maintain backend continuity instead of fragmenting it in
> > > search for clean blocks.
> > > 
> > > Jane Chu (3):
> > >    dax: introduce dax_operation dax_clear_poison
> > 
> > The problem with new dax operations is that they need to be plumbed
> > not only through fsdax and pmem, but also through device-mapper.
> > 
> > In this case I think we're already covered by dax_zero_page_range().
> > That will ultimately trigger pmem_clear_poison() and it is routed
> > through device-mapper properly.
> > 
> > Can you clarify why the existing dax_zero_page_range() is not sufficient?
> 
> fallocate ZERO_RANGE is in itself a functionality that applied to dax
> should lead to zero out the media range.  So one may argue it is part
> of a block operations, and not something explicitly aimed at clearing
> poison.

Yeah, Christoph suggested that we make the clearing operation explicit
in a related thread a few weeks ago:
https://lore.kernel.org/linux-fsdevel/YRtnlPERHfMZ23Tr@infradead.org/

I like Jane's patchset far better than the one that I sent, because it
doesn't require a block device wrapper for the pmem, and it enables us
to tell application writers that they can handle media errors by
pwrite()ing the bad region, just like they do for nvme and spinners.

> I'm also thinking about the MOVEDIR64B instruction and how it
> might be used to clear poison on the fly with a single 'store'.
> Of course, that means we need to figure out how to narrow down the
> error blast radius first.

That was one of the advantages of Shiyang Ruan's NAKed patchset to
enable byte-granularity media errors to pass upwards through the stack
back to the filesystem, which could then tell applications exactly what
they lost.

I want to get back to that, though if Dan won't withdraw the NAK then I
don't know how to move forward...

> With respect to plumbing through device-mapper, I thought about that,
> and wasn't sure. I mean the clear-poison work will eventually fall on
> the pmem driver, and thru the DM layers, how does that play out thru
> DM?

Each of the dm drivers has to add their own ->clear_poison operation
that remaps the incoming (sector, len) parameters as appropriate for
that device and then calls the lower device's ->clear_poison with the
translated parameters.

This (AFAICT) has already been done for dax_zero_page_range, so I sense
that Dan is trying to save you a bunch of code plumbing work by nudging
you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
and then you only need patches 2-3.

> BTW, our customer doesn't care about creating dax volume thru DM, so.

They might not care, but anything going upstream should work in the
general case.

--D

> thanks!
> -jane
> 
> 
> > 
> > >    dax: introduce dax_clear_poison to dax pwrite operation
> > >    libnvdimm/pmem: Provide pmem_dax_clear_poison for dax operation
> > > 
> > >   drivers/dax/super.c   | 13 +++++++++++++
> > >   drivers/nvdimm/pmem.c | 17 +++++++++++++++++
> > >   fs/dax.c              |  9 +++++++++
> > >   include/linux/dax.h   |  6 ++++++
> > >   4 files changed, 45 insertions(+)
> > > 
> > > --
> > > 2.18.4
> > > 
