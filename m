Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015BF3429B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 02:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhCTBrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 21:47:11 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:57309 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229831AbhCTBqy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:46:54 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 11BD910665A;
        Sat, 20 Mar 2021 12:46:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lNQhU-004WUW-Aj; Sat, 20 Mar 2021 12:46:48 +1100
Date:   Sat, 20 Mar 2021 12:46:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, dax, pmem: Introduce dev_pagemap_failure()
Message-ID: <20210320014648.GD349301@dread.disaster.area>
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210318045745.GC349301@dread.disaster.area>
 <CAPcyv4iPE_MB08PFM-DZig8g35YH_VTKydeFyffN+QovfXx7HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iPE_MB08PFM-DZig8g35YH_VTKydeFyffN+QovfXx7HA@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_d
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=FIbilaf9nrSP0Ts9LYgA:9 a=I-lTFRH0pfkfxKSN:21 a=N81Os2z_8gTrtb2s:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 12:20:35PM -0700, Dan Williams wrote:
> On Wed, Mar 17, 2021 at 9:58 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Mar 17, 2021 at 09:08:23PM -0700, Dan Williams wrote:
> > > Jason wondered why the get_user_pages_fast() path takes references on a
> > > @pgmap object. The rationale was to protect against accessing a 'struct
> > > page' that might be in the process of being removed by the driver, but
> > > he rightly points out that should be solved the same way all gup-fast
> > > synchronization is solved which is invalidate the mapping and let the
> > > gup slow path do @pgmap synchronization [1].
> > >
> > > To achieve that it means that new user mappings need to stop being
> > > created and all existing user mappings need to be invalidated.
> > >
> > > For device-dax this is already the case as kill_dax() prevents future
> > > faults from installing a pte, and the single device-dax inode
> > > address_space can be trivially unmapped.
> > >
> > > The situation is different for filesystem-dax where device pages could
> > > be mapped by any number of inode address_space instances. An initial
> > > thought was to treat the device removal event like a drop_pagecache_sb()
> > > event that walks superblocks and unmaps all inodes. However, Dave points
> > > out that it is not just the filesystem user-mappings that need to react
> > > to global DAX page-unmap events, it is also filesystem metadata
> > > (proposed DAX metadata access), and other drivers (upstream
> > > DM-writecache) that need to react to this event [2].
> > >
> > > The only kernel facility that is meant to globally broadcast the loss of
> > > a page (via corruption or surprise remove) is memory_failure(). The
> > > downside of memory_failure() is that it is a pfn-at-a-time interface.
> > > However, the events that would trigger the need to call memory_failure()
> > > over a full PMEM device should be rare.
> >
> > This is a highly suboptimal design. Filesystems only need a single
> > callout to trigger a shutdown that unmaps every active mapping in
> > the filesystem - we do not need a page-by-page error notification
> > which results in 250 million hwposion callouts per TB of pmem to do
> > this.
> >
> > Indeed, the moment we get the first hwpoison from this patch, we'll
> > map it to the primary XFS superblock and we'd almost certainly
> > consider losing the storage behind that block to be a shut down
> > trigger. During the shutdown, the filesystem should unmap all the
> > active mappings (we already need to add this to shutdown on DAX
> > regardless of this device remove issue) and so we really don't need
> > a page-by-page notification of badness.
> 
> XFS doesn't, but what about device-mapper and other agents? Even if
> the driver had a callback up the stack memory_failure() still needs to
> be able to trigger failures down the stack for CPU consumed poison.

If the device is gone, then they don't need page by page
notifucation, either. Tell them the entire device is gone so they
can do what they need (like pass it up to the filesystem as ranges
of badness!).

> > AFAICT, it's going to take minutes, maybe hours for do the page-by-page
> > iteration to hwposion every page. It's going to take a few seconds
> > for the filesystem shutdown to run a device wide invalidation.
> >
> > SO, yeah, I think this should simply be a single ranged call to the
> > filesystem like:
> >
> >         ->memory_failure(dev, 0, -1ULL)
> >
> > to tell the filesystem that the entire backing device has gone away,
> > and leave the filesystem to handle failure entirely at the
> > filesystem level.
> 
> So I went with memory_failure() after our discussion of all the other
> agents in the system that might care about these pfns going offline
> and relying on memory_failure() to route down to each of those. I.e.
> the "reuse the drop_pagecache_sb() model" idea was indeed
> insufficient.

Using drop_pagecache_sb is insufficient because filesystems have
more than just inode indexed caches that pmem failure may affect.
This is not an argument against a "knock everything down at once"
notification model, just that drop_pagecache_sb() is ...
insufficient to do what we need...

> Now I'm trying to reconcile the fact that platform
> poison handling will hit memory_failure() first and may not
> immediately reach the driver, if ever (see the perennially awkward
> firmware-first-mode error handling: ghes_handle_memory_failure()) . So
> even if the ->memory_failure(dev...) up call exists there is no
> guarantee it can get called for all poison before the memory_failure()
> down call happens. Which means regardless of whether
> ->memory_failure(dev...) exists memory_failure() needs to be able to
> do the right thing.

I don't see how a poor implementation of memory_failure in a driver
or hardware is even remotely relevant to the interface used to
notify the filesystem of a media or device failure. It sounds like
you are trying to use memory_failure() for something it was never
intended to support and that there's a bunch of driver and
infrastructure work needed to make it work how you want it to work.
And even then it may not work the way we want it to work....

> Combine that with the fact that new buses like CXL might be configured
> in "poison on decode error" mode which means that a memory_failure()
> storm can happen regardless of whether the driver initiates it
> programatically.

Straw man argument.

"We can't make this interface a ranged notification because the
hardware might only be able to do page-by-page notification."

You can do page-by-page notification with a range based interface.
We are talking about how to efficiently and reliably inform the
filesystem that a range of a device is no longer accessible and so
it needs to revoke all mappings over that range of it's address
space. That does not need to be a single page at a time interface.

If your hardware is configured to do stupid things, then that is not
the fault of the software interface used to communicate faults up
the stack, nor is it something that the notfication interface should
try to fix or mitigate.....

> How about a mechanism to optionally let a filesystem take over memory
> failure handling for a range of pfns that the memory_failure() can
> consult to fail ranges at a time rather than one by one? So a new
> 'struct dax_operations' op (void) (*memory_failure_register(struct
> dax_device *, void *data). Where any agent that claims a dax_dev can
> register to take over memory_failure() handling for any event that
> happens in that range. This would be routed through device-mapper like
> any other 'struct dax_operations' op. I think that meets your
> requirement to get notifications of all the events you want to handle,
> but still allows memory_failure() to be the last resort for everything
> that has not opted into this error handling.

Which is basically the same as the proposed ->corrupted_range stack,
except it doesn't map the pfns back to LBA addresses the filesystem
needs to make sense of the failure.

fs-dax filesystems have no clue what pfns are, or how to translate
them to LBAs in their block device address space that the map
everything to. The fs-dax infrastructure asks the filesystem for
bdev/sector based mappings, and internally converts them to pfns by
a combination of bdev and daxdev callouts. Hence fs-dax filesystems
never see nor interpret pfns at all.  Nor do they have the
capability to convert a PFN to a LBA address. And neither the
underlying block device nor the associated DAX device provide a
method for doing this reverse mapping translation.

So if we have an interface that hands a {daxdev,PFN,len} tuple to
the filesystem, exactly what is the filesystem supposed to do with
it? How do we turn that back into a {bdev,sector,len} tuple so we
can do reverse mapping lookups to find the filesystem objects that
allocated within the notified range?

I'll point out again that these address space translations were
something that the ->corrupted_range callbacks handled directly - no
layer in the stack was handed a range that it didn't know how to map
to it's own internal structures. By the time it got to the
filesystem, it was a {bdev,sector,len} tuple, and the filesystem
could feed that directly to it's reverse mapping lookups....

Maybe I'm missing something magical about ->memory_failure that does
all this translation for us, but I don't see it in this patchset. I
just don't see how this proposed interface is a usable at the
filesystem level as it stands.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
