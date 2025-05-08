Return-Path: <linux-fsdevel+bounces-48495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93643AAFFDD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6BB1B6110D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9927BF78;
	Thu,  8 May 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXBGPfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6396127B4F5;
	Thu,  8 May 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720263; cv=none; b=LLQ3MjKLcjNGVquSJFfDh/HzeMpZSgQ9DF17Y5b8bwxWm959SBRypmcLIZRDzJBkoiW30qe1ZuL5cuHGfp4BDQx711OGpwEB6QtbMpRvu05qix7QucjKz++mIkvnwmTtdBKez+UJNGvmR3wOBwiC4Ko0ZjWTNejY+kvLqGI+xdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720263; c=relaxed/simple;
	bh=8L04ShsPj5PK2TE2kYeu+fsIEh3/s/4hzs7V521W0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYuWKZXPNL8dchBKNeVhNaSTiUTu8Hql93mvYcjrEp960fed+w7N2P1F3qLojOjsoobh2zUnZzAEvrVRz17jYrw3bG5HARiFFE10Cwr0VdCXHdnYYSPTJxzgWPyrdG8UT6PW0gP9mEstxZoJCV9sE/3TG/oljXpEAIzPxnSigr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwXBGPfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BAFC4CEE7;
	Thu,  8 May 2025 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746720262;
	bh=8L04ShsPj5PK2TE2kYeu+fsIEh3/s/4hzs7V521W0MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwXBGPfKFqlJde3QHU+D7F84H5XleyT0K3A4zyX+gZs53/nobK9mPWkjD03muXSfy
	 nVyFgMRxmPC8MZk4LssoqSuUgsV2T7WuCk/4BfGKD8fkHKXI0qz6HZWeV91JEA4Gbg
	 CxN782QS/10wA6vzaLc6W2JB+le+TmBQ/ZVNjp9O2BC1cQ2Y9U8yc6+lfxIF+ZAYIY
	 vkonNh4GpbtHxPWdwbRs7fObtHskuvDvpv2KorvHZsIvG+oh4OuQM1mNpS4IbGUa9s
	 ETtVLuOZ53jRshn0CaFsw4n8n+8i9KyIE2cyzB12duxfQQTyk5zGmY/BHjWKzFtr+j
	 s9bNjbarS+M+w==
Date: Thu, 8 May 2025 09:04:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Message-ID: <20250508160422.GN1035866@frogsfrogsfrogs>
References: <20250508133427.3799322-1-agruenba@redhat.com>
 <aBzABse9b6vF_LTv@bfoster>
 <20250508150446.GB2701446@frogsfrogsfrogs>
 <aBzLib4tHj351di2@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBzLib4tHj351di2@bfoster>

On Thu, May 08, 2025 at 11:19:37AM -0400, Brian Foster wrote:
> On Thu, May 08, 2025 at 08:04:46AM -0700, Darrick J. Wong wrote:
> > On Thu, May 08, 2025 at 10:30:30AM -0400, Brian Foster wrote:
> > > On Thu, May 08, 2025 at 03:34:27PM +0200, Andreas Gruenbacher wrote:
> > > > Since commit eb65540aa9fc ("iomap: warn on zero range of a post-eof
> > > > folio"), iomap_zero_range() warns when asked to zero a folio beyond eof.
> > > > The warning triggers on the following code path:
> > 
> > Which warning?  This one?
> > 
> > 	/* warn about zeroing folios beyond eof that won't write back */
> > 	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> > 
> > If so, then why are there folios that start entirely beyond EOF?
> > 
> 
> Yeah.. this gfs2 instance is simply a case of their punch hole mechanism
> does unconditional partial folio zeroing via iomap zero range, so if a
> punch hole occurs on some unaligned range of post-eof blocks, it will
> basically create and perform zeroing of post-eof folios. IIUC the caveat
> here is that these blocks are all zeroed on alloc (unwritten extents are
> apparently not a thing in gfs2), so the punch time zeroing and warning
> are spurious. Andreas can correct me if I have any of that wrong.

Oh, right, because iomap_zero_iter calls iomap_write_begin, which
allocates a new folio completely beyond EOF, and then we see that new
folio and WARN about it before scribbling on the folio and dirtying it.
Correct?

If so then yeah, it doesn't seem useful to do that... unless the file
size immediately gets extended such that at least one byte of the dirty
folio is within EOF.  Even then, that seems like a stretch...

> > > > 
> > > >   gfs2_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
> > > >     __gfs2_punch_hole()
> > > >       gfs2_block_zero_range()
> > > >         iomap_zero_range()
> > > > 
> > > > So far, gfs2 is just zeroing out partial pages at the beginning and end
> > > > of the range, whether beyond eof or not.  The data beyond eof is already
> > > > expected to be all zeroes, though.  Truncate the range passed to
> > > > iomap_zero_range().
> > > > 
> > > > As an alternative approach, we could also implicitly truncate the range
> > > > inside iomap_zero_range() instead of issuing a warning.  Any thoughts?
> > > > 
> > > 
> > > Thanks Andreas. The more I think about this the more it seems like
> > > lifting this logic into iomap is a reasonable compromise between just
> > > dropping the warning and forcing individual filesystems to work around
> > > it. The original intent of the warning was to have something to catch
> > > subtle bad behavior since zero range did update i_size for so long.
> > > 
> > > OTOH I think it's reasonable to argue that we shouldn't need to warn in
> > > situations where we could just enforce correct behavior. Also, I believe
> > > we introduced something similar to avoid post-eof weirdness wrt unshare
> > > range [1], so precedent exists.
> > > 
> > > I'm interested if others have opinions on the iomap side.. (though as I
> > > write this it looks like hch sits on the side of not tweaking iomap).
> > 
> > IIRC XFS calls iomap_zero_range during file extending operations to zero
> > the tail of a folio that spans EOF, so you'd have to allow for that too.
> > 
> 
> Yeah, good point. Perhaps we'd want to bail on a folio that starts
> beyond EOF with this approach, similar to the warning logic.

...because I don't see much use in zeroing and dirtying a folio that
starts well beyond EOF since iomap_writepage_handle_eof will ignore it
and there are several gigantic comments in buffered-io.c about clamping
to EOF.

<shrug> But maybe I'm missing a usecase?

--D

> Brian
> 
> > --D
> > 
> > > Brian
> > > 
> > > [1] a311a08a4237 ("iomap: constrain the file range passed to iomap_file_unshare")
> > > 
> > > > Thanks,
> > > > Andreas
> > > > 
> > > > --
> > > > 
> > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > > > 
> > > > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > > > index b81984def58e..d9a4309cd414 100644
> > > > --- a/fs/gfs2/bmap.c
> > > > +++ b/fs/gfs2/bmap.c
> > > > @@ -1301,6 +1301,10 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
> > > >  				 unsigned int length)
> > > >  {
> > > >  	BUG_ON(current->journal_info);
> > > > +	if (from > inode->i_size)
> > > > +		return 0;
> > > > +	if (from + length > inode->i_size)
> > > > +		length = inode->i_size - from;
> > > >  	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
> > > >  			NULL);
> > > >  }
> > > > 
> > > 
> > > 
> > 
> 
> 

