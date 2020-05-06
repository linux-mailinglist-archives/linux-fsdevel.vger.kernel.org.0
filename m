Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C51E1C66AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 06:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEFESQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 00:18:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgEFESP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 00:18:15 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04642cHq055004;
        Wed, 6 May 2020 00:18:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8sqysjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 00:18:06 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04643hkn057461;
        Wed, 6 May 2020 00:18:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30u8sqysj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 00:18:05 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04645Cgt022755;
        Wed, 6 May 2020 04:18:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 30s0g63c43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 04:18:02 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0464Gorg52822302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 04:16:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9753BA4040;
        Wed,  6 May 2020 04:18:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41AB7A405B;
        Wed,  6 May 2020 04:17:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.89.50])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 04:17:56 +0000 (GMT)
Subject: Re: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20200505154324.3226743-1-hch@lst.de>
 <20200505154324.3226743-10-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 6 May 2020 09:47:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200505154324.3226743-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200506041757.41AB7A405B@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_11:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060026
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/5/20 9:13 PM, Christoph Hellwig wrote:
> By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
> handled once instead of duplicated, but can still be done under fs locks,
> like xfs/iomap intended with its duplicate handling.  Also make sure the
> error value of filemap_write_and_wait is propagated to user space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

LGTM, please feel free to add:
Reviewed-by: Ritesh  Harjani <riteshh@linux.ibm.com>


> ---
>   fs/btrfs/inode.c      |  4 +---
>   fs/cifs/smb2ops.c     |  3 +--
>   fs/ext4/extents.c     |  2 +-
>   fs/ext4/ioctl.c       |  3 ---
>   fs/f2fs/data.c        |  3 +--
>   fs/ioctl.c            | 10 ++++++----
>   fs/iomap/fiemap.c     |  8 +-------
>   fs/nilfs2/inode.c     |  2 +-
>   fs/ocfs2/extent_map.c |  5 +----
>   fs/overlayfs/inode.c  |  4 ----
>   10 files changed, 13 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 1f1ec361089b3..529ffa5e7b452 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8243,14 +8243,12 @@ static ssize_t btrfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>   	return ret;
>   }
>   
> -#define BTRFS_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
> -
>   static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		__u64 start, __u64 len)
>   {
>   	int	ret;
>   
> -	ret = fiemap_prep(inode, fieinfo, start, &len, BTRFS_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 828e53e795c6d..300ade2acc41e 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -3408,8 +3408,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>   	int i, num, rc, flags, last_blob;
>   	u64 next;
>   
> -	rc = fiemap_prep(d_inode(cfile->dentry), fei, start, &len,
> -			FIEMAP_FLAG_SYNC);
> +	rc = fiemap_prep(d_inode(cfile->dentry), fei, start, &len, 0);
>   	if (rc)
>   		return rc;
>   
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 41f73dea92cac..93574e88f6543 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4908,7 +4908,7 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		fieinfo->fi_flags &= ~FIEMAP_FLAG_CACHE;
>   	}
>   
> -	error = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	error = fiemap_prep(inode, fieinfo, start, &len, 0);
>   	if (error)
>   		return error;
>   
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 0746532ba463d..f81acbbb1b12e 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -759,9 +759,6 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
>   		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
>   		return -EFAULT;
>   
> -	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
> -		filemap_write_and_wait(inode->i_mapping);
> -
>   	error = ext4_get_es_cache(inode, &fieinfo, fiemap.fm_start,
>   			fiemap.fm_length);
>   	fiemap.fm_flags = fieinfo.fi_flags;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 03faafc591b17..9de7dc476ed16 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1825,8 +1825,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   			return ret;
>   	}
>   
> -	ret = fiemap_prep(inode, fieinfo, start, &len,
> -			FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_XATTR);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 56bbf02209aef..b16e962340db6 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -166,6 +166,7 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   {
>   	u64 maxbytes = inode->i_sb->s_maxbytes;
>   	u32 incompat_flags;
> +	int ret = 0;
>   
>   	if (*len == 0)
>   		return -EINVAL;
> @@ -178,13 +179,17 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	if (*len > maxbytes || (maxbytes - *len) < start)
>   		*len = maxbytes - start;
>   
> +	supported_flags |= FIEMAP_FLAG_SYNC;
>   	supported_flags &= FIEMAP_FLAGS_COMPAT;
>   	incompat_flags = fieinfo->fi_flags & ~supported_flags;
>   	if (incompat_flags) {
>   		fieinfo->fi_flags = incompat_flags;
>   		return -EBADR;
>   	}
> -	return 0;
> +
> +	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
> +		ret = filemap_write_and_wait(inode->i_mapping);
> +	return ret;
>   }
>   EXPORT_SYMBOL(fiemap_prep);
>   
> @@ -213,9 +218,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
>   		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
>   		return -EFAULT;
>   
> -	if (fieinfo.fi_flags & FIEMAP_FLAG_SYNC)
> -		filemap_write_and_wait(inode->i_mapping);
> -
>   	error = inode->i_op->fiemap(inode, &fieinfo, fiemap.fm_start,
>   			fiemap.fm_length);
>   	fiemap.fm_flags = fieinfo.fi_flags;
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index 89dca4a97e4a2..aab070df4a217 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -75,16 +75,10 @@ int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi,
>   	ctx.fi = fi;
>   	ctx.prev.type = IOMAP_HOLE;
>   
> -	ret = fiemap_prep(inode, fi, start, &len, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fi, start, &len, 0);
>   	if (ret)
>   		return ret;
>   
> -	if (fi->fi_flags & FIEMAP_FLAG_SYNC) {
> -		ret = filemap_write_and_wait(inode->i_mapping);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	while (len > 0) {
>   		ret = iomap_apply(inode, start, len, IOMAP_REPORT, ops, &ctx,
>   				iomap_fiemap_actor);
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 052c2da11e4d7..25b0d368ecdb2 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -1006,7 +1006,7 @@ int nilfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	unsigned int blkbits = inode->i_blkbits;
>   	int ret, n;
>   
> -	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_SYNC);
> +	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
> index 3744179b73fa1..a94852af5510d 100644
> --- a/fs/ocfs2/extent_map.c
> +++ b/fs/ocfs2/extent_map.c
> @@ -733,8 +733,6 @@ static int ocfs2_fiemap_inline(struct inode *inode, struct buffer_head *di_bh,
>   	return 0;
>   }
>   
> -#define OCFS2_FIEMAP_FLAGS	(FIEMAP_FLAG_SYNC)
> -
>   int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		 u64 map_start, u64 map_len)
>   {
> @@ -746,8 +744,7 @@ int ocfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   	struct buffer_head *di_bh = NULL;
>   	struct ocfs2_extent_rec rec;
>   
> -	ret = fiemap_prep(inode, fieinfo, map_start, &map_len,
> -			OCFS2_FIEMAP_FLAGS);
> +	ret = fiemap_prep(inode, fieinfo, map_start, &map_len, 0);
>   	if (ret)
>   		return ret;
>   
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index b5fec34105569..c7cb883c47b86 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -462,10 +462,6 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   		return -EOPNOTSUPP;
>   
>   	old_cred = ovl_override_creds(inode->i_sb);
> -
> -	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC)
> -		filemap_write_and_wait(realinode->i_mapping);
> -
>   	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
>   	revert_creds(old_cred);
>   
> 
