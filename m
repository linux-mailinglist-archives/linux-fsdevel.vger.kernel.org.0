Return-Path: <linux-fsdevel+bounces-71291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F104CBC985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037B830194D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FCD326D68;
	Mon, 15 Dec 2025 06:01:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E626F2BD;
	Mon, 15 Dec 2025 06:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778499; cv=none; b=tgH8hR75dEOpB/4HsSC3CK4q/xmVu06ZcoE7HJY6+xF2NFScTFYAs8Se6TCeY/qSx4aL0MkO+QzyfVFbXjVqIEDgR++WJDsgpO9Skb7keNGzsf6tE28qFyzE2GRayhzRq6qGxjIY7tgfaa9nSfAy6OAQGcS/k1H5aHiFkAgdTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778499; c=relaxed/simple;
	bh=LskhsMtiOGSZ/cLwjDdQl2ugEYhkbVZlDuXll7aR6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0aTBY6MZ6RQXlyWSTht4PwGmE//cMV1vyTs3+LBiZmZv6mlY6Gj9cXoUJMzasXs+KBtAwfHUNHNdgQ/pXRk8xweRH4R8pPEXEfVmr76GNCxp5xnzgGwEWAyTyfjZ7QS6L/a8f7HQVTxsnP1hr+jPUvp0nXdrQ/UpQP0Dmr29Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAF8D227A87; Mon, 15 Dec 2025 07:01:34 +0100 (CET)
Date: Mon, 15 Dec 2025 07:01:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted
 bio page allocation
Message-ID: <20251215060133.GB31097@lst.de>
References: <20251210152343.3666103-1-hch@lst.de> <20251210152343.3666103-8-hch@lst.de> <20251213012141.GE2696@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213012141.GE2696@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 12, 2025 at 05:21:41PM -0800, Eric Biggers wrote:
> > +	memset(pages, 0, sizeof(struct page *) * nr_segs);
> > +	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
> > +	if (nr_allocated < nr_segs)
> > +		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
> > +				nr_segs, nr_allocated);
> 
> alloc_pages_bulk() is documented to fill in pages sequentially.  So the
> "random pages in the array unallocated" part seems misleading.  This
> also means that only the remaining portion needs to be passed to
> mempool_alloc_bulk(), similar to blk_crypto_fallback_encrypt_endio().

I the better idea is to offset the search in mempool_alloc_bulk
based on the passed in allocated argument.  I'll prepare a patch for
that.


