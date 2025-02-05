Return-Path: <linux-fsdevel+bounces-40960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB20A29970
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864C3A1E29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730111FECB8;
	Wed,  5 Feb 2025 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEdopMEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFD1885BE;
	Wed,  5 Feb 2025 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781422; cv=none; b=L1Woj6abHltDQv5/tlN6HN2PxYwC3tbkW/Fb5bxCqsfhytn1D6jwbkGYwOvJpel2I+yHY3TIYaRTg9dC8wRHhPkTqm7l3+IRXsETYT0r72WLhcOmtJGio1V/NEfJw5+jkRFL7NDNsWJcn3rolkERhm27OeLaMc95HbfQni/41zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781422; c=relaxed/simple;
	bh=rleZcJe36KCio1tATqQdE8IEI7teWDdGZWHt0oVXTUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+iLJfyXZ4XSzH8r5UsIZi7hDVxL2XNGBeURDUpe+b9UyK1IZR6y49Nv1sHKWIZvojh4LuVn33oYiGjKs1Qy0CKToZ1tjhQ3VWbE2seb9VCnXMsnZy7n/XE5VYlj7tpv6YYtzGddKIi1TCyFNJJRTaTsIAgGRxiBnEcx4eQZNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEdopMEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368DAC4CED1;
	Wed,  5 Feb 2025 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738781422;
	bh=rleZcJe36KCio1tATqQdE8IEI7teWDdGZWHt0oVXTUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEdopMEPYk1m18qKK3M2HhOdNqDGChSGGUuNj0ESRXsg63pNtYEWogNfd3zKvJR6+
	 aI88sUvkEsYPJxFquH/LnoiYIll4GxkQABmv4+p0NetIrTvzd3td2PiCdhdGtvcvvp
	 mMew3EIIIJ6PQPYj0iIhTl003HNXARDdDNb53dkqWP6GyN6F2rJtcdcNrivNwik86D
	 TOiS0FK/Vl12uranIgTt0/+tNvGLM34kPNpE+g/MRzdZySGLCBNQ3HIuW5xrfcrHxz
	 yXDwghfjgywqA2+DkW0VRRRma8Cw7IJoofikL4DdqavQbF3olg0d5kt9YGy3X3KaBw
	 Q57towsEtgFZQ==
Date: Wed, 5 Feb 2025 10:50:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 03/10] iomap: refactor iomap_iter() length check and
 tracepoint
Message-ID: <20250205185021.GM21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-4-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:14AM -0500, Brian Foster wrote:
> iomap_iter() checks iomap.length to skip individual code blocks not
> appropriate for the initial case where there is no mapping in the
> iter. To prepare for upcoming changes, refactor the code to jump
> straight to the ->iomap_begin() handler in the initial case and move
> the tracepoint to the top of the function so it always executes.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index 731ea7267f27..a2ae99fe6431 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -73,7 +73,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  {
>  	int ret;
>  
> -	if (iter->iomap.length && ops->iomap_end) {
> +	trace_iomap_iter(iter, ops, _RET_IP_);
> +
> +	if (!iter->iomap.length)
> +		goto begin;
> +
> +	if (ops->iomap_end) {
>  		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
>  				iter->processed > 0 ? iter->processed : 0,
>  				iter->flags, &iter->iomap);
> @@ -82,14 +87,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  	}
>  
>  	/* advance and clear state from the previous iteration */
> -	trace_iomap_iter(iter, ops, _RET_IP_);
> -	if (iter->iomap.length) {
> -		ret = iomap_iter_advance(iter, iter->processed);
> -		iomap_iter_reset_iomap(iter);
> -		if (ret <= 0)
> -			return ret;
> -	}
> +	ret = iomap_iter_advance(iter, iter->processed);
> +	iomap_iter_reset_iomap(iter);
> +	if (ret <= 0)
> +		return ret;
>  
> +begin:
>  	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
>  			       &iter->iomap, &iter->srcmap);
>  	if (ret < 0)
> -- 
> 2.48.1
> 
> 

