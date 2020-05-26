Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5421E2981
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgEZSBV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 14:01:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45010 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgEZSBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 14:01:21 -0400
Received: by mail-io1-f72.google.com with SMTP id a2so10348781iok.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2020 11:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sd8nmkms1/N9z7AdzgC+R46KNkX+9L8bcWhvBuXIhMY=;
        b=hqrWYbfTn/vj+DWHlcS17jzEShbS+kVhi/fVSsdwNt/Ij9IlK1kSqU4JsgSfek1Moq
         Hfg9Cy8F5HMt6yozNOlDFzznVAhrqnSBe08Zi8r8MHCT59tObaYShYFQtpbIiTQd0Sk7
         wiKjNPxCFWNFqTRT/ICgSIZlqkZCx5gAo6u65XArZe8Z2Nrdp0lLjYlv14ckcKlN/O4v
         AElhJ836Y8mqHaPOwwmdlWlmKAOWFS80sPA9CrosT2rAgMW9F9z9vLkCKP/d6QYFzjv9
         9/XcO251SjLnIsFrxA3+QHniNxa+2qI8/bmXGOVocjCwGvoaJ5/ztr1QCTKT2GVU40El
         wIgA==
X-Gm-Message-State: AOAM532yRwhEu/YvGZJodavjfCsHRKxJTcc0nOvvovOGZUd7sDbHbWrx
        /sXSS7vTnbu5EeDa3SW5t7WZDUgWH7g8Jn+fNLyqK7NK26jI
X-Google-Smtp-Source: ABdhPJyxU0VH7iNc//c7Sjkr4WsJ1d5JTA5CIgPyVmwZ4YpHfw6jWhbSuzpPc4YvdZEnklzJESDhxknh2HX5YWBaeoiYHoWsN9nT
MIME-Version: 1.0
X-Received: by 2002:a6b:ea11:: with SMTP id m17mr17504736ioc.149.1590516078244;
 Tue, 26 May 2020 11:01:18 -0700 (PDT)
Date:   Tue, 26 May 2020 11:01:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da764a05a690e1cc@google.com>
Subject: KASAN: use-after-free Read in cdev_put
From:   syzbot <syzbot+2af7aca9f40c4c773068@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13abef06100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=2af7aca9f40c4c773068
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2af7aca9f40c4c773068@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kobject_put+0x296/0x2f0 lib/kobject.c:745
Read of size 1 at addr ffff88808e2391c4 by task syz-executor.1/11174

CPU: 0 PID: 11174 Comm: syz-executor.1 Not tainted 5.7.0-rc6-next-20200522-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 kobject_put+0x296/0x2f0 lib/kobject.c:745
 cdev_put.part.0+0x32/0x50 fs/char_dev.c:365
 cdev_put+0x1b/0x30 fs/char_dev.c:363
 __fput+0x69b/0x880 fs/file_table.c:284
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x416621
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007fff6b522200 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000416621
RDX: 0000000000000000 RSI: 00000000000000d0 RDI: 0000000000000004
RBP: 0000000000000001 R08: 00000000551800d0 R09: 00000000551800d4
R10: 00007fff6b5222f0 R11: 0000000000000293 R12: 0000000000792bd0
R13: 000000000004e9c2 R14: ffffffffffffffff R15: 000000000078bf0c

Allocated by task 11177:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 evdev_connect+0x80/0x4d0 drivers/input/evdev.c:1352
 input_attach_handler+0x194/0x200 drivers/input/input.c:1031
 input_register_device.cold+0xf5/0x246 drivers/input/input.c:2229
 uinput_create_device drivers/input/misc/uinput.c:364 [inline]
 uinput_ioctl_handler.isra.0+0x1210/0x1d80 drivers/input/misc/uinput.c:870
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl fs/ioctl.c:760 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

Freed by task 11174:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 device_release+0x71/0x200 drivers/base/core.c:1541
 kobject_cleanup lib/kobject.c:701 [inline]
 kobject_release lib/kobject.c:732 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x2f0 lib/kobject.c:749
 kobject_cleanup lib/kobject.c:701 [inline]
 kobject_release lib/kobject.c:732 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x2f0 lib/kobject.c:749
 cdev_put.part.0+0x32/0x50 fs/char_dev.c:365
 cdev_put+0x1b/0x30 fs/char_dev.c:363
 __fput+0x69b/0x880 fs/file_table.c:284
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff88808e239000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 452 bytes inside of
 2048-byte region [ffff88808e239000, ffff88808e239800)
The buggy address belongs to the page:
page:ffffea0002388e40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00029d3dc8 ffffea00027ec908 ffff8880aa000e00
raw: 0000000000000000 ffff88808e239000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88808e239080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808e239100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88808e239180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88808e239200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808e239280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
