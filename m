Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD895B6A18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfIRR5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 13:57:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfIRR5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:57:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd0Ho048019;
        Wed, 18 Sep 2019 17:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ILiVhJ7DLYxwa6MdSg+JwtPhyGoEho5XUmD4yw7lGJs=;
 b=N5rGQxW2VqcLL9u6WAshf9XX/7hH2XUhVcCNjtzHRDJ9xjnth8qHxGy1QAIxuhuWbbpF
 KdKpYS8xJvRu4JKD/06B9ABhpQ33Dn7Ri9lZ6rR5YD/tjyinA80s6tC+sQ3pt74mK+XQ
 698kjxUWTLdHTkwSq/pEcE/fwrxebhp6BuII2nKwQxnBIrtQtgJm7WdMFfIakx2/QWr1
 a5STrkUE9mMswTUP9mEDUGmdicfBT/In1D9zJ4wsIFapBPJcqWq7I8W1m2HtBS3X+Uaq
 rpm1E4+BDXWU6Nn79smOWXtuoYaBAVE8llMSAlg+xM76B7cYll1AzhuivBzj2bkp2UVi zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v385e5k4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:57:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8IHd8h5054583;
        Wed, 18 Sep 2019 17:55:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2v37may0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 17:55:31 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8IHtVRO002182;
        Wed, 18 Sep 2019 17:55:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Sep 2019 10:55:30 -0700
Date:   Wed, 18 Sep 2019 10:55:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/19] xfs: factor out a helper to calculate the end_fsb
Message-ID: <20190918175529.GF2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-14-hch@lst.de>
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
 definitions=main-1909180160
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:16PM +0200, Christoph Hellwig wrote:
> We have lots of places that want to calculate the final fsb for
> a offset + count in bytes and check that the result fits into
> s_maxbytes.  Factor out a helper for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iomap.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d12eacdc9bba..0ba67a8d8169 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -102,6 +102,17 @@ xfs_hole_to_iomap(
>  	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
>  }
>  
> +static inline xfs_fileoff_t
> +xfs_iomap_end_fsb(

I wonder if this function ought to have a comment that it returns the
offset block number of offset + count clamped to the highest offset
supported by the page cache, but ... eh.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> +	struct xfs_mount	*mp,
> +	loff_t			offset,
> +	loff_t			count)
> +{
> +	ASSERT(offset <= mp->m_super->s_maxbytes);
> +	return min(XFS_B_TO_FSB(mp, offset + count),
> +		   XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
> +}
> +
>  xfs_extlen_t
>  xfs_eof_alignment(
>  	struct xfs_inode	*ip,
> @@ -172,8 +183,8 @@ xfs_iomap_write_direct(
>  	int		nmaps)
>  {
>  	xfs_mount_t	*mp = ip->i_mount;
> -	xfs_fileoff_t	offset_fsb;
> -	xfs_fileoff_t	last_fsb;
> +	xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t	last_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  	xfs_filblks_t	count_fsb, resaligned;
>  	xfs_extlen_t	extsz;
>  	int		nimaps;
> @@ -192,8 +203,6 @@ xfs_iomap_write_direct(
>  
>  	ASSERT(xfs_isilocked(ip, lockmode));
>  
> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	last_fsb = XFS_B_TO_FSB(mp, ((xfs_ufsize_t)(offset + count)));
>  	if ((offset + count) > XFS_ISIZE(ip)) {
>  		/*
>  		 * Assert that the in-core extent list is present since this can
> @@ -533,9 +542,7 @@ xfs_file_iomap_begin_delay(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		maxbytes_fsb =
> -		XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
> -	xfs_fileoff_t		end_fsb;
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  	struct xfs_bmbt_irec	imap, cmap;
>  	struct xfs_iext_cursor	icur, ccur;
>  	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -565,8 +572,6 @@ xfs_file_iomap_begin_delay(
>  			goto out_unlock;
>  	}
>  
> -	end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
> -
>  	/*
>  	 * Search the data fork fork first to look up our source mapping.  We
>  	 * always need the data fork map, as we have to return it to the
> @@ -648,7 +653,7 @@ xfs_file_iomap_begin_delay(
>  		 * the lower level functions are updated.
>  		 */
>  		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
> -		end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
> +		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>  
>  		if (xfs_is_always_cow_inode(ip))
>  			whichfork = XFS_COW_FORK;
> @@ -674,7 +679,8 @@ xfs_file_iomap_begin_delay(
>  			if (align)
>  				p_end_fsb = roundup_64(p_end_fsb, align);
>  
> -			p_end_fsb = min(p_end_fsb, maxbytes_fsb);
> +			p_end_fsb = min(p_end_fsb,
> +				XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
>  			ASSERT(p_end_fsb > offset_fsb);
>  			prealloc_blocks = p_end_fsb - end_fsb;
>  		}
> @@ -937,7 +943,8 @@ xfs_file_iomap_begin(
>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	struct xfs_bmbt_irec	imap, cmap;
> -	xfs_fileoff_t		offset_fsb, end_fsb;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  	int			nimaps = 1, error = 0;
>  	bool			shared = false;
>  	u16			iomap_flags = 0;
> @@ -963,12 +970,6 @@ xfs_file_iomap_begin(
>  	if (error)
>  		return error;
>  
> -	ASSERT(offset <= mp->m_super->s_maxbytes);
> -	if (offset > mp->m_super->s_maxbytes - length)
> -		length = mp->m_super->s_maxbytes - offset;
> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> -
>  	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>  			       &nimaps, 0);
>  	if (error)
> @@ -1189,8 +1190,7 @@ xfs_seek_iomap_begin(
>  		/*
>  		 * Fake a hole until the end of the file.
>  		 */
> -		data_fsb = min(XFS_B_TO_FSB(mp, offset + length),
> -			       XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
> +		data_fsb = xfs_iomap_end_fsb(mp, offset, length);
>  	}
>  
>  	/*
> -- 
> 2.20.1
> 
