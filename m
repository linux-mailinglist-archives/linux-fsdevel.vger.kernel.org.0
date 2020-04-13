Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076781A6957
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgDMQB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:01:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731188AbgDMQB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:01:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFw3Uo028358;
        Mon, 13 Apr 2020 16:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=REbA4S1oU2wWHOxI9V9GVO68wioqMje5FElRBnjCl5I=;
 b=nhnBxR+7YjxF8kahBI7sjAwFvjkmiXcvZP8glENhP/EGSHbsZ7A4q/qWXrhey5FDpeDf
 FsvMU4Lj3Qq1tcj2gKOCs3kipJB5zq979K5Ou1SopA5IPU9PlMSfjeBTNK4kbWDiCCEX
 yGV+SPTjDEdyO3X0WEH0I0hZGtCUjVCPwY6OCcHfgMgnrEOMOgZvXg9YIjLP4U/4Csz9
 Vw5ERk0VPVoAkxrJ1ClfLPMd0mT0WFzen5vx5au9ijHvS7+NTWYBB9nRRzElNaq5xwcN
 MsHvBVSfYLDZJMR81mOQSQ2M9QyOMu/aGcbKnP5xGRA025qAzUCA47a9pD8jo3WbmHQp tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30b5ukycr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:01:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DFurNL144073;
        Mon, 13 Apr 2020 16:01:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30bqkxmau9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:01:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DG1fRL018862;
        Mon, 13 Apr 2020 16:01:41 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:01:40 -0700
Date:   Mon, 13 Apr 2020 09:01:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 6/9] fs/xfs: Combine xfs_diflags_to_linux() and
 xfs_diflags_to_iflags()
Message-ID: <20200413160138.GV6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-7-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:43PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The functionality in xfs_diflags_to_linux() and xfs_diflags_to_iflags() are
> nearly identical.  The only difference is that *_to_linux() is called after
> inode setup and disallows changing the DAX flag.
> 
> Combining them can be done with a flag which indicates if this is the initial
> setup to allow the DAX flag to be properly set only at init time.
> 
> So remove xfs_diflags_to_linux() and call the modified xfs_diflags_to_iflags()
> directly.
> 
> While we are here simplify xfs_diflags_to_iflags() to take struct xfs_inode and
> use xfs_ip2xflags() to ensure future diflags are included correctly.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V6:
> 	Move unrelated hunk to previous patch.
> 	Change logic for better code generation.
> 
> Changes from V5:
> 	The functions are no longer identical so we can only combine
> 	them rather than deleting one completely.  This is reflected in
> 	the new init parameter.
> ---
>  fs/xfs/xfs_inode.h |  1 +
>  fs/xfs/xfs_ioctl.c | 33 +--------------------------------
>  fs/xfs/xfs_iops.c  | 42 +++++++++++++++++++++++-------------------
>  3 files changed, 25 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 492e53992fa9..e76ed9ca17f7 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -466,6 +466,7 @@ int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  /* from xfs_iops.c */
>  extern void xfs_setup_inode(struct xfs_inode *ip);
>  extern void xfs_setup_iops(struct xfs_inode *ip);
> +extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
>  
>  /*
>   * When setting up a newly allocated inode, we need to call
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index d42de92cb283..c6cd92ef4a05 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1100,37 +1100,6 @@ xfs_flags2diflags2(
>  	return di_flags2;
>  }
>  
> -STATIC void
> -xfs_diflags_to_linux(
> -	struct xfs_inode	*ip)
> -{
> -	struct inode		*inode = VFS_I(ip);
> -	unsigned int		xflags = xfs_ip2xflags(ip);
> -
> -	if (xflags & FS_XFLAG_IMMUTABLE)
> -		inode->i_flags |= S_IMMUTABLE;
> -	else
> -		inode->i_flags &= ~S_IMMUTABLE;
> -	if (xflags & FS_XFLAG_APPEND)
> -		inode->i_flags |= S_APPEND;
> -	else
> -		inode->i_flags &= ~S_APPEND;
> -	if (xflags & FS_XFLAG_SYNC)
> -		inode->i_flags |= S_SYNC;
> -	else
> -		inode->i_flags &= ~S_SYNC;
> -	if (xflags & FS_XFLAG_NOATIME)
> -		inode->i_flags |= S_NOATIME;
> -	else
> -		inode->i_flags &= ~S_NOATIME;
> -#if 0	/* disabled until the flag switching races are sorted out */
> -	if (xflags & FS_XFLAG_DAX)
> -		inode->i_flags |= S_DAX;
> -	else
> -		inode->i_flags &= ~S_DAX;
> -#endif
> -}
> -
>  static int
>  xfs_ioctl_setattr_xflags(
>  	struct xfs_trans	*tp,
> @@ -1168,7 +1137,7 @@ xfs_ioctl_setattr_xflags(
>  	ip->i_d.di_flags = xfs_flags2diflags(ip, fa->fsx_xflags);
>  	ip->i_d.di_flags2 = di_flags2;
>  
> -	xfs_diflags_to_linux(ip);
> +	xfs_diflags_to_iflags(ip, false);
>  	xfs_trans_ichgtime(tp, ip, XFS_ICHGTIME_CHG);
>  	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
>  	XFS_STATS_INC(mp, xs_ig_attrchg);
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 37bd15b55878..856ad823e754 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1284,26 +1284,30 @@ xfs_inode_enable_dax(
>  #endif /* CONFIG_FS_DAX */
>  
>  
> -STATIC void
> +void
>  xfs_diflags_to_iflags(
> -	struct inode		*inode,
> -	struct xfs_inode	*ip)
> +	struct xfs_inode	*ip,
> +	bool init)
>  {
> -	uint16_t		flags = ip->i_d.di_flags;
> -
> -	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC |
> -			    S_NOATIME | S_DAX);
> -
> -	if (flags & XFS_DIFLAG_IMMUTABLE)
> -		inode->i_flags |= S_IMMUTABLE;
> -	if (flags & XFS_DIFLAG_APPEND)
> -		inode->i_flags |= S_APPEND;
> -	if (flags & XFS_DIFLAG_SYNC)
> -		inode->i_flags |= S_SYNC;
> -	if (flags & XFS_DIFLAG_NOATIME)
> -		inode->i_flags |= S_NOATIME;
> -	if (xfs_inode_enable_dax(ip))
> -		inode->i_flags |= S_DAX;
> +	struct inode            *inode = VFS_I(ip);
> +	unsigned int            xflags = xfs_ip2xflags(ip);
> +	unsigned int            flags = 0;
> +
> +	ASSERT(!(IS_DAX(inode) && init));
> +
> +	if (xflags & FS_XFLAG_IMMUTABLE)
> +		flags |= S_IMMUTABLE;
> +	if (xflags & FS_XFLAG_APPEND)
> +		flags |= S_APPEND;
> +	if (xflags & FS_XFLAG_SYNC)
> +		flags |= S_SYNC;
> +	if (xflags & FS_XFLAG_NOATIME)
> +		flags |= S_NOATIME;
> +	if (init && xfs_inode_enable_dax(ip))
> +		flags |= S_DAX;
> +
> +	inode->i_flags &= ~(S_IMMUTABLE | S_APPEND | S_SYNC | S_NOATIME);

I noticed that S_DAX drops out of the mask out operation here, which of
course resulted in an eyebrow-raise because the other four flags are
always set to whatever we just computed. :)

Then I realized that yes, this is intentional since we can't change
S_DAX on the fly, and that S_DAX is never set i_flags on an inode that's
being initialized so we don't need to mask off S_DAX ever.

Could we add a comment here to remind the reader that S_DAX is a bit
special?

/*
 * S_DAX can only be set during inode initialization and is never set by
 * the VFS, so we cannot mask off S_DAX in i_flags.
 */

With that added,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +	inode->i_flags |= flags;
>  }
>  
>  /*
> @@ -1332,7 +1336,7 @@ xfs_setup_inode(
>  	inode->i_gid    = xfs_gid_to_kgid(ip->i_d.di_gid);
>  
>  	i_size_write(inode, ip->i_d.di_size);
> -	xfs_diflags_to_iflags(inode, ip);
> +	xfs_diflags_to_iflags(ip, true);
>  
>  	if (S_ISDIR(inode->i_mode)) {
>  		/*
> -- 
> 2.25.1
> 
