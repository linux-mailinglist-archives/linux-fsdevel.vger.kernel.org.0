Return-Path: <linux-fsdevel+bounces-22151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24992912E1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C1C1C211B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB617B504;
	Fri, 21 Jun 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgxUqQ9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE05664;
	Fri, 21 Jun 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999459; cv=none; b=jg3+M6Tgkeh+RJR36p50ZfPlj7RJeADqDn+3kGVZFdmnVc4nv2FCAA4NPfSmT8NVpZ5NYI9JGLvRUzhycPUjKK70rPisrVwruKau5d6EgM2g+PdiT6Rnz9CkSS0JH5KLF8G8a9MqQKWDc3rRN+ppUNk0ndV6XAMlqobk4/p32lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999459; c=relaxed/simple;
	bh=rB6V0Nwk3vOo+iDf5YMWh0T5Y3UT4s8EuBKwjeSnFxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKFPK/5rbtTLEWjwf9d/U9XXtAaDKw2l5drUbu05650QSWfykMS5CYZgobHU0zPgPwY3ftUBB+W9Qq3NNWF4Au4Zk/K2sFOTKbbh2r1qKClhzbcOfvllABhTSKtXSlfUDceY5QWk54N1faV8rTo8RKI8o8OcQ8leCwwz1HnlB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgxUqQ9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16D2C2BBFC;
	Fri, 21 Jun 2024 19:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718999458;
	bh=rB6V0Nwk3vOo+iDf5YMWh0T5Y3UT4s8EuBKwjeSnFxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgxUqQ9Q3urZD4YxmjWfmF5/+0Lr3AWpMAbgC+XJolUIupUldNxifhIUMe/4I7Lvo
	 1wvFZo/GUhenNP3wSyjwIXnJjy5hAld9iA+fiP617YKxye6KYM43dT1vei1lUpn2fA
	 fTm8+iZhBKpU/rlTw8Akiy0xOY6LOvqHPduG3OYFoT6QR/b6yEZ/x0cXbXyD5sc1dW
	 Wwxc8SYGlRhiyc+2ONDp1dyTS8tBlIvsXpfGl/JO40U9D9UoyCqegcoHduh7OlwafN
	 dolVHdI7psEKaHpceTJgilBywJZuOcfbkmm/IuGFtLt7TCe5cTl2iWzpsTTysyqKfF
	 AkQGUFhIxRGag==
Date: Fri, 21 Jun 2024 12:50:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 02/13] xfs: always tail align maxlen allocations
Message-ID: <20240621195058.GS3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-3-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:29AM +0000, John Garry wrote:
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
> alignment failure to e reclassified from an unimportant curiousity

                    to be

> to a must-fix bug.
> 
> Removing the assumption about args->maxlen allocations always being
> tail aligned is trivial, and should not impact anything because
> args->maxlen for inodes with extent size hints configured are
> already aligned. Hence all this change does it avoid weird corner
> cases that would have resulted in unaligned extent sizes by always
> trimming the extent down to an aligned size.

IOWs, we always trim rlen, unless there is no alignment (prod==1) or
rlen is less than mod.  For a forcealign file, it should never be the
case that minlen < mod because we'll have returned ENOSPC, right?

> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

If the answer is 'yes' and the typo gets fixed,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
> index 5855a21d4864..32f72217c126 100644
> --- a/fs/xfs/libxfs/xfs_alloc.c
> +++ b/fs/xfs/libxfs/xfs_alloc.c
> @@ -432,20 +432,18 @@ xfs_alloc_compute_diff(
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

