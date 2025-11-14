Return-Path: <linux-fsdevel+bounces-68412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 390FCC5ACFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 01:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AA7F35581A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E585221F29;
	Fri, 14 Nov 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUAnNNjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30919F43A;
	Fri, 14 Nov 2025 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080712; cv=none; b=rDyzGWNXb5IkhWZFfyBnRtwvCRWK7Mgp7x6MsnwUhniVJaA64lALMB4Yke+qr3drCXRvKtJzxRM0n9NEJqToW6F0egytF+kmkptP2fJl7/lTny1hwDxrLFUL2BQTmtUchhxj8qK3Wm222oVX0S30PYaIZXzNEc9/bP98RGSl8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080712; c=relaxed/simple;
	bh=VnC/Cpeb7QXhyfiqkSDO4UcZXLs/noIUYMjxye6egB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMG3BsDNwPDPaxes00qaLdY/q9izp6ZwXIFT7rbNjp7GuPTaTzvZnjyzJIzESyoZqSm1VF8Lb5eaciPYdS2VpIFAinp7al0bIPiaqt5d4fH/ry43G7nrpbobkcNeJEPR9X1k0w3ddPdEbD+GIL1IGulz8bmj05D0sP3h4ply3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUAnNNjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08769C4CEF8;
	Fri, 14 Nov 2025 00:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763080712;
	bh=VnC/Cpeb7QXhyfiqkSDO4UcZXLs/noIUYMjxye6egB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUAnNNjJ+3nSCgOJ3PR8vZDu67EvX/FawQM01PvWo/ci8bnmP2rNvE/WsnHqZ6L6S
	 YKJx52A01ibfJBY+6aDXkc9edSsf4tVWTFBLbBPjeEaaFT4ks/H/cxNgYKplSvAVm/
	 mF0mzwsc2B7Od1fIZWgDi/uuCqoQhcL7Xc0bIvMf88v59R1GUTwcom7oHYlUEAD2WH
	 H+ShHpfNNlDzA60Z/AqHCux1aFzH0HUcNYhbKHYBsyiJqZJQR9LHP42oOokHTgpgo5
	 U7AsaeRG2b0CFIMRJEJZBCZ/D+eV2pKlMQjeWCnkd0ktHmQtIc3FdQZxZiMjn/m2aI
	 iSJdeGllV5Oaw==
Date: Thu, 13 Nov 2025 16:37:38 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 7/9] blk-crypto: handle the fallback above the block layer
Message-ID: <20251114003738.GC30712@quark>
References: <20251031093517.1603379-1-hch@lst.de>
 <20251031093517.1603379-8-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031093517.1603379-8-hch@lst.de>

On Fri, Oct 31, 2025 at 10:34:37AM +0100, Christoph Hellwig wrote:
> -/**
> - * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decryption
> - *
> - * @bio_ptr: pointer to the bio to prepare
> - *
> - * If bio is doing a WRITE operation, this splits the bio into two parts if it's
> - * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allocates a
> - * bounce bio for the first part, encrypts it, and updates bio_ptr to point to
> - * the bounce bio.
> - *
> - * For a READ operation, we mark the bio for decryption by using bi_private and
> - * bi_end_io.
> - *
> - * In either case, this function will make the bio look like a regular bio (i.e.
> - * as if no encryption context was ever specified) for the purposes of the rest
> - * of the stack except for blk-integrity (blk-integrity and blk-crypto are not
> - * currently supported together).
> - *
> - * Return: true on success. Sets bio->bi_status and returns false on error.
> +/*
> + * bio READ case: Set up a f_ctx in the bio's bi_private and set the bi_end_io
> + * appropriately to trigger decryption when the bio is ended.
>   */
> -bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
> +bool blk_crypto_fallback_prep_decrypt_bio(struct bio *bio)

This omits some important details.  Maybe:

/*
 * bio READ case: Set up a fallback crypt context in the bio's bi_private, clear
 * the bio's original crypt context, and set bi_end_io appropriately to trigger
 * decryption when the bio is ended.  Returns true if bio submission should
 * continue, or false if aborted with bio_endio already called.
 */

> -/**
> - * __blk_crypto_bio_prep - Prepare bio for inline encryption
> - *
> - * @bio_ptr: pointer to original bio pointer
> - *
> - * If the bio crypt context provided for the bio is supported by the underlying
> - * device's inline encryption hardware, do nothing.
> - *
> - * Otherwise, try to perform en/decryption for this bio by falling back to the
> - * kernel crypto API. When the crypto API fallback is used for encryption,
> - * blk-crypto may choose to split the bio into 2 - the first one that will
> - * continue to be processed and the second one that will be resubmitted via
> - * submit_bio_noacct. A bounce bio will be allocated to encrypt the contents
> - * of the aforementioned "first one", and *bio_ptr will be updated to this
> - * bounce bio.
> - *
> - * Caller must ensure bio has bio_crypt_ctx.
> - *
> - * Return: true on success; false on error (and bio->bi_status will be set
> - *	   appropriately, and bio_endio() will have been called so bio
> - *	   submission should abort).
> - */
> -bool __blk_crypto_bio_prep(struct bio **bio_ptr)
> +bool __blk_crypto_submit_bio(struct bio *bio)

Similarly, this could at least use a comment about what the return value
means.  It's true if the caller should continue with submission, or
false if blk-crypto took ownership of the bio (either by completing the
bio right away or by arranging for it to be completed later).

- Eric

