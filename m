Return-Path: <linux-fsdevel+bounces-62543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D34B9863C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3E41646E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14BF242D66;
	Wed, 24 Sep 2025 06:31:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9583BBF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695492; cv=none; b=m9hgIayEztO2IXZFdJVW9BPVE7us7NvWM4HVEspksQlQ1Gi3SrYGHxcwKWZerWiVzoDJgaZ9Dm5u5uD0orKOo/raGzPP1wpTD/5dUkXQj49xEDhkPxlRm6Ji/7U571eAWMqtr5uqEVFOw5ITOdT+bazIRhKXW9JjBJtyrrD+iZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695492; c=relaxed/simple;
	bh=JrMEKcy6a4ezHAC7HsxibFnJo5mw15JJuHwghIAxmms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HCx+TC0t+IoOVf/UhScfmEffqOuIAEMpw8xrBDLUardXD0ab5lphE27mtXpWnLqPq59ApGvwVTxc68FqyS56XCdwwYmdzFkTQMfbQIDwZmW5PVb9y+gY5oWgvtqIONLeFP5iVULlTHBmCNowIgg9uXoLou1w6qmVhIzfgvAbvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4248d44a345so56523925ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 23:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758695490; x=1759300290;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uaqA3uMt/ffDNX61ABkn9g/IYRzpwisZzQElb6ztCk=;
        b=MNIWS8snVdju/rvsIJaLHhj0f1sABqZDeypDwxSE8LK11SS81XwfB0oQKsFEIlZs2I
         Q01SBdjQxUH6zdNFDhzxKEKaUabAMI+6ET6F2x54CR3K3qLrI1W3TMIs4qdEMvemdM1F
         2zSTIEvRhyn5b4kGzEQ3spCxkuqY+r4c8hRCsLy+qrIq6rONWb+B+Sz5LziBOJ6w8dwT
         AlDljivsqLhaolpCcz6HzqhhT9iYRc9HVo7o5lu/MGHZvQAW8bSppovxX3ok5X7kj8oG
         POZ25a7uqPNC40wvD5KtldRSoFzGv7fsUIg4Q4GBetzz+fW+dovpwZq/+XBRl5ELZM8A
         oikQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8eIDv7G4D5ohWHNBnRAlLTAJlNvSQyY9SsGU7WWTyxa9wUq28pa2p/z0usWyfJ4NlNyBTovAcUU1UnX0u@vger.kernel.org
X-Gm-Message-State: AOJu0YyguCEKwTp5wls8Hyn1J3+h2Vdxyh/gu2IKFsCIuC3RIVS1Vf6T
	ArtT1rrK/rYWxB5YRPvp6NbwMAqXZ4JDZhE/cNQsStP+To9k4kLwguyXz+45HnPCV+31tOknZN4
	rEQij9Z1pMaO1ELH9u5OdDHT/l8FpMAoc0d/QcxyBLyZ7GIjZ+fNSOFqJGoo=
X-Google-Smtp-Source: AGHT+IHJvxZk2WoXOJu/hz+7blCR2WuUWBoSl069fCkN7jgSwpLfo1/cb9knBHNfY/LrPcM/k96dClGNxZzRN6b+UXf/Dw5CsGdf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:424:cf7:7d04 with SMTP id
 e9e14a558f8ab-42581e10ec9mr82158825ab.4.1758695489782; Tue, 23 Sep 2025
 23:31:29 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d39041.a70a0220.1b52b.02c0.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in bus_remove_driver
From: syzbot <syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ce7f1a983b07 Add linux-next specific files for 20250923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=170b8d34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1be6fa3d47bce66e
dashboard link: https://syzkaller.appspot.com/bug?extid=f6a9069da61d382bf085
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fe94e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11912142580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c30be6f36c31/disk-ce7f1a98.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ae9ea347d4d8/vmlinux-ce7f1a98.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d59682a4f33c/bzImage-ce7f1a98.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com

comedi comedi1: c6xdigio: I/O port conflict (0x401,3)
==================================================================
BUG: KASAN: slab-use-after-free in sysfs_remove_file_ns+0x3d/0x70 fs/sysfs/file.c:510
Read of size 8 at addr ffff88814c9b5030 by task syz.0.18/6068

CPU: 0 UID: 0 PID: 6068 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 sysfs_remove_file_ns+0x3d/0x70 fs/sysfs/file.c:510
 remove_bind_files drivers/base/bus.c:605 [inline]
 bus_remove_driver+0x198/0x2f0 drivers/base/bus.c:743
 comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
 comedi_device_detach drivers/comedi/drivers.c:215 [inline]
 comedi_device_attach+0x5d4/0x720 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:872 [inline]
 comedi_unlocked_ioctl+0x5ff/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9aee78eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe7540fbc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9aee9e5fa0 RCX: 00007f9aee78eec9
RDX: 0000200000000080 RSI: 0000000040946400 RDI: 0000000000000004
RBP: 00007f9aee811f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9aee9e5fa0 R14: 00007f9aee9e5fa0 R15: 0000000000000003
 </TASK>

Allocated by task 6067:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:400 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:417
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __kmalloc_cache_noprof+0x3d5/0x6f0 mm/slub.c:5723
 kmalloc_noprof include/linux/slab.h:957 [inline]
 kzalloc_noprof include/linux/slab.h:1094 [inline]
 bus_add_driver+0x162/0x640 drivers/base/bus.c:662
 driver_register+0x23a/0x320 drivers/base/driver.c:249
 c6xdigio_attach+0x94/0x890 drivers/comedi/drivers/c6xdigio.c:253
 comedi_device_attach+0x51f/0x720 drivers/comedi/drivers.c:1007
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:872 [inline]
 comedi_unlocked_ioctl+0x5ff/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6067:
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 __kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:587
 kasan_save_free_info mm/kasan/kasan.h:406 [inline]
 poison_slab_object mm/kasan/common.c:252 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:284
 kasan_slab_free include/linux/kasan.h:234 [inline]
 slab_free_hook mm/slub.c:2507 [inline]
 slab_free mm/slub.c:6557 [inline]
 kfree+0x19a/0x6d0 mm/slub.c:6765
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 bus_remove_driver+0x245/0x2f0 drivers/base/bus.c:749
 comedi_device_detach_locked+0x178/0x750 drivers/comedi/drivers.c:207
 comedi_device_detach drivers/comedi/drivers.c:215 [inline]
 comedi_device_attach+0x5d4/0x720 drivers/comedi/drivers.c:1011
 do_devconfig_ioctl drivers/comedi/comedi_fops.c:872 [inline]
 comedi_unlocked_ioctl+0x5ff/0x1020 drivers/comedi/comedi_fops.c:2178
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88814c9b5000
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 freed 256-byte region [ffff88814c9b5000, ffff88814c9b5100)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14c9b4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x57ff00000000040(head|node=1|zone=2|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 057ff00000000040 ffff88813fe26b40 0000000000000000 0000000000000001
raw: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 057ff00000000040 ffff88813fe26b40 0000000000000000 0000000000000001
head: 0000000000000000 0000000080100010 00000000f5000000 0000000000000000
head: 057ff00000000001 ffffea0005326d01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 27843801833, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1850
 prep_new_page mm/page_alloc.c:1858 [inline]
 get_page_from_freelist+0x2365/0x2440 mm/page_alloc.c:3884
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5183
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
 alloc_slab_page mm/slub.c:3023 [inline]
 allocate_slab+0x96/0x3a0 mm/slub.c:3196
 new_slab mm/slub.c:3250 [inline]
 ___slab_alloc+0xe94/0x1920 mm/slub.c:4626
 __slab_alloc+0x65/0x100 mm/slub.c:4745
 __slab_alloc_node mm/slub.c:4821 [inline]
 slab_alloc_node mm/slub.c:5232 [inline]
 __do_kmalloc_node mm/slub.c:5601 [inline]
 __kmalloc_node_track_caller_noprof+0x5c7/0x800 mm/slub.c:5711
 __do_krealloc mm/slub.c:6907 [inline]
 krealloc_node_align_noprof+0x140/0x390 mm/slub.c:6966
 add_sysfs_param+0xd4/0xa30 kernel/params.c:655
 kernel_add_sysfs_param+0x7f/0xe0 kernel/params.c:812
 param_sysfs_builtin+0x18a/0x230 kernel/params.c:851
 param_sysfs_builtin_init+0x23/0x30 kernel/params.c:987
 do_one_initcall+0x236/0x820 init/main.c:1283
 do_initcall_level+0x104/0x190 init/main.c:1345
 do_initcalls+0x59/0xa0 init/main.c:1361
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814c9b4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88814c9b4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88814c9b5000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88814c9b5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88814c9b5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

