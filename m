Return-Path: <linux-fsdevel+bounces-4147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD57FCF37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F991C20C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780E101F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Ex4tgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588713FFE;
	Wed, 29 Nov 2023 05:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D116BC433C8;
	Wed, 29 Nov 2023 05:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701235535;
	bh=XbZzfVtimLVO8rDiWWDKxSGKxNNhGJ3Y4ioHdJOnEhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C4Ex4tgln/a/Fhe3iOvB0HbEwysa+tihzlRbKlvsKH1IgMVdax4m1ho0K9/8gJZpL
	 i6mFe9xBHjQlGaMlBwoxAkwZtbUbrdoL1i0nfPAJDkWQ5xfBm0gUc46m0rc8Mi7BkN
	 uZZ93G9s5FTVhjyyTJmhGAiAWXXagRbVC28aaY+6wbp7W9hb7TwYAKRpiQGVIS0j1l
	 ku9mI9JfxcAG52Or5Q21ioa8RBhcOT4wYSBDEXVrtG34sqInsfhrloFa8Y3D8buT4U
	 swlJH4xoACfkdEM0ndkcmZapwGzgVnn3zHjfmmsFicivQopQ0GfF3XgIljS5Vtad/V
	 qxK7SFpWYmtDA==
Date: Tue, 28 Nov 2023 21:25:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/13] iomap: map multiple blocks at a time
Message-ID: <20231129052535.GO36211@frogsfrogsfrogs>
References: <20231126124720.1249310-1-hch@lst.de>
 <20231126124720.1249310-14-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126124720.1249310-14-hch@lst.de>

On Sun, Nov 26, 2023 at 01:47:20PM +0100, Christoph Hellwig wrote:
> The ->map_blocks interface returns a valid range for writeback, but we
> still call back into it for every block, which is a bit inefficient.
> 
> Change xfs_writepage_map to use the valid range in the map until the end

iomap_writepage_map?

> of the folio or the dirty range inside the folio instead of calling back
> into every block.
> 
> Note that the range is not used over folio boundaries as we need to be
> able to check the mapping sequence count under the folio lock.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 113 ++++++++++++++++++++++++++++-------------
>  include/linux/iomap.h  |   7 +++
>  2 files changed, 86 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index a01b0686e7c8a0..a98cb38a71ebc8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2010 Red Hat, Inc.
> - * Copyright (C) 2016-2019 Christoph Hellwig.
> + * Copyright (C) 2016-2023 Christoph Hellwig.
>   */
>  #include <linux/module.h>
>  #include <linux/compiler.h>
> @@ -95,6 +95,42 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
>  	return test_bit(block + blks_per_folio, ifs->state);
>  }
>  
> +static unsigned ifs_find_dirty_range(struct folio *folio,
> +		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
> +{
> +	struct inode *inode = folio->mapping->host;
> +	unsigned start_blk =
> +		offset_in_folio(folio, *range_start) >> inode->i_blkbits;
> +	unsigned end_blk = min_not_zero(
> +		offset_in_folio(folio, range_end) >> inode->i_blkbits,
> +		i_blocks_per_folio(inode, folio));
> +	unsigned nblks = 1;
> +
> +	while (!ifs_block_is_dirty(folio, ifs, start_blk))
> +		if (++start_blk == end_blk)
> +			return 0;
> +
> +	while (start_blk + nblks < end_blk &&
> +	       ifs_block_is_dirty(folio, ifs, start_blk + nblks))
> +		nblks++;

I don't like ^^^ the single-space indentation of the loop body over the
loop test expression because I almost missed that.  Extra braces for
clarity, please?

> +
> +	*range_start = folio_pos(folio) + (start_blk << inode->i_blkbits);
> +	return nblks << inode->i_blkbits;
> +}
> +
> +static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
> +		u64 range_end)
> +{
> +	struct iomap_folio_state *ifs = folio->private;
> +	

   ^^^^^ extra whitespace?

> +	if (*range_start >= range_end)
> +		return 0;
> +
> +	if (ifs)
> +		return ifs_find_dirty_range(folio, ifs, range_start, range_end);
> +	return range_end - *range_start;
> +}
> +
>  static void ifs_clear_range_dirty(struct folio *folio,
>  		struct iomap_folio_state *ifs, size_t off, size_t len)
>  {
> @@ -1712,10 +1748,9 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset)
>   */
>  static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, loff_t pos)
> +		struct inode *inode, loff_t pos, unsigned len)
>  {
>  	struct iomap_folio_state *ifs = folio->private;
> -	unsigned len = i_blocksize(inode);
>  	size_t poff = offset_in_folio(folio, pos);
>  	int error;
>  
> @@ -1739,28 +1774,41 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  
>  static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		struct writeback_control *wbc, struct folio *folio,
> -		struct inode *inode, u64 pos, unsigned *count)
> +		struct inode *inode, u64 pos, unsigned dirty_len,
> +		unsigned *count)
>  {
>  	int error;
>  
> -	error = wpc->ops->map_blocks(wpc, inode, pos);
> -	if (error)
> -		goto fail;
> -	trace_iomap_writepage_map(inode, &wpc->iomap);
> -
> -	switch (wpc->iomap.type) {
> -	case IOMAP_INLINE:
> -		WARN_ON_ONCE(1);
> -		error = -EIO;
> -		break;
> -	case IOMAP_HOLE:
> -		break;
> -	default:
> -		iomap_add_to_ioend(wpc, wbc, folio, inode, pos);

Hey wait, the previous patch missed the error return here!

> -		(*count)++;
> -	}
> +	do {
> +		unsigned map_len;
> +
> +		error = wpc->ops->map_blocks(wpc, inode, pos);
> +		if (error)
> +			break;
> +		trace_iomap_writepage_map(inode, &wpc->iomap);
> +
> +		map_len = min_t(u64, dirty_len,
> +			wpc->iomap.offset + wpc->iomap.length - pos);
> +		WARN_ON_ONCE(!folio->private && map_len < dirty_len);
> +
> +		switch (wpc->iomap.type) {
> +		case IOMAP_INLINE:
> +			WARN_ON_ONCE(1);
> +			error = -EIO;
> +			break;
> +		case IOMAP_HOLE:
> +			break;
> +		default:
> +			error = iomap_add_to_ioend(wpc, wbc, folio, inode, pos,
> +					map_len);
> +			if (!error)
> +				(*count)++;
> +			break;
> +		}
> +		dirty_len -= map_len;
> +		pos += map_len;
> +	} while (dirty_len && !error);
>  
> -fail:
>  	/*
>  	 * We cannot cancel the ioend directly here on error.  We may have
>  	 * already set other pages under writeback and hence we have to run I/O
> @@ -1827,7 +1875,7 @@ static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
>  		 * beyond i_size.
>  		 */
>  		folio_zero_segment(folio, poff, folio_size(folio));
> -		*end_pos = isize;
> +		*end_pos = round_up(isize, i_blocksize(inode));
>  	}
>  
>  	return true;
> @@ -1838,12 +1886,11 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  {
>  	struct iomap_folio_state *ifs = folio->private;
>  	struct inode *inode = folio->mapping->host;
> -	unsigned len = i_blocksize(inode);
> -	unsigned nblocks = i_blocks_per_folio(inode, folio);
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	unsigned count = 0;
> -	int error = 0, i;
> +	int error = 0;
> +	u32 rlen;
>  
>  	WARN_ON_ONCE(!folio_test_locked(folio));
>  	WARN_ON_ONCE(folio_test_dirty(folio));
> @@ -1857,7 +1904,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	}
>  	WARN_ON_ONCE(end_pos <= pos);
>  
> -	if (nblocks > 1) {
> +	if (i_blocks_per_folio(inode, folio) > 1) {
>  		if (!ifs) {
>  			ifs = ifs_alloc(inode, folio, 0);
>  			iomap_set_range_dirty(folio, 0, end_pos - pos);
> @@ -1880,18 +1927,16 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	folio_start_writeback(folio);
>  
>  	/*
> -	 * Walk through the folio to find areas to write back. If we
> -	 * run off the end of the current map or find the current map
> -	 * invalid, grab a new one.
> +	 * Walk through the folio to find dirty areas to write back.
>  	 */
> -	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> -		if (ifs && !ifs_block_is_dirty(folio, ifs, i))
> -			continue;
> -		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode, pos,
> -				&count);
> +	while ((rlen = iomap_find_dirty_range(folio, &pos, end_pos))) {
> +		error = iomap_writepage_map_blocks(wpc, wbc, folio, inode,
> +				pos, rlen, &count);
>  		if (error)
>  			break;
> +		pos += rlen;
>  	}
> +
>  	if (count)
>  		wpc->nr_folios++;
>  
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b8d3b658ad2b03..49d93f53878565 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -309,6 +309,13 @@ struct iomap_writeback_ops {
>  	/*
>  	 * Required, maps the blocks so that writeback can be performed on
>  	 * the range starting at offset.
> +	 *
> +	 * Can return arbitrarily large regions, but we need to call into it at
> +	 * least once per folio to allow the file systems to synchronize with
> +	 * the write path that could be invalidating mappings.

Does xfs_map_blocks already return arbitrarily large regions?  I think
it already does since I see it setting imap.br_blockcount in places.

--D

> +	 *
> +	 * An existing mapping from a previous call to this method can be reused
> +	 * by the file system if it is still valid.
>  	 */
>  	int (*map_blocks)(struct iomap_writepage_ctx *wpc, struct inode *inode,
>  				loff_t offset);
> -- 
> 2.39.2
> 
> 

