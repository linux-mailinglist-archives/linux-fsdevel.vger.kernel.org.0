Return-Path: <linux-fsdevel+bounces-35602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DCF9D6446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 19:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05355161B65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62931DFE33;
	Fri, 22 Nov 2024 18:44:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6882FC23
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732301068; cv=none; b=e1ckjPw9TQfh49m0vS6NjBjYd5L+fsLlRysXx+yTmf0vfYl6Hsx8buFH6b34oaHEf/8C00r5HqEpFKSeQ8HoaKHdcNFcfbNn7Ic6hnl34khTqf2tUAU9W4mUGpHpJvXoCy2TZxJuKc17641NNydGQqGZd8pFBseDApdZyBEujTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732301068; c=relaxed/simple;
	bh=c4+x+Q4YVHHhSLA0v65KrpstMCen0NK4Wh3wf8GSeUY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f8xsdvGh0EoVGYSYffJRfBhPWyXklnUAbxYchDenTixrFi72aW5p/uB81GvdUfiQB6J+Ib51K+0jw921quddIjDOTtuYk9kWSQs1iMFiNxX95Jw2Tym0UUzC/TrwnxdWs+SxDF7xw4dOUAw5g7Xiw6JHVMpVkX9yJgqrmsxbUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7a72bd3a2so4845095ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 10:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732301064; x=1732905864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66i2rzbJqgIXp2mnX8j2LWFwTw12gX6IqhteqHgOhx4=;
        b=kGBUp699i6dPcTTx6ai1rxC2UlAjXLvwJ2JgXMrHEMDBMfDTBBHZ8Z0q4SRHbMq+x9
         lc3Q34N+agactpHh4XR+5SbVVZOnc7EdrayW3pto9+xVqSj1WuQzdRausQEi48hQToUW
         SItNWsr2Xib0D5HyNKdLMgM0N+/oStx26qNaUh0Kr5C67jQWkdFoP1hnlLEKd20sgHcT
         UdeJw6+d6d2LIzWPLA+IBbLt3Hd9ehNDZ90hqvXwrocnIXp+8553TJ66b825GvEL85FR
         x/q8TlP796BYOKHVri2tHLvsIfWLLZEwFqOjl5Ols8eViD+8UgPH1HGAdCcwS44it3PZ
         k9lw==
X-Gm-Message-State: AOJu0YycbwN4rpyue5R/PQ9yyLXv/+Rz/X4VbqBEPRkNN1tEP2FsP3LT
	XPt3hKiNDk2LpNsAInOrrvFJWtrAcEyVeCVlsBMgkbmWq1h0FfYwhQ0OJ3mCkz4deub85wxMxiX
	faioLQE4EUIBrv8IGNWPQW41KkzDbfZuQQh3lNvL3KpYCYQbdtIbb6IE=
X-Google-Smtp-Source: AGHT+IFM+c0Fsqd5EL/LkzELI3zLYgzfAgk5N8KJQ2H4/Iy3lxW3hg6cZ7DAexwC7M8M/Nh1kBGhNa7lrPCGHs66sDN3OPC+FxRh
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a7:7124:bd2b with SMTP id
 e9e14a558f8ab-3a79af53200mr50451505ab.15.1732301063954; Fri, 22 Nov 2024
 10:44:23 -0800 (PST)
Date: Fri, 22 Nov 2024 10:44:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740d107.050a0220.3c9d61.0195.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in minix_unlink
From: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a3cb78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=320c57a47bdabc1f294b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d31930580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129b76c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/54e0ad660b2f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com

minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6433b9
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bac135e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd609af0 x19: ffff0000dd609aa8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86ed5e6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86ed5e7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 14240
hardirqs last  enabled at (14239): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (14239): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (14240): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (13948): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (13948): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (13941): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66a6ce
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001babf963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd5fcb18 x19: ffff0000dd5fcad0 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86e55de x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86e55df x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 18414
hardirqs last  enabled at (18413): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (18413): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (18414): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (18126): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (18126): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (18107): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b683270
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bae2163 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd710b18 x19: ffff0000dd710ad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86deaf6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86deaf7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 22134
hardirqs last  enabled at (22133): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (22133): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (22134): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (21124): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (21122): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a6a9f
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001babfd59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd5feac8 x19: ffff0000dd5fea80 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 25870
hardirqs last  enabled at (25869): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (25869): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (25870): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (25760): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (25758): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b8c9b4
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bae2559 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd712ac8 x19: ffff0000dd712a80 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8ab2086 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8ab2087 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 29568
hardirqs last  enabled at (29567): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (29567): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (29568): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (29364): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (29362): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a9585
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001babff54 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd5ffaa0 x19: ffff0000dd5ffa58 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 34332
hardirqs last  enabled at (34331): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (34331): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (34332): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (34044): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (34044): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (34025): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b68475b
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad035e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd681af0 x19: ffff0000dd681aa8 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86f389e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86f389f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 38582
hardirqs last  enabled at (38581): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (38581): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (38582): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (38300): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (38300): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (38263): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b3fcafd
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad0754 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd683aa0 x19: ffff0000dd683a58 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8d8c7be x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8d8c7bf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 42828
hardirqs last  enabled at (42827): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (42827): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (42828): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (42544): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (42544): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (42535): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b98a12
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001badf163 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6f8b18 x19: ffff0000dd6f8ad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 46512
hardirqs last  enabled at (46511): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (46511): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (46512): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (46264): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (46264): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (46255): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b980c9
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001badf35e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6f9af0 x19: ffff0000dd6f9aa8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 50766
hardirqs last  enabled at (50765): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (50765): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (50766): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (50100): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (50098): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b699b8a
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baced59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd676ac8 x19: ffff0000dd676a80 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 54686
hardirqs last  enabled at (54685): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (54685): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (54686): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (54570): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (54568): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b686b8a
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad5963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6acb18 x19: ffff0000dd6acad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86ec2de x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86ec2df x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 58854
hardirqs last  enabled at (58853): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (58853): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (58854): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (58796): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (58796): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (58787): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b69f7b9
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad5d59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6aeac8 x19: ffff0000dd6aea80 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86eedfe x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86eedff x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 63018
hardirqs last  enabled at (63017): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (63017): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (63018): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (62716): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (62716): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (62691): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66ac6b
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bacb963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd65cb18 x19: ffff0000dd65cad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 67566
hardirqs last  enabled at (67565): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (67565): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (67566): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (67266): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (67266): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (67251): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b637241
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad4963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6a4b18 x19: ffff0000dd6a4ad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8708cb6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8708cb7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 71272
hardirqs last  enabled at (71271): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (71271): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (71272): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (70252): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (70250): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5a4a70
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bacbb5e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd65daf0 x19: ffff0000dd65daa8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 75078
hardirqs last  enabled at (75077): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (75077): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (75078): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (74954): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (74952): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b690e9f
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bad4d59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd6a6ac8 x19: ffff0000dd6a6a80 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8708cae x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8708caf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 78816
hardirqs last  enabled at (78815): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (78815): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (78816): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (78694): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (78694): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (78685): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd9d56
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baea963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd754b18 x19: ffff0000dd754ad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 82554
hardirqs last  enabled at (82553): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (82553): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (82554): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (82488): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (82486): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b680b5b
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baead59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd756ac8 x19: ffff0000dd756a80 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff870675e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff870675f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 86326
hardirqs last  enabled at (86325): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (86325): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (86326): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (86260): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (86260): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (86239): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd840d
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baeaf54 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd757aa0 x19: ffff0000dd757a58 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 90150
hardirqs last  enabled at (90149): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (90149): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (90150): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (90030): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (90028): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001badd270
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baee163 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd770b18 x19: ffff0000dd770ad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86f54ce x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86f54cf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 94386
hardirqs last  enabled at (94385): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (94385): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (94386): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (94268): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (94266): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b67fcc9
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baedb5e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd76daf0 x19: ffff0000dd76daa8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 98122
hardirqs last  enabled at (98121): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (98121): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (98122): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (98074): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (98074): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (98053): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W          6.12.0-syzkaller-g7b1d1d4cfac0 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3857a60
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5e189a
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001baedf54 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000dd76faa0 x19: ffff0000dd76fa58 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86f4c7e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86f4c7f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 inode_dec_link_count include/linux/fs.h:2510 [inline]
 minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 101832
hardirqs last  enabled at (101831): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inl

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

