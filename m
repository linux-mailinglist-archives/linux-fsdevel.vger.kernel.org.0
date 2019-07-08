Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83519629BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 21:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391730AbfGHThH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 15:37:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48643 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391655AbfGHThG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:37:06 -0400
Received: by mail-io1-f72.google.com with SMTP id z19so20223784ioi.15
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2019 12:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GUa9cZJ8ImXXkbt2lBydisFYDuQGqcV3NZw+kvaoZYo=;
        b=Tg9UNcwbvsASn9h4gtdI++ZBnN1bc/nGa8Q0HjFUetQNW7YTT8h++IS3fN4F4B4iyK
         TIOszsKT7jwYONyFaWZSv8BUPItvUvtNd2CuwAME/sutsnSwo/0zx7z6kjI21jA6CTXN
         MugiZZBwSlRYqZGcoqsjPrA/BwtokML5vYmk/GBpRZGB2l70w3Abaoiky9qGHR0Y4KYs
         r4n6py6HmqCbOrO4aDHyylc7/s3LVtn2tZ+rc2J3C80ZkWHaZrjy/M/Kh02ryEYFt1pP
         DvBvD1OYwx7lGbK3PGdE5+9FwCX27CLbZun7kpoQ0NWwNN3QIISuplKPrVLkXm5i4y+B
         KwgQ==
X-Gm-Message-State: APjAAAXaqNu/aOH8y5Jg64ZlbWyt2T8BhExpvx1v/VGLsqJujZ0106i7
        skejArqqwWkBjHCwuZ6r2LvgmkFNQFTEL3N2WxlL8Pi/7S8H
X-Google-Smtp-Source: APXvYqy5vmeb5tsQ9SDTC13H7/uGhyBpBt4LOXC8NwsUUbTsafLH2NBrZguq/jvGzP9tojrP5rPS9sVgAEK/v8qw3Np+gLXWzGOn
MIME-Version: 1.0
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr6074270iop.293.1562614626062;
 Mon, 08 Jul 2019 12:37:06 -0700 (PDT)
Date:   Mon, 08 Jul 2019 12:37:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b519af058d3091d1@google.com>
Subject: kernel BUG at lib/lockref.c:LINE!
From:   syzbot <syzbot+f70e9b00f8c7d4187bd0@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d58b5ab9 Add linux-next specific files for 20190708
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123d6887a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf9882946ecc11d9
dashboard link: https://syzkaller.appspot.com/bug?extid=f70e9b00f8c7d4187bd0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=173375c7a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1536f9bfa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f70e9b00f8c7d4187bd0@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/lockref.c:189!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9350 Comm: syz-executor444 Not tainted 5.2.0-next-20190708 #33
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:lockref_mark_dead lib/lockref.c:189 [inline]
RIP: 0010:lockref_mark_dead+0x8b/0xa0 lib/lockref.c:187
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03  
7e 1d c7 43 38 80 ff ff ff 5b 41 5c 5d c3 e8 75 19 38 fe <0f> 0b 48 89 df  
e8 0b 59 72 fe eb ab e8 a4 59 72 fe eb dc 90 90 55
RSP: 0018:ffff88809004fc90 EFLAGS: 00010293
RAX: ffff88808bcc0300 RBX: ffff8880a69b0520 RCX: ffffffff833a3abf
RDX: 0000000000000000 RSI: ffffffff833a3afb RDI: 0000000000000005
RBP: ffff88809004fca0 R08: ffff88808bcc0300 R09: ffffed1014d360a5
R10: ffffed1014d360a4 R11: ffff8880a69b0523 R12: 0000000000000000
R13: ffff8880a69b0520 R14: ffff8880a69b04a0 R15: 0000000000000000
FS:  000055555571f880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555738938 CR3: 0000000091be1000 CR4: 00000000001406f0
Call Trace:
  __dentry_kill+0x5f/0x600 fs/dcache.c:560
  shrink_dcache_parent+0x2c9/0x3d0 fs/dcache.c:1565
  vfs_rmdir fs/namei.c:3882 [inline]
  vfs_rmdir+0x26f/0x4f0 fs/namei.c:3857
  do_rmdir+0x39e/0x420 fs/namei.c:3940
  __do_sys_rmdir fs/namei.c:3958 [inline]
  __se_sys_rmdir fs/namei.c:3956 [inline]
  __x64_sys_rmdir+0x36/0x40 fs/namei.c:3956
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441917
Code: 0f 1f 00 b8 57 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 09 fc ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 54 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 8d 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe53fc08f8 EFLAGS: 00000207 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 0000000000441917
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffe53fc1a90
RBP: 00000000000024ef R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000005 R11: 0000000000000207 R12: 00007ffe53fc1a90
R13: 00005555557288c0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 407254279c8c4b61 ]---
RIP: 0010:lockref_mark_dead lib/lockref.c:189 [inline]
RIP: 0010:lockref_mark_dead+0x8b/0xa0 lib/lockref.c:187
Code: 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 04 3c 03  
7e 1d c7 43 38 80 ff ff ff 5b 41 5c 5d c3 e8 75 19 38 fe <0f> 0b 48 89 df  
e8 0b 59 72 fe eb ab e8 a4 59 72 fe eb dc 90 90 55
RSP: 0018:ffff88809004fc90 EFLAGS: 00010293
RAX: ffff88808bcc0300 RBX: ffff8880a69b0520 RCX: ffffffff833a3abf
RDX: 0000000000000000 RSI: ffffffff833a3afb RDI: 0000000000000005
RBP: ffff88809004fca0 R08: ffff88808bcc0300 R09: ffffed1014d360a5
R10: ffffed1014d360a4 R11: ffff8880a69b0523 R12: 0000000000000000
R13: ffff8880a69b0520 R14: ffff8880a69b04a0 R15: 0000000000000000
FS:  000055555571f880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555738938 CR3: 0000000091be1000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
