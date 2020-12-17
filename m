Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0746A2DD4A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 16:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgLQPyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 10:54:51 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38694 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgLQPyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:54:51 -0500
Received: by mail-io1-f72.google.com with SMTP id q140so27579570iod.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 07:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=m1z8Xry1KKXh3W2b7n7wksWhEKpKfj57GIAa8FsV6s0=;
        b=bJpjAlVErsrzM4hKBZ5jLdypZ99eHl0WvSvwHkErBYbVSPqjzcqtg8DE/eFfeJigF/
         nmV117+X36DPzGhff2jkESnMxrKtcXzNCrHvOLHtlwZlyLg9Xas4a2OnRSAfK2XgokuE
         vH6MYIYZ3/Z8/f0lxLaE9Jc6Ch6veXGaxq3M7+OY2d7blUQ748DQu6UJRnByKpvAGOv1
         Y/tjb4kH8aNK3TMRSchdTRMRzLsUw3DiZzxGzboiXx4GF6RlEOvwKy2dx7Ar8oHmfBvp
         6a+aUvORu/QEAr5zehJBgvEJFcXKH83xUGvH3RIXU5dPC7J1xNf161emBbrDZcXFNQOD
         IWTQ==
X-Gm-Message-State: AOAM531Zs3z6aTZHTU+G1CenaBJXp4UKUDhBLePMMCquU75n8zVXgD3h
        IngdgMoR7T6E270sS5LjRVGFu7ZQ8IZfNAby/r/QoSstDaOk
X-Google-Smtp-Source: ABdhPJzbE94LOGk1THU2x4Jf2Zkz2gwX7nSM8+VQ5wQ+7znn7/l7XiAsGgXqGMUEE78kWNwYfaWXy3BV4KevWWLPy0mfdwuEu+7L
MIME-Version: 1.0
X-Received: by 2002:a02:91c2:: with SMTP id s2mr48568855jag.48.1608220449935;
 Thu, 17 Dec 2020 07:54:09 -0800 (PST)
Date:   Thu, 17 Dec 2020 07:54:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3962305b6ab0077@google.com>
Subject: KASAN: null-ptr-deref Read in filp_close
From:   syzbot <syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com>
To:     christian.brauner@ubuntu.com, gscrivan@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e60366d Merge tag 'fallthrough-fixes-clang-5.11-rc1' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f15413500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db720fe37a6a41d8
dashboard link: https://syzkaller.appspot.com/bug?extid=96cfd2b22b3213646a93
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e1a00b500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128e41f500000

The issue was bisected to:

commit 582f1fb6b721facf04848d2ca57f34468da1813e
Author: Giuseppe Scrivano <gscrivan@redhat.com>
Date:   Wed Nov 18 10:47:45 2020 +0000

    fs, close_range: add flag CLOSE_RANGE_CLOEXEC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e85613500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e85613500000
console output: https://syzkaller.appspot.com/x/log.txt?x=11e85613500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96cfd2b22b3213646a93@syzkaller.appspotmail.com
Fixes: 582f1fb6b721 ("fs, close_range: add flag CLOSE_RANGE_CLOEXEC")

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
BUG: KASAN: null-ptr-deref in atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
BUG: KASAN: null-ptr-deref in filp_close+0x22/0x170 fs/open.c:1274
Read of size 8 at addr 0000000000000077 by task syz-executor511/8522

CPU: 1 PID: 8522 Comm: syz-executor511 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:549 [inline]
 kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 instrument_atomic_read include/linux/instrumented.h:71 [inline]
 atomic64_read include/asm-generic/atomic-instrumented.h:837 [inline]
 atomic_long_read include/asm-generic/atomic-long.h:29 [inline]
 filp_close+0x22/0x170 fs/open.c:1274
 close_files fs/file.c:402 [inline]
 put_files_struct fs/file.c:417 [inline]
 put_files_struct+0x1cc/0x350 fs/file.c:414
 exit_files+0x12a/0x170 fs/file.c:435
 do_exit+0xb4f/0x2a00 kernel/exit.c:818
 do_group_exit+0x125/0x310 kernel/exit.c:920
 get_signal+0x428/0x2100 kernel/signal.c:2792
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x124/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x447039
Code: Unable to access opcode bytes at RIP 0x44700f.
RSP: 002b:00007f1b1225cdb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00000000006dbc28 RCX: 0000000000447039
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00000000006dbc2c
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007fff223b6bef R14: 00007f1b1225d9c0 R15: 00000000006dbc2c
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
