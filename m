Return-Path: <linux-fsdevel+bounces-37128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E189EDF0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 06:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB69A283A48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AB185B6D;
	Thu, 12 Dec 2024 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LxJPtnMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0297629A9;
	Thu, 12 Dec 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982622; cv=none; b=d6o2bs7qnyaWPiLaLUi1OoHC+pJ44cJyTB5/3LZg60f+BRXotxYiG9rd6VypgXh4FGK6PjEzZbNpiZfbS/lSN/uxCib88JET0MtohLGlA/s9ZP/fVI212H0f9XMhxKYW9remVIoLFQUlBsWmPvofB8lcNUe2dZysZt7nXKaLtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982622; c=relaxed/simple;
	bh=XPA+8hGnezDK/cAW5N+82NcAeOzLbG7VN/Ex6ABGO4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf1rY/7sj/Wu6sowhswh/l7RBBknUJf2PhmpfLDwiowbESPKWoecO4mwITBu2kzACLdgqjxtLtS8GK95NEZqfTiLAlEg9EnfKn+Yr8QWDisWTamfeM3bfStGqSL+h+4GTYrD9jxNx5g/DmXU6d5gP9gQyKZyhdeaMXaeSgUsl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LxJPtnMV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pcELzZSVcZp1+kgY3EddYDKju3cmFn5oocwvVGhpALw=; b=LxJPtnMVMgJ3H+5TJzZZ9z7wS+
	RbHDYNbA8oyTIKQ8dXz8E9KQalQccSW/uJ+CD8jGmMTb6F+Iogje1GseuTRVuYxOnfDobUHnmbOOh
	IYmuv96LZdVwrSIPEtv2LaUZsDgxxlTEvQfDaNj8p+u16ORUWAukW9oTg2vxO5Jp2YDRrBcqqR6YG
	P0c22F1xHFrYZQFBk6vc3WU0+9BZzuNOgEJOsO5aLddQPTNfbtkSQK4EQGXn4iWPuPb0X8eC0seZa
	L1KrbEKSTzpk1z4voFKA8PoR34ldMVgEwmc2/5IFgED+8BX+xvshdrHZ5VqcmmqIRYeTVLXzimy5o
	Lk9hXYpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc5b-0000000Gyq7-47gi;
	Thu, 12 Dec 2024 05:50:19 +0000
Date: Wed, 11 Dec 2024 21:50:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	bfoster@redhat.com
Subject: Re: [PATCH 14/17] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <Z1p5my4wynAW_Vc3@infradead.org>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-16-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114152743.2381672-16-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 14, 2024 at 08:25:18AM -0700, Jens Axboe wrote:
> +	if (iocb->ki_flags & IOCB_UNCACHED)
> +		iter.flags |= IOMAP_UNCACHED;
>  
> -	while ((ret = iomap_iter(&iter, ops)) > 0)
> +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> +		if (iocb->ki_flags & IOCB_UNCACHED)
> +			iter.iomap.flags |= IOMAP_F_UNCACHED;

iomap.flags and the IOMAP_F_* namespace is used to communicate flags
from the file system to the iomap core, so this looks wrong.

>  	size_t poff = offset_in_folio(folio, pos);
>  	int error;
>  
> +	if (folio_test_uncached(folio))
> +		wpc->iomap.flags |= IOMAP_F_UNCACHED;

I guess this is what actually makes it work.  Note that with the iomap
zoned series I posted yesteday things change a bit here in that the flags
in the wpc are decouple from the iomap flags, and this would now become
a wpc only flag as it isn't really a fs to iomap cummunication, but
based on iomap / page cache state.


