Return-Path: <linux-fsdevel+bounces-18649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B508BAEF5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8DCB23459
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900A15667A;
	Fri,  3 May 2024 14:24:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE45154C16
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714746270; cv=none; b=gNxs8KbcOZEaHYr5iJ8ZNVpLdogh01oWbcGA/WRX1v12jokP9UXfL2oJ/oLpEnc4UbDD64yTqxwLW0+waIedvhdhHJyKcjGHnbv6ALUx24Y4SIdPCEjoObicSxfqkhNT/dZKDmXtl0I+pYLl/Ju6hI6d0pXr2m24/Fy1cWh4VI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714746270; c=relaxed/simple;
	bh=nVXcJHcZXdesKjE8vJRpj0lZ1/+RgYD7tyy8wrtKiRc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eElOF5ZNxDQP/laGkT/m0lodGb8CJ8KwI2ACYh+D4JxvSeQDXwr/DXBmI3SAOTo5amhe0mrnf0wHhOyBN5PIzLqeJtLfNGEEj9JoR0vvfE3azbzdBzF2li02wYsuUKP/9wgjA/Z0Eh4ntcwN0bxpCHGCLmCRjYb1NO51VpFMNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so990184739f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 07:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714746268; x=1715351068;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1rCHm96AiJhRq3rpvqRExVN/wMvxevJc+nhep5CfRs=;
        b=wkSVs5po1pOqLhR0WyFtdDXh4lc0T9jGCMuXLn/8bN1gy5D5+y46rKKibJxiOaG3QG
         enzqZuX7grL2rPzJcuMQXl0tEGweuVuWnXeWBd0F0bg/huIBCL4xSSjV1ne1/ITEH8MY
         CWP5QO6TMpOLUUo9Jiq3dMxTEHzXyapVUbWZzc6T0W96+FI8H9TysR45+8mEse9SeZLp
         69NTVHfF0PZ9CD3mijCUgsk0Bv318q6QvYBqsYBzMLl9c4esWG8C0GPNSDuGbixl4HRQ
         9h2bMe5T5ZmAhNv+M5kGZqSwdnTUtBc2huJm4rvJg/geb8EbSpTY1FzZA+XyM6omNY8t
         WqYA==
X-Forwarded-Encrypted: i=1; AJvYcCUfQodZHtXIydeiTNJKncx0RJ0HyugCahLZ9N3CrfxO6zQz41nSApu4JqC28G09DP/0bQsmZ+u8ht5oBpB8NDUeRK2o5SCC6LAwXJVghQ==
X-Gm-Message-State: AOJu0YwkXFf7ld9rGb8XUdPv51r/rJrdrSJ2lhvYrwnifCvfWsrZKj3b
	+lM6jTyN2LVHPSdmHPon+9ocp8o6d7ZPDg5K4LdQ1gE/8KFR7NPQtRMddBFj7xBfUGtbNvqhME/
	rDPqMCEIs8tvmUBEGhzyIV61Fnt/f1oq3B6vdzj5sK3XT0UJGpApw9x8=
X-Google-Smtp-Source: AGHT+IFvqLmMgYZls/CBXxPOB4E2J7JTnZPI5bKV+raQMke2LclpyYp29bASoj4Vkqi4AHNVQ3qtxMiFMpTUVJ53Ku31oig1E3w/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:36c:4d81:8656 with SMTP id
 h24-20020a056e021d9800b0036c4d818656mr165011ila.0.1714746268271; Fri, 03 May
 2024 07:24:28 -0700 (PDT)
Date: Fri, 03 May 2024 07:24:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003355e706178d7a8a@google.com>
Subject: [syzbot] [bcachefs?] WARNING in __virt_to_phys (3)
From: syzbot <syzbot+3333603f569fc2ef258c@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=119f5f18980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=3333603f569fc2ef258c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3333603f569fc2ef258c@syzkaller.appspotmail.com

------------[ cut here ]------------
virt_to_phys used for non-linear address: fffffffffffff75e (0xfffffffffffff75e)
WARNING: CPU: 1 PID: 9858 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
Modules linked in:
CPU: 1 PID: 9858 Comm: syz-executor.4 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
lr : __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
sp : ffff80009adf6e00
x29: ffff80009adf6e00 x28: 1ffff000135bee02 x27: fffffffffffff75e
x26: ffff80009adf7010 x25: ffff7000135bedf4 x24: dfff800000000000
x23: ffff000130f00000 x22: 000f600000000000 x21: 000000000000002d
x20: fffffffffffff75e x19: 000ffffffffff75e x18: 1fffe000367bdd96
x17: ffff80008ee7d000 x16: ffff800080333fec x15: 0000000000000001
x14: 1fffe000367c0990 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000001 x10: 0000000000000003 x9 : 56d29d05a132eb00
x8 : 56d29d05a132eb00 x7 : ffff8000802aabc8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008afdfb40 x0 : ffff80012501d000
Call trace:
 __virt_to_phys+0xc4/0x138 arch/arm64/mm/physaddr.c:12
 virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
 virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
 virt_to_folio include/linux/mm.h:1304 [inline]
 kfree+0xa4/0x3e8 mm/slub.c:4382
 bch2_fs_recovery+0x32c/0x4854 fs/bcachefs/recovery.c:902
 bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1042
 bch2_fs_open+0x8b4/0xb64 fs/bcachefs/super.c:2101
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1900
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 76030
hardirqs last  enabled at (76029): [<ffff8000802aac68>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1397 [inline]
hardirqs last  enabled at (76029): [<ffff8000802aac68>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5163
hardirqs last disabled at (76030): [<ffff80008ae6da08>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:470
softirqs last  enabled at (75882): [<ffff8000800218e4>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (75882): [<ffff8000800218e4>] __do_softirq+0xb10/0xd2c kernel/softirq.c:583
softirqs last disabled at (75823): [<ffff80008002ad34>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffffffffc37affc8
KASAN: maybe wild-memory-access in range [0x0003fffe1bd7fe40-0x0003fffe1bd7fe47]
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
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001ad5bd000
[ffffffffc37affc8] pgd=0000000000000000, p4d=00000001b0d98003, pud=00000001b0d99003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 9858 Comm: syz-executor.4 Tainted: G        W          6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:247 [inline]
pc : virt_to_folio include/linux/mm.h:1306 [inline]
pc : kfree+0xbc/0x3e8 mm/slub.c:4382
lr : virt_to_phys arch/arm64/include/asm/memory.h:368 [inline]
lr : virt_to_pfn arch/arm64/include/asm/memory.h:382 [inline]
lr : virt_to_folio include/linux/mm.h:1304 [inline]
lr : kfree+0xa4/0x3e8 mm/slub.c:4382
sp : ffff80009adf6e30
x29: ffff80009adf6e40 x28: 1ffff000135bee02 x27: fffffffffffff75e
x26: ffff80009adf7010 x25: ffff7000135bedf4 x24: dfff800000000000
x23: ffff000130f00000 x22: 0000000000000001 x21: ffffffffc37affc0
x20: ffff80008293e95c x19: fffffffffffff75e x18: 1fffe000367bdd96
x17: ffff80008ee7d000 x16: ffff800080333fec x15: 0000000000000001
x14: 1fffe000367c0990 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000040000 x10: 000000000003ffff x9 : 00003e00037affc0
x8 : ffffc1ffc0000000 x7 : ffff8000802aabc8 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff80008afdfb40 x0 : 000080011ebff75e
Call trace:
 virt_to_folio include/linux/mm.h:1304 [inline]
 kfree+0xbc/0x3e8 mm/slub.c:4382
 bch2_fs_recovery+0x32c/0x4854 fs/bcachefs/recovery.c:902
 bch2_fs_start+0x30c/0x53c fs/bcachefs/super.c:1042
 bch2_fs_open+0x8b4/0xb64 fs/bcachefs/super.c:2101
 bch2_mount+0x558/0xe10 fs/bcachefs/fs.c:1900
 legacy_get_tree+0xd4/0x16c fs/fs_context.c:662
 vfs_get_tree+0x90/0x288 fs/super.c:1779
 do_new_mount+0x278/0x900 fs/namespace.c:3352
 path_mount+0x590/0xe04 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __arm64_sys_mount+0x45c/0x594 fs/namespace.c:3875
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
Code: 927acd29 f2d83fe8 cb151929 8b080135 (f94006a8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	927acd29 	and	x9, x9, #0x3ffffffffffffc0
   4:	f2d83fe8 	movk	x8, #0xc1ff, lsl #32
   8:	cb151929 	sub	x9, x9, x21, lsl #6
   c:	8b080135 	add	x21, x9, x8
* 10:	f94006a8 	ldr	x8, [x21, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

