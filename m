Return-Path: <linux-fsdevel+bounces-36215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3089DF765
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 00:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3D162A6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD61D8E06;
	Sun,  1 Dec 2024 23:03:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205A13635C
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733094212; cv=none; b=b4E9lcJAHU8fpYsStpL8Z79m8ugCQ2a/wLJ5BAneXfMXstgLxTsTaKwGftR2SSMCdcAYo/HjCxwT7ifPuGBl1V50ubbwOTE4z/J0cfZ1jBsOiFwwxRDnpTOrskSi8WbsVhxBYjDoxXcq1hiE1gctZjds0ko+DzKXDhUGa/LDhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733094212; c=relaxed/simple;
	bh=kN3XJ+YVWB3V0ClvNdf6urdu9EM49Bphm3/PuaiIGlI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hm0RDbaBA75nPfuYkYek3YmtDgRhP1gMLNOWXOotqQJhbbbKusmXCHPCnVRPnS8hHZRBR4C8mwtVxK9RCUwlFd+5+gK8E+N9FZ/rReGl+R///6WYG/8Lu19zte4CJ/pLvab1k6IpctXx3NxlB7BOktQ5t9t8/3y1+yWO8NhiNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-84193bb7ed1so341124939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 15:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733094210; x=1733699010;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+3R5a1sE3BXqMiRu972WSrKfBX8E5WH/+BDgc03Tyhk=;
        b=A9BTdmiKI1ZJ8qoeUKhUzImi2sXrTmgYfvKnpSgBg4ZklZEd9DDAyt6nV1AVkQO/kG
         P3QfttNeu+WHI93W8UXxjLNhG7zfVXhTVzC+HwDxwZ4Yd95SzRI0PrkP+gsgjpH9wk6p
         ES/M7w3Fz6iC3DMUn6cIJYiT9KJMbNlIeTMKE85xyxr6Ysp5jYaVm/e1+3PcX3a9JiEK
         XhEI4KqX8VvoUA4kKh2KWkrWeOsIcktltOUg4F0irJclVLDcf1ALGnjpMCrM9wTvqG/M
         D+TZi7e65mt7L5w5lOlkR3Jpk2NybkPvSNU8Y/beugmBFNUIjNmzgfWIMJmSlg/PUfAl
         P9yA==
X-Forwarded-Encrypted: i=1; AJvYcCWzTCMA5bD4Wq4hyvKTl9yDYzLllet3uHv3yGdjAaDtrewc5hBj557DfVEG86DrRBSEvDfECFSCTv3CJRJ1@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFGs94MSqdkjqmO2Ci/zuN4d8g/8cQIAnKBtGz0r2+8+Wdbgd
	DFr2owSYYA8dLVsaC9iUuq8ekRp1rFZGjqYCKeILYWe+360UggHAdFxwRt4/2+YWrLst/jW/+bP
	HgF5LgOgVzknvVrTd5zNel9izOwPqMBXaz7+rfbGu9Px6SQDzLRZ9HOw=
X-Google-Smtp-Source: AGHT+IEXOUSRAc2bVsgYzsYZDpc7piCvXxGewwr3QfRbFthdHfZ7joMwbFjSQ9OUs6LBErKOhyFJ09LurCnOg++2l6xwSs+mzJTf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:3a7:c378:3bab with SMTP id
 e9e14a558f8ab-3a7c5445d3amr222449275ab.0.1733094209853; Sun, 01 Dec 2024
 15:03:29 -0800 (PST)
Date: Sun, 01 Dec 2024 15:03:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674ceb41.050a0220.48a03.0018.GAE@google.com>
Subject: [syzbot] [exfat?] general protection fault in exfat_init_ext_entry
From: syzbot <syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, daniel.palmer@sony.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	wataru.aoyama@sony.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1549f530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=6f6c9397e0078ef60bce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1443ef5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349f530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/792711885a74/mount_0.gz

The issue was bisected to:

commit 8a3f5711ad74db9881b289a6e34d7f3b700df720
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Thu Sep 12 08:57:06 2024 +0000

    exfat: reduce FAT chain traversal

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1145cf78580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1345cf78580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1545cf78580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f6c9397e0078ef60bce@syzkaller.appspotmail.com
Fixes: 8a3f5711ad74 ("exfat: reduce FAT chain traversal")

syz-executor166: attempt to access beyond end of device
loop3: rw=524288, sector=167, nr_sectors = 1 limit=64
syz-executor166: attempt to access beyond end of device
loop3: rw=0, sector=161, nr_sectors = 1 limit=64
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5890 Comm: syz-executor166 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:exfat_get_dentry_cached fs/exfat/dir.c:727 [inline]
RIP: 0010:exfat_init_ext_entry+0x3fd/0x990 fs/exfat/dir.c:498
Code: 48 98 49 8d 1c c6 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 01 26 89 ff 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 e4 25 89 ff 4c 8b 33 43 80 7c 3d
RSP: 0018:ffffc900041ff318 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 0000000000000009
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000020
RBP: 0000000000000200 R08: ffffffff8281406f R09: 0000000000000002
R10: ffff88805d092022 R11: ffffed100ba12407 R12: ffffc900041ff700
R13: 1ffff9200083fee0 R14: ffffc900041ff710 R15: dffffc0000000000
FS:  00007fb6d86536c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb6d8653d58 CR3: 000000002fc0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exfat_add_entry+0x529/0xaa0 fs/exfat/namei.c:517
 exfat_create+0x1c7/0x570 fs/exfat/namei.c:565
 lookup_open fs/namei.c:3649 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb6d86c4099
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb6d8653218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fb6d87534b8 RCX: 00007fb6d86c4099
RDX: 00007fb6d869bc26 RSI: 0000000000000000 RDI: 0000000020000e00
RBP: 00007fb6d87534b0 R08: 00007ffed34fd087 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb6d8718d84
R13: 00007fb6d8717880 R14: 0032656c69662f2e R15: 6f6f6c2f7665642f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_get_dentry_cached fs/exfat/dir.c:727 [inline]
RIP: 0010:exfat_init_ext_entry+0x3fd/0x990 fs/exfat/dir.c:498
Code: 48 98 49 8d 1c c6 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 01 26 89 ff 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 e4 25 89 ff 4c 8b 33 43 80 7c 3d
RSP: 0018:ffffc900041ff318 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 0000000000000009
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000020
RBP: 0000000000000200 R08: ffffffff8281406f R09: 0000000000000002
R10: ffff88805d092022 R11: ffffed100ba12407 R12: ffffc900041ff700
R13: 1ffff9200083fee0 R14: ffffc900041ff710 R15: dffffc0000000000
FS:  00007fb6d86536c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bc85806ca8 CR3: 000000002fc0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 98                	cltq
   2:	49 8d 1c c6          	lea    (%r14,%rax,8),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 01 26 89 ff       	call   0xff89261d
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 28          	add    $0x28,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 e4 25 89 ff       	call   0xff89261d
  39:	4c 8b 33             	mov    (%rbx),%r14
  3c:	43                   	rex.XB
  3d:	80                   	.byte 0x80
  3e:	7c 3d                	jl     0x7d


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

