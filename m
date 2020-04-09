Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 155181A2CBE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 02:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDIAMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 20:12:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:61592 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgDIAMH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:12:07 -0400
IronPort-SDR: ND5DkgcL+z7gVwp3XABxUt63eoTIeZKdnsHqh0FdJ5Vp/E6CxN0XM4YilMarkFcIggPm6Aofzk
 HmZwWPOofR7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 17:12:07 -0700
IronPort-SDR: C0qu+JybDG0QthltkoJTdCtv80Mb6QfdGXNwCVFyt5H3gZHhGU+0LzHSeJ7Zf5tdCc/C6gKDGD
 EghjE+0adNwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,360,1580803200"; 
   d="scan'208";a="240456460"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga007.jf.intel.com with ESMTP; 08 Apr 2020 17:12:07 -0700
Date:   Wed, 8 Apr 2020 17:12:06 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V6 6/8] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200409001206.GD664132@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
 <20200408210236.GK24067@dread.disaster.area>
 <20200408220734.GA664132@iweiny-DESK2.sc.intel.com>
 <20200408232106.GO24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408232106.GO24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:21:06AM +1000, Dave Chinner wrote:
> On Wed, Apr 08, 2020 at 03:07:35PM -0700, Ira Weiny wrote:
> > On Thu, Apr 09, 2020 at 07:02:36AM +1000, Dave Chinner wrote:
> > > On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:
> > 
> > [snip]
> > 
> > > > 
> > > > This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> > > > 
> > > > void
> > > > xfs_diflags_to_iflags(
> > > >         struct xfs_inode        *ip,
> > > >         bool init)
> > > > {
> > > >         struct inode            *inode = VFS_I(ip);
> > > >         unsigned int            xflags = xfs_ip2xflags(ip);
> > > >         unsigned int            flags = 0;
> > > > 
> > > >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
> > > >                             S_DAX);
> > > 
> > > We don't want to clear the dax flag here, ever, if it is already
> > > set. That is an externally visible change and opens us up (again) to
> > > races where IS_DAX() changes half way through a fault path. IOWs, avoiding
> > > clearing the DAX flag was something I did explicitly in the above
> > > code fragment.
> > 
> > <sigh> yes... you are correct.
> > 
> > But I don't like depending on the caller to clear the S_DAX flag if
> > xfs_inode_enable_dax() is false.  IMO this function should clear the flag in
> > that case for consistency...
> 
> No. We simply cannot do that here except in the init case when the
> inode is not yet visible to userspace. In which case, we know -for
> certain- that the S_DAX is not set, and hence we do not need to
> clear it. Initial conditions matter!
> 
> If you want to make sure of this, add this:
> 
> 	ASSERT(!(IS_DAX(inode) && init));
> 
> And now we'll catch inodes that incorrectly have S_DAX set at init
> time.

Ok, that will work.  Also documents that expected initial condition.

> 
> > > memory S_DAX flag, we can actually clear the on-disk flag
> > > safely, so that next time the inode cycles into memory it won't
> > > be using DAX. IOWs, admins can stop the applications, clear the
> > > DAX flag and drop caches. This should result in the inode being
> > > recycled and when the app is restarted it will run without DAX.
> > > No ned for deleting files, copying large data sets, etc just to
> > > turn off an inode flag.
> > 
> > We already discussed evicting the inode and it was determined to
> > be too confusing.[*]
> 
> That discussion did not even consider how admins are supposed to
> clear the inode flag once it is set on disk.

I think this is a bit unfair.  I think we were all considering it...  and I
still think this patch set is a step in the right direction.

> It was entirely
> focussed around "we can't change in memory S_DAX state"

Not true.  There were many ideas on how to change the FS_XFLAG_DAX with some
sort of delayed S_DAX state to avoid changing S_DAX on an in memory inode.

I made the comment:

	"... I want to clarify.  ...  we could have the flag change with an
	appropriate error which could let the user know the change has been
	delayed."

	-- https://lore.kernel.org/lkml/20200402205518.GF3952565@iweiny-DESK2.sc.intel.com/

Jan made multiple comments:

	"I generally like the proposal but I think the fact that toggling
	FS_XFLAG_DAX will not have immediate effect on S_DAX will cause quite
	some confusion and ultimately bug reports."

	-- https://lore.kernel.org/lkml/20200401102511.GC19466@quack2.suse.cz/


	"Just switch FS_XFLAG_DAX flag, S_DAX flag will magically switch when
	inode gets evicted and the inode gets reloaded from the disk again. Did
	I misunderstand anything?

	And my thinking was that this is surprising behavior for the user and
	so it will likely generate lots of bug reports along the lines of "DAX
	inode flag does not work!"."

	-- https://lore.kernel.org/lkml/20200403170338.GD29920@quack2.suse.cz/

Darrick also had similar ideas/comments.

Christoph did say:

	"A reasonably smart application can try to evict itself."

	-- https://lore.kernel.org/lkml/20200403072731.GA24176@lst.de/

Which I was unclear about???

Christoph does this mean you would be ok with changing the FS_XFLAG_DAX on disk
and letting S_DAX change later?

> and how the
> tri-state mount option to "override" the on-disk flag could be done.
> 
> Nobody noticed that being unable to rmeove the on-disk flag means
> the admin's only option to turn off dax for an application is to
> turn it off for everything, filesystem wide, which requires:

No. This is not entirely true.  While I don't like the idea of having to copy
data (and I agree with your points) it is possible to do.

> 
> 	1. stopping the app.
> 	2. stopping every other app using the filesystem
> 	3. unmounting the filesystem
> 	4. changing to dax=never mount option

I don't understand why we need to unmount and mount with dax=never?

> 	5. mounting the filesystem
> 	6. restarting all apps.
> 
> It's a hard stop for everything using the filesystem, and it changes
> the runtime environment for all applications, not just the one that
> needs DAX turned off.  Not to mention that if it's the root
> filesystem that is using DAX, then it's a full system reboot needed
> to change the mount options.
> 
> IMO, this is a non-starter from a production point of view - testing
> and qualification of all applications rather than just the affected
> app is required to make this sort of change.  It simply does not
> follow the "minimal change to fix the problem" rules for managing
> issues in production environments.
> 
> So, pLease explain to me how this process:
> 
> 	1. stop the app
> 	2. remove inode flags via xfs_io
> 	3. run drop_caches
> 	4. start the app
> 
> is worse than requiring admins to unmount the filesystem to turn off
> DAX for an application.

Jan?  Christoph?

> 
> > Furthermore, if we did want an interface like that why not allow
> > the on-disk flag to be set as well as cleared?
> 
> Well, why not - it's why I implemented the flag in the first place!
> The only problem we have here is how to safely change the in-memory
> DAX state, and that largely has nothing to do with setting/clearing
> the on-disk flag....

With the above change to xfs_diflags_to_iflags() I think we are ok here.

Ira

