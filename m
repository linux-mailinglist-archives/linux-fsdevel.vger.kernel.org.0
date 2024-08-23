Return-Path: <linux-fsdevel+bounces-26941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E45B95D35E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16C41C2390C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535FB18BC04;
	Fri, 23 Aug 2024 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBd8AxYB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72BF18B49C;
	Fri, 23 Aug 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430500; cv=none; b=WwCFZBzaNu0/l/ypwWGgSAXmSKEJAKoTc6CkFwtnHbcaj8ign28AVPLksnKvQ1uOkr+J+VxaxOdKRSGQ24qHMiEkpGizIdZZ6s1zswvvSzt6TTV5g87xnFxyGhW0QIowgLmlt4HEKeqvpBHkxjPVxjGo9spcn8BGQurLrVdALME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430500; c=relaxed/simple;
	bh=Fu4zYUmJgBcqoo3fJtRKVrGuO9BhONx3Z/G49nzToQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jch7MadAFDVXzrxc8nMmT+/gfWqgIbQW6ljVGaToQHKDRXJDHP9nVrQiPz+w791tCOB50P5RiJO6mz21epoOk6FTJUFd+UVLRHzV9Ite6Oqz4j/RfOp88b1t87OhqFf4dmk9b//LRZJ17Lk8UpQke3U7ODm/1dRKEbTuqXYGnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBd8AxYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BD0C32786;
	Fri, 23 Aug 2024 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430500;
	bh=Fu4zYUmJgBcqoo3fJtRKVrGuO9BhONx3Z/G49nzToQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBd8AxYBTKrCLUyAyhzpDS8FlukESEFJTv3f2YOWiHpXBcemeHdns75+kq2Dvrf1p
	 To1HylzD2NqADKx3FRArV6/1ATAA7RwZuIiMAE1daOD9tKwpQZIlc7wCu4cMjz7pz1
	 wyP85hqqo43AqocmM08Gx96/j1czPwXTdvtbxA33H4Kcd+RwN41hRQS5fEu+M/PZd/
	 RBjoJH0lc8Y7GnKbZRkoMlXq+TEWncf8NCuBu6olOs26i8b0bIlcVeAnJyZe3vhSOm
	 B2eZncOpwzMqld7IyoOz1VoWFZWTO0ujW99CwU/1Di+hFECPH4g2VPuDQmPDYlXD6c
	 H/2VglONz3cgw==
Date: Fri, 23 Aug 2024 09:28:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 01/14] xfs: only allow minlen allocations when near
 ENOSPC
Message-ID: <20240823162819.GB865349@frogsfrogsfrogs>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813163638.3751939-2-john.g.garry@oracle.com>

On Tue, Aug 13, 2024 at 04:36:25PM +0000, John Garry wrote:
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

Looks ok.  I still have some misgivings about going straight to minlen,
but that's a common tactic elsewhere in the allocator and at worst the
performance is suboptimal.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 59326f84f6a5..d559d992c6ef 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -2524,14 +2524,23 @@ xfs_alloc_space_available(
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
> +	if (longest < alloc_len) {
> +		args->maxlen = args->minlen;
>  		ASSERT(args->maxlen > 0);
> -		ASSERT(args->maxlen >= args->minlen);
>  	}
>  
>  	return true;
> -- 
> 2.31.1
> 
> 

