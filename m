Return-Path: <linux-fsdevel+bounces-47154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4CA9A0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 08:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98A8D1945F47
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 06:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4D1DED69;
	Thu, 24 Apr 2025 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+4zHtGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4C61C5F07;
	Thu, 24 Apr 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474810; cv=none; b=V9TIKHmUOODiRjYyktEh7W+wp5TGexorgU565xHdBlZtqLldtzI+sPT3CYmaTYiZjbqjxWBuDTFje8RQnb45zhobDLCrVSP3yi64bk/5c8aFc5DRlhKjq17ANdn51mNY969UBDVRzRLwrWIHK0rvZaVnymRNlTSDpuhDXH45PI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474810; c=relaxed/simple;
	bh=WGK9E7/qaLTf787QCZsaNhWUfFJ8XGt+6uy2r0LT8Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bp0sD4CVXDvgXR+JxWRJ7wEZlSkL2I1InYX6fE9aaCpStmju991itJBXlMUT7Mwaow7lxstPshQIxitg17ln2Z/WLp9W7hNht6+7Otii/1WOJP0D/feCRAkXGxftIMxnxAqQQAj+WRwaLAhsANDMtAVu3mIrlcNeTHs50j1+6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+4zHtGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D79CC4CEE3;
	Thu, 24 Apr 2025 06:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745474810;
	bh=WGK9E7/qaLTf787QCZsaNhWUfFJ8XGt+6uy2r0LT8Og=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E+4zHtGAwh2YipSe0jaYUgQ5H6OYyWEwKBjrcpWRICjFaAu7dJ9Ogb3J+uMOdRku8
	 IuciCbR2YacS6raxRq50hZlEfDQ962/ts8yv4RwVJaFoOZZ7pcXOVx7ZVJVUZcWwE/
	 eMO32ScbVm7F292ufsS9GQWV8JRzesehXUYL2rb1XjCj1rO6fMpFg1SNzgCb6vliOR
	 RZsP8CteQ0Rv7N2NoyDFAszSt6vcAgekOceEeeAOIapdL580FGv5fF/l0gW1i/T0wY
	 NQPwdyD6g0n1MdPaVvad3o1lS1Z4ZV5gWBKAc5pPTMwUoddkJXfonpCS3EqscOd2gn
	 V3Oh+HruZVAxA==
Message-ID: <3f860c62-6285-4462-b3de-932fa2888168@kernel.org>
Date: Thu, 24 Apr 2025 15:06:45 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] block: add a bio_add_vmalloc helper
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
 <20250422142628.1553523-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Add a helper to add a vmalloc region to a bio, abstracting away the
> vmalloc addresses from the underlying pages.  Also add a helper to
> calculate how many segments need to be allocated for a vmalloc region.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c         | 27 +++++++++++++++++++++++++++
>  include/linux/bio.h | 17 +++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index a6a867a432cf..3cc93bbdeeb9 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1058,6 +1058,33 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
>  }
>  EXPORT_SYMBOL(bio_add_folio);
>  
> +/**
> + * bio_add_vmalloc - add a vmalloc region to a bio
> + * @bio: destination bio
> + * @vaddr: virtual address to add
> + * @len: total length of the data to add

Nit: to be consistent in the wording...

 * @vaddr: address of the vmalloc region to add
 * @len: total length of the vmalloc region to add

> + *
> + * Add the data at @vaddr to @bio and return how much was added.  This can an

s/an/and

or may be simply:

This may be less than the amount originally asked.

> + * usually is less than the amount originally asked.  Returns 0 if no data could
> + * be added to the bio.
> + *
> + * This helper calls flush_kernel_vmap_range() for the range added.  For reads,
> + * the caller still needs to manually call invalidate_kernel_vmap_range() in
> + * the completion handler.
> + */
> +unsigned int bio_add_vmalloc(struct bio *bio, void *vaddr, unsigned len)
> +{
> +	unsigned int offset = offset_in_page(vaddr);
> +
> +	len = min(len, PAGE_SIZE - offset);
> +	if (bio_add_page(bio, vmalloc_to_page(vaddr), len, offset) < len)
> +		return 0;
> +	if (op_is_write(bio_op(bio)))
> +		flush_kernel_vmap_range(vaddr, len);
> +	return len;
> +}
> +EXPORT_SYMBOL_GPL(bio_add_vmalloc);
> +
>  void __bio_release_pages(struct bio *bio, bool mark_dirty)
>  {
>  	struct folio_iter fi;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 17a10220c57d..c4069422fd0a 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -433,6 +433,23 @@ static inline void bio_add_virt_nofail(struct bio *bio, void *vaddr,
>  	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
>  }
>  
> +/**
> + * bio_vmalloc_max_vecs - number of segments needed to map vmalloc data

Nit: number of BIO segments needed to add a vmalloc-ed region to a BIO ?

> + * @vaddr: address to map
> + * @len: length to map

Nit:

 * @vaddr: address of the vmalloc region to add
 * @len: total length of the vmalloc region to add

> + *
> + * Calculate how many bio segments need to be allocated to map the vmalloc/vmap

s/to map/to add ?

> + * range in [@addr:@len].  This could be an overestimation if the vmalloc area
> + * is backed by large folios.
> + */
> +static inline unsigned int bio_vmalloc_max_vecs(void *vaddr, unsigned int len)
> +{
> +	return DIV_ROUND_UP(offset_in_page(vaddr) + len, PAGE_SIZE);
> +}
> +
> +unsigned int __must_check bio_add_vmalloc(struct bio *bio, void *vaddr,
> +		unsigned len);
> +
>  int submit_bio_wait(struct bio *bio);
>  int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
>  		size_t len, enum req_op op);

Other than these wording nits, looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

