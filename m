Return-Path: <linux-fsdevel+bounces-59366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F9B38359
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FD7C659B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8AF350D68;
	Wed, 27 Aug 2025 13:07:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25611DFE22
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300054; cv=none; b=nTpgkEkLgWCK1oI8BHbH5ti/4wySXYrGA/BomoMHmMq7J6KHqA7KU6I5f+yqUgW+Yvn3dIq/5x9hNiFc8c/Q5dUE/HOUIpT4izKON+fSV5kStbrzKLBvIlghglE7SzQRBDc1SR35uC4V3/V1TkkV11JRP4WXhtdRCKuaP1M2pPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300054; c=relaxed/simple;
	bh=uhZEyNjpgt2nKhG1FnpuwlfVRtd/DA2+sMMguQJJMic=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kNfrRKhFvZhzezXlhx6hOVOu2lls14Sxlcek5kQ9tQJ3zm5Y42yBLxkxmip5pLQXgMaqpdxSNJIJaq0oLMg/qugMhWsJGm0KaDz7qocQPLEMQXOln/vsHYMemm+YK7b+B+kWJjVYdhyIijTKBtsvsXfzJbN5zkuZihD/5KhDsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-886e2e808e8so590262339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 06:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756300052; x=1756904852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqAAZ2PNKYljta7EnxR4rGO0uElyvx3egJwvBQhHbdA=;
        b=cKq8Ec0xxvAnY3KLibxOkhEHwZ4Aqb/oYgUp4RE/AG0v5cO90zQYwtETyGFW8Lf1sM
         3FVtn59dcHw7toD1/NoHjM/kcSW5QxL/SS8C0nOF5zQyoZg107Ue1+WzN+3b/Inj+EYw
         jyZY2wRiofHC0TAUqWiIUJw2Nnc6Popl8K0/PUpNdOwcTZ+sm4G6sDZBu9rfpd6Gp5PP
         yrUDY2TC07L1gCeWwFzJpOI6fsFV01Ig8D5loUOI1a9OBGg6XIT74j+BvfcVuAXDElDZ
         EIBXPR+lSh1gL8wIXqDN95VK2a7i4NvoApvQ7/TPHAtZNFPh3pvhoi1ykSAQCOWjtcyK
         gzag==
X-Forwarded-Encrypted: i=1; AJvYcCWJpeX1klT9GkkLJkwn1g+weXhKI7iPRHl6mYyXT2Hqqlgr/hcfXc8WvzUl32j50q2yDAsAzaDkxn6GoSU/@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSTlsMy2b9E5KVhLX83Vir6I2ugU/CXtQgb8GRTQ1sxAKSBRy
	vt4nPVSC+uAGfKCO+x4ZWOn1VVXC9Rn4gOeD4/iVUIEZRXokzI+ohzi7JwwTjxG8Ctp825bS7hc
	xY7xrDqqSEt0yc7Oy5LimsKZnA/liT41E56TyRCpv7FcbH46PSfN0DQKn2u4=
X-Google-Smtp-Source: AGHT+IEqs+daARbh9yMs35OsmplpX2B5BTuI9FVSQSDfBuhtSnWgP2j53rMkalQByvr/nOab0ANgDGAkdG0Vxgcbi+gNsSs4qV5l
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3eb:2b11:441d with SMTP id
 e9e14a558f8ab-3eb2b1146bdmr213821075ab.15.1756300051987; Wed, 27 Aug 2025
 06:07:31 -0700 (PDT)
Date: Wed, 27 Aug 2025 06:07:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af0313.a70a0220.3cafd4.0020.GAE@google.com>
Subject: [syzbot] [block?] [ext4?] [btrfs?] INFO: rcu detected stall in
 sys_mount (8)
From: syzbot <syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com>
To: brauner@kernel.org, clm@fb.com, dsterba@suse.com, jack@suse.cz, 
	josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a85ef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=4507914ec56d21bb39ed
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1455a462580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12229462580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/47be3ab62135/mount_6.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [syz.0.563:8489]
Modules linked in:
irq event stamp: 251614
hardirqs last  enabled at (251613): [<ffff80008b028df8>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (251613): [<ffff80008b028df8>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (251614): [<ffff80008b001cbc>] __el1_irq arch/arm64/kernel/entry-common.c:650 [inline]
hardirqs last disabled at (251614): [<ffff80008b001cbc>] el1_interrupt+0x24/0x54 arch/arm64/kernel/entry-common.c:668
softirqs last  enabled at (251590): [<ffff8000803d88a0>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (251590): [<ffff8000803d88a0>] handle_softirqs+0xaf8/0xc88 kernel/softirq.c:607
softirqs last disabled at (251581): [<ffff800080022028>] __do_softirq+0x14/0x20 kernel/softirq.c:613
CPU: 1 UID: 0 PID: 8489 Comm: syz.0.563 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : skip_mnt_tree fs/namespace.c:-1 [inline]
pc : commit_tree fs/namespace.c:1201 [inline]
pc : attach_recursive_mnt+0x1414/0x19f0 fs/namespace.c:2716
lr : skip_mnt_tree fs/namespace.c:1184 [inline]
lr : commit_tree fs/namespace.c:1201 [inline]
lr : attach_recursive_mnt+0x1430/0x19f0 fs/namespace.c:2716
sp : ffff8000a0de7960
x29: ffff8000a0de7a60 x28: ffff0000df3956c0 x27: dfff800000000000
x26: ffff0000d65d31c0 x25: ffff0000d65d3180 x24: ffff0000d931d600
x23: ffff0000df3956c0 x22: ffff0000df395500 x21: ffff0000d65d2e41
x20: ffff0000f39e5ab0 x19: ffff0000f39e5ab0 x18: 1fffe000337a0688
x17: ffff0001fea8c8b0 x16: ffff80008afd3190 x15: 0000000000000002
x14: 1fffe0001be72ae1 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001be72ae3 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : 0000000000000000
x2 : 0000000000000008 x1 : ffff0000d65d31c0 x0 : ffff0000f39e5aa8
Call trace:
 skip_mnt_tree fs/namespace.c:-1 [inline] (P)
 commit_tree fs/namespace.c:1201 [inline] (P)
 attach_recursive_mnt+0x1414/0x19f0 fs/namespace.c:2716 (P)
 graft_tree+0x134/0x184 fs/namespace.c:2862
 do_loopback+0x334/0x3e8 fs/namespace.c:3037
 path_mount+0x4cc/0xde0 fs/namespace.c:4114
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount fs/namespace.c:4321 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4321
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6164 Comm: udevd Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __sanitizer_cov_trace_pc+0x80/0x84 kernel/kcov.c:235
lr : path_init+0xdc0/0xe98 fs/namei.c:2537
sp : ffff8000a43e7740
x29: ffff8000a43e77a0 x28: dfff800000000000 x27: 1fffe00018f95664
x26: ffff0000c7cab320 x25: 0000000000000101 x24: 1ffff0001487cf5b
x23: ffff80008f745840 x22: ffff8000a43e7adc x21: 0000000000000100
x20: ffff8000a43e7aa0 x19: 0000000000032fab x18: 0000000000000000
x17: 0000000000000000 x16: ffff80008b007230 x15: 0000000000000001
x14: 1ffff00011ee8b08 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700011ee8b09 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000d8babd00 x7 : ffff800080daa4c4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800080da8a84
x2 : 0000000000000000 x1 : 0000000000000004 x0 : 0000000000000001
Call trace:
 __sanitizer_cov_trace_pc+0x80/0x84 kernel/kcov.c:235 (P)
 path_openat+0x13c/0x2c40 fs/namei.c:4041
 do_filp_open+0x18c/0x36c fs/namei.c:4073
 do_sys_openat2+0x11c/0x1b4 fs/open.c:1435
 do_sys_open fs/open.c:1450 [inline]
 __do_sys_openat fs/open.c:1466 [inline]
 __se_sys_openat fs/open.c:1461 [inline]
 __arm64_sys_openat+0x120/0x158 fs/open.c:1461
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596


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

