Return-Path: <linux-fsdevel+bounces-35281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98A79D35B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D8F28350C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014A175D3A;
	Wed, 20 Nov 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jSZEaAg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FEE15CD46;
	Wed, 20 Nov 2024 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092229; cv=none; b=WWVUUtM8gWJ30NB8IabcgyXcxXj8a6Kb3fB4HwknbY1OhIjVW3N08omoyd1cDZFx8tS2oRCApfxucdSXxj53CXv1Nqcr+HL2Btb4L1eiZmA2YDzzjFwW/Ure4BXKJRp0RFA+tmO+JUsJ1idFxhKxSZM3DFMK+1g20C4w8TVU9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092229; c=relaxed/simple;
	bh=fMhrOl+nY4qnzhafrcQPW/Z0Qozrepf0MPnbSy9LnY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVTV08kw7ubjdnsVIc9449gDDHKjTC46hLTy4EfZNQIKlYqcZn3lqPy5KI8iVemi5R7wg8fOy8/ccnHnPOUCMaXo8Dlcew/GId4LZTAAgjKsafBP7+3F+U2lhIV39kHYdjVQiwpEfPdu/w5nQ0dBRtyJtTteDmy22na6kLOgV28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jSZEaAg6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JnZQmEVCjUehsHWVpGBm+X2p0J0S/Dzk+i9+yxPD6HU=; b=jSZEaAg6uPIm7zDAbC2L6IoJnv
	/Me1OKvLDbvI12riudOPq+rgsh0MY1awPP/RcKGALJa6O+jWLeKfDzFZmRAXxstagN0wbHXQGLNad
	2XXZ5jCzXvC9m+q1OsKLL2clbf0lvTkQhcQ7D1sjnIU5+cvMSAtK1XYUZUUOM12UU390M9Wb53y9v
	3GyxdPLKoGmVdjCMEdVX3q3ac1M5YnnKHJ5KSxBipMAg5VDmvXOa97m40vX7Ayz6ZLd8SrqMxYZ6q
	7R1gsMlxx6QVSnfPOg9sZy36G2tPUVMrN29zzYBAKEnyFrd6Hd6xatk9C81VT+R1rHwY+Yh0HUPuZ
	FzUFTWhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDgJP-0000000EnPt-3Qmm;
	Wed, 20 Nov 2024 08:43:47 +0000
Date: Wed, 20 Nov 2024 00:43:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 2/4] iomap: optional zero range dirty folio processing
Message-ID: <Zz2hQ05dZC4D5fEl@infradead.org>
References: <20241119154656.774395-1-bfoster@redhat.com>
 <20241119154656.774395-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154656.774395-3-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 10:46:54AM -0500, Brian Foster wrote:
> +loff_t
> +iomap_fill_dirty_folios(
> +	struct inode		*inode,
> +	struct iomap		*iomap,

If you pass in the batch directly instead of the iomap this is
completely generic and could go into filemap.c.  Adding willy
and linux-mm for these kinds of things also tends to help to
get good review feedback and often improvements.

> +	loff_t			offset,
> +	loff_t			length)
> +{
> +	struct address_space	*mapping = inode->i_mapping;
> +	struct folio_batch	fbatch;
> +	pgoff_t			start, end;
> +	loff_t			end_pos;
> +
> +	folio_batch_init(&fbatch);
> +	folio_batch_init(&iomap->fbatch);
> +
> +	end_pos = offset + length;
> +	start = offset >> PAGE_SHIFT;
> +	end = (end_pos - 1) >> PAGE_SHIFT;

Nit: initializing these at declaration time make the code easier to
read (at least for me :)).

> +
> +	while (filemap_get_folios(mapping, &start, end, &fbatch) &&
> +	       folio_batch_space(&iomap->fbatch)) {
> +		struct folio *folio;
> +		while ((folio = folio_batch_next(&fbatch))) {
> +			if (folio_trylock(folio)) {
> +				bool clean = !folio_test_dirty(folio) &&
> +					     !folio_test_writeback(folio);
> +				folio_unlock(folio);
> +				if (clean)
> +					continue;

What does the lock protect here given that it can become stale as soon
as we unlock?

Note that there also is a filemap_get_folios_tag that only looks up
folios with the right tag (dirty or writeback).  Currently it only
supports a single tag, which wuld not be helpful here, but this might
be worth talking to the pagecache and xarray maintainer.


