Return-Path: <linux-fsdevel+bounces-51047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C53AD237A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084293A5375
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFC1218AC7;
	Mon,  9 Jun 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx6gy/0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561B213E77;
	Mon,  9 Jun 2025 16:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485541; cv=none; b=uELNwhvxtKLaVsoFYhPKXQWmeuG4oLROORVecORn5VVlXkF7b1pKFjNKQTgaQktVyTFjGX3Aevf5185OrpKFMiiFJLAC0CUYWF3NQQH6z2NkWB/q4uFH7Dx3MWu9coVxatwShJ6BMwcnADJMVygAwBoH3j0X54fbBCa6Vg8++ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485541; c=relaxed/simple;
	bh=TnxPRrt3FuETnxO3K1XsXNg8xwyrps9vUrbwT0pBR58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usJh7IrB/sp4FOtwiT4zQHHhb8/URjNJQdhV6Go7HuuZRygno8qhOmjdGvbPVUbrw0BFX0DhpCS3hF3A7nur/UWBHZkHFAfBGOoQ5jXmOaKBK1di9vxqQzHY5oMRkAwpxdL+E5NDNCdF62HDbqvarW6B/miUqEYfn8NIaI6tSHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx6gy/0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACDC4CEEB;
	Mon,  9 Jun 2025 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749485540;
	bh=TnxPRrt3FuETnxO3K1XsXNg8xwyrps9vUrbwT0pBR58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xx6gy/0w0Cox/y0AwwMFXT+Q4DBELLGAjGsCLZEVrqM2JMSqQG2Fgsd5qEWlAATqz
	 CR55SLHsbrNNCvCI668SvNjRlvvWB9c144BStsaP0v+dqUzbV+EAE6iBsOdADtR7dW
	 MfDqiR58aeXrs8PJcqnpxxmMcs1FQrbKQB6jJjaLHKWMf7EM50AJgHCl7D2RoWtXim
	 FA6tm8qs3nlPneczfKl0c1ne/YfrE/MZ2oy9UFKFIGk6z8Xt2O3alEFIJUpmDB+pra
	 9faR5ddifjqxmMKoIfioKA+SFfqVLsu4aDkzuei9DP19l8saUp1R1IY/1DAYcnOdms
	 vLBmLzs8ELrnA==
Date: Mon, 9 Jun 2025 09:12:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <20250609161219.GE6156@frogsfrogsfrogs>
References: <20250605173357.579720-1-bfoster@redhat.com>
 <20250605173357.579720-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-6-bfoster@redhat.com>

On Thu, Jun 05, 2025 at 01:33:55PM -0400, Brian Foster wrote:
> Use the iomap folio batch mechanism to select folios to zero on zero
> range of unwritten mappings. Trim the resulting mapping if the batch
> is filled (unlikely for current use cases) to distinguish between a
> range to skip and one that requires another iteration due to a full
> batch.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/xfs/xfs_iomap.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index b5cf5bc6308d..63054f7ead0e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1691,6 +1691,8 @@ xfs_buffered_write_iomap_begin(
>  	struct iomap		*iomap,
>  	struct iomap		*srcmap)
>  {
> +	struct iomap_iter	*iter = container_of(iomap, struct iomap_iter,
> +						     iomap);

/me has been wondering more and more if we should just pass the iter
directly to iomap_begin rather than make them play these container_of
tricks... OTOH I think the whole point of this:

	ret = ops->iomap_begin(iter->inode, iter->pos, iter->len, iter->flags,
			       &iter->iomap, &iter->srcmap);

is to "avoid" allowing the iomap users to mess with the internals of the
iomap iter...

>  	struct xfs_inode	*ip = XFS_I(inode);
>  	struct xfs_mount	*mp = ip->i_mount;
>  	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> @@ -1762,6 +1764,7 @@ xfs_buffered_write_iomap_begin(
>  	 */
>  	if (flags & IOMAP_ZERO) {
>  		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
> +		u64 end;
>  
>  		if (isnullstartblock(imap.br_startblock) &&
>  		    offset_fsb >= eof_fsb)
> @@ -1769,6 +1772,26 @@ xfs_buffered_write_iomap_begin(
>  		if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
>  			end_fsb = eof_fsb;
>  
> +		/*
> +		 * Look up dirty folios for unwritten mappings within EOF.
> +		 * Providing this bypasses the flush iomap uses to trigger
> +		 * extent conversion when unwritten mappings have dirty
> +		 * pagecache in need of zeroing.
> +		 *
> +		 * Trim the mapping to the end pos of the lookup, which in turn
> +		 * was trimmed to the end of the batch if it became full before
> +		 * the end of the mapping.
> +		 */
> +		if (imap.br_state == XFS_EXT_UNWRITTEN &&
> +		    offset_fsb < eof_fsb) {
> +			loff_t len = min(count,
> +					 XFS_FSB_TO_B(mp, imap.br_blockcount));
> +
> +			end = iomap_fill_dirty_folios(iter, offset, len);

...though I wonder, does this need to happen in
xfs_buffered_write_iomap_begin?  Is it required to hold the ILOCK while
we go look for folios in the mapping?  Or could this become a part of
iomap_write_begin?

--D

> +			end_fsb = min_t(xfs_fileoff_t, end_fsb,
> +					XFS_B_TO_FSB(mp, end));
> +		}
> +
>  		xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
>  	}
>  
> -- 
> 2.49.0
> 
> 

