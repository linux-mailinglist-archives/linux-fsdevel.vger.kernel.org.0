Return-Path: <linux-fsdevel+bounces-63900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC0BD1508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 05:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4A1896437
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747427A129;
	Mon, 13 Oct 2025 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1D+NRQBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820B1C8FBA
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 03:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760325208; cv=none; b=TfXOUMlocXj2KMQ6yleRIAD3a/u8izp/Q+0S2tdrp27/yEOnVlSjIjIbcf+SjI5+EqmSt0TgmIjHiAlcz5B+nTYlqYJT4C+/j8+INc5PF813W+0EzXYG3Fi78DTbKwjlRCln2DgyRSR62NhD70tJOEx8zyVLPZFwYSUJrLcieXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760325208; c=relaxed/simple;
	bh=J4ED8A13/+NmqUSpCMPsKYFFqp2y9ibwvRa0O16Zx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPbO+3JNpE69bfKClCP/97Kgf1ftAhLIjHYBvVHkY6KeU/yQ1e0fJu4eCCKPJXPS7pQpHDLucE9h+tGPYeM0n8UOaeyJdu7RWlf91d4/2ukPbZGXAU9+MJ3W+/e7K4zadWt26wpK/9T/W89F8LLHSczAXxAXduSm03ZAjqBs5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1D+NRQBd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wrZKhDRvxqfhpFObNZAZ9N1lsJp5O14/VE3d2mlxJzg=; b=1D+NRQBd6dIwRbUbFTfa2i6Phe
	mfgtMaKyMEVFguOyYIsmpWvRbI1JDSJDVm3LpJmDMhNGHuwiy3E17AeJlbunehYQxaGBtlWLTBCzh
	YfeavLjpPj7bD2OUwYGTTvidz39G1BmMfoseEBI2kDzBv4yOhbrRgwXNjpdWU1IRvCeCWpLe6ddaM
	AdTCawjGr7BShtHEz2RCefUWnEchFcybSxAUkGplQCcAZSZqMbbjOCcVzrshZMJAuBMPCG86rvn8i
	m5TIK1TNXB4PmdRs8VfjbLxJfP585ZvhVhqy0Y+jUPUkEqGofi54qyzy2uWStlC1ZEvl5Gmsr9hbo
	MkfCqFRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8901-0000000C9X9-2bhz;
	Mon, 13 Oct 2025 03:13:25 +0000
Date: Sun, 12 Oct 2025 20:13:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v1 8/9] iomap: use find_next_bit() for dirty bitmap
 scanning
Message-ID: <aOxuVR-WCfsFbqX5@infradead.org>
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009225611.3744728-9-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 09, 2025 at 03:56:10PM -0700, Joanne Koong wrote:
> Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> scanning. This uses __ffs() internally and is more efficient for
> finding the next dirty or clean bit than manually iterating through the
> bitmap range testing every bit.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 73 ++++++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 66c47404787f..37d2b76ca230 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -76,15 +76,49 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  		folio_mark_uptodate(folio);
>  }
>  
> -static inline bool ifs_block_is_dirty(struct folio *folio,
> -		struct iomap_folio_state *ifs, int block)
> +/**
> +* ifs_next_dirty_block - find the next dirty block in the folio
> +* @folio: The folio
> +* @start_blk: Block number to begin searching at
> +* @end_blk: Last block number (inclusive) to search
> +*
> +* If no dirty block is found, this will return end_blk + 1.
> +*/

I'm not a huge fan of using the very verbose kerneldoc comments for
static functions where this isn't even turned into generated
documentation.  Can you shorten the comments into normal non-structured
ones?

> +	if (start_blk > end_blk)
> +		return 0;
> +	else if (start_blk == end_blk)

No need for an else after a return.

> +		nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk)
> +				- start_blk;

Kernel style keeps the operator before the line break.

> +	for_each_clean_block(folio, first_blk, last_blk)

Given that this is the only user of this macro in the entire series,
what is the point of it?  Just open coding the search would be simpler.


