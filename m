Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1774ADA64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 04:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfD2CKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 22:10:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:51014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbfD2CKo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:10:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9DFDAD05;
        Mon, 29 Apr 2019 02:10:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0B8711E3C11; Mon, 29 Apr 2019 04:10:40 +0200 (CEST)
Date:   Mon, 29 Apr 2019 04:10:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in fanotify_handle_event
Message-ID: <20190429021039.GB29678@quack2.suse.cz>
References: <20190426105511.GA18333@quack2.suse.cz>
 <00000000000089f82105876d041b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000089f82105876d041b@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-04-19 04:13:00, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered
> crash:
> general protection fault in fanotify_handle_event
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 13565 Comm: syz-executor.2 Not tainted 5.1.0-rc6+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
> RIP: 0010:fanotify_handle_event+0x7d0/0xc40
> fs/notify/fanotify/fanotify.c:412
> Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85
> 47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a 48
> 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
> RSP: 0018:ffff888085eb7b78 EFLAGS: 00010203
> RAX: 1ffff11013db05ab RBX: 0000000000000000 RCX: ffffffff81c427ae
> RDX: 0000000000000007 RSI: ffffffff81c427bb RDI: 000000000000003c
> RBP: ffff888085eb7cc0 R08: ffff88808b0926c0 R09: 0000000000000000
> R10: ffff88808b092f90 R11: ffff88808b0926c0 R12: 0000000000000002
> R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
> FS:  00007ff801b58700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f500e416000 CR3: 00000000a3f17000 CR4: 00000000001406f0
> Call Trace:
>  send_to_group fs/notify/fsnotify.c:243 [inline]
>  fsnotify+0x725/0xbc0 fs/notify/fsnotify.c:381
>  fsnotify_path include/linux/fsnotify.h:54 [inline]
>  fsnotify_path include/linux/fsnotify.h:47 [inline]
>  fsnotify_modify include/linux/fsnotify.h:263 [inline]
>  vfs_write+0x4dc/0x580 fs/read_write.c:551
>  ksys_write+0x14f/0x2d0 fs/read_write.c:599
>  __do_sys_write fs/read_write.c:611 [inline]
>  __se_sys_write fs/read_write.c:608 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:608
>  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x458c29
> Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff
> 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff801b57c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000458c29
> RDX: 0000000000000007 RSI: 0000000020000080 RDI: 0000000000000005
> RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff801b586d4
> R13: 00000000004c8386 R14: 00000000004de8b8 R15: 00000000ffffffff
> Modules linked in:
> ---[ end trace 1767f2144c7cb47e ]---
> RIP: 0010:fanotify_get_fsid fs/notify/fanotify/fanotify.c:352 [inline]
> RIP: 0010:fanotify_handle_event+0x7d0/0xc40
> fs/notify/fanotify/fanotify.c:412
> Code: ff ff 48 8b 18 48 8d 7b 68 48 89 f8 48 c1 e8 03 42 80 3c 38 00 0f 85
> 47 04 00 00 48 8b 5b 68 48 8d 7b 3c 48 89 fa 48 c1 ea 03 <42> 0f b6 0c 3a 48
> 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85
> RSP: 0018:ffff888085eb7b78 EFLAGS: 00010203
> RAX: 1ffff11013db05ab RBX: 0000000000000000 RCX: ffffffff81c427ae
> RDX: 0000000000000007 RSI: ffffffff81c427bb RDI: 000000000000003c
> RBP: ffff888085eb7cc0 R08: ffff88808b0926c0 R09: 0000000000000000
> R10: ffff88808b092f90 R11: ffff88808b0926c0 R12: 0000000000000002
> R13: 0000000000000000 R14: 0000000000000001 R15: dffffc0000000000
> FS:  00007ff801b58700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f500e416000 CR3: 00000000a3f17000 CR4: 00000000001406f0
> 
> 
> Tested on:
> 
> commit:         8c7008a0 fsnotify: Fix NULL ptr deref in fanotify_get_fsid()
> git tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> console output: https://syzkaller.appspot.com/x/log.txt?x=13020ef4a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a42d110b47dd6b36
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Let's try new version of the patch:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
