Return-Path: <linux-fsdevel+bounces-48033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F8AA8ECC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C4A3A6F4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBBA1E5219;
	Mon,  5 May 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VJLpeR2J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C15BA50;
	Mon,  5 May 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435789; cv=none; b=hnvUZiJJOsOp/ETVUbwZ6OWdKozj4Bpjww4Zm8xcEjnkRsPXbSssKUNTPnRU6bI4Jc8B+MGUX20cWi1GBMEwWMuTZxzGcoATeKkpH8O5o/kDAidbc6fXwGyYhSZgnrQuAeC2hGzm10pFh9VaWDS+UpUDv5zDp4+O4n4SP7f9ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435789; c=relaxed/simple;
	bh=LmVsZVcJuPXAK23UFYmnlI9yldlm8rBqY438E/vzs0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLnSDRRMAC7dT07N1/NfST2571pLGzCiO8aGrmMiWYWtmcNwgNkEESUNV8bQ1hIekwpsw+anDRtJ7PTZHz1sNaN1eX098oInx2Pa0bLZkJhRE16C22t653sx2euQAFMH4gHTXmJN4qvBYfPhEBm1m1ROY0D6Y7DtMEV7wwZY61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VJLpeR2J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jZicAZl4inIorCMm3ScPZv2JObSPKM30PYqRX8J6lMA=; b=VJLpeR2JRXsUQKq5M2t1/5HvEy
	hdiexcyzPD/3FFMU8YIHecwXnUXW9WdaY8K0e+tzoIGfFCZQrNt/omL4q11bIhuiiQCPoyr2G8TrQ
	mmzXQjCfUvcwFRx/kg1C4zYmy9CTzRiZAU+VBR0zuF9WQi1Z8zIK8rue8NNY61tQsqPS/foUVsYly
	IIKjZwor/QnH4GA541uTRy2B7tBiGqr92FIHpmV7ZDiNyCAIO4drdIeklx+gOTGgY13o6BK/SYWRh
	Jkperm0YbVHrRhweCHTyKuU/h5HOr82vHqcNwYRsLCGaoDjucArWTpStDyQEw8zi2xdhPxNKl+My4
	lifikreQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrj9-00000006rCu-1Rjd;
	Mon, 05 May 2025 09:03:07 +0000
Date: Mon, 5 May 2025 02:03:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] iomap: helper to trim pos/bytes to within folio
Message-ID: <aBh-y_qLVZUGxMU_@infradead.org>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-5-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 30, 2025 at 03:01:10PM -0400, Brian Foster wrote:
> +/* trim pos and bytes to within a given folio */
> +static loff_t iomap_trim_folio_range(struct iomap_iter *iter,
> +		struct folio *folio, size_t *offset, u64 *bytes)
> +{
> +	loff_t pos = iter->pos;
> +	size_t fsize = folio_size(folio);
> +
> +	WARN_ON_ONCE(pos < folio_pos(folio) || pos >= folio_pos(folio) + fsize);

Should this be two separate WARN_ON_ONCE calls to see which one
triggered?

> +
> +	*offset = offset_in_folio(folio, pos);
> +	if (*bytes > fsize - *offset)
> +		*bytes = fsize - *offset;

	*bytes = min(*bytes, fsize - *offset);

?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

