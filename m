Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C161A2D17
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDIAt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 20:49:29 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47127 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgDIAt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:49:29 -0400
Received: from dread.disaster.area (pa49-180-167-53.pa.nsw.optusnet.com.au [49.180.167.53])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 925BD3A3A5F;
        Thu,  9 Apr 2020 10:49:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMLNh-00064c-Uo; Thu, 09 Apr 2020 10:49:21 +1000
Date:   Thu, 9 Apr 2020 10:49:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409004921.GS24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
 <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=2xmR08VVv0jSFCMMkhec0Q==:117 a=2xmR08VVv0jSFCMMkhec0Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=XzohEP87-a05f5LQuZEA:9
        a=nMb1Ig4BaMjQqHx8:21 a=cqw_wM9ek9d8jNnC:21 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 05:12:06PM -0700, Ira Weiny wrote:
> On Thu, Apr 09, 2020 at 09:21:06AM +1000, Dave Chinner wrote:
> > On Wed, Apr 08, 2020 at 03:07:35PM -0700, Ira Weiny wrote:
> > > On Thu, Apr 09, 2020 at 07:02:36AM +1000, Dave Chinner wrote:
> > > > On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:
> > > 
> > > [snip]
> > > 
> > > > > 
> > > > > This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> > > > > 
> > > > > void
> > > > > xfs_diflags_to_iflags(
> > > > >         struct xfs_inode        *ip,
> > > > >         bool init)
> > > > > {
> > > > >         struct inode            *inode = VFS_I(ip);
> > > > >         unsigned int            xflags = xfs_ip2xflags(ip);
> > > > >         unsigned int            flags = 0;
> > > > > 
> > > > >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> > > > >                             S_DAX);
> > > > 
> > > > We don't want to clear the dax flag here, ever, if it is already
> > > > set. That is an externally visible change and opens us up (again) to
> > > > races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> > > > clearing the DAX flag was something I did explicitly in the above
> > > > code fragment.
> > > 
> > > <sigh> yes... you are correct.
> > > 
> > > But I don't like depending on the caller to clear the S_DAX flag if
> > > xfs_inode_enable_dax() is false.  IMO this function should clear the flag in
> > > that case for consistency...
> > 
> > No. We simply cannot do that here except in the init case when the
> > inode is not yet visible to userspace. In which case, we know -for
> > certain- that the S_DAX is not set, and hence we do not need to
> > clear it. Initial conditions matter!
> > 
> > If you want to make sure of this, add this:
> > 
> > 	ASSERT(!(IS_DAX(inode) && init));
> > 
> > And now we'll catch inodes that incorrectly have S_DAX set at init
> > time.
> 
> Ok, that will work.  Also documents that expected initial condition.
> 
> > 
> > > > memory S_DAX flag, we can actually clear the on-disk flag
> > > > safely, so that next time the inode cycles into memory it won't
> > > > be using DAX. IOWs, admins can stop the applications, clear the
> > > > DAX flag and drop caches. This should result in the inode being
> > > > recycled and when the app is restarted it will run without DAX.
> > > > No ned for deleting files, copying large data sets, etc just to
> > > > turn off an inode flag.
> > > 
> > > We already discussed evicting the inode and it was determined to
> > > be too confusing.[*]
> > 
> > That discussion did not even consider how admins are supposed to
> > clear the inode flag once it is set on disk.
> 
> I think this is a bit unfair.  I think we were all considering it...  and I
> still think this patch set is a step in the right direction.
> 
> > It was entirely
> > focussed around "we can't change in memory S_DAX state"
> 
> Not true.  There were many ideas on how to change the FS_XFLAG_DAX with some
> sort of delayed S_DAX state to avoid changing S_DAX on an in memory inode.
> 
> I made the comment:
> 
> 	"... I want to clarify.  ...  we could have the flag change with an
> 	appropriate error which could let the user know the change has been
> 	delayed."
> 
> 	-- https://lore.kernel.org/lkml/20200402205518.GF3952565@iweiny-DESK2.sc.intel.com/
> 
> Jan made multiple comments:
> 
> 	"I generally like the proposal but I think the fact that toggling
> 	FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite
> 	some confusion and ultimately bug reports."
> 
> 	-- https://lore.kernel.org/lkml/20200401102511.GC19466@quack2.suse.cz/
> 
> 
> 	"Just switch FS_XFLAG_DAX flag, S_DAX flag will magically switch when
> 	inode gets evicted and the inode gets reloaded from the disk again. Did
> 	I misunderstand anything?
> 
> 	And my thinking was that this is surprising behavior for the user and
> 	so it will likely generate lots of bug reports along the lines of "DAX
> 	inode flag does not work!"."
> 
> 	-- https://lore.kernel.org/lkml/20200403170338.GD29920@quack2.suse.cz/
> 
> Darrick also had similar ideas/comments.

None of these consider how the admin is supposed to remove
the flag once it is set. They all talk about issues that result
from setting/clearing the flag inside the kernel, and don't consider
the administration impacts of having an unclearable flag on disk
that the kernel uses for operational policy decisions.

Nobody said "hey, wait, if we don't allow the flag to be cleared
once the flag is set, how do we actually remove it so the admin can
stop overriding them globally with the mount option? If the kernel
can't clear the flag, then what mechanism are we going to provide to
let them clear it without interrupting production?"

> Christoph did say:
> 
> 	"A reasonably smart application can try to evict itself."
> 
> 	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/

I'd love to know how an unprivileged application can force the
eviction of an inode from cache. If the application cannot evict
files it is using reliably, then it's no better solution than
drop_caches. And given that userspace has to take references to
files to access them, by definition a file that userspace is trying
to evict will have active references and hence cannot be evicted.

However, if userspace can reliably evict inodes that it can access,
then we have a timing attack vector that we need to address.  i.e.
by now everyone here should know that user controlled cache eviction
is the basic requirement for creating most OS and CPU level timing
attacks....

> > and how the
> > tri-state mount option to "override" the on-disk flag could be done.
> > 
> > Nobody noticed that being unable to rmeove the on-disk flag means
> > the admin's only option to turn off dax for an application is to
> > turn it off for everything, filesystem wide, which requires:
> 
> No. This is not entirely true.  While I don't like the idea of having to copy
> data (and I agree with your points) it is possible to do.
> 
> > 
> > 	1. stopping the app.
> > 	2. stopping every other app using the filesystem
> > 	3. unmounting the filesystem
> > 	4. changing to dax=never mount option
> 
> I don't understand why we need to unmount and mount with dax=never?

1. IIUC your patches correctly, that's exactly how you implemented
the dax=... mount option.

2. If you don't unmount the filesystem and only require a remount,
then changing the mount option has all the same "delayed effect"
issues that changing the on-disk flag has. i.e. We can't change the
in-memory inode state until the inode has been evicted from cache
and a remount doesn't guarantee that cache eviction will succeed.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
