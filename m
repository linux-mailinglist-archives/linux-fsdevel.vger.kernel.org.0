Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2344040D08F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 02:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhIPAHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 20:07:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232465AbhIPAHN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:07:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E545461164;
        Thu, 16 Sep 2021 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631750754;
        bh=Uy0zID/jX88WBrciDPIHMPruWk4OtOhmOwUWZHhLBfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XS0YoOnyKV12Gk3fKvZIRXhyI8o5iSx4vfwa1HgM1KZM0R4uz087LBBXeQo59K05g
         hZdTM60bDub/QL28D5SAEBknTgSamysES46mMx1CjAmW9xfWv9Xk+3ZewKtvWVYojo
         yV2Xj/74rK0rMHm4L2/Gq5k43PcQGAuLPQRAB+LXgf6zFmiC1srnA6VGuPALpk7a8D
         9eIC4S9hu96ErVbiNOlac4qy6MXqkhwNVpYNtydcym/TAvxaIM7eDTAVJxUnhLgBrK
         9u74hLT7wByTVEW3zTqvdwRR5oWWL5ACF5Chm71sFuAcMqhva0c+FI/hWoXiSa8MU/
         QAk1pXvuK/MVA==
Date:   Wed, 15 Sep 2021 17:05:53 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
Message-ID: <20210916000553.GB34899@magnolia>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 01:27:47PM -0700, Dan Williams wrote:
> On Wed, Sep 15, 2021 at 9:15 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Wed, Sep 15, 2021 at 12:22:05AM -0700, Jane Chu wrote:
> > > Hi, Dan,
> > >
> > > On 9/14/2021 9:44 PM, Dan Williams wrote:
> > > > On Tue, Sep 14, 2021 at 4:32 PM Jane Chu <jane.chu@oracle.com> wrote:
> > > > >
> > > > > If pwrite(2) encounters poison in a pmem range, it fails with EIO.
> > > > > This is unecessary if hardware is capable of clearing the poison.
> > > > >
> > > > > Though not all dax backend hardware has the capability of clearing
> > > > > poison on the fly, but dax backed by Intel DCPMEM has such capability,
> > > > > and it's desirable to, first, speed up repairing by means of it;
> > > > > second, maintain backend continuity instead of fragmenting it in
> > > > > search for clean blocks.
> > > > >
> > > > > Jane Chu (3):
> > > > >    dax: introduce dax_operation dax_clear_poison
> > > >
> > > > The problem with new dax operations is that they need to be plumbed
> > > > not only through fsdax and pmem, but also through device-mapper.
> > > >
> > > > In this case I think we're already covered by dax_zero_page_range().
> > > > That will ultimately trigger pmem_clear_poison() and it is routed
> > > > through device-mapper properly.
> > > >
> > > > Can you clarify why the existing dax_zero_page_range() is not sufficient?
> > >
> > > fallocate ZERO_RANGE is in itself a functionality that applied to dax
> > > should lead to zero out the media range.  So one may argue it is part
> > > of a block operations, and not something explicitly aimed at clearing
> > > poison.
> >
> > Yeah, Christoph suggested that we make the clearing operation explicit
> > in a related thread a few weeks ago:
> > https://lore.kernel.org/linux-fsdevel/YRtnlPERHfMZ23Tr@infradead.org/
> 
> That seemed to be tied to a proposal to plumb it all the way out to an
> explicit fallocate() mode, not make it a silent side effect of
> pwrite(). That said pwrite() does clear errors in hard drives in
> not-DAX mode, but I like the change in direction to make it explicit
> going forward.
> 
> > I like Jane's patchset far better than the one that I sent, because it
> > doesn't require a block device wrapper for the pmem, and it enables us
> > to tell application writers that they can handle media errors by
> > pwrite()ing the bad region, just like they do for nvme and spinners.
> 
> pwrite(), hmm, so you're not onboard with the explicit clearing API
> proposal, or...?

I don't really care either way.  I was going to send a reworked version
of that earlier patchset which would add an explicit fallocate mode and
make it work on regular block storage too, but then Jane sent this. :)

Hmm, maybe I should rework my patchset to call dax_zero_page_range
directly...?

> > > I'm also thinking about the MOVEDIR64B instruction and how it
> > > might be used to clear poison on the fly with a single 'store'.
> > > Of course, that means we need to figure out how to narrow down the
> > > error blast radius first.
> 
> It turns out the MOVDIR64B error clearing idea runs into problem with
> the device poison tracking. Without the explicit notification that
> software wanted the error cleared the device may ghost report errors
> that are not there anymore. I think we should continue explicit error
> clearing and notification of the device that the error has been
> cleared (by asking the device to clear it).

If the poison clearing is entirely OOB (i.e. you have to call ACPI
methods) and can't be made part of the memory controller, then I guess
you can't use movdir64b at all, right?

> > That was one of the advantages of Shiyang Ruan's NAKed patchset to
> > enable byte-granularity media errors
> 
> ...the method of triggering reverse mapping had review feedback, I
> apologize if that came across of a NAK of the whole proposal. As I
> clarified to Eric this morning, I think the solution is iterating
> towards upstream inclusion.
> 
> > to pass upwards through the stack
> > back to the filesystem, which could then tell applications exactly what
> > they lost.
> >
> > I want to get back to that, though if Dan won't withdraw the NAK then I
> > don't know how to move forward...
> 
> No NAK in place. Let's go!

Ok, thanks.  I'll start looking through Shiyang's patches tomorrow.

> 
> >
> > > With respect to plumbing through device-mapper, I thought about that,
> > > and wasn't sure. I mean the clear-poison work will eventually fall on
> > > the pmem driver, and thru the DM layers, how does that play out thru
> > > DM?
> >
> > Each of the dm drivers has to add their own ->clear_poison operation
> > that remaps the incoming (sector, len) parameters as appropriate for
> > that device and then calls the lower device's ->clear_poison with the
> > translated parameters.
> >
> > This (AFAICT) has already been done for dax_zero_page_range, so I sense
> > that Dan is trying to save you a bunch of code plumbing work by nudging
> > you towards doing s/dax_clear_poison/dax_zero_page_range/ to this series
> > and then you only need patches 2-3.
> 
> Yes, but it sounds like Christoph was saying don't overload
> dax_zero_page_range(). I'd be ok splitting the difference and having a
> new fallocate clear poison mode map to dax_zero_page_range()
> internally.

Ok.

--D

> >
> > > BTW, our customer doesn't care about creating dax volume thru DM, so.
> >
> > They might not care, but anything going upstream should work in the
> > general case.
> 
> Agree.
