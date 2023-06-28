Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F03740B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjF1IWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjF1IOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC8A35AF;
        Wed, 28 Jun 2023 01:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46ACC61320;
        Wed, 28 Jun 2023 06:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582CAC433C0;
        Wed, 28 Jun 2023 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687935043;
        bh=hOoc0Aib4oo18mfm9eMNY+OdZZuW9BRl3RB1Xy+bYdQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zr+radOpKjLX3+uyggdMAMeysCvRREugMDJxSgJC7GDtmHPQvpfQ+21qXFEC86oLx
         G5mjTNXmnH2l09LBWyxFTDwMjrg71JWpxipEoSXG3LUAaSKPC2GF4TjAxh0zlBGreo
         mprfHbxiTnlcRzb8ED8F7o129HlYF941zxBulinGOaIZEPQyOfw2ZRe8vNmJK0NupK
         wMsdXupbWl6iNYc6Tcn9wrroIBiD2Z/J+GPTkDdZ2XIjemOvjD218fHfn+ukNsg8N1
         HMwsroLdPuEUTpNCPv4qkuIW36MtmwCUJgVgg3W2yqlwaKu5Gj22YWDbM2yV2gd5q0
         X/Udzd2lKgIBA==
Message-ID: <cdd190e3-d510-f4f3-46ee-3570f0317501@kernel.org>
Date:   Wed, 28 Jun 2023 15:50:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 03:36, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is
> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination asynchronously.
> Also emulation is used, if copy offload fails or partially completes.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-lib.c           | 183 +++++++++++++++++++++++++++++++++++++-
>  block/blk-map.c           |   4 +-
>  include/linux/blk_types.h |   5 ++
>  include/linux/blkdev.h    |   3 +
>  4 files changed, 192 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 10c3eadd5bf6..09e0d5d51d03 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -234,6 +234,180 @@ static ssize_t __blkdev_copy_offload(
>  	return blkdev_copy_wait_io_completion(cio);
>  }
>  
> +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
> +		gfp_t gfp_mask)
> +{
> +	int min_size = PAGE_SIZE;
> +	void *buf;
> +
> +	while (req_size >= min_size) {
> +		buf = kvmalloc(req_size, gfp_mask);
> +		if (buf) {
> +			*alloc_size = req_size;
> +			return buf;
> +		}
> +		/* retry half the requested size */

Kind of obvious :)

> +		req_size >>= 1;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void blkdev_copy_emulate_write_endio(struct bio *bio)
> +{
> +	struct copy_ctx *ctx = bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +
> +	if (bio->bi_status) {
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
> +	}
> +	kfree(bvec_virt(&bio->bi_io_vec[0]));
> +	bio_map_kern_endio(bio);
> +	kfree(ctx);
> +	if (atomic_dec_and_test(&cio->refcount)) {
> +		if (cio->endio) {
> +			cio->endio(cio->private, cio->comp_len);
> +			kfree(cio);
> +		} else
> +			blk_wake_io_task(cio->waiter);

Curly brackets.

> +	}
> +}
> +
> +static void blkdev_copy_emulate_read_endio(struct bio *read_bio)
> +{
> +	struct copy_ctx *ctx = read_bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +
> +	if (read_bio->bi_status) {
> +		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
> +						cio->pos_in;
> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
> +		kfree(bvec_virt(&read_bio->bi_io_vec[0]));
> +		bio_map_kern_endio(read_bio);
> +		kfree(ctx);
> +
> +		if (atomic_dec_and_test(&cio->refcount)) {
> +			if (cio->endio) {
> +				cio->endio(cio->private, cio->comp_len);
> +				kfree(cio);
> +			} else
> +				blk_wake_io_task(cio->waiter);

Same.

> +		}
> +	}
> +	schedule_work(&ctx->dispatch_work);

ctx may have been freed above.

> +	kfree(read_bio);
> +}
> +
> +static void blkdev_copy_dispatch_work(struct work_struct *work)
> +{
> +	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
> +			dispatch_work);

Please align the argument, or even better: split the line after "=".

> +
> +	submit_bio(ctx->write_bio);
> +}
> +
> +/*
> + * If native copy offload feature is absent, this function tries to emulate,
> + * by copying data from source to a temporary buffer and from buffer to
> + * destination device.
> + * Returns the length of bytes copied or error if encountered
> + */
> +static ssize_t __blkdev_copy_emulate(
> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
> +{
> +	struct request_queue *in = bdev_get_queue(bdev_in);
> +	struct request_queue *out = bdev_get_queue(bdev_out);
> +	struct bio *read_bio, *write_bio;
> +	void *buf = NULL;
> +	struct copy_ctx *ctx;
> +	struct cio *cio;
> +	sector_t buf_len, req_len, rem = 0;
> +	sector_t max_src_hw_len = min_t(unsigned int,
> +			queue_max_hw_sectors(in),
> +			queue_max_segments(in) << (PAGE_SHIFT - SECTOR_SHIFT))
> +			<< SECTOR_SHIFT;
> +	sector_t max_dst_hw_len = min_t(unsigned int,
> +		queue_max_hw_sectors(out),
> +			queue_max_segments(out) << (PAGE_SHIFT - SECTOR_SHIFT))
> +			<< SECTOR_SHIFT;
> +	sector_t max_hw_len = min_t(unsigned int,
> +			max_src_hw_len, max_dst_hw_len);
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 0);
> +	cio->pos_in = pos_in;
> +	cio->pos_out = pos_out;
> +	cio->waiter = current;
> +	cio->endio = endio;
> +	cio->private = private;
> +
> +	for (rem = len; rem > 0; rem -= buf_len) {
> +		req_len = min_t(int, max_hw_len, rem);
> +
> +		buf = blkdev_copy_alloc_buf(req_len, &buf_len, gfp_mask);
> +		if (!buf)
> +			goto err_alloc_buf;
> +
> +		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +		if (!ctx)
> +			goto err_ctx;
> +
> +		read_bio = bio_map_kern(in, buf, buf_len, gfp_mask);
> +		if (IS_ERR(read_bio))
> +			goto err_read_bio;
> +
> +		write_bio = bio_map_kern(out, buf, buf_len, gfp_mask);
> +		if (IS_ERR(write_bio))
> +			goto err_write_bio;
> +
> +		ctx->cio = cio;
> +		ctx->write_bio = write_bio;
> +		INIT_WORK(&ctx->dispatch_work, blkdev_copy_dispatch_work);
> +
> +		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +		read_bio->bi_iter.bi_size = buf_len;
> +		read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
> +		bio_set_dev(read_bio, bdev_in);
> +		read_bio->bi_end_io = blkdev_copy_emulate_read_endio;
> +		read_bio->bi_private = ctx;
> +
> +		write_bio->bi_iter.bi_size = buf_len;
> +		write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
> +		bio_set_dev(write_bio, bdev_out);
> +		write_bio->bi_end_io = blkdev_copy_emulate_write_endio;
> +		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +		write_bio->bi_private = ctx;
> +
> +		atomic_inc(&cio->refcount);
> +		submit_bio(read_bio);
> +
> +		pos_in += buf_len;
> +		pos_out += buf_len;
> +	}
> +	return blkdev_copy_wait_io_completion(cio);
> +
> +err_write_bio:
> +	bio_put(read_bio);
> +err_read_bio:
> +	kfree(ctx);
> +err_ctx:
> +	kvfree(buf);
> +err_alloc_buf:
> +	cio->comp_len -= min_t(sector_t, cio->comp_len, len - rem);
> +	if (!atomic_read(&cio->refcount)) {
> +		kfree(cio);
> +		return -ENOMEM;
> +	}
> +	return blkdev_copy_wait_io_completion(cio);
> +}
> +
>  static inline ssize_t blkdev_copy_sanity_check(
>  	struct block_device *bdev_in, loff_t pos_in,
>  	struct block_device *bdev_out, loff_t pos_out,
> @@ -284,9 +458,16 @@ ssize_t blkdev_copy_offload(
>  	if (ret)
>  		return ret;
>  
> -	if (blk_queue_copy(q_in) && blk_queue_copy(q_out))
> +	if (blk_queue_copy(q_in) && blk_queue_copy(q_out)) {
>  		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
>  			   len, endio, private, gfp_mask);
> +		if (ret < 0)
> +			ret = 0;
> +	}
> +
> +	if (ret != len)
> +		ret = __blkdev_copy_emulate(bdev_in, pos_in + ret, bdev_out,
> +			 pos_out + ret, len - ret, endio, private, gfp_mask);
>  
>  	return ret;
>  }
> diff --git a/block/blk-map.c b/block/blk-map.c
> index 44d74a30ddac..ceeb70a95fd1 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -363,7 +363,7 @@ static void bio_invalidate_vmalloc_pages(struct bio *bio)
>  #endif
>  }
>  
> -static void bio_map_kern_endio(struct bio *bio)
> +void bio_map_kern_endio(struct bio *bio)
>  {
>  	bio_invalidate_vmalloc_pages(bio);
>  	bio_uninit(bio);
> @@ -380,7 +380,7 @@ static void bio_map_kern_endio(struct bio *bio)
>   *	Map the kernel address into a bio suitable for io to a block
>   *	device. Returns an error pointer in case of error.
>   */
> -static struct bio *bio_map_kern(struct request_queue *q, void *data,
> +struct bio *bio_map_kern(struct request_queue *q, void *data,
>  		unsigned int len, gfp_t gfp_mask)
>  {
>  	unsigned long kaddr = (unsigned long)data;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 336146798e56..f8c80940c7ad 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -562,4 +562,9 @@ struct cio {
>  	atomic_t refcount;
>  };
>  
> +struct copy_ctx {
> +	struct cio *cio;
> +	struct work_struct dispatch_work;
> +	struct bio *write_bio;
> +};
>  #endif /* __LINUX_BLK_TYPES_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 963f5c97dec0..c176bf6173c5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1047,6 +1047,9 @@ ssize_t blkdev_copy_offload(
>  		struct block_device *bdev_in, loff_t pos_in,
>  		struct block_device *bdev_out, loff_t pos_out,
>  		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
> +struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
> +		gfp_t gfp_mask);
> +void bio_map_kern_endio(struct bio *bio);
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */

-- 
Damien Le Moal
Western Digital Research

