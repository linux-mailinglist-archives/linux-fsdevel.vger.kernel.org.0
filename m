Return-Path: <linux-fsdevel+bounces-24165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF5F93AA17
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 02:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B18C283A76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 00:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4CF2595;
	Wed, 24 Jul 2024 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2VMoEu+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95478EC0;
	Wed, 24 Jul 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721779452; cv=none; b=Sxzx7NroahLHwxeqpwd9RbPvaoIy3sGpHqhyclfFufvWZlt3g3uL3Ms8GGojyNHo1l7Tzo9Rw2mizAJa1bAhdvdMQ8Y165ryP2ITKCPVhhkX+qcYHfXTGuibt4TU5ni0Nb6kRUGLmBwh+vbFEE+6Ddj0UYGLxzQkLUS8lW5a9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721779452; c=relaxed/simple;
	bh=VPV36HaGUqkbfGoYAsYx5S52gzWNBj88rNBBg/x3J1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9IwxV2LpFa3Egf9wocVQXJ/HexYc+qbkuoswctj8/dEre1Qw4ar6ayc89KvktOm8YhCv//DnLejvla4/houc0zAZxD+83fDlz7fVQ1OGOSyx1giMYquRA+WTa7s4Kd8HTwwuAfuapUCOzMu1VYeefbI6co80hBhy4ODpJ2ssSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2VMoEu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE9BC4AF09;
	Wed, 24 Jul 2024 00:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721779452;
	bh=VPV36HaGUqkbfGoYAsYx5S52gzWNBj88rNBBg/x3J1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o2VMoEu+yIw3BqE4OKhx38JpxBJE9Ca1r6V54m5NJKlxk57mbNM81lnFKln+BRchE
	 4v7WYiWVKIF09ZEyQ4xYkFtQm1ry25xu/hY2A7T6XnrOxH5EVcE+nAloJ61p0Kr/Dz
	 525j9iwtZAZoGkKB5Pg+ofyGdaSNNHZtZE1/sZvKbl4HFtXeAmdCBlgDMoUrK7NpxN
	 wQv+1H5ET4WSnT0s8ucL1sqkR2aVRbDSVWWnVFk09yiX9xMllVTksYR9Tl7kqBnydh
	 0QhZg2SM0WQJKvdFS6+cCleUoZ4QbCBnvF2h56MqCxN6uaKVD9hwwYW1/D98gm2E0j
	 CYKqINaNMp4lQ==
Date: Tue, 23 Jul 2024 17:04:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 07/13] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240724000411.GV612460@frogsfrogsfrogs>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-8-john.g.garry@oracle.com>
 <20240711025958.GJ612460@frogsfrogsfrogs>
 <ZpBouoiUpMgZtqMk@dread.disaster.area>
 <0c502dd9-7108-4d5f-9337-16b3c0952c04@oracle.com>
 <ZqA+6o/fRufaeQHG@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqA+6o/fRufaeQHG@dread.disaster.area>

On Wed, Jul 24, 2024 at 09:38:18AM +1000, Dave Chinner wrote:
> On Thu, Jul 18, 2024 at 09:53:14AM +0100, John Garry wrote:
> > On 12/07/2024 00:20, Dave Chinner wrote:
> > > > > /* Reflink'ed disallowed */
> > > > > +	if (flags2 & XFS_DIFLAG2_REFLINK)
> > > > > +		return __this_address;
> > > > Hmm.  If we don't support reflink + forcealign ATM, then shouldn't the
> > > > superblock verifier or xfs_fs_fill_super fail the mount so that old
> > > > kernels won't abruptly emit EFSCORRUPTED errors if a future kernel adds
> > > > support for forcealign'd cow and starts writing out files with both
> > > > iflags set?
> > > I don't think we should error out the mount because reflink and
> > > forcealign are enabled - that's going to be the common configuration
> > > for every user of forcealign, right? I also don't think we should
> > > throw a corruption error if both flags are set, either.
> > > 
> > > We're making an initial*implementation choice*  not to implement the
> > > two features on the same inode at the same time. We are not making a
> > > an on-disk format design decision that says "these two on-disk flags
> > > are incompatible".
> > > 
> > > IOWs, if both are set on a current kernel, it's not corruption but a
> > > more recent kernel that supports both flags has modified this inode.
> > > Put simply, we have detected a ro-compat situation for this specific
> > > inode.
> > > 
> > > Looking at it as a ro-compat situation rather then corruption,
> > > what I would suggest we do is this:
> > > 
> > > 1. Warn at mount that reflink+force align inodes will be treated
> > > as ro-compat inodes. i.e. read-only.
> > > 
> > > 2. prevent forcealign from being set if the shared extent flag is
> > > set on the inode.
> > > 
> > > 3. prevent shared extents from being created if the force align flag
> > > is set (i.e. ->remap_file_range() and anything else that relies on
> > > shared extents will fail on forcealign inodes).
> > > 
> > > 4. if we read an inode with both set, we emit a warning and force
> > > the inode to be read only so we don't screw up the force alignment
> > > of the file (i.e. that inode operates in ro-compat mode.)
> > > 
> > > #1 is the mount time warning of potential ro-compat behaviour.
> > > 
> > > #2 and #3 prevent both from getting set on existing kernels.
> > > 
> > > #4 is the ro-compat behaviour that would occur from taking a
> > > filesystem that ran on a newer kernel that supports force-align+COW.
> > > This avoids corruption shutdowns and modifications that would screw
> > > up the alignment of the shared and COW'd extents.
> > > 
> > 
> > This seems fine for dealing with forcealign and reflink.
> > 
> > So what about forcealign and RT?
> > 
> > We want to support this config in future, but the current implementation
> > will not support it.
> 
> What's the problem with supporting it right from the start? We
> already support forcealign for RT, just it's a global config 
> under the "big rt alloc" moniker rather than a per-inode flag.
> 
> Like all on-disk format change based features,
> forcealign should add the EXPERIMENTAL flag to the filesystem for a
> couple of releases after merge, so there will be plenty of time to
> test both data and rt dev functionality before removing the
> EXPERIMENTAL flag from it.
> 
> So why not just enable the per-inode flag with RT right from the
> start given that this functionality is supposed to work and be
> globally supported by the rtdev right now? It seems like a whole lot
> less work to just enable it for RT now than it is to disable it...

What needs to be done to the rt allocator, anyway?

I think it's mostly turning off the fallback to unaligned allocation,
just like what was done for the data device allocator, right?  And
possibly tweaking whatever this does:

	/*
	 * Only bother calculating a real prod factor if offset & length are
	 * perfectly aligned, otherwise it will just get us in trouble.
	 */
	div_u64_rem(ap->offset, align, &mod);
	if (mod || ap->length % align) {
		prod = 1;
	} else {
		prod = xfs_extlen_to_rtxlen(mp, align);
		if (prod > 1)
			xfs_rtalloc_align_minmax(&raminlen, &ralen, &prod);
	}


> > In this v2 series, I just disallow a mount for forcealign and RT, similar to
> > reflink and RT together.
> > 
> > Furthermore, I am also saying here that still forcealign and RT bits set is
> > a valid inode on-disk format and we just have to enforce a sb_rextsize to
> > extsize relationship:
> > 
> > xfs_inode_validate_forcealign(
> > 	struct xfs_mount	*mp,
> > 	uint32_t		extsize,
> > 	uint32_t		cowextsize,
> > 	uint16_t		mode,
> > 	uint16_t		flags,
> > 	uint64_t		flags2)
> > {
> > 	bool			rt =  flags & XFS_DIFLAG_REALTIME;
> > ...
> > 
> > 
> > 	/* extsize must be a multiple of sb_rextsize for RT */
> > 	if (rt && mp->m_sb.sb_rextsize && extsize % mp->m_sb.sb_rextsize)
> > 		return __this_address;
> > 
> > 	return NULL;
> > }
> 
> I suspect the logic needs tweaking, but why not just do this right
> from the start?

Do we even allow (i_extsize % mp->m_sb.sb_rextsize) != 0 for realtime
files?  I didn't think we did.

--D

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

