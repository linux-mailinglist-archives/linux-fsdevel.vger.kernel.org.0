Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60F62171B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 17:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGGPYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 11:24:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbgGGPYO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:24:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 245C3AC24;
        Tue,  7 Jul 2020 15:24:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 730F01E12BC; Tue,  7 Jul 2020 17:24:11 +0200 (CEST)
Date:   Tue, 7 Jul 2020 17:24:11 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com>
Cc:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: memory leak in inotify_update_watch
Message-ID: <20200707152411.GD25069@quack2.suse.cz>
References: <000000000000a47ace05a9c7b825@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a47ace05a9c7b825@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Mon 06-07-20 08:42:24, syzbot wrote:
> syzbot found the following crash on:
> 
> HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17644c05100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ee23b9caef4e07a
> dashboard link: https://syzkaller.appspot.com/bug?extid=dec34b033b3479b9ef13
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1478a67b100000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+dec34b033b3479b9ef13@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888115db8480 (size 576):
>   comm "systemd-udevd", pid 11037, jiffies 4295104591 (age 56.960s)
>   hex dump (first 32 bytes):
>     00 04 00 00 00 00 00 00 80 fd e8 15 81 88 ff ff  ................
>     a0 02 dd 20 81 88 ff ff b0 81 d0 09 81 88 ff ff  ... ............
>   backtrace:
>     [<00000000288c0066>] radix_tree_node_alloc.constprop.0+0xc1/0x140 lib/radix-tree.c:252
>     [<00000000f80ba6a7>] idr_get_free+0x231/0x3b0 lib/radix-tree.c:1505
>     [<00000000ec9ab938>] idr_alloc_u32+0x91/0x120 lib/idr.c:46
>     [<00000000aea98d29>] idr_alloc_cyclic+0x84/0x110 lib/idr.c:125
>     [<00000000dbad44a4>] inotify_add_to_idr fs/notify/inotify/inotify_user.c:365 [inline]
>     [<00000000dbad44a4>] inotify_new_watch fs/notify/inotify/inotify_user.c:578 [inline]
>     [<00000000dbad44a4>] inotify_update_watch+0x1af/0x2d0 fs/notify/inotify/inotify_user.c:617
>     [<00000000e141890d>] __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:755 [inline]
>     [<00000000e141890d>] __se_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:698 [inline]
>     [<00000000e141890d>] __x64_sys_inotify_add_watch+0x12f/0x180 fs/notify/inotify/inotify_user.c:698
>     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
>     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

I've been looking into this for a while and I don't think this is related
to inotify at all. Firstly the reproducer looks totally benign:

prlimit64(0x0, 0xe, &(0x7f0000000280)={0x9, 0x8d}, 0x0)
sched_setattr(0x0, &(0x7f00000000c0)={0x38, 0x2, 0x0, 0x0, 0x9}, 0x0)
vmsplice(0xffffffffffffffff, 0x0, 0x0, 0x0)
perf_event_open(0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
clone(0x20000103, 0x0, 0xfffffffffffffffe, 0x0, 0xffffffffffffffff)
syz_mount_image$vfat(0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0)

So we seem to set SCHED_RR class and prio 9 to itself, the rest of syscalls
seem to be invalid and should fail. Secondly, the kernel log shows that we
hit OOM killer frequently and after one of these kills, many leaked objects
(among them this radix tree node from inotify idr) are reported. I'm not
sure if it could be the leak detector getting confused (e.g. because it got
ENOMEM at some point) or something else... Catalin, any idea?

								Honza

> BUG: memory leak
> unreferenced object 0xffff88811fb8c180 (size 192):
>   comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
>   hex dump (first 32 bytes):
>     08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 89 13 1a 81 88 ff ff  ................
>   backtrace:
>     [<000000009fe0803b>] __d_alloc+0x2a/0x260 fs/dcache.c:1709
>     [<000000005a828803>] d_alloc+0x21/0xb0 fs/dcache.c:1788
>     [<00000000e0349988>] __lookup_hash+0x67/0xc0 fs/namei.c:1441
>     [<00000000907d6c36>] filename_create+0xa5/0x1c0 fs/namei.c:3459
>     [<0000000025ebf47f>] user_path_create fs/namei.c:3516 [inline]
>     [<0000000025ebf47f>] do_symlinkat+0x70/0x180 fs/namei.c:3973
>     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
>     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff888107962b00 (size 704):
>   comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
>   hex dump (first 32 bytes):
>     00 00 00 00 01 00 00 00 00 00 20 00 00 00 00 00  .......... .....
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000001bbffdf0>] shmem_alloc_inode+0x18/0x40 mm/shmem.c:3701
>     [<000000008bdb5db7>] alloc_inode+0x27/0xf0 fs/inode.c:232
>     [<00000000b322bd08>] new_inode_pseudo fs/inode.c:928 [inline]
>     [<00000000b322bd08>] new_inode+0x21/0xf0 fs/inode.c:957
>     [<0000000090aa6bc7>] shmem_get_inode+0x47/0x2b0 mm/shmem.c:2229
>     [<00000000d46b8299>] shmem_symlink+0x6b/0x290 mm/shmem.c:3080
>     [<00000000edfa50df>] vfs_symlink fs/namei.c:3953 [inline]
>     [<00000000edfa50df>] vfs_symlink+0x15a/0x230 fs/namei.c:3939
>     [<00000000a8f2bfa3>] do_symlinkat+0x14f/0x180 fs/namei.c:3980
>     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
>     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff88811952fa80 (size 56):
>   comm "systemd-udevd", pid 11486, jiffies 4295108810 (age 14.770s)
>   hex dump (first 32 bytes):
>     a8 2c 96 07 81 88 ff ff e0 18 b9 81 ff ff ff ff  .,..............
>     70 2b 96 07 81 88 ff ff 98 fa 52 19 81 88 ff ff  p+........R.....
>   backtrace:
>     [<00000000369fbe38>] kmem_cache_zalloc include/linux/slab.h:659 [inline]
>     [<00000000369fbe38>] lsm_inode_alloc security/security.c:588 [inline]
>     [<00000000369fbe38>] security_inode_alloc+0x2e/0xb0 security/security.c:971
>     [<000000005b4a8c5f>] inode_init_always+0x10c/0x200 fs/inode.c:171
>     [<0000000022ebc8f1>] alloc_inode+0x44/0xf0 fs/inode.c:239
>     [<00000000b322bd08>] new_inode_pseudo fs/inode.c:928 [inline]
>     [<00000000b322bd08>] new_inode+0x21/0xf0 fs/inode.c:957
>     [<0000000090aa6bc7>] shmem_get_inode+0x47/0x2b0 mm/shmem.c:2229
>     [<00000000d46b8299>] shmem_symlink+0x6b/0x290 mm/shmem.c:3080
>     [<00000000edfa50df>] vfs_symlink fs/namei.c:3953 [inline]
>     [<00000000edfa50df>] vfs_symlink+0x15a/0x230 fs/namei.c:3939
>     [<00000000a8f2bfa3>] do_symlinkat+0x14f/0x180 fs/namei.c:3980
>     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
>     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff88811f95dcc0 (size 192):
>   comm "systemd-udevd", pid 11488, jiffies 4295108822 (age 14.650s)
>   hex dump (first 32 bytes):
>     08 80 00 00 06 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 89 13 1a 81 88 ff ff  ................
>   backtrace:
>     [<000000009fe0803b>] __d_alloc+0x2a/0x260 fs/dcache.c:1709
>     [<000000005a828803>] d_alloc+0x21/0xb0 fs/dcache.c:1788
>     [<00000000e0349988>] __lookup_hash+0x67/0xc0 fs/namei.c:1441
>     [<00000000907d6c36>] filename_create+0xa5/0x1c0 fs/namei.c:3459
>     [<0000000025ebf47f>] user_path_create fs/namei.c:3516 [inline]
>     [<0000000025ebf47f>] do_symlinkat+0x70/0x180 fs/namei.c:3973
>     [<00000000d872d7cc>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:359
>     [<000000005c62d8da>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
