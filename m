Return-Path: <linux-fsdevel+bounces-12651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE32862299
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 05:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E638E1C220B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 04:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA2168A9;
	Sat, 24 Feb 2024 04:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI5zVrCS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123314013;
	Sat, 24 Feb 2024 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708748311; cv=none; b=oFOGYvyXTfEIDSB0HXaQyvXbPh1kvLjPWyT4mN2fE+vPNtf1Ec0W0Ffeoh4Cci7Oas99Sxg7Vg+1bqukxXgs1UQKerxcsh/HiMpWAcVgPDdRtZO8kShMioqBoEV5bSK4fsWTSH59fKzEYMnYRtkHSFGLIcmD0GBC6fATrWaOkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708748311; c=relaxed/simple;
	bh=PlOmuFhugEwwRV6cuY7RCU8BXAR4nueeMtbiA2O68Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBwtpvPmPC5fFshKsz3bnF5DhKnXt/Z3GbxLPskdUMI4FRYDnSJC0wqrV6L3Gru5RsIEjJuuDBawqApy2rPxnrdKJZ/owEFHqJ+8cdaxueGzMu3sP3QOsKNBzk2UCihZY9IRLnElMwBGmUACB1+aFiM7ihaiL2xSDuBVh3DeUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI5zVrCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE431C433C7;
	Sat, 24 Feb 2024 04:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708748310;
	bh=PlOmuFhugEwwRV6cuY7RCU8BXAR4nueeMtbiA2O68Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dI5zVrCSJkhKhvZL66iKGt5qW9XRFwbM3LAXpnKm91wdxJ7id/P3Ay+NHaF39zKW1
	 xr02bKBnmI2u71g5MldyqRHEEVjlmluG7xkUDpYjwGYw0P/yd/1RBVb3NkQ9Ki/K5Y
	 6H7sCJe8p6kFWmqX4nQKJVaErmdqsXm1okBy/DHID3qU4FEBUKt7mxfrNXJwSeA5EZ
	 IInQkbvL9FIyLoXGy3DYV6RpCzgxUn7a6NgQGw/xm5/naL90M89uQjwikNL7/RVDOt
	 gySUvsirys0x9s7+FQ+KcHTPPUlLwsm2w20jtjwzAsXgupy1ZS1G6em78HWZyIzJpK
	 /VMA3a+VILYaA==
Date: Fri, 23 Feb 2024 20:18:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
Message-ID: <20240224041830.GK6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
 <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
 <20240213175954.GV616564@frogsfrogsfrogs>
 <b902bee1-fcfd-4542-8a4e-c6b9861828c9@oracle.com>
 <20240221170031.GI6184@frogsfrogsfrogs>
 <f7ad3aed-3482-4eee-8c81-8e471916ef82@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7ad3aed-3482-4eee-8c81-8e471916ef82@oracle.com>

On Wed, Feb 21, 2024 at 05:38:39PM +0000, John Garry wrote:
> On 21/02/2024 17:00, Darrick J. Wong wrote:
> > > > Hmm.  Well, if we move towards pushing all the hardware checks out of
> > > > xfs/iomap and into whatever goes on underneath submit_bio then I guess
> > > > we don't need to check device support here at all.
> > > Yeah, I have been thinking about this. But I was still planning on putting a
> > > "bdev on atomic write" check here, as you mentioned.
> > > 
> > > But is this a proper method to access the bdev for an xfs inode:
> > > 
> > > STATIC bool
> > > xfs_file_can_atomic_write(
> > > struct xfs_inode *inode)
> > > {
> > > 	struct xfs_buftarg *target = xfs_inode_buftarg(inode);
> > > 	struct block_device *bdev = target->bt_bdev;
> > > 
> > > 	if (!xfs_inode_atomicwrites(inode))
> > > 		return false;
> > > 
> > > 	return bdev_can_atomic_write(bdev);
> > > }
> > There's still a TOCTOU race problem if the bdev gets reconfigured
> > between xfs_file_can_atomic_write and submit_bio.
> 
> If that is the case then a check in the bio submit path is required to catch
> any such reconfigure problems - and we effectively have that in this series.
> 
> I am looking at change some of these XFS bdev_can_atomic_write() checks, but
> would still have a check in the bio submit path.

<nod> "check in the bio submit path" sounds good to me.  Adding in
redundant checks which are eventually gated on whatever submit_bio does
sounds like excessive overhead and layering violations.

> > 
> > However, if you're only using this to advertise the capability via statx
> > then I suppose that's fine -- userspace has to have some means of
> > discovering the ability at all.  Userspace is also inherently racy.
> > 
> > > I do notice the dax check in xfs_bmbt_to_iomap() when assigning iomap->bdev,
> > > which is creating some doubt?
> > Do you mean this?
> > 
> > 	if (mapping_flags & IOMAP_DAX)
> > 		iomap->dax_dev = target->bt_daxdev;
> > 	else
> > 		iomap->bdev = target->bt_bdev;
> > 
> > The dax path wants dax_dev set so that it can do the glorified memcpy
> > operation, and it doesn't need (or want) a block device.
> 
> Yes, so proper to use target->bt_bdev for checks for bdev atomic write
> capability, right?

Right.  fsdax doesn't support atomic memcpy to pmem.

--D

> 
> Thanks,
> John
> 
> 

