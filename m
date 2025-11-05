Return-Path: <linux-fsdevel+bounces-67218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9BC3827A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BFB3B6D42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB922E091C;
	Wed,  5 Nov 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r27CZ8c+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F1A2392;
	Wed,  5 Nov 2025 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380932; cv=none; b=sjLm3ZgSoyhE0YKM2cIuaMkhva4VOVb3ojTyoJHy5c/MY4BitqOj/KC/TR/pzgjvfPbMePJ804LCM+ttxhNCwwBt2aNwPZ5E891W+TMB/FPUTCy/am5qnsLkkpfQsHQuu/2ZecTbB/FYDsMnW4zBwPWQQ2vBj88FQIr2oQiHXjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380932; c=relaxed/simple;
	bh=xfaDNOp67hySE5VTV7Uf0rk9QOvyxGdHfOLbCUUCPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TGsu/e+DwejBLjKIxoGFyuXui89V/II/dJo5x1/RiLQsR6W/k3loYb0I63nPJrqPY/QPpUKwpJqWNJ5rRgxATLIolD2AghJIUxpqJ0OBAUNcqiUhxJtdTidJVOLp+XAMWFVKUzEsBCKz0HuMGvLD0EPK8qrKcx4XzidY4D97XSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r27CZ8c+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5EFC4CEF5;
	Wed,  5 Nov 2025 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762380932;
	bh=xfaDNOp67hySE5VTV7Uf0rk9QOvyxGdHfOLbCUUCPkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r27CZ8c+Cu1Hln5pRx93L7cf07j24kuEaDujit+pqJYhYZte0PRrrhuW1wFVt2N2z
	 lEl94dBvl1O0vYYa+25v9JkE4b0Bd1Tqd03543Cb8TRh1jvWDx5NrbtW51WNsklLRV
	 VQxz3Cwf23+IPG8nxyRQXFbHjHv0xvgPo0NtzNzmlZcNo2ybLfNqEPfv5eMuz3BEsU
	 aaKJbUfH4wlZQXJ3fHZoeQ+DS9ZUCP1W1QqlWFZ/CpVcbE2eyyE0Yn4uEsu0Qxb61h
	 fBBUvpHBLf7PLiFqPbHx/NrbcNQ0TR3MxE0OiALPbx7+Nq89HbhHUe3wZXbTQYQBIS
	 dZb6X1W2rT6tA==
Date: Wed, 5 Nov 2025 14:15:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/6] xfs: flush eof folio before insert range size update
Message-ID: <20251105221531.GG196370@frogsfrogsfrogs>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-4-bfoster@redhat.com>
 <20251105001445.GW196370@frogsfrogsfrogs>
 <aQtughoBHt6LRTUx@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtughoBHt6LRTUx@bfoster>

On Wed, Nov 05, 2025 at 10:34:26AM -0500, Brian Foster wrote:
> On Tue, Nov 04, 2025 at 04:14:45PM -0800, Darrick J. Wong wrote:
> > On Thu, Oct 16, 2025 at 03:03:00PM -0400, Brian Foster wrote:
> > > The flush in xfs_buffered_write_iomap_begin() for zero range over a
> > > data fork hole fronted by COW fork prealloc is primarily designed to
> > > provide correct zeroing behavior in particular pagecache conditions.
> > > As it turns out, this also partially masks some odd behavior in
> > > insert range (via zero range via setattr).
> > > 
> > > Insert range bumps i_size the length of the new range, flushes,
> > > unmaps pagecache and cancels COW prealloc, and then right shifts
> > > extents from the end of the file back to the target offset of the
> > > insert. Since the i_size update occurs before the pagecache flush,
> > > this creates a transient situation where writeback around EOF can
> > > behave differently.
> > 
> > Why not flush the file from @offset to EOF, flush the COW
> > preallocations, extend i_size, and only then start shifting extents?
> > That would seem a lot more straightforward to me.
> > 
> 
> I agree. I noted in the cover letter that I started with this approach
> of reordering the existing sequence of operations, but the factoring
> looked ugly enough that I stopped and wanted to solicit input.
> 
> The details of that fell out of my brain since I posted this,
> unfortunately. I suspect it may have been related to layering or
> something wrt the prepare_shift factoring, but I'll take another look in
> that direction for v2 and once I've got some feedback on the rest of the
> series.. Thanks.

I'm guessing that you want me to keep going with the other three
patches, then? :)

--D

> Brian
> 
> > --D
> > 
> > > This appears to be corner case situation, but if happens to be
> > > fronted by COW fork speculative preallocation and a large, dirty
> > > folio that contains at least one full COW block beyond EOF, the
> > > writeback after i_size is bumped may remap that COW fork block into
> > > the data fork within EOF. The block is zeroed and then shifted back
> > > out to post-eof, but this is unexpected in that it leads to a
> > > written post-eof data fork block. This can cause a zero range
> > > warning on a subsequent size extension, because we should never find
> > > blocks that require physical zeroing beyond i_size.
> > > 
> > > To avoid this quirk, flush the EOF folio before the i_size update
> > > during insert range. The entire range will be flushed, unmapped and
> > > invalidated anyways, so this should be relatively unnoticeable.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 5b9864c8582e..cc3a9674ad40 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1226,6 +1226,23 @@ xfs_falloc_insert_range(
> > >  	if (offset >= isize)
> > >  		return -EINVAL;
> > >  
> > > +	/*
> > > +	 * Let writeback clean up EOF folio state before we bump i_size. The
> > > +	 * insert flushes before it starts shifting and under certain
> > > +	 * circumstances we can write back blocks that should technically be
> > > +	 * considered post-eof (and thus should not be submitted for writeback).
> > > +	 *
> > > +	 * For example, a large, dirty folio that spans EOF and is backed by
> > > +	 * post-eof COW fork preallocation can cause block remap into the data
> > > +	 * fork. This shifts back out beyond EOF, but creates an expectedly
> > > +	 * written post-eof block. The insert is going to flush, unmap and
> > > +	 * cancel prealloc across this whole range, so flush EOF now before we
> > > +	 * bump i_size to provide consistent behavior.
> > > +	 */
> > > +	error = filemap_write_and_wait_range(inode->i_mapping, isize, isize);
> > > +	if (error)
> > > +		return error;
> > > +
> > >  	error = xfs_falloc_setsize(file, isize + len);
> > >  	if (error)
> > >  		return error;
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> 
> 

