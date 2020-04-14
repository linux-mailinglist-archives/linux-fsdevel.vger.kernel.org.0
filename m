Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF131A73A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 08:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405996AbgDNG10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 02:27:26 -0400
Received: from verein.lst.de ([213.95.11.211]:37638 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405926AbgDNG1Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:27:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23D05227A81; Tue, 14 Apr 2020 08:27:19 +0200 (CEST)
Date:   Tue, 14 Apr 2020 08:27:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 5/9] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200414062718.GE23154@lst.de>
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-6-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:42PM -0700, ira.weiny@intel.com wrote:
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
> Changes from v6:
> 	Change enable checks to be sequential logic.
> 	Update for 2 bit tri-state option.
> 	Make 'static' consistent.
> 	Don't set S_DAX if !CONFIG_FS_DAX
> 
> Changes from v5:
> 	Update to reflect the new tri-state mount option
> 
> Changes from v3:
> 	Update functions and names to be more clear
> 	Update commit message
> 	Merge with
> 		'fs/xfs: Clean up DAX support check'
> 		don't allow IS_DAX() on a directory
> 		use STATIC macro for static
> 		make xfs_inode_supports_dax() static
> ---
>  fs/xfs/xfs_iops.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..37bd15b55878 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1244,12 +1244,11 @@ xfs_inode_supports_dax(
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

To me it would make sense to check S_ISREG before reflink, as it seems
more logical.

> +#ifdef CONFIG_FS_DAX
> +static bool
> +xfs_inode_enable_dax(
> +	struct xfs_inode *ip)
> +{
> +	if (ip->i_mount->m_flags & XFS_MOUNT_NODAX)
> +		return false;
> +	if (!xfs_inode_supports_dax(ip))
> +		return false;
> +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> +		return true;
> +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> +		return true;
> +	return false;
> +}
> +#else /* !CONFIG_FS_DAX */
> +static bool
> +xfs_inode_enable_dax(
> +	struct xfs_inode *ip)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_FS_DAX */

Just throw in a

	if (!IS_ENABLED(CONFIG_FS_DAX))
		return false;

as the first statement of the full version and avoid the stub entirely?
