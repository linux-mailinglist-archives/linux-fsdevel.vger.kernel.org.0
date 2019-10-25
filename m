Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F02E45DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407271AbfJYIiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 04:38:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:40562 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404179AbfJYIiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:38:13 -0400
Received: by mail-il1-f199.google.com with SMTP id x17so1592054ill.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Oct 2019 01:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Xx2ilS5o98N5EWeA3DS9BzkSPRq1qrT7n0PMAlOFbY8=;
        b=aEntqEcrgIj4/NSZEzeR4egOqZgsFZ78+SGP52/krXQaGIFldmz/0rEnEGVSvZGuZE
         X9Xu7ZJdnVMcwUZcGrwzOfl3nKCATS9vL7QEz5YS1L0uFuFP9FoyQ5WBD6PaVxDywJVI
         dNHdD/kihS/so4+q9kVTG1nooFEO5POd9mXBz+0QCwORIWlqN8Gd9DeBfiWcNarfBOrl
         h129+h00n0KleHZNLDvFfSZpq1lVZIZN59n7H4Mnz8sU06/s6DbmmWe/ajDM0bE34HUX
         T9uk9uatKo+avSHY1zxkWlYVlEwPnoxE+9kEYyQHDdODpjcDGXnIi1J6Dr0TZ8AyQcVL
         Iobw==
X-Gm-Message-State: APjAAAXVhEbVJXSXzgh0p8Z49vccIoNYWJgvopliUKR7ItR7q91iMs6f
        +YiHYvsW25EtotCkraHzXjJ8ftlF70gWAVEtdZxhYXJkn6oo
X-Google-Smtp-Source: APXvYqyGIgGMWwSwmp7dv/vinP8k9GbsPCnDljuS1bRDLNuHaYz7l+t+DoF01rQS0n34/MlnEOtAB3p6GxnPpYdNtOZM4CpXPBGR
MIME-Version: 1.0
X-Received: by 2002:a02:a786:: with SMTP id e6mr135587jaj.29.1571992692688;
 Fri, 25 Oct 2019 01:38:12 -0700 (PDT)
Date:   Fri, 25 Oct 2019 01:38:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000098bee0595b81273@google.com>
Subject: KASAN: stack-out-of-bounds Read in finish_writeback_work
From:   syzbot <syzbot+357de617b97752833bd5@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05679ca6 xdp: Prevent overflow in devmap_hash cost calcula..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=12d37fcf600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebb95b9e9f5291dd
dashboard link: https://syzkaller.appspot.com/bug?extid=357de617b97752833bd5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+357de617b97752833bd5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in finish_writeback_work.isra.0+0x11b/0x120  
fs/fs-writeback.c:168
Read of size 8 at addr ffff88806f04f9c8 by task kworker/u4:2/33

CPU: 1 PID: 33 Comm: kworker/u4:2 Not tainted 5.4.0-rc1+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:634
  __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  finish_writeback_work.isra.0+0x11b/0x120 fs/fs-writeback.c:168
  wb_do_writeback fs/fs-writeback.c:2030 [inline]
  wb_workfn+0x34f/0x1220 fs/fs-writeback.c:2070
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the page:
page:ffffea0001bc13c0 refcount:0 mapcount:0 mapping:0000000000000000  
index:0x0
flags: 0x1fffc0000000000()
raw: 01fffc0000000000 0000000000000000 ffffffff01bc0101 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88806f04f880: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
  ffff88806f04f900: f1 00 00 f3 f3 00 00 00 00 00 00 00 00 00 00 00
> ffff88806f04f980: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3
                                               ^
  ffff88806f04fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f1
  ffff88806f04fa80: f1 f1 f1 00 f2 f2 f2 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
