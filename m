Return-Path: <linux-fsdevel+bounces-47877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E58AA6628
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 00:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB56B1BC262A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD229264F96;
	Thu,  1 May 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqCUztw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3679224E4B3;
	Thu,  1 May 2025 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138180; cv=none; b=jcnOJTuVuY8SotO+d6epUmnv1T0P1kkPta7Z+7u8u09QExkbsrsOYE3hWtENtv8HLm4N7OdFEgPPhFC+FdYKe/6FCmViU7GNikigzLPuWViVK/LnPqHg1dWlI1rZ9POY7VAN7KBJBDfsCDz1UHXZear/1WJpkQVbRUn1un+MkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138180; c=relaxed/simple;
	bh=5xKN6KBcMKNEPrLu+kiVws5FGA/CbRwZZLn+ueopDxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOqrNQ5GWsWIsG2c8A9AQ5dHVcat5YF+htvIH7yzcnT7TPTz2/VG/c84vxqSJKyQVbz3lBG0jcP7xY+WPvXFvXob91pUuLiMtSmsv2nqkZSJ5uGa8HnJ+NqF5JqyRMj9+0bb8BtMWNfMo+NOM+NiqcTc7tFedJok9dxSQE+lah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqCUztw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF61C4CEE3;
	Thu,  1 May 2025 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746138179;
	bh=5xKN6KBcMKNEPrLu+kiVws5FGA/CbRwZZLn+ueopDxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqCUztw0Wl1Wuq0Rh4J4PewXjdSYTrQiX/XkhbJB4SOiMOTwMSKfIFIdxKWS1iqNB
	 OCsnVo98BLG/kLSawbMPHH6EWjvRvHqx2ibIBul+Ixsxht8nB1EqAhs4gesfvW9eyM
	 OwMSuIKydiwoPck7U/01EZyBeeymPTdkTaC3+vnwvloLicU1klmE9boimHIE3L7P9M
	 VNfToJQL5bQK9Be9Bnjj7a5WTrAzg3d5LmX6ywpWXdBHtu5VX/ydd+s+VP90W9qPbM
	 2hSDg0O0gknvrIFom9ycSDrui2g9qL4pWxywwOdaM9Y1OKqunFzDGla3yo/zSQlSqk
	 8b0xWyPTyOueg==
Date: Thu, 1 May 2025 15:22:59 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] iomap: drop pos param from __iomap_[get|put]_folio()
Message-ID: <20250501222259.GN25675@frogsfrogsfrogs>
References: <20250430190112.690800-1-bfoster@redhat.com>
 <20250430190112.690800-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430190112.690800-4-bfoster@redhat.com>

On Wed, Apr 30, 2025 at 03:01:09PM -0400, Brian Foster wrote:
> Both helpers take the iter and pos as parameters. All callers
> effectively pass iter->pos, so drop the unnecessary pos parameter.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks ok,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d1a50300a5dc..5c08b2916bc7 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -741,10 +741,10 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
>  	return 0;
>  }
>  
> -static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
> -		size_t len)
> +static struct folio *__iomap_get_folio(struct iomap_iter *iter, size_t len)
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> +	loff_t pos = iter->pos;
>  
>  	if (folio_ops && folio_ops->get_folio)
>  		return folio_ops->get_folio(iter, pos, len);
> @@ -752,10 +752,11 @@ static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
>  		return iomap_get_folio(iter, pos, len);
>  }
>  
> -static void __iomap_put_folio(struct iomap_iter *iter, loff_t pos, size_t ret,
> +static void __iomap_put_folio(struct iomap_iter *iter, size_t ret,
>  		struct folio *folio)
>  {
>  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
> +	loff_t pos = iter->pos;
>  
>  	if (folio_ops && folio_ops->put_folio) {
>  		folio_ops->put_folio(iter->inode, pos, ret, folio);
> @@ -793,7 +794,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
>  	if (!mapping_large_folio_support(iter->inode->i_mapping))
>  		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
>  
> -	folio = __iomap_get_folio(iter, pos, len);
> +	folio = __iomap_get_folio(iter, len);
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  
> @@ -834,7 +835,7 @@ static int iomap_write_begin(struct iomap_iter *iter, size_t len,
>  	return 0;
>  
>  out_unlock:
> -	__iomap_put_folio(iter, pos, 0, folio);
> +	__iomap_put_folio(iter, 0, folio);
>  
>  	return status;
>  }
> @@ -983,7 +984,7 @@ static int iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  			i_size_write(iter->inode, pos + written);
>  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  		}
> -		__iomap_put_folio(iter, pos, written, folio);
> +		__iomap_put_folio(iter, written, folio);
>  
>  		if (old_size < pos)
>  			pagecache_isize_extended(iter->inode, old_size, pos);
> @@ -1295,7 +1296,7 @@ static int iomap_unshare_iter(struct iomap_iter *iter)
>  			bytes = folio_size(folio) - offset;
>  
>  		ret = iomap_write_end(iter, bytes, bytes, folio);
> -		__iomap_put_folio(iter, pos, bytes, folio);
> +		__iomap_put_folio(iter, bytes, folio);
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
>  
> @@ -1376,7 +1377,7 @@ static int iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		folio_mark_accessed(folio);
>  
>  		ret = iomap_write_end(iter, bytes, bytes, folio);
> -		__iomap_put_folio(iter, pos, bytes, folio);
> +		__iomap_put_folio(iter, bytes, folio);
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
>  
> -- 
> 2.49.0
> 
> 

