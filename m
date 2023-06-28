Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503CE740B34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjF1IY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:24:26 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:58889 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjF1ITt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432A96131D;
        Wed, 28 Jun 2023 06:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55F8C433C8;
        Wed, 28 Jun 2023 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687934415;
        bh=oLTq+iKrj17LlqKFqM7yyfd7btM7xW9Ms0g9sXkCcbY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T5oKMrz5s4Lya00ey+pGe8W728mfu4d6JL3p5TJ4MwKMiW2nPVsQJ6sguljni0uzn
         s/KOWdJRgJ/9tuYTRItCUhbiuofr0Aevp8UK/HKAT/61ttug8954rIV4mWs4sEhTm9
         K+hmbdZFCOi3qdFznwL04rC9m75JzBavT1XHr4Rgw/tcbS8/0mqqxnVeqWPIXyA8M6
         WUDY8NmQcMY4NvocjCw3ik6Ey9HHLLAvYkcUHBOZIIB+QMAm41GGVkDzW2/GmDyfol
         cMO01CyDc+0Z6K4524H4t7MaSDBHmcZTCtXCnC8xzZotNTl1y1upDdbL+sQYAjO9Di
         REnD7LeklvfVg==
Message-ID: <0d05d74e-48c5-2b99-dc28-482dc717e508@kernel.org>
Date:   Wed, 28 Jun 2023 15:40:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v13 1/9] block: Introduce queue limits for copy-offload
 support
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
        gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184000epcas5p1c7cb01eb1c70bc5a19f76ce21f2ec3f8@epcas5p1.samsung.com>
 <20230627183629.26571-2-nj.shetty@samsung.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230627183629.26571-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 03:36, Nitesh Shetty wrote:
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
>  Documentation/ABI/stable/sysfs-block | 33 +++++++++++++++
>  block/blk-settings.c                 | 24 +++++++++++
>  block/blk-sysfs.c                    | 63 ++++++++++++++++++++++++++++
>  include/linux/blkdev.h               | 12 ++++++
>  include/uapi/linux/fs.h              |  3 ++
>  5 files changed, 135 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index c57e5b7cb532..3c97303f658b 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -155,6 +155,39 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_offload
> +Date:		June 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] When read, this file shows whether offloading copy to a
> +		device is enabled (1) or disabled (0). Writing '0' to this
> +		file will disable offloading copies for this device.
> +		Writing any '1' value will enable this feature. If the device
> +		does not support offloading, then writing 1, will result in an
> +		error.

I am still not convinced that this one is really necessary. copy_max_bytes_hw !=
0 indicates that the devices supports copy offload. And setting copy_max_bytes
to 0 can be used to disable copy offload (which probably should be the default
for now).

> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		June 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] This is the maximum number of bytes that the block layer
> +		will allow for a copy request. This will is always smaller or

will is -> is

> +		equal to the maximum size allowed by the hardware, indicated by
> +		'copy_max_bytes_hw'. An attempt to set a value higher than
> +		'copy_max_bytes_hw' will truncate this to 'copy_max_bytes_hw'.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw

Nit: In keeping with the spirit of attributes like
max_hw_sectors_kb/max_sectors_kb, I would call this one copy_max_hw_bytes.

> +Date:		June 2023
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] This is the maximum number of bytes that the hardware
> +		will allow for single data copy request.
> +		A value of 0 means that the device does not support
> +		copy offload.
> +
> +
>  What:		/sys/block/<disk>/queue/crypto/
>  Date:		February 2022
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 4dd59059b788..738cd3f21259 100644
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
> +	lim->max_copy_sectors_hw = UINT_MAX;
> +	lim->max_copy_sectors = UINT_MAX;
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
> index afc797fb0dfc..43551778d035 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -199,6 +199,62 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
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
> +	unsigned long copy_offload;
> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
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

See above. I think we can drop this attribute.

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
> +	unsigned long max_copy;
> +	ssize_t ret = queue_var_store(&max_copy, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;
> +
> +	max_copy >>= SECTOR_SHIFT;
> +	q->limits.max_copy_sectors = min_t(unsigned int, max_copy,
> +					q->limits.max_copy_sectors_hw);
> +
> +	return count;
> +}
> +
>  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(0, page);
> @@ -522,6 +578,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
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
> @@ -638,6 +698,9 @@ static struct attribute *queue_attrs[] = {
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
> index ed44a997f629..6098665953e6 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -309,6 +309,9 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned int		max_copy_sectors_hw;
> +	unsigned int		max_copy_sectors;
> +
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -554,6 +557,7 @@ struct request_queue {
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
>  #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
> +#define QUEUE_FLAG_COPY		32	/* enable/disable device copy offload */
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
>  				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
> @@ -574,6 +578,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
> +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
>  #define blk_queue_zone_resetall(q)	\
>  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
>  #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
> @@ -891,6 +896,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
>  extern void blk_queue_max_segments(struct request_queue *, unsigned short);
>  extern void blk_queue_max_discard_segments(struct request_queue *,
>  		unsigned short);
> +extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> +		unsigned int max_copy_sectors);
>  void blk_queue_max_secure_erase_sectors(struct request_queue *q,
>  		unsigned int max_sectors);
>  extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
> @@ -1210,6 +1217,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
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
> index b7b56871029c..dff56813f95a 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,9 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  
> +/* maximum copy offload length, this is set to 128MB based on current testing */
> +#define COPY_MAX_BYTES	(1 << 27)
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1

-- 
Damien Le Moal
Western Digital Research

