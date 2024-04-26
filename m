Return-Path: <linux-fsdevel+bounces-17910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0C8B3B10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754B0B25102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA29150994;
	Fri, 26 Apr 2024 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWzOlfNd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFD14884A;
	Fri, 26 Apr 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144580; cv=none; b=pfLRZMG5ygTafu66dsTK/fmSCk+RJivU10Qkh99PilcGn6TLnkg2pub5MXeexTppZvyIg9Gh/HBtaGjy3BHMSLdlTkspA9bjIKuVv4x6A+3sHg4c3E0Y8FT1fr3sGyDy+BbbaDULllV/GQsKtajGDlpRlZ5pEZgXADhD/oT9guM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144580; c=relaxed/simple;
	bh=6O55S30yhSxrufIxUQivUWS2HXmNr/eDu8y7coHNiko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbELHZRXenY9PBP8AQIjcncyx8aFLzwzOTO+Qbgu99Y9wt4SUiLASgJefWkpMHL2P+ayEJmuKMxqIWG0PtgaM/QQ+JZumnn3qWGtmkK2aRD2IxQaNGZiYdYUMKcR6DRo4ovvnG0KglNxDXfSBUGlkWqtXWQbHJ9+3GafSE3Aju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWzOlfNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9827EC113CD;
	Fri, 26 Apr 2024 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144579;
	bh=6O55S30yhSxrufIxUQivUWS2HXmNr/eDu8y7coHNiko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWzOlfNdDph2jErkCnqNMCbQeWTzFhb2h4H1oYGTesbJPcQh8LSQpUKKE205Jcb/h
	 iq08eAB/2LjOYi2aO0WdTHjGqGFGM2fT+AxUqZrrA1/Vx284yxMk8O10R7990N1yzQ
	 0FmNOa1nA8H9RIGLGZPaz2CN9KCdUrkbPyhcVeLPKAPFbQjTxZ657KjXyJyQ+4QFeF
	 4BtJLDH5OkHBwrIBK9i1oOL+PzxwBiYHrvtScoa+yX4GSem3ha0AOTwy7AdnpWsnva
	 aWlMqV6Cqmo5+cZplCJBxOCI01Vtn5pJvQFi92otmTH7uKBSbDSyh1lINOGayFfOIy
	 UYRlMRIC/uXLA==
Date: Fri, 26 Apr 2024 08:16:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: willy@infradead.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, mcgrof@kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com
Subject: Re: [PATCH v4 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240426151619.GF360919@frogsfrogsfrogs>
References: <20240425113746.335530-1-kernel@pankajraghav.com>
 <20240425113746.335530-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425113746.335530-11-kernel@pankajraghav.com>

On Thu, Apr 25, 2024 at 01:37:45PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> Instead of assuming that PAGE_SHIFT is always higher than the blocklog,
> make the calculation generic so that page cache count can be calculated
> correctly for LBS.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_mount.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index df370eb5dc15..56d71282972a 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -133,9 +133,16 @@ xfs_sb_validate_fsb_count(
>  {
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
> +	uint64_t max_index;
> +	uint64_t max_bytes;
> +
> +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> +		return -EFBIG;
>  
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	max_index = max_bytes >> PAGE_SHIFT;
> +
> +	if (max_index > ULONG_MAX)
>  		return -EFBIG;
>  	return 0;
>  }
> -- 
> 2.34.1
> 
> 

