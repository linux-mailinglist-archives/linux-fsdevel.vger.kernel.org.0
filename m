Return-Path: <linux-fsdevel+bounces-19814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A208C9EDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5631C21222
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51072136E26;
	Mon, 20 May 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggletEnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9622E7C0B2;
	Mon, 20 May 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215604; cv=none; b=ZehN82VuTMLd0hMvUz7U2bvMLBcCHTkkVCe0mw0ULMXKYZKqKtw+DVYIFAsIC7yCA96Byaxdqdva+BeQwGGuqEaP6G5HsrRFFfCl6Fm1PkueKJxAOaW1bwqFrne2HDdvVk3JCI9mCqIaQfh7AXmTZtkla6TL49cDJM5wGc7ChOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215604; c=relaxed/simple;
	bh=xciCHReFFZlVddQDu0g7FFTsuuoF7H/QKFVGKEg8Gc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEqlV5guO/Ct8vqbCOTk5eiTvEjLIiJPon8L5Gty0iWGAivT9MuvzSn9oKK53gtc7vKbxMzBljdZcAkwY7t5ZZovx1WKUTz6GJrNElDJXrIvn6FCLdWhBZnReaKob+33gi/mJpSLEp8TNsQIt1T6J7AYKW/jDUFl9SpdlIyXnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggletEnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D3EC2BD10;
	Mon, 20 May 2024 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716215604;
	bh=xciCHReFFZlVddQDu0g7FFTsuuoF7H/QKFVGKEg8Gc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ggletEnJVNvT+XMfBN6K1gVjC0KEbb4ExeLzLf0vbaRRHkZ7IEvEOZKQ/PDc2oi8E
	 pXage4QdiC0oUqSrpJiUeB0dKqWhB9I2hK5C8yyHuxu3ceh9gv3Z3LhdYf2h19+aDY
	 oFvXuSOCMpaBZfU2sTrfs2yKp2E1sJ2bpIDWvK9q4yAf2KdBD459pZm2g4WzKYdPaZ
	 9LKPkZgdyYVLe5mOYkhyVJZG4nDEp5EiHkvCVT78MBz3DJ+jvCWsC1a70wZeVO+0qJ
	 P7lIZ7Cvagfs8b82Dg3wnyXYXdq61GunvMX/02kzLwD+9UncB7By2qWgOYlHFsdMqd
	 ZZ624nKVYYE4w==
Message-ID: <c31f663f-36c0-4db2-8bf6-8e3c699073ca@kernel.org>
Date: Mon, 20 May 2024 16:33:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com>
 <20240520102033.9361-2-nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240520102033.9361-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/20 12:20, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
> 	- copy_max_bytes (RW)
> 	- copy_max_hw_bytes (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_hw_bytes: Reflects the device supported maximum limit.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 23 +++++++++++++++
>  block/blk-settings.c                 | 34 ++++++++++++++++++++--
>  block/blk-sysfs.c                    | 43 ++++++++++++++++++++++++++++
>  include/linux/blkdev.h               | 14 +++++++++
>  4 files changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 831f19a32e08..52d8a253bf8e 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -165,6 +165,29 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		May 2024
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] This is the maximum number of bytes that the block layer
> +		will allow for a copy request. This is always smaller or
> +		equal to the maximum size allowed by the hardware, indicated by
> +		'copy_max_hw_bytes'. An attempt to set a value higher than
> +		'copy_max_hw_bytes' will truncate this to 'copy_max_hw_bytes'.
> +		Writing '0' to this file will disable offloading copies for this
> +		device, instead copy is done via emulation.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_hw_bytes
> +Date:		May 2024
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
> index a7fe8e90240a..67010ed82422 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -52,6 +52,9 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
>  	lim->max_user_discard_sectors = UINT_MAX;
> +	lim->max_copy_hw_sectors = UINT_MAX;
> +	lim->max_copy_sectors = UINT_MAX;
> +	lim->max_user_copy_sectors = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -219,6 +222,9 @@ static int blk_validate_limits(struct queue_limits *lim)
>  		lim->misaligned = 0;
>  	}
>  
> +	lim->max_copy_sectors =
> +		min(lim->max_copy_hw_sectors, lim->max_user_copy_sectors);
> +
>  	return blk_validate_zoned_limits(lim);
>  }
>  
> @@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
>  {
>  	/*
>  	 * Most defaults are set by capping the bounds in blk_validate_limits,
> -	 * but max_user_discard_sectors is special and needs an explicit
> -	 * initialization to the max value here.
> +	 * but max_user_discard_sectors and max_user_copy_sectors are special
> +	 * and needs an explicit initialization to the max value here.

s/needs/need

>  	 */
>  	lim->max_user_discard_sectors = UINT_MAX;
> +	lim->max_user_copy_sectors = UINT_MAX;
>  	return blk_validate_limits(lim);
>  }
>  
> @@ -316,6 +323,25 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/*
> + * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
> + * @q:	the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + */
> +void blk_queue_max_copy_hw_sectors(struct request_queue *q,
> +				   unsigned int max_copy_sectors)
> +{
> +	struct queue_limits *lim = &q->limits;
> +
> +	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
> +		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
> +
> +	lim->max_copy_hw_sectors = max_copy_sectors;
> +	lim->max_copy_sectors =
> +		min(max_copy_sectors, lim->max_user_copy_sectors);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);

Hmm... Such helper seems to not fit with Christoph's changes of the limits
initialization as that is not necessarily done using &q->limits but depending on
the driver, a different limit structure. So shouldn't this function be passed a
queue_limits struct pointer instead of the request queue pointer ?

> +
>  /**
>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>   * @q:  the request queue for the device
> @@ -633,6 +659,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> +	t->max_copy_hw_sectors = min(t->max_copy_hw_sectors,
> +				     b->max_copy_hw_sectors);
> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f0f9314ab65c..805c2b6b0393 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -205,6 +205,44 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>  	return queue_var_show(0, page);
>  }
>  
> +static ssize_t queue_copy_hw_max_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n", (unsigned long long)
> +		       q->limits.max_copy_hw_sectors << SECTOR_SHIFT);
> +}
> +
> +static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n", (unsigned long long)
> +		       q->limits.max_copy_sectors << SECTOR_SHIFT);
> +}

Given that you repeat the same pattern twice, may be add a queue_var64_show()
helper ? (naming can be changed).

> +
> +static ssize_t queue_copy_max_store(struct request_queue *q, const char *page,
> +				    size_t count)
> +{
> +	unsigned long max_copy_bytes;
> +	struct queue_limits lim;
> +	ssize_t ret;
> +	int err;
> +
> +	ret = queue_var_store(&max_copy_bytes, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;
> +
> +	blk_mq_freeze_queue(q);
> +	lim = queue_limits_start_update(q);
> +	lim.max_user_copy_sectors = max_copy_bytes >> SECTOR_SHIFT;

max_copy_bytes is an unsigned long, so 64 bits on 64-bit arch and
max_user_copy_sectors is an unsigned int, so 32-bits. There are thus no
guarantees that this will not overflow. A check is needed.

> +	err = queue_limits_commit_update(q, &lim);
> +	blk_mq_unfreeze_queue(q);
> +
> +	if (err)

You can reuse ret here. No need for adding the err variable.

> +		return err;
> +	return count;
> +}
> +
>  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(0, page);
> @@ -505,6 +543,9 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
> +QUEUE_RO_ENTRY(queue_copy_hw_max, "copy_max_hw_bytes");
> +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> +
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> @@ -618,6 +659,8 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_copy_hw_max_entry.attr,
> +	&queue_copy_max_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index aefdda9f4ec7..109d9f905c3c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -309,6 +309,10 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned int		max_copy_hw_sectors;
> +	unsigned int		max_copy_sectors;
> +	unsigned int		max_user_copy_sectors;
> +
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -933,6 +937,8 @@ void blk_queue_max_secure_erase_sectors(struct request_queue *q,
>  		unsigned int max_sectors);
>  extern void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors);
> +extern void blk_queue_max_copy_hw_sectors(struct request_queue *q,
> +					  unsigned int max_copy_sectors);
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,
>  		unsigned int max_write_same_sectors);
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigned int);
> @@ -1271,6 +1277,14 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>  	return bdev_get_queue(bdev)->limits.discard_granularity;
>  }
>  
> +/* maximum copy offload length, this is set to 128MB based on current testing */

Current testing will not be current in a while... So may be simply say
"arbitrary" or something. Also please capitalize the first letter of the
comment. So something like:

/* Arbitrary absolute limit of 128 MB for copy offload. */

> +#define BLK_COPY_MAX_BYTES		(1 << 27)

Also, it is not clear from the name if this is a soft limit or a cap on the
hardware limit... So at least please adjust the comment to say which one it is.

> +
> +static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
> +{
> +	return bdev_get_queue(bdev)->limits.max_copy_sectors;
> +}
> +
>  static inline unsigned int
>  bdev_max_secure_erase_sectors(struct block_device *bdev)
>  {

-- 
Damien Le Moal
Western Digital Research


