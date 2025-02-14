Return-Path: <linux-fsdevel+bounces-41704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D577A3569D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20803ACE0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 05:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9618A6D7;
	Fri, 14 Feb 2025 05:55:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E318A6D3
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512522; cv=none; b=b88hjx/WSE0zaY505VnpdgU1UTrSs/4S8Pe0JnKpwUcRLxjydu7niUv6KlfyKkHF0gEQ8ADUN8mdBKYHfeFKpSKI7kxB4+AeISVhkKHCBd+5NxAIs3X560mkM+ozI2WYCE93EIncKAFAD79WULloWwNxDb0rUMFhTyTL/dBNad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512522; c=relaxed/simple;
	bh=xG/WiWhE2VASJoLC+TK+opDP7wvJBqlW162OcEOi8DU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R83cU774EQTD+E+Zzo8Nlg4T+M/tWKQE22aqEOo+CL3bCarUO/AdaQ+B7Q5FkdS7RPF8U4CYQ/ruvcJ+R9gQFu24o3VMt6EF8HG0Jhue/En2r7IWEAcJ9tMcC/Dw5+JtfqqZRRNMEB9IX/BdWsixlvZ8V7XeNmf/QcCX1lQQrpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-84cdb5795b0so106433039f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2025 21:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739512520; x=1740117320;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrKwjpGfEgEA7ekoiQ9bheUPdvjTHRo0hykzOIcnQxI=;
        b=m0bQvLYkVCZq4FtDP1CNOPL15fwOPqBGPb4OdJSz39oxl56Jktr0HiVCzrZuXxfAPW
         +1flrqkjBZs18N6C1pSlRof06ie3Gen7x6UBSADhWSbiMi7CdITVCB20DxH7wdXabnT9
         XCGZbjVNgqCtIG61mLA1aY/aCLfK6k1TVdzpeYAVcAqQuewcaH3MayvUIBgS8LerKbXC
         e6rrDsRhd+letufiADR0SNZYhbSLho3phOTF2fHaqhqLEx/iHtG7x3mXwboNCY2RJbFr
         YCG5vAUDI3cCVPwffwJG/rBpvV4X2HJbGaAzzixNb7iHS26vXxQHP97MS+RoA07fz40B
         5QHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOpvh9xrvuOWT7GxOOTVCxTnTzUdW2mtgfAAGPbhQOoMdQWza32qYNCvvGgvEH+dNkzYDGLTtD+2JzJ1po@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2QWK5Ds4U8/9ncfZ4DLpz1xEx8kEz5KPhkNn/qLgmRYZG2XD0
	n/wW2veIAICIB6G//tFb+Ocov97lJ44HzCpUpfOrw59xl9JFlau6W4rL/gnm4DhT7uOJjnZpdLA
	cgPViCCxuf6/5nY2kndnPjAOwjh/t43/S40jpeiVXKd17cAWT8V9O1eU=
X-Google-Smtp-Source: AGHT+IGYqeE0cx+KfQsbioxXQbp1PLMMAPT0jG0ANq+XLEb6wIRWDtEddGFyxzW+cxbxZWHBZe0mzWqqmDaeGi0v1wONVL7iB9W3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184b:b0:3cf:cd3c:bdfd with SMTP id
 e9e14a558f8ab-3d18c23caa4mr46478665ab.12.1739512519837; Thu, 13 Feb 2025
 21:55:19 -0800 (PST)
Date: Thu, 13 Feb 2025 21:55:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aedac7.050a0220.21dd3.002d.GAE@google.com>
Subject: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b54314c975 Merge tag 'kbuild-fixes-v6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147e83f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7ddf49cf33ba213
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118998e4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10fcbb18580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69b54314.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d0a58d1d655/vmlinux-69b54314.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99949b40299/bzImage-69b54314.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com

netfs: Couldn't get user pages (rc=-14)
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:264 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:307 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:325 [inline]
BUG: KASAN: slab-use-after-free in iocb_put fs/aio.c:1208 [inline]
BUG: KASAN: slab-use-after-free in io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
Write of size 4 at addr ffff8880317b3b08 by task syz-executor210/6000

CPU: 3 UID: 0 PID: 6000 Comm: syz-executor210 Not tainted 6.14.0-rc1-syzkaller-00276-g69b54314c975 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 iocb_put fs/aio.c:1208 [inline]
 io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9104587229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9104537168 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f910460b408 RCX: 00007f9104587229
RDX: 00004000000002c0 RSI: 0000000000000001 RDI: 00007f9104516000
RBP: 00007f910460b400 R08: 00007f91045376c0 R09: 0000000000000000
R10: 00007f91045376c0 R11: 0000000000000246 R12: 00007f910460b40c
R13: 000000000000000b R14: 00007fff6ba87360 R15: 00007fff6ba87448
 </TASK>

Allocated by task 6000:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x226/0x3d0 mm/slub.c:4171
 aio_get_req fs/aio.c:1058 [inline]
 io_submit_one+0x123/0x1da0 fs/aio.c:2048
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6000:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x2e2/0x4d0 mm/slub.c:4711
 iocb_destroy fs/aio.c:1110 [inline]
 iocb_put fs/aio.c:1210 [inline]
 iocb_put fs/aio.c:1206 [inline]
 aio_complete_rw+0x3ec/0x7b0 fs/aio.c:1507
 netfs_rreq_assess_dio fs/netfs/read_collect.c:375 [inline]
 netfs_read_collection+0x30ae/0x3cb0 fs/netfs/read_collect.c:438
 netfs_wait_for_pause+0x31c/0x3e0 fs/netfs/read_collect.c:689
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:106 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:144 [inline]
 netfs_unbuffered_read_iter_locked+0xb50/0x1610 fs/netfs/direct_read.c:229
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:264
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 aio_read+0x313/0x4e0 fs/aio.c:1602
 __io_submit_one fs/aio.c:2003 [inline]
 io_submit_one+0x1580/0x1da0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880317b3a40
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 200 bytes inside of
 freed 216-byte region [ffff8880317b3a40, ffff8880317b3b18)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x317b2
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888100e8e280 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080190019 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888100e8e280 dead000000000122 0000000000000000
head: 0000000000000000 0000000080190019 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0000c5ec81 ffffffffffffffff 0000000000000000
head: ffff888000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5956, tgid 5955 (syz-executor210), ts 65172573555, free_ts 65103511107
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0xfa/0x3d0 mm/slub.c:4171
 aio_get_req fs/aio.c:1058 [inline]
 io_submit_one+0x123/0x1da0 fs/aio.c:2048
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2802
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffff8880317b3a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff8880317b3a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880317b3b00: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff8880317b3b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880317b3c00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

