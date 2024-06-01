Return-Path: <linux-fsdevel+bounces-20699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0728D6E75
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 08:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CD81C2481C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2024 06:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BB14F6C;
	Sat,  1 Jun 2024 06:22:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF74125AC;
	Sat,  1 Jun 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717222946; cv=none; b=EEgXDuK6zLcMgXIoCQHuzN+4NGIWgKg/gimO/mkv1f+D/u8SdGG2vnYUSI8sH/knaTdaznS9YoBIUNaVQmonDspTJYZw08KSCCSDzPqLCWo2JTGD/kGaC5ev6U4I3o7PCzJhMItsMZr1h9D+Pc5tuDfk+Y9BRuaUKB477siWQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717222946; c=relaxed/simple;
	bh=ueo2AbPJP1H/rx7rcof5h1bt+mD9E8aJVXr9WZHpZv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bu+XsXp1Bv/WL0e6ojjdAW/GaO+iqZxJu0lFIMZZFt95vg1OFU8I7A7XAOSCLjcfwe3zROqLa7gR8c/T1/BwaFpnlKH5Hy6k7LKSk3qP/cw4XnV5xcuLZCiu9IvYn1VgPsiriKqDBSkIXBaa6LWn/oRwx8/8wVgFEjhlE3gg1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 941C868D1C; Sat,  1 Jun 2024 08:22:19 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:22:19 +0200
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
	gost.dev@samsung.com, Javier Gonz??lez <javier.gonz@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 07/12] nvme: add copy offload support
Message-ID: <20240601062219.GB6221@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7@epcas5p2.samsung.com> <20240520102033.9361-8-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 20, 2024 at 03:50:20PM +0530, Nitesh Shetty wrote:
> +	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
> +		return BLK_STS_IOERR;

This sounds like BLK_COPY_MAX_SEGMENTS is misnamed.  Right now this is
not a max segments, but the exact number of segments required.

>  /*
>   * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
> - * 
> + *

Please submit this whitespace fix separately.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8b1edb46880a..1c5974bb23d5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1287,6 +1287,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>  
>  /* maximum copy offload length, this is set to 128MB based on current testing */
>  #define BLK_COPY_MAX_BYTES		(1 << 27)
> +#define BLK_COPY_MAX_SEGMENTS		2

... and this doesn't belong into a NVMe patch.  I'd also expect that
the block layer would verify this before sending of the request to the driver.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 425573202295..5275a0962a02 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h

Note that we've usually kept adding new protocol bits to nvme.h separate
from the implementation in the host or target code.


