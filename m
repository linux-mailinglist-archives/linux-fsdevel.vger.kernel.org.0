Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446EC3882C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 May 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352771AbhERWiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 18:38:03 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:51453 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhERWiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 18:38:02 -0400
Received: from dread.disaster.area (pa49-195-118-180.pa.nsw.optusnet.com.au [49.195.118.180])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 363BA108858;
        Wed, 19 May 2021 08:36:38 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lj8KL-002Ymb-Nc; Wed, 19 May 2021 08:36:37 +1000
Date:   Wed, 19 May 2021 08:36:37 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 03/11] mm: Protect operations adding pages to page cache
 with invalidate_lock
Message-ID: <20210518223637.GJ2893@dread.disaster.area>
References: <20210512101639.22278-1-jack@suse.cz>
 <20210512134631.4053-3-jack@suse.cz>
 <20210512152345.GE8606@magnolia>
 <20210513174459.GH2734@quack2.suse.cz>
 <20210513185252.GB9675@magnolia>
 <20210513231945.GD2893@dread.disaster.area>
 <20210514161730.GL9675@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514161730.GL9675@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=xcwBwyABtj18PbVNKPPJDQ==:117 a=xcwBwyABtj18PbVNKPPJDQ==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=cLZU_rh0lbdFaG61GT8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 09:17:30AM -0700, Darrick J. Wong wrote:
> On Fri, May 14, 2021 at 09:19:45AM +1000, Dave Chinner wrote:
> > On Thu, May 13, 2021 at 11:52:52AM -0700, Darrick J. Wong wrote:
> > > On Thu, May 13, 2021 at 07:44:59PM +0200, Jan Kara wrote:
> > > > On Wed 12-05-21 08:23:45, Darrick J. Wong wrote:
> > > > > On Wed, May 12, 2021 at 03:46:11PM +0200, Jan Kara wrote:
> > > > > > +->fallocate implementation must be really careful to maintain page cache
> > > > > > +consistency when punching holes or performing other operations that invalidate
> > > > > > +page cache contents. Usually the filesystem needs to call
> > > > > > +truncate_inode_pages_range() to invalidate relevant range of the page cache.
> > > > > > +However the filesystem usually also needs to update its internal (and on disk)
> > > > > > +view of file offset -> disk block mapping. Until this update is finished, the
> > > > > > +filesystem needs to block page faults and reads from reloading now-stale page
> > > > > > +cache contents from the disk. VFS provides mapping->invalidate_lock for this
> > > > > > +and acquires it in shared mode in paths loading pages from disk
> > > > > > +(filemap_fault(), filemap_read(), readahead paths). The filesystem is
> > > > > > +responsible for taking this lock in its fallocate implementation and generally
> > > > > > +whenever the page cache contents needs to be invalidated because a block is
> > > > > > +moving from under a page.
> > > > > > +
> > > > > > +->copy_file_range and ->remap_file_range implementations need to serialize
> > > > > > +against modifications of file data while the operation is running. For blocking
> > > > > > +changes through write(2) and similar operations inode->i_rwsem can be used. For
> > > > > > +blocking changes through memory mapping, the filesystem can use
> > > > > > +mapping->invalidate_lock provided it also acquires it in its ->page_mkwrite
> > > > > > +implementation.
> > > > > 
> > > > > Question: What is the locking order when acquiring the invalidate_lock
> > > > > of two different files?  Is it the same as i_rwsem (increasing order of
> > > > > the struct inode pointer) or is it the same as the XFS MMAPLOCK that is
> > > > > being hoisted here (increasing order of i_ino)?
> > > > > 
> > > > > The reason I ask is that remap_file_range has to do that, but I don't
> > > > > see any conversions for the xfs_lock_two_inodes(..., MMAPLOCK_EXCL)
> > > > > calls in xfs_ilock2_io_mmap in this series.
> > > > 
> > > > Good question. Technically, I don't think there's real need to establish a
> > > > single ordering because locks among different filesystems are never going
> > > > to be acquired together (effectively each lock type is local per sb and we
> > > > are free to define an ordering for each lock type differently). But to
> > > > maintain some sanity I guess having the same locking order for doublelock
> > > > of i_rwsem and invalidate_lock makes sense. Is there a reason why XFS uses
> > > > by-ino ordering? So that we don't have to consider two different orders in
> > > > xfs_lock_two_inodes()...
> > > 
> > > I imagine Dave will chime in on this, but I suspect the reason is
> > > hysterical raisins^Wreasons.
> > 
> > It's the locking rules that XFS has used pretty much forever.
> > Locking by inode number always guarantees the same locking order of
> > two inodes in the same filesystem, regardless of the specific
> > in-memory instances of the two inodes.
> > 
> > e.g. if we lock based on the inode structure address, in one
> > instancex, we could get A -> B, then B gets recycled and
> > reallocated, then we get B -> A as the locking order for the same
> > two inodes.
> > 
> > That, IMNSHO, is utterly crazy because with non-deterministic inode
> > lock ordered like this you can't make consistent locking rules for
> > locking the physical inode cluster buffers underlying the inodes in
> > the situation where they also need to be locked.
> 
> <nod> That's protected by the ILOCK, correct?
> 
> > We've been down this path before more than a decade ago when the
> > powers that be decreed that inode locking order is to be "by
> > structure address" rather than inode number, because "inode number
> > is not unique across multiple superblocks".
> > 
> > I'm not sure that there is anywhere that locks multiple inodes
> > across different superblocks, but here we are again....
> 
> Hm.  Are there situations where one would want to lock multiple
> /mappings/ across different superblocks?  The remapping code doesn't
> allow cross-super operations, so ... pipes and splice, maybe?  I don't
> remember that code well enough to say for sure.

Hmmmm. Doing read IO into a buffer that is mmap()d from another
file, and we take a page fault on it inside the read IO path? We're
copying from a page in one mapping and taking a fault in another
mapping and hence taking the invalidate_lock to populate the page
cache for the second mapping...

I haven't looked closely enough at where the invalidate_lock is held
in the read path to determine if this is an issue, but if it is then
it is also a potential deadlock scenario...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
