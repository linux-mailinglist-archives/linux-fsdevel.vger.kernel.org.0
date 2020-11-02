Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7872A3090
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgKBQzT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 11:55:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59744 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgKBQzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:55:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2GipSt125557;
        Mon, 2 Nov 2020 16:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=fpbCG2OtM1Up+kxO9vDyx7qYKStM0Y5WPsRxKyG/cJI=;
 b=uv8V4Qf4EQB9/QknsVF9Fi+L5IzOM4Wwg0EdpgdoVrzuOAiw0U7kWc2aDPwhz/5P2nfO
 zvgqR+c6RnG5U434+RUrVh30FYJx3U/3jjyrpCN7OA6PQx844u6C0NeBdcauoa4c78Hm
 eCakjsdk+baDOOmmLcq41BgFp5XKu29bePRp3OhdeSzcD890v2BVLKbWTrHBVMC2MZwz
 t/SwcXA+DTQikvbYJBR/QOPIuwAg4gf5sdjD3j+xOFswEV7ZLSzRtPDgmTCzmQcFK6+7
 2i2YRwz8GcfhqIvmeQ/U+6ORLu54UIuwVlOFNsf5VCztdUPKkKxrNNNAG8SPWet/tB1x hQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34hhw2d26h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 16:55:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2Gijnr188226;
        Mon, 2 Nov 2020 16:55:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34jf46sw14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 16:55:07 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A2Gt4LQ017674;
        Mon, 2 Nov 2020 16:55:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 08:55:04 -0800
Date:   Mon, 2 Nov 2020 08:55:02 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v9 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201102165502.GA7123@magnolia>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 clxscore=1011 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020129
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:09PM +0900, Naohiro Aota wrote:
> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
> REQ_OP_ZONE_APPEND.
> 
> To utilize it, we need to set the bio_op before calling
> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
> and restricted bio.

Would you mind putting this paragraph in a comment before the
bio_iov_iter_get_pages call?  I could easily see someone (i.e. 2021 me)
forgetting there's a data dependency and breaking this.

> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/iomap/direct-io.c  | 22 ++++++++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..e534703c5594 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -210,6 +210,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
> +	bool zone_append = false;
>  	int nr_pages, ret = 0;
>  	size_t copied = 0;
>  	size_t orig_count;
> @@ -241,6 +242,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			use_fua = true;
>  	}
>  
> +	zone_append = ;
> +
>  	/*
>  	 * Save the original count and trim the iter to just the extent we
>  	 * are operating on right now.  The iter will be re-expanded once
> @@ -278,6 +281,19 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +		if (dio->flags & IOMAP_DIO_WRITE) {
> +			bio->bi_opf = (zone_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE) |
> +				      REQ_SYNC | REQ_IDLE;
> +			if (use_fua)
> +				bio->bi_opf |= REQ_FUA;
> +			else
> +				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> +		} else {
> +			WARN_ON_ONCE(zone_append);
> +
> +			bio->bi_opf = REQ_OP_READ;
> +		}

Also, I think this should be hoisted into a separate helper to return
bi_opf rather than making iomap_dio_bio_actor even longer...

/*
 * Figure out the bio's operation flags from the dio request, the
 * mapping, and whether or not we want FUA.  Note that we can end up
 * clearing the WRITE_FUA flag in the dio request.
 */
static inline unsigned int
iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
{
	unsigned int opflags = REQ_SYNC | REQ_IDLE;

	if (!(dio->flags & IOMAP_DIO_WRITE)) {
		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
		return REQ_OP_READ;
	}

	if (iomap->flags & IOMAP_F_ZONE_APPEND)
		opflags |= REQ_OP_ZONE_APPEND;
	else
		opflags |= REQ_OP_WRITE;

	if (use_fua)
		opflags |= REQ_FUA;
	else
		dio->flags &= ~IOMAP_DIO_WRITE_FUA;

	return opflags;
}

	/*
	 * Set the operation flags early so that bio_iov_iter_get_pages can
	 * set up the page vector appropriately for a ZONE_APPEND operation.
	 */
	bio->bi_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);

	ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
	if (unlikely(ret)) {

--D

> +
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
>  			/*
> @@ -292,14 +308,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  		n = bio->bi_iter.bi_size;
>  		if (dio->flags & IOMAP_DIO_WRITE) {
> -			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
> -			if (use_fua)
> -				bio->bi_opf |= REQ_FUA;
> -			else
> -				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
>  			task_io_account_write(n);
>  		} else {
> -			bio->bi_opf = REQ_OP_READ;
>  			if (dio->flags & IOMAP_DIO_DIRTY)
>  				bio_set_pages_dirty(bio);
>  		}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 4d1d3c3469e9..1bccd1880d0d 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -54,6 +54,7 @@ struct vm_fault;
>  #define IOMAP_F_SHARED		0x04
>  #define IOMAP_F_MERGED		0x08
>  #define IOMAP_F_BUFFER_HEAD	0x10
> +#define IOMAP_F_ZONE_APPEND	0x20
>  
>  /*
>   * Flags set by the core iomap code during operations:
> -- 
> 2.27.0
> 
