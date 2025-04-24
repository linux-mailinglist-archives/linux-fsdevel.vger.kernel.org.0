Return-Path: <linux-fsdevel+bounces-47152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88054A9A0AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6D14454ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 05:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3AB1DB128;
	Thu, 24 Apr 2025 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9UM6IWk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AE2701B8;
	Thu, 24 Apr 2025 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474168; cv=none; b=IW8aKDmO6D2zuN8L+3kPH9SuNSJS8+awnrva5rolkc63Eaq3dy6PGPnDKc2E80CZJmi7x03wzbGpILKCYlHWB6DWRQY7vXzkkTfwOVsfa35PPTd99k7GAey2Z61EF9UoRggG8AksDweq6/8BTc3RLY+xUWbzMZKLnjGRXNwi1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474168; c=relaxed/simple;
	bh=oZkKhqQBMZiuxEgfsDNa+7Jj1Ykre8OoNXuKqazZy5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LImwnOK7j0dDVy1RCYFNIW9nJt7MgCPNH/xnnUGr9NEg49KdE3rw5XvzhkxyBYCUYxppYD09nXJ8QBdl177gFS40U7/6Pjv23J0jMhjBV9qBNbdSZoOUHCCK828DK2RTvibPpcINJLjI2gpe37IuCkbn1h+geVUOautjm7TASqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9UM6IWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76836C4CEE3;
	Thu, 24 Apr 2025 05:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745474167;
	bh=oZkKhqQBMZiuxEgfsDNa+7Jj1Ykre8OoNXuKqazZy5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C9UM6IWkGpHgQ+AreIBAsDT6ksEGQHQZZLCZsWdCyVQfO9nywdqHCUFjE4dnkjI4v
	 XjwT4dxTcJefuR2CauB5szxf7RIwFHdXejZCq9gKa51uan+cutuS6QPoPKoMvfOfHX
	 viTKKxlMSYuTjlkQQ8a4QM6r9dmCDn5wJHMxFffRBNFwPHC9ovp9rghiQ+n3rqG7w9
	 /eOI2+NXP5UiKDmcT6ZE1Czqp5V/3OeE1UA4WvmhYaFaFL3055xw2vqszd2+WSXqeB
	 rKr0QrvQGCT4XQyAacZPGEhSVzlCEVg6JPbxNn3WhZ7kwSC4rLnrK3Z10YXty5CqgI
	 ddFLOfbA38xDA==
Message-ID: <98fcbf51-b91c-4211-98d2-a987bdc09f49@kernel.org>
Date: Thu, 24 Apr 2025 14:56:03 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] block: add a bio_add_virt_nofail helper
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
 <20250422142628.1553523-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250422142628.1553523-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 23:26, Christoph Hellwig wrote:
> Add a helper to add a directly mapped kernel virtual address to a
> bio so that callers don't have to convert to pages or folios.
> 
> For now only the _nofail variant is provided as that is what all the
> obvious callers want.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/bio.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index cafc7c215de8..0678b67162ee 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -417,6 +417,23 @@ void __bio_add_page(struct bio *bio, struct page *page,
>  		unsigned int len, unsigned int off);
>  void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
>  			  size_t off);
> +
> +/**
> + * bio_add_virt_nofail - add data in the diret kernel mapping to a bio

s/diret/direct

With that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> + * @bio: destination bio
> + * @vaddr: data to add
> + * @len: length of the data to add, may cross pages
> + *
> + * Add the data at @vaddr to @bio.  The caller must have ensure a segment
> + * is available for the added data.  No merging into an existing segment
> + * will be performed.
> + */
> +static inline void bio_add_virt_nofail(struct bio *bio, void *vaddr,
> +		unsigned len)
> +{
> +	__bio_add_page(bio, virt_to_page(vaddr), len, offset_in_page(vaddr));
> +}
> +
>  int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
>  void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
>  void __bio_release_pages(struct bio *bio, bool mark_dirty);


-- 
Damien Le Moal
Western Digital Research

