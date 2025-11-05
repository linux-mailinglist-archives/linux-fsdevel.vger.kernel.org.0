Return-Path: <linux-fsdevel+bounces-67150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563EFC366F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AD1D3A2364
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 15:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CE432ED58;
	Wed,  5 Nov 2025 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFKFfDsg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB432ED39
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356533; cv=none; b=fxNGxHSmB2/4snfBsuEl28snwqW9gvOc2cYx+T9TA13LtXR1uXrjdBzW7nI3MF8P/7Yhge6AqCYDsmhbOvwsfSiWpzlNoRHE6TanrBPglssPHmdXQb/TOPFveqHjlVFn4GBhT+1Z/WIKlrQIbj91IuRslwPj9oyInL6Np98JqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356533; c=relaxed/simple;
	bh=02HHu47V5B1AgqVWRsh9u0XB8hvxi9+e0DWhFevvMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWh/ly7ZITsviIASTIAtgAa3pCvCFQWeVU8TvzEacia+Ui9lM3NgMMXEWOx5hTunnCmVB9c9a7IcjOp1gjW4zOZEsUAVonxHQELesYTgUQPA69lvEBfHgtPHmqdncgcPV/2xHH8FsYvto8UWHkYc1exXy7YUCAUP0zPiUtWwadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DFKFfDsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762356530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+5hRDI7SZ0uZHSZPEqeC8t/60M6asZ42vgi6SEFQJt0=;
	b=DFKFfDsggUBkZCTCWgc2I6s4+5IEfaCftPzkAPqcpJKUoeIEyshza7jE5FJ8PXShM7Vum1
	o6eyrnBXAwWSDUFTumDXuzFiPK2j4wB9qgDbdHvGYZbYCMM5pZtWhJ0/7sxlCKUTNI/Uvj
	LvUAToMA1ROvAtnECHNaz5CjTcjeaO4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-d1HSu3OPOqqcJTonuo3msA-1; Wed,
 05 Nov 2025 10:28:49 -0500
X-MC-Unique: d1HSu3OPOqqcJTonuo3msA-1
X-Mimecast-MFC-AGG-ID: d1HSu3OPOqqcJTonuo3msA_1762356528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6747C1956058;
	Wed,  5 Nov 2025 15:28:48 +0000 (UTC)
Received: from bfoster (unknown [10.22.88.135])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3BED180049F;
	Wed,  5 Nov 2025 15:28:47 +0000 (UTC)
Date: Wed, 5 Nov 2025 10:33:16 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <aQtuPFHtzm8-zeqS@bfoster>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
 <20251105003114.GY196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105003114.GY196370@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Nov 04, 2025 at 04:31:14PM -0800, Darrick J. Wong wrote:
> On Thu, Oct 16, 2025 at 03:02:59PM -0400, Brian Foster wrote:
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
> 
> It occurs to me that the situation (unwritten cow mapping, hole in data
> fork) results in iomap_iter::iomap getting the unwritten mapping, and
> iomap_iter::srcmap getting the hole mapping.  iomap_iter_srcmap returns
> iomap_itere::iomap because srcmap.type == HOLE.
> 
> But then you have ext4 where there is no cow fork, so it will only ever
> set iomap_iter::iomap, leaving iomap_iter::srcmap set to the default.
> The default srcmap is a HOLE.
> 
> So iomap can't distinguish between xfs' speculative cow over a hole
> behavior vs. ext4 just being simple.  I wonder if we actually need to
> introduce a new iomap type for "pure overwrite"?
> 

I definitely think we need a better solution here in iomap. The current
iomap/srcmap management/handling is quite confusing. What that solution
is, I'm not sure.

> The reason I say that that in designing the fuse-iomap uapi, it was a
> lot easier to understand the programming model if there was always
> explicit read and write mappings being sent back and forth; and a new
> type FUSE_IOMAP_TYPE_PURE_OVERWRITE that could be stored in the write
> mapping to mean "just look at the read mapping".  If such a beast were
> ported to the core iomap code then maybe that would help here?
> 

I'm not following what this means. Separate read/write mappings for each
individual iomap operation (i.e. "read from here, write to there"), or
separate iomap structures to be used for read ops vs. write ops, or
something else..?

> A hole with an out-of-place mapping needs a flush (or maybe just go find
> the pagecache and zero it), whereas a hole with nothing else backing it
> clearly doesn't need any action at all.
> 
> Does that help?
> 

This kind of sounds like what we're already doing in iomap, so I suspect
I'm missing something on the fuse side...

WRT this patchset, I'm trying to address the underlying problems that
require the flush-a-dirty-hole hack that provides zeroing correctness
for XFS. This needs to be lifted out of iomap because it also causes
problems for ext4, but can be bypassed completely for XFS as well by the
end of the series. The first part is just a straight lift into xfs, but
the next patches replace the flush with use of the folio batch, and
split off the band-aid case down into insert range where this flush was
also indirectly suppressing issues.

For the former, if you look at the last few patches the main reason we
rely on the flush-a-dirty-hole hack is that we don't actually report the
mappings correctly in XFS for zero range with respect to allowable
behavior. We just report a hole if one exists in the data fork. So this
is trying to encode that "COW fork prealloc over data fork hole"
scenario correctly for zero range, and also identify when we need to
consider whether the mapping range is dirty in cache (i.e. unwritten COW
blocks).

So yes in general I think we need to improve on iomap reporting somehow,
but I don't necessarily see how that avoids the need (or desire) to fix
up the iomap_begin logic. I also think it's confusing enough that it
should probably be a separate discussion (I'd probably need to stare at
the fuse-related proposition to grok it).

Ultimately the flush in zero range should go away completely except for
the default/fallback case where the fs supports zero range, fails to
check pagecache itself, and iomap has otherwise detected that the range
over an unwritten mapping was dirty. There has been some discussion over
potentially lifting the batch lookup into iomap as well, but there are
some details that would need to be worked out to determine whether that
can be done safely.

Brian

> --D
> 
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
> > index 05ff82c5432e..d6de689374c3 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1543,7 +1543,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> >  		     srcmap->type == IOMAP_UNWRITTEN)) {
> >  			s64 status;
> >  
> > -			if (range_dirty) {
> > +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
> >  				range_dirty = false;
> >  				status = iomap_zero_iter_flush_and_stale(&iter);
> >  			} else {
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 01833aca37ac..b84c94558cc9 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1734,6 +1734,7 @@ xfs_buffered_write_iomap_begin(
> >  	if (error)
> >  		return error;
> >  
> > +restart:
> >  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> >  	if (error)
> >  		return error;
> > @@ -1761,9 +1762,27 @@ xfs_buffered_write_iomap_begin(
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
> > +			error = filemap_write_and_wait_range(inode->i_mapping,
> > +						offset, offset + count - 1);
> > +			if (error)
> > +				return error;
> > +			goto restart;
> > +		}
> >  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> >  		goto out_unlock;
> >  	}
> > -- 
> > 2.51.0
> > 
> > 
> 


