Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9532032A4FD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350018AbhCBLpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:45:35 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:48031 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444617AbhCBCn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:43:27 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 6ABC110748E;
        Tue,  2 Mar 2021 13:42:28 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lGuzT-00Ao38-CB; Tue, 02 Mar 2021 13:42:27 +1100
Date:   Tue, 2 Mar 2021 13:42:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
Message-ID: <20210302024227.GH4662@dread.disaster.area>
References: <20210226205126.GX4662@dread.disaster.area>
 <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
 <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area>
 <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210301224640.GG4662@dread.disaster.area>
 <CAPcyv4iTqDJApZY0o_Q0GKn93==d2Gta2NM5x=upf=3JtTia7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iTqDJApZY0o_Q0GKn93==d2Gta2NM5x=upf=3JtTia7Q@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=7-415B0cAAAA:8
        a=86xVJcmK9V8V8UM-AToA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:32:36PM -0800, Dan Williams wrote:
> On Mon, Mar 1, 2021 at 2:47 PM Dave Chinner <david@fromorbit.com> wrote:
> > Now we have the filesytem people providing a mechanism for the pmem
> > devices to tell the filesystems about physical device failures so
> > they can handle such failures correctly themselves. Having the
> > device go away unexpectedly from underneath a mounted and active
> > filesystem is a *device failure*, not an "unplug event".
> 
> It's the same difference to the physical page, all mappings to that
> page need to be torn down. I'm happy to call an fs callback and let
> each filesystem do what it wants with a "every pfn in this dax device
> needs to be unmapped".

You keep talking like this is something specific to a DAX device.
It isn't - the filesystem needs to take specific actions if any type
of block device reports that it has a corrupted range, not just DAX.
A DAX device simply adds "and invalidate direct mappings" to the
list of stuff that needs to be done.

And as far as a filesystem is concerned, there is no difference
between "this 4kB range is bad" and "the range of this entire device
is bad". We have to do the same things in both situations.

> I'm looking at the ->corrupted_range() patches trying to map it to
> this use case and I don't see how, for example a realtime-xfs over DM
> over multiple PMEM gets the notification to the right place.
> bd_corrupted_range() uses get_super() which get the wrong answer for
> both realtime-xfs and DM.

I'm not sure I follow your logic. What is generating the wrong
answer?

We already have infrastructure for the block device to look up the
superblock mounted on top of it, an DM already uses that for things
like "dmsetup suspend" to freeze the filesystem before it does
something.  This "superblock lookup" only occurs for the top level
DM device, not for the component pmem devices that make up the DM
device.


IOWs, if there's a DM device that maps multiple pmem devices, then
it should be stacking the bd_corrupted_range() callbacks to map the
physical device range to the range in the higher level DM device
that belongs to. This mapping of ranges is what DM exists to do -
the filesystem has no clue about what devices make up a DM device,
so the DM device *must* translate ranges for component devices into
the ranges that it maps that device into the LBA range it exposes to
the filesystem.

> I'd flip that arrangement around and have the FS tell the block device
> "if something happens to you, here is the super_block to notify".

We already have a mechanism for this that the block device calls:
get_active_super(bdev). There can be only one superblock per block
device - the superblock has exclusive ownership of the block device
while the filesystem is mounted.

get_active_super() returns the superblock that sits on top of the
bdev with an active reference, allowing the caller to safely access
and operate on the sueprblock without having to worry about the
superblock going away in the middle of whatever operation the block
device needs to perform.

If this isn't working, then existing storage stack functionality
doesn't work as it should and this needs fixing independently of
the PMEM/DAX stuff we are talking about here.

> So
> to me this looks like a fs_dax_register_super() helper that plumbs the
> superblock through an arbitrary stack of block devices to the leaf
> block-device that might want to send a notification up when a global
> unmap operation needs to be performed.

No, this is just wrong. The filesystem has no clue what block device
is at the leaf level of a block device stack, nor what LBA block
range represents that device within the address space the stacked
block devices present to the filesystem.

> > Please listen when we say "that is
> > not sufficient" because we don't want to be backed into a corner
> > that we have to fix ourselves again before we can enable some basic
> > filesystem functionality that we should have been able to support on
> > DAX from the start...
> 
> That's some revisionist interpretation of how the discovery of the
> reflink+dax+memory-error-handling collision went down.
> 
> The whole point of this discussion is to determine if
> ->corrupted_range() is suitable for this notification, and looking at
> the code as is, it isn't. Perhaps you have a different implementation
> of ->corrupted_range() in mind that allows this to be plumbed
> correctly?

So rather than try to make the generic ->corrupted_range
infrastructure be able to report "DAX range is invalid" (which is
the very definition of a corrupted block device range!), you want
to introduce a DAX specific notification to tell us that a range in
the block device contains invalid/corrupt data?

We're talking about a patchset that is in development. The proposed
notification path is supposed to be generic and *not PMEM specific*,
and is intended to handle exactly the use case that you raised.
The implementation may not be perfect yet, so rather than trying to
say "we need something different but does the same thing", work to
ensure that the proposed -generic infrastructure- can pass the
information you want to pass to the filesystem.

> > > Yes, but I was trying to map it to an existing mechanism and the
> > > internals of drop_pagecache_sb() are, in coarse terms, close to what
> > > needs to happen here.
> >
> > No.
> >
> > drop_pagecache_sb() is not a relevant model for telling a filesystem
> > that the block device underneath has gone away,
> 
> Like I said I'm not trying to communicate "device has gone away", only
> "unmap all dax pages".

That is the wrong thing to be communicating.  If the device has gone
away, the filesystem needs to know that the device has gone away,
not that it should just unmap DAX pages.

> If you want those to be one in the same
> mechanism I'm listening, but like I said it was my mistake for tying
> global unmap to device-gone, they need not be the same given
> fileystems have not historically been notified proactively of device
> removal.

What other circumstance is there for the device driver punching
through block device layers to tell the filesystem it should "unmap
all dax pages"? ANd if we get such an event, what does that mean for
any of the other filesystem data/metadata in that range?

You are still trying to tell the filesystem what action it must take
based on what went wrong at the device driver level, not
communicating what error just occurred to the device. The filesystem
needs to know about the error that occurred, not what some device
thinks the filesystem should do when the device detects an error.

> > Filesystems are way more complex than pure DAX devices, and hence
> > handle errors and failure events differently. Unlike DAX devices, we
> > have both internal and external references to the DAX device, and we
> > can have both external and internal direct maps.  Invalidating user
> > data mappings is all dax devices need to do on unplug, but for
> > filesystems it is only a small part of what we have to do when a
> > range of a device goes bad.
> >
> > IOWs, there is no "one size fits all" approach that works for all
> > filesystems, nor is there one strategy that is is optimal for all
> > filesystems. Failure handling in a filesystem is almost always
> > filesystem specific...
> 
> Point taken, if a filesystem is not using the block-layer for metadata
> I/O and using DAX techniques directly it needs this event too
> otherwise it will crash vs report failed operations...
> ->corrupted_range() does not offer the correct plumbing for that
> today.
> 
> There's an additional problem this brings to mind. Device-mapper
> targets like dm-writecache need this notification as well because it
> is using direct physical page access via the linear map and may crash
> like the filesystem if the mm-direct-map is torn down from underneath
> it.

Yes, dm gets the notification by the ->corrupted_range() callback
from it's underlying device(s). It can then do what it needs to map
the range and pass that error on to the filesystem. Fundamentally,
though, if the range is mapped into userspace and it goes away, the
user has lost data and there's nothing DM can do to recover it so
all it can do is pass the corruption up the stack to the next layer
(either another block device or the filesystem).

> > For actual pmem, maybe. But hotplug RAM is a thing; big numa
> > machines that can hotplug nodes into their fabric and so have CPUs
> > and memory able to come and go from a live machine. It's not a small
> > stretch to extend that to having PMEM in those nodes. So it's a
> > practical design concern right now, even ignoring that NVMe is
> > hotplug....
> 
> Memory hotplug today requires the memory-device to be offlined before
> the memory is unplugged and the core-mm has a chance to say "no" if it
> sees even one page with an elevated reference. Block-devices in
> contrast have no option to say "no" to being unplugged / ->remove()
> triggered.

Yes, I know that. That's my whole point - NVMe persistent regions
mean that DAX filesystems will have to handle the latter case, and
that it looks no different to normal block device failure to the
filesystem.  ->corrupted_range is exactly how these events are
intended to be sent up the storage stack to the filesystem, so why
should PMEM be handled any different?

> > > While the pmem
> > > driver has a ->remove() path that's purely a software unbind
> > > operation. That said the vulnerability window today is if a process
> > > acquires a dax mapping, the pmem device hosting that filesystem goes
> > > through an unbind / bind cycle, and then a new filesystem is created /
> > > mounted. That old pte may be able to access data that is outside its
> > > intended protection domain.
> >
> > So what is being done to prevent stale DAX mappings from being
> > leaked this way right now, seeing as the leak you mention here
> > doesn't appear in any way to be filesystem related?
> 
> For device-dax where there is only one inode->i_mapping to deal with,
> one unmap_mapping_range() call is performed in the device shutdown
> path. For filesystem-dax only the direct-map is torn down.
> 
> The user mapping teardown gap is why I'm coming at this elephant from
> the user mapping perspective and not necessarily the "what does the
> filesystem want to do about device removal" perspective.

But that doesn't help avoid the "user mapping teardown gap" at all -
that gap only gets bigger when you add a filesystem into the picture
because not we have tens to hundreds of millions of cache inodes to
walk and invalidate mappings on.

Closing this gap requires brute force purging the CPU ptes the
moment an unexpected DAX device unplug occurs. There is no other way
to do it quickly, and just waiting until the filesystem can unmap it
only increases the gap between the ptes becoming invalid and them
getting invalidated.

> > And once you take into account that "pulling the wrong device" can
> > happen, how does the filesystem tell tell the difference between a
> > device being pulled and a drive cage just dying and so the drive
> > just disappear from the system? How are these accidental vs real
> > failures any different from the perspective of a filesystem mounted
> > on that device?
> 
> Not even the device driver can tell you that.

Exactly my point. As there is no difference between unplug and
device failure from a filesystem perspective, the comunication
should come through a single "device failure" interface, not some
special DAX-specific notification path that you are advocating for.

> This goes back to Yasunori's question, can't ->remove() just be
> blocked when the filesystem is mounted? The answer is similar to
> asking the filesystem to allow DAX RDMA pages to be pinned
> indefinitely and lock-out the filesystem from making any extent-map
> changes. If the admin wants the device disabled while the filesystem
> is mounted the kernel should do everything it can to honor that
> request safely.

Sure, but the end effect of this is that the filesystem seems that
the -device has failed- and there is no need for DAX devices to
require some special "invalidate all mappings" notification when a
"device jsut failed" notification tells the filesystem the same
thing and a whole lot more....

> > This just makes no sense at all from an operations perspective - if
> > you know that you are about to do an unplug that will result in all
> > your DAX apps and filesystems being killed (i.e. fatal production
> > environment failure) then why haven't they all been stopped by the
> > admin before the device unplug is done? Why does this "human in the
> > loop" admin task require the applications and filesystems to handle
> > this without warning and have to treat it as a "device failure"
> > event when this can all be avoided for normal, scheduled, controlled
> > unplug operations? The "unexpected unplug" is a catastrophic failure
> > event which may have severe side effects on system operation and
> > stability. Why would you design an unplug process that does not
> > start with a clean, a controlled shutdown process from the top down?
> > If we make the assumption that planned unplugs are well planned,
> > organised and scheduled, then the only thing that an unplug event
> > needs to mean to a filesystem is "catastrophic device failure has
> > occurred".
> 
> There is a difference between the kernel saying "don't do that, bad
> things will happen" and "you can't do that the entire system will
> crash / security promises will be violated".
> 
> git grep -n suppress_bind_attr drivers/ata/ drivers/scsi/ drivers/nvme/
> 
> There are no block-device providers that I can find on a quick search
> that forbid triggering ->remove() on the driver if a filesystem is
> mounted. pmem is not the first block device driver to present this
> problem.

Yes, that's because, as you point out,  pmem has unique
characteristics - DAX - that absolutely require us to handle storage
failures in this way. No other type of device requires the fileystem
to directly arbitrate userspace access to the device, and so we've
been able to get away with having the block device return EIO or
ENODEV when we try to do IO and handling the problem that way.

But we still have been wanting ENODEV notification from block
devices when they are unexpectedly unplugged, and have been wanting
that functionality for at least the last decade, if not longer.
Filesystem shutdown on device removal should be instantenous because
device removal for most filesystems is an unrecoverable error and
delaying the shutdown until a fatal IO error occurrs in the
filesystem benefits no-one.

And now, we can't even get reliable IO error reporting, because DAX.

That's the problems that this set of ->corrupted_range callbacks is
supposed to provide - it's generic enough that we can plumb
ata/scsi/nvme layers into it as well as PMEM, and the filesystem
will now get device failure notifications from all types of device
drivers and block devices.

We do not need a DAX specific mechanism to tell us "DAX device
gone", we need a generic block device interface that tells us "range
of block device is gone".

The reason that the block device is gone is irrelevant to the
filesystem. The type of block device is also irrelevant. If the
filesystem isn't using DAX (e.g. dax=never mount option) even when
it is on a DAX capable device, then it just doesn't care about
invalidating DAX mappings because it has none. But it still may care
about shutting down the filesystem because the block device is gone.

This is why we need to communicate what error occurred, not what
action a device driver thinks needs to be taken. The error is
important to the filesystem, the action might be completely
irrelevant. And, as we know now, shutdown on DAX enable filesystems
needs to imply DAX mapping invalidation in all cases, not just when
the device disappears from under the filesystem.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
