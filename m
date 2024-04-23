Return-Path: <linux-fsdevel+bounces-17501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B548AE438
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331F91F2142A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8180040;
	Tue, 23 Apr 2024 11:38:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270EE7F7EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872300; cv=none; b=V63AA1/m+KXpb9tdz++RKk8LYb1LZAZUfJyCgxfNnsM28m0F/DcHNaIeW8Pr/RLzJBf59JLmSEXjCd43st3+fygEFPRdYSXLgb6MZG1ilUXRFmZ+D19wIAvSuRTz9MVDhTOqL0wHmlBO3OXs9MDzwTxNmvAh8ZmBwY/lxynipGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872300; c=relaxed/simple;
	bh=edpR4V4UufkC6Q7sDETTFaZGGVz23xgEptOGtSzAMp4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MyBMVdfZgNuNsQ3Ms2UYcbyrA2Ln2VRc1i54asO9xBq6uvN5ovkwix8Vfmr3jkZeie+AcIRfe3aRmajTh41ywfY/C2wRRowzpyh9geJwIFpYMIp4CUso+9+uhOohnld3lw3FGdzoKSzck3dCQJIHIN9a54q6kv2jpTUw9ndJunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dd914c91afso137378039f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 04:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872298; x=1714477098;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nzZmkYlRcZ64VuYGAa+e/dW/+oc3oLK0hmQ5R2S61Y=;
        b=OmBszYe99V6FpMPcURVW4EchL2uJtOSR0lew2Nlq4VuQj9jQtRcK76dHCCh0KkgR2d
         NYUgnawT6Kg9cSMFMoC3SiY8+koGmOrXuGG7C3fGqqvtyHZG6pMPldjJcRfFfVjYpisD
         jENC6ZPyPJGwwES44vFerdu2DSzjrtz5893ylA5SiDguneQK+CiYVLNhxp6TZM9JkjnA
         R8nGrF2+pBXG9q/mzEkC1u2ndZqtEvIBh9BS1F++12AneHUv/qLc5ZzVQ1MxJP5dUre6
         k8SQwZhAjxqDkFTR+QZM/TwCtJ2d1lKCGmytkaxDGhIHKXQAfb2/UZ62uyRPA1L/z5P6
         PabA==
X-Forwarded-Encrypted: i=1; AJvYcCUPTEWdFAMavz+IZrePQWHhvzenaJnzXP42I95czr6jANfhhN0ujK4eMtiahbSOe9I5fIaRUwh30Cew+ZpTnNCveBUegSg3mgNefzCgiA==
X-Gm-Message-State: AOJu0YwDr6mYnhvX5ShiBKbCVi8cVLSzYLMzsqjsSwxKEdbtGgJbBZ44
	HuAicw/nP/HmcjgpKYQTgWzh2PT3WUmyiSDh33CNZAR45ia1RtgbKsdKzcwSPChKxgytk4yrZWI
	5D9eBkcpjCzQ4k0uDEUN4uqBSw7P9Y4Ispb70P2DAKVjmlxe5j+eoOj8=
X-Google-Smtp-Source: AGHT+IGG5VxxpQoWg49yW/rqgVqN2yXJjSUyhG7qsVpJTQ/jK8et0isChmzVXu5ZV31dSSWRaz6UepPUJA36OQrgbSP+nM/e2YQG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9511:b0:485:6475:6c4a with SMTP id
 lb17-20020a056638951100b0048564756c4amr192951jab.2.1713872298408; Tue, 23 Apr
 2024 04:38:18 -0700 (PDT)
Date: Tue, 23 Apr 2024 04:38:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000898d010616c1fd03@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in __fput (2)
From: syzbot <syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12b508d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d4cb6b4409edfd18646
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1357d230980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10923dfd180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4250d1d2a53f/disk-4d200843.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af264ac1a9b0/vmlinux-4d200843.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0e1e88877a5/bzImage-4d200843.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d4cb6b4409edfd18646@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 5113 Comm: syz-executor107 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:fsnotify_parent include/linux/fsnotify.h:68 [inline]
RIP: 0010:fsnotify_file include/linux/fsnotify.h:106 [inline]
RIP: 0010:fsnotify_close include/linux/fsnotify.h:387 [inline]
RIP: 0010:__fput+0x59e/0xb80 fs/file_table.c:408
Code: ea 03 80 3c 02 00 0f 85 88 05 00 00 49 8b 47 68 48 8d 78 28 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 35 05 00 00 48 8b 44 24 10 be 08 00 00 00 48 8b
RSP: 0018:ffffc90003197da8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88801fa16f00 RCX: ffffffff81f974e8
RDX: 0000000000000005 RSI: ffffffff81f978bf RDI: 0000000000000028
RBP: ffff88801fa16f50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000080007
R13: 0000000000000008 R14: ffff888078a81e60 R15: ffff88807de245e0
FS:  00007fd582e0b6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 00000000774ac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 ptrace_notify+0x10e/0x130 kernel/signal.c:2404
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work kernel/entry/common.c:173 [inline]
 syscall_exit_to_user_mode_prepare+0x126/0x260 kernel/entry/common.c:200
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x11/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd582e504e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd582e0b218 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: 0000000000000001 RBX: 00007fd582eda348 RCX: 00007fd582e504e9
RDX: 0000000000000002 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007fd582eda340 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000000fa R11: 0000000000000246 R12: 00007fd582ea717c
R13: 00007fd582ea7068 R14: 00667562616d6475 R15: 6d64752f7665642f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fsnotify_parent include/linux/fsnotify.h:68 [inline]
RIP: 0010:fsnotify_file include/linux/fsnotify.h:106 [inline]
RIP: 0010:fsnotify_close include/linux/fsnotify.h:387 [inline]
RIP: 0010:__fput+0x59e/0xb80 fs/file_table.c:408
Code: ea 03 80 3c 02 00 0f 85 88 05 00 00 49 8b 47 68 48 8d 78 28 48 89 44 24 10 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 35 05 00 00 48 8b 44 24 10 be 08 00 00 00 48 8b
RSP: 0018:ffffc90003197da8 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff88801fa16f00 RCX: ffffffff81f974e8
RDX: 0000000000000005 RSI: ffffffff81f978bf RDI: 0000000000000028
RBP: ffff88801fa16f50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000080007
R13: 0000000000000008 R14: ffff888078a81e60 R15: ffff88807de245e0
FS:  00007fd582e0b6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd582e8c190 CR3: 00000000774ac000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 88 05 00 00 49    	test   %ecx,0x49000005(%rax)
   c:	8b 47 68             	mov    0x68(%rdi),%eax
   f:	48 8d 78 28          	lea    0x28(%rax),%rdi
  13:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 35 05 00 00    	jne    0x568
  33:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  38:	be 08 00 00 00       	mov    $0x8,%esi
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

