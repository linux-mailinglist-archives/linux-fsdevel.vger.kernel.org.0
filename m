Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32B89D7E53
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfJOSAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 14:00:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45484 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfJOSAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 14:00:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmctF077103;
        Tue, 15 Oct 2019 18:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=bGzfVb3yG+riR1e+Cglfn5fweSx+L4ckA+uA0cCeuLo=;
 b=PPsGD5chXI1rkMH4IOGqQ88BaC0eHsh22zfaAHOERqPvU2E5xlVul9kKsnAgxQP6zsq6
 pQn+5gI87WBN4PN3iakNmdKv8gyBTP3/M8UOumeSSQynmBLrIS7scR75goLlSAA3H5+c
 a+8YH/Ugsv1FOYA6fPMNXql+9MVAI9A/CJVtrmZ87pS7c6FCGlc36mEBv1hXotA9sm2N
 O8PQUnCvf31Zgbv6hiOMDCZd2F+nWUMo7QGm19lAiQr++m0mC8JWZhHmsglR7/JOsYGw
 X6nceahid6xQLcwunoSUlZdJaC1H/rHN0jc9YcHjI4dYB9Ybbt4113ykBZB6mJm9ZYGs 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vk6sqhu11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:00:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9FHmuXq121560;
        Tue, 15 Oct 2019 18:00:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vn718saxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 18:00:37 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9FI0a5p005633;
        Tue, 15 Oct 2019 18:00:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 11:00:36 -0700
Date:   Tue, 15 Oct 2019 11:00:34 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] xfs: initialize iomap->flags in xfs_bmbt_to_iomap
Message-ID: <20191015180034.GP13108@magnolia>
References: <20191015154345.13052-1-hch@lst.de>
 <20191015154345.13052-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015154345.13052-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910150153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910150153
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 15, 2019 at 05:43:34PM +0200, Christoph Hellwig wrote:
> Currently we don't overwrite the flags field in the iomap in
> xfs_bmbt_to_iomap.  This works fine with 0-initialized iomaps on stack,
> but is harmful once we want to be able to reuse an iomap in the
> writeback code.  Replace the shared paramter with a set of initial

"parameter"

Looks ok otherwise,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> flags an thus ensures the flags field is always reinitialized.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 28 +++++++++++++++++-----------
>  fs/xfs/xfs_iomap.h |  2 +-
>  fs/xfs/xfs_pnfs.c  |  2 +-
>  3 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index f780e223b118..54c9ec7ad337 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -54,7 +54,7 @@ xfs_bmbt_to_iomap(
>  	struct xfs_inode	*ip,
>  	struct iomap		*iomap,
>  	struct xfs_bmbt_irec	*imap,
> -	bool			shared)
> +	u16			flags)
>  {
>  	struct xfs_mount	*mp = ip->i_mount;
>  
> @@ -79,12 +79,11 @@ xfs_bmbt_to_iomap(
>  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
>  	iomap->bdev = xfs_find_bdev_for_inode(VFS_I(ip));
>  	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
> +	iomap->flags = flags;
>  
>  	if (xfs_ipincount(ip) &&
>  	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
>  		iomap->flags |= IOMAP_F_DIRTY;
> -	if (shared)
> -		iomap->flags |= IOMAP_F_SHARED;
>  	return 0;
>  }
>  
> @@ -540,6 +539,7 @@ xfs_file_iomap_begin_delay(
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
>  	bool			eof = false, cow_eof = false, shared = false;
> +	u16			iomap_flags = 0;
>  	int			whichfork = XFS_DATA_FORK;
>  	int			error = 0;
>  
> @@ -707,7 +707,7 @@ xfs_file_iomap_begin_delay(
>  	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
>  	 * them out if the write happens to fail.
>  	 */
> -	iomap->flags |= IOMAP_F_NEW;
> +	iomap_flags |= IOMAP_F_NEW;
>  	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
>  			whichfork == XFS_DATA_FORK ? &imap : &cmap);
>  done:
> @@ -715,14 +715,17 @@ xfs_file_iomap_begin_delay(
>  		if (imap.br_startoff > offset_fsb) {
>  			xfs_trim_extent(&cmap, offset_fsb,
>  					imap.br_startoff - offset_fsb);
> -			error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
> +			error = xfs_bmbt_to_iomap(ip, iomap, &cmap,
> +					IOMAP_F_SHARED);
>  			goto out_unlock;
>  		}
>  		/* ensure we only report blocks we have a reservation for */
>  		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
>  		shared = true;
>  	}
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
> +	if (shared)
> +		iomap_flags |= IOMAP_F_SHARED;
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  	return error;
> @@ -930,6 +933,7 @@ xfs_file_iomap_begin(
>  	xfs_fileoff_t		offset_fsb, end_fsb;
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
> +	u16			iomap_flags = 0;
>  	unsigned		lockmode;
>  
>  	if (XFS_FORCED_SHUTDOWN(mp))
> @@ -1045,11 +1049,13 @@ xfs_file_iomap_begin(
>  	if (error)
>  		return error;
>  
> -	iomap->flags |= IOMAP_F_NEW;
> +	iomap_flags |= IOMAP_F_NEW;
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
>  
>  out_finish:
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
> +	if (shared)
> +		iomap_flags |= IOMAP_F_SHARED;
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, iomap_flags);
>  
>  out_found:
>  	ASSERT(nimaps);
> @@ -1193,7 +1199,7 @@ xfs_seek_iomap_begin(
>  		if (data_fsb < cow_fsb + cmap.br_blockcount)
>  			end_fsb = min(end_fsb, data_fsb);
>  		xfs_trim_extent(&cmap, offset_fsb, end_fsb);
> -		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, true);
> +		error = xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
>  		/*
>  		 * This is a COW extent, so we must probe the page cache
>  		 * because there could be dirty page cache being backed
> @@ -1215,7 +1221,7 @@ xfs_seek_iomap_begin(
>  	imap.br_state = XFS_EXT_NORM;
>  done:
>  	xfs_trim_extent(&imap, offset_fsb, end_fsb);
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  out_unlock:
>  	xfs_iunlock(ip, lockmode);
>  	return error;
> @@ -1261,7 +1267,7 @@ xfs_xattr_iomap_begin(
>  	if (error)
>  		return error;
>  	ASSERT(nimaps);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  }
>  
>  const struct iomap_ops xfs_xattr_iomap_ops = {
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 5c2f6aa6d78f..71d0ae460c44 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -16,7 +16,7 @@ int xfs_iomap_write_direct(struct xfs_inode *, xfs_off_t, size_t,
>  int xfs_iomap_write_unwritten(struct xfs_inode *, xfs_off_t, xfs_off_t, bool);
>  
>  int xfs_bmbt_to_iomap(struct xfs_inode *, struct iomap *,
> -		struct xfs_bmbt_irec *, bool shared);
> +		struct xfs_bmbt_irec *, u16);
>  xfs_extlen_t xfs_eof_alignment(struct xfs_inode *ip, xfs_extlen_t extsize);
>  
>  static inline xfs_filblks_t
> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index a339bd5fa260..9c96493be9e0 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -178,7 +178,7 @@ xfs_fs_map_blocks(
>  	}
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  
> -	error = xfs_bmbt_to_iomap(ip, iomap, &imap, false);
> +	error = xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
>  	*device_generation = mp->m_generation;
>  	return error;
>  out_unlock:
> -- 
> 2.20.1
> 
