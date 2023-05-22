Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9870BC1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjEVLpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjEVLpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C76791;
        Mon, 22 May 2023 04:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F3E662156;
        Mon, 22 May 2023 11:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02E1C433EF;
        Mon, 22 May 2023 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684755949;
        bh=6osBNc+1R96qPdGszLby/qLWSiSW+HNIAW5t2+muLK0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hITQNh8Diaxm9RR24RVQSvxeHhiRgUbTJ8IGEUgJGgtSRlN/wvFeB+74H73y2HCyy
         go1/q7oGYPRlG7kILoT2EKoDgIl4EW2I/SFkwPOB3jM/YEC00iuEbcV4kEYeRPJrGn
         b3uy2qZ3l6BRklyiehU8tX14HM/AK7KU70yagqZnumul086n5LluEPenOJsK4uqBey
         KDMBs9VkDUSIoRcFQYgxQAPNG+IzF8iPaJkGQb/ipqgU0Z5aDW5dQtA90eI+EfIBoY
         i0FgKdblyDK0llVliLrXNXEcp87R195+PvifWqlTBvm/u6wcULkjaYnkCsPX53RrPv
         FmFs6uWrwtcXw==
Message-ID: <dba0bdea-4f64-8b3c-d366-1046860ccf07@kernel.org>
Date:   Mon, 22 May 2023 20:45:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v11 1/9] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230522104146.2856-1-nj.shetty@samsung.com>
 <CGME20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e@epcas5p3.samsung.com>
 <20230522104146.2856-2-nj.shetty@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230522104146.2856-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/23 19:41, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_bytes_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload: used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_bytes_hw: Reflects the device supported maximum limit.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 33 ++++++++++++++
>  block/blk-settings.c                 | 24 +++++++++++
>  block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
>  include/linux/blkdev.h               | 12 ++++++
>  include/uapi/linux/fs.h              |  3 ++
>  5 files changed, 136 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index c57e5b7cb532..e4d31132f77c 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -155,6 +155,39 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_offload
> +Date:		April 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] When read, this file shows whether offloading copy to a
> +		device is enabled (1) or disabled (0). Writing '0' to this
> +		file will disable offloading copies for this device.
> +		Writing any '1' value will enable this feature. If the device
> +		does not support offloading, then writing 1, will result in
> +		error.

will result is an error.

> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		April 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] This is the maximum number of bytes, that the block layer

Please drop the comma after block.

> +		will allow for copy request. This will be smaller or equal to

will allow for a copy request. This value is always smaller...

> +		the maximum size allowed by the hardware, indicated by
> +		'copy_max_bytes_hw'. Attempt to set value higher than

An attempt to set a value higher than...

> +		'copy_max_bytes_hw' will truncate this to 'copy_max_bytes_hw'.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> +Date:		April 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] This is the maximum number of bytes, that the hardware

drop the comma after bytes

> +		will allow in a single data copy request.

will allow for

> +		A value of 0 means that the device does not support
> +		copy offload.

Given that you do have copy emulation for devices that do not support hw
offload, how is the user supposed to know the maximum size of a copy request
when it is emulated ? This is not obvious from looking at these parameters.

> +
> +
>  What:		/sys/block/<disk>/queue/crypto/
>  Date:		February 2022
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..23aff2d4dcba 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->max_copy_sectors_hw = 0;
> +	lim->max_copy_sectors = 0;
>  }
>  
>  /**
> @@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_copy_sectors_hw = ULONG_MAX;
> +	lim->max_copy_sectors = ULONG_MAX;

UINT_MAX is not enough ?

>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_max_copy_sectors_hw - set max sectors for a single copy payload
> + * @q:  the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + **/
> +void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> +		unsigned int max_copy_sectors)
> +{
> +	if (max_copy_sectors > (COPY_MAX_BYTES >> SECTOR_SHIFT))
> +		max_copy_sectors = COPY_MAX_BYTES >> SECTOR_SHIFT;
> +
> +	q->limits.max_copy_sectors_hw = max_copy_sectors;
> +	q->limits.max_copy_sectors = max_copy_sectors;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);
> +
>  /**
>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>   * @q:  the request queue for the device
> @@ -578,6 +598,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> +	t->max_copy_sectors_hw = min(t->max_copy_sectors_hw,
> +						b->max_copy_sectors_hw);
> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index a64208583853..826ab29beba3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -212,6 +212,63 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>  	return queue_var_show(0, page);
>  }
>  
> +static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(blk_queue_copy(q), page);
> +}
> +
> +static ssize_t queue_copy_offload_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	s64 copy_offload;
> +	ssize_t ret = queue_var_store64(&copy_offload, page);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_offload && !q->limits.max_copy_sectors_hw)
> +		return -EINVAL;
> +
> +	if (copy_offload)
> +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> +
> +	return count;
> +}
> +
> +static ssize_t queue_copy_max_hw_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n", (unsigned long long)
> +			q->limits.max_copy_sectors_hw << SECTOR_SHIFT);
> +}
> +
> +static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n", (unsigned long long)
> +			q->limits.max_copy_sectors << SECTOR_SHIFT);
> +}
> +
> +static ssize_t queue_copy_max_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	s64 max_copy;
> +	ssize_t ret = queue_var_store64(&max_copy, page);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;
> +
> +	max_copy >>= SECTOR_SHIFT;
> +	if (max_copy > q->limits.max_copy_sectors_hw)
> +		max_copy = q->limits.max_copy_sectors_hw;
> +
> +	q->limits.max_copy_sectors = max_copy;

	q->limits.max_copy_sectors =
		min(max_copy, q->limits.max_copy_sectors_hw);

To remove the if above.

> +	return count;
> +}
> +
>  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(0, page);
> @@ -590,6 +647,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
> +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> +QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
> +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> +
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> @@ -637,6 +698,9 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_copy_offload_entry.attr,
> +	&queue_copy_max_hw_entry.attr,
> +	&queue_copy_max_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b441e633f4dd..c9bf11adccb3 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -295,6 +295,9 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned long		max_copy_sectors_hw;
> +	unsigned long		max_copy_sectors;

Why unsigned long ? unsigned int gives you 4G * 512 = 2TB max copy. Isn't that a
large enough max limit ?

> +
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -561,6 +564,7 @@ struct request_queue {
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
>  #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
> +#define QUEUE_FLAG_COPY		32	/* supports copy offload */

Nope. That is misleading. This flag is cleared in queue_copy_offload_store() if
the user writes 0. So this flag indicates that copy offload is enabled or
disabled, not that the device supports it. For the device support, one has to
look at max copy sectors hw being != 0.

>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
>  				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
> @@ -581,6 +585,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
> +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
>  #define blk_queue_zone_resetall(q)	\
>  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
>  #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
> @@ -899,6 +904,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
>  extern void blk_queue_max_segments(struct request_queue *, unsigned short);
>  extern void blk_queue_max_discard_segments(struct request_queue *,
>  		unsigned short);
> +extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> +		unsigned int max_copy_sectors);
>  void blk_queue_max_secure_erase_sectors(struct request_queue *q,
>  		unsigned int max_sectors);
>  extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
> @@ -1218,6 +1225,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>  	return bdev_get_queue(bdev)->limits.discard_granularity;
>  }
>  
> +static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
> +{
> +	return bdev_get_queue(bdev)->limits.max_copy_sectors;
> +}
> +
>  static inline unsigned int
>  bdev_max_secure_erase_sectors(struct block_device *bdev)
>  {
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index b7b56871029c..8879567791fa 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,9 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* maximum total copy length */
> +#define COPY_MAX_BYTES	(1 << 27)

My brain bit shifter is not as good as a CPU one :) So it would be nice to
mention what value that is in MB and also explain where this magic value comes from.

> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1

-- 
Damien Le Moal
Western Digital Research

