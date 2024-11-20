Return-Path: <linux-fsdevel+bounces-35279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499E59D359D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C292FB25746
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD66170A1A;
	Wed, 20 Nov 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sCbIQDkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C060DCF;
	Wed, 20 Nov 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091923; cv=none; b=Mc6DSA20z5YBMjSSTF87sF2Jz66IxfBj7inXucdIn0FQwMNgc9yolWuQjJEYG4pCVCJsDu0dny7qll0bOUO0O9HnEV8ptfZ7A69DDpChVGwR5V6/zjr36PUL3VW6kICKGSF0g13wqfwY1QpI4HsnC2Zdb04V9eEJjvMIJPDo16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091923; c=relaxed/simple;
	bh=TqEZb26ITS6jm8maCU3sYBC994TatjiJ0cfoGuXxjxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwVvW+u0qCAsU5jr/Ozs8w3YjxkQpP0YTRxBhiIlwqMyhpviTzluSzcZH3C6b7etRzAXYIzOOCv3xtgGKnAT94N7mQpvokffqIIzyaH2Hmh5yWW1Mq/x3wCRKYlHLjZ3tobYXpEsNdFt1w8MKHxsYufzMOQkVF8Gk38BDeseiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sCbIQDkR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OkBGfjAvfUSj8V9T1dOMACoRCnqnTitJzdB0t0O95MQ=; b=sCbIQDkR8b5tPw1yGbdKvLlpYg
	GxueTXQIGcTjdX7wH6axx+Yw1rXCj2kH0HQrtv+iFhmUzBfymoxQmfVqLYnFWWNYt+WbQ2G5zKrAa
	Mf5verrHW2LeNPcs/USv4XrryOFQHHoszy0asxcDaoV8m8E74lTns21MOV13k3KFzobExa3+6TVX/
	GeGon5WWFoOirmkiSKfrhdIVhjqv9Py3Zm4reg32k088yEd4S2B8HTYe6dpmsbZ7rqp/F2hDGZS1e
	vAWY7UUMzBcidngZo3BwcjoKw/uP9TqwyLZydwTXgeQDNGycdhflacFvX8OiT5Xkdy1XmZB9PYJQH
	XQ5XA/xg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgET-0000000EmlI-2vEv;
	Wed, 20 Nov 2024 08:38:41 +0000
Date: Wed, 20 Nov 2024 00:38:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] iomap: allow passing a folio into write begin
 path
Message-ID: <Zz2gEfgY8G7oTpdV@infradead.org>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <20241119154656.774395-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154656.774395-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 10:46:53AM -0500, Brian Foster wrote:
> To facilitate batch processing of dirty folios for zero range, tweak
> the write begin path to allow the caller to optionally pass in its
> own folio/pos combination.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ce73d2a48c1e..d1a86aea1a7a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -781,7 +781,7 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> -	struct folio *folio;
> +	struct folio *folio = *foliop;
>  	int status = 0;
>  
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
> @@ -794,9 +794,15 @@ static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	folio = __iomap_get_folio(iter, pos, len);
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> +	/*
> +	 * XXX: Might want to plumb batch handling down through here. For now
> +	 * let the caller do it.

Yeah, plumbing in the batch here would be nicer.

I suspect doing batch processing might actually be a neat thing for
the normal write patch as well.


