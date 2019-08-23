Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE59A60B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 05:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391517AbfHWDZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 23:25:02 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:58696 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732546AbfHWDZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 23:25:01 -0400
Received: from dread.disaster.area (pa49-181-142-13.pa.nsw.optusnet.com.au [49.181.142.13])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5B63B43D0B5;
        Fri, 23 Aug 2019 13:24:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i10Az-0008A6-UL; Fri, 23 Aug 2019 13:23:45 +1000
Date:   Fri, 23 Aug 2019 13:23:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190823032345.GG1119@dread.disaster.area>
References: <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=pdRIKMFd4+xhzJrg6WzXNA==:117 a=pdRIKMFd4+xhzJrg6WzXNA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=rm80kFlqY6Er904cOY0A:9 a=56S7X8Id4VG2n9yJ:21
        a=ImN9Ga2Z1gCvYqWp:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 01:44:21PM -0700, Ira Weiny wrote:
> On Wed, Aug 21, 2019 at 04:48:10PM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:
> > 
> > > > Oh, I didn't think we were talking about that. Hanging the close of
> > > > the datafile fd contingent on some other FD's closure is a recipe for
> > > > deadlock..
> > > 
> > > The discussion between Jan and Dave was concerning what happens when a user
> > > calls
> > > 
> > > fd = open()
> > > fnctl(...getlease...)
> > > addr = mmap(fd...)
> > > ib_reg_mr() <pin>
> > > munmap(addr...)
> > > close(fd)
> > 
> > I don't see how blocking close(fd) could work.
> 
> Well Dave was saying this _could_ work. FWIW I'm not 100% sure it will but I
> can't prove it won't..

Right, I proposed it as a possible way of making sure application
developers don't do this. It _could_ be made to work (e.g. recording
longterm page pins on the vma->file), but this is tangential to 
the discussion of requiring active references to all resources
covered by the layout lease.

I think allowing applications to behave like the above is simply
poor system level design, regardless of the interaction with
filesystems and layout leases.

> Maybe we are all just touching a different part of this
> elephant[1] but the above scenario or one without munmap is very reasonably
> something a user would do.  So we can either allow the close to complete (my
> current patches) or try to make it block like Dave is suggesting.
> 
> I don't disagree with Dave with the semantics being nice and clean for the
> filesystem.

I'm not trying to make it "nice and clean for the filesystem".

The problem is not just RDMA/DAX - anything that is directly
accessing the block device under the filesystem has the same set of
issues. That is, the filesystem controls the life cycle of the
blocks in the block device, so direct access to the blocks by any
means needs to be co-ordinated with the filesystem. Pinning direct
access to a file via page pins attached to a hardware context that
the filesystem knows nothing about is not an access model that the
filesystems can support.

IOWs, anyone looking at this problem just from the RDMA POV of page
pins is not seeing all the other direct storage access mechainsms
that we need to support in the filesystems. RDMA on DAX is just one
of them.  pNFS is another. Remote acces via NVMeOF is another. XDP
-> DAX (direct file data placement from the network hardware) is
another. There are /lots/ of different direct storage access
mechanisms that filesystems need to support and we sure as hell do
not want to have to support special case semantics for every single
one of them.

Hence if we don't start with a sane model for arbitrating direct
access to the storage at the filesystem level we'll never get this
stuff to work reliably, let alone work together coherently.  An
application that wants a direct data path to storage should have a
single API that enables then to safely access the storage,
regardless of how they are accessing the storage.

From that perspective, what we are talking about here with RDMA
doing "mmap, page pin, unmap, close" and "pass page pins via
SCM_RIGHTS" are fundamentally unworkable from the filesystem
perspective. They are use-after-free situations from the filesystem
perspective - they do not hold direct references to anything in the
filesystem, and so the filesytem is completely unaware of them.

The filesystem needs to be aware of /all users/ of it's resources if
it's going to manage them sanely.  It needs to be able to corectly
coordinate modifications to ownership of the underlying storage with
all the users directly accessing that physical storage regardless of
the mechanism being used to access the storage.  IOWs, access
control must be independent of the mechanism used to gain access to
the storage hardware.

That's what file layout leases are defining - the filesystem support
model for allowing direct storage access from userspace. It's not
defining "RDMA/FSDAX" access rules, it's defining a generic direct
access model. And one of the rules in this model is "if you don't
have an active reference to the file layout, you are not allowed to
directly access the layout.".

Anything else is unsupportable from the filesystem perspective -
designing an access mechanism that allows userspace to retain access
indefinitely by relying on hidden details of kernel subsystem
implementations is a terrible architecture.  Not only does it bleed
kernel implementation into the API and the behavioural model, it
means we can't ever change that internal kernel behaviour because
userspace may be dependent on it. I shouldn't be having to point out
how bad this is from a system design perspective.

That's where the "nice and clean" semantics come from - starting
from "what can we actually support?", "what exactly do all the
different direct access mechanisms actually require?", "does it work
for future technologies not yet on our radar?" and working from
there.  So I'm not just looking at what we are doing right now, I'm
looking at 15 years down the track when we still have to support
layout leases and we've got hardware we haven't dreamed of yet.  If
the model is clean, simple, robust, implementation independent and
has well defined semantics, then it should stand the test of time.
i.e. the "nice and clean" semantics have nothign to do with the
filesystem per se, but everything to do with ensuring the mechanism
is generic and workable for direct storage access for a long time
into the future.

We can't force people to use layout leases - at all, let alone
correctly - but if you want filesystems and enterprise distros to
support direct access to filesystem controlled storage, then direct
access applications need to follow a sane set of rules that are
supportable at the filesystem level.

> But the fact that RDMA, and potentially others, can "pass the
> pins" to other processes is something I spent a lot of time trying to work out.

There's nothing in file layout lease architecture that says you
can't "pass the pins" to another process.  All the file layout lease
requirements say is that if you are going to pass a resource for
which the layout lease guarantees access for to another process,
then the destination process already have a valid, active layout
lease that covers the range of the pins being passed to it via the
RDMA handle.

i.e. as the pins pass from one process to another, they pass from
the protection of the lease process A holds to the protection that
the lease process B holds. This can probably even be done by
duplicating the lease fd and passing it by SCM_RIGHTS first.....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
