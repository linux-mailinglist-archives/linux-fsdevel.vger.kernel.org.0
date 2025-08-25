Return-Path: <linux-fsdevel+bounces-58962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA2B3380A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C3168F7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E7C29993A;
	Mon, 25 Aug 2025 07:46:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB428F1;
	Mon, 25 Aug 2025 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756107973; cv=none; b=tObDfS2jqgmSc/xQ/UBH1E7UfM4rWzQjl0qsqCa0n2o+PPxF45z3cmeaJQiHs2PNTiCOg+Fo3HoSSdClOFsJFvMSLfgfwIim9TedN7L8x386vP+EljpeZ5AeXzH1X4qpjjH5IsAuXPkVrdm1NIAklt5Z07jdBxNBC8FBVb/J4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756107973; c=relaxed/simple;
	bh=93dYZci4N9YyD6RIQ3oAlUCKKDLe2Eys9vqtOW0Sfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIZci8QppxhXVn62t3PPteRRL2leXfwSpCPYZcCUlunC+RKeOr6MhYhmF43SJCu8zrVpNKNb1KpQp8/oiPXHCwKcwEQO73qpaHOHEPYxtu+l4kGo/AOglESPirzrJyj5gIu7BYCCjj5G8uHhYGwJFNfaSfyfeVwJPx0SS+KjXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A94568AA6; Mon, 25 Aug 2025 09:46:07 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:46:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <20250825074606.GE20853@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 19, 2025 at 09:49:17AM -0700, Keith Busch wrote:
> +/*
> + * Aligns the bio size to the len_align_mask, releasing any excessive bio vecs
> + * that  __bio_iov_iter_get_pages may have inserted and reverts that length for
> + * the next iteration.
> + */
> +static int bio_align(struct bio *bio, struct iov_iter *iter,
> +			    unsigned len_align_mask)

I think the name is a bit too generic, as the function is very
specific to the __bio_iov_iter_get_pages-path only releasing of
pages, and also only aligns down.  Maybe name it
bio_iov_iter_align_down or something like that?

> +	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
> +
> +	if (!nbytes)
> +		return 0;
> +
> +	iov_iter_revert(iter, nbytes);
> +	bio->bi_iter.bi_size -= nbytes;
> +	while (nbytes) {
> +		struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
> +
> +		if (nbytes < bv->bv_len) {
> +			bv->bv_len -= nbytes;
> +			nbytes = 0;
> +		} else {
> +			bio_release_page(bio, bv->bv_page);
> +			bio->bi_vcnt--;
> +			nbytes -= bv->bv_len;
> +		}
> +	}

Minor nitpicks on the loop:  it could be turned into a do { } while ()
loop, because nbytes is already checked above.  And the condition that
sets nbytes to 0 could just break out of the loo.

> +
> +	if (!bio->bi_iter.bi_size)
> +		return -EFAULT;

And as bi_size doesn't change in the loop, this should probably move
above the loop.


