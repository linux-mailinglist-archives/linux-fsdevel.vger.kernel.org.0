Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39BB3B0FD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 00:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhFVWJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 18:09:01 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:50582 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229612AbhFVWJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:09:01 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 3F98D7126;
        Wed, 23 Jun 2021 08:06:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lvoXX-00Fr2Q-Fn; Wed, 23 Jun 2021 08:06:39 +1000
Date:   Wed, 23 Jun 2021 08:06:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <20210622220639.GH2419729@dread.disaster.area>
References: <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
 <YM0Q5/unrL6MFNCb@zeniv-ca.linux.org.uk>
 <CAHk-=wjDhxnRaO8FU-fOEAF6WeTUsvaoz0+fr1tnJvRCfAaSCQ@mail.gmail.com>
 <YM0Zu3XopJTGMIO5@relinquished.localdomain>
 <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YND8p7ioQRfoWTOU@relinquished.localdomain>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=-uoBkjAQAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=SiS6zSyo1DA6T2jvNdwA:9 a=CjuIK1q_8ugA:10
        a=y0wLjPFBLyexm0soFTcm:22 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 21, 2021 at 01:55:03PM -0700, Omar Sandoval wrote:
> On Mon, Jun 21, 2021 at 01:46:04PM -0700, Omar Sandoval wrote:
> > On Mon, Jun 21, 2021 at 12:33:17PM -0700, Linus Torvalds wrote:
> > > On Mon, Jun 21, 2021 at 11:46 AM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > How do we get the userspace size with the encoded_iov.size approach?
> > > > We'd have to read the size from the iov_iter before writing to the rest
> > > > of the iov_iter. Is it okay to mix the iov_iter as a source and
> > > > destination like this? From what I can tell, it's not intended to be
> > > > used like this.
> > > 
> > > I guess it could work that way, but yes, it's ugly as hell. And I
> > > really don't want a readv() system call - that should write to the
> > > result buffer - to first have to read from it.
> > > 
> > > So I think the original "just make it be the first iov entry" is the
> > > better approach, even if Al hates it.
> > > 
> > > Although I still get the feeling that using an ioctl is the *really*
> > > correct way to go. That was my first reaction to the series
> > > originally, and I still don't see why we'd have encoded data in a
> > > regular read/write path.
> > > 
> > > What was the argument against ioctl's, again?
> > 
> > The suggestion came from Dave Chinner here:
> > https://lore.kernel.org/linux-fsdevel/20190905021012.GL7777@dread.disaster.area/
> > 
> > His objection to an ioctl was two-fold:
> > 
> > 1. This interfaces looks really similar to normal read/write, so we
> >    should try to use the normal read/write interface for it. Perhaps
> >    this trouble with iov_iter has refuted that.
> > 2. The last time we had Btrfs-specific ioctls that eventually became
> >    generic (FIDEDUPERANGE and FICLONE{,RANGE}), the generalization was
> >    painful. Part of the problem with clone/dedupe was that the Btrfs
> >    ioctls were underspecified. I think I've done a better job of
> >    documenting all of the semantics and corner cases for the encoded I/O
> >    interface (and if not, I can address this). The other part of the
> >    problem is that there were various sanity checks in the normal
> >    read/write paths that were missed or drifted out of sync in the
> >    ioctls. That requires some vigilance going forward. Maybe starting
> >    this off as a generic (not Btrfs-specific) ioctl right off the bat
> >    will help.
> > 
> > If we do go the ioctl route, then we also have to decide how much of
> > preadv2/pwritev2 it should emulate. Should it use the fd offset, or
> > should that be an ioctl argument? Some of the RWF_ flags would be useful
> > for encoded I/O, too (RWF_DSYNC, RWF_SYNC, RWF_APPEND), should it
> > support those? These bring us back to Dave's first point.
> 
> Oops, I dropped Dave from the Cc list at some point. Adding him back
> now.

Fair summary. The only other thing that I'd add is this is an IO
interface that requires issuing physical IO. So if someone wants
high throughput for encoded IO, we really need AIO and/or io_uring
support, and we get that for free if we use readv2/writev2
interfaces.

Yes, it could be an ioctl() interface, but I think that this sort of
functionality is exactly what extensible syscalls like
preadv2/pwritev2 should be used for. It's a slight variant on normal
IO, and that's exactly what the RWF_* flags are intended to be used
for - allowing interesting per-IO variant behaviour without having
to completely re-implemnt the IO path via custom ioctls every time
we want slightly different functionality...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
