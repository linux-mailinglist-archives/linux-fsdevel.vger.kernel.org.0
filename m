Return-Path: <linux-fsdevel+bounces-42135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD66A3CC73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 23:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FE3ADC2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 22:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B625A2DE;
	Wed, 19 Feb 2025 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy8MeA/M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECF25A2CD;
	Wed, 19 Feb 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740004548; cv=none; b=nqf0Q9WhwuajjdS79RAjxuOGYUShkJO9G/RIOuqO7YW6HZtya9Xc83/ryl6fdtv40vH4JYHpEuoyX+U8fTfV8uVpQOFoeB97R9gs0CC4syvV8F0jpu8Is43WzMAuUozT1W5Fh4JJsyE9UYcP1lHkpHq1zqqIEEK4sYP3JN9AyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740004548; c=relaxed/simple;
	bh=DQTCkEDM5+wYWTjDsprWvn8OheCRbzSScLnPulgduHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBOGBjjJSEqes4Gw2eKlS9BnV8oSKs5NiYkn//UgP0pNu0buMSqxvynzpszPZWyVYVjhbtN8NEpK3OvndfiTf1l2uBTOF6yHeXzj4t+umZyyyF1nhJaTVs1mRt9KYv5KoDFYMgSmCmpAnEV1J8U1sCRPbMQvNGIN8gMGcgx+lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy8MeA/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4FAC4CED1;
	Wed, 19 Feb 2025 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740004547;
	bh=DQTCkEDM5+wYWTjDsprWvn8OheCRbzSScLnPulgduHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy8MeA/MEn8Z6a4767MnkfC1TVXFmFf+rLk2Tx7T6VTIjWxtEu4Fwny/F0uaoiw7i
	 CMLeYar1dfamSSVQa145RHi43XOH/1iv1DhuIIe6NXV7QomK68s9YQIIDoIal4yb2Q
	 GX9XVEmwnrnHWL0fvGG9NalBLr6Sjgm/4K8b+HVdZaX7xSwSvONTsR4fULOND/WBVB
	 Rinji+D3Vkqkr/xh17d6UlMgjC5+nB1PtXSEZ4GlL5AAE7HZF4MBKOUc3HrycdsGEU
	 jRJMDq9pokCqez9IqziSkjuOmY7/4gerhMyHcZQjnG27n+F4MwV2rlRKYGObUVWRtE
	 9t7AOiEWbLVVQ==
Date: Wed, 19 Feb 2025 14:35:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 08/12] dax: advance the iomap_iter on dedupe range
Message-ID: <20250219223546.GN21808@frogsfrogsfrogs>
References: <20250219175050.83986-1-bfoster@redhat.com>
 <20250219175050.83986-9-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219175050.83986-9-bfoster@redhat.com>

On Wed, Feb 19, 2025 at 12:50:46PM -0500, Brian Foster wrote:
> Advance the iter on successful dedupe. Dedupe range uses two iters
> and iterates so long as both have outstanding work, so
> correspondingly this needs to advance both on each iteration. Since
> dax_range_compare_iter() now returns status instead of a byte count,
> update the variable name in the caller as well.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Double iterators, hrhghghggh
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index c0fbab8c66f7..c8c0d81122ab 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -2001,12 +2001,13 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
>  }
>  EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
>  
> -static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
> +static int dax_range_compare_iter(struct iomap_iter *it_src,
>  		struct iomap_iter *it_dest, u64 len, bool *same)
>  {
>  	const struct iomap *smap = &it_src->iomap;
>  	const struct iomap *dmap = &it_dest->iomap;
>  	loff_t pos1 = it_src->pos, pos2 = it_dest->pos;
> +	u64 dest_len;
>  	void *saddr, *daddr;
>  	int id, ret;
>  
> @@ -2014,7 +2015,7 @@ static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
>  
>  	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
>  		*same = true;
> -		return len;
> +		goto advance;
>  	}
>  
>  	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> @@ -2037,7 +2038,13 @@ static loff_t dax_range_compare_iter(struct iomap_iter *it_src,
>  	if (!*same)
>  		len = 0;
>  	dax_read_unlock(id);
> -	return len;
> +
> +advance:
> +	dest_len = len;
> +	ret = iomap_iter_advance(it_src, &len);
> +	if (!ret)
> +		ret = iomap_iter_advance(it_dest, &dest_len);
> +	return ret;
>  
>  out_unlock:
>  	dax_read_unlock(id);
> @@ -2060,15 +2067,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>  		.len		= len,
>  		.flags		= IOMAP_DAX,
>  	};
> -	int ret, compared = 0;
> +	int ret, status;
>  
>  	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
>  	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
> -		compared = dax_range_compare_iter(&src_iter, &dst_iter,
> +		status = dax_range_compare_iter(&src_iter, &dst_iter,
>  				min(src_iter.len, dst_iter.len), same);
> -		if (compared < 0)
> +		if (status < 0)
>  			return ret;
> -		src_iter.processed = dst_iter.processed = compared;
> +		src_iter.processed = dst_iter.processed = status;
>  	}
>  	return ret;
>  }
> -- 
> 2.48.1
> 
> 

