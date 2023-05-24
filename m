Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C527270FAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjEXPm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237364AbjEXPmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:42:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E10A10C7;
        Wed, 24 May 2023 08:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B5961737;
        Wed, 24 May 2023 15:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86682C433EF;
        Wed, 24 May 2023 15:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684942849;
        bh=GnBtoU8AMWYWI0jmSKm6MAQYcMfd9WMfCQJci24HSso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iumgZOlwMMVHnX3saoIbtTHjUshN63+XBubTBJi17C6veAJPuwlOHoFz6mD+N+CfC
         DsRlkO8WESZ/IZ0psjH3pWnzMN80Oqa8umBBZXTH2orLwWEq7YdUz5N3CCN9HHmvK1
         fuvB4Omj594/ClEQivNwooSDO1gQQO/aD6EcAiSqIhDHqiEGOI96j83oZK959IrrLa
         cZedGhsGZ+NvTax50h/VT/us59Rc9YvONq7m662wirC1aQ6Lt+jKQvE0/hN9sw5FP6
         iz0ApmoVCgbJDSp/Z541KCZSTqunVAUYL+Grd4H5txwgdTGNj+2Vr7IFjiSKdmVSmA
         rRvccFrd1ygSw==
Date:   Wed, 24 May 2023 08:40:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-mm@kvack.org,
        gost.dev@samsung.com, anuj20.g@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com, James.Bottomley@hansenpartnership.com,
        linux-fsdevel@vger.kernel.org, dlemoal@kernel.org,
        joshi.k@samsung.com, nitheshshetty@gmail.com, bvanassche@acm.org
Subject: Re: [dm-devel] [PATCH v11 2/9] block: Add copy offload support
 infrastructure
Message-ID: <20230524154049.GD11607@frogsfrogsfrogs>
References: <20230522104146.2856-1-nj.shetty@samsung.com>
 <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522104146.2856-3-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:11:33PM +0530, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which takes similar arguments as
> copy_file_range and performs copy offload between two bdevs.
> Introduce REQ_COPY copy offload operation flag. Create a read-write
> bio pair with a token as payload and submitted to the device in order.
> Read request populates token with source specific information which
> is then passed with write request.
> This design is courtesy Mikulas Patocka's token based copy
> 
> Larger copy will be divided, based on max_copy_sectors limit.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  block/blk-lib.c           | 235 ++++++++++++++++++++++++++++++++++++++
>  block/blk.h               |   2 +
>  include/linux/blk_types.h |  25 ++++
>  include/linux/blkdev.h    |   3 +
>  4 files changed, 265 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e59c3069e835..ed089e703cb1 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -115,6 +115,241 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  }
>  EXPORT_SYMBOL(blkdev_issue_discard);
>  
> +/*
> + * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
> + * This must only be called once all bios have been issued so that the refcount
> + * can only decrease. This just waits for all bios to make it through
> + * blkdev_copy_write_endio.
> + */
> +static int blkdev_copy_wait_completion(struct cio *cio)
> +{
> +	int ret;
> +
> +	if (cio->endio)
> +		return 0;
> +
> +	if (atomic_read(&cio->refcount)) {
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		blk_io_schedule();
> +	}
> +
> +	ret = cio->comp_len;
> +	kfree(cio);
> +
> +	return ret;
> +}
> +
> +static void blkdev_copy_offload_write_endio(struct bio *bio)
> +{
> +	struct copy_ctx *ctx = bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +
> +	if (bio->bi_status) {
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	bio_put(bio);
> +
> +	kfree(ctx);
> +	if (!atomic_dec_and_test(&cio->refcount))
> +		return;
> +	if (cio->endio) {
> +		cio->endio(cio->private, cio->comp_len);
> +		kfree(cio);
> +	} else
> +		blk_wake_io_task(cio->waiter);
> +}
> +
> +static void blkdev_copy_offload_read_endio(struct bio *read_bio)
> +{
> +	struct copy_ctx *ctx = read_bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +
> +	if (read_bio->bi_status) {
> +		clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT)
> +				- cio->pos_in;
> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
> +		__free_page(read_bio->bi_io_vec[0].bv_page);
> +		bio_put(ctx->write_bio);
> +		bio_put(read_bio);
> +		kfree(ctx);
> +		if (atomic_dec_and_test(&cio->refcount)) {
> +			if (cio->endio) {
> +				cio->endio(cio->private, cio->comp_len);
> +				kfree(cio);
> +			} else
> +				blk_wake_io_task(cio->waiter);
> +		}
> +		return;
> +	}
> +
> +	schedule_work(&ctx->dispatch_work);
> +	bio_put(read_bio);
> +}
> +
> +static void blkdev_copy_dispatch_work(struct work_struct *work)
> +{
> +	struct copy_ctx *ctx = container_of(work, struct copy_ctx,
> +			dispatch_work);
> +
> +	submit_bio(ctx->write_bio);
> +}
> +
> +/*
> + * __blkdev_copy_offload	- Use device's native copy offload feature.
> + * we perform copy operation by sending 2 bio.
> + * 1. First we send a read bio with REQ_COPY flag along with a token and source
> + * and length. Once read bio reaches driver layer, device driver adds all the
> + * source info to token and does a fake completion.
> + * 2. Once read operation completes, we issue write with REQ_COPY flag with same
> + * token. In driver layer, token info is used to form a copy offload command.
> + *
> + * Returns the length of bytes copied or error if encountered
> + */
> +static int __blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		cio_iodone_t endio, void *private, gfp_t gfp_mask)
> +{
> +	struct cio *cio;
> +	struct copy_ctx *ctx;
> +	struct bio *read_bio, *write_bio;
> +	struct page *token;
> +	sector_t copy_len;
> +	sector_t rem, max_copy_len;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 0);
> +	cio->waiter = current;
> +	cio->endio = endio;
> +	cio->private = private;
> +
> +	max_copy_len = min(bdev_max_copy_sectors(bdev_in),
> +			bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
> +
> +	cio->pos_in = pos_in;
> +	cio->pos_out = pos_out;
> +	/* If there is a error, comp_len will be set to least successfully
> +	 * completed copied length
> +	 */
> +	cio->comp_len = len;
> +	for (rem = len; rem > 0; rem -= copy_len) {
> +		copy_len = min(rem, max_copy_len);
> +
> +		token = alloc_page(gfp_mask);
> +		if (unlikely(!token))
> +			goto err_token;
> +
> +		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +		if (!ctx)
> +			goto err_ctx;
> +		read_bio = bio_alloc(bdev_in, 1, REQ_OP_READ | REQ_COPY
> +			| REQ_SYNC | REQ_NOMERGE, gfp_mask);
> +		if (!read_bio)
> +			goto err_read_bio;
> +		write_bio = bio_alloc(bdev_out, 1, REQ_OP_WRITE
> +			| REQ_COPY | REQ_SYNC | REQ_NOMERGE, gfp_mask);
> +		if (!write_bio)
> +			goto err_write_bio;
> +
> +		ctx->cio = cio;
> +		ctx->write_bio = write_bio;
> +		INIT_WORK(&ctx->dispatch_work, blkdev_copy_dispatch_work);
> +
> +		__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +		read_bio->bi_iter.bi_size = copy_len;
> +		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +		read_bio->bi_end_io = blkdev_copy_offload_read_endio;
> +		read_bio->bi_private = ctx;
> +
> +		__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +		write_bio->bi_iter.bi_size = copy_len;
> +		write_bio->bi_end_io = blkdev_copy_offload_write_endio;
> +		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +		write_bio->bi_private = ctx;
> +
> +		atomic_inc(&cio->refcount);
> +		submit_bio(read_bio);
> +		pos_in += copy_len;
> +		pos_out += copy_len;
> +	}
> +
> +	/* Wait for completion of all IO's*/
> +	return blkdev_copy_wait_completion(cio);
> +
> +err_write_bio:
> +	bio_put(read_bio);
> +err_read_bio:
> +	kfree(ctx);
> +err_ctx:
> +	__free_page(token);
> +err_token:
> +	cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
> +	if (!atomic_read(&cio->refcount))
> +		return -ENOMEM;
> +	/* Wait for submitted IOs to complete */
> +	return blkdev_copy_wait_completion(cio);
> +}
> +
> +static inline int blkdev_copy_sanity_check(struct block_device *bdev_in,
> +	loff_t pos_in, struct block_device *bdev_out, loff_t pos_out,
> +	size_t len)
> +{
> +	unsigned int align = max(bdev_logical_block_size(bdev_out),
> +					bdev_logical_block_size(bdev_in)) - 1;
> +
> +	if (bdev_read_only(bdev_out))
> +		return -EPERM;
> +
> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
> +		len >= COPY_MAX_BYTES)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +/*
> + * @bdev_in:	source block device
> + * @pos_in:	source offset
> + * @bdev_out:	destination block device
> + * @pos_out:	destination offset
> + * @len:	length in bytes to be copied
> + * @endio:	endio function to be called on completion of copy operation,
> + *		for synchronous operation this should be NULL
> + * @private:	endio function will be called with this private data, should be
> + *		NULL, if operation is synchronous in nature
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + *
> + * Returns the length of bytes copied or error if encountered
> + *
> + * Description:
> + *	Copy source offset from source block device to destination block
> + *	device. Max total length of copy is limited to MAX_COPY_TOTAL_LENGTH
> + */
> +int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,

I'd have thought you'd return ssize_t here.  If the two block devices
are loopmounted xfs files, we can certainly reflink "copy" more than 2GB
at a time.

--D

> +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		      cio_iodone_t endio, void *private, gfp_t gfp_mask)
> +{
> +	struct request_queue *q_in = bdev_get_queue(bdev_in);
> +	struct request_queue *q_out = bdev_get_queue(bdev_out);
> +	int ret;
> +
> +	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
> +	if (ret)
> +		return ret;
> +
> +	if (blk_queue_copy(q_in) && blk_queue_copy(q_out))
> +		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
> +			   len, endio, private, gfp_mask);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blkdev_issue_copy);
> +
>  static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned flags)
> diff --git a/block/blk.h b/block/blk.h
> index 45547bcf1119..ec48a237fe12 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -303,6 +303,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
>  		break;
>  	}
>  
> +	if (unlikely(op_is_copy(bio->bi_opf)))
> +		return false;
>  	/*
>  	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
>  	 * This is a quick and dirty check that relies on the fact that
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 740afe80f297..0117e33087e1 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -420,6 +420,7 @@ enum req_flag_bits {
>  	 */
>  	/* for REQ_OP_WRITE_ZEROES: */
>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
> +	__REQ_COPY,		/* copy request */
>  
>  	__REQ_NR_BITS,		/* stops here */
>  };
> @@ -444,6 +445,7 @@ enum req_flag_bits {
>  #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
>  #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
>  #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
> +#define REQ_COPY	((__force blk_opf_t)(1ULL << __REQ_COPY))
>  #define REQ_DRV		(__force blk_opf_t)(1ULL << __REQ_DRV)
>  #define REQ_FS_PRIVATE	(__force blk_opf_t)(1ULL << __REQ_FS_PRIVATE)
>  
> @@ -474,6 +476,11 @@ static inline bool op_is_write(blk_opf_t op)
>  	return !!(op & (__force blk_opf_t)1);
>  }
>  
> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return op & REQ_COPY;
> +}
> +
>  /*
>   * Check if the bio or request is one that needs special treatment in the
>   * flush state machine.
> @@ -533,4 +540,22 @@ struct blk_rq_stat {
>  	u64 batch;
>  };
>  
> +typedef void (cio_iodone_t)(void *private, int comp_len);
> +
> +struct cio {
> +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> +	atomic_t refcount;
> +	loff_t pos_in;
> +	loff_t pos_out;
> +	size_t comp_len;
> +	cio_iodone_t *endio;		/* applicable for async operation */
> +	void *private;			/* applicable for async operation */
> +};
> +
> +struct copy_ctx {
> +	struct cio *cio;
> +	struct work_struct dispatch_work;
> +	struct bio *write_bio;
> +};
> +
>  #endif /* __LINUX_BLK_TYPES_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c9bf11adccb3..6f2814ab4741 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1051,6 +1051,9 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
>  int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp);
> +int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
> +		      struct block_device *bdev_out, loff_t pos_out, size_t len,
> +		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
>  
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
> -- 
> 2.35.1.500.gb896f729e2
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 
