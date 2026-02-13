Return-Path: <linux-fsdevel+bounces-77151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0oDpJQj2nnPgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:25:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC15137EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 17:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC6D3011770
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7734E26E6E1;
	Fri, 13 Feb 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/1VxxWF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050562459FD;
	Fri, 13 Feb 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999899; cv=none; b=SPJKwnCqngsXVXamUfzDKNJxnoWDPowpEhjqXbfpqu/6UYXkZj+xR/JyxM6b3x8GHwtBR8eYI4zI4SsDCsPxlhFAbmk0W/8ySZnmRai4o+N7vv+Lx8VINwoagUvDoGVBK0gk7yoJIWgEYHypJgKsQBeKceZI4dvHlefhySEeadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999899; c=relaxed/simple;
	bh=kwsicxk0t02G079LmEmHH+BZZGn76QP0Y73QpA4Vh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOxOtfWzmEG4oqaJhYUTIW/D6lb+dpRkkLZNE1etJfF/I6S4SkV5Mkem3yTbfUS7DW4PpPOxr5i49MQIyX4cHCyJyA6TSD/zb0p7d3s/DHu9V6aKkem59R8az/uPpae3CCirYDZlcGr1M0MqYNOiNDxO4kjjs8Zt9U67NWKQoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/1VxxWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ABEC116C6;
	Fri, 13 Feb 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770999898;
	bh=kwsicxk0t02G079LmEmHH+BZZGn76QP0Y73QpA4Vh2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/1VxxWFUBxmCE5cPbqQPvU7xXhEdFurJIkc5qcF1ykBB/FdcBOs79bBfswY7UO0D
	 zwZYMsV2uKRbIConToUacSfC5wJ/TAtghmMznbRGSSAzT/AH3pM1lGCIemEKWmBNHu
	 PDDS1WFCU7HI8YIyzao3IZ7fJA6kMCu9SuEN9Arcq2uNsKbAh02UiTxmC0nKeT0WlW
	 btgKsCol7lsM/xX3Xy1z5C3r26zzXhmplRFKFYA/HHRYSuC28Iu0nLl60TUYSrK9RI
	 2gaP4xWMD3Wj/WrGIPxVhgVtQZMtIImeFnmUjM6Z+5yPF+/6511UFUpTmMA5T0QZBu
	 8ofCr/IS7IcEg==
Date: Fri, 13 Feb 2026 08:24:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <20260213162457.GG7712@frogsfrogsfrogs>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-2-bfoster@redhat.com>
 <af7b989f430a8b464f48a8404b4f60a5fb4a189f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af7b989f430a8b464f48a8404b4f60a5fb4a189f.camel@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77151-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDC15137EE9
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 03:50:07PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2026-01-29 at 10:50 -0500, Brian Foster wrote:
> > iomap zero range has a wart in that it also flushes dirty pagecache
> > over hole mappings (rather than only unwritten mappings). This was
> > included to accommodate a quirk in XFS where COW fork preallocation
> > can exist over a hole in the data fork, and the associated range is
> > reported as a hole. This is because the range actually is a hole,
> > but XFS also has an optimization where if COW fork blocks exist for
> > a range being written to, those blocks are used regardless of
> > whether the data fork blocks are shared or not. For zeroing, COW
> > fork blocks over a data fork hole are only relevant if the range is
> > dirty in pagecache, otherwise the range is already considered
> > zeroed.
> > 
> > The easiest way to deal with this corner case is to flush the
> > pagecache to trigger COW remapping into the data fork, and then
> > operate on the updated on-disk state. The problem is that ext4
> > cannot accommodate a flush from this context due to being a
> > transaction deadlock vector.
> > 
> > Outside of the hole quirk, ext4 can avoid the flush for zero range
> > by using the recently introduced folio batch lookup mechanism for
> > unwritten mappings. Therefore, take the next logical step and lift
> > the hole handling logic into the XFS iomap_begin handler. iomap will
> > still flush on unwritten mappings without a folio batch, and XFS
> > will flush and retry mapping lookups in the case where it would
> > otherwise report a hole with dirty pagecache during a zero range.
> > 
> > Note that this is intended to be a fairly straightforward lift and
> > otherwise not change behavior. Now that the flush exists within XFS,
> > follow on patches can further optimize it.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c |  2 +-
> >  fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 6beb876658c0..807384d72311 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1620,7 +1620,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  		     srcmap->type == IOMAP_UNWRITTEN)) {
> >  			s64 status;
> >  
> > -			if (range_dirty) {
> > +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
> >  				range_dirty = false;
> >  				status = iomap_zero_iter_flush_and_stale(&iter);
> >  			} else {
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 37a1b33e9045..896d0dd07613 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1790,6 +1790,7 @@ xfs_buffered_write_iomap_begin(
> >  	if (error)
> >  		return error;
> >  
> > +restart:
> >  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> >  	if (error)
> >  		return error;
> > @@ -1817,9 +1818,27 @@ xfs_buffered_write_iomap_begin(
> >  	if (eof)
> >  		imap.br_startoff = end_fsb; /* fake hole until the end */
> >  
> > -	/* We never need to allocate blocks for zeroing or unsharing a hole. */
> > -	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> > -	    imap.br_startoff > offset_fsb) {
> > +	/* We never need to allocate blocks for unsharing a hole. */
> > +	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> > +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> > +		goto out_unlock;
> > +	}
> > +
> > +	/*
> > +	 * We may need to zero over a hole in the data fork if it's fronted by
> > +	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> > +	 * writeback to remap pending blocks and restart the lookup.
> > +	 */
> > +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> > +		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> > +						  offset + count - 1)) {
> > +			xfs_iunlock(ip, lockmode);
> 
> I am a bit new to this section of the code - so a naive question:
> Why do we need to unlock the inode here? Shouldn't the mappings be thread safe while the write/flush
> is going on?

Writeback takes XFS_ILOCK, which we currently hold here (possibly in
exclusive mode) so we must drop it to write(back) and wait.

--D

> --NR
> > +			error = filemap_write_and_wait_range(inode->i_mapping,
> > +						offset, offset + count - 1);
> > +			if (error)
> > +				return error;
> > +			goto restart;
> > +		}
> >  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> >  		goto out_unlock;
> >  	}
> 
> 

