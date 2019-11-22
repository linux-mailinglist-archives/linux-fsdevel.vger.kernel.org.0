Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F2105D7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 01:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVACz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 19:02:55 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36260 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVACz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:02:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALNnZur039203;
        Fri, 22 Nov 2019 00:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vX3q2NAzhUNf0+7l5tqwfMGF04CL6nqnJLiu5zBmRhc=;
 b=Bq/hWuzbwAYdiWo5KeAWb0UcveheXar02DjzE65oxkWhwmGKeFmUpwK6VLo5GCnBLQPj
 GltY9qGgej0vyhzKv1cqyVvASrhCPTvfa4Q7A1EvjelhM/vEjcYVfZDiHl9RwfY3Lpry
 2CnTLoaJ9i95qB0RJbXTzLic5vxmeWjiPaDOUvrK8t+rqk4hEbJLEuKSr+qEfgF1//ys
 8v932gcHhTGaCaO5Jr4ZbmlgV+/yG4zyA9pdo3dcYfV7H0pBHBf5JECszAo+crdNf2Yh
 n1SMURwxZhACPj/Xy1+5FgmcARxYC20igpt0xhCDWi046PB931h9gOnp1HN+e61su3nC WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wa92q7j1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 00:02:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xALNmfkk177967;
        Fri, 22 Nov 2019 00:02:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2wd4708jrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Nov 2019 00:02:30 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAM02TgL007092;
        Fri, 22 Nov 2019 00:02:29 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 16:02:29 -0800
Date:   Thu, 21 Nov 2019 16:02:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/2] iomap: Do not create fake iter in
 iomap_dio_bio_actor()
Message-ID: <20191122000228.GP6211@magnolia>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121161538.18445-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121161538.18445-2-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210202
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9448 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210202
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 05:15:35PM +0100, Jan Kara wrote:
> iomap_dio_bio_actor() copies iter to a local variable and then limits it
> to a file extent we have mapped. When IO is submitted,
> iomap_dio_bio_actor() advances the original iter while the copied iter
> is advanced inside bio_iov_iter_get_pages(). This logic is non-obvious
> especially because both iters still point to same shared structures
> (such as pipe info) so if iov_iter_advance() changes anything in the
> shared structure, this scheme breaks. Let's just truncate and reexpand
> the original iter as needed instead of playing games with copying iters
> and keeping them in sync.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/iomap/direct-io.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 30189652c560..01a4264bce37 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -201,12 +201,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
>  	unsigned int fs_block_size = i_blocksize(inode), pad;
>  	unsigned int align = iov_iter_alignment(dio->submit.iter);
> -	struct iov_iter iter;
>  	struct bio *bio;
>  	bool need_zeroout = false;
>  	bool use_fua = false;
>  	int nr_pages, ret = 0;
>  	size_t copied = 0;
> +	size_t orig_count = iov_iter_count(dio->submit.iter);
>  
>  	if ((pos | length | align) & ((1 << blkbits) - 1))
>  		return -EINVAL;
> @@ -235,16 +235,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  			use_fua = true;
>  	}
>  
> -	/*
> -	 * Operate on a partial iter trimmed to the extent we were called for.
> -	 * We'll update the iter in the dio once we're done with this extent.
> -	 */
> -	iter = *dio->submit.iter;
> -	iov_iter_truncate(&iter, length);
> +	/* Operate on a partial iter trimmed to the extent we were called for */
> +	iov_iter_truncate(dio->submit.iter, length);

Ok... so here we shorten the dio iterator to fit the mapping we got...

>  
> -	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> -	if (nr_pages <= 0)
> +	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +	if (nr_pages <= 0) {
> +		iov_iter_reexpand(dio->submit.iter, orig_count);
>  		return nr_pages;

...and if there aren't any pages, we revert the truncation and bail...

> +	}
>  
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
> @@ -257,6 +255,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		size_t n;
>  		if (dio->error) {
>  			iov_iter_revert(dio->submit.iter, copied);
> +			iov_iter_reexpand(dio->submit.iter, orig_count);

...if the bio failed, we walk the dio iterator backward the entire
amount that it had advanced, undo the length truncation and bail...

>  			return 0;
>  		}
>  
> @@ -268,7 +267,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -		ret = bio_iov_iter_get_pages(bio, &iter);
> +		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);

...here's where we walk the dio iter forward as part of attaching pages
to the bio...

>  		if (unlikely(ret)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
> @@ -294,13 +293,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  				bio_set_pages_dirty(bio);
>  		}
>  
> -		iov_iter_advance(dio->submit.iter, n);
> -
>  		dio->size += n;
>  		pos += n;
>  		copied += n;
>  
> -		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> +		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
>  		iomap_dio_submit_bio(dio, iomap, bio);
>  	} while (nr_pages);
>  
> @@ -318,6 +315,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		if (pad)
>  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>  	}
> +	/* Undo iter limitation to current extent */
> +	iov_iter_reexpand(dio->submit.iter, orig_count - copied);

...and here we undo the length truncation, same as all the other exit
points.  Assuming my understanding of the bookkeeping is correct,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(Would still like to see a proper regression test for fstests though...)

--D


>  	return copied ? copied : ret;
>  }
>  
> -- 
> 2.16.4
> 
