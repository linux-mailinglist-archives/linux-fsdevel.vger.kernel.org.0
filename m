Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF317509E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2020 23:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCAWhw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Mar 2020 17:37:52 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:56494 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbgCAWhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Mar 2020 17:37:52 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id F069A3A1D80;
        Mon,  2 Mar 2020 09:37:46 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j8XDV-0004U5-FH; Mon, 02 Mar 2020 09:37:45 +1100
Date:   Mon, 2 Mar 2020 09:37:45 +1100
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
Subject: Re: [PATCH V5 05/12] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200301223745.GE10776@dread.disaster.area>
References: <20200227052442.22524-1-ira.weiny@intel.com>
 <20200227052442.22524-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227052442.22524-6-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=SS2py6AdgQ4A:10
        a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=SBY6GoZAAwZHPrv_PwMA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:24:35PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_inode_supports_dax() should reflect if the inode can support DAX not
> that it is enabled for DAX.
> 
> Change the use of xfs_inode_supports_dax() to reflect only if the inode
> and underlying storage support dax.
> 
> Add a new function xfs_inode_enable_dax() which reflects if the inode
> should be enabled for DAX.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v3:
> 	Update functions and names to be more clear
> 	Update commit message
> 	Merge with
> 		'fs/xfs: Clean up DAX support check'
> 		don't allow IS_DAX() on a directory
> 		use STATIC macro for static
> 		make xfs_inode_supports_dax() static
> ---
>  fs/xfs/xfs_iops.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..ff711efc5247 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1237,19 +1237,18 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
>  };
>  
>  /* Figure out if this file actually supports DAX. */
> -static bool
> +STATIC bool
>  xfs_inode_supports_dax(
>  	struct xfs_inode	*ip)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  
>  	/* Only supported on non-reflinked files. */
> -	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
> +	if (xfs_is_reflink_inode(ip))
>  		return false;
>  
> -	/* DAX mount option or DAX iflag must be set. */
> -	if (!(mp->m_flags & XFS_MOUNT_DAX) &&
> -	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> +	/* Only supported on regular files. */
> +	if (!S_ISREG(VFS_I(ip)->i_mode))
>  		return false;

Why split the initial check? The "non-reflinked files" comment is
pretty explicit, so splitting it just to add a "only support on
regular files" comment doesn't actually add any value here.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
