Return-Path: <linux-fsdevel+bounces-9921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB858461D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C621F24A5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 20:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B385638;
	Thu,  1 Feb 2024 20:14:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56648562B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818466; cv=none; b=gd1cZ9jcVR/Pggz982nPmYuaH17kYxjUE/VPnVpNdThh8ZVtTDLLM1pcgK+4ssLvtiAhXbYCbuIdmCRTs00y0Bj1rhRvDltsn8iIHQWnFGCaa2nIV56b8lTrPRSRPZmI81qBbI9J3B+DASQyntDGwZ2IyFB2nXEihTdHaZrbqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818466; c=relaxed/simple;
	bh=+QpMI9k/BLr0ee24Y0sqfjNtefIRexkIcJIpXe0+0Uo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WbJ+Rh4jSh84Kh7M6zHrbK0gQ+6NFkj1Ya46bWS6ji9qnUzTabJVqoYat4uW6KWwknRQkAWaOwsVgUI/DpdbQCrKrwL0bZ1sna5LPfBOJawKaekeud4HpecmGJ35UjkNQ9tciwMQGzOwTi3829XPQHHBsWV8FaDGGDETsKpFpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3639649adcaso11842205ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 12:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706818464; x=1707423264;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hKLzu8RpP7yzjkAS4EHh6rQyy4Mmh8LTEFg/lS+p0A=;
        b=gUmHezuQlrweQS3xU8lEVyLukUjgNqhhKV8aADXdziPMb91q86wP3E9NaR0O8cAkvs
         eu434FcuHsnFlWVLB+ObV/0IVZSXh1T69kFzihBcjU0A5Vv/MkxtAufuVAMaoU/MV9+W
         9D5QufoKD/z9cxvn4+gXHI+0wgGH35r7z64KhJ8Bdgs/Nux9dLkIqFxUT9GWJ62KO8Xe
         atzk0FrPy+Nlj6/m/GD1wDpeX+YxtRUVD/vQOUMvAnpve6w2uWofU3CPnAhk4V/LlVZY
         UKfB8g8QPdg1YLI0sT8zl9G2GDPorY9Hq2Ha6PFZUHNt/EqERKHm5aaYVzsa3XODkELk
         RgDg==
X-Gm-Message-State: AOJu0Yy3BWEs7MctMCRHDB38pZd0NyMV6R29kyu0Z0tJwnRjZuczpHbP
	iBEeurm24vFccM/BTS1ApFem0vNRGC9wgw0dXLdi8q4Y02KjiiEwMHIq6AuFDoSYSGcIIjId3Vc
	djSmxkFoWhFMiIKw4oaplHEWZmbZH8fASAbJ9BdGw7FwE5OQz+ItY7Ai3QQ==
X-Google-Smtp-Source: AGHT+IH7he1XfLgHdPgbVBdozLkZejnINOpYRRankCVw3uJSD6DmJmUx1y3tO0ej8aC9qFDvlsPuY0BfKZQZRLeknFFGnACX2Lxj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:260d:b0:363:96ee:cc55 with SMTP id
 by13-20020a056e02260d00b0036396eecc55mr590790ilb.1.1706818463894; Thu, 01 Feb
 2024 12:14:23 -0800 (PST)
Date: Thu, 01 Feb 2024 12:14:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c932e061057a423@google.com>
Subject: [syzbot] [reiserfs?] KASAN: slab-out-of-bounds Read in
 reiserfs_xattr_get (2)
From: syzbot <syzbot+a4caacbfba68b042e694@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0802e17d9aca Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1567a297e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9616b7e180577ba
dashboard link: https://syzkaller.appspot.com/bug?extid=a4caacbfba68b042e694
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84e45f27a78/disk-0802e17d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b16d2fc3b1/vmlinux-0802e17d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c7ac36b3de1/Image-0802e17d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4caacbfba68b042e694@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in reiserfs_xattr_get+0xd0/0x96c fs/reiserfs/xattr.c:676
Read of size 8 at addr ffff00012166eb98 by task syz-executor.4/12688

CPU: 1 PID: 12688 Comm: syz-executor.4 Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 reiserfs_xattr_get+0xd0/0x96c fs/reiserfs/xattr.c:676
 reiserfs_get_acl+0x94/0x624 fs/reiserfs/xattr_acl.c:215
 __get_acl+0x26c/0x474 fs/posix_acl.c:160
 get_inode_acl+0x34/0x44 fs/posix_acl.c:185
 check_acl+0x40/0x184 fs/namei.c:310
 acl_permission_check fs/namei.c:355 [inline]
 generic_permission+0x2f8/0x498 fs/namei.c:408
 reiserfs_permission+0x74/0xa8 fs/reiserfs/xattr.c:958
 do_inode_permission fs/namei.c:462 [inline]
 inode_permission+0x1d0/0x3b4 fs/namei.c:529
 may_open+0x290/0x3bc fs/namei.c:3249
 do_open fs/namei.c:3620 [inline]
 path_openat+0x1e44/0x2888 fs/namei.c:3779
 do_filp_open+0x1bc/0x3cc fs/namei.c:3809
 do_sys_openat2+0x124/0x1b8 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1463
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Allocated by task 12732:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xcc/0x1b8 mm/slab_common.c:1020
 kmalloc_array include/linux/slab.h:637 [inline]
 bitmap_alloc+0x34/0x44 lib/bitmap.c:712
 ptp_open+0xf0/0x3a8 drivers/ptp/ptp_chardev.c:116
 posix_clock_open+0x170/0x1f4 kernel/time/posix-clock.c:134
 chrdev_open+0x3c8/0x4dc fs/char_dev.c:414
 do_dentry_open+0x778/0x12b4 fs/open.c:948
 vfs_open+0x7c/0x90 fs/open.c:1082
 do_open fs/namei.c:3622 [inline]
 path_openat+0x1f6c/0x2888 fs/namei.c:3779
 do_filp_open+0x1bc/0x3cc fs/namei.c:3809
 do_sys_openat2+0x124/0x1b8 fs/open.c:1437
 do_sys_open fs/open.c:1452 [inline]
 __do_sys_openat fs/open.c:1468 [inline]
 __se_sys_openat fs/open.c:1463 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1463
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 kvfree_call_rcu+0xac/0x674 kernel/rcu/tree.c:3400
 drop_sysctl_table+0x2c8/0x410 fs/proc/proc_sysctl.c:1508
 drop_sysctl_table+0x2d8/0x410 fs/proc/proc_sysctl.c:1511
 unregister_sysctl_table+0x48/0x68 fs/proc/proc_sysctl.c:1529
 unregister_net_sysctl_table+0x20/0x30 net/sysctl_net.c:185
 rds_tcp_exit_net+0x53c/0x5cc net/rds/tcp.c:640
 ops_exit_list net/core/net_namespace.c:170 [inline]
 cleanup_net+0x564/0x8d0 net/core/net_namespace.c:614
 process_one_work+0x694/0x1204 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:2781
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:857

The buggy address belongs to the object at ffff00012166ea00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 152 bytes to the right of
 allocated 256-byte region [ffff00012166ea00, ffff00012166eb00)

The buggy address belongs to the physical page:
page:00000000727b44d9 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16166e
head:00000000727b44d9 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001b40 fffffc000345d600 dead000000000004
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff00012166ea80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff00012166eb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff00012166eb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff00012166ec00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff00012166ec80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

