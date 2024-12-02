Return-Path: <linux-fsdevel+bounces-36263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E519E0581
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 15:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF5D281A14
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175E20B7EF;
	Mon,  2 Dec 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTEXGDHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F120B20E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150498; cv=none; b=S5h2x+mgM2j9XnlvE+MnnZKgHemTRnt/C8DGrniCXVDLvQLXrJQeIT0lMJROXx0kGpKHMJbi5LAkT7NRBf3uCBxBtTgqNVM3Nyw0jLH5hSuXDHLfqZ2iHKGs+AipCP9Ae77ibM2Hv05ZcifGeowUe49mWn75Mv5epL8dA4iuhBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150498; c=relaxed/simple;
	bh=LC7a4IadXDSBG+FPlnSGhFh+gxKKCByBUescMabMaOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaHWdfSfeMDZrGZm/JXgQgFqNF4yx5XjK1fZJY8Up5aH3npewavzBq6CKiPf9DjeLc08XsF/DvHKsmDGMFrm8XRMB2w8Oh6Iy6WC4ERUvnzOoJiED93GP5CPZmbK596yfriQNRS9usHYuLN/wq7uaKMNcs5q5Qvrx6hqLsZn0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTEXGDHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUvIdNYn/fqF9K6BoxsffOp47UHQFllLU+FnZQWOnJs=;
	b=bTEXGDHBroAxQ6pBPjN0kMov7k4Je6GpkGTpIFV+GX6JAXcuHH+DQC1d+AJ3hoLBywzPg2
	HUEL99tWl4CCDDtrYCc1CChwh9I4pLQaRC27sJreKKCXUUZ/C9736EzbL0gS52EKfqcxcT
	BsvBlovTJd0BioNpFUnnd5gLjebLO7c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-dGxSDJsqNb6Lbe3LF1xgNQ-1; Mon,
 02 Dec 2024 09:41:30 -0500
X-MC-Unique: dGxSDJsqNb6Lbe3LF1xgNQ-1
X-Mimecast-MFC-AGG-ID: dGxSDJsqNb6Lbe3LF1xgNQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 746FC1954197;
	Mon,  2 Dec 2024 14:41:28 +0000 (UTC)
Received: from bfoster (unknown [10.22.65.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C601E30000DF;
	Mon,  2 Dec 2024 14:41:26 +0000 (UTC)
Date: Mon, 2 Dec 2024 09:43:13 -0500
From: Brian Foster <bfoster@redhat.com>
To: syzbot <syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, gfs2@lists.linux.dev
Subject: Re: [syzbot] [iomap?] WARNING in iomap_zero_iter
Message-ID: <Z03HgRGByNi1spE0@bfoster>
References: <674d11ec.050a0220.48a03.001c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674d11ec.050a0220.48a03.001c.GAE@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

CC'd gfs2@lists.linux.dev.

On Sun, Dec 01, 2024 at 05:48:28PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=107623c0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
> dashboard link: https://syzkaller.appspot.com/bug?extid=af7e25f0384dc888e1bf
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-b86545e0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/00ec87aaa7ee/vmlinux-b86545e0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fcc70e20d51b/bzImage-b86545e0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+af7e25f0384dc888e1bf@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> gfs2: fsid=syz:syz: Trying to join cluster "lock_nolock", "syz:syz"
> gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
> gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
> gfs2: fsid=syz:syz.0: first mount done, others may mount
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5341 at fs/iomap/buffered-io.c:1373 iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373

This is the recently added warning for zeroing folios that start beyond
i_size:

	WARN_ON_ONCE(folio_pos(folio) > iter->inode->i_size);

This was added because iomap zero range was somewhat recently changed to
no longer update i_size, which means such writes are at risk of being
thrown away. A quick look at the gfs2_fallocate() -> __gfs2_punch_hole()
path below shows we make a couple zero range calls around block
unaligned boundaries and immediately follow that with a flush of the
entire range. If a portion of this starts beyond i_size then writeback
will simply throw those folios away.

I think the main question here is whether there is some known/legitimate
use case for post-eof zeroing in GFS2 that requires behavior to be
revisited on one side or the other, or otherwise if there is an issue
with the warning check being racy and thus causing a false positive.

GFS2 folks,

Could you comment on the above wrt GFS2 and post-eof zeroing?

If this isn't some obvious case, hopefully syzbot can spit out a
reproducer soon to help get to the bottom of it. Thanks.

Brian

> Modules linked in:
> CPU: 0 UID: 0 PID: 5341 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10553-gb86545e02e8c #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:iomap_zero_iter+0x3b3/0x4c0 fs/iomap/buffered-io.c:1373
> Code: 85 ff 49 bc 00 00 00 00 00 fc ff df 7e 56 49 01 dd e8 21 66 60 ff 48 8b 1c 24 48 8d 4c 24 60 e9 0b fe ff ff e8 0e 66 60 ff 90 <0f> 0b 90 e9 1b ff ff ff 48 8b 4c 24 10 80 e1 07 fe c1 38 c1 0f 8c
> RSP: 0018:ffffc9000d27f3e0 EFLAGS: 00010283
> RAX: ffffffff82357e72 RBX: 0000000000000000 RCX: 0000000000100000
> RDX: ffffc9000e2fa000 RSI: 000000000000053d RDI: 000000000000053e
> RBP: ffffc9000d27f4b0 R08: ffffffff82357d88 R09: 1ffffd40002a07d8
> R10: dffffc0000000000 R11: fffff940002a07d9 R12: 0000000000008000
> R13: 0000000000008000 R14: ffffea0001503ec0 R15: 0000000000000001
> FS:  00007efeb79fe6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007efeb81360e8 CR3: 00000000442d8000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  iomap_zero_range+0x69b/0x970 fs/iomap/buffered-io.c:1456
>  gfs2_block_zero_range fs/gfs2/bmap.c:1303 [inline]
>  __gfs2_punch_hole+0x311/0xb30 fs/gfs2/bmap.c:2420
>  gfs2_fallocate+0x3a1/0x490 fs/gfs2/file.c:1399
>  vfs_fallocate+0x569/0x6e0 fs/open.c:327
>  do_vfs_ioctl+0x258c/0x2e40 fs/ioctl.c:885
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x80/0x170 fs/ioctl.c:892
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efeb7f80809
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007efeb79fe058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007efeb8145fa0 RCX: 00007efeb7f80809
> RDX: 0000000020000000 RSI: 0000000040305829 RDI: 0000000000000005
> RBP: 00007efeb7ff393e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007efeb8145fa0 R15: 00007ffd994f7a38
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


