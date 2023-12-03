Return-Path: <linux-fsdevel+bounces-4701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09977802064
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 03:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1E3280E8E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F64A19
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Dec 2023 02:30:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9944C116
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 18:17:22 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fad1eeb333so2245193fac.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 18:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701569842; x=1702174642;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGzXlsAzbZiLccFkwH8GA+pyTeJhZabwV9L8aYXVjKo=;
        b=HtXnEuEVnafxo2AiJiptc0U8D4E+7DoCq+1HTvivOOtEbWXxq6ykkqlRv2ltkCuDRI
         HfEk1kvQ+1eY9lB9ZUrGl+FFQf5/FhPrzNEBm7Q267eXjSVeq/KfmAYaK2LPloXPEpJP
         m5+901pIwtVfFv0ilWF4q/xBsc9KlEG53CEtCRueHSr4JhFFUDKLJTm+Zxh9KOacYFoU
         gKpYOJfFOoePYXqA5spqvUlc4mPGiakflrHKCZKoKMDTnvXHD3Af02E5nxHRpqrWG+TL
         HeQzgHM/NO26gBstExrkqvssZ9ZfW/hJGhd7GqtBwhxPDMpr37kwQ6wj5n9TAQvbJ1z3
         zuzA==
X-Gm-Message-State: AOJu0YyXqltkSUjPIE++MhIjkbwMd6KE09e0Mn/xH0WrYOUhKy2mTnz5
	vJFFoG/RZXJIr6xzN+Y1qPOaiYK2PXS7H+BRqZd7ACgdR8Ox
X-Google-Smtp-Source: AGHT+IH0hFtoyfkjTi/wlcQhnKQkR6jkSpzFeik5lnAZDT4v1m0WC9I7Nu68iRbHaOygebrSbFi81efNOarNRE7JGtC7ONW1IjKT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:160a:b0:1fa:4e4:c49 with SMTP id
 b10-20020a056870160a00b001fa04e40c49mr2091482oae.0.1701569841976; Sat, 02 Dec
 2023 18:17:21 -0800 (PST)
Date: Sat, 02 Dec 2023 18:17:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdfe4b060b91993f@google.com>
Subject: [syzbot] [fs?] general protection fault in pagemap_scan_hugetlb_entry
From: syzbot <syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dan.carpenter@linaro.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	sidhartha.kumar@oracle.com, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Level: ***

Hello,

syzbot found the following issue on:

HEAD commit:    df60cee26a2e Merge tag '6.7-rc3-smb3-server-fixes' of git:..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ad46fce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb39fe85d254f638
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2ccedb96d1174e6a5f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17befd62e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d5a90ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c632017e0dc4/disk-df60cee2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f94c8fa25aeb/vmlinux-df60cee2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af80f80c708b/bzImage-df60cee2.xz

The issue was bisected to:

commit a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
Author: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Date:   Tue Sep 26 19:20:17 2023 +0000

    mm/filemap: remove hugetlb special casing in filemap.c

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17f61552e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=140e1552e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=100e1552e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e2ccedb96d1174e6a5f@syzkaller.appspotmail.com
Fixes: a08c7193e4f1 ("mm/filemap: remove hugetlb special casing in filemap.c")

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5072 Comm: syz-executor107 Not tainted 6.7.0-rc3-syzkaller-00014-gdf60cee26a2e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 walk_hugetlb_range mm/pagewalk.c:326 [inline]
 __walk_page_range+0x36c/0x770 mm/pagewalk.c:393
 walk_page_range+0x626/0xa80 mm/pagewalk.c:521
 do_pagemap_scan+0x40d/0xcd0 fs/proc/task_mmu.c:2437
 do_pagemap_cmd+0x5e/0x80 fs/proc/task_mmu.c:2478
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f171819d669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbe81bb68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffbe81bb80 RCX: 00007f171819d669
RDX: 0000000020000040 RSI: 00000000c0606610 RDI: 0000000000000003
RBP: 00007f1718210610 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000286 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffbe81bdb8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pagemap_scan_backout_range fs/proc/task_mmu.c:1946 [inline]
RIP: 0010:pagemap_scan_hugetlb_entry+0x6ca/0x1130 fs/proc/task_mmu.c:2254
Code: 3c 02 00 0f 85 68 09 00 00 48 8b 83 80 00 00 00 48 8d 04 40 4d 8d 6c c5 00 48 b8 00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 51 09 00 00 4d 8b 75 00 48 8b 7c 24 08 4c 89 f6
RSP: 0018:ffffc90003a2fa50 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc90003a2fdb0 RCX: ffffffff82111e46
RDX: 0000000000000000 RSI: ffffffff82111e54 RDI: ffffc90003a2fe30
RBP: 1ffff92000745f52 R08: 0000000000000006 R09: 0000000020ffc000
R10: 00000000211f9000 R11: ffffffff915f5de8 R12: ffff8880299e0300
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000020ffc000
FS:  0000555555c7b380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 00000000752b4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 68 09             	test   %ebp,0x9(%rax)
   7:	00 00                	add    %al,(%rax)
   9:	48 8b 83 80 00 00 00 	mov    0x80(%rbx),%rax
  10:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
  14:	4d 8d 6c c5 00       	lea    0x0(%r13,%rax,8),%r13
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 51 09 00 00    	jne    0x985
  34:	4d 8b 75 00          	mov    0x0(%r13),%r14
  38:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  3d:	4c 89 f6             	mov    %r14,%rsi


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

