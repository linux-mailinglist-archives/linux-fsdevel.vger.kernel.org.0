Return-Path: <linux-fsdevel+bounces-25315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D8894AA7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F9281D10
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C383CDB;
	Wed,  7 Aug 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJUEnvUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBC82D9A;
	Wed,  7 Aug 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041643; cv=none; b=RbH2c9AatxQK4Eu36tQSP8W79+TCSP1GbNEJ6KcEcd1vp/ct1NXPuXaVOwHllym3gpncGo1EH4feLDe97GpcciM8LBtR7qqIed+yLLJrtjXGNLsZb8NjNIIDRiHRbMp5vK1ioorUX8ryrmx4ZaEo9THAHeYBcL9Qo1mIesFbMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041643; c=relaxed/simple;
	bh=Yp3AmtGCpcU1nG1f/EJmqw8w6DNbUcdzWqWMeZZVk+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsOtzqtly5WvVyEaPnY9WvChox04RVf74czqw5OLV3zpj/4LCtZQa12zUbvKB54pHAuVGWGdNkTVd0V0xG+QnNdq/Yx2+UgcttDTQiJKHwnDSu9oc57BD3501zQIL3vSwdTJ6MAd4ugDVLFU2/0wYZrdOhJFqx7CLXPoLgHJIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJUEnvUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CEBC32781;
	Wed,  7 Aug 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723041643;
	bh=Yp3AmtGCpcU1nG1f/EJmqw8w6DNbUcdzWqWMeZZVk+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJUEnvUgg6dNw2nG5jR9mYavrcK4ovoc9TqrQOD75uafdEY9Zj4BVGXo1P50jKX52
	 6ho2Ok6RYRBsmL4eacYmGDirJRggxQn3e/cScdVrSxM/31cAue1UdEFybQlvcfsF/p
	 pWgoA9cOV+ZLqTtwgy5PSBLMLM3Zypq7QwYLK76226jQqiVHLNOu9TxmXABi8dIeGu
	 0vXwhiaN1wlGkOql9qDSxl28KbjEXC5B6wI7rcC4s6h2FVl/bTmOBoiZMC1KdjH4kk
	 LsUjKH0n7ZemJRv/uzHzadMuHwVNFUwOeZZ38xFNby5z0WXtSm6oqZqtk/rOgjSXHO
	 er1mHaBJYBuuw==
Date: Wed, 7 Aug 2024 07:40:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 07/14] xfs: Introduce FORCEALIGN inode flag
Message-ID: <20240807144042.GB6051@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-8-john.g.garry@oracle.com>
 <20240806190206.GJ623936@frogsfrogsfrogs>
 <5e5d1cfa-e003-4a9a-9bd3-516616e1edbf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e5d1cfa-e003-4a9a-9bd3-516616e1edbf@oracle.com>

On Wed, Aug 07, 2024 at 12:42:32PM +0100, John Garry wrote:
> On 06/08/2024 20:02, Darrick J. Wong wrote:
> > On Thu, Aug 01, 2024 at 04:30:50PM +0000, John Garry wrote:
> > > From: "Darrick J. Wong" <djwong@kernel.org>
> > > 
> > > Add a new inode flag to require that all file data extent mappings must
> > > be aligned (both the file offset range and the allocated space itself)
> > > to the extent size hint.  Having a separate COW extent size hint is no
> > > longer allowed.
> > > 
> > > The goal here is to enable sysadmins and users to mandate that all space
> > > mappings in a file must have a startoff/blockcount that are aligned to
> > > (say) a 2MB alignment and that the startblock/blockcount will follow the
> > > same alignment.
> > > 
> > > Allocated space will be aligned to start of the AG, and not necessarily
> > > aligned with disk blocks. The upcoming atomic writes feature will rely and
> > > forcealign and will also require allocated space will also be aligned to
> > > disk blocks.
> > > 
> > > reflink will not be supported for forcealign yet, so disallow a mount under
> > > this condition. This is because we have the limitation of pageache
> > > writeback not knowing how to writeback an entire allocation unut, so
> > > reject a mount with relink.
> > > 
> > > RT vol will not be supported for forcealign yet, so disallow a mount under
> > > this condition. It will be possible to support RT vol and forcealign in
> > > future. For this, the inode extsize must be a multiple of rtextsize - this
> > > is enforced already in xfs_ioctl_setattr_check_extsize() and
> > > xfs_inode_validate_extsize().
> > > 
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > Co-developed-by: John Garry <john.g.garry@oracle.com>
> > > [jpg: many changes from orig, including forcealign inode verification
> > >   rework, ioctl setattr rework disallow reflink a forcealign inode,
> > >   disallow mount for forcealign + reflink or rt]
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > 
> > This patch looks ready to me but as I'm the original author I cannot add
> > a RVB tag.  Someone else needs to add that -- frankly, John is the best
> > candidate because he grabbed my patch into his tree and actually
> > modified it to do what he wants, which means he's the most familiar with
> > it.
> 
> I thought my review would be implied since I noted how I appended it, above.
> 
> Anyway,
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> I am hoping that Dave and Christoph will give some formal ack/review when
> they get a chance.
> 
> BTW, at what stage do we give XFS_SB_FEAT_RO_COMPAT_FORCEALIGN a more proper
> value? So far it has the experimental dev value of 1 << 30, below.

When you're ready for the release manager to merge it, change the value,
resend the entire series for archival purposes, and send a pull request.

--D

> Thanks!
> 
> 
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> > > index e1bfee0c3b1a..95f5259c4255 100644
> > > --- a/fs/xfs/libxfs/xfs_format.h
> > > +++ b/fs/xfs/libxfs/xfs_format.h
> > > @@ -352,6 +352,7 @@ xfs_sb_has_compat_feature(
> > >   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
> > >   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
> > >   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> > > +#define XFS_SB_FEAT_RO_COMPAT_FORCEALIGN (1 << 30)	/* aligned file data extents */
> > >   #define XFS_SB_FEAT_RO_COMPAT_ALL \
> > >   		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
> > >   		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
> 

