Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B94E283238
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 10:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgJEIia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 04:38:30 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:42361 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgJEIi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:38:26 -0400
Received: by mail-il1-f207.google.com with SMTP id 18so6732804ilt.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 01:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/X0hny45nTAJMYRYWT5kLxsV4E880MCOQ1NBrS8q5FA=;
        b=kleBv3o9pypNllSMupiYKvZynLoJGWUCz9TGIu3XHl6Ct/Bi833dU1Mgl5mRgnF3ut
         1wLHXS3v8TVS90Yzb8R9i3fMY3PK1jGTkT5FFjNJdYbNaHigyzo/ZBU2ZAAXZdNrqoWF
         BkCIsI90ZccVPkf0ZMlOq/7+2tkiP/FN4VvW+DPAwdhNVZKTCJt6VXTIGWS9XOgx55qX
         WBkpLw66Tv8ef4bh0b0ljgcd2t/VFkVvfCyR644nbuTkX+C111uo4+ResI29u2Qz45tU
         eAX6QBP/B25WnaHqH20Frj5D2FFdiE9ULF/InQClTKwuVfczW0ZKEGTcLG1jstjCKLNR
         B9iw==
X-Gm-Message-State: AOAM530KRoOY/m0JBTg63FEK0z79xTAj2goPRe8VZ9Gwv2PpQ07YaOTs
        4zFlXtox3+LRb82ucN0L+M8iiXcTRNX7rO9sSOkOQp4om2xl
X-Google-Smtp-Source: ABdhPJyIyPhScsYqZWWyyWaEryIxyoXWd7m0pZF+x3CfI1nk/ejhYBvuelFHDDwWnfF5pMttNGsjus/AyYMPovd5FTWpeUmM24wC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1392:: with SMTP id d18mr3017810ilo.196.1601887103768;
 Mon, 05 Oct 2020 01:38:23 -0700 (PDT)
Date:   Mon, 05 Oct 2020 01:38:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca5ab205b0e8675a@google.com>
Subject: INFO: trying to register non-static key in clear_inode (2)
From:   syzbot <syzbot+d8dcf068719ec73f6ea9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    549738f1 Linux 5.9-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=138b8993900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
dashboard link: https://syzkaller.appspot.com/bug?extid=d8dcf068719ec73f6ea9
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8dcf068719ec73f6ea9@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 1 PID: 7216 Comm: syz-executor.5 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x157d/0x1630 kernel/locking/lockdep.c:1206
 __lock_acquire+0x101/0x5780 kernel/locking/lockdep.c:4320
 lock_acquire+0x1f3/0xaf0 kernel/locking/lockdep.c:5029
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x94/0xd0 kernel/locking/spinlock.c:167
 spin_lock_irq include/linux/spinlock.h:379 [inline]
 clear_inode+0x1b/0x1e0 fs/inode.c:529
 shmem_evict_inode+0x240/0xbc0 mm/shmem.c:1182
 evict+0x2ed/0x750 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 do_unlinkat+0x40b/0x660 fs/namei.c:3902
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f4f549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000090bed1c EFLAGS: 00000212 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00000000090bedac RCX: 000000005f7aa726
RDX: 0000000009908228 RSI: 0000000000000000 RDI: 00000000080d8a9e
RBP: 00000000090bedac R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
------------[ cut here ]------------
kernel BUG at fs/inode.c:533!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7216 Comm: syz-executor.5 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:clear_inode+0x189/0x1e0 fs/inode.c:533
Code: 75 38 e8 aa 5e ad ff 48 c7 83 d8 00 00 00 60 00 00 00 5b 5d 41 5c c3 e8 95 5e ad ff 0f 0b e8 8e 5e ad ff 0f 0b e8 87 5e ad ff <0f> 0b e8 80 5e ad ff 0f 0b e8 79 5e ad ff 0f 0b e8 72 5e ad ff 0f
RSP: 0018:ffffc90006677c38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800011c120 RCX: 0000000000000000
RDX: ffff8880910aa380 RSI: ffffffff81c8e009 RDI: 0000000000000001
RBP: ffff88800011c4c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000031323754 R12: ffff88800011c350
R13: ffff888086128878 R14: ffff88800011c0c8 R15: ffff88800011c0c8
FS:  0000000000000000(0000) GS:ffff8880ae500000(0063) knlGS:0000000009907900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002001d000 CR3: 00000000a4575000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 shmem_evict_inode+0x240/0xbc0 mm/shmem.c:1182
 evict+0x2ed/0x750 fs/inode.c:576
 iput_final fs/inode.c:1652 [inline]
 iput.part.0+0x424/0x850 fs/inode.c:1678
 iput+0x58/0x70 fs/inode.c:1668
 do_unlinkat+0x40b/0x660 fs/namei.c:3902
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x60/0x90 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f4f549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000090bed1c EFLAGS: 00000212 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00000000090bedac RCX: 000000005f7aa726
RDX: 0000000009908228 RSI: 0000000000000000 RDI: 00000000080d8a9e
RBP: 00000000090bedac R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 9126b3e9e9b64308 ]---
RIP: 0010:clear_inode+0x189/0x1e0 fs/inode.c:533
Code: 75 38 e8 aa 5e ad ff 48 c7 83 d8 00 00 00 60 00 00 00 5b 5d 41 5c c3 e8 95 5e ad ff 0f 0b e8 8e 5e ad ff 0f 0b e8 87 5e ad ff <0f> 0b e8 80 5e ad ff 0f 0b e8 79 5e ad ff 0f 0b e8 72 5e ad ff 0f
RSP: 0018:ffffc90006677c38 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800011c120 RCX: 0000000000000000
RDX: ffff8880910aa380 RSI: ffffffff81c8e009 RDI: 0000000000000001
RBP: ffff88800011c4c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000031323754 R12: ffff88800011c350
R13: ffff888086128878 R14: ffff88800011c0c8 R15: ffff88800011c0c8
FS:  0000000000000000(0000) GS:ffff8880ae500000(0063) knlGS:0000000009907900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000090c7850 CR3: 00000000a4575000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
