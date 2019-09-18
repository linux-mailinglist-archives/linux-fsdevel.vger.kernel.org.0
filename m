Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8210B6A43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 20:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfIRSJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 14:09:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35816 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbfIRSJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:09:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx39l103913;
        Wed, 18 Sep 2019 18:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=c91cAFvOytVQ1UwaIASTXrwTPX4ReWXiVoqg8P+QogA=;
 b=Tk6ybYkDy3NeWeXidEoS/QD9crkoT6s8q+BvWZA2lklOekN2UAY/xAJFo+kqyxeuwWks
 Vf8iH5S771ypixhH/3tXyfPgn/VWsbIm9YwUGue9WmjAaUWT2GLoxcTRGpsGlhHUabOW
 pmx7+QwW5enSdD5BIeYI7n4jz868Um8a1lv+PfeI43/jw+VqCJnNgGko/Vm3nrCLhD8z
 11M7ZDq3RVUePsIDh3qr5xU6XhPxX3mgkb+mtlfhXh9Cwk0Q1Gfd7G6zeg3LbiL2FODb
 K8s1jFgGEITYtbjdhUKzA1OmRFJKO/E5xeDdgQ+V8rbtwlg8v2J1sDNS9KgvamUJUcA3 rQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v385dwphv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:09:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8II3h72038312;
        Wed, 18 Sep 2019 18:09:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v37mn2yh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 18:09:02 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8II92M7002733;
        Wed, 18 Sep 2019 18:09:02 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 11:09:02 -0700
Date:   Wed, 18 Sep 2019 11:09:01 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/19] xfs: improve the IOMAP_NOWAIT check for COW inodes
Message-ID: <20190918180901.GL2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-20-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-20-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909180161
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:22PM +0200, Christoph Hellwig wrote:
> Only bail out once we know that a COW allocation is actually required,
> similar to how we handle normal data fork allocations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

/me is still a little fuzzy about what NOWAIT is actually supposed to
mean (no waiting for fs metadata to load?  no waiting on other io to the
same device?  no waiting for anything, period?) but afaict this doesn't
seem to change the behavior much...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_iomap.c | 23 +++++------------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index e4e79aa5b695..9e1b4b94acac 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -693,15 +693,8 @@ xfs_ilock_for_iomap(
>  	 * COW writes may allocate delalloc space or convert unwritten COW
>  	 * extents, so we need to make sure to take the lock exclusively here.
>  	 */
> -	if (xfs_is_cow_inode(ip) && is_write) {
> -		/*
> -		 * FIXME: It could still overwrite on unshared extents and not
> -		 * need allocation.
> -		 */
> -		if (flags & IOMAP_NOWAIT)
> -			return -EAGAIN;
> +	if (xfs_is_cow_inode(ip) && is_write)
>  		mode = XFS_ILOCK_EXCL;
> -	}
>  
>  	/*
>  	 * Extents not yet cached requires exclusive access, don't block.  This
> @@ -760,12 +753,6 @@ xfs_direct_write_iomap_begin(
>  	if (XFS_FORCED_SHUTDOWN(mp))
>  		return -EIO;
>  
> -	/*
> -	 * Lock the inode in the manner required for the specified operation and
> -	 * check for as many conditions that would result in blocking as
> -	 * possible. This removes most of the non-blocking checks from the
> -	 * mapping code below.
> -	 */
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -775,11 +762,11 @@ xfs_direct_write_iomap_begin(
>  	if (error)
>  		goto out_unlock;
>  
> -	/*
> -	 * Break shared extents if necessary. Checks for non-blocking IO have
> -	 * been done up front, so we don't need to do them here.
> -	 */
>  	if (imap_needs_cow(ip, &imap, flags, nimaps)) {
> +		error = -EAGAIN;
> +		if (flags & IOMAP_NOWAIT)
> +			goto out_unlock;
> +
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>  				&lockmode, flags & IOMAP_DIRECT);
> -- 
> 2.20.1
> 
