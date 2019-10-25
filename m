Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA36E430C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 07:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393372AbfJYFtW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 01:49:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390519AbfJYFtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 01:49:22 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5nDxC136298;
        Fri, 25 Oct 2019 05:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bzgKDxxrdr9lL8i69RC4xSCWbKGxL5MvlfDJuiL7k5w=;
 b=bjVa9d9dmSpL4BA0bLik9XNNj6jmL/Kh9cQW46YEMJNRUdcvCGkS9sp9KrfCr6g4Euzn
 751BFzR3V9uRNfut6blskmFGyYjqIhwS11cMGykn6Bgo5Lc7KFg3mf34ae4NBEnbqkYk
 b4NemLNxp6O78gX5j3vKEZLr2x2NgWvYiIUxKToBtJ1S7fyVePyb/lYr5vTmjsU2QNMU
 pDrWZGhIJyuUDZJKd+Mm2rRqnbxeDnwOxXeHhFmPAy6McU52zVZApOeGshS/5FfJupAb
 KDaHGOIyb//WZE6q5F7bX6xgSFI2I5rQeqTSl+Ki3JqZIh+wJv0JaVeoGpV/PXAy4PMi Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vqteq8a9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:49:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9P5n9b9041564;
        Fri, 25 Oct 2019 05:49:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vug0daqw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 05:49:11 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9P5mRrS011680;
        Fri, 25 Oct 2019 05:48:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 22:48:26 -0700
Date:   Thu, 24 Oct 2019 22:48:25 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs: consolidate preallocation in xfs_file_fallocate
Message-ID: <20191025054825.GH913374@magnolia>
References: <20191025023609.22295-1-hch@lst.de>
 <20191025023609.22295-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025023609.22295-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250057
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:36:09AM +0900, Christoph Hellwig wrote:
> Remove xfs_zero_file_space and reorganize xfs_file_fallocate so that a
> single call to xfs_alloc_file_space covers all modes that preallocate
> blocks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems pretty straightforward.

On a side note I think Dave and Eric might have noticed that fallocate
doesn't drain directio which could lead to incorrect file size.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_bmap_util.c | 37 -------------------------------------
>  fs/xfs/xfs_bmap_util.h |  2 --
>  fs/xfs/xfs_file.c      | 32 ++++++++++++++++++++++++--------
>  3 files changed, 24 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 9b0572a7b03a..11658da40640 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -1133,43 +1133,6 @@ xfs_free_file_space(
>  	return error;
>  }
>  
> -/*
> - * Preallocate and zero a range of a file. This mechanism has the allocation
> - * semantics of fallocate and in addition converts data in the range to zeroes.
> - */
> -int
> -xfs_zero_file_space(
> -	struct xfs_inode	*ip,
> -	xfs_off_t		offset,
> -	xfs_off_t		len)
> -{
> -	struct xfs_mount	*mp = ip->i_mount;
> -	uint			blksize;
> -	int			error;
> -
> -	trace_xfs_zero_file_space(ip);
> -
> -	blksize = 1 << mp->m_sb.sb_blocklog;
> -
> -	/*
> -	 * Punch a hole and prealloc the range. We use hole punch rather than
> -	 * unwritten extent conversion for two reasons:
> -	 *
> -	 * 1.) Hole punch handles partial block zeroing for us.
> -	 *
> -	 * 2.) If prealloc returns ENOSPC, the file range is still zero-valued
> -	 * by virtue of the hole punch.
> -	 */
> -	error = xfs_free_file_space(ip, offset, len);
> -	if (error || xfs_is_always_cow_inode(ip))
> -		return error;
> -
> -	return xfs_alloc_file_space(ip, round_down(offset, blksize),
> -				     round_up(offset + len, blksize) -
> -				     round_down(offset, blksize),
> -				     XFS_BMAPI_PREALLOC);
> -}
> -
>  static int
>  xfs_prepare_shift(
>  	struct xfs_inode	*ip,
> diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
> index 7a78229cf1a7..3e0fa0d363d1 100644
> --- a/fs/xfs/xfs_bmap_util.h
> +++ b/fs/xfs/xfs_bmap_util.h
> @@ -59,8 +59,6 @@ int	xfs_alloc_file_space(struct xfs_inode *ip, xfs_off_t offset,
>  			     xfs_off_t len, int alloc_type);
>  int	xfs_free_file_space(struct xfs_inode *ip, xfs_off_t offset,
>  			    xfs_off_t len);
> -int	xfs_zero_file_space(struct xfs_inode *ip, xfs_off_t offset,
> -			    xfs_off_t len);
>  int	xfs_collapse_file_space(struct xfs_inode *, xfs_off_t offset,
>  				xfs_off_t len);
>  int	xfs_insert_file_space(struct xfs_inode *, xfs_off_t offset,
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 156238d5af19..525b29b99116 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -880,16 +880,30 @@ xfs_file_fallocate(
>  		}
>  
>  		if (mode & FALLOC_FL_ZERO_RANGE) {
> -			error = xfs_zero_file_space(ip, offset, len);
> +			/*
> +			 * Punch a hole and prealloc the range.  We use a hole
> +			 * punch rather than unwritten extent conversion for two
> +			 * reasons:
> +			 *
> +			 *   1.) Hole punch handles partial block zeroing for us.
> +			 *   2.) If prealloc returns ENOSPC, the file range is
> +			 *       still zero-valued by virtue of the hole punch.
> +			 */
> +			unsigned int blksize = i_blocksize(inode);
> +
> +			trace_xfs_zero_file_space(ip);
> +
> +			error = xfs_free_file_space(ip, offset, len);
> +			if (error)
> +				goto out_unlock;
> +
> +			len = round_up(offset + len, blksize) -
> +			      round_down(offset, blksize);
> +			offset = round_down(offset, blksize);
>  		} else if (mode & FALLOC_FL_UNSHARE_RANGE) {
>  			error = xfs_reflink_unshare(ip, offset, len);
>  			if (error)
>  				goto out_unlock;
> -
> -			if (!xfs_is_always_cow_inode(ip)) {
> -				error = xfs_alloc_file_space(ip, offset, len,
> -						XFS_BMAPI_PREALLOC);
> -			}
>  		} else {
>  			/*
>  			 * If always_cow mode we can't use preallocations and
> @@ -899,12 +913,14 @@ xfs_file_fallocate(
>  				error = -EOPNOTSUPP;
>  				goto out_unlock;
>  			}
> +		}
>  
> +		if (!xfs_is_always_cow_inode(ip)) {
>  			error = xfs_alloc_file_space(ip, offset, len,
>  						     XFS_BMAPI_PREALLOC);
> +			if (error)
> +				goto out_unlock;
>  		}
> -		if (error)
> -			goto out_unlock;
>  	}
>  
>  	if (file->f_flags & O_DSYNC)
> -- 
> 2.20.1
> 
