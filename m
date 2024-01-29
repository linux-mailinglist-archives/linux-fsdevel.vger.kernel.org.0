Return-Path: <linux-fsdevel+bounces-9468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B578416CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4927284FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD9D54677;
	Mon, 29 Jan 2024 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYbOj+lj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE651C38;
	Mon, 29 Jan 2024 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570780; cv=none; b=HkRn/LqRwZwbt5wpwrgWpjvrSBu5apmCVlS4mqdHcNCtuXpAK6uISpx1VjMRGenl89Y0uGVdL+dydoFaXikQgyEJM0aTU8oIZr/jkBg6I7SqWXBfvwfxFyOM5y51aiV8iydv6K0Ynht60DlsBZaf73DXoLciA35TEpQGYED9yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570780; c=relaxed/simple;
	bh=d/aQihyhdrtQJBuM7w+mKzeJ7H7OziElkA0HqJ7h9Ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1lIsFXnym3kNJiP+NccDTcW2rIXknVo143Dj+7m7cvip3EOQwmiZaUrrnbSDwh1Fav64Kd153Bs981xpg/xegGfz0spYJm9/UiPsepqi94Kka/f9S1bJl2vSaJ0ZMjBimtCouWZIh/yloAADWnId2tkloYRXEgo0b2v9NAINdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYbOj+lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE9C433F1;
	Mon, 29 Jan 2024 23:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570779;
	bh=d/aQihyhdrtQJBuM7w+mKzeJ7H7OziElkA0HqJ7h9Ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cYbOj+lj440jTo5PgwKnZXAFXNbloJYcUptUFrmP/kHDVvR5Z1i2RPWI4PU6Yxkym
	 Kg+OIUk9HDHgMKXZTE81B0sSLP2CSr5ZdS2J6eOdc+GiZqL350GMAvwUwofcabo2rn
	 pdAV3WTDvgkHzQH/AuUmbL1/MN6crGnAmcHZVMqy4YdEGfyg7DSfLdFL1Qk+BWwFw8
	 icjJpIuLa4aSSs+9DERd0+aaZ5zqBiYROxRuNxljVdlSRdlBfeNEElbCisc9dyRumd
	 WQQhGjtgaDkAecCk/hjPseTUUSpTW9yFJaXQDr6D2CdIkQeQUhI4T5hAM+EvQYomCT
	 df9fqY/vlV2qw==
Message-ID: <e2f8b1d7-78ab-4ef5-bb4f-088d60f7d7fc@kernel.org>
Date: Tue, 30 Jan 2024 08:26:17 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio
 scope
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-2-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Guard the calls to blkdev_zone_mgmt() with a memalloc_noio scope.
> This helps us getting rid of the GFP_NOIO argument to blkdev_zone_mgmt();
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/md/dm-zoned-metadata.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index fdfe30f7b697..165996cc966c 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -1655,10 +1655,13 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
>  
>  	if (!dmz_is_empty(zone) || dmz_seq_write_err(zone)) {
>  		struct dmz_dev *dev = zone->dev;
> +		unsigned int noio_flag;
>  
> +		noio_flag = memalloc_noio_save();
>  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
>  				       dmz_start_sect(zmd, zone),
> -				       zmd->zone_nr_sectors, GFP_NOIO);
> +				       zmd->zone_nr_sectors, GFP_KERNEL);
> +		memalloc_noio_restore(noio_flag);
>  		if (ret) {
>  			dmz_dev_err(dev, "Reset zone %u failed %d",
>  				    zone->id, ret);
> 

-- 
Damien Le Moal
Western Digital Research


