Return-Path: <linux-fsdevel+bounces-42597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260CCA4490D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0530880DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B169B19AD86;
	Tue, 25 Feb 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1hDAtND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761E195B1A;
	Tue, 25 Feb 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505649; cv=none; b=g9aN5ftgnHbWhiRkxaHmfvrS3UW3/RsuNOPKxhUHHYzI4IIHw5g7PjXnCIQE/R6/B4y2zf7dDayuKaF3DsPSJJT54y1ACe/Q5igH8cYUn0SDlCzfED8fDv7p1bIhlnwbUtlTNF+5P9NKQirWqYbVMz+Dm57cOpCa5Eo543H8BAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505649; c=relaxed/simple;
	bh=9uuqhp6RkiJhtMT5zR1Cc/fblk44OMPAt2hYASfkTws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw+mszZdnWV2GQNX/uNEAtwIP/uEGzAoAZyz8Q9NZqB1qGeWIdABwEQcruqGs48Ra/D+N7hX7v904PGcFRHDInQD6oUOdHDKEZPa2LXrN5n1tIVGNN5LV8QqFXHpsr+pUEOkrh8ucG1z4Ply2rc7dkdiQIB+wuDi/p6cVGxAOdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1hDAtND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661EDC4CEDD;
	Tue, 25 Feb 2025 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740505648;
	bh=9uuqhp6RkiJhtMT5zR1Cc/fblk44OMPAt2hYASfkTws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1hDAtNDBKcWq3l+2TtaxUcY1SdWwI+2HJ1SKw/KP9e95d1ebfzEE+PS5uUcsppOD
	 PArlM2tieL8GgmNdsXRuORZP3wYf1fJFwsHLgI4xZa+6z7+Z/nLolYmDOZeIZXPA/d
	 9wOXCEaUF/1iEfJ+q8NN01MoZTtmFhLSJaWdyO3zrxuO0/QWAS5RPX4j9tr+k2ACOT
	 myVchm/lwOyLaxEEWD9KTosuLud9sEKVnamSaVyEy+Bu04fYAW6YSQJMdsVGY2WoMJ
	 sC1fYYirgvZhO/JEIQM2h9RemKV0nA6z2WMeVrbE0dJ5HbjSBuJ0R4Jhx38gBlrAf1
	 5uPAb/boF6YRg==
Date: Tue, 25 Feb 2025 09:47:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 07/11] xfs: iomap CoW-based atomic write support
Message-ID: <20250225174727.GF6242@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-8-john.g.garry@oracle.com>
 <20250224201333.GD21808@frogsfrogsfrogs>
 <4e78abd2-4f84-4002-b84c-6f90e2f869a8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e78abd2-4f84-4002-b84c-6f90e2f869a8@oracle.com>

On Tue, Feb 25, 2025 at 11:06:50AM +0000, John Garry wrote:
> On 24/02/2025 20:13, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2025 at 01:56:15PM +0000, John Garry wrote:
> > > In cases of an atomic write occurs for misaligned or discontiguous disk
> > > blocks, we will use a CoW-based method to issue the atomic write.
> > > 
> > > So, for that case, return -EAGAIN to request that the write be issued in
> > > CoW atomic write mode. The dio write path should detect this, similar to
> > > how misaligned regalar DIO writes are handled.
> > > 
> > > For normal HW-based mode, when the range which we are atomic writing to
> > > covers a shared data extent, try to allocate a new CoW fork. However, if
> > > we find that what we allocated does not meet atomic write requirements
> > > in terms of length and alignment, then fallback on the CoW-based mode
> > > for the atomic write.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iomap.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 69 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index ab79f0080288..c5ecfafbba60 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -795,6 +795,23 @@ imap_spans_range(
> > >   	return true;
> > >   }
> > > +static bool
> > > +imap_range_valid_for_atomic_write(
> > 
> > xfs_bmap_valid_for_atomic_write()
> 
> I'm ok with this.
> 
> But we do have other private functions without "xfs" prefix - like
> imap_needs_cow(), so a bit inconsistent to begin with.

Yeah, others prefer shorter names but I try at least to maintain
consistent prefixes for namespacing.

> > 
> > > +	struct xfs_bmbt_irec	*imap,
> > > +	xfs_fileoff_t		offset_fsb,
> > > +	xfs_fileoff_t		end_fsb)
> > > +{
> > > +	/* Misaligned start block wrt size */
> > > +	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
> > > +		return false;
> > > +
> > > +	/* Discontiguous or mixed extents */
> > > +	if (!imap_spans_range(imap, offset_fsb, end_fsb))
> > > +		return false;
> > > +
> > > +	return true;
> > > +}
> > > +
> > >   static int
> > >   xfs_direct_write_iomap_begin(
> > >   	struct inode		*inode,
> > > @@ -809,12 +826,20 @@ xfs_direct_write_iomap_begin(
> > >   	struct xfs_bmbt_irec	imap, cmap;
> > >   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > >   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> > > +	bool			atomic_cow = flags & IOMAP_ATOMIC_COW;
> > > +	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
> > >   	int			nimaps = 1, error = 0;
> > >   	bool			shared = false;
> > >   	u16			iomap_flags = 0;
> > > +	xfs_fileoff_t		orig_offset_fsb;
> > > +	xfs_fileoff_t		orig_end_fsb;
> > > +	bool			needs_alloc;
> > >   	unsigned int		lockmode;
> > >   	u64			seq;
> > > +	orig_offset_fsb = offset_fsb;
> > 
> > When does offset_fsb change?
> 
> It doesn't, so this is not really required.
> 
> > 
> > > +	orig_end_fsb = end_fsb;
> > 
> > Set this in the variable declaration?
> 
> ok
> 
> > 
> > > +
> > >   	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
> > >   	if (xfs_is_shutdown(mp))
> > > @@ -832,7 +857,7 @@ xfs_direct_write_iomap_begin(
> > >   	 * COW writes may allocate delalloc space or convert unwritten COW
> > >   	 * extents, so we need to make sure to take the lock exclusively here.
> > >   	 */
> > > -	if (xfs_is_cow_inode(ip))
> > > +	if (xfs_is_cow_inode(ip) || atomic_cow)
> > >   		lockmode = XFS_ILOCK_EXCL;
> > >   	else
> > >   		lockmode = XFS_ILOCK_SHARED;
> > > @@ -857,6 +882,22 @@ xfs_direct_write_iomap_begin(
> > >   	if (error)
> > >   		goto out_unlock;
> > > +	if (flags & IOMAP_ATOMIC_COW) {
> > 
> > 	if (atomic_cow) ?
> > 
> > Or really, atomic_sw?
> 
> Yes, will change.
> 
> > 
> > > +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> > > +				&lockmode,
> > > +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
> > > +		/*
> > > +		 * Don't check @shared. For atomic writes, we should error when
> > > +		 * we don't get a CoW fork.
> > 
> > "Get a CoW fork"?  What does that mean?  The cow fork should be
> > automatically allocated when needed, right?  Or should this really read
> > "...when we don't get a COW mapping"?
> 
> ok, I can change as you suggest
> 
> > 
> > > +		 */
> > > +		if (error)
> > > +			goto out_unlock;
> > > +
> > > +		end_fsb = imap.br_startoff + imap.br_blockcount;
> > > +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
> > > +		goto out_found_cow;
> > > +	}
> > 
> > Can this be a separate ->iomap_begin (and hence iomap ops)?  I am trying
> > to avoid the incohesion (still) plaguing most of the other iomap users.
> 
> I can try, and would then need to try to factor out what would be much
> duplicated code.

<nod> I think it's pretty straightforward:

xfs_direct_cow_write_iomap_begin()
{
	ASSERT(flags & IOMAP_WRITE);
	ASSERT(flags & IOMAP_DIRECT);
	ASSERT(flags & IOMAP_ATOMIC_SW);

	if (xfs_is_shutdown(mp))
		return -EIO;

	/*
	 * Writes that span EOF might trigger an IO size update on
	 * completion, so consider them to be dirty for the purposes of
	 * O_DSYNC even if there is no other metadata changes pending or
	 * have been made here.
	 */
	if (offset + length > i_size_read(inode))
		iomap_flags |= IOMAP_F_DIRTY;

	lockmode = XFS_ILOCK_EXCL;
	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
	if (error)
		return error;

	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb,
			&imap, &nimaps, 0);
	if (error)
		goto out_unlock;

	error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
			&lockmode, true, true);
	if (error)
		goto out_unlock;

	endoff = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
	trace_xfs_iomap_found(ip, offset, endoff - offset, XFS_COW_FORK,
			&cmap);
	if (imap.br_startblock != HOLESTARTBLOCK) {
		seq = xfs_iomap_inode_sequence(ip, 0);
		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
				seq);
		if (error)
			goto out_unlock;
	}
	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
	xfs_iunlock(ip, lockmode);
	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
			IOMAP_F_SHARED, seq);

out_unlock:
	if (lockmode)
		xfs_iunlock(ip, lockmode);
	return error;
}

--D

> > > +
> > >   	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
> > >   		error = -EAGAIN;
> > >   		if (flags & IOMAP_NOWAIT)
> > > @@ -868,13 +909,38 @@ xfs_direct_write_iomap_begin(
> > >   				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
> > >   		if (error)
> > >   			goto out_unlock;
> > > -		if (shared)
> > > +		if (shared) {
> > > +			if (atomic_hw &&
> > > +			    !imap_range_valid_for_atomic_write(&cmap,
> > > +					orig_offset_fsb, orig_end_fsb)) {
> > > +				error = -EAGAIN;
> > > +				goto out_unlock;
> > > +			}
> > >   			goto out_found_cow;
> > > +		}
> > >   		end_fsb = imap.br_startoff + imap.br_blockcount;
> > >   		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
> > >   	}
> > > -	if (imap_needs_alloc(inode, flags, &imap, nimaps))
> > > +	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> > > +
> > > +	if (atomic_hw) {
> > > +		error = -EAGAIN;
> > > +		/*
> > > +		 * Use CoW method for when we need to alloc > 1 block,
> > > +		 * otherwise we might allocate less than what we need here and
> > > +		 * have multiple mappings.
> > > +		*/
> > > +		if (needs_alloc && orig_end_fsb - orig_offset_fsb > 1)
> > > +			goto out_unlock;
> > > +
> > > +		if (!imap_range_valid_for_atomic_write(&imap, orig_offset_fsb,
> > > +						orig_end_fsb)) {
> > 
> > You only need to indent by two more tabs for a continuation line.
> 
> ok
> 
> Thanks,
> John
> 

