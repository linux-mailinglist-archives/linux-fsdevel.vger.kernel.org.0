Return-Path: <linux-fsdevel+bounces-67054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EE5C33A87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492B8189EE9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C166E23EAA1;
	Wed,  5 Nov 2025 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZKonvzv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946D226D14
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306043; cv=none; b=kmflhadQo4Re0YVjoPuTCw9tptxNIOKB3eU1Ybz60JmlARVniDmPNgviM6NoSb6d4MQphmGg9NDVj8NjTX7WyWOFJo5naMGGPxM/lTDQ2TiQe7Hzb9x3pJUnFjQD1YL4aq4JAIpGYX7t9Z1vy0g/ezfDLHC6n4d8nCLb04jsDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306043; c=relaxed/simple;
	bh=tMaKpeHUmVC9E2KV5oeOEYzU5pJvu2niWyPWOHQHiug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGCJNAMUg9zJUdrRgwFXM9HibjDXE3fy+OQSHAmzF2l0IZ4MYN2H2vIvG6iNqpAf6SVxI90We/jXiWJ/yEqJg81k9N1Gl5XYsxhkbMJ4hPg6t0u0bkTPMk4OjrO38fVzTsLvRzhrfOQcnmvFKPqbRbrxmjINfoqU+Aq07waNXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZKonvzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AA7C4CEF7;
	Wed,  5 Nov 2025 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306041;
	bh=tMaKpeHUmVC9E2KV5oeOEYzU5pJvu2niWyPWOHQHiug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZKonvzvLXk8eCSBlSnv5v/PhBQ5FBFR6mP4nKXOmUeBu5cKovgXjBdijUMNxK1RO
	 rAZ9/f/9DFIqHYBmWLvSx0Mw2FkAUlh+CcJk1TdYQqixuEggGAAGavqJpZnzSbrqYw
	 oLIlbeEDeyCnXHVs7/pCZuloTuq1jzRdUOn1AJxJxboEyK2UZcetzbPGe4JaDAAwxq
	 H+rFLGY5oYRllNfMi/5pFcEzWMb/lGk4qZeqDHdV/Hqp+86UCpAl9AIX0R5NudUmF5
	 IPJWyV+x6UuHc1/s1LjWtnoSF485LkHtwQ89FBBHySmdAmEkbyZlYR2hfCKedRKgYE
	 /Ta64OcV8iGCw==
Date: Tue, 4 Nov 2025 17:27:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/8] iomap: account for unaligned end offsets when
 truncating read range
Message-ID: <20251105012721.GD196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-2-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:12PM -0800, Joanne Koong wrote:
> The end position to start truncating from may be at an offset into a
> block, which under the current logic would result in overtruncation.
> 
> Adjust the calculation to account for unaligned end offsets.

When would the read offset be in the middle of a block?  My guess is
that happens when fuse reads some unaligned number of bytes into a folio
and then stops?  Can this also happen with inlinedata mappings?  I think
those are the only two conditions where iomap isn't dealing with
fsblock-aligned mappings and/or IOs.

(Obviously the pagecache copies themselves aren't required to be
aligned)

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f099c086cbe8..c79b59e52a49 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -218,6 +218,22 @@ static void ifs_free(struct folio *folio)
>  	kfree(ifs);
>  }
>  
> +/*
> + * Calculate how many bytes to truncate based off the number of blocks to
> + * truncate and the end position to start truncating from.
> + */
> +static size_t iomap_bytes_to_truncate(loff_t end_pos, unsigned block_bits,
> +		unsigned blocks_truncated)
> +{
> +	unsigned block_size = 1 << block_bits;
> +	unsigned block_offset = end_pos & (block_size - 1);
> +
> +	if (!block_offset)
> +		return blocks_truncated << block_bits;
> +
> +	return ((blocks_truncated - 1) << block_bits) + block_offset;
> +}
> +
>  /*
>   * Calculate the range inside the folio that we actually need to read.
>   */
> @@ -263,7 +279,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  		/* truncate len if we find any trailing uptodate block(s) */
>  		while (++i <= last) {
>  			if (ifs_block_is_uptodate(ifs, i)) {
> -				plen -= (last - i + 1) * block_size;
> +				plen -= iomap_bytes_to_truncate(*pos + plen,
> +						block_bits, last - i + 1);
>  				last = i - 1;
>  				break;
>  			}
> @@ -279,7 +296,8 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  		unsigned end = offset_in_folio(folio, isize - 1) >> block_bits;
>  
>  		if (first <= end && last > end)
> -			plen -= (last - end) * block_size;
> +			plen -= iomap_bytes_to_truncate(*pos + plen, block_bits,
> +					last - end);
>  	}
>  
>  	*offp = poff;
> -- 
> 2.47.3
> 
> 

