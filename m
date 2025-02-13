Return-Path: <linux-fsdevel+bounces-41629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C231A33835
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 07:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A630165B6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C05207A35;
	Thu, 13 Feb 2025 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x99Z+VOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D717EADC;
	Thu, 13 Feb 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429414; cv=none; b=Tgje58THWCDDuzqgc4ylhJsFRziyrIMF8wfbmuxY5ab/wXkgPHZ6zOGp19UO/CEaEKETaeJFN4P2qgGKJxPF4FqofmmOIKZ7xOP0b4usaDJzbfvDYvZJhEZMQ7hHGOwmbnqDWvaC+psWPUh5/Es8pzaTe/IxEbzxJ9IHmhEetf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429414; c=relaxed/simple;
	bh=zLlalgvnPlPl79Pj4q3EdUNwzxP11KfmHvMaKmr3Q/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrz0ylUeQlWKHyhIXPiuYiCksckm46qZuxmfzYccmolbjpuNepQB3OexOGJ4/TN6V80W90EBpfx38kpjnyRhaoFmG/IGGSUKGw9M5x6ZR2t4mqFbZP52VtpAVn/6M4MsDQCE5xtG+pD3n4VbklvIYQWrDP7m3rb8bV1RlBZ9k/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x99Z+VOv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rS0Zr3qHL+nTaU3fg6ZrpT0K/XiaxWPKoH/sIaK/eEU=; b=x99Z+VOvliCIQvvVKtQ0DIamoA
	muTCcrYz0G5p/y69w69R1TXBE3SyErGXrSbihv5q1MmzajUbgFyDUAGxdvq+9bQkGjIadzIHHGLVZ
	YqRL3X68yFlf5rPx6EH+HZt4MTNPcd3V+GlG7JRnLbItRVoirMd6OZJOjI6H6w630QpFGKxJsW0bz
	c4u+FEtg54I8amrWW8EbjPWy3M5itglBr9/oXHzDjo/iVv85/g/ldwIIVgNLWm50AUBPVAEly82Ja
	yI91joYQQugc/EMrkrMB1zzYiUoWz9dw0n17WJ3wbryDy64mHz1bcg4JCExsY+uqrCNQ/PhBRwHkc
	mwA2Rnlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT36-00000009zhO-07rZ;
	Thu, 13 Feb 2025 06:50:12 +0000
Date: Wed, 12 Feb 2025 22:50:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH 01/10] iomap: advance the iter directly on buffered read
Message-ID: <Z62WJACaaAP2oH1S@infradead.org>
References: <20250212135712.506987-1-bfoster@redhat.com>
 <20250212135712.506987-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212135712.506987-2-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 12, 2025 at 08:57:03AM -0500, Brian Foster wrote:
> iomap buffered read advances the iter via iter.processed. To
> continue separating iter advance from return status, update
> iomap_readpage_iter() to advance the iter instead of returning the
> number of bytes processed. In turn, drop the offset parameter and
> sample the updated iter->pos at the start of the function. Update
> the callers to loop based on remaining length in the current
> iteration instead of number of bytes processed.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 44 +++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ec227b45f3aa..44a366736289 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -366,12 +366,12 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  		pos >= i_size_read(iter->inode);
>  }
>  
> -static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
> -		struct iomap_readpage_ctx *ctx, loff_t offset)
> +static loff_t iomap_readpage_iter(struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx)
>  {
>  	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos + offset;
> -	loff_t length = iomap_length(iter) - offset;
> +	loff_t pos = iter->pos;
> +	loff_t length = iomap_length(iter);
>  	struct folio *folio = ctx->cur_folio;
>  	struct iomap_folio_state *ifs;
>  	loff_t orig_pos = pos;
> @@ -438,25 +438,22 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	 * we can skip trailing ones as they will be handled in the next
>  	 * iteration.
>  	 */
> -	return pos - orig_pos + plen;
> +	length = pos - orig_pos + plen;
> +	return iomap_iter_advance(iter, &length);

At this point orig_pos should orig_pos should always be just iter->pos
and we could trivially drop the variable, right?

> -static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> +static loff_t iomap_read_folio_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	struct folio *folio = ctx->cur_folio;
> -	size_t offset = offset_in_folio(folio, iter->pos);
> -	loff_t length = min_t(loff_t, folio_size(folio) - offset,
> -			      iomap_length(iter));
> -	loff_t done, ret;
> -
> -	for (done = 0; done < length; done += ret) {
> -		ret = iomap_readpage_iter(iter, ctx, done);
> -		if (ret <= 0)
> +	loff_t ret;
> +
> +	while (iomap_length(iter)) {
> +		ret = iomap_readpage_iter(iter, ctx);
> +		if (ret)
>  			return ret;

This looks so much nicer!

> -static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
> +static loff_t iomap_readahead_iter(struct iomap_iter *iter,
>  		struct iomap_readpage_ctx *ctx)
>  {
> -	loff_t length = iomap_length(iter);
> -	loff_t done, ret;
> +	loff_t ret;
>  
> -	for (done = 0; done < length; done += ret) {
> +	while (iomap_length(iter) > 0) {

iomap_length can't really be negative, so we could just drop the "> 0"
here.  Or if you think it's useful add it in the other loop above to
be consistent.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

