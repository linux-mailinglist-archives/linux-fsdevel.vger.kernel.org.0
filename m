Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA312410219
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbhIRAIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 20:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245639AbhIRAIX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:08:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E659A60F46;
        Sat, 18 Sep 2021 00:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631923621;
        bh=OUe3nAMlae74ZYW8tC5vlGgEhMH49GBMLtVi93PoftA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rb/Z/jJ81LgwmE7jE22mZGV56FF5RpfASb347mf9+Z+ey2uWzm42oW/vhbsD7KFpC
         aSsBDd45QEPrzLhvwwvm+q0OL7+q9ilpgOY1LcBJTXhdYhhNJKZrZNpCQlAF+cMIHa
         7u0XT8UZ/FrMjwnXhbxFy0C65haYNdzu/0GhGRDGHvmYCbOZKetVrKsLsrtVwf9Jy3
         aahqYmg4X3hT958JdzhpRVL+SLQsMJ7SKDQc7my+34HoP+hfvzMlZHicHi3AWlIa7W
         UzDWjMmkUdMOqcCu4v+BUV3w6PbM2STVmyuxZ8Z6RLQ1OdBbmPJBuCSAVh+piE7LFR
         +e5bOV9B7f++A==
Date:   Fri, 17 Sep 2021 17:07:00 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/3] dax: clear poison on the fly along pwrite
Message-ID: <20210918000700.GA10182@magnolia>
References: <20210914233132.3680546-1-jane.chu@oracle.com>
 <CAPcyv4h3KpOKgy_Cwi5fNBZmR=n1hB33mVzA3fqOY7c3G+GrMA@mail.gmail.com>
 <516ecedc-38b9-1ae3-a784-289a30e5f6df@oracle.com>
 <20210915161510.GA34830@magnolia>
 <CAPcyv4jaCiSXU61gsQTaoN_cdDTDMvFSfMYfBz2yLKx11fdwOQ@mail.gmail.com>
 <YULuMO86NrQAPcpf@infradead.org>
 <CAPcyv4g_qPBER2W+OhCf29kw-+tjs++TsTiRGWgX3trv11+28A@mail.gmail.com>
 <YUSPzVG0ulHdLWn7@infradead.org>
 <20210917152744.GA10250@magnolia>
 <CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iAr_Vwwgqw+4wz0RQUXhUUJGGz7_T+p+W6tC4T+k+zNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:21:25PM -0700, Dan Williams wrote:
> On Fri, Sep 17, 2021 at 8:27 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Fri, Sep 17, 2021 at 01:53:33PM +0100, Christoph Hellwig wrote:
> > > On Thu, Sep 16, 2021 at 11:40:28AM -0700, Dan Williams wrote:
> > > > > That was my gut feeling.  If everyone feels 100% comfortable with
> > > > > zeroingas the mechanism to clear poisoning I'll cave in.  The most
> > > > > important bit is that we do that through a dedicated DAX path instead
> > > > > of abusing the block layer even more.
> > > >
> > > > ...or just rename dax_zero_page_range() to dax_reset_page_range()?
> > > > Where reset == "zero + clear-poison"?
> > >
> > > I'd say that naming is more confusing than overloading zero.
> >
> > How about dax_zeroinit_range() ?
> 
> Works for me.
> 
> >
> > To go with its fallocate flag (yeah I've been too busy sorting out -rc1
> > regressions to repost this) FALLOC_FL_ZEROINIT_RANGE that will reset the
> > hardware (whatever that means) and set the contents to the known value
> > zero.
> >
> > Userspace usage model:
> >
> > void handle_media_error(int fd, loff_t pos, size_t len)
> > {
> >         /* yell about this for posterior's sake */
> >
> >         ret = fallocate(fd, FALLOC_FL_ZEROINIT_RANGE, pos, len);
> >
> >         /* yay our disk drive / pmem / stone table engraver is online */
> 
> The fallocate mode can still be error-aware though, right? When the FS
> has knowledge of the error locations the fallocate mode could be
> fallocate(fd, FALLOC_FL_OVERWRITE_ERRORS, pos, len) with the semantics
> of attempting to zero out any known poison extents in the given file
> range? At the risk of going overboard on new fallocate modes there
> could also (or instead of) be FALLOC_FL_PUNCH_ERRORS to skip trying to
> clear them and just ask the FS to throw error extents away.

It /could/ be, but for now I've stuck to what you see is what you get --
if you tell it to 'zero initialize' 1MB of pmem, it'll write zeroes and
clear the poison on all 1MB, regardless of the old contents.

IOWs, you can use it from a poison handler on just the range that it
told you about, or you could use it to bulk-clear a lot of space all at
once.

A dorky thing here is that the dax_zero_page_range function returns EIO
if you tell it to do more than one page...


> 
> > }
> >
> > > > > I'm really worried about both patartitions on DAX and DM passing through
> > > > > DAX because they deeply bind DAX to the block layer, which is just a bad
> > > > > idea.  I think we also need to sort that whole story out before removing
> > > > > the EXPERIMENTAL tags.
> > > >
> > > > I do think it was a mistake to allow for DAX on partitions of a pmemX
> > > > block-device.
> > > >
> > > > DAX-reflink support may be the opportunity to start deprecating that
> > > > support. Only enable DAX-reflink for direct mounting on /dev/pmemX
> > > > without partitions (later add dax-device direct mounting),
> > >
> > > I think we need to fully or almost fully sort this out.
> > >
> > > Here is my bold suggestions:
> > >
> > >  1) drop no drop the EXPERMINTAL on the current block layer overload
> > >     at all
> >
> > I don't understand this.
> >
> > >  2) add direct mounting of the nvdimm namespaces ASAP.  Because all
> > >     the filesystem currently also need the /dev/pmem0 device add a way
> > >     to open the block device by the dax_device instead of our current
> > >     way of doing the reverse
> > >  3) deprecate DAX support through block layer mounts with a say 2 year
> > >     deprecation period
> > >  4) add DAX remapping devices as needed
> >
> > What devices are needed?  linear for lvm, and maybe error so we can
> > actually test all this stuff?
> 
> The proposal would be zero lvm support. The nvdimm namespace
> definition would need to grow support for concatenation + striping.

Ah, ok.

> Soft error injection could be achieved by writing to the badblocks
> interface.

<nod>

I'll send out an RFC of what I have currently.

--D
