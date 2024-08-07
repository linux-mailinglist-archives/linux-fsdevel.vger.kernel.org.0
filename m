Return-Path: <linux-fsdevel+bounces-25326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6AA94AC32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F70F1C21755
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8226784A5E;
	Wed,  7 Aug 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghJVU2TF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CCD823DE;
	Wed,  7 Aug 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043576; cv=none; b=ghTNc0KCxmN8bflyoc3ZMCgOyg4Q4H/S/0Yh+3u069vR9Rf0AlvjY4S5G7ihuDk8OfuPRHMjwO2M2gHZmJcFyqGEmajfm71i6dqhOannS3HzccUqvhuxuoWfr7IgnWUF6GSTys6GGJuJSe0D3aMgajashG7k0o3Qi/fttyq2I1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043576; c=relaxed/simple;
	bh=edT9Ll2C0aXQgRu354/92nyX+FLK0NJKdFiGlV9ekCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRhDe8lTKBVmoKIdi+LuWB7UVcagVob6WGOAcFmRaXwDFGZ/fjqmmvN7PJxcl5BvTngjtsI9ylBiI8k9zLSBFDw5yx2MFlGfzMz7cDkpHXKukpVorMNKR8TGG0QrOA3CQ+DFuMSz0DbUfrUEk6L/yO+zYndfXeCrNMlrxPeqSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghJVU2TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CB4C32781;
	Wed,  7 Aug 2024 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723043575;
	bh=edT9Ll2C0aXQgRu354/92nyX+FLK0NJKdFiGlV9ekCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghJVU2TFPplw6CoTGLAsUiCcRTrSz4lq2VV49XXD+NvBiFKU8Pav6e4QpVhoqaCwW
	 AnL3ND2BnmajPsy0mVQG2scRJpiwv283iVTptmQjoM/hrLrESe99MkGv4vjKoDgR71
	 h5wqp9Y/sltoP7+dnnzwvJGDvMhSdN/1in/4mT+hJ4lottWbN7tOU6OjGwIoBHig5D
	 3SPWEzq//pOhpSllm7hwvu6GS71XbNmcaxnbhwY0stDBo3fAK+bB8JzEEe7f9cx53y
	 Ku6MVKGXpVCm9QZyU22AZSB+5OnlfCjqEpmq08eM1PKp7QXNHpuuVGeObUdikfehBC
	 FfntjYe66QYuw==
Date: Wed, 7 Aug 2024 08:12:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 10/14] xfs: Do not free EOF blocks for forcealign
Message-ID: <20240807151254.GG6051@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-11-john.g.garry@oracle.com>
 <20240806192441.GM623936@frogsfrogsfrogs>
 <f39d240b-7abe-45d6-9d87-553ce8c6cf41@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39d240b-7abe-45d6-9d87-553ce8c6cf41@oracle.com>

On Wed, Aug 07, 2024 at 01:33:49PM +0100, John Garry wrote:
> > > +void
> > > +xfs_roundout_to_alloc_fsbsize(
> > > +	struct xfs_inode	*ip,
> > > +	xfs_fileoff_t		*start,
> > > +	xfs_fileoff_t		*end)
> > > +{
> > > +	unsigned int		blocks = xfs_inode_alloc_fsbsize(ip);
> > > +
> > > +	if (blocks == 1)
> > > +		return;
> > > +	*start = rounddown_64(*start, blocks);
> > > +	*end = roundup_64(*end, blocks);
> > > +}
> > 
> > This is probably going to start another round of shouting, but I think
> > it's silly to do two rounding operations when you only care about one
> > value.
> 
> Sure, but the "in" version does use the 2x values and I wanted to be
> consistent. Anyway, I really don't feel strongly about this.
> 
> > In patch 12 it results in a bunch more dummy variables that you
> > then ignore.
> > 
> > Can't this be:
> > 
> > static inline xfs_fileoff_t
> > xfs_inode_rounddown_alloc_unit(
> 
> Just a question about the naming:
> xfs_inode_alloc_unitsize() returns bytes, so I would expect
> xfs_inode_rounddown_alloc_unit() to deal in bytes. Would you be satisfied
> with xfs_rounddown_alloc_fsbsize()? Or any other suggestion?

xfs_fileoff_t is the unit for file logical blocks, no need to append
stuff to the name.  It's clear that this function takes a file block
offset and returns another one.  If we need a second function for file
byte offsets then we can add another function and maybe wrap the whole
mess in _Generic.

--D

> > 	struct xfs_inode	*ip,
> > 	xfs_fileoff		off)
> > {
> > 	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
> > 
> > 	if (rounding == 1)
> > 		return off;
> > 	return rounddown_64(off, rounding);
> > }
> > 
> > static inline xfs_fileoff_t
> > xfs_inode_roundup_alloc_unit(
> > 	struct xfs_inode	*ip,
> > 	xfs_fileoff		off)
> > {
> > 	unsigned int		rounding = xfs_inode_alloc_fsbsize(ip);
> > 
> > 	if (rounding == 1)
> > 		return off;
> > 	return roundup_64(off, rounding);
> > }
> > 
> > Then that callsite can be:
> > 
> > 	end_fsb = xfs_inode_roundup_alloc_unit(ip,
> > 			XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip)));
> 
> 
> Thanks,
> John
> 

