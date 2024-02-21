Return-Path: <linux-fsdevel+bounces-12283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF585E3E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB701F22D8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92983A0C;
	Wed, 21 Feb 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0LQ+lQN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED508120C;
	Wed, 21 Feb 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534832; cv=none; b=qutG271cqNDb3tJrUIEhsIumxWmzD9n3pwnZ8ggkk9yKDtV2vlLtIcxiygpfxPGQOH5VGlNAYGKEMb6jXuCoH4SSmbjsXOtMt5kelQT8vDJo7ZDVESoGq2AH6qlbWiorClIAZ+Tp7AaMg26l/c6ENoeEgUC9of/y4R2yunC3dFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534832; c=relaxed/simple;
	bh=iGVZ/N3krdQEpR2YIqJ2azORXnLZSoYtAOSEv6DTkVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUwghT5xLXhSPD9LV0Ulu3CrsTKNn2ray94E7PNzvRWP+1kwX9HHvneOPgX4e4uF/GK6zuYik7egD8KJJI/S5N0fkONSkRae6rDi3p1ZbXrD0rldTz5eYaeNuVtrKD+JOPtNYTigNo04rl/iGaC6KHrRL3uQpTewphKSK46sQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0LQ+lQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38187C433F1;
	Wed, 21 Feb 2024 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708534832;
	bh=iGVZ/N3krdQEpR2YIqJ2azORXnLZSoYtAOSEv6DTkVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0LQ+lQNyUBqL3xZxjWQwXIYmMJ4Mc61P182iU00QTi9UpVH4rUWh/I8wtg4/ZqRK
	 blVj+fKKQ25YyDt1zWlvxqQywOM+LKbrkox8kN0n0gnsxFmUdOai6aJsyWgITJBQoK
	 nJuMm6+a+GSjbYPTRlnbx1fJhge5k1nFG6g87v6CCUjBZc3345UD+R+0o4cZzqSZDc
	 TyaLFg889IY/i64SNfTSJXc8Y//sI0e6gymKeCB9bYsh/aL1cWbj6zhV58/D+xn4NB
	 1NVef/M6RfDMaELFPHF/IWDBsO16gWf11Jcl86DSY+vThpY+eSfvxMdGRKG5d5ICXZ
	 qIPyCDKxcU1pQ==
Date: Wed, 21 Feb 2024 09:00:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 6/6] fs: xfs: Set FMODE_CAN_ATOMIC_WRITE for
 FS_XFLAG_ATOMICWRITES set
Message-ID: <20240221170031.GI6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-7-john.g.garry@oracle.com>
 <20240202180619.GK6184@frogsfrogsfrogs>
 <7e3b9556-f083-4c14-a48f-46242d1c744b@oracle.com>
 <20240213175954.GV616564@frogsfrogsfrogs>
 <b902bee1-fcfd-4542-8a4e-c6b9861828c9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b902bee1-fcfd-4542-8a4e-c6b9861828c9@oracle.com>

On Wed, Feb 14, 2024 at 12:36:40PM +0000, John Garry wrote:
> On 13/02/2024 17:59, Darrick J. Wong wrote:
> > > > Shouldn't we check that the device supports AWU at all before turning on
> > > > the FMODE flag?
> > > Can we easily get this sort of bdev info here?
> > > 
> > > Currently if we do try to issue an atomic write and AWU for the bdev is
> > > zero, then XFS iomap code will reject it.
> > Hmm.  Well, if we move towards pushing all the hardware checks out of
> > xfs/iomap and into whatever goes on underneath submit_bio then I guess
> > we don't need to check device support here at all.
> 
> Yeah, I have been thinking about this. But I was still planning on putting a
> "bdev on atomic write" check here, as you mentioned.
> 
> But is this a proper method to access the bdev for an xfs inode:
> 
> STATIC bool
> xfs_file_can_atomic_write(
> struct xfs_inode *inode)
> {
> 	struct xfs_buftarg *target = xfs_inode_buftarg(inode);
> 	struct block_device *bdev = target->bt_bdev;
> 
> 	if (!xfs_inode_atomicwrites(inode))
> 		return false;
> 
> 	return bdev_can_atomic_write(bdev);
> }

There's still a TOCTOU race problem if the bdev gets reconfigured
between xfs_file_can_atomic_write and submit_bio.

However, if you're only using this to advertise the capability via statx
then I suppose that's fine -- userspace has to have some means of
discovering the ability at all.  Userspace is also inherently racy.

> I do notice the dax check in xfs_bmbt_to_iomap() when assigning iomap->bdev,
> which is creating some doubt?

Do you mean this?

	if (mapping_flags & IOMAP_DAX)
		iomap->dax_dev = target->bt_daxdev;
	else
		iomap->bdev = target->bt_bdev;

The dax path wants dax_dev set so that it can do the glorified memcpy
operation, and it doesn't need (or want) a block device.

--D

> Thanks,
> John
> 

