Return-Path: <linux-fsdevel+bounces-40961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA82A29974
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0624D1694E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04321FECB5;
	Wed,  5 Feb 2025 18:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGhonQ0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9713D897;
	Wed,  5 Feb 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738781471; cv=none; b=rWNw/jQRhqxh6yqdKPzWg41wU5EX9u/ufzTFTXbGV3/juq5xlw4s1yrxt0GrGpzK+BxgCqVroXi2nsn5FQu7T3amlIxNqM8AGofkE3RNaRMlehZZZL2iA/YBIxOyloSLYjLUJ2DccGc8vc6PVMNmI5KHIHF7itNWtKI7GPZmVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738781471; c=relaxed/simple;
	bh=FVE1hcq61ntcAAbP/sNKB6B2eEIGEwmuV+8GyvPFvc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mo9awbea9uo/C9grFNHQ2zwtnGpgyHQIEGwg9fq8ICbPE0cfbG+3OMcs3G45DS36pUbZMuqHj1ltQ2Z2qsNIkbHhfqQUsLstyTd7jVywZFG5rfQIIwKRr/YfLWsLvnRImPCBHpB1chrBi4iTg5tXaNDWj49AzyaVX8cYTcrpfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGhonQ0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DBFC4CED1;
	Wed,  5 Feb 2025 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738781470;
	bh=FVE1hcq61ntcAAbP/sNKB6B2eEIGEwmuV+8GyvPFvc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGhonQ0Ib3r7h5BOdajXW9+RzUnA08/hVtLQVOEpw2OGWfy2k+Kel0dPQDi3l9CJw
	 Z58o1oLqMPcCNGm0QBz4pGUDL88nv9F6Ex5LVCXI2JDUThq/mbu2fPOaFPkDSA3B8p
	 Z3N/Jc99DGdQK3zsZ/pzP6RcITMKh+2XaRCHxEZd6hYGQxuunGvT+DybPqsfLRl3n4
	 AA5u7USA/8CQvlMmSyJbkjGjVcJV1Nag/E0w0VFxWFjEqwwIOqD4eLb7hHg8zGMHt5
	 7+CP99kM3yd2LAChoSkOQnZ+x+pzz8UNuHgrHkkMOLqgMncG4DkWBROIw3c5fy82la
	 yIFN3ubBmFALQ==
Date: Wed, 5 Feb 2025 10:51:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 04/10] iomap: lift error code check out of
 iomap_iter_advance()
Message-ID: <20250205185110.GN21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-5-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-5-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:15AM -0500, Brian Foster wrote:
> The error code is only used to check whether iomap_iter() should
> terminate due to an error returned in iter.processed. Lift the check
> out of iomap_iter_advance() in preparation to make it more generic.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good now,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/iter.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index a2ae99fe6431..1db16be7b9f0 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -30,8 +30,6 @@ static inline int iomap_iter_advance(struct iomap_iter *iter, s64 count)
>  	bool stale = iter->iomap.flags & IOMAP_F_STALE;
>  	int ret = 1;
>  
> -	if (count < 0)
> -		return count;
>  	if (WARN_ON_ONCE(count > iomap_length(iter)))
>  		return -EIO;
>  	iter->pos += count;
> @@ -71,6 +69,7 @@ static inline void iomap_iter_done(struct iomap_iter *iter)
>   */
>  int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  {
> +	s64 processed;
>  	int ret;
>  
>  	trace_iomap_iter(iter, ops, _RET_IP_);
> @@ -86,8 +85,14 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
>  			return ret;
>  	}
>  
> +	processed = iter->processed;
> +	if (processed < 0) {
> +		iomap_iter_reset_iomap(iter);
> +		return processed;
> +	}
> +
>  	/* advance and clear state from the previous iteration */
> -	ret = iomap_iter_advance(iter, iter->processed);
> +	ret = iomap_iter_advance(iter, processed);
>  	iomap_iter_reset_iomap(iter);
>  	if (ret <= 0)
>  		return ret;
> -- 
> 2.48.1
> 
> 

