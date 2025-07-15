Return-Path: <linux-fsdevel+bounces-54986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42FB06194
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC711C24A23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457819F464;
	Tue, 15 Jul 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkhtV5n/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3F13AD1C;
	Tue, 15 Jul 2025 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590253; cv=none; b=dVMAgwZgut/i/7P4aeM/I23x4h1v6Nkv2oV9wy8bUVLwZRjjtqgbgKGJOgvbF2vhaNsvegio13H/5sliJ+XbloDDIS79rjQA2wWDCkE3mSN/nrz1E7piZRoU5pNJtMwHVuqgS6a2LTAjzlWUrtmHNbPAlrDV0NiRHuhDQgKgva0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590253; c=relaxed/simple;
	bh=4xv5/UPT8nXhMWZuxQNTUwAJ/ZNAv+qsk6EDFikuCRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jt4t+CQzBg6yNkmQ0aBcFtDtVg2zdBTkf4iYhmKbyzh37+f8TNNwsSFkvm4Bex+wQcnE5J8WTBJdogvJNyyyuZhV3hT8uwg9VWsucDWmJ1CT15NMLrlpY6WnssEgyXSsr/F52P7U9efPDaEiInQpOvD1ndYlZEN2nyi5TXwWK/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkhtV5n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87E8C4CEE3;
	Tue, 15 Jul 2025 14:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752590253;
	bh=4xv5/UPT8nXhMWZuxQNTUwAJ/ZNAv+qsk6EDFikuCRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkhtV5n/j7MM3TN5WebjgziDEpogVIRekHXMAFmCH4qnPaAQhc44rxsI8QOr0JSmJ
	 ZoLT7k7cseFjT2FcAnSsu4oTRaDhp/JrhAKoxbyhZj9VRpPGGSp5tUFLrwMU0g7xCt
	 PLhoJYuX1a/ySv0n7UA9mrOJ4wmYWtMiLTKy6fMlkk0cIJ2vdme+dnW38s81S7PaVR
	 ZRlXhrDRe596qHchhv3nbtsGAAl7L/y3rYOce0M9SCGq4dK9e7vlVfmjDU1IBHxTBU
	 iD8fXYQyMl+kzM2DLKOcCwt3rCHW61e1kHKzE3zfBIM6wFP5zZkpHDleTpJRyGAdhn
	 bydIIM1Jgx9JA==
Date: Tue, 15 Jul 2025 07:37:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 6/7] iomap: remove old partial eof zeroing optimization
Message-ID: <20250715143733.GO2672029@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-7-bfoster@redhat.com>
 <20250715053417.GR2672049@frogsfrogsfrogs>
 <aHZLZid5gggmDD09@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZLZid5gggmDD09@bfoster>

On Tue, Jul 15, 2025 at 08:36:54AM -0400, Brian Foster wrote:
> On Mon, Jul 14, 2025 at 10:34:17PM -0700, Darrick J. Wong wrote:
> > On Mon, Jul 14, 2025 at 04:41:21PM -0400, Brian Foster wrote:
> > > iomap_zero_range() optimizes the partial eof block zeroing use case
> > > by force zeroing if the mapping is dirty. This is to avoid frequent
> > > flushing on file extending workloads, which hurts performance.
> > > 
> > > Now that the folio batch mechanism provides a more generic solution
> > > and is used by the only real zero range user (XFS), this isolated
> > > optimization is no longer needed. Remove the unnecessary code and
> > > let callers use the folio batch or fall back to flushing by default.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Heh, I was staring at this last Friday chasing fuse+iomap bugs in
> > fallocate zerorange and straining to remember what this does.
> > Is this chunk still needed if the ->iomap_begin implementation doesn't
> > (or forgets to) grab the folio batch for iomap?
> > 
> 
> No, the hunk removed by this patch is just an optimization. The fallback
> code here flushes the range if it's dirty and retries the lookup (i.e.
> picking up unwritten conversions that were pending via dirty pagecache).
> That flush logic caused a performance regression in a particular
> workload, so this was introduced to mitigate that regression by just
> doing the zeroing for the first block or so if the folio is dirty. [1]
> 
> The reason for removing it is more just for maintainability. XFS is
> really the only user here and it is changing over to the more generic
> batch mechanism, which effectively provides the same optimization, so
> this basically becomes dead/duplicate code. If an fs doesn't use the
> batch mechanism it will just fall back to the flush and retry approach,
> which can be slower but is functionally correct.

Oh ok thanks for the reminder.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

> > My bug turned out to be a bug in my fuse+iomap design -- with the way
> > iomap_zero_range does things, you have to flush+unmap, punch the range
> > and zero the range.  If you punch and realloc the range and *then* try
> > to zero the range, the new unwritten extents cause iomap to miss dirty
> > pages that fuse should've unmapped.  Ooops.
> > 
> 
> I don't quite follow. How do you mean it misses dirty pages?

Oops, I misspoke, the folios were clean.  Let's say the pagecache is
sparsely populated with some folios for written space:

-------fffff-------fffffff
wwwwwwwwwwwwwwwwwwwwwwwwww

Now you tell it to go zero range the middle.  fuse's fallocate code
issues the upcall to userspace, whch changes some mappings:

-------fffff-------fffffff
wwwwwuuuuuuuuuuuwwwwwwwwww

Only after the upcall returns does the kernel try to do the pagecache
zeroing.  Unfortunately, the mapping changed to unwritten so
iomap_zero_range doesn't see the "fffff" and leaves its contents intact.

(Note: Non-iomap fuse defers everything to the fuse server so this isn't
a problem if the fuse server does all the zeroing itself.)

--D

> Brian
> 
> [1] Details described in the commit log of fde4c4c3ec1c ("iomap: elide
> flush from partial eof zero range").
> 
> > --D
> > 
> > > ---
> > >  fs/iomap/buffered-io.c | 24 ------------------------
> > >  1 file changed, 24 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 194e3cc0857f..d2bbed692c06 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1484,33 +1484,9 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
> > >  		.private	= private,
> > >  	};
> > >  	struct address_space *mapping = inode->i_mapping;
> > > -	unsigned int blocksize = i_blocksize(inode);
> > > -	unsigned int off = pos & (blocksize - 1);
> > > -	loff_t plen = min_t(loff_t, len, blocksize - off);
> > >  	int ret;
> > >  	bool range_dirty;
> > >  
> > > -	/*
> > > -	 * Zero range can skip mappings that are zero on disk so long as
> > > -	 * pagecache is clean. If pagecache was dirty prior to zero range, the
> > > -	 * mapping converts on writeback completion and so must be zeroed.
> > > -	 *
> > > -	 * The simplest way to deal with this across a range is to flush
> > > -	 * pagecache and process the updated mappings. To avoid excessive
> > > -	 * flushing on partial eof zeroing, special case it to zero the
> > > -	 * unaligned start portion if already dirty in pagecache.
> > > -	 */
> > > -	if (!iter.fbatch && off &&
> > > -	    filemap_range_needs_writeback(mapping, pos, pos + plen - 1)) {
> > > -		iter.len = plen;
> > > -		while ((ret = iomap_iter(&iter, ops)) > 0)
> > > -			iter.status = iomap_zero_iter(&iter, did_zero);
> > > -
> > > -		iter.len = len - (iter.pos - pos);
> > > -		if (ret || !iter.len)
> > > -			return ret;
> > > -	}
> > > -
> > >  	/*
> > >  	 * To avoid an unconditional flush, check pagecache state and only flush
> > >  	 * if dirty and the fs returns a mapping that might convert on
> > > -- 
> > > 2.50.0
> > > 
> > > 
> > 
> 
> 

