Return-Path: <linux-fsdevel+bounces-14177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CA7878D14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 03:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E3A1C21197
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 02:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6285779E0;
	Tue, 12 Mar 2024 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lo5mtQDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14020E3;
	Tue, 12 Mar 2024 02:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211402; cv=none; b=FAGmTaBCJ0gT309gxNM3ML+mM77BsNxowPzn9F/iwRavGKHnZqTFuflYh4noUoUTFGz2qucPz2iyJcEqdp4DS6WgichUPBwILRugp06g2+t618hNbt76EOsX3d0Dx580qXlZVJu5YmqaSTxA33BhUgmQK/g8dwvhuRfkwNysfhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211402; c=relaxed/simple;
	bh=J/Q9UmRTh2v7P72a1vGw00fRzsPM7zb0R9gHTCovB/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLCTiPsW0PLOgUyorNWlrqY7gAPqbLSQF99pJHWdwPVO3V+4v6aqLEyKJnvtKDpDlXHBv/QvWOqXTedwizqbllooXkVaKZKu8DU8r0Bpse8ANCmSZRA9pFcv535NMI5YX8WmIDXoMcCKdDjWCGJoeA8FKXd5vPZiKbkP8Q8KEO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo5mtQDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EE6C433C7;
	Tue, 12 Mar 2024 02:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710211402;
	bh=J/Q9UmRTh2v7P72a1vGw00fRzsPM7zb0R9gHTCovB/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lo5mtQDAPz/VA2w3BPG+ICSUw3FcggcBh+FZ3l19QEtg9zTNAtQfc3msxuegOOams
	 xkheFfFY+gA7OdUVHB5P3i8Fjw23Q34OkNp6+WLjKnFJqYrxAV0KnnnFRxAq0Ry+sQ
	 mp/N2VRJtWN/xttig2AUocLQotICsu3NcBxT7JCMZoi1hs2nZtGd0Jh1DhUJdoU70m
	 A9KNTfntDZmTXnbNRzeSOq9fqqdzsItUf2+F4TKNcn9+90+9KmBt4c2Wb5gqmbRTOz
	 XKUGvBdm8DMZxnfT81IqQy9OFLCEFRCOQYWHyGeXfATqCaPiUhvlpNVXM4VfvDypH6
	 ilqYpuovZyglA==
Date: Mon, 11 Mar 2024 19:43:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 11/24] xfs: add XBF_VERITY_SEEN xfs_buf flag
Message-ID: <20240312024320.GD1182@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-13-aalbersh@redhat.com>
 <20240307224654.GB1927156@frogsfrogsfrogs>
 <ZepxHObVLb3JLCl/@dread.disaster.area>
 <20240308033138.GN6184@frogsfrogsfrogs>
 <20240309162828.GQ1927156@frogsfrogsfrogs>
 <Ze5PsMopkWqZZ1NX@dread.disaster.area>
 <20240311152505.GR1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311152505.GR1927156@frogsfrogsfrogs>

On Mon, Mar 11, 2024 at 08:25:05AM -0700, Darrick J. Wong wrote:
> > > > I wonder, what are the access patterns for merkle blobs?  Is it actually
> > > > sequential, or is more like 0 -> N -> N*N as we walk towards leaves?
> > 
> > I think the leaf level (i.e. individual record) access patterns
> > largely match data access patterns, so I'd just treat it like as if
> > it's a normal file being accessed....
> 
> <nod> The latest version of this tries to avoid letting reclaim take the
> top of the tree.  Logically this makes sense to me to reduce read verify
> latency, but I was hoping Eric or Andrey or someone with more
> familiarity with fsverity would chime in on whether or not that made
> sense.

The levels are stored ordered from root to leaf; they aren't interleaved.  So
technically the overall access pattern isn't sequential, but it is sequential
within each level, and the leaf level is over 99% of the accesses anyway
(assuming the default parameters where each block has 128 children).

It makes sense to try to keep the top levels, i.e. the blocks with the lowest
indices, cached.  (The other filesystems that support fsverity currently aren't
doing anything special to treat them differently from other pagecache pages.)

- Eric

