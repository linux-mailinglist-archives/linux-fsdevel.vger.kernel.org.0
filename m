Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7045241BE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgHKN5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 09:57:19 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44986 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHKN5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:57:18 -0400
Received: by mail-il1-f197.google.com with SMTP id z15so219280ile.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 06:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+cHgg9a8eJJddqLe/oCJVSWP9J8KQvuNJEZvME5xXmA=;
        b=COm+mAgVrCxjgLbQVmVqm00sei+qv96DaBL7FnwBkVOQ6mVAtFOb79XgbwT495hV5h
         6UOW9kNwscH5U7EaeY4aldOJJJV9GVadk4UzLwybdYKJlg89byI018ZaC0fh3G1yypqB
         Ev5jF88MijICb7aAfnqaUTQrir78JmdiZdxlg1A+mM4/EScYMNUhEYTK0F5tglxdShtw
         e+6sy8h25xtB72asNDksLEc6TXXfUTpR4JKKyMM++Ieb/0/6dtrePrAgH8K7fOvnlpfI
         63CjqPVHc0JXM+mKDE0vTG+Z5RIa8i/alU0e7MIw+eWN5w0qaZZpqYwNO8d9vsLhayhV
         Eikw==
X-Gm-Message-State: AOAM533QasviGSCr2hMgNvqRb/MENBM7hxYgF4FynQ6X016XjE4vpsbH
        cbByiW0qLxugT2dyJH3shSAtqkqrbXhwWUxXh7eDiPIL/4w2
X-Google-Smtp-Source: ABdhPJzs9eayEdRluYFEuglfzFGulTDu+xWt1TmqdMl9GvrP3V31DsgZogEIIu9s8vdOXfBs4Z46I6DETIsQ3oOb27AArE8NQjvQ
MIME-Version: 1.0
X-Received: by 2002:a02:9307:: with SMTP id d7mr17785704jah.71.1597154237154;
 Tue, 11 Aug 2020 06:57:17 -0700 (PDT)
Date:   Tue, 11 Aug 2020 06:57:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f50fb505ac9a72c9@google.com>
Subject: memory leak in io_submit_sqes
From:   syzbot <syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d6efb3ac Merge tag 'tty-5.9-rc1' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cb0762900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42163327839348a9
dashboard link: https://syzkaller.appspot.com/bug?extid=a730016dc0bdce4f6ff5
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e877dc900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608291a900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888124949100 (size 256):
  comm "syz-executor808", pid 6480, jiffies 4294949911 (age 33.960s)
  hex dump (first 32 bytes):
    00 78 74 2a 81 88 ff ff 00 00 00 00 00 00 00 00  .xt*............
    90 b0 51 81 ff ff ff ff 00 00 00 00 00 00 00 00  ..Q.............
  backtrace:
    [<0000000084e46f34>] io_alloc_req fs/io_uring.c:1503 [inline]
    [<0000000084e46f34>] io_submit_sqes+0x5dc/0xc00 fs/io_uring.c:6306
    [<000000006d4e19eb>] __do_sys_io_uring_enter+0x582/0x830 fs/io_uring.c:8036
    [<00000000a4116b07>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000067b2aefc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811751d200 (size 96):
  comm "syz-executor808", pid 6480, jiffies 4294949911 (age 33.960s)
  hex dump (first 32 bytes):
    00 78 74 2a 81 88 ff ff 00 00 00 00 00 00 00 00  .xt*............
    0e 01 00 00 00 00 75 22 00 00 00 00 00 0f 1f 04  ......u"........
  backtrace:
    [<00000000073ea2ba>] kmalloc include/linux/slab.h:555 [inline]
    [<00000000073ea2ba>] io_arm_poll_handler fs/io_uring.c:4773 [inline]
    [<00000000073ea2ba>] __io_queue_sqe+0x445/0x6b0 fs/io_uring.c:5988
    [<000000001551bde0>] io_queue_sqe+0x309/0x550 fs/io_uring.c:6060
    [<000000002dfb908f>] io_submit_sqe fs/io_uring.c:6130 [inline]
    [<000000002dfb908f>] io_submit_sqes+0x8b8/0xc00 fs/io_uring.c:6327
    [<000000006d4e19eb>] __do_sys_io_uring_enter+0x582/0x830 fs/io_uring.c:8036
    [<00000000a4116b07>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<0000000067b2aefc>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
