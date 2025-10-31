Return-Path: <linux-fsdevel+bounces-66593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06585C25802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C74D4F8B6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD834BA33;
	Fri, 31 Oct 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EMcWQw5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E21F37D4;
	Fri, 31 Oct 2025 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919654; cv=none; b=G93OVb/LGjv57HPbanMzYzevCdhmIzMOPJBEuW4q8QCxwOj2HPzy95IlGYjCwuG2rx1PKttT1tPa6qUjyTFskyuLhKR/PJdcT0nPYLLZtO+DFDCtjZTXNEL5cgw9GQjxpBLNkKuZDZ20x0RkTXUN1BKlKYHVFzoRLvRDOilt2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919654; c=relaxed/simple;
	bh=0UtECDDVDoMeGv6AOHU1hrS9LICcBRmYsMnjhXTO3Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZAaCrDlTlR2n7Uhx6auL7Vuip1NhvnblLvJ/Gb1al7qRoOIZ5GiA0FCOcq0v/QDfxJqjaOUs9GJDA/PS/EOnTWbvQ/Px3c5XVxxXDsAJ/chBDGBtVZUgsXA4NDO7+38GxAI8HYdPaEEMEpl9KzLpPO7inXbU127QQJ3himkut8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EMcWQw5O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MLAwkHonC2DerArQ3Bdk4og7Ld5OzLQQ7bOHEpoGgjI=; b=EMcWQw5OloLnivQ+xZN9+/zmD2
	o/bw6GWxHhQoeiNwX0+YCtqP2+u8gAVJuQGefkOzOBzD8gYxEw8OyMzIJCkJqIVfA+Z18QM+uaqDf
	7rEI41hlgyXOorcfAcUWEbGsOjC1k9cOo9mCJKNkh+WWJEQ2PEXbCF6KML6Z0deK+twjXlKNTjXQq
	3mVBBo0wbg6EN794hBf15sNoCsjnopGiQi8YSUza/26kzFcKXjJu1AoNM7wky1bksP0yVkrVLQRaZ
	gMX97DJ9Mdh1E7afU92WL8rHX9QB/IOwPqyZ9hXnWeKfNZTTA+7pCWQC7TXPAzeriwprIkLBaGgd5
	IR493mfg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEpmq-0000000GyAr-2Nr2;
	Fri, 31 Oct 2025 14:07:28 +0000
Date: Fri, 31 Oct 2025 14:07:28 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: remove ntfs_bio_pages and use page cache for
 compressed I/O
Message-ID: <aQTCoABT6usmY8iF@casper.infradead.org>
References: <20251031071516.3604-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031071516.3604-1-almaz.alexandrovich@paragon-software.com>

On Fri, Oct 31, 2025 at 08:15:16AM +0100, Konstantin Komarov wrote:
> Replace the use of ntfs_bio_pages with the disk page cache for reading and
> writing compressed files. This slightly improves performance when reading
> compressed data and simplifies the I/O logic.

Yes, this is a good improvement.

> +		/* Read range [lbo, lbo+len). */
> +		page = read_mapping_page(mapping, lbo >> PAGE_SHIFT, NULL);

I'm not keen on this though.  read_mapping_page() is deprecated; please
use read_mapping_folio().

> +		kaddr = kmap_local_page(page);

kmap_local_folio()

> +		if (wr) {
> +			memcpy(kaddr + off, buf, op);
> +			set_page_dirty(page);

folio_mark_dirty()

> +		} else {
> +			memcpy(buf, kaddr + off, op);
> +			flush_dcache_page(page);

flush_dcache_folio()

> +		}
> +		kunmap_local(kaddr);
> +		put_page(page);

folio_put()


