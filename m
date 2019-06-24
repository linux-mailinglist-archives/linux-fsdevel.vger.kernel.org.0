Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5944E51019
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfFXPPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 11:15:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56876 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfFXPPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:15:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFECoq071721;
        Mon, 24 Jun 2019 15:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=K2nF3E6XseZb+sJVbpB/EPZWQ5pUv4zPKdLyAreNOeQ=;
 b=tTbnK/vSuSa/WFsaptNDxZHOGxUMqS8lmHdzq0BRMVHDBGNihqRcZwy7kJVr8k6ag7RL
 X0FIAd02B28xMSzH+fRqWndtIb7Qw/Um9Mqamdp9nUtdjxj9vaVcpJh1z9N+vihDaH90
 Uej6lAZjeSzXYFFtLwsbrh2JTcXgM1yOCvCesULk6OlXMsJNUsMStk17Z1RnI4TiXA7u
 dQya6dyibkajKJgk96csInRebW5GNNeq0m6qcJn/MEvUzrWMtmzakakVu6I9Z3mXL6NI
 EYvFTPHiWPKPmnTV1eXVR5hqYH3kXFGoY5LHfyBIG184Hkdse1xBtXt2+dH3/EDLyowK WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t9cyq7023-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:15:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OFEkLB095843;
        Mon, 24 Jun 2019 15:15:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6tn1ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 15:15:01 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OFF0xw004130;
        Mon, 24 Jun 2019 15:15:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 08:14:59 -0700
Date:   Mon, 24 Jun 2019 08:14:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] xfs: simplify xfs_chain_bio
Message-ID: <20190624151458.GI5387@magnolia>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624055253.31183-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240123
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:52:43AM +0200, Christoph Hellwig wrote:
> Move setting up operation and write hint to xfs_alloc_ioend, and
> then just copy over all needed information from the previous bio
> in xfs_chain_bio and stop passing various parameters to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I always thought it was a little odd that we were still setting bio
fields in the submission function...

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/xfs/xfs_aops.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index a6f0f4761a37..9cceb90e77c5 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -665,7 +665,6 @@ xfs_submit_ioend(
>  
>  	ioend->io_bio->bi_private = ioend;
>  	ioend->io_bio->bi_end_io = xfs_end_bio;
> -	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
>  
>  	/*
>  	 * If we are failing the IO now, just mark the ioend with an
> @@ -679,7 +678,6 @@ xfs_submit_ioend(
>  		return status;
>  	}
>  
> -	ioend->io_bio->bi_write_hint = ioend->io_inode->i_write_hint;
>  	submit_bio(ioend->io_bio);
>  	return 0;
>  }
> @@ -691,7 +689,8 @@ xfs_alloc_ioend(
>  	xfs_exntst_t		state,
>  	xfs_off_t		offset,
>  	struct block_device	*bdev,
> -	sector_t		sector)
> +	sector_t		sector,
> +	struct writeback_control *wbc)
>  {
>  	struct xfs_ioend	*ioend;
>  	struct bio		*bio;
> @@ -699,6 +698,8 @@ xfs_alloc_ioend(
>  	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &xfs_ioend_bioset);
>  	bio_set_dev(bio, bdev);
>  	bio->bi_iter.bi_sector = sector;
> +	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
> +	bio->bi_write_hint = inode->i_write_hint;
>  
>  	ioend = container_of(bio, struct xfs_ioend, io_inline_bio);
>  	INIT_LIST_HEAD(&ioend->io_list);
> @@ -719,24 +720,22 @@ xfs_alloc_ioend(
>   * so that the bi_private linkage is set up in the right direction for the
>   * traversal in xfs_destroy_ioend().
>   */
> -static void
> +static struct bio *
>  xfs_chain_bio(
> -	struct xfs_ioend	*ioend,
> -	struct writeback_control *wbc,
> -	struct block_device	*bdev,
> -	sector_t		sector)
> +	struct bio		*prev)
>  {
>  	struct bio *new;
>  
>  	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
> -	bio_set_dev(new, bdev);
> -	new->bi_iter.bi_sector = sector;
> -	bio_chain(ioend->io_bio, new);
> -	bio_get(ioend->io_bio);		/* for xfs_destroy_ioend */
> -	ioend->io_bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
> -	ioend->io_bio->bi_write_hint = ioend->io_inode->i_write_hint;
> -	submit_bio(ioend->io_bio);
> -	ioend->io_bio = new;
> +	bio_copy_dev(new, prev);
> +	new->bi_iter.bi_sector = bio_end_sector(prev);
> +	new->bi_opf = prev->bi_opf;
> +	new->bi_write_hint = prev->bi_write_hint;
> +
> +	bio_chain(prev, new);
> +	bio_get(prev);		/* for xfs_destroy_ioend */
> +	submit_bio(prev);
> +	return new;
>  }
>  
>  /*
> @@ -771,14 +770,14 @@ xfs_add_to_ioend(
>  		if (wpc->ioend)
>  			list_add(&wpc->ioend->io_list, iolist);
>  		wpc->ioend = xfs_alloc_ioend(inode, wpc->fork,
> -				wpc->imap.br_state, offset, bdev, sector);
> +				wpc->imap.br_state, offset, bdev, sector, wbc);
>  	}
>  
>  	if (!__bio_try_merge_page(wpc->ioend->io_bio, page, len, poff, true)) {
>  		if (iop)
>  			atomic_inc(&iop->write_count);
>  		if (bio_full(wpc->ioend->io_bio))
> -			xfs_chain_bio(wpc->ioend, wbc, bdev, sector);
> +			wpc->ioend->io_bio = xfs_chain_bio(wpc->ioend->io_bio);
>  		bio_add_page(wpc->ioend->io_bio, page, len, poff);
>  	}
>  
> -- 
> 2.20.1
> 
