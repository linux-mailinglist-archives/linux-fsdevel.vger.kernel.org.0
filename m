Return-Path: <linux-fsdevel+bounces-53676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C797CAF5DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 18:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F85B5246DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A61B2F0E5B;
	Wed,  2 Jul 2025 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqlbQRnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52B3196AD;
	Wed,  2 Jul 2025 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471970; cv=none; b=PnrFWOhJxtf7Mdo6ciXl93THkT+useSMOw70q1NkDfvA+kLp4CMVcJiMx1e/WryD1I4+9GvRtIndfdjSVwgSnhw2n0pX1kAld4d3aPPBDu8meLEayP7ERjOhKi7KHTaQgXqycGDUeYBr5TTDbLv8BbrFThtXE/BL27xpx4Q1was=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471970; c=relaxed/simple;
	bh=4I/F+PLDspmS8iOW/s/m6osb0Un9n8GXw4cf8sc32Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbqOaEiaIWrWkrwtwmRDOrM2Eog4JqfKuj2IhZ3Y9suw65bntQgU6eLFL5q/NN8uvqL1JXXsoC4EjYOdVYNPJQMVIP3LTRXexAo09yo7KHTD8jnRL+YPCTld6md0cRO6ez9JlBjxPbxegQMdDyqu4LdDDjp5vmK7Pa7I+yOuPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqlbQRnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468CEC4CEE7;
	Wed,  2 Jul 2025 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751471970;
	bh=4I/F+PLDspmS8iOW/s/m6osb0Un9n8GXw4cf8sc32Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqlbQRnw01AXL+uf4DFd3xpF89F7pe4/78JpH3loY+fOQ7qnWAUZlgodu/b5PsAXu
	 YcwqodFiXy7l9KrZPH9O28pY0lPK3sBxC+enZNItvTVXUz2v4Ijt0b727mggQYhJaN
	 oie8Sg0XfR7hR5ZyXcgnGihYPMwUYbQqtL2lwSlgid6LV885CUSTG+LfeFArUYRFGE
	 RHMqWqVACkhhOVhXmo7AxThvCYOsel1CdaNIDQVmr7+kmUGT5OVltUb2gVm0tnVjHA
	 NZaBwgt4t4cPBvtBFyWl/CMWuEHOO7RO9V46QWATl10Qtv9rZ1/7ZzogMDwiRikCwm
	 asoJPq8/7/row==
Date: Wed, 2 Jul 2025 08:59:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, miklos@szeredi.hu,
	brauner@kernel.org, anuj20.g@samsung.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v3 02/16] iomap: cleanup the pending writeback tracking
 in iomap_writepage_map_blocks
Message-ID: <20250702155929.GV10009@frogsfrogsfrogs>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624022135.832899-3-joannelkoong@gmail.com>

On Mon, Jun 23, 2025 at 07:21:21PM -0700, Joanne Koong wrote:
> We don't care about the count of outstanding ioends, just if there is one.
> Replace the count variable passed to iomap_writepage_map_blocks with a
> boolean to make that more clear.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> [hch: rename the variable, update the commit message]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

/methinks this also fixes a theoretical logic bug if *count should
ever overflow back to zero so

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 71ad17bf827f..11a55da26a6f 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1758,7 +1758,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
>  
>  static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
> -		unsigned *count)
> +		bool *wb_pending)
>  {
>  	int error;
>  
> @@ -1786,7 +1786,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
>  			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
>  					map_len);
>  			if (!error)
> -				(*count)++;
> +				*wb_pending = true;
>  			break;
>  		}
>  		dirty_len -= map_len;
> @@ -1873,7 +1873,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	u64 pos = folio_pos(folio);
>  	u64 end_pos = pos + folio_size(folio);
>  	u64 end_aligned = 0;
> -	unsigned count = 0;
> +	bool wb_pending = false;
>  	int error = 0;
>  	u32 rlen;
>  
> @@ -1917,13 +1917,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	end_aligned = round_up(end_pos, i_blocksize(inode));
>  	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
>  		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
> -				rlen, &count);
> +				rlen, &wb_pending);
>  		if (error)
>  			break;
>  		pos += rlen;
>  	}
>  
> -	if (count)
> +	if (wb_pending)
>  		wpc->nr_folios++;
>  
>  	/*
> @@ -1945,7 +1945,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  		if (atomic_dec_and_test(&ifs->write_bytes_pending))
>  			folio_end_writeback(folio);
>  	} else {
> -		if (!count)
> +		if (!wb_pending)
>  			folio_end_writeback(folio);
>  	}
>  	mapping_set_error(inode->i_mapping, error);
> -- 
> 2.47.1
> 
> 

