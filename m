Return-Path: <linux-fsdevel+bounces-71292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E784CBC98E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE68301A1A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E14326D68;
	Mon, 15 Dec 2025 06:03:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3526F2BD;
	Mon, 15 Dec 2025 06:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778580; cv=none; b=eF42VkgrpRQxFMR1LEppilbewn+/Ha97xPGpb3uAHsm0+e8/XAuERO/e0BcW/KHWc/Lm8zoiT1I90tE1AICxW0U/lQysYnNvniadhBbWUiRwp3Cmdwm7/USFl9qQ2sBCWtJ21eGsWldUqUXvPOApEQRQktuGsBcr4TpJOi7/JqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778580; c=relaxed/simple;
	bh=RnhH7Em6OzCrbPKPPY3YmWHk1J1ipvj4nHgs5PNMAg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC0sT5k3St1zpvTU2ac+LuwvzC2DgeTVuJB+2lr5paGHJU2ycCBMlfqr47tJc6APBUqUU4QNDZhG1r56c1toyO8BhTUr0V0UgHa0KYKhd+3riMXKyiOST8FuveKONnfwaVxZJW64JXKJqECOeWeq4DhxiiiGlL3QdzahkNJHohE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4BB468B05; Mon, 15 Dec 2025 07:02:55 +0100 (CET)
Date: Mon, 15 Dec 2025 07:02:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Message-ID: <20251215060255.GC31097@lst.de>
References: <20251210152343.3666103-1-hch@lst.de> <20251210152343.3666103-9-hch@lst.de> <20251213013038.GF2696@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213013038.GF2696@quark>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 12, 2025 at 05:30:38PM -0800, Eric Biggers wrote:
> > +	if (bio_has_crypt_ctx(bio)) {
> > +		struct bio_crypt_ctx *bc = bio->bi_crypt_context;
> > +
> > +		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
> > +	}
> 
> Needs an #ifdef CONFIG_BLK_INLINE_ENCRYPTION, since ->bi_crypt_context
> is conditional on it.

Yeah, the build bot reported this after sending out the patch (but not in
the three days the branch waited for it..).

I'll add a bio_crypt_ctx() helper to avoid the ifdefs:

https://git.infradead.org/?p=users/hch/misc.git;a=commitdiff;h=748ca0feda9d4e7afc3ae0b2377550925e0835e2

