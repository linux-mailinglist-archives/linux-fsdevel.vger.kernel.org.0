Return-Path: <linux-fsdevel+bounces-15951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AE89620B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7201F218E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 01:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208114A9D;
	Wed,  3 Apr 2024 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZq+5m6x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A956D29B;
	Wed,  3 Apr 2024 01:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108093; cv=none; b=Ntu16MXRi6ieojyHKfM6F5AfQmCQSgHiL96rWlBiQZ8hTDI9PUojarDv3O6wyBWYdGNzNA2FmAaF/JNWbRQr4fwrC5QkdFkkgg28ptZkjmT4e1B0GNG8j/1una4s6vfQ59VZ/kvBjFuzFFeLt7rtI8w9HzAyQTNLCj2suNpUHkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108093; c=relaxed/simple;
	bh=ceGda0ijA6CvAkSGPMbv7mwJc0hdj0ZZUAhG5icICyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+FMKZYf6SZAJZW7xUJdBoLH75LpxUrAv9XTbpVa8A8X4297bT6cvVOwI8eWWEBHoLM5aPzRO2Oyl2W9ElUG9UOv+0EHAldyfk0pn3iY/usZs7xLfq2o3KmAIWNo1VYSVGXbT+ungfXAGyx0Begm53OE5o8yekAICne3jQFAfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZq+5m6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA09C433C7;
	Wed,  3 Apr 2024 01:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712108092;
	bh=ceGda0ijA6CvAkSGPMbv7mwJc0hdj0ZZUAhG5icICyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZq+5m6xUxllMFHRdJ4V/2UlJcCbcPA2UPil6WvQkZfqBPHoJ5rX5YfSfUZPzkNLI
	 tSInXpGxYbFKsxF77Vne6gBw1KWGIqCA7235kNEs15l1opgzsN3guxq0JCaqd9A7Fw
	 CMJc3MwVWK2k0PXFfN2flwGA4t4sJB/Y8Fj5hrz+Yd0DKjyfRm9UqjIeCL6QClanAm
	 vGirMLXBzLIM68kuEwRe4u2VYTREVmJnIKFezIuEE9ueQ/eEJ1HHCRxTNo99yfTy8r
	 S5VQZVd+O0EOWrQoQW2mJR9k+gx+vPsgPnnt1tYwBtpBgtv17E97sPg+jnW6j/FJNH
	 yQxh1DBUHgyHQ==
Date: Tue, 2 Apr 2024 18:34:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Colin Walters <walters@verbum.org>, aalbersh@redhat.com,
	xfs <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 28/29] xfs: allow verity files to be opened even if the
 fsverity metadata is damaged
Message-ID: <20240403013452.GF6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175869022.1988170.16501260874882118498.stgit@frogsfrogsfrogs>
 <2afcf2b2-992d-4678-bf68-d70dce0a2289@app.fastmail.com>
 <20240402225216.GW6414@frogsfrogsfrogs>
 <20240402234558.GB2576@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402234558.GB2576@sol.localdomain>

On Tue, Apr 02, 2024 at 04:45:58PM -0700, Eric Biggers wrote:
> On Tue, Apr 02, 2024 at 03:52:16PM -0700, Darrick J. Wong wrote:
> > On Tue, Apr 02, 2024 at 04:00:06PM -0400, Colin Walters wrote:
> > > 
> > > 
> > > On Fri, Mar 29, 2024, at 8:43 PM, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > >
> > > > There are more things that one can do with an open file descriptor on
> > > > XFS -- query extended attributes, scan for metadata damage, repair
> > > > metadata, etc.  None of this is possible if the fsverity metadata are
> > > > damaged, because that prevents the file from being opened.
> > > >
> > > > Ignore a selective set of error codes that we know fsverity_file_open to
> > > > return if the verity descriptor is nonsense.
> > > >
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  fs/iomap/buffered-io.c |    8 ++++++++
> > > >  fs/xfs/xfs_file.c      |   19 ++++++++++++++++++-
> > > >  2 files changed, 26 insertions(+), 1 deletion(-)
> > > >
> > > >
> > > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > > index 9f9d929dfeebc..e68a15b72dbdd 100644
> > > > --- a/fs/iomap/buffered-io.c
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -487,6 +487,14 @@ static loff_t iomap_readpage_iter(const struct 
> > > > iomap_iter *iter,
> > > >  	size_t poff, plen;
> > > >  	sector_t sector;
> > > > 
> > > > +	/*
> > > > +	 * If this verity file hasn't been activated, fail read attempts.  This
> > > > +	 * can happen if the calling filesystem allows files to be opened even
> > > > +	 * with damaged verity metadata.
> > > > +	 */
> > > > +	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
> > > > +		return -EIO;
> > > > +
> > > >  	if (iomap->type == IOMAP_INLINE)
> > > >  		return iomap_read_inline_data(iter, folio);
> > > > 
> > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > > index c0b3e8146b753..36034eaefbf55 100644
> > > > --- a/fs/xfs/xfs_file.c
> > > > +++ b/fs/xfs/xfs_file.c
> > > > @@ -1431,8 +1431,25 @@ xfs_file_open(
> > > >  			FMODE_DIO_PARALLEL_WRITE | FMODE_CAN_ODIRECT;
> > > > 
> > > >  	error = fsverity_file_open(inode, file);
> > > > -	if (error)
> > > > +	switch (error) {
> > > > +	case -EFBIG:
> > > > +	case -EINVAL:
> > > > +	case -EMSGSIZE:
> > > > +	case -EFSCORRUPTED:
> > > > +		/*
> > > > +		 * Be selective about which fsverity errors we propagate to
> > > > +		 * userspace; we still want to be able to open this file even
> > > > +		 * if reads don't work.  Someone might want to perform an
> > > > +		 * online repair.
> > > > +		 */
> > > > +		if (has_capability_noaudit(current, CAP_SYS_ADMIN))
> > > > +			break;
> > > 
> > > As I understand it, fsverity (and dm-verity) are desirable in
> > > high-safety and integrity requirement cases where the goal is for the
> > > system to "fail closed" if errors in general are detected; anything
> > > that would have the system be in an ill-defined state.
> > 
> > Is "open() fails if verity metadata are trashed" a hard requirement?
> > 
> > Reads will still fail due to (iomap) readahead returning EIO for a file
> > that is IS_VERITY() && !fsverity_active().  This is (afaict) the state
> > you end up with when the fsverity open fails.  ext4/f2fs don't do that,
> > but they also don't have online fsck so once a file's dead it's dead.
> > 
> 
> We really should have the same behavior on all filesystems, and that behavior
> should be documented in Documentation/filesystems/fsverity.rst.  I guess you
> want this for XFS_IOC_SCRUB_METADATA?

Yes.  xfs_scrub tries to open every regular file that it can, but if the
fsverity metadata is too badly damaged then the open() returns EMSGSIZE
or EINVAL or something.  The EMSGSIZE is particularly nasty since it's
not listed in the openat() manpage as a possible error code, which
surprised me.

>                                        That takes in an inode number directly,
> in xfs_scrub_metadata::sm_ino; does it even need to be executed on the same file
> it's checking?

<nod> The metadata repairs themselves can use scrub-by-handle mode, so
it's not *so* hard to handle it gracefully.

>                 Anyway, allowing the open means that the case of IS_VERITY() &&
> !fsverity_active() needs to be handled later in any case when I/O may be done to
> the file.  We need to be super careful to ensure that all cases are handled.

I /think/ most everything else is gated on IS_VERITY, right?

> Even just considering this patchset and XFS only, it looks like you got it wrong
> in xfs_file_read_iter().  You're allowing direct I/O to files that have
> IS_VERITY() && !fsverity_active().

Ahaha, yeah, that needs to be changed to:

	else if ((iocb->ki_flags & IOCB_DIRECT) && !IS_VERITY(inode))
		ret = xfs_file_dio_read(iocb, to);

Good catch.

> This change also invalidates the documentation for fsverity_active() which is:
> 
> /**
>  * fsverity_active() - do reads from the inode need to go through fs-verity?
>  * @inode: inode to check
>  *
>  * This checks whether ->i_verity_info has been set.
>  *
>  * Filesystems call this from ->readahead() to check whether the pages need to
>  * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
>  * a race condition where the file is being read concurrently with
>  * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before ->i_verity_info.)
>  *
>  * Return: true if reads need to go through fs-verity, otherwise false
>  */
> 
> I think that if you'd like to move forward with this, it would take a patchset
> that brings the behavior to all filesystems and considers all callers of
> fsverity_active().

<nod> If you think it's a reasonable thing to allow, then I'll of course
apply it to btr/ext4/f2fs.

> Another consideration will be whether the fsverity builtin signature not
> matching the file, not being trusted, or being malformed counts as "the fsverity
> metadata being damaged".

<shrug> Can you easily check that in the open routine?  I figured that
signature validation problems would manifest as read errors.

--D

> - Eric
> 

