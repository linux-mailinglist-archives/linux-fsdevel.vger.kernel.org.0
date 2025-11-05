Return-Path: <linux-fsdevel+bounces-67058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03657C33B14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 02:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9713B4FE7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 01:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3892D22D7A1;
	Wed,  5 Nov 2025 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHMeowDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D91F03EF
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306954; cv=none; b=E9Jt/ynoOmzlVdijhcvXDSed+lpgatXwS57Ljzolyr2gYWprtW2A8HWU2JCooRTOPvixlF6a8uimCKzn8pNLhwrxcMy837HFsKy0I0WPXZjSrFGgaYJNdl7IshtvVIJF2BJn3WH0VE0jLlkosEYipQSYHgJPCWgB1l0hfnjeChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306954; c=relaxed/simple;
	bh=KNuKg5a/kPdE2LMVMwtD7pzUzOoaBdWvRzqGY+Srvi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb9Qv2E1b1MmB65kpsA5mQQQ2X32O/83LAEsy+zGZ0eTgQ8ioLBZbeVQ+94R0dxu9IJvHXHsMR6Iqmi5YaF6kg38DIXRCI2VoAw2KFcdy6eMIKlm+xbUXOUe3YKJVRRsqWJBtlazne8lg0tuTyMUO1wIIPkz4rJPO13J3RqgmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHMeowDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC94C116B1;
	Wed,  5 Nov 2025 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306954;
	bh=KNuKg5a/kPdE2LMVMwtD7pzUzOoaBdWvRzqGY+Srvi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHMeowDlUYY8HEI7hwaGp95oTUGhpXyyv6wCQleazGjLRvjB4x83hUPkqOf/0+w1J
	 YeO65qw1zi+8xAxinNaFW/YIJJXdumjkjKjkR4UZQIxAJlKvuNm2wWkBSa0wJPUdEP
	 ahwhkLAs7NzybhVArKPVGXJreEW8xzFsNhUqTiuIxIo9A+bhwdNYFgaxXppHwmpchP
	 pQ9b06H90Ttny9olMrai84QWWLppLKRDmiCPhhYa2AhAZJXcCTgJ7AXJ+bc1Osy4e8
	 //GCFLIbNtoQa4UN3p6+Gm3mZnG8wJ8GgPaS2P60qpZSoGKfWoUiGjnc1tGxc3rKh/
	 Po7J6T1CsQAKA==
Date: Tue, 4 Nov 2025 17:42:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 7/8] iomap: use find_next_bit() for dirty bitmap
 scanning
Message-ID: <20251105014233.GH196362@frogsfrogsfrogs>
References: <20251104205119.1600045-1-joannelkoong@gmail.com>
 <20251104205119.1600045-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104205119.1600045-8-joannelkoong@gmail.com>

On Tue, Nov 04, 2025 at 12:51:18PM -0800, Joanne Koong wrote:
> Use find_next_bit()/find_next_zero_bit() for iomap dirty bitmap
> scanning. This uses __ffs() internally and is more efficient for
> finding the next dirty or clean bit than iterating through the bitmap
> range testing every bit.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: Christoph Hellwig <hch@infradead.org>

Oh hey, that's a nice cleanup
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 61 ++++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 420fe2865927..3c9a4b773186 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -76,13 +76,34 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>  		folio_mark_uptodate(folio);
>  }
>  
> -static inline bool ifs_block_is_dirty(struct folio *folio,
> -		struct iomap_folio_state *ifs, int block)
> +/*
> + * Find the next dirty block in the folio. end_blk is inclusive.
> + * If no dirty block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_dirty_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
>  {
> +	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = folio->mapping->host;
> -	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
> +	unsigned int blks = i_blocks_per_folio(inode, folio);
> +
> +	return find_next_bit(ifs->state, blks + end_blk + 1,
> +			blks + start_blk) - blks;
> +}
> +
> +/*
> + * Find the next clean block in the folio. end_blk is inclusive.
> + * If no clean block is found, this will return end_blk + 1.
> + */
> +static unsigned ifs_next_clean_block(struct folio *folio,
> +		unsigned start_blk, unsigned end_blk)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	struct inode *inode = folio->mapping->host;
> +	unsigned int blks = i_blocks_per_folio(inode, folio);
>  
> -	return test_bit(block + blks_per_folio, ifs->state);
> +	return find_next_zero_bit(ifs->state, blks + end_blk + 1,
> +			blks + start_blk) - blks;
>  }
>  
>  static unsigned ifs_find_dirty_range(struct folio *folio,
> @@ -94,18 +115,17 @@ static unsigned ifs_find_dirty_range(struct folio *folio,
>  		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
>  	unsigned end_blk = min_not_zero(
>  		offset_in_folio(folio, range_end) >> inode->i_blkbits,
> -		i_blocks_per_folio(inode, folio));
> -	unsigned nblks = 1;
> -
> -	while (!ifs_block_is_dirty(folio, ifs, start_blk))
> -		if (++start_blk == end_blk)
> -			return 0;
> +		i_blocks_per_folio(inode, folio)) - 1;
> +	unsigned nblks;
>  
> -	while (start_blk + nblks < end_blk) {
> -		if (!ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> -			break;
> -		nblks++;
> -	}
> +	start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
> +	if (start_blk > end_blk)
> +		return 0;
> +	if (start_blk == end_blk)
> +		nblks = 1;
> +	else
> +		nblks = ifs_next_clean_block(folio, start_blk + 1, end_blk) -
> +				start_blk;
>  
>  	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
>  	return nblks << inode->i_blkbits;
> @@ -1161,7 +1181,7 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  		struct folio *folio, loff_t start_byte, loff_t end_byte,
>  		struct iomap *iomap, iomap_punch_t punch)
>  {
> -	unsigned int first_blk, last_blk, i;
> +	unsigned int first_blk, last_blk;
>  	loff_t last_byte;
>  	u8 blkbits = inode->i_blkbits;
>  	struct iomap_folio_state *ifs;
> @@ -1180,10 +1200,11 @@ static void iomap_write_delalloc_ifs_punch(struct inode *inode,
>  			folio_pos(folio) + folio_size(folio) - 1);
>  	first_blk = offset_in_folio(folio, start_byte) >> blkbits;
>  	last_blk = offset_in_folio(folio, last_byte) >> blkbits;
> -	for (i = first_blk; i <= last_blk; i++) {
> -		if (!ifs_block_is_dirty(folio, ifs, i))
> -			punch(inode, folio_pos(folio) + (i << blkbits),
> -				    1 << blkbits, iomap);
> +	while ((first_blk = ifs_next_clean_block(folio, first_blk, last_blk))
> +		       <= last_blk) {
> +		punch(inode, folio_pos(folio) + (first_blk << blkbits),
> +				1 << blkbits, iomap);
> +		first_blk++;
>  	}
>  }
>  
> -- 
> 2.47.3
> 
> 

