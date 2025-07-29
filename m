Return-Path: <linux-fsdevel+bounces-56264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87898B151B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EE518A46D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFC29827E;
	Tue, 29 Jul 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgWjM5w3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F128DF27;
	Tue, 29 Jul 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808185; cv=none; b=Jt58lbkQ5gBhC8PrXZxZPC+KQfEsojxAfSTgGBevhJlbSn2XIkndT0oRv1qdfXeqIqBM1r9Cre51vxQPEG8IUGlnCNUs2sz8JClVO9pEhm/vj3+v5y6KaZRcLF9USMD3tRobFaJoQu+OdV55HrtqYPU40MmUafUiRxGWzrYdlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808185; c=relaxed/simple;
	bh=JU9cJLhUxADwV8B7lb61J9Qm/bJ63FqgVTEZ8cqZAHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FN/brVwA7iEq/XFufXMnp2HVvr4yyTJKvMW1F94kSoWCqDUpV7wHEGjLP5GvGbgIKoGxZmohZg3Esi4qzB6GKdzstQwN/yzf9bTnxs0bdz5XsgywxZMoZXTVBxsJ3fS0dgyxuSMdPXpLYiLqZPtGGNKd+0AbWuchz/0AB0xg2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgWjM5w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4ADC4CEEF;
	Tue, 29 Jul 2025 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753808184;
	bh=JU9cJLhUxADwV8B7lb61J9Qm/bJ63FqgVTEZ8cqZAHw=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OgWjM5w3N6KIsRtvgWsvYUuf4D8Y3EV44Uu+PvFJN9k9jRpc4UZZYKcEGi0kemWqs
	 gFSMfWGHjzvu1pQvW3BMJ3NH5HqpWPNhPCK+EG82TGF6ZXrD9jEQ6lSwjEMDjxHGpN
	 OUZ9XToJPwO98mUdakK6eO1jBdSbd5X+RUaLw5AlE867umn/qvPCuKgkOzC5KXdmd3
	 ZXoAXi8jjaAyixZmiyd2VEMnJwJQ8aMQK/o7uRvU1Ea4c6OYgBnpg/apHLpDga381p
	 Uw1QxvQYohfVS37CinS705ETFmIvx6YfxnzVqXhnqn9RYtIOoXNnFh97pkNi4ZBlu2
	 //fdxjD9mj7Lw==
Message-ID: <3660751f-e230-498c-b857-99d61fe442e6@kernel.org>
Date: Wed, 30 Jul 2025 00:56:19 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@kernel.org
Subject: Re: [PATCH 1/2] md/raid0,raid4,raid5,raid6,raid10: fix bogus io_opt
 value
To: Tony Battersby <tonyb@cybernetics.com>, Song Liu <song@kernel.org>,
 Yu Kuai <yukuai3@huawei.com>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-raid@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b122fa8c-f6a0-4dee-b998-bde65d212c11@cybernetics.com>
Content-Language: en-US
From: Yu Kuai <yukuai@kernel.org>
In-Reply-To: <b122fa8c-f6a0-4dee-b998-bde65d212c11@cybernetics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

在 2025/7/30 0:12, Tony Battersby 写道:
> md-raid currently sets io_min and io_opt to the RAID chunk and stripe
> sizes and then calls queue_limits_stack_bdev() to combine the io_min and
> io_opt values with those of the component devices.  The io_opt size is
> notably combined using the least common multiple (lcm), which does not
> work well in practice for some drives (1), resulting in overflow or
> unreasonable values.
>
> dm-raid, on the other hand, sets io_min and io_opt through the
> raid_io_hints() function, which is called after stacking all the queue
> limits of the component drives, so the RAID chunk and stripe sizes
> override the values of the stacking.
>
> Change md-raid to be more like dm-raid by setting io_min and io_opt to
> the RAID chunk and stripe sizes after stacking the queue limits of the
> component devies.  This fixes /sys/block/md0/queue/optimal_io_size from
> being a bogus value like 3221127168 to being the correct RAID stripe
> size.
This is already discussed, and mtp3sas should fix this strange value.
>
> (1) SATA disks attached to mpt3sas report io_opt = 16776704, or
> 2^24 - 512.  See also commit 9c0ba14828d6 ("blk-settings: round down
> io_opt to physical_block_size").
>
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   drivers/md/md.c     | 15 +++++++++++++++
>   drivers/md/raid0.c  |  4 ++--
>   drivers/md/raid10.c |  4 ++--
>   drivers/md/raid5.c  |  4 ++--
>   4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 0f03b21e66e4..decf593d3bd7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5837,11 +5837,15 @@ EXPORT_SYMBOL_GPL(mddev_stack_rdev_limits);
>   int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
>   {
>   	struct queue_limits lim;
> +	unsigned int io_min;
> +	unsigned int io_opt;
>   
>   	if (mddev_is_dm(mddev))
>   		return 0;
>   
>   	lim = queue_limits_start_update(mddev->gendisk->queue);
> +	io_min = lim.io_min;
> +	io_opt = lim.io_opt;
>   	queue_limits_stack_bdev(&lim, rdev->bdev, rdev->data_offset,
>   				mddev->gendisk->disk_name);
>   
> @@ -5851,6 +5855,17 @@ int mddev_stack_new_rdev(struct mddev *mddev, struct md_rdev *rdev)
>   		queue_limits_cancel_update(mddev->gendisk->queue);
>   		return -ENXIO;
>   	}
> +	switch (mddev->level) {
> +	case 0:
> +	case 4:
> +	case 5:
> +	case 6:
> +	case 10:
> +		/* Preserve original chunk size and stripe size. */
> +		lim.io_min = io_min;
> +		lim.io_opt = io_opt;
> +		break;
> +	}
>   
>   	return queue_limits_commit_update(mddev->gendisk->queue, &lim);
>   }
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index d8f639f4ae12..657e66e92e14 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -382,12 +382,12 @@ static int raid0_set_limits(struct mddev *mddev)
>   	md_init_stacking_limits(&lim);
>   	lim.max_hw_sectors = mddev->chunk_sectors;
>   	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
> -	lim.io_min = mddev->chunk_sectors << 9;
> -	lim.io_opt = lim.io_min * mddev->raid_disks;
>   	lim.features |= BLK_FEAT_ATOMIC_WRITES;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>   	if (err)
>   		return err;
> +	lim.io_min = mddev->chunk_sectors << 9;
> +	lim.io_opt = lim.io_min * mddev->raid_disks;
This is too hacky, and I'm sure will break existing users, at least this 
will be a
mess to build raid array on the top of another array.

Thanks,
Kuai
>   	return queue_limits_set(mddev->gendisk->queue, &lim);
>   }
>   
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index c9bd2005bfd0..ea5147531ceb 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4011,12 +4011,12 @@ static int raid10_set_queue_limits(struct mddev *mddev)
>   
>   	md_init_stacking_limits(&lim);
>   	lim.max_write_zeroes_sectors = 0;
> -	lim.io_min = mddev->chunk_sectors << 9;
> -	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
>   	lim.features |= BLK_FEAT_ATOMIC_WRITES;
>   	err = mddev_stack_rdev_limits(mddev, &lim, MDDEV_STACK_INTEGRITY);
>   	if (err)
>   		return err;
> +	lim.io_min = mddev->chunk_sectors << 9;
> +	lim.io_opt = lim.io_min * raid10_nr_stripes(conf);
>   	return queue_limits_set(mddev->gendisk->queue, &lim);
>   }
>   
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index ca5b0e8ba707..bba647c38cff 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7727,8 +7727,6 @@ static int raid5_set_limits(struct mddev *mddev)
>   	stripe = roundup_pow_of_two(data_disks * (mddev->chunk_sectors << 9));
>   
>   	md_init_stacking_limits(&lim);
> -	lim.io_min = mddev->chunk_sectors << 9;
> -	lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
>   	lim.features |= BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE;
>   	lim.discard_granularity = stripe;
>   	lim.max_write_zeroes_sectors = 0;
> @@ -7736,6 +7734,8 @@ static int raid5_set_limits(struct mddev *mddev)
>   	rdev_for_each(rdev, mddev)
>   		queue_limits_stack_bdev(&lim, rdev->bdev, rdev->new_data_offset,
>   				mddev->gendisk->disk_name);
> +	lim.io_min = mddev->chunk_sectors << 9;
> +	lim.io_opt = lim.io_min * (conf->raid_disks - conf->max_degraded);
>   
>   	/*
>   	 * Zeroing is required for discard, otherwise data could be lost.
>
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f


