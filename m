Return-Path: <linux-fsdevel+bounces-54984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1A7B06197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B96505D92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81820299B;
	Tue, 15 Jul 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFmIrfPm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD89218AB0;
	Tue, 15 Jul 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589843; cv=none; b=Sh1otrZtfqEhL5sfom2x304xgqnkbA6GjM5sSFmw8eEh2l7FUI3pvAqzQude/X5fiP2H9OSx0LNIW6pHZZ2iucUL3dJ6wPwk5n13EAUQpRJE0Zfnxamh4cs/UFRRDEwSsq0oIwEY6AgIrw1JSBuWa7LR2lyAlcLQTs0sGApphe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589843; c=relaxed/simple;
	bh=sV1OZP5WMBeyKyulfXGILmszhTuQ8xOGFvfPdffvOJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPi7E2wHxxF7cgOji2waFlRXfUin12WyvmDXvTYKV6EaHtHXLMf2x3FVo2rb1/b9pRZMRQuT2FKZQxxqgsr6o/agIJbk6LjPvFDkCJ+qd7itXVQi598cQK2KTES37FaNT34vztYQJfspOhfuZSZA0tLygfntFsnRm7JAjAmYgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFmIrfPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C9C4CEE3;
	Tue, 15 Jul 2025 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589842;
	bh=sV1OZP5WMBeyKyulfXGILmszhTuQ8xOGFvfPdffvOJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFmIrfPmJ7DAsHWOUFFVRGodoN8liMahk8iM7VXw3B4q+tfagwCYomKPsHLGjw8tC
	 DMTG4TdnPN+ppLpbKF07Qqcq+jEEe3uPHEvKkL3+TTT4/f8mWadzhV+VildbgUx7/Y
	 r5ugytVSnUVAezv+EsFWTy7W9gNy3LmqGBrmiybyLbpgpacc4jae2bwuTDpV2/i5/D
	 gzmjgIR5tcH0Q2IzGdMIC4FC3mmHAxVzDhLxHmTiG0xRPu6Rmoq3FCxAIF/fjtDrzJ
	 FQuN9LseWR1zN0mMvQ08GUIA45xgdup4iKjOVC9aOw5qqVoInuUrafaW1Qm1KziLpG
	 aEpL7JDge/YGA==
Date: Tue, 15 Jul 2025 07:30:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, willy@infradead.org
Subject: Re: [PATCH v3 7/7] xfs: error tag to force zeroing on debug kernels
Message-ID: <20250715143041.GN2672029@frogsfrogsfrogs>
References: <20250714204122.349582-1-bfoster@redhat.com>
 <20250714204122.349582-8-bfoster@redhat.com>
 <20250715052444.GP2672049@frogsfrogsfrogs>
 <aHZL55AcNnAD-uAn@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZL55AcNnAD-uAn@bfoster>

On Tue, Jul 15, 2025 at 08:39:03AM -0400, Brian Foster wrote:
> On Mon, Jul 14, 2025 at 10:24:44PM -0700, Darrick J. Wong wrote:
> > On Mon, Jul 14, 2025 at 04:41:22PM -0400, Brian Foster wrote:
> > > iomap_zero_range() has to cover various corner cases that are
> > > difficult to test on production kernels because it is used in fairly
> > > limited use cases. For example, it is currently only used by XFS and
> > > mostly only in partial block zeroing cases.
> > > 
> > > While it's possible to test most of these functional cases, we can
> > > provide more robust test coverage by co-opting fallocate zero range
> > > to invoke zeroing of the entire range instead of the more efficient
> > > block punch/allocate sequence. Add an errortag to occasionally
> > > invoke forced zeroing.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/xfs/libxfs/xfs_errortag.h |  4 +++-
> > >  fs/xfs/xfs_error.c           |  3 +++
> > >  fs/xfs/xfs_file.c            | 26 ++++++++++++++++++++------
> > >  3 files changed, 26 insertions(+), 7 deletions(-)
> > > 
> ...
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 0b41b18debf3..c865f9555b77 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -27,6 +27,8 @@
> > >  #include "xfs_file.h"
> > >  #include "xfs_aops.h"
> > >  #include "xfs_zone_alloc.h"
> > > +#include "xfs_error.h"
> > > +#include "xfs_errortag.h"
> > >  
> > >  #include <linux/dax.h>
> > >  #include <linux/falloc.h>
> > > @@ -1269,13 +1271,25 @@ xfs_falloc_zero_range(
> > >  	if (error)
> > >  		return error;
> > >  
> > > -	error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> > > -	if (error)
> > > -		return error;
> > > +	/*
> > > +	 * Zero range implements a full zeroing mechanism but is only used in
> > > +	 * limited situations. It is more efficient to allocate unwritten
> > > +	 * extents than to perform zeroing here, so use an errortag to randomly
> > > +	 * force zeroing on DEBUG kernels for added test coverage.
> > > +	 */
> > > +	if (XFS_TEST_ERROR(false, XFS_I(inode)->i_mount,
> > > +			   XFS_ERRTAG_FORCE_ZERO_RANGE)) {
> > > +		error = xfs_zero_range(XFS_I(inode), offset, len, ac, NULL);
> > 
> > Isn't this basically the ultra slow version fallback version of
> > FALLOC_FL_WRITE_ZEROES ?
> > 
> 
> ~/linux$ git grep FALLOC_FL_WRITE_ZEROES
> ~/linux$ 
> 
> IIRC write zeroes is intended to expose fast hardware (physical) zeroing
> (i.e. zeroed written extents)..? If so, I suppose you could consider
> this a fallback of sorts. I'm not sure what write zeroes is expected to
> do in the unwritten extent case, whereas iomap zero range is happy to
> skip those mappings unless they're already dirty in pagecache.

Sorry, forgot that they weren't wiring anything up in xfs so it never
showed up here:
https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.zhang@huaweicloud.com/

Basically they want to avoid the unwritten extent conversion overhead by
providing a way to preallocate written zeroed extents and sending magic
commands to hardware that unmaps LBAs in such a way that rereads return
zero.

> Regardless, the purpose of this patch is not to add support for physical
> zeroing, but rather to increase test coverage for the additional code on
> debug kernels because the production use case tends to be more limited.
> This could easily be moved/applied to write zeroes if it makes sense in
> the future and test infra grows support for it.

<nod> On second look, I don't think the new fallocate flag allows for
letting the kernel do pagecache zeroing + flush.  Admittedly that would
be beside the point (and userspaces already do that anyway).

Anyway enough mumbling from me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> Brian
> 
> > --D
> > 
> > > +	} else {
> > > +		error = xfs_free_file_space(XFS_I(inode), offset, len, ac);
> > > +		if (error)
> > > +			return error;
> > >  
> > > -	len = round_up(offset + len, blksize) - round_down(offset, blksize);
> > > -	offset = round_down(offset, blksize);
> > > -	error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> > > +		len = round_up(offset + len, blksize) -
> > > +			round_down(offset, blksize);
> > > +		offset = round_down(offset, blksize);
> > > +		error = xfs_alloc_file_space(XFS_I(inode), offset, len);
> > > +	}
> > >  	if (error)
> > >  		return error;
> > >  	return xfs_falloc_setsize(file, new_size);
> > > -- 
> > > 2.50.0
> > > 
> > > 
> > 
> 
> 

