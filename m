Return-Path: <linux-fsdevel+bounces-49589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF340ABFC45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 19:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE913A94D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C159289E15;
	Wed, 21 May 2025 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAiz5sXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B560289824;
	Wed, 21 May 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747848528; cv=none; b=fsvQ+7arIli5+lliw1voKeIKh7LvU/fIkDiWFbNxmJbVE4LOVtAQGK9vIzXhqmHqdaaOJ6lMVDKdwqxr6UP2tiUjlYRKLSu4U46YNK5rDjkTN3TAnlfkVP04OIX+py7JSqInsDqvz4KJsMG0KY2MuhApzNqpjzBBc7ttN3ekR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747848528; c=relaxed/simple;
	bh=HK/f2OC27kw7E2aDKCk4nq2rlgz3dZYbc65P0dIeI8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0uGs4oaPvXKBvFFihdeWCrT2EgMfapiJCxhISjNQVd88dY/AyeanugOXBx97BVHTZzsk/+qJ3r6LqAVWCPMT3akVv0QCOofp7UsbGAuYqudSzhqPxdz+Qs2IHvKZT3n5wl8rRTwYSQCVJ23OaoJpv7hskvaqvA+DAMP1OS2d7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAiz5sXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3218C4CEED;
	Wed, 21 May 2025 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747848527;
	bh=HK/f2OC27kw7E2aDKCk4nq2rlgz3dZYbc65P0dIeI8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NAiz5sXKNgZ+c0/iaEixDGFzVzruxX16Qc+eAi4IvjNCcp7qOQFYB4aH8AUxjy2UA
	 XE2gR0hG307xua48iHqYps6FT4DmrMAUPMYqvQb6e8QlZ4wS3SmrQlEwFjURyxtncg
	 H0/sm2zccIoh1qkUXXO0XgpgNeW67ZtKf2t+V87czNZ1PTpL4+8AZZHQ3dxjCe/jUX
	 y/N0yL0xUAXNrSBNLZjor6d284iKVof+HfghtSagl7NIC9/XTQV7paBl/DALLrBfKA
	 gHzuZI1ehMUevP/u0ZjK/JGIaRH6ymFHw/SLHpZMe7ftn4rSfRJPuDEzixL5X2TC1m
	 AAjk67Ub9s3Rw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so8354808e87.1;
        Wed, 21 May 2025 10:28:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAg+5duOt9wRM6+bJLinTbn7OnLba1ODZY0yoYlKgoUCYtXphOlACfRf/2QdHPCJhTQx7qncEv7GkzZtM6@vger.kernel.org, AJvYcCVwqzaEtzylXF43O6gi2gvZqqMqPQhFNTzSh6MMAHWm1gF5TguqSy3jbRn3jgT4feWGpY4HSkULeiw=@vger.kernel.org, AJvYcCXPvEVGZxoR3poGo1T5okptscEkhfx5r7YW0kLl9OMf0Hs1PUXX8iPZ4B3SmjxKaBrKylsfqtd5bEeMYcCf/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/rfMk2jbJgwZlMMwohzO4UqvCIiABEv7Nqx/Iu04BC/QY/Kur
	ci7JyHPHx8QJsxg/WXg6uiOnKa7fI495ujsTjb1VXWYyqZQiu8fQbdi49gnEshjSlB3Lt5BMVik
	S2QU6ij1mU/qRq3A8+wPZgi1HiAGNDJE=
X-Google-Smtp-Source: AGHT+IED7hvEqvRCCLir6jjUlL9xucAtYBb9f1l0NIqbApbevbcHb1vS7VmHxi6m3+G9Dil82JpRAU6w7+u6lw79G9c=
X-Received: by 2002:ac2:4e07:0:b0:54f:c6b0:4c71 with SMTP id
 2adb3069b0e04-550e71983e4mr7313533e87.10.1747848526113; Wed, 21 May 2025
 10:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6820e1f6.050a0220.f2294.003c.GAE@google.com>
In-Reply-To: <6820e1f6.050a0220.f2294.003c.GAE@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 21 May 2025 19:28:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEg88Q5GCV+YW13UT4eDEzMpnKW8ReJNDjLqX7xeXaw=w@mail.gmail.com>
X-Gm-Features: AX0GCFsyajLOL0aLII2QTgKTT2Po4pG1OJqA5lR8WKR5gk16iSvrfBCxXYID3RQ
Message-ID: <CAMj1kXEg88Q5GCV+YW13UT4eDEzMpnKW8ReJNDjLqX7xeXaw=w@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [efi?] BUG: unable to handle kernel paging request
 in alloc_fs_context
To: syzbot <syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

(cc James, Al, Christian)

Please see the splat below.

The NULL dereference is due to get_cred() in alloc_fs_context()
attempting to increment current->cred->usage while current->cred ==
NULL, and this is a result of the fact that PM notifier call chain is
called while the task is exiting.

IIRC, the intent was for commit

  11092db5b573 efivarfs: fix NULL dereference on resume

to be replaced at some point with something more robust; might that
address this issue as well?

Thanks,
Ard.




On Sun, 11 May 2025 at 19:44, syzbot
<syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c32f8dc5aaf9 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1762d670580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ea4635ffd6ad5b4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=52cd651546d11d2af06b
> compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165c0cd4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f49cf4580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b921498959d4/disk-c32f8dc5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/04e6ad946c4b/vmlinux-c32f8dc5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d4f0d8db50ee/Image-c32f8dc5.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com
>
> efivarfs: resyncing variable state
> Unable to handle kernel paging request at virtual address dfff800000000005
> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
> Mem abort info:
>   ESR = 0x0000000096000005
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x05: level 1 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [dfff800000000005] address between user and kernel address ranges
> Internal error: Oops: 0000000096000005 [#1]  SMP
> Modules linked in:
> CPU: 1 UID: 0 PID: 6487 Comm: syz-executor120 Not tainted 6.15.0-rc5-syzkaller-gc32f8dc5aaf9 #0 PREEMPT
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : alloc_fs_context+0x1b4/0x76c fs/fs_context.c:294
> lr : __lse_atomic64_add arch/arm64/include/asm/atomic_lse.h:134 [inline]
> lr : arch_atomic64_add arch/arm64/include/asm/atomic.h:67 [inline]
> lr : raw_atomic64_add include/linux/atomic/atomic-arch-fallback.h:2672 [inline]
> lr : raw_atomic_long_add include/linux/atomic/atomic-long.h:121 [inline]
> lr : atomic_long_add include/linux/atomic/atomic-instrumented.h:3261 [inline]
> lr : get_cred_many include/linux/cred.h:203 [inline]
> lr : get_cred include/linux/cred.h:218 [inline]
> lr : alloc_fs_context+0x150/0x76c fs/fs_context.c:293
> sp : ffff8000a31b7760
> x29: ffff8000a31b7790 x28: dfff800000000000 x27: ffff0000c8ef88d8
> x26: 0000000000000028 x25: ffff0000c7e6f4c8 x24: ffff80008fb953e0
> x23: 0000000000000000 x22: ffff0000c7e6f498 x21: ffff0000c8ef8000
> x20: 0000000000000000 x19: ffff0000c7e6f400 x18: 00000000ffffffff
> x17: ffff800092f27000 x16: ffff80008adb31c0 x15: 0000000000000001
> x14: 1fffe0001a05b0e0 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff60001a05b0e1 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000005 x7 : ffff80008022b2b8 x6 : ffff80008022b4b4
> x5 : ffff0000dabc9c90 x4 : ffff8000a31b7520 x3 : ffff800080dfa950
> x2 : 0000000000000001 x1 : 0000000000000008 x0 : 0000000000000001
> Call trace:
>  alloc_fs_context+0x1b4/0x76c fs/fs_context.c:294 (P)
>  fs_context_for_mount+0x34/0x44 fs/fs_context.c:332
>  vfs_kern_mount+0x38/0x178 fs/namespace.c:1313
>  efivarfs_pm_notify+0x1c4/0x4b4 fs/efivarfs/super.c:529
>  notifier_call_chain+0x1b8/0x4e4 kernel/notifier.c:85
>  blocking_notifier_call_chain+0x70/0xa0 kernel/notifier.c:380
>  pm_notifier_call_chain+0x2c/0x3c kernel/power/main.c:109
>  snapshot_release+0x104/0x1c4 kernel/power/user.c:125
>  __fput+0x340/0x75c fs/file_table.c:465
>  ____fput+0x20/0x58 fs/file_table.c:493
>  task_work_run+0x1dc/0x260 kernel/task_work.c:227
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x4e8/0x1998 kernel/exit.c:953
>  do_group_exit+0x194/0x22c kernel/exit.c:1102
>  __do_sys_exit_group kernel/exit.c:1113 [inline]
>  __se_sys_exit_group kernel/exit.c:1111 [inline]
>  pid_child_should_wake+0x0/0x1dc kernel/exit.c:1111
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x58/0x17c arch/arm64/kernel/entry-common.c:767
>  el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> Code: 97f8a879 f9400368 9100a11a d343ff48 (387c6908)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   97f8a879        bl      0xffffffffffe2a1e4
>    4:   f9400368        ldr     x8, [x27]
>    8:   9100a11a        add     x26, x8, #0x28
>    c:   d343ff48        lsr     x8, x26, #3
> * 10:   387c6908        ldrb    w8, [x8, x28] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

