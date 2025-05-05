Return-Path: <linux-fsdevel+bounces-48094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4609EAA95CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E03C17A77E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D025B69D;
	Mon,  5 May 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5xL6MAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644025A646;
	Mon,  5 May 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455167; cv=none; b=oGJgUYP7ubWItEnQYbDdj8d0Ed8x+Xdvg/9uXs0T7lkUT1+Y6iq/Y6ONgON84PTQbtwBk9yYwlPciIL0cQqQzGmT+GIcDXzTeZBpAy1N+g+sdqG51b8uTuceiluUo+kfMPudvjAYX05MzTyiXgH438699ewCXmQM39bxho7pwkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455167; c=relaxed/simple;
	bh=ORf5T6DyIpU2ggmib2GrVIAMXQW+GcCXEhexCw0dD7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uw9mHwRzoJdHZrfmchoNIPB/VPKkM6qTW7s1X9k48V+n3gQ7lAfEVOXyHztl2bhVwcKsHF2ZydhoLjChpQAccP80q7B3WUiuJwO5iCYDE3UaPmhVvhiP9gGbAsy1SipeTxfAI1Coz3WpapfjNriQcCs5O1jt5rzETaPBRziZ7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5xL6MAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF975C4CEE4;
	Mon,  5 May 2025 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746455165;
	bh=ORf5T6DyIpU2ggmib2GrVIAMXQW+GcCXEhexCw0dD7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5xL6MAGJA7Om9o5vIMnY5S4yM6ykW0pNMlqCtzCgD9wjwMH2YZmz8/mFqBXQScHc
	 h8SVSjlVAv66C4AEpNIO3WMK/aArHq0A64BEnHPIkCZy5o5bCdTUUepzIeahZ4NOug
	 w6u7PMwI5Pi+zuataeTVcktGi/CqfrrB3KLkJyo3epOIJY39tC8XEtFm3iqdRaRj+u
	 HhWItV2pqPj5nNulhJMwkh2Ce8jacCz8tPE6CPghbM4vXTD+7zgew9de2Qe9GfbIQ3
	 Ze/QmVx4yYpfUAVYHTcDw1GsjBDqQkA86bnhtFmK6uGwb7jJGnJ9PCdiimLcP60+eQ
	 PLTVJ8kj6aK/w==
Date: Mon, 5 May 2025 07:26:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
	cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v11 14/16] xfs: add xfs_calc_atomic_write_unit_max()
Message-ID: <20250505142605.GI1035866@frogsfrogsfrogs>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
 <20250504085923.1895402-15-john.g.garry@oracle.com>
 <20250505052534.GX25675@frogsfrogsfrogs>
 <2a5688e8-88ef-4224-b757-af5adfca1be1@oracle.com>
 <9d5d7037-6ed7-4c61-afec-8422d656de37@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d5d7037-6ed7-4c61-afec-8422d656de37@oracle.com>

On Mon, May 05, 2025 at 09:02:31AM +0100, John Garry wrote:
> On 05/05/2025 07:08, John Garry wrote:
> > On 05/05/2025 06:25, Darrick J. Wong wrote:
> > > Ok so I even attached the reply to the WRONG VERSION.  Something in
> > > these changes cause xfs/289 to barf up this UBSAN warning, even on a
> > > realtime + rtgroups volume:
> 
> Could this just be from another mount (of not a realtime + rtgroups xfs
> instance)?

Quite possibly.

> > > 
> > > [ 1160.539004] ------------[ cut here ]------------
> > > [ 1160.540701] UBSAN: shift-out-of-bounds in /storage/home/djwong/
> > > cdev/work/linux-djw/include/linux/log2.h:67:13
> > > [ 1160.544597] shift exponent 4294967295 is too large for 64-bit
> > > type 'long unsigned int'
> > > [ 1160.547038] CPU: 3 UID: 0 PID: 288421 Comm: mount Not tainted
> > > 6.15.0-rc5-djwx #rc5 PREEMPT(lazy)
> > > 6f606c17703b80ffff7378e7041918eca24b3e68
> > > [ 1160.547045] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > > 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
> > > [ 1160.547047] Call Trace:
> > > [ 1160.547049]  <TASK>
> > > [ 1160.547051]  dump_stack_lvl+0x4f/0x60
> > > [ 1160.547060]  __ubsan_handle_shift_out_of_bounds+0x1bc/0x380
> > > [ 1160.547066]  xfs_set_max_atomic_write_opt.cold+0x22d/0x252 [xfs
> > > 1f657532c3dee9b1d567597a31645929273d3283]
> > > [ 1160.547249]  xfs_mountfs+0xa5c/0xb50 [xfs
> > > 1f657532c3dee9b1d567597a31645929273d3283]
> > > [ 1160.547434]  xfs_fs_fill_super+0x7eb/0xb30 [xfs
> > > 1f657532c3dee9b1d567597a31645929273d3283]
> > > [ 1160.547616]  ? xfs_open_devices+0x240/0x240 [xfs
> > > 1f657532c3dee9b1d567597a31645929273d3283]
> > > [ 1160.547797]  get_tree_bdev_flags+0x132/0x1d0
> > > [ 1160.547801]  vfs_get_tree+0x17/0xa0
> > > [ 1160.547803]  path_mount+0x720/0xa80
> > > [ 1160.547807]  __x64_sys_mount+0x10c/0x140
> > > [ 1160.547810]  do_syscall_64+0x47/0x100
> > > [ 1160.547814]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > [ 1160.547817] RIP: 0033:0x7fde55d62e0a
> > > [ 1160.547820] Code: 48 8b 0d f9 7f 0c 00 f7 d8 64 89 01 48 83 c8 ff
> > > c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
> > > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c6 7f 0c 00 f7 d8 64
> > > 89 01 48
> > > [ 1160.547823] RSP: 002b:00007fff11920ce8 EFLAGS: 00000246 ORIG_RAX:
> > > 00000000000000a5
> > > [ 1160.547826] RAX: ffffffffffffffda RBX: 0000556a10cd1de0 RCX:
> > > 00007fde55d62e0a
> > > [ 1160.547828] RDX: 0000556a10cd2010 RSI: 0000556a10cd2090 RDI:
> > > 0000556a10ce2590
> > > [ 1160.547829] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > > 00007fff11920d50
> > > [ 1160.547830] R10: 0000000000000000 R11: 0000000000000246 R12:
> > > 0000556a10ce2590
> > > [ 1160.547832] R13: 0000556a10cd2010 R14: 00007fde55eca264 R15:
> > > 0000556a10cd1ef8
> > > [ 1160.547834]  </TASK>
> > > [ 1160.547835] ---[ end trace ]---
> > > 
> > > John, can you please figure this one out, seeing as it's 10:30pm on
> > > Sunday night here?
> 
> 
> I could recreate this.
> 
> > 
> 
> I think that we need this change:
> 
> @@ -715,6 +716,9 @@ static inline xfs_extlen_t
> xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
>  {
>         struct xfs_groups       *rgs = &mp->m_groups[XG_TYPE_RTG];
> 
> +       if (rgs->blocks == 0)
> +               return 0;
>         if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
>                 return max_pow_of_two_factor(rgs->blocks);
>         return rounddown_pow_of_two(rgs->blocks);
> 
> My xfs/289 problem goes away with this change.

Ok good.

--D

> 
> > 
> 
> 

