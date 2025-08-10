Return-Path: <linux-fsdevel+bounces-57236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6CB1FA8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B1D1888640
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1F26563F;
	Sun, 10 Aug 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RH0e3XXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FB27462;
	Sun, 10 Aug 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754837028; cv=none; b=O5WFhxEYWx73gHSXhqZEwF8eUz7XVFydpNs9EMCBWsaKwCuxgeTO0e5Dko6KRM31Zqidxm0G3rfx5vbEX1HVMh/U2CiBf1P50iLKQ7MB21jqscLN4yzHDmtbDnIg8sPipu1I5WE4POdGOBhgms/nW5X2MaMiYG+gqwyCmwwVeEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754837028; c=relaxed/simple;
	bh=/2hkWykdN5SGC949fKWLSJv0MD92nI/TP0V4jimqPf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnMCmfjYz8ryzHQ86bMun3IcpVVwolBMaYHTST3Tij579T4oHGkNCYd6CdgipW2DojA3mr5hyoF4TG3Jbwx5+89vP6dGZE3/nHvUHlIXkeqTP0ef5Gz4nVmjEw2W5tDA1/Xo8Mk9HSpIJSoCq2UQhCnQyqDhCHmnxpFT63NIMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RH0e3XXe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S/EEJenBN5OfCRJ1aaN/UO5YQygmLrn7WRn6fy2hpQ4=; b=RH0e3XXenEZ5QCZMpJn4UshNmg
	oH+wcv1djJL0fSOsQWfOSzJQHQJ4/RLMsZt+S5p2qJhAKFsG32PoSZsmzJV7sCaeerfL0C6hvGAs/
	tWNY9mGREiEpLqo1tuooNGJuiZsXAIs6kULpOuINHeSm2uZxBTSCWa5vvop2doc78T0tGVLacpbPh
	QBavYDGo6FglgtwXN0diqTYv2WGj9Poc8iC7t4J+Eth18u9R++BW2p4ZDfhyN0Zq6SPc0vphkWUX3
	TsyZz67B5zU6yoiWJlHrq5z017gEK3Zfme99eokNXw/qj7jz8Ke+apxAajKMp9FdolkpekGE9suak
	aOim7V8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7H0-00000005i4h-1eW2;
	Sun, 10 Aug 2025 14:43:46 +0000
Date: Sun, 10 Aug 2025 07:43:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/7] block: align the bio after building it
Message-ID: <aJiwIgotNmmJvtjP@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805141123.332298-3-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 05, 2025 at 07:11:18AM -0700, Keith Busch wrote:
> +static inline void bio_revert(struct bio *bio, unsigned int nbytes)

Can you add a little comment explaining what this code does?  The name
suggast it is similar to iov_iter_revert, but I'm not sure how similar
it is intended to be.  The direct poking into bi_io_vec suggest it
can only be used by the I/O submitter, and the use of bio_release_page
suggests it is closely tied to to bio_iov_iter_get_pages despite the
very generic name.

> +static int bio_align_to_lbs(struct bio *bio, struct iov_iter *iter)
> +{
> +	struct block_device *bdev = bio->bi_bdev;
> +	size_t nbytes;
> +
> +	if (!bdev)
> +		return 0;

So this is something horribly Kent put in where he failed to deal with
review feedback and just fed his stuff to Linus, and I think we need
to fix it when touching this code again.  Assuming we want to support
bio_iov_iter_get_pages on bios without bi_bdev set we simplify can't
rely in looking at bdev_logical_block_size here, but instead need to
pass it explicitly.  Which honestly doesn't sound to bad, just add an
explicit argument for the required alignment to bio_iov_iter_get_pages
instead of trying to derive it.  Which is actually going to be useful
to reduce duplicate checks for file systems the require > LBA size
alignment as well.

> -	return bio->bi_vcnt ? 0 : ret;
> +	if (bio->bi_vcnt)
> +		return bio_align_to_lbs(bio, iter);
> +	return ret;

Nit, this would flow a little more easily by moving the error /
exceptional case into the branch, i.e.

	if (!bio->bi_vcnt)
		return ret;
	return bio_align_to_lbs(bio, iter);

