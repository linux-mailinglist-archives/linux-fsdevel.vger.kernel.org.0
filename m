Return-Path: <linux-fsdevel+bounces-17811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37F8B26E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 18:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15EC3285236
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 16:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC314D451;
	Thu, 25 Apr 2024 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxlI2MKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0467131746;
	Thu, 25 Apr 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064124; cv=none; b=WOiN9gEluTmHw96ZJ3GXvXG2IXSLLfpCvmS/KRx26oxkU0OT21o+jXorypzYH7FZT3T1LYjk2JW7zQluoPE3Pn8evwwRD5jDgWrweQV1+xbM0549dnLfPLQA1mQFPp2r2iej7VgnA4PhE58f8QzRButwy98SzUvYhoKFyGs/jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064124; c=relaxed/simple;
	bh=spomJ+a/wob9Uwtaio77gXEhScUHFtHTYV3kW94eQoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXDjhUmbT1Rg52Bc3MXNOpmREapqGQRjLCxU2z2WRzuUqlXoGHCHDlSnDZbWws324t1j2hGHE8YdhlVk5dUcgurRyxyj7lpAIy/Q0tzTiASEMTNW6nN2MnipCs4IC8uuKLl+OlqmndGnHATWCbmUXCkdOwILcacPbdtmDd3ihrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxlI2MKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16046C113CC;
	Thu, 25 Apr 2024 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714064124;
	bh=spomJ+a/wob9Uwtaio77gXEhScUHFtHTYV3kW94eQoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxlI2MKgQyMg6IF7lPjYV9tOd7J+RWsmL5/hN9rSHeHkOJK8peg4d6kZhI26i5VBD
	 oj8k+pfmbaf603cP4zVG12ayPxYY/oGvkHbe1jXAD3d8AhFprIiix7YeIOEbr+BvJJ
	 eNdYTIofP4QSBELqBCMprtkI0Wt2y6XE+iB/iA8njkcayBn9O9+nyjYRqnKgH3bJXY
	 LarEANd56itUxB00uszt8qVK4aC4hS6t3gu2PoYVrFZgghzLwJCaMtLLBYnR4j3cgn
	 Yn2jMApggD4UVbwFc2o3HTMJQ8AAWRlndw4WUIijnhgrO0S5iaattp8MohvPxJkhQq
	 vy8fEnzdAMu0Q==
Date: Thu, 25 Apr 2024 09:55:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 27/30] iomap: Remove calls to set and clear folio error
 flag
Message-ID: <20240425165523.GB360898@frogsfrogsfrogs>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-28-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420025029.2166544-28-willy@infradead.org>

On Sat, Apr 20, 2024 at 03:50:22AM +0100, Matthew Wilcox (Oracle) wrote:
> The folio error flag is not checked anywhere, so we can remove the calls
> to set and clear it.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: linux-xfs@vger.kernel.org
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks fine to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 4e8e41c8b3c0..41352601f939 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -306,8 +306,6 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
>  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>  	}
>  
> -	if (error)
> -		folio_set_error(folio);
>  	if (finished)
>  		folio_end_read(folio, uptodate);
>  }
> @@ -460,9 +458,6 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
>  		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
>  
> -	if (ret < 0)
> -		folio_set_error(folio);
> -
>  	if (ctx.bio) {
>  		submit_bio(ctx.bio);
>  		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
> @@ -697,7 +692,6 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  
>  	if (folio_test_uptodate(folio))
>  		return 0;
> -	folio_clear_error(folio);
>  
>  	do {
>  		iomap_adjust_read_range(iter->inode, folio, &block_start,
> @@ -1528,8 +1522,6 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  
>  	/* walk all folios in bio, ending page IO on them */
>  	bio_for_each_folio_all(fi, bio) {
> -		if (error)
> -			folio_set_error(fi.folio);
>  		iomap_finish_folio_write(inode, fi.folio, fi.length);
>  		folio_count++;
>  	}
> -- 
> 2.43.0
> 
> 

