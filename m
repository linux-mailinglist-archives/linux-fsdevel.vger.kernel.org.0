Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034008B9D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfHMNQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 09:16:02 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:44686 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfHMNQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:16:01 -0400
Received: by mail-ot1-f69.google.com with SMTP id q16so90986546otn.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d0r87t9CMJReMCIKgADceWEv1Iat/T7XNQ2Cc2NBdKE=;
        b=gr5hCKqRlpI2uK60EqxOA3dy9ZJd/oA3cGoinW5+NlwJQ9iDfNyLIybntwQSnygOD7
         L855TrhJfCkYt337EffspOuHaDkzFL9jWw+k3KTqUvH+4tNVsHOCDhM1tfWYVG8l3+Qh
         P4zous9f0FqfmDQrdzPRkVCBye5mtlljQIJjr8Pq+RW9+DORgx/DM1saXIwoOH7vyNYL
         mYivb6ZshFOR6D8xTwNLeJi/QrlVzlDvEEjINpBhDohv9HAGQyH+eRKV8bxAZ1sS01Fx
         wGsotygWjxGeAue5V31o9RmKCDi37A7vbgDiamEtiIKOxmf4CQFPh8tvgFDje1EwcIrm
         2Eug==
X-Gm-Message-State: APjAAAWIhIzjAeM9BK36pu0abX13yhOaLxfTbcPO0kqwArgIQX+QsTVb
        /G6iE2cABnXvmfjdczaO+/WS58WKTNm3FjNqffBDPOafRAh2
X-Google-Smtp-Source: APXvYqwg8efLPEJCxZEQfv9hR8WXl5BIq9Gqby8BQemxWa0W5JTjEXd5+qVJNcnjjaCdZu44Txe0fJzDN+RwYCTnLehdS6HyoGQ1
MIME-Version: 1.0
X-Received: by 2002:a6b:da1a:: with SMTP id x26mr38773136iob.285.1565702160485;
 Tue, 13 Aug 2019 06:16:00 -0700 (PDT)
Date:   Tue, 13 Aug 2019 06:16:00 -0700
In-Reply-To: <CAAeHK+waUUNpGp1b2WqXQHkbBcQT_MonG62-bK-aEj2dvYr-gA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000199b6c058fff71c8@google.com>
Subject: Re: general protection fault in cdev_del
From:   syzbot <syzbot+67b2bd0e34f952d0321e@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
KASAN: use-after-free Read in hso_free_interface

==================================================================
BUG: KASAN: use-after-free in hso_free_interface+0x3f2/0x4f0  
drivers/net/usb/hso.c:3108
Read of size 8 at addr ffff8881d112d998 by task kworker/0:1/12

CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.2.0-rc1+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x67/0x231 mm/kasan/report.c:188
  __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:317
  kasan_report+0xe/0x20 mm/kasan/common.c:614
  hso_free_interface+0x3f2/0x4f0 drivers/net/usb/hso.c:3108
  hso_probe+0x362/0x1a50 drivers/net/usb/hso.c:2963
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

Allocated by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_kmalloc mm/kasan/common.c:489 [inline]
  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:462
  kmalloc include/linux/slab.h:547 [inline]
  kzalloc include/linux/slab.h:742 [inline]
  hso_create_device+0x43/0x390 drivers/net/usb/hso.c:2336
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2617 [inline]
  hso_probe+0xbb0/0x1a50 drivers/net/usb/hso.c:2948
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

Freed by task 12:
  save_stack+0x1b/0x80 mm/kasan/common.c:71
  set_track mm/kasan/common.c:79 [inline]
  __kasan_slab_free+0x130/0x180 mm/kasan/common.c:451
  slab_free_hook mm/slub.c:1421 [inline]
  slab_free_freelist_hook mm/slub.c:1448 [inline]
  slab_free mm/slub.c:2994 [inline]
  kfree+0xd7/0x290 mm/slub.c:3949
  hso_create_bulk_serial_device drivers/net/usb/hso.c:2687 [inline]
  hso_probe+0x13c6/0x1a50 drivers/net/usb/hso.c:2948
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

The buggy address belongs to the object at ffff8881d112d900
  which belongs to the cache kmalloc-512 of size 512
The buggy address is located 152 bytes inside of
  512-byte region [ffff8881d112d900, ffff8881d112db00)
The buggy address belongs to the page:
page:ffffea0007444b00 refcount:1 mapcount:0 mapping:ffff8881dac02c00  
index:0x0 compound_mapcount: 0
flags: 0x200000000010200(slab|head)
raw: 0200000000010200 ffffea000744ea80 0000000400000004 ffff8881dac02c00
raw: 0000000000000000 00000000000c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881d112d880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff8881d112d900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff8881d112d980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                             ^
  ffff8881d112da00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881d112da80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         69bbe8c7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e6156a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c309d28e15db39c5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1715ad4a600000

