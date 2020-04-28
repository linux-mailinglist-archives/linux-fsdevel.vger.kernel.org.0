Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB41BC287
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgD1PQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 11:16:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47240 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgD1PQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:16:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFDCcm148213;
        Tue, 28 Apr 2020 15:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=O47k4FqtONgc99tpMX37EzU2xK327w9XPhEl7zPLLko=;
 b=VeHKX1Pv1fFnBsK8vtRJ/bwbqHH1VsAPsWVwmGyj6oqACQiDm/3xNtPb7z1ahES2gcx3
 /5iyieri+nXYgbiWDjL2jCkXiBfwf3sidu5CBk1JCqofmDkFGuoDyYCB9VKOCK3iBljp
 fVQGq6iFoO3sJa7di2FKjuuq7BgUJiT3UuVxX8EFPXH78p6Yj0SY5OzxxQ8bxdI9MN/t
 ARnapUq0FD4DCLua80vqRbjsxp0r4++Q8kBC8gydeWKbz0+JPPby7h5PzW08al1SYS4a
 7caOoam4/TutRHhxOdOLVBnWePJpkTy5q/BKl44JiqHwVU0pdc1wJartvSbROPUH5EZR vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30p01nq4jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:16:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFC3P1111053;
        Tue, 28 Apr 2020 15:16:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30mxrss470-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:16:45 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SFGhho019188;
        Tue, 28 Apr 2020 15:16:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:16:42 -0700
Date:   Tue, 28 Apr 2020 08:16:39 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-ext4@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        tytso@mit.edu, adilger@dilger.ca, riteshh@linux.ibm.com,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
Message-ID: <20200428151639.GK6741@magnolia>
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427181957.1606257-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:19:55PM +0200, Christoph Hellwig wrote:
> By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
> handled once instead of duplicated, but can still be done under fs locks,
> like xfs/iomap intended with its duplicate handling.  Also make sure the
> error value of filemap_write_and_wait is propagated to user space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems reasonable,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/btrfs/inode.c      |  4 +---
>  fs/cifs/smb2ops.c     |  3 +--
>  fs/ext4/extents.c     |  2 +-
>  fs/f2fs/data.c        |  3 +--
>  fs/ioctl.c            | 10 ++++++----
>  fs/iomap/fiemap.c     |  8 +-------
>  fs/nilfs2/inode.c     |  2 +-
>  fs/ocfs2/extent_map.c |  5 +----
>  fs/overlayfs/inode.c  |  4 ----
>  9 files changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1f1ec361089b3..529ffa5e7b452 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8243,14 +8243,12 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  	return ret;
>  }
>  
> -#define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
> -
>  static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		__u64 start, __u64 len)
>  {
>  	int	ret;
>  
> -	ret = fiemap_prep(inode, fieinfo, start, &len, BTRFS_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 8a2e94931dc96..32880fca6d8d8 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -3408,8 +3408,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>  	int i, num, rc, flags, last_blob;
>  	u64 next;
>  
> -	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len,
> -			FIEMAP_FLAG_SYNC);
> +	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len, 0);
>  	if (rc)
>  		rc;
>  
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 41f73dea92cac..93574e88f6543 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4908,7 +4908,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>  	}
>  
> -	error = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	error = fiemap_prep(inode, fieinfo, start, &len, 0);
>  	if (error)
>  		return error;
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 03faafc591b17..9de7dc476ed16 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1825,8 +1825,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  			return ret;
>  	}
>  
> -	ret = fiemap_prep(inode, fieinfo, start, &len,
> -			FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_XATTR);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 4d94c20c9596b..ae0d228d18a16 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -162,6 +162,7 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  {
>  	u64 maxbytes = inode->i_sb->s_maxbytes;
>  	u32 incompat_flags;
> +	int ret = 0;
>  
>  	if (*len == 0)
>  		return -EINVAL;
> @@ -174,13 +175,17 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	if (*len > maxbytes || (maxbytes - *len) < start)
>  		*len = maxbytes - start;
>  
> +	supported_flags |= FIEMAP_FLAG_SYNC;
>  	supported_flags &= FIEMAP_FLAGS_COMPAT;
>  	incompat_flags = fieinfo->fi_flags & ~supported_flags;
>  	if (incompat_flags) {
>  		fieinfo->fi_flags = incompat_flags;
>  		return -EBADR;
>  	}
> -	return 0;
> +
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
> +		ret = filemap_write_and_wait(inode->i_mapping);
> +	return ret;
>  }
>  EXPORT_SYMBOL(fiemap_prep);
>  
> @@ -209,9 +214,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>  		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
>  		return -EFAULT;
>  
> -	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
> -		filemap_write_and_wait(inode->i_mapping);
> -
>  	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
>  			fiemap.fm_length);
>  	fiemap.fm_flags = fieinfo.fi_flags;
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 5e4e3520424da..fffd9eedfd880 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -75,16 +75,10 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>  	ctx.fi = fi;
>  	ctx.prev.type = IOMAP_HOLE;
>  
> -	ret = fiemap_prep(inode, fi, start, &len, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fi, start, &len, 0);
>  	if (ret)
>  		return ret;
>  
> -	if (fi->fi_flags & FIEMAP_FLAG_SYNC) {
> -		ret = filemap_write_and_wait(inode->i_mapping);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	while (len > 0) {
>  		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
>  				iomap_fiemap_actor);
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 052c2da11e4d7..25b0d368ecdb2 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1006,7 +1006,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	unsigned int blkbits = inode->i_blkbits;
>  	int ret, n;
>  
> -	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 3744179b73fa1..a94852af5510d 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -733,8 +733,6 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>  	return 0;
>  }
>  
> -#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
> -
>  int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		 u64 map_start, u64 map_len)
>  {
> @@ -746,8 +744,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	struct buffer_head *di_bh = NULL;
>  	struct ocfs2_extent_rec rec;
>  
> -	ret = fiemap_prep(inode, fieinfo, map_start, &map_len,
> -			OCFS2_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, map_start, &map_len, 0);
>  	if (ret)
>  		return ret;
>  
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b5fec34105569..c7cb883c47b86 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -462,10 +462,6 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  		return -EOPNOTSUPP;
>  
>  	old_cred = ovl_override_creds(inode->i_sb);
> -
> -	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
> -		filemap_write_and_wait(realinode->i_mapping);
> -
>  	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
>  	revert_creds(old_cred);
>  
> -- 
> 2.26.1
> 
