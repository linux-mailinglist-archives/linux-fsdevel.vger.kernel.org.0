Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB622ADEDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbgKJSzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:55:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:59370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgKJSzT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:55:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAIhm1d192831;
        Tue, 10 Nov 2020 18:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=W2aScfHznhI+VyiJ4fFe1ILGDTvOPvEnoD1x5S1squ4=;
 b=e0WkwSSEs1WLM7IATyjNp72qZp1/6WD837Jjx0yIuVzdWUwSTRJa+iqZEWGd4XYVmtit
 Mxglww0lhukYir1vFRBEcWj065GJyJSBKvuim+37/A5zOrguGnmx8zmWttSmxlf0UV45
 5hIT38XXHXNTW99cjwJO2SQHOHMQdZ4DSD05AbPrYHJ5HEJGllGx+3K9Af08thWEO/WG
 ELmRS63rCOoTioAdKch5AcQGFyyPd0hf3TJz8qYlZo1QktAmdspcXlGgEfaM5Od3m4c5
 K7bjQrFFA1OjBA8k6giEERuCcOgPFYiEJetA5eSmdUkqAUfHPUcgsYoex5KISPIJICnI Xg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkw9tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 18:55:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AAIiqQb048059;
        Tue, 10 Nov 2020 18:55:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34p5g0r7ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 18:55:10 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AAIt76A001267;
        Tue, 10 Nov 2020 18:55:09 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 10:55:07 -0800
Date:   Tue, 10 Nov 2020 10:55:06 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201110185506.GD9685@magnolia>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=1 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100129
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:26:05PM +0900, Naohiro Aota wrote:
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
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/iomap/direct-io.c  | 41 +++++++++++++++++++++++++++++++++++------
>  include/linux/iomap.h |  1 +
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index c1aafb2ab990..f04572a55a09 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -200,6 +200,34 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
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

Hmm, just to check my understanding of what iomap has to do to support
all this:

When we're wanting to use a ZONE_APPEND command, the @iomap structure
has to have IOMAP_F_ZONE_APPEND set in iomap->flags, iomap->type is set
to IOMAP_MAPPED, but what should iomap->addr be set to?

I gather from what I see in zonefs and the relevant NVME proposal that
iomap->addr should be set to the (byte) address of the zone we want to
append to?  And if we do that, then bio->bi_iter.bi_sector will be set
to sector address of iomap->addr, right?

(I got lost trying to figure out how btrfs sets ->addr for appends.)

Then when the IO completes, the block layer sets bio->bi_iter.bi_sector
to wherever the drive told it that it actually wrote the bio, right?

If that's true, then that implies that need_zeroout must always be false
for an append operation, right?  Does that also mean that the directio
request has to be aligned to an fs block and not just the sector size?

Can userspace send a directio append that crosses a zone boundary?  If
so, what happens if a direct append to a lower address fails but a
direct append to a higher address succeeds?

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
> @@ -278,6 +306,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +		/*
> +		 * Set the operation flags early so that bio_iov_iter_get_pages
> +		 * can set up the page vector appropriately for a ZONE_APPEND
> +		 * operation.
> +		 */
> +		bio->bi_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);

I'm also vaguely wondering how to communicate the write location back to
the filesystem when the bio completes?  btrfs handles the bio completion
completely so it doesn't have a problem, but for other filesystems
(cough future xfs cough) either we'd have to add a new callback for
append operations; or I guess everyone could hook the bio endio.

Admittedly that's not really your problem, and for all I know hch is
already working on this.

--D

> +
>  		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
>  			/*
> @@ -292,14 +327,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
