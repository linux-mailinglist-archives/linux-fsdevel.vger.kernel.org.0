Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F152EA011
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhADWej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 17:34:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:56576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADWej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:34:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MTmLD144310;
        Mon, 4 Jan 2021 22:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B4AF3PcBZa+S1JWtjwXD0lkljtZvCwjIFfv+bAAGyd8=;
 b=Ui0x0IOaWACgg4zyEfwhsfAr8g7OzXbxsMSPk4DXUOrIXl6VbO3RZQo6IEsXnb6oWtA5
 c7MtveUcstTYN3GAZs8hi6o37UlRgSyerggOV18FWz7GyMUx/wT112xWy3/mmC5nPx6y
 l4cBb/H2Ze8sI2Gz0iw1X19p5kk+ybn/REC6i3NAT83M8S69rMKsnNOqKb17TFAYGj5+
 2wNzMXCIqNdsa/kVO4ap1aDs/sS/tRgaxWGDkeTgWXgSVm6qH75QqXk9yJbMUvHOqqZW
 Iyx8BNj4SN3d2To6w2TI+5pDmCQ67A2cTrNcwAX4dMt+IHQP7I3xRj2L+hDS/bMgG335 dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35tg8qxftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 22:33:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MXWNK030584;
        Mon, 4 Jan 2021 22:33:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 35v4rapvhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 22:33:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 104MUwg6009121;
        Mon, 4 Jan 2021 22:30:59 GMT
Received: from localhost (/10.159.152.204)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 14:30:58 -0800
Date:   Mon, 4 Jan 2021 14:30:56 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v11 02/40] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20210104223056.GL38809@magnolia>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <33bbb544385b7710f29c03b06699755def39319a.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33bbb544385b7710f29c03b06699755def39319a.1608608848.git.naohiro.aota@wdc.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040134
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 22, 2020 at 12:48:55PM +0900, Naohiro Aota wrote:
> A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
> max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
> such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
> REQ_OP_ZONE_APPEND.
> 
> To utilize it, we need to set the bio_op before calling
> bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
> that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
> and restricted bio.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Looks fine to me too,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Do the authors intend this one patch to go into 5.12 via the iomap tree?

--D

> ---
>  fs/iomap/direct-io.c  | 43 +++++++++++++++++++++++++++++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 933f234d5bec..2273120d8ed7 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -201,6 +201,34 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
>  	iomap_dio_submit_bio(dio, iomap, bio, pos);
>  }
>  
> +/*
> + * Figure out the bio's operation flags from the dio request, the
> + * mapping, and whether or not we want FUA.  Note that we can end up
> + * clearing the WRITE_FUA flag in the dio request.
> + */
> +static inline unsigned int
> +iomap_dio_bio_opflags(struct iomap_dio *dio, struct iomap *iomap, bool use_fua)
> +{
> +	unsigned int opflags = REQ_SYNC | REQ_IDLE;
> +
> +	if (!(dio->flags & IOMAP_DIO_WRITE)) {
> +		WARN_ON_ONCE(iomap->flags & IOMAP_F_ZONE_APPEND);
> +		return REQ_OP_READ;
> +	}
> +
> +	if (iomap->flags & IOMAP_F_ZONE_APPEND)
> +		opflags |= REQ_OP_ZONE_APPEND;
> +	else
> +		opflags |= REQ_OP_WRITE;
> +
> +	if (use_fua)
> +		opflags |= REQ_FUA;
> +	else
> +		dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> +
> +	return opflags;
> +}
> +
>  static loff_t
>  iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		struct iomap_dio *dio, struct iomap *iomap)
> @@ -208,6 +236,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
>  	unsigned int align = iov_iter_alignment(dio->submit.iter);
> +	unsigned int bio_opf;
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
> @@ -263,6 +292,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			iomap_dio_zero(dio, iomap, pos - pad, pad);
>  	}
>  
> +	/*
> +	 * Set the operation flags early so that bio_iov_iter_get_pages
> +	 * can set up the page vector appropriately for a ZONE_APPEND
> +	 * operation.
> +	 */
> +	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
> +
>  	do {
>  		size_t n;
>  		if (dio->error) {
> @@ -278,6 +314,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_ioprio = dio->iocb->ki_ioprio;
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
> +		bio->bi_opf = bio_opf;
>  
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
> @@ -293,14 +330,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
> index 5bd3cac4df9c..8ebb1fa6f3b7 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -55,6 +55,7 @@ struct vm_fault;
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
