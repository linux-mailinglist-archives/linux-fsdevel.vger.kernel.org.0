Return-Path: <linux-fsdevel+bounces-22150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE0912E10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4CB25740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0887817BB26;
	Fri, 21 Jun 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR2AIQkz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA317BB08;
	Fri, 21 Jun 2024 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998946; cv=none; b=jXq5l08R/XIQhtEezbyz8X61uQHHiqUbqQAN9+V0yErYyiC7vWJZ/CIgXTD8ck0YCSvPJwtACdrfNCmj0bgF3d3qFfKo0WnT6e51t0hREODCw4b2+7I69J3K9na+iBrH3YCilF53fXc+eYfSPhrLqTYhkuy5yW7MUPl2lt4dW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998946; c=relaxed/simple;
	bh=YxoHs/MZgzWYB+EBfGrNrzS7EXBm148ckuCUwY2V2/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEFeWPUhZJFltcGVpI6prAmc+lBszef825K82kcfmBb3XyZzAhJyt+gWvNJU+Khhknamf0b6OaPYtOdaIHzqltq4WCDcFM80ouXh1pdGzg8TChyB0ef0JMYe1BJwOU2iLoMWMziiFtC5voDoOePBTrB4rb5H/djzn1OGvNop3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR2AIQkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1180C2BBFC;
	Fri, 21 Jun 2024 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718998946;
	bh=YxoHs/MZgzWYB+EBfGrNrzS7EXBm148ckuCUwY2V2/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CR2AIQkzqBmC5ymH7i6NPNzRQOvW3RU7o+FzsFnIZF1boFfulZTlAKnSnk+3Jk5pZ
	 4QE5Sg7dRqovKnoIX7qDeagad0P0Uy1ZXoyOGVli1kSnO9dycbLHCclm1yrY3P2lkZ
	 mNs6xLexX/qEYA79NIefufKmuRTCthrDxmpfthmIg3tHMbUdsfdK64JgKfOwoL4Ubn
	 3Fuh8a8ylZlYCzNdIZVvELhCE0UjUGOgO+5KZeJN/+dnuPU2Ol8atYQolqPSaWJ1gD
	 8ifP0WFbHF5X8KO1mWAlDFmQ1LdS0wjcHZl5JES+0JFJwLYhQT5eUJUWibkCZBTijq
	 21IDhezDi1hGw==
Date: Fri, 21 Jun 2024 12:42:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 01/13] xfs: only allow minlen allocations when near ENOSPC
Message-ID: <20240621194225.GR3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-2-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:28AM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When we are near ENOSPC and don't have enough free
> space for an args->maxlen allocation, xfs_alloc_space_available()
> will trim args->maxlen to equal the available space. However, this
> function has only checked that there is enough contiguous free space
> for an aligned args->minlen allocation to succeed. Hence there is no
> guarantee that an args->maxlen allocation will succeed, nor that the
> available space will allow for correct alignment of an args->maxlen
> allocation.
> 
> Further, by trimming args->maxlen arbitrarily, it breaks an
> assumption made in xfs_alloc_fix_len() that if the caller wants
> aligned allocation, then args->maxlen will be set to an aligned
> value. It then skips the tail alignment and so we end up with
> extents that aren't aligned to extent size hint boundaries as we
> approach ENOSPC.
> 
> To avoid this problem, don't reduce args->maxlen by some random,
> arbitrary amount. If args->maxlen is too large for the available
> space, reduce the allocation to a minlen allocation as we know we
> have contiguous free space available for this to succeed and always
> be correctly aligned.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 6c55a6e88eba..5855a21d4864 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -2409,14 +2409,23 @@ xfs_alloc_space_available(
>  	if (available < (int)max(args->total, alloc_len))
>  		return false;
>  
> +	if (flags & XFS_ALLOC_FLAG_CHECK)
> +		return true;
> +
>  	/*
> -	 * Clamp maxlen to the amount of free space available for the actual
> -	 * extent allocation.
> +	 * If we can't do a maxlen allocation, then we must reduce the size of
> +	 * the allocation to match the available free space. We know how big
> +	 * the largest contiguous free space we can allocate is, so that's our
> +	 * upper bound. However, we don't exaclty know what alignment/size
> +	 * constraints have been placed on the allocation, so we can't
> +	 * arbitrarily select some new max size. Hence make this a minlen
> +	 * allocation as we know that will definitely succeed and match the
> +	 * callers alignment constraints.
>  	 */
> -	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
> -		args->maxlen = available;
> +	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;

Didn't we already calculate alloc_len identically under "do we have
enough contiguous free space for the allocation?"?  AFAICT we haven't
alter anything in @args since then, right?

> +	if (longest < alloc_len) {
> +		args->maxlen = args->minlen;

Is it possible to reduce maxlen the largest multiple of the alignment
that is still less than @longest?

--D

>  		ASSERT(args->maxlen > 0);
> -		ASSERT(args->maxlen >= args->minlen);
>  	}
>  
>  	return true;
> -- 
> 2.31.1
> 
> 

