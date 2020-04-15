Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB31B1AABB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506408AbgDOPUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:20:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506400AbgDOPT6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:19:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFIDOb106181;
        Wed, 15 Apr 2020 15:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jyN0h1t2Sj5nRS0+T4R8pLekzD6mhe1Qv0xeGlU246c=;
 b=oKIpJwKRdmjhyG3vNvcS52Kas4tjsLxYOSRJwjmdfIHvxb/mOoNT9FqB5JUDBzw6mDuE
 G8M1npIlXAoahGrF19eF9FG/bdhhefePqY53Arpojv8fYov1UjzQ/KpkU9Cj2WOu9H9c
 puLkN7o711dtOyINfJUEzviFlBegXGEvhCJltOheKRXkN9CEpM5CzeMVEGaXs36niKNB
 YKG6Lp0IgacGU26OZG7O7Ei40WadxVsN9MUynbjXVlFCSlVYs2kRugkY7HkqZwo7tIGQ
 l+vdsHGo0chSEyIJGq+WsYu5//tRD7lbIxeJg4W/Mjw0XAF7T91MhNi6/1vEgMCuDx6+ aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30dn95m1sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:19:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFC3FG171421;
        Wed, 15 Apr 2020 15:17:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30dn9c3rys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:17:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFHh5V030448;
        Wed, 15 Apr 2020 15:17:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:17:43 -0700
Date:   Wed, 15 Apr 2020 08:17:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 06/11] fs/xfs: Create function xfs_inode_enable_dax()
Message-ID: <20200415151742.GP6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-7-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-7-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=1
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:18PM -0700, ira.weiny@intel.com wrote:
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
> Changes from v7:
> 	Move S_ISREG check first
> 	use IS_ENABLED(CONFIG_FS_DAX) rather than duplicated function
> 
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
>  fs/xfs/xfs_iops.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a6e634631da8..2ecc2b2050ab 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1243,13 +1243,12 @@ xfs_inode_supports_dax(
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  
> -	/* Only supported on non-reflinked files. */
> -	if (!S_ISREG(VFS_I(ip)->i_mode) || xfs_is_reflink_inode(ip))
> +	/* Only supported on regular files. */
> +	if (!S_ISREG(VFS_I(ip)->i_mode))
>  		return false;
>  
> -	/* DAX mount option or DAX iflag must be set. */
> -	if (!(mp->m_flags & XFS_MOUNT_DAX_ALWAYS) &&
> -	    !(ip->i_d.di_flags2 & XFS_DIFLAG2_DAX))
> +	/* Only supported on non-reflinked files. */
> +	if (xfs_is_reflink_inode(ip))
>  		return false;
>  
>  	/* Block size must match page size */
> @@ -1260,6 +1259,23 @@ xfs_inode_supports_dax(
>  	return xfs_inode_buftarg(ip)->bt_daxdev != NULL;
>  }
>  
> +static bool
> +xfs_inode_enable_dax(
> +	struct xfs_inode *ip)
> +{
> +	if (!IS_ENABLED(CONFIG_FS_DAX))
> +		return false;
> +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX_NEVER)
> +		return false;
> +	if (!xfs_inode_supports_dax(ip))
> +		return false;
> +	if (ip->i_mount->m_flags & XFS_MOUNT_DAX_ALWAYS)
> +		return true;
> +	if (ip->i_d.di_flags2 & XFS_DIFLAG2_DAX)
> +		return true;
> +	return false;

You could simplify the last two lines by making them read:

return ip->i_d.di_flags2 & XFS_DIFLAG2_DAX;

But it's probably not worth respinning the whole thing just for that.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +}
> +
>  STATIC void
>  xfs_diflags_to_iflags(
>  	struct inode		*inode,
> @@ -1278,7 +1294,7 @@ xfs_diflags_to_iflags(
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
