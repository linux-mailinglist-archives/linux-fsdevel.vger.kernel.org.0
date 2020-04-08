Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867561A27B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgDHRJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 13:09:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:50387 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgDHRJY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:09:24 -0400
IronPort-SDR: U5mznCRFcfPbM/uKWSi0ZLOzktDhS9K8jNQyxmSk1o3q9eQJDMdC5CdPUGr29bA5GbLcrhXt1z
 /Vr+yMkNxuNw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 10:09:24 -0700
IronPort-SDR: YzStcBYNyg4rM2NCqyMoWrdbPIx41Hz7AvtD2FHxf/oLSnxNIkoE7Lh+X2uMhDlywMDPL9gAGi
 LVNM72pCv2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="297289595"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2020 10:09:24 -0700
Date:   Wed, 8 Apr 2020 10:09:23 -0700
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
Message-ID: <20200408170923.GC569068@iweiny-DESK2.sc.intel.com>
References: <20200407182958.568475-1-ira.weiny@intel.com>
 <20200407182958.568475-7-ira.weiny@intel.com>
 <20200408020827.GI24067@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408020827.GI24067@dread.disaster.area>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 08, 2020 at 12:08:27PM +1000, Dave Chinner wrote:
> On Tue, Apr 07, 2020 at 11:29:56AM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>

[snip]

> >  
> > -STATIC void
> > -xfs_diflags_to_linux(
> > -	struct xfs_inode	*ip)
> > -{
> > -	struct inode		*inode = VFS_I(ip);
> > -	unsigned int		xflags = xfs_ip2xflags(ip);
> > -
> > -	if (xflags & FS_XFLAG_IMMUTABLE)
> > -		inode->i_flags |= S_IMMUTABLE;
> > -	else
> > -		inode->i_flags &= ~S_IMMUTABLE;
> > -	if (xflags & FS_XFLAG_APPEND)
> > -		inode->i_flags |= S_APPEND;
> > -	else
> > -		inode->i_flags &= ~S_APPEND;
> > -	if (xflags & FS_XFLAG_SYNC)
> > -		inode->i_flags |= S_SYNC;
> > -	else
> > -		inode->i_flags &= ~S_SYNC;
> > -	if (xflags & FS_XFLAG_NOATIME)
> > -		inode->i_flags |= S_NOATIME;
> > -	else
> > -		inode->i_flags &= ~S_NOATIME;
> > -#if 0	/* disabled until the flag switching races are sorted out */
> > -	if (xflags & FS_XFLAG_DAX)
> > -		inode->i_flags |= S_DAX;
> > -	else
> > -		inode->i_flags &= ~S_DAX;
> > -#endif
> 
> So this variant will set the flag in the inode if the disk inode
> flag is set, otherwise it will clear it.  It does it with if/else
> branches.
> 
> 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index e07f7b641226..a4ac8568c8c7 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1259,7 +1259,7 @@ xfs_inode_supports_dax(
> >  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
> >  }
> >  
> > -STATIC bool
> > +static bool
> >  xfs_inode_enable_dax(
> >  	struct xfs_inode *ip)
> >  {
> 
> This belongs in the previous patch.

Ah yea...  Sorry.

Fixed in V7

> 
> > @@ -1272,26 +1272,38 @@ xfs_inode_enable_dax(
> >  	return false;
> >  }
> >  
> > -STATIC void
> > +void
> >  xfs_diflags_to_iflags(
> > -	struct inode		*inode,
> > -	struct xfs_inode	*ip)
> > +	struct xfs_inode	*ip,
> > +	bool init)
> >  {
> > -	uint16_t		flags = ip->i_d.di_flags;
> > -
> > -	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
> > -			    S_NOATIME | S_DAX);
> 
> And this code cleared all the flags in the inode first, then
> set them if the disk inode flag is set. This does not require
> branches, resulting in more readable code and better code
> generation.
> 
> > +	struct inode		*inode = VFS_I(ip);
> > +	uint			diflags = xfs_ip2xflags(ip);
> >  
> > -	if (flags & XFS_DIFLAG_IMMUTABLE)
> > +	if (diflags & FS_XFLAG_IMMUTABLE)
> >  		inode->i_flags |= S_IMMUTABLE;
> > -	if (flags & XFS_DIFLAG_APPEND)
> > +	else
> > +		inode->i_flags &= ~S_IMMUTABLE;
> 
> > +	if (diflags & FS_XFLAG_APPEND)
> >  		inode->i_flags |= S_APPEND;
> > -	if (flags & XFS_DIFLAG_SYNC)
> > +	else
> > +		inode->i_flags &= ~S_APPEND;
> > +	if (diflags & FS_XFLAG_SYNC)
> >  		inode->i_flags |= S_SYNC;
> > -	if (flags & XFS_DIFLAG_NOATIME)
> > +	else
> > +		inode->i_flags &= ~S_SYNC;
> > +	if (diflags & FS_XFLAG_NOATIME)
> >  		inode->i_flags |= S_NOATIME;
> > -	if (xfs_inode_enable_dax(ip))
> > -		inode->i_flags |= S_DAX;
> > +	else
> > +		inode->i_flags &= ~S_NOATIME;
> > +
> > +	/* Only toggle the dax flag when initializing */
> > +	if (init) {
> > +		if (xfs_inode_enable_dax(ip))
> > +			inode->i_flags |= S_DAX;
> > +		else
> > +			inode->i_flags &= ~S_DAX;
> > +	}
> >  }
> 
> IOWs, this:
> 
>         struct inode            *inode = VFS_I(ip);
>         unsigned int            xflags = xfs_ip2xflags(ip);
>         unsigned int            flags = 0;
> 
>         if (xflags & FS_XFLAG_IMMUTABLE)
>                 flags |= S_IMMUTABLE;
>         if (xflags & FS_XFLAG_APPEND)
>                 flags |= S_APPEND;
>         if (xflags & FS_XFLAG_SYNC)
>                 flags |= S_SYNC;
>         if (xflags & FS_XFLAG_NOATIME)
>                 flags |= S_NOATIME;
> 	if ((xflags & FS_XFLAG_DAX) && init)
> 		flags |= S_DAX;
> 
>         inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);
>         inode->i_flags |= flags;
> 
> ends up being much easier to read and results in better code
> generation. And we don't need to clear the S_DAX flag when "init" is
> set, because we are starting from an inode that has no flags set
> (because init!)...

This sounds good but I think we need a slight modification to make the function equivalent in functionality.

void
xfs_diflags_to_iflags(
        struct xfs_inode        *ip,
        bool init)
{
        struct inode            *inode = VFS_I(ip);
        unsigned int            xflags = xfs_ip2xflags(ip);
        unsigned int            flags = 0;

        inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME |
                            S_DAX);

        if (xflags & FS_XFLAG_IMMUTABLE)
                flags |= S_IMMUTABLE;
        if (xflags & FS_XFLAG_APPEND)
                flags |= S_APPEND;
        if (xflags & FS_XFLAG_SYNC)
                flags |= S_SYNC;
        if (xflags & FS_XFLAG_NOATIME)
                flags |= S_NOATIME;
        if (init && xfs_inode_enable_dax(ip))
                flags |= S_DAX;

        inode->i_flags |= flags;
}

I've queued this for v7.

Thanks,
Ira

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
