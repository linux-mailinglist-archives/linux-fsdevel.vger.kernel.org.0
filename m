Return-Path: <linux-fsdevel+bounces-67396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCEC3DDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802413A59A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2B2DA76C;
	Thu,  6 Nov 2025 23:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY3rlzsz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27429B77C;
	Thu,  6 Nov 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471930; cv=none; b=O8C/B4jeGGf4VyiBeu50JTYNEpyejSs4AkcpHsb/JEarRktN0x7X6si5Rn7Azm6o/VSL5vdzh+L8xSByWV3dDnztNAdN/VER45CrTDEX9Aw5qau16QNxd/42vxyYKaKxeI64EzSNE0W2LHY08/hs2aS251I4TQKxrW+FNGQ/m5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471930; c=relaxed/simple;
	bh=kwFIXGmDTz0KkgPWThrn6kIiD9F0ge+/uB7o9DvzaIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAvBdFkjy5+Hfkyx36x4gXtfrcWrL8rHY5OxzKxtAscjtKaDca2xmcwsdVoS3mlXoJ33kWdjy04+LSbuAnUbesQqwkhcYRgDs2OZvqBAyo1a99Uy3V8HxIQL0iJFMWIiZ+RxJoIExel2NiPrrmSmdjAKvDtVqJUP/jXT3yDm8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY3rlzsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828E3C113D0;
	Thu,  6 Nov 2025 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762471929;
	bh=kwFIXGmDTz0KkgPWThrn6kIiD9F0ge+/uB7o9DvzaIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PY3rlzszd8HeovWoMEwil15yWUj3nJDd+KAARRV982DSu1LzqHHuCN2vJRwGlVI6e
	 dvV50K5HmfMNLwM0ezVOkZwEDsyJnHnC1ySS5BFlgFqZOUUP3Jjk+em3N6yrY4qM+g
	 IAbmdVTG92RzUCp10JnLVPcpxKyz/w6pZchu23cH6Wxpo0ttNXpAnM76csI9XIirEa
	 hvv5684hKL7+jUySNsUap90DekGbtFWTZuNB63wSBfpnuLz6ahWGzLpJWI+4bUoejG
	 2ftamriKytvKIY30zqOCohVaLkHbWmmzbkAEpdYxrsutGrYzq9bpsxp8+4XsOxms/d
	 hk4HV08MwlVRA==
Date: Thu, 6 Nov 2025 15:32:08 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <20251106233208.GU196362@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
 <20251105003114.GY196370@frogsfrogsfrogs>
 <aQtuPFHtzm8-zeqS@bfoster>
 <20251105222350.GO196362@frogsfrogsfrogs>
 <aQzEQtynNsJLdLcD@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzEQtynNsJLdLcD@bfoster>

On Thu, Nov 06, 2025 at 10:52:34AM -0500, Brian Foster wrote:
> On Wed, Nov 05, 2025 at 02:23:50PM -0800, Darrick J. Wong wrote:
> > On Wed, Nov 05, 2025 at 10:33:16AM -0500, Brian Foster wrote:
> > > On Tue, Nov 04, 2025 at 04:31:14PM -0800, Darrick J. Wong wrote:
> > > > On Thu, Oct 16, 2025 at 03:02:59PM -0400, Brian Foster wrote:
> > > > > iomap zero range has a wart in that it also flushes dirty pagecache
> > > > > over hole mappings (rather than only unwritten mappings). This was
> > > > > included to accommodate a quirk in XFS where COW fork preallocation
> > > > > can exist over a hole in the data fork, and the associated range is
> > > > > reported as a hole. This is because the range actually is a hole,
> > > > > but XFS also has an optimization where if COW fork blocks exist for
> > > > > a range being written to, those blocks are used regardless of
> > > > > whether the data fork blocks are shared or not. For zeroing, COW
> > > > > fork blocks over a data fork hole are only relevant if the range is
> > > > > dirty in pagecache, otherwise the range is already considered
> > > > > zeroed.
> > > > 
> > > > It occurs to me that the situation (unwritten cow mapping, hole in data
> > > > fork) results in iomap_iter::iomap getting the unwritten mapping, and
> > > > iomap_iter::srcmap getting the hole mapping.  iomap_iter_srcmap returns
> > > > iomap_itere::iomap because srcmap.type == HOLE.
> > > > 
> > > > But then you have ext4 where there is no cow fork, so it will only ever
> > > > set iomap_iter::iomap, leaving iomap_iter::srcmap set to the default.
> > > > The default srcmap is a HOLE.
> > > > 
> > > > So iomap can't distinguish between xfs' speculative cow over a hole
> > > > behavior vs. ext4 just being simple.  I wonder if we actually need to
> > > > introduce a new iomap type for "pure overwrite"?
> > > > 
> > > 
> > > I definitely think we need a better solution here in iomap. The current
> > > iomap/srcmap management/handling is quite confusing. What that solution
> > > is, I'm not sure.
> > > 
> > > > The reason I say that that in designing the fuse-iomap uapi, it was a
> > > > lot easier to understand the programming model if there was always
> > > > explicit read and write mappings being sent back and forth; and a new
> > > > type FUSE_IOMAP_TYPE_PURE_OVERWRITE that could be stored in the write
> > > > mapping to mean "just look at the read mapping".  If such a beast were
> > > > ported to the core iomap code then maybe that would help here?
> > > > 
> > > 
> > > I'm not following what this means. Separate read/write mappings for each
> > > individual iomap operation (i.e. "read from here, write to there"), or
> > > separate iomap structures to be used for read ops vs. write ops, or
> > > something else..?
> > 
> > "read from here, write to there".
> > 
> 
> Ok..
> 
> > First, we move IOMAP_HOLE up one:
> > 
> > #define IOMAP_NULL	0	/* no mapping here at all */
> > #define IOMAP_HOLE	1	/* no blocks allocated, need allocation */
> > #define IOMAP_DELALLOC	2	/* delayed allocation blocks */
> > ...
> > 
> > and do some renaming:
> > 
> > struct iomap_iter {
> > 	struct inode *inode;
> > 	loff_t pos;
> > 	u64 len;
> > 	loff_t iter_start_pos;
> > 	int status;
> > 	unsigned flags;
> > 	struct iomap write_map;
> > 	struct iomap read_map;
> > 	void *private;
> > };
> > 
> > Then we change the interface so that ->iomap_begin always sets read_map
> > to a mapping from which file data can be read, and write_map is always
> > set to a mapping into which file data can be written.  If a filesystem
> > doesn't support out of place writes, then it can ignore write_map and
> > write_map.type will be IOMAP_NULL.
> > 
> > (Obviously the fs always has to supply a read mapping)
> > 
> > The read operations (e.g. readahead, fiemap) only ever pay attention to
> > what the filesystem supplies in iomap_iter::read_map.
> > 
> > An unaligned pagecache write to an uncached region uses the read mapping
> > to pull data into the pagecache.  For writeback, we'd use the write
> > mapping if it's non-null, or else the read mapping.
> > 
> 
> Or perhaps let the read/write mappings overlap? It's not clear to me if
> that's better or worse. ;P
> 
> > This might not move the needle much wrt to fixing your problem, but at
> > least it eliminates the weirdness around "@iomap is for reads except
> > when you're doing a write but you have to do a read *and* @srcmap isn't
> > a hole".
> > 
> 
> Yeah.. it might be reaching a pedantic level, but to me having a couple
> mappings that say "you can read from this range, write to that range,
> and they might be the same" is more clear than the srcmap/dstmap/maybe
> both logic we have today.
> 
> I'd be a little concerned about having similar complexity along the
> lines of "read from here, write to there, except maybe sometimes write
> to where you read from" in iomap if we could just make the logic dead
> simple/consistent and give the fs helpers to fill things out properly.
> But again this is my first exposure to the idea and so I'm thinking out
> loud and probably missing some details..

That's basically it.  I thought about requiring the fuse server to fill
out both read and write iomaps, but decided the OVERWRITE_ONLY way was
easier because libfuse could initialize write_iomap to OVERWRITE_ONLY
which would be a "sane" default.

A harder question is: what would filesystems put in write_map for a pure
read?  They could leave it at the default (null mapping) and the kernel
wouldn't pay attention to it.

> > > > A hole with an out-of-place mapping needs a flush (or maybe just go find
> > > > the pagecache and zero it), whereas a hole with nothing else backing it
> > > > clearly doesn't need any action at all.
> > > > 
> > > > Does that help?
> > > > 
> > > 
> > > This kind of sounds like what we're already doing in iomap, so I suspect
> > > I'm missing something on the fuse side...
> > > 
> > > WRT this patchset, I'm trying to address the underlying problems that
> > > require the flush-a-dirty-hole hack that provides zeroing correctness
> > > for XFS. This needs to be lifted out of iomap because it also causes
> > > problems for ext4, but can be bypassed completely for XFS as well by the
> > > end of the series. The first part is just a straight lift into xfs, but
> > > the next patches replace the flush with use of the folio batch, and
> > > split off the band-aid case down into insert range where this flush was
> > > also indirectly suppressing issues.
> > > 
> > > For the former, if you look at the last few patches the main reason we
> > > rely on the flush-a-dirty-hole hack is that we don't actually report the
> > > mappings correctly in XFS for zero range with respect to allowable
> > > behavior. We just report a hole if one exists in the data fork. So this
> > > is trying to encode that "COW fork prealloc over data fork hole"
> > > scenario correctly for zero range, and also identify when we need to
> > > consider whether the mapping range is dirty in cache (i.e. unwritten COW
> > > blocks).
> > 
> > Ahh, ok.  I think I get what you're saying now -- instead of doddering
> > around in iomap to make it know the difference between "prealloc in cow,
> > hole in data fork" vs. "hole in data fork", you'd rather try to
> > accumulate folios in the folio_batch, hand that to iomap, and then iomap
> > will just zero folios in the batch.  No need for the preflush or deep
> > surgery to core code.
> > 
> 
> Yeah, I don't want to preclude potential mapping improvements, but I'm
> also not trying to solve that here just for zero range.

<nod> The problem fixed by each of our patchsets is not a sidequest for
the other's. ;)

I think your patchset is fine, but remind me -- what happens if you
can't fill the whole folio batch?  iomap just calls us back to get the
rest of the mapping and more folios?  I think that's sufficient to fix
the problem.

> I suppose we could consider changing this particular case to also report
> the cow mapping (similar to buffered write IIRC) and maybe that would
> reduce some quirkiness, but I'd have to think harder and test that out.
> It might probably still be a separate patch just because I'm hesitant to
> change too much at once and hurt bisectability.

It never hurts to tack the experimental patches on the end of series, if
it would help answer hypothetical questions.  Though those ought to be
marked as such.

--D

> > > So yes in general I think we need to improve on iomap reporting somehow,
> > > but I don't necessarily see how that avoids the need (or desire) to fix
> > > up the iomap_begin logic. I also think it's confusing enough that it
> > > should probably be a separate discussion (I'd probably need to stare at
> > > the fuse-related proposition to grok it).
> > > 
> > > Ultimately the flush in zero range should go away completely except for
> > > the default/fallback case where the fs supports zero range, fails to
> > > check pagecache itself, and iomap has otherwise detected that the range
> > > over an unwritten mapping was dirty. There has been some discussion over
> > > potentially lifting the batch lookup into iomap as well, but there are
> > > some details that would need to be worked out to determine whether that
> > > can be done safely.
> > 
> > <nod> ok I'll keep reading this series.
> > 
> 
> Thanks.
> 
> Brian
> 
> > --D
> > 
> > > Brian
> > > 
> > > > --D
> > > > 
> > > > > The easiest way to deal with this corner case is to flush the
> > > > > pagecache to trigger COW remapping into the data fork, and then
> > > > > operate on the updated on-disk state. The problem is that ext4
> > > > > cannot accommodate a flush from this context due to being a
> > > > > transaction deadlock vector.
> > > > > 
> > > > > Outside of the hole quirk, ext4 can avoid the flush for zero range
> > > > > by using the recently introduced folio batch lookup mechanism for
> > > > > unwritten mappings. Therefore, take the next logical step and lift
> > > > > the hole handling logic into the XFS iomap_begin handler. iomap will
> > > > > still flush on unwritten mappings without a folio batch, and XFS
> > > > > will flush and retry mapping lookups in the case where it would
> > > > > otherwise report a hole with dirty pagecache during a zero range.
> > > > > 
> > > > > Note that this is intended to be a fairly straightforward lift and
> > > > > otherwise not change behavior. Now that the flush exists within XFS,
> > > > > follow on patches can further optimize it.
> > > > > 
> > > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > > > ---
> > > > >  fs/iomap/buffered-io.c |  2 +-
> > > > >  fs/xfs/xfs_iomap.c     | 25 ++++++++++++++++++++++---
> > > > >  2 files changed, 23 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > > index 05ff82c5432e..d6de689374c3 100644
> > > > > --- a/fs/iomap/buffered-io.c
> > > > > +++ b/fs/iomap/buffered-io.c
> > > > > @@ -1543,7 +1543,7 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > > > >  		     srcmap->type == IOMAP_UNWRITTEN)) {
> > > > >  			s64 status;
> > > > >  
> > > > > -			if (range_dirty) {
> > > > > +			if (range_dirty && srcmap->type == IOMAP_UNWRITTEN) {
> > > > >  				range_dirty = false;
> > > > >  				status = iomap_zero_iter_flush_and_stale(&iter);
> > > > >  			} else {
> > > > > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > > > > index 01833aca37ac..b84c94558cc9 100644
> > > > > --- a/fs/xfs/xfs_iomap.c
> > > > > +++ b/fs/xfs/xfs_iomap.c
> > > > > @@ -1734,6 +1734,7 @@ xfs_buffered_write_iomap_begin(
> > > > >  	if (error)
> > > > >  		return error;
> > > > >  
> > > > > +restart:
> > > > >  	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
> > > > >  	if (error)
> > > > >  		return error;
> > > > > @@ -1761,9 +1762,27 @@ xfs_buffered_write_iomap_begin(
> > > > >  	if (eof)
> > > > >  		imap.br_startoff = end_fsb; /* fake hole until the end */
> > > > >  
> > > > > -	/* We never need to allocate blocks for zeroing or unsharing a hole. */
> > > > > -	if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
> > > > > -	    imap.br_startoff > offset_fsb) {
> > > > > +	/* We never need to allocate blocks for unsharing a hole. */
> > > > > +	if ((flags & IOMAP_UNSHARE) && imap.br_startoff > offset_fsb) {
> > > > > +		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> > > > > +		goto out_unlock;
> > > > > +	}
> > > > > +
> > > > > +	/*
> > > > > +	 * We may need to zero over a hole in the data fork if it's fronted by
> > > > > +	 * COW blocks and dirty pagecache. To make sure zeroing occurs, force
> > > > > +	 * writeback to remap pending blocks and restart the lookup.
> > > > > +	 */
> > > > > +	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
> > > > > +		if (filemap_range_needs_writeback(inode->i_mapping, offset,
> > > > > +						  offset + count - 1)) {
> > > > > +			xfs_iunlock(ip, lockmode);
> > > > > +			error = filemap_write_and_wait_range(inode->i_mapping,
> > > > > +						offset, offset + count - 1);
> > > > > +			if (error)
> > > > > +				return error;
> > > > > +			goto restart;
> > > > > +		}
> > > > >  		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
> > > > >  		goto out_unlock;
> > > > >  	}
> > > > > -- 
> > > > > 2.51.0
> > > > > 
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 
> 

