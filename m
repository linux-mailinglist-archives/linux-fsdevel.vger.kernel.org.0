Return-Path: <linux-fsdevel+bounces-47153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 265D9A9A0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A2E1945F4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D41DB548;
	Thu, 24 Apr 2025 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUercfWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953F2701B8;
	Thu, 24 Apr 2025 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474377; cv=none; b=WllHRL+xIKGXTOAS9FexwxvsvqrXgvg/wKJytPNY1uVisGJChU8N1uriZtVL0W0yj2pBQMys7+Wwz1D0dP9qc9S3ZonBUgdHOH5O3LFDGF6DTz7RYSMhl+EomxD3KfKxxjI++B/qS7gIppYs3G+tOey9v40DjB5V8SJIZ8fF8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474377; c=relaxed/simple;
	bh=RVfHEn1l3qUMo/fBvZ0wGlN0YHW9ntQqSNIyl4PNeTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEhwJU38Q09XqNCHGRVUZ8fOr+iZaS/oYh4KXEmW0xvv+OnjvzVXppn8FFdqBZ6rX911SEWqhJZT2yccWGDqiEzhBcS8RGVV4lpy9HzdJT6qkcwD5fbBdiyvWXNbKyGU9ZBTv8R0pD9WzwU+lruqShHov2yvUHoVBCmrw4Yve0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUercfWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCE8C4CEE3;
	Thu, 24 Apr 2025 05:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745474377;
	bh=RVfHEn1l3qUMo/fBvZ0wGlN0YHW9ntQqSNIyl4PNeTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XUercfWm6e4WRZ+U7Ue0ZN6bD9nHN7vcFo3x+/FCSsmm3sbWRertGFFsvjIAXyStD
	 4ZQMmj13qmDGX9HST3EMV18piz0DgQktZmq31phrgD6Hrefs5L5L8Sv4pNRR7oXHvt
	 5rQw3O7eajeMw+zvhBzG/OKFlZNPlWlU/BIcUC/ZnBgKaT5Krrhv4dxKKL7yu+Ljon
	 WNVjbR0hmKtHWSASPJ+UEXgi45jw+1jkPor1MT3bgCZfo6JlD3Gg4EpdNFUjUyOqDV
	 wiFxiUoW6RYlcOcIQBbezSu4lGwABjMe/Ft87RRkjuIhDc+buykshKIYErP3Ft9l59
	 JsH8kQWiMsZNw==
Message-ID: <12473563-eafd-4e1f-858d-3a244aec6d8a@kernel.org>
Date: Thu, 24 Apr 2025 14:59:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] block: add a bdev_rw_virt helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-3-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Add a helper to perform synchronous I/O on a kernel direct map range.
> Currently this is implemented in various places in usually not very
> efficient ways, so provide a generic helper instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 30 ++++++++++++++++++++++++++++++
>  include/linux/bio.h |  5 ++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 4e6c85a33d74..a6a867a432cf 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1301,6 +1301,36 @@ int submit_bio_wait(struct bio *bio)
>  }
>  EXPORT_SYMBOL(submit_bio_wait);
>  
> +/**
> + * bdev_rw_virt - synchronously read into / write from kernel mapping
> + * @bdev:	block device to access
> + * @sector:	sector to accasse

s/accasse/access

> + * @data:	data to read/write
> + * @len:	length to read/write

Maybe "length in bytes to read/write", to avoid any confusion with sector unit.

With that, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

