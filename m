Return-Path: <linux-fsdevel+bounces-73321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA33D158C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38F9301F7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CC274B32;
	Mon, 12 Jan 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXWnB7bU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593FB2777F3;
	Mon, 12 Jan 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256334; cv=none; b=f3LELC4ouMNy5z9MTl3gZaxjdg6xX5Y0ZTbthg/uPaHUvWIJH/kwHDaWOEHdLm5FKdRxKhHxCCVwYyGe90mdWyl4O/qsZgVCVJCOG1XCYLul6Uc51wBhyTrM2369ZNaOa1Et0ej2YwcBoRFevZJAlJr4jB5QeXQmZCT+iFePV6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256334; c=relaxed/simple;
	bh=aSkvTxQ8xQvcD+/rSk/ljj81MlYXjvJC/9/nkbaBhCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gG71kmWZKZvAbmd8rizv4PK0T2Km9IRcRWNVU0l0w90W60N21Ay7PHLblhPCeeEqPwsg3oh5wLm4HM8SF1s3LlVkQWE3y5UIqMHcYmQj5lclWetykq/pUeqhjKCZjDSlCIaKG9QBjLle1HSjh5r87cbx6B1zE20i2DWyeiFeTh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXWnB7bU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B6C116D0;
	Mon, 12 Jan 2026 22:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768256334;
	bh=aSkvTxQ8xQvcD+/rSk/ljj81MlYXjvJC/9/nkbaBhCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aXWnB7bUMeiTPTTpmTk6wAirYZBBbWIyEsvl5PoNXB6JtWxcCvh0fHiA/otmvgfJ9
	 2OoQd/YkXq9unmqs5u1WdazS4zxyCNigeUK3oGKzUrecckX/zyCEEOyT7sQ6lDPbzk
	 jSkNQnTDbQEyePFFD2/wvpU3uL2EBQ6cRceNqBgnC9k8Qr87jtD8gZPSk1p0kmBGLS
	 nV6UlftZ0MjK2VVUVKS1LCPIMROhNtU2FbIOz7O7SsLIaIX5gs9JaHQXyt/NNRUAW7
	 8Sw8d7/NJQLTf7PnftsQH8EvFqFVm2G2R//GqwLv4k+rOuu8mountTC75Vew0SwuC3
	 pQgzlhY5W2/tQ==
Date: Mon, 12 Jan 2026 14:18:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260112221853.GI15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>

On Mon, Jan 12, 2026 at 03:50:05PM +0100, Andrey Albershteyn wrote:
> Flag to indicate to iomap that read/write is happening beyond EOF and no
> isize checks/update is needed.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 13 ++++++++-----
>  fs/iomap/trace.h       |  3 ++-
>  include/linux/iomap.h  |  5 +++++
>  3 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index e5c1ca440d..cc1cbf2a4c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -533,7 +533,8 @@

(Does your diff program not set --show-c-function?  That makes reviewing
harder because I have to search on the comment text to figure out which
function this is)

>  			return 0;
>  
>  		/* zero post-eof blocks as the page may be mapped */
> -		if (iomap_block_needs_zeroing(iter, pos)) {
> +		if (iomap_block_needs_zeroing(iter, pos) &&
> +		    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {

Hrm.  The last test in iomap_block_needs_zeroing is if pos is at or
beyond EOF, and iomap_adjust_read_range takes great pains to reduce plen
so that poff/plen never cross EOF.  I think the intent of that code is
to ensure that we always zero the post-EOF part of a folio when reading
it in from disk.

For verity I can see why you don't want to zero the merkle tree blocks
beyond EOF, but I think this code can expose unwritten junk in the
post-EOF part of the EOF block on disk.

Would it be more correct to do:

static inline bool
iomap_block_needs_zeroing(
	const struct iomap_iter *iter,
	struct folio *folio,
	loff_t pos)
{
	const struct iomap *srcmap = iomap_iter_srcmap(iter);

	if (srcmap->type != IOMAP_MAPPED)
		return true;
	if (srcmap->flags & IOMAP_F_NEW);
		return true;

	/*
	 * Merkle tree exists in a separate folio beyond EOF, so
	 * only zero if this is the EOF folio.
	 */
	if (iomap->flags & IOMAP_F_BEYOND_EOF)
		return folio_pos(folio) == i_size_read(iter->inode);

	return pos >= i_size_read(iter->inode);
}

>  			folio_zero_range(folio, poff, plen);
>  			iomap_set_range_uptodate(folio, poff, plen);
>  		} else {
> @@ -1130,13 +1131,14 @@
>  		 * unlock and release the folio.
>  		 */
>  		old_size = iter->inode->i_size;
> -		if (pos + written > old_size) {
> +		if (pos + written > old_size &&
> +		    !(iter->flags & IOMAP_F_BEYOND_EOF)) {
>  			i_size_write(iter->inode, pos + written);
>  			iter->iomap.flags |= IOMAP_F_SIZE_CHANGED;
>  		}
>  		__iomap_put_folio(iter, write_ops, written, folio);
>  
> -		if (old_size < pos)
> +		if (old_size < pos && !(iter->flags & IOMAP_F_BEYOND_EOF))
>  			pagecache_isize_extended(iter->inode, old_size, pos);
>  
>  		cond_resched();
> @@ -1815,8 +1817,9 @@
>  
>  	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
>  
> -	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
> -		return 0;
> +	if (!(wpc->iomap.flags & IOMAP_F_BEYOND_EOF) &&
> +	    !iomap_writeback_handle_eof(folio, inode, &end_pos))

Hrm.  I /think/ this might break post-eof zeroing on writeback if
BEYOND_EOF is set.  For verity this isn't a problem because there's no
writeback, but it's a bit of a logic bomb if someone ever tries to set
BEYOND_EOF on a non-verity file.

--D

> + 		return 0;
>  	WARN_ON_ONCE(end_pos <= pos);
>  
>  	if (i_blocks_per_folio(inode, folio) > 1) {
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 532787277b..f1895f7ae5 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -118,7 +118,8 @@
>  	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
>  	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
>  	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> -	{ IOMAP_F_STALE,	"STALE" }
> +	{ IOMAP_F_STALE,	"STALE" }, \
> +	{ IOMAP_F_BEYOND_EOF,	"BEYOND_EOF" }
>  
>  
>  #define IOMAP_DIO_STRINGS \
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 520e967cb5..7a7e31c499 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -86,6 +86,11 @@
>  #define IOMAP_F_PRIVATE		(1U << 12)
>  
>  /*
> + * IO happens beyound inode EOF

s/beyound/beyond/

> + */
> +#define IOMAP_F_BEYOND_EOF	(1U << 13)
> +
> +/*
>   * Flags set by the core iomap code during operations:
>   *
>   * IOMAP_F_SIZE_CHANGED indicates to the iomap_end method that the file size
> 
> -- 
> - Andrey
> 
> 

