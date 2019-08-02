Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9799D7FED7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 18:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733087AbfHBQpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 12:45:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55466 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733047AbfHBQpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:45:07 -0400
Received: by mail-io1-f72.google.com with SMTP id f22so83767700ioh.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2019 09:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UA45qRYC5K8T4QSrCN5nW+v8qYL3F1Jg1eJKai+z9Uk=;
        b=BPjha1fh1xkNG5EkPIdQAjsgivAVvTLS0qYaTa7QoxHU6t/DULIrfqL2ocu6iNYlR2
         XkHHEV9Kc1cdrjQnRkrgqK+HkxErrUsjdE3kWL/EzL0cI9CeNBZLcWPfXBTbAT5lgk+f
         8j+urIDvUt6ybSsvF73a2IoXpq8zGcOxpPRU/5v6+d2nRUbAUPzVPFJYRJtFgG1NH3X2
         68fQ2H+YNZPOrZzfGTE4ldk1hWOjlnawdqLZZc1prVx7iIfB2J8ThZ8+o+mzqCQLlFNB
         c7PfIebjNLFvn2yeIUDZBk3S2/ZYs/btGzGwybcycoQ+i67qdGwM0l+wAUlIthW2azza
         oFXg==
X-Gm-Message-State: APjAAAUEMPT7J8UTTw20Kxc8ZofpNlfcLkL7T1JawaWehoE4xvwMEjTj
        tv1sRpt27xa1PVjQ+puRw7NPEDaXc28cB36QEiM1QDSLYc12
X-Google-Smtp-Source: APXvYqxiTbiTo9aYM5HaVlxqYEyQKJfZPhpQvK4Ko5Qyke8npJSk6xT5Phqo4afTc8Eg38skhIqM09IV89Mj0PZFy+Q0xqZmXqyK
MIME-Version: 1.0
X-Received: by 2002:a6b:d008:: with SMTP id x8mr1372310ioa.129.1564764306330;
 Fri, 02 Aug 2019 09:45:06 -0700 (PDT)
Date:   Fri, 02 Aug 2019 09:45:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2db16058f2514fa@google.com>
Subject: KASAN: use-after-free Read in blkdev_direct_IO
From:   syzbot <syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1e78030e Merge tag 'mmc-v5.3-rc1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172e72dc600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c7b914a2680c9c6
dashboard link: https://syzkaller.appspot.com/bug?extid=0a0e5f37746013dc7476
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11fa7830600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f31c8a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0a0e5f37746013dc7476@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __blkdev_direct_IO fs/block_dev.c:468 [inline]
BUG: KASAN: use-after-free in blkdev_direct_IO+0x13cd/0x1590  
fs/block_dev.c:518
Read of size 4 at addr ffff8880a3115f28 by task syz-executor964/10331

CPU: 0 PID: 10331 Comm: syz-executor964 Not tainted 5.3.0-rc2+ #112
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x17 mm/kasan/common.c:612
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
  __blkdev_direct_IO fs/block_dev.c:468 [inline]
  blkdev_direct_IO+0x13cd/0x1590 fs/block_dev.c:518
  generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3230
  __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3413
  blkdev_write_iter fs/block_dev.c:1993 [inline]
  blkdev_write_iter+0x23a/0x440 fs/block_dev.c:1970
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44d8f9
Code: e8 7c e6 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 3b c9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f85ed575ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006e0c98 RCX: 000000000044d8f9
RDX: 0000000052698b21 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00000000006e0c90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006e0c9c
R13: 00007ffc4e9d0e7f R14: 00007f85ed5769c0 R15: 0000000000000016

Allocated by task 10331:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:460
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:495
  slab_post_alloc_hook mm/slab.h:520 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 mm/slab.c:3483
  mempool_alloc_slab+0x47/0x60 mm/mempool.c:513
  mempool_alloc+0x169/0x380 mm/mempool.c:393
  bio_alloc_bioset+0x3b9/0x680 block/bio.c:477
  bio_alloc include/linux/bio.h:400 [inline]
  __blkdev_direct_IO fs/block_dev.c:470 [inline]
  blkdev_direct_IO+0x8b0/0x1590 fs/block_dev.c:518
  generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3230
  __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3413
  blkdev_write_iter fs/block_dev.c:1993 [inline]
  blkdev_write_iter+0x23a/0x440 fs/block_dev.c:1970
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write+0x4d3/0x770 fs/read_write.c:483
  __vfs_write+0xe1/0x110 fs/read_write.c:496
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:457
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 mm/slab.c:3693
  mempool_free_slab+0x1e/0x30 mm/mempool.c:520
  mempool_free+0xeb/0x370 mm/mempool.c:502
  bio_free+0x267/0x420 block/bio.c:255
  bio_put+0xda/0x110 block/bio.c:549
  blkdev_bio_end_io+0x338/0x4b0 fs/block_dev.c:333
  bio_endio+0x611/0xaf0 block/bio.c:1830
  req_bio_endio block/blk-core.c:239 [inline]
  blk_update_request+0x32e/0xc10 block/blk-core.c:1424
  blk_mq_end_request+0x5b/0x560 block/blk-mq.c:557
  blk_flush_complete_seq+0x558/0x1030 block/blk-flush.c:196
  flush_end_io+0x3d1/0x6d0 block/blk-flush.c:237
  __blk_mq_end_request block/blk-mq.c:548 [inline]
  blk_mq_end_request+0x32e/0x560 block/blk-mq.c:559
  lo_complete_rq+0x210/0x2e0 drivers/block/loop.c:485
  blk_done_softirq+0x2fe/0x4d0 block/blk-softirq.c:37
  __do_softirq+0x262/0x98c kernel/softirq.c:292

The buggy address belongs to the object at ffff8880a3115f00
  which belongs to the cache bio-0 of size 192
The buggy address is located 40 bytes inside of
  192-byte region [ffff8880a3115f00, ffff8880a3115fc0)
The buggy address belongs to the page:
page:ffffea00028c4540 refcount:1 mapcount:0 mapping:ffff88821b2978c0  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea0002a16f08 ffff8880a7833a48 ffff88821b2978c0
raw: 0000000000000000 ffff8880a3115000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8880a3115e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8880a3115e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff8880a3115f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff8880a3115f80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff8880a3116000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
