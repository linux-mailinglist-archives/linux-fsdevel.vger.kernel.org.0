Return-Path: <linux-fsdevel+bounces-25329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A7994ADE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BD12835B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BF137747;
	Wed,  7 Aug 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVf+NKFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462FA131E38;
	Wed,  7 Aug 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047585; cv=none; b=QVPH15O97cM8SQ8CiveEW984QL12F8okS/8SSao09JnytUJpKYSBBzvq7tHim4X7KEsknOty5ogFlc308GomLeT3s/HBzNiTJLDNIytJNoMUj6EvcFc1NC+hFV1EeachZ4lJLUfOt3T2ub6yvLIVXPfHNRL4ExS3xbVc55SNkQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047585; c=relaxed/simple;
	bh=koobHu2VSfpdR59P+3UJi1CotOU281nr2YLgb37Sa78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJ6CF3bH7t4QisGIqB3uPrTydHW5RJYm6sETg20fB7UoqP5b1shMD6piIN3D/OTCz7wJSoQFaA3coIqUEPb0ILFf6lHUoIXC+cbk0t32oDdZE+ua4S6SF/NyNZLa2xO8Cb+6TcfpiuDJKh8ZDsbqubiJ61HOAWSgg9IeMvLtG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVf+NKFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC528C4AF0E;
	Wed,  7 Aug 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723047584;
	bh=koobHu2VSfpdR59P+3UJi1CotOU281nr2YLgb37Sa78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVf+NKFlTm6gf6cZvQRIf/T3SgbS3HFSkaNF0F0fWR2ceLYdvRMLIioaf7TXDxc2C
	 zY/rAsF3syVahcSEmHXk7bjhBpmaZvrLg5qrbxiXvkdDkcI5YBTR+ROA9ytljTt9H4
	 raNWQ5x+tSMawZ0YJJ8Hu+/MAz41Eeyk9vDiaj4c2vaoT7MWpC5aFZlLBvg7Zg5Rn/
	 9fZ1uZuZbHesy198XvV020UjK4ptZTif/RnA2wN8NzwyH4wHj8QnsoCDcv0BUeknPR
	 OwAssROsGZ2BaPJGB1i0I8rA1Eb3diugOBXLwxz4eKMko+3dsXozw8CCvoKaqT1uoy
	 vchAn0tyzFW8g==
Date: Wed, 7 Aug 2024 09:19:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 12/14] xfs: Unmap blocks according to forcealign
Message-ID: <20240807161944.GJ6051@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-13-john.g.garry@oracle.com>
 <20240806201438.GP623936@frogsfrogsfrogs>
 <5e4e6fdb-03fe-4541-8f09-8300665551a2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4e6fdb-03fe-4541-8f09-8300665551a2@oracle.com>

On Wed, Aug 07, 2024 at 02:40:36PM +0100, John Garry wrote:
> On 06/08/2024 21:14, Darrick J. Wong wrote:
> > On Thu, Aug 01, 2024 at 04:30:55PM +0000, John Garry wrote:
> > > For when forcealign is enabled, blocks in an inode need to be unmapped
> > > according to extent alignment, like what is already done for rtvol.
> > > 
> > > Change variable isrt in __xfs_bunmapi() to a bool, as that is really what
> > > it is.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/libxfs/xfs_bmap.c | 48 +++++++++++++++++++++++++++++-----------
> > >   fs/xfs/xfs_inode.c       | 16 ++++++++++++++
> > >   fs/xfs/xfs_inode.h       |  2 ++
> > >   3 files changed, 53 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 0c3df8c71c6d..d6ae344a17fc 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -5409,6 +5409,25 @@ xfs_bmap_del_extent_real(
> > >   	return 0;
> > >   }
> > > +static xfs_extlen_t
> > > +xfs_bunmapi_align(
> > > +	struct xfs_inode	*ip,
> > > +	xfs_fsblock_t		fsbno,
> > > +	xfs_extlen_t *off)
> > > +{
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +
> > > +	if (XFS_IS_REALTIME_INODE(ip))
> > > +		return xfs_inode_alloc_fsbsize_align(ip, fsbno, off);
> > > +	/*
> > > +	 * The agbno for the fsbno is aligned to extsize, but the fsbno itself
> > > +	 * is not necessarily aligned (to extsize), so use agbno to determine
> > > +	 * mod+offset to the alloc unit boundary.
> > > +	 */
> > > +	return xfs_inode_alloc_fsbsize_align(ip, XFS_FSB_TO_AGBNO(mp, fsbno),
> > > +					off);
> > > +}
> > > +
> > >   /*
> > >    * Unmap (remove) blocks from a file.
> > >    * If nexts is nonzero then the number of extents to remove is limited to
> > > @@ -5430,7 +5449,8 @@ __xfs_bunmapi(
> > >   	xfs_extnum_t		extno;		/* extent number in list */
> > >   	struct xfs_bmbt_irec	got;		/* current extent record */
> > >   	struct xfs_ifork	*ifp;		/* inode fork pointer */
> > > -	int			isrt;		/* freeing in rt area */
> > > +	bool			isrt;		/* freeing in rt area */
> > > +	bool			isforcealign;	/* forcealign inode */
> > >   	int			logflags;	/* transaction logging flags */
> > >   	xfs_extlen_t		mod;		/* rt extent offset */
> > >   	struct xfs_mount	*mp = ip->i_mount;
> > > @@ -5468,6 +5488,8 @@ __xfs_bunmapi(
> > >   	}
> > >   	XFS_STATS_INC(mp, xs_blk_unmap);
> > >   	isrt = xfs_ifork_is_realtime(ip, whichfork);
> > > +	isforcealign = (whichfork != XFS_ATTR_FORK) &&
> > > +			xfs_inode_has_forcealign(ip);
> > >   	end = start + len;
> > >   	if (!xfs_iext_lookup_extent_before(ip, ifp, &end, &icur, &got)) {
> > > @@ -5486,6 +5508,8 @@ __xfs_bunmapi(
> > >   	extno = 0;
> > >   	while (end != (xfs_fileoff_t)-1 && end >= start &&
> > >   	       (nexts == 0 || extno < nexts)) {
> > > +		xfs_extlen_t off;
> > 
> > I got really confused because I thought this was a file block offset and
> > only after more digging realized that this is a sometimes dummy
> > adjustment variable.
> 
> yeah, I put it here to use the common helper in both callsites
> 
> > 
> > > +
> > >   		/*
> > >   		 * Is the found extent after a hole in which end lives?
> > >   		 * Just back up to the previous extent, if so.
> > > @@ -5519,18 +5543,18 @@ __xfs_bunmapi(
> > >   		if (del.br_startoff + del.br_blockcount > end + 1)
> > >   			del.br_blockcount = end + 1 - del.br_startoff;
> > > -		if (!isrt || (flags & XFS_BMAPI_REMAP))
> > > +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
> > >   			goto delete;
> > > -		mod = xfs_rtb_to_rtxoff(mp,
> > > -				del.br_startblock + del.br_blockcount);
> > > +		mod = xfs_bunmapi_align(ip,
> > > +				del.br_startblock + del.br_blockcount, &off);
> > >   		if (mod) {
> > 
> > Oof.  I don't like how this loop body has the rtx adjustment code
> > inlined into it.  We only use the isrt flag for the one test above.
> > I tried hoisting this into something less gross involving separate
> > adjustment functions but then you have to pass in so many outer
> > variables that it becomes a mess.
> > 
> > The best I can come up with for now is:
> > 
> > 	unsigned int		alloc_fsb = xfs_inode_alloc_fsbsize(ip);
> > 	/* no more isrt/isforcealign bools */
> > 
> > ...
> > 
> > 		if (alloc_fsb == 1 || (flags & XFS_BMAPI_REMAP))
> > 			goto delete;
> 
> ok, good
> 
> > 
> > 		mod = do_div(del.br_startblock + del.br_blockcount,
> > 				alloc_fsb);
> 
> Note that xfs_bunmapi_align() uses agbno for !rt

Right, I forgot about that.  Can we make the name say that we're
computing the offset within an allocunit?  It's not actually aligning
any of its parameters.

static inline unsigned int
xfs_bmap_alloc_unit_offset(
	struct xfs_inode	*ip,
	xfs_fsblock_t		fsbno,
	unsigned int		alloc_fsb)
{
	xfs_agblock_t		agbno;

	if (XFS_IS_REALTIME_INODE(ip))
		return do_div(fsbno, alloc_fsb);

	agbno = XFS_FSB_TO_AGBNO(ip->i_mount, fsbno);
	return agbno % alloc_fsb;
}

		mod = xfs_bmap_alloc_unit_offset(ip,
				del.br_startblock + del.br_blockcount,
				alloc_fsb);

and

		mod = xfs_bmap_alloc_unit_offset(ip, del.br_startblock,
				alloc_fsb);

--D

> 
> > 		if (mod) {
> > 
> > >   			/*
> > > -			 * Realtime extent not lined up at the end.
> > > +			 * Not aligned to allocation unit on the end.
> > >   			 * The extent could have been split into written
> > >   			 * and unwritten pieces, or we could just be
> > >   			 * unmapping part of it.  But we can't really
> > > -			 * get rid of part of a realtime extent.
> > > +			 * get rid of part of an extent.
> > >   			 */
> > >   			if (del.br_state == XFS_EXT_UNWRITTEN) {
> > >   				/*
> > > @@ -5554,7 +5578,7 @@ __xfs_bunmapi(
> > >   			ASSERT(del.br_state == XFS_EXT_NORM);
> > >   			ASSERT(tp->t_blk_res > 0);
> > >   			/*
> > > -			 * If this spans a realtime extent boundary,
> > > +			 * If this spans an extent boundary,
> > >   			 * chop it back to the start of the one we end at.
> > >   			 */
> > >   			if (del.br_blockcount > mod) {
> > > @@ -5571,14 +5595,12 @@ __xfs_bunmapi(
> > >   			goto nodelete;
> > >   		}
> > > -		mod = xfs_rtb_to_rtxoff(mp, del.br_startblock);
> > > +		mod = xfs_bunmapi_align(ip, del.br_startblock, &off);
> > >   		if (mod) {
> > > -			xfs_extlen_t off = mp->m_sb.sb_rextsize - mod;
> > 
> > 		mod = do_div(del.br_startblock, alloc_fsb);
> > 		if (mod) {
> > 			xfs_extlen_t off = alloc_fsb - mod;
> > 
> > At least then you don't need this weird xfs_inode_alloc_fsbsize_align
> > that passes back two xfs_extlen_t arguments.
> 
> Sure, but same point about xfs_bunmapi_align() using agbno. I suppose I can
> just make the change to not have xfs_bunmapi_align() be passed the off
> address pointer, and do the calcation here for off here (as you suggest).
> 
> Thanks,
> John
> 

