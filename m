Return-Path: <linux-fsdevel+bounces-73801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3A1D20E3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 19:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845803043912
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E387632571F;
	Wed, 14 Jan 2026 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8lTOmn9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6C9296BB7
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416499; cv=none; b=ObxA7Y10XOXQ8LH1kmICpK2zd4EV6eJQjHi7binWeVWFGcQOb0u51hhFnQy8JHMOECHBp2v6fDXR8GSapdMH1heA/YTAhzVz9E4S8PoSECaxUhcFpsoMr5FFun0S1mmGAaZui+824Qv10w97h1rSMuoQofSoXmE29nn50hLRVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416499; c=relaxed/simple;
	bh=4CoRtm0i0BS2ZEUP+Fn5tOoBw3+OB4VGgXnt+rmOGQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lR0NxSUepbpW7vT5F8GjeUQ/xNepAm5wx3MmPk+yZSURAfcUN2RvrI6vgwRKvS2AY0qvURa/p//4vPknZ1AC4JuqbeLFF1HLtgVrT5gudx2bR4MNufThCIkvVOhwmEksQ44D5CK9epy0jmJjkbkxSFTCgpIP+G2zSdD1nv25W+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8lTOmn9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5frLD+2rxNstV3zU4wbe4fBThMmD1jGs55/ZE2A/WY8=; b=T8lTOmn9EACRWy+733m+QZae9X
	dgUFMCyuenZVeQ1yhHenM6+14F7hf/Y4Z2CAkTc9TogomKIHx3OxcCbJdPkATd2f1zPVaE2tNvXdy
	QZ/n4tb00LQdO712RXW1kjTT1+RzEry93p9aWWad3My75XJHRwqhNGJH5sO2a95u/deQ/3c7PPQnx
	dI/jGpjJarRcFTxRZ4ziBVdKzbx622YeBXxcVeRNisNziwLmt5FI1q0LDxzvMO5qEopNiB68mqptU
	kTbQ27OaN8xp8MSUV1QBxXYrdtSF4U27IDsvKI3FQobQjxukBr7QA0y0GAC4IUWQXANkYuExHJpAa
	i3gt879Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg5uf-00000006bGX-3gqT;
	Wed, 14 Jan 2026 18:48:13 +0000
Date: Wed, 14 Jan 2026 18:48:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix readahead folio refcounting race
Message-ID: <aWfk7T4sCjAhOVZ9@casper.infradead.org>
References: <20260114180255.3043081-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114180255.3043081-1-joannelkoong@gmail.com>

On Wed, Jan 14, 2026 at 10:02:55AM -0800, Joanne Koong wrote:
> readahead_folio() returns the next folio from the readahead control
> (rac) but it also drops the refcount on the folio that had been held by
> the rac. As such, there is only one refcount remaining on the folio
> (which is held by the page cache) after this returns.
> 
> This is problematic because this opens a race where if the folio does
> not have an iomap_folio_state struct attached to it and the folio gets
> read in by the filesystem's IO helper, folio_end_read() may have already
> been called on the folio (which will unlock the folio) which allows the
> page cache to evict the folio (dropping the refcount and leading to the
> folio being freed) by the time iomap_read_end() runs.
> 
> Switch to __readahead_folio(), which returns the folio with a reference
> held for the caller, and add explicit folio_put() calls when done with
> the folio.

No.  The direction we're going in is that there's no refcount held at
this point.  I just want to get this ANCK out before Christian applies
the patch; I'll send a followup with a better fix imminently.

> Fixes: d43558ae6729 ("iomap: track pending read bytes more optimally")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index fd9a2cf95620..96fab015371b 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -588,10 +588,11 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
>  		if (ctx->cur_folio &&
>  		    offset_in_folio(ctx->cur_folio, iter->pos) == 0) {
>  			iomap_read_end(ctx->cur_folio, *cur_bytes_submitted);
> +			folio_put(ctx->cur_folio);
>  			ctx->cur_folio = NULL;
>  		}
>  		if (!ctx->cur_folio) {
> -			ctx->cur_folio = readahead_folio(ctx->rac);
> +			ctx->cur_folio = __readahead_folio(ctx->rac);
>  			if (WARN_ON_ONCE(!ctx->cur_folio))
>  				return -EINVAL;
>  			*cur_bytes_submitted = 0;
> @@ -639,8 +640,10 @@ void iomap_readahead(const struct iomap_ops *ops,
>  	if (ctx->ops->submit_read)
>  		ctx->ops->submit_read(ctx);
>  
> -	if (ctx->cur_folio)
> +	if (ctx->cur_folio) {
>  		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
> +		folio_put(ctx->cur_folio);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(iomap_readahead);
>  
> -- 
> 2.47.3
> 
> 

