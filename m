Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970F02C4B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfE1KsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 06:48:06 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:56319 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1KsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 06:48:06 -0400
Received: by mail-it1-f199.google.com with SMTP id o126so1946529itc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2019 03:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0nui5Erb9mPjKkGbLUOeBj8g+XDIbbULEjjyl9kXiHU=;
        b=qqJzhtzHhEOF5n2Md89/sEFwk7xI3FS31bpEbrakrkoxMjEJHV4xmyz0SaQsRdEVRc
         1hSAzTyoCylR6FQd9H15d0UsWmIFshJ+JecHo1WhFgcNAUBC+9CX3TooOQPtpdXdIR2u
         R56/aVS0nkwFgv8pcGfwQXffLR7POxnNkJR0sLokT0eI6dp1MbWToJB5OOsUdqxGBrgk
         P3LzUS6FtNtGnQKBxf8DDwTPeq05Ea+EwE3smFYumxxhJGcr58A1TYGcHjD6KHbDpwk5
         MDA4BO50LIRaq4SELtgDJz2iJoqL1ETIYwyOg6ixEMsRmHNWvBu6Wixm9L8lxTAcNcyc
         KN/w==
X-Gm-Message-State: APjAAAVsk45jJYU6hZ8nP0m9y9rLHkYBAvOkkIcx6OCmnagUHtUOHvaz
        g5JD07W+tfn6GM7O/hT8rc6SjonUedSpGkUmSVg7X8DxMvp/
X-Google-Smtp-Source: APXvYqwOl9+z3XSVgq/rWqTJjMm0wzXaZIrMXRTXxNwn6ciNwHUq+gQi/t8avgjA3A9klnIUAhByu5nHzGzhvdjuep01l8PC9bDC
MIME-Version: 1.0
X-Received: by 2002:a24:5547:: with SMTP id e68mr2727057itb.83.1559040485433;
 Tue, 28 May 2019 03:48:05 -0700 (PDT)
Date:   Tue, 28 May 2019 03:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000532b860589f0669a@google.com>
Subject: general protection fault in cdev_del
From:   syzbot <syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=178e4526a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
dashboard link: https://syzkaller.appspot.com/bug?extid=67b2bd0e34f952d0321e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dc5d54a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cae526a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 2486 Comm: kworker/1:2 Not tainted 5.2.0-rc1+ #9
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:592
Code: cf 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 93 a5 d5 ff 48 8d  
7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
RSP: 0018:ffff8881d18e7218 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff8881d249a100 RCX: ffffffff820d879e
RDX: 000000000000000c RSI: ffffffff8167705d RDI: 0000000000000064
RBP: 0000000000000000 R08: ffff8881d18d1800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8881d25c9100 R14: 0000000000000000 R15: ffff8881cc2a8070
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f35af318000 CR3: 00000001cc182000 CR4: 00000000001406e0
Call Trace:
  tty_unregister_device drivers/tty/tty_io.c:3192 [inline]
  tty_unregister_device+0x10d/0x1a0 drivers/tty/tty_io.c:3187
  hso_serial_tty_unregister drivers/net/usb/hso.c:2245 [inline]
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2682 [inline]
  hso_probe.cold+0xc8/0x120 drivers/net/usb/hso.c:2948
  usb_probe_interface+0x30b/0x7a0 drivers/usb/core/driver.c:361
  really_probe+0x287/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x1700 drivers/base/core.c:2111
  usb_set_configuration+0xdf6/0x1670 drivers/usb/core/message.c:2023
  generic_probe+0x9d/0xd5 drivers/usb/core/generic.c:210
  usb_probe_device+0xa2/0x100 drivers/usb/core/driver.c:266
  really_probe+0x287/0x660 drivers/base/dd.c:509
  driver_probe_device+0x104/0x210 drivers/base/dd.c:670
  __device_attach_driver+0x1c4/0x230 drivers/base/dd.c:777
  bus_for_each_drv+0x15e/0x1e0 drivers/base/bus.c:454
  __device_attach+0x217/0x360 drivers/base/dd.c:843
  bus_probe_device+0x1e6/0x290 drivers/base/bus.c:514
  device_add+0xae6/0x1700 drivers/base/core.c:2111
  usb_new_device.cold+0x8c1/0x1016 drivers/usb/core/hub.c:2534
  hub_port_connect drivers/usb/core/hub.c:5089 [inline]
  hub_port_connect_change drivers/usb/core/hub.c:5204 [inline]
  port_event drivers/usb/core/hub.c:5350 [inline]
  hub_event+0x1adc/0x35a0 drivers/usb/core/hub.c:5432
  process_one_work+0x90a/0x1580 kernel/workqueue.c:2268
  worker_thread+0x96/0xe20 kernel/workqueue.c:2414
  kthread+0x30e/0x420 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 3b56fa5a205cba42 ]---
RIP: 0010:cdev_del+0x22/0x90 fs/char_dev.c:592
Code: cf 0f 1f 80 00 00 00 00 55 48 89 fd 48 83 ec 08 e8 93 a5 d5 ff 48 8d  
7d 64 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48  
89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 4f 48
RSP: 0018:ffff8881d18e7218 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffff8881d249a100 RCX: ffffffff820d879e
RDX: 000000000000000c RSI: ffffffff8167705d RDI: 0000000000000064
RBP: 0000000000000000 R08: ffff8881d18d1800 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8881d25c9100 R14: 0000000000000000 R15: ffff8881cc2a8070
FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f35af318000 CR3: 00000001cc182000 CR4: 00000000001406e0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
