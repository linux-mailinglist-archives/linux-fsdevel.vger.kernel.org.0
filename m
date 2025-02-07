Return-Path: <linux-fsdevel+bounces-41232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84E3A2C9F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68D93A6695
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B501917D9;
	Fri,  7 Feb 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guGmgJyL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A62A1D8;
	Fri,  7 Feb 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948675; cv=none; b=MuGfxEilRfl7zyial5TjuJkVhgGP4Z4Rh2ha+aC4U/s4backim/64/Qq6uevNcgAhlR8NU8LumYENVmNdRkGkR4t9DXLFA+cnsGV/5f2EkhDBV+Z00DQzC+pVR1w7LbdBv5+rgYtnPRosKQJXjGXE01YxO8Rdzpmumg4lEfvM44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948675; c=relaxed/simple;
	bh=HS8uVSRu6b2pgnN7Ftvg56TUsGxahXbFklVCruWlQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIq/zd45p68ji3R5KtNsrvs5igLXtRLjtZBeJwD2o0v7LZwOocN2zrBlbe75KUMBL6NaQ4xjE4OQPanLyIolz09HJcbo7R+dr53A+KfaleVCoqAQz1SiA9Jmp5G9D9IYKeDkGBtDVvgZzPOeWjKZu0QBQlOy356nShgRTfnK4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guGmgJyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C9AC4CED1;
	Fri,  7 Feb 2025 17:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738948675;
	bh=HS8uVSRu6b2pgnN7Ftvg56TUsGxahXbFklVCruWlQG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guGmgJyLLZk0k18eKt+HxunqgwEjze2VZrOGhFvhPRuEuNyDArKpoMhN87+xYwafY
	 FTwShWPW/sG1s5ib61a2rjtVXuKkqeBOj8UPwvHvKnznVrqzYpD0ni1eDa7QRAowPC
	 0HCcLgToCE6t6DhtxBby5ledNBMQC4GoFoDxSauUR1MtcnKBtIGSOn7y71+sFxxnfL
	 8TqYyqS2gLSySkFTlLd2meM3MUUUI3z5smZodGwkFCXCyEQzxI3Mx7bBkbbEXQeSyI
	 np9JaAhYLu+GheI736B9Ws6euiVaV0q/l1y6szaSvmU6H3UrFaqx6Z4TE1VqVhugSe
	 I6iy++J0Sf0hQ==
Date: Fri, 7 Feb 2025 09:17:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 06/10] iomap: export iomap_iter_advance() and return
 remaining length
Message-ID: <20250207171754.GX21808@frogsfrogsfrogs>
References: <20250207143253.314068-1-bfoster@redhat.com>
 <20250207143253.314068-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207143253.314068-7-bfoster@redhat.com>

On Fri, Feb 07, 2025 at 09:32:49AM -0500, Brian Foster wrote:
> As a final step for generic iter advance, export the helper and
> update it to return the remaining length of the current iteration
> after the advance. This will usually be 0 in the iomap_iter() case,
> but will be useful for the various operations that iterate on their
> own and will be updated to advance as they progress.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c       | 22 ++++++++--------------
>  include/linux/iomap.h |  1 +
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 8e0746ad80bd..544cd7a5a16b 100644
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
> + * Advance the current iterator position and output the length remaining for the
> + * current mapping.
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

