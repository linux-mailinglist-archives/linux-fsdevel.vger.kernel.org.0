Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02E1A692B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgDMPxT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 11:53:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44608 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbgDMPxS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:53:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFoQDZ005867;
        Mon, 13 Apr 2020 15:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=srCDAz5N4+WCiR6E5PKm1RCPVKwnD6BJ37Mx//acQQM=;
 b=0DC8fAQmJXap+e5oJFoGTMaAK4p6Lkib+qycnp8LUrhcDt4tWwlaRhwAwlielnMurWtl
 aIMPBGTaRB1d0WNlAmpr3F+K/0ZF4LJ348Itq+2n//W7Ngez5yJbFyrum12DJ+OyECIe
 54YYTtLFlQZrFVjouVo9y30eAsdDta1TX/dmKkLe3lKpdKzBsso5WZoWrYxF6bgUw4fi
 1CQ7L33Jyspiu8vhpmsw9v4O3Io/WJWCCfuogVs3Ovdqqraaf3w6Dm+m81LXLsBPpMlz
 sZZNLrqgdJefzttwiLyXdl7tTZQO4VeNBNU4tr9wvvEOBuS2X5m8/y8LMDqK4RoK7WpM aQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30b5ukyb0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:53:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFr24D155451;
        Mon, 13 Apr 2020 15:53:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30cta7byj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 15:53:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DFqqSD024615;
        Mon, 13 Apr 2020 15:52:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 08:52:52 -0700
Date:   Mon, 13 Apr 2020 08:52:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 5/9] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200413155251.GU6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-6-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130119
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

Why separate the !S_ISREG and the is_reflink_inode checks?

The part about "Change the use of xfs_inode_supports_dax() to reflect
only if the inode and underlying storage support dax" would be a lot
more straightforward if this hunk only removed the DIFLAG2_DAX check.

The rest of the patch looks ok.

--D

>  
>  	/* Block size must match page size */
> @@ -1260,6 +1259,31 @@ xfs_inode_supports_dax(
>  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
>  }
>  
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
> +
> +
>  STATIC void
>  xfs_diflags_to_iflags(
>  	struct inode		*inode,
> @@ -1278,7 +1302,7 @@ xfs_diflags_to_iflags(
>  		inode->i_flags |= S_SYNC;
>  	if (flags & XFS_DIFLAG_NOATIME)
>  		inode->i_flags |= S_NOATIME;
> -	if (xfs_inode_supports_dax(ip))
> +	if (xfs_inode_enable_dax(ip))
>  		inode->i_flags |= S_DAX;
>  }
>  
> -- 
> 2.25.1
> 
