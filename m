Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF07D1D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfGaXXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:23:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfGaXXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:23:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VMsNjK159636;
        Wed, 31 Jul 2019 23:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hoICPq/B4Rl+u229+Cf3hJipAPf92XT5oZxQEN91dFk=;
 b=OAz0fXJEXjDoXwQa8TEJzG/Axc6VanAbozkS64a0qSWqaFyDOkXsT0tfX3bvWsiPCmCV
 xi3P6a2SzD/7z2Hy68KXLWLBvnqvmnwbVosGCXclgG5xfc65KxjnP07pVJotxVkS5U9h
 3RmMcLHJzxVlD7EaEKav+JulpABF7ZFTNZJFclYuisFPKLwGxhAQfHI0qFOAlwboCZmI
 EZV/R0KuRhe3WpTUojzO4hobosukUkXgfrV7I0VdIwXnPPtBu2+4Uvf5HCZZ7JgQrtWA
 JOfkWdueJFpgir+HEQIIy6UyejvmGK2o5Qc53+GtFKthhX9DkiPJwTtaloowadybGLvx sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1u0caw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:23:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNNKYd081051;
        Wed, 31 Jul 2019 23:23:22 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2u38fbcs9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:23:22 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VNMuRb021253;
        Wed, 31 Jul 2019 23:22:56 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:22:55 -0700
Date:   Wed, 31 Jul 2019 16:22:54 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190731232254.GW1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-9-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-9-cmaiolino@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310230
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310229
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:44PM +0200, Carlos Maiolino wrote:
> Enables the usage of FIEMAP ioctl infrastructure to handle FIBMAP calls.
> From now on, ->bmap() methods can start to be removed from filesystems
> which already provides ->fiemap().
> 
> This adds a new helper - bmap_fiemap() - which is used to fill in the
> fiemap request, call into the underlying filesystem and check the flags
> set in the extent requested.
> 
> Add a new fiemap fill extent callback to handle the in-kernel only
> fiemap_extent structure used for FIBMAP.
> 
> The new FIEMAP_KERNEL_FIBMAP flag, is used to tell the filesystem
> ->fiemap interface, that the call is coming from ioctl_fibmap. The
> addition of this new flag, requires an update to fiemap_check_flags(),
> so it doesn't treat FIBMAP requests as invalid.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> 
> Changelog:
> 
> V4:
> 	- Fix if conditional in bmap()
> 	- Add filesystem-specific modifications
> V3:
> 	- Add FIEMAP_EXTENT_SHARED to the list of invalid extents in
> 	  bmap_fiemap()
> 	- Rename fi_extents_start to fi_cb_data
> 	- Use if conditional instead of ternary operator
> 	- Make fiemap_fill_* callbacks static (which required the
> 	  removal of some macros
> 	- Set FIEMAP_FLAG_SYNC when calling in ->fiemap method from
> 	  fibmap
> 	- Add FIEMAP_KERNEL_FIBMAP flag, to identify the usage of fiemap
> 	  infrastructure for fibmap calls, defined in fs.h so it's not
> 	  exported to userspace.
> 	- Update fiemap_check_flags() to understand FIEMAP_KERNEL_FIBMAP
> 	- Update filesystems supporting both FIBMAP and FIEMAP, which
> 	  need extra checks on FIBMAP calls
> 
> V2:
> 	- Now based on the updated fiemap_extent_info,
> 	- move the fiemap call itself to a new helper
> 
>  fs/ext4/extents.c     |  7 +++-
>  fs/f2fs/data.c        | 10 +++++-
>  fs/gfs2/inode.c       |  6 +++-
>  fs/inode.c            | 81 +++++++++++++++++++++++++++++++++++++++++--
>  fs/ioctl.c            | 40 ++++++++++++++-------
>  fs/iomap.c            |  2 +-
>  fs/ocfs2/extent_map.c |  8 ++++-
>  fs/xfs/xfs_iops.c     |  5 +++
>  include/linux/fs.h    |  4 +++
>  9 files changed, 144 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 436e564ebdd6..093b6a07067f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5001,7 +5001,9 @@ static int ext4_find_delayed_extent(struct inode *inode,
>  	return next_del;
>  }
>  /* fiemap flags we can handle specified here */
> -#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC|FIEMAP_FLAG_XATTR)
> +#define EXT4_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC | \
> +				 FIEMAP_FLAG_XATTR| \
> +				 FIEMAP_KERNEL_FIBMAP)
>  
>  static int ext4_xattr_fiemap(struct inode *inode,
>  				struct fiemap_extent_info *fieinfo)
> @@ -5048,6 +5050,9 @@ int ext4_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	if (ext4_has_inline_data(inode)) {
>  		int has_inline = 1;
>  
> +		if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> +			return -EINVAL;

Wouldn't the inline data case be caught by fiemap_bmap and turned into
-EINVAL?

> +
>  		error = ext4_inline_data_fiemap(inode, fieinfo, &has_inline,
>  						start, len);
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 2979ca40d192..29b6c48fb6cc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1409,6 +1409,9 @@ static int f2fs_xattr_fiemap(struct inode *inode,
>  	return (err < 0 ? err : 0);
>  }
>  
> +#define F2FS_FIEMAP_COMPAT	(FIEMAP_FLAG_SYNC | \
> +				 FIEMAP_FLAG_XATTR| \
> +				 FIEMAP_KERNEL_FIBMAP)
>  int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
>  	u64 start = fieinfo->fi_start;
> @@ -1426,7 +1429,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  			return ret;
>  	}
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
> +	ret = fiemap_check_flags(fieinfo, F2FS_FIEMAP_COMPAT);
>  	if (ret)
>  		return ret;
>  
> @@ -1438,6 +1441,11 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	}
>  
>  	if (f2fs_has_inline_data(inode)) {
> +
> +		ret = -EINVAL;
> +		if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> +			goto out;
> +
>  		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
>  		if (ret != -EAGAIN)
>  			goto out;
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index df31bd8ecf6f..30554b4f49c3 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -2016,7 +2016,11 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	if (ret)
>  		goto out;
>  
> -	ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
> +	if (gfs2_is_stuffed(ip) &&
> +	    (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP))
> +		ret = -EINVAL;
> +	else
> +		ret = iomap_fiemap(inode, fieinfo, &gfs2_iomap_ops);
>  
>  	gfs2_glock_dq_uninit(&gh);
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 824fa54d393d..02552b09e77f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1575,6 +1575,78 @@ void iput(struct inode *inode)
>  }
>  EXPORT_SYMBOL(iput);
>  
> +static int fiemap_fill_kernel_extent(struct fiemap_extent_info *fieinfo,
> +			u64 logical, u64 phys, u64 len, u32 flags)
> +{
> +	struct fiemap_extent *extent = fieinfo->fi_cb_data;
> +
> +	/* only count the extents */
> +	if (fieinfo->fi_cb_data == 0) {
> +		fieinfo->fi_extents_mapped++;
> +		goto out;
> +	}
> +
> +	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
> +		return 1;
> +
> +	if (flags & FIEMAP_EXTENT_DELALLOC)
> +		flags |= FIEMAP_EXTENT_UNKNOWN;
> +	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
> +		flags |= FIEMAP_EXTENT_ENCODED;
> +	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
> +		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
> +
> +	extent->fe_logical = logical;
> +	extent->fe_physical = phys;
> +	extent->fe_length = len;
> +	extent->fe_flags = flags;
> +
> +	fieinfo->fi_extents_mapped++;
> +
> +	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
> +		return 1;
> +
> +out:
> +	if (flags & FIEMAP_EXTENT_LAST)
> +		return 1;
> +	return 0;
> +}
> +
> +static int bmap_fiemap(struct inode *inode, sector_t *block)
> +{
> +	struct fiemap_extent_info fieinfo = { 0, };
> +	struct fiemap_extent fextent;
> +	u64 start = *block << inode->i_blkbits;
> +	int error = -EINVAL;
> +
> +	fextent.fe_logical = 0;
> +	fextent.fe_physical = 0;
> +	fieinfo.fi_extents_max = 1;
> +	fieinfo.fi_extents_mapped = 0;
> +	fieinfo.fi_cb_data = &fextent;
> +	fieinfo.fi_start = start;
> +	fieinfo.fi_len = 1 << inode->i_blkbits;
> +	fieinfo.fi_cb = fiemap_fill_kernel_extent;
> +	fieinfo.fi_flags = (FIEMAP_KERNEL_FIBMAP | FIEMAP_FLAG_SYNC);
> +
> +	error = inode->i_op->fiemap(inode, &fieinfo);
> +
> +	if (error)
> +		return error;
> +
> +	if (fieinfo.fi_flags & (FIEMAP_EXTENT_UNKNOWN |
> +				FIEMAP_EXTENT_ENCODED |
> +				FIEMAP_EXTENT_DATA_INLINE |
> +				FIEMAP_EXTENT_UNWRITTEN |
> +				FIEMAP_EXTENT_SHARED))
> +		return -EINVAL;
> +
> +	*block = (fextent.fe_physical +
> +		  (start - fextent.fe_logical)) >> inode->i_blkbits;
> +
> +	return error;
> +}
> +
>  /**
>   *	bmap	- find a block number in a file
>   *	@inode:  inode owning the block number being requested
> @@ -1591,10 +1663,15 @@ EXPORT_SYMBOL(iput);
>   */
>  int bmap(struct inode *inode, sector_t *block)
>  {
> -	if (!inode->i_mapping->a_ops->bmap)
> +	if (inode->i_op->fiemap)
> +		return bmap_fiemap(inode, block);
> +
> +	if (inode->i_mapping->a_ops->bmap)
> +		*block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
> +						       *block);
> +	else
>  		return -EINVAL;
>  
> -	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
>  	return 0;
>  }
>  EXPORT_SYMBOL(bmap);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index d72696c222de..0759ac6e4c7e 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -77,11 +77,8 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	return error;
>  }
>  
> -#define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
> -#define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
> -#define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
> -int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> -			    u64 phys, u64 len, u32 flags)
> +static int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo,
> +			u64 logical, u64 phys, u64 len, u32 flags)
>  {
>  	struct fiemap_extent extent;
>  	struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
> @@ -89,17 +86,17 @@ int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  	/* only count the extents */
>  	if (fieinfo->fi_extents_max == 0) {
>  		fieinfo->fi_extents_mapped++;
> -		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
> +		goto out;
>  	}
>  
>  	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
>  		return 1;
>  
> -	if (flags & SET_UNKNOWN_FLAGS)
> +	if (flags & FIEMAP_EXTENT_DELALLOC)
>  		flags |= FIEMAP_EXTENT_UNKNOWN;
> -	if (flags & SET_NO_UNMOUNTED_IO_FLAGS)
> +	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
>  		flags |= FIEMAP_EXTENT_ENCODED;
> -	if (flags & SET_NOT_ALIGNED_FLAGS)

It's too bad that we lose the "not aligned" semantic meaning here.

> +	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
>  		flags |= FIEMAP_EXTENT_NOT_ALIGNED;

Why doesn't this function just call fiemap_fill_kernel_extent to fill
out the onstack @extent structure?  We've now implemented "fill out out
a struct fiemap_extent" twice.

>  
>  	memset(&extent, 0, sizeof(extent));
> @@ -115,7 +112,11 @@ int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  	fieinfo->fi_extents_mapped++;
>  	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
>  		return 1;
> -	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
> +
> +out:
> +	if (flags & FIEMAP_EXTENT_LAST)
> +		return 1;
> +	return 0;
>  }
>  
>  /**
> @@ -151,13 +152,23 @@ EXPORT_SYMBOL(fiemap_fill_next_extent);
>   * flags, the invalid values will be written into the fieinfo structure, and
>   * -EBADR is returned, which tells ioctl_fiemap() to return those values to
>   * userspace. For this reason, a return code of -EBADR should be preserved.
> + * In case ->fiemap is being used for FIBMAP calls, and the filesystem does not
> + * support it, return -EINVAL.
>   *
> - * Returns 0 on success, -EBADR on bad flags.
> + * Returns 0 on success, -EBADR on bad flags, -EINVAL for an unsupported FIBMAP
> + * request.
>   */
>  int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
>  {
>  	u32 incompat_flags;
>  
> +	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP) {
> +		if (fs_flags & FIEMAP_KERNEL_FIBMAP)
> +			return 0;
> +
> +		return -EINVAL;
> +	}
> +
>  	incompat_flags = fieinfo->fi_flags & ~(FIEMAP_FLAGS_COMPAT & fs_flags);
>  	if (incompat_flags) {
>  		fieinfo->fi_flags = incompat_flags;
> @@ -208,6 +219,10 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
>  	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>  		return -EINVAL;
>  
> +	/* Userspace has no access to this flag */
> +	if (fiemap.fm_flags & FIEMAP_KERNEL_FIBMAP)
> +		return -EINVAL;
> +
>  	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
>  				    &len);
>  	if (error)
> @@ -318,7 +333,8 @@ int __generic_block_fiemap(struct inode *inode,
>  	bool past_eof = false, whole_file = false;
>  	int ret = 0;
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_check_flags(fieinfo,
> +				 FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index b1e88722e10b..2b182abd18e8 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1195,7 +1195,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  	ctx.fi = fi;
>  	ctx.prev.type = IOMAP_HOLE;
>  
> -	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index e01fd38ea935..2884395f3972 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -747,7 +747,7 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  	return 0;
>  }
>  
> -#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
> +#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC | FIEMAP_KERNEL_FIBMAP)
>  
>  int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  {
> @@ -756,6 +756,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	unsigned int hole_size;
>  	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
>  	u64 len_bytes, phys_bytes, virt_bytes;
> +
>  	struct buffer_head *di_bh = NULL;
>  	struct ocfs2_extent_rec rec;
>  	u64 map_start = fieinfo->fi_start;
> @@ -765,6 +766,11 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo)
>  	if (ret)
>  		return ret;
>  
> +	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP) {
> +		if (ocfs2_is_refcount_inode(inode))
> +			return -EINVAL;
> +	}
> +
>  	ret = ocfs2_inode_lock(inode, &di_bh, 0);
>  	if (ret) {
>  		mlog_errno(ret);
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b485190b7ecd..18a798e9076b 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1113,6 +1113,11 @@ xfs_vn_fiemap(
>  	struct fiemap_extent_info *fieinfo)
>  {
>  	int	error;
> +	struct	xfs_inode	*ip = XFS_I(inode);

Would you mind fixing the indentation to match usual xfs style?

> +
> +	if (fieinfo->fi_flags & FIEMAP_KERNEL_FIBMAP)
> +		if (xfs_is_reflink_inode(ip) || XFS_IS_REALTIME_INODE(ip))
> +			return -EINVAL;

The xfs part looks ok to me.

--D

>  
>  	xfs_ilock(XFS_I(inode), XFS_IOLOCK_SHARED);
>  	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a8bd3c4f6d86..233e12ccb6d3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1709,6 +1709,10 @@ extern bool may_open_dev(const struct path *path);
>  typedef int (*fiemap_fill_cb)(struct fiemap_extent_info *fieinfo, u64 logical,
>  			      u64 phys, u64 len, u32 flags);
>  
> +#define FIEMAP_KERNEL_FIBMAP 0x10000000		/* FIBMAP call through FIEMAP
> +						   interface. This is a kernel
> +						   only flag */
> +
>  struct fiemap_extent_info {
>  	unsigned int	fi_flags;		/* Flags as passed from user */
>  	u64		fi_start;
> -- 
> 2.20.1
> 
