Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4B75A807
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 09:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjGTHnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 03:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjGTHnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:43:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07882123;
        Thu, 20 Jul 2023 00:43:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 053696732D; Thu, 20 Jul 2023 09:42:57 +0200 (CEST)
Date:   Thu, 20 Jul 2023 09:42:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 2/9] block: Add copy offload support infrastructure
Message-ID: <20230720074256.GA5042@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9@epcas5p4.samsung.com> <20230627183629.26571-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-3-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I wonder if this might benefit if you split the actual block
layer copy infrastructure from the blkdev_copy_offload* helpers
that just make use of it.

> Suggested-by: Christoph Hellwig <hch@lst.de>

Hmm, I'm not sure I suggested adding copy offload..

> +/*
> + * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
> + * This must only be called once all bios have been issued so that the refcount
> + * can only decrease. This just waits for all bios to make it through
> + * blkdev_copy_(offload/emulate)_(read/write)_endio.
> + */
> +static ssize_t blkdev_copy_wait_io_completion(struct cio *cio)
> +{
> +	ssize_t ret;
> +
> +	if (cio->endio)
> +		return 0;

I'd move this to the caller to make things more clear.

> +
> +	if (atomic_read(&cio->refcount)) {
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		blk_io_schedule();

I don't think the refcount scheme you have works, instead you need
to have an extra count for the submitter, which is dropped using
atomic_dec_and_test here.  Take a look at ref scheme in blkdev_dio
which should be applicable here.

> +	ret = cio->comp_len;

The comp_len name for this variable confuses me.  I think is the length
that has succesfully been copied.  So maybe name it copied?

> +static void blkdev_copy_offload_read_endio(struct bio *bio)
> +{
> +	struct cio *cio = bio->bi_private;
> +	sector_t clen;
> +
> +	if (bio->bi_status) {
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
> +		cio->comp_len = min_t(sector_t, clen, cio->comp_len);

bi_sector can be thrashed once you hit the end_io handler.

> +	if (!atomic_dec_and_test(&cio->refcount))
> +		return;
> +	if (cio->endio) {
> +		cio->endio(cio->private, cio->comp_len);
> +		kfree(cio);
> +	} else
> +		blk_wake_io_task(cio->waiter);
> +}

This code is duplicated in a few places, please add a helper for it.

Also don't we need a way to return an error code through ->endio?

> +static ssize_t __blkdev_copy_offload(
> +		struct block_device *bdev_in, loff_t pos_in,
> +		struct block_device *bdev_out, loff_t pos_out,
> +		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)

I'd call this something like blkdev_copy_native, or maybe just
blkdev_copy_offlod.  Also given that we only want to support
single-device copies there i no need to pass two block_devices here.

Also please use the available space on the declaration line:

static ssize_t __blkdev_copy_offload(struct block_device *bdev_in,
		loff_t pos_in, struct block_device *bdev_out, loff_t pos_out,
		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)

Also the cio_iodone_t name is very generic.  Givne that there aren't
many places where we pass these callbacks I'd probably just drop the
typedef entirely.

> +	/* If there is a error, comp_len will be set to least successfully
> +	 * completed copied length
> +	 */

This is not the canonical kernel comment style.

> +	cio->comp_len = len;
> +	for (rem = len; rem > 0; rem -= copy_len) {
> +		copy_len = min(rem, max_copy_len);
> +
> +		write_bio = bio_alloc(bdev_out, 0, REQ_OP_COPY_DST, gfp_mask);
> +		if (!write_bio)
> +			goto err_write_bio_alloc;
> +		write_bio->bi_iter.bi_size = copy_len;
> +		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +
> +		blk_start_plug(&plug);
> +		read_bio = blk_next_bio(write_bio, bdev_in, 0, REQ_OP_COPY_SRC,
> +						gfp_mask);
> +		read_bio->bi_iter.bi_size = copy_len;
> +		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +		read_bio->bi_end_io = blkdev_copy_offload_read_endio;
> +		read_bio->bi_private = cio;

The chaining order here seems inverse to what I'd expect.  At least
for NVMe the copy command supports multiple input ranges being copied
to a single output range, and that is a very useful and important
feature for garbage collection in out of place write file systems.

So I'd expect to see one or more read bios first, which get chained
to the write bio that drives the completion.  We don't need the
multiple input range support in the very first version, but I'd expect
it to be added soon later so we better get the infrastructure right
for it.

> +
> +static inline ssize_t blkdev_copy_sanity_check(
> +	struct block_device *bdev_in, loff_t pos_in,
> +	struct block_device *bdev_out, loff_t pos_out,
> +	size_t len)

Two tab indents for the prototype, please.

> +{
> +	unsigned int align = max(bdev_logical_block_size(bdev_out),
> +					bdev_logical_block_size(bdev_in)) - 1;
> +
> +	if (bdev_read_only(bdev_out))
> +		return -EPERM;
> +
> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
> +		len >= COPY_MAX_BYTES)

This indentation should also use two tabs or alignent of the opening
brace, and not the same as the indented branch.

> +ssize_t blkdev_copy_offload(

Just blkdev_copy?  Especially as the non-offloaded version is added
later.

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 65e75efa9bd3..bfd86c54df22 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -922,6 +922,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>  	if (!rq_mergeable(rq) || !bio_mergeable(bio))
>  		return false;
>  
> +	if ((req_op(rq) == REQ_OP_COPY_DST) && (bio_op(bio) == REQ_OP_COPY_SRC))
> +		return true;

This seems to be equivalent to blk_copy_offload_mergable, so why not
use that?

> +static enum bio_merge_status bio_attempt_copy_offload_merge(
> +	struct request_queue *q, struct request *req, struct bio *bio)

Same comment about the indentation as above (I'm not going to mention
it further, please do a sweep).

Also we don't need the q argument, it must be req->q.

> +{
> +	if (req->__data_len != bio->bi_iter.bi_size)
> +		return BIO_MERGE_FAILED;
> +
> +	req->biotail->bi_next = bio;
> +	req->biotail = bio;
> +	req->nr_phys_segments = blk_rq_nr_phys_segments(req) + 1;

This should just be req->nr_phys_segments++, shouldn't it?

>  }
>  
> +static inline bool blk_copy_offload_mergable(struct request *req,
> +					     struct bio *bio)
> +{
> +	return ((req_op(req) == REQ_OP_COPY_DST)  &&
> +		(bio_op(bio) == REQ_OP_COPY_SRC));
> +}

Can you please add a comment explaining the logic of merging different
operations here?

Also all the braces in the function body are superflous and there is a
double whitespace before the &&.

>  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
>  {
>  	if (req_op(rq) == REQ_OP_DISCARD)
> @@ -303,6 +310,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
>  		break;
>  	}
>  
> +	if (unlikely(op_is_copy(bio->bi_opf)))
> +		return false;

This looks wrong to me.  I think the copy ops need to be added to the
switch statement above as they have non-trivial splitting decisions.
Or at least should have those as we're missing the code to split
copy commands right now.

> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index c4f5b5228105..a2673f24e493 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -57,7 +57,9 @@ static inline bool bio_has_data(struct bio *bio)
>  	    bio->bi_iter.bi_size &&
>  	    bio_op(bio) != REQ_OP_DISCARD &&
>  	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
> +	    bio_op(bio) != REQ_OP_COPY_DST &&
> +	    bio_op(bio) != REQ_OP_COPY_SRC)

It probably make sense to replace this with a positive check
for the operations that do have data as a prep patch, which is
just REQ_OP_READ an  REQ_OP_WRITE.

>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>  
> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
> +	REQ_OP_COPY_DST		= (__force blk_opf_t)19,

Little comments on these ops, please.

> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return (((op & REQ_OP_MASK) == REQ_OP_COPY_SRC) ||
> +		((op & REQ_OP_MASK) == REQ_OP_COPY_DST));

All but the inner most braces here are superflous.

> +struct cio {
> +	struct task_struct *waiter;     /* waiting task (NULL if none) */
> +	loff_t pos_in;
> +	loff_t pos_out;
> +	ssize_t comp_len;
> +	cio_iodone_t *endio;		/* applicable for async operation */
> +	void *private;			/* applicable for async operation */
> +	atomic_t refcount;
> +};

The name for this structure is way to generic.  It also is only used
inside of blk-lib.c and should be moved there.
