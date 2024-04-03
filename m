Return-Path: <linux-fsdevel+bounces-15952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D689620F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6BE1F25546
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 01:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4795814F70;
	Wed,  3 Apr 2024 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXh7GE+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBCFD29B;
	Wed,  3 Apr 2024 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108344; cv=none; b=Su1YCCqcYvj7fMoWd1hYUu2ZPdQXJZci3RZicZfuHiqAkYToUE+Y5FshTF6JPli09QIdnYketm/gZ+L8Tv9v0QPAQH8Wz952SqBoZSwBvZUU5T9y7jM/cO9R4Ed1zjfxik5LqvEh45v24VokG7IkphZtpgNxHbKEflRQgb7KlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108344; c=relaxed/simple;
	bh=+JwCZHCrwplzo0ui7tlXWPoiKwih3iQc4ip+3HLzvGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHGP1eYfzGZ1R9GJeGhSxGnhi2xY4cgEj9Kew+6cdcZMivjpCzfTF9o5m8LE98ka5s4U2dgPL8khEjH8dWSiYHogqAkl+cSHtTNaTy25HO8MSQJQ2LVOe0VYsw/42hRXXD5lx7hBjiu+U8hpthWUBkjlP9Ccvmh19COP7dtwVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXh7GE+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19768C433F1;
	Wed,  3 Apr 2024 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108344;
	bh=+JwCZHCrwplzo0ui7tlXWPoiKwih3iQc4ip+3HLzvGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXh7GE+isVzbwWj5SRgZWVdBr8eOgosRszGibFRsu3ySkJIraD8WpQXLhVFNc4TUK
	 gJqsUBVNPyijM5jRWL287alvOY+L2Z6Agy9KKoJX0ZKNXzVBFMlFhxVPnO9o2Z3Pvr
	 EOqwDpBN0OgZ+e/jEr15MJxkSvAdd8O/kLFJLwov6zCPEnghV7lheZQN9tOuj+tJKN
	 xBYunaseYeuM+rIkvqaEMMkfAppdvA1SwwHenqe2c/8Y+iDp/j1wATWjdS2r73t5Hl
	 SS/YEZogeJZJN3M4ggpMPzBCSgnCnRCHEK5JIh9rFBgLUjIPf0V/BUAtkuXL4kORCJ
	 N+7ltwY3yHXcA==
Date: Tue, 2 Apr 2024 18:39:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Colin Walters <walters@verbum.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <20240403013903.GG6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
 <20240402225216.GW6414@frogsfrogsfrogs>
 <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <992e84c7-66f5-42d2-a042-9a850891b705@app.fastmail.com>

On Tue, Apr 02, 2024 at 08:10:15PM -0400, Colin Walters wrote:
> [cc alexl@, retained quotes for context]
> 
> On Tue, Apr 2, 2024, at 6:52 PM, Darrick J. Wong wrote:
> > On Tue, Apr 02, 2024 at 04:00:06PM -0400, Colin Walters wrote:
> >> 
> >> 
> >> On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
> >> > From: Darrick J. Wong <djwong@kernel.org>
> >> >
> >> > There are more things that one can do with an open file descriptor on
> >> > XFS -- query extended attributes, scan for metadata damage, repair
> >> > metadata, etc.  None of this is possible if the fsverity metadata are
> >> > damaged, because that prevents the file from being opened.
> >> >
> >> > Ignore a selective set of error codes that we know fsverity_file_open to
> >> > return if the verity descriptor is nonsense.
> >> >
> >> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> >> > ---
> >> >  fs/iomap/buffered-io.c |    8 ++++++++
> >> >  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
> >> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >> >
> >> >
> >> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> > index 9f9d929dfeebc..e68a15b72dbdd 100644
> >> > --- a/fs/iomap/buffered-io.c
> >> > +++ b/fs/iomap/buffered-io.c
> >> > @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct 
> >> > iomap_iter *iter,
> >> >  	size_t poff, plen;
> >> >  	sector_t sector;
> >> > 
> >> > +	/*
> >> > +	 * If this verity file hasn't been activated, fail read attempts.  This
> >> > +	 * can happen if the calling filesystem allows files to be opened even
> >> > +	 * with damaged verity metadata.
> >> > +	 */
> >> > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> >> > +		return -EIO;
> >> > +
> >> >  	if (iomap->type == IOMAP_INLINE)
> >> >  		return iomap_read_inline_data(iter, folio);
> >> > 
> >> > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> >> > index c0b3e8146b753..36034eaefbf55 100644
> >> > --- a/fs/xfs/xfs_file.c
> >> > +++ b/fs/xfs/xfs_file.c
> >> > @@ -1431,8 +1431,25 @@ xfs_file_open(
> >> >  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> >> > 
> >> >  	error = fsverity_file_open(inode, file);
> >> > -	if (error)
> >> > +	switch (error) {
> >> > +	case -EFBIG:
> >> > +	case -EINVAL:
> >> > +	case -EMSGSIZE:
> >> > +	case -EFSCORRUPTED:
> >> > +		/*
> >> > +		 * Be selective about which fsverity errors we propagate to
> >> > +		 * userspace; we still want to be able to open this file even
> >> > +		 * if reads don't work.  Someone might want to perform an
> >> > +		 * online repair.
> >> > +		 */
> >> > +		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
> >> > +			break;
> >> 
> >> As I understand it, fsverity (and dm-verity) are desirable in
> >> high-safety and integrity requirement cases where the goal is for the
> >> system to "fail closed" if errors in general are detected; anything
> >> that would have the system be in an ill-defined state.
> >
> > Is "open() fails if verity metadata are trashed" a hard requirement?
> 
> I can't say authoritatively, but I do want to ensure we've dug into
> the semantics here, and I agree with Eric that it would make the most
> sense to have this be consistent across filesystems.
> 
> > Reads will still fail due to (iomap) readahead returning EIO for a file
> > that is IS_VERITY() && !fsverity_active().  This is (afaict) the state
> > you end up with when the fsverity open fails.  ext4/f2fs don't do that,
> > but they also don't have online fsck so once a file's dead it's dead.
> 
> OK, right.  Allowing an open() but having read() fail seems like it
> doesn't weaken things too much in reality.  I think what makes me
> uncomfortable is the error-swallowing; but yes, in theory we should
> get the same or similar error on a subsequent read().

<nod> I /could/ write up some tests to make sure that happens.

> > <shrug> I don't know if regular (i.e. non-verity) xattrs are one of the
> > things that get frozen by verity?  Storing fsverity metadata in private
> > namespace xattrs is unique to xfs.
> 
> No, verity only covers file contents, no other metadata.  This is one
> of the rationales for composefs (e.g. ensuring things like the suid
> bit, security.selinux xattr etc. are covered as well as in general
> complete filesystem trees).
> 
> >> I hesitate to say it but maybe there should be some ioctl for online
> >> repair use cases only, or perhaps a new O_NOVERITY special flag to
> >> openat2()?
> >
> > "openat2 but without meddling from the VFS"?  Tempting... ;)
> 
> Or really any lower level even filesystem-specific API for the online
> fsck case.  Adding a blanket new special case for all CAP_SYS_ADMIN
> processes covers a lot of things that don't need that.

I suppose there could be an O_NOVALIDATION to turn off data checksum
validation on btrfs/bcachefs too.  But then you'd want to careful
controls on who gets to use it.  Maybe not liblzma_la-crc64-fast.o.

--D

