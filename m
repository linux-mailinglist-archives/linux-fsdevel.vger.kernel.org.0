Return-Path: <linux-fsdevel+bounces-17853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744648B2F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 06:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3461C21DBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 04:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E501713A24C;
	Fri, 26 Apr 2024 04:42:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2B139CFE
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106548; cv=none; b=OTcRS26XqwNb8zxuFt06IgwO+v5tMQ3cm6F/k+8TF8bPPqbsLtITTnZTBEy5YX4XfFt/VSsdQZ7/iqR+htxvc0q7ZbP0gc2IiWXVDPPHdak+61Lbcpw0ZebWRdbwK9n24Y+cnWKayfBANO1C8odF8enkIWQn539x3vFEw0pzzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106548; c=relaxed/simple;
	bh=ADLRAnQbB9NsvTAX6kpCXcmg8vWXsE/wlaBD0urQNSA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sP2C8josg5a0w5Qn0KkzrvGaywljGkOBIiJ9zmDfux2cvMKdPO1gUFDW6p7oU+s+RGMAjOhKpzLaswnRDEUft796uVPNXwE7eyWevgwqur033xxT/buDvCP2wXqV+C+dpayHffnZA72Umag0tzYTumEikqVC84XzuGhEXhJMCpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dab89699a8so179489439f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 21:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714106546; x=1714711346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLMyuKda2xPHRkztxdZBggzq4y7PK0nY7x5M6U+fPUQ=;
        b=rmJuo7g1DldDj4czeZpMvWhDooDnI9ALxmuYXPxrLDXg7VZCYIx9ydKQTpVclMay61
         E9vt0gK/NSYbz/aiFjR2ZRZ9qYkrxw5PuYWFMpWKq4ddbuAewses5CGFMco3N1FR30JO
         12GebRf5eLj6ha/T+g/wiSIa744Xt3mxgarY72LIjpzeMkeQAHN35JWRGZ+egvK651mW
         RwKxhAZ7cFWDq314USJPVlC+7HvkMUmZ3LxnfRO0/JGSaKkCF8MPSdYGwRSFPhgVvtIC
         8y9znVjTQqKV1Vj2objh9yU8N4v7To7fjRiYkc9hXplv7LO1cCR0bYy1E1W1rXYzZIte
         FuFw==
X-Forwarded-Encrypted: i=1; AJvYcCXG+NEiM5VRJBot10oja+OtigfRRP+xC2XIq8H08tL98l66RWUZOS4lEcU/nTYClZJBuLlGLSwLWfduPVzWbo/jcRWjyNucajKieMCrxw==
X-Gm-Message-State: AOJu0YxbodoUhdNZhqxyL/MEUY5tMfpiblk8slbD21FOlXBQV9LyuUNN
	ocsmiv67NVs09lnv1ADMjo2sXOcpNMo9t7LjSleMRY13vSbK4CY9m9mw06wV5bdmLuD7WPqj7OR
	tVI+K7hpMH+q40LmA0KZ74XG4UIsfdZdHMNCLJk0XuJetjqUNQUpLIJw=
X-Google-Smtp-Source: AGHT+IHwzRlt52Zv/PA1gArMdk0fM9fBC4PiBmIdglpkx/HW7P+MyeODxpT8hYq45Zvz+2Ua8FgMLgz2VUPs1ik8sPL1rSPVKjtm
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d11:b0:487:3b5a:c97c with SMTP id
 he17-20020a0566386d1100b004873b5ac97cmr90011jab.0.1714106546207; Thu, 25 Apr
 2024 21:42:26 -0700 (PDT)
Date: Thu, 25 Apr 2024 21:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb5a8d0616f8872d@google.com>
Subject: [syzbot] [input?] [ext4?] possible deadlock in uinput_request_submit
From: syzbot <syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com>
To: dmitry.torokhov@gmail.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a07f67180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1273c763180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b59430980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/95b3c106e235/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+159077b1355b8cd72757@syzkaller.appspotmail.com

WARNING: possible circular locking dependency detected
6.9.0-rc4-next-20240418-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor109/5116 is trying to acquire lock:
ffff8880117e3870 (&newdev->mutex){+.+.}-{3:3}, at: uinput_request_send drivers/input/misc/uinput.c:151 [inline]
ffff8880117e3870 (&newdev->mutex){+.+.}-{3:3}, at: uinput_request_submit+0x19c/0x740 drivers/input/misc/uinput.c:182

but task is already holding lock:
ffff888015fb60b0
 (&ff->mutex
){+.+.}-{3:3}
, at: input_ff_upload+0x3e4/0xb00 drivers/input/ff-core.c:120

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (
&ff->mutex){+.+.}-{3:3}
:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       input_ff_flush+0x5e/0x140 drivers/input/ff-core.c:240
       input_flush_device+0x9c/0xc0 drivers/input/input.c:686
       evdev_release+0xf9/0x7d0 drivers/input/evdev.c:444
       __fput+0x406/0x8b0 fs/file_table.c:422
       __do_sys_close fs/open.c:1555 [inline]
       __se_sys_close fs/open.c:1540 [inline]
       __x64_sys_close+0x7f/0x110 fs/open.c:1540
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (
&dev->mutex
#2){+.+.}-{3:3}
:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       input_register_handle+0x6d/0x3b0 drivers/input/input.c:2555
       kbd_connect+0xbf/0x130 drivers/tty/vt/keyboard.c:1589
       input_attach_handler drivers/input/input.c:1064 [inline]
       input_register_device+0xcfa/0x1090 drivers/input/input.c:2396
       acpi_button_add+0x6c6/0xb90 drivers/acpi/button.c:604
       acpi_device_probe+0xa5/0x2b0 drivers/acpi/bus.c:1063
       really_probe+0x2b8/0xad0 drivers/base/dd.c:656
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:798
       driver_probe_device+0x50/0x430 drivers/base/dd.c:828
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1214
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
       bus_add_driver+0x346/0x670 drivers/base/bus.c:673
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       do_one_initcall+0x248/0x880 init/main.c:1263
       do_initcall_level+0x157/0x210 init/main.c:1325
       do_initcalls+0x3f/0x80 init/main.c:1341
       kernel_init_freeable+0x435/0x5d0 init/main.c:1574
       kernel_init+0x1d/0x2b0 init/main.c:1463
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (
input_mutex){+.+.}-{3:3}
:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       input_register_device+0xae5/0x1090 drivers/input/input.c:2389
       uinput_create_device+0x40e/0x630 drivers/input/misc/uinput.c:365
       uinput_ioctl_handler+0x48b/0x1770 drivers/input/misc/uinput.c:904
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0
 (&newdev->mutex
){+.+.}-{3:3}
:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       uinput_request_send drivers/input/misc/uinput.c:151 [inline]
       uinput_request_submit+0x19c/0x740 drivers/input/misc/uinput.c:182
       uinput_dev_upload_effect+0x199/0x240 drivers/input/misc/uinput.c:257
       input_ff_upload+0x5df/0xb00 drivers/input/ff-core.c:150
       evdev_do_ioctl drivers/input/evdev.c:1183 [inline]
       evdev_ioctl_handler+0x17d0/0x21b0 drivers/input/evdev.c:1272
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &newdev->mutex
 --> &dev->mutex
#2 --> 
&ff->mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(
&ff->mutex);
                               lock(&dev->mutex
#2);
                               lock(&ff->mutex
);
  lock(&newdev->mutex
);

 *** DEADLOCK ***

2 locks held by syz-executor109/5116:
 #0: ffff88801cac6110
 (&evdev->mutex
){+.+.}-{3:3}
, at: evdev_ioctl_handler+0x125/0x21b0 drivers/input/evdev.c:1263
 #1: ffff888015fb60b0
 (&ff->mutex
){+.+.}-{3:3}


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

