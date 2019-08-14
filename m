Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB38CD93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfHNIFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 04:05:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45123 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725265AbfHNIFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:05:24 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2A6E62ADD91;
        Wed, 14 Aug 2019 18:05:15 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hxoGO-0000sh-7T; Wed, 14 Aug 2019 18:04:08 +1000
Date:   Wed, 14 Aug 2019 18:04:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 07/19] fs/xfs: Teach xfs to use new
 dax_layout_busy_page()
Message-ID: <20190814080408.GI6129@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-8-ira.weiny@intel.com>
 <20190809233037.GB7777@dread.disaster.area>
 <20190812180551.GC19746@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812180551.GC19746@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=HrHlqKvGs1hBEanXDooA:9
        a=7KaysmK63p_gRbVv:21 a=sBCleACJziiZA8k5:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:05:51AM -0700, Ira Weiny wrote:
> On Sat, Aug 10, 2019 at 09:30:37AM +1000, Dave Chinner wrote:
> > On Fri, Aug 09, 2019 at 03:58:21PM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > dax_layout_busy_page() can now operate on a sub-range of the
> > > address_space provided.
> > > 
> > > Have xfs specify the sub range to dax_layout_busy_page()
> > 
> > Hmmm. I've got patches that change all these XFS interfaces to
> > support range locks. I'm not sure the way the ranges are passed here
> > is the best way to do it, and I suspect they aren't correct in some
> > cases, either....
> > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index ff3c1fae5357..f0de5486f6c1 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1042,10 +1042,16 @@ xfs_vn_setattr(
> > >  		xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > >  		iolock = XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL;
> > >  
> > > -		error = xfs_break_layouts(inode, &iolock, BREAK_UNMAP);
> > > -		if (error) {
> > > -			xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > > -			return error;
> > > +		if (iattr->ia_size < inode->i_size) {
> > > +			loff_t                  off = iattr->ia_size;
> > > +			loff_t                  len = inode->i_size - iattr->ia_size;
> > > +
> > > +			error = xfs_break_layouts(inode, &iolock, off, len,
> > > +						  BREAK_UNMAP);
> > > +			if (error) {
> > > +				xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > > +				return error;
> > > +			}
> > 
> > This isn't right - truncate up still needs to break the layout on
> > the last filesystem block of the file,
> 
> I'm not following this?  From a user perspective they can't have done anything
> with the data beyond the EOF.  So isn't it safe to allow EOF to grow without
> changing the layout of that last block?


You're looking at this from the perspective of what RDMA page
pinning, not what the guarantees a filesystem has to provide layout
holders.

For example, truncate up has to zero the portion of the block beyond
EOF and that requires a data write. What happens if that block is a
shared extent and hence we have do a copy on write and alter the
file layout?

Or perhaps that tail block still has dirty data over it that is
marked for delayed allocation? Truncate up will have to write that
data to zero the delayed allocation extent that spans EOF, and hence
the truncate modifies the layout because it triggers allocation.

i.e. just because an operation does not change user data, it does
not mean that it will not change the file layout. There is a chance
that truncate up will modify the layout and so we need to break the
layout leases that span the range from the old size to the new
size...

> > and truncate down needs to
> > extend to "maximum file offset" because we remove all extents beyond
> > EOF on a truncate down.
> 
> Ok, I was trying to allow a user to extend the file without conflicts if they
> were to have a pin on the 'beginning' of the original file.

If we want to allow file extension under a layout lease, the lease
has to extend beyond EOF, otherwise the new section of the file is
not covered by a lease. If leases only extend to the existing
EOF, then once the new data is written and the file is extended,
then the lease owner needs to take a new lease on the range they
just wrote. SO the application ends up having to do write - lease
-write -lease - .... so that it has leases covering the range of the
file it is extending into.

Much better it to define a lease that extends to max file offset,
such that it always covers they range past the existing EOF and
extending writes will automatically be covered. What this then does
is to trigger layout break notifications on file size change, either
by write, truncate, fallocate, without having to actually know or
track the exactly file size in the lease....

> This sounds like
> you are saying that a layout lease must be dropped to do that?  In some ways I
> think I understand what you are driving at and I think I see how I may have
> been playing "fast and loose" with the strictness of the layout lease.  But
> from a user perspective if there is a part of the file which "does not exist"
> (beyond EOF) does it matter that the layout there may change?

Yes, it does, because userspace can directly manipulate the layout
beyond EOF via fallocate(). e.g. we can preallocation beyond EOF
without changing the file size, such that when we then do an
extending write no layout change actually takes place. The only
thing that happens from a layout point of view is that the file size
changes.

This becomes /interesting/ when you start doing things like

	lseek(fd, offset, SEEK_END);
	write(fd, buf, len);

which will trigger a write way beyond EOF into allocated space.
That will also trigger block zeroing at the old tail, and there may
be block zeroing around the write() as well. We've effectively
change the layout of the file at EOF,  We've effectively change the
layout of the file at EOF, and potentially beyond EOF.

Indeed, the app might be expecting the preallocation beyond EOF to
remain, so it might register a layout over that range to be notified
if the preallocation is removed or the EOF extends beyond it. It
needs to be notified on truncate down (which removes that
preallocated range the lease sits over) and EOF is moved beyond it
(layout range state has changed from inaccessable to valid file
data)....


> > i.e. when we use preallocation, the extent map extends beyond EOF,
> > and layout leases need to be able to extend beyond the current EOF
> > to allow the lease owner to do extending writes, extending truncate,
> > preallocation beyond EOF, etc safely without having to get a new
> > lease to cover the new region in the extended file...
> 
> I'm not following this.  What determines when preallocation is done?

The application can direct it via fallocate(FALLOC_FL_KEEPSIZE).
It's typically used for workloads that do appending O_DSYNC or
direct IO writes to minimise file fragmentation.

The filesystem can ialso choose to do allocation beyond EOFi
speculatively during writes. XFS does this extensively with delayed
allocation. And the filesystem can also remove this speculative
allocation beyond EOF, which it may do if there are no active pages
dirties on the inode for a period, it is reclaimed, the filesystem
is running low on space, the user/group is running low on quota
space, etc.

Again, just because user data does not change, it does not mean that
the file layout will not change....

> Forgive my ignorance on file systems but how can we have a layout for every
> file which is "maximum file offset" for every file even if a file is only 1
> page long?

The layout lease doesn't care what the file size it. It doesn't even
know what the file size is. The layout lease covers a range the
logical file offset with the intend that any change to the file
layout within that range will result in a notification. The layout
lease is not bound to the range of valid data in the file at all -
it doesn't matter if it points beyond EOF - if the file grows to
the size the it overlaps the layout lease, then that layout lease
needs to be notified by break_layouts....

I've had a stinking headache all day, so I'm struggling to make
sense right now. The best I can describe is that layout lease ranges
do not imply or require valid file data to exist within the range
they are taken over - they just cover a file offset range.

FWIW, the fcntl() locking interface uses a length of 0 to
indicate "to max file offset" rather than a specific length. e.g.
SETLK and friends:

	Specifying 0 for l_len has the special meaning: lock all
	bytes starting at the location specified by l_whence and
	l_start through to the end of file, no  matter
	how large the file grows.

That's exactly the semantics I'm talking about here - layout leases
need to be able to specify an extent anywhere within the valid file
offset range, and also to specify a nebulous "through to the end of
the layout range" so taht file growth can be done without needing
new leases to be taken as the file grows....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
