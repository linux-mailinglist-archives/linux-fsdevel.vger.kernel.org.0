Return-Path: <linux-fsdevel+bounces-67059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E18D1C33B0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D01C14E153C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810A2253FF;
	Wed,  5 Nov 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBJLSunh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444A27470
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306980; cv=none; b=g2mMMZwYY3ixPx2X+m/HB22+t3u+JQrWFj/7cnsTRNVPGUwm69K0eCpT8ttVTGpPU6C2rRZ1U4CKbH0BVMDDGXLZm/Q2ZEYRBcElv8RvOcEAlP1HRHkd12sgkkZMAF6zAbUZvhs7MU6n7N4wgRUCs+fYKTtidYor49PNLWs9az8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306980; c=relaxed/simple;
	bh=Q+W1v7RxgclqGCBVkHavlezwg+oZ+Agtl3ex/hfDG9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7pCK3aV6aS7ztDfzIOBkt5lVZGk57y4uck1HtWFOGTib3xfBwVjOgj9QtPMBkEoHKBuoM+bIh01E4HpVppV1dXlqRoiPAn/+RASJq1QaLtFyDhETXxTjiNuXnI/p0u4synw4eojGMhDPGljxv0h4V38VSJQrI8HpudPERTTm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBJLSunh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC2CC116D0;
	Wed,  5 Nov 2025 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306980;
	bh=Q+W1v7RxgclqGCBVkHavlezwg+oZ+Agtl3ex/hfDG9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBJLSunhooF2ut7aqV2tbkvxo5Ne9/SfwG9nUDphu1UQAYzgfe8DPbcoinnyFsDtX
	 OCtDe5SKtuyyMvd2njGE3ufjd/7UVe6qzTaoqUUHraJEebvxI9ZWkA/HBTR7IOO7/A
	 xBbU72cc/NQKmzKAdtz1+nMcKWxeF0WBg6pSZ4o9PDSIIplcUlE1d53MH0qOkHYKJq
	 xIiKpPAaJSHixsXhVoR1AY/U++G3inxuWQXu9vc8tXYewRTIeT8BsK5Af3qHCpqVRG
	 oTMtinZgRnCRWwfgaNKY8cM48XteMJpaL0ONO9Dd5/byaVCnlBZuWTxNad4iC90lEH
	 /MavjEhsVCvug==
Date: Tue, 4 Nov 2025 17:42:58 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 8/8] iomap: use find_next_bit() for uptodate bitmap
 scanning
Message-ID: <20251105014258.GI196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-9-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-9-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:19PM -0800, Joanne Koong wrote:
> Use find_next_bit()/find_next_zero_bit() for iomap uptodate bitmap
> scanning. This uses __ffs() internally and is more efficient for
> finding the next uptodate or non-uptodate bit than iterating through the
> the bitmap range testing every bit.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>

Here too!
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 52 ++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 3c9a4b773186..03dd524b69d2 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -38,10 +38,28 @@ static inline bool ifs_is_fully_uptodate(struct folio *folio,
>  	return bitmap_full(ifs->state, i_blocks_per_folio(inode, folio));
>  }
>  
> -static inline bool ifs_block_is_uptodate(struct iomap_folio_state *ifs,
> -		unsigned int block)
> +/*
> + * Find the next uptodate block in the folio. end_blk is inclusive.
> + * If no uptodate block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_uptodate_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
>  {
> -	return test_bit(block, ifs->state);
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	return find_next_bit(ifs->state, end_blk + 1, start_blk);
> +}
> +
> +/*
> + * Find the next non-uptodate block in the folio. end_blk is inclusive.
> + * If no non-uptodate block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_nonuptodate_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +
> +	return find_next_zero_bit(ifs->state, end_blk + 1, start_blk);
>  }
>  
>  static bool ifs_set_range_uptodate(struct folio *folio,
> @@ -278,14 +296,11 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  	 * to avoid reading in already uptodate ranges.
>  	 */
>  	if (ifs) {
> -		unsigned int i, blocks_skipped;
> +		unsigned int next, blocks_skipped;
>  
> -		/* move forward for each leading block marked uptodate */
> -		for (i = first; i <= last; i++)
> -			if (!ifs_block_is_uptodate(ifs, i))
> -				break;
> +		next = ifs_next_nonuptodate_block(folio, first, last);
> +		blocks_skipped = next - first;
>  
> -		blocks_skipped = i - first;
>  		if (blocks_skipped) {
>  			unsigned long block_offset = *pos & (block_size - 1);
>  			unsigned bytes_skipped =
> @@ -295,15 +310,15 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
>  			poff += bytes_skipped;
>  			plen -= bytes_skipped;
>  		}
> -		first = i;
> +		first = next;
>  
>  		/* truncate len if we find any trailing uptodate block(s) */
> -		while (++i <= last) {
> -			if (ifs_block_is_uptodate(ifs, i)) {
> +		if (++next <= last) {
> +			next = ifs_next_uptodate_block(folio, next, last);
> +			if (next <= last) {
>  				plen -= iomap_bytes_to_truncate(*pos + plen,
> -						block_bits, last - i + 1);
> -				last = i - 1;
> -				break;
> +						block_bits, last - next + 1);
> +				last = next - 1;
>  			}
>  		}
>  	}
> @@ -634,7 +649,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = folio->mapping->host;
> -	unsigned first, last, i;
> +	unsigned first, last;
>  
>  	if (!ifs)
>  		return false;
> @@ -646,10 +661,7 @@ bool iomap_is_partially_uptodate(struct folio *folio, size_t from, size_t count)
>  	first = from >> inode->i_blkbits;
>  	last = (from + count - 1) >> inode->i_blkbits;
>  
> -	for (i = first; i <= last; i++)
> -		if (!ifs_block_is_uptodate(ifs, i))
> -			return false;
> -	return true;
> +	return ifs_next_nonuptodate_block(folio, first, last) > last;
>  }
>  EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
>  
> -- 
> 2.47.3
> 
> 

