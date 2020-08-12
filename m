Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA0243075
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 23:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLV2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 17:28:16 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:39015 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgHLV2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:28:15 -0400
Received: by mail-il1-f197.google.com with SMTP id i66so2763247ile.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2020 14:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ilCTY64RuUG02GFuuWjDIx1Ci3e/PJFPZPYdOkrJo64=;
        b=gPalZwtZkjLXy1VB5dXvwxgJ2DtGKlTKY86fjeMedTKk2DBWuwJSbFbfeSaz+32bfZ
         LXXCqXAkmdAw2f+rur9xM+aar794CL4lorT1rO9Ww/mR71w1WmDK0HdDTOSffx1GhI+s
         7qHZ9+o5Rq6g18RxwNhiotJsQnNnbP+wERG+nIoWlJgGkNs0cx+0ATilmBctmg1W5un3
         KlnK9wZoRsNvlIkzrnwJXzfQQkISLqneXgP7mWS4/VuSiEwi9lu1J/eE7tLQ1bbS+8Rm
         +cHyyGCW8NTaDq5+4BxU5YEL5I3cfErztEYU9hfHG2rjhYWys14zMR2Ztjj0LZ5J6D1C
         qAtQ==
X-Gm-Message-State: AOAM5336m/w2QzJanxlJxhEKtGMzoO/8LZyjrIyKSSo/AYN9+o4IgcLM
        KC0R5CObOrPYti/chN9B7+U53WVg1ZlIr8BDd2N4v6Hoye5v
X-Google-Smtp-Source: ABdhPJw33yFNC2zXSn+p5lX5ZDyAPSvDLXh/be+FiUata4vDh7uXDJLRiUIDIPGB5q7w3Dy5crJD3YjdBt0+8CgnWYplEalN/W0s
MIME-Version: 1.0
X-Received: by 2002:a92:aa4b:: with SMTP id j72mr1651939ili.141.1597267694581;
 Wed, 12 Aug 2020 14:28:14 -0700 (PDT)
Date:   Wed, 12 Aug 2020 14:28:14 -0700
In-Reply-To: <000000000000f0724405aca59f64@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bfef305acb4ddee@google.com>
Subject: Re: KASAN: use-after-free Read in path_init (2)
From:   syzbot <syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com>
To:     arnd@arndb.de, christian.brauner@ubuntu.com, hch@lst.de,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    fb893de3 Merge tag 'tag-chrome-platform-for-v5.9' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16139be2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fedc63022bf07e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbeb1c88016c7db4aa24
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa83e2900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15920c4a900000

The issue was bisected to:

commit e24ab0ef689de43649327f54cd1088f3dad25bb3
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jul 21 08:48:15 2020 +0000

    fs: push the getname from do_rmdir into the callers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=155f36c2900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=175f36c2900000
console output: https://syzkaller.appspot.com/x/log.txt?x=135f36c2900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbeb1c88016c7db4aa24@syzkaller.appspotmail.com
Fixes: e24ab0ef689d ("fs: push the getname from do_rmdir into the callers")

==================================================================
BUG: KASAN: use-after-free in path_init+0x116b/0x13c0 fs/namei.c:2207
Read of size 8 at addr ffff8880950a8a80 by task syz-executor167/6821

CPU: 0 PID: 6821 Comm: syz-executor167 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 path_init+0x116b/0x13c0 fs/namei.c:2207
 path_parentat+0x22/0x1b0 fs/namei.c:2384
 filename_parentat+0x188/0x560 fs/namei.c:2407
 do_rmdir+0xa8/0x440 fs/namei.c:3732
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4403e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd4e3bdb58 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 69662f7375622f2e RCX: 00000000004403e9
RDX: 00000000004403e9 RSI: 00000000004403e9 RDI: 0000000020000080
RBP: 2f31656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401bf0
R13: 0000000000401c80 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 6821:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 slab_post_alloc_hook mm/slab.h:518 [inline]
 slab_alloc mm/slab.c:3312 [inline]
 kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags include/linux/audit.h:320 [inline]
 getname fs/namei.c:209 [inline]
 __do_sys_rmdir fs/namei.c:3783 [inline]
 __se_sys_rmdir fs/namei.c:3781 [inline]
 __x64_sys_rmdir+0xb1/0x100 fs/namei.c:3781
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 6821:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
 putname+0xe1/0x120 fs/namei.c:259
 do_rmdir+0x145/0x440 fs/namei.c:3773
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880950a8a80
 which belongs to the cache names_cache of size 4096
The buggy address is located 0 bytes inside of
 4096-byte region [ffff8880950a8a80, ffff8880950a9a80)
The buggy address belongs to the page:
page:00000000c8532513 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x950a8
head:00000000c8532513 order:1 compound_mapcount:0
flags: 0xfffe0000010200(slab|head)
raw: 00fffe0000010200 ffffea0002540e88 ffffea000251ef88 ffff88821bc47a00
raw: 0000000000000000 ffff8880950a8a80 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880950a8980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880950a8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880950a8a80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880950a8b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880950a8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

