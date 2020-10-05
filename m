Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294902841A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJEUtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 16:49:24 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:51263 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgJEUtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 16:49:24 -0400
Received: by mail-il1-f205.google.com with SMTP id e3so8332482ilq.18
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 13:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4gS6tQ16mTAvNSH6terYY+v6JKkK5KLz9dMkwlTRuGg=;
        b=U/NROgmP1JXwRJs/WAMntFlYERoTr1GLs4/lxavB18ImM/Q5wPa1kJhR1z6W/6HpnY
         P9CrO6nluzq6DQA1r6GX1k+YDORU3xTEAiYp436M9Qk0l79oM6g8KJa/wZQVxh9O6qEI
         FzYIkdwKpLcwVyhBFS1Is0bQ9AoJQaMKIXb7P69SILyKLP6djnzkPBTpvWIS4UsWLxM8
         RfM5nD0/R/GSBLLsXrjDW4UsiwiAm8Aw3GpaJr7Nw4VyYvkZjnNdfGwL1V8ZFDEj/L4U
         Asz7JU21il/Yoj2ZqEzcszrc4ArQIwqLAp9qD4nflulbc3uYjnSCxQmxZVuZwt0QfHoa
         gX+A==
X-Gm-Message-State: AOAM532iWGJv2N72fcZW+1nrqd+5YLpN+CtmweCzL5ayVW86/UuLpX1l
        vgSydNCPpEWdEvScJAbAUlZX5ecEfpSwao5mwOv+fticEvZv
X-Google-Smtp-Source: ABdhPJz9QzCL7G9kCnlHQEaESrWjvNy1Nad43ymz5O0eIPHd8In6KVd7G8A9QoZn9M3eRBYUzw9y/sEsEQ1cHyG1YFsFnbo9+OUx
MIME-Version: 1.0
X-Received: by 2002:a92:b00e:: with SMTP id x14mr1064103ilh.4.1601930963821;
 Mon, 05 Oct 2020 13:49:23 -0700 (PDT)
Date:   Mon, 05 Oct 2020 13:49:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000dacf905b0f29e75@google.com>
Subject: KASAN: invalid-free in put_files_struct
From:   syzbot <syzbot+9cee17fa4a973a9e60f2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15d14513900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=9cee17fa4a973a9e60f2
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cee17fa4a973a9e60f2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in put_files_struct fs/file.c:434 [inline]
BUG: KASAN: double-free or invalid-free in put_files_struct+0x2c8/0x350 fs/file.c:426

CPU: 0 PID: 27522 Comm: syz-executor.0 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 kasan_report_invalid_free+0x51/0x80 mm/kasan/report.c:477
 __kasan_slab_free+0x107/0x120 mm/kasan/common.c:401
 __cache_free mm/slab.c:3422 [inline]
 kmem_cache_free.part.0+0x74/0x1e0 mm/slab.c:3697
 put_files_struct fs/file.c:434 [inline]
 put_files_struct+0x2c8/0x350 fs/file.c:426
 exit_files+0x7e/0xa0 fs/file.c:458
 do_exit+0xb43/0x29f0 kernel/exit.c:801
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
 __do_fast_syscall_32+0x6c/0x90 arch/x86/entry/common.c:138
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f41549
Code: Bad RIP value.
RSP: 002b:00000000f553b0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000171
RAX: 0000000000090fc0 RBX: 0000000000000004 RCX: 0000000020f6f000
RDX: 00000000fffffea7 RSI: 0000000020000004 RDI: 0000000020b63fe4
RBP: 000000000000001c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 30131:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3316 [inline]
 kmem_cache_alloc+0x13a/0x3f0 mm/slab.c:3486
 dup_fd+0x89/0xc90 fs/file.c:293
 copy_files kernel/fork.c:1461 [inline]
 copy_process+0x1d99/0x6940 kernel/fork.c:2058
 _do_fork+0xe8/0xb10 kernel/fork.c:2429
 __do_sys_clone3+0x1dd/0x320 kernel/fork.c:2704
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

The buggy address belongs to the object at ffff88805c9a00c0
 which belongs to the cache files_cache of size 832
The buggy address is located 192 bytes to the left of
 832-byte region [ffff88805c9a00c0, ffff88805c9a0400)
The buggy address belongs to the page:
page:00000000953999c6 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88805c9a0840 pfn:0x5c9a0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002669748 ffffea0002a460c8 ffff88821bc47500
raw: ffff88805c9a0840 ffff88805c9a00c0 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88805c99ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805c99ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805c9a0000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                   ^
 ffff88805c9a0080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88805c9a0100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
