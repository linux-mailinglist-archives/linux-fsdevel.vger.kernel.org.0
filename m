Return-Path: <linux-fsdevel+bounces-60606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E8B49F03
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 04:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E881BC0CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 02:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8922D7B1;
	Tue,  9 Sep 2025 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nTJlb2v7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB2D15A848;
	Tue,  9 Sep 2025 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384100; cv=none; b=ngSWIKmy1tZyTvE9zu6jeDxBgKB3Vs6wuN+mK777UQy7KFOXN/t92JE0mASn07e7xbXFIsbFaPut/pzeeJXdGLkXLNYgaoBbJnNzJcRqFn+sRpgx0ZSMdgwUFEI2TpZGJyFve4Y12j+fSNb6nBlreIpHB5B3JceuKpA1rTUf6Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384100; c=relaxed/simple;
	bh=Wps+OyxWaCXOFIIUN8fH/RJaPXux108yrkDeCKzXcLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUraf1NkOgzXNb6z43y6qYTHNiORJEaBamqnnBiO6vTEfD4L1jxil8qlQLoaDLv73fzVppWVoi8BzUPF2NMEfPbQSV8vAxVAp6bPBmdYglnP63FaN9PkYCWxdSaPxa6N+Ps0EWpOV2s9QrofBLfMk49kZgxS0u0paVxJtVCo2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nTJlb2v7; arc=none smtp.client-ip=47.90.199.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757384088; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v43zf9nWVT3sBkS/OER5LVhm/vl5yYsnxYjb37stWRA=;
	b=nTJlb2v7nbOAU0oaKcJ6TytcnMoTV8E4A03xSOuZAjUpBuajgzuy+p4tZzpN9cotbz5IsYzc9vLl4R4Z6HGY7BDZqtAyaybDuiIZEw/NIaDn9CECK8PjWzM31CjuV4O9CSG5ETqdWdVW932vVtEksPp0s519RDMhGBzIeELzaMc=
Received: from 30.221.131.27(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnbpmUx_1757384086 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 10:14:47 +0800
Message-ID: <a1529c0f-1f1a-477a-aeeb-a4f108aab26b@linux.alibaba.com>
Date: Tue, 9 Sep 2025 10:14:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] iomap: move read/readahead logic out of
 CONFIG_BLOCK guard
To: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
 miklos@szeredi.hu
Cc: hch@infradead.org, djwong@kernel.org, linux-block@vger.kernel.org,
 gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-14-joannelkoong@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250908185122.3199171-14-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/9 02:51, Joanne Koong wrote:
> There is no longer a dependency on CONFIG_BLOCK in the iomap read and
> readahead logic. Move this logic out of the CONFIG_BLOCK guard. This
> allows non-block-based filesystems to use iomap for reads/readahead.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>   fs/iomap/buffered-io.c | 151 +++++++++++++++++++++--------------------
>   1 file changed, 76 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f673e03f4ffb..c424e8c157dd 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -358,81 +358,6 @@ void iomap_finish_folio_read(struct folio *folio, size_t off, size_t len,
>   }
>   EXPORT_SYMBOL_GPL(iomap_finish_folio_read);
>   
> -#ifdef CONFIG_BLOCK
> -static void iomap_read_end_io(struct bio *bio)
> -{
> -	int error = blk_status_to_errno(bio->bi_status);
> -	struct folio_iter fi;
> -
> -	bio_for_each_folio_all(fi, bio)
> -		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> -	bio_put(bio);
> -}
> -
> -static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> -{
> -	struct bio *bio = ctx->private;
> -
> -	if (bio)
> -		submit_bio(bio);
> -
> -	return 0;
> -}
> -
> -/**
> - * Read in a folio range asynchronously through bios.
> - *
> - * This should only be used for read/readahead, not for buffered writes.
> - * Buffered writes must read in the folio synchronously.
> - */
> -static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
> -		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
> -{
> -	struct folio *folio = ctx->cur_folio;
> -	const struct iomap *iomap = &iter->iomap;
> -	size_t poff = offset_in_folio(folio, pos);
> -	loff_t length = iomap_length(iter);
> -	sector_t sector;
> -	struct bio *bio = ctx->private;
> -
> -	iomap_start_folio_read(folio, plen);
> -
> -	sector = iomap_sector(iomap, pos);
> -	if (!bio || bio_end_sector(bio) != sector ||
> -	    !bio_add_folio(bio, folio, plen, poff)) {
> -		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> -		gfp_t orig_gfp = gfp;
> -		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> -
> -		iomap_submit_read_bio(ctx);
> -
> -		if (ctx->rac) /* same as readahead_gfp_mask */
> -			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> -				     REQ_OP_READ, gfp);
> -		/*
> -		 * If the bio_alloc fails, try it again for a single page to
> -		 * avoid having to deal with partial page reads.  This emulates
> -		 * what do_mpage_read_folio does.
> -		 */
> -		if (!bio)
> -			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> -		if (ctx->rac)
> -			bio->bi_opf |= REQ_RAHEAD;
> -		bio->bi_iter.bi_sector = sector;
> -		bio->bi_end_io = iomap_read_end_io;
> -		bio_add_folio_nofail(bio, folio, plen, poff);
> -		ctx->private = bio;
> -	}
> -	return 0;
> -}
> -
> -const struct iomap_read_ops iomap_read_bios_ops = {
> -	.read_folio_range = iomap_read_folio_range_bio_async,
> -	.read_submit = iomap_submit_read_bio,
> -};
> -EXPORT_SYMBOL_GPL(iomap_read_bios_ops);
> -
>   static int iomap_read_folio_iter(struct iomap_iter *iter,
>   		struct iomap_read_folio_ctx *ctx, bool *cur_folio_owned)
>   {
> @@ -601,6 +526,82 @@ void iomap_readahead(const struct iomap_ops *ops,
>   }
>   EXPORT_SYMBOL_GPL(iomap_readahead);
>   
> +#ifdef CONFIG_BLOCK
> +static void iomap_read_end_io(struct bio *bio)
> +{
> +	int error = blk_status_to_errno(bio->bi_status);
> +	struct folio_iter fi;
> +
> +	bio_for_each_folio_all(fi, bio)
> +		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> +	bio_put(bio);
> +}
> +
> +static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> +{
> +	struct bio *bio = ctx->private;
> +
> +	if (bio)
> +		submit_bio(bio);
> +
> +	return 0;
> +}
> +
> +/**
> + * Read in a folio range asynchronously through bios.
> + *
> + * This should only be used for read/readahead, not for buffered writes.
> + * Buffered writes must read in the folio synchronously.
> + */
> +static int iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
> +		struct iomap_read_folio_ctx *ctx, loff_t pos, size_t plen)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	const struct iomap *iomap = &iter->iomap;
> +	size_t poff = offset_in_folio(folio, pos);
> +	loff_t length = iomap_length(iter);
> +	sector_t sector;
> +	struct bio *bio = ctx->private;
> +
> +	iomap_start_folio_read(folio, plen);
> +
> +	sector = iomap_sector(iomap, pos);
> +	if (!bio || bio_end_sector(bio) != sector ||
> +	    !bio_add_folio(bio, folio, plen, poff)) {
> +		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> +		gfp_t orig_gfp = gfp;
> +		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
> +
> +		if (bio)
> +			submit_bio(bio);
> +
> +		if (ctx->rac) /* same as readahead_gfp_mask */
> +			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> +		bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
> +				     REQ_OP_READ, gfp);
> +		/*
> +		 * If the bio_alloc fails, try it again for a single page to
> +		 * avoid having to deal with partial page reads.  This emulates
> +		 * what do_mpage_read_folio does.
> +		 */
> +		if (!bio)
> +			bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ, orig_gfp);
> +		if (ctx->rac)
> +			bio->bi_opf |= REQ_RAHEAD;
> +		bio->bi_iter.bi_sector = sector;
> +		bio->bi_end_io = iomap_read_end_io;
> +		bio_add_folio_nofail(bio, folio, plen, poff);
> +		ctx->private = bio;

Yes, I understand some way is needed to isolate bio from non-bio
based filesystems, and I also agree `bio` shouldn't be stashed
into `iter->private` since it's just an abuse usage as mentioned
in:
https://lore.kernel.org/r/20250903203031.GM1587915@frogsfrogsfrogs
https://lore.kernel.org/r/aLkskcgl3Z91oIVB@infradead.org

However, the naming of `(struct iomap_read_folio_ctx)->private`
really makes me feel confused because the `private` name in
`read_folio_ctx` is much like a filesystem read context instead
of just be used as `bio` internally in iomap for block-based
filesystems.

also the existing of `iter->private` makes the naming of
`ctx->private` more confusing at least in my view.

Thanks,
Gao Xiang

