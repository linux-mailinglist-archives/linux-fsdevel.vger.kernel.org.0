Return-Path: <linux-fsdevel+bounces-24042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6032938221
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 18:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37900281BCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 16:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12F14389C;
	Sat, 20 Jul 2024 16:36:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03CC147
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721493389; cv=none; b=jZnH8Fy82qsweF6k9Gao7yvPqxM7pTv3iT+LJ1UyCdw1TmLg0nhnD0FaagG7MBIek3gh+mzkDZ9DtZnOnbueU7nWYpCrygI4/ISfODj3iIngOj2Hofua/BDFxpOCOXM3s8lIjjLKq1s2by1mn5UxM5H+efB1MhSVR79pUBLKCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721493389; c=relaxed/simple;
	bh=x5nZpoUxWlYkOK2CPdfk4iiMxOM1shVSNdgSQUw+92M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EPe3/Z0A8AhfAKULz1MUPyufpzSBLrRkX65xszee/+RgrN7/ZhM6hi9RpT/MKO3J2DbbJw+biHOUpD7o3o+gB9klEF+YVmR6gxEL/Lqrkn7Dn6ogj32JnV1Z+BaodLF3O22kKzh5CaQHXqmq+7K+GNsaV5v/7LVrZOm8gjNAWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8036e96f0caso437859039f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 09:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721493387; x=1722098187;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LRGN3kJB9SgmQiPPP6CQ92MgXVNbAynRSv+V3pl0fvk=;
        b=jhmW6olPPSOvLJn5EHBuioab3cyovIDm88a1PQq8lr02ggVPVbtNue9W8U1S3xCmx/
         ZoEXYI9Gre5psEhUI/8L/3GlPSCpDFtBAJJfaTYJbb7+LSeIc0vbmns1RfMwZaY0NxCL
         SX/ALOLytbz9T75wn9m0jx2c6cRaqLy36xDwXXnS5+c0hT+cngWfuCkOsqBP2pIbZ9bi
         BuL+LCquH3BKGqc8SLPLkbQ85oHWZeH1iwOsJkSINReFlZiHvMxxAgaD6Ug7q1nBnlEk
         vCof4nfsNWP2F347gFpa/d6IBdSRKMS+CRyZ9CSFDCM38UPuBQ/fLb8UiPMQL/Bwa1G2
         RgYw==
X-Forwarded-Encrypted: i=1; AJvYcCUAYHfbVtnCLJVhw+IyqrbASIohZAii+UFyUGvn88Amgg/f/RbYEyc4eMBh0oVAkhb+f1acvAz29TXO8I5F/mETyCCMeKztK9hw0vImNg==
X-Gm-Message-State: AOJu0YwGmENIkdSvfu1EftBJpwuzDitXHBZYsIu3FS7BurgAPbP8Q+7K
	o4NIpWfVLEPH5J0Uoe4rzfj9x6pQvdQuvSKlKzvcxbGlpMsIfZeMkzKkOor3dAjfbkU1tIAyTtQ
	a0Jq4J+dEsSLi2mQIxrBF+HVWkyr4nTww3RFa4cfo0yvoBCgz58fD6es=
X-Google-Smtp-Source: AGHT+IGjvJKcM7jZdVlU2SWo8vovQgsGjivjSO7/frs+yHbtpnd2MrQj+FTU17qAB6FQCb7onaps9sBN+J630X+jlIc8JpnFRusm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1607:b0:4b9:e776:675 with SMTP id
 8926c6da1cb9f-4c23fb24492mr193099173.0.1721493386915; Sat, 20 Jul 2024
 09:36:26 -0700 (PDT)
Date: Sat, 20 Jul 2024 09:36:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf8462061db0699c@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in path_from_stashed
From: syzbot <syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1325e60d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1c1b0a8065e216
dashboard link: https://syzkaller.appspot.com/bug?extid=34a0ee986f61f15da35d
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bd9a5e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15726e95980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a129ae4ab997/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9339fe082652/zImage-51835949.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000008 when read
[00000008] *pgd=844c0003, *pmd=fe12e003
Internal error: Oops: 205 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 3011 Comm: syz-executor103 Not tainted 6.10.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at path_from_stashed+0x1c/0x308 fs/libfs.c:2204
LR is at open_namespace+0x44/0xbc fs/nsfs.c:102
pc : [<8053af54>]    lr : [<8054d6f8>]    psr: 80000013
sp : df959e80  ip : 84183000  fp : df959ec4
r10: 84183000  r9 : 00000003  r8 : 843f3300
r7 : 82caa250  r6 : 84183000  r5 : 00000000  r4 : 82625878
r3 : df959ecc  r2 : 00000008  r1 : 82c95800  r0 : 00000008
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 843f1a00  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: slab kmalloc-1k start 82c95800 pointer offset 0 size 1024
Register r2 information: non-paged memory
Register r3 information: 2-page vmalloc region starting at 0xdf958000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2780
Register r4 information: non-slab/vmalloc memory
Register r5 information: NULL pointer
Register r6 information: slab task_struct start 84183000 pointer offset 0 size 3072
Register r7 information: slab mnt_cache start 82caa240 pointer offset 16 size 184
Register r8 information: slab filp start 843f3300 pointer offset 0 size 160
Register r9 information: non-paged memory
Register r10 information: slab task_struct start 84183000 pointer offset 0 size 3072
Register r11 information: 2-page vmalloc region starting at 0xdf958000 allocated at kernel_clone+0xac/0x3e4 kernel/fork.c:2780
Register r12 information: slab task_struct start 84183000 pointer offset 0 size 3072
Process syz-executor103 (pid: 3011, stack limit = 0xdf958000)
Stack: (0xdf959e80 to 0xdf95a000)
9e80: 841b2400 00000008 df959eb4 df959e98 806e6544 804065ac 00000009 82625878
9ea0: 00000000 84183000 841b2c80 843f3300 00000003 84183000 df959ef4 df959ec8
9ec0: 8054d6f8 8053af44 df959ef4 00000000 00000000 f9244696 82625878 82625878
9ee0: 841b2400 00000008 df959f14 df959ef8 8055271c 8054d6c0 0000ff07 00000000
9f00: 843f3300 00000000 df959fa4 df959f18 8051a7f0 805525a4 000001b2 8020029c
9f20: 84183000 000001b2 df959fac df959f38 8020ba70 8042c724 83f01500 df959f80
9f40: 00000000 843f3300 00000003 82cb0800 df959f7c df959f60 805283b8 8027aebc
9f60: 83f01500 00000003 83f01500 00000003 df959fa4 f9244696 8026b8b0 00000000
9f80: 00000000 0008e058 00000036 8020029c 84183000 00000036 00000000 df959fa8
9fa0: 80200060 8051a6c8 00000000 00000000 00000003 0000ff07 00000000 00000000
9fc0: 00000000 00000000 0008e058 00000036 7ee54e0c 00000000 00000001 00000000
9fe0: 7ee54c70 7ee54c60 0001064c 0002e7a0 00000010 00000003 00000000 00000000
Call trace: 
[<8053af38>] (path_from_stashed) from [<8054d6f8>] (open_namespace+0x44/0xbc fs/nsfs.c:102)
 r10:84183000 r9:00000003 r8:843f3300 r7:841b2c80 r6:84183000 r5:00000000
 r4:82625878
[<8054d6b4>] (open_namespace) from [<8055271c>] (pidfd_ioctl+0x184/0x4c4 fs/pidfs.c:196)
 r6:00000008 r5:841b2400 r4:82625878
[<80552598>] (pidfd_ioctl) from [<8051a7f0>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80552598>] (pidfd_ioctl) from [<8051a7f0>] (do_vfs_ioctl fs/ioctl.c:861 [inline])
[<80552598>] (pidfd_ioctl) from [<8051a7f0>] (__do_sys_ioctl fs/ioctl.c:905 [inline])
[<80552598>] (pidfd_ioctl) from [<8051a7f0>] (sys_ioctl+0x134/0xda4 fs/ioctl.c:893)
 r7:00000000 r6:843f3300 r5:00000000 r4:0000ff07
[<8051a6bc>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xdf959fa8 to 0xdf959ff0)
9fa0:                   00000000 00000000 00000003 0000ff07 00000000 00000000
9fc0: 00000000 00000000 0008e058 00000036 7ee54e0c 00000000 00000001 00000000
9fe0: 7ee54c70 7ee54c60 0001064c 0002e7a0
 r10:00000036 r9:84183000 r8:8020029c r7:00000036 r6:0008e058 r5:00000000
 r4:00000000
Code: e24dd01c e1a07001 e5911004 ee1dcf70 (e5905000) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	e24dd01c 	sub	sp, sp, #28
   4:	e1a07001 	mov	r7, r1
   8:	e5911004 	ldr	r1, [r1, #4]
   c:	ee1dcf70 	mrc	15, 0, ip, cr13, cr0, {3}
* 10:	e5905000 	ldr	r5, [r0] <-- trapping instruction


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

