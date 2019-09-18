Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D6FB6A20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfIRR7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:59:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55534 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfIRR7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:59:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHx7hV064656;
        Wed, 18 Sep 2019 17:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=tA5ToDyA6YgtPEjpZnOP7/oJ9o1gcVCVqM6J+omhjHs=;
 b=g+9ixLegPqoirIYgIY/AfzhJRVwh/p7PVkca/PXU0kJ2IExudcXZ8w0a85n6uU/LwuPd
 eXjeekmk4hi7RMexO5JsZyYW2u8RI9pBuDW0pa7Hlx/3u5so0UFbIhgavOlTNfHxfCiJ
 mjC6APNFr08HOm+Yj9fdjqNczTNHuaLVc07bcWkHBrtf1KJiV3huqzkOM7kPhd8is5PL
 eGmLwQcAT0vFeIwv8EVnXsOLtb1lPK0QsQ/e/28jvkY1g+PA9Kg3EyIoHlgORDwya7Ht
 D57HsfRtRX+ZBZBWutG706UpxxDC+DNt4oV9Byp5TCsznXrED1KQLREVwei4QYkUUo3P 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v385e5kf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:59:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd57Q054423;
        Wed, 18 Sep 2019 17:59:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v37may9m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:59:06 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8IHx5Gc028761;
        Wed, 18 Sep 2019 17:59:05 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:59:04 -0700
Date:   Wed, 18 Sep 2019 10:59:02 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/19] xfs: move xfs_file_iomap_begin_delay around
Message-ID: <20190918175902.GH2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-16-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9384 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909180160
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

On Mon, Sep 09, 2019 at 08:27:18PM +0200, Christoph Hellwig wrote:
> Move xfs_file_iomap_begin_delay near the end of the file next to the
> other iomap functions to prepare for additional refactoring.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 434 +++++++++++++++++++++++----------------------
>  1 file changed, 221 insertions(+), 213 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d0ed0cba9041..7ae55503ee27 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -530,219 +530,6 @@ xfs_iomap_prealloc_size(
>  	return alloc_blocks;
>  }
>  
> -static int
> -xfs_file_iomap_begin_delay(
> -	struct inode		*inode,
> -	loff_t			offset,
> -	loff_t			count,
> -	unsigned		flags,
> -	struct iomap		*iomap,
> -	struct iomap		*srcmap)
> -{
> -	struct xfs_inode	*ip = XFS_I(inode);
> -	struct xfs_mount	*mp = ip->i_mount;
> -	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> -	struct xfs_bmbt_irec	imap, cmap;
> -	struct xfs_iext_cursor	icur, ccur;
> -	xfs_fsblock_t		prealloc_blocks = 0;
> -	bool			eof = false, cow_eof = false, shared = false;
> -	int			whichfork = XFS_DATA_FORK;
> -	int			error = 0;
> -
> -	ASSERT(!XFS_IS_REALTIME_INODE(ip));
> -	ASSERT(!xfs_get_extsz_hint(ip));
> -
> -	xfs_ilock(ip, XFS_ILOCK_EXCL);
> -
> -	if (unlikely(XFS_TEST_ERROR(
> -	    (XFS_IFORK_FORMAT(ip, XFS_DATA_FORK) != XFS_DINODE_FMT_EXTENTS &&
> -	     XFS_IFORK_FORMAT(ip, XFS_DATA_FORK) != XFS_DINODE_FMT_BTREE),
> -	     mp, XFS_ERRTAG_BMAPIFORMAT))) {
> -		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, mp);
> -		error = -EFSCORRUPTED;
> -		goto out_unlock;
> -	}
> -
> -	XFS_STATS_INC(mp, xs_blk_mapw);
> -
> -	if (!(ip->i_df.if_flags & XFS_IFEXTENTS)) {
> -		error = xfs_iread_extents(NULL, ip, XFS_DATA_FORK);
> -		if (error)
> -			goto out_unlock;
> -	}
> -
> -	/*
> -	 * Search the data fork fork first to look up our source mapping.  We
> -	 * always need the data fork map, as we have to return it to the
> -	 * iomap code so that the higher level write code can read data in to
> -	 * perform read-modify-write cycles for unaligned writes.
> -	 */
> -	eof = !xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
> -	if (eof)
> -		imap.br_startoff = end_fsb; /* fake hole until the end */
> -
> -	/* We never need to allocate blocks for zeroing a hole. */
> -	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> -		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> -		goto out_unlock;
> -	}
> -
> -	/*
> -	 * Search the COW fork extent list even if we did not find a data fork
> -	 * extent.  This serves two purposes: first this implements the
> -	 * speculative preallocation using cowextsize, so that we also unshare
> -	 * block adjacent to shared blocks instead of just the shared blocks
> -	 * themselves.  Second the lookup in the extent list is generally faster
> -	 * than going out to the shared extent tree.
> -	 */
> -	if (xfs_is_cow_inode(ip)) {
> -		if (!ip->i_cowfp) {
> -			ASSERT(!xfs_is_reflink_inode(ip));
> -			xfs_ifork_init_cow(ip);
> -		}
> -		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
> -				&ccur, &cmap);
> -		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
> -			trace_xfs_reflink_cow_found(ip, &cmap);
> -			goto found_cow;
> -		}
> -	}
> -
> -	if (imap.br_startoff <= offset_fsb) {
> -		/*
> -		 * For reflink files we may need a delalloc reservation when
> -		 * overwriting shared extents.   This includes zeroing of
> -		 * existing extents that contain data.
> -		 */
> -		if (!xfs_is_cow_inode(ip) ||
> -		    ((flags & IOMAP_ZERO) && imap.br_state != XFS_EXT_NORM)) {
> -			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
> -					&imap);
> -			goto found_imap;
> -		}
> -
> -		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> -
> -		/* Trim the mapping to the nearest shared extent boundary. */
> -		error = xfs_inode_need_cow(ip, &imap, &shared);
> -		if (error)
> -			goto out_unlock;
> -
> -		/* Not shared?  Just report the (potentially capped) extent. */
> -		if (!shared) {
> -			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
> -					&imap);
> -			goto found_imap;
> -		}
> -
> -		/*
> -		 * Fork all the shared blocks from our write offset until the
> -		 * end of the extent.
> -		 */
> -		whichfork = XFS_COW_FORK;
> -		end_fsb = imap.br_startoff + imap.br_blockcount;
> -	} else {
> -		/*
> -		 * We cap the maximum length we map here to MAX_WRITEBACK_PAGES
> -		 * pages to keep the chunks of work done where somewhat
> -		 * symmetric with the work writeback does.  This is a completely
> -		 * arbitrary number pulled out of thin air.
> -		 *
> -		 * Note that the values needs to be less than 32-bits wide until
> -		 * the lower level functions are updated.
> -		 */
> -		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
> -		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> -
> -		if (xfs_is_always_cow_inode(ip))
> -			whichfork = XFS_COW_FORK;
> -	}
> -
> -	error = xfs_qm_dqattach_locked(ip, false);
> -	if (error)
> -		goto out_unlock;
> -
> -	if (eof) {
> -		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
> -				count, &icur);
> -		if (prealloc_blocks) {
> -			xfs_extlen_t	align;
> -			xfs_off_t	end_offset;
> -			xfs_fileoff_t	p_end_fsb;
> -
> -			end_offset = XFS_WRITEIO_ALIGN(mp, offset + count - 1);
> -			p_end_fsb = XFS_B_TO_FSBT(mp, end_offset) +
> -					prealloc_blocks;
> -
> -			align = xfs_eof_alignment(ip, 0);
> -			if (align)
> -				p_end_fsb = roundup_64(p_end_fsb, align);
> -
> -			p_end_fsb = min(p_end_fsb,
> -				XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
> -			ASSERT(p_end_fsb > offset_fsb);
> -			prealloc_blocks = p_end_fsb - end_fsb;
> -		}
> -	}
> -
> -retry:
> -	error = xfs_bmapi_reserve_delalloc(ip, whichfork, offset_fsb,
> -			end_fsb - offset_fsb, prealloc_blocks,
> -			whichfork == XFS_DATA_FORK ? &imap : &cmap,
> -			whichfork == XFS_DATA_FORK ? &icur : &ccur,
> -			whichfork == XFS_DATA_FORK ? eof : cow_eof);
> -	switch (error) {
> -	case 0:
> -		break;
> -	case -ENOSPC:
> -	case -EDQUOT:
> -		/* retry without any preallocation */
> -		trace_xfs_delalloc_enospc(ip, offset, count);
> -		if (prealloc_blocks) {
> -			prealloc_blocks = 0;
> -			goto retry;
> -		}
> -		/*FALLTHRU*/
> -	default:
> -		goto out_unlock;
> -	}
> -
> -	if (whichfork == XFS_COW_FORK) {
> -		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> -		goto found_cow;
> -	}
> -
> -	/*
> -	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
> -	 * them out if the write happens to fail.
> -	 */
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, IOMAP_F_NEW);
> -
> -found_imap:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	return xfs_bmbt_to_iomap(ip, iomap, &imap, 0);
> -
> -found_cow:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	if (imap.br_startoff <= offset_fsb) {
> -		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> -		if (error)
> -			return error;
> -	} else {
> -		xfs_trim_extent(&cmap, offset_fsb,
> -				imap.br_startoff - offset_fsb);
> -	}
> -	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> -
> -out_unlock:
> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> -	return error;
> -
> -}
> -
>  int
>  xfs_iomap_write_unwritten(
>  	xfs_inode_t	*ip,
> @@ -931,6 +718,15 @@ xfs_ilock_for_iomap(
>  	return 0;
>  }
>  
> +static int
> +xfs_file_iomap_begin_delay(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			count,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap);
> +
>  static int
>  xfs_file_iomap_begin(
>  	struct inode		*inode,
> @@ -1061,6 +857,218 @@ xfs_file_iomap_begin(
>  	return error;
>  }
>  
> +static int
> +xfs_file_iomap_begin_delay(
> +	struct inode		*inode,
> +	loff_t			offset,
> +	loff_t			count,
> +	unsigned		flags,
> +	struct iomap		*iomap,
> +	struct iomap		*srcmap)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +	struct xfs_bmbt_irec	imap, cmap;
> +	struct xfs_iext_cursor	icur, ccur;
> +	xfs_fsblock_t		prealloc_blocks = 0;
> +	bool			eof = false, cow_eof = false, shared = false;
> +	int			whichfork = XFS_DATA_FORK;
> +	int			error = 0;
> +
> +	ASSERT(!XFS_IS_REALTIME_INODE(ip));
> +	ASSERT(!xfs_get_extsz_hint(ip));
> +
> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> +
> +	if (unlikely(XFS_TEST_ERROR(
> +	    (XFS_IFORK_FORMAT(ip, XFS_DATA_FORK) != XFS_DINODE_FMT_EXTENTS &&
> +	     XFS_IFORK_FORMAT(ip, XFS_DATA_FORK) != XFS_DINODE_FMT_BTREE),
> +	     mp, XFS_ERRTAG_BMAPIFORMAT))) {
> +		XFS_ERROR_REPORT(__func__, XFS_ERRLEVEL_LOW, mp);
> +		error = -EFSCORRUPTED;
> +		goto out_unlock;
> +	}
> +
> +	XFS_STATS_INC(mp, xs_blk_mapw);
> +
> +	if (!(ip->i_df.if_flags & XFS_IFEXTENTS)) {
> +		error = xfs_iread_extents(NULL, ip, XFS_DATA_FORK);
> +		if (error)
> +			goto out_unlock;
> +	}
> +
> +	/*
> +	 * Search the data fork fork first to look up our source mapping.  We
> +	 * always need the data fork map, as we have to return it to the
> +	 * iomap code so that the higher level write code can read data in to
> +	 * perform read-modify-write cycles for unaligned writes.
> +	 */
> +	eof = !xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
> +	if (eof)
> +		imap.br_startoff = end_fsb; /* fake hole until the end */
> +
> +	/* We never need to allocate blocks for zeroing a hole. */
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * Search the COW fork extent list even if we did not find a data fork
> +	 * extent.  This serves two purposes: first this implements the
> +	 * speculative preallocation using cowextsize, so that we also unshare
> +	 * block adjacent to shared blocks instead of just the shared blocks
> +	 * themselves.  Second the lookup in the extent list is generally faster
> +	 * than going out to the shared extent tree.
> +	 */
> +	if (xfs_is_cow_inode(ip)) {
> +		if (!ip->i_cowfp) {
> +			ASSERT(!xfs_is_reflink_inode(ip));
> +			xfs_ifork_init_cow(ip);
> +		}
> +		cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
> +				&ccur, &cmap);
> +		if (!cow_eof && cmap.br_startoff <= offset_fsb) {
> +			trace_xfs_reflink_cow_found(ip, &cmap);
> +			goto found_cow;
> +		}
> +	}
> +
> +	if (imap.br_startoff <= offset_fsb) {
> +		/*
> +		 * For reflink files we may need a delalloc reservation when
> +		 * overwriting shared extents.   This includes zeroing of
> +		 * existing extents that contain data.
> +		 */
> +		if (!xfs_is_cow_inode(ip) ||
> +		    ((flags & IOMAP_ZERO) && imap.br_state != XFS_EXT_NORM)) {
> +			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
> +					&imap);
> +			goto found_imap;
> +		}
> +
> +		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
> +
> +		/* Trim the mapping to the nearest shared extent boundary. */
> +		error = xfs_inode_need_cow(ip, &imap, &shared);
> +		if (error)
> +			goto out_unlock;
> +
> +		/* Not shared?  Just report the (potentially capped) extent. */
> +		if (!shared) {
> +			trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
> +					&imap);
> +			goto found_imap;
> +		}
> +
> +		/*
> +		 * Fork all the shared blocks from our write offset until the
> +		 * end of the extent.
> +		 */
> +		whichfork = XFS_COW_FORK;
> +		end_fsb = imap.br_startoff + imap.br_blockcount;
> +	} else {
> +		/*
> +		 * We cap the maximum length we map here to MAX_WRITEBACK_PAGES
> +		 * pages to keep the chunks of work done where somewhat
> +		 * symmetric with the work writeback does.  This is a completely
> +		 * arbitrary number pulled out of thin air.
> +		 *
> +		 * Note that the values needs to be less than 32-bits wide until
> +		 * the lower level functions are updated.
> +		 */
> +		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
> +		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
> +
> +		if (xfs_is_always_cow_inode(ip))
> +			whichfork = XFS_COW_FORK;
> +	}
> +
> +	error = xfs_qm_dqattach_locked(ip, false);
> +	if (error)
> +		goto out_unlock;
> +
> +	if (eof) {
> +		prealloc_blocks = xfs_iomap_prealloc_size(ip, whichfork, offset,
> +				count, &icur);
> +		if (prealloc_blocks) {
> +			xfs_extlen_t	align;
> +			xfs_off_t	end_offset;
> +			xfs_fileoff_t	p_end_fsb;
> +
> +			end_offset = XFS_WRITEIO_ALIGN(mp, offset + count - 1);
> +			p_end_fsb = XFS_B_TO_FSBT(mp, end_offset) +
> +					prealloc_blocks;
> +
> +			align = xfs_eof_alignment(ip, 0);
> +			if (align)
> +				p_end_fsb = roundup_64(p_end_fsb, align);
> +
> +			p_end_fsb = min(p_end_fsb,
> +		   		XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));

Might as well fix the indenting damage here?

With that fixed,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +			ASSERT(p_end_fsb > offset_fsb);
> +			prealloc_blocks = p_end_fsb - end_fsb;
> +		}
> +	}
> +
> +retry:
> +	error = xfs_bmapi_reserve_delalloc(ip, whichfork, offset_fsb,
> +			end_fsb - offset_fsb, prealloc_blocks,
> +			whichfork == XFS_DATA_FORK ? &imap : &cmap,
> +			whichfork == XFS_DATA_FORK ? &icur : &ccur,
> +			whichfork == XFS_DATA_FORK ? eof : cow_eof);
> +	switch (error) {
> +	case 0:
> +		break;
> +	case -ENOSPC:
> +	case -EDQUOT:
> +		/* retry without any preallocation */
> +		trace_xfs_delalloc_enospc(ip, offset, count);
> +		if (prealloc_blocks) {
> +			prealloc_blocks = 0;
> +			goto retry;
> +		}
> +		/*FALLTHRU*/
> +	default:
> +		goto out_unlock;
> +	}
> +
> +	if (whichfork == XFS_COW_FORK) {
> +		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
> +		goto found_cow;
> +	}
> +
> +	/*
> +	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
> +	 * them out if the write happens to fail.
> +	 */
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
> +		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, 0);
> +		if (error)
> +			return error;
> +	} else {
> +		xfs_trim_extent(&cmap, offset_fsb,
> +				imap.br_startoff - offset_fsb);
> +	}
> +	return xfs_bmbt_to_iomap(ip, iomap, &cmap, IOMAP_F_SHARED);
> +
> +out_unlock:
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +	return error;
> +}
> +
>  static int
>  xfs_file_iomap_end_delalloc(
>  	struct xfs_inode	*ip,
> -- 
> 2.20.1
> 
