Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B943010A38C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 18:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfKZRtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 12:49:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKZRrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:47:52 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQHiE6g008010;
        Tue, 26 Nov 2019 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=VLb/YMJCsrWhkvFIIjrbjJTaLfIayBXhXUM0yEnRDWo=;
 b=Jh9MUTMxEOm/dG3iFRfvsYLovnV1zqT4f07gIo4HvvCmRIeQGo7Cui9Qh2qlmOqNQHuZ
 qXkPiZU07/d7vp7nctgUHrm/gHHTqJIZhnR+JPvf+K2tpDNePStwdTK6/u2PNaHBNVla
 KrhNmsiPCTrcqYvODaU8CG1dZ1BvkswwWwjEvrXODclRVJ2xhuSHYi/EvWyKNVjnNwWF
 KPqxLCH5q9czNMNzl1QuVBSqDCsn8D3KL4k/2yGvWvPPQ4RQN/cr4uAoF7U6Nkiym609
 cxVL8y6umD5WduoWuudIJ4aZQITft44ojo9nw/fVnya9Mx4XT7lCt2nYaPbR6xqLemYG Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wewdr8bt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 17:47:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQHdT4B014627;
        Tue, 26 Nov 2019 17:47:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wgvfjwm9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 17:47:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAQHlVFd025458;
        Tue, 26 Nov 2019 17:47:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 09:47:31 -0800
Date:   Tue, 26 Nov 2019 09:47:30 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] iomap: Do not create fake iter in iomap_dio_bio_actor()
Message-ID: <20191126174730.GT6211@magnolia>
References: <20191125083930.11854-1-jack@suse.cz>
 <20191125111901.11910-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125111901.11910-1-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 n Mon, Nov 25, 2019 at 12:18:57PM +0100, Jan Kara wrote:
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

Looks ok, seems to test ok too
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/direct-io.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 420c0c82f0ac..b75cd0b0609b 100644
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
> +	size_t orig_count;
>  
>  	if ((pos | length | align) & ((1 << blkbits) - 1))
>  		return -EINVAL;
> @@ -236,15 +236,18 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  	}
>  
>  	/*
> -	 * Operate on a partial iter trimmed to the extent we were called for.
> -	 * We'll update the iter in the dio once we're done with this extent.
> +	 * Save the original count and trim the iter to just the extent we
> +	 * are operating on right now.  The iter will be re-expanded once
> +	 * we are done.
>  	 */
> -	iter = *dio->submit.iter;
> -	iov_iter_truncate(&iter, length);
> +	orig_count = iov_iter_count(dio->submit.iter);
> +	iov_iter_truncate(dio->submit.iter, length);
>  
> -	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> -	if (nr_pages <= 0)
> -		return nr_pages;
> +	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> +	if (nr_pages <= 0) {
> +		ret = nr_pages;
> +		goto out;
> +	}
>  
>  	if (need_zeroout) {
>  		/* zero out from the start of the block to the write offset */
> @@ -257,7 +260,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		size_t n;
>  		if (dio->error) {
>  			iov_iter_revert(dio->submit.iter, copied);
> -			return 0;
> +			copied = ret = 0;
> +			goto out;
>  		}
>  
>  		bio = bio_alloc(GFP_KERNEL, nr_pages);
> @@ -268,7 +272,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> -		ret = bio_iov_iter_get_pages(bio, &iter);
> +		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
>  		if (unlikely(ret)) {
>  			/*
>  			 * We have to stop part way through an IO. We must fall
> @@ -294,13 +298,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
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
> @@ -318,6 +320,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		if (pad)
>  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>  	}
> +out:
> +	/* Undo iter limitation to current extent */
> +	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
>  	if (copied)
>  		return copied;
>  	return ret;
> -- 
> 2.16.4
> 
