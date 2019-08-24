Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B26CC9BBD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 06:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfHXEtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 00:49:14 -0400
Received: from mga18.intel.com ([134.134.136.126]:53747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfHXEtO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 00:49:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 21:49:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,423,1559545200"; 
   d="scan'208";a="354867531"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2019 21:49:12 -0700
Date:   Fri, 23 Aug 2019 21:49:12 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20190824044911.GB1092@iweiny-DESK2.sc.intel.com>
References: <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823032345.GG1119@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 23, 2019 at 01:23:45PM +1000, Dave Chinner wrote:
> On Wed, Aug 21, 2019 at 01:44:21PM -0700, Ira Weiny wrote:
> > On Wed, Aug 21, 2019 at 04:48:10PM -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:
> > > 
> > > > > Oh, I didn't think we were talking about that. Hanging the close of
> > > > > the datafile fd contingent on some other FD's closure is a recipe for
> > > > > deadlock..
> > > > 
> > > > The discussion between Jan and Dave was concerning what happens when a user
> > > > calls
> > > > 
> > > > fd = open()
> > > > fnctl(...getlease...)
> > > > addr = mmap(fd...)
> > > > ib_reg_mr() <pin>
> > > > munmap(addr...)
> > > > close(fd)
> > > 
> > > I don't see how blocking close(fd) could work.
> > 
> > Well Dave was saying this _could_ work. FWIW I'm not 100% sure it will but I
> > can't prove it won't..
> 
> Right, I proposed it as a possible way of making sure application
> developers don't do this. It _could_ be made to work (e.g. recording
> longterm page pins on the vma->file), but this is tangential to 
> the discussion of requiring active references to all resources
> covered by the layout lease.
> 
> I think allowing applications to behave like the above is simply
> poor system level design, regardless of the interaction with
> filesystems and layout leases.
> 
> > Maybe we are all just touching a different part of this
> > elephant[1] but the above scenario or one without munmap is very reasonably
> > something a user would do.  So we can either allow the close to complete (my
> > current patches) or try to make it block like Dave is suggesting.

My belief when writing the current series was that hanging the close would
cause deadlock.  But it seems I was wrong because of the delayed __fput().

So far, I have not been able to get RDMA to have an issue like Jason suggested
would happen (or used to happen).  So from that perspective it may be ok to
hang the close.

> > 
> > I don't disagree with Dave with the semantics being nice and clean for the
> > filesystem.
> 
> I'm not trying to make it "nice and clean for the filesystem".
> 
> The problem is not just RDMA/DAX - anything that is directly
> accessing the block device under the filesystem has the same set of
> issues. That is, the filesystem controls the life cycle of the
> blocks in the block device, so direct access to the blocks by any
> means needs to be co-ordinated with the filesystem. Pinning direct
> access to a file via page pins attached to a hardware context that
> the filesystem knows nothing about is not an access model that the
> filesystems can support.
> 
> IOWs, anyone looking at this problem just from the RDMA POV of page
> pins is not seeing all the other direct storage access mechainsms
> that we need to support in the filesystems. RDMA on DAX is just one
> of them.  pNFS is another. Remote acces via NVMeOF is another. XDP
> -> DAX (direct file data placement from the network hardware) is
> another. There are /lots/ of different direct storage access
> mechanisms that filesystems need to support and we sure as hell do
> not want to have to support special case semantics for every single
> one of them.

My use of struct file was based on the fact that FDs are a primary interface
for linux and my thought was that they would be more universal than having file
pin information stored in an RDMA specific structure.

XDP is not as direct; it uses sockets.  But sockets also have a struct file
which I believe could be used in a similar manner.  I'm not 100% sure of the
xdp_umem lifetime yet but it seems that my choice of using struct file was a
good one in this respect.

> 
> Hence if we don't start with a sane model for arbitrating direct
> access to the storage at the filesystem level we'll never get this
> stuff to work reliably, let alone work together coherently.  An
> application that wants a direct data path to storage should have a
> single API that enables then to safely access the storage,
> regardless of how they are accessing the storage.
> 
> From that perspective, what we are talking about here with RDMA
> doing "mmap, page pin, unmap, close" and "pass page pins via
> SCM_RIGHTS" are fundamentally unworkable from the filesystem
> perspective. They are use-after-free situations from the filesystem
> perspective - they do not hold direct references to anything in the
> filesystem, and so the filesytem is completely unaware of them.

I see your point of view but looking at it from a different point of view I
don't see this as a "use after free".

The user has explicitly registered this memory (and layout) with another direct
access subsystem (RDMA for example) so why do they need to keep the FD around?

> 
> The filesystem needs to be aware of /all users/ of it's resources if
> it's going to manage them sanely.

From the way I look at it the underlying filesystem _is_ aware of the leases
with my patch set.  And so to is the user.  It is just not through the original
"data file fd".

And the owner of the lease becomes the subsystem object ("RDMA FD" in this
case) which is holding the pins.  Furthermore, the lease is maintained and
transferred automatically through the normal FD processing.

(Furthermore, tracking of these pins is available for whatever subsystem by
tracking them with struct file; _not_ just RDMA).  When those subsystem objects
are released the "data file lease" will be released as well.  That was the
design.

> 
> > But the fact that RDMA, and potentially others, can "pass the
> > pins" to other processes is something I spent a lot of time trying to work out.
> 
> There's nothing in file layout lease architecture that says you
> can't "pass the pins" to another process.  All the file layout lease
> requirements say is that if you are going to pass a resource for
> which the layout lease guarantees access for to another process,
> then the destination process already have a valid, active layout
> lease that covers the range of the pins being passed to it via the
> RDMA handle.
> 
> i.e. as the pins pass from one process to another, they pass from
> the protection of the lease process A holds to the protection that
> the lease process B holds. This can probably even be done by
> duplicating the lease fd and passing it by SCM_RIGHTS first.....

My worry with this is how to enforce it.  As I said in the other thread I think
we could potentially block SCM_RIGHTS use in the short term.  But I'm not sure
about blocking every call which may "dup()" an FD to random processes.

Ira

