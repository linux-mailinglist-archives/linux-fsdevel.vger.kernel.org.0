Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB818E41C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgCUUAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Mar 2020 16:00:20 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:55049 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgCUUAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Mar 2020 16:00:19 -0400
Received: by mail-il1-f198.google.com with SMTP id m2so8524605ilb.21
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2020 13:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Jjk7RcYR/0pIZUwas1f6jqZpt+iipnJOHpIzpubPMdo=;
        b=K7VodZL2Gf8awF58sHcAayvlAwgYKSGTwJlx0VhDNt3ec+RSLNxy7i+reE4+iCq/uE
         DDJjS8XpJz4FA00Dq2pOpa8UU7G8y3GWGI0yvyhYd/so+s6Cb8E0+ToOnPHBT/TF56j1
         rgsNWeLf0/47hdKrb03793aWtS6/hVn5Hob90DQyN/OVP+SfMDOLuTL/4Z9oM0BpVywH
         pYE5ro0N3VHQr5s81Ql6bBGtCduIylBnhLv9SJMf4/pqLyoROsjfzjOVDZghL6QI7gZO
         1gMA+RrWgOMQD0KL6o/t/xYzA48XrVEhBpy1B/83lPSMhYz7lT6b8isNwrS5gn4CPQ4G
         ztfw==
X-Gm-Message-State: ANhLgQ3TOD1iPts77Lqo2n+vvGk+JozvIjEtA0w0SoP0vTKRSVC2srT9
        Q9OS/P/w0rafn4mnFdbXqhPmbUr5BrDcDi4vnQwYPYQxIzKb
X-Google-Smtp-Source: ADFU+vvEHIYJ92ncPfNE955oa0p6N4gEEzurLcL0XrL3F/4gMcYKiOQZZwESUnnU/1B4LQIoSQs8LzIWNBp86FkG2wv2NE/5WvJ8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:e89:: with SMTP id t9mr3616546ilj.83.1584820818816;
 Sat, 21 Mar 2020 13:00:18 -0700 (PDT)
Date:   Sat, 21 Mar 2020 13:00:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0373505a162d972@google.com>
Subject: WARNING in alloc_page_buffers
From:   syzbot <syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        schatzberg.dan@gmail.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    770fbb32 Add linux-next specific files for 20200228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13507489e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=576314276bce4ad5
dashboard link: https://syzkaller.appspot.com/bug?extid=0985c7ea18137bf0c4ca
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b970e5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178e99f9e00000

The bug was bisected to:

commit c9e1feb96bd90a4b51d440a015ba2f1c0562de59
Author: Dan Schatzberg <schatzberg.dan@gmail.com>
Date:   Tue Feb 25 04:14:08 2020 +0000

    loop: charge i/o to mem and blk cg

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102199f9e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=122199f9e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=142199f9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0985c7ea18137bf0c4ca@syzkaller.appspotmail.com
Fixes: c9e1feb96bd9 ("loop: charge i/o to mem and blk cg")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 170 at include/linux/sched/mm.h:323 memalloc_use_memcg include/linux/sched/mm.h:323 [inline]
WARNING: CPU: 1 PID: 170 at include/linux/sched/mm.h:323 alloc_page_buffers+0x41f/0x590 fs/buffer.c:866
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 170 Comm: kworker/u4:4 Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: loop-2074257985 loop_workfn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:memalloc_use_memcg include/linux/sched/mm.h:323 [inline]
RIP: 0010:alloc_page_buffers+0x41f/0x590 fs/buffer.c:866
Code: 39 a9 ff e8 e3 fb 96 ff e8 3e 39 a9 ff 48 c7 c6 33 5c c9 81 48 c7 c7 80 dc 9a 89 e8 9b 9d 8f ff e9 a3 fe ff ff e8 21 39 a9 ff <0f> 0b e9 61 fc ff ff e8 15 39 a9 ff e8 30 41 96 ff 31 ff 89 c3 89
RSP: 0018:ffffc90001607110 EFLAGS: 00010293
RAX: ffff8880a8820440 RBX: ffff8880a8820440 RCX: 1ffff1101510419a
RDX: 0000000000000000 RSI: ffffffff81c95c5f RDI: ffff8880a8821808
RBP: ffffea000239c480 R08: ffff8880a8820440 R09: fffffbfff150c429
R10: fffffbfff150c428 R11: ffffffff8a862147 R12: 0000000000001000
R13: 0000000000001000 R14: 0000000000408c40 R15: ffffea000239c480
 create_empty_buffers+0x2c/0x8c0 fs/buffer.c:1595
 create_page_buffers+0x2b0/0x400 fs/buffer.c:1712
 __block_write_full_page+0xf7/0x11b0 fs/buffer.c:1758
 block_write_full_page+0x21a/0x270 fs/buffer.c:3030
 __writepage+0x62/0x100 mm/page-writeback.c:2303
 write_cache_pages+0x799/0x12f0 mm/page-writeback.c:2238
 generic_writepages mm/page-writeback.c:2329 [inline]
 generic_writepages+0xed/0x160 mm/page-writeback.c:2318
 do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
 __filemap_fdatawrite_range+0x2aa/0x390 mm/filemap.c:421
 ? 0xffffffff81000000
 filemap_write_and_wait_range mm/filemap.c:654 [inline]
 filemap_write_and_wait_range+0xf7/0x1e0 mm/filemap.c:648
 generic_file_read_iter+0x11bd/0x2a40 mm/filemap.c:2272
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:2039
 call_read_iter include/linux/fs.h:1895 [inline]
 lo_rw_aio+0xc96/0xf20 drivers/block/loop.c:572
 do_req_filebacked drivers/block/loop.c:620 [inline]
 loop_handle_cmd drivers/block/loop.c:2060 [inline]
 loop_process_work+0x147b/0x29d0 drivers/block/loop.c:2096
 process_one_work+0x94b/0x1690 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x357/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
