Return-Path: <linux-fsdevel+bounces-58863-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C267FB3253B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924431C85CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9838C2C3761;
	Fri, 22 Aug 2025 22:57:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E72C029C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755903454; cv=none; b=MRP7hPOy2TzPvmANsi+noaNegXcxnMTGT0nzW4VeTI+igSAhxyCmz4aKZlBTKpr94u5uSrE7qULkrQmDrT+7rJ4BGVS+D9awijvKj67JiWsXCpK9DRPZytlt0yStoc2qSRbYZo+IgLor8TaIOSJB0Stqh2Iho3EjZIWFwD60SZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755903454; c=relaxed/simple;
	bh=gU9BKqGr5tHsN9O4wtAri1w0A/LO7anQXCLac3RVf1Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cXPItXQeoLBKCnzvx356SX11nlpoIxkMpaJDzNCTRjbOxt3T1/glMyYq+Co8vqnGUhCwjGca3GkM6/0Wock2M5fP7ar0wRJFqk4A+I+RzMUTY4OJ4xDvsek1RjwHYI1hUb66d/RZWUnjqltWdsepSunaNbPAhBb5KVIIb2CeerA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3e911fae022so41134305ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755903451; x=1756508251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcVZz1MXvngUx58tABa4HM9SmPuLGVyuDATLrOyXF2o=;
        b=QnLsYkmKUzQ3G5XQDqCbsKSFqbtSKhXNCC3jodaUstCa+0jj53zpQsYIWnewxLWZQI
         kr7LKTRK6cJxezQyJ0eIunQk6tB4JHU9xh/AOvJCXnyXsrUjHNVHYGZYYbNc5xDXw1te
         N4s5pEGD5khbgO7zHaaCuuZVrHMWpRI+TArT76k4hyj+x5x5JoGHxAnZe1x8BjV45FhY
         P8/RVDaNtCAowV0DSX+YlyqT75+c8CbCVi5LIlENvCv+fnzbH/mgyzCU1Gr8VBDONyEX
         +Iyns2Erug3HXBo1erLkSt7RkliePg4ZgtswFrBg2DX6acjuAx30k4zL54EsKyTgf323
         B84A==
X-Gm-Message-State: AOJu0YyeN7r4/EFmaSsqdhFntACgxGgtnPk6cHmjqz5sGjT/R/GgOJ+j
	hX+NJBlzgc9rMwgETVhmq/mQWP4IfTaRwkcgDqldo3oEiuVdH0kZoVBBcovjGDxgm2BZw3OvyUG
	uwVU92QjCiK3l+uxZvjJZWuJjzIOk4GNg9V4CzEiFziZyO1jtG8oGJpHkoQV9eQ==
X-Google-Smtp-Source: AGHT+IHEBIRASaB8E1sxsilzvXLhcJqDVYnjJLujuPB1Piod3EBJGk6BW58f1B74n8HzPIiO+3opCRtZq8EkRTALMQPLNml3TMTy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ce:b0:3ea:41fe:de5c with SMTP id
 e9e14a558f8ab-3ea41fee3demr25021035ab.30.1755903451539; Fri, 22 Aug 2025
 15:57:31 -0700 (PDT)
Date: Fri, 22 Aug 2025 15:57:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
Subject: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
From: syzbot <syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf6fc5eefc5b Merge tag 's390-6.17-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15348c42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7511150b112b9c3
dashboard link: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147a5062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139caa34580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-cf6fc5ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a27518272e48/vmlinux-cf6fc5ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf3f4cc06dfd/bzImage-cf6fc5ee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in fuse_retrieve fs/fuse/dev.c:1911 [inline]
BUG: KASAN: slab-out-of-bounds in fuse_notify_retrieve fs/fuse/dev.c:1959 [inline]
BUG: KASAN: slab-out-of-bounds in fuse_notify fs/fuse/dev.c:2067 [inline]
BUG: KASAN: slab-out-of-bounds in fuse_dev_do_write+0x308b/0x3420 fs/fuse/dev.c:2158
Write of size 4 at addr ffff88803b8fc6dc by task syz.0.17/6135

CPU: 0 UID: 0 PID: 6135 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 fuse_retrieve fs/fuse/dev.c:1911 [inline]
 fuse_notify_retrieve fs/fuse/dev.c:1959 [inline]
 fuse_notify fs/fuse/dev.c:2067 [inline]
 fuse_dev_do_write+0x308b/0x3420 fs/fuse/dev.c:2158
 fuse_dev_write+0x155/0x1e0 fs/fuse/dev.c:2242
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f440eb8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f440f9e1038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f440edb5fa0 RCX: 00007f440eb8ebe9
RDX: 0000000000000030 RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007f440ec11e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f440edb6038 R14: 00007f440edb5fa0 R15: 00007ffddcd08da8
 </TASK>

Allocated by task 6135:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:405
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4365 [inline]
 __kmalloc_noprof+0x223/0x510 mm/slub.c:4377
 kmalloc_noprof include/linux/slab.h:909 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 fuse_retrieve fs/fuse/dev.c:1879 [inline]
 fuse_notify_retrieve fs/fuse/dev.c:1959 [inline]
 fuse_notify fs/fuse/dev.c:2067 [inline]
 fuse_dev_do_write+0x1c50/0x3420 fs/fuse/dev.c:2158
 fuse_dev_write+0x155/0x1e0 fs/fuse/dev.c:2242
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803b8fc600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 4 bytes to the right of
 allocated 216-byte region [ffff88803b8fc600, ffff88803b8fc6d8)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3b8fc
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b842b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b842b40 dead000000000122 0000000000000000
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0000ee3f01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1151, tgid 1151 (kworker/u32:8), ts 61845903757, free_ts 55626037651
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1c0/0x230 mm/page_alloc.c:1851
 prep_new_page mm/page_alloc.c:1859 [inline]
 get_page_from_freelist+0x132b/0x38e0 mm/page_alloc.c:3858
 __alloc_frozen_pages_noprof+0x261/0x23f0 mm/page_alloc.c:5148
 alloc_pages_mpol+0x1fb/0x550 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:2487 [inline]
 allocate_slab mm/slub.c:2655 [inline]
 new_slab+0x247/0x330 mm/slub.c:2709
 ___slab_alloc+0xcf2/0x1740 mm/slub.c:3891
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3981
 __slab_alloc_node mm/slub.c:4056 [inline]
 slab_alloc_node mm/slub.c:4217 [inline]
 __kmalloc_cache_noprof+0xfb/0x3e0 mm/slub.c:4391
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 batadv_bla_get_backbone_gw+0xbe/0xc40 net/batman-adv/bridge_loop_avoidance.c:508
 batadv_bla_update_own_backbone_gw.isra.0+0x4e/0x170 net/batman-adv/bridge_loop_avoidance.c:571
 batadv_bla_tx+0x144/0x21b0 net/batman-adv/bridge_loop_avoidance.c:2105
 batadv_interface_tx+0x5e7/0x1b80 net/batman-adv/mesh-interface.c:227
 __netdev_start_xmit include/linux/netdevice.h:5222 [inline]
 netdev_start_xmit include/linux/netdevice.h:5231 [inline]
 xmit_one net/core/dev.c:3839 [inline]
 dev_hard_start_xmit+0x94/0x740 net/core/dev.c:3855
 __dev_queue_xmit+0xa46/0x4490 net/core/dev.c:4725
 dev_queue_xmit include/linux/netdevice.h:3361 [inline]
 neigh_resolve_output net/core/neighbour.c:1595 [inline]
 neigh_resolve_output+0x53a/0x940 net/core/neighbour.c:1575
 neigh_output include/net/neighbour.h:547 [inline]
 ip6_finish_output2+0xaee/0x2020 net/ipv6/ip6_output.c:141
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1395 [inline]
 __free_frozen_pages+0x7d5/0x10f0 mm/page_alloc.c:2895
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0x799/0x1530 kernel/rcu/tree.c:2861
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1050
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff88803b8fc580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803b8fc600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88803b8fc680: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
                                                    ^
 ffff88803b8fc700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803b8fc780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

