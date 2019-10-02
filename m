Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C572CC92B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 21:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfJBT4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 15:56:21 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:38208 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfJBT4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:56:12 -0400
Received: by mail-io1-f70.google.com with SMTP id e6so759008iog.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2019 12:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JmmhvD56+86cKmGJpC46U0DMJFQEjRV4WR2YbpopV7Q=;
        b=rn77aRjaPWMaKQUfKC1oUfok7Q+IvTeuDD1r+xyIZmuKYibvfpOfsYC4pwyV3bFT0o
         B+6yfeQssSkg29jU+mZWk7zHGIgdwRNqqvP9UMVIFr5bA9M7hcnOglMlCGhcDK40ObD1
         N5+oRRYCIMeplqsypQR/r+84D2UCB/uy0d0WJda4+KuiLuthfl1n30Sa9k19pXA77E5B
         q56jkyBmX9rsPkxtTV3z1Z6eXvGGRkK/BkZH15+fq/lS6rpLKSDnWIXw9PZ8y/HLejLQ
         s6SLL3WXr8ka+FbVsANdtDqrYteoiESz+wcHc6rMaaEFAwexYQpNI0BXB0ulslARHvyZ
         dnwA==
X-Gm-Message-State: APjAAAXYd2aiWtB5q2o9m3kyiUt0IkU7bURvdpq/jRpIeQqAV6b1hsQG
        1OdGg2SD5ZbE3CbsJhlgbL2dPHsiMyR13bWI/k6icqqUdEwg
X-Google-Smtp-Source: APXvYqyKWFQ9nMYaeB+adjLLYq+GWCbEqjA5HKFVq3Wi4PvimrZwawHHv0M8lKnOp3YqEfVpzW5RXVsseabjBLfm+59ou6SvFEzr
MIME-Version: 1.0
X-Received: by 2002:a02:cd06:: with SMTP id g6mr5596386jaq.89.1570046172033;
 Wed, 02 Oct 2019 12:56:12 -0700 (PDT)
Date:   Wed, 02 Oct 2019 12:56:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005d7df10593f2dc07@google.com>
Subject: KMSAN: uninit-value in read_rio
From:   syzbot <syzbot+a3b2314912629b97f231@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with kmsan_i..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13806633600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f03c659d0830ab8d
dashboard link: https://syzkaller.appspot.com/bug?extid=a3b2314912629b97f231
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a3b2314912629b97f231@syzkaller.appspotmail.com

usb 5-1: Rio opened.
=====================================================
BUG: KMSAN: uninit-value in __vfs_read+0x1a9/0xc90 fs/read_write.c:425
CPU: 1 PID: 12169 Comm: syz-executor.4 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x191/0x1f0 lib/dump_stack.c:113
  kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
  __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
  read_rio+0x55d/0x860 drivers/usb/misc/rio500.c:404
  __vfs_read+0x1a9/0xc90 fs/read_write.c:425
  vfs_read+0x359/0x6f0 fs/read_write.c:461
  ksys_read+0x265/0x430 fs/read_write.c:587
  __do_sys_read fs/read_write.c:597 [inline]
  __se_sys_read+0x92/0xb0 fs/read_write.c:595
  __x64_sys_read+0x4a/0x70 fs/read_write.c:595
  do_syscall_64+0xbc/0xf0 arch/x86/entry/common.c:297
  entry_SYSCALL_64_after_hwframe+0x63/0xe7
RIP: 0033:0x459a29
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd0a6183c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459a29
RDX: 0000000000000009 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd0a61846d4
R13: 00000000004c7066 R14: 00000000004dc8c8 R15: 00000000ffffffff

Local variable description: ----partial@read_rio
Variable was created at:
  read_rio+0xff/0x860 drivers/usb/misc/rio500.c:360
  __vfs_read+0x1a9/0xc90 fs/read_write.c:425
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
