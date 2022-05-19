Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5524152D5CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiESOTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 10:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239275AbiESOTq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 10:19:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A124B225F;
        Thu, 19 May 2022 07:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FADFB824AB;
        Thu, 19 May 2022 14:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BEC385AA;
        Thu, 19 May 2022 14:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652969979;
        bh=AjcVgLoqYhR+OmjDZ/KC9hQplvQiRocHLy3+qkbQDfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdjVjQPnxxFIK55MMaaGa6M3zks5qKVGEKHVtrlY48UpoWbJgGNfj8egsjgeu8Rzc
         0fvtF2YcNKanPs1pljIo6gxkvbjA+c/Bq26Gswomfq+2Sixs0DlN1eXxzlSA0rnfiW
         cGzyA3p51UdS43U9GMsq9dV9QyRS5DdXhnENVXVLujguvvBYy+AvySLDaA69q7bEzr
         6c7BXWqU8uQTg6v+WyJAFRSF9x2x8ptKkOwkA0gmbO3+B84qyJS1iu0p/MMZLLgOdw
         3OrRTCMvcAOQopjnQMZ7SaeSvEeCVf7ojsW8UlVKMNDI4FW5nt1QWRgB4gh9FwTsJ4
         IUdaJH0Cxe4lQ==
Date:   Thu, 19 May 2022 08:19:35 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 1/3] block/bio: remove duplicate append pages code
Message-ID: <YoZR9zJl/o0XgQtN@kbusch-mbp>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-2-kbusch@fb.com>
 <20220519073256.GC22301@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519073256.GC22301@lst.de>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 09:32:56AM +0200, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 10:11:29AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The setup for getting pages are identical for zone append and normal IO.
> > Use common code for each.
> 
> How about using even more common code and avoiding churn at the same
> time?  Something like:

Yes, I'll fold this in.
 
> diff --git a/block/bio.c b/block/bio.c
> index a3893d80dccc9..15da722ed26d1 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1158,6 +1158,37 @@ static void bio_put_pages(struct page **pages, size_t size, size_t off)
>  		put_page(pages[i]);
>  }
>  
> +static int bio_iov_add_page(struct bio *bio, struct page *page,
> +		unsigned int len, unsigned int offset)
> +{
> +	bool same_page = false;
> +
> +	if (!__bio_try_merge_page(bio, page, len, offset, &same_page)) {
> +		if (WARN_ON_ONCE(bio_full(bio, len)))
> +			return -EINVAL;
> +		__bio_add_page(bio, page, len, offset);
> +		return 0;
> +	}
> +
> +	if (same_page)
> +		put_page(page);
> +	return 0;
> +}
> +
> +static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
> +		unsigned int len, unsigned int offset)
> +{
> +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> +	bool same_page = false;
> +
> +	if (bio_add_hw_page(q, bio, page, len, offset,
> +			queue_max_zone_append_sectors(q), &same_page) != len)
> +		return -EINVAL;
> +	if (same_page)
> +		put_page(page);
> +	return 0;
> +}
> +
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
>  
>  /**
> @@ -1176,7 +1207,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
>  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
>  	struct page **pages = (struct page **)bv;
> -	bool same_page = false;
>  	ssize_t size, left;
>  	unsigned len, i;
>  	size_t offset;
> @@ -1195,18 +1225,18 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  
>  	for (left = size, i = 0; left > 0; left -= len, i++) {
>  		struct page *page = pages[i];
> +		int ret;
>  
>  		len = min_t(size_t, PAGE_SIZE - offset, left);
> +		if (bio_op(bio) == REQ_OP_ZONE_APPEND)	
> +			ret = bio_iov_add_zone_append_page(bio, page, len,
> +					offset);
> +		else
> +			ret = bio_iov_add_page(bio, page, len, offset);
>  
> -		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
> -			if (same_page)
> -				put_page(page);
> -		} else {
> -			if (WARN_ON_ONCE(bio_full(bio, len))) {
> -				bio_put_pages(pages + i, left, offset);
> -				return -EINVAL;
> -			}
> -			__bio_add_page(bio, page, len, offset);
> +		if (ret) {
> +			bio_put_pages(pages + i, left, offset);
> +			return ret;
>  		}
>  		offset = 0;
>  	}
> @@ -1215,54 +1245,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	return 0;
>  }
>  
> -static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
> -{
> -	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> -	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> -	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> -	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
> -	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> -	struct page **pages = (struct page **)bv;
> -	ssize_t size, left;
> -	unsigned len, i;
> -	size_t offset;
> -	int ret = 0;
> -
> -	if (WARN_ON_ONCE(!max_append_sectors))
> -		return 0;
> -
> -	/*
> -	 * Move page array up in the allocated memory for the bio vecs as far as
> -	 * possible so that we can start filling biovecs from the beginning
> -	 * without overwriting the temporary page array.
> -	 */
> -	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
> -	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> -
> -	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> -	if (unlikely(size <= 0))
> -		return size ? size : -EFAULT;
> -
> -	for (left = size, i = 0; left > 0; left -= len, i++) {
> -		struct page *page = pages[i];
> -		bool same_page = false;
> -
> -		len = min_t(size_t, PAGE_SIZE - offset, left);
> -		if (bio_add_hw_page(q, bio, page, len, offset,
> -				max_append_sectors, &same_page) != len) {
> -			bio_put_pages(pages + i, left, offset);
> -			ret = -EINVAL;
> -			break;
> -		}
> -		if (same_page)
> -			put_page(page);
> -		offset = 0;
> -	}
> -
> -	iov_iter_advance(iter, size - left);
> -	return ret;
> -}
> -
>  /**
>   * bio_iov_iter_get_pages - add user or kernel pages to a bio
>   * @bio: bio to add pages to
> @@ -1297,10 +1279,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>  	}
>  
>  	do {
> -		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
> -			ret = __bio_iov_append_get_pages(bio, iter);
> -		else
> -			ret = __bio_iov_iter_get_pages(bio, iter);
> +		ret = __bio_iov_iter_get_pages(bio, iter);
>  	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
>  
>  	/* don't account direct I/O as memory stall */
