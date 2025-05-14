Return-Path: <linux-fsdevel+bounces-49020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF02AB7916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F032C3AE373
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAE72222CB;
	Wed, 14 May 2025 22:36:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5B282E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262196; cv=none; b=XxvP/SbyEjMDImzPLlcCsEn4UYBSx31xozFgbUEvw4I/1OHAZ3fLaiTvjV8r70gFl2vmPwamgopvZLhCgjU6Nz74wbmdYfW1MwMjtcDQ5j5UfWyeHsD0BsbUBmCeGoGJyd2FquKVVlkRM+5lZvPBc2/XxF8i3KUdtxWWELUjiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262196; c=relaxed/simple;
	bh=b6zdgUuJ4rXNIe4EL0ebNNGZyH7uikVUuAGHICgSmgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HOTeuuTu5vHbGAzivuQXNQ5c7A6E7AdaTUq9g91Nz7fJe3R/ojg/5pdQuxVYUufMNJW51L7IW7yaYILzBa2xR++j4ssHaZYd4xtWcqsu+aavIK8F9V7GQNvqu8OLjvVqRA4lcNkvKknyxLRHtj1yoMi8JouH0Zcb4iqxcbwouns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3da76423b9cso3508075ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 15:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262194; x=1747866994;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HW6sVjwa/8HWvL0DaQEOOA9zmHq3csI2nZnraKHVsEk=;
        b=Y+c5+pq5obeFsUZ2aaCLqoUDyUfVMfxaIjDrhTRgR+dNEm93pgJnnDqfnYeQUTWral
         l98n5AxWgTYIMveYMmmuyJfNAtZa00HHjDdLHKyE6S+j2bXkYJ3swcqiOGE8owY5FeD+
         V9KFPHOjx9QJgFKMowKezqu7djNU881qytVPGQcFOmxdcKeI8MjgBTg5PIxR62BZVOGM
         Qgs7OZ9jRhIkMlp6KdacFVC8kaIIl56wgfKcP9ISkPPr/73vj7nFutX45uq/vvnPOAxA
         WD2puxaJZJsEc1z/Duyj7/0LGYevbE0e/txd+3nKd5diGgEXXJl0LV/SSgITT5fE+r4b
         EbAw==
X-Forwarded-Encrypted: i=1; AJvYcCVK+RqZwvZjp3bB1Pz1t5bP3sV6pGb71Qtxh7cIiQ+eoIrz9nE76eUOod3E/MTU05vvVKd/wIbD4cLSJh9k@vger.kernel.org
X-Gm-Message-State: AOJu0YzOejxe0PckUSJZNgIQt+UpfX2dXLKrVG9LHxQDByuyyyHHv+1X
	GhLsJXhH+pt/kJbczvOtPKclN8O3NRTDx88AILetzb6bUlwpo43Q7OQV7IdHtbiMc+R6JauUv+U
	P3nxjvVFE9lMgGpefbxDFfOc19C8vxIlYNZJQuKtw9pe7Bz3+2Gyep5c=
X-Google-Smtp-Source: AGHT+IEjcvJF6BFL4mc4RYAfI3Nty8HD/KnYqY8mGN3NiM2rXQ3NRh64b0MGI/fse+R9sckS9qtUAawZVj1TsoXrljn6PhTIDlrp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:3d8:2085:a16e with SMTP id
 e9e14a558f8ab-3db6f775d86mr52060035ab.1.1747262193843; Wed, 14 May 2025
 15:36:33 -0700 (PDT)
Date: Wed, 14 May 2025 15:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68251af1.a70a0220.3e9d8.001f.GAE@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel paging request in drop_sysctl_table
From: syzbot <syzbot+0b62957894976d747660@syzkaller.appspotmail.com>
To: joel.granados@kernel.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1a33418a69cc Merge tag '6.15-rc5-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c0ccf4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=925afd2bdd38a581
dashboard link: https://syzkaller.appspot.com/bug?extid=0b62957894976d747660
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160eecf4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/98a89b9f34e4/non_bootable_disk-1a33418a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b719c768f61/vmlinux-1a33418a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37b85c3e7f3b/zImage-1a33418a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b62957894976d747660@syzkaller.appspotmail.com

veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
8<--- cut here ---
Unable to handle kernel paging request at virtual address 74756f78 when read
[74756f78] *pgd=80000080005003, *pmd=00000000
Internal error: Oops: 206 [#1] SMP ARM
Modules linked in:
CPU: 1 UID: 0 PID: 3143 Comm: kworker/u8:2 Not tainted 6.15.0-rc5-syzkaller #0 PREEMPT 
Hardware name: ARM-Versatile Express
Workqueue: netns cleanup_net
PC is at __rb_change_child include/linux/rbtree_augmented.h:199 [inline]
PC is at __rb_erase_augmented include/linux/rbtree_augmented.h:242 [inline]
PC is at rb_erase+0x270/0x394 lib/rbtree.c:443
LR is at 0x0
pc : [<81a3fb58>]    lr : [<00000000>]    psr: 200f0013
sp : df9e5d80  ip : 74756f70  fp : df9e5d94
r10: 82c1f980  r9 : 829d1ec4  r8 : 00000004
r7 : 838d8b00  r6 : 00000001  r5 : 8517c348  r4 : 8517c300
r3 : 74756f72  r2 : 00000000  r1 : 838d8b34  r0 : 8517c368
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 850515c0  DAC: 00000000
Register r0 information: slab kmalloc-128 start 8517c300 pointer offset 104 size 128
Register r1 information: slab kmalloc-128 start 838d8b00 pointer offset 52 size 128
Register r2 information: NULL pointer
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-128 start 8517c300 pointer offset 0 size 128
Register r5 information: slab kmalloc-128 start 8517c300 pointer offset 72 size 128
Register r6 information: non-paged memory
Register r7 information: slab kmalloc-128 start 838d8b00 pointer offset 0 size 128
Register r8 information: non-paged memory
Register r9 information: non-slab/vmalloc memory
Register r10 information: non-slab/vmalloc memory
Register r11 information: 2-page vmalloc region starting at 0xdf9e4000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2844
Register r12 information: non-paged memory
Process kworker/u8:2 (pid: 3143, stack limit = 0xdf9e4000)
Stack: (0xdf9e5d80 to 0xdf9e6000)
5d80: 8517c300 8517c348 df9e5dd4 df9e5d98 80610d54 81a3f8f4 0000000c 600f0013
5da0: ddde099c 600f0013 00000000 03710a8b 8517cb00 84813a00 8517cb00 00000001
5dc0: 8517c300 00000004 df9e5e14 df9e5dd8 80610d88 80610c90 816f4260 829d1ec4
5de0: 829d1ec4 82aca2a8 df9e5e90 03710a8b df9e5e14 84813a00 df9e5e90 829e0224
5e00: df9e5e90 829d1ec4 df9e5e2c df9e5e18 80610e58 80610c90 8517cb00 df9e5e90
5e20: df9e5e3c df9e5e30 81980b1c 80610e3c df9e5e54 df9e5e40 816f45b0 81980b18
5e40: 84951b00 df9e5e90 df9e5e74 df9e5e58 81539cdc 816f45a4 829e0224 82c1f940
5e60: 829d1e80 df9e5e90 df9e5ed4 df9e5e78 8153c160 81539ca8 81a5bd14 8029ce24
5e80: 82c1f940 829d1e80 808c99b0 81539d04 84951b20 84951b20 00000100 00000122
5ea0: 00000000 03710a8b 81c01f84 83b83d80 829d1e98 8301bc00 8300e600 84186000
5ec0: 8301bc15 8300f070 df9e5f2c df9e5ed8 802873bc 8153bebc 81c01a44 84186000
5ee0: df9e5f14 df9e5ef0 829d1e9c 829d1e98 829d1e9c 829d1e98 df9e5f2c 00000000
5f00: 80282cf8 83b83d80 8300e620 8300e600 82804d40 83b83dac 84186000 61c88647
5f20: df9e5f6c df9e5f30 80288004 80287214 81a5bd14 8029ce24 df9e5f6c df9e5f48
5f40: 8028eb98 00000001 84186000 83b83e00 e4935e60 80287e08 83b83d80 00000000
5f60: df9e5fac df9e5f70 8028f07c 80287e14 80274ea8 81a5bc9c 84186000 03710a8b
5f80: df9e5fac 84986300 8028ef50 00000000 00000000 00000000 00000000 00000000
5fa0: 00000000 df9e5fb0 80200114 8028ef5c 00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
Call trace: 
[<81a3f8e8>] (rb_erase) from [<80610d54>] (erase_entry fs/proc/proc_sysctl.c:189 [inline])
[<81a3f8e8>] (rb_erase) from [<80610d54>] (erase_header fs/proc/proc_sysctl.c:225 [inline])
[<81a3f8e8>] (rb_erase) from [<80610d54>] (start_unregistering fs/proc/proc_sysctl.c:322 [inline])
[<81a3f8e8>] (rb_erase) from [<80610d54>] (drop_sysctl_table+0xd0/0x1ac fs/proc/proc_sysctl.c:1514)
 r5:8517c348 r4:8517c300
[<80610c84>] (drop_sysctl_table) from [<80610d88>] (drop_sysctl_table+0x104/0x1ac fs/proc/proc_sysctl.c:1521)
 r8:00000004 r7:8517c300 r6:00000001 r5:8517cb00 r4:84813a00
[<80610c84>] (drop_sysctl_table) from [<80610e58>] (unregister_sysctl_table fs/proc/proc_sysctl.c:1539 [inline])
[<80610c84>] (drop_sysctl_table) from [<80610e58>] (unregister_sysctl_table+0x28/0x38 fs/proc/proc_sysctl.c:1531)
 r8:829d1ec4 r7:df9e5e90 r6:829e0224 r5:df9e5e90 r4:84813a00
[<80610e30>] (unregister_sysctl_table) from [<81980b1c>] (unregister_net_sysctl_table+0x10/0x14 net/sysctl_net.c:177)
 r5:df9e5e90 r4:8517cb00
[<81980b0c>] (unregister_net_sysctl_table) from [<816f45b0>] (sysctl_route_net_exit+0x18/0x38 net/ipv4/route.c:3632)
[<816f4598>] (sysctl_route_net_exit) from [<81539cdc>] (ops_exit_list+0x40/0x68 net/core/net_namespace.c:172)
 r5:df9e5e90 r4:84951b00
[<81539c9c>] (ops_exit_list) from [<8153c160>] (cleanup_net+0x2b0/0x49c net/core/net_namespace.c:654)
 r7:df9e5e90 r6:829d1e80 r5:82c1f940 r4:829e0224
[<8153beb0>] (cleanup_net) from [<802873bc>] (process_one_work+0x1b4/0x4f4 kernel/workqueue.c:3238)
 r10:8300f070 r9:8301bc15 r8:84186000 r7:8300e600 r6:8301bc00 r5:829d1e98
 r4:83b83d80
[<80287208>] (process_one_work) from [<80288004>] (process_scheduled_works kernel/workqueue.c:3319 [inline])
[<80287208>] (process_one_work) from [<80288004>] (worker_thread+0x1fc/0x3d8 kernel/workqueue.c:3400)
 r10:61c88647 r9:84186000 r8:83b83dac r7:82804d40 r6:8300e600 r5:8300e620
 r4:83b83d80
[<80287e08>] (worker_thread) from [<8028f07c>] (kthread+0x12c/0x280 kernel/kthread.c:464)
 r10:00000000 r9:83b83d80 r8:80287e08 r7:e4935e60 r6:83b83e00 r5:84186000
 r4:00000001
[<8028ef50>] (kthread) from [<80200114>] (ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:137)
Exception stack(0xdf9e5fb0 to 0xdf9e5ff8)
5fa0:                                     00000000 00000000 00000000 00000000
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:8028ef50
 r4:84986300
Code: e5903000 e3530003 9a00001b e3c3c003 (e59c2008) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e5903000 	ldr	r3, [r0]
   4:	e3530003 	cmp	r3, #3
   8:	9a00001b 	bls	0x7c
   c:	e3c3c003 	bic	ip, r3, #3
* 10:	e59c2008 	ldr	r2, [ip, #8] <-- trapping instruction


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

