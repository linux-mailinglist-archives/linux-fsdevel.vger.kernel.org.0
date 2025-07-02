Return-Path: <linux-fsdevel+bounces-53686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16382AF6049
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502B41C44AFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD91F303DC3;
	Wed,  2 Jul 2025 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZCDJIAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D2F5095;
	Wed,  2 Jul 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478224; cv=none; b=WgfIBXh3MWIRAzqX7OrHAOzPpUlmt3s+4MyvceIQhXTrOCAhUW8FNvuMdJ5s8rL9hJfpFsmhyxAb+IM+kYzuhOrpGQ3S1IwODM5X4TT/6xgSubLORpj5QLU/Az5DeMEPuR6EdeUqMGgLVn4g7Y9mTSqYVVaisLvHYM4QR9ejqwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478224; c=relaxed/simple;
	bh=kEm1uCnyyPPr9BhjUBEY9Orbu28WO8xuseH2zk0SkVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bd2yayWjqXJn5ybE632TkYpNyjSXnp17bpyiMbnwzm8f4wm8g1YftCf9Tn8WQurNX4IlVVAQePEaoQJdbvnhBsSKKI15RUemLdQBk6UKSPDf+zJBoUPIuWcoEMPGOgrCnqvqFdOSYpY3Sxjq5q0nAVpQ0ndgKGiP0lZJeM9r/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZCDJIAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BFCC4CEE7;
	Wed,  2 Jul 2025 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478222;
	bh=kEm1uCnyyPPr9BhjUBEY9Orbu28WO8xuseH2zk0SkVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZCDJIAOuungqWaplozLYrHujJSIIOUTnU8E4hUQLWT5yTmmXZh/N33feT5/x2sSm
	 GCVjFkPEEyuV5+h39XqyJ+sc3fCFSVbCzjk2pApGJuJnWjxwasIh8rSQ4nns0MjuE0
	 GGKfmSvzZaVpi+Vj0KYGTJIzpuh5LhxkSYWZnYpgDI4ft7Kc5rXhRqTEVfTDvfis6k
	 9poG0cbLRLb+780PKnc0AlvMNuZy1Ao53yNxlWohUdhzPdQkdUDhTZK4/cs/K3un5s
	 OZZXVQ8hgLyY+NkGlj6FkdSetCJVdhDIvM3qIgCrQvxde1X+1C1a5rV+bsr3ZkQG6q
	 sD3oaFy5hJZqQ==
Date: Wed, 2 Jul 2025 10:43:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 08/16] iomap: move folio_unlock out of
 iomap_writeback_folio
Message-ID: <20250702174342.GB10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-9-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:27PM -0700, Joanne Koong wrote:
> Move unlocking the folio out of iomap_writeback_folio into the caller.
> This means the end writeback machinery is now run with the folio locked
> when no writeback happend, or writeback completed extremely fast.
> 
> This prepares for exporting iomap_writeback_folio for use in folio
> laundering.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> [hch: split from a larger patch]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems fine to me, since the folio lock state is the same beofre and
after the call to iomap_writeback_folio.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index c6bbee68812e..2973fced2a52 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1656,10 +1656,8 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
>  
>  	trace_iomap_writepage(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos)) {
> -		folio_unlock(folio);
> +	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
>  		return 0;
> -	}
>  	WARN_ON_ONCE(end_pos <= pos);
>  
>  	if (i_blocks_per_folio(inode, folio) > 1) {
> @@ -1713,7 +1711,6 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
>  	 * already at this point.  In that case we need to clear the writeback
>  	 * bit ourselves right after unlocking the page.
>  	 */
> -	folio_unlock(folio);
>  	if (ifs) {
>  		if (atomic_dec_and_test(&ifs->write_bytes_pending))
>  			folio_end_writeback(folio);
> @@ -1740,8 +1737,10 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
>  			PF_MEMALLOC))
>  		return -EIO;
>  
> -	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error)))
> +	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
>  		error = iomap_writeback_folio(wpc, folio);
> +		folio_unlock(folio);
> +	}
>  
>  	/*
>  	 * If @error is non-zero, it means that we have a situation where some
> -- 
> 2.47.1
> 
> 

