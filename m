Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14F3F168AF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 01:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgBVA2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 19:28:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36164 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVA2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:28:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0IJ9o062366;
        Sat, 22 Feb 2020 00:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/VPVeh1c+6mc9B9FJQZVdoDMBgYy/1D1NNm9h5BUePQ=;
 b=w/v2PiDCjJ37v8mFyABwCCdqxpL2+e7giVrv7yNq1kYmANdP5xf4oPmNaRFaLEy0Ys9v
 0UKiHeccK9N/EgPGv037qg612gn+gXMppnYvBDXnE1iEOuhm/x1MGHTCq74/RCrgJZzb
 bHj95B2HTHriEc3BT2FZ8z2mHKLz0G0FnNGdMOTi5evKFxqGHMJctFEK3U1sT3egJNjk
 xwH6W5msLM897b0g2gAj6jdl5PiZWlumUyGanjOshSX+yVQ4bnIPrDW92esF3+hHiI1Y
 6ZS3v2UdzzOUjcbDoeY0Cu3sG90PrmYFDiNszq3ve1Iy93s0JeVVBAtyVSJLP6Iv/5a5 Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2y8ud1kj0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:28:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0STRT038398;
        Sat, 22 Feb 2020 00:28:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y8udg7t2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:28:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01M0SNgV005254;
        Sat, 22 Feb 2020 00:28:23 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 16:28:22 -0800
Date:   Fri, 21 Feb 2020 16:28:21 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 06/13] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200222002821.GD9506@magnolia>
References: <20200221004134.30599-1-ira.weiny@intel.com>
 <20200221004134.30599-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-7-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=1 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=1 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002220000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:27PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> xfs_inode_supports_dax() should reflect if the inode can support DAX not
> that it is enabled for DAX.
> 
> Change the use of xfs_inode_supports_dax() to reflect only if the inode
> and underlying storage support dax.
> 
> Add a new function xfs_inode_enable_dax() which reflects if the inode

Heavily into bikeshedding here, but "enable" sounds like a verb, but
this function doesn't actually turn dax on for a file, it merely decides
if we /should/ turn it on.

xfs_inode_wants_dax() ?

--D

> should be enabled for DAX.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v3:
> 	Update functions and names to be more clear
> 	Update commit message
> 	Merge with
> 		'fs/xfs: Clean up DAX support check'
> 		don't allow IS_DAX() on a directory
> 		use STATIC macro for static
> 		make xfs_inode_supports_dax() static
> ---
>  fs/xfs/xfs_iops.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 81f2f93caec0..ff711efc5247 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1237,19 +1237,18 @@ static const struct inode_operations xfs_inline_symlink_inode_operations = {
>  };
>  
>  /* Figure out if this file actually supports DAX. */
> -static bool
> +STATIC bool
>  xfs_inode_supports_dax(
>  	struct xfs_inode	*ip)
>  {
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
>  
>  	/* Block size must match page size */
> @@ -1260,6 +1259,20 @@ xfs_inode_supports_dax(
>  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
>  }
>  
> +STATIC bool
> +xfs_inode_enable_dax(
> +	struct xfs_inode *ip)
> +{
> +	if (!xfs_inode_supports_dax(ip))
> +		return false;
> +
> +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> +		return true;
> +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX)
> +		return true;
> +	return false;
> +}
> +
>  STATIC void
>  xfs_diflags_to_iflags(
>  	struct inode		*inode,
> @@ -1278,7 +1291,7 @@ xfs_diflags_to_iflags(
>  		inode->i_flags |= S_SYNC;
>  	if (flags & XFS_DIFLAG_NOATIME)
>  		inode->i_flags |= S_NOATIME;
> -	if (xfs_inode_supports_dax(ip))
> +	if (xfs_inode_enable_dax(ip))
>  		inode->i_flags |= S_DAX;
>  }
>  
> -- 
> 2.21.0
> 
