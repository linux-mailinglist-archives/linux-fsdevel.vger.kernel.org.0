Return-Path: <linux-fsdevel+bounces-18460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DFF8B929A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B981C212A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CEE168B1E;
	Wed,  1 May 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbMRMmVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79784E15;
	Wed,  1 May 2024 23:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714607591; cv=none; b=E1maIIe3xn8D0Skz/Yef4XEYPYDvyacgUOBzTIX1S/RMZ4ie/JRWC1AiW6v14YouShnWmDlJb6f83uu2Swm4WWYzSsNbNn4pCpCbfo1V2HU++863JfEqal+OYBAJvA8hyTzpZg56C3ggWJTvZtDBBb3XCWhlqPFFDOScAan1Gnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714607591; c=relaxed/simple;
	bh=rHALjmhDn2eakGTTRIV+n62I6oIK/4AWJyxlnXnxY10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aN6/NhYHu46AqBQ0j4WSad4XuYXCrL4ZacAv8/GbXIB2y3TPovpXtI9T99Zmu3gYek3EAL0OwMQ6v3j4iDDeTlZ/O/kkcRmFtFCy7GiZl5Y3bDsFjcgbJRRekM+4VoQbWkPTzT6IGQyfskGvJSgidLn48dVjkA+kkWQZfwO+Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbMRMmVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D282C072AA;
	Wed,  1 May 2024 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714607591;
	bh=rHALjmhDn2eakGTTRIV+n62I6oIK/4AWJyxlnXnxY10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbMRMmVs9NwW2rD82p4kN+osUxHziPBz9ymZ1HvKM8NvZpPHE8i2rCTPCKLIJXqvp
	 MlJabX2OfJiEuLLSAFGnxb4cyS90MG8RnVdyCQVW7hRC9Htg+f/rY2Keh1OHURtDxA
	 ImLteSENVT9/+Doq3hZ0qrXiDlzCQ0ZS1X4Nd3KamtroPDhFMS39CPJU1A/XYCwMhB
	 jrbsNXDNYNKFv8yjrMmWHzVxoZvhbjrr/Aj9vBzTUtXd1tKHiaIeqrLo54bmB8bMM2
	 AzvqOL6EBkVpSvqjyOqkFUDWsmySD2llpN4bbKP4U7hX6zhD0elQUSJE4fTzgBNTib
	 7iJDdD22wN+tA==
Date: Wed, 1 May 2024 16:53:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	chandan.babu@oracle.com, willy@infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
	p.raghav@samsung.com, linux-xfs@vger.kernel.org,
	catherine.hoang@oracle.com
Subject: Re: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
Message-ID: <20240501235310.GP360919@frogsfrogsfrogs>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-13-john.g.garry@oracle.com>
 <ZjGSiOt21g5JCOhf@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjGSiOt21g5JCOhf@dread.disaster.area>

On Wed, May 01, 2024 at 10:53:28AM +1000, Dave Chinner wrote:
> On Mon, Apr 29, 2024 at 05:47:37PM +0000, John Garry wrote:
> > Like we already do for rtvol, only free full extents for forcealign in
> > xfs_free_file_space().
> > 
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > ---
> >  fs/xfs/xfs_bmap_util.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index f26d1570b9bd..1dd45dfb2811 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -847,8 +847,11 @@ xfs_free_file_space(
> >  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
> >  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
> >  
> > -	/* We can only free complete realtime extents. */
> > -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> > +	/* Free only complete extents. */
> > +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
> > +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> > +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> > +	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
> >  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
> >  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
> >  	}
> 
> When you look at xfs_rtb_roundup_rtx() you'll find it's just a one
> line wrapper around roundup_64().

I added this a couple of cycles ago to get ready for realtime
modernization.  That will create a bunch *more* churn in my tree just to
convert everything *back*.

Where the hell were you when that was being reviewed?!!!

NO!  This is pointless busywork!

--D

> So lets get rid of the obfuscation that the one line RT wrapper
> introduces, and it turns into this:
> 
> 	rounding = 1;
> 	if (xfs_inode_has_forcealign(ip)
> 		rounding = ip->i_extsize;
> 	else if (XFS_IS_REALTIME_INODE(ip))
> 		rounding = mp->m_sb.sb_rextsize;
> 
> 	if (rounding > 1) {
> 		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
> 		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
> 	}
> 
> What this points out is that the prep steps for fallocate operations
> also need to handle both forced alignment and rtextsize rounding,
> and it does neither right now.  xfs_flush_unmap_range() is the main
> offender here, but xfs_prepare_shift() also needs fixing.
> 
> Hence:
> 
> static inline xfs_extlen_t
> xfs_extent_alignment(
> 	struct xfs_inode	*ip)
> {
> 	if (xfs_inode_has_forcealign(ip))
> 		return ip->i_extsize;
> 	if (XFS_IS_REALTIME_INODE(ip))
> 		return mp->m_sb.sb_rextsize;
> 	return 1;
> }
> 
> 
> In xfs_flush_unmap_range():
> 
> 	/*
> 	 * Make sure we extend the flush out to extent alignment
> 	 * boundaries so any extent range overlapping the start/end
> 	 * of the modification we are about to do is clean and idle.
> 	 */
> 	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
> 	rounding = max(rounding, PAGE_SIZE);
> 	...
> 
> in xfs_free_file_space()
> 
> 	/*
> 	 * Round the range we are going to free inwards to extent
> 	 * alignment boundaries so we don't free blocks outside the
> 	 * range requested.
> 	 */
> 	rounding = xfs_extent_alignment(ip);
> 	if (rounding > 1 ) {
> 		startoffset_fsb = roundup_64(startoffset_fsb, rounding);
> 		endoffset_fsb = rounddown_64(endoffset_fsb, rounding);
> 	}
> 
> and in xfs_prepare_shift()
> 
> 	/*
> 	 * Shift operations must stabilize the start block offset boundary along
> 	 * with the full range of the operation. If we don't, a COW writeback
> 	 * completion could race with an insert, front merge with the start
> 	 * extent (after split) during the shift and corrupt the file. Start
> 	 * with the aligned block just prior to the start to stabilize the boundary.
> 	 */
> 	rounding = XFS_FSB_TO_B(mp, xfs_extent_alignment(ip));
> 	offset = round_down(offset, rounding);
> 	if (offset)
> 		offset -= rounding;
> 
> Also, I think that the changes I suggested earlier to 
> xfs_is_falloc_aligned() could use this xfs_extent_alignment()
> helper...
> 
> Overall this makes the code a whole lot easier to read and it also
> allows forced alignment to work correctly on RT devices...
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

