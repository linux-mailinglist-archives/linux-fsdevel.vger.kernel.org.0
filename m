Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C745440584
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Oct 2021 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhJ2WfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 18:35:07 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:57548 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhJ2WfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 18:35:06 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id C472FFCC60F;
        Sat, 30 Oct 2021 09:32:34 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mgaQL-002a5C-Gj; Sat, 30 Oct 2021 09:32:33 +1100
Date:   Sat, 30 Oct 2021 09:32:33 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211029223233.GB449541@dread.disaster.area>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
 <20211028225955.GA449541@dread.disaster.area>
 <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22255117-52de-4b2d-822e-b4bc50bbc52b@gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=617c7683
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=7-415B0cAAAA:8
        a=dKw9hyCRfQi49U3FdP0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 12:46:14PM +0100, Pavel Begunkov wrote:
> On 10/28/21 23:59, Dave Chinner wrote:
> [...]
> > > > Well, my point is doing recovery from bit errors is by definition not
> > > > the fast path.  Which is why I'd rather keep it away from the pmem
> > > > read/write fast path, which also happens to be the (much more important)
> > > > non-pmem read/write path.
> > > 
> > > The trouble is, we really /do/ want to be able to (re)write the failed
> > > area, and we probably want to try to read whatever we can.  Those are
> > > reads and writes, not {pre,f}allocation activities.  This is where Dave
> > > and I arrived at a month ago.
> > > 
> > > Unless you'd be ok with a second IO path for recovery where we're
> > > allowed to be slow?  That would probably have the same user interface
> > > flag, just a different path into the pmem driver.
> > 
> > I just don't see how 4 single line branches to propage RWF_RECOVERY
> > down to the hardware is in any way an imposition on the fast path.
> > It's no different for passing RWF_HIPRI down to the hardware *in the
> > fast path* so that the IO runs the hardware in polling mode because
> > it's faster for some hardware.
> 
> Not particularly about this flag, but it is expensive. Surely looks
> cheap when it's just one feature, but there are dozens of them with
> limited applicability, default config kernels are already sluggish
> when it comes to really fast devices and it's not getting better.
> Also, pretty often every of them will add a bunch of extra checks
> to fix something of whatever it would be.
> 
> So let's add a bit of pragmatism to the picture, if there is just one
> user of a feature but it adds overhead for millions of machines that
> won't ever use it, it's expensive.

Yup, you just described RWF_HIPRI! Seriously, Pavel, did you read
past this?  I'll quote what I said again, because I've already
addressed this argument to point out how silly it is:

> > IOWs, saying that we shouldn't implement RWF_RECOVERY because it
> > adds a handful of branches to the fast path is like saying that we
> > shouldn't implement RWF_HIPRI because it slows down the fast path
> > for non-polled IO....

 RWF_HIPRI functionality represents a *tiny* niche in the wider
Linux ecosystem, so by your reasoning it is too expensive to
implement because millions (billions!) of machines don't need or use
it. Do you now see how silly your argument is?

Seriously, this "optimise the IO fast path at the cost of everything
else" craziness has gotten out of hand. Nobody in the filesystem or
application world cares if you can do 10M IOPS per core when all the
CPU is doing is sitting in a tight loop inside the kernel repeatedly
overwriting data in the same memory buffers, essentially tossing the
old away the data without ever accessing it or doing anything with
it.  Such speed racer games are *completely meaningless* as an
optimisation goal - it's what we've called "benchmarketing" for a
couple of decades now.

If all we focus on is bragging rights because "bigger number is
always better", then we'll end up with iand IO path that looks like
the awful mess that the fs/direct-io.c turned into. That ended up
being hyper-optimised for CPU performance right down to single
instructions and cacheline load orders that the code became
extremely fragile and completely unmaintainable.

We ended up *reimplementing the direct IO code from scratch* so that
XFS could build and submit direct IO smarter and faster because it
simply couldn't be done to the old code.  That's how iomap came
about, and without *any optimisation at all* iomap was 20-30% faster
than the old, hyper-optimised fs/direct-io.c code.  IOWs, we always
knew we could do direct IO faster than fs/direct-io.c, but we
couldn't make the fs/direct-io.c faster because of the
hyper-optimisation of the code paths made it impossible to modify
and maintain.

The current approach of hyper-optimising the IO path for maximum
per-core IOPS at the expensive of everything else has been proven in
the past to be exactly the wrong approach to be taking for IO path
development. Yes, we need to be concerned about performance and work
to improve it, but we should not be doing that at the cost of
everything else that the IO stack needs to be able to do.

Fundamentally, optimisation is something we do *after* we provide
the functionality that is required; using "fast path optimisation"
as a blunt force implement to prevent new features from being
implemented is just ...  obnoxious.

> This one doesn't spill yet into paths I care about, but in general
> it'd be great if we start thinking more about such stuff instead of
> throwing yet another if into the path, e.g. by shifting the overhead
> from linear to a constant for cases that don't use it, for instance
> with callbacks or bit masks.

This is orthogonal to providing data recovery functionality.
If the claims that flag propagation is too expensive are true, then
fixing this problem this will also improve RWF_HIPRI performance
regardless of whether RWF_DATA_RECOVERY exists or not...

IOWs, *if* there is a fast path performance degradation as a result
of flag propagation, then *go measure it* and show us how much
impact it has on _real world applications_.  *Show us the numbers*
and document how much each additional flag propagation actually
costs so we can talk about whether it is acceptible, mitigation
strategies and/or alternative implementations.  Flag propagation
overhead is just not a valid reason for preventing us adding new
flags to the IO path. Fix the flag propagation overhead if it's a
problem for you, don't use it as an excuse for preventing people
from adding new functionality that uses flag propagation...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
