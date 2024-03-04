Return-Path: <linux-fsdevel+bounces-13506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AB87092C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D2FB244F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE52C62147;
	Mon,  4 Mar 2024 18:11:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E66168A
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575883; cv=none; b=nMdCYdz85iIPp2bD63ql1g8lyKG2QpBjc6rwGQzehQYzuIA8B+rhxy+UMuzg4fq+SBol+MH+Q3WkzpfCAFKX7zga+jwBC/oiQFAXfFBxZIurmzrC47UbQ2TYTteamaSKTC4q4+adzVfxECNV8N2HAnb8vSVtLai7FYzDYQO4YlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575883; c=relaxed/simple;
	bh=OxKUW07uCPsIbUITY/K52x7PHUdIXQJWeSxv7ImbHXI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a62fqzWnvd81ffEDGx10SRB7Gx5tYIDfJUHV+uIBS5+BDS20TQumxldWGvHhs2D1AfYWwUNOoP/AOULvNl29TlKw91ZbZp+S0jPCEJfuqKOOa6wWwsm76GQF1iYtMxNx7mru1SludN10ZXNHP5SU8SCeGXcmARnYjgPUlts4dNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c000114536so445784239f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 10:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709575881; x=1710180681;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qy49v2YVGJ+vVdKRs4HHtEwF6G7H2IbHFsn5mHhGpWI=;
        b=pRYF7I0ssJ1sL3SdwBZ6KSQFxs+gz7KNimwtB0WHYtdngAgqd6HoVRoc9QjSgV7nrP
         NnlP3FbGft7P9xaBgPzIjsq7gxMZcIVoab7uSbXjD3QTHC6LXovQYrRtx9ri52xjDFpg
         GDyX/Apyi57BEdp9mhXHDB/cNSCw3wZpzX4tOuQILSfAcXQBUXZ/1BhkRjolj93dRKp3
         vj9MCgMOMH6vYdUB3ahm/3GvevJRCJpXxeU5iI6lSc++hFP8qpFCqoiW9ta6yD720Jx7
         0VlUJLVwBaty49FqxC+zqAjVhz8NuRM8IWmGUN891/Fiv6DIXp53rdR3iaLnRb5mmkDh
         sMXg==
X-Gm-Message-State: AOJu0YxLTnN+qz5Ti5ZjxcHAnBqoo11zW8yNPqBoKI5uKaYP3YjrVPvO
	JhjeKpNB5w+bBksZ5ikalt42hhp09ueZ6mbqXHvjdd6nfF19hzXRKemuZiyUAyAn7t/b0zFEBCQ
	YSt5UQt58kCA78j1tRFmb6wvUOcxjZAaa1ebGqUXsO73zIiJ6beCePkpXOw==
X-Google-Smtp-Source: AGHT+IHzFd/qiopJJ+DNnqRLo1DbAfH58/diZt6xDt2vebFqVhKZc5bLPWPqDpeD47x4y79w4i3DMOs+nJFLr22PpzSMWVw4+763
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1643:b0:7c8:5e7c:52d2 with SMTP id
 y3-20020a056602164300b007c85e7c52d2mr61829iow.2.1709575881080; Mon, 04 Mar
 2024 10:11:21 -0800 (PST)
Date: Mon, 04 Mar 2024 10:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bc4a00612d9a7f4@google.com>
Subject: [syzbot] [fs?] KASAN: null-ptr-deref Write in do_pagemap_cmd
From: syzbot <syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    381f163531d8 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=108175ac180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2402d46ab3c7e581
dashboard link: https://syzkaller.appspot.com/bug?extid=02e64be5307d72e9c309
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125fa6a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1211e332180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/47402e75ee62/disk-381f1635.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a26a3a35fa67/vmlinux-381f1635.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d8dae1be1fa4/Image-381f1635.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: null-ptr-deref in atomic_long_add_return_acquire include/linux/atomic/atomic-instrumented.h:3269 [inline]
BUG: KASAN: null-ptr-deref in rwsem_read_trylock kernel/locking/rwsem.c:243 [inline]
BUG: KASAN: null-ptr-deref in __down_read_common kernel/locking/rwsem.c:1249 [inline]
BUG: KASAN: null-ptr-deref in __down_read_killable kernel/locking/rwsem.c:1273 [inline]
BUG: KASAN: null-ptr-deref in down_read_killable+0x78/0x338 kernel/locking/rwsem.c:1551
Write of size 8 at addr 0000000000000120 by task syz-executor185/6171

CPU: 0 PID: 6171 Comm: syz-executor185 Tainted: G    B              6.8.0-rc6-syzkaller-g381f163531d8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_report+0xe4/0x518 mm/kasan/report.c:491
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 kasan_check_range+0x254/0x294 mm/kasan/generic.c:189
 __kasan_check_write+0x20/0x30 mm/kasan/shadow.c:37
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_long_add_return_acquire include/linux/atomic/atomic-instrumented.h:3269 [inline]
 rwsem_read_trylock kernel/locking/rwsem.c:243 [inline]
 __down_read_common kernel/locking/rwsem.c:1249 [inline]
 __down_read_killable kernel/locking/rwsem.c:1273 [inline]
 down_read_killable+0x78/0x338 kernel/locking/rwsem.c:1551
 mmap_read_lock_killable include/linux/mmap_lock.h:155 [inline]
 do_pagemap_scan fs/proc/task_mmu.c:2460 [inline]
 do_pagemap_cmd+0x8d8/0x1240 fs/proc/task_mmu.c:2513
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
==================================================================
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000120
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001129c0000
[0000000000000120] pgd=080000011d13d003, p4d=080000011d13d003, pud=080000011cfae003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 6171 Comm: syz-executor185 Tainted: G    B              6.8.0-rc6-syzkaller-g381f163531d8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lse_atomic64_fetch_add_acquire arch/arm64/include/asm/atomic_lse.h:169 [inline]
pc : __lse_atomic64_add_return_acquire arch/arm64/include/asm/atomic_lse.h:202 [inline]
pc : arch_atomic64_add_return_acquire arch/arm64/include/asm/atomic.h:91 [inline]
pc : raw_atomic64_add_return_acquire include/linux/atomic/atomic-arch-fallback.h:2703 [inline]
pc : raw_atomic_long_add_return_acquire include/linux/atomic/atomic-long.h:163 [inline]
pc : atomic_long_add_return_acquire include/linux/atomic/atomic-instrumented.h:3270 [inline]
pc : rwsem_read_trylock kernel/locking/rwsem.c:243 [inline]
pc : __down_read_common kernel/locking/rwsem.c:1249 [inline]
pc : __down_read_killable kernel/locking/rwsem.c:1273 [inline]
pc : down_read_killable+0x80/0x338 kernel/locking/rwsem.c:1551
lr : instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
lr : atomic_long_add_return_acquire include/linux/atomic/atomic-instrumented.h:3269 [inline]
lr : rwsem_read_trylock kernel/locking/rwsem.c:243 [inline]
lr : __down_read_common kernel/locking/rwsem.c:1249 [inline]
lr : __down_read_killable kernel/locking/rwsem.c:1273 [inline]
lr : down_read_killable+0x78/0x338 kernel/locking/rwsem.c:1551
sp : ffff8000978a79d0
x29: ffff8000978a79d0 x28: ffff8000978a7b40 x27: dfff800000000000
x26: 0000000000000000 x25: 0000000020ffd000 x24: ffff8000978a7b68
x23: ffff700012f14f68 x22: ffff0000d8fdda2c x21: 0000000000000120
x20: 0000000000000190 x19: ffff800080cef5fc x18: 0000000000000000
x17: 3d3d3d3d3d3d3d3d x16: ffff800080275eb0 x15: 0000000000000001
x14: 1ffff000123e3a9c x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000123e3a9d x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000100 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000978a71d8 x4 : ffff80008ed81760 x3 : ffff8000801c0944
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 raw_atomic64_add_return_acquire include/linux/atomic/atomic-arch-fallback.h:2703 [inline]
 raw_atomic_long_add_return_acquire include/linux/atomic/atomic-long.h:163 [inline]
 atomic_long_add_return_acquire include/linux/atomic/atomic-instrumented.h:3270 [inline]
 rwsem_read_trylock kernel/locking/rwsem.c:243 [inline]
 __down_read_common kernel/locking/rwsem.c:1249 [inline]
 __down_read_killable kernel/locking/rwsem.c:1273 [inline]
 down_read_killable+0x80/0x338 kernel/locking/rwsem.c:1551
 mmap_read_lock_killable include/linux/mmap_lock.h:155 [inline]
 do_pagemap_scan fs/proc/task_mmu.c:2460 [inline]
 do_pagemap_cmd+0x8d8/0x1240 fs/proc/task_mmu.c:2513
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 52800101 974346ca d503201f 52802008 (f8a802a8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	52800101 	mov	w1, #0x8                   	// #8
   4:	974346ca 	bl	0xfffffffffd0d1b2c
   8:	d503201f 	nop
   c:	52802008 	mov	w8, #0x100                 	// #256
* 10:	f8a802a8 	ldadda	x8, x8, [x21] <-- trapping instruction


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

