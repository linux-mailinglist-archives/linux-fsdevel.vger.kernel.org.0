Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCB11B6967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfIRRcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:32:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57082 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbfIRRcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHO9oX074641;
        Wed, 18 Sep 2019 17:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=y3yvB9o5peEfSJ3/KZpS6cvqexwlG9BX6KOgJIcOF7Y=;
 b=W3GArmrizpn46hE5QVozajFB6ANWeC6zo688Ol78SFPlEvTN4tJXbJy1JH/wUN7vGKyv
 E2pEpj++7wqSB5WSjj9nQRt/XhBcZYE5EIH0vXF/6KCTar3xOK6Xz9+0Bu9yZhaNY2q2
 Oui+a6/2tGJSxzE4Vp7FG/1Qsgjd8cUlUIiMAtHP4g4DbeIeKUqh0zbIBeeZ85Za5G4t
 lTEbcDgphUGWTkV4q7735rFjtZpoKUzM11m/LoYpHs2jxkfntAclgbg8mZ9sNFpmyMMW
 Hg+xjvU6+G2zaJ5tFGj1OyD4jVbSgdsM4/qXaS/HcvCqURIvzoDZ8bhPe2xLiwKNbKzc eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2v385dwg7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:32:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHMoMl078201;
        Wed, 18 Sep 2019 17:30:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2v37mndm5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:30:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IHUdci009003;
        Wed, 18 Sep 2019 17:30:39 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:30:39 -0700
Date:   Wed, 18 Sep 2019 10:30:38 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/19] xfs: refactor xfs_file_iomap_begin_delay
Message-ID: <20190918173038.GC2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-12-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180159
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:14PM +0200, Christoph Hellwig wrote:
> Rejuggle the return path to prepare for filling out a source iomap.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 48 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index b228d1dbf59f..18a0f8a5d8c9 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -539,7 +539,6 @@ xfs_file_iomap_begin_delay(
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
>  	bool			eof = false, cow_eof = false, shared = false;
> -	u16			iomap_flags = 0;
>  	int			whichfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> @@ -600,8 +599,7 @@ xfs_file_iomap_begin_delay(
>  				&ccur, &cmap);
>  		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
>  			trace_xfs_reflink_cow_found(ip, &cmap);
> -			whichfork = XFS_COW_FORK;
> -			goto done;
> +			goto found_cow;
>  		}
>  	}
>  
> @@ -615,7 +613,7 @@ xfs_file_iomap_begin_delay(
>  		    ((flags & IOMAP_ZERO) && imap.br_state != XFS_EXT_NORM)) {
>  			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
>  					&imap);
> -			goto done;
> +			goto found_imap;
>  		}
>  
>  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> @@ -629,7 +627,7 @@ xfs_file_iomap_begin_delay(
>  		if (!shared) {
>  			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
>  					&imap);
> -			goto done;
> +			goto found_imap;
>  		}
>  
>  		/*
> @@ -703,35 +701,37 @@ xfs_file_iomap_begin_delay(
>  		goto out_unlock;
>  	}
>  
> +	if (whichfork == XFS_COW_FORK) {
> +		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> +		goto found_cow;
> +	}
> +
>  	/*
>  	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
>  	 * them out if the write happens to fail.
>  	 */
> -	if (whichfork == XFS_DATA_FORK) {
> -		iomap_flags |= IOMAP_F_NEW;
> -		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> -	} else {
> -		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> -	}
> -done:
> -	if (whichfork == XFS_COW_FORK) {
> -		if (imap.br_startoff > offset_fsb) {
> -			xfs_trim_extent(&cmap, offset_fsb,
> -					imap.br_startoff - offset_fsb);
> -			error = xfs_bmbt_to_iomap(ip, iomap, &cmap,
> -					IOMAP_F_SHARED);
> -			goto out_unlock;
> -		}
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
> +
> +found_imap:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> +
> +found_cow:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	if (imap.br_startoff <= offset_fsb) {
>  		/* ensure we only report blocks we have a reservation for */
>  		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
> -		shared = true;
> +		return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_SHARED);
>  	}
> -	if (shared)
> -		iomap_flags |= IOMAP_F_SHARED;
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
> +	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
> +
>  }
>  
>  int
> -- 
> 2.20.1
> 
