Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FB15514F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGDsS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:48:18 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:46836 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBGDsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:48:18 -0500
Received: by mail-io1-f72.google.com with SMTP id r74so798063iod.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 19:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Gpj439YuL5OBJHJARKwV1DOQm+d7b45Zou3yW231quI=;
        b=o9ekuUCJD5oF4oyhZghvaZ/vTkGFHWK6dvBNmeceB2dO8PrkysqZTIyIG0P8FFOciU
         btZSvpQq5QNtqiRjFF+xIq6Nk1aUK3E7Pn4mAkMBH5x+G+fk2T1ILNJnIcrK73UyyZ2d
         oFM85Ih7zT4ywv4cUSnH/2zDWMvZyaPuvnVxOyJG2Xc6vzLx4N09NuWe2z+jK0pcA+M8
         YTlHpH/isnu2bBo+pN9kTPyzAlksfvaHLIoUEMcKQr7EyLZA8fHSil9A9eUieiJpK9e/
         PtTuKoXhCrvAj6+VnmN8d92Jlka+T80Br0A/59CAmlywSG7bF38YIqmXTQTxxqBIZyEj
         vSxA==
X-Gm-Message-State: APjAAAWnQ19Eq6+J4n3o+88CX3OQg5VPsW52zuCur2nsx/hZe7Z7pk5u
        xAA0MJ1mUQaCaODQEQXwuxhOvix/D3A2lOYGSecWuTqscl6C
X-Google-Smtp-Source: APXvYqz7wFpzoXVy256kEgZ4WKf4hZrVYsh1sJA11Et2hNsV86G3sN012ji4qzOKYzb4Hnft9qHq2XXaFEwqZhAM/Qyj+GciGbWA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:242c:: with SMTP id g12mr1341457iob.193.1581047297212;
 Thu, 06 Feb 2020 19:48:17 -0800 (PST)
Date:   Thu, 06 Feb 2020 19:48:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000860811059df44228@google.com>
Subject: KASAN: slab-out-of-bounds Read in suffix_kstrtoint
From:   syzbot <syzbot+c23efa0cc68e79d551fc@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, ceph-devel@vger.kernel.org,
        darrick.wong@oracle.com, dhowells@redhat.com,
        dongsheng.yang@easystack.cn, gregkh@linuxfoundation.org,
        idryomov@gmail.com, kstewart@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sage@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a0c61bf1 Add linux-next specific files for 20200206
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13925e6ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d320d6d9afdaecd
dashboard link: https://syzkaller.appspot.com/bug?extid=c23efa0cc68e79d551fc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1725bad9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ac3c5ee00000

The bug was bisected to:

commit 61dff92158775e70c0183f4f52c3a5a071dbc24b
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Dec 17 19:15:04 2019 +0000

    Pass consistent param->type to fs_parse()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fa020de00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13fa020de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15fa020de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c23efa0cc68e79d551fc@syzkaller.appspotmail.com
Fixes: 61dff9215877 ("Pass consistent param->type to fs_parse()")

==================================================================
BUG: KASAN: slab-out-of-bounds in suffix_kstrtoint.constprop.0+0x214/0x250 fs/xfs/xfs_super.c:1083
Read of size 1 at addr ffff8880a4b5b3ff by task syz-executor933/9793

CPU: 0 PID: 9793 Comm: syz-executor933 Not tainted 5.5.0-next-20200206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 suffix_kstrtoint.constprop.0+0x214/0x250 fs/xfs/xfs_super.c:1083
 xfs_fc_parse_param+0x991/0xcd0 fs/xfs/xfs_super.c:1127
 vfs_parse_fs_param+0x2b4/0x610 fs/fs_context.c:147
 vfs_parse_fs_string+0x10a/0x170 fs/fs_context.c:191
 generic_parse_monolithic+0x181/0x200 fs/fs_context.c:231
 parse_monolithic_mount_data+0x69/0x90 fs/fs_context.c:679
 do_new_mount fs/namespace.c:2818 [inline]
 do_mount+0x1310/0x1b50 fs/namespace.c:3107
 __do_sys_mount fs/namespace.c:3316 [inline]
 __se_sys_mount fs/namespace.c:3293 [inline]
 __x64_sys_mount+0x192/0x230 fs/namespace.c:3293
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446a8a
Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 7d ae fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 5a ae fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007ffc8d9430c8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc8d9430d0 RCX: 0000000000446a8a
RDX: 00007ffc8d9430d0 RSI: 0000000020000080 RDI: 00007ffc8d9430f0
RBP: 0000000000000003 R08: 00007ffc8d943130 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc8d943130
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9791:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 tomoyo_encode2.part.0+0xf5/0x400 security/tomoyo/realpath.c:44
 tomoyo_encode2 security/tomoyo/realpath.c:30 [inline]
 tomoyo_encode+0x2b/0x50 security/tomoyo/realpath.c:79
 tomoyo_realpath_from_path+0x19c/0x660 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x230/0x430 security/tomoyo/file.c:822
 tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
 security_inode_getattr+0xf2/0x150 security/security.c:1254
 vfs_getattr+0x25/0x70 fs/stat.c:117
 vfs_statx_fd+0x71/0xc0 fs/stat.c:147
 vfs_fstat include/linux/fs.h:3287 [inline]
 __do_sys_newfstat+0x9b/0x120 fs/stat.c:388
 __se_sys_newfstat fs/stat.c:385 [inline]
 __x64_sys_newfstat+0x54/0x80 fs/stat.c:385
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9791:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x2c0 mm/slab.c:3757
 tomoyo_path_perm+0x24e/0x430 security/tomoyo/file.c:842
 tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
 security_inode_getattr+0xf2/0x150 security/security.c:1254
 vfs_getattr+0x25/0x70 fs/stat.c:117
 vfs_statx_fd+0x71/0xc0 fs/stat.c:147
 vfs_fstat include/linux/fs.h:3287 [inline]
 __do_sys_newfstat+0x9b/0x120 fs/stat.c:388
 __se_sys_newfstat fs/stat.c:385 [inline]
 __x64_sys_newfstat+0x54/0x80 fs/stat.c:385
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880a4b5b3c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 31 bytes to the right of
 32-byte region [ffff8880a4b5b3c0, ffff8880a4b5b3e0)
The buggy address belongs to the page:
page:ffffea000292d6c0 refcount:1 mapcount:0 mapping:ffff8880aa4001c0 index:0xffff8880a4b5bfc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002a15908 ffffea00025c80c8 ffff8880aa4001c0
raw: ffff8880a4b5bfc1 ffff8880a4b5b000 0000000100000028 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a4b5b280: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff8880a4b5b300: 00 03 fc fc fc fc fc fc fb fb fb fb fc fc fc fc
>ffff8880a4b5b380: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                                                                ^
 ffff8880a4b5b400: 01 fc fc fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff8880a4b5b480: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
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
