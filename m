Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF732DDED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 00:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhCDXkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 18:40:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhCDXkQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:40:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3DD664F62;
        Thu,  4 Mar 2021 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614901215;
        bh=/0DW0uDIqgzkDXBs7LC+CDyXpa8iOTe6w8cw9abn6UI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnWu6vola+FNdAFd0O0QSm5CrhcxhlC4xqH8nCAsjypIQxK7Nfk41NTf6Spr5n04q
         k0c8hhgqr83fDz29/W3sfYKwGDITitYFhQFi4BE7nIQ6u6rpyzx/562jryvL8kGula
         Y22Pir+9Uwh4bVQA1M2OVITjvU1n1h7MBf0EHluTmx7XN8H86bvZ4/qweshhjrbc7r
         KJZY3ZHUYbqfUP+o6GOttYrxAxE9L+OA32k7AI9nwqEa3cYP0OqGucUUKr0DVCxdGi
         vJO+RX7WZl/yiBGpCr/Z3SI5kRSIXruyntKWfATL5pDR2eJWQVBTGjmA5v8TFLd+yw
         343jX08iumibA==
Date:   Thu, 4 Mar 2021 15:40:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20210304234014.GG3419940@magnolia>
References: <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
 <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area>
 <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210302032805.GM7272@magnolia>
 <CAPcyv4jXH0F+aii6ZtYQ3=Rx-mOWM7NFHC9wVxacW-b1o_s20g@mail.gmail.com>
 <20210302075736.GJ4662@dread.disaster.area>
 <CAPcyv4iyTHVW51xocmLO7F6ATgq0rJtQ1nShB=rAmDfzx83EyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iyTHVW51xocmLO7F6ATgq0rJtQ1nShB=rAmDfzx83EyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 02, 2021 at 09:49:30AM -0800, Dan Williams wrote:
> On Mon, Mar 1, 2021 at 11:57 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Mon, Mar 01, 2021 at 09:41:02PM -0800, Dan Williams wrote:
> > > On Mon, Mar 1, 2021 at 7:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > > > I really don't see you seem to be telling us that invalidation is an
> > > > > > either/or choice. There's more ways to convert physical block
> > > > > > address -> inode file offset and mapping index than brute force
> > > > > > inode cache walks....
> > > > >
> > > > > Yes, but I was trying to map it to an existing mechanism and the
> > > > > internals of drop_pagecache_sb() are, in coarse terms, close to what
> > > > > needs to happen here.
> > > >
> > > > Yes.  XFS (with rmap enabled) can do all the iteration and walking in
> > > > that function except for the invalidate_mapping_* call itself.  The goal
> > > > of this series is first to wire up a callback within both the block and
> > > > pmem subsystems so that they can take notifications and reverse-map them
> > > > through the storage stack until they reach an fs superblock.
> > >
> > > I'm chuckling because this "reverse map all the way up the block
> > > layer" is the opposite of what Dave said at the first reaction to my
> > > proposal, "can't the mm map pfns to fs inode  address_spaces?".
> >
> > Ah, no, I never said that the filesystem can't do reverse maps. I
> > was asking if the mm could directly (brute-force) invalidate PTEs
> > pointing at physical pmem ranges without needing walk the inode
> > mappings. That would be far more efficient if it could be done....

So, uh, /can/ the kernel brute-force invalidate PTEs when the pmem
driver says that something died?  Part of what's keeping me from putting
together a coherent vision for how this would work is my relative
unfamiliarity with all things mm/.

> > > Today whenever the pmem driver receives new corrupted range
> > > notification from the lower level nvdimm
> > > infrastructure(nd_pmem_notify) it updates the 'badblocks' instance
> > > associated with the pmem gendisk and then notifies userspace that
> > > there are new badblocks. This seems a perfect place to signal an upper
> > > level stacked block device that may also be watching disk->bb. Then
> > > each gendisk in a stacked topology is responsible for watching the
> > > badblock notifications of the next level and storing a remapped
> > > instance of those blocks until ultimately the filesystem mounted on
> > > the top-level block device is responsible for registering for those
> > > top-level disk->bb events.
> > >
> > > The device gone notification does not map cleanly onto 'struct badblocks'.
> >
> > Filesystems are not allowed to interact with the gendisk
> > infrastructure - that's for supporting the device side of a block
> > device. It's a layering violation, and many a filesytem developer
> > has been shouted at for trying to do this. At most we can peek
> > through it to query functionality support from the request queue,
> > but otherwise filesystems do not interact with anything under
> > bdev->bd_disk.
> 
> So lets add an api that allows the querying of badblocks by bdev and
> let the block core handle the bd_disk interaction. I see other block
> functionality like blk-integrity reaching through gendisk. The fs need
> not interact with the gendisk directly.

(I thought it was ok for block code to fiddle with other block
internals, and it's filesystems messing with block internals that was
prohibited?)

> > As it is, badblocks are used by devices to manage internal state.
> > e.g. md for recording stripes that need recovery if the system
> > crashes while they are being written out.
> 
> I know, I was there when it was invented which is why it was
> top-of-mind when pmem had a need to communicate badblocks. Other block
> drivers have threatened to use it for badblocks tracking, but none of
> those have carried through on that initial interest.

I hadn't realized that badblocks was bolted onto gendisk nowadays, I
mistakenly thought it was still something internal to md.

Looking over badblocks, I see a major drawback in that it can only
remember a single page's worth of badblocks records.

> > > If an upper level agent really cared about knowing about ->remove()
> > > events before they happened it could maybe do something like:
> > >
> > > dev = disk_to_dev(bdev->bd_disk)->parent;
> > > bus_register_notifier(dev->bus. &disk_host_device_notifier_block)
> >
> > Yeah, that's exactly the sort of thing that filesystems have been
> > aggressively discouraged from doing for years.
> 
> Yup, it's a layering violation.
> 
> > Part of the reason for this is that gendisk based mechanisms are not
> > very good for stacked device error reporting. Part of the problem
> > here is that every layer of the stacked device has to hook the
> > notifier of the block devices underneath it, then translate the
> > event to match the upper block device map, then regenerate the
> > notification for the next layer up. This isn't an efficient way to
> > pass a notification through a series of stacked devices and it is
> > messy and cumbersome to maintain.
> 
> It's been messy and cumbersome to route new infrastructure through DM
> every time a new dax_operation arrives. The corrupted_range() routing
> has the same burden. The advantage of badblocks over corrupted_range()
> is that it solves the "what If I miss a notification" problem. Each
> layer of the stack maintains its sector translation of the next level
> errors.

Oh.  Hum.  This changes my interpretation of what you're advocating.

If I'm understanding you correctly, I think you want to handle pmem
persistence errors (aka "I lost this cache line") by ... what?  The pmem
driver marks the appropriate range in the block_device/dax_device's
badblocks list, invalidates the page tables to force fs page faults, and
the next time the fs tries to access that pmem (either via bios or by
creating a direct map) the lower level storage driver will see the
badblocks entry and fail the IO / decline the mapping?

<shrug> I dunno, does that even make sense?  I thought it was pretty
easy for the kernel to invalidate a mapping to force a page fault, since
we (xfs) do that to the regular page cache all the time.

Assuming I understood that part correctly, why is it objectionable to
ask for the one extra step where pmem steps through the dax_device to
call the filesystem ->memory_failure handler?  There's no pmem-mapper
layer (yet) so making this piece happen should be relatively simple
since it doesn't require translating through multiple layers of dm,
right?

Also, does your mental model of storage device error reporting center
around lower layers setting badblocks ranges and then poking filesystems
to call down into badblocks to find out what's bad?  Versus lower layers
calling filesystems with the bad ranges directly?  Or are you trying to
omit as much fs involvement as possible?

(I'll address invalidating dax devices a little further down)

> > It can be effective for getting notifications to userspace about
> > something that happens to a specific block device.
> 
> No, it's not block device specific, it's stuck at the disk level. The
> user notification aspect was added for pmem at the disk layer because
> IIRC it was NAKd to add it to the block_device itself.
> 
> >
> > But The userspace
> > still ends up having to solve the "what does this error resolve to"
> > problem. i.e. Userspace still needs to map that notification to a
> > filesystem, and for data loss events map it to objects within the
> > filesystem, which can be extremely expensive to do from userspace.
> 
> Expensive and vulnerable to TOCTOU, this has been the motivation for
> filesystem native awareness of these errors from the beginning.
> 
> > This is exactly the sort of userspace error reporting mess that
> > various projects have asked us to try to fix. Plumbing errors
> > internally through the kernel up to the filesystem where the
> > filesytem can point directly to the user data that is affected is a
> > simple, effective solution to the problem. Especially if we then
> > have a generic error notification mechanism for filesystems to emit
> > errors to registered userspace watchers...
> 
> Agree, that's the dream worth pursuing.

(Agree, the error reporting story is still a mess.)

> >
> > > I still don't think that solves the need for a separate mechanism for
> > > global dax_device pte invalidation.
> >
> > It's just another type of media error because.....
> >
> > > I think that global dax_device invalidation needs new kernel
> > > infrastructure to allow internal users, like dm-writecache and future
> > > filesystems using dax for metadata, to take a fault when pmem is
> > > offlined.
> >
> > .... if userspace has directly mapped into the cache, and the cache
> > storage goes away, the userspace app has to be killed because we
> > have no idea if the device going away has caused data loss or not.
> > IOWs, if userspace writes direct to the cache device and it hasn't
> > been written back to other storage when it gets yanked, we have just
> > caused data corruption to occur.
> 
> If userspace has it direct mapped dirty in the cache when the remove
> fires, there is no opportunity to flush the cache. Just as there is no
> opportunity today with non-DAX and the page cache. The block-queue
> will be invalidated and any dirty in page cache is stranded.

So this is the "dax device invalidation" case that you also mention
below.  How differently would you handle this case from the persistence
error case I outlined above?  It sounds like in this case all the mm can
really do is invalidate the active page table mappings and set some
"totally offline" state in the dax/block_device badblocks so that all
future io requests are declined?

Do I understand that correctly?

If so, then I guess my next question is about the coordinated
pre-removal step that I think you mentioned in connection with something
named "CXL"?  If someone /requests/ the removal of a chunk of pmem,
would you propagate that request far enough up the storage chain so that
a mounted filesystem could reject the removal attempt?

> > At minimum, we now have to tell the filesystem that the dirty data
> > in the cache is now bad, and direct map applications that map those
> > dirty ranges need to be killed because their backing store is no
> > longer valid nor does the backup copy contain the data they last
> > wrote. Nor is it acessible by direct access, which is going to be
> > interesting because dynamically changing dax to non-dax access can't
> > be done without forcibly kicking the inode out of the cache. That
> > requires all references to the inode to go away. And that means the
> > event really has to go up to the filesystem.
> >
> > But I think the biggest piece of the puzzle that you haven't grokked
> > here is that the dm cache device isn't a linear map - it's made up of
> > random ranges from the underlying devices. Hence the "remove" of a dm
> > cache device turns into a huge number of small, sparse corrupt
> > ranges, not a single linear device remove event.
> 
> I am aware that DM is non-linear. The other non-linearity is sector-to-pfn.
> 
> > IOWs, device unplug/remove events are not just simple "pass it on"
> > events in a stacked storage setup. There can be non-trivial mappings
> > through the layers, and device disappearance may in fact manifest to
> > the user as data corruption rather than causing data to be
> > inaccessible.
> 
> Even MD does not rely on component device notifications for failure
> notifications, it waits for write-errors, and yes losing a component
> of a raid0 is more than a data offline event.
> 
> > Hence "remove" notifications just don't work in the storage stack.
> > They need to be translated to block ranges going bad (i.e.  media
> > errors), and reported to higher layers as bad ranges, not as device
> > removal.
> 
> Yes, the generic top-level remove event is pretty much useless for
> both the dax pte invalidation and lba range offline notification. I'm
> distinguishing that from knock on events that fire in response to
> ->remove() triggering on the disk driver which seems to be where you
> are at as well with the idea to trigger ->corrupted_range(0, EOD) from
> ->remove().
> 
> There's 2 ways to view the "filesystems have wanted proactive
> notification of remove events from storage for a long time". There's
> either enough pent up demand to convince all parties to come to the
> table and get something done, or there's too much momentum with the
> status quo to overcome.

Don't forget my cynical product manager view: "Here's a good opportunity
to get the basics of this revolutionary change plumbed in while upper
management is still hot enough about pmem to spend engineer time". :P

> I do not think it is fair to ask Ruan to solve a problem with brand
> new plumbing that the Linux storage community has not seen fit to
> address for a decade.

Nevertheless, he's more or less built it now.  Honestly I'm pleased to
see him pushing this forward exactly /because/ nobody has seen fit to
address this for so long.

The part where we plumb notifications upwards through the storage stack
is indeed revolutionary.  However, I /do/ think it's fair to ask Ruan to
make a revolutionary change as part of adapting to recent revolutionary
changes in storage hardware.

(At the very least I think it soul-crushing to toss out Ruan's work
now that he's at least gotten the proof of concept running... but Ruan
is in the best place to say that)

> Not when disk->bb is already plumbed without anyone complaining about
> it.

...or noticing it was there, as was the case here. :/

> > The same goes for DAX devices. The moment they can be placed in
> > storage stacks in non-trivial configurations and/or used as cache
> > devices that can be directly accessed over tranditional block
> > devices, we end up with error conditions that can only be mapped as
> > ranges of blocks that have gone bad.
> 
> I see plumbing corrupted_range() and using it to communicate removal
> in addition to badblocks in addition to bad pfns as a revolutionary
> change. A reuse of disk->bb for communicating poison sector discovery
> events up the stack and a separate facility to invalidate dax devices
> as evolutionary. The evolutionary change does not preclude the
> eventual revolutionary change, but it has a better chance of making
> forward progress in the near term.

And I want both. :)

But I'll end this email here to make sure I've understood what you're
going for, Dan, before working on a reply.

Hopefully it doesn't take 2 days to roundtrip a reply email like the
last week of utter vger frustration. :(

--D
