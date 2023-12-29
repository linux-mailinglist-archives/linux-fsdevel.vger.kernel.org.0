Return-Path: <linux-fsdevel+bounces-7026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF597820138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 20:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F32283898
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Dec 2023 19:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D25134AC;
	Fri, 29 Dec 2023 19:44:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90FD134A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36000996c84so55536665ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Dec 2023 11:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703879060; x=1704483860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xm2JljNeDXjf0r5Jy6i0DIKctQIgzp9TSAs84vX4V2M=;
        b=sxx0Amu63L/MheqJki0vSwxDEnR+zo+XRtW3pppGAdrRUrfg/sna5JDXRcnMsY6ZVI
         LHJJtrbCiPOiinziqXTnoyE4QOtlPxvR3J2pvsPuT5Gdm/vkt3o3hCDC89BEK2YNBFxj
         Cvd5teNwG3MeoySkCwgnmf/J9f6P905Z8BVFFDilnta6iywFfCU/LAqdkhAalWeNve+4
         imLHDTPup5t+zOaH0L/GOiTXC9AosIT6MwifqsSEPjaxlRS7EfMeb0XwVfBxeImnX0Ya
         r/4J9d5D6JPV4J8WJxAl+7vp7/pwJSKdSxV9O/5NKauDWTAijW81WiVyYxF52AQz90Ji
         U23g==
X-Gm-Message-State: AOJu0YxYQKT3H75mSiUgvdSkUtwqMo7vB5b3/Fg1Xdk5yKNPyPok3CWz
	PikHjAsaHbonIpsWp7Gt7Hbfal3oTXS3NOac4V0IhC1DVyCberk=
X-Google-Smtp-Source: AGHT+IF0HebSqY8WUZk+zcQ2hnfh4gQOS06u6BvnDyKIsMITdYf8ZOAcnaFIo5+J0lExPyT7zNwwPmrKSYpXASEYPd1boWbpC1Rz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:35f:edd9:2440 with SMTP id
 j25-20020a056e02219900b0035fedd92440mr1686236ila.4.1703879059990; Fri, 29 Dec
 2023 11:44:19 -0800 (PST)
Date: Fri, 29 Dec 2023 11:44:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c6fbf060dab4271@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel paging request in mmu_notifier_invalidate_range_start
From: syzbot <syzbot+0e7b9b7452ded0356f2d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aafe7ad77b91 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13836436e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23ce86eb3d78ef4d
dashboard link: https://syzkaller.appspot.com/bug?extid=0e7b9b7452ded0356f2d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169f2595e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef73d6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23845238c49b/disk-aafe7ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1144b0f74104/vmlinux-aafe7ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6db20df213a2/Image-aafe7ad7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0e7b9b7452ded0356f2d@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff8000000000d1
KASAN: null-ptr-deref in range [0x0000000000000688-0x000000000000068f]
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
[dfff8000000000d1] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6095 Comm: syz-executor387 Not tainted 6.7.0-rc6-syzkaller-gaafe7ad77b91 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
pc : mmu_notifier_invalidate_range_start+0x80/0x10c include/linux/mmu_notifier.h:455
lr : mmu_notifier_invalidate_range_start+0x60/0x10c include/linux/mmu_notifier.h:454
sp : ffff800096d97a10
x29: ffff800096d97a10 x28: ffff800096d97be0 x27: ffff800096d97bb8
x26: 0000000020ffc000 x25: ffff700012db2f68 x24: 1ffff00012db2f78
x23: dfff800000000000 x22: ffff0000da811e00 x21: dfff800000000000
x20: 0000000000000688 x19: ffff800096d97b60 x18: 0000000000000000
x17: 00000000c0606610 x16: ffff80008a82b25c x15: 0000000020000180
x14: ffff80008e4f0448 x13: dfff800000000000 x12: 00000000050405e5
x11: 00000000d5d3f9bd x10: 0000000000ff0100 x9 : 343472906370af00
x8 : 00000000000000d1 x7 : ffff800080cc5610 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000008 x1 : 0000000000000080 x0 : 0000000000000001
Call trace:
 mm_has_notifiers include/linux/mmu_notifier.h:282 [inline]
 mmu_notifier_invalidate_range_start+0x80/0x10c include/linux/mmu_notifier.h:455
 do_pagemap_scan fs/proc/task_mmu.c:2438 [inline]
 do_pagemap_cmd+0x880/0x11ec fs/proc/task_mmu.c:2494
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
Code: 97f46443 f9400268 911a2114 d343fe88 (38756908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	97f46443 	bl	0xffffffffffd1910c
   4:	f9400268 	ldr	x8, [x19]
   8:	911a2114 	add	x20, x8, #0x688
   c:	d343fe88 	lsr	x8, x20, #3
* 10:	38756908 	ldrb	w8, [x8, x21] <-- trapping instruction


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

