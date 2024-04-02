Return-Path: <linux-fsdevel+bounces-15943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B98895FD5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 00:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A4328728C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 22:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68035F18;
	Tue,  2 Apr 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+Rb195/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF511D6AE;
	Tue,  2 Apr 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098337; cv=none; b=lizRcw9jixiutD6WqsDlzH4uPLvsmqKHa8FIeP+GZZu7Z6BpEp18aTtwXvl5LHkEX1uxragaQTZfpLWrrGd26nO6dbek5pTyraGYlzAXnTNMwedj8vu+jIcrvigwDGvicTgOE0r1RAZ+TXzK7NSJsmAtCG45OjX+n2/AUrNjNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098337; c=relaxed/simple;
	bh=JCUX01z4imv3ohaGJcNNxza8lnFq8bCI2iYQo+Q8KyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHOKGAkmZOI7edPVD0mdXbmjyysnf6dkwVRkSZcqgAwZ+QJakRUr9yE9DPQjjUqQQkawcAaWap4laV4mH2MJGhGKRmSWepmNkLUR3E3bOWaxvmXDf+j9uDmOs0GY4TY6Tp7wkcP5/49at3sL4Wyk+Ii28aa2eKZa7kRMnWKlSrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+Rb195/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3858C433C7;
	Tue,  2 Apr 2024 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712098336;
	bh=JCUX01z4imv3ohaGJcNNxza8lnFq8bCI2iYQo+Q8KyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+Rb195/3tMPL+2xn3xsfYWgYwB5vpbIMaaBppUtggwt8lZH3uhcy3a/vOr59P1tI
	 pc4lnQtV/7JLof4BOrv0XyWtdVYZL15oVG6eyn6mGWOSlTBMa11UCTgoaRM2BxSFK1
	 egKEZSNleAdO3YoTqXaVZ8QC1risSSqzrDXgvG+PZ27MK5zMBz6Ia1+oP8cR5V1tJO
	 thqPtu2HQzPDXbTpx7FOXxUoOjgxFEx55OuMvI4VbzmTWqRMTkhLOkVvFNKQk7wz7r
	 jMnjF9gUMmAA1aSlV49Szfr7GDDvzefjuGNM4g/AbP7T1ChNJqoqmOVG3uGkrbKFgU
	 TDShKNv8sqAaw==
Date: Tue, 2 Apr 2024 15:52:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: Eric Biggers <ebiggers@kernel.org>, aalbersh@redhat.com,
	xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <20240402225216.GW6414@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>

On Tue, Apr 02, 2024 at 04:00:06PM -0400, Colin Walters wrote:
> 
> 
> On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > There are more things that one can do with an open file descriptor on
> > XFS -- query extended attributes, scan for metadata damage, repair
> > metadata, etc.  None of this is possible if the fsverity metadata are
> > damaged, because that prevents the file from being opened.
> >
> > Ignore a selective set of error codes that we know fsverity_file_open to
> > return if the verity descriptor is nonsense.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/iomap/buffered-io.c |    8 ++++++++
> >  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 9f9d929dfeebc..e68a15b72dbdd 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct 
> > iomap_iter *iter,
> >  	size_t poff, plen;
> >  	sector_t sector;
> > 
> > +	/*
> > +	 * If this verity file hasn't been activated, fail read attempts.  This
> > +	 * can happen if the calling filesystem allows files to be opened even
> > +	 * with damaged verity metadata.
> > +	 */
> > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> > +		return -EIO;
> > +
> >  	if (iomap->type == IOMAP_INLINE)
> >  		return iomap_read_inline_data(iter, folio);
> > 
> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > index c0b3e8146b753..36034eaefbf55 100644
> > --- a/fs/xfs/xfs_file.c
> > +++ b/fs/xfs/xfs_file.c
> > @@ -1431,8 +1431,25 @@ xfs_file_open(
> >  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> > 
> >  	error = fsverity_file_open(inode, file);
> > -	if (error)
> > +	switch (error) {
> > +	case -EFBIG:
> > +	case -EINVAL:
> > +	case -EMSGSIZE:
> > +	case -EFSCORRUPTED:
> > +		/*
> > +		 * Be selective about which fsverity errors we propagate to
> > +		 * userspace; we still want to be able to open this file even
> > +		 * if reads don't work.  Someone might want to perform an
> > +		 * online repair.
> > +		 */
> > +		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
> > +			break;
> 
> As I understand it, fsverity (and dm-verity) are desirable in
> high-safety and integrity requirement cases where the goal is for the
> system to "fail closed" if errors in general are detected; anything
> that would have the system be in an ill-defined state.

Is "open() fails if verity metadata are trashed" a hard requirement?

Reads will still fail due to (iomap) readahead returning EIO for a file
that is IS_VERITY() && !fsverity_active().  This is (afaict) the state
you end up with when the fsverity open fails.  ext4/f2fs don't do that,
but they also don't have online fsck so once a file's dead it's dead.

> A lot of ambient processes are going to have CAP_SYS_ADMIN and this
> will just swallow these errors for those (will things the EFSCORRUPTED
> path at least have been logged by a lower level function?)...whereas
> this is only needed just for a very few tools.
> 
> At least for composefs the quoted cases of "query extended attributes,
> scan for metadata damage, repair metadata" are all things that
> canonically live in the composefs metadata (EROFS) blob, so in theory
> there's a lot less of a need to query/inspect it for those use cases.
> (Maybe for composefs we should force canonicalize all the underlying
> files to have mode 0400 and no xattrs or something and add that to its
> repair).

<shrug> I don't know if regular (i.e. non-verity) xattrs are one of the
things that get frozen by verity?  Storing fsverity metadata in private
namespace xattrs is unique to xfs.

> I hesitate to say it but maybe there should be some ioctl for online
> repair use cases only, or perhaps a new O_NOVERITY special flag to
> openat2()?

"openat2 but without meddling from the VFS"?  Tempting... ;)

--D

