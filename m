Return-Path: <linux-fsdevel+bounces-2893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307277EC3BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 14:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97761F26E72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4790C1A715;
	Wed, 15 Nov 2023 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966231A703
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 13:32:21 +0000 (UTC)
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D672125
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 05:32:20 -0800 (PST)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-28004d4462dso721559a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 05:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055139; x=1700659939;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiUWWAK8hFsU91ktuG0aBOn9mRyPVX1KZ66LKphaOsM=;
        b=dV/uHFyAwGgPBcPjYGqS0/osMocbaQkGvNX6rochrxU9H+SW0rDiTyqDq+phBfYfIv
         snpJuQPrOA15TJ/rKTlJx/Ho4+/bVnkifEN/ijZUFkMSH8kxq+Ekypu/8SMtUvFZNd4M
         FjE7viJHIVIcQ+43SApuajXzf6AvTIVKW+0BWFMb+ov20Kx4TEmPmgZ6q/XnCMSNpXNb
         qlOgbNZh4fzuiFBjqgi5hi0k0CMyGiUsCsYP80VM2MSNIZqlOtrj6zsjVuNf5Vv7jI68
         8rnOpC/bFbcAeBW9IHMQA2c3vcQKjw2lP6WkF3MecagsvS1QPjA4oB17be/ehvc4niM4
         Z9tg==
X-Gm-Message-State: AOJu0YxNez9o+GcA9Znby9sKO5RrYhZCGugeaqkSuzBsQbRxsgWOZE1g
	+AyZ3bKE2Plfv0W/xdbSn7DOWj2Q+9qTh7EpBGyzQMn1s0Bs
X-Google-Smtp-Source: AGHT+IHQciS6h1jPmUiLqvMgAMIin4uULzptWzeI8+RwCVMuG/H/DumfPZBvBZ5xxMRXeNAd/yLL+NJDHS1H3OMM9tIJene435AS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d803:b0:27d:a0b:bff with SMTP id
 a3-20020a17090ad80300b0027d0a0b0bffmr3748368pjv.2.1700055139538; Wed, 15 Nov
 2023 05:32:19 -0800 (PST)
Date: Wed, 15 Nov 2023 05:32:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0e576060a30ee3b@google.com>
Subject: [syzbot] [mm?] WARNING in unmap_page_range (2)
From: syzbot <syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, usama.anjum@collabora.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac347a0655db Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15ff3057680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=287570229f5c0a7c
dashboard link: https://syzkaller.appspot.com/bug?extid=7ca4b2719dc742b8d0a4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162a25ff680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d62338e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/00e30e1a5133/disk-ac347a06.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07c43bc37935/vmlinux-ac347a06.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6690c715398/bzImage-ac347a06.xz

The issue was bisected to:

commit 12f6b01a0bcbeeab8cc9305673314adb3adf80f7
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Mon Aug 21 14:15:15 2023 +0000

    fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e5591f680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e5591f680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e5591f680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ca4b2719dc742b8d0a4@syzkaller.appspotmail.com
Fixes: 12f6b01a0bcb ("fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_pte_range mm/memory.c:1520 [inline]
WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_pmd_range mm/memory.c:1582 [inline]
WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_pud_range mm/memory.c:1611 [inline]
WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 zap_p4d_range mm/memory.c:1632 [inline]
WARNING: CPU: 0 PID: 5059 at mm/memory.c:1520 unmap_page_range+0x1711/0x2c00 mm/memory.c:1653
Modules linked in:
CPU: 0 PID: 5059 Comm: syz-executor416 Not tainted 6.6.0-syzkaller-16039-gac347a0655db #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:zap_pte_range mm/memory.c:1520 [inline]
RIP: 0010:zap_pmd_range mm/memory.c:1582 [inline]
RIP: 0010:zap_pud_range mm/memory.c:1611 [inline]
RIP: 0010:zap_p4d_range mm/memory.c:1632 [inline]
RIP: 0010:unmap_page_range+0x1711/0x2c00 mm/memory.c:1653
Code: 0f 8e 4a 12 00 00 48 8b 44 24 30 31 ff 0f b6 58 08 89 de e8 d1 00 bf ff 84 db 0f 85 88 f3 ff ff e9 0a f4 ff ff e8 8f 05 bf ff <0f> 0b e9 77 f3 ff ff e8 83 05 bf ff 48 83 44 24 10 08 e9 9d f6 ff
RSP: 0018:ffffc900034bf8f8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000007 RCX: ffffffff81c894fd
RDX: ffff88801ff66040 RSI: ffffffff81c89561 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888074017008 R14: dffffc0000000000 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f70d28ca0d0 CR3: 000000001d5be000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1699
 unmap_vmas+0x229/0x470 mm/memory.c:1743
 exit_mmap+0x1ad/0xa60 mm/mmap.c:3308
 __mmput+0x12a/0x4d0 kernel/fork.c:1349
 mmput+0x62/0x70 kernel/fork.c:1371
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9ad/0x2ae0 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f70d284ef39
Code: Unable to access opcode bytes at 0x7f70d284ef0f.
RSP: 002b:00007ffc9cfa2fb8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f70d284ef39
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 00007f70d28c9270 R08: ffffffffffffffb8 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f70d28c9270
R13: 0000000000000000 R14: 00007f70d28c9cc0 R15: 00007f70d2820ae0
 </TASK>


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

