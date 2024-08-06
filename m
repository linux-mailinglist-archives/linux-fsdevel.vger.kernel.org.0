Return-Path: <linux-fsdevel+bounces-25156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A438F9497BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 20:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B3B1F24797
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7B7E0F4;
	Tue,  6 Aug 2024 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5uvVOex"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364058F77;
	Tue,  6 Aug 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970299; cv=none; b=SJasnmLFE+LXX6ueNo9YP6WHnjRLwyL0I1/tv/ueyec5Yu87uxdSL3T/3HNu+QfbXxLNNloJ5XyWFH3dk2oxcSxdod3cmY/OwVvPtMZ6KerimgDtrLvAInnI2Ipi9mZ8H6VBb4YmcNDU2vrSCWZhK0DTU9klH4D2ROG9YiAVtBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970299; c=relaxed/simple;
	bh=yriVAzItDrt9m0IOacwV5U8YZFGUHYkZLyfOw6hqRvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTIH99PXsnmhohOXJs3HrlAQ+xPhTKXwg72vhTsk+Zqmq4oRUAzvFxGG7G4Kv8YBFYSEa1hHH0536RY097iC6kNTYKojSe0UaAGyKCQihlIe1tBI3kiNdqsL3hfbxMc1bZ6jN+Tjv9Qusx2TlyUzDqVGcQIuD4vF3tqQ5elgHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5uvVOex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B308AC32786;
	Tue,  6 Aug 2024 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970298;
	bh=yriVAzItDrt9m0IOacwV5U8YZFGUHYkZLyfOw6hqRvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5uvVOexNdVv7IR46Jfa9rqBmRSdna/6vLRIrZySt3iFaWKCQgdi/W4yqml3d5xDY
	 C/JaQ3bDBNNLyp0VKyYKaABFahYaonWSCeABssEXElKjSP0V/O8gR3JKMIBdn3cYpy
	 L1Ue4JD1bbwIESFe/uQQCJyk/M7dKsFur892xBg084SM5/LR3nU+oIhw/ff66GoiG5
	 wIE08ra124LN4rZ6nlVHv2QChyzggumcOPno70X1w3LzZ+Cyr5V1+vcjP9pz/gplBL
	 R8Lj+Iycq7bJejOtgmkEh7K/jGIfgnwHS+dIfoqAQhMK3ZAiDLh5rHDZNlWfdgGVPD
	 zRP2pvZNjdy6A==
Date: Tue, 6 Aug 2024 11:51:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 01/14] xfs: only allow minlen allocations when near
 ENOSPC
Message-ID: <20240806185138.GF623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-2-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:44PM +0000, John Garry wrote:
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

Same question as the June 21st posting:

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

