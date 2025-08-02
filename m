Return-Path: <linux-fsdevel+bounces-56546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C46B18A5B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 04:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5C11C24310
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Aug 2025 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEED149C41;
	Sat,  2 Aug 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BySllj1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE032CA9;
	Sat,  2 Aug 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754100171; cv=none; b=qpa40518lqI2frFfRkam/yCtcFLOshlbDsxmjwZBBq/Nn9Ms+MjWFF6D/FvhLUp1dCs7cq0KOhmy/AdFe98PQq1qMLd3funq7tLOkTAFM+R0vaJozLlmRk1pTWE7QftlsA/UGs+M7Pixv1qfU2tOoUjW+Wm+pR4n55eTT7t9Vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754100171; c=relaxed/simple;
	bh=6bITi9gvtbX7RAdnVVPYE2QrTPy+diCSRNMo8t0owvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8rHpA5BGd49qcKlGZlzS8/zN61TS8vlTNnaNPwT6kKcaimYqMVrTaG/sLV0RfbwraGCpwIqpe3pNPn+O7KnfO4oVs2WSBTlZPXxaQ/GJAcEdy99fPho6OO9GP1h45pTBQiGnn/C+2ogLhD/wKs2XHSv/TTOftjSkFcnhRIn/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BySllj1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF51C4CEE7;
	Sat,  2 Aug 2025 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754100170;
	bh=6bITi9gvtbX7RAdnVVPYE2QrTPy+diCSRNMo8t0owvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BySllj1FubO0oyO0tHAr96uaOj4qO4A5jIQwliWhAJ+MYQboc8F6bjo+a4mDDl5s8
	 vytkyV5rWN+Gb9VLglRtyPwRihX5XPLqJsa01osMw7D7w8FaMl34Am+p1N8hDuZbBE
	 Zaj54jJyLrZ8nP1IkUUYX/+cVeezt0gNRKqL7A8bHdHztbBC9TvidGcPAyHkTzNqNl
	 KNYxW3Vpp5rH6Cte8Idfp9ypvhJRWF1IEIbEaBXmkYbFdfVoUhOMqSS1xzsaYtPm/I
	 WLSElLTTH4uqNDIuqPqD6rApaq56Bog93dKEY4nCl436AJxcYUnSUATRY/55mFq/+y
	 QEBH9tOBXjljg==
Date: Fri, 1 Aug 2025 22:02:49 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, Keith Busch <kbusch@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Message-ID: <aI1xySNUdQ2B0dbJ@kernel.org>
References: <20250801234736.1913170-1-kbusch@meta.com>
 <20250801234736.1913170-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801234736.1913170-8-kbusch@meta.com>

On Fri, Aug 01, 2025 at 04:47:36PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> No more callers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

You had me up until this last patch.

I'm actually making use of iov_iter_is_aligned() in a series of
changes for both NFS and NFSD.  Chuck has included some of the
NFSD changes in his nfsd-testing branch, see:
https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-testing&id=5d78ac1e674b45f9c9e3769b48efb27c44f4e4d3

And the balance of my work that is pending review/inclusion is:
https://lore.kernel.org/linux-nfs/20250731230633.89983-1-snitzer@kernel.org/
https://lore.kernel.org/linux-nfs/20250801171049.94235-1-snitzer@kernel.org/

I only need iov_iter_aligned_bvec, but recall I want to relax its
checking with this patch:
https://lore.kernel.org/linux-nfs/20250708160619.64800-5-snitzer@kernel.org/

Should I just add iov_iter_aligned_bvec() to fs/nfs_common/ so that
both NFS and NFSD can use it?

Thanks,
Mike

> ---
>  include/linux/uio.h |  2 -
>  lib/iov_iter.c      | 95 ---------------------------------------------
>  2 files changed, 97 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 2e86c653186c6..5b127043a1519 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -286,8 +286,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
>  #endif
>  
>  size_t iov_iter_zero(size_t bytes, struct iov_iter *);
> -bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
> -			unsigned len_mask);
>  unsigned long iov_iter_alignment(const struct iov_iter *i);
>  unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
>  void iov_iter_init(struct iov_iter *i, unsigned int direction, const struct iovec *iov,
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index f9193f952f499..2fe66a6b8789e 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -784,101 +784,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
>  }
>  EXPORT_SYMBOL(iov_iter_discard);
>  
> -static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned addr_mask,
> -				   unsigned len_mask)
> -{
> -	const struct iovec *iov = iter_iov(i);
> -	size_t size = i->count;
> -	size_t skip = i->iov_offset;
> -
> -	do {
> -		size_t len = iov->iov_len - skip;
> -
> -		if (len > size)
> -			len = size;
> -		if (len & len_mask)
> -			return false;
> -		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
> -			return false;
> -
> -		iov++;
> -		size -= len;
> -		skip = 0;
> -	} while (size);
> -
> -	return true;
> -}
> -
> -static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned addr_mask,
> -				  unsigned len_mask)
> -{
> -	const struct bio_vec *bvec = i->bvec;
> -	unsigned skip = i->iov_offset;
> -	size_t size = i->count;
> -
> -	do {
> -		size_t len = bvec->bv_len - skip;
> -
> -		if (len > size)
> -			len = size;
> -		if (len & len_mask)
> -			return false;
> -		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
> -			return false;
> -
> -		bvec++;
> -		size -= len;
> -		skip = 0;
> -	} while (size);
> -
> -	return true;
> -}
> -
> -/**
> - * iov_iter_is_aligned() - Check if the addresses and lengths of each segments
> - * 	are aligned to the parameters.
> - *
> - * @i: &struct iov_iter to restore
> - * @addr_mask: bit mask to check against the iov element's addresses
> - * @len_mask: bit mask to check against the iov element's lengths
> - *
> - * Return: false if any addresses or lengths intersect with the provided masks
> - */
> -bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
> -			 unsigned len_mask)
> -{
> -	if (likely(iter_is_ubuf(i))) {
> -		if (i->count & len_mask)
> -			return false;
> -		if ((unsigned long)(i->ubuf + i->iov_offset) & addr_mask)
> -			return false;
> -		return true;
> -	}
> -
> -	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
> -		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
> -
> -	if (iov_iter_is_bvec(i))
> -		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
> -
> -	/* With both xarray and folioq types, we're dealing with whole folios. */
> -	if (iov_iter_is_xarray(i)) {
> -		if (i->count & len_mask)
> -			return false;
> -		if ((i->xarray_start + i->iov_offset) & addr_mask)
> -			return false;
> -	}
> -	if (iov_iter_is_folioq(i)) {
> -		if (i->count & len_mask)
> -			return false;
> -		if (i->iov_offset & addr_mask)
> -			return false;
> -	}
> -
> -	return true;
> -}
> -EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
> -
>  static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
>  {
>  	const struct iovec *iov = iter_iov(i);
> -- 
> 2.47.3
> 

