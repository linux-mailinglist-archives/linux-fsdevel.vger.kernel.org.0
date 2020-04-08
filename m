Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51ABB1A2AC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 23:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgDHVCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 17:02:43 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:44124 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728221AbgDHVCn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:02:43 -0400
Received: from dread.disaster.area (pa49-180-125-11.pa.nsw.optusnet.com.au [49.180.125.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9A6A77EA644;
        Thu,  9 Apr 2020 07:02:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jMHqG-0004mn-Sn; Thu, 09 Apr 2020 07:02:36 +1000
Date:   Thu, 9 Apr 2020 07:02:36 +1000
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
Message-ID: <20200408210236.GK24067@dread.disaster.area>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
 <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=2h+yFbpuifLtD1c++IMymA==:117 a=2h+yFbpuifLtD1c++IMymA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=BZUbvsNFl7CrKh3hfgsA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 10:09:23AM -0700, Ira Weiny wrote:
> On Wed, Apr 08, 2020 at 12:08:27PM +1000, Dave Chinner wrote:
> > On Tue, Apr 07, 2020 at 11:29:56AM -0700, ira.weiny@intel.com wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 
> > >  
> > > -STATIC void
> > > -xfs_diflags_to_linux(
> > > -	struct xfs_inode	*ip)
> > > -{
> > > -	struct inode		*inode = VFS_I(ip);
> > > -	unsigned int		xflags = xfs_ip2xflags(ip);
> > > -
> > > -	if (xflags & FS_XFLAG_IMMUTABLE)
> > > -		inode->i_flags |= S_IMMUTABLE;
> > > -	else
> > > -		inode->i_flags &= ~S_IMMUTABLE;
> > > -	if (xflags & FS_XFLAG_APPEND)
> > > -		inode->i_flags |= S_APPEND;
> > > -	else
> > > -		inode->i_flags &= ~S_APPEND;
> > > -	if (xflags & FS_XFLAG_SYNC)
> > > -		inode->i_flags |= S_SYNC;
> > > -	else
> > > -		inode->i_flags &= ~S_SYNC;
> > > -	if (xflags & FS_XFLAG_NOATIME)
> > > -		inode->i_flags |= S_NOATIME;
> > > -	else
> > > -		inode->i_flags &= ~S_NOATIME;
> > > -#if 0	/* disabled until the flag switching races are sorted out */
> > > -	if (xflags & FS_XFLAG_DAX)
> > > -		inode->i_flags |= S_DAX;
> > > -	else
> > > -		inode->i_flags &= ~S_DAX;
> > > -#endif
> > 
> > So this variant will set the flag in the inode if the disk inode
> > flag is set, otherwise it will clear it.  It does it with if/else
> > branches.
> > 
> > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index e07f7b641226..a4ac8568c8c7 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -1259,7 +1259,7 @@ xfs_inode_supports_dax(
> > >  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
> > >  }
> > >  
> > > -STATIC bool
> > > +static bool
> > >  xfs_inode_enable_dax(
> > >  	struct xfs_inode *ip)
> > >  {
> > 
> > This belongs in the previous patch.
> 
> Ah yea...  Sorry.
> 
> Fixed in V7
> 
> > 
> > > @@ -1272,26 +1272,38 @@ xfs_inode_enable_dax(
> > >  	return false;
> > >  }
> > >  
> > > -STATIC void
> > > +void
> > >  xfs_diflags_to_iflags(
> > > -	struct inode		*inode,
> > > -	struct xfs_inode	*ip)
> > > +	struct xfs_inode	*ip,
> > > +	bool init)
> > >  {
> > > -	uint16_t		flags = ip->i_d.di_flags;
> > > -
> > > -	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
> > > -			    S_NOATIME | S_DAX);
> > 
> > And this code cleared all the flags in the inode first, then
> > set them if the disk inode flag is set. This does not require
> > branches, resulting in more readable code and better code
> > generation.
> > 
> > > +	struct inode		*inode = VFS_I(ip);
> > > +	uint			diflags = xfs_ip2xflags(ip);
> > >  
> > > -	if (flags & XFS_DIFLAG_IMMUTABLE)
> > > +	if (diflags & FS_XFLAG_IMMUTABLE)
> > >  		inode->i_flags |= S_IMMUTABLE;
> > > -	if (flags & XFS_DIFLAG_APPEND)
> > > +	else
> > > +		inode->i_flags &= ~S_IMMUTABLE;
> > 
> > > +	if (diflags & FS_XFLAG_APPEND)
> > >  		inode->i_flags |= S_APPEND;
> > > -	if (flags & XFS_DIFLAG_SYNC)
> > > +	else
> > > +		inode->i_flags &= ~S_APPEND;
> > > +	if (diflags & FS_XFLAG_SYNC)
> > >  		inode->i_flags |= S_SYNC;
> > > -	if (flags & XFS_DIFLAG_NOATIME)
> > > +	else
> > > +		inode->i_flags &= ~S_SYNC;
> > > +	if (diflags & FS_XFLAG_NOATIME)
> > >  		inode->i_flags |= S_NOATIME;
> > > -	if (xfs_inode_enable_dax(ip))
> > > -		inode->i_flags |= S_DAX;
> > > +	else
> > > +		inode->i_flags &= ~S_NOATIME;
> > > +
> > > +	/* Only toggle the dax flag when initializing */
> > > +	if (init) {
> > > +		if (xfs_inode_enable_dax(ip))
> > > +			inode->i_flags |= S_DAX;
> > > +		else
> > > +			inode->i_flags &= ~S_DAX;
> > > +	}
> > >  }
> > 
> > IOWs, this:
> > 
> >         struct inode            *inode = VFS_I(ip);
> >         unsigned int            xflags = xfs_ip2xflags(ip);
> >         unsigned int            flags = 0;
> > 
> >         if (xflags & FS_XFLAG_IMMUTABLE)
> >                 flags |= S_IMMUTABLE;
> >         if (xflags & FS_XFLAG_APPEND)
> >                 flags |= S_APPEND;
> >         if (xflags & FS_XFLAG_SYNC)
> >                 flags |= S_SYNC;
> >         if (xflags & FS_XFLAG_NOATIME)
> >                 flags |= S_NOATIME;
> > 	if ((xflags & FS_XFLAG_DAX) && init)
> > 		flags |= S_DAX;
> > 
> >         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);
> >         inode->i_flags |= flags;
> > 
> > ends up being much easier to read and results in better code
> > generation. And we don't need to clear the S_DAX flag when "init" is
> > set, because we are starting from an inode that has no flags set
> > (because init!)...
> 
> This sounds good but I think we need a slight modification to make the function equivalent in functionality.
> 
> void
> xfs_diflags_to_iflags(
>         struct xfs_inode        *ip,
>         bool init)
> {
>         struct inode            *inode = VFS_I(ip);
>         unsigned int            xflags = xfs_ip2xflags(ip);
>         unsigned int            flags = 0;
> 
>         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
>                             S_DAX);

We don't want to clear the dax flag here, ever, if it is already
set. That is an externally visible change and opens us up (again) to
races where IS_DAX() changes half way through a fault path. IOWs, avoiding
clearing the DAX flag was something I did explicitly in the above
code fragment.

And it makes the logic clearer by pre-calculating the new flags,
then clearing and setting the inode flags together, rather than
having the spearated at the top and bottom of the function.

THis leads to an obvious conclusion: if we never clear the in memory
S_DAX flag, we can actually clear the on-disk flag safely, so that
next time the inode cycles into memory it won't be using DAX. IOWs,
admins can stop the applications, clear the DAX flag and drop
caches. This should result in the inode being recycled and when the
app is restarted it will run without DAX. No ned for deleting files,
copying large data sets, etc just to turn off an inode flag.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
