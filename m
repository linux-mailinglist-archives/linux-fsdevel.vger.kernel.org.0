Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055A6285E25
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgJGLbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 07:31:21 -0400
Received: from mail-io1-f79.google.com ([209.85.166.79]:52530 "EHLO
        mail-io1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgJGLbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:31:19 -0400
Received: by mail-io1-f79.google.com with SMTP id e10so1079670ioq.19
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2020 04:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vjtRuHi2Hc6BiX+YCDt+i6nOG7vmNbQPu3H+COlDXvc=;
        b=IQBNjO7A0m4Me8fTOg/qxNUPXauIRFgMO4tnlFiwHrsu0QHoT4IQEEvEJ2zE+H+Gai
         Er0EtT5EAYeFcjZzgaP22noGJdfqmPDvyVyte84Vn255iOyLokUkD60Jq1t2410QpI1z
         sF/SU4y8LZUV6BGTqqoCxUDLnLiYWBPvafi7HqgY7W/2s9QueSucWmWekLCU1EYqBoaw
         m3Cma1gZ3UkePx5iqGtSVQAabhLtSVvPaqi8dExzvKBOzwIfFMKO+PyuX6kQO3t0p0Py
         o++HHG2/lL1aVNkRrFg0gOTWld8a6KCIpButc7Pyf7HOspDvGWRcAPphWMhCnRmuMn7W
         4Gtg==
X-Gm-Message-State: AOAM530j9NFL1HW7KXtfepMFeNDfPsgb1ZvMwGXturHVAhMXt1SyF8Ta
        4tXP4E1WKGpmoJbILISm1A1vehP3SPFzJWR46eJhaopoxmL9
X-Google-Smtp-Source: ABdhPJyznvfWXXedrCqL5DcgMCDv/+9tBiX1/p6fdQaxxU7KE1KLFFgKG+Fg3Rm8tixZrRivTm+Z2vTGavwaOFvPa3XFON/nDHkb
MIME-Version: 1.0
X-Received: by 2002:a05:6602:54:: with SMTP id z20mr1906863ioz.85.1602070276914;
 Wed, 07 Oct 2020 04:31:16 -0700 (PDT)
Date:   Wed, 07 Oct 2020 04:31:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2c2f005b1130def@google.com>
Subject: KASAN: use-after-free Read in __d_alloc
From:   syzbot <syzbot+0842a31cc990d5a8a60c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3d45f82 Merge tag 'pinctrl-v5.9-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1615acaf900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
dashboard link: https://syzkaller.appspot.com/bug?extid=0842a31cc990d5a8a60c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0842a31cc990d5a8a60c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy include/linux/string.h:406 [inline]
BUG: KASAN: use-after-free in __d_alloc+0x19a/0x950 fs/dcache.c:1740
Read of size 1 at addr ffff8880928f30c0 by task kworker/0:3/7298

CPU: 0 PID: 7298 Comm: kworker/0:3 Not tainted 5.9.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: afs afs_manage_cell
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:406 [inline]
 __d_alloc+0x19a/0x950 fs/dcache.c:1740
 d_alloc+0x4a/0x230 fs/dcache.c:1788
 d_alloc_parallel+0xe9/0x18e0 fs/dcache.c:2540
 __lookup_slow+0x193/0x480 fs/namei.c:1529
 lookup_one_len+0x163/0x190 fs/namei.c:2562
 afs_dynroot_mkdir+0x167/0x250 fs/afs/dynroot.c:293
 afs_activate_cell fs/afs/cell.c:632 [inline]
 afs_manage_cell+0x6d2/0x11c0 fs/afs/cell.c:697
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 process_scheduled_works kernel/workqueue.c:2331 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2417
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 13591:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 __do_kmalloc mm/slab.c:3659 [inline]
 __kmalloc+0x1b0/0x360 mm/slab.c:3668
 kmalloc include/linux/slab.h:559 [inline]
 afs_alloc_cell fs/afs/cell.c:157 [inline]
 afs_lookup_cell+0x5e9/0x1440 fs/afs/cell.c:262
 afs_parse_source fs/afs/super.c:290 [inline]
 afs_parse_param+0x404/0x8c0 fs/afs/super.c:326
 vfs_parse_fs_param fs/fs_context.c:117 [inline]
 vfs_parse_fs_param+0x203/0x550 fs/fs_context.c:98
 vfs_parse_fs_string+0xe6/0x150 fs/fs_context.c:161
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:201
 do_new_mount fs/namespace.c:2871 [inline]
 path_mount+0x133f/0x20a0 fs/namespace.c:3192
 do_mount fs/namespace.c:3205 [inline]
 __do_sys_mount fs/namespace.c:3413 [inline]
 __se_sys_mount fs/namespace.c:3390 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3390
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6891:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3422 [inline]
 kfree+0x10e/0x2b0 mm/slab.c:3760
 afs_cell_destroy+0x1b0/0x240 fs/afs/cell.c:500
 rcu_do_batch kernel/rcu/tree.c:2430 [inline]
 rcu_core+0x5ca/0x1130 kernel/rcu/tree.c:2658
 __do_softirq+0x1f8/0xb23 kernel/softirq.c:298

The buggy address belongs to the object at ffff8880928f30c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff8880928f30c0, ffff8880928f30e0)
The buggy address belongs to the page:
page:00000000ff82e524 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880928f3fc1 pfn:0x928f3
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002881b08 ffffea000299dc88 ffff8880aa040100
raw: ffff8880928f3fc1 ffff8880928f3000 0000000100000039 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880928f2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880928f3000: 00 00 01 fc fc fc fc fc fa fb fb fb fc fc fc fc
>ffff8880928f3080: 00 01 fc fc fc fc fc fc fa fb fb fb fc fc fc fc
                                           ^
 ffff8880928f3100: 00 00 01 fc fc fc fc fc fb fb fb fb fc fc fc fc
 ffff8880928f3180: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
