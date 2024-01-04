Return-Path: <linux-fsdevel+bounces-7355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E38240B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3A2283CD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 11:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EA5219F2;
	Thu,  4 Jan 2024 11:33:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D8219E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fd902c677so2413905ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 03:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704368005; x=1704972805;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z6aGuDvpYQUksFUHAmENfFaQp6wPi3FHv64CWDEiCWU=;
        b=LwVONCesWPhNGxPxErxxAu/PPnar/+jo+uWIAgOC6xHVuOrGNGPc+5JmjIMMe/cW2L
         cL237keb9jjkWk+fWyAqMjBhQLHwbQ4xx3e+aiWY8AKzSF9/hkbP5HoMnuyw53Lverk9
         MGcEaebgMgjR4B8MS2QOzwSaZQnnvt7LEsNEPjRMq9xD+4vdYt++ywy7V7xAuNOpJf/t
         1+z+qjr2nqEgK5Z/irKMpBp8JXqiT4OCd5Mkjw7fwMi6Mp3uwiflJuVriIIrsXmzsBI9
         xR/rtqFUewQSyRVArirbVvOMUW6nIti5/Ee3HXgwgo2dZYkjITnOOq66CewE20ITA73l
         BCUg==
X-Gm-Message-State: AOJu0YwfGO1MPYNHcfRTas+3IYhhlU8w9c2/l0kFCT3+c+7dJ4eDHyvG
	kH/R1AIY2fjRPMIY4JF1hsn7//zS8+z6Dps6QEPV9pufh1DU
X-Google-Smtp-Source: AGHT+IHjzc3t0M1BuNsSfxbFFB0E77D2XSJkMZII+4oUQ53F91g3oOJJ779JeCpxk0+f4UUxcluQcVc2EZFpduTkMYeqm2jG2RQX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:360:391:93ce with SMTP id
 a10-20020a92c54a000000b00360039193cemr38971ilj.1.1704368005580; Thu, 04 Jan
 2024 03:33:25 -0800 (PST)
Date: Thu, 04 Jan 2024 03:33:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a0fa9060e1d198e@google.com>
Subject: [syzbot] [mm?] [reiserfs?] general protection fault in
 free_swap_cache (4)
From: syzbot <syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bristot@redhat.com, bsegall@google.com, 
	chouhan.shreyansh630@gmail.com, dietmar.eggemann@arm.com, jack@suse.cz, 
	jeffm@suse.com, juri.lelli@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, reiserfs-devel@vger.kernel.org, 
	rkovhaev@gmail.com, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    610a9b8f49fb Linux 6.7-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106d2699e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca880a5d56f9b1
dashboard link: https://syzkaller.appspot.com/bug?extid=fd93e36ced1a43a58f75
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f4cc41e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d526ade80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1acb98afcb0/disk-610a9b8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4f7d6503eb8c/vmlinux-610a9b8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/927f38e505d9/bzImage-610a9b8f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c4f427645c60/mount_0.gz

The issue was bisected to:

commit 13d257503c0930010ef9eed78b689cec417ab741
Author: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Date:   Fri Jul 9 15:29:29 2021 +0000

    reiserfs: check directory items on read from disk

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1603b8f9e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1503b8f9e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1103b8f9e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd93e36ced1a43a58f75@syzkaller.appspotmail.com
Fixes: 13d257503c09 ("reiserfs: check directory items on read from disk")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 5048 Comm: sshd Not tainted 6.7.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:_compound_head include/linux/page-flags.h:247 [inline]
RIP: 0010:free_swap_cache+0x25/0x3d0 mm/swap_state.c:287
Code: 0f 1f 44 00 00 66 0f 1f 00 41 54 55 53 48 89 fb e8 90 e9 b2 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 34 03 00 00 4c 8b 63 08 31 ff 4c 89 e5 83 e5 01
RSP: 0018:ffffc900034df938 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81d3826a
RDX: 0000000000000001 RSI: ffffffff81d37b70 RDI: 0000000000000008
RBP: 0000000000000005 R08: 0000000000000004 R09: 0000000000000200
R10: 0000000000000004 R11: 0000000000000001 R12: 0000000000000200
R13: dffffc0000000000 R14: ffff88807490d010 R15: ffff88807490d008
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc22cebe00 CR3: 000000007c973000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 free_pages_and_swap_cache+0x60/0xa0 mm/swap_state.c:315
 tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:98
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu mm/mmu_gather.c:300 [inline]
 tlb_finish_mmu+0x14b/0x6f0 mm/mmu_gather.c:392
 exit_mmap+0x38b/0xa70 mm/mmap.c:3321
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9a5/0x2ad0 kernel/exit.c:856
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
 get_signal+0x23b5/0x2790 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x5623b9f0af8e
Code: Unable to access opcode bytes at 0x5623b9f0af64.
RSP: 002b:00007fff3b36f178 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: 0000000000000000 RBX: 00000000000668a0 RCX: 00007f85b4f19ad5
RDX: 00007fff3b36f180 RSI: 00007fff3b36f2b0 RDI: 0000000000000011
RBP: 00005623bb920260 R08: 0000000000000008 R09: 0000000000000000
R10: 00007fff3b36f848 R11: 0000000000000246 R12: 00005623b9f8faa4
R13: 0000000000000001 R14: 00005623b9f903e8 R15: 00007fff3b36f7c8
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   5:	66 0f 1f 00          	nopw   (%rax)
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 90 e9 b2 ff       	call   0xffb2e9a5
  15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 34 03 00 00    	jne    0x368
  34:	4c 8b 63 08          	mov    0x8(%rbx),%r12
  38:	31 ff                	xor    %edi,%edi
  3a:	4c 89 e5             	mov    %r12,%rbp
  3d:	83 e5 01             	and    $0x1,%ebp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

