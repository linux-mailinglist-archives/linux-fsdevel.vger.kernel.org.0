Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D62CA9E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbgLARjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 12:39:55 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56432 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387820AbgLARjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:39:55 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HYvmH051943;
        Tue, 1 Dec 2020 17:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4dj3kScweVczOZbYU+emzj8oUQKL0l0sEkzlyn1Dy+0=;
 b=qDv3LaV0UbHVS52KNTXYzLfGc/Y4teoG3Kq1CN2tWnIyyipxrgHvs146vDrbkW0ajI63
 ih2q4AsPeKjZVrBox4e5VSVu6hY/h/kxRYz3h09mfMc3F/qfTZLPK3xWhs0oFDe+NdYP
 rcGykFqcxVtvK5slRq1CA0DH4UiZrOJbzBAupqWARadrTWp2Yq+GWrycGFGCjHpuPu/a
 FYTnJCJ58cHy1YPzsvf9WhOWN6cG/8CTaNkH+yCQZmlvPsXb/barj64NqGzm3ZIhpa2g
 XoQV09uNG1zG1+ZRJRS8z1drMsCk/Oa0xJG3Da9MEbOGLeqGOWS02JMjpT6+oBax95aZ 8A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2av1by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 17:39:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HZLqV083775;
        Tue, 1 Dec 2020 17:39:09 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3540fxad0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 17:39:09 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B1Hd7Q9014206;
        Tue, 1 Dec 2020 17:39:07 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 09:39:07 -0800
Date:   Tue, 1 Dec 2020 09:39:05 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <20201201173905.GI143045@magnolia>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010108
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:59:36AM -0600, Eric Sandeen wrote:
> It's a bit odd to set STATX_ATTR_DAX into the statx attributes in the VFS;
> while the VFS can detect the current DAX state, it is the filesystem which
> actually sets S_DAX on the inode, and the filesystem is the place that
> knows whether DAX is something that the "filesystem actually supports" [1]
> so that the statx attributes_mask can be properly set.
> 
> So, move STATX_ATTR_DAX attribute setting to the individual dax-capable
> filesystems, and update the attributes_mask there as well.
> 
> [1] 3209f68b3ca4 statx: Include a mask for stx_attributes in struct statx
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
>  fs/ext2/inode.c   | 6 +++++-
>  fs/ext4/inode.c   | 5 ++++-
>  fs/stat.c         | 3 ---
>  fs/xfs/xfs_iops.c | 5 ++++-
>  4 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index 11c5c6fe75bb..3550783a6ea0 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1653,11 +1653,15 @@ int ext2_getattr(const struct path *path, struct kstat *stat,
>  		stat->attributes |= STATX_ATTR_IMMUTABLE;
>  	if (flags & EXT2_NODUMP_FL)
>  		stat->attributes |= STATX_ATTR_NODUMP;
> +	if (IS_DAX(inode))
> +		stat->attributes |= STATX_ATTR_DAX;
> +
>  	stat->attributes_mask |= (STATX_ATTR_APPEND |
>  			STATX_ATTR_COMPRESSED |
>  			STATX_ATTR_ENCRYPTED |
>  			STATX_ATTR_IMMUTABLE |
> -			STATX_ATTR_NODUMP);
> +			STATX_ATTR_NODUMP |
> +			STATX_ATTR_DAX);
>  
>  	generic_fillattr(inode, stat);
>  	return 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0d8385aea898..848a0f2b154e 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5550,13 +5550,16 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
>  		stat->attributes |= STATX_ATTR_NODUMP;
>  	if (flags & EXT4_VERITY_FL)
>  		stat->attributes |= STATX_ATTR_VERITY;
> +	if (IS_DAX(inode))
> +		stat->attributes |= STATX_ATTR_DAX;
>  
>  	stat->attributes_mask |= (STATX_ATTR_APPEND |
>  				  STATX_ATTR_COMPRESSED |
>  				  STATX_ATTR_ENCRYPTED |
>  				  STATX_ATTR_IMMUTABLE |
>  				  STATX_ATTR_NODUMP |
> -				  STATX_ATTR_VERITY);
> +				  STATX_ATTR_VERITY |
> +				  STATX_ATTR_DAX);
>  
>  	generic_fillattr(inode, stat);
>  	return 0;
> diff --git a/fs/stat.c b/fs/stat.c
> index dacecdda2e79..5bd90949c69b 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -80,9 +80,6 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> -	if (IS_DAX(inode))
> -		stat->attributes |= STATX_ATTR_DAX;
> -
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
>  					    query_flags);
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1414ab79eacf..56deda7042fd 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -575,10 +575,13 @@ xfs_vn_getattr(
>  		stat->attributes |= STATX_ATTR_APPEND;
>  	if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>  		stat->attributes |= STATX_ATTR_NODUMP;
> +	if (IS_DAX(inode))
> +		stat->attributes |= STATX_ATTR_DAX;
>  
>  	stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
>  				  STATX_ATTR_APPEND |
> -				  STATX_ATTR_NODUMP);
> +				  STATX_ATTR_NODUMP |
> +				  STATX_ATTR_DAX);

TBH I preferred your previous iteration on this, which only set the DAX
bit in the attributes_mask if the underlying storage was pmem and the
blocksize was correct, etc. since it made it easier to distinguish
between a filesystem where you /could/ have DAX (but it wasn't currently
enabled) and a filesystem where it just isn't possible.

That might be enough to satisfy any critics who want to be able to
detect DAX support from an installer program.

--D

>  
>  	switch (inode->i_mode & S_IFMT) {
>  	case S_IFBLK:
> -- 
> 2.17.0
> 
> 
