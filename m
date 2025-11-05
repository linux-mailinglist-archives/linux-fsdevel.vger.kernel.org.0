Return-Path: <linux-fsdevel+bounces-67019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE1C337A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B22D4E974F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8685B24B28;
	Wed,  5 Nov 2025 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFdLjsXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F61FC8;
	Wed,  5 Nov 2025 00:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302677; cv=none; b=q58ChhTjHBqxKPq+PYUh9AvDvTSknLb1Amk+7V0UNm2lOaCXOwbPWpfF1g01Gl8XODLpLEtL65I0c5xac9OEk3bXm50+yr0XWLnjgs9UM2HFGyhkioJ4SIMmotgYl3WEpjKtMMWBzcx4zjRgyj7yjnmbRlq3EldnhuC+4lc9+O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302677; c=relaxed/simple;
	bh=fvsuoJmK6PbnYdkMRKBiZIBvwzEp6WB857fVoWxCI0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3Gj+uO74gLIg+6YDE6oNcv1++QtwqWOPibyY9OSjPU2mvfnblcNaUe6zbL9UuxEBzIpD1h3XjrzKNpVh456X429biQIUBPisLE3UqSWJN+02p+N7q7nwVy/N4s6wroyFtzK9pkwBHDmadj1GFq/5FGgIQBAkSyrSBD2PWCBH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFdLjsXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67199C116B1;
	Wed,  5 Nov 2025 00:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302675;
	bh=fvsuoJmK6PbnYdkMRKBiZIBvwzEp6WB857fVoWxCI0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFdLjsXPziKRs6Ovq37U1gAt4QNCZzfaF4zJXoPAPtwpiDaSCZh6FJxMWa0nFHerJ
	 sxIfhXrmMfnXcbi00FD4meookYpXzGfrcVaZ3r6j7tyDPInY6Nj4VON7lQlo1LmW8y
	 7XEYBeXnhBb9H6lmfQV+a8A6FQxnTTXipJ6GcX7Lctz5q7M6brwPQezGkohZFkzzNA
	 O7Y/P5OPb9tjSdYoxRLX2zqhESBO4vnB/W1MM1z7tKvgEiN/Zt2DcduH1d/AUQUASW
	 c8aLosC7A9eeKWIOF2+7VNdpg/wLQ3IhKTsdt3nUfssk4B4QJY07rpQ+zt4vWnDzkz
	 7OlUYpIBVuk/g==
Date: Tue, 4 Nov 2025 16:31:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <20251105003114.GY196370@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016190303.53881-3-bfoster@redhat.com>

On Thu, Oct 16, 2025 at 03:02:59PM -0400, Brian Foster wrote:
> iomap zero range has a wart in that it also flushes dirty pagecache
> over hole mappings (rather than only unwritten mappings). This was
> included to accommodate a quirk in XFS where COW fork preallocation
> can exist over a hole in the data fork, and the associated range is
> reported as a hole. This is because the range actually is a hole,
> but XFS also has an optimization where if COW fork blocks exist for
> a range being written to, those blocks are used regardless of
> whether the data fork blocks are shared or not. For zeroing, COW
> fork blocks over a data fork hole are only relevant if the range is
> dirty in pagecache, otherwise the range is already considered
> zeroed.

It occurs to me that the situation (unwritten cow mapping, hole in data
fork) results in iomap_iter::iomap getting the unwritten mapping, and
iomap_iter::srcmap getting the hole mapping.  iomap_iter_srcmap returns
iomap_itere::iomap because srcmap.type == HOLE.

But then you have ext4 where there is no cow fork, so it will only ever
set iomap_iter::iomap, leaving iomap_iter::srcmap set to the default.
The default srcmap is a HOLE.

So iomap can't distinguish between xfs' speculative cow over a hole
behavior vs. ext4 just being simple.  I wonder if we actually need to
introduce a new iomap type for "pure overwrite"?

The reason I say that that in designing the fuse-iomap uapi, it was a
lot easier to understand the programming model if there was always
explicit read and write mappings being sent back and forth; and a new
type FUSE_IOMAP_TYPE_PURE_OVERWRITE that could be stored in the write
mapping to mean "just look at the read mapping".  If such a beast were
ported to the core iomap code then maybe that would help here?

A hole with an out-of-place mapping needs a flush (or maybe just go find
the pagecache and zero it), whereas a hole with nothing else backing it
clearly doesn't need any action at all.

Does that help?

--D

> The easiest way to deal with this corner case is to flush the
> pagecache to trigger COW remapping into the data fork, and then
> operate on the updated on-disk state. The problem is that ext4
> cannot accommodate a flush from this context due to being a
> transaction deadlock vector.
> 
> Outside of the hole quirk, ext4 can avoid the flush for zero range
> by using the recently introduced folio batch lookup mechanism for
> unwritten mappings. Therefore, take the next logical step and lift
> the hole handling logic into the XFS iomap_begin handler. iomap will
> still flush on unwritten mappings without a folio batch, and XFS
> will flush and retry mapping lookups in the case where it would
> otherwise report a hole with dirty pagecache during a zero range.
> 
> Note that this is intended to be a fairly straightforward lift and
> otherwise not change behavior. Now that the flush exists within XFS,
> follow on patches can further optimize it.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/iomap/buffered-io.c |  2 +-
>  fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 05ff82c5432e..d6de689374c3 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1543,7 +1543,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
>  		     srcmap->type == IOMAP_UNWRITTEN)) {
>  			s64 status;
>  
> -			if (range_dirty) {
> +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
>  				range_dirty = false;
>  				status = iomap_zero_iter_flush_and_stale(&iter);
>  			} else {
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 01833aca37ac..b84c94558cc9 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1734,6 +1734,7 @@ xfs_buffered_write_iomap_begin(
>  	if (error)
>  		return error;
>  
> +restart:
>  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
>  	if (error)
>  		return error;
> @@ -1761,9 +1762,27 @@ xfs_buffered_write_iomap_begin(
>  	if (eof)
>  		imap.br_startoff = end_fsb; /* fake hole until the end */
>  
> -	/* We never need to allocate blocks for zeroing or unsharing a hole. */
> -	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> -	    imap.br_startoff > offset_fsb) {
> +	/* We never need to allocate blocks for unsharing a hole. */
> +	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * We may need to zero over a hole in the data fork if it's fronted by
> +	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> +	 * writeback to remap pending blocks and restart the lookup.
> +	 */
> +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> +		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> +						  offset + count - 1)) {
> +			xfs_iunlock(ip, lockmode);
> +			error = filemap_write_and_wait_range(inode->i_mapping,
> +						offset, offset + count - 1);
> +			if (error)
> +				return error;
> +			goto restart;
> +		}
>  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
>  		goto out_unlock;
>  	}
> -- 
> 2.51.0
> 
> 

