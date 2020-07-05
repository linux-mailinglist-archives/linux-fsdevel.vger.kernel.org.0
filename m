Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2152214ED5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 21:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGETMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 15:12:20 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:39513 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgGETMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:12:20 -0400
Received: by mail-il1-f200.google.com with SMTP id f66so20757121ilh.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2020 12:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Sl5/QP84bh2XxnAfKFwY88vpKb0Kww2/Do1jEci7GLs=;
        b=J1d0TykngtGrvZxNKmupecigRBtPpdjrxUySkUYWm0iU3XRNMfalMcx0lWizUR7WTI
         u439iKHteR3JmRRnsHggoQxRja8bLzC/7CEb/mErbExOIM+yZ7GNj1il2cW43J+npNLX
         VVqMXVELqIWrqyvDUj+cZ4EQsd52FQ9hQOonU5yTM/P+QnmgnPjHP2oggEWumu6vj6Dh
         n2blW++EaR1OMrIyHg0wXyWD8RcsDVLgL+ESjC5W6VDlo6STboKmYvL+0cFHDe5njZQ8
         sAQ9fAEKOFiWnZPaLIPfvcVTcBvbXjeJvFoCmzRqzJu/foz4OmKYKZnqcOVnTJTsYmD3
         ijkg==
X-Gm-Message-State: AOAM530FXeYGe7PD5Dnr3DKT4NkIxDefoex8Wzjuq8FkUGuLU16pgkez
        jzZIz+63VrtxXMRu2t8tTAYABiNG6agr4+kOuVt/LV8D3aTd
X-Google-Smtp-Source: ABdhPJzWjNzar+P72KKdkIVF+DZ40jOXCSUNpjoq3IH8gtvzQBLAlN4ZtpkRp7YaQTqzLA0ezWTZA4EJ+Ull5RrmQRfAQfZXUJLC
MIME-Version: 1.0
X-Received: by 2002:a02:30c4:: with SMTP id q187mr48480579jaq.102.1593976339427;
 Sun, 05 Jul 2020 12:12:19 -0700 (PDT)
Date:   Sun, 05 Jul 2020 12:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007df63d05a9b68960@google.com>
Subject: general protection fault in bdev_read_page (2)
From:   syzbot <syzbot+662448179365dddc1880@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7c30b859 Merge tag 'spi-fix-v5.8-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1279b86b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7be693511b29b338
dashboard link: https://syzkaller.appspot.com/bug?extid=662448179365dddc1880
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bd80a3100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16af525b100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+662448179365dddc1880@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001e: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000f0-0x00000000000000f7]
CPU: 0 PID: 7121 Comm: systemd-udevd Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:bdev_read_page+0x35/0x290 fs/block_dev.c:700
Code: f5 53 48 89 fb 48 83 ec 08 48 89 14 24 e8 03 12 a5 ff 48 8d bb f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 01 00 00 4c 8b bb f0 00 00 00 48 b8 00 00 00
RSP: 0018:ffffc90001b57530 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81cf749a
RDX: 000000000000001e RSI: ffffffff81cea51d RDI: 00000000000000f0
RBP: fff89719b6b00000 R08: 0000000000000001 R09: ffffea0002871787
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90001b57748
FS:  00007fde67d458c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f65ed31138 CR3: 00000000a78d8000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_mpage_readpage+0x10ca/0x1ef0 fs/mpage.c:302
 mpage_readahead+0x3a2/0x870 fs/mpage.c:391
 read_pages+0x1df/0x8d0 mm/readahead.c:130
 page_cache_readahead_unbounded+0x572/0x850 mm/readahead.c:244
 __do_page_cache_readahead mm/readahead.c:273 [inline]
 force_page_cache_readahead+0x2e9/0x460 mm/readahead.c:303
 page_cache_sync_readahead mm/readahead.c:580 [inline]
 page_cache_sync_readahead+0x113/0x130 mm/readahead.c:567
 generic_file_buffered_read+0x108c/0x27e0 mm/filemap.c:2033
 generic_file_read_iter+0x396/0x4e0 mm/filemap.c:2307
 blkdev_read_iter+0x11b/0x180 fs/block_dev.c:2044
 call_read_iter include/linux/fs.h:1901 [inline]
 new_sync_read+0x41a/0x6e0 fs/read_write.c:415
 __vfs_read+0xc9/0x100 fs/read_write.c:428
 vfs_read+0x1f6/0x420 fs/read_write.c:462
 ksys_read+0x12d/0x250 fs/read_write.c:588
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fde66e8c210
Code: Bad RIP value.
RSP: 002b:00007fff13285fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055f65ed30d00 RCX: 00007fde66e8c210
RDX: 0000000000000400 RSI: 000055f65ed30d28 RDI: 000000000000000f
RBP: 000055f65ed34e80 R08: 00007fde66e76f88 R09: 0000000000000430
R10: 000000000000006d R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000400 R14: 000055f65ed34ed0 R15: 0000000000000400
Modules linked in:
---[ end trace 5b6f53a9af7ced6f ]---
RIP: 0010:bdev_read_page+0x35/0x290 fs/block_dev.c:700
Code: f5 53 48 89 fb 48 83 ec 08 48 89 14 24 e8 03 12 a5 ff 48 8d bb f0 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 01 00 00 4c 8b bb f0 00 00 00 48 b8 00 00 00
RSP: 0018:ffffc90001b57530 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81cf749a
RDX: 000000000000001e RSI: ffffffff81cea51d RDI: 00000000000000f0
RBP: fff89719b6b00000 R08: 0000000000000001 R09: ffffea0002871787
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffc90001b57748
FS:  00007fde67d458c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5807cc2ab4 CR3: 00000000a78d8000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
