Return-Path: <linux-fsdevel+bounces-47876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D70FAA6624
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26159A1ACA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 22:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5C3264F99;
	Thu,  1 May 2025 22:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp6PnGyl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552D257443;
	Thu,  1 May 2025 22:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138166; cv=none; b=LZjpFexSd1yhPU0HU14UTP6sn8LDx/2ngem7t4lRZFx1GYvHt65eu2zXeNc3lg85R0vG3cp44gta8gnK1v8BhgW0wSzdl7yeE45lNFvzHaCub+kowL88JvzB/DQtc+zYhFJOKJjGD7CVbxjEIS8oNCGZfBmTUy12LAQRHvGI5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138166; c=relaxed/simple;
	bh=N/stVUrSZ+h+28ExQuQmtpRWGYLCV+oNcXw/0FrEdv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBN+dVSuIrUJbUihsetU0+3+WnVzMZ2XaJSOQkOu63WBaD4nV7lZqQ8ptaD5lZbn5fWfvZIDxjzIY+45E53YfnMf7anJlptScqzQPAnxX6rI7E60XQ/LK/xhceWn1FBzQ7PFLah4Ptwi6ghvmSJZ0gdUq2SF8orHmWSUVnVGuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp6PnGyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A8CC4CEE3;
	Thu,  1 May 2025 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746138165;
	bh=N/stVUrSZ+h+28ExQuQmtpRWGYLCV+oNcXw/0FrEdv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hp6PnGylr2eTYx1uCjTTPPBj6T/QU0Yqo1WYi/SkbtIwlsRkuQKrwQ4Y5Es3LQPtK
	 RVzfUk0jQWnlO4SRuGxOiAl3g8gHG3jqOoYJzSwH516G59DRLzOuHeHhiaveflfqcL
	 lOvyIS6H6kVVf5UPFlzs7KEb/guO/KiB3drEqKmNKg2Jbf1/Zk+U4/TojYybgThd36
	 3tE8TmD4ShNG1K4763ldgx4VyK4Mv06pGDm05oLIa7b+0K5knr3RX/JdC7Xgm4tX+u
	 pb/25tysp7cbWyONnRo5bf/BL9I4OVGJkxAosS6PWjtC1RtSAP84u5XmKjUZWlN69K
	 PvqsTD2XuD6mQ==
Date: Thu, 1 May 2025 15:22:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap: drop unnecessary pos param from
 iomap_write_[begin|end]
Message-ID: <20250501222245.GM25675@frogsfrogsfrogs>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-3-bfoster@redhat.com>

On Wed, Apr 30, 2025 at 03:01:08PM -0400, Brian Foster wrote:
> iomap_write_begin() and iomap_write_end() both take the iter and
> iter->pos as parameters. Drop the unnecessary pos parameter and
> sample iter->pos within each function.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a41c8ffc4996..d1a50300a5dc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -774,11 +774,12 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  	return iomap_read_inline_data(iter, folio);
>  }
>  
> -static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
> -		size_t len, struct folio **foliop)
> +static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> +		struct folio **foliop)
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	loff_t pos = iter->pos;
>  	struct folio *folio;
>  	int status = 0;
>  
> @@ -883,10 +884,11 @@ static void iomap_write_end_inline(const struct iomap_iter *iter,
>   * Returns true if all copied bytes have been written to the pagecache,
>   * otherwise return false.
>   */
> -static bool iomap_write_end(struct iomap_iter *iter, loff_t pos, size_t len,
> -		size_t copied, struct folio *folio)
> +static bool iomap_write_end(struct iomap_iter *iter, size_t len, size_t copied,
> +		struct folio *folio)
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> +	loff_t pos = iter->pos;
>  
>  	if (srcmap->type == IOMAP_INLINE) {
>  		iomap_write_end_inline(iter, folio, pos, copied);
> @@ -949,7 +951,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, iter->pos, bytes, &folio);
> +		status = iomap_write_begin(iter, bytes, &folio);
>  		if (unlikely(status)) {
>  			iomap_write_failed(iter->inode, iter->pos, bytes);
>  			break;
> @@ -966,7 +968,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			flush_dcache_folio(folio);
>  
>  		copied = copy_folio_from_iter_atomic(folio, offset, bytes, i);
> -		written = iomap_write_end(iter, pos, bytes, copied, folio) ?
> +		written = iomap_write_end(iter, bytes, copied, folio) ?
>  			  copied : 0;
>  
>  		/*
> @@ -1281,7 +1283,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
>  		bool ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
> -		status = iomap_write_begin(iter, iter->pos, bytes, &folio);
> +		status = iomap_write_begin(iter, bytes, &folio);
>  		if (unlikely(status))
>  			return status;
>  		if (iomap->flags & IOMAP_F_STALE)
> @@ -1292,7 +1294,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
>  		if (bytes > folio_size(folio) - offset)
>  			bytes = folio_size(folio) - offset;
>  
> -		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		ret = iomap_write_end(iter, bytes, bytes, folio);
>  		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
> @@ -1357,7 +1359,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		bool ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
> -		status = iomap_write_begin(iter, iter->pos, bytes, &folio);
> +		status = iomap_write_begin(iter, bytes, &folio);
>  		if (status)
>  			return status;
>  		if (iter->iomap.flags & IOMAP_F_STALE)
> @@ -1373,7 +1375,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
>  
> -		ret = iomap_write_end(iter, pos, bytes, bytes, folio);
> +		ret = iomap_write_end(iter, bytes, bytes, folio);
>  		__iomap_put_folio(iter, pos, bytes, folio);
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
> -- 
> 2.49.0
> 
> 

