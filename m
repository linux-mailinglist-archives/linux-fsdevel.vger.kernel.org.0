Return-Path: <linux-fsdevel+bounces-9613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEF78434A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 04:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7B31F24865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 03:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C3F14F7A;
	Wed, 31 Jan 2024 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYl0lesL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDBB182DC;
	Wed, 31 Jan 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672792; cv=none; b=Dkp9vwFQcBCzN4AzjYPYCRZ0sEmvwCDasUx+ti8skUzG8sVK2c5zRvGaEeOwBLGEtcKqbwzSSdEanSPJANiK9d0QPTM+O8QB0N7MOFTtOzbJ2BC67gW7JSsz1uj9SNtMsqxAkK3dToCZnwYi4GJ8X0GXFWwQszI7wrsbvonu8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672792; c=relaxed/simple;
	bh=uBP0xLV0puOMRWgLlE3p7c4/r63hU0vvOrCmsIDP4Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRXzb5hCrtSYiIQVenZZ0g2wCMqWTdToIPEWgw/XSfR4WIAg4tmORSDGeJghbUcIpuxi0nAzg7B7S/+TUpz+FTTvrG3nBGPQT5FS0JGI2G8y6dcxYkKCEiy5Aimfa3UGdrM1neQDAfEs0jEiXUwxXcYv5CeHCG4akKwTddE3K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYl0lesL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B044FC433F1;
	Wed, 31 Jan 2024 03:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706672791;
	bh=uBP0xLV0puOMRWgLlE3p7c4/r63hU0vvOrCmsIDP4Fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYl0lesLcikTc4IbkFpqV46U31I+exMQn6r5lmxWvRyeh+ANn3ptqeNPGrROr2Hke
	 UVwbP/fdstTB9vRuaTjEdhwWuXSbaqXZfID31Xuv/bTVzArU9NrhP7hQY9vO/OVQDr
	 gKzN+41Bsv1SsUcWAfvGst3Dy3t1B9/CqXNSJ0Hp3tIaFy1hYZXDXEbMbn+8Rj9sXY
	 8vKtoHYz5pSpCeTngjZBPRYeDWveMbrImykVe1QNdun5F0PLF4+xANczK9FDECjS5f
	 shsJw82ZEi4glCC9/6wzQdtgn7HCSIKbjb1YAluIt0C6nCb/p3fan7JicG75jOssfj
	 OlUPB+LsMf8aQ==
Date: Tue, 30 Jan 2024 19:46:31 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: syzbot <syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com>,
	adilger.kernel@dilger.ca, chandan.babu@oracle.com, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: current->journal_info got nested! (was Re: [syzbot] [xfs?]
 [ext4?] general protection fault in jbd2__journal_start)
Message-ID: <20240131034631.GE6184@frogsfrogsfrogs>
References: <000000000000e98460060fd59831@google.com>
 <000000000000d6e06d06102ae80b@google.com>
 <ZbmILkfdGks57J4a@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbmILkfdGks57J4a@dread.disaster.area>

On Wed, Jan 31, 2024 at 10:37:18AM +1100, Dave Chinner wrote:
> On Tue, Jan 30, 2024 at 06:52:21AM -0800, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    861c0981648f Merge tag 'jfs-6.8-rc3' of github.com:kleikam..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ca8d97e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=b0b9993d7d6d1990
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cdee56dbcdf0096ef605
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104393efe80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1393b90fe80000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/7c6cc521298d/disk-861c0981.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6203c94955db/vmlinux-861c0981.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/17e76e12b58c/bzImage-861c0981.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/d31d4eed2912/mount_3.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
> > 
> > general protection fault, probably for non-canonical address 0xdffffc000a8a4829: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: probably user-memory-access in range [0x0000000054524148-0x000000005452414f]
> > CPU: 1 PID: 5065 Comm: syz-executor260 Not tainted 6.8.0-rc2-syzkaller-00031-g861c0981648f #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> > RIP: 0010:jbd2__journal_start+0x87/0x5d0 fs/jbd2/transaction.c:496
> > Code: 74 63 48 8b 1b 48 85 db 74 79 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 4d 8f ff 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 ef e8 4a 4d 8f ff 4c 39 65 00 0f 85 1a
> > RSP: 0018:ffffc900043265c8 EFLAGS: 00010203
> > RAX: 000000000a8a4829 RBX: ffff8880205fa3a8 RCX: ffff8880235dbb80
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88801c1a6000
> > RBP: 000000005452414e R08: 0000000000000c40 R09: 0000000000000001
>                ^^^^^^^^
> Hmmmm - TRAN. That's looks suspicious, I'll come back to that.
> 
> > R10: dffffc0000000000 R11: ffffed1003834871 R12: ffff88801c1a6000
> > R13: dffffc0000000000 R14: 0000000000000c40 R15: 0000000000000002
> > FS:  0000555556f90380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020020000 CR3: 0000000021fed000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __ext4_journal_start_sb+0x215/0x5b0 fs/ext4/ext4_jbd2.c:112
> >  __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
> >  ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:5969
> >  __mark_inode_dirty+0x305/0xda0 fs/fs-writeback.c:2452
> >  generic_update_time fs/inode.c:1905 [inline]
> >  inode_update_time fs/inode.c:1918 [inline]
> >  __file_update_time fs/inode.c:2106 [inline]
> >  file_update_time+0x39b/0x3e0 fs/inode.c:2136
> >  ext4_page_mkwrite+0x207/0xdf0 fs/ext4/inode.c:6090
> >  do_page_mkwrite+0x197/0x470 mm/memory.c:2966
> >  wp_page_shared mm/memory.c:3353 [inline]
> >  do_wp_page+0x20e3/0x4c80 mm/memory.c:3493
> >  handle_pte_fault mm/memory.c:5160 [inline]
> >  __handle_mm_fault+0x26a3/0x72b0 mm/memory.c:5285
> >  handle_mm_fault+0x27e/0x770 mm/memory.c:5450
> >  do_user_addr_fault arch/x86/mm/fault.c:1415 [inline]
> >  handle_page_fault arch/x86/mm/fault.c:1507 [inline]
> >  exc_page_fault+0x2ad/0x870 arch/x86/mm/fault.c:1563
> >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> 
> EXt4 is triggering a BUG_ON:
> 
> 	handle_t *handle = journal_current_handle();
> 	int err;
> 
> 	if (!journal)
> 		return ERR_PTR(-EROFS);
> 
> 	if (handle) {
> >>>>>>>>>	J_ASSERT(handle->h_transaction->t_journal == journal);
> 		handle->h_ref++;
> 		return handle;
> 	}
> 
> via a journal assert failure. It appears that current->journal_info
> isn't what it is supposed to be. It's finding something with TRAN in
> it, I think. I'll come back to this.
> 
> What syzbot is doing is creating a file on it's root filesystem and
> write()ing 0x208e24b bytes (zeroes from an anonymous mmap() region,
> I think) to it to initialise it's contents.
> 
> Then it mmap()s the ext4 file for 0xb36000 bytes and copies the raw
> test filesystem image in the source code into it.  It then creates a
> memfd that it decompresses the data in the mapped ext4 file into and
> creates a loop device that points to that memfd. It then mounts the
> loop device and we get an XFS filesystem which doesn't appear to
> contain any corruptions in it at all.  It then runs a bulkstat pass
> on the the XFS filesystem.
> 
> This is where it gets interesting. The user buffer that XFS
> copies the inode data into points to a memory address inside the
> range of the ext4 file that the filesystem image was copied to.
> It does not overlap with the filesystem image.
> 
> Hence when XFS goes to copy the inodes into the user buffer, it
> triggers write page faults on the ext4 backing file.
> 
> That's this part of the trace:
> 
> 
> > RIP: 0010:rep_movs_alternative+0x4a/0x70 arch/x86/lib/copy_user_64.S:71
> > Code: 75 f1 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 06 48 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb c9 <f3> a4 c3 48 89 c8 48 c1 e9 03 83 e0 07 f3 48 a5 89 c1 85 c9 75 b3
> > RSP: 0018:ffffc900043270f8 EFLAGS: 00050202
> > RAX: ffffffff848cda01 RBX: 0000000020020040 RCX: 0000000000000040
> > RDX: 0000000000000000 RSI: ffff8880131873b0 RDI: 0000000020020000
> > RBP: 1ffff92000864f26 R08: ffff8880131873ef R09: 1ffff11002630e7d
> > R10: dffffc0000000000 R11: ffffed1002630e7e R12: 00000000000000c0
> > R13: dffffc0000000000 R14: 000000002001ff80 R15: ffff888013187330
> >  copy_user_generic arch/x86/include/asm/uaccess_64.h:112 [inline]
> >  raw_copy_to_user arch/x86/include/asm/uaccess_64.h:133 [inline]
> >  _copy_to_user+0x86/0xa0 lib/usercopy.c:41
> >  copy_to_user include/linux/uaccess.h:191 [inline]
> >  xfs_bulkstat_fmt+0x4f/0x120 fs/xfs/xfs_ioctl.c:744
> >  xfs_bulkstat_one_int+0xd8b/0x12e0 fs/xfs/xfs_itable.c:161
> >  xfs_bulkstat_iwalk+0x72/0xb0 fs/xfs/xfs_itable.c:239
> >  xfs_iwalk_ag_recs+0x4c3/0x820 fs/xfs/xfs_iwalk.c:220
> >  xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
> >  xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
> >  xfs_iwalk+0x360/0x6f0 fs/xfs/xfs_iwalk.c:584
> >  xfs_bulkstat+0x4f8/0x6c0 fs/xfs/xfs_itable.c:308
> >  xfs_ioc_bulkstat+0x3d0/0x450 fs/xfs/xfs_ioctl.c:867
> >  xfs_file_ioctl+0x6a5/0x1980 fs/xfs/xfs_ioctl.c:1994
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:871 [inline]
> >  __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> What is interesting here is this is running in an empty XFS
> transaction context so that the bulkstat operation garbage collects
> all the buffers it accesses without us having to explicit cleanup -
> they all get released when we cancel the transaction context at the
> end of the process.
> 
> But that means copy-out is running inside a transaction context, and
> that means current->journal_info contains a pointer to the current
> struct xfs_trans the bulkstat operation is using.
> 
> Guess what we have as the first item in a struct xfs_trans? That's
> right, it's a magic number, and that magic number is:
> 
> #define XFS_TRANS_HEADER_MAGIC  0x5452414e      /* TRAN */
> 
> It should be obvious what has happened now -
> current->journal_info is not null, so ext4 thinks it owns the
> structure attached there and panics when it finds that it isn't an
> ext4 journal handle being held there.
> 
> I don't think there are any clear rules as to how filesystems can
> and can't use current->journal_info. In general, a task can't jump
> from one filesystem to another inside a transaction context like
> this, so there's never been a serious concern about nested
> current->journal_info assignments like this in the past.
> 
> XFS is doing nothing wrong - we're allowed to define transaction
> contexts however we want and use current->journal_info in this way.
> However, we have to acknowledge that ext4 has also done nothing
> wrong by assuming current->journal_info should below to it if it is
> not null. Indeed, XFS does the same thing.

Getting late here, so this will be pretty terse--

Thinking narrowly about just xfs, I think this means that the
bulkstat/inumbers implementations need to allocate a bounce buffer to
format records into so that it can copy_to_user without any locks held.
We have no idea if the destination page is a file page or anonymous
memory or whatever.  Or: Do we really need to set current->journal_info
for empty transactions?

> The question here is what to do about this? The obvious solution is
> to have save/restore semantics in the filesystem code that
> sets/clears current->journal_info, and then filesystems can also do
> the necessary "recursion into same filesystem" checks they need to
> ensure that they aren't nesting transactions in a way that can
> deadlock.

We don't know what locks might be held by whatever code set
journal_info.  I don't see how we could push it aside sanely?

> Maybe there are other options - should filesystems even be allowed to
> trigger page faults when they have set current->journal_info?

I wonder if we ought to be checking current->journal_info in our own
page_mkwrite handler and throwing back an errno?  I don't think we want
to go down the rabbithele of "someone else was running a transaction,
maybe we can proceed with an update anyway???".

> What other potential avenues are there that could cause this sort of
> transaction context nesting that we haven't realised exist? Does
> ext4 data=jounral have problems like this in the data copy-in path?
> What other filesystems allow page faults in transaction contexts?

Ugh, whackamole. :/

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

