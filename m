Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87E08676F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404098AbfHHQsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 12:48:06 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:53834 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbfHHQsG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:48:06 -0400
Received: by mail-ot1-f69.google.com with SMTP id e42so1086317ote.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 09:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=aZTT0yWwCLvofMIk/vDC+UDU3g6pGvtYwgnyGAaloQg=;
        b=ufs9UcTbJQGiOT5cCGZrZvqKeeqz37U6jq6mDFeupAdpeeEYN5wjbibTr7VDiMh6PT
         UK82BCZYbbpNzCHWXjsBmpSd9Fnq/VRHafAny9ETiMsqosEWBjUOPjYqg1SOF1e80QZd
         f067PCAQkbZAzMiIZ0NlvlhSLZ/pfyCUrS2ZT86n5SS3nPon8nxG/7UUP6oyYciKfdfU
         nvhOUu8/r4FACUHqXgMEDSaxdOJPB/0+D90q/A0+fK9M4i9B96lpmoxu2wBi145pWQEs
         tytj2NSbe7l0wJtQJL6RFm0Mb+uuDjWpc+SSu0f0UeyAbCZj/BswvdlDzU6GhI1YlKHb
         lpTQ==
X-Gm-Message-State: APjAAAWbZxpIGdnFmTwdIKKs2r6cGQxrr+wIZ/RIDeulJ7Do1HCVp1DU
        1nt9AS3N86GZ/m22jjUNOG4P+wdB+DtvZBomMBTxfRt23NDF
X-Google-Smtp-Source: APXvYqytw9HqCH1DBUw67wrUkqUU8fJEGDnt8vZR6W2gnl4+Ka54Jb73f78Rhe/UFgBE7w2DUO6m9ZbJFc8S+UCKUKlRtodfp82z
MIME-Version: 1.0
X-Received: by 2002:a02:b713:: with SMTP id g19mr10752238jam.77.1565282885836;
 Thu, 08 Aug 2019 09:48:05 -0700 (PDT)
Date:   Thu, 08 Aug 2019 09:48:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062292b058f9dd282@google.com>
Subject: KASAN: use-after-free Read in __blkdev_direct_IO
From:   syzbot <syzbot+a1fc36a4d12501564d34@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    629f8205 Merge tag 'for-linus-20190730' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e50eb4600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e397351d2615e10
dashboard link: https://syzkaller.appspot.com/bug?extid=a1fc36a4d12501564d34
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a1fc36a4d12501564d34@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __blkdev_direct_IO+0xb3d/0x1310  
fs/block_dev.c:468
Read of size 4 at addr ffff888037bc2028 by task syz-executor.0/5655

CPU: 0 PID: 5655 Comm: syz-executor.0 Not tainted 5.3.0-rc2+ #56
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  print_address_description+0x75/0x5b0 mm/kasan/report.c:351
  __kasan_report+0x14b/0x1c0 mm/kasan/report.c:482
  kasan_report+0x26/0x50 mm/kasan/common.c:612
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:131
  __blkdev_direct_IO+0xb3d/0x1310 fs/block_dev.c:468
  blkdev_direct_IO+0xbe/0xd0 fs/block_dev.c:518
  generic_file_direct_write+0x22e/0x440 mm/filemap.c:3230
  __generic_file_write_iter+0x2af/0x520 mm/filemap.c:3413
  blkdev_write_iter+0x2f2/0x420 fs/block_dev.c:1993
  ? 0xffffffff81000000
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write fs/read_write.c:483 [inline]
  __vfs_write+0x617/0x7d0 fs/read_write.c:496
  vfs_write+0x275/0x590 fs/read_write.c:558
  ksys_write+0x16b/0x2a0 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x7b/0x90 fs/read_write.c:620
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f56f3b24c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000052698b21 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f56f3b256d4
R13: 00000000004c5db7 R14: 00000000004e00e0 R15: 00000000ffffffff

Allocated by task 5655:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc+0x11c/0x1b0 mm/kasan/common.c:487
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:495
  slab_post_alloc_hook mm/slab.h:520 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x1f5/0x2e0 mm/slab.c:3483
  mempool_alloc_slab+0x4d/0x70 mm/mempool.c:513
  mempool_alloc+0x15f/0x6c0 mm/mempool.c:393
  bio_alloc_bioset+0x210/0x670 block/bio.c:477
  bio_alloc include/linux/bio.h:400 [inline]
  __blkdev_direct_IO+0xa29/0x1310 fs/block_dev.c:470
  blkdev_direct_IO+0xbe/0xd0 fs/block_dev.c:518
  generic_file_direct_write+0x22e/0x440 mm/filemap.c:3230
  __generic_file_write_iter+0x2af/0x520 mm/filemap.c:3413
  blkdev_write_iter+0x2f2/0x420 fs/block_dev.c:1993
  call_write_iter include/linux/fs.h:1870 [inline]
  new_sync_write fs/read_write.c:483 [inline]
  __vfs_write+0x617/0x7d0 fs/read_write.c:496
  vfs_write+0x275/0x590 fs/read_write.c:558
  ksys_write+0x16b/0x2a0 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x7b/0x90 fs/read_write.c:620
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9:
  save_stack mm/kasan/common.c:69 [inline]
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x12a/0x1e0 mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:457
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x81/0xf0 mm/slab.c:3693
  mempool_free_slab+0x1d/0x30 mm/mempool.c:520
  mempool_free+0xd5/0x350 mm/mempool.c:502
  bio_put+0x35a/0x420 block/bio.c:253
  blkdev_bio_end_io+0x336/0x430 fs/block_dev.c:333
  bio_endio+0x4ff/0x570 block/bio.c:1830
  req_bio_endio block/blk-core.c:239 [inline]
  blk_update_request+0x385/0xf80 block/blk-core.c:1424
  blk_mq_end_request+0x42/0x80 block/blk-mq.c:557
  blk_flush_complete_seq+0x5e1/0xd10 block/blk-flush.c:196
  flush_end_io+0x4d2/0x670 block/blk-flush.c:237
  __blk_mq_end_request+0x38a/0x410 block/blk-mq.c:548
  blk_mq_end_request+0x55/0x80 block/blk-mq.c:559
  lo_complete_rq+0x13b/0x270 drivers/block/loop.c:485
  blk_done_softirq+0x362/0x3e0 block/blk-softirq.c:37
  __do_softirq+0x333/0x7c4 arch/x86/include/asm/paravirt.h:778

The buggy address belongs to the object at ffff888037bc2000
  which belongs to the cache bio-0 of size 192
The buggy address is located 40 bytes inside of
  192-byte region [ffff888037bc2000, ffff888037bc20c0)
The buggy address belongs to the page:
page:ffffea0000def080 refcount:1 mapcount:0 mapping:ffff88821ac91540  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea000167a2c8 ffffea0001e21ac8 ffff88821ac91540
raw: 0000000000000000 ffff888037bc2000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888037bc1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff888037bc1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff888037bc2000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                   ^
  ffff888037bc2080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
  ffff888037bc2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
