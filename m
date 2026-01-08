Return-Path: <linux-fsdevel+bounces-72809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68797D04009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0190311D51D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFF2D9ECD;
	Thu,  8 Jan 2026 09:31:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC737083C;
	Thu,  8 Jan 2026 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864681; cv=none; b=QRdHlm4ufLjYHtOniwoRNR+KKGkKi7XLHQhDdAEo+lGrzKct1Q829ThXSdZpQzAxnd0jHL15uHnF8ATFUkGHrwedl09kgK6Rj1QtYSGY3J3emapvwlh5LX2tTAWMPwSqn6X95BOwUvcQ5SD6ZVoK33mseKn04Iw5jrR9R3RnE/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864681; c=relaxed/simple;
	bh=jgrwJ32MrtKLFCwfKG6SoX/ziA1fnF3cqXAWEWhwFVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V09NN3Ehn3JPDHVGAxEnlnYULMINBTUqT7/ydl6xr/lcd/zN6WW3Ixp5TU2TzWXYe8y+03XpVUcVORvW4n+eyPeub2Drg8oTTy5RYdztVWblbHNgTM8RQhkp00WmCTyncqb3BxOSMHhx9n6gDI12AETVQ2x7XFXqvKe1BnNkLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2BD0227A87; Thu,  8 Jan 2026 10:31:02 +0100 (CET)
Date: Thu, 8 Jan 2026 10:31:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted
 bio page allocation
Message-ID: <20260108093101.GA20489@lst.de>
References: <20260106073651.1607371-1-hch@lst.de> <20260106073651.1607371-8-hch@lst.de> <20260108002250.GA2614@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108002250.GA2614@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 07, 2026 at 04:22:50PM -0800, Eric Biggers wrote:
> On Tue, Jan 06, 2026 at 08:36:30AM +0100, Christoph Hellwig wrote:
> > +out_free_enc_bio:
> > +	/*
> > +	 * Add the remaining pages to the bio so that the normal completion path
> > +	 * in blk_crypto_fallback_encrypt_endio frees them.  The exact data
> > +	 * layout does not matter for that, so don't bother iterating the source
> > +	 * bio.
> > +	 */
> > +	for (; enc_idx < nr_enc_pages; enc_idx++)
> > +		__bio_add_page(enc_bio, enc_pages[enc_idx++], PAGE_SIZE, 0);
> > +	bio_io_error(enc_bio);
> 
> There's a double increment above.

Indeed.  Which also means the failure testing wasn't all that
great..


