Return-Path: <linux-fsdevel+bounces-69131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE4DC70A7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DCF4E6E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 18:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A8930F7EB;
	Wed, 19 Nov 2025 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycdyx44o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486E2D63F2
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576873; cv=none; b=XRpJUT5mFnJbo4TCzWR5nkL+QOwugosV++UbapEs35I75obvv+WBCozkGgPqLoHsiZEiQcxEDJwtvipdMf0tBudR9MDwgEoHuSuor9Dkyv0QwnB5ltdgEeAAESFYzwbl7q25667hJDuxZVtm7h5+fZC19QXrRDMY6ndqtG9V2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576873; c=relaxed/simple;
	bh=d1J0TyRX/MU+8MC3ZbQpcAVCnLBee4sTjj8CshFsNUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwhBNg+NaYw/ii8B4UNx9hlZJiOZaaxHC2dKIx8fc62mAYWUIcTJ1rH18iuxWOd1D0zDfWlffh8EbNrTDdVv8WV89rvZH02IhQ/1Svc/WNoeKHX3EeDqRGrIeITJ9kT48Spl08bgWvyOr61vIfkRKp/kmxEL81lor8AWDgN6rXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycdyx44o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CA3C4CEF5;
	Wed, 19 Nov 2025 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763576870;
	bh=d1J0TyRX/MU+8MC3ZbQpcAVCnLBee4sTjj8CshFsNUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ycdyx44oJdUQF4s6IiFeyeAV6x3N7MFXErPkjHs1h8yc9Y6yHiluWQZhwQa/qkIVy
	 MQDaT/rm1kxJ7YypFCEDHR8eQwkFS0rWp8ZGx5tcNvF0+WifUVrdy6RHYLleClURPa
	 JcKorO92NXOmlSW8Bdr9QRZb+v8pbcMXS9UXh3i4oa690PHTsgFXuUcsmd25JF3Xtj
	 u6TYTINehSsbSqgseocNkP0BSjgCCB3NloXsywmywMm+PXcxbpg3yj/70Ux0amlmS7
	 5Fs1QZognTObcRtVlitkZ3FfnVfaKO0p6BDtRnJVDwJtYAdheG42IvCSJCTXIAa984
	 ZIaSLtEsMqyVg==
Date: Wed, 19 Nov 2025 10:27:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, brauner@kernel.org,
	hch@infradead.org, bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] iomap: use loff_t for file positions and offsets
 in writeback code
Message-ID: <20251119182750.GD196391@frogsfrogsfrogs>
References: <20251111193658.3495942-1-joannelkoong@gmail.com>
 <20251111193658.3495942-8-joannelkoong@gmail.com>
 <aR08JNZt4e8DNFwb@casper.infradead.org>
 <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yby0ExKeGhSGxjHiYB9zA7z51V2iHdCjHLAn_Vox+x7g@mail.gmail.com>

On Wed, Nov 19, 2025 at 10:10:40AM -0800, Joanne Koong wrote:
> On Tue, Nov 18, 2025 at 7:40 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 11, 2025 at 11:36:56AM -0800, Joanne Koong wrote:
> > > Use loff_t instead of u64 for file positions and offsets to be
> > > consistent with kernel VFS conventions. Both are 64-bit types. loff_t is
> > > signed for historical reasons but this has no practical effect.
> >
> > generic/303       run fstests generic/303 at 2025-11-19 03:27:51
> > XFS: Assertion failed: imap.br_startblock != DELAYSTARTBLOCK, file: fs/xfs/xfs_reflink.c, line: 1569
> > ------------[ cut here ]------------
> > kernel BUG at fs/xfs/xfs_message.c:102!
> > Oops: invalid opcode: 0000 [#1] SMP NOPTI
> > CPU: 8 UID: 0 PID: 2422 Comm: cp Not tainted 6.18.0-rc1-ktest-00035-gb94488503277 #169 NONE
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:assfail+0x3c/0x46
> > Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> > RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> > RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> > RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> > RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> > R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> > R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> > FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  xfs_reflink_remap_blocks+0x259/0x450
> >  xfs_file_remap_range+0xe9/0x3d0
> >  vfs_clone_file_range+0xde/0x460
> >  ioctl_file_clone+0x50/0xc0
> >  __x64_sys_ioctl+0x619/0x9d0
> >  ? do_sys_openat2+0x99/0xd0
> >  x64_sys_call+0xed0/0x1da0
> >  do_syscall_64+0x6a/0x2e0
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7fc4cd34d37b
> > Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
> > RSP: 002b:00007ffeb4734050 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fc4cd34d37b
> > RDX: 0000000000000003 RSI: 0000000040049409 RDI: 0000000000000004
> > RBP: 00007ffeb4734490 R08: 00007ffeb4734660 R09: 0000000000000002
> > R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000001
> > R13: 0000000000000000 R14: 0000000000008000 R15: 0000000000000002
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:assfail+0x3c/0x46
> > Code: c2 e0 cc 40 82 48 89 f1 48 89 fe 48 c7 c7 e3 60 45 82 48 89 e5 e8 e4 fd ff ff 8a 05 16 98 55 01 3c 01 76 02 0f 0b a8 01 74 02 <0f> 0b 0f 0b 5d c3 cc cc cc cc 48 8d 45 10 4c 8d 6c 24 10 48 89 e2
> > RSP: 0018:ffff888111433cf8 EFLAGS: 00010202
> > RAX: 00000000ffffff01 RBX: 0007ffffffffffff RCX: 000000007fffffff
> > RDX: 0000000000000021 RSI: 0000000000000000 RDI: ffffffff824560e3
> > RBP: ffff888111433cf8 R08: 0000000000000000 R09: 000000000000000a
> > R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000001
> > R13: 00000000ffffff8b R14: ffff888105280000 R15: 0007ffffffffffff
> > FS:  00007fc4cd191580(0000) GS:ffff8881f6ccb000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005612bbfade30 CR3: 000000011146c000 CR4: 0000000000750eb0
> > PKRU: 55555554
> > Kernel panic - not syncing: Fatal exception
> > Kernel Offset: disabled
> > ---[ end Kernel panic - not syncing: Fatal exception ]---
> >
> 
> First off, it's becoming clear to me that I didn't test this patchset
> adequately enough. I had run xfstests on fuse but didn't run it on
> XFS. My apologies for that, I should have done that and caught these
> bugs myself, and will certainly do so next time.
> 
> For this test failure, it's because the change from u64 to loff_t is
> overflowing loff_t on xfs. The failure is coming from this line change
> in particular:
> 
> -static unsigned iomap_find_dirty_range(struct folio *folio, u64 *range_start,
> - u64 range_end)
> +static unsigned iomap_find_dirty_range(struct folio *folio, loff_t
> *range_start,
> + loff_t range_end)
> 
> which is called when writing back the folio (in iomap_writeback_folio()).
> 
> I added some printks and it's overflowing because we are trying to
> write back a 4096-byte folio starting at position 9223372036854771712
> (2^63 - 4096) in the file which results in an overflowed end_pos of
> 9223372036854775808 (2^63) when calculating folio_pos + folio_size.
> 
> I'm assuming XFS uses these large folio positions as a sentinel/marker
> and that it's not actually a folio at position 9223372036854771712,
> but either way, this patch doesn't seem viable with how XFS currently
> works and I think it needs to get dropped.

xfs supports 9223372036854775807-byte files, so 0x7FFFFFFFFFFFF000
is a valid location for a folio.

--D

> I'm going to run the rest of the xfstests suite on XFS for this
> patchset series to verify there are no other issues.
> 
> Thanks,
> Joanne

