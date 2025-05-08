Return-Path: <linux-fsdevel+bounces-48488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A1EAAFE49
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88AE23B6CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E9D27A93F;
	Thu,  8 May 2025 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umCmZNYP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044772797A0;
	Thu,  8 May 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716688; cv=none; b=MdsBRhXl7YP5+aplFmCxbar1k6FnqAWaOPx0QVsXwsZ7J/PlSBVCfEALFeNblvIZSt/3Wsu6knLKV8h+E6yeRNBFTBvxaK+W/8k1ltVWACzipBn30K7YfCvb65hRonLLM86m1OOrJKlFeoeNXxpSwAg9gMqAM3BFmev8sJIpXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716688; c=relaxed/simple;
	bh=MtGlRt8tCtbJM/pg+IiI4jcKiJc64uhf5JsgVr7+h/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5PvrpIXiMXyV9GJEHR1JuMEi0k9IB8xK0zVjHbpTDHuFbVCc/B6dbhlqIb3nspVRXldYPCb9U9CCzPCss7t+25F0IQdurtG/FZeaL/Nw9BUnGeThtJ968RoQcn1QmwockXTLP6vI+AXjYKR9qFczvZHlWKTeKQK0PJVmOjmZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umCmZNYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50059C4CEE7;
	Thu,  8 May 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716687;
	bh=MtGlRt8tCtbJM/pg+IiI4jcKiJc64uhf5JsgVr7+h/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umCmZNYPpz2qnsSIx46S3awAvn28IX9eyeewAEVxbQ1Ls9Jm0+GtnFFMcLT5JjKH3
	 Dnftv56YDyRS6aPeUqxAqJGehHDNRd/yLrq9J67X/uWPtGKBZnODGwPmTDKyxSY/SR
	 PsCQnJCbKPgZ6L3nLSkZD6+bUODzYzPGZu8AyR+WBeapeqwFHN3uzMzrL1wzlvnM7Q
	 SewbWYvvhxlJKmduaBpfpwhSDyAjQvqELiKB4LnpDkskV6+BOQ0zB5wRedWULOLMdD
	 +QKVSm9gk2gG2isjJODCtqBfdkmgaKuxGY69MBEBAFx6VHZRGDOnvYZEjBiKe128Xq
	 aBY56fYWyN/Eg==
Date: Thu, 8 May 2025 08:04:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [RFC] gfs2: Do not call iomap_zero_range beyond eof
Message-ID: <20250508150446.GB2701446@frogsfrogsfrogs>
References: <20250508133427.3799322-1-agruenba@redhat.com>
 <aBzABse9b6vF_LTv@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBzABse9b6vF_LTv@bfoster>

On Thu, May 08, 2025 at 10:30:30AM -0400, Brian Foster wrote:
> On Thu, May 08, 2025 at 03:34:27PM +0200, Andreas Gruenbacher wrote:
> > Since commit eb65540aa9fc ("iomap: warn on zero range of a post-eof
> > folio"), iomap_zero_range() warns when asked to zero a folio beyond eof.
> > The warning triggers on the following code path:

Which warning?  This one?

	/* warn about zeroing folios beyond eof that won't write back */
	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);

If so, then why are there folios that start entirely beyond EOF?

> > 
> >   gfs2_fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
> >     __gfs2_punch_hole()
> >       gfs2_block_zero_range()
> >         iomap_zero_range()
> > 
> > So far, gfs2 is just zeroing out partial pages at the beginning and end
> > of the range, whether beyond eof or not.  The data beyond eof is already
> > expected to be all zeroes, though.  Truncate the range passed to
> > iomap_zero_range().
> > 
> > As an alternative approach, we could also implicitly truncate the range
> > inside iomap_zero_range() instead of issuing a warning.  Any thoughts?
> > 
> 
> Thanks Andreas. The more I think about this the more it seems like
> lifting this logic into iomap is a reasonable compromise between just
> dropping the warning and forcing individual filesystems to work around
> it. The original intent of the warning was to have something to catch
> subtle bad behavior since zero range did update i_size for so long.
> 
> OTOH I think it's reasonable to argue that we shouldn't need to warn in
> situations where we could just enforce correct behavior. Also, I believe
> we introduced something similar to avoid post-eof weirdness wrt unshare
> range [1], so precedent exists.
> 
> I'm interested if others have opinions on the iomap side.. (though as I
> write this it looks like hch sits on the side of not tweaking iomap).

IIRC XFS calls iomap_zero_range during file extending operations to zero
the tail of a folio that spans EOF, so you'd have to allow for that too.

--D

> Brian
> 
> [1] a311a08a4237 ("iomap: constrain the file range passed to iomap_file_unshare")
> 
> > Thanks,
> > Andreas
> > 
> > --
> > 
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > 
> > diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> > index b81984def58e..d9a4309cd414 100644
> > --- a/fs/gfs2/bmap.c
> > +++ b/fs/gfs2/bmap.c
> > @@ -1301,6 +1301,10 @@ static int gfs2_block_zero_range(struct inode *inode, loff_t from,
> >  				 unsigned int length)
> >  {
> >  	BUG_ON(current->journal_info);
> > +	if (from > inode->i_size)
> > +		return 0;
> > +	if (from + length > inode->i_size)
> > +		length = inode->i_size - from;
> >  	return iomap_zero_range(inode, from, length, NULL, &gfs2_iomap_ops,
> >  			NULL);
> >  }
> > 
> 
> 

