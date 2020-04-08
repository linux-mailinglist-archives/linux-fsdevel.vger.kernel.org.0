Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3C1A2C2C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 01:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHXVM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 19:21:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52664 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgDHXVM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 19:21:12 -0400
Received: from dread.disaster.area (pa49-180-125-11.pa.nsw.optusnet.com.au [49.180.125.11])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EBE823A2652;
        Thu,  9 Apr 2020 09:21:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMK0I-0005XT-PA; Thu, 09 Apr 2020 09:21:06 +1000
Date:   Thu, 9 Apr 2020 09:21:06 +1000
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
Message-ID: <20200408232106.GO24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=2h+yFbpuifLtD1c++IMymA==:117 a=2h+yFbpuifLtD1c++IMymA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=7-415B0cAAAA:8 a=Ekvvis_OAEGBRbM5Ic8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 03:07:35PM -0700, Ira Weiny wrote:
> On Thu, Apr 09, 2020 at 07:02:36AM +1000, Dave Chinner wrote:
> > On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:
> 
> [snip]
> 
> > > 
> > > This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> > > 
> > > void
> > > xfs_diflags_to_iflags(
> > >         struct xfs_inode        *ip,
> > >         bool init)
> > > {
> > >         struct inode            *inode = VFS_I(ip);
> > >         unsigned int            xflags = xfs_ip2xflags(ip);
> > >         unsigned int            flags = 0;
> > > 
> > >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> > >                             S_DAX);
> > 
> > We don't want to clear the dax flag here, ever, if it is already
> > set. That is an externally visible change and opens us up (again) to
> > races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> > clearing the DAX flag was something I did explicitly in the above
> > code fragment.
> 
> <sigh> yes... you are correct.
> 
> But I don't like depending on the caller to clear the S_DAX flag if
> xfs_inode_enable_dax() is false.  IMO this function should clear the flag in
> that case for consistency...

No. We simply cannot do that here except in the init case when the
inode is not yet visible to userspace. In which case, we know -for
certain- that the S_DAX is not set, and hence we do not need to
clear it. Initial conditions matter!

If you want to make sure of this, add this:

	ASSERT(!(IS_DAX(inode) && init));

And now we'll catch inodes that incorrectly have S_DAX set at init
time.

> > memory S_DAX flag, we can actually clear the on-disk flag
> > safely, so that next time the inode cycles into memory it won't
> > be using DAX. IOWs, admins can stop the applications, clear the
> > DAX flag and drop caches. This should result in the inode being
> > recycled and when the app is restarted it will run without DAX.
> > No ned for deleting files, copying large data sets, etc just to
> > turn off an inode flag.
> 
> We already discussed evicting the inode and it was determined to
> be too confusing.[*]

That discussion did not even consider how admins are supposed to
clear the inode flag once it is set on disk. It was entirely
focussed around "we can't change in memory S_DAX state" and how the
tri-state mount option to "override" the on-disk flag could be done.

Nobody noticed that being unable to rmeove the on-disk flag means
the admin's only option to turn off dax for an application is to
turn it off for everything, filesystem wide, which requires:

	1. stopping the app.
	2. stopping every other app using the filesystem
	3. unmounting the filesystem
	4. changing to dax=never mount option
	5. mounting the filesystem
	6. restarting all apps.

It's a hard stop for everything using the filesystem, and it changes
the runtime environment for all applications, not just the one that
needs DAX turned off.  Not to mention that if it's the root
filesystem that is using DAX, then it's a full system reboot needed
to change the mount options.

IMO, this is a non-starter from a production point of view - testing
and qualification of all applications rather than just the affected
app is required to make this sort of change.  It simply does not
follow the "minimal change to fix the problem" rules for managing
issues in production environments.

So, pLease explain to me how this process:

	1. stop the app
	2. remove inode flags via xfs_io
	3. run drop_caches
	4. start the app

is worse than requiring admins to unmount the filesystem to turn off
DAX for an application.

> Furthermore, if we did want an interface like that why not allow
> the on-disk flag to be set as well as cleared?

Well, why not - it's why I implemented the flag in the first place!
The only problem we have here is how to safely change the in-memory
DAX state, and that largely has nothing to do with setting/clearing
the on-disk flag....

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
