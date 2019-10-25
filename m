Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D70E4A76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393548AbfJYLvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:51:12 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56499 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfJYLvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:51:11 -0400
Received: by mail-io1-f72.google.com with SMTP id a22so1455967ioq.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 04:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GCYuTfVSSG8sj2mz/8sBF97BcpApt0s2WcNDvXp5Rdc=;
        b=Nw/VgZW4i3VTF/B64vU0uwwxnY2os/xfaP0zqDB6Xc3ZPmYZ1KMTUgWcvuaF/ubUQL
         hLSSXxS5G4URxahaEyWiCdZuHc5zrVwaO2smopscJc2lt9F6vbFRx9uWblbWawbdfHyy
         yIwcsFMjRCX+kE84FFR5/ONPZ1h5BJn+QHiZVYF8lR06ImGyEsL40RLn+05JoY6Bmvgg
         ng9Ujdr+Ps/Xyl3QRL3qvoyrVImTTyXXn8L8Qu8c78wnJEbOSq1KikrMwNc4p74DOfGS
         1v4l7F5ARQoCFwPM2UzbREk1aWuIM6OptzV1aEMRlraEAeSNq1kzIPvgcWv5l1MXUt5q
         D7ig==
X-Gm-Message-State: APjAAAWx23kgjCFbHhLI7fr2409OEJt0uMZ2dhiEK6EL21WNNpnSGHUE
        XjlFiS4x9tCqXHeX0ToQ1wIe8bAw/Vncn0FlgFoJqEo2RmxY
X-Google-Smtp-Source: APXvYqzi/Tq9tGi61conwDmSuuhTnjfKda+BVSQOBrtGtekXzYN1GkXl7rH3BUyOB+Lfpg3b30IwlpSKdF3RBgWrpzeQAVPYjyPu
MIME-Version: 1.0
X-Received: by 2002:a02:ba8d:: with SMTP id g13mr3313659jao.93.1572004268056;
 Fri, 25 Oct 2019 04:51:08 -0700 (PDT)
Date:   Fri, 25 Oct 2019 04:51:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbbe1e0595bac322@google.com>
Subject: KASAN: null-ptr-deref Write in io_wq_cancel_all
From:   syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    139c2d13 Add linux-next specific files for 20191025
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab5a70e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in set_bit  
include/asm-generic/bitops-instrumented.h:28 [inline]
BUG: KASAN: null-ptr-deref in io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:574
Write of size 8 at addr 0000000000000004 by task syz-executor.5/17477

CPU: 1 PID: 17477 Comm: syz-executor.5 Not tainted 5.4.0-rc4-next-20191025  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
  set_bit include/asm-generic/bitops-instrumented.h:28 [inline]
  io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:574
  io_ring_ctx_wait_and_kill+0x1e2/0x710 fs/io_uring.c:3679
  io_uring_release+0x42/0x50 fs/io_uring.c:3691
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  exit_task_work include/linux/task_work.h:22 [inline]
  do_exit+0x904/0x2e60 kernel/exit.c:817
  do_group_exit+0x135/0x360 kernel/exit.c:921
  get_signal+0x47c/0x24f0 kernel/signal.c:2734
  do_signal+0x87/0x1700 arch/x86/kernel/signal.c:815
  exit_to_usermode_loop+0x286/0x380 arch/x86/entry/common.c:159
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x65f/0x760 arch/x86/entry/common.c:300
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459ef9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7129716c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001a9
RAX: 0000000000000005 RBX: 0000000000000002 RCX: 0000000000459ef9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000ebf
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f71297176d4
R13: 00000000004c14ae R14: 00000000004d4c68 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
