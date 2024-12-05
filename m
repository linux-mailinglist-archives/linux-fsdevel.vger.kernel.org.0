Return-Path: <linux-fsdevel+bounces-36537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C89E580C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2E1882DD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC24219A85;
	Thu,  5 Dec 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwZiz3s7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C498218828
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733407153; cv=none; b=sSDTfUt2G8pwTjGWKMjPH3jtoqYU1lGc9nIUNkm4vIQCpViUNvYVDrpu1I7ihPDWS91FfkmW7+L5QSLY8Qk9onW6HCRgyW+OGSMmO9Vg9lA6y5Ee3RYzg8g7B+N4CgHACIwPJ3E7hbeiiYs0N2pR8INZocaxolhfp3awZxbP/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733407153; c=relaxed/simple;
	bh=upXv39DcpzAnRR2m+Dy9MKh5yxeRBYKZHjbdCOTFt/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9UgerEyvPL3QsrIjOOXm6L7X0hKAFNwwuKZILCV4TqHqF+Z9VStTBEmqqexjB9JVjNu6x5C5H0vOcfGkYe4k3lR/BFrgDnDcAYl93smWX4upZl6SAan0wBBSQjgTJixSq7peDCcHGdb5YypaedL7JYucjh0wn4/y+9T5nNmwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwZiz3s7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733407149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4ZRbeRfvgZdeTCHGebmg6ySPrk2ImCTx7xrraRS1AI=;
	b=OwZiz3s7VUuaWFYV4zLmuURiRKec7kWDMJKfie/lBw3/pMP3qdPjfxHZWvEC7M9vO3mV1o
	jFToquStJWnU0/vWQ0i5A+EfYyK0MqNkdQgZdHkTKmLZgLpvbpiKP9Luz/AbxLmvw80BKK
	xCqDscevKN1QwZhlf7c3QNTDhqWg6Pw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-GZgOzY5-MKqqbg6onIdSBA-1; Thu,
 05 Dec 2024 08:59:05 -0500
X-MC-Unique: GZgOzY5-MKqqbg6onIdSBA-1
X-Mimecast-MFC-AGG-ID: GZgOzY5-MKqqbg6onIdSBA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B9A41955E80;
	Thu,  5 Dec 2024 13:59:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.90.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77F0219560A2;
	Thu,  5 Dec 2024 13:59:02 +0000 (UTC)
Date: Thu, 5 Dec 2024 09:00:48 -0500
From: Brian Foster <bfoster@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: syzbot <syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com>,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, gfs2@lists.linux.dev
Subject: Re: [syzbot] [iomap?] WARNING in iomap_zero_iter
Message-ID: <Z1GyEOuIrb8GLirf@bfoster>
References: <674d11ec.050a0220.48a03.001c.GAE@google.com>
 <Z03HgRGByNi1spE0@bfoster>
 <20241205070653.GE7837@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205070653.GE7837@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Dec 04, 2024 at 11:06:53PM -0800, Darrick J. Wong wrote:
> On Mon, Dec 02, 2024 at 09:43:13AM -0500, Brian Foster wrote:
> > CC'd gfs2@lists.linux.dev.
> > 
> > On Sun, Dec 01, 2024 at 05:48:28PM -0800, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=107623c0580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=af7e25f0384dc888e1bf
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b86545e0.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/00ec87aaa7ee/vmlinux-b86545e0.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/fcc70e20d51b/bzImage-b86545e0.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com
> > > 
> > > loop0: detected capacity change from 0 to 32768
> > > gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
> > > gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> > > gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
> > > gfs2: fsid=syz:syz.0: first mount done, others may mount
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 5341 at fs/iomap/buffered-io.c:1373 iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373
> > 
> > This is the recently added warning for zeroing folios that start beyond
> > i_size:
> > 
> > 	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);
> > 
> > This was added because iomap zero range was somewhat recently changed to
> > no longer update i_size, which means such writes are at risk of being
> > thrown away. A quick look at the gfs2_fallocate() -> __gfs2_punch_hole()
> > path below shows we make a couple zero range calls around block
> > unaligned boundaries and immediately follow that with a flush of the
> > entire range. If a portion of this starts beyond i_size then writeback
> > will simply throw those folios away.
> > 
> > I think the main question here is whether there is some known/legitimate
> > use case for post-eof zeroing in GFS2 that requires behavior to be
> > revisited on one side or the other, or otherwise if there is an issue
> > with the warning check being racy and thus causing a false positive.
> > 
> > GFS2 folks,
> > 
> > Could you comment on the above wrt GFS2 and post-eof zeroing?
> > 
> > If this isn't some obvious case, hopefully syzbot can spit out a
> > reproducer soon to help get to the bottom of it. Thanks.
> 
> I can't say much about gfs2, but rebasing the rtreflink patchset atop
> 6.13-rc1 also triggered this.
> 
> The refcount code in xfs isn't designed to allowed shared unwritten
> extents.  If the rt extent size is greater than 1 fsblock, that means
> that FICLONE (after flushing and invalidating pagecache) write zeroes to
> unwritten extents and changes the mapping to written.
> 

Hm, Ok. I'm not familiar with the rt bits but it sounds like we have a
situation where explicit zeroing is preferred over unwritten post-eof
extents.

> Unfortunately, if EOF happens to be in the middle of a shared rt extent,
> the file will then have written mappings that start entirely beyond EOF.
> If there's a dirty folio that spans EOF but doesn't cache the entire rt
> extent and someone initiates a write well beyond EOF, the posteof
> prezeroing will see the written mapping, allocate a new folio entirely
> beyond EOF, and trip over this.
> 

Fun. So we have "zeroed but not unwritten" post-eof extents that trip
this warning, but may not necessarily be problematic because the extents
were already zeroed either way..?

> Seeing as writeback ignores totally posteof folios, the COW code will
> probably have to do BMAPI_ZERO allocations to ensure that we've zeroed
> out any stale data just in case they end up being used for a small file
> extension.  I might have to make ->iomap_begin never return written
> mappings that start after EOF, though I could just fix iomap to skip
> post-EOF written mappings since pagecache doesn't service that anyway.
> 

Hmm.. it kind of sounds like that would defeat the purpose of the
warning..? I.e., iomap doesn't zero something the caller expected it to
because iomap makes no assumptions about whether post-eof (written)
extents are actually zero on disk.

FWIW, a secondary reason for adding this warning was to grok whether
users depended on historical behavior here. The first I brought this up
was here [1], but TLDR is my sense is that this was a result of some
combination of dueling bugfixes where between removing the i_size
updates, changing XFS to convert post-eof delalloc, I'm not totally
convinced this hasn't just replaced some known problems with different
unknown ones. I'm kind of patiently waiting for somebody to discover how
the latter can noticeably increase fragmentation on concurrent write
workloads so I don't have to argue about it.

Anyways, this is all to say.. I wonder at what point it would make more
sense to pare back some of these changes rather than continue to
compound on them. Would it be a problem for this rt use case if zero
range just went back to updating i_size? I suppose a compromise could be
to support an optional IOMAP_KEEPSIZE flag if there are callers who
explicitly don't want size updates, but TBH I'd have to go back and read
back through some of the original commit logs again to remember what the
intent was and if there's any use to that at all..

Brian

[1] https://lore.kernel.org/linux-xfs/ZxkE93Vz3ZQaAFO1@bfoster/

> <shrug>
> 
> --D
> 
> > Brian
> > 
> > > Modules linked in:
> > > CPU: 0 UID: 0 PID: 5341 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > RIP: 0010:iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373
> > > Code: 85 ff 49 bc 00 00 00 00 00 fc ff df 7e 56 49 01 dd e8 21 66 60 ff 48 8b 1c 24 48 8d 4c 24 60 e9 0b fe ff ff e8 0e 66 60 ff 90 <0f> 0b 90 e9 1b ff ff ff 48 8b 4c 24 10 80 e1 07 fe c1 38 c1 0f 8c
> > > RSP: 0018:ffffc9000d27f3e0 EFLAGS: 00010283
> > > RAX: ffffffff82357e72 RBX: 0000000000000000 RCX: 0000000000100000
> > > RDX: ffffc9000e2fa000 RSI: 000000000000053d RDI: 000000000000053e
> > > RBP: ffffc9000d27f4b0 R08: ffffffff82357d88 R09: 1ffffd40002a07d8
> > > R10: dffffc0000000000 R11: fffff940002a07d9 R12: 0000000000008000
> > > R13: 0000000000008000 R14: ffffea0001503ec0 R15: 0000000000000001
> > > FS:  00007efeb79fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007efeb81360e8 CR3: 00000000442d8000 CR4: 0000000000352ef0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >  <TASK>
> > >  iomap_zero_range+0x69b/0x970 fs/iomap/buffered-io.c:1456
> > >  gfs2_block_zero_range fs/gfs2/bmap.c:1303 [inline]
> > >  __gfs2_punch_hole+0x311/0xb30 fs/gfs2/bmap.c:2420
> > >  gfs2_fallocate+0x3a1/0x490 fs/gfs2/file.c:1399
> > >  vfs_fallocate+0x569/0x6e0 fs/open.c:327
> > >  do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
> > >  __do_sys_ioctl fs/ioctl.c:904 [inline]
> > >  __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > RIP: 0033:0x7efeb7f80809
> > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007efeb79fe058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > RAX: ffffffffffffffda RBX: 00007efeb8145fa0 RCX: 00007efeb7f80809
> > > RDX: 0000000020000000 RSI: 0000000040305829 RDI: 0000000000000005
> > > RBP: 00007efeb7ff393e R08: 0000000000000000 R09: 0000000000000000
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > > R13: 0000000000000000 R14: 00007efeb8145fa0 R15: 00007ffd994f7a38
> > >  </TASK>
> > > 
> > > 
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > 
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > 
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > > 
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > > 
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > > 
> > > If you want to undo deduplication, reply with:
> > > #syz undup
> > > 
> > 
> > 
> 


