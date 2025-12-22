Return-Path: <linux-fsdevel+bounces-71843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE5CD73EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F323302C4D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE832721C;
	Mon, 22 Dec 2025 22:12:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2922B8AB;
	Mon, 22 Dec 2025 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766441552; cv=none; b=eeI07BNsw6sPQFfyRKLYBoCqjEzLyZkf16KXYba42vhsGAYyj0EDp69+QeLmHRvjNJcwD2Dq6kSzUR2BrRqYHKGkOxy08I8/yZtgke3jBpd2yRenCcTuyt6cp6H4bVJaRQvbI42ASioeMq77xTUtLeAKgIqauPzlbh7D2Jec2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766441552; c=relaxed/simple;
	bh=hjzXiyBP2HiKw77LvA/qR+FNKcEZhPW//HK8DG5cs0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhri5eMtjtY1QW1s5MZePUYVEBwyYmAg66d8nk7MDOydVrJkXCEmNCLFUzrfYrchr3eZ1/v6zC9pb7Dpq3jXZm/Pz9fLNO7Gkf9aRBCC1qMQa3URmhlbbKwucD9C07nKX20SJFXR3C/BHPEswPF57hmoxYQuFB6rAUAwM3i7jKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22A7168B05; Mon, 22 Dec 2025 23:12:19 +0100 (CET)
Date: Mon, 22 Dec 2025 23:12:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH 5/9] blk-crypto: optimize bio splitting in
 blk_crypto_fallback_encrypt_bio
Message-ID: <20251222221218.GA17420@lst.de>
References: <20251217060740.923397-1-hch@lst.de> <20251217060740.923397-6-hch@lst.de> <20251219200837.GF1602@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219200837.GF1602@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 19, 2025 at 12:08:37PM -0800, Eric Biggers wrote:
> Actually I think using bi_max_vecs is broken.
> 
> This code assumes that bi_max_vecs matches the nr_segs that was passed
> to bio_alloc_bioset().
> 
> That assumption is incorrect, though.  If nr_segs > 0 && nr_segs <
> BIO_INLINE_VECS, bio_alloc_bioset() sets bi_max_vecs to BIO_INLINE_VECS.
> BIO_INLINE_VECS is 4.
> 
> I think blk_crypto_alloc_enc_bio() will need to return a nr_enc_pages
> value.  That value will need to be used above as well as at
> out_free_enc_bio, instead of bi_max_vecs.

A bigger bi_max_vecs should not a problem as we still have a terminating
condition based on the source bio iterator.  That being said I agree
it is not very nice, and I've reworked the code to keep a variable
counting the segments in the encrypted bio.


