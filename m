Return-Path: <linux-fsdevel+bounces-35721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCEE9D77F8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78B3281A32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC2157A5C;
	Sun, 24 Nov 2024 19:41:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566E14A627
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732477266; cv=none; b=bmY1wRHM2x77Rz7uCX4rbA/ePtLf1QlZaCOt9kwWGkxGd/m92ZjsnIj+7qwG9+pIdkRzZsxLSxVQfjuigshl94ZeeG+VU+x6MpeabLOX3G5YayVz9qvgJOD48e/hH01VwuiOb1Fh4toHF1bkt4h6BKEQ/Jn2DsAvWZTnVGU94iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732477266; c=relaxed/simple;
	bh=qz24nwWbf2EHu8QHTI2/piAe3DmEVOabAB7t2kczWBg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t+7ltl40xmAp7rdjZ5876mwlo96xHTo1NG0iu0Wbt2o/bYmDZR9I5vIfCZwwwsgWyjXMTq2N1C/NUgXnqoiC56EF76HhKZLD0pmWIFJFcBwE1dv5Zp+lGTqAt0p9r7dCM90j5Euybep6S8WQp9owQYsElhZyUIvCsDIOZJtZ/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7ace5dd02so12131145ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 11:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732477261; x=1733082061;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnI1dBV7nKYiDBk0KooUEX48sxAe/+xBBKTnIBp4Sxg=;
        b=gVKdIQMWRh01EgexhMRn11L8CuGqKmKrkMSpWmqZN6wtm0Kb/EZH7e6S4IJaNryqr8
         z0To92KQKSg56SV13RAgFIrU3X2AWe0oEpo7DWZCQFpMqPRYOTiea/3FvcEEmprbs87b
         p7iMN3V0NnN4k3o/TRszm4ADsxwnBjnnYtNLPa+RIH1ITL9tP37k4wt1oLSAuYtuhlpG
         Jw4QU678fBjVqJeT7NdSB7dAKLxC0Mud/W1z06DK+lJQyBhi71GVUCUcsZpEQpDlGo3x
         yZ+c8J9YlukdbigSaBTWXGDHj/CzuOWVDPsLWjHCC7k2BDookSXfSi/4gggln9Z6Sfbw
         C84w==
X-Gm-Message-State: AOJu0YxFIAPDQN5jPbawW67ppSqf3MRRkWXOpxnI4VDQkaKnakzSiqde
	P+MiqPfPQGDqgLbGf1r3lyTxluQGBTTIaKKuKT1TQeg8Qu0flObAKZ0tkY4/Rk+/s1Dtlz8bR76
	pMRdeNK705nfxUedhgeHFMMUBfmze7yPTWpuaNQLKU7x24EcXn4jVeJo=
X-Google-Smtp-Source: AGHT+IEKgZOgP6ONDRByDiiSktwOf8HEFbQn80hxKFlZ1XkIlIuNspONvc2hLBS2x42Ah1+8MW4G0M9muSjHdKGymAiGLTBvwRJq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:3a7:6ec2:71d9 with SMTP id
 e9e14a558f8ab-3a79ae1c1c9mr96015505ab.13.1732477261679; Sun, 24 Nov 2024
 11:41:01 -0800 (PST)
Date: Sun, 24 Nov 2024 11:41:01 -0800
In-Reply-To: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743814d.050a0220.1cc393.0049.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
From: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in minix_unlink

minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Not tainted 6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001bdf2fb9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c28f963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e147cb18 x19: ffff0000e147cad0 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8752a9e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8752a9f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 156268
hardirqs last  enabled at (156267): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (156267): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (156268): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (155154): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (155152): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2e10c9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c28fd59 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e147eac8 x19: ffff0000e147ea80 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8714636 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8714637 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 164108
hardirqs last  enabled at (164107): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (164107): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (164108): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (163994): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (163992): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2b29e3
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001b6dd963 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000db6ecb18 x19: ffff0000db6ecad0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff875c8fe x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff875c8ff x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 172342
hardirqs last  enabled at (172341): [<ffff80008b5a7504>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (172341): [<ffff80008b5a7504>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (172342): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (172078): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (172076): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe00019fa3d56
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001b6ddb5e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000db6edaf0 x19: ffff0000db6edaa8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff875deee x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff875deef x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 180252
hardirqs last  enabled at (180251): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (180251): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (180252): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (179760): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (179760): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (179735): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b669a9f
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2dfb5e x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e16fdaf0 x19: ffff0000e16fdaa8 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff875dde6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff875dde7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 187498
hardirqs last  enabled at (187497): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (187497): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (187498): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (187242): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (187240): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2b2e12
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2dff54 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e16ffaa0 x19: ffff0000e16ffa58 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8b2e506 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8b2e507 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 193844
hardirqs last  enabled at (193843): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (193843): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (193844): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (193592): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (193590): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe000195d43b9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2cf2b5 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e16795a8 x19: ffff0000e1679560 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8b2e2c6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8b2e2c7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 200564
hardirqs last  enabled at (200563): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (200563): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (200564): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (199538): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (199536): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b669c0d
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c297811 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e14bc088 x19: ffff0000e14bc040 x18: ffff0000e5e5e68c
x17: 0000000000000000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8b2e2c6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8b2e2c7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 207240
hardirqs last  enabled at (207239): [<ffff80008b4b56a4>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (207239): [<ffff80008b4b56a4>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (207240): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (207150): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (207150): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (206993): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe000195e346b
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c297c07 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e14be038 x19: ffff0000e14bdff0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff872331e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff872331f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 214990
hardirqs last  enabled at (214989): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (214989): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (214990): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (214528): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (214528): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (214449): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b6900c9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c297cb0 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e14be580 x19: ffff0000e14be538 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff86e1a66 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff86e1a67 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 221326
hardirqs last  enabled at (221325): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (221325): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (221326): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (220296): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (220294): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b68f1e3
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdd4a0c x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000deea5060 x19: ffff0000deea5018 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff87585a6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff87585a7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 227596
hardirqs last  enabled at (227595): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (227595): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (227596): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (227296): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (227296): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (227193): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b5d5127
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdd4c07 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000deea6038 x19: ffff0000deea5ff0 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff875dde6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff875dde7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 233724
hardirqs last  enabled at (233723): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (233723): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (233724): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (233618): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (233616): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2e5156
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2cd011 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e1668088 x19: ffff0000e1668040 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff870ec6e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff870ec6f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 240910
hardirqs last  enabled at (240909): [<ffff80008b5a7504>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (240909): [<ffff80008b5a7504>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (240910): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (240782): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (240780): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2dec6b
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2c4ab5 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e16255a8 x19: ffff0000e1625560 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8748c4e x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8748c4f x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 247850
hardirqs last  enabled at (247849): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (247849): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (247850): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (247734): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (247732): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2c7b2c
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2cd602 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e166b010 x19: ffff0000e166afc8 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8715166 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8715167 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 258042
hardirqs last  enabled at (258041): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (258041): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (258042): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (257002): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (257000): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b68d585
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdeb20c x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000def59060 x19: ffff0000def59018 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8785536 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8785537 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 264894
hardirqs last  enabled at (264893): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (264893): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (264894): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (264784): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (264782): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe000195d343c
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdeb407 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000def5a038 x19: ffff0000def59ff0 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff871ffd6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff871ffd7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 271416
hardirqs last  enabled at (271415): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (271415): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (271416): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (271306): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (271304): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 1 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b5a6fb9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdf8011 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000defc0088 x19: ffff0000defc0040 x18: 1fffe000366cb076
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8715f86 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8715f87 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 279158
hardirqs last  enabled at (279157): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (279157): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (279158): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (278720): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (278718): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b696b8a
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdf820c x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000defc1060 x19: ffff0000defc1018 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8c2befe x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8c2beff x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 285224
hardirqs last  enabled at (285223): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (285223): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (285224): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (284756): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (284756): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (284733): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001bdf23b9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001bdf8602 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000defc3010 x19: ffff0000defc2fc8 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8746aae x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8746aaf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 292714
hardirqs last  enabled at (292713): [<ffff80008b5a7504>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (292713): [<ffff80008b5a7504>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (292714): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (292284): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (292282): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001b6e03b9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2d0a0c x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e1685060 x19: ffff0000e1685018 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8746aae x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8746aaf x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 299672
hardirqs last  enabled at (299671): [<ffff80008b4b56a4>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (299671): [<ffff80008b4b56a4>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (299672): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (298620): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (298618): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2b7bb9
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2b82b5 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e15c15a8 x19: ffff0000e15c1560 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8b2e0c6 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8b2e0c7 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 306582
hardirqs last  enabled at (306581): [<ffff8000802c423c>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
hardirqs last  enabled at (306581): [<ffff8000802c423c>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
hardirqs last disabled at (306582): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (306330): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (306330): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (306305): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---
minix_free_block (loop0:20): bit already cleared
minix_free_block (loop0:21): bit already cleared
minix_free_block (loop0:19): bit already cleared
minix_free_block (loop0:22): bit already cleared
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7139 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 0 UID: 0 PID: 7139 Comm: syz-executor Tainted: G        W          6.12.0-syzkaller-00237-g7b1d1d4cfac0-dirty #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff80009dca7a60
x29: ffff80009dca7a60 x28: dfff800000000000 x27: 1fffe0001c2b4127
x26: 1ffff00013b94f54 x25: dfff800000000000 x24: 0000000000000003
x23: 1fffe0001c2b8407 x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000e15c2038 x19: ffff0000e15c1ff0 x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
x14: 1fffffbff8711936 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7fbff8711937 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000de380000 x7 : ffff800080c93b64 x6 : 0000000000000000
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
irq event stamp: 312274
hardirqs last  enabled at (312273): [<ffff80008b5a7504>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]

Tested on:

commit:         7b1d1d4c Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=147e4778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=320c57a47bdabc1f294b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d64778580000


