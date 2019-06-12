Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D940842F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfFLSrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFLSrW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:47:22 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2891C20896;
        Wed, 12 Jun 2019 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560365240;
        bh=Mu8MsyDqwI1xMjO/n74TanH+3lavL7WUWw2zY4LfQak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhIdugIuo0lJDiIRyejtpeQ/Znvnp3LMRvNOmjgAQBqJNHD1MU0y0WKboRbPDTtx8
         MF4Tdj00Wjo3pBmVlyksV9PNnAh2MQoffbEJAwSXWcqaaYr0ZFgyFhRq+zRAxluH1x
         57Gh7yRFdFoDHznN9TSTc6OPmZsh5Xexzucw4mDw=
Date:   Wed, 12 Jun 2019 11:47:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+99de05d099a170867f22@syzkaller.appspotmail.com>
Cc:     arnd@arndb.de, axboe@kernel.dk, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dhowells@redhat.com,
        geert@linux-m68k.org, hare@suse.com, heiko.carstens@de.ibm.com,
        hpa@zytor.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: KASAN: use-after-free Read in mntput
Message-ID: <20190612184718.GC18795@gmail.com>
References: <000000000000f1e431058b0466ab@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f1e431058b0466ab@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 09:05:06PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d1fdb6d8 Linux 5.2-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12b30acaa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> dashboard link: https://syzkaller.appspot.com/bug?extid=99de05d099a170867f22
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1114dc46a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eade6aa00000
> 
> The bug was bisected to:
> 
> commit 9c8ad7a2ff0bfe58f019ec0abc1fb965114dde7d
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu May 16 11:52:27 2019 +0000
> 
>     uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c9f91ea00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=17c9f91ea00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13c9f91ea00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+99de05d099a170867f22@syzkaller.appspotmail.com
> Fixes: 9c8ad7a2ff0b ("uapi, x86: Fix the syscall numbering of the mount API
> syscalls [ver #2]")
> 
> ==================================================================
> BUG: KASAN: use-after-free in mntput+0x91/0xa0 fs/namespace.c:1207
> Read of size 4 at addr ffff88808f661124 by task syz-executor817/8955
> 
> CPU: 1 PID: 8955 Comm: syz-executor817 Not tainted 5.2.0-rc4 #18
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:188
>  __kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
>  kasan_report+0x12/0x20 mm/kasan/common.c:614
>  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
>  mntput+0x91/0xa0 fs/namespace.c:1207
>  path_put+0x50/0x70 fs/namei.c:483
>  free_fs_struct+0x25/0x70 fs/fs_struct.c:91
>  exit_fs+0xf0/0x130 fs/fs_struct.c:108
>  do_exit+0x8e0/0x2fa0 kernel/exit.c:873
>  do_group_exit+0x135/0x370 kernel/exit.c:981
>  __do_sys_exit_group kernel/exit.c:992 [inline]
>  __se_sys_exit_group kernel/exit.c:990 [inline]
>  __ia32_sys_exit_group+0x44/0x50 kernel/exit.c:990
>  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
>  do_fast_syscall_32+0x27b/0xd7d arch/x86/entry/common.c:408
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7f16849
> Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90
> 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ffe4f85c EFLAGS: 00000296 ORIG_RAX: 00000000000000fc
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000080ed2b8
> RDX: 0000000000000000 RSI: 00000000080d71fc RDI: 00000000080ed2c0
> RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 8955:
>  save_stack+0x23/0x90 mm/kasan/common.c:71
>  set_track mm/kasan/common.c:79 [inline]
>  __kasan_kmalloc mm/kasan/common.c:489 [inline]
>  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:462
>  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:497
>  slab_post_alloc_hook mm/slab.h:437 [inline]
>  slab_alloc mm/slab.c:3326 [inline]
>  kmem_cache_alloc+0x11a/0x6f0 mm/slab.c:3488
>  kmem_cache_zalloc include/linux/slab.h:732 [inline]
>  alloc_vfsmnt+0x28/0x780 fs/namespace.c:182
>  vfs_create_mount+0x96/0x500 fs/namespace.c:961
>  __do_sys_fsmount fs/namespace.c:3423 [inline]
>  __se_sys_fsmount fs/namespace.c:3340 [inline]
>  __ia32_sys_fsmount+0x584/0xc80 fs/namespace.c:3340
>  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
>  do_fast_syscall_32+0x27b/0xd7d arch/x86/entry/common.c:408
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> Freed by task 16:
>  save_stack+0x23/0x90 mm/kasan/common.c:71
>  set_track mm/kasan/common.c:79 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:451
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:459
>  __cache_free mm/slab.c:3432 [inline]
>  kmem_cache_free+0x86/0x260 mm/slab.c:3698
>  free_vfsmnt+0x6f/0x90 fs/namespace.c:559
>  delayed_free_vfsmnt+0x16/0x20 fs/namespace.c:564
>  __rcu_reclaim kernel/rcu/rcu.h:222 [inline]
>  rcu_do_batch kernel/rcu/tree.c:2092 [inline]
>  invoke_rcu_callbacks kernel/rcu/tree.c:2310 [inline]
>  rcu_core+0xba5/0x1500 kernel/rcu/tree.c:2291
>  __do_softirq+0x25c/0x94c kernel/softirq.c:292
> 
> The buggy address belongs to the object at ffff88808f661000
>  which belongs to the cache mnt_cache of size 432
> The buggy address is located 292 bytes inside of
>  432-byte region [ffff88808f661000, ffff88808f6611b0)
> The buggy address belongs to the page:
> page:ffffea00023d9840 refcount:1 mapcount:0 mapping:ffff8880aa594940
> index:0x0
> flags: 0x1fffc0000000200(slab)
> raw: 01fffc0000000200 ffffea0002a35e08 ffffea00022a3f08 ffff8880aa594940
> raw: 0000000000000000 ffff88808f661000 0000000100000008 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff88808f661000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88808f661080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ffff88808f661100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                ^
>  ffff88808f661180: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>  ffff88808f661200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 

Same as https://marc.info/?l=linux-fsdevel&m=156017950130792&w=2

#syz dup: BUG: Dentry still in use [unmount of tmpfs tmpfs]

Also, patch sent: https://patchwork.kernel.org/patch/10990715/
("vfs: fsmount: add missing mntget()").

- Eric
