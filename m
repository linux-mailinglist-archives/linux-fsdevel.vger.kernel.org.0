Return-Path: <linux-fsdevel+bounces-62174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADDDB87228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5606F1CC31A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 21:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4772FA0F3;
	Thu, 18 Sep 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq/ir4UO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBF2EBB84;
	Thu, 18 Sep 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230865; cv=none; b=E8AxAf85P5wbddk8pTVeOcEl5su2uXQVIS2HIPTokcJHlvRXMTHsK1LhWNgwvwKvm/0ntgA1XbNrMas7xQa+L5pF/ifxX6h3mB3TKEBFCfUE3TYfjkZwU31oJXvUv2f3e2ZyezeKsohWR8Q8bcH6LfXX5BZ/2Er6UPIQlQ3bLEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230865; c=relaxed/simple;
	bh=0f4Lp8BvJEmbGEbwbDOYJDBzksXQKZkaMh8xyxf7tbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFHaPKFo0wSJ/nsOoyyHK+Id7v0UdNpiJjzMvwiteie3EuMWtUheKimPgrqf6pP4Co8JOKFvFyM8PQ4p6rkUWPj1/uct2V9ox8tyUhsRBfOzyO34Xz0AhoACCj66MXxwL+kanswKcKrpCl/gL3aBv2B7WYxFGFI60JKANxPtDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq/ir4UO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D61EC4CEE7;
	Thu, 18 Sep 2025 21:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758230864;
	bh=0f4Lp8BvJEmbGEbwbDOYJDBzksXQKZkaMh8xyxf7tbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq/ir4UOENI7uhnEKaY0G3DSseRKh7addg4WQTL12EJ4MCULwoB4SAMFqhVwwMlBq
	 uK21UuD2LMb/Hkpsdmls7dYH85Uxxx0l9rPyy7eBR3ViDybBI0DbuoggOmN5R/ERBZ
	 f6S21ml+8vq9bNX7GM8kCJcH5uM+mDjmq7j1vplOAOY7CCkKlkpT9qZ6tVzd3YG1l8
	 KigHLhcO2y5ionszEV9ikTp50J1/IIbIaRatQT1twe5ts1MU1hlR1AYTc2EXecmHYg
	 w0eGulrBQSM02e7PXr2PLrovzf2lxV6Wo+pSlOlmYM3qeuNoSSaKMkpbdSxluxJprX
	 FB2L9cvoBjBGg==
Date: Thu, 18 Sep 2025 14:27:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 02/15] iomap: move read/readahead bio submission logic
 into helper function
Message-ID: <20250918212743.GT1587915@frogsfrogsfrogs>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-3-joannelkoong@gmail.com>

On Tue, Sep 16, 2025 at 04:44:12PM -0700, Joanne Koong wrote:
> Move the read/readahead bio submission logic into a separate helper.
> This is needed to make iomap read/readahead more generically usable,
> especially for filesystems that do not require CONFIG_BLOCK.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good to me!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 05399aaa1361..ee96558b6d99 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -357,6 +357,14 @@ struct iomap_readpage_ctx {
>  	struct readahead_control *rac;
>  };
>  
> +static void iomap_bio_submit_read(struct iomap_readpage_ctx *ctx)
> +{
> +	struct bio *bio = ctx->bio;
> +
> +	if (bio)
> +		submit_bio(bio);
> +}
> +
>  static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
>  {
> @@ -382,8 +390,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
> -		if (ctx->bio)
> -			submit_bio(ctx->bio);
> +		iomap_bio_submit_read(ctx);
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> @@ -478,13 +485,10 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.status = iomap_read_folio_iter(&iter, &ctx);
>  
> -	if (ctx.bio) {
> -		submit_bio(ctx.bio);
> -		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
> -	} else {
> -		WARN_ON_ONCE(ctx.cur_folio_in_bio);
> +	iomap_bio_submit_read(&ctx);
> +
> +	if (!ctx.cur_folio_in_bio)
>  		folio_unlock(folio);
> -	}
>  
>  	/*
>  	 * Just like mpage_readahead and block_read_full_folio, we always
> @@ -550,12 +554,10 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
>  	while (iomap_iter(&iter, ops) > 0)
>  		iter.status = iomap_readahead_iter(&iter, &ctx);
>  
> -	if (ctx.bio)
> -		submit_bio(ctx.bio);
> -	if (ctx.cur_folio) {
> -		if (!ctx.cur_folio_in_bio)
> -			folio_unlock(ctx.cur_folio);
> -	}
> +	iomap_bio_submit_read(&ctx);
> +
> +	if (ctx.cur_folio && !ctx.cur_folio_in_bio)
> +		folio_unlock(ctx.cur_folio);
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 

