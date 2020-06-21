Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F010F2029F7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgFUKHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 06:07:13 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:46593 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFUKHN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 06:07:13 -0400
Received: by mail-io1-f70.google.com with SMTP id w2so10374358iom.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 03:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mzm10RGjJNpKvxhGS4GfgH7+IDQ736GgimRVfF5QPkg=;
        b=ban/Ep/t3tBqxWK7dpjUWDSsGaTuhIwYUDYEbdL7KO9zMBVrgepcTaz9LWozDt81La
         rUX5WeX5cqppIGYMqo2bR20M/TlLmx5ksOqM6Sxlqk5Emow5ct/iEl3/F1mu3nnuT/oH
         DEgNPIzMO9IXCEQHfuTWrAyIqkv9wqSiX/85G7i4keR7OPiud2jtAvwD0L1v32gRDg09
         jqiTEohN74IyRY+wZsWyn4JRFGuYAOdDYdhvfyOBLOew5sIyFryP29vb61Peiz4dja3q
         e3lv0q7zhk2Mze0TZVFNDTvBl75//UdJdPDV72djWPk2oXea+EnjKCyzhLiWpVo4zqVT
         6Fag==
X-Gm-Message-State: AOAM5306sOS/5A5qe00oJq9fGMxtKCwRTOLMhlKG+r0l3bBI86DiKokW
        bBPLWulCR/enqYK4E+Xk2xXH107YXlrPlljdCYT1bRS+h/xD
X-Google-Smtp-Source: ABdhPJwZv8cJwKrif3fd/MrdYQ8iTjiZ8EkVFX88TS7S24e46rMMWlVphVoI8B4IMCrijKdWohyDABfBLZvHxHlsPmsvK2k+AGGT
MIME-Version: 1.0
X-Received: by 2002:a92:5fcd:: with SMTP id i74mr11780919ill.169.1592734031570;
 Sun, 21 Jun 2020 03:07:11 -0700 (PDT)
Date:   Sun, 21 Jun 2020 03:07:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c6fbf05a8954afe@google.com>
Subject: BUG: sleeping function called from invalid context in do_user_addr_fault
From:   syzbot <syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1772c3a9100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=7748c5375dc20dfdb92f
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1259
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 10572, name: syz-executor.3
2 locks held by syz-executor.3/10572:
 #0: ffffffff892e89d0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:240
 #1: ffff88809b127028 (&mm->mmap_sem#2){++++}-{3:3}, at: do_user_addr_fault+0x344/0xba0 arch/x86/mm/fault.c:1242
Preemption disabled at:
[<ffffffff8147bc44>] irq_enter+0x64/0x100 kernel/softirq.c:358
CPU: 0 PID: 10572 Comm: syz-executor.3 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 ___might_sleep+0x3c0/0x570 kernel/sched/core.c:6877
 do_user_addr_fault+0x377/0xba0 arch/x86/mm/fault.c:1259
 page_fault+0x39/0x40 arch/x86/entry/entry_64.S:1203
RIP: 0010:__read_once_size include/linux/compiler.h:252 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x60 kernel/kcov.c:202
Code: c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 04 14 00 00 00 74 2c 8b 91 e0 13 00 00 83 fa 02 75 21 48 8b 91 e8 13 00 00 <48> 8b 32 48 8d 7e 01 8b 89 e4 13 00 00 48 39 cf 73 08 48 89 44 f2
RSP: 0018:ffffc90004b37938 EFLAGS: 00010246
RAX: ffffffff81c35ba2 RBX: 0000000000000001 RCX: ffff88805962a380
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880ae8387d8
RBP: 0000000000000000 R08: dffffc0000000000 R09: ffffed1015d070fc
R10: ffffed1015d070fc R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90004b37d30 R14: ffffc900000ca3b0 R15: ffff8880a26f4170
 rcu_read_lock include/linux/rcupdate.h:635 [inline]
 __d_lookup+0xa2/0x6e0 fs/dcache.c:2386
 lookup_fast+0x99/0x700 fs/namei.c:1488
 walk_component+0x72/0x680 fs/namei.c:1842
 link_path_walk+0x66d/0xba0 fs/namei.c:2165
 path_openat+0x21d/0x38b0 fs/namei.c:3342
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca59
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fada1226c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000004f7e60 RCX: 000000000045ca59
RDX: 0000000000000000 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 000000000078c180 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000007b2 R14: 00000000004ca90b R15: 00007fada12276d4
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD a1df9067 P4D a1df9067 PUD a0772067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10572 Comm: syz-executor.3 Tainted: G        W         5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__read_once_size include/linux/compiler.h:252 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x60 kernel/kcov.c:202
Code: c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 04 14 00 00 00 74 2c 8b 91 e0 13 00 00 83 fa 02 75 21 48 8b 91 e8 13 00 00 <48> 8b 32 48 8d 7e 01 8b 89 e4 13 00 00 48 39 cf 73 08 48 89 44 f2
RSP: 0018:ffffc90004b37938 EFLAGS: 00010246
RAX: ffffffff81c35ba2 RBX: 0000000000000001 RCX: ffff88805962a380
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880ae8387d8
RBP: 0000000000000000 R08: dffffc0000000000 R09: ffffed1015d070fc
R10: ffffed1015d070fc R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90004b37d30 R14: ffffc900000ca3b0 R15: ffff8880a26f4170
FS:  00007fada1227700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a7654000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rcu_read_lock include/linux/rcupdate.h:635 [inline]
 __d_lookup+0xa2/0x6e0 fs/dcache.c:2386
 lookup_fast+0x99/0x700 fs/namei.c:1488
 walk_component+0x72/0x680 fs/namei.c:1842
 link_path_walk+0x66d/0xba0 fs/namei.c:2165
 path_openat+0x21d/0x38b0 fs/namei.c:3342
 do_filp_open+0x191/0x3a0 fs/namei.c:3373
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca59
Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fada1226c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000004f7e60 RCX: 000000000045ca59
RDX: 0000000000000000 RSI: 0000000020000100 RDI: ffffffffffffff9c
RBP: 000000000078c180 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000007b2 R14: 00000000004ca90b R15: 00007fada12276d4
Modules linked in:
CR2: 0000000000000000
---[ end trace 4b5ea1725b962f43 ]---
RIP: 0010:__read_once_size include/linux/compiler.h:252 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x3f/0x60 kernel/kcov.c:202
Code: c2 00 01 ff 00 74 11 f7 c2 00 01 00 00 74 35 83 b9 04 14 00 00 00 74 2c 8b 91 e0 13 00 00 83 fa 02 75 21 48 8b 91 e8 13 00 00 <48> 8b 32 48 8d 7e 01 8b 89 e4 13 00 00 48 39 cf 73 08 48 89 44 f2
RSP: 0018:ffffc90004b37938 EFLAGS: 00010246
RAX: ffffffff81c35ba2 RBX: 0000000000000001 RCX: ffff88805962a380
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff8880ae8387d8
RBP: 0000000000000000 R08: dffffc0000000000 R09: ffffed1015d070fc
R10: ffffed1015d070fc R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc90004b37d30 R14: ffffc900000ca3b0 R15: ffff8880a26f4170
FS:  00007fada1227700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a7654000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
