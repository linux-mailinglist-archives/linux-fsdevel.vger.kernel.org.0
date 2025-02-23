Return-Path: <linux-fsdevel+bounces-42360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C73A40E2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 11:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B84C16D133
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3AD2054E3;
	Sun, 23 Feb 2025 10:53:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BFD2046B1
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308006; cv=none; b=LZ19WuHCoY9vTKQpBJACQF0hjWVuPZQSYPPjOnTu/1lrbiv3s0akWjTM/nEA7DSZ7/K3y6PFbRs/XDIJMT8zHCrhNrlQ2qfVZ81ZDjPsYtisfNuprD+sjdovuuUoq/Pyx/FhCW5ELeHf1FiShhnDtDIjCa4ez7w+BQISwEPCdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308006; c=relaxed/simple;
	bh=AHO7laaTifAW5dt9m9AopSHStlrCSiPNTqUC0306dbo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cSYHDzCByIwdtFRjg64/DUUZvhVb2j0SBFRf/9cXdcBF8OKEMzalYlbaoHHcJg15itHQmDe9Yp6t2HSDwlZlTB+m9TUv/HtG5rYls4BffVp2wCPP5VeKU8VWIcByrj5WbXlj/4cH3Bgb4Xb9RMpN1RlgpF/LHL7eC1zCGnCBpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-855b27236d1so732725939f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 02:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740308003; x=1740912803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=labABXKuLNGyrtUOxWIIn3XWVMM47LlHKowaDLL1Rm4=;
        b=aC7hgR6o1B2rIGdGreP7tsb306fGpWr2exXG+lqKAkU8vFHjjwBIneaYITHVV9jDjd
         Lvy/P8KnhhB/h2Or35hpeiRniFsqid7qu6bH/sb4oOpEe7lvR6vyG0WfBTVQzGq3E3Ru
         cuYfOPPs6uFFEln67LeWKmMuLS2esGmedDrZ1tjjn+4zp4wtxyrdWnY6D5DqCJ2CzSdD
         KKd5DSE8RuPjgRd9+g4/SZeRr7eJbx7J0F7CV8a3urCxuvIZz1QzZJQ9NLpkYO6dZd56
         Ktq4R3q+Sf1cwEaW2Op0hrFjrjlrJBJz6j00fhsFzvtaSbfEGBo4/DF1vKW78neombO3
         xHwg==
X-Forwarded-Encrypted: i=1; AJvYcCWVVm+D+hvqtqRDMkxYaHgWFrANEWOqOhBNMOwBmFTEH9r9PAq27ti4IAAoeLhLcJTZOIKXX8yfi7leRqH4@vger.kernel.org
X-Gm-Message-State: AOJu0YxymlVeZa4XRClYP3q58tgUSxGaCRBdzagIh6kyulwQPH/OekZF
	8W2fmrdkSiQs2KdHkvqxvXDN/FMICdOq6yUivjT6BfiGdgklTDXQ+8xNuESFbmdGC3D9+XbYu1+
	NdhGsz2jtqLtCYlj1YZOOF7K1fvSkA2/gLZu4EXXDYXtvYHIaNl8/pOo=
X-Google-Smtp-Source: AGHT+IHY5YiFUVTTLeHRmsPwEcNgVIoVmrsXiM7452gr41wCJVprBmr4u3ifaayuaRYc2zNeqjoungbsRXBnldmuyCJtSpiI/rxs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d2cae8cf13mr114975415ab.12.1740308003656; Sun, 23 Feb 2025
 02:53:23 -0800 (PST)
Date: Sun, 23 Feb 2025 02:53:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bafe23.050a0220.bbfd1.0017.GAE@google.com>
Subject: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request in efivarfs_pm_notify
From: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a1c24ab82279 Merge branch 'for-next/el2-enable-feat-pmuv3p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=127d53b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6b108de97771157
dashboard link: https://syzkaller.appspot.com/bug?extid=00d13e505ef530a45100
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e7a7a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17457498580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9581dbc26f55/disk-a1c24ab8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50aec9ab8b8b/vmlinux-a1c24ab8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a018984f8f5/Image-a1c24ab8.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com

random: crng reseeded on system resumption
Unable to handle kernel paging request at virtual address dfff80000000000d
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff80000000000d] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6436 Comm: syz-executor261 Not tainted 6.14.0-rc3-syzkaller-ga1c24ab82279 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : efivarfs_pm_notify+0xcc/0x350 fs/efivarfs/super.c:480
lr : efivarfs_pm_notify+0x8c/0x350 fs/efivarfs/super.c:477
sp : ffff80009cba7260
x29: ffff80009cba7300 x28: 0000000000000000 x27: 1fffe00019fdce21
x26: dfff800000000000 x25: ffff700013974e4c x24: 0000000000000068
x23: ffff80009cba7288 x22: 0000000000000005 x21: ffff80009cba7280
x20: ffff80009cba7260 x19: ffff0000cfee7108 x18: ffff80009cba6e00
x17: 000000000000d2a0 x16: ffff8000832b5a70 x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000003 x12: ffff0000c2620000
x11: ffff800082da568c x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 000000000000000d x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800093813f70 x4 : 0000000000000002 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000005 x0 : ffff0000cfee7128
Call trace:
 efivarfs_pm_notify+0xcc/0x350 fs/efivarfs/super.c:480 (P)
 notifier_call_chain+0x1c4/0x550 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust+0xdc/0x1bc kernel/notifier.c:345
 pm_notifier_call_chain_robust+0x34/0x64 kernel/power/main.c:102
 snapshot_open+0x11c/0x270 kernel/power/user.c:87
 misc_open+0x2b8/0x328 drivers/char/misc.c:179
 chrdev_open+0x3b0/0x4bc fs/char_dev.c:414
 do_dentry_open+0xb7c/0x1538 fs/open.c:956
 vfs_open+0x48/0x2d8 fs/open.c:1086
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2308/0x2b1c fs/namei.c:3989
 do_filp_open+0x1e8/0x404 fs/namei.c:4016
 do_sys_openat2+0x124/0x1b8 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1454
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: f940027c 9100a297 9101a398 d343ff08 (387a6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f940027c 	ldr	x28, [x19]
   4:	9100a297 	add	x23, x20, #0x28
   8:	9101a398 	add	x24, x28, #0x68
   c:	d343ff08 	lsr	x8, x24, #3
* 10:	387a6908 	ldrb	w8, [x8, x26] <-- trapping instruction


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

