Return-Path: <linux-fsdevel+bounces-62673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392EB9C523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F51BC1BE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042E28640B;
	Wed, 24 Sep 2025 22:04:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3D189
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758751471; cv=none; b=iuILcqF1ipZoTWMJMlDNMB6PKz+UvqGaFl2nTU7PVFkjjJ38LfeOkVnqPAnEwbp3GhqkDslMcf+DZifHlpEJJNgkiGq9jhdPC2RxEtIRLiBG53cKcQ217PXSQp7koRFcw9Ntojy3eRE8uAYnOeZtfoZlimH7TbUaj8eCnGoaq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758751471; c=relaxed/simple;
	bh=dLP9/BLbWygvPDr7dc3tU/C4dbsJ+f4ymVXjQ8ZrprI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CJRcJqp472mhW4vHpzmeSKS68NDWHxFmGkidAk1HIgHZTI1ts5Xz+O9cFm+ItUqBzwxhhSFh/kf2XzsidcZ6a6qcvsoU6UwsyKNSy350PVKSpvU2CR704MEjrRDlj3tH7bT9/DZKItK9WoplovuqFdClrcsELO70RiH6saKd9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-88de776aab6so100746739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 15:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758751469; x=1759356269;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bh14WtxqlTErTmUGgCQZcxARLQRm29m4vAX3yMUVATU=;
        b=tfezPNXaiQUtlKthkK3uQW+Ue+ixvpwsOwEBlZlAYjDu5UtrpiQgjrEZP6CQViMLKr
         rmSMEc8TALGh12xzt4zOSWEsogjrrjM4pdIfXnVCEZj9tBBbHd310br3XcicEcmHw4MG
         oyoo+wtVX7LhiYzx5k6GBOTTG0nAuke1WjreLiKLSqgb4EI+Woc8tPb4ur1pOVy03zXA
         gABSE4GYlWeycw65teLoWAtTxEPJZq+7L9tGrr50P4LjgQVD+Y7DP3+gOljYiXqKUsmN
         FF0/NXbuCwCD35tS1OHLu5rsO2Z/IaFct3phmNJoN/WoROWczFPY/6XniHSQOakM7nx6
         +A6w==
X-Forwarded-Encrypted: i=1; AJvYcCWOku3YnUHAszwVUEV/eqVDrj1ghMxvEpOvTxUMpYWwkxDRnvil7DfNLASeFVwbtPng3BJTJeT0TOSfzKSO@vger.kernel.org
X-Gm-Message-State: AOJu0YzElAaqFNHQoffZfz9UoHP3aY01R0t3b+E8jBhGL2ZcUbuZc31C
	sOc2Eu7b/6MmXVoGV8lfhLjBF6uKzLj3k3HPBZFc3ngJFfKLKTQTOd1NsbFMFDU+6jDR+MTfpn9
	8qvXU0DwrjwcVmX4Y4/0WLmA7CDuY7Ztm36OuAvwQuAUnGiIuaM1BC7I0syk=
X-Google-Smtp-Source: AGHT+IHXzvfczUFbplfuCpp3ozMDxIpmGxW9rPrjNkI2aAgj287IAE0CEHYAz3EvPabmkMNxoWtGzvOo2bvx8L3PuY0jsESbF+RN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8a:b0:423:2666:4687 with SMTP id
 e9e14a558f8ab-425c36bb2cdmr5906755ab.15.1758751469114; Wed, 24 Sep 2025
 15:04:29 -0700 (PDT)
Date: Wed, 24 Sep 2025 15:04:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d46aed.050a0220.57ae1.0002.GAE@google.com>
Subject: [syzbot] [exfat?] general protection fault in exfat_utf16_to_nls
From: syzbot <syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b5a4da2c459f Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ffad34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc64d939cce41d2
dashboard link: https://syzkaller.appspot.com/bug?extid=3e9cb93e3c5f90d28e19
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1704cf12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c8d4e2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/127c931e6696/disk-b5a4da2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf4957abd39e/vmlinux-b5a4da2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/860d3ac61bac/bzImage-b5a4da2c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9006b1673f9f/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11c8d4e2580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e9cb93e3c5f90d28e19@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 5979 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:exfat_convert_ucs2_to_char fs/exfat/nls.c:441 [inline]
RIP: 0010:__exfat_utf16_to_nls fs/exfat/nls.c:554 [inline]
RIP: 0010:exfat_utf16_to_nls+0x21c/0x840 fs/exfat/nls.c:638
Code: 2e 29 ff 66 41 83 fc 7f 77 14 e8 7f 2a 29 ff e9 b6 00 00 00 e8 75 2a 29 ff e9 a9 00 00 00 48 8b 4c 24 40 48 89 c8 48 c1 e8 03 <42> 80 3c 38 00 74 0f 48 8b 7c 24 40 e8 d3 6b 8e ff 48 8b 4c 24 40
RSP: 0018:ffffc90003fef760 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000004 RCX: 0000000000000010
RDX: ffff88802f18bc80 RSI: 00000000000000e1 RDI: 0000000000000080
RBP: ffffc90003fef850 R08: 0000000000000005 R09: 0000000000000000
R10: ffffc90003fef7e0 R11: fffff520007fdefc R12: 00000000000000e1
R13: ffffc90003fefa48 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557b9c2500(0000) GS:ffff888125b03000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557b9e5608 CR3: 00000000734c8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 exfat_readdir fs/exfat/dir.c:143 [inline]
 exfat_iterate+0x19a7/0x2050 fs/exfat/dir.c:243
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:65
 iterate_dir+0x399/0x570 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0xe4/0x260 fs/readdir.c:396
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c837c1833
Code: c1 66 0f 1f 44 00 00 48 83 c4 08 48 89 ef 5b 5d e9 32 3d f8 ff 66 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 a8 ff ff ff f7 d8
RSP: 002b:00007ffc8cf73ff8 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000055557b9dd600 RCX: 00007f2c837c1833
RDX: 0000000000008000 RSI: 000055557b9dd600 RDI: 0000000000000005
RBP: 000055557b9dd5d4 R08: 0000000000028a41 R09: 0000000000000000
R10: 00007f2c839b7cc0 R11: 0000000000000293 R12: ffffffffffffffa8
R13: 0000000000000010 R14: 000055557b9dd5d0 R15: 00007ffc8cf762b0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_convert_ucs2_to_char fs/exfat/nls.c:441 [inline]
RIP: 0010:__exfat_utf16_to_nls fs/exfat/nls.c:554 [inline]
RIP: 0010:exfat_utf16_to_nls+0x21c/0x840 fs/exfat/nls.c:638
Code: 2e 29 ff 66 41 83 fc 7f 77 14 e8 7f 2a 29 ff e9 b6 00 00 00 e8 75 2a 29 ff e9 a9 00 00 00 48 8b 4c 24 40 48 89 c8 48 c1 e8 03 <42> 80 3c 38 00 74 0f 48 8b 7c 24 40 e8 d3 6b 8e ff 48 8b 4c 24 40
RSP: 0018:ffffc90003fef760 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000004 RCX: 0000000000000010
RDX: ffff88802f18bc80 RSI: 00000000000000e1 RDI: 0000000000000080
RBP: ffffc90003fef850 R08: 0000000000000005 R09: 0000000000000000
R10: ffffc90003fef7e0 R11: fffff520007fdefc R12: 00000000000000e1
R13: ffffc90003fefa48 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055557b9c2500(0000) GS:ffff888125a03000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c000692800 CR3: 00000000734c8000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	2e 29 ff             	cs sub %edi,%edi
   3:	66 41 83 fc 7f       	cmp    $0x7f,%r12w
   8:	77 14                	ja     0x1e
   a:	e8 7f 2a 29 ff       	call   0xff292a8e
   f:	e9 b6 00 00 00       	jmp    0xca
  14:	e8 75 2a 29 ff       	call   0xff292a8e
  19:	e9 a9 00 00 00       	jmp    0xc7
  1e:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
  23:	48 89 c8             	mov    %rcx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 0f                	je     0x40
  31:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
  36:	e8 d3 6b 8e ff       	call   0xff8e6c0e
  3b:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx


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

