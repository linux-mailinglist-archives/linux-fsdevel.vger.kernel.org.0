Return-Path: <linux-fsdevel+bounces-41131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A41A2B46B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F091674B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82A323716D;
	Thu,  6 Feb 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbpxy3cj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05933225A52;
	Thu,  6 Feb 2025 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738878846; cv=none; b=rwxAwUnua8D3t9tX+FrmXkBBTUU6Q6ltIO6QG264S8hxccqfwopG21nrHz9sm9f41XNBHWA0BtsDdsw1FtrEt7c8qQc2WmhkInHye/V5n9q6VNV/j5w4+ANhXwrZsmCGcbLq+xwQUICu+bhTLMQhFy/Ziuvu1TIAlYS34ZKDCFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738878846; c=relaxed/simple;
	bh=qsgx0yG3fcFdIMBY6CpY/hBjuwM/XNFWm9F5VbOcvG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2rpI32JZBVw56LfI8/zUDy1H53ACjVBfalZAGBpv30LD43WqrUQxfid39WyJor2TSWHT6VhIXrvwxwVM1qch07VPSCY0J1YD1ChfhTBQ9LCXQ0igQaK4wzqG7B6Ks7GpkL7eztTSB89bKmhdVelHbAljl2NiJswGkGwSmD66us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbpxy3cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC77C4CEDD;
	Thu,  6 Feb 2025 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738878844;
	bh=qsgx0yG3fcFdIMBY6CpY/hBjuwM/XNFWm9F5VbOcvG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nbpxy3cjXe+w4jv96P9uoxABJhsdJXsbL+i+KHnvpgfSzrl77cTAQcYDhpwuO6I3n
	 ZarvMmT5fwIyzcyQXdBlrVdOgdAwztVFn8gWbPj/O4UNRXVDYo/g1fihd8otcsqo1G
	 B9jvcmJp7b8vuOcGMslNsxXofiktfSB2yyqCsZNMtBwjyRkJ7CbpG7NetE1xnmhbql
	 ujj4rZhkaSn8hVips2jsnp0GdRKifF6BVO+shhj/AJ0L7sSsgvLKY+LWQGjG4RdoVe
	 IazMxkX9KLrkrOz5ajF6BN+xuFr+DUmRJ4/fxkZ3iIU84++YgvNWRpu9KQMcFyqYVC
	 HJTQtxBeodVqg==
Date: Thu, 6 Feb 2025 13:54:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 09/10] xfs: Update atomic write max size
Message-ID: <20250206215403.GY21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-10-john.g.garry@oracle.com>
 <20250205194115.GV21808@frogsfrogsfrogs>
 <b2fb57fc-7a3d-496b-8f1e-110814440e5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fb57fc-7a3d-496b-8f1e-110814440e5b@oracle.com>

On Thu, Feb 06, 2025 at 09:15:16AM +0000, John Garry wrote:
> On 05/02/2025 19:41, Darrick J. Wong wrote:
> > On Tue, Feb 04, 2025 at 12:01:26PM +0000, John Garry wrote:
> > > Now that CoW-based atomic writes are supported, update the max size of an
> > > atomic write.
> > > 
> > > For simplicity, limit at the max of what the mounted bdev can support in
> > > terms of atomic write limits. Maybe in future we will have a better way
> > > to advertise this optimised limit.
> > > 
> > > In addition, the max atomic write size needs to be aligned to the agsize.
> > > Currently when attempting to use HW offload, we  just check that the
> > > mapping startblock is aligned. However, that is just the startblock within
> > > the AG, and the AG may not be properly aligned to the underlying block
> > > device atomic write limits.
> > > 
> > > As such, limit atomic writes to the greatest power-of-2 which fits in an
> > > AG, so that aligning to the startblock will be mean that we are also
> > > aligned to the disk block.
> 
> Right, "startblock" is a bit vague
> 
> > 
> > I don't understand this sentence -- what are we "aligning to the
> > startblock"?  I think you're saying that you want to limit the size of
> > untorn writes to the greatest power-of-two factor of the agsize so that
> > allocations for an untorn write will always be aligned compatibly with
> > the alignment requirements of the storage for an untorn write?
> 
> Yes, that's it. I'll borrow your wording :)
> 
> > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_iops.c  |  7 ++++++-
> > >   fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
> > >   fs/xfs/xfs_mount.h |  1 +
> > >   3 files changed, 35 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index ea79fb246e33..95681d6c2bcd 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -606,12 +606,17 @@ xfs_get_atomic_write_attr(
> > >   	unsigned int		*unit_min,
> > >   	unsigned int		*unit_max)
> > >   {
> > > +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +
> > >   	if (!xfs_inode_can_atomicwrite(ip)) {
> > >   		*unit_min = *unit_max = 0;
> > >   		return;
> > >   	}
> > > -	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
> > > +	*unit_min = ip->i_mount->m_sb.sb_blocksize;
> > > +	*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
> > > +					target->bt_bdev_awu_max);
> > >   }
> > >   static void
> > > diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> > > index 477c5262cf91..4e60347f6b7e 100644
> > > --- a/fs/xfs/xfs_mount.c
> > > +++ b/fs/xfs/xfs_mount.c
> > > @@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
> > >   	levels = max(levels, mp->m_rmap_maxlevels);
> > >   	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
> > >   }
> > > +static inline void
> > > +xfs_mp_compute_awu_max(
> > 
> > xfs_compute_awu_max() ?
> 
> ok
> 
> > 
> > > +	struct xfs_mount	*mp)
> > > +{
> > > +	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
> > > +	xfs_agblock_t		awu_max;
> > > +
> > > +	if (!xfs_has_reflink(mp)) {
> > > +		mp->awu_max = 1;
> > > +		return;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Find highest power-of-2 evenly divisible into agsize and which
> > > +	 * also fits into an unsigned int field.
> > > +	 */
> > > +	awu_max = 1;
> > > +	while (1) {
> > > +		if (agsize % (awu_max * 2))
> > > +			break;
> > > +		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
> > > +			break;
> > > +		awu_max *= 2;
> > > +	}
> > > +	mp->awu_max = awu_max;
> > 
> > I think you need two awu_maxes here -- one for the data device, and
> > another for the realtime device.
> How about we just don't support rtdev initially for this CoW-based method,
> i.e. stick at 1x FSB awu max?

I guess, but that's more unfinished business.

--D

> >  The rt computation is probably more
> > complex since I think it's the greatest power of two that fits in the rt
> > extent size if it isn't a power of two;> or the greatest power of two>
> that fits in the rtgroup if rtgroups are enabled; or probably just no
> > limit otherwise.
> >
> 
> Thanks,
> John
> 

