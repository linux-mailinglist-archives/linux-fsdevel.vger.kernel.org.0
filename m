Return-Path: <linux-fsdevel+bounces-8832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC683B6FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 03:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73843B238B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 02:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA729AB;
	Thu, 25 Jan 2024 02:05:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030110E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148343; cv=none; b=gSw8/LCZYNrl29R5Nf4WGyJqA8ZWTQTt1Uz2OVJr4nw/E9X6nYjyiK+8hFJHLPfLsXY/BvhfJ57Nn6Pt0RayriuDoBUMtSvsnRksKyhOIJx1LCfBhaZB0B2tHBgiyiWU/lM/1SAVjeNf5nk0PK8QAoiibqr4O6+nErDCP0RHR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148343; c=relaxed/simple;
	bh=EYtxmzGtBo9a3GmEiqTcVIa7kIqjTkE6u2BLO+Suios=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qpEHYRUpHRjJUOT16533gAAAeK12tH1ebtsl/hxruL88e49esTL6MQpwwZ8vpFk0nNGvGlmqC7Jw/yUNzzoeReqH3t3AH0ckuMxAWZ+q9gHK+D866CTyqfs9ILLeICFi+Vic54qSWATGuDHA9OVhHkl7v9OhREPuzuKRYYg4EXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf46c17b7dso13700139f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:05:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706148341; x=1706753141;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrtQw57YFxwhUAcIcBKTdH/pTxNy27NU1BXt25Zxlu0=;
        b=Um9N7e2EKHfjV8cQ/Sp+EnYerxS2nupmu/VM9OFKZRsMewtsTWFdANE7P1loRId6OV
         v7u5fP7EDaMyF1GKHG/bJ833opfIiZowK4x0xJYJp7IkL79Q1grZArCLUacIE2YoDDoi
         k4/tbDhGoW1Z9FpeZdkdW50wuNYN824iWudwBiMQ13wmAdsBzwJJRUSZRM71Vkmrg3xq
         FNbtgPEB9VoNjtgUHjfVV3dI+kdf5YTnngb0I8e3XRQ2IkJfyrG1Mknmg6yN3ggIOISZ
         vhwJ9Xr2Mtm9DeNybb8f3n7jCbMwN8m6FAPpYeDtVqjwSmYwJJ/HlRyKiJDN5elmULsO
         Youw==
X-Gm-Message-State: AOJu0YzlHhRZK1zEWC0gui0Dd0yPNvjeLLUYK3qjJQGt+L9thi5tFrti
	vhR11VBaIxViDxjf5rW6JoxbpmNfMb4rcRTD7jR2sf+vi4ZnaojotoFaqIyfyOyGFujmeL1ZfeL
	z0cRA1MD4oir89QT/EjYZSN86Dcn2f2+bOHfZZCSMv1mZkONfIVxVQ6o=
X-Google-Smtp-Source: AGHT+IFlaBgnwcgnQsGPtFezUgoC6PWYVSfidrctl04cXapMekDozI/tF79NqL7CmPq4rP6C7KxOp62S+WakPcFo1ITeRha0xlc9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:df0c:0:b0:7bf:69d6:d232 with SMTP id
 f12-20020a5edf0c000000b007bf69d6d232mr16896ioq.1.1706148341306; Wed, 24 Jan
 2024 18:05:41 -0800 (PST)
Date: Wed, 24 Jan 2024 18:05:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d16096060fbb9d6b@google.com>
Subject: [syzbot] [fs?] BUG: soft lockup in pipe_read
From: syzbot <syzbot+8b31216d2ea3f2c6905b@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0802e17d9aca Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=130bfa8be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9616b7e180577ba
dashboard link: https://syzkaller.appspot.com/bug?extid=8b31216d2ea3f2c6905b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e3d957e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84e45f27a78/disk-0802e17d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8b16d2fc3b1/vmlinux-0802e17d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c7ac36b3de1/Image-0802e17d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8b31216d2ea3f2c6905b@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 27s! [syz-execprog:6302]
Modules linked in:
irq event stamp: 9320
hardirqs last  enabled at (9319): [<ffff800080031c54>] local_daif_restore+0x1c/0x3c arch/arm64/include/asm/daifflags.h:75
hardirqs last disabled at (9320): [<ffff80008a82ca9c>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (9320): [<ffff80008a82ca9c>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (9314): [<ffff80008003144c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (9312): [<ffff800080031418>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
CPU: 0 PID: 6302 Comm: syz-execprog Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : access_ok arch/arm64/include/asm/uaccess.h:46 [inline]
pc : copy_to_user_iter lib/iov_iter.c:22 [inline]
pc : iterate_ubuf include/linux/iov_iter.h:29 [inline]
pc : iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
pc : iterate_and_advance include/linux/iov_iter.h:271 [inline]
pc : _copy_to_iter+0x1b0/0x1500 lib/iov_iter.c:186
lr : copy_to_user_iter lib/iov_iter.c:20 [inline]
lr : iterate_ubuf include/linux/iov_iter.h:29 [inline]
lr : iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
lr : iterate_and_advance include/linux/iov_iter.h:271 [inline]
lr : _copy_to_iter+0x190/0x1500 lib/iov_iter.c:186
sp : ffff8000977276c0
x29: ffff8000977277f0 x28: dfff800000000000 x27: ffff700012ee4ee8
x26: 1ffff00012ee4f77 x25: 000000400156f5f0 x24: ffff0000ccf41e2c
x23: ffff800097727bb8 x22: ffff0000ccf41e00 x21: 0000000000000000
x20: 0000000000000001 x19: ffff800097727bc8 x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008a830fdc x15: 0000000000000001
x14: 0000000000000000 x13: 0000000000000004 x12: ffff0000ccf41e00
x11: 0000000000ff0100 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : ffff8000808bc19c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 access_ok arch/arm64/include/asm/uaccess.h:46 [inline]
 copy_to_user_iter lib/iov_iter.c:22 [inline]
 iterate_ubuf include/linux/iov_iter.h:29 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:245 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 _copy_to_iter+0x1b0/0x1500 lib/iov_iter.c:186
 copy_page_to_iter+0x200/0x2f8 lib/iov_iter.c:381
 pipe_read+0x454/0xfe0 fs/pipe.c:337
 call_read_iter include/linux/fs.h:2014 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x5b4/0x8a4 fs/read_write.c:470
 ksys_read+0x15c/0x26c fs/read_write.c:613
 __do_sys_read fs/read_write.c:623 [inline]
 __se_sys_read fs/read_write.c:621 [inline]
 __arm64_sys_read+0x7c/0x90 fs/read_write.c:621
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6211 Comm: udevd Not tainted 6.7.0-rc8-syzkaller-g0802e17d9aca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
pc : __do_softirq+0x1c0/0xce4 kernel/softirq.c:537
lr : __do_softirq+0x1bc/0xce4 kernel/softirq.c:537
sp : ffff800080017f20
x29: ffff800080017f90 x28: ffff0000d8c25a00 x27: ffff800097267b20
x26: ffff80008e45a500 x25: ffff0000d8c25a08 x24: dfff800000000000
x23: ffff0000d8c25a00 x22: ffff0001b4166500 x21: ffff0001b4152c6c
x20: 0000000000000186 x19: ffff0001b4166500 x18: 0000000000000000
x17: ffff800125d0c000 x16: ffff800080318564 x15: 0000000000000001
x14: ffff80008e4f0448 x13: dfff800000000000 x12: 0000000000000003
x11: 0000000000000100 x10: 0000000000000003 x9 : 0000000000000000
x8 : 000000000002bea4 x7 : ffff8000804272d4 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000003 x1 : ffff80008a99d720 x0 : ffff800125d0c000
Call trace:
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
 __do_softirq+0x1c0/0xce4 kernel/softirq.c:537
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:886
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:86
 invoke_softirq kernel/softirq.c:434 [inline]
 __irq_exit_rcu+0x1d8/0x434 kernel/softirq.c:632
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:644
 __el1_irq arch/arm64/kernel/entry-common.c:503 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:517
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:522
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:591
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:196 [inline]
 seqcount_lockdep_reader_access+0xe0/0x100 include/linux/seqlock.h:104
 read_seqbegin include/linux/seqlock.h:847 [inline]
 read_seqbegin_or_lock include/linux/seqlock.h:1151 [inline]
 prepend_path+0xd8/0xaf8 fs/d_path.c:166
 d_absolute_path+0x13c/0x27c fs/d_path.c:234
 tomoyo_get_absolute_path security/tomoyo/realpath.c:101 [inline]
 tomoyo_realpath_from_path+0x24c/0x4cc security/tomoyo/realpath.c:271
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x218/0x588 security/tomoyo/file.c:822
 tomoyo_inode_getattr+0x28/0x38 security/tomoyo/tomoyo.c:122
 security_inode_getattr+0xd8/0x124 security/security.c:2153
 vfs_getattr fs/stat.c:173 [inline]
 vfs_statx+0x184/0x420 fs/stat.c:248
 vfs_fstatat+0x118/0x25c fs/stat.c:299
 __do_sys_newfstatat fs/stat.c:463 [inline]
 __se_sys_newfstatat fs/stat.c:457 [inline]
 __arm64_sys_newfstatat+0x104/0x184 fs/stat.c:457
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595


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

