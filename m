Return-Path: <linux-fsdevel+bounces-9961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204E1846716
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98DA28EDB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278CDF513;
	Fri,  2 Feb 2024 04:49:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E8101D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 04:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849371; cv=none; b=SVgIGItOdYLpWGuzxbJ/t6s3y3wOsKKyekoykyYRAMblGrtIyO2ZWK2Y+l9eNv0UDaN/m5IMjeV+H3cKoICPVEo3n2DIWjUPuyfG5TdI5RvWsXwyKNXFrM6999Jjo9Djv7MZpjROlMbHA6olbYbYEO+y+QHvIVxZNq+qCBfEZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849371; c=relaxed/simple;
	bh=Hl1RshuMx+02yuuVjIIZYxYd5g1+ii10CB95NuLkCJQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sRIBMNhkpO/TGuu5Yld6F/LQKTaC0uTDG5emjYxBrPWFsSOuTleE7XCGmLby/EZncYho1m15vVESnpHqT2DYbg3OdZMokcz6Cd+GeErn2cbGEd0MEVu+BrIXxoYtlLoDEiC/6l0aBBJbxeinfJLF7IyEksJuLPlX4yrG1DtqXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c02ed38aa5so103919039f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 20:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706849369; x=1707454169;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yldXXvBQxXDqTydnus0ehNthfX5/keabFAHFyQe7ozw=;
        b=uozmqKxm25GoJIeDb+qppYhKP/GS6+j5kGNiUAFeqJfigDnewlIhV4cCt2YBJiQmg+
         CWI/2FNGPDGziV7yoLmOpqaCZxQIZuSBb8THbRPZZNIQJNxTQQXoCNpK6bE8OOScjz7H
         Nd0Nij9ACUZr8J00ysBvsW5yJI4LPXbM0viRmMaMjh2SayqSwHoN2dXcqHKvvOZbOBB8
         UejRFXVDBdfa0Q+3t2aqOZGxiujkGuSZ7S5qmmIN/e4cSybSCWQNY9i+X1vOU7KMlDEO
         rQlTVvY723J5rpsyaU5e1BPseK9ne7HXYqbu8i2ZuWeppXcDdLZA9lqRLJ2uDyimyUok
         jVVw==
X-Gm-Message-State: AOJu0YzWihWbMZpB5MirLzlK5Mi1CFH40s3w2jBVPDu9PMlm41NO8ObF
	q65tzLPLK7iWmFOWy0+NDO2igeP3ShLtsuuQKWTYRfycGOVyPS2dVDQiD12+xxiXaJWgIHNrDC2
	QZ0NDeZvyWuvy0rFij5mkf7HZ59WLAUTd2JIOR3U19tUv/gBjyYBrAXg=
X-Google-Smtp-Source: AGHT+IG+ygqKezv89JfyLJkMW6K9WmKY9u5awuJVxvKiRmbmKvpq8PiKWIFLIR1BkIQUuBwbEilv2zQwlfFvfFJVBmry6eKVnuz7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:361:a961:b31a with SMTP id
 x13-20020a056e021cad00b00361a961b31amr620828ill.5.1706849369187; Thu, 01 Feb
 2024 20:49:29 -0800 (PST)
Date: Thu, 01 Feb 2024 20:49:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055ecb906105ed669@google.com>
Subject: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
From: syzbot <syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    596764183be8 Add linux-next specific files for 20240129
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1612e22fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=584144ad19f381aa
dashboard link: https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12251228180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1641bcdfe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b647c038857b/disk-59676418.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/729e26c3ac55/vmlinux-59676418.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15aa5e287059/bzImage-59676418.xz

The issue was bisected to:

commit 724a08450f74b02bd89078a596fd24857827c012
Author: Eric Van Hensbergen <ericvh@kernel.org>
Date:   Fri Jan 5 22:25:39 2024 +0000

    fs/9p: simplify iget to remove unnecessary paths

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165c6d0fe80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=155c6d0fe80000
console output: https://syzkaller.appspot.com/x/log.txt?x=115c6d0fe80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com
Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary paths")

==================================================================
BUG: KASAN: slab-use-after-free in v9fs_stat2inode_dotl+0xb3f/0xce0 fs/9p/vfs_inode_dotl.c:569
Read of size 8 at addr ffff8880172d4bb0 by task syz-executor117/5063

CPU: 1 PID: 5063 Comm: syz-executor117 Not tainted 6.8.0-rc1-next-20240129-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 v9fs_stat2inode_dotl+0xb3f/0xce0 fs/9p/vfs_inode_dotl.c:569
 v9fs_fid_iget_dotl+0x1cb/0x260 fs/9p/vfs_inode_dotl.c:85
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0x515/0xa90 fs/9p/vfs_super.c:142
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f88a76d7b69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff734da2a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f88a76d7b69
RDX: 0000000020004500 RSI: 00000000200002c0 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000020000300 R09: 00007fff734da2e0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff734da2e0
R13: 00007fff734da568 R14: 431bde82d7b634db R15: 00007f88a7720074
 </TASK>

Allocated by task 5063:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 p9_client_getattr_dotl+0x4c/0x1e0 net/9p/client.c:1726
 v9fs_fid_iget_dotl+0xe7/0x260 fs/9p/vfs_inode_dotl.c:73
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0x515/0xa90 fs/9p/vfs_super.c:142
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5063:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2122 [inline]
 slab_free mm/slub.c:4296 [inline]
 kfree+0x129/0x370 mm/slub.c:4406
 v9fs_fid_iget_dotl+0x195/0x260 fs/9p/vfs_inode_dotl.c:81
 v9fs_get_inode_from_fid fs/9p/v9fs.h:230 [inline]
 v9fs_mount+0x515/0xa90 fs/9p/vfs_super.c:142
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880172d4bb0
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 freed 192-byte region [ffff8880172d4bb0, ffff8880172d4c70)

The buggy address belongs to the physical page:
page:ffffea00005cb500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x172d4
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff888014c41a00 ffffea00005fa5c0 dead000000000004
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 7, tgid 7 (kworker/0:0), ts 3076962571, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1539
 prep_new_page mm/page_alloc.c:1546 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3353
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4609
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x66d/0x17a0 mm/slub.c:3541
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3626
 __slab_alloc_node mm/slub.c:3679 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmalloc_node_trace+0x113/0x390 mm/slub.c:4021
 kmalloc_node include/linux/slab.h:606 [inline]
 kzalloc_node include/linux/slab.h:722 [inline]
 alloc_worker+0x40/0x1b0 kernel/workqueue.c:2078
 create_worker+0xf3/0x730 kernel/workqueue.c:2186
 maybe_create_worker kernel/workqueue.c:2468 [inline]
 manage_workers kernel/workqueue.c:2520 [inline]
 worker_thread+0xca1/0x1290 kernel/workqueue.c:2766
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880172d4a80: fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880172d4b00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff8880172d4b80: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880172d4c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff8880172d4c80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

