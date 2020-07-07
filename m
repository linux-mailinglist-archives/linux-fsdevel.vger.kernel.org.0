Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058DF217922
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 22:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGGUQ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 16:16:27 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33314 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGUQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:16:27 -0400
Received: by mail-io1-f69.google.com with SMTP id x2so26663121iof.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 13:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dR4bNMUx1r4Ca56TjVMWL41woSnGCncK21qs6HcUUW8=;
        b=h74njhBK4IGRX0swbC0Ao+HWuT+32WhEHuT5mPxSVjzxY8++FG0WHV7LpRu7GX4rNU
         92N+0TRVNdQB4yBknVdKoXfC/V2MVSUiOJbpfob6NLtSpy9cxgtcwPN/b2pBS8/BgmZ8
         QG7EClNSDfphH2cJiHqxDESaLcKWGdx6yAHXfFX8gbABK2VNlI8tA3l9dvdrm/MNkOqv
         DXKeFp0dYW3gF/dLR8sUzyPIrmw7hTJ0PRICdsfueYY0+NE1w0l9eSPT5iYtPkA+T9Rr
         P6h5wZ3vVq+xZ8kMrjtbTohd3KYfWjOw28jqW6hFSty/XhlVeAeu9ppWvgJbRFKgo/Qw
         K/Jw==
X-Gm-Message-State: AOAM531kNRk4+R4IwPHfg79W6G5J0hFY3hxAavh5LOw2D92PwcVhvnu1
        j+LnQfitmyqdXv4NblL1PxEoFisHju6FcAvRIKb00J23tDLe
X-Google-Smtp-Source: ABdhPJz7SsqUs129FfxLBzeUA+omP///IVXqW+HzxrlwzojVITiw3p5ysCjO92SvHBSPQdttjN5gkEQ9s46c/w78AktpAdQTAX9N
MIME-Version: 1.0
X-Received: by 2002:a02:70d6:: with SMTP id f205mr61992950jac.5.1594152985671;
 Tue, 07 Jul 2020 13:16:25 -0700 (PDT)
Date:   Tue, 07 Jul 2020 13:16:25 -0700
In-Reply-To: <0000000000002c6fbf05a8954afe@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006dbe1005a9dfaa7c@google.com>
Subject: Re: BUG: sleeping function called from invalid context in do_user_addr_fault
From:   syzbot <syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ed01a3100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=7748c5375dc20dfdb92f
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1469d28f100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7748c5375dc20dfdb92f@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1253
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 6824, name: syz-executor.2
1 lock held by syz-executor.2/6824:
 #0: ffff88809abb82a8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:56 [inline]
 #0: ffff88809abb82a8 (&mm->mmap_lock#2){++++}-{3:3}, at: do_user_addr_fault+0x344/0xba0 arch/x86/mm/fault.c:1236
irq event stamp: 190300
hardirqs last  enabled at (190299): [<ffffffff881efdef>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (190299): [<ffffffff881efdef>] _raw_spin_unlock_irqrestore+0x6f/0xd0 kernel/locking/spinlock.c:191
hardirqs last disabled at (190300): [<ffffffff810075c2>] __syscall_return_slowpath+0x52/0x180 arch/x86/entry/common.c:328
softirqs last  enabled at (187494): [<ffffffff88200f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
softirqs last disabled at (187473): [<ffffffff88200f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 0 PID: 6824 Comm: syz-executor.2 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 ___might_sleep+0x3c0/0x570 kernel/sched/core.c:6899
 do_user_addr_fault+0x377/0xba0 arch/x86/mm/fault.c:1253
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0x124/0x1f0 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:565
RIP: 0010:__prepare_exit_to_usermode+0x52/0x1e0 arch/x86/entry/common.c:240
Code: 24 50 15 00 00 0f 85 8f 01 00 00 f0 41 80 64 24 03 7f 83 3d 9f e9 6c 08 00 74 23 41 83 bc 24 cc 08 00 00 00 75 18 41 83 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001607f10 EFLAGS: 00010006
RAX: 0000000000000000 RBX: 000000000000003d RCX: ffff888095318300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90001607f58
RBP: 0000000000000000 R08: ffffffff817a2250 R09: ffffed10128c82ed
R10: ffffed10128c82ed R11: 0000000000000000 R12: ffff888095318300
R13: 0000000000000000 R14: ffffc90001607f58 R15: ffffc90001607f58
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4169ca
Code: Bad RIP value.
RSP: 002b:00007fff61070cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: 0000000000000000 RBX: 000000000000e1d1 RCX: 00000000004169ca
RDX: 0000000040000001 RSI: 00007fff61070d10 RDI: ffffffffffffffff
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001cf2940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 00007fff61070d10 R14: 000000000000de93 R15: 00007fff61070d20
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD a7cf1067 P4D a7cf1067 PUD a0728067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6824 Comm: syz-executor.2 Tainted: G        W         5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__prepare_exit_to_usermode+0x52/0x1e0 arch/x86/entry/common.c:240
Code: 24 50 15 00 00 0f 85 8f 01 00 00 f0 41 80 64 24 03 7f 83 3d 9f e9 6c 08 00 74 23 41 83 bc 24 cc 08 00 00 00 75 18 41 83 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001607f10 EFLAGS: 00010006
RAX: 0000000000000000 RBX: 000000000000003d RCX: ffff888095318300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90001607f58
RBP: 0000000000000000 R08: ffffffff817a2250 R09: ffffed10128c82ed
R10: ffffed10128c82ed R11: 0000000000000000 R12: ffff888095318300
R13: 0000000000000000 R14: ffffc90001607f58 R15: ffffc90001607f58
FS:  0000000001cf2940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a380c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 do_syscall_64+0x7f/0xe0 arch/x86/entry/common.c:368
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4169ca
Code: Bad RIP value.
RSP: 002b:00007fff61070cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000003d
RAX: 0000000000000000 RBX: 000000000000e1d1 RCX: 00000000004169ca
RDX: 0000000040000001 RSI: 00007fff61070d10 RDI: ffffffffffffffff
RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000001cf2940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 00007fff61070d10 R14: 000000000000de93 R15: 00007fff61070d20
Modules linked in:
CR2: 0000000000000000
---[ end trace bee8a2ac971d1076 ]---
RIP: 0010:__prepare_exit_to_usermode+0x52/0x1e0 arch/x86/entry/common.c:240
Code: 24 50 15 00 00 0f 85 8f 01 00 00 f0 41 80 64 24 03 7f 83 3d 9f e9 6c 08 00 74 23 41 83 bc 24 cc 08 00 00 00 75 18 41 83 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
RSP: 0018:ffffc90001607f10 EFLAGS: 00010006
RAX: 0000000000000000 RBX: 000000000000003d RCX: ffff888095318300
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc90001607f58
RBP: 0000000000000000 R08: ffffffff817a2250 R09: ffffed10128c82ed
R10: ffffed10128c82ed R11: 0000000000000000 R12: ffff888095318300
R13: 0000000000000000 R14: ffffc90001607f58 R15: ffffc90001607f58
FS:  0000000001cf2940(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a380c000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

