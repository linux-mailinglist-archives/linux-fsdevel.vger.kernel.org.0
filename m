Return-Path: <linux-fsdevel+bounces-58139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8101B2A030
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 13:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB173B7823
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150030FF38;
	Mon, 18 Aug 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWNgzXFv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2AC2C2370;
	Mon, 18 Aug 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515844; cv=none; b=UY43weJU0Zj2oTiJRey1H3k/3fTEcj8rSUEK42aKBBNSMp00eDYZDoKWTwBfDpUJm3HNfxT4RUwuGbQFawhUX641iK+brpAm9pAT7uL5oG4dKS+Y1ygPCXa58yzN/VWjo0LHUwQ1amPHiZRCsYVh1YXlNbFGfBBgBqmyEZsdoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515844; c=relaxed/simple;
	bh=Vn+6AoeFfOC2dEOVUivoL+u8+xhCzZN6tjBzp+tZRCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufu2PCnbUBPt4Be6CfXYvgceicUB2vatlZY6QLqyKDERV4Ed7Xr5kT31NZk7QoBNWyBw/dcHvbnNdIH9+NV1kyFk0DaAAt5CHO3S4sT84IkEH2AhMi+lJFN9GiWPhDOu08Ds9DFYMMmz0Si22dShigc8hpjwdlcWapp/e7zEmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWNgzXFv; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 07:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755515839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7eARwxjHrjiUlBOiogcNArJCMPY65GQtpA9M3yDfEg=;
	b=gWNgzXFvM2QaqbmFBRvkjWKcwPYU1DAMKzIajtoC5k/zXPy73UOBOMiOt7CHhgObe/sVRc
	oJHt9snDy24PGD8frtEgFgwK122zorE+Ab22ALq5Qpw/bYsQa9alBQNERUDIRSXwKD90Cz
	R/c+5G3y4tj3D8DnaLGniWIm3XOhof8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	linux-bcachefs@vger.kernel.org, ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 2/3] bcachefs: stop using write_cache_pages
Message-ID: <3zji6rc56egwqvy2gy63aj2wjfo5pyeuq2iikhgudcttdcif2m@dphqqiozruka>
References: <20250818061017.1526853-1-hch@lst.de>
 <20250818061017.1526853-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818061017.1526853-3-hch@lst.de>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 18, 2025 at 08:10:09AM +0200, Christoph Hellwig wrote:
> Stop using the obsolete write_cache_pages and use writeback_iter
> directly.  This basically just open codes write_cache_pages
> without the indirect call, but there's probably ways to structure
> the code even nicer as a follow on.

Wouldn't inlining write_cache_pages() achieve the same thing?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/bcachefs/fs-io-buffered.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
> index 1c54b9b5bd69..fdeaa25189f2 100644
> --- a/fs/bcachefs/fs-io-buffered.c
> +++ b/fs/bcachefs/fs-io-buffered.c
> @@ -655,6 +655,17 @@ static int __bch2_writepage(struct folio *folio,
>  	return 0;
>  }
>  
> +static int bch2_write_cache_pages(struct address_space *mapping,
> +		      struct writeback_control *wbc, void *data)
> +{
> +	struct folio *folio = NULL;
> +	int error;
> +
> +	while ((folio = writeback_iter(mapping, wbc, folio, &error)))
> +		error = __bch2_writepage(folio, wbc, data);
> +	return error;
> +}
> +
>  int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc)
>  {
>  	struct bch_fs *c = mapping->host->i_sb->s_fs_info;
> @@ -663,7 +674,7 @@ int bch2_writepages(struct address_space *mapping, struct writeback_control *wbc
>  	bch2_inode_opts_get(&w->opts, c, &to_bch_ei(mapping->host)->ei_inode);
>  
>  	blk_start_plug(&w->plug);
> -	int ret = write_cache_pages(mapping, wbc, __bch2_writepage, w);
> +	int ret = bch2_write_cache_pages(mapping, wbc, w);
>  	if (w->io)
>  		bch2_writepage_do_io(w);
>  	blk_finish_plug(&w->plug);
> -- 
> 2.47.2
> 

