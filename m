Return-Path: <linux-fsdevel+bounces-40968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03807A299EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069481889FE6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E7201019;
	Wed,  5 Feb 2025 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZe7STuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DA1FE45E;
	Wed,  5 Feb 2025 19:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782905; cv=none; b=oYtwxothd+vcVc9wldmUL4neMKF/kGKj4rd2NbuGvQ3GLpSDVV9rSBRw4aasPlcHMabyvH1ibq34iMDwXnXDdH3wnnNVgugHDPUUnVQV5rOc4Z7bAItYOV694WvqsEXrydE8fBmHzPUb0j/W6rpj3429GuKv9K128Gt6yeTeLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782905; c=relaxed/simple;
	bh=PqbcbTM5oUyLqpxUJ/M7/jDa/OgRkhHuvLKfxZZP+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2I4yEjvOyHvKftszGxM3Kss8LetFkBLNH/FTqxfXJ4h9x03kyFtLpaOqueMyPb3jFw/1hmQAGE3aS+WjuFiYTZyZXZR9703MkYX5CTA6IOA2wyU+rOLYIaAqlpOJ4XDoEsxmjp3nFOKSkG4ldtjD6sdHrR4VJnHOSjoMP7ecUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZe7STuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47154C4CED1;
	Wed,  5 Feb 2025 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782905;
	bh=PqbcbTM5oUyLqpxUJ/M7/jDa/OgRkhHuvLKfxZZP+EE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZe7STuEjmmknsdyJVRWOB1kGRFOP9KZrOg1HB+QYFnXZF7oj/MqmLzAx1EIjKJF4
	 q4yztPcvEW3QnHnyIo0v97tNdh8OT/onHY7iXoe7Oi8PzWcDHr/pupkGxipB4YdlCF
	 cbfspHrFdNq1YYCpg+/dHkPU3OemP129KR9klBPTWlxN+w02n6mHCv/3rujR/spP/k
	 vp629EXEs/+AzwkZGTkgYraSJO3m1otqeDEHJVGLenLCxL6EMgcejLKQGHF/3mJPNN
	 SlWZBWzHzirGiloqFa+4Kqg9Rt43o2GyHksGi0/E27jYCB+85EFvWAR0DeK9Ru4wc0
	 iI6QLjIu6cMEg==
Date: Wed, 5 Feb 2025 11:15:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 10/10] iomap: advance the iter directly on zero range
Message-ID: <20250205191503.GR21808@frogsfrogsfrogs>
References: <20250205135821.178256-1-bfoster@redhat.com>
 <20250205135821.178256-11-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205135821.178256-11-bfoster@redhat.com>

On Wed, Feb 05, 2025 at 08:58:21AM -0500, Brian Foster wrote:
> Modify zero range to advance the iter directly. Replace the local pos
> and length calculations with direct advances and loop based on iter
> state instead.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f953bf66beb1..ec227b45f3aa 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1345,17 +1345,16 @@ static inline int iomap_zero_iter_flush_and_stale(struct iomap_iter *i)
>  
>  static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  {
> -	loff_t pos = iter->pos;
> -	loff_t length = iomap_length(iter);
> -	loff_t written = 0;
> +	u64 bytes = iomap_length(iter);
> +	int status;
>  
>  	do {
>  		struct folio *folio;
> -		int status;
>  		size_t offset;
> -		size_t bytes = min_t(u64, SIZE_MAX, length);
> +		loff_t pos = iter->pos;

I wonder, is there any need for the local variable here?

Looks fine to me though.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


>  		bool ret;
>  
> +		bytes = min_t(u64, SIZE_MAX, bytes);
>  		status = iomap_write_begin(iter, pos, bytes, &folio);
>  		if (status)
>  			return status;
> @@ -1376,14 +1375,14 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  		if (WARN_ON_ONCE(!ret))
>  			return -EIO;
>  
> -		pos += bytes;
> -		length -= bytes;
> -		written += bytes;
> -	} while (length > 0);
> +		status = iomap_iter_advance(iter, &bytes);
> +		if (status)
> +			break;
> +	} while (bytes > 0);
>  
>  	if (did_zero)
>  		*did_zero = true;
> -	return written;
> +	return status;
>  }
>  
>  int
> @@ -1436,11 +1435,14 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  
>  		if (srcmap->type == IOMAP_HOLE ||
>  		    srcmap->type == IOMAP_UNWRITTEN) {
> -			loff_t proc = iomap_length(&iter);
> +			s64 proc;
>  
>  			if (range_dirty) {
>  				range_dirty = false;
>  				proc = iomap_zero_iter_flush_and_stale(&iter);
> +			} else {
> +				u64 length = iomap_length(&iter);
> +				proc = iomap_iter_advance(&iter, &length);
>  			}
>  			iter.processed = proc;
>  			continue;
> -- 
> 2.48.1
> 
> 

