Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3894032A523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443421AbhCBLrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:41 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:33075 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376815AbhCBIAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:00:41 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 740D3105F88;
        Tue,  2 Mar 2021 18:57:37 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lGzuS-00B8zi-8j; Tue, 02 Mar 2021 18:57:36 +1100
Date:   Tue, 2 Mar 2021 18:57:36 +1100
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
Message-ID: <20210302075736.GJ4662@dread.disaster.area>
References: <20210226205126.GX4662@dread.disaster.area>
 <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area>
 <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area>
 <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210302032805.GM7272@magnolia>
 <CAPcyv4jXH0F+aii6ZtYQ3=Rx-mOWM7NFHC9wVxacW-b1o_s20g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jXH0F+aii6ZtYQ3=Rx-mOWM7NFHC9wVxacW-b1o_s20g@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=dESyimp9J3IA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=sNTs5Pk-nQt0djJhEW0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 09:41:02PM -0800, Dan Williams wrote:
> On Mon, Mar 1, 2021 at 7:28 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > I really don't see you seem to be telling us that invalidation is an
> > > > either/or choice. There's more ways to convert physical block
> > > > address -> inode file offset and mapping index than brute force
> > > > inode cache walks....
> > >
> > > Yes, but I was trying to map it to an existing mechanism and the
> > > internals of drop_pagecache_sb() are, in coarse terms, close to what
> > > needs to happen here.
> >
> > Yes.  XFS (with rmap enabled) can do all the iteration and walking in
> > that function except for the invalidate_mapping_* call itself.  The goal
> > of this series is first to wire up a callback within both the block and
> > pmem subsystems so that they can take notifications and reverse-map them
> > through the storage stack until they reach an fs superblock.
> 
> I'm chuckling because this "reverse map all the way up the block
> layer" is the opposite of what Dave said at the first reaction to my
> proposal, "can't the mm map pfns to fs inode  address_spaces?".

Ah, no, I never said that the filesystem can't do reverse maps. I
was asking if the mm could directly (brute-force) invalidate PTEs
pointing at physical pmem ranges without needing walk the inode
mappings. That would be far more efficient if it could be done....

> Today whenever the pmem driver receives new corrupted range
> notification from the lower level nvdimm
> infrastructure(nd_pmem_notify) it updates the 'badblocks' instance
> associated with the pmem gendisk and then notifies userspace that
> there are new badblocks. This seems a perfect place to signal an upper
> level stacked block device that may also be watching disk->bb. Then
> each gendisk in a stacked topology is responsible for watching the
> badblock notifications of the next level and storing a remapped
> instance of those blocks until ultimately the filesystem mounted on
> the top-level block device is responsible for registering for those
> top-level disk->bb events.
> 
> The device gone notification does not map cleanly onto 'struct badblocks'.

Filesystems are not allowed to interact with the gendisk
infrastructure - that's for supporting the device side of a block
device. It's a layering violation, and many a filesytem developer
has been shouted at for trying to do this. At most we can peek
through it to query functionality support from the request queue,
but otherwise filesystems do not interact with anything under
bdev->bd_disk.

As it is, badblocks are used by devices to manage internal state.
e.g. md for recording stripes that need recovery if the system
crashes while they are being written out.

> If an upper level agent really cared about knowing about ->remove()
> events before they happened it could maybe do something like:
> 
> dev = disk_to_dev(bdev->bd_disk)->parent;
> bus_register_notifier(dev->bus. &disk_host_device_notifier_block)

Yeah, that's exactly the sort of thing that filesystems have been
aggressively discouraged from doing for years.

Part of the reason for this is that gendisk based mechanisms are not
very good for stacked device error reporting. Part of the problem
here is that every layer of the stacked device has to hook the
notifier of the block devices underneath it, then translate the
event to match the upper block device map, then regenerate the
notification for the next layer up. This isn't an efficient way to
pass a notification through a series of stacked devices and it is
messy and cumbersome to maintain.

It can be effective for getting notifications to userspace about
something that happens to a specific block device. But The userspace
still ends up having to solve the "what does this error resolve to"
problem. i.e. Userspace still needs to map that notification to a
filesystem, and for data loss events map it to objects within the
filesystem, which can be extremely expensive to do from userspace.

This is exactly the sort of userspace error reporting mess that
various projects have asked us to try to fix. Plumbing errors
internally through the kernel up to the filesystem where the
filesytem can point directly to the user data that is affected is a
simple, effective solution to the problem. Especially if we then
have a generic error notification mechanism for filesystems to emit
errors to registered userspace watchers...

> I still don't think that solves the need for a separate mechanism for
> global dax_device pte invalidation.

It's just another type of media error because.....

> I think that global dax_device invalidation needs new kernel
> infrastructure to allow internal users, like dm-writecache and future
> filesystems using dax for metadata, to take a fault when pmem is
> offlined.

.... if userspace has directly mapped into the cache, and the cache
storage goes away, the userspace app has to be killed because we
have no idea if the device going away has caused data loss or not.
IOWs, if userspace writes direct to the cache device and it hasn't
been written back to other storage when it gets yanked, we have just
caused data corruption to occur.

At minimum, we now have to tell the filesystem that the dirty data
in the cache is now bad, and direct map applications that map those
dirty ranges need to be killed because their backing store is no
longer valid nor does the backup copy contain the data they last
wrote. Nor is it acessible by direct access, which is going to be
interesting because dynamically changing dax to non-dax access can't
be done without forcibly kicking the inode out of the cache. That
requires all references to the inode to go away. And that means the
event really has to go up to the filesystem.

But I think the biggest piece of the puzzle that you haven't grokked
here is that the dm cache device isn't a linear map - it's made up of
random ranges from the underlying devices. Hence the "remove" of a dm
cache device turns into a huge number of small, sparse corrupt
ranges, not a single linear device remove event.

IOWs, device unplug/remove events are not just simple "pass it on"
events in a stacked storage setup. There can be non-trivial mappings
through the layers, and device disappearance may in fact manifest to
the user as data corruption rather than causing data to be
inaccessible.

Hence "remove" notifications just don't work in the storage stack.
They need to be translated to block ranges going bad (i.e.  media
errors), and reported to higher layers as bad ranges, not as device
removal.

The same goes for DAX devices. The moment they can be placed in
storage stacks in non-trivial configurations and/or used as cache
devices that can be directly accessed over tranditional block
devices, we end up with error conditions that can only be mapped as
ranges of blocks that have gone bad.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
