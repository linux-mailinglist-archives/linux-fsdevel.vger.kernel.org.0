Return-Path: <linux-fsdevel+bounces-36766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FAD9E921F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC776280CE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 11:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A921A943;
	Mon,  9 Dec 2024 11:26:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828921A93A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743589; cv=none; b=eVDGtGPesZrRrDjlaVsDlSZunA+lb8lEaH5qmzKpUi+LbA7X9Q6di0jNDkYBY/Mr0TN5CAcww//7LcbbpjptbJTprCCZbBctouReFRnVpJchroDPeEnZXGl+UOQODlVC2mecKFrRr18fI++QROW8V1Dg9O1yphOvR+xjp+ZdL8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743589; c=relaxed/simple;
	bh=/TXYt/JSVpvKcKJZQh9UGQYFi/v8I1iqiR++f4oZ78c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aCQtbhAMV4Ryx1jjnlFg7zAfP8w+2I2kkGMyyq1xqiQ5DNxy6NP7a1hPHSQa+7QdiXFHUVEA5GZ1STIMtZO7G+tNkGNcbaG677qV3YmsbokbWTiiCsuusw67i/0CPwRvf5wGLhDxfIAFNNpzXG18S02T5F7Iyol3OFkjSnawxU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so24052195ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 03:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743587; x=1734348387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8n91O6zTrZE9K8rkaFaaKhWrRhPVCdSytUqfDyk7UA=;
        b=UV8fB1QTLLOM7v641RUuo//9/WwmsMxaB0pTPmnpVcTpMlb7Zit6qIJ3cRD4hjzDCU
         Oa4KHl9czkth96jNaVngLq3IDMWkW2pK/Xf1+WJZXg3TF3S5gYKv58VRL1wQimi835um
         G1WKn8cgtlY8Uu36cz8io1265oLZQgZEv9GbDHLWveLq5ju7RoxNZulDM72WduW8g3Dm
         GO+u0bhqwmULqitmEZx3CCUkaPGGd8+CHQah/IWpVe0RrO/X/TPR33tzONx2SGtvaM+F
         dpmOWwbqqBzaA4LtbAore0INJbddbDzsxUxT89JvIAuHX2LcT9UoT6igkDGjjD36fH/V
         zVuA==
X-Forwarded-Encrypted: i=1; AJvYcCWehw6uRaKab4qvlh2ZGg8f13PMYfd6uqpQqg805kdBTQFntDGB0EtcZkVMumP1+p3pY5eUggeRvGqPW0Th@vger.kernel.org
X-Gm-Message-State: AOJu0YwOAn7phumOpzAl35ZxPg0/7tSJE0VhejDCA6rYH4E1V0x2ipCe
	jd65B5BjO+eLP1nsx0ILngy8n6Rf5eaSMPpjW8XLxr8IF9Qk1Hw8WKlik7dvJxuLBj12mK+2moV
	UAdL2ZD334NvItmf3PJXfF9DpugET5HNiwDaiDeOtfNpWZsLZYHVIbNc=
X-Google-Smtp-Source: AGHT+IGsj1R+31SpApdsRX1q5hzIVUTnr7Mow2hTGAEj2UZzKWYRHGYRxrU+y/GPEfaIlgyIrvkKbY2DaGUOLIZ2NkfyODWinTN1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a7:a29b:c181 with SMTP id
 e9e14a558f8ab-3a9dbac647amr780545ab.13.1733743586864; Mon, 09 Dec 2024
 03:26:26 -0800 (PST)
Date: Mon, 09 Dec 2024 03:26:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d3e2.050a0220.a30f1.019d.GAE@google.com>
Subject: [syzbot] [exfat?] general protection fault in exfat_init_dir_entry
From: syzbot <syzbot+ff3c3b48f27747505446@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62b5a46999c7 Merge tag '6.13-rc1-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17679944580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=ff3c3b48f27747505446
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-62b5a469.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2545deb88ab1/vmlinux-62b5a469.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7af07c0abbf0/bzImage-62b5a469.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff3c3b48f27747505446@syzkaller.appspotmail.com

syz.0.0: attempt to access beyond end of device
loop0: rw=0, sector=161, nr_sectors = 1 limit=134
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 5331 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00378-g62b5a46999c7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:exfat_get_dentry_cached fs/exfat/dir.c:727 [inline]
RIP: 0010:exfat_init_dir_entry+0x556/0x9c0 fs/exfat/dir.c:460
Code: 48 98 49 8d 1c c7 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 d8 66 89 ff 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 bb 66 89 ff 4c 8b 3b 42 80 7c 2d
RSP: 0018:ffffc9000d4472f8 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 0000000000000009
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000020
RBP: 1ffff92001a88edc R08: ffffffff8280f817 R09: 0000000000000000
R10: ffffc9000d447240 R11: fffff52001a88e4d R12: 0000000000000200
R13: dffffc0000000000 R14: ffff88801ab22000 R15: ffffc9000d4476f0
FS:  00007fa72178f6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf81a2818 CR3: 0000000034a2e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 exfat_add_entry+0x516/0xaa0 fs/exfat/namei.c:516
 exfat_create+0x1c7/0x570 fs/exfat/namei.c:565
 lookup_open fs/namei.c:3649 [inline]
 open_last_lookups fs/namei.c:3748 [inline]
 path_openat+0x1c03/0x3590 fs/namei.c:3984
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_openat fs/open.c:1433 [inline]
 __se_sys_openat fs/open.c:1428 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa72097fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa72178f058 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fa720b45fa0 RCX: 00007fa72097fed9
RDX: 0000000000141842 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007fa7209f3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa720b45fa0 R15: 00007ffea8996448
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:exfat_get_dentry_cached fs/exfat/dir.c:727 [inline]
RIP: 0010:exfat_init_dir_entry+0x556/0x9c0 fs/exfat/dir.c:460
Code: 48 98 49 8d 1c c7 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 d8 66 89 ff 48 8b 1b 48 83 c3 28 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 bb 66 89 ff 4c 8b 3b 42 80 7c 2d
RSP: 0018:ffffc9000d4472f8 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: 0000000000000009
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000020
RBP: 1ffff92001a88edc R08: ffffffff8280f817 R09: 0000000000000000
R10: ffffc9000d447240 R11: fffff52001a88e4d R12: 0000000000000200
R13: dffffc0000000000 R14: ffff88801ab22000 R15: ffffc9000d4476f0
FS:  00007fa72178f6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffea8995c80 CR3: 0000000034a2e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 98                	cltq
   2:	49 8d 1c c7          	lea    (%r15,%rax,8),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 d8 66 89 ff       	call   0xff8966f4
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 28          	add    $0x28,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 bb 66 89 ff       	call   0xff8966f4
  39:	4c 8b 3b             	mov    (%rbx),%r15
  3c:	42                   	rex.X
  3d:	80                   	.byte 0x80
  3e:	7c 2d                	jl     0x6d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

