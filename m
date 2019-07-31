Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23A87D1DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 01:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfGaX0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 19:26:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfGaX0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:26:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNOo95183155;
        Wed, 31 Jul 2019 23:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JfnbxS8m05Mexf2WRIB4eZcjB7poy74uf2SKLy5WZyU=;
 b=lFDkabiJ1vteiThGrX5f1RCOp2VvZAeFrNcLZFdtMfWKetUigccZFkFFuefULbuPvvDa
 W5md9nntpVdgQc4AUbtlW1PRCwZAqM+MjdP5T/JGrLTJB0vNbRz3YUNUTZ6g7NUek59I
 JDH6P3gM9CXP++mFZPFth7/Q+eY8NY4gBz6l1sTNnDF+jdfK1XLVGciYuueeZaDLGcHa
 G2omAj3Eqzx22+xNYx+NF48hhAObWFoyCbLo9UUMkYSI62SUogOM2Cm2EJs9WoFETZEx
 4rA16uvE2lNMz2B2KRIsXmxiZqeJmgE17WVZJAJ1efg6eXRP/x3xgar45AeC+G9wMAU/ kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u0f8r859e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:26:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VNNtnK110189;
        Wed, 31 Jul 2019 23:26:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2u3mbtget3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 23:26:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VNQb0e030144;
        Wed, 31 Jul 2019 23:26:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 16:26:36 -0700
Date:   Wed, 31 Jul 2019 16:26:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/9] fiemap: Use a callback to fill fiemap extents
Message-ID: <20190731232635.GY1561054@magnolia>
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-8-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731141245.7230-8-cmaiolino@redhat.com>
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
 definitions=main-1907310230
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 31, 2019 at 04:12:43PM +0200, Carlos Maiolino wrote:
> As a goal to enable fiemap infrastructure to be used by fibmap too, we need a
> way to use different helpers to fill extent data, depending on its usage. One
> helper to fill extent data stored in user address space (used in fiemap), and
> another fo fill extent data stored in kernel address space (will be used in
> fibmap).
> 
> This patch sets up the usage of a callback to be used to fill in the extents.
> It transforms the current fiemap_fill_next_extent, into a simple helper to call
> the callback, avoiding unneeded changes on any filesystem, and reutilizes the
> original function as the callback used by FIEMAP.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Changelog:
> 
> V3:
> 	- Rebase to current linux-next
> 	- Fix conflict on rebase
> 	- Merge this patch into patch 07 from V2
> 	- Rename fi_extents_start to fi_cb_data
> 
> V2:
> 	- Now based on the rework on fiemap_extent_info (previous was
> 	  based on fiemap_ctx)
> 
>  fs/ioctl.c         | 45 ++++++++++++++++++++++++++-------------------
>  include/linux/fs.h | 12 +++++++++---
>  2 files changed, 35 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index ad8edcb10dc9..d72696c222de 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -77,29 +77,14 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	return error;
>  }
>  
> -/**
> - * fiemap_fill_next_extent - Fiemap helper function
> - * @fieinfo:	Fiemap context passed into ->fiemap
> - * @logical:	Extent logical start offset, in bytes
> - * @phys:	Extent physical start offset, in bytes
> - * @len:	Extent length, in bytes
> - * @flags:	FIEMAP_EXTENT flags that describe this extent
> - *
> - * Called from file system ->fiemap callback. Will populate extent
> - * info as passed in via arguments and copy to user memory. On
> - * success, extent count on fieinfo is incremented.
> - *
> - * Returns 0 on success, -errno on error, 1 if this was the last
> - * extent that will fit in user array.
> - */
>  #define SET_UNKNOWN_FLAGS	(FIEMAP_EXTENT_DELALLOC)
>  #define SET_NO_UNMOUNTED_IO_FLAGS	(FIEMAP_EXTENT_DATA_ENCRYPTED)
>  #define SET_NOT_ALIGNED_FLAGS	(FIEMAP_EXTENT_DATA_TAIL|FIEMAP_EXTENT_DATA_INLINE)
> -int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> +int fiemap_fill_user_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  			    u64 phys, u64 len, u32 flags)
>  {
>  	struct fiemap_extent extent;
> -	struct fiemap_extent __user *dest = fieinfo->fi_extents_start;
> +	struct fiemap_extent __user *dest = fieinfo->fi_cb_data;
>  
>  	/* only count the extents */
>  	if (fieinfo->fi_extents_max == 0) {
> @@ -132,6 +117,27 @@ int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
>  		return 1;
>  	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
>  }
> +
> +/**
> + * fiemap_fill_next_extent - Fiemap helper function
> + * @fieinfo:	Fiemap context passed into ->fiemap
> + * @logical:	Extent logical start offset, in bytes
> + * @phys:	Extent physical start offset, in bytes
> + * @len:	Extent length, in bytes
> + * @flags:	FIEMAP_EXTENT flags that describe this extent
> + *
> + * Called from file system ->fiemap callback. Will populate extent
> + * info as passed in via arguments and copy to user memory. On
> + * success, extent count on fieinfo is incremented.
> + *
> + * Returns 0 on success, -errno on error, 1 if this was the last
> + * extent that will fit in user array.
> + */
> +int fiemap_fill_next_extent(struct fiemap_extent_info *fieinfo, u64 logical,
> +			    u64 phys, u64 len, u32 flags)
> +{
> +	return fieinfo->fi_cb(fieinfo, logical, phys, len, flags);
> +}
>  EXPORT_SYMBOL(fiemap_fill_next_extent);
>  
>  /**
> @@ -209,12 +215,13 @@ static int ioctl_fiemap(struct file *filp, unsigned long arg)
>  
>  	fieinfo.fi_flags = fiemap.fm_flags;
>  	fieinfo.fi_extents_max = fiemap.fm_extent_count;
> -	fieinfo.fi_extents_start = ufiemap->fm_extents;
> +	fieinfo.fi_cb_data = ufiemap->fm_extents;
>  	fieinfo.fi_start = fiemap.fm_start;
>  	fieinfo.fi_len = len;
> +	fieinfo.fi_cb = fiemap_fill_user_extent;
>  
>  	if (fiemap.fm_extent_count != 0 &&
> -	    !access_ok(fieinfo.fi_extents_start,
> +	    !access_ok(fieinfo.fi_cb_data,
>  		       fieinfo.fi_extents_max * sizeof(struct fiemap_extent)))
>  		return -EFAULT;
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7b744b7de24e..a8bd3c4f6d86 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -66,6 +66,7 @@ struct fscrypt_info;
>  struct fscrypt_operations;
>  struct fs_context;
>  struct fs_parameter_description;
> +struct fiemap_extent_info;
>  
>  extern void __init inode_init(void);
>  extern void __init inode_init_early(void);
> @@ -1704,16 +1705,21 @@ extern bool may_open_dev(const struct path *path);
>  /*
>   * VFS FS_IOC_FIEMAP helper definitions.
>   */
> +
> +typedef int (*fiemap_fill_cb)(struct fiemap_extent_info *fieinfo, u64 logical,
> +			      u64 phys, u64 len, u32 flags);
> +
>  struct fiemap_extent_info {
>  	unsigned int	fi_flags;		/* Flags as passed from user */
>  	u64		fi_start;
>  	u64		fi_len;
>  	unsigned int	fi_extents_mapped;	/* Number of mapped extents */
>  	unsigned int	fi_extents_max;		/* Size of fiemap_extent array */
> -	struct		fiemap_extent __user *fi_extents_start;	/* Start of
> -								   fiemap_extent
> -								   array */
> +	void		*fi_cb_data;		/* Start of fiemap_extent
> +						   array */
> +	fiemap_fill_cb	fi_cb;
>  };
> +
>  int fiemap_fill_next_extent(struct fiemap_extent_info *info, u64 logical,
>  			    u64 phys, u64 len, u32 flags);
>  int fiemap_check_flags(struct fiemap_extent_info *fieinfo, u32 fs_flags);
> -- 
> 2.20.1
> 
