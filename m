Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F873D810
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjFZGy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 02:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFZGyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:54:53 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0DE70
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 23:54:49 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-345ac144755so2642155ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jun 2023 23:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762488; x=1690354488;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8mEi6poOBLtYC1W5WtbrRIYe+es2VTG5P987tbWLzsw=;
        b=OCVcBMgPNjBeV0EYUhtlvB/4evv/Qn5LGSz+ZqCrGzI4V7TYkm8+ztpSAf4Pb6elfN
         D+JWg9Uj+ZJ8MCXWhfPOVWNL+XbVGPkPQNo8Ztmi4frxmMZ/dgBg6IA5lrO9u4U4BrMZ
         s8HTGmJh0WqJI69L/wAH2BnrH/E943NHedDyqtTy4ayhLz9pw+e7BKrrSNTm06A1cpIj
         6zat8Xdfo7FnLateEWCcL7LkDYQeB2hJUsHpuL1Ao4XkFgKMz7/xeqytxNWlxIWdP0P1
         P0TuAB3wS46miy1R8C+C0lIL1lbIgD4V85iQs2RyHwyZ59ImaO3zc0pp+98w/d5Luohi
         xulw==
X-Gm-Message-State: AC+VfDxS45wjTYMcCJqsxIpAmWpMg8ekJOjHbEaTuX3ZnAe2W4U3Pffo
        ISskSoX3qabWyLTkellafvqHcu63EqjTGm/EceD8qzCfsr4A
X-Google-Smtp-Source: ACHHUZ7zLfPBwSCF/f6vdEneINOaDNd0j9+qLXY9mgaYJt+jhBjTPa0ZV8ku3SRi6nLRUREcoxX5QayjylmT2NgKjC0O1VClkgku
MIME-Version: 1.0
X-Received: by 2002:a92:4b06:0:b0:345:93da:209 with SMTP id
 m6-20020a924b06000000b0034593da0209mr1557103ilg.2.1687762488685; Sun, 25 Jun
 2023 23:54:48 -0700 (PDT)
Date:   Sun, 25 Jun 2023 23:54:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a7f2105ff02d381@google.com>
Subject: [syzbot] [reiserfs?] [fat?] [mm?] general protection fault in
 unlink_file_vma (2)
From:   syzbot <syzbot+7fbdbd17a5bd6d01bc65@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, reiserfs-devel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    547cc9be86f4 Merge tag 'perf_urgent_for_v6.4' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120f1677280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=7fbdbd17a5bd6d01bc65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a58757280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134a0f1f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7daf3e78f564/disk-547cc9be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb3208252f02/vmlinux-547cc9be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/209415d43289/bzImage-547cc9be.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ad9db3ff710e/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fbdbd17a5bd6d01bc65@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000030: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000180-0x0000000000000187]
CPU: 0 PID: 4994 Comm: udevd Not tainted 6.4.0-rc7-syzkaller-00234-g547cc9be86f4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__lock_acquire+0xe01/0x5f30 kernel/locking/lockdep.c:4956
Code: 00 00 3b 05 01 b0 59 0f 0f 87 7a 09 00 00 41 be 01 00 00 00 e9 84 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 9e 33 00 00 49 81 3c 24 20 38 16 90 0f 84 cd f2
RSP: 0000:ffffc90003b0f5d8 EFLAGS: 00010016

RAX: dffffc0000000000 RBX: 1ffff92000761eec RCX: 0000000000000000
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000180
RBP: ffff888076abbb80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81d6f0d2 R12: 0000000000000180
R13: 0000000000000000 R14: 0000000000000180 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff9 CR3: 00000000278f2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 i_mmap_lock_write include/linux/fs.h:485 [inline]
 unlink_file_vma+0x81/0x120 mm/mmap.c:128
 free_pgtables+0x147/0x930 mm/memory.c:386
 exit_mmap+0x29e/0x930 mm/mmap.c:3118
 __mmput+0x128/0x4c0 kernel/fork.c:1351
 mmput+0x60/0x70 kernel/fork.c:1373
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b0/0x29b0 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x2318/0x25b0 kernel/signal.c:2876
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:310
 exc_page_fault+0xc0/0x170 arch/x86/mm/fault.c:1593
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7fd9a06c926e
Code: Unable to access opcode bytes at 0x7fd9a06c9244.
RSP: 002b:00007fffd3ceb1d0 EFLAGS: 00010202
RAX: 000056344395de44 RBX: fffffffffffffe60 RCX: 000000000000001f
RDX: 000056344395f79e RSI: 000056312086e010 RDI: 0000000000000001
RBP: 0000563120882320 R08: 0000000000000000 R09: 8ad69a18ea1c0cdc
R10: 00000000ffffffff R11: 0000000000000007 R12: fffffffffffffff1
R13: 000056311ea72040 R14: 0000000000000000 R15: 000056312086e910
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe01/0x5f30 kernel/locking/lockdep.c:4956
Code: 00 00 3b 05 01 b0 59 0f 0f 87 7a 09 00 00 41 be 01 00 00 00 e9 84 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 9e 33 00 00 49 81 3c 24 20 38 16 90 0f 84 cd f2
RSP: 0000:ffffc90003b0f5d8 EFLAGS: 00010016
RAX: dffffc0000000000 RBX: 1ffff92000761eec RCX: 0000000000000000
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000180
RBP: ffff888076abbb80 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81d6f0d2 R12: 0000000000000180
R13: 0000000000000000 R14: 0000000000000180 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffffffff9 CR3: 00000000278f2000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	3b 05 01 b0 59 0f    	cmp    0xf59b001(%rip),%eax        # 0xf59b009
   8:	0f 87 7a 09 00 00    	ja     0x988
   e:	41 be 01 00 00 00    	mov    $0x1,%r14d
  14:	e9 84 00 00 00       	jmpq   0x9d
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 9e 33 00 00    	jne    0x33d2
  34:	49 81 3c 24 20 38 16 	cmpq   $0xffffffff90163820,(%r12)
  3b:	90
  3c:	0f                   	.byte 0xf
  3d:	84 cd                	test   %cl,%ch
  3f:	f2                   	repnz


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
