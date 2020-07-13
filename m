Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED6E21CD27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGMCYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Jul 2020 22:24:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52075 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgGMCYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:24:16 -0400
Received: by mail-io1-f70.google.com with SMTP id l1so7160599ioh.18
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2020 19:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oeDO3uGOlGXCY3ZqE1/B/SxjjNdp+6TXbFewQjpCefw=;
        b=unp9DCJdUPL42K8vrAl4IQasP0/wnokvMN9CEDLOuLgQmTFRyfRwUtFTTM/GSNeK89
         sKj827vjPtR2u0EtNYogPNqNkxU80WpHDKyNnlK6Y+gBbwhRMaTlcEHEaB2X0CmjB51Z
         oI8zQG5gkqUu1o5MMzZEV1pd4Ph0ok2gJwvlgdHtvXF+qO+Nq/rF8NfzFvzARvegEFyr
         MhLJWr+XOmdpEc9LSH6j/yKdfB8KJY2urGrM+63lGhml2xTL065HnJUhvLcAgpBH9jfF
         WPANMoWl+6oFXH2qJW8eUnES4DqXiEaY+nWrxxGkzgJBnfre9Zo1Hoh8efvzgNKXcaPY
         QywA==
X-Gm-Message-State: AOAM5320mhuB/ZP+c2OIZrSHkSTQW5Kt8JTqe4wQmw4HCjPnfhl8pFwE
        zLF6jB70HoISjrBd4DtbVY9MaSRbEq6aKT0SUCenPt8cX69m
X-Google-Smtp-Source: ABdhPJxRfVkxi74W5tf9BM+cl+c0WkhO3ZD1Gj8UUT++sqELpJ0xxRFyOqGRMEVMAJfZrykDKadxtB6k6oIeE2W8sjCkgYoqqHmJ
MIME-Version: 1.0
X-Received: by 2002:a02:b897:: with SMTP id p23mr7141821jam.32.1594607055648;
 Sun, 12 Jul 2020 19:24:15 -0700 (PDT)
Date:   Sun, 12 Jul 2020 19:24:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bbb6705aa49635a@google.com>
Subject: KASAN: use-after-free Read in userfaultfd_release (2)
From:   syzbot <syzbot+75867c44841cb6373570@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    89032636 Add linux-next specific files for 20200708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1028732f100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=75867c44841cb6373570
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c4c8db100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12cbb68f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in userfaultfd_release+0x57f/0x5f0 fs/userfaultfd.c:879
Read of size 8 at addr ffff88809b09af88 by task syz-executor902/6813

CPU: 0 PID: 6813 Comm: syz-executor902 Not tainted 5.8.0-rc4-next-20200708-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 userfaultfd_release+0x57f/0x5f0 fs/userfaultfd.c:879
 __fput+0x33c/0x880 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:135
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop arch/x86/entry/common.c:239 [inline]
 __prepare_exit_to_usermode+0x1e9/0x1f0 arch/x86/entry/common.c:269
 do_syscall_64+0x6c/0xe0 arch/x86/entry/common.c:393
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4401f9
Code: Bad RIP value.
RSP: 002b:00007ffdd722dfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000143
RAX: ffffffffffffffe8 RBX: 00000000004002c8 RCX: 00000000004401f9
RDX: 00000000004401f9 RSI: 0000000000400aa0 RDI: 0000000000000000
RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401a00
R13: 0000000000401a90 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6813:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:536 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x148/0x550 mm/slab.c:3482
 __do_sys_userfaultfd+0x96/0x4b0 fs/userfaultfd.c:2026
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6813:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 __do_sys_userfaultfd+0x3cf/0x4b0 fs/userfaultfd.c:2061
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88809b09ae00
 which belongs to the cache userfaultfd_ctx_cache of size 408
The buggy address is located 392 bytes inside of
 408-byte region [ffff88809b09ae00, ffff88809b09af98)
The buggy address belongs to the page:
page:ffffea00026c2680 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880a03d5dc0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffff8880a3de5d50 ffff8880a3de5d50 ffff888219701b00
raw: ffff8880a03d5dc0 ffff88809b09a000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88809b09ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809b09af00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88809b09af80: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff88809b09b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809b09b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
