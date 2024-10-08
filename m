Return-Path: <linux-fsdevel+bounces-31304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677C39944C0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 957A6B26FBE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F052F19409C;
	Tue,  8 Oct 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BeZkH76i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306B18BB99;
	Tue,  8 Oct 2024 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380925; cv=none; b=jWfjewy3f+tMI8STw4Vmz6mZLHC5IXOxQDhm2lC3ulApxjT3ww0/N3B4i2NQBqz/rt/zJC9mhROh79Wx4zIykVX4kSTQYIo4G3g/RBEcTmNa3GoeEBwBFvHyRPY2WLP0q5+cvkKtqPqZG5p6prT2qLgtOH4llRRKw//ZN9Ih0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380925; c=relaxed/simple;
	bh=pT7qntOf17AvadpBcYUgwTKzG1s7QwQdwKkU8Xtyb+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAV7XMTw7AvBwGRh2XmY35BGFIt35qKCLMWtfmNXgQNBn9Df2SjIUCe2k9pAxH2C+Oq/Vtht0hEiaNdiZu0XBeoVs7q+GkF+UZcaV4nd0ID9QklMc7cx/b9nclJish4ghjCBT3TNSzbMo5rKpHXH4E3FQOBtLTwXCPAGF62xfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BeZkH76i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hnrqZO66EWmpYM+rVE+peV13SgqS5x5mVhBeG1fLfv4=; b=BeZkH76iAoZdPgzvt/7oQNLp9x
	PhL6Csjl2mcy7dCs85Mw2vRHSvKmYdRi8WOrF2Bhu8kk9OjI3d5NhKE+O/TYwZ5qkXTMUVC9IBWrF
	9VEsqeWFpxKNfbB0t18ZrNpXREQ0iopPxjVjryeNJnof1pl3tIipNHXdaTvo2DDwU53X9EWra91DU
	nftGjBa8GA+g0BIAa7lmwjmGimYzoixTlp6AMpFQKy2KPZ5iQ8td5eKKu7ESEMFjKqN6yn3+Xvg1R
	9s60tfS4KzV+P+N4AjIL8Kb73MvjrsQ2v+9UY7ItfiX1bXwZi7+DTmkQvFlPHbKb2LISDSW9QNKcA
	BJAhb0pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6pf-00000005Mt7-35nm;
	Tue, 08 Oct 2024 09:48:43 +0000
Date: Tue, 8 Oct 2024 02:48:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/12] iomap: Introduce IOMAP_ENCODED
Message-ID: <ZwT_-7RGl6ygY6dz@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 04:04:32PM -0400, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> An encoded extent must be read completely. Make the bio just as a
> regular bio and let filesystem deal with the rest of the extent.
> A new bio must be created if a new iomap is returned.
> The filesystem must be informed that the bio to be read is
> encoded and the offset from which the encoded extent starts. So, pass
> the iomap associated with the bio while calling submit_io. Save the
> previous iomap (associated with the bio being submitted) in prev in
> order to submit when the iomap changes.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/buffered-io.c | 17 ++++++++++-------
>  include/linux/iomap.h  | 11 +++++++++--
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 0e682ff84e4a..4c734899a8e5 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -378,12 +378,13 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  
> -	return srcmap->type != IOMAP_MAPPED ||
> +	return (srcmap->type != IOMAP_MAPPED &&
> +			srcmap->type != IOMAP_ENCODED) ||
>  		(srcmap->flags & IOMAP_F_NEW) ||
>  		pos >= i_size_read(iter->inode);

Non-standard indentation for the new line.  But at this point the
condition is becoming complex enough that it is best split into
multiple if statements anyway.


>  	sector = iomap_sector(iomap, pos);
>  	if (!ctx->bio ||
> +	    (iomap->type & IOMAP_ENCODED && iomap->offset != iter->prev.offset) ||

Overly long line.  And this could really use a comment as well.

> -static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> +static loff_t iomap_readahead_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)

Why is the iter de-constified?

In general I'm not a huge fan of the encoded magic here, but I'll
need to take a closer look at the caller if I can come up with
something better.

