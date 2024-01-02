Return-Path: <linux-fsdevel+bounces-7080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98365821A16
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DE61C21D96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDEEEADD;
	Tue,  2 Jan 2024 10:39:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC9EACB
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baec2c5f38so715127739f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jan 2024 02:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191963; x=1704796763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQ4pJPlxSR7eGp+w8N5DMR7Ntm+XldcehR4x424Ja1o=;
        b=OQU7F8t+7PyYsgTGuFfyuUl6yAmQaTAyNlZ51e2pXuXPNoW4BJQ1RTpEJvap3VD8nb
         fi2wnNhpc98qmnizQpAaPjRsOFjk2qZ6AcCJyyPT5d/MV6m0O7iXyYjaVfclJ75JIga9
         dqwAEPTrTZCz2u6h670zzRgo820OsO9fAdarKKSN9rMLv1yk2MMSWY8zQB+P0SMszuDf
         0LPY+bOOPgJ12rBhz3m5XNfSiqhiRvYZXmvUVdH0DO3btGhOY0JO/1V9jW1t5JKMbHlQ
         6HQivREUh9Pnwi7r0AY8AOQ/ewzsoBdburjvGrSfWdRGQGYJ74MSCwVZ3QDsxeojHdR1
         YLug==
X-Gm-Message-State: AOJu0Yx8GRPeHzMsm1SirrORYEosK1eypHs19iAus1Zo8MwfZhVv6wq3
	/O56IZmxEfzl8+fop1tZQJIrhHxCEEGt9vxQ5TdTmbZKCg0xXoA=
X-Google-Smtp-Source: AGHT+IEqqXpZ4VR1B82LUp72LjJMBcPpwlfnPcE9O+hg+slO6ah9n2qqeASy+wrdAuVa/fWPYjS1ue1zcwYaQxostL8f+2B1SHYn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:35f:eceb:fc42 with SMTP id
 j2-20020a056e02218200b0035fecebfc42mr2251682ila.3.1704191963513; Tue, 02 Jan
 2024 02:39:23 -0800 (PST)
Date: Tue, 02 Jan 2024 02:39:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d4b80060df41cf8@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in reiserfs_xattr_set
From: syzbot <syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=172207cee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=74dce9511a59ad67a492
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1534af31e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1512b9a1e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d4df4c41f20/disk-453f5db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e858c1c82b6d/vmlinux-453f5db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39c3d125719d/bzImage-453f5db0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/519b891d4149/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 0 PID: 6365 Comm: syz-executor145 Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:d_really_is_negative include/linux/dcache.h:467 [inline]
RIP: 0010:reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:79 [inline]
RIP: 0010:reiserfs_xattr_set+0x2d4/0x5c0 fs/reiserfs/xattr.c:626
Code: e9 03 80 3c 11 00 0f 85 e0 02 00 00 4d 8b a4 24 a0 05 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 7c 24 68 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 cc 02 00 00 49 83 7c 24 68 00 0f 84 eb 01 00 00
RSP: 0018:ffffc9000a22f8f0 EFLAGS: 00010212
RAX: 000000000000006c RBX: ffff88805d650190 RCX: 000000000000000d
RDX: dffffc0000000000 RSI: ffffffff822cd9af RDI: 0000000000000068
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: ffff88801c4e0000 R14: ffff88805d6501b8 R15: 0000000000000036
FS:  00007fd868e9f6c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd868e9fd58 CR3: 0000000079dbb000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 security_set+0x85/0xb0 fs/reiserfs/xattr_security.c:32
 __vfs_setxattr+0x173/0x1d0 fs/xattr.c:201
 __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:235
 __vfs_setxattr_locked+0x17e/0x250 fs/xattr.c:296
 vfs_setxattr+0x146/0x350 fs/xattr.c:322
 do_setxattr+0x142/0x170 fs/xattr.c:630
 setxattr+0x159/0x170 fs/xattr.c:653
 __do_sys_fsetxattr fs/xattr.c:709 [inline]
 __se_sys_fsetxattr fs/xattr.c:698 [inline]
 __x64_sys_fsetxattr+0x25e/0x310 fs/xattr.c:698
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd868f03e99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd868e9f228 EFLAGS: 00000246 ORIG_RAX: 00000000000000be
RAX: ffffffffffffffda RBX: 00007fd868f8c6d8 RCX: 00007fd868f03e99
RDX: 0000000020000400 RSI: 00000000200003c0 RDI: 0000000000000004
RBP: 00007fd868f8c6d0 R08: 0000000000000000 R09: 00007fd868e9f6c0
R10: 0000000000000002 R11: 0000000000000246 R12: 00007fd868f58073
R13: 00007fd868f5806b R14: 3404af7c435ebb98 R15: 00007ffd907624e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:d_really_is_negative include/linux/dcache.h:467 [inline]
RIP: 0010:reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:79 [inline]
RIP: 0010:reiserfs_xattr_set+0x2d4/0x5c0 fs/reiserfs/xattr.c:626
Code: e9 03 80 3c 11 00 0f 85 e0 02 00 00 4d 8b a4 24 a0 05 00 00 48 ba 00 00 00 00 00 fc ff df 49 8d 7c 24 68 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f 85 cc 02 00 00 49 83 7c 24 68 00 0f 84 eb 01 00 00
RSP: 0018:ffffc9000a22f8f0 EFLAGS: 00010212
RAX: 000000000000006c RBX: ffff88805d650190 RCX: 000000000000000d
RDX: dffffc0000000000 RSI: ffffffff822cd9af RDI: 0000000000000068
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000002 R12: 0000000000000000
R13: ffff88801c4e0000 R14: ffff88805d6501b8 R15: 0000000000000036
FS:  00007fd868e9f6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd860e9f000 CR3: 0000000079dbb000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
   4:	0f 85 e0 02 00 00    	jne    0x2ea
   a:	4d 8b a4 24 a0 05 00 	mov    0x5a0(%r12),%r12
  11:	00
  12:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  19:	fc ff df
  1c:	49 8d 7c 24 68       	lea    0x68(%r12),%rdi
  21:	48 89 f9             	mov    %rdi,%rcx
  24:	48 c1 e9 03          	shr    $0x3,%rcx
* 28:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1) <-- trapping instruction
  2c:	0f 85 cc 02 00 00    	jne    0x2fe
  32:	49 83 7c 24 68 00    	cmpq   $0x0,0x68(%r12)
  38:	0f 84 eb 01 00 00    	je     0x229


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

