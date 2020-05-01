Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051BA1C20EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 May 2020 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEAWws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 18:52:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56570 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbgEAWwr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 18:52:47 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 041MXtYB192626;
        Fri, 1 May 2020 18:52:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r822dcrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 18:52:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 041MYJLB193357;
        Fri, 1 May 2020 18:52:38 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r822dcqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 18:52:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 041Mf86F016648;
        Fri, 1 May 2020 22:52:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu75jvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 22:52:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 041MpPsu50725354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 22:51:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B03AAE045;
        Fri,  1 May 2020 22:52:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1B4AE05D;
        Fri,  1 May 2020 22:52:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 22:52:32 +0000 (GMT)
Subject: Re: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
To:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
References: <20200427181957.1606257-1-hch@lst.de>
 <20200427181957.1606257-10-hch@lst.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Sat, 2 May 2020 04:22:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427181957.1606257-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200501225232.9F1B4AE05D@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_16:2020-05-01,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010154
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/27/20 11:49 PM, Christoph Hellwig wrote:
> By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
> handled once instead of duplicated, but can still be done under fs locks,
> like xfs/iomap intended with its duplicate handling.  Also make sure the
> error value of filemap_write_and_wait is propagated to user space.


Forgot to remove filemap_write_and_wait() from
ext4_ioctl_get_es_cache() ?


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/inode.c      |  4 +---
>   fs/cifs/smb2ops.c     |  3 +--
>   fs/ext4/extents.c     |  2 +-
>   fs/f2fs/data.c        |  3 +--
>   fs/ioctl.c            | 10 ++++++----
>   fs/iomap/fiemap.c     |  8 +-------
>   fs/nilfs2/inode.c     |  2 +-
>   fs/ocfs2/extent_map.c |  5 +----
>   fs/overlayfs/inode.c  |  4 ----
>   9 files changed, 13 insertions(+), 28 deletions(-)
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
> index 8a2e94931dc96..32880fca6d8d8 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -3408,8 +3408,7 @@ static int smb3_fiemap(struct cifs_tcon *tcon,
>   	int i, num, rc, flags, last_blob;
>   	u64 next;
>   
> -	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len,
> -			FIEMAP_FLAG_SYNC);
> +	rc = fiemap_prep(cfile->dentry->d_inode, fei, start, &len, 0);
>   	if (rc)
>   		rc;
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
> index 4d94c20c9596b..ae0d228d18a16 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -162,6 +162,7 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
>   {
>   	u64 maxbytes = inode->i_sb->s_maxbytes;
>   	u32 incompat_flags;
> +	int ret = 0;
>   
>   	if (*len == 0)
>   		return -EINVAL;
> @@ -174,13 +175,17 @@ int fiemap_prep(struct inode *inode, struct fiemap_extent_info *fieinfo,
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

Since we could return an error from here.
I think we should again update the function description that
it could return a negative error value if filemap_write_and_wait()
fails. And also should document this in Documentation/*




>   }
>   EXPORT_SYMBOL(fiemap_prep);
>   
> @@ -209,9 +214,6 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
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
> index 5e4e3520424da..fffd9eedfd880 100644
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
