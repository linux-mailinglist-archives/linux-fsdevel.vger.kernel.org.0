Return-Path: <linux-fsdevel+bounces-60246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646FB43208
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFB258190D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39409246BB4;
	Thu,  4 Sep 2025 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nVOWQ730"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5711F61C;
	Thu,  4 Sep 2025 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966174; cv=none; b=CqK3hnzBEE6UNruya+OWYnwWvAncFxu9CVYmutRjmeJSE4X6KDDZCA3slcvqxTT/LNCT0SxxroxeNVs4DI6lCVLtkLwv0B7HLPOPfY/N7Lm0r0s6H8rQBKroCzpvrdsddHcD/GWGg46sEtPjM8hwZ4goP4V21d3iI0eRTm5RDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966174; c=relaxed/simple;
	bh=hJSkDHddAGaCCBsFJjfORe5bIVxSxKpXLzYzqXH+F7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcAghzuWB7ODgA/ZIqaUgWcPRIaAxELg9ftKsKCGblLUcCg/y2572hNzJuykZc/OhvLZa6Qk5WJl/UDemD7OP/GXvdJgw/RRVIg9ChYuS8jd+ffBjPHd/KjsnBWVf8EFQKPTTavuvluj/NwPAp755JjBDvLCpr35Wwuxrf9yRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nVOWQ730; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K0ztp/jWBH6U223FVYos4BoPMPm+JuIPBgJf10Hx6m0=; b=nVOWQ730yQfndSuJ4YP8f6rgDf
	lcpoRizPeTLbit6IAI+R0Io2VUiFmdgVKa9G1IuhBC14dTVltiuWAzDR6moZXQoy1jRdTl39J1NbN
	9TaH3Tm1uh+gfEd74oSCh7FsevUTEkeUi+lGem19eo4xJ5kM9PXz69rQ2PCT0lJ22qQYARpRAtsDj
	RC7yrMGHvOo6qNM4ggseOAQEuKvb5RCn9mqNHwLJkuqU12T9z/B9zjC/vWygfGvSj35Vnz7qfhKn1
	QvFIKXw2Mm2V/vzaroJATX8n99B+aiUD5Gg0sqFkAgaFf97DgVR1iIL1wS7VOmflPmQikqqf99lqe
	hgY9B4dw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3A4-00000009QZW-1FJy;
	Thu, 04 Sep 2025 06:09:32 +0000
Date: Wed, 3 Sep 2025 23:09:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <aLktHFhtV_4seMDN@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-6-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-6-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 29, 2025 at 04:56:16PM -0700, Joanne Koong wrote:
> Propagate any error encountered in iomap_read_folio() back up to its
> caller (otherwise a default -EIO will be passed up by
> filemap_read_folio() to callers). This is standard behavior for how
> other filesystems handle their ->read_folio() errors as well.

Is it?  As far as I remember we, or willy in particular has been
trying to kill this error return - it isn't very hepful when the
actually interesting real errors only happen on async completion
anyway.

> 
> Remove the out of date comment about setting the folio error flag.
> Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> Remove calls to set and clear folio error flag").
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/iomap/buffered-io.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9db233a4a82c..8dd26c50e5ea 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -495,12 +495,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  
>  	iomap_readfolio_complete(&iter, &ctx);
>  
> -	/*
> -	 * Just like mpage_readahead and block_read_full_folio, we always
> -	 * return 0 and just set the folio error flag on errors.  This
> -	 * should be cleaned up throughout the stack eventually.
> -	 */
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iomap_read_folio);
>  
> -- 
> 2.47.3
> 
---end quoted text---

