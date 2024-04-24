Return-Path: <linux-fsdevel+bounces-17662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B918B12E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3849C1F21183
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D81AACA;
	Wed, 24 Apr 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miO2nvr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061761CD13;
	Wed, 24 Apr 2024 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984752; cv=none; b=NxoZP2HMDqbpRd5qo79w6AC8agEYRB1jKfkNLzN2jXDLdEbU9RhLPtThGfOHZ61U6a6slk4T0Cob3DHJ5nVjcxmt8ROBLs3rsUVEGS5HX8dh9jbwvYVL/ax4SHn57o3iWq3j+vUp7fjBRksCnzeDKp+0VMAb11+n5yb5CL5uZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984752; c=relaxed/simple;
	bh=csF033P0Iegx1PQkAyo0WKuKXVyqATtEopDLBESCLSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9EVDEDc4TTQ333RODNqWszrGjsUmB6bIVEBfbmJTN/F2iNyYcRCCm8gdaczTaBB6wLb8kjQyVbmzDBcTiM2tfuNc1+4yc3SXqBP7aGKWeaHsLibt6qYkRKV36PKQO83MvPr00+d+7aXbavmIjZkTczr1lhCBJs4Oezbb7sQ/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miO2nvr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C73C113CD;
	Wed, 24 Apr 2024 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713984751;
	bh=csF033P0Iegx1PQkAyo0WKuKXVyqATtEopDLBESCLSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miO2nvr7XJh+30y0M8t94mmLI9Hejev2CCfNGs9kRPp5qPIgEVgnJcGt+fZDsP3d7
	 H8Q1DyaheO0JBYyjRW6X2tAs0ck/L3ryqmj3IIMrTF8gZL6pMpw+uragbrPMAYx5O5
	 m/fvtSNeJGaq8NE+ErpEJYg4HbMhm9a/9f4zrrKL/YmgaLc0drO+eZbAsWmKvQFDvr
	 2nCEiPNO1U2Pcn0LQ4cw6o3a0SQ5GOl9kOIOQB7l737B82UoXFLrbtDUEkH6J9/2uo
	 jfm4JQW9lnNf2H9w+nc9z/HmDeUK3EpfB25CdS5SlBCKWviRJKcD8NYGK/ndxtm8Uf
	 Omc4RDMnNv3Kg==
Date: Wed, 24 Apr 2024 18:52:30 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 11/13] fsverity: report validation errors back to the
 filesystem
Message-ID: <20240424185230.GB693059@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>
 <20240405030911.GI1958@quark.localdomain>
 <20240424181826.GK360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424181826.GK360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 11:18:26AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 04, 2024 at 11:09:11PM -0400, Eric Biggers wrote:
> > On Fri, Mar 29, 2024 at 05:35:32PM -0700, Darrick J. Wong wrote:
> > > +	/**
> > > +	 * Notify the filesystem that file data validation failed
> > > +	 *
> > > +	 * @inode: the inode being validated
> > > +	 * @pos: the file position of the invalid data
> > > +	 * @len: the length of the invalid data
> > > +	 *
> > > +	 * This is called when fs-verity cannot validate the file contents.
> > > +	 */
> > > +	void (*fail_validation)(struct inode *inode, loff_t pos, size_t len);
> > 
> > There is a difference between the file actually being corrupt (mismatching
> > hashes) and other problems like disk errors reading from the Merkle tree.
> > "Validation failed" is a bit ambiguous, and "cannot validate the file contents"
> > even more so.  Do you want only file corruption errors?  If so it may be a good
> > idea to call this 'file_corrupt', which would be consistent with the
> > "FILE CORRUPTED" error message in fs/verity/verify.c.  Or do you actually want
> > all errors?  Either way, it needs to be clarified what is actually meant.
> 
> I only want actual file corruption errors -- XFS can handle disk errors
> from reading merkle tree blocks on its own.  I'll change this to
> file_corrupt.  How's this?
> 
> 	/**
> 	 * Notify the filesystem that file data is corrupt.
> 	 *
> 	 * @inode: the inode being validated
> 	 * @pos: the file position of the invalid data
> 	 * @len: the length of the invalid data
> 	 *
> 	 * This function is called when fs-verity cannot validate the file
> 	 * contents against the merkle tree hashes and logs a FILE CORRUPTED
> 	 * error message.
> 	 */
> 	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);

It looks good except for the last sentence, which still has the potentially
misleading "cannot validate the file contents" wording.  How about something
like the following:

"This function is called when fs-verity detects that a portion of a file's data
is inconsistent with the Merkle tree, or a Merkle tree block needed to validate
the data is inconsistent with the level above it."

- Eric

