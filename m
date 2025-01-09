Return-Path: <linux-fsdevel+bounces-38713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C0A06EF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44BE1639C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3E21422B;
	Thu,  9 Jan 2025 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAeFu2T9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3D200126;
	Thu,  9 Jan 2025 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736407240; cv=none; b=jAbcx2s03CggUc6SaebJRDjrHxn3kUdU/kCh+sLH1t8OMWwjuPhSSiT1InLAJ/aPa2GgU8lMYGF5Yjansiqe1pwRENhpxEiBOg+urKquZGcqGD3tboWvvlfdOnZbYvaqdrAfX02z8cBVHqbUr5RIChLyyJhIsqLGgra9pbxl4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736407240; c=relaxed/simple;
	bh=t24HPqtN0rVY3zUHkQR5oELpAI70cXNav+BJ5u6iccY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuJ/fr/YD20q2+0YH0OI/Z/fP/CfvAuMrJcTDCdqhdzZHW1H84twZ/1StTkgCG5nIjagJp/XXxbhYXMaxi/+X1qdgh3Eo4Aqfq57YLyUVquUq8/aCC4r9C96aE8ceOGpOi2bZ3iN4iar0rf2r73bxywshMnDmTc0sW6AMn7ZUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAeFu2T9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mz+ygRKoMsv8UuIr871Alpa1QFXGqs5EZGStdh6eAgc=; b=PAeFu2T9lFRIjyn5GwD09xHIZ6
	93aui31nY2jWkLiTgEtyVrZeHxgnkiTJYGrwTNolFXdlYXuXEZkwEcpcpQrU2+uTK+JKNZgXo6dTO
	PMujVhFMJFKrvOPoPO1HPmZnaQLisf6Xpx8wZZ1h14KsCJGazp4FZXk2CKQ5BZXTdvdoJdiik7Knt
	x7fqkxm8szgJmrMiahRyWgiCcIigokbS+pRVBRz2o6Ya/qnwQAb7LaVk4C6GbuJA2bjezmGi7NI1Y
	6tGaTHXhTxJKvj80i8GUVhCkyBl6ZAwewOTxatjI4JdsUqlX4zVagCGY6D7yLt6St4P/VmET9/vtx
	Kp5XVzYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVmqN-0000000B26n-0wYt;
	Thu, 09 Jan 2025 07:20:39 +0000
Date: Wed, 8 Jan 2025 23:20:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFCv2 2/4] iomap: optional zero range dirty folio
 processing
Message-ID: <Z394x1XyN5F0fd4h@infradead.org>
References: <20241213150528.1003662-1-bfoster@redhat.com>
 <20241213150528.1003662-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213150528.1003662-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Just a bit of nitpicking, otherwise this looks sane, although I'd
want to return to proper review of the squashed prep patches first.

>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> +	if (iter->fbatch) {
> +		struct folio *folio = folio_batch_next(iter->fbatch);
> +		if (folio) {

Missing empty line after the variable declaration.

> +	if (!folio) {
> +		WARN_ON_ONCE(!iter->fbatch);
> +		len = 0;
> +		goto out;

Given that the put label really just updates the return by reference
folio and len arguments we might as well do that here and avoid the
goto.

> +	} else if (folio_pos(folio) > iter->pos) {

Also no need for an else after a goto (or return).

> @@ -1374,6 +1393,11 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> +		if (!folio) {
> +			iomap_iter_advance(iter, iomap_length(iter));
> +			break;
> +		}

Maybe throw in a comment here how the NULL folio can happen?

> +	while (filemap_get_folios(mapping, &start, end, &fbatch) &&
> +	       folio_batch_space(iter->fbatch)) {
> +		struct folio *folio;
> +		while ((folio = folio_batch_next(&fbatch))) {
> +			if (folio_trylock(folio)) {
> +				bool clean = !folio_test_dirty(folio) &&
> +					     !folio_test_writeback(folio);
> +				folio_unlock(folio);
> +				if (clean)
> +					continue;
> +			}
> +
> +			folio_get(folio);
> +			if (!folio_batch_add(iter->fbatch, folio)) {
> +				end_pos = folio_pos(folio) + folio_size(folio);
> +				break;
> +			}
> +		}
> +		folio_batch_release(&fbatch);

I think I mentioned this last time, but I'd much prefer to do away
with the locla fbatch used for processing and rewrite this using a
find_get_entry() loop.  That probably means this helper needs to move
to filemap.c, which should be easy if we pass in the mapping and outer
fbatch.

> +		if (WARN_ON_ONCE(iter.fbatch && srcmap->type != IOMAP_UNWRITTEN))

Overly long line.

>  static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  {
> +	if (iter->fbatch) {
> +		folio_batch_release(iter->fbatch);
> +		kfree(iter->fbatch);
> +		iter->fbatch = NULL;
> +	}

Does it make sense to free the fbatch allocation on every iteration,
or should we keep the memory allocation around and only free it after
the last iteration?


