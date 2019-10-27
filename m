Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B260E604C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 03:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfJ0CgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Oct 2019 22:36:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43122 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfJ0CgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Oct 2019 22:36:10 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so5394028ioo.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Oct 2019 19:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yCx8cEP9LpJ4m50eMQ5ykCVi6OurwW26hlxrBSgzIkc=;
        b=dfbJmUUm6ztstPz08ceN38lQ/tzlD5xi4cvxGylXYE4GyZLn4VWw2DBdVcIi7Qe0/P
         0sax1k0P4j2nrQWgBovT/nrGZKlOSp/fwEty49JYdgP465ijopdkPe4db3kRKJIwDSNU
         Dj/97D/0OJ/xOX8t7q/ihigYMpV18N17OWZsYxmq7YcAxMFFy5efDt0SOEVkHNGgEDu6
         ar8RHm38txo3YblNN49raMTitxGJMlxSdIww11SIxbnLZC7u9e40z5TDl/ZN2nTOGVqd
         ESSM9A/MooQVWhrqdmv/rXw6VHV7tG11Fm5fRlMiY/MTGWeuiP6A57LRxDr+xjTNP3RV
         GIyA==
X-Gm-Message-State: APjAAAXP6XEbrOQ4huB4IQYA0xl2oHypMMPVqwYcGXiu4l/AiOzWD3w4
        ODGUtlsvjm3CAJmb/WAbf9ie619n6INyg3ejTrK23RTzXby4
X-Google-Smtp-Source: APXvYqwgZBh1WoBbz1CdFayyooQPEDzAySNCiRpQRVGPlm1srTgOFJl4hk7hmSSXBUduywkG70WG6ZWJwZ7LvqdCNKQ5C5bBEPX0
MIME-Version: 1.0
X-Received: by 2002:a5d:814c:: with SMTP id f12mr12008236ioo.174.1572143769334;
 Sat, 26 Oct 2019 19:36:09 -0700 (PDT)
Date:   Sat, 26 Oct 2019 19:36:09 -0700
In-Reply-To: <000000000000fbbe1e0595bac322@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e83aa20595db3e33@google.com>
Subject: Re: KASAN: null-ptr-deref Write in io_wq_cancel_all
From:   syzbot <syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    139c2d13 Add linux-next specific files for 20191025
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12888a00e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28fd7a693df38d29
dashboard link: https://syzkaller.appspot.com/bug?extid=d958a65633ea70280b23
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160573c0e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d958a65633ea70280b23@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in set_bit  
include/asm-generic/bitops-instrumented.h:28 [inline]
BUG: KASAN: null-ptr-deref in io_wq_cancel_all+0x28/0x2a0 fs/io-wq.c:574
Write of size 8 at addr 0000000000000004 by task syz-executor.2/9365

CPU: 1 PID: 9365 Comm: syz-executor.2 Not tainted 5.4.0-rc4-next-20191025 #0
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
  syscall_return_slowpath+0x47a/0x530 arch/x86/entry/common.c:274
  ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:344
RIP: 0033:0x45c909
Code: ff 48 85 f6 0f 84 d7 8c fb ff 48 83 ee 10 48 89 4e 08 48 89 3e 48 89  
d7 4c 89 c2 4d 89 c8 4c 8b 54 24 08 b8 38 00 00 00 0f 05 <48> 85 c0 0f 8c  
ae 8c fb ff 74 01 c3 31 ed 48 f7 c7 00 00 01 00 75
RSP: 002b:00007fe3de137db0 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
RAX: 0000000000000000 RBX: 00007fe3de138700 RCX: 000000000045c909
RDX: 00007fe3de1389d0 RSI: 00007fe3de137db0 RDI: 00000000003d0f00
RBP: 00007ffff688f6a0 R08: 00007fe3de138700 R09: 00007fe3de138700
R10: 00007fe3de1389d0 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffff688f53f R14: 00007fe3de1389c0 R15: 000000000075bfd4
==================================================================

