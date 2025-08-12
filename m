Return-Path: <linux-fsdevel+bounces-57482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D205AB22079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 10:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2183B16FCE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E52DF3F8;
	Tue, 12 Aug 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FrxgrVtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1273B2E1C69
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986514; cv=none; b=ZsPJa23ixkFwXgkm07PR4mCxeN/CTtA4iuaz8dl0lvRon0xO1zhgUZMPb6vb0WrpX3oaMieAAVzJlwfydwixrEzu86kxybOQzscPYDIatrIFkv2ZJtGXn+HVwxw6x0R4Teszj/URADnQ64S6R/vn3CBaY60aoyXysFiRq4n7HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986514; c=relaxed/simple;
	bh=neAzmMUGnx0hJU+0Lv5HU49gdojYbeGHBQFKu1UKZ2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsvbdwAb0K2wKykvMYcjeRFjsAPKsz011LaFffLSI4cc+4vLFItPm1B/PMplu+FQQIbB66ML34GfLM8KNk7kLgxY2KcVPi+90huPe3MAOS5XDLteOK5txSL+2pgvSAW+kYpmimZkKy/4H9rL2tHk0G36dY7CvWhv1g/e6X/Ul04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FrxgrVtU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i1a5Sy4YXsTFeKN4+P/fLFTUGtAtBymy9RHHSvlwq08=; b=FrxgrVtUVjW5SqogYthsgZQlMi
	3p9g3b7adEh2YYSjclbIwZ0WhtVD9/BX8CHMnZekNVB8i/LiykRD/TCPmp26qfayA8QiJ2ggmxaUK
	8ysWryy8KrFCGC6y8hhuG3dugZ3mimUXurnGuDuRaf0CMwajEfIpVYZ50/zhErLLCo/OUx8d0KLpO
	CeyNsDeGsLhVwMOxpTQD7eAtGX5AkcsPUmt0Ob2GgPcr4a5vHaxbhkqqTCrqNsKmh4h9h2SXALsYQ
	Gd70A9nI4eGUBST4exzrVi1Fy82LRkw35oXoAQFj8HegkAjInKfHMw6ASYQiRC/t0pCW0uoSLSdxh
	2UWM/1cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulkA3-0000000ADHX-22WD;
	Tue, 12 Aug 2025 08:15:11 +0000
Date: Tue, 12 Aug 2025 01:15:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org,
	jack@suse.cz, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback
 accounting
Message-ID: <aJr4D9ec7XG92G--@infradead.org>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801002131.255068-11-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcc6e0e5334e..626c3c8399cc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -20,6 +20,8 @@ struct iomap_folio_state {
>  	spinlock_t		state_lock;
>  	unsigned int		read_bytes_pending;
>  	atomic_t		write_bytes_pending;
> +	/* number of pages being currently written back */
> +	unsigned		nr_pages_writeback;

This adds more sizse to the folio state.  Shouldn't this be the same
as

    DIV_ROUND_UP(write_bytes_pending, PAGE_SIZE)

anyway?

> +	unsigned end_blk = min((unsigned)(i_size_read(inode) >> inode->i_blkbits),
> +				i_blocks_per_folio(inode, folio));

Overly long line.  Also not sure why the cast is needed to start with?

> +	unsigned nblks = 0;
> +
> +	while (start_blk < end_blk) {
> +		if (ifs_block_is_dirty(folio, ifs, start_blk))
> +			nblks++;
> +		start_blk++;
> +	}

We have this pattern open coded in a few places.  Maybe factor it into a
helper first?  And then maybe someone smart can actually make it use
find_first_bit/find_next_bit.

> +static bool iomap_granular_dirty_pages(struct folio *folio)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode;
> +	unsigned block_size;
> +
> +	if (!ifs)
> +		return false;
> +
> +	inode = folio->mapping->host;
> +	block_size = 1 << inode->i_blkbits;
> +
> +	if (block_size >= PAGE_SIZE) {
> +		WARN_ON(block_size & (PAGE_SIZE - 1));
> +		return true;
> +	}
> +	return false;

Do we need the WARN_ON?  Both the block and page size must be powers
of two, so I can't see how it would trigger.  Also this can use the
i_blocksize helper.

I.e. just turn this into:

	return i_blocksize(folio->mapping->host) >= PAGE_SIZE;


> +static bool iomap_dirty_folio_range(struct address_space *mapping, struct folio *folio,

Overly long line.

> +	wpc->wbc->no_stats_accounting = true;

Who does the writeback accounting now?  Maybe throw in a comment if
iomap is now doing something different than all the other writeback
code.


