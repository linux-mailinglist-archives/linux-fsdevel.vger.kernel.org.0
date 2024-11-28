Return-Path: <linux-fsdevel+bounces-36051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE9C9DB491
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 10:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB9AB21242
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F46155389;
	Thu, 28 Nov 2024 09:07:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CD1547E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732784845; cv=none; b=gNSouPFooP3qdcH6lgy46KZFArsWpjfn/NTarajlAgLVQ9O1ceMlDmFtqxuk3gMWh9WuGAbFlg7P89Wc+acTUswhAo8Z81pKG7Ef/+uSR+O1cc7MH6e9szhogZm2h1MpKoMOiY9bod/DbYOckuTVU1dIZfswyhsVDM+sYiPMkq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732784845; c=relaxed/simple;
	bh=SPXbvgRpSUPKNeuCmCZ4GEbx9xuC0Y9jezQfKH53BTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bGadwoISiIrG9f6XXNe9xPPgRULKZZt7pxHaOlyFS9QlkofrAV1k4Ll6qcPcstI8G8m2JryKmibPY+10TVFBWQ/hZYol4SYg69uEbUMb+s7XLi/tbAUlOR9IkmmQksq867XZzCyEym5rMMXFcp3yJiZ5WksGXFlMlg80zMwdhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a787d32003so6212835ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 01:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732784843; x=1733389643;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6TE4e4Bb5OrTmbFbuc0RLRJY6XYdoSFPb2NDKZfHFA=;
        b=td9DUE/GghrHf7RuTOUDRAiSMOq1kkn2Coj8fiSbYzRhd+gFNXBB8/ouhRyNsbCxff
         KPDa9CVm3Zib5F4BjwrVcCA09EDU7lr62TD4rls3fNn4axFza8v0fJUE7tmF30VBre7p
         q3Idedey2yYlgHUKODQzvvHvhemntXHaAXdxpd/N7iXO8HejpjPyAOKY0uqE7EP1iGNA
         k3IYD1i9sm5CteYu8TsYpLidum7czdGtKVG77oxxQAkD1fqv6xM4d5DKr8Kf4u2OYnzu
         ib2Vc+vFuUFcsZX8PB0pHgSp5NaSnjRTNPy7jKh5NcZ1w1xYjgJ4j7dCSI+QCW1GsX/Q
         maCg==
X-Forwarded-Encrypted: i=1; AJvYcCWlBop4xcPRtHDcdOuSpi8H9EvSXWC37+jfiVsr2S4ryHxVqE0n+GDONptH6Pd0QQz3w5ZGTItMGfFE2emt@vger.kernel.org
X-Gm-Message-State: AOJu0YyHWsEaTJtJQTBCcnsvcAWLczEMM0X0vxef2nmXZ8nbnxdYUr38
	i5zUHjjWZz3qy0PO0uqGaajM743XA7pFXavwRvzVpktIP+DCN/yNK+RzNKNnSBlT4R9ZqEZirff
	Kejsswn0zF53dda7iH0W+Cz8HOdhmor8aCzT6u2UoGWuMLXX+VPWTCMQ=
X-Google-Smtp-Source: AGHT+IGl4NsuasVX4CbzS7/Pe1vbj3ipLwcVldBd2NiLWYDrblcA4ibVU7akFLUQYOZfzOGEWFcXG4q5HcnQ35CN/HzSEDayr92b
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3702:b0:3a7:c5ca:ac9f with SMTP id
 e9e14a558f8ab-3a7c5caad62mr72505205ab.6.1732784843472; Thu, 28 Nov 2024
 01:07:23 -0800 (PST)
Date: Thu, 28 Nov 2024 01:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674832cb.050a0220.253251.007a.GAE@google.com>
Subject: [syzbot] [ocfs2?] WARNING in poll_select_finish
From: syzbot <syzbot+15f68436afaf0cc3af11@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=127619c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=15f68436afaf0cc3af11
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12368530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c8d5f19b6cc3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15f68436afaf0cc3af11@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6595 at include/linux/sched/signal.h:548 restore_saved_sigmask_unless include/linux/sched/signal.h:548 [inline]
WARNING: CPU: 0 PID: 6595 at include/linux/sched/signal.h:548 poll_select_finish+0x71c/0x7e0 fs/select.c:301
Modules linked in:
CPU: 0 UID: 0 PID: 6595 Comm: syz.0.15 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : restore_saved_sigmask_unless include/linux/sched/signal.h:548 [inline]
pc : poll_select_finish+0x71c/0x7e0 fs/select.c:301
lr : restore_saved_sigmask_unless include/linux/sched/signal.h:548 [inline]
lr : poll_select_finish+0x71c/0x7e0 fs/select.c:301
sp : ffff8000a02e7b20
x29: ffff8000a02e7c20 x28: dfff800000000000 x27: 0000000000000000
x26: ffff70001405cf6c x25: 0000000000000002 x24: ffff8000a02e7ce0
x23: 0000000000000008 x22: ffff8000a02e7ba0 x21: ffff0000d55cbc80
x20: 0000000000000008 x19: 00000000fffffdfe x18: 1fffe000366c6876
x17: ffff80008f81d000 x16: ffff80008b3edfc8 x15: 0000000000000002
x14: 1ffff0001405cf74 x13: 0000000000000000 x12: 0000000000000000
x11: ffff70001405cf76 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d55cbc80 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000010
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 restore_saved_sigmask_unless include/linux/sched/signal.h:548 [inline] (P)
 poll_select_finish+0x71c/0x7e0 fs/select.c:301 (P)
 restore_saved_sigmask_unless include/linux/sched/signal.h:548 [inline] (L)
 poll_select_finish+0x71c/0x7e0 fs/select.c:301 (L)
 __do_sys_ppoll fs/select.c:1122 [inline]
 __se_sys_ppoll fs/select.c:1101 [inline]
 __arm64_sys_ppoll+0x2d8/0x358 fs/select.c:1101
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 796
hardirqs last  enabled at (795): [<ffff80008b4b56a4>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (795): [<ffff80008b4b56a4>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (796): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (752): [<ffff80008002f3d8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (750): [<ffff80008002f3a4>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


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

