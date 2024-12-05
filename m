Return-Path: <linux-fsdevel+bounces-36518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29FB9E4DF5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 08:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584232818CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E8E1ABECD;
	Thu,  5 Dec 2024 07:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7LstXkJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2A194C85;
	Thu,  5 Dec 2024 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382414; cv=none; b=Cas/4wOdhXX62ynh/i/H9KAlHzPhSp5PUepPpvII17H43XkAZr7AstM/kTPvRblFQJzMWceB8pgcBr3FkRtuxuEWR06nrI5wrI5ZKMsh8nKA/GrDFvf+B/BET6ZKjLtHDVYNzxecld5u09FEh3nh2muSEls0x3j/qABJx+ftB5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382414; c=relaxed/simple;
	bh=tbiN7RVlLpB1Ip3vbOmE2HV+9+XTkxu5ArmQsaP6xVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mngQVRCg2ubwA2bPJHTPgQi1tgmpCzwrCChyjcGLy7P3Ztz1wL4pPv+vaUfShSS4lfE0555hU7BRQK5gkp7lg+cXhs2oPJAs+4jKviERf6xYIwUrhpl+rcabkyiHHXcM2MEuwlJ7CbiFiqODsr4JVGG/gkfGyfIF7pvxI9J/ayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7LstXkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8469BC4CED1;
	Thu,  5 Dec 2024 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733382413;
	bh=tbiN7RVlLpB1Ip3vbOmE2HV+9+XTkxu5ArmQsaP6xVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7LstXkJXZUBNvB6tsK9Wgw589JBEAaS7C8T+vYPVIBk68cKHIxzRqwvgy5dxLuj+
	 Uqig9mOypdAjYPcwRYera+gWtWDTgVBBN7TM/TcqYhUABe9pUjsWafuJNc5tVpifH4
	 z2UuIM5+TAkUf+A8Wdnc8UqEbLUFQYtOA2Drbu4eKpA4MuSfIPI9nWTnDH+Zjcm3xQ
	 OUPIwhV3H3JrPgrNN9Mpcj4BzJUYYrcqKvqz/L1a5ZO5usIT5NLiTcgVHqeL+qZWGR
	 Svomb5nmP+lgYtekotf0qBqTC3JNQJ9fKEe7pCYAKUPpJ8lhaZxtUhlh3Pr4X1AUQB
	 SZuGQTglMKbKA==
Date: Wed, 4 Dec 2024 23:06:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: syzbot <syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com>,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, gfs2@lists.linux.dev
Subject: Re: [syzbot] [iomap?] WARNING in iomap_zero_iter
Message-ID: <20241205070653.GE7837@frogsfrogsfrogs>
References: <674d11ec.050a0220.48a03.001c.GAE@google.com>
 <Z03HgRGByNi1spE0@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z03HgRGByNi1spE0@bfoster>

On Mon, Dec 02, 2024 at 09:43:13AM -0500, Brian Foster wrote:
> CC'd gfs2@lists.linux.dev.
> 
> On Sun, Dec 01, 2024 at 05:48:28PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=107623c0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
> > dashboard link: https://syzkaller.appspot.com/bug?extid=af7e25f0384dc888e1bf
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b86545e0.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/00ec87aaa7ee/vmlinux-b86545e0.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fcc70e20d51b/bzImage-b86545e0.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 32768
> > gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
> > gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> > gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
> > gfs2: fsid=syz:syz.0: first mount done, others may mount
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5341 at fs/iomap/buffered-io.c:1373 iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373
> 
> This is the recently added warning for zeroing folios that start beyond
> i_size:
> 
> 	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> 
> This was added because iomap zero range was somewhat recently changed to
> no longer update i_size, which means such writes are at risk of being
> thrown away. A quick look at the gfs2_fallocate() -> __gfs2_punch_hole()
> path below shows we make a couple zero range calls around block
> unaligned boundaries and immediately follow that with a flush of the
> entire range. If a portion of this starts beyond i_size then writeback
> will simply throw those folios away.
> 
> I think the main question here is whether there is some known/legitimate
> use case for post-eof zeroing in GFS2 that requires behavior to be
> revisited on one side or the other, or otherwise if there is an issue
> with the warning check being racy and thus causing a false positive.
> 
> GFS2 folks,
> 
> Could you comment on the above wrt GFS2 and post-eof zeroing?
> 
> If this isn't some obvious case, hopefully syzbot can spit out a
> reproducer soon to help get to the bottom of it. Thanks.

I can't say much about gfs2, but rebasing the rtreflink patchset atop
6.13-rc1 also triggered this.

The refcount code in xfs isn't designed to allowed shared unwritten
extents.  If the rt extent size is greater than 1 fsblock, that means
that FICLONE (after flushing and invalidating pagecache) write zeroes to
unwritten extents and changes the mapping to written.

Unfortunately, if EOF happens to be in the middle of a shared rt extent,
the file will then have written mappings that start entirely beyond EOF.
If there's a dirty folio that spans EOF but doesn't cache the entire rt
extent and someone initiates a write well beyond EOF, the posteof
prezeroing will see the written mapping, allocate a new folio entirely
beyond EOF, and trip over this.

Seeing as writeback ignores totally posteof folios, the COW code will
probably have to do BMAPI_ZERO allocations to ensure that we've zeroed
out any stale data just in case they end up being used for a small file
extension.  I might have to make ->iomap_begin never return written
mappings that start after EOF, though I could just fix iomap to skip
post-EOF written mappings since pagecache doesn't service that anyway.

<shrug>

--D

> Brian
> 
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5341 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > RIP: 0010:iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373
> > Code: 85 ff 49 bc 00 00 00 00 00 fc ff df 7e 56 49 01 dd e8 21 66 60 ff 48 8b 1c 24 48 8d 4c 24 60 e9 0b fe ff ff e8 0e 66 60 ff 90 <0f> 0b 90 e9 1b ff ff ff 48 8b 4c 24 10 80 e1 07 fe c1 38 c1 0f 8c
> > RSP: 0018:ffffc9000d27f3e0 EFLAGS: 00010283
> > RAX: ffffffff82357e72 RBX: 0000000000000000 RCX: 0000000000100000
> > RDX: ffffc9000e2fa000 RSI: 000000000000053d RDI: 000000000000053e
> > RBP: ffffc9000d27f4b0 R08: ffffffff82357d88 R09: 1ffffd40002a07d8
> > R10: dffffc0000000000 R11: fffff940002a07d9 R12: 0000000000008000
> > R13: 0000000000008000 R14: ffffea0001503ec0 R15: 0000000000000001
> > FS:  00007efeb79fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007efeb81360e8 CR3: 00000000442d8000 CR4: 0000000000352ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  iomap_zero_range+0x69b/0x970 fs/iomap/buffered-io.c:1456
> >  gfs2_block_zero_range fs/gfs2/bmap.c:1303 [inline]
> >  __gfs2_punch_hole+0x311/0xb30 fs/gfs2/bmap.c:2420
> >  gfs2_fallocate+0x3a1/0x490 fs/gfs2/file.c:1399
> >  vfs_fallocate+0x569/0x6e0 fs/open.c:327
> >  do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
> >  __do_sys_ioctl fs/ioctl.c:904 [inline]
> >  __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7efeb7f80809
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007efeb79fe058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007efeb8145fa0 RCX: 00007efeb7f80809
> > RDX: 0000000020000000 RSI: 0000000040305829 RDI: 0000000000000005
> > RBP: 00007efeb7ff393e R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00007efeb8145fa0 R15: 00007ffd994f7a38
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup
> > 
> 
> 

