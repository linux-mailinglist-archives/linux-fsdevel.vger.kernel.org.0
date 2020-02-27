Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5F55171426
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgB0J3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 04:29:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33648 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgB0J3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:29:12 -0500
Received: by mail-il1-f197.google.com with SMTP id i13so4635801ill.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 01:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=a5nwarW/Ch1YAxFwUTvooBTTNGZG4Pb2BJatlqPFCQE=;
        b=kvzT49aiiGceHnUBAymmbzbgAil6OWWXieIMqQdCBQpRO2aWGzm9ajQDGBvnlSN4FY
         i498ZPdrEEnvwfvEHs5XeY0RwFzQDI/B5fkQXQsxx1FobFp9YasLk1CjMC8stZZJtQGz
         Zs7M3ROnnXuIUtgzmEkl/15RFiAED4SmS4ihlC6uXVbVZEUuumMNNlPwtGpaTmnx4NRx
         uw0LtS7mZL6ZjdIc9wql/yMBqsiCteVOmcGNYHBw9FKpuk5+D3xdzAV8UKSe4hfLlncd
         4Top4BECvWsJk08DKfILc83KdJkZsoBEzf/N9kkbPUnHq6X7cFJDUisv5ujmuzSIxQya
         I6NQ==
X-Gm-Message-State: APjAAAWfRQJQ/q0/0SkWgTKX++L9vuJ5Se0Wez1dqWJoEsPzyQTV2XuX
        C+SzeRKtwUKlUGWJn/nXvcSpJPEB5WEvyHVxiIGtQceDfVCC
X-Google-Smtp-Source: APXvYqympk9d8+qZ5FGZeZTSzTy5FAkbhvFXKmFCYRmxoq7y6pwo/OYAI9WUHGn71WYxNNKY1Asd80Nj+Lp1VgEx/dW2UJ0G4aaA
MIME-Version: 1.0
X-Received: by 2002:a92:ca8a:: with SMTP id t10mr2702434ilo.210.1582795750709;
 Thu, 27 Feb 2020 01:29:10 -0800 (PST)
Date:   Thu, 27 Feb 2020 01:29:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007b25c1059f8b5a4f@google.com>
Subject: KMSAN: uninit-value in simple_attr_read
From:   syzbot <syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14394265e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=fcab69d1ada3e8d6f06b
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1338127ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161403ede00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strlen+0x5e/0xa0 lib/string.c:552
CPU: 1 PID: 11402 Comm: syz-executor230 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 strlen+0x5e/0xa0 lib/string.c:552
 simple_attr_read+0x1ec/0x740 fs/libfs.c:935
 debugfs_attr_read+0x13e/0x290 fs/debugfs/file.c:360
 __vfs_read+0x1a9/0xc80 fs/read_write.c:425
 vfs_read+0x346/0x6a0 fs/read_write.c:461
 ksys_read+0x267/0x450 fs/read_write.c:587
 __do_sys_read fs/read_write.c:597 [inline]
 __se_sys_read+0x92/0xb0 fs/read_write.c:595
 __x64_sys_read+0x4a/0x70 fs/read_write.c:595
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x440269
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff09d3bc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440269
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 000000000000000a R09: 000000000000000a
R10: 0000000000010001 R11: 0000000000000246 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2793 [inline]
 slab_alloc mm/slub.c:2802 [inline]
 kmem_cache_alloc_trace+0x6f3/0xd70 mm/slub.c:2819
 kmalloc include/linux/slab.h:555 [inline]
 simple_attr_open+0xd4/0x400 fs/libfs.c:894
 lowpan_enable_fops_open+0x94/0xb0 net/bluetooth/6lowpan.c:1105
 open_proxy_open+0x657/0x800 fs/debugfs/file.c:189
 do_dentry_open+0xf89/0x1820 fs/open.c:797
 vfs_open+0xaf/0xe0 fs/open.c:914
 do_last fs/namei.c:3490 [inline]
 path_openat+0x4d57/0x6bd0 fs/namei.c:3607
 do_filp_open+0x2b8/0x710 fs/namei.c:3637
 do_sys_openat2+0x92e/0xd40 fs/open.c:1149
 do_sys_open fs/open.c:1165 [inline]
 __do_sys_openat fs/open.c:1179 [inline]
 __se_sys_openat+0x24a/0x2b0 fs/open.c:1174
 __x64_sys_openat+0x56/0x70 fs/open.c:1174
 do_syscall_64+0xb8/0x160 arch/x86/entry/common.c:296
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
