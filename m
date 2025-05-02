Return-Path: <linux-fsdevel+bounces-47948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15396AA7A84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 22:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FC94C7806
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8664B1F585C;
	Fri,  2 May 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CppAOWOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3181F30DD;
	Fri,  2 May 2025 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216040; cv=none; b=a+8YnQ2anSwv3pP9oeuqrbQGXXXL8L8B8B5mIYt4Oh7Ez4sRjNXwoAUvGfCmDeUlkra1wbe3W6IONZ3FC2nv7skHoVI8eEtpUPoyUqs/tMM6Y6lxMfYUwqI74myI2BMDLNGQCIZPKbRiH5ZzBFdaGa0i/JcUQ1VjdFAlaC4puUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216040; c=relaxed/simple;
	bh=vb/v4exIhtV9dqEEonVug6BUDFTp+2bkIJbCBlsDDu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqaUGQFg/j03krwdF7epbPP7baVtzTzInq5fff8msUaZa7UEVfeQfzDtyzma0J1L5N9DFSecKhmuEDePVCQmMg3tDDHkhRgqqV/z/wD9BSlRmEsiWSIGTrqfOBLHpuVEMPg85Fox8fjmgol0VASiEIayIViar2CYSfP7a854JWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CppAOWOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D211C4CEE9;
	Fri,  2 May 2025 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746216039;
	bh=vb/v4exIhtV9dqEEonVug6BUDFTp+2bkIJbCBlsDDu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CppAOWOEsTqjjlVk60N1TPJK2qOPNoG7vfsIpq5r/xhAeYB1oCtqS81eXL6NBq0k+
	 fdjvMiDlZQccS+OYYhtbZfoLgobp9TbBvwwOnXJi+qDunw+vN+xANwxs9BqwUk4HWB
	 KM+U7Aj7rhb3zgsjJ+TI+trBN29BXhKKcRRsBdZaxq3Yi9WMMROAsHb/lLhuB7beAW
	 oXSCHrKGmObVGvG5RLjk322dKYW3acg4tqC7B1vpocMmRRDXzIAcYyhKbj0iGwBMC+
	 eQLmaS3LXRvTH4QyW7kbHFMHmhSr3e6ENcfHQlfWYM93T5x7BDazFr7gfeaolLXFim
	 Ff5rKfqVwChGw==
Date: Fri, 2 May 2025 13:00:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 6/6] iomap: rework iomap_write_begin() to return folio
 offset and length
Message-ID: <20250502200038.GR25675@frogsfrogsfrogs>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-7-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-7-bfoster@redhat.com>

On Wed, Apr 30, 2025 at 03:01:12PM -0400, Brian Foster wrote:
> iomap_write_begin() returns a folio based on current pos and
> remaining length in the iter, and each caller then trims the
> pos/length to the given folio. Clean this up a bit and let
> iomap_write_begin() return the trimmed range along with the folio.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d3b30ebad9ea..2fde268c39fc 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -793,15 +793,22 @@ static int iomap_write_begin_inline(const struct iomap_iter *iter,
>  	return iomap_read_inline_data(iter, folio);
>  }
>  
> -static int iomap_write_begin(struct iomap_iter *iter, size_t len,
> -		struct folio **foliop)
> +/*
> + * Grab and prepare a folio for write based on iter state. Returns the folio,
> + * offset, and length. Callers can optionally pass a max length *plen,
> + * otherwise init to zero.
> + */
> +static int iomap_write_begin(struct iomap_iter *iter, struct folio **foliop,
> +		size_t *poffset, u64 *plen)
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  	loff_t pos = iter->pos;
> +	u64 len = min_t(u64, SIZE_MAX, iomap_length(iter));
>  	struct folio *folio;
>  	int status = 0;
>  
> +	len = *plen > 0 ? min_t(u64, len, *plen) : len;
>  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
>  	if (srcmap != &iter->iomap)
>  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
> @@ -833,8 +840,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
>  		}
>  	}
>  
> -	if (pos + len > folio_pos(folio) + folio_size(folio))
> -		len = folio_pos(folio) + folio_size(folio) - pos;
> +	pos = iomap_trim_folio_range(iter, folio, poffset, &len);

Do we still need this pos variable?  AFAICT it aliases iter->pos.  But
maybe that's something needed for whatever the subsequent series does?

>  
>  	if (srcmap->type == IOMAP_INLINE)
>  		status = iomap_write_begin_inline(iter, folio);
> @@ -847,6 +853,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
>  		goto out_unlock;
>  
>  	*foliop = folio;
> +	*plen = len;
>  	return 0;
>  
>  out_unlock:
> @@ -967,7 +974,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			break;
>  		}
>  
> -		status = iomap_write_begin(iter, bytes, &folio);
> +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
>  		if (unlikely(status)) {
>  			iomap_write_failed(iter->inode, iter->pos, bytes);
>  			break;
> @@ -975,7 +982,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
>  
> -		pos = iomap_trim_folio_range(iter, folio, &offset, &bytes);
> +		pos = iter->pos;

I wonder, do we still need this pos variable?  AFAICT it aliases
iter->pos too.

Aside from that, the series looks decent to me and it's nice to
eliminate some argument passing.

--D

>  
>  		if (mapping_writably_mapped(mapping))
>  			flush_dcache_folio(folio);
> @@ -1295,14 +1302,12 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
>  		bool ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
> -		status = iomap_write_begin(iter, bytes, &folio);
> +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
>  		if (unlikely(status))
>  			return status;
>  		if (iomap->flags & IOMAP_F_STALE)
>  			break;
>  
> -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
> -
>  		ret = iomap_write_end(iter, bytes, bytes, folio);
>  		__iomap_put_folio(iter, bytes, folio);
>  		if (WARN_ON_ONCE(!ret))
> @@ -1367,7 +1372,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		bool ret;
>  
>  		bytes = min_t(u64, SIZE_MAX, bytes);
> -		status = iomap_write_begin(iter, bytes, &folio);
> +		status = iomap_write_begin(iter, &folio, &offset, &bytes);
>  		if (status)
>  			return status;
>  		if (iter->iomap.flags & IOMAP_F_STALE)
> @@ -1376,7 +1381,6 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		/* warn about zeroing folios beyond eof that won't write back */
>  		WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
>  
> -		iomap_trim_folio_range(iter, folio, &offset, &bytes);
>  		folio_zero_range(folio, offset, bytes);
>  		folio_mark_accessed(folio);
>  
> -- 
> 2.49.0
> 
> 

