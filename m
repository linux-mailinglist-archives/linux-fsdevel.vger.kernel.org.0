Return-Path: <linux-fsdevel+bounces-40969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C002A299F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620A37A4533
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F1FECD1;
	Wed,  5 Feb 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWJfofEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119C38F82;
	Wed,  5 Feb 2025 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782971; cv=none; b=ZCukzwZhLwubQCEWC0R7uxslv0+bPlKGHsjd/qx4VWAWEVdwWgS7Jzh07GzwZyW5+DktbB943C4vw7wjWKzPiQJ0kfA65Mx4zOjlLolyZA3yk91uTI88OucI0Y7z4Saxyh6aeXNNihMc5vX2ZkZXtpNES406Cf7EcsWB1luUEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782971; c=relaxed/simple;
	bh=0iCCtZg7nct8wSNzXxsNigRzOjo1H6LvKufl3GMsjeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2SUbildw3TyQR/RLCjak2+rYtwVUW032AfzdcmsdZ4+HXHI+SBqgo49aquHPEpY3JxG3l40zldT7XtMbxokmkaAYLggw2msg9Inre6glhbybRIl/FA5HwbP3nnZEZwRIEfbgGRT2hY9r488ZqgCz5l5o5tFla0McSXM+6h77wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWJfofEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49192C4CED1;
	Wed,  5 Feb 2025 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782971;
	bh=0iCCtZg7nct8wSNzXxsNigRzOjo1H6LvKufl3GMsjeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FWJfofEga3F4Mtt6nXGFkOV5x5UEf+yTkE4YmVzetVCs+Z4V6VyiEAI6TMuM/GtT3
	 nxSAb1S8GFBEEnvcSL7EAOD30C8BvI1MAZoOrP4suwuk4xOKA6ExPmbhiBp9/s5zKd
	 WhK6v0EqK8YxJc+7+tFhN8j8RrWqjKftOls+pb2heb3bMeEr6yJFvfbN0n1OIxwdni
	 wxKo+OKAh/gMLn3RwAKZPtbjWPb5+pdTCs+f/b92CAGRgnkKKfg5YdFhOAEXOymaDS
	 L+SV1CnF7DXsHBocU61wVmAEGtITJqDYBi1NgYbgzxfxDdL8z1Ib1ERrhibEA+wu51
	 HYDvHe+6zYvHw==
Date: Wed, 5 Feb 2025 11:16:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 09/10] iomap: advance the iter directly on unshare
 range
Message-ID: <20250205191610.GS21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-10-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-10-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:20AM -0500, Brian Foster wrote:
> Modify unshare range to advance the iter directly. Replace the local
> pos and length calculations with direct advances and loop based on
> iter state instead.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 678c189faa58..f953bf66beb1 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1267,20 +1267,19 @@ EXPORT_SYMBOL_GPL(iomap_write_delalloc_release);
>  static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  {
>  	struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;
> -	loff_t length = iomap_length(iter);
> -	loff_t written = 0;
> +	u64 bytes = iomap_length(iter);
> +	int status;
>  
>  	if (!iomap_want_unshare_iter(iter))
> -		return length;
> +		return iomap_iter_advance(iter, &bytes);
>  
>  	do {
>  		struct folio *folio;
> -		int status;
>  		size_t offset;
> -		size_t bytes = min_t(u64, SIZE_MAX, length);
> +		loff_t pos = iter->pos;

Do we still need the local variable here?

Otherwise looks right to me, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  		bool ret;
>  
> +		bytes = min_t(u64, SIZE_MAX, bytes);
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (unlikely(status))
>  			return status;
> @@ -1298,14 +1297,14 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
>  
>  		cond_resched();
>  
> -		pos += bytes;
> -		written += bytes;
> -		length -= bytes;
> -
>  		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
> -	} while (length > 0);
>  
> -	return written;
> +		status = iomap_iter_advance(iter, &bytes);
> +		if (status)
> +			break;
> +	} while (bytes > 0);
> +
> +	return status;
>  }
>  
>  int
> -- 
> 2.48.1
> 
> 

