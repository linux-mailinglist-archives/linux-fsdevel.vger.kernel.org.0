Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1991434322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJTB4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 21:56:36 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54129 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhJTB4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 21:56:35 -0400
Received: by mail-io1-f71.google.com with SMTP id g9-20020a056602150900b005d6376bdce7so14614020iow.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Oct 2021 18:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OhXXtvdf90jdSB49MhADk/GhXUJVepQ8kXUhBdeL8iU=;
        b=TgDTYVzSeOyworZHDTBMQqzjGZtQAAI1D47crxWaDJ47E5Xfx7Lheuxd0ayw6jLocp
         JJGr9rsWVd9SHeSkwlfje4t8Io264F/FOiBpYaOZCz4EWcCXy2QxKUVgXW9Jc9LMpG8Z
         Vz9b56zLnjHOF3fGBK7Ef3yo9zHDEuPWlBlbz5FlSjgxPkpWNedc7wRPI9+Dr/finY+D
         /tOubmVDy4yqjEE08pXWwU7UBtneHzYJL15zUTk3P6JaWudjp2sutSvKbzLTyPHDdGM0
         brZgv2Q/qzQjbyzcK7z8iM0t/HwBoz6rnD0mAQ0eUO9U0QPRwpEiNcYZlQEb/GSmfesM
         Uq/Q==
X-Gm-Message-State: AOAM5339zbLwIVo6cP6u1ebtFJpJMa3B4MWIM11YX3YD6/htWL4VhJEd
        v/QActKYFt0P2SUN+9xYKmvHHphYCj6jaAjnBgh5rb+Bfx7x
X-Google-Smtp-Source: ABdhPJwhDFEZUrxVtCDoKyIHQrJ/xgtgyEER90eXiOsD0yihfEKXIy9OpYpGq+mkVkskKGbBcgA3RAubSK3m/o/E2+JIzsnxYR+s
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:: with SMTP id d10mr21688124ilv.290.1634694861229;
 Tue, 19 Oct 2021 18:54:21 -0700 (PDT)
Date:   Tue, 19 Oct 2021 18:54:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085145205cebf0e87@google.com>
Subject: [syzbot] WARNING in fuse_writepages_fill
From:   syzbot <syzbot+29e1f6075bbe07b2beb6@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c832d2f9b95 Add linux-next specific files for 20211015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e15a10b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6ac42766a768877
dashboard link: https://syzkaller.appspot.com/bug?extid=29e1f6075bbe07b2beb6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13715144b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b749ccb00000

The issue was bisected to:

commit 6e6b45a963c4a962c61ca59982982ddcdc82e651
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed Oct 13 12:33:40 2021 +0000

    fuse: write inode in fuse_vma_close() instead of fuse_release()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133b0194b00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10bb0194b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=173b0194b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29e1f6075bbe07b2beb6@syzkaller.appspotmail.com
Fixes: 6e6b45a963c4 ("fuse: write inode in fuse_vma_close() instead of fuse_release()")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 54 at fs/fuse/file.c:1829 fuse_write_file_get fs/fuse/file.c:1829 [inline]
WARNING: CPU: 0 PID: 54 at fs/fuse/file.c:1829 fuse_write_file_get fs/fuse/file.c:1826 [inline]
WARNING: CPU: 0 PID: 54 at fs/fuse/file.c:1829 fuse_writepages_fill+0x1591/0x1a40 fs/fuse/file.c:2134
Modules linked in:
CPU: 0 PID: 54 Comm: kworker/u4:3 Not tainted 5.15.0-rc5-next-20211015-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: writeback wb_workfn (flush-0:50)
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1829 [inline]
RIP: 0010:fuse_write_file_get fs/fuse/file.c:1826 [inline]
RIP: 0010:fuse_writepages_fill+0x1591/0x1a40 fs/fuse/file.c:2134
Code: ff 4c 89 f7 e8 90 3c 0f ff e9 71 ec ff ff e8 86 3c 0f ff e9 98 ec ff ff e8 dc a9 c8 fe 4c 89 ff e8 84 82 a1 06 e8 cf a9 c8 fe <0f> 0b 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 10 48 c1 ea 03 80
RSP: 0018:ffffc90001a2f428 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90001a2f680 RCX: 0000000000000000
RDX: ffff888011ba5700 RSI: ffffffff82aebac1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88806eee85e3
R10: ffffed100dddd0bc R11: 0000000000000000 R12: ffffea0001b04240
R13: ffffc90001a2f690 R14: ffff88806eee84c8 R15: ffff88806eee85e0
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000019b88000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 write_cache_pages+0x6f4/0x10c0 mm/page-writeback.c:2255
 fuse_writepages+0x1c9/0x320 fs/fuse/file.c:2236
 do_writepages+0x1a4/0x670 mm/page-writeback.c:2364
 __writeback_single_inode+0x126/0xff0 fs/fs-writeback.c:1616
 writeback_sb_inodes+0x53d/0xf00 fs/fs-writeback.c:1881
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1950
 wb_writeback+0x7f1/0xc30 fs/fs-writeback.c:2055
 wb_check_background_flush fs/fs-writeback.c:2121 [inline]
 wb_do_writeback fs/fs-writeback.c:2209 [inline]
 wb_workfn+0xa21/0x1180 fs/fs-writeback.c:2237
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
