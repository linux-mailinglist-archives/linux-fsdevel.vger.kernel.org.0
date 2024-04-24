Return-Path: <linux-fsdevel+bounces-17659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C598B1280
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 20:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A73EB2F956
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96716E863;
	Wed, 24 Apr 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NySPGZnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3916DEA7;
	Wed, 24 Apr 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982707; cv=none; b=N6ir+zMPI1eurpuDo42nTqYiM0Kh50vg8hJSr78VFTU5INeCrCua+QeuliYMD5VPmbb5h/19dh4urFsP257DeujjnAXTYtyVhItHCHA9KDOBtprECCfIgxIN9JqEcNJO8nAztvL9ksWdSubnW0EdiQVJyyWEYEUimXGdUwqne7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982707; c=relaxed/simple;
	bh=FOWq/3p+B1FPL+NRzxNchjjgo2vnC2244vADQod+z18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOShdc9TAfg0UMpi82q9aHGXw/+Jug/jP3WWtsMQZGNzJ3c29whze570xGxAalJEeX7aH9i0M7RGBhLlPpKl1l4qkp4BxzUw5M8QE/1AJsV4S1GCf84C4oghMfoc8cyo1Qv8xdNFZ4MdfmL/grHxZ2s+poPLNCC9fYj7hhWjKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NySPGZnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B2DC113CD;
	Wed, 24 Apr 2024 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713982706;
	bh=FOWq/3p+B1FPL+NRzxNchjjgo2vnC2244vADQod+z18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NySPGZnP4R61Tr+jKFalwtQboENZtJF/b8hzYq9a6h5MZPrUl0CXXcmROcPG1l82N
	 ZMO8rpb8A/9aQ4rXo2uTRAM1mUB7WHpyZ2WdhpfPmG+h0gSUd91H0i91DI/fI34Jcg
	 AxnBbirg7QJB2Ec94q2hrFTliTzrfMK+a7YyGEP+JtPtF6UoobRIZXf87fVaFg5NJi
	 Qquialy/jw8weDiWeJCHPF0M9M/boGyB6Xfxv+lnPoY2TbAL942NQ+qPn4lHt6+XNj
	 8KX32u6dWtp6QL5adnk43mJT+viCYOB6PZUBZM1op6GaT/UUfqKg2ev3PCGPuY2Env
	 vNfQ8DEvIe2PA==
Date: Wed, 24 Apr 2024 11:18:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 11/13] fsverity: report validation errors back to the
 filesystem
Message-ID: <20240424181826.GK360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868048.1987804.2771715174385554090.stgit@frogsfrogsfrogs>
 <20240405030911.GI1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405030911.GI1958@quark.localdomain>

On Thu, Apr 04, 2024 at 11:09:11PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:35:32PM -0700, Darrick J. Wong wrote:
> > +	/**
> > +	 * Notify the filesystem that file data validation failed
> > +	 *
> > +	 * @inode: the inode being validated
> > +	 * @pos: the file position of the invalid data
> > +	 * @len: the length of the invalid data
> > +	 *
> > +	 * This is called when fs-verity cannot validate the file contents.
> > +	 */
> > +	void (*fail_validation)(struct inode *inode, loff_t pos, size_t len);
> 
> There is a difference between the file actually being corrupt (mismatching
> hashes) and other problems like disk errors reading from the Merkle tree.
> "Validation failed" is a bit ambiguous, and "cannot validate the file contents"
> even more so.  Do you want only file corruption errors?  If so it may be a good
> idea to call this 'file_corrupt', which would be consistent with the
> "FILE CORRUPTED" error message in fs/verity/verify.c.  Or do you actually want
> all errors?  Either way, it needs to be clarified what is actually meant.

I only want actual file corruption errors -- XFS can handle disk errors
from reading merkle tree blocks on its own.  I'll change this to
file_corrupt.  How's this?

	/**
	 * Notify the filesystem that file data is corrupt.
	 *
	 * @inode: the inode being validated
	 * @pos: the file position of the invalid data
	 * @len: the length of the invalid data
	 *
	 * This function is called when fs-verity cannot validate the file
	 * contents against the merkle tree hashes and logs a FILE CORRUPTED
	 * error message.
	 */
	void (*file_corrupt)(struct inode *inode, loff_t pos, size_t len);

--D

> - Eric
> 

