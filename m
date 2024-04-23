Return-Path: <linux-fsdevel+bounces-17487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B638AE231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EA51F25CE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4295762E8;
	Tue, 23 Apr 2024 10:29:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18566BFBD
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 10:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868159; cv=none; b=hJgSqmJ9Dg90pXqFOoAZg42QfUTFcXeBFozGpRv9vjMu1GaaOu1bYGAwW9IokbdRQjxZZ2NufyKZk1Ch2Ba1v6XL1jHDgRX/K4pVA08WOiKZREdlK/pr3jcbZ7v2+CPrVvfRRoSDl8GHCTGrRTDlC+tNFpVg+Pw5LyHyKkKQ0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868159; c=relaxed/simple;
	bh=L3jiFzGv8CW/eYS7xwVo1H6Pdw7XVhKlu6ATDYfvFHM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rCeDyT4UzZyQLRtljZ+xnNtzbx2a98bOEaDJJEUeA6svPVemyZpph0AzGX0FIxWxijNDdgkwqmVJoNBEKXkTUgI3gccxS1ZL2f+uVbfaEuVw4M9QfM8xoe5XYlVntyYazE08xXLfNoZLMvuK9rxelFpEzE50DNFMZ+p36+pkMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d6c32ef13bso477520539f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 03:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868157; x=1714472957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpzC/7Vv5H5tnWt0QaflGZ5O9cDinxvMiEDIKfsweow=;
        b=gAyCfNMP5Y0LLpAuBTt12v0LlOz/L2VeOvYPbF194FjlG/jGQmzpj6em1iP7AWnYp3
         VPT8CxaNehZZh87GsipY3afxKpMKgF50J3sHDm9r1ja6WdnedB3Jwn8PzjwuM0xOyrGi
         sh/c0jmKbj0RPVA6CMX6A1rKbAwW1fPogQC1eDwXg6XtNA5H+0u/0E3rMErJhH9CMG2l
         sntyOsBE7oP04kWysknMpr70RQrKwFyTfUFUiLZEneTUwPVghNZHNb6/b9HKagElgvn3
         IR80esH96RfX+QsbW4XhF3fw/owbDKR8kQ6Crbedl5AhWliF3tVvFznaRLYxJKqqet5E
         iWpw==
X-Forwarded-Encrypted: i=1; AJvYcCVHiclnRiukW0XZ96pnQj9HkmuUSZlvLGRn3cCzXP6UUo4IHP1EFwWdaNZcUxCD6HAGzo622fSDsapWM/+hO6t7RqdUysYi1Sy980kgNQ==
X-Gm-Message-State: AOJu0YwN164ETYqMrdpH2r805UNdme6qDR9NTXt8hVDiFM2e+hcnnRYN
	l5YYk7I4VGTEvtzn3gytTDh6NNOiCIR2h3Tyv5fK36ZKVxiJmnkrG4G4+Cj/P8LXvI3WHXEx9SC
	oNxGlfiWOkaRS3+xEaiNAQYGrtdkXl5UHT0798qRnTnBtOnz6PAggXqk=
X-Google-Smtp-Source: AGHT+IGxpKmZp8/LE/B9qS5v2Hj1V6sVtP3QKtPOLa0/SF+qYuIFfhBVnzlf4gU4xmUz+pvIT4j33qTKscqs8jg7joZd9JqkstEF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b10:b0:7da:bccd:c3e3 with SMTP id
 p16-20020a0566022b1000b007dabccdc3e3mr223099iov.1.1713868157132; Tue, 23 Apr
 2024 03:29:17 -0700 (PDT)
Date: Tue, 23 Apr 2024 03:29:17 -0700
In-Reply-To: <000000000000f40f0c0615506b93@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2aefe0616c1063c@google.com>
Subject: Re: [syzbot] [netfs?] divide error in netfs_submit_writethrough
From: syzbot <syzbot+f3a09670f3d2a55b89b2@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, samsun1006219@gmail.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@protonmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a2c63a3f3d68 Merge tag 'bcachefs-2024-04-22' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11623dfd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=f3a09670f3d2a55b89b2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ff809b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15aaab4f180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a2c63a3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b64cb6a17a78/vmlinux-a2c63a3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8984e0f657fd/bzImage-a2c63a3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3a09670f3d2a55b89b2@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 3 PID: 5183 Comm: syz-executor293 Not tainted 6.9.0-rc5-syzkaller-00025-ga2c63a3f3d68 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:netfs_submit_writethrough+0x201/0x280 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 0f af e9 e9 1d ff ff ff e8 9b a3 b8 ff eb df
RSP: 0018:ffffc90003477760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff88802d072c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82304719 RDI: ffff88802d072d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880324e05e0 R14: ffff88802d072d20 R15: 0000000000000000
FS:  0000555585aef480(0000) GS:ffff88806b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc516dc998 CR3: 0000000029bf4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 netfs_advance_writethrough+0x13f/0x170 fs/netfs/output.c:449
 netfs_perform_write+0x1b9f/0x26b0 fs/netfs/buffered_write.c:385
 netfs_buffered_write_iter_locked+0x213/0x2c0 fs/netfs/buffered_write.c:454
 netfs_file_write_iter+0x1e0/0x470 fs/netfs/buffered_write.c:493
 v9fs_file_write_iter+0xa1/0x100 fs/9p/vfs_file.c:407
 call_write_iter include/linux/fs.h:2110 [inline]
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_pwritev+0x1b2/0x260 fs/read_write.c:1072
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2 fs/read_write.c:1122 [inline]
 __x64_sys_pwritev2+0xef/0x160 fs/read_write.c:1122
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fecc4c95b59
Code: 48 83 c4 28 c3 e8 67 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff380e4b18 EFLAGS: 00000216 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fff380e4b30 RCX: 00007fecc4c95b59
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007fff380e4b38 R08: 0000000000000000 R09: 0000000000000015
R10: 0000000000000000 R11: 0000000000000216 R12: 0000000000000000
R13: 00007fff380e4d98 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netfs_submit_writethrough+0x201/0x280 fs/netfs/output.c:427
Code: fc ff df 48 89 fa 48 c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1a 8b 8b 0c 01 00 00 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 0f af e9 e9 1d ff ff ff e8 9b a3 b8 ff eb df
RSP: 0018:ffffc90003477760 EFLAGS: 00010246
RAX: 0000000000001000 RBX: ffff88802d072c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82304719 RDI: ffff88802d072d0c
RBP: 0000000000001000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8880324e05e0 R14: ffff88802d072d20 R15: 0000000000000000
FS:  0000555585aef480(0000) GS:ffff88806b500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc516dc998 CR3: 0000000029bf4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   c:	48 89 f8             	mov    %rdi,%rax
   f:	83 e0 07             	and    $0x7,%eax
  12:	83 c0 03             	add    $0x3,%eax
  15:	38 d0                	cmp    %dl,%al
  17:	7c 04                	jl     0x1d
  19:	84 d2                	test   %dl,%dl
  1b:	75 1a                	jne    0x37
  1d:	8b 8b 0c 01 00 00    	mov    0x10c(%rbx),%ecx
  23:	48 89 e8             	mov    %rbp,%rax
  26:	31 d2                	xor    %edx,%edx
* 28:	48 f7 f1             	div    %rcx <-- trapping instruction
  2b:	48 89 c5             	mov    %rax,%rbp
  2e:	48 0f af e9          	imul   %rcx,%rbp
  32:	e9 1d ff ff ff       	jmp    0xffffff54
  37:	e8 9b a3 b8 ff       	call   0xffb8a3d7
  3c:	eb df                	jmp    0x1d


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

