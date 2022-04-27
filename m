Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2023511520
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiD0Kpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiD0Kpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:45:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A499284D47;
        Wed, 27 Apr 2022 03:29:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 63E961F388;
        Wed, 27 Apr 2022 10:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651055356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ68u8jd1pGMMpvwjEOkdhZXSNG8xLLCdO1Cn+Xq+gA=;
        b=gDV+xrS2GbcllQPvhcHYRsIZ5JmMF2CTqkJH2hZzzFtDP0TXmtJZrpUuuojh3t96ebXcco
        MAc0BQ67VewzXUn+zMa2QyCdDcBvaXF2/Fq9ddaIFETQCt9fte7B7E4o+krYi72nEXZLYM
        2ZEuZ2TIjVXu6V9ocZWj7LvaM3Bftfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651055356;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJ68u8jd1pGMMpvwjEOkdhZXSNG8xLLCdO1Cn+Xq+gA=;
        b=EkM4US2Ur6JYETOSv0kVXMTGm4wfX9NWB6vWzYaHSmzhLafSzMfv1PShz4hn4/DwHAF+XD
        EYzGw+r4D0s0dBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 193711323E;
        Wed, 27 Apr 2022 10:29:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 24OHBfwaaWJ/AQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 27 Apr 2022 10:29:16 +0000
Message-ID: <2082148f-890f-e5f4-c304-b99212aa377e@suse.de>
Date:   Wed, 27 Apr 2022 12:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de,
        Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
 <20220426101241.30100-3-nj.shetty@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
In-Reply-To: <20220426101241.30100-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 12:12, Nitesh Shetty wrote:
> Introduce blkdev_issue_copy which supports source and destination bdevs,
> and an array of (source, destination and copy length) tuples.
> Introduce REQ_COPY copy offload operation flag. Create a read-write
> bio pair with a token as payload and submitted to the device in order.
> Read request populates token with source specific information which
> is then passed with write request.
> This design is courtesy Mikulas Patocka's token based copy
> 
> Larger copy will be divided, based on max_copy_sectors,
> max_copy_range_sector limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>   block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
>   block/blk.h               |   2 +
>   include/linux/blk_types.h |  21 ++++
>   include/linux/blkdev.h    |   2 +
>   include/uapi/linux/fs.h   |  14 +++
>   5 files changed, 271 insertions(+)
> 
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 09b7e1200c0f..ba9da2d2f429 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>   }
>   EXPORT_SYMBOL(blkdev_issue_discard);
>   
> +/*
> + * Wait on and process all in-flight BIOs.  This must only be called once
> + * all bios have been issued so that the refcount can only decrease.
> + * This just waits for all bios to make it through bio_copy_end_io. IO
> + * errors are propagated through cio->io_error.
> + */
> +static int cio_await_completion(struct cio *cio)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (cio->refcount) {
> +		cio->waiter = current;
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +		spin_unlock_irqrestore(&cio->lock, flags);
> +		blk_io_schedule();
> +		/* wake up sets us TASK_RUNNING */
> +		spin_lock_irqsave(&cio->lock, flags);
> +		cio->waiter = NULL;
> +		ret = cio->io_err;
> +	}
> +	spin_unlock_irqrestore(&cio->lock, flags);
> +	kvfree(cio);
> +
> +	return ret;
> +}
> +
> +static void bio_copy_end_io(struct bio *bio)
> +{
> +	struct copy_ctx *ctx = bio->bi_private;
> +	struct cio *cio = ctx->cio;
> +	sector_t clen;
> +	int ri = ctx->range_idx;
> +	unsigned long flags;
> +	bool wake = false;
> +
> +	if (bio->bi_status) {
> +		cio->io_err = bio->bi_status;
> +		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
> +		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
> +	}
> +	__free_page(bio->bi_io_vec[0].bv_page);
> +	kfree(ctx);
> +	bio_put(bio);
> +
> +	spin_lock_irqsave(&cio->lock, flags);
> +	if (((--cio->refcount) <= 0) && cio->waiter)
> +		wake = true;
> +	spin_unlock_irqrestore(&cio->lock, flags);
> +	if (wake)
> +		wake_up_process(cio->waiter);
> +}
> +
> +/*
> + * blk_copy_offload	- Use device's native copy offload feature
> + * Go through user provide payload, prepare new payload based on device's copy offload limits.
> + */
> +int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
> +{
> +	struct request_queue *sq = bdev_get_queue(src_bdev);
> +	struct request_queue *dq = bdev_get_queue(dst_bdev);
> +	struct bio *read_bio, *write_bio;
> +	struct copy_ctx *ctx;
> +	struct cio *cio;
> +	struct page *token;
> +	sector_t src_blk, copy_len, dst_blk;
> +	sector_t remaining, max_copy_len = LONG_MAX;
> +	unsigned long flags;
> +	int ri = 0, ret = 0;
> +
> +	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
> +	if (!cio)
> +		return -ENOMEM;
> +	cio->rlist = rlist;
> +	spin_lock_init(&cio->lock);
> +
> +	max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
> +	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
> +			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
> +
> +	for (ri = 0; ri < nr_srcs; ri++) {
> +		cio->rlist[ri].comp_len = rlist[ri].len;
> +		src_blk = rlist[ri].src;
> +		dst_blk = rlist[ri].dst;
> +		for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
> +			copy_len = min(remaining, max_copy_len);
> +
> +			token = alloc_page(gfp_mask);
> +			if (unlikely(!token)) {
> +				ret = -ENOMEM;
> +				goto err_token;
> +			}
> +
> +			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +			if (!ctx) {
> +				ret = -ENOMEM;
> +				goto err_ctx;
> +			}
> +			ctx->cio = cio;
> +			ctx->range_idx = ri;
> +			ctx->start_sec = dst_blk;
> +
> +			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!read_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
> +			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			read_bio->bi_iter.bi_size = copy_len;
> +			ret = submit_bio_wait(read_bio);
> +			bio_put(read_bio);
> +			if (ret)
> +				goto err_read_bio;
> +
> +			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
> +					gfp_mask);
> +			if (!write_bio) {
> +				ret = -ENOMEM;
> +				goto err_read_bio;
> +			}
> +			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
> +			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
> +			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
> +			write_bio->bi_iter.bi_size = copy_len;
> +			write_bio->bi_end_io = bio_copy_end_io;
> +			write_bio->bi_private = ctx;
> +
> +			spin_lock_irqsave(&cio->lock, flags);
> +			++cio->refcount;
> +			spin_unlock_irqrestore(&cio->lock, flags);
> +
> +			submit_bio(write_bio);
> +			src_blk += copy_len;
> +			dst_blk += copy_len;
> +		}
> +	}
> +

Hmm. I'm not sure if I like the copy loop.
What I definitely would do is to allocate the write bio before reading 
data; after all, if we can't allocate the write bio reading is pretty 
much pointless.

But the real issue I have with this is that it's doing synchronous 
reads, thereby limiting the performance.

Can't you submit the write bio from the end_io function of the read bio?
That would disentangle things, and we should be getting a better 
performance.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
