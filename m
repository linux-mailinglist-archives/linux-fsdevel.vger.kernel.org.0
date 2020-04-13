Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B801A6C9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbgDMTja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 15:39:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:2346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387935AbgDMTj2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:39:28 -0400
IronPort-SDR: SPlWXs2KrMSQxUnM6RnTorVE2e0tU99HnckO1Aw/31ckL/pmC1D3ttqdunzBpaQoof6rnbKwNF
 NMB6Xu8U1hNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 12:39:28 -0700
IronPort-SDR: AtZlCvspS0QhHfNaeA4JpRFkstaWsTU7TlFEOda3Xn0ws7J1kIWaG8dnZOqg7oDZGJPh9Nsewu
 chVjMzIPBUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="245219538"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2020 12:39:28 -0700
Date:   Mon, 13 Apr 2020 12:39:28 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 5/9] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200413193927.GC1649878@iweiny-DESK2.sc.intel.com>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-6-ira.weiny@intel.com>
 <20200413155251.GU6742@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413155251.GU6742@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:52:51AM -0700, Darrick J. Wong wrote:
> On Sun, Apr 12, 2020 at 10:40:42PM -0700, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > xfs_inode_supports_dax() should reflect if the inode can support DAX not
> > that it is enabled for DAX.
> > 
> > Change the use of xfs_inode_supports_dax() to reflect only if the inode
> > and underlying storage support dax.
> > 
> > Add a new function xfs_inode_enable_dax() which reflects if the inode
> > should be enabled for DAX.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from v6:
> > 	Change enable checks to be sequential logic.
> > 	Update for 2 bit tri-state option.
> > 	Make 'static' consistent.
> > 	Don't set S_DAX if !CONFIG_FS_DAX
> > 
> > Changes from v5:
> > 	Update to reflect the new tri-state mount option
> > 
> > Changes from v3:
> > 	Update functions and names to be more clear
> > 	Update commit message
> > 	Merge with
> > 		'fs/xfs: Clean up DAX support check'
> > 		don't allow IS_DAX() on a directory
> > 		use STATIC macro for static
> > 		make xfs_inode_supports_dax() static
> > ---
> >  fs/xfs/xfs_iops.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index 81f2f93caec0..37bd15b55878 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -1244,12 +1244,11 @@ xfs_inode_supports_dax(
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  
> >  	/* Only supported on non-reflinked files. */
> > -	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
> > +	if (xfs_is_reflink_inode(ip))
> >  		return false;
> >  
> > -	/* DAX mount option or DAX iflag must be set. */
> > -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> > -	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> > +	/* Only supported on regular files. */
> > +	if (!S_ISREG(VFS_I(ip)->i_mode))
> >  		return false;
> 
> Why separate the !S_ISREG and the is_reflink_inode checks?
> 
> The part about "Change the use of xfs_inode_supports_dax() to reflect
> only if the inode and underlying storage support dax" would be a lot
> more straightforward if this hunk only removed the DIFLAG2_DAX check.

Yes I could see that.  But for me the separate checks were more clear.  FWIW,
Dave requested a similar pattern for xfs_inode_enable_dax()[*] and I think I
agree with him.

So I'm inclined to keep the checks like this.

Thanks for the reviews!
Ira

[*] https://lore.kernel.org/lkml/20200408000533.GG24067@dread.disaster.area/

> 
> The rest of the patch looks ok.
> 
> --D
> 
> >  
> >  	/* Block size must match page size */
> > @@ -1260,6 +1259,31 @@ xfs_inode_supports_dax(
> >  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
> >  }
> >  
> > +#ifdef CONFIG_FS_DAX
> > +static bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	if (ip->i_mount->m_flags & XFS_MOUNT_NODAX)
> > +		return false;
> > +	if (!xfs_inode_supports_dax(ip))
> > +		return false;
> > +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> > +		return true;
> > +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> > +		return true;
> > +	return false;
> > +}
> > +#else /* !CONFIG_FS_DAX */
> > +static bool
> > +xfs_inode_enable_dax(
> > +	struct xfs_inode *ip)
> > +{
> > +	return false;
> > +}
> > +#endif /* CONFIG_FS_DAX */
> > +
> > +
> >  STATIC void
> >  xfs_diflags_to_iflags(
> >  	struct inode		*inode,
> > @@ -1278,7 +1302,7 @@ xfs_diflags_to_iflags(
> >  		inode->i_flags |= S_SYNC;
> >  	if (flags & XFS_DIFLAG_NOATIME)
> >  		inode->i_flags |= S_NOATIME;
> > -	if (xfs_inode_supports_dax(ip))
> > +	if (xfs_inode_enable_dax(ip))
> >  		inode->i_flags |= S_DAX;
> >  }
> >  
> > -- 
> > 2.25.1
> > 
