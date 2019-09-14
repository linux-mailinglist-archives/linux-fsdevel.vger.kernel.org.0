Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D065B2928
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbfINAmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 20:42:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388296AbfINAmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:42:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cXOx053662;
        Sat, 14 Sep 2019 00:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 references : message-id : date : mime-version : in-reply-to : content-type
 : content-transfer-encoding; s=corp-2019-08-05;
 bh=JIlsIFctdQfQmaWqEIwsoscnJvi3fzDVX3ZTQvW9q0w=;
 b=Of+sM23gi5UtULzvuCDShKMc9tGgfpCoKE+1P5HWVBu+1gs51TpBoSLEbEnnH/R+1VNj
 rd/3d8A15h0iLSXSf+AOAzaz8S7661IRG4WE3qoP6MQXA2NDSWVPwo+CH77PxuRafbjS
 O1DE4BEVn3GfA6ewCAsXlybuAiJwXKRGyARe/fRe0Z2rRgDyze2W5kbfF8YGnAWCzhpK
 fcZpcvH4Fs/j83KUs4H0NRQSrcap33EHzvvb4i7AW/tsv/Qfc7Sl8VYCXGL2AyWpqTh8
 geEEDdZhip332qPXHYo6dTs9GbfFd6ytQbutwwatRZEG7PbBc58xV1iQUpfHHK1vB9Gu gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2uytd37kej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8E0cYQP065906;
        Sat, 14 Sep 2019 00:42:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v0mm0ap4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Sep 2019 00:42:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8E0gj7I026633;
        Sat, 14 Sep 2019 00:42:45 GMT
Received: from [192.168.1.9] (/67.1.21.243)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 17:42:45 -0700
From:   Allison Collins <allison.henderson@oracle.com>
Subject: Re: [PATCH 13/19] xfs: factor out a helper to calculate the end_fsb
To:     Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-14-hch@lst.de>
Message-ID: <a7926d72-bbee-eb3d-124d-ebcb094de6ea@oracle.com>
Date:   Fri, 13 Sep 2019 17:42:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909182722.16783-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909140004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909140004
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks Ok to me:
Reviewed-by: Allison Collins <allison.henderson@oracle.com>

On 9/9/19 11:27 AM, Christoph Hellwig wrote:
> We have lots of places that want to calculate the final fsb for
> a offset + count in bytes and check that the result fits into
> s_maxbytes.  Factor out a helper for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/xfs/xfs_iomap.c | 40 ++++++++++++++++++++--------------------
>   1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index d12eacdc9bba..0ba67a8d8169 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -102,6 +102,17 @@ xfs_hole_to_iomap(
>   	iomap->dax_dev = xfs_find_daxdev_for_inode(VFS_I(ip));
>   }
>   
> +static inline xfs_fileoff_t
> +xfs_iomap_end_fsb(
> +	struct xfs_mount	*mp,
> +	loff_t			offset,
> +	loff_t			count)
> +{
> +	ASSERT(offset <= mp->m_super->s_maxbytes);
> +	return min(XFS_B_TO_FSB(mp, offset + count),
> +		   XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
> +}
> +
>   xfs_extlen_t
>   xfs_eof_alignment(
>   	struct xfs_inode	*ip,
> @@ -172,8 +183,8 @@ xfs_iomap_write_direct(
>   	int		nmaps)
>   {
>   	xfs_mount_t	*mp = ip->i_mount;
> -	xfs_fileoff_t	offset_fsb;
> -	xfs_fileoff_t	last_fsb;
> +	xfs_fileoff_t	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t	last_fsb = xfs_iomap_end_fsb(mp, offset, count);
>   	xfs_filblks_t	count_fsb, resaligned;
>   	xfs_extlen_t	extsz;
>   	int		nimaps;
> @@ -192,8 +203,6 @@ xfs_iomap_write_direct(
>   
>   	ASSERT(xfs_isilocked(ip, lockmode));
>   
> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	last_fsb = XFS_B_TO_FSB(mp, ((xfs_ufsize_t)(offset + count)));
>   	if ((offset + count) > XFS_ISIZE(ip)) {
>   		/*
>   		 * Assert that the in-core extent list is present since this can
> @@ -533,9 +542,7 @@ xfs_file_iomap_begin_delay(
>   	struct xfs_inode	*ip = XFS_I(inode);
>   	struct xfs_mount	*mp = ip->i_mount;
>   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	xfs_fileoff_t		maxbytes_fsb =
> -		XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
> -	xfs_fileoff_t		end_fsb;
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>   	struct xfs_bmbt_irec	imap, cmap;
>   	struct xfs_iext_cursor	icur, ccur;
>   	xfs_fsblock_t		prealloc_blocks = 0;
> @@ -565,8 +572,6 @@ xfs_file_iomap_begin_delay(
>   			goto out_unlock;
>   	}
>   
> -	end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
> -
>   	/*
>   	 * Search the data fork fork first to look up our source mapping.  We
>   	 * always need the data fork map, as we have to return it to the
> @@ -648,7 +653,7 @@ xfs_file_iomap_begin_delay(
>   		 * the lower level functions are updated.
>   		 */
>   		count = min_t(loff_t, count, 1024 * PAGE_SIZE);
> -		end_fsb = min(XFS_B_TO_FSB(mp, offset + count), maxbytes_fsb);
> +		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
>   
>   		if (xfs_is_always_cow_inode(ip))
>   			whichfork = XFS_COW_FORK;
> @@ -674,7 +679,8 @@ xfs_file_iomap_begin_delay(
>   			if (align)
>   				p_end_fsb = roundup_64(p_end_fsb, align);
>   
> -			p_end_fsb = min(p_end_fsb, maxbytes_fsb);
> +			p_end_fsb = min(p_end_fsb,
> +				XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
>   			ASSERT(p_end_fsb > offset_fsb);
>   			prealloc_blocks = p_end_fsb - end_fsb;
>   		}
> @@ -937,7 +943,8 @@ xfs_file_iomap_begin(
>   	struct xfs_inode	*ip = XFS_I(inode);
>   	struct xfs_mount	*mp = ip->i_mount;
>   	struct xfs_bmbt_irec	imap, cmap;
> -	xfs_fileoff_t		offset_fsb, end_fsb;
> +	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> +	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
>   	int			nimaps = 1, error = 0;
>   	bool			shared = false;
>   	u16			iomap_flags = 0;
> @@ -963,12 +970,6 @@ xfs_file_iomap_begin(
>   	if (error)
>   		return error;
>   
> -	ASSERT(offset <= mp->m_super->s_maxbytes);
> -	if (offset > mp->m_super->s_maxbytes - length)
> -		length = mp->m_super->s_maxbytes - offset;
> -	offset_fsb = XFS_B_TO_FSBT(mp, offset);
> -	end_fsb = XFS_B_TO_FSB(mp, offset + length);
> -
>   	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
>   			       &nimaps, 0);
>   	if (error)
> @@ -1189,8 +1190,7 @@ xfs_seek_iomap_begin(
>   		/*
>   		 * Fake a hole until the end of the file.
>   		 */
> -		data_fsb = min(XFS_B_TO_FSB(mp, offset + length),
> -			       XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
> +		data_fsb = xfs_iomap_end_fsb(mp, offset, length);
>   	}
>   
>   	/*
> 
