Return-Path: <linux-fsdevel+bounces-40108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3AA1C2CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE257A434D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2025 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98DE207DE8;
	Sat, 25 Jan 2025 10:51:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915A1DC745
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jan 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802276; cv=none; b=UmdiHXBmvMYuencFTlfyB8zbP9xfgT/OfvKJRQUdAiaRSBfizbHnDNYFbloyBM8pZRfNs6GcqIvBDe51Xsor2FRlCDTY8VNBliyV8dixaxdGVIrCD3TbTmVV5hNdqSvKg8GPn8nHt/8V0yBnGMZiEpLv+mFiuSedrXeESJE05ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802276; c=relaxed/simple;
	bh=rr8wVz9+8UhW/nGsvyFPcFuFkMOfDhtmR2r+Y4DctxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss/JqWirPVDBypzTnoBBY6lbOkvXssVtdTq8OkT/2did1i+hx6Oi5xvHTPNH7q8U0gkTMa5TFq4+mw9SRfW4b8Dq1uCrdaJpi0uSf8/i+z4nUXV6S7X3ms8QRocFH0vGdUke6RhzK/jFmFKjKtmN7mEFQtFcc64pcCr8fEQNw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.79])
	by sina.com (10.185.250.24) with ESMTP
	id 6794C21300003BB0; Sat, 25 Jan 2025 18:51:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6400710748365
X-SMAIL-UIID: 620B751162A744EA8E9FC17AC404AD7B-20250125-185101-1
From: Hillf Danton <hdanton@sina.com>
To: linux-mm@kvack.org
Cc: syzbot <syzbot+069bb8b6fd64a600ab7b@syzkaller.appspotmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in stable_page_flags
Date: Sat, 25 Jan 2025 18:50:53 +0800
Message-ID: <20250125105054.1851-1-hdanton@sina.com>
In-Reply-To: <67944daf.050a0220.3ab881.000d.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Jan 2025 18:34:23 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ffd294d346d1 Linux 6.13
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1505b9df980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fdfc8dd0ccb1401a
> dashboard link: https://syzkaller.appspot.com/bug?extid=069bb8b6fd64a600ab7b
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163fd2b0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4d78aa6f8378/disk-ffd294d3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bdc1d0e9ca62/vmlinux-ffd294d3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/80447d1feefe/bzImage-ffd294d3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+069bb8b6fd64a600ab7b@syzkaller.appspotmail.com
> 
>  faultin_page mm/gup.c:1196 [inline]
>  __get_user_pages+0x8d9/0x3b50 mm/gup.c:1494
>  populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1932
>  __mm_populate+0x1d6/0x380 mm/gup.c:2035
>  mm_populate include/linux/mm.h:3397 [inline]
>  vm_mmap_pgoff+0x293/0x360 mm/util.c:580
>  ksys_mmap_pgoff+0x7d/0x5c0 mm/mmap.c:546
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_large_mapcount include/linux/mm.h:1228 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapcount include/linux/mm.h:1262 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 folio_mapped include/linux/mm.h:1273 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 page_mapped include/linux/mm.h:1283 [inline]
> WARNING: CPU: 0 PID: 6789 at ./include/linux/mm.h:1228 stable_page_flags+0xab5/0xbc0 fs/proc/page.c:132
> Modules linked in:
> CPU: 0 UID: 0 PID: 6789 Comm: syz.1.263 Not tainted 6.13.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
> RIP: 0010:folio_large_mapcount include/linux/mm.h:1228 [inline]
> RIP: 0010:folio_mapcount include/linux/mm.h:1262 [inline]
> RIP: 0010:folio_mapped include/linux/mm.h:1273 [inline]
> RIP: 0010:page_mapped include/linux/mm.h:1283 [inline]
> RIP: 0010:stable_page_flags+0xab5/0xbc0 fs/proc/page.c:132
> Code: f7 ff ff e8 fd 67 61 ff 4c 8b 3c 24 49 83 ef 01 e9 c9 fc ff ff e8 eb 67 61 ff 48 c7 c6 40 0c 62 8b 4c 89 ef e8 ec 28 a8 ff 90 <0f> 0b 90 e9 69 ff ff ff 4c 89 f7 e8 eb d8 c3 ff e9 21 fd ff ff 4c
> RSP: 0018:ffffc9000bfbfc60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: 00fff00000000240 RCX: 0000000000000000
> RDX: ffff8880262b3c00 RSI: ffffffff8237e5a4 RDI: ffff8880262b4044
> RBP: ffffea0000cffe40 R08: 0000000000000001 R09: fffffbfff2d37baf
> R10: ffffffff969bdd7f R11: 0000000000000004 R12: ffffea0000cffe00
> R13: ffffea0000cffe00 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007fd7774456c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c0076a2000 CR3: 0000000028ade000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kpageflags_read+0x145/0x230 fs/proc/page.c:248

This read method is ill designed because querying mapcount for a buddy page
makes no sense.

>  pde_read fs/proc/inode.c:308 [inline]
>  proc_reg_read+0x11d/0x330 fs/proc/inode.c:318
>  vfs_read+0x1df/0xbe0 fs/read_write.c:563
>  ksys_read+0x12b/0x250 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd776585d29
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd777445038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00007fd776776080 RCX: 00007fd776585d29
> RDX: 0000000000400000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007fd776601b08 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fd776776080 R15: 00007fff7853bb08
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

