Return-Path: <linux-fsdevel+bounces-48686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C678DAB2A16
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 19:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7057A287C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33A25D557;
	Sun, 11 May 2025 17:44:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AF256C82
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985465; cv=none; b=LAchOCkN1b3YVKdZtXT8QjY6H87wDhtFPJJQMh9ekJOWEKuy2JzVkXVnOv/jjYFeqy6xcOOdND8a3SIsW7in76ZLtElU27UshBfuj3lxT9WEaF7w4DkbsOBDzJqOMIHN5WUCSFyUsN5H/hVjmZEBq+YaYiAzWANOBKKiSRsYaLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985465; c=relaxed/simple;
	bh=CEsw6mzRiWGUMeZK0jVVN6aEuZaR4voawRXJKJIskg0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k22JuxUPObCxrGAHE9D/Vo4r8VoKItIsEprrs0hJuN8D0HUsv8r6S2+5/aGoQY7ATv8Oa3MlepUBsu1J1lEZC7dK7k5l3tlJ/g8fDvavorOKlf7xMvOnIHi1xsX58ZcW/mjTAD8NDX7eLBs2QRMDG4u7NQUkuXTaYemDBJmrz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d93e2ac7fbso87077525ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 May 2025 10:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746985463; x=1747590263;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/KpCTyNle1tG7yuZb222RpeOFLV+rMGE2z3vKjcud4s=;
        b=Vg5U9Z7vGk2IuBMgBvn07bK/lH7HDjwtsDsqveRgtlvjS0VHpz6ZJAcFRHdhvlMODk
         nMyNXmngZVDep7VRrq/Z20a7fElNe6/zz11j9Xk5qm90H5mnBhHQx10TVQdRUWfS7RvV
         xV/pcPi0whenuHMHX3dpDnfZhaWBnio+z4Ug+24zPK/s1KiSi+J6AVBIPDFN5zUWVJh9
         QI7GZnFoGlk2jzRO+rqkJs1v41XG5E47LmJP80lmC1FBcQ+ha8OvhLWTeM8EU4Ql/smJ
         ArGodXGBKHhWmMHLbhAlWbEEs4ZfgFFrvp8CNP9eHoH6Ygx1EYhJ+Bx24QbP3rIwsazN
         BKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBLpQ8YvCKA4X+rwRxU3fU43/0JViEujNDaG8ZmN+IIbJWzWm+SkQB/4W9+kOjsF5glMDM5s6xHAIFC1YY@vger.kernel.org
X-Gm-Message-State: AOJu0YxWz76RA+NMIwyxffDQaPIjEz2mk1t5vaj3SooHI8Q/zp3+Kh3N
	47qQmvjtunEpJB0yiCOw3WEluFnjpJ5s514fMjXwMZOb1dn71EwGZS5GGQu8Z01VNJ0sgLA5TiE
	kGCOsDmwUyKtkJ810+xccAmjbW+YaWnw7dNnY9aT8+6K/Qy2oLqVnPDQ=
X-Google-Smtp-Source: AGHT+IHEWo5oVhboPVPcl3NLw/eLbWnrfvPyU8Exy8KJuGNj7ubzRaMT3oH6ORwYi/96ZfWdTQ6EDrBIlyZbDntLjEwOAvYlPw93
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349a:b0:3d9:6cb5:3be4 with SMTP id
 e9e14a558f8ab-3da7e20d096mr137937015ab.15.1746985462726; Sun, 11 May 2025
 10:44:22 -0700 (PDT)
Date: Sun, 11 May 2025 10:44:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6820e1f6.050a0220.f2294.003c.GAE@google.com>
Subject: [syzbot] [fs?] [efi?] BUG: unable to handle kernel paging request in alloc_fs_context
From: syzbot <syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com>
To: ardb@kernel.org, jk@ozlabs.org, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1762d670580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=52cd651546d11d2af06b
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c0cd4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f49cf4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com

efivarfs: resyncing variable state
Unable to handle kernel paging request at virtual address dfff800000000005
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
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
[dfff800000000005] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6487 Comm: syz-executor120 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : alloc_fs_context+0x1b4/0x76c fs/fs_context.c:294
lr : __lse_atomic64_add arch/arm64/include/asm/atomic_lse.h:134 [inline]
lr : arch_atomic64_add arch/arm64/include/asm/atomic.h:67 [inline]
lr : raw_atomic64_add include/linux/atomic/atomic-arch-fallback.h:2672 [inline]
lr : raw_atomic_long_add include/linux/atomic/atomic-long.h:121 [inline]
lr : atomic_long_add include/linux/atomic/atomic-instrumented.h:3261 [inline]
lr : get_cred_many include/linux/cred.h:203 [inline]
lr : get_cred include/linux/cred.h:218 [inline]
lr : alloc_fs_context+0x150/0x76c fs/fs_context.c:293
sp : ffff8000a31b7760
x29: ffff8000a31b7790 x28: dfff800000000000 x27: ffff0000c8ef88d8
x26: 0000000000000028 x25: ffff0000c7e6f4c8 x24: ffff80008fb953e0
x23: 0000000000000000 x22: ffff0000c7e6f498 x21: ffff0000c8ef8000
x20: 0000000000000000 x19: ffff0000c7e6f400 x18: 00000000ffffffff
x17: ffff800092f27000 x16: ffff80008adb31c0 x15: 0000000000000001
x14: 1fffe0001a05b0e0 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001a05b0e1 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000005 x7 : ffff80008022b2b8 x6 : ffff80008022b4b4
x5 : ffff0000dabc9c90 x4 : ffff8000a31b7520 x3 : ffff800080dfa950
x2 : 0000000000000001 x1 : 0000000000000008 x0 : 0000000000000001
Call trace:
 alloc_fs_context+0x1b4/0x76c fs/fs_context.c:294 (P)
 fs_context_for_mount+0x34/0x44 fs/fs_context.c:332
 vfs_kern_mount+0x38/0x178 fs/namespace.c:1313
 efivarfs_pm_notify+0x1c4/0x4b4 fs/efivarfs/super.c:529
 notifier_call_chain+0x1b8/0x4e4 kernel/notifier.c:85
 blocking_notifier_call_chain+0x70/0xa0 kernel/notifier.c:380
 pm_notifier_call_chain+0x2c/0x3c kernel/power/main.c:109
 snapshot_release+0x104/0x1c4 kernel/power/user.c:125
 __fput+0x340/0x75c fs/file_table.c:465
 ____fput+0x20/0x58 fs/file_table.c:493
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x4e8/0x1998 kernel/exit.c:953
 do_group_exit+0x194/0x22c kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 pid_child_should_wake+0x0/0x1dc kernel/exit.c:1111
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
Code: 97f8a879 f9400368 9100a11a d343ff48 (387c6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f8a879 	bl	0xffffffffffe2a1e4
   4:	f9400368 	ldr	x8, [x27]
   8:	9100a11a 	add	x26, x8, #0x28
   c:	d343ff48 	lsr	x8, x26, #3
* 10:	387c6908 	ldrb	w8, [x8, x28] <-- trapping instruction


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

