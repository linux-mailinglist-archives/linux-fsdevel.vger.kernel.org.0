Return-Path: <linux-fsdevel+bounces-38090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E671C9FB959
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 05:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D3B163E63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 04:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CB1494D8;
	Tue, 24 Dec 2024 04:48:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C8219E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735015710; cv=none; b=Xv2LbgZImJEsTjKCu/+MDcyo43kD2j2wqf/uLL1MO95Mgugq8DKl97qeW03hD2Y4Mjd/NCq7TqQe72cX79cu8FdobDuWl7uChLAI95EAMnn+7IAgEq/Ukjhqfk5cpYrhuFgmejq3WkgxJpCPI98OJ1G0+NQFRBa/qnU+PfpAv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735015710; c=relaxed/simple;
	bh=lo2RXNSBAZb81WipyLjt6+MQ4yl2jxUv9K/zN7sYMh4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q6pw3o2AUAL2JUuEgNLtK+LCKkgA2BY3hgotEJjqGtRkJws7i+1GCd3SIInpu0sEBGcFpO+5vI3lRJ/ATdvwiChhOc7g+KRWUDYUNTGnarjAfMsmG/moewuo6i+tIH3PALXcqQOLWiPtRHCLyLNKxSZ4ljWFLl3me/ZiW8Uu9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844e6476ab1so744998639f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 20:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735015707; x=1735620507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcLo/HctTvrMPpCbi+TWdiMrTgdhY0+MJzeJQuDaGug=;
        b=pHfzxQ25HlLDwhEh4qoe7yQEVeU6QPerII73vdF4ZHGqVCOkNaNyEgMTr2opN/BOcF
         1Zxa6tyYMhdzEJLl4GYLEazC5IqnBIOnw8yogwAJH7WDed65UiEEcjN0ExRc0F0ifRYX
         yiHm0LIAy9amQuwttRyy8fDCgxz0F6xQ7/QNrUrhgugTpk1O+xgAg/oRyLLXtRdx1J9H
         onxTLbz5xvrEnOOKy6052voK50/3dwdrvmr4dbf5QSf/x5+M4kVTuC4Yl9NgfAcBooOp
         FV4DRDUJTtM0Gj/Leb7Krbt0O/Y0nKi+U/fRoOm5z4gnlDBjAf4kO0ZdmwbRqlJSYEQK
         i9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXWPJCnRm2Aod8z6Sz6rupMgAuWAsAY4E/GTDFKOliJeFUAj7ZTWoMR91GJkHpuaolXlvfe81WX+nJ5TvV2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv/Wq+ryQj+N2IfhRm0347Fo8QBtlyJ+yp10F+jKevYmFA7vY/
	7WspG2KTpUrn3lMwa58DZUiMIJg3sdLUzGgUdjc1xHld84lJ+a0rF873VazwOCeEN2S0+IwMpT0
	sjIohfgoYpZMSlWc+CC25Lcbdi3rFWyEpNUsxaClIPiPJ/98umUStT5s=
X-Google-Smtp-Source: AGHT+IGpK4/FujjsGBOxT93pLQdnsUBCTkLLBOsTSMdn7fnHiILWKb7FtIWZOh2pi8q4H/8wUYYqjDkeEkz4xBSvbVvGxnQBw+9+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c42:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3c2d533f04dmr129035915ab.19.1735015707652; Mon, 23 Dec 2024
 20:48:27 -0800 (PST)
Date: Mon, 23 Dec 2024 20:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676a3d1b.050a0220.2f3838.014f.GAE@google.com>
Subject: [syzbot] [jfs?] [nilfs?] WARNING in mnt_ns_release
From: syzbot <syzbot+5b9d613904b2f185f2fe@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jfs-discussion@lists.sourceforge.net, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8503810115fb Add linux-next specific files for 20241219
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14412fe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26a4b4cc7f877b28
dashboard link: https://syzkaller.appspot.com/bug?extid=5b9d613904b2f185f2fe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134992df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e84022cbe98/disk-85038101.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/112a23063d67/vmlinux-85038101.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3778558f0562/bzImage-85038101.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/3e0de479e20d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/051056cfbd12/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b9d613904b2f185f2fe@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5847 at fs/namespace.c:163 mnt_ns_release+0x15d/0x1c0 fs/namespace.c:163
Modules linked in:
CPU: 0 UID: 0 PID: 5847 Comm: syz-executor Not tainted 6.13.0-rc3-next-20241219-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:mnt_ns_release+0x15d/0x1c0 fs/namespace.c:163
Code: 15 bf 01 00 00 00 89 ee e8 90 fc 7d ff 85 ed 7e 39 e8 47 f8 7d ff 4c 89 ff 5b 41 5e 41 5f 5d e9 19 ca d8 ff e8 34 f8 7d ff 90 <0f> 0b 90 e9 12 ff ff ff e8 26 f8 7d ff 48 89 df be 03 00 00 00 5b
RSP: 0018:ffffc90000007bb8 EFLAGS: 00010246
RAX: ffffffff8241281c RBX: 0000000000000001 RCX: ffff888034a81e00
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc90000007e10 R08: ffffffff82412722 R09: 1ffffffff285ab0b
R10: dffffc0000000000 R11: ffffffff82422da0 R12: ffffffff81a6a587
R13: ffff88807cec0e58 R14: dffffc0000000000 R15: ffff88807cec0e00
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f98aaffed00 CR3: 0000000076918000 CR4: 00000000003526f0
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
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:228 [inline]
RIP: 0010:rb_erase+0x3e/0xe70 lib/rbtree.c:443
Code: 74 24 20 48 89 fb 48 b9 00 00 00 00 00 fc ff df 48 83 c7 08 48 89 f8 48 c1 e8 03 80 3c 08 00 74 05 e8 56 08 39 f6 4c 8b 63 08 <4c> 8d 7b 10 4d 89 fd 49 c1 ed 03 48 b8 00 00 00 00 00 fc ff df 41
RSP: 0018:ffffc9000414f9f8 EFLAGS: 00000246
RAX: 1ffff11005f7cf97 RBX: ffff88802fbe7cb0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffffff9a4501a0 RDI: ffff88802fbe7cb8
RBP: 1ffff11005f7cf89 R08: ffffffff942d5857 R09: 1ffffffff285ab0a
R10: dffffc0000000000 R11: fffffbfff285ab0b R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff818b397d R15: ffff88802fbe7c00
 mnt_ns_tree_remove fs/namespace.c:183 [inline]
 free_mnt_ns+0x10f/0x210 fs/namespace.c:3916
 free_nsproxy+0x4d/0x3c0 kernel/nsproxy.c:193
 do_exit+0xa2a/0x28e0 kernel/exit.c:937
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbe62f846fd
Code: Unable to access opcode bytes at 0x7fbe62f846d3.
RSP: 002b:00007ffeb8ef6dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007fbe62f846fd
RDX: 0000000000000030 RSI: 00007ffeb8ef6e50 RDI: 00000000000000f9
RBP: 00007ffeb8ef6dfc R08: 00000000000003b8 R09: 0079746972756365
R10: 00007fbe631487e0 R11: 0000000000000246 R12: 00007fbe63145f68
R13: 000000000001946d R14: 00007ffeb8ef6e50 R15: 0000000000000001
 </TASK>
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	20 48 89             	and    %cl,-0x77(%rax)
   5:	fb                   	sti
   6:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
   d:	fc ff df
  10:	48 83 c7 08          	add    $0x8,%rdi
  14:	48 89 f8             	mov    %rdi,%rax
  17:	48 c1 e8 03          	shr    $0x3,%rax
  1b:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  1f:	74 05                	je     0x26
  21:	e8 56 08 39 f6       	call   0xf639087c
  26:	4c 8b 63 08          	mov    0x8(%rbx),%r12
* 2a:	4c 8d 7b 10          	lea    0x10(%rbx),%r15 <-- trapping instruction
  2e:	4d 89 fd             	mov    %r15,%r13
  31:	49 c1 ed 03          	shr    $0x3,%r13
  35:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3c:	fc ff df
  3f:	41                   	rex.B


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

