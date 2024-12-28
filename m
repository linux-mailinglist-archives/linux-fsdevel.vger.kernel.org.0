Return-Path: <linux-fsdevel+bounces-38202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC69FDBBD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F53B3A1437
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 17:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8671946DA;
	Sat, 28 Dec 2024 17:10:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99F1917E4
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735405825; cv=none; b=PryKTDBAWLo5KGdCKV+b2ZcW73M3hTonEK2RYwO5g0AHOgiyzLFLxmJXQIZJK+jXdeCJ4PRazVotLOp6XEqkY7N9LdWBtunxpayG6CDyoxtt900Z6wARpGqn9oft7X2/Q1iLn6ZvFo7XEey86contHLQ9q01F99N+JQ8uo/cZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735405825; c=relaxed/simple;
	bh=xZh0K5AoWrKk+2nyL8+5t9boqfrlkhc4gOXTShSk8/k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XgZR6jI/ygGGF1AhwTqWQP7RCUicqWFeSwiIhQSAYI5qQMhP/dZF4TVO3uoQkSv9esKYCfcYHYEkWqwXZeYC5nhjQEpiQH5NDtnUXB0du4i1ho/YASBUDOCBBKfYcZQ+Gvkc3/ara0GrmcqCfzEIDvWXa8bkywt3ykRL/EzoCUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so77479065ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2024 09:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735405823; x=1736010623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CODmsC4LZsdpSiW+E8OKW5kDjjIqL2wYdRrUqr1lNS8=;
        b=WKDSDWZnVl611K1pp6vYOQKX+an4iPMhYSpKOh1HALgQEHVTi0x+cHui85YcZ1Y6tw
         NQsW+v9l8EfMKpNxN7I/0SlfaDGssVN70mfU//NjRoLeNo9o6Zbu1dTSTbO2xJgcVNFj
         6QgaNDcCjr3obqzjriyvp+7RUt6lQuq53mGmH9FlzOLr3D2p2PfkRFEWVbjzWrGB1qFr
         W20J5URb9rf67lCnCTlU2El8ivnFVmoZgP7E8cjm5JTX+eYiIsxN2WpjFsOB3vZIdDUQ
         tMgnk52LGS2K7FEpOiL5SLCoBmfOW+pyFEg2GVVTZdVY+R/dGGEGIt4rsw31OaKcxBEy
         mERw==
X-Forwarded-Encrypted: i=1; AJvYcCXFmM1hLUQEm70h9XHrfzRvpXqhIHhJfd6LO3zvE8qolWRyC8MjLPfiCRFH5Inr7ijyLBRENoBn9Sz3LlJ0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiy2CeqT0dJGiFdw6AqN6/XbU2CaEtHNxf7IXnGbIhqbfIPg2x
	GXz0ncF+MxpDRU59/bfuZYHl+FMLDrU9uSEp9F1wbaeOHDGf+yHHTDAaAaw9x4vKnyiNNwJ8ST6
	gHbtsn9DLDV2mACnZX7zJIBfVdkSEEyX5Kys5ATpQ19N/DaLGp4xyP7E=
X-Google-Smtp-Source: AGHT+IFpl0r+R7wut9k1MreS/2Yiih5CiUGFH5GutuTjiDtlJjqxeSzUMGhzCJxlvjVJ70UhAtpAFQ27D4JSY3l7C7dv1bV3HzIu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:3a7:6e59:33ad with SMTP id
 e9e14a558f8ab-3c2d4e6c573mr205087085ab.17.1735405823311; Sat, 28 Dec 2024
 09:10:23 -0800 (PST)
Date: Sat, 28 Dec 2024 09:10:23 -0800
In-Reply-To: <676a3d1b.050a0220.2f3838.014f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677030ff.050a0220.2f3838.0499.GAE@google.com>
Subject: Re: [syzbot] [jfs?] [nilfs?] WARNING in mnt_ns_release
From: syzbot <syzbot+5b9d613904b2f185f2fe@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=175106df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=5b9d613904b2f185f2fe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc4af8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11dc4af8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b9d613904b2f185f2fe@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 18491 at fs/namespace.c:163 mnt_ns_release+0x15d/0x1c0 fs/namespace.c:163
Modules linked in:
CPU: 1 UID: 0 PID: 18491 Comm: syz-executor346 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:mnt_ns_release+0x15d/0x1c0 fs/namespace.c:163
Code: 15 bf 01 00 00 00 89 ee e8 d0 e8 7d ff 85 ed 7e 39 e8 87 e4 7d ff 4c 89 ff 5b 41 5e 41 5f 5d e9 39 be d8 ff e8 74 e4 7d ff 90 <0f> 0b 90 e9 12 ff ff ff e8 66 e4 7d ff 48 89 df be 03 00 00 00 5b
RSP: 0018:ffffc90000a18bb8 EFLAGS: 00010246
RAX: ffffffff82413fac RBX: 0000000000000001 RCX: ffff888022f98000
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90000a18e10 R08: ffffffff82413eb2 R09: 1ffffffff285af0b
R10: dffffc0000000000 R11: ffffffff82424530 R12: ffffffff81a6a6d7
R13: ffff88807a8b4e58 R14: dffffc0000000000 R15: ffff88807a8b4e00
FS:  000055556221c380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff70e84301d CR3: 0000000032e1a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 0a 13 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc90004c3fac0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000987f64 RCX: ffff888022f98ae0
RDX: dffffc0000000000 RSI: ffffffff8c0aaba0 RDI: ffffffff8c5fed00
RBP: ffffc90004c3fc10 R08: ffffffff942d7857 R09: 1ffffffff285af0a
R10: dffffc0000000000 R11: fffffbfff285af0b R12: 1ffff92000987f60
R13: dffffc0000000000 R14: ffffc90004c3fb20 R15: 0000000000000246
 do_write_seqcount_begin_nested include/linux/seqlock.h:476 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:502 [inline]
 write_seqlock include/linux/seqlock.h:876 [inline]
 mnt_ns_tree_write_lock fs/namespace.c:133 [inline]
 mnt_ns_tree_add+0x52/0x340 fs/namespace.c:145
 copy_mnt_ns+0x857/0x960 fs/namespace.c:4044
 create_new_namespaces+0xd3/0x7b0 kernel/nsproxy.c:78
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x57d/0xa70 kernel/fork.c:3331
 __do_sys_unshare kernel/fork.c:3402 [inline]
 __se_sys_unshare kernel/fork.c:3400 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3400
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff70e7faaa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec6e71348 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff70e7faaa9
RDX: 00007ff70e7f9ce0 RSI: 0000000000000012 RDI: 000000002c060000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000001975b
R13: 00007ffec6e7135c R14: 00007ffec6e71370 R15: 00007ffec6e71360
 </TASK>
----------------
Code disassembly (best guess):
   0:	2b 00                	sub    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 0a 13 8b 00       	call   0x8b1316
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 85 01 00 00    	jne    0x19c
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 44 25 00 00 00 	movq   $0x0,0x0(%r13,%r12,1) <-- trapping instruction
  31:	00 00
  33:	43 c7 44 25 09 00 00 	movl   $0x0,0x9(%r13,%r12,1)
  3a:	00 00
  3c:	43                   	rex.XB
  3d:	c7                   	.byte 0xc7
  3e:	44                   	rex.R
  3f:	25                   	.byte 0x25


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

