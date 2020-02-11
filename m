Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93AD1589C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 06:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgBKFrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 00:47:53 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44791 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727594AbgBKFrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:47:53 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8AB503A353F;
        Tue, 11 Feb 2020 16:47:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j1OOi-0005zL-VL; Tue, 11 Feb 2020 16:47:48 +1100
Date:   Tue, 11 Feb 2020 16:47:48 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 03/12] fs/xfs: Separate functionality of
 xfs_inode_supports_dax()
Message-ID: <20200211054748.GF10776@dread.disaster.area>
References: <20200208193445.27421-1-ira.weiny@intel.com>
 <20200208193445.27421-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208193445.27421-4-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=Yrr-Swfh6q8XfX9a3mMA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 08, 2020 at 11:34:36AM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_inode_supports_dax() should reflect if the inode can support DAX not
> that it is enabled for DAX.  Leave that to other helper functions.
> 
> Change the caller of xfs_inode_supports_dax() to call
> xfs_inode_use_dax() which reflects new logic to override the effective
> DAX flag with either the mount option or the physical DAX flag.
> 
> To make the logic clear create 2 helper functions for the mount and
> physical flag.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/xfs/xfs_iops.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..a7db50d923d4 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1236,6 +1236,15 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
>  	.update_time		= xfs_vn_update_time,
>  };
>  
> +static bool
> +xfs_inode_mount_is_dax(
> +	struct xfs_inode *ip)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	return (mp->m_flags & XFS_MOUNT_DAX) == XFS_MOUNT_DAX;
> +}
> +
>  /* Figure out if this file actually supports DAX. */
>  static bool
>  xfs_inode_supports_dax(
> @@ -1247,11 +1256,6 @@ xfs_inode_supports_dax(
>  	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
>  		return false;
>  
> -	/* DAX mount option or DAX iflag must be set. */
> -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> -	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> -		return false;
> -
>  	/* Block size must match page size */
>  	if (mp->m_sb.sb_blocksize != PAGE_SIZE)
>  		return false;
> @@ -1260,6 +1264,22 @@ xfs_inode_supports_dax(
>  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
>  }
>  
> +static bool
> +xfs_inode_is_dax(
> +	struct xfs_inode *ip)
> +{
> +	return (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX) == XFS_DIFLAG2_DAX;
> +}

I don't think these wrappers add any value at all - the naming of
them is entirely confusing, too. e.g. "inode is dax" doesn't tell me
that it is checking the on disk flags - it doesn't tell me how it is
different to IS_DAX, or why I'd use one versus the other. And then
xfs_inode_mount_is_dax() is just... worse.

Naming is hard. :)

> +
> +static bool
> +xfs_inode_use_dax(
> +	struct xfs_inode *ip)
> +{
> +	return xfs_inode_supports_dax(ip) &&
> +		(xfs_inode_mount_is_dax(ip) ||
> +		 xfs_inode_is_dax(ip));
> +}

Urk. Naming - we're not "using dax" here, we are checkign to see if
we should enable DAX on this inode. IOWs:

static bool
xfs_inode_enable_dax(
	struct xfs_inode *ip)
{
	if (!xfs_inode_supports_dax(ip))
		return false;

	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
		return true;
	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
		return true;
	return false;
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
