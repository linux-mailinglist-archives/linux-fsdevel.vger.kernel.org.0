Return-Path: <linux-fsdevel+bounces-41129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDAA2B451
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E50016703A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49C22331A;
	Thu,  6 Feb 2025 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn+fcOSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738F222594;
	Thu,  6 Feb 2025 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878257; cv=none; b=XPTzx/re3aFuc4HM9XjxesdIos1qMDjU8E06OCMRa28xy6KZ5F3QuKPByM+Mtkk6AVez7yITGYW8qehvrM8em8AB2DvkyN18h57FnMQgiE4qF8JBnDAnWFd5ZSs4djjeOhVIc7O7T/2cypwIPosE3jFbYHS0PZIRWmDYlkkivhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878257; c=relaxed/simple;
	bh=6zObI4C337nw+w0a2+/LBlBPr3WJ+YI2x3tcPiGCBR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Whi9vAru0RyRHlyJb7MWvM+i5rynKpQbNkcp+Y5YlRmtxXQXa+YLXWtlK2jCn2KHE/n9h8X4EfoMNKtGSr0jmpP35+sHSQ6OdaCssODakuglx10A9aUpYGlct04RCzQON8YxrM2Jfl+xjwOvNS4bQXNUmujY58OET+QsHeRWwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn+fcOSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7B3C4CEDF;
	Thu,  6 Feb 2025 21:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878257;
	bh=6zObI4C337nw+w0a2+/LBlBPr3WJ+YI2x3tcPiGCBR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tn+fcOSsTEzLUCbA+pPMxIZE8ESiMmMJW0s1HmPZVHK+kUrqVWV/IbFgFXj/5T1Jg
	 fk3KFiv6qHk4Rdvsb3aiR9BMS6RzETxLSb53f340I1i7wDmBY8uJz7phpUlPCxf2h7
	 Xd+y9/g9UpgEbgq57gKI/v7HEVDGB/rQYKOCq4+5ku8iHOsrMaBkl+texDH18P0ZAw
	 WtDXO4AksOd9P2L1QAoO9C76XTVvtHepHAfGgSderN4PWCZHw6mk1s7HiopSycmI27
	 39r4Ajqtfdcqpv2UE5RpAN8yQkhz6adPm/m0tyqjrQYPZMNupMMziEFJLSB20hDT43
	 G3rqbA/9s1yxQ==
Date: Thu, 6 Feb 2025 13:44:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 06/10] xfs: iomap CoW-based atomic write support
Message-ID: <20250206214417.GW21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-7-john.g.garry@oracle.com>
 <20250205200517.GZ21808@frogsfrogsfrogs>
 <58f630a4-3e02-451c-bd6e-22427cec5c11@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f630a4-3e02-451c-bd6e-22427cec5c11@oracle.com>

On Thu, Feb 06, 2025 at 11:10:40AM +0000, John Garry wrote:
> On 05/02/2025 20:05, Darrick J. Wong wrote:
> > On Tue, Feb 04, 2025 at 12:01:23PM +0000, John Garry wrote:
> > > In cases of an atomic write occurs for misaligned or discontiguous disk
> > > blocks, we will use a CoW-based method to issue the atomic write.
> > > 
> > > So, for that case, return -EAGAIN to request that the write be issued in
> > > CoW atomic write mode. The dio write path should detect this, similar to
> > > how misaligned regalar DIO writes are handled.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iomap.c | 68 ++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 66 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > index ae3755ed00e6..2c2867d728e4 100644
> > > --- a/fs/xfs/xfs_iomap.c
> > > +++ b/fs/xfs/xfs_iomap.c
> > > @@ -809,9 +809,12 @@ xfs_direct_write_iomap_begin(
> > >   	struct xfs_bmbt_irec	imap, cmap;
> > >   	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
> > >   	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
> > > +	bool			atomic = flags & IOMAP_ATOMIC;
> > >   	int			nimaps = 1, error = 0;
> > >   	bool			shared = false;
> > > +	bool			found = false;
> > >   	u16			iomap_flags = 0;
> > > +	bool			need_alloc;
> > >   	unsigned int		lockmode;
> > >   	u64			seq;
> > > @@ -832,7 +835,7 @@ xfs_direct_write_iomap_begin(
> > >   	 * COW writes may allocate delalloc space or convert unwritten COW
> > >   	 * extents, so we need to make sure to take the lock exclusively here.
> > >   	 */
> > > -	if (xfs_is_cow_inode(ip))
> > > +	if (xfs_is_cow_inode(ip) || atomic)
> > >   		lockmode = XFS_ILOCK_EXCL;
> > >   	else
> > >   		lockmode = XFS_ILOCK_SHARED;
> > > @@ -857,12 +860,73 @@ xfs_direct_write_iomap_begin(
> > >   	if (error)
> > >   		goto out_unlock;
> > > +
> > > +	if (flags & IOMAP_ATOMIC_COW) {
> > > +		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> > > +				&lockmode,
> > > +				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
> > 
> > Weird nit not relate to this patch: Is there ever a case where
> > IS_DAX(inode) and (flags & IOMAP_DAX) disagree?  I wonder if this odd
> > construction could be simplified to:
> > 
> > 	(flags & (IOMAP_DIRECT | IOMAP_DAX))
> 
> I'm not sure. I assume that we always want to convert for DAX, and IOMAP_DAX
> may not be set always for DIO path - but I only see xfs_file_write_iter() ->
> xfs_file_dax_write() ->dax_iomap_rw(xfs_dax_write_iomap_ops), which sets
> IOMAP_DAX in iomap_iter.flags
> 
> > 
> > ?
> > 
> > > +		if (error)
> > > +			goto out_unlock;
> > > +
> > > +		end_fsb = imap.br_startoff + imap.br_blockcount;
> > > +		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
> > > +
> > > +		if (imap.br_startblock != HOLESTARTBLOCK) {
> > > +			seq = xfs_iomap_inode_sequence(ip, 0);
> > > +
> > > +			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags,
> > > +				iomap_flags | IOMAP_F_ATOMIC_COW, seq);
> > > +			if (error)
> > > +				goto out_unlock;
> > > +		}
> > > +		seq = xfs_iomap_inode_sequence(ip, 0);
> > > +		xfs_iunlock(ip, lockmode);
> > > +		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
> > > +					iomap_flags | IOMAP_F_ATOMIC_COW, seq);
> > > +	}
> > 
> > /me wonders if this should be a separate helper so that the main
> > xfs_direct_write_iomap_begin doesn't get even longer... but otherwise
> > the logic in here looks sane.
> 
> I can do that. Maybe some code can be factored out for regular "found cow
> path".
> 
> > 
> > > +
> > > +	need_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
> > > +
> > > +	if (atomic) {
> > > +		/* Use CoW-based method if any of the following fail */
> > > +		error = -EAGAIN;
> > > +
> > > +		/*
> > > +		 * Lazily use CoW-based method for initial alloc of data.
> > > +		 * Check br_blockcount for FSes which do not support atomic
> > > +		 * writes > 1x block.
> > > +		 */
> > > +		if (need_alloc && imap.br_blockcount > 1)
> > > +			goto out_unlock;
> > > +
> > > +		/* Misaligned start block wrt size */
> > > +		if (!IS_ALIGNED(imap.br_startblock, imap.br_blockcount))
> > > +			goto out_unlock;
> > > +
> > > +		/* Discontiguous or mixed extents */
> > > +		if (!imap_spans_range(&imap, offset_fsb, end_fsb))
> > > +			goto out_unlock;
> > > +	}
> > 
> > (Same two comments here.)
> 
> ok
> 
> > 
> > > +
> > >   	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
> > >   		error = -EAGAIN;
> > >   		if (flags & IOMAP_NOWAIT)
> > >   			goto out_unlock;
> > > +		if (atomic) {
> > > +			/* Detect whether we're already covered in a cow fork */
> > > +			error  = xfs_find_trim_cow_extent(ip, &imap, &cmap, &shared, &found);
> > > +			if (error)
> > > +				goto out_unlock;
> > > +
> > > +			if (shared) {
> > > +				error = -EAGAIN;
> > > +				goto out_unlock;
> > 
> > What is this checking?  That something else already created a mapping in
> > the COW fork, so we want to bail out to get rid of it?
> 
> I want to check if some data is shared. In that case, we should unshare.

Why is it necessary to unshare?  Userspace gave us a buffer of new
contents, and we're already prepared to write that out of place and
remap it.

> And I am not sure if that check is sufficient.
> 
> On the buffered write path, we may have something in a CoW fork - in that
> case it should be flushed, right?

Flushed against what?  Concurrent writeback or something?  The directio
setup should have flushed dirty pagecache, so the only things left in
the COW fork are speculative preallocations.  (IOWs, I don't understand
what needs to be flushed or why.)

--D

> 
> Thanks,
> John
> 

