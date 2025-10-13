Return-Path: <linux-fsdevel+bounces-63915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6262BD1B06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 08:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CA524E9A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 06:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885A2E092B;
	Mon, 13 Oct 2025 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fC0VpZHS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4434BA46;
	Mon, 13 Oct 2025 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337209; cv=none; b=kEkBB+xCOdjJoE5ZWlx38p5X76MNjOlWBoBt1V/h4fU9gZ2qo9nhJWbUj+K5i694iBzBZAQYkKmDQTUdVrOkUnveKjkR4eWDY3e8HHBmEG4Y+onva6JVwO8VVRbydK0tf+vFUTKDGzJleEpDO5Ztbl/Cb05PVbExhZGHGKOwOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337209; c=relaxed/simple;
	bh=C2JMw6vRCYLpCur5CAXs/t5bssJE2SFWfnEq3ZMm2y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COO6Eyh5/WneyWY7XtTIPHV+7etzRu+0eCCtxq7FQxFU1Pffgefj1qzjQ14hWE28hOuSEV99N2pIcfS66O6phI7aD7VCTR3oMXPP6KxJktSKaRzMznrRjYEWwi/9us4dX2ijpMAbZLcCMgOXhmdDhkNA9J3+5ZtGZuxxIUBdNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fC0VpZHS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tpankzcijBPjD9K1TKHkqkQC3QK9Nw1+fLBwa5WqQts=; b=fC0VpZHS7JdVQ4YdtjRC31t+5p
	ByBQzusJl7GU5wqEevoYT4+k/ir+RtHzNAPrnR9S9IqBaYdV1Hj3I9UJWdNM9YKos2yRhU61T3aIM
	hp2gwvxmGnm2wLFCrhaxyhke8m6Z97Pb9OWg1/3hMOU6skTXDRNalO3cRIInubA+4AR5e9Y8tvoNs
	rXz8npEG/mh6CJUwO2W5MsACelNXXyk2CeZFzKWZcX0gA4/pGrgdEBp9Hk9ruSuAJ2/Vf2puOoMmk
	/SdhEARMwLSOcC0QRurv0AXwb/Kvxpt2StPhav4xfm7JUOLG+eX7/nRcj8Xx/DpLbTNgDWC11F3X8
	INRfjddA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8C7b-0000000CPEi-3rr3;
	Mon, 13 Oct 2025 06:33:27 +0000
Date: Sun, 12 Oct 2025 23:33:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: add IOMAP_DIO_ALIGNED flag for btrfs
Message-ID: <aOydN1rIsWiNo4m6@infradead.org>
References: <5dbcc1d717c1f8a6ed85da4768306efb0073ff78.1760335677.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbcc1d717c1f8a6ed85da4768306efb0073ff78.1760335677.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 13, 2025 at 04:38:40PM +1030, Qu Wenruo wrote:
> For now only btrfs will utilize this flag, as btrfs needs to calculate
> checksum for direct read.

Maybe reword this as: 

The initial user of this flag is btrfs, whichs needs to calculate
the checksum for direct read and thus requires the biovec to be
file system block size aligned?

> index 802d4dbe5b38..15aff186642d 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c

Please split the patch to use the flag in btrfs from the one adding
the the flag to iomap.

> +	const unsigned int alignment = (dio->flags & IOMAP_DIO_ALIGNED) ?
> +		max(fs_block_size, bdev_logical_block_size(iomap->bdev)) :
> +		bdev_logical_block_size(iomap->bdev);

Please unwind this into an if/else to be easily readable.  Also a
comment on why you still need the max when the flag is set would be
useful.

> +		ret = bio_iov_iter_get_pages(bio, dio->submit.iter, alignment - 1);

Please avoid overly long lines in the iomap code.

> +/*
> + * Ensure each bio is aligned to fs block size.
> + *
> + * For filesystems which need to calculate/verify data checksum for each data bio.

Another overly long line here.

> + */
> +#define IOMAP_DIO_ALIGNED		(1 << 3)

Maybe call the flag IOMAP_DIO_FSBLOCK_ALIGNED to make it clear
what alignment is implied by the flag.

