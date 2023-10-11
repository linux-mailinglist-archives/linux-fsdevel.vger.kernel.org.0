Return-Path: <linux-fsdevel+bounces-55-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CC97C5270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A973C1C20DB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C01EA7A;
	Wed, 11 Oct 2023 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9691097B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 11:48:54 +0000 (UTC)
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79864CA
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:48:50 -0700 (PDT)
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-6c4afe695a7so9348732a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 04:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024930; x=1697629730;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvPO+gogj2TMD3QRmWPHiBIeaehacfqKQiwt3SM/RLA=;
        b=O/lEJTkncnNJDFnzCjsY4Su8SvFYh34K2X2KUI6YWH3jhuAScsZ9CbRo/4m2awW49S
         EaB4etEeNINa2QTaoWHXg5VtNh0cUKvJuJRJTKD3zqQz/RQ5DeVQA/bmqQ40Bdz3rVN4
         CDrNP1Izm0sNTVHJgd5b0sswi2FZX9C2aQUoUsjSk7cihzRfyxelBb4IHJ2uThpf/ZHW
         wQBYErI0DHUlHZLvJrtMZ6CdolzPjEZbR/anveckIG3gzwglcDd+F2xWajI5WDMaGMuI
         NZ5y13ah78s0FcWaXSkH9MwWt2yqNtNxjEfiFfSKiDQ6gQnvjzwHXZnbrUyGQb5j0t5p
         i6WQ==
X-Gm-Message-State: AOJu0Yy7uVd3TG8W+KWLsW8nHtWTWmhnd2V5B2hTcP4Wf/i17PaxaPVy
	ruoAo0YxVOW/oq7aefBLBuzVWvi4lx2Qr7TZRJRlvk1TlQL90J9msQ==
X-Google-Smtp-Source: AGHT+IEhpG/z3De/SR73x/Sern95ULB4+POFxC41sig7+OOBFbrqeEVEgjwVKIKp6TWOD9FLk44cHY2qGHH6ctQGcjtI0weTvKO0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:67cb:0:b0:6ab:8d3:5209 with SMTP id
 c11-20020a9d67cb000000b006ab08d35209mr6579019otn.5.1697024929803; Wed, 11 Oct
 2023 04:48:49 -0700 (PDT)
Date: Wed, 11 Oct 2023 04:48:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001db56d06076f6861@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_rename_cat
From: syzbot <syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    82714078aee4 Merge tag 'pm-6.6-rc5' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=151aa759680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a5682d32a74b423
dashboard link: https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13095252680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123ba911680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d1f78c1d4d78/disk-82714078.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2a379fc35bb/vmlinux-82714078.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e52238a1bd60/bzImage-82714078.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/286844f77c11/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b3eaee680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17b3eaee680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b3eaee680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com

         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 PID: 5030 Comm: syz-executor114 Not tainted 6.6.0-rc4-syzkaller-00229-g82714078aee4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:hfsplus_rename_cat+0x4b3/0x1050 fs/hfsplus/catalog.c:480
Code: 60 42 80 3c 20 00 48 8b 5c 24 20 74 05 e8 05 38 81 ff 48 8b 94 24 20 01 00 00 48 83 c3 40 48 89 d8 48 c1 e8 03 48 89 44 24 68 <42> 80 3c 20 00 48 89 54 24 08 74 0d 48 89 df e8 d9 37 81 ff 48 8b
RSP: 0018:ffffc90003a6f780 EFLAGS: 00010202
RAX: 0000000000000008 RBX: 0000000000000040 RCX: ffff8880203e1dc0
RDX: ffff88801fb6f000 RSI: 0000000000000000 RDI: ffffc90003a6f8a0
RBP: ffffc90003a6fbf0 R08: ffffffff8267c274 R09: ad0047e119000000
R10: ad0047e119000000 R11: ad0047e1ad0047e1 R12: dffffc0000000000
R13: ffffc90003a6f86c R14: ffffc90003a6f900 R15: 1ffff9200074df04
FS:  0000555556d88380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd58aeb000 CR3: 0000000027125000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hfsplus_unlink+0x308/0x790 fs/hfsplus/dir.c:376
 vfs_unlink+0x35d/0x5f0 fs/namei.c:4332
 do_unlinkat+0x4a7/0x950 fs/namei.c:4398
 __do_sys_unlink fs/namei.c:4446 [inline]
 __se_sys_unlink fs/namei.c:4444 [inline]
 __x64_sys_unlink+0x49/0x50 fs/namei.c:4444
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9d18b02019
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd58aea948 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f9d18b4b082 RCX: 00007f9d18b02019
RDX: 00007f9d18b02019 RSI: 00007f9d18b012f7 RDI: 00000000200000c0
RBP: 00007f9d18b4b08c R08: 0000000020000000 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd58aea980
R13: 00007ffd58aeaba8 R14: 431bde82d7b634db R15: 00007f9d18b4b03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_rename_cat+0x4b3/0x1050 fs/hfsplus/catalog.c:480
Code: 60 42 80 3c 20 00 48 8b 5c 24 20 74 05 e8 05 38 81 ff 48 8b 94 24 20 01 00 00 48 83 c3 40 48 89 d8 48 c1 e8 03 48 89 44 24 68 <42> 80 3c 20 00 48 89 54 24 08 74 0d 48 89 df e8 d9 37 81 ff 48 8b
RSP: 0018:ffffc90003a6f780 EFLAGS: 00010202
RAX: 0000000000000008 RBX: 0000000000000040 RCX: ffff8880203e1dc0
RDX: ffff88801fb6f000 RSI: 0000000000000000 RDI: ffffc90003a6f8a0
RBP: ffffc90003a6fbf0 R08: ffffffff8267c274 R09: ad0047e119000000
R10: ad0047e119000000 R11: ad0047e1ad0047e1 R12: dffffc0000000000
R13: ffffc90003a6f86c R14: ffffc90003a6f900 R15: 1ffff9200074df04
FS:  0000555556d88380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd58aeb000 CR3: 0000000027125000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   5:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
   a:	74 05                	je     0x11
   c:	e8 05 38 81 ff       	call   0xff813816
  11:	48 8b 94 24 20 01 00 	mov    0x120(%rsp),%rdx
  18:	00
  19:	48 83 c3 40          	add    $0x40,%rbx
  1d:	48 89 d8             	mov    %rbx,%rax
  20:	48 c1 e8 03          	shr    $0x3,%rax
  24:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
* 29:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2e:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  33:	74 0d                	je     0x42
  35:	48 89 df             	mov    %rbx,%rdi
  38:	e8 d9 37 81 ff       	call   0xff813816
  3d:	48                   	rex.W
  3e:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

