Return-Path: <linux-fsdevel+bounces-26920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E895D20D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5F62822E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168F18953F;
	Fri, 23 Aug 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGl+vgph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538771885AF;
	Fri, 23 Aug 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428322; cv=none; b=OFHpjKoeO6BxREJ6rU9yupKpGFsDV+vjhyx6zDxpS+Wib0MJV4O3ks6OnLKjwANKExKL6m2j0rDdK2M7obFdSXa21PfqLo5fUG9nSH/AExv1JzK40P1gONjtelPbzp82oRke3+2klnZGex0p5llpZ+cXoP+H8NywasAeNZAaIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428322; c=relaxed/simple;
	bh=rE1uTKpErbUu5iBsz4kkqwehDvpJ536HFW1GxF/MV4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVUICn3qBggoqNcInhPNW56XpNF/4Ae+ljb2tJubjmVbdKnBPXcsGtzMOwJXN4U1qrXFDOvcd5qz4GPhvt2Foc/y1BzIMBPwU9TKVSoF7CT1bYB/THlC4uzZ20nrx4L4JRp2L9UvLMhAe7rEJbjf6wQLT5CgtbwluDrnNdNyQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGl+vgph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1ABC32786;
	Fri, 23 Aug 2024 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724428321;
	bh=rE1uTKpErbUu5iBsz4kkqwehDvpJ536HFW1GxF/MV4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGl+vgphux+x+jwS02M7ATO5nNsnM+DaMtpFiv+GsHIr6s73yTK/QeM5OGg8vgHIA
	 EVAE/2+Fdy9jn3R3g8R/is8A8PDS54MvOd7+psyP0zq22WfGKuGxzDjPspgw6c2FSf
	 eSaUO0eu8mi06nWaJISx7mM272Pnn3SfmNpdFOLPnLyTWzX9pZ5c5hma7mubC56z0y
	 +JD8O95GfgLa+S3x+PBd9U3ARNs43C2Zz89YaGOHijiz/zVnvJJf/QzPmlbePs6Zkx
	 T6thkW1OfYhybkmsQ3Gie8HMG1aIOHTBY4QJbHcQVWWY5V894/v9NH8rwsVZuoFf9z
	 nx9h85RYTWCSA==
Date: Fri, 23 Aug 2024 08:52:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, chandan.babu@oracle.com, dchinner@redhat.com,
	hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hare@suse.de,
	martin.petersen@oracle.com, catherine.hoang@oracle.com,
	kbusch@kernel.org
Subject: Re: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <20240823155201.GZ865349@frogsfrogsfrogs>
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-8-john.g.garry@oracle.com>
 <20240821171142.GM865349@frogsfrogsfrogs>
 <7c5fdd14-5c59-4292-b4b5-b0d49ba1bce6@oracle.com>
 <20240822204407.GU865349@frogsfrogsfrogs>
 <e0a93440-8f38-46e1-a77f-6a0125ab8cb5@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a93440-8f38-46e1-a77f-6a0125ab8cb5@oracle.com>

On Fri, Aug 23, 2024 at 11:41:07AM +0100, John Garry wrote:
> On 22/08/2024 21:44, Darrick J. Wong wrote:
> > > Do you mean that add a new member to xfs_inode to record this? If yes, it
> > > sounds ok, but we need to maintain consistency (of that member) whenever
> > > anything which can affect it changes, which is always a bit painful.
> > I actually meant something more like:
> > 
> > static bool
> > xfs_file_open_can_atomicwrite(
> > 	struct file		*file,
> > 	struct inode		*inode)
> > {
> > 	struct xfs_inode	*ip = XFS_I(inode);
> > 	struct xfs_mount	*mp = ip->i_mount;
> > 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > 
> > 	if (!(file->f_flags & O_DIRECT))
> > 		return false;
> > 	if (!xfs_inode_has_atomicwrites(ip))
> > 		return false;
> > 	if (mp->m_dalign && (mp->m_dalign % ip->i_extsize))
> > 		return false;
> > 	if (mp->m_swidth && (mp->m_swidth % ip->i_extsize))
> > 		return false;
> > 	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
> > 		return false;
> > 	if (xfs_inode_alloc_unitsize(ip) > target->bt_bdev_awu_max)
> > 		return false;
> > 	return true;
> > }
> 
> ok, but we should probably factor out some duplicated code with helpers,
> like:
> 
> bool xfs_validate_atomicwrites_extsize(struct xfs_mount *mp, uint32_t
> extsize)

xfs_agblock_t extsize, but other than that this looks right to me.

> {
> 	if (!is_power_of_2(extsize))
> 		return false;
> 
> 	/* Required to guarantee data block alignment */
> 	if (mp->m_sb.sb_agblocks % extsize)
> 		return false;
> 
> 	/* Requires stripe unit+width be a multiple of extsize */
> 	if (mp->m_dalign && (mp->m_dalign % extsize))
> 		return false;
> 
> 	if (mp->m_swidth && (mp->m_swidth % extsize))
> 		return false;
> 
> 	return true;
> }
> 
> 
> bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
> {
> 	struct xfs_mount	*mp = ip->i_mount;
> 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> 
> 	if (!(ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES))
> 		return false;
> 	if (!xfs_validate_atomicwrites_extsize(mp, ip->i_extsize))
> 		return false;
> 	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
> 		return false;
> 	if (xfs_inode_alloc_unitsize(ip) > target->bt_bdev_awu_max)
> 		return false;
> 	return true;
> }
> 
> 
> static bool xfs_file_open_can_atomicwrite(
> 	struct inode		*inode,
> 	struct file		*file)
> {
> 	struct xfs_inode	*ip = XFS_I(inode);
> 
> 	if (!(file->f_flags & O_DIRECT))
> 		return false;
> 	return xfs_inode_has_atomicwrites(ip);
> }
> 
> Those helpers can be re-used in xfs_inode_validate_atomicwrites() and
> xfs_ioctl_setattr_atomicwrites().

Looks good to me.

--D

> 
> John
> 
> 

