Return-Path: <linux-fsdevel+bounces-17665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E7C8B132B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0078B2686E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413981CFA9;
	Wed, 24 Apr 2024 19:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcJOt3on"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571619479;
	Wed, 24 Apr 2024 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985410; cv=none; b=oJYPHJZpdZnjOBy4hp5sK0rM17Al5MJ07Hz2XZcHzn58o1urUBhykEIh+L/f347ddIZ1QGk2+zVL5Cqqi5EaMM2MAEV9Zzt7HTA9R9DEfaE9+SjOpJnX0IFPAuA3VMeha0XVj3CsSRlNqjPbHlm5hxNwzyZzf4Mnm+irgVoapd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985410; c=relaxed/simple;
	bh=PUyA8MCfLWIb2MZ3Fzmz6V19VUZvvJyQjpKg/ngvXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZR3i7a+fPhIzn6XdlsU9lxnSfvt1ZNDECd2iZcBS7sm9JtbsCQwajj8mK4gPgoIpSl07E6b8kTyuV83Dn0KW12DTn7FVSxcXpI0NIHtvufe8tAUCdq4fPwsVpjBNTImcJ+tk6+5h/GMxfJN1Ru599wJ0oAOyGiX6WyKH+7SGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcJOt3on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0919EC113CD;
	Wed, 24 Apr 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985410;
	bh=PUyA8MCfLWIb2MZ3Fzmz6V19VUZvvJyQjpKg/ngvXYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OcJOt3onuV9o06zeIa8SeOJbwYhe97t3nchqoYPofvj+buZ5DgXJESeHd18kDgaW5
	 cSBfla/rd4/o6bFXitn77Y8EIYPNXC5hqZahJPoGyy5mzVJnLC5vzolygGbolVCzYI
	 cUuBhIN1cP6xQw0Vy3Lo1YyjSFRs02dv+xpqDepythb9CFZBUZQWZb1pmWmGt3TsIk
	 K5sf/UTOYfeNAnCBFpz2QjV7dp/5dgYsYYq6ZlJ5sTBuL+TusQpoOkbHEvQrYkjYkp
	 GbpBBjPrgvXGeBT8EqLtAkC/o+58vw+wXflB1xL+1ZEbgd6G9GK3smkeM3mxK5LcGb
	 eMSLG8e37C0Uw==
Date: Wed, 24 Apr 2024 12:03:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 11/13] fsverity: report validation errors back to the
 filesystem
Message-ID: <20240424190329.GM360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>
 <20240405030911.GI1958@quark.localdomain>
 <20240424181826.GK360919@frogsfrogsfrogs>
 <20240424185230.GB693059@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424185230.GB693059@google.com>

On Wed, Apr 24, 2024 at 06:52:30PM +0000, Eric Biggers wrote:
> On Wed, Apr 24, 2024 at 11:18:26AM -0700, Darrick J. Wong wrote:
> > On Thu, Apr 04, 2024 at 11:09:11PM -0400, Eric Biggers wrote:
> > > On Fri, Mar 29, 2024 at 05:35:32PM -0700, Darrick J. Wong wrote:
> > > > +	/**
> > > > +	 * Notify the filesystem that file data validation failed
> > > > +	 *
> > > > +	 * @inode: the inode being validated
> > > > +	 * @pos: the file position of the invalid data
> > > > +	 * @len: the length of the invalid data
> > > > +	 *
> > > > +	 * This is called when fs-verity cannot validate the file contents.
> > > > +	 */
> > > > +	void (*fail_validation)(struct inode *inode, loff_t pos, size_t len);
> > > 
> > > There is a difference between the file actually being corrupt (mismatching
> > > hashes) and other problems like disk errors reading from the Merkle tree.
> > > "Validation failed" is a bit ambiguous, and "cannot validate the file contents"
> > > even more so.  Do you want only file corruption errors?  If so it may be a good
> > > idea to call this 'file_corrupt', which would be consistent with the
> > > "FILE CORRUPTED" error message in fs/verity/verify.c.  Or do you actually want
> > > all errors?  Either way, it needs to be clarified what is actually meant.
> > 
> > I only want actual file corruption errors -- XFS can handle disk errors
> > from reading merkle tree blocks on its own.  I'll change this to
> > file_corrupt.  How's this?
> > 
> > 	/**
> > 	 * Notify the filesystem that file data is corrupt.
> > 	 *
> > 	 * @inode: the inode being validated
> > 	 * @pos: the file position of the invalid data
> > 	 * @len: the length of the invalid data
> > 	 *
> > 	 * This function is called when fs-verity cannot validate the file
> > 	 * contents against the merkle tree hashes and logs a FILE CORRUPTED
> > 	 * error message.
> > 	 */
> > 	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);
> 
> It looks good except for the last sentence, which still has the potentially
> misleading "cannot validate the file contents" wording.  How about something
> like the following:
> 
> "This function is called when fs-verity detects that a portion of a file's data
> is inconsistent with the Merkle tree, or a Merkle tree block needed to validate
> the data is inconsistent with the level above it."

Much better!  I'll change it to that, thank you for the suggestion.

--D

> - Eric
> 

