Return-Path: <linux-fsdevel+bounces-28835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6296EE5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C807B1C21D41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7512E158216;
	Fri,  6 Sep 2024 08:40:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E0D156C40
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725612026; cv=none; b=W7/VuH/5BU8CMPzBMVShoElpnDCMbW7z0DKfVYwigKvkp8t+bqAdMPcUd8s2DJcB0Qqehd18n5PFkSWwUZyX/jq3E+Kf8AQQc21bBagQbxRDdJ4J3F/2aFVaHBFDfUIA4WNq/DXf2cTuz0H6Bboq1wpqFRg6/5yAgbUUyUjYkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725612026; c=relaxed/simple;
	bh=e8Q9CXP4EQ4aHDpjhvlYAJBy8g2VChIudliQKIE9Qww=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Sa50Nicdzokx0OFZ/Mif2pFoOJshk7ThxI8DDSXZMSVBjs6u1pxkMVdEo6/xDdRj7riXemiCYBwYwicr0P06104yKDl6/Fg1NkIvaImc8cUrPAyPjbLaHJgVKcpI2wpz30XKFYpCBNCL779255UnZCFee7iBt1cn7qHuqXBxK7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a330ab764so396262039f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 01:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725612023; x=1726216823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxMtXmxbmIuI9BH9fl2KBtlQSH4poSJVQCqdbJyhlzA=;
        b=CKXd8aTzSEKPeZAqz0d0c0KC37GkmATBvTf3r6RQ6lD7PXdMtzDDW8AGgxlg9JrnMK
         ufpgxfOYkQi4pwQTiP45raV0AxDvdipFpuCgRhhzANRe8D0aVLrpqYvrtKnKK5wsvvPF
         x0Yaz4Nz4VJIJ2LrcaoQe4Dxc5SvxBHdbLp4DzNTDq1LLi8CyyabSWaBh8y7FTYF6uTb
         dSdPbsJMtGouRXKKT6vNEnnckz0b/SRixPVDN/rg7uNCo+4C35cUjExO1voTkhh+1sLs
         SVfOOjVODA3IQoAF6vx8ORjkGGk7dwM8PZCSNfKuukAFGh2zBE2N2bj9FKiy9OX9VE8e
         Gm3w==
X-Gm-Message-State: AOJu0YzPIwAeudBLz+tRWh7PZdwEA8KDUTShkeqKGjtEF6mTp7leMj9H
	cFhEI6wXuCmsQqM1x8hYWF/OqW4K/qpIoCEq9MNq6A67EE0Zq+xkCWhFhvjqA9XPJ3KHjEK83jR
	3XyVrrqw+n8D8zCubFCwyv6XVajcGtadtevfyQPugRzEj4MMJeSnIZns=
X-Google-Smtp-Source: AGHT+IGU/x+f6zi6jCEqPmhPkUEnJh9k4zt2qXJR1860FVwoYiqZo117bWs06xrpRKJ/Q6g0XA1Okt9C0Dv+9Dylrg62iw57nUiH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1386:b0:39d:25b4:1528 with SMTP id
 e9e14a558f8ab-3a04f0e655dmr743625ab.3.1725612023557; Fri, 06 Sep 2024
 01:40:23 -0700 (PDT)
Date: Fri, 06 Sep 2024 01:40:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af47d506216f5b6e@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in lockref_get_not_dead
 (2)
From: syzbot <syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b0874286768 Merge branch 'mctp-serial-tx-escapes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11bb370b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=f82b36bffae7ef78b6a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1627ab2b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dcf9f909bf9e/disk-9b087428.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edebf1ed521a/vmlinux-9b087428.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df22819dee6a/bzImage-9b087428.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x77/0x2040 kernel/locking/lockdep.c:5007
Read of size 8 at addr ffff88805c6ce248 by task syz.4.339/6895

CPU: 0 UID: 0 PID: 6895 Comm: syz.4.339 Not tainted 6.11.0-rc5-syzkaller-00154-g9b0874286768 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __lock_acquire+0x77/0x2040 kernel/locking/lockdep.c:5007
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 lockref_get_not_dead+0x26/0xc0 lib/lockref.c:184
 get_stashed_dentry fs/libfs.c:2128 [inline]
 path_from_stashed+0x218/0xb90 fs/libfs.c:2222
 proc_ns_get_link+0xf9/0x240 fs/proc/namespaces.c:61
 pick_link+0x631/0xd50
 step_into+0xca9/0x1080 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x184b/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab18f78850
Code: 48 89 44 24 20 75 93 44 89 54 24 0c e8 19 8f 02 00 44 8b 54 24 0c 89 da 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 89 44 24 0c e8 6c 8f 02 00 8b 44
RSP: 002b:00007fab19c74f60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fab18f78850
RDX: 0000000000000000 RSI: 00007fab18fe7a56 RDI: 00000000ffffff9c
RBP: 00007fab18fe7a56 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fab19116130 R15: 00007ffe82b25778
 </TASK>

Allocated by task 6889:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4056
 __d_alloc+0x31/0x700 fs/dcache.c:1631
 prepare_anon_dentry fs/libfs.c:2162 [inline]
 path_from_stashed+0x63a/0xb90 fs/libfs.c:2229
 proc_ns_get_link+0xf9/0x240 fs/proc/namespaces.c:61
 pick_link+0x631/0xd50
 step_into+0xca9/0x1080 fs/namei.c:1909
 open_last_lookups fs/namei.c:3674 [inline]
 path_openat+0x184b/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:928
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 __dentry_kill+0x497/0x630 fs/dcache.c:629
 dput+0x19f/0x2b0 fs/dcache.c:852
 __fput+0x5f8/0x8a0 fs/file_table.c:430
 __do_sys_close fs/open.c:1566 [inline]
 __se_sys_close fs/open.c:1551 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88805c6ce178
 which belongs to the cache dentry of size 312
The buggy address is located 208 bytes inside of
 freed 312-byte region [ffff88805c6ce178, ffff88805c6ce2b0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5c6ce
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff8880279abf01
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801bafe8c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000150015 00000001fdffffff ffff8880279abf01
head: 00fff00000000040 ffff88801bafe8c0 dead000000000100 dead000000000122
head: 0000000000000000 0000000000150015 00000001fdffffff ffff8880279abf01
head: 00fff00000000001 ffffea000171b381 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0x1d20d0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5646, tgid 5645 (syz.1.52), ts 379968019454, free_ts 379948285619
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_lru_noprof+0x1c5/0x2b0 mm/slub.c:4056
 __d_alloc+0x31/0x700 fs/dcache.c:1631
 d_alloc_pseudo+0x1f/0xb0 fs/dcache.c:1763
 alloc_path_pseudo fs/file_table.c:330 [inline]
 alloc_file_pseudo+0x123/0x290 fs/file_table.c:346
 sock_alloc_file+0xb8/0x290 net/socket.c:469
 sock_map_fd net/socket.c:494 [inline]
 __sys_socket+0x1dd/0x3c0 net/socket.c:1715
 __do_sys_socket net/socket.c:1720 [inline]
 __se_sys_socket net/socket.c:1718 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1718
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5643 tgid 5642 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __slab_free+0x31b/0x3d0 mm/slub.c:4384
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 create_nsproxy kernel/nsproxy.c:56 [inline]
 create_new_namespaces+0x34/0x7b0 kernel/nsproxy.c:74
 prepare_nsset kernel/nsproxy.c:335 [inline]
 __do_sys_setns kernel/nsproxy.c:569 [inline]
 __se_sys_setns+0x2cb/0x1c10 kernel/nsproxy.c:546
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805c6ce100: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
 ffff88805c6ce180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88805c6ce200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88805c6ce280: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
 ffff88805c6ce300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

