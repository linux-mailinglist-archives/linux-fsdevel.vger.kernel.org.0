Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36332D07C5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgLFW4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 17:56:04 -0500
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:53337 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgLFW4E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:56:04 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 6D9241AC2B8;
        Mon,  7 Dec 2020 09:55:19 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1km2w2-001FXH-Ks; Mon, 07 Dec 2020 09:55:18 +1100
Date:   Mon, 7 Dec 2020 09:55:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com, hch@lst.de,
        song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201206225518.GJ3913616@dread.disaster.area>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <20201129224723.GG2842436@dread.disaster.area>
 <e0aa187f-e124-1ddc-0f5a-6a8c41a3dc66@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0aa187f-e124-1ddc-0f5a-6a8c41a3dc66@cn.fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
        a=HHWehwv_o5C9Q5xAZY4A:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 03:12:20PM +0800, Ruan Shiyang wrote:
> Hi Dave,
> 
> On 2020/11/30 上午6:47, Dave Chinner wrote:
> > On Mon, Nov 23, 2020 at 08:41:10AM +0800, Shiyang Ruan wrote:
> > > 
> > > The call trace is like this:
> > >   memory_failure()
> > >     pgmap->ops->memory_failure()   => pmem_pgmap_memory_failure()
> > >      gendisk->fops->block_lost()   => pmem_block_lost() or
> > >                                           md_blk_block_lost()
> > >       sb->s_ops->storage_lost()    => xfs_fs_storage_lost()
> > >        xfs_rmap_query_range()
> > >         xfs_storage_lost_helper()
> > >          mf_recover_controller->recover_fn => \
> > >                              memory_failure_dev_pagemap_kill_procs()
> > > 
> > > The collect_procs() and kill_procs() are moved into a callback which
> > > is passed from memory_failure() to xfs_storage_lost_helper().  So we
> > > can call it when a file assocaited is found, instead of creating a
> > > file list and iterate it.
> > > 
> > > The fsdax & reflink support for XFS is not contained in this patchset.
> > 
> > This looks promising - the overall architecture is a lot more
> > generic and less dependent on knowing about memory, dax or memory
> > failures. A few comments that I think would further improve
> > understanding the patchset and the implementation:
> 
> Thanks for your kindly comment.  It gives me confidence.
> 
> > 
> > - the order of the patches is inverted. It should start with a
> >    single patch introducing the mf_recover_controller structure for
> >    callbacks, then introduce pgmap->ops->memory_failure, then
> >    ->block_lost, then the pmem and md implementations of ->block
> >    list, then ->storage_lost and the XFS implementations of
> >    ->storage_lost.
> 
> Yes, it will be easier to understand the patchset in this order.
> 
> But I have something unsure: for example, I introduce ->memory_failure()
> firstly, but the implementation of ->memory_failure() needs to call
> ->block_lost() which is supposed to be introduced in the next patch. So, I
> am not sure the code is supposed to be what in the implementation of
> ->memory_failure() in pmem?  To avoid this situation, I committed the
> patches in the inverted order: lowest level first, then its caller, and then
> caller's caller.

Well, there's two things here. The first is the infrastructure, the
second is the drivers that use the infrastructure. You can introduce
a method in one patch, and then the driver that uses it in another.
Or you can introduce a driver skeleton that doesn't nothing until
more infrastructure is added. so...

> 
> I am trying to sort out the order.  How about this:
>  Patch i.
>    Introduce ->memory_failure()
>       - just introduce interface, without implementation
>  Patch i++.
>    Introduce ->block_lost()
>       - introduce interface and implement ->memory_failure()
>          in pmem, so that it can call ->block_lost()
>  Patch i++.
>    (similar with above, skip...)

So this is better, but you don't need to add the pmem driver use of
"->block_lost" in the patch that adds the method. IOWs, something
like:

P1: introduce ->memory_failure API, all the required documentation
and add the call sites in the infrastructure that trigger it

P2: introduce ->corrupted_range to the block device API, all the
required documentation and any generic block infrastructure that
needs to call it.

P3: introduce ->corrupted_range to the superblock ops API, all the
required documentation

P4: add ->corrupted_range() API to the address space ops, all the
required documentation

P5: factor the existing kill procs stuff to be able to be called on
via generic_mapping_kill_range()

P5: add dax_mapping_kill_range()

P6: add the pmem driver support for ->memory_failure

P7: add the block device driver support for ->corrupted_range

P8: add filesystem support for sb_ops->corrupted_range.

P9: add filesystem support for aops->corrupted_range.

> >    This gets rid of the mf_recover_controller altogether and allows
> >    the interface to be used by any sort of block device for any sort
> >    of bottom-up reporting of media/device failures.
> 
> Moving the recover function to the address_space ops looks a better idea.
> But I think that the error handler for page cache mapping is finished well
> in memory-failure.  The memory-failure is also reused to handles anonymous
> page.

Yes, anonymous page handling can remain there, we're only concerned
about handling file mapped pages here right now. If we end up
sharing page cache pages across reflink mappings, we'll have exactly
the same issue we have now with DAX....

> If we move the recover function to address_space ops, I think we also
> need to refactor the existing handler for page cache mapping, which may
> affect anonymous page handling.  This makes me confused...

Make the handling of the page the error occurred in conditional on
!PageAnon().

> I rewrote the call trace:
> memory_failure()
>  * dax mapping case
>  pgmap->ops->memory_failure()          =>
>                                    pmem_pgmap_memory_failure()
>   gendisk->fops->block_corrupt_range() =>
>                                    - pmem_block_corrupt_range()
>                                    - md_blk_block_corrupt_range()
>    sb->s_ops->storage_currupt_range()  =>
>                                    xfs_fs_storage_corrupt_range()

No need for block/storage prefixes in these...

>     xfs_rmap_query_range()
>      xfs_storage_lost_helper()
>       mapping->a_ops->corrupt_range()  =>
>                                    xfs_dax_aops.xfs_dax_corrupt_range
>        memory_failure_dev_pagemap_kill_procs()

This assumes we find a user data mapping. We might find the
corrupted storage contained metadata, in which case we'll be
shutting down the filesystem, not trying to kill user procs...

Also, we don't need aops->corrupt_range() here as we are already in
the filesystem code and if we find a mapping in memory we can just
do "if (IS_DAX(mapping->host))" to call the right kill procs
implementation for the mapping we've found. aops->corrupt_range is
for generic code working on a mapping to inform the filesystem that
there is a bad range in the mapping (my apologies for getting that
all mixed up in my last email).

>  * page cache mapping case
>  mapping->a_ops->corrupt_range()       =>
>                                    xfs_address_space_operations.xfs_xxx
>   memory_failure_generic_kill_procs()

We need the aops->corrupted_range() to call into the filesystem so
it can do a similar reverse mapping lookup to
sb->s_ops->corrupted_range.  Yes, the page cache should already have
a mapping attached to the page, but we do not know whether it is the
only mapping that exists for that page. e.g. if/when we implement
multiple-mapped shared read-only reflink pages in the page cache
which results in the same problem we have with DAX pages right now.

Overall, though, it seems like you're on the right path. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
