Return-Path: <linux-fsdevel+bounces-26942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE495D37B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3992E1F23643
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57218BC39;
	Fri, 23 Aug 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuH1LepR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377F18BBAA;
	Fri, 23 Aug 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430710; cv=none; b=AWugMzOXQIJg/YFtWALomUn5PEH6ENRf5gZ7Q+QM8OzfOMtrD4uSTzbRCGWzzHgp/fqBFFh8vpTWD90O9TYU0Hea0KjyHnS+7iGQhprPzMdJEZJx3g5O//6ZQ6CbloKydvWWRc3RQ21FyvcCGVJBP2WO2b87u96EFEo1X2R5OTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430710; c=relaxed/simple;
	bh=O+t/jgWCnfmI/92tweQIm+7M4T93kf6dJyGeWX91+3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+hbYEFvwRukO0qf8olgwH+ydXGKi3Mz/wUnw2V1cLY3QW5OH4peI9/3MnsKaFJRJ43xT6dZvfDsDdWA2T4sed47NTQIZk4VsIUka2UBiJUv9X/0wCDgAOMB5KeakBgOD6ixLLabpRkG4Q2fmebsknDTafueDz4vMUEKMoefL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuH1LepR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B0EC4AF0E;
	Fri, 23 Aug 2024 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430710;
	bh=O+t/jgWCnfmI/92tweQIm+7M4T93kf6dJyGeWX91+3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nuH1LepRThtihD5OUbXXEDFX+9tz0MUmeKxw1eRHQy/rOI2GeS2Z34f2eJgVyK0oc
	 3rniIqb+5C+clVpLE8wnkus5If9MPvJzBpnWUbWkGMmILXAayg2vINnfXj0aGYJAwE
	 ccrOb+9SKbGFWKJIsiIiPQH2FWc6fKu4EfveJA+fkqdI3pxu1os+CbYtumOka3wWxR
	 GmwwYtxpLtgBinOSS2MlyhmxHvEpYBFjdEY8yGQWIBMZ29r+s0I4W5xHqcF3lIHz+L
	 12AsH/6hxAZWtUHZIQ8S+6vTt0NO2kcYxk/cKbH+kK8+EUOgXtX22nX7K13+4eq0I0
	 +Yt6bRRsIEi5Q==
Date: Fri, 23 Aug 2024 09:31:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v4 02/14] xfs: always tail align maxlen allocations
Message-ID: <20240823163149.GC865349@frogsfrogsfrogs>
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813163638.3751939-3-john.g.garry@oracle.com>

On Tue, Aug 13, 2024 at 04:36:26PM +0000, John Garry wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When we do a large allocation, the core free space allocation code
> assumes that args->maxlen is aligned to args->prod/args->mod. hence
> if we get a maximum sized extent allocated, it does not do tail
> alignment of the extent.
> 
> However, this assumes that nothing modifies args->maxlen between the
> original allocation context setup and trimming the selected free
> space extent to size. This assumption has recently been found to be
> invalid - xfs_alloc_space_available() modifies args->maxlen in low
> space situations - and there may be more situations we haven't yet
> found like this.
> 
> Force aligned allocation introduces the requirement that extents are
> correctly tail aligned, resulting in this occasional latent
> alignment failure to be reclassified from an unimportant curiousity
> to a must-fix bug.
> 
> Removing the assumption about args->maxlen allocations always being
> tail aligned is trivial, and should not impact anything because
> args->maxlen for inodes with extent size hints configured are
> already aligned. Hence all this change does it avoid weird corner
> cases that would have resulted in unaligned extent sizes by always
> trimming the extent down to an aligned size.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org> [provisional on v1 series comment]

Still provisional -- neither the original patch author nor the submitter
have answered my question from June:

IOWs, we always trim rlen, unless there is no alignment (prod==1) or
rlen is less than mod.  For a forcealign file, it should never be the
case that minlen < mod because we'll have returned ENOSPC, right?

--D

> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index d559d992c6ef..bf08b9e9d9ac 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -433,20 +433,18 @@ xfs_alloc_compute_diff(
>   * Fix up the length, based on mod and prod.
>   * len should be k * prod + mod for some k.
>   * If len is too small it is returned unchanged.
> - * If len hits maxlen it is left alone.
>   */
> -STATIC void
> +static void
>  xfs_alloc_fix_len(
> -	xfs_alloc_arg_t	*args)		/* allocation argument structure */
> +	struct xfs_alloc_arg	*args)
>  {
> -	xfs_extlen_t	k;
> -	xfs_extlen_t	rlen;
> +	xfs_extlen_t		k;
> +	xfs_extlen_t		rlen = args->len;
>  
>  	ASSERT(args->mod < args->prod);
> -	rlen = args->len;
>  	ASSERT(rlen >= args->minlen);
>  	ASSERT(rlen <= args->maxlen);
> -	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
> +	if (args->prod <= 1 || rlen < args->mod ||
>  	    (args->mod == 0 && rlen < args->prod))
>  		return;
>  	k = rlen % args->prod;
> -- 
> 2.31.1
> 
> 

