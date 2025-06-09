Return-Path: <linux-fsdevel+bounces-50968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3277AD182B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 06:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA53C3A2B53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 04:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321B27FD71;
	Mon,  9 Jun 2025 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s570O2fb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3572715E97;
	Mon,  9 Jun 2025 04:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444980; cv=none; b=Rok1dzNgUvmDkzQQ9rMJhgRdztZcazUdeisbYhki5qQ0SrQe4mjwSZufg1TQ0Yhupg5cVH38UZg2DqHzu0wuZ0tY/ZlTEOxHfS9rNdiD141qt92nFzZqz4cgjS5XZWSmcBQc9sF1oqpy+Vb6WCJw0Kpm58irUZv2sve7o88fqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444980; c=relaxed/simple;
	bh=Z5HIgjlOS94+nPpkxTPAYvhjP0Hqj9eocta0Qd+kdz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iavX2mZFBnOM2sgHfcGw77Y+1U8Z28UdZveOvuo3aU/eWnG5OD2+Fm0PuO2txWRq+mfZDcLl1dxnmxuaicoHDdooD9HoI12nlnE+fQMNSwCHvhU0M9qrAtcV0n82GZu3IkuoG3nA8A4ZHML8b+zHuXtwaDRfEGK5UXDz2Ac47ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s570O2fb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yhG6fHCXxn+MKljVIWwC1KUatCxWtWPpFNYqFAJDLYo=; b=s570O2fbtSEb3+waQduQknjbN5
	GQGCOCljej/ky8L6V9tz+svEIHtOUKgiNt+ax8ngI3D37iASjIgDxwuMIddEhsHPPzgqsOzyyydpk
	iJ9MCGNr7adNR9E8v5r9+K2GedUB++W36FwVJro13Wey1r5r05ByDOXTL9UYaWC2iHgkAuVOdH/dC
	KgWTW2MM1zRFlk4eBqmLHpIIHbzuxSr4DLJt/6gJZCQbHuwF6Gk2S8380Ptryn96H8LH74Pp8UVWl
	UIvMi0SsiilJRqF6ncuZNfF89+jjh/c3/1L1kPhewiTIwO9TvERXeweiJ9KJIT8tdBVbJUUd8h9Eb
	CpzwLCrA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUYT-00000003RXa-36oC;
	Mon, 09 Jun 2025 04:56:17 +0000
Date: Sun, 8 Jun 2025 21:56:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 3/8] iomap: add buffered write support for
 IOMAP_IN_MEM iomaps
Message-ID: <aEZpcWGYssJ2OpqL@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-4-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> -static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
> -		size_t poff, size_t plen, const struct iomap *iomap)
> +static int iomap_read_folio_sync(const struct iomap_iter *iter, loff_t block_start,
> +				 struct folio *folio, size_t poff, size_t plen)
>  {
> -	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, iomap);
> +	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +
> +	if (folio_ops && folio_ops->read_folio_sync)
> +		return folio_ops->read_folio_sync(block_start, folio,
> +						  poff, plen, srcmap,
> +						  iter->private);
> +
> +	/* IOMAP_IN_MEM iomaps must always handle ->read_folio_sync() */
> +	WARN_ON_ONCE(iter->iomap.type == IOMAP_IN_MEM);
> +
> +	return iomap_bio_read_folio_sync(block_start, folio, poff, plen, srcmap);

I just ran into this for another project and I hated my plumbing for
this.  I hate yours very slightly less but I still don't like it.

This is really more of a VM level concept, so I  wonder if we should
instead:

 - add a new read_folio_sync method to the address space operations that
   reads a folio without unlocking it.
 - figure out if just reading the head/tail really is as much of an
   optimization, and if it it pass arguments to it to just read the
   head/tail, and if not skip it.


