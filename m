Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E592F797A2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243541AbjIGRdV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 13:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244824AbjIGRdA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:33:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DC10FD;
        Thu,  7 Sep 2023 10:32:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D54322184B;
        Thu,  7 Sep 2023 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694065801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkBgQJPFmxHSxjl0QqrHficEND3DHJwl7TSsSPl31Fk=;
        b=OG/bX/wrznenCvi4sH/KPgR14Bby2fChMRcPR0onrTpciMwcRSMqhwU92k6p4F3mYpEjrM
        I73ZOXQxPb1P2/tWgTdEU1Vt7uGnuPI4/Nq3+F3L8f0eGoN45orjQzGgA5nogh707sjQSU
        lU6OFXkGX5+JoD9SNdIkEB1HGapEjsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694065801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkBgQJPFmxHSxjl0QqrHficEND3DHJwl7TSsSPl31Fk=;
        b=P1+WN2lEYCmr3vUbniY4nBzQ0JIJQZ9CjwNIIWHR3JfF+Ww/p4VX/BIwViWf0CHNVx0sXh
        1MuiyNe4GgEVZFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2E3B13458;
        Thu,  7 Sep 2023 05:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fk1vIYhk+WRcYAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 07 Sep 2023 05:50:00 +0000
Message-ID: <b0f3d320-047b-4bd8-a6fc-25b468caf5b3@suse.de>
Date:   Thu, 7 Sep 2023 07:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/12] block: add copy offload support
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164312epcas5p397662c68dde1dbc4dc14c3e80ca260b3@epcas5p3.samsung.com>
 <20230906163844.18754-4-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906163844.18754-4-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/6/23 18:38, Nitesh Shetty wrote:
> Introduce blkdev_copy_offload to perform copy offload.
> Issue REQ_OP_COPY_SRC with source info along with taking a plug.
> This flows till request layer and waits for dst bio to arrive.
> Issue REQ_OP_COPY_DST with destination info and this bio reaches request
> layer and merges with src request.
> For any reason, if a request comes to the driver with only one of src/dst
> bio, we fail the copy offload.
> 
> Larger copy will be divided, based on max_copy_sectors limit.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>   block/blk-lib.c        | 202 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/blkdev.h |   4 +
>   2 files changed, 206 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index e59c3069e835..d22e1e7417ca 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -10,6 +10,22 @@
>   
>   #include "blk.h"
>   
> +/* Keeps track of all outstanding copy IO */
> +struct blkdev_copy_io {
> +	atomic_t refcount;
> +	ssize_t copied;
> +	int status;
> +	struct task_struct *waiter;
> +	void (*endio)(void *private, int status, ssize_t copied);
> +	void *private;
> +};
> +
> +/* Keeps track of single outstanding copy offload IO */
> +struct blkdev_copy_offload_io {
> +	struct blkdev_copy_io *cio;
> +	loff_t offset;
> +};
> +
>   static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
>   {
>   	unsigned int discard_granularity = bdev_discard_granularity(bdev);
> @@ -115,6 +131,192 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL(blkdev_issue_discard);
>   
> +static inline ssize_t blkdev_copy_sanity_check(struct block_device *bdev_in,
> +					       loff_t pos_in,
> +					       struct block_device *bdev_out,
> +					       loff_t pos_out, size_t len)
> +{
> +	unsigned int align = max(bdev_logical_block_size(bdev_out),
> +				 bdev_logical_block_size(bdev_in)) - 1;
> +
> +	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
> +	    len >= BLK_COPY_MAX_BYTES)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline void blkdev_copy_endio(struct blkdev_copy_io *cio)
> +{
> +	if (cio->endio) {
> +		cio->endio(cio->private, cio->status, cio->copied);
> +		kfree(cio);
> +	} else {
> +		struct task_struct *waiter = cio->waiter;
> +
> +		WRITE_ONCE(cio->waiter, NULL);
> +		blk_wake_io_task(waiter);
> +	}
> +}
> +
> +/*
> + * This must only be called once all bios have been issued so that the refcount
> + * can only decrease. This just waits for all bios to complete.
> + * Returns the length of bytes copied or error
> + */
> +static ssize_t blkdev_copy_wait_io_completion(struct blkdev_copy_io *cio)
> +{
> +	ssize_t ret;
> +
> +	for (;;) {
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		if (!READ_ONCE(cio->waiter))
> +			break;
> +		blk_io_schedule();
> +	}
> +	__set_current_state(TASK_RUNNING);
> +	ret = cio->copied;
> +	kfree(cio);
> +
> +	return ret;
> +}
> +
> +static void blkdev_copy_offload_dst_endio(struct bio *bio)
> +{
> +	struct blkdev_copy_offload_io *offload_io = bio->bi_private;
> +	struct blkdev_copy_io *cio = offload_io->cio;
> +
> +	if (bio->bi_status) {
> +		cio->copied = min_t(ssize_t, offload_io->offset, cio->copied);
> +		if (!cio->status)
> +			cio->status = blk_status_to_errno(bio->bi_status);
> +	}
> +	bio_put(bio);
> +
> +	if (atomic_dec_and_test(&cio->refcount))
> +		blkdev_copy_endio(cio);
> +}
> +
> +/*
> + * @bdev:	block device
> + * @pos_in:	source offset
> + * @pos_out:	destination offset
> + * @len:	length in bytes to be copied
> + * @endio:	endio function to be called on completion of copy operation,
> + *		for synchronous operation this should be NULL
> + * @private:	endio function will be called with this private data,
> + *		for synchronous operation this should be NULL
> + * @gfp_mask:	memory allocation flags (for bio_alloc)
> + *
> + * For synchronous operation returns the length of bytes copied or error
> + * For asynchronous operation returns -EIOCBQUEUED or error
> + *
> + * Description:
> + *	Copy source offset to destination offset within block device, using
> + *	device's native copy offload feature. This function can fail, and
> + *	in that case the caller can fallback to emulation.
> + *	We perform copy operation using 2 bio's.
> + *	1. We take a plug and send a REQ_OP_COPY_SRC bio along with source
> + *	sector and length. Once this bio reaches request layer, we form a
> + *	request and wait for dst bio to arrive.
> + *	2. We issue REQ_OP_COPY_DST bio along with destination sector, length.
> + *	Once this bio reaches request layer and find a request with previously
> + *	sent source info we merge the destination bio and return.
> + *	3. Release the plug and request is sent to driver
> + *	This design works only for drivers with request queue.
> + */
> +ssize_t blkdev_copy_offload(struct block_device *bdev, loff_t pos_in,
> +			    loff_t pos_out, size_t len,
> +			    void (*endio)(void *, int, ssize_t),
> +			    void *private, gfp_t gfp)
> +{
> +	struct blkdev_copy_io *cio;
> +	struct blkdev_copy_offload_io *offload_io;
> +	struct bio *src_bio, *dst_bio;
> +	ssize_t rem, chunk, ret;
> +	ssize_t max_copy_bytes = bdev_max_copy_sectors(bdev) << SECTOR_SHIFT;
> +	struct blk_plug plug;
> +
> +	if (!max_copy_bytes)
> +		return -EINVAL;
> +
> +	ret = blkdev_copy_sanity_check(bdev, pos_in, bdev, pos_out, len);
> +	if (ret)
> +		return ret;
> +
> +	cio = kzalloc(sizeof(*cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	atomic_set(&cio->refcount, 1);
> +	cio->waiter = current;
> +	cio->endio = endio;
> +	cio->private = private;
> +
> +	/*
> +	 * If there is a error, copied will be set to least successfully
> +	 * completed copied length
> +	 */
> +	cio->copied = len;
> +	for (rem = len; rem > 0; rem -= chunk) {
> +		chunk = min(rem, max_copy_bytes);
> +
> +		offload_io = kzalloc(sizeof(*offload_io), GFP_KERNEL);
> +		if (!offload_io)
> +			goto err_free_cio;
> +		offload_io->cio = cio;
> +		/*
> +		 * For partial completion, we use offload_io->offset to truncate
> +		 * successful copy length
> +		 */
> +		offload_io->offset = len - rem;
> +
> +		src_bio = bio_alloc(bdev, 0, REQ_OP_COPY_SRC, gfp);
> +		if (!src_bio)
> +			goto err_free_offload_io;
> +		src_bio->bi_iter.bi_size = chunk;
> +		src_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
> +
> +		blk_start_plug(&plug);
> +		dst_bio = blk_next_bio(src_bio, bdev, 0, REQ_OP_COPY_DST, gfp);
> +		if (!dst_bio)
> +			goto err_free_src_bio;
> +		dst_bio->bi_iter.bi_size = chunk;
> +		dst_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
> +		dst_bio->bi_end_io = blkdev_copy_offload_dst_endio;
> +		dst_bio->bi_private = offload_io;
> +
> +		atomic_inc(&cio->refcount);
> +		submit_bio(dst_bio);
> +		blk_finish_plug(&plug);
> +		pos_in += chunk;
> +		pos_out += chunk;
> +	}
> +
> +	if (atomic_dec_and_test(&cio->refcount))
> +		blkdev_copy_endio(cio);
> +	if (cio->endio)
> +		return -EIOCBQUEUED;
> +
> +	return blkdev_copy_wait_io_completion(cio);
> +
> +err_free_src_bio:
> +	bio_put(src_bio);
> +err_free_offload_io:
> +	kfree(offload_io);
> +err_free_cio:
> +	cio->copied = min_t(ssize_t, cio->copied, (len - rem));
> +	cio->status = -ENOMEM;
> +	if (rem == len) {
> +		kfree(cio);
> +		return cio->status;
> +	}
> +	if (cio->endio)
> +		return cio->status;
> +
> +	return blkdev_copy_wait_io_completion(cio);
> +}
> +EXPORT_SYMBOL_GPL(blkdev_copy_offload);

Hmm. That looks a bit odd. Why do you have to use wait_for_completion?
Can't you submit the 'src' bio, and then submit the 'dst' bio from the 
endio handler of the 'src' bio?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

