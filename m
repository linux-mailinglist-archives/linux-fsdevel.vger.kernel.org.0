Return-Path: <linux-fsdevel+bounces-17688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 390568B1823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4821F259F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDA17C9;
	Thu, 25 Apr 2024 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh4y/h+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E63816;
	Thu, 25 Apr 2024 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005946; cv=none; b=He2UWVTiRLBBbYr3rE5yomNHC1pv6iBw3eUav6DodOL2yFUaBKy4IA4W6VEDFnrmgscnmWJQOqOa41qbM2v7SAHlnlZIPMgM5VXy9DXP0jfKQevOgZLqhd5TBxCZ75v2L0P9dF8ZJbMekOvdpHX0Jn9S+buX+whWMhzBv/cSF6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005946; c=relaxed/simple;
	bh=bVOU6tOiuNXUao4R1yl9Kt8577O5Q/2RVA/VfGBG9oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd6lafCSZTgs94E2E1C1SnjPrLw9TI3PwIaGGP2UPyJstKNklLpbZqyOynZ2fQfB6NfGEFYf0D0Mqkf3k54KZxupd9GoE8Ybr5VJ1fJj8GLISkiavgRyI0Ivox/UoEfqAN1BTG6Ij6r53IWEjhf1SUOydDaIXVJteC0t87PRq9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh4y/h+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7323C113CD;
	Thu, 25 Apr 2024 00:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005945;
	bh=bVOU6tOiuNXUao4R1yl9Kt8577O5Q/2RVA/VfGBG9oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xh4y/h+m/y2LnBrm0pPsghkzZvXdJdnP+Q/nqM937UXIKZCa0FB5uoXlVkot0yCUB
	 3CIPyqQ/uGc4fK6fAKnRsmLdlDRBioFP8UKcnqz0X3wumqTGUBRcavSBNS4vG21hYG
	 ik1XHM7n/N9yg/e3Ev4Ujh6UqgOfQk6Y5/D3u5vV5IakqshBeUEaX400rBMzRvvc6t
	 82nrejF7Q56UgfQBFOmkqfJpBGSxjTmfGn4ZUBN7UdREYJGZqjwUzC8OwM4yuuiZ8X
	 Yta9wBrxP4R8/s2Y8BOiCdVKc4td3y1p0e0pYLxVgofAaleY5rCunFFIqhgH2nQoCj
	 +nrkya7hBBijA==
Date: Wed, 24 Apr 2024 17:45:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
Message-ID: <20240425004545.GU360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
 <20240405025045.GF1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405025045.GF1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:50:45PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:34:45PM -0700, Darrick J. Wong wrote:
> > +/**
> > + * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> > + * @inode: the inode for which the Merkle tree is being built
> 
> This function is actually for inodes that already have fsverity enabled.  So the
> above comment is misleading.

How about:

/**
 * fsverity_merkle_tree_geometry() - return Merkle tree geometry
 * @inode: the inode to query
 * @block_size: size of a merkle tree block, in bytes
 * @tree_size: size of the merkle tree, in bytes
 *
 * Callers are not required to have opened the file.
 */


> > +int fsverity_merkle_tree_geometry(struct inode *inode, unsigned int *block_size,
> > +				  u64 *tree_size)
> > +{
> > +	struct fsverity_info *vi;
> > +	int error;
> > +
> > +	if (!IS_VERITY(inode))
> > +		return -EOPNOTSUPP;
> 
> Maybe use ENODATA, similar to fsverity_ioctl_measure() and
> bpf_get_fsverity_digest().

Done.

> > +
> > +	error = ensure_verity_info(inode);
> > +	if (error)
> > +		return error;
> > +
> > +	vi = fsverity_get_info(inode);
> 
> This can just use 'vi = inode->i_verity_info', since ensure_verity_info() was
> called.

Changed.

> It should also be documented that an open need not have been done on the file
> yet, as this behavior differs from functions like fsverity_get_digest() that
> require that an open was done first.

Done.

--D

> - Eric
> 

