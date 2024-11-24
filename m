Return-Path: <linux-fsdevel+bounces-35716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A19D7764
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71FBB1636A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C213AD11;
	Sun, 24 Nov 2024 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTao2hPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A388376E0;
	Sun, 24 Nov 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732473288; cv=none; b=k6YwHK6qFEKhDlXzyPDiUIfEKDclQxbSSLktHwsUcBTYljMZtPXjrn28ScwmkRJAFRlCRJkLIztZTWF/EkVp6dHrgj9ZddgiG0dAPmQJLrnwEVywqESyMJC+xRApNWqtgINnWFYnaOcwPW04LOyBepk29Qo6PkWFIdKZBPnE2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732473288; c=relaxed/simple;
	bh=cl1Zu0xcmXtHBm1fsA0sKafkjie9H43MlBq8H5G4JDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgxsch87ILNe4hR29n/eetbgLRjPZCzgvERR94pM68Ir9MaApnGVwjiB40GI0Gq4gI8Xi4RT9pi3AUvl25GFegTK9x4x70lHvtlU163HpDtUSjaDufKpJbv55DzXXrSe01P9pt4NcDI0wTHYLQZPAcrVF/hO4FZhI8tHoYMwyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTao2hPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0513FC4CECC;
	Sun, 24 Nov 2024 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732473288;
	bh=cl1Zu0xcmXtHBm1fsA0sKafkjie9H43MlBq8H5G4JDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTao2hPQG5JL2+MpViH9pcDzQ9eFgXvAgJnKhxe0er4A0yb4s3GdlixJofg1c5D2k
	 lw4v+QoXZJdZtQYmIwME4l3TnDG+i9CsqLISxC9yRR+P6TWqRKP4FLKWyX+RQCYz2x
	 9+qmFLQeAVMMGyXbIL01hw3s4uKJqR9ILjkWQPl0Bifh46KMekMbr+kBsTaHBJc/2A
	 prGJ+yRT0eY7x3ULbsWO/2oN3OnzZFynZoQMkSsinPpGXjYcVum0UVMyD5cWS381NE
	 g0XH5/TgcMESL2txoYE2YlI0iwMicgFJtt9OB1hFTVh4pDO620Rxltsbj6q7a1PDV1
	 Pebt/ECmXoMWQ==
Date: Sun, 24 Nov 2024 10:34:47 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [PATCH v4] fs: Fix data race in inode_set_ctime_to_ts
Message-ID: <20241124183447.GP1926309@frogsfrogsfrogs>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>

On Sun, Nov 24, 2024 at 06:56:57PM +0100, Mateusz Guzik wrote:
> On Sun, Nov 24, 2024 at 09:44:35AM -0800, Darrick J. Wong wrote:
> > On Sun, Nov 24, 2024 at 05:42:53PM +0800, Hao-ran Zheng wrote:
> > > A data race may occur when the function `inode_set_ctime_to_ts()` and
> > > the function `inode_get_ctime_sec()` are executed concurrently. When
> > > two threads call `aio_read` and `aio_write` respectively, they will
> > > be distributed to the read and write functions of the corresponding
> > > file system respectively. Taking the btrfs file system as an example,
> > > the `btrfs_file_read_iter` and `btrfs_file_write_iter` functions are
> > > finally called. These two functions created a data race when they
> > > finally called `inode_get_ctime_sec()` and `inode_set_ctime_to_ns()`.
> > > The specific call stack that appears during testing is as follows:
> > > 
> > > ============DATA_RACE============
> > > btrfs_delayed_update_inode+0x1f61/0x7ce0 [btrfs]
> > > btrfs_update_inode+0x45e/0xbb0 [btrfs]
> > > btrfs_dirty_inode+0x2b8/0x530 [btrfs]
> > > btrfs_update_time+0x1ad/0x230 [btrfs]
> > > touch_atime+0x211/0x440
> > > filemap_read+0x90f/0xa20
> > > btrfs_file_read_iter+0xeb/0x580 [btrfs]
> > > aio_read+0x275/0x3a0
> > > io_submit_one+0xd22/0x1ce0
> > > __se_sys_io_submit+0xb3/0x250
> > > do_syscall_64+0xc1/0x190
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > ============OTHER_INFO============
> > > btrfs_write_check+0xa15/0x1390 [btrfs]
> > > btrfs_buffered_write+0x52f/0x29d0 [btrfs]
> > > btrfs_do_write_iter+0x53d/0x1590 [btrfs]
> > > btrfs_file_write_iter+0x41/0x60 [btrfs]
> > > aio_write+0x41e/0x5f0
> > > io_submit_one+0xd42/0x1ce0
> > > __se_sys_io_submit+0xb3/0x250
> > > do_syscall_64+0xc1/0x190
> > > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > 
> > > To address this issue, it is recommended to add WRITE_ONCE
> > > and READ_ONCE when reading or writing the `inode->i_ctime_sec`
> > > and `inode->i_ctime_nsec` variable.
> > 
> > Excuse my ignorance, but how exactly does this annotation fix the race?
> > Does it prevent reordering of the memory accesses or something?  "it is
> > recommended" is not enough for dunces such as myself to figure out why
> > this fixes the problem. :(
> > 
> 
> It prevents the compiler from getting ideas. One hypothetical is
> splitting the load from one asm op to several, possibly resulting a
> corrupted value when racing against an update
> 
> A not hypothethical concerns some like this:
> 	time64_t sec = inode_get_ctime_sec(inode);
> 	/* do stuff with sec */
> 	/* do other stuff */
> 	/* do more stuff sec */
> 
> The compiler might have decided to throw away the read sec value and do
> the load again later. Thus if an update happened in the meantime then
> the code ends up operating on 2 different values, even though the
> programmer clearly intended it to be stable.

<nod> I figured as much, but I wanted the commit message to spell that
out for everybody, e.g. "Use READ_ONCE to force compilers to sample the
ctime values one time only, and WRITE_ONCE to prevent the compiler from
turning one line of code into multiple stores to the same address."

> However, since both sec and nsec are updated separately and there is no
> synchro, reading *both* can still result in values from 2 different
> updates which is a bug not addressed by any of the above. To my
> underestanding of the vfs folk take on it this is considered tolerable.

<nod> This is the other thing -- the commit message refers to preventing
a data race, but there is indeed nothing about access ordering that
prevents /that/ race.  Someone not an fs developer could interpret that
as "the patch does not fully fix all possible problems" whereas the
community has decided there's an acceptable tradeoff with not taking
i_rwsem.

--D

