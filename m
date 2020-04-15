Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22481AAC27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414864AbgDOPoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:44:24 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:38462 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414847AbgDOPoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:44:15 -0400
Received: by mail-il1-f199.google.com with SMTP id c16so5090347ilh.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2020 08:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=eqjPebZkxvIVOOaEV11hzMkXCR7nmCQk9pVx/SYH/j8=;
        b=sKIoiznEdlKp+Z9066Gi9149uDLwKQDRIb635CyqGyQAJVDS4LltPUwgsV3NHQsPCM
         FRUy8rjisMlapGXe+SulRr6KlrRJ2/oMFyPXo7PXKRueRqTqpOTfR5V2TZfKskzehMzb
         Xhb8YWUTrbZnjLlmOsNAKasrIp3VysPxs8cciPGkBWxENqXHMwJ0wn4AHUzfzL/nbx4f
         HQp7SD6Obfwtu3ZhDOgqkIZbCy9D534K9UiO0Lr8696KLrY4bXjmMEjGy9RVMgKWr11F
         1/rlYJxwxlADeZepE3p0Y4M3WVZ3ATu8KUPg+NCQRxUX3gNkg7SagIVwkWt80pC3ICtG
         W1bw==
X-Gm-Message-State: AGi0Pub6Qz3kjnM4GP9NgIfSd0tyvnW7kpGdz3WNBdrOPOHOe36jIwHn
        UevCsglUzKEg/0w2xFcfD6eAktX9Nv9qX7v8PSILicQZlaWn
X-Google-Smtp-Source: APiQypJp3lnpU30Shr0MWJtmdJJGunKB4NUMJ1FoqEGgX9oQIpZVejSCF6w2hawZOCr6kh279yDla/WOKGM6TCeUCkvAf2ANG5Jp
MIME-Version: 1.0
X-Received: by 2002:a05:6638:103c:: with SMTP id n28mr1884178jan.114.1586965453902;
 Wed, 15 Apr 2020 08:44:13 -0700 (PDT)
Date:   Wed, 15 Apr 2020 08:44:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000269a6205a3563067@google.com>
Subject: KASAN: use-after-free Read in dput (2)
From:   syzbot <syzbot+72868dd424eb66c6b95f@syzkaller.appspotmail.com>
To:     0x7f454c46@gmail.com, adobriyan@gmail.com, areber@redhat.com,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        cyphar@cyphar.com, ebiederm@xmission.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcroce@redhat.com, oleg@redhat.com, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d2a22790 Add linux-next specific files for 20200412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fa5020100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=602913252b851ac7
dashboard link: https://syzkaller.appspot.com/bug?extid=72868dd424eb66c6b95f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1656abb3e00000

The bug was bisected to:

commit 69879c01a0c3f70e0887cfb4d9ff439814361e46
Author: Eric W. Biederman <ebiederm@xmission.com>
Date:   Thu Feb 20 14:08:20 2020 +0000

    proc: Remove the now unnecessary internal mount of proc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1474cde7e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1674cde7e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1274cde7e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+72868dd424eb66c6b95f@syzkaller.appspotmail.com
Fixes: 69879c01a0c3 ("proc: Remove the now unnecessary internal mount of proc")

proc_fill_super: allocate dentry failed
==================================================================
BUG: KASAN: use-after-free in fast_dput fs/dcache.c:727 [inline]
BUG: KASAN: use-after-free in dput+0x53e/0xdf0 fs/dcache.c:846
Read of size 4 at addr ffff88808a618cf0 by task syz-executor.0/8426

CPU: 0 PID: 8426 Comm: syz-executor.0 Not tainted 5.6.0-next-20200412-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 fast_dput fs/dcache.c:727 [inline]
 dput+0x53e/0xdf0 fs/dcache.c:846
 proc_kill_sb+0x73/0xf0 fs/proc/root.c:195
 deactivate_locked_super+0x8c/0xf0 fs/super.c:335
 vfs_get_super+0x258/0x2d0 fs/super.c:1212
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2813 [inline]
 do_mount+0x1306/0x1b30 fs/namespace.c:3138
 __do_sys_mount fs/namespace.c:3347 [inline]
 __se_sys_mount fs/namespace.c:3324 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3324
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c889
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc1930ec48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000001324914 RCX: 000000000045c889
RDX: 0000000020000140 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000749 R14: 00000000004ca15a R15: 0000000000000013

Allocated by task 8404:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 __kasan_kmalloc mm/kasan/common.c:495 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:468
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc mm/slab.c:3320 [inline]
 kmem_cache_alloc+0x11b/0x740 mm/slab.c:3484
 __d_alloc+0x2b/0x8e0 fs/dcache.c:1690
 d_alloc+0x4a/0x240 fs/dcache.c:1769
 d_alloc_name+0x80/0xb0 fs/dcache.c:1831
 proc_setup_self+0xe4/0x3c0 fs/proc/self.c:44
 proc_fill_super+0x3fb/0x660 fs/proc/root.c:133
 vfs_get_super+0x12e/0x2d0 fs/super.c:1191
 vfs_get_tree+0x89/0x2f0 fs/super.c:1547
 do_new_mount fs/namespace.c:2813 [inline]
 do_mount+0x1306/0x1b30 fs/namespace.c:3138
 __do_sys_mount fs/namespace.c:3347 [inline]
 __se_sys_mount fs/namespace.c:3324 [inline]
 __x64_sys_mount+0x18f/0x230 fs/namespace.c:3324
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 9:
 save_stack+0x1b/0x40 mm/kasan/common.c:49
 set_track mm/kasan/common.c:57 [inline]
 kasan_set_free_info mm/kasan/common.c:317 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:456
 __cache_free mm/slab.c:3426 [inline]
 kmem_cache_free+0x7f/0x320 mm/slab.c:3694
 rcu_do_batch kernel/rcu/tree.c:2206 [inline]
 rcu_core+0x59f/0x1370 kernel/rcu/tree.c:2433
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292

The buggy address belongs to the object at ffff88808a618cf0
 which belongs to the cache dentry of size 304
The buggy address is located 0 bytes inside of
 304-byte region [ffff88808a618cf0, ffff88808a618e20)
The buggy address belongs to the page:
page:ffffea0002298600 refcount:1 mapcount:0 mapping:000000001a027ea8 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00022985c8 ffffea0002298648 ffff88821bc50540
raw: 0000000000000000 ffff88808a618000 000000010000000b 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808a618b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88808a618c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88808a618c80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fb fb
                                                             ^
 ffff88808a618d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808a618d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
