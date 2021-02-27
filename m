Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A98326F73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 23:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhB0WhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 17:37:11 -0500
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:50640 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhB0WhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:37:06 -0500
Received: from dread.disaster.area (pa49-179-130-210.pa.nsw.optusnet.com.au [49.179.130.210])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id CC7D3102B0D;
        Sun, 28 Feb 2021 09:36:12 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lG8C3-007Rz9-F6; Sun, 28 Feb 2021 09:36:11 +1100
Date:   Sun, 28 Feb 2021 09:36:11 +1100
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
Message-ID: <20210227223611.GZ4662@dread.disaster.area>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia>
 <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area>
 <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area>
 <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0 cx=a_idp_d
        a=JD06eNgDs9tuHP7JIKoLzw==:117 a=JD06eNgDs9tuHP7JIKoLzw==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8 a=VwQbUJbxAAAA:8
        a=pGLkceISAAAA:8 a=iSifgx3cvDvq2X9g5s4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 02:41:34PM -0800, Dan Williams wrote:
> On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > > On Fri, Feb 26, 2021 at 12:51 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > My immediate concern is the issue Jason recently highlighted [1] with
> > > > > respect to invalidating all dax mappings when / if the device is
> > > > > ripped out from underneath the fs. I don't think that will collide
> > > > > with Ruan's implementation, but it does need new communication from
> > > > > driver to fs about removal events.
> > > > >
> > > > > [1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
> > > >
> > > > Oh, yay.
> > > >
> > > > The XFS shutdown code is centred around preventing new IO from being
> > > > issued - we don't actually do anything about DAX mappings because,
> > > > well, I don't think anyone on the filesystem side thought they had
> > > > to do anything special if pmem went away from under it.
> > > >
> > > > My understanding -was- that the pmem removal invalidates
> > > > all the ptes currently mapped into CPU page tables that point at
> > > > the dax device across the system. THe vmas that manage these
> > > > mappings are not really something the filesystem really manages,
> > > > but a function of the mm subsystem. What the filesystem cares about
> > > > is that it gets page faults triggered when a change of state occurs
> > > > so that it can remap the page to it's backing store correctly.
> > > >
> > > > IOWs, all the mm subsystem needs to when pmem goes away is clear the
> > > > CPU ptes, because then when then when userspace tries to access the
> > > > mapped DAX pages we get a new page fault. In processing the fault, the
> > > > filesystem will try to get direct access to the pmem from the block
> > > > device. This will get an ENODEV error from the block device because
> > > > because the backing store (pmem) has been unplugged and is no longer
> > > > there...
> > > >
> > > > AFAICT, as long as pmem removal invalidates all the active ptes that
> > > > point at the pmem being removed, the filesystem doesn't need to
> > > > care about device removal at all, DAX or no DAX...
> > >
> > > How would the pmem removal do that without walking all the active
> > > inodes in the fs at the time of shutdown and call
> > > unmap_mapping_range(inode->i_mapping, 0, 0, 1)?
> >
> > Which then immediately ends up back at the vmas that manage the ptes
> > to unmap them.
> >
> > Isn't finding the vma(s) that map a specific memory range exactly
> > what the rmap code in the mm subsystem is supposed to address?
> 
> rmap can lookup only vmas from a virt address relative to a given
> mm_struct. The driver has neither the list of mm_struct objects nor
> virt addresses to do a lookup. All it knows is that someone might have
> mapped pages through the fsdax interface.

So there's no physical addr to vma translation in the mm subsystem
at all?

That doesn't make sense. We do exactly this for hwpoison for DAX
mappings. While we don't look at ptes, we get a pfn, grab the page
it points to, check if it points to the PMEM that is being removed,
grab the page it points to, map that to the relevant struct page,
run collect_procs() on that page, then kill the user processes that
map that page.

So why can't we walk the ptes, check the physical pages that they
map to and if they map to a pmem page we go poison that
page and that kills any user process that maps it.

i.e. I can't see how unexpected pmem device unplug is any different
to an MCE delivering a hwpoison event to a DAX mapped page.  Both
indicate a physical address range now contains invalid data and the
filesystem has to take the same action...

IOWs, we could just call ->corrupted_range(0, EOD) here to tell the
filesystem the entire device went away. Then the filesystem deal
with this however it needs to. However, it would be more efficient
from an invalidation POV to just call it on the pages that have
currently active ptes because once the block device is dead
new page faults on DAX mappings will get a SIGBUS naturally.

> To me this looks like a notifier that fires from memunmap_pages()
> after dev_pagemap_kill() to notify any block_device associated with
> that dev_pagemap() to say that any dax mappings arranged through this
> block_device are now invalid. The reason to do this after
> dev_pagemap_kill() is so that any new mapping attempts that are racing
> the removal will be blocked.

I don't see why this needs a unique notifier. At the filesystem
level, we want a single interface that tells us "something bad
happened to the block device", not a proliferation of similar but
subtly different "bad thing X happened to block device" interfaces
that are unique to specific physical device drivers...

> The receiver of that notification needs to go from a block_device to a
> superblock that has mapped inodes and walk ->sb_inodes triggering the
> unmap/invalidation.

Not necessarily.

What if the filesystem is managing mirrored data across multiple
devices and this device is only one leg of the mirror? Or that the
pmem was used by the RT device in XFS and the data/log devices are
still fine? What if the pmem is just being used as a cache tier, and
no data was actually lost?

IOWs, what needs to happen at this point is very filesystem
specific. Assuming that "device unplug == filesystem dead" is not
correct, nor is specifying a generic action that assumes the
filesystem is dead because a device it is using went away.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
