Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1681E26E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgEZQZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 12:25:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36238 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZQZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 12:25:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QGHm0u075607;
        Tue, 26 May 2020 16:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=76aLELeLO0JWPuhqb4dEFdJMwX5Q75x/l2EgC5/0hdo=;
 b=X0ZC2RT1Eqt+ztzZbx5OnH3vmpFXc097w2UsGhiTZUKVr1lpfeLhN/ZD5bOx9Rfa1Vv8
 vCsvkcTG+yJlPlcK22V30cQwJB92caZvbQEr/pYWcvlwSfl7PgxeFA2tc+CTxOV1WeMl
 5lo8IhO0lUCEiCj2GbXqNwk/1UZWDBde+DPAs6UXj+Nvocmvo9/C6bRx8iDMTOgjTZOn
 kLPSbBNVuiWZw1cEjTfUlDJGBwHYbtTIYq3f+RIUmKkFwCnMKUupgDfv5PoAQEqqqPKV
 egaMnLuAArdWEm5hLRB8mEMfbSg71tyjHatsgDmJmeHmu17xh+WdTwKjB3+3S8m/VwUS fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 318xbjtwfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 16:25:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QGMpGa196255;
        Tue, 26 May 2020 16:25:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 317drxrj82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 16:25:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04QGPDiF031427;
        Tue, 26 May 2020 16:25:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 09:25:13 -0700
Date:   Tue, 26 May 2020 09:25:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 6/9] fs: move fiemap range validation into the file
 systems instances
Message-ID: <20200526162512.GA8204@magnolia>
References: <20200523073016.2944131-1-hch@lst.de>
 <20200523073016.2944131-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523073016.2944131-7-hch@lst.de>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=2 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=2 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005260126
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 23, 2020 at 09:30:13AM +0200, Christoph Hellwig wrote:
> Replace fiemap_check_flags with a fiemap_prep helper that also takes the
> inode and mapped range, and performs the sanity check and truncation
> previously done in fiemap_check_range.  This way the validation is inside
> the file system itself and thus properly works for the stacked overlayfs
> case as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Still looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  Documentation/filesystems/fiemap.txt | 12 +++---
>  fs/btrfs/inode.c                     |  2 +-
>  fs/cifs/smb2ops.c                    |  6 ++-
>  fs/ext4/extents.c                    |  5 ++-
>  fs/f2fs/data.c                       |  3 +-
>  fs/ioctl.c                           | 63 +++++++++++-----------------
>  fs/iomap/fiemap.c                    |  2 +-
>  fs/nilfs2/inode.c                    |  2 +-
>  fs/ocfs2/extent_map.c                |  3 +-
>  include/linux/fiemap.h               |  3 +-
>  10 files changed, 47 insertions(+), 54 deletions(-)
> 
> diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
> index ac87e6fda842b..35c8571eccb6e 100644
> --- a/Documentation/filesystems/fiemap.txt
> +++ b/Documentation/filesystems/fiemap.txt
> @@ -203,16 +203,18 @@ EINTR once fatal signal received.
>  
>  
>  Flag checking should be done at the beginning of the ->fiemap callback via the
> -fiemap_check_flags() helper:
> +fiemap_prep() helper:
>  
> -int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
> +int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		u64 start, u64 *len, u32 supported_flags);
>  
>  The struct fieinfo should be passed in as received from ioctl_fiemap(). The
>  set of fiemap flags which the fs understands should be passed via fs_flags. If
> -fiemap_check_flags finds invalid user flags, it will place the bad values in
> +fiemap_prep finds invalid user flags, it will place the bad values in
>  fieinfo->fi_flags and return -EBADR. If the file system gets -EBADR, from
> -fiemap_check_flags(), it should immediately exit, returning that error back to
> -ioctl_fiemap().
> +fiemap_prep(), it should immediately exit, returning that error back to
> +ioctl_fiemap().  Additionally the range is validate against the supported
> +maximum file size.
>  
>  
>  For each extent in the request range, the file system should call
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 320d1062068d3..1f1ec361089b3 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8250,7 +8250,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  {
>  	int	ret;
>  
> -	ret = fiemap_check_flags(fieinfo, BTRFS_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, BTRFS_FIEMAP_FLAGS);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 09047f1ddfb66..828e53e795c6d 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -3408,8 +3408,10 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>  	int i, num, rc, flags, last_blob;
>  	u64 next;
>  
> -	if (fiemap_check_flags(fei, FIEMAP_FLAG_SYNC))
> -		return -EBADR;
> +	rc = fiemap_prep(d_inode(cfile->dentry), fei, start, &len,
> +			FIEMAP_FLAG_SYNC);
> +	if (rc)
> +		return rc;
>  
>  	xid = get_xid();
>   again:
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a41ae7c510170..41f73dea92cac 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4908,8 +4908,9 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>  	}
>  
> -	if (fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC))
> -		return -EBADR;
> +	error = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	if (error)
> +		return error;
>  
>  	error = ext4_fiemap_check_ranges(inode, start, &len);
>  	if (error)
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 25abbbb65ba09..03faafc591b17 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1825,7 +1825,8 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return ret;
>  	}
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
> +	ret = fiemap_prep(inode, fieinfo, start, &len,
> +			FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 3f300cc07dee4..56bbf02209aef 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -149,61 +149,50 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  EXPORT_SYMBOL(fiemap_fill_next_extent);
>  
>  /**
> - * fiemap_check_flags - check validity of requested flags for fiemap
> + * fiemap_prep - check validity of requested flags for fiemap
> + * @inode:	Inode to operate on
>   * @fieinfo:	Fiemap context passed into ->fiemap
> - * @fs_flags:	Set of fiemap flags that the file system understands
> + * @start:	Start of the mapped range
> + * @len:	Length of the mapped range, can be truncated by this function.
> + * @supported_flags:	Set of fiemap flags that the file system understands
>   *
> - * Called from file system ->fiemap callback. This will compute the
> - * intersection of valid fiemap flags and those that the fs supports. That
> - * value is then compared against the user supplied flags. In case of bad user
> - * flags, the invalid values will be written into the fieinfo structure, and
> - * -EBADR is returned, which tells ioctl_fiemap() to return those values to
> - * userspace. For this reason, a return code of -EBADR should be preserved.
> + * This function must be called from each ->fiemap instance to validate the
> + * fiemap request against the file system parameters.
>   *
> - * Returns 0 on success, -EBADR on bad flags.
> + * Returns 0 on success, or a negative error on failure.
>   */
> -int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags)
> +int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		u64 start, u64 *len, u32 supported_flags)
>  {
> +	u64 maxbytes = inode->i_sb->s_maxbytes;
>  	u32 incompat_flags;
>  
> -	incompat_flags = fieinfo->fi_flags & ~(FIEMAP_FLAGS_COMPAT & fs_flags);
> -	if (incompat_flags) {
> -		fieinfo->fi_flags = incompat_flags;
> -		return -EBADR;
> -	}
> -	return 0;
> -}
> -EXPORT_SYMBOL(fiemap_check_flags);
> -
> -static int fiemap_check_ranges(struct super_block *sb,
> -			       u64 start, u64 len, u64 *new_len)
> -{
> -	u64 maxbytes = (u64) sb->s_maxbytes;
> -
> -	*new_len = len;
> -
> -	if (len == 0)
> +	if (*len == 0)
>  		return -EINVAL;
> -
>  	if (start > maxbytes)
>  		return -EFBIG;
>  
>  	/*
>  	 * Shrink request scope to what the fs can actually handle.
>  	 */
> -	if (len > maxbytes || (maxbytes - len) < start)
> -		*new_len = maxbytes - start;
> +	if (*len > maxbytes || (maxbytes - *len) < start)
> +		*len = maxbytes - start;
>  
> +	supported_flags &= FIEMAP_FLAGS_COMPAT;
> +	incompat_flags = fieinfo->fi_flags & ~supported_flags;
> +	if (incompat_flags) {
> +		fieinfo->fi_flags = incompat_flags;
> +		return -EBADR;
> +	}
>  	return 0;
>  }
> +EXPORT_SYMBOL(fiemap_prep);
>  
>  static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  {
>  	struct fiemap fiemap;
>  	struct fiemap_extent_info fieinfo = { 0, };
>  	struct inode *inode = file_inode(filp);
> -	struct super_block *sb = inode->i_sb;
> -	u64 len;
>  	int error;
>  
>  	if (!inode->i_op->fiemap)
> @@ -215,11 +204,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
>  		return -EINVAL;
>  
> -	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
> -				    &len);
> -	if (error)
> -		return error;
> -
>  	fieinfo.fi_flags = fiemap.fm_flags;
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
>  	fieinfo.fi_extents_start = ufiemap->fm_extents;
> @@ -232,7 +216,8 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
>  		filemap_write_and_wait(inode->i_mapping);
>  
> -	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start, len);
> +	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
> +			fiemap.fm_length);
>  	fiemap.fm_flags = fieinfo.fi_flags;
>  	fiemap.fm_mapped_extents = fieinfo.fi_extents_mapped;
>  	if (copy_to_user(ufiemap, &fiemap, sizeof(fiemap)))
> @@ -320,7 +305,7 @@ static int __generic_block_fiemap(struct inode *inode,
>  	bool past_eof = false, whole_file = false;
>  	int ret = 0;
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 449705575acf9..89dca4a97e4a2 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -75,7 +75,7 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  	ctx.fi = fi;
>  	ctx.prev.type = IOMAP_HOLE;
>  
> -	ret = fiemap_check_flags(fi, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fi, start, &len, FIEMAP_FLAG_SYNC);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 6e1aca38931f3..052c2da11e4d7 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1006,7 +1006,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	unsigned int blkbits = inode->i_blkbits;
>  	int ret, n;
>  
> -	ret = fiemap_check_flags(fieinfo, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index e3e2d1b2af51a..3744179b73fa1 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -746,7 +746,8 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	struct buffer_head *di_bh = NULL;
>  	struct ocfs2_extent_rec rec;
>  
> -	ret = fiemap_check_flags(fieinfo, OCFS2_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, map_start, &map_len,
> +			OCFS2_FIEMAP_FLAGS);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/fiemap.h b/include/linux/fiemap.h
> index 240d4f7d9116a..4e624c4665837 100644
> --- a/include/linux/fiemap.h
> +++ b/include/linux/fiemap.h
> @@ -13,9 +13,10 @@ struct fiemap_extent_info {
>  							fiemap_extent array */
>  };
>  
> +int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
> +		u64 start, u64 *len, u32 supported_flags);
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
> -int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
>  
>  int generic_block_fiemap(struct inode *inode,
>  		struct fiemap_extent_info *fieinfo, u64 start, u64 len,
> -- 
> 2.26.2
> 
