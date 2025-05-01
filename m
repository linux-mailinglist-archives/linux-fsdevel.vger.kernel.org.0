Return-Path: <linux-fsdevel+bounces-47857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC33AA6347
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F677B11A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5537224B12;
	Thu,  1 May 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO0jGRnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE921C1F22;
	Thu,  1 May 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125772; cv=none; b=KnoTtdZMIeRNCYkVS2aGPN3ZFTDZVILOyV/BKD/MbHnwSFBMxqkVI2H0wDuYyqsC7yg/yHjPNCshBgk7eZ4CZzJbho0pXTYzgDn1xhigKnEZVE+YXlrbEFwhgrVonqXM/OJMIGXMG9J+F0Cw/l/lkLuyoTYSLwY24AEp2E/91Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125772; c=relaxed/simple;
	bh=aoUCNHH94C/YkJgvrEffXlEDA3mvb7RNsiqKuxkjMRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgRahciW+OTdUY0nh4DZHjH8e3cxYcpPDqIlyH0EF5JsXCwbi79a4UxjdFwq/gZAw1sjSWQtmWy9DgP9ASrV9FOpy60IpDad0Mj2JEVEP8rpc7yjmtf7b6Ezzndih65ANMf3a8D4s3WY22Z5imnc1XdSP+3q6oIG/QtrBrm6MnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO0jGRnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3358C4CEE3;
	Thu,  1 May 2025 18:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125771;
	bh=aoUCNHH94C/YkJgvrEffXlEDA3mvb7RNsiqKuxkjMRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hO0jGRnJ7du929+TwtEY+N5BVvF4BaCClZbO/mETKu+E/gbBF3nOvGzsVRcTQeXxW
	 TxqzO7rF2L2n7yI0sQnJ7mclNdOTXlrJvuxIp898Nk8EsHFGbiADooLTqBDGAOSt9U
	 RZ4cIJVVZe7j/PgsxUC/8dhsby6z0Vvs3HWBkedosWKHauR442NsUMc9Kstpa7Ov0w
	 mgO/qR/B1RRiWD1rpK9pI05yhXujlLBB1uLqtPLQ1pz+biTtcQFdufygYYOFhrdVNs
	 vRlB+DBcyVMifXaaUHvoGH+yX6r9v5gWruUqjRf9ZLjE2RjuR6ohRZ0EGK4zA6tkj6
	 nYm9hj4GTok5w==
Message-ID: <282b0a35-cc60-4d61-a3b7-9b565c57b8bf@kernel.org>
Date: Fri, 2 May 2025 03:56:08 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] block: simplify bio_map_kern
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>,
 Carlos Maiolino <cem@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, slava@dubeyko.com,
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250430212159.2865803-1-hch@lst.de>
 <20250430212159.2865803-8-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250430212159.2865803-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 06:21, Christoph Hellwig wrote:
> Rewrite bio_map_kern using the new bio_add_* helpers and drop the
> kerneldoc comment that is superfluous for an internal helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.

> ---
>  block/blk-map.c | 56 ++++++++-----------------------------------------
>  1 file changed, 9 insertions(+), 47 deletions(-)
> 
> diff --git a/block/blk-map.c b/block/blk-map.c
> index ca6b55ac0da1..0bc823b168e4 100644
> --- a/block/blk-map.c
> +++ b/block/blk-map.c
> @@ -317,64 +317,26 @@ static void bio_map_kern_endio(struct bio *bio)
>  	kfree(bio);
>  }
>  
> -/**
> - *	bio_map_kern	-	map kernel address into bio
> - *	@data: pointer to buffer to map
> - *	@len: length in bytes
> - *	@op: bio/request operation
> - *	@gfp_mask: allocation flags for bio allocation
> - *
> - *	Map the kernel address into a bio suitable for io to a block
> - *	device. Returns an error pointer in case of error.
> - */
> -static struct bio *bio_map_kern(void *data, unsigned int len,
> -		enum req_op op, gfp_t gfp_mask)
> +static struct bio *bio_map_kern(void *data, unsigned int len, enum req_op op,
> +		gfp_t gfp_mask)
>  {
> -	unsigned long kaddr = (unsigned long)data;
> -	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	unsigned long start = kaddr >> PAGE_SHIFT;
> -	const int nr_pages = end - start;
> -	bool is_vmalloc = is_vmalloc_addr(data);
> -	struct page *page;
> -	int offset, i;
> +	unsigned int nr_vecs = bio_add_max_vecs(data, len);
>  	struct bio *bio;
>  
> -	bio = bio_kmalloc(nr_pages, gfp_mask);
> +	bio = bio_kmalloc(nr_vecs, gfp_mask);

This may also fail if nr_vecs is larger than UIO_MAXIOV, in which case, the
ENOMEM error may not really be appropriate. I guess we can sort this out
separately though.

>  	if (!bio)
>  		return ERR_PTR(-ENOMEM);
> -	bio_init(bio, NULL, bio->bi_inline_vecs, nr_pages, op);



-- 
Damien Le Moal
Western Digital Research

