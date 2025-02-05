Return-Path: <linux-fsdevel+bounces-40963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32AA2999A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B193A3827
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB051FECD1;
	Wed,  5 Feb 2025 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1zHlavC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480413D897;
	Wed,  5 Feb 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781882; cv=none; b=g7NEtlm2tdFapTEb3YwXts9kDdnFKybrWkvDKGWdb49xKYa1x7goM7TfMu4JAJZWcWR/HQvaULWnhO6RyA/Iz6p25yoZH24myKsJgfAD2R7eRF+VvGgg+O9ktMLs0/9+kRaTiQjV0BEOVRO7tsbgGn9QU2YRlrB18cPn+hehK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781882; c=relaxed/simple;
	bh=Hceogdek36+SZAqauV6t7bwwMBUi65kxQD75Yha6DtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui2HgQLVR3khdnWoJHShqNq6YSkN/giWlasNFk7dKJIn5PJcrjJRGUvvu/ucODCUmcxZ6ohmp2cvSgM6tB1C7YgpLiXBTYcTx0wrLzCTUcNionultE0zC6qGNdgIpJhE8gmiKN2sE7CTudv54wsIGFQixw4ziQjx2QmzIwRP/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1zHlavC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C05CC4CED1;
	Wed,  5 Feb 2025 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738781881;
	bh=Hceogdek36+SZAqauV6t7bwwMBUi65kxQD75Yha6DtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1zHlavCQGfR6rdR554HHeAcWUhIrgDv7T2V7kHUf7Xau0/K+5TirCnSgtq1mjaaN
	 Dp7Cw7uQH1OkgpX0lBRVfeZlTSLRjONjLhBODkU3BaS2El6Kgxl6DAuquV95NA6ZDf
	 T8msNSTuYR/mwUSVzJEOdDkIMoNe8Sgjt8AN/Bfx8tO4MkCHqLEnELAZhC+OD7hvXI
	 YY99F2y01rZZrSJes/UFv0SBt/aFSQy4u/NTmqCn61l7sgLd3ZsMGoG8KGMm7WSPAV
	 IO4+2wQvN69b+RcaueKMProEFfYx8t0HvSBKSWTNWaxFva0bp3lJk6se1TkBzd/fu9
	 E7Uxdk24UOUZQ==
Date: Wed, 5 Feb 2025 10:58:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 06/10] iomap: export iomap_iter_advance() and return
 remaining length
Message-ID: <20250205185801.GO21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-7-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:17AM -0500, Brian Foster wrote:
> As a final step for generic iter advance, export the helper and
> update it to return the remaining length of the current iteration
> after the advance. This will usually be 0 in the iomap_iter() case,
> but will be useful for the various operations that iterate on their
> own and will be updated to advance as they progress.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/iter.c       | 22 ++++++++--------------
>  include/linux/iomap.h |  1 +
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 8e0746ad80bd..cdba24dbbfd7 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -15,22 +15,16 @@ static inline void iomap_iter_reset_iomap(struct iomap_iter *iter)
>  }
>  
>  /*
> - * Advance to the next range we need to map.
> - *
> - * If the iomap is marked IOMAP_F_STALE, it means the existing map was not fully
> - * processed - it was aborted because the extent the iomap spanned may have been
> - * changed during the operation. In this case, the iteration behaviour is to
> - * remap the unprocessed range of the iter, and that means we may need to remap
> - * even when we've made no progress (i.e. count = 0). Hence the "finished
> - * iterating" case needs to distinguish between (count = 0) meaning we are done
> - * and (count = 0 && stale) meaning we need to remap the entire remaining range.
> + * Advance the current iterator position and return the length remaining for the
> + * current mapping.

This last sentence should state that the remaining length is returned
via @count as an outparam and not through the function's return value.

Otherwise looks ok to me.

--D

>   */
> -static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
> +int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
>  {
> -	if (WARN_ON_ONCE(count > iomap_length(iter)))
> +	if (WARN_ON_ONCE(*count > iomap_length(iter)))
>  		return -EIO;
> -	iter->pos += count;
> -	iter->len -= count;
> +	iter->pos += *count;
> +	iter->len -= *count;
> +	*count = iomap_length(iter);
>  	return 0;
>  }
>  
> @@ -93,7 +87,7 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	 * advanced at all (i.e. no work was done for some reason) unless the
>  	 * mapping has been marked stale and needs to be reprocessed.
>  	 */
> -	ret = iomap_iter_advance(iter, processed);
> +	ret = iomap_iter_advance(iter, &processed);
>  	if (!ret && iter->len > 0)
>  		ret = 1;
>  	if (ret > 0 && !iter->processed && !stale)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index f5ca71ac2fa2..f304c602e5fe 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -229,6 +229,7 @@ struct iomap_iter {
>  };
>  
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops);
> +int iomap_iter_advance(struct iomap_iter *iter, u64 *count);
>  
>  /**
>   * iomap_length_trim - trimmed length of the current iomap iteration
> -- 
> 2.48.1
> 
> 

