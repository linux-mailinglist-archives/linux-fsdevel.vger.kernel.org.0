Return-Path: <linux-fsdevel+bounces-20694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E39E8D6E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 07:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D943C285BEA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5F125C9;
	Sat,  1 Jun 2024 05:53:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F72111A8;
	Sat,  1 Jun 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717221216; cv=none; b=NG4FCQvC28xuQHPhB9o/+yObNrWyQDTbuhUEWxRIE92Bnsm1Z5eHg+2u/ZGdvu34W45EuN09z9rNFo7iHbBoJ8NjuS9HwP/LE6Bkwq7Ih30cmKH8wjXKPryALf1Prf/8jEgqwETVhq7dMARWdFCr9KyQnNnE4jKd5kCfIlFgxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717221216; c=relaxed/simple;
	bh=sK+PY7jfW5rGdua1lss1CPxpFyj2P5q7uLdGs1sUJpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1nzNO1OCc5horlZRo7K9qX1t1rYJPICSaJkMa3IS7oCysJAsZ9hitM7YBG3tnfFyvjXVQcy8FAdhR0zD/Hwba+Fj63F7uAeedkjKRPNlQWJ8rTUjGxAfEnZjGwKC9ZKs+Uchp4bGAgWgvClnXyFkjKxWbQLDFtMvB5aG+bxNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3643A68D17; Sat,  1 Jun 2024 07:53:23 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:53:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240601055323.GB5613@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com> <20240520102033.9361-2-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-2-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 03:50:14PM +0530, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
> 	- copy_max_bytes (RW)
> 	- copy_max_hw_bytes (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_hw_bytes: Reflects the device supported maximum limit.

That's a bit of a weird way to phrase the commit log as the queue_limits
are the main thing (and there are three of them as required for the
scheme to work).  The sysfs attributes really are just an artifact.

> @@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
>  {
>  	/*
>  	 * Most defaults are set by capping the bounds in blk_validate_limits,
> -	 * but max_user_discard_sectors is special and needs an explicit
> -	 * initialization to the max value here.
> +	 * but max_user_discard_sectors and max_user_copy_sectors are special
> +	 * and needs an explicit initialization to the max value here.

s/needs/need/

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

Please don't add new blk_queue_* helpers, everything should go through
the atomic queue limits API now.  Also capping the hardware limit
here looks odd.

> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;

This should probably go into blk_validate_limits and just round down.

Also most block limits are in kb.  Not that I really know why we are
doing that, but is there a good reason to deviate from that scheme?


