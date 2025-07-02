Return-Path: <linux-fsdevel+bounces-53691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1AFAF6068
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33C45245D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5E309A7A;
	Wed,  2 Jul 2025 17:52:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCEC309A6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478752; cv=none; b=YX9f/jazpaZm6Q6Uqbhi/Ws+WM/40Dp4mA7Lkj7SpY6jwwF0E6MUvLUv0R0EK3vXgW5EtlX5dxQRocGsaCvFnFN2EyIBxaw7h/Oyq+7P0QsUHHMX3DhiUCpW24QmvElQotZx8FjTW0AhNFuKfeDgK4hjwckNHQFN4oaWmjPy2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478752; c=relaxed/simple;
	bh=jOA51kJs7DdwBvoI/ntKjxR99Kf1zbZd/EaeOozix5o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MxzSdUUYVF3Y4fRo4kd6U61KYt6njKmZTqPjGFEXrFs3LuhwzYaBaylkphYJDUTX8ePhEl6ntna26iMRNc13F3vCDNTUOLjzuGKVcgTMuCuEebrnPLPaEjl7WSh9ogc6V1UH8ZTRJnDci5r5INMgnqfjyLzaSiPIaWLFRfU+G6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3ddc0a6d4bdso57142895ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 10:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751478750; x=1752083550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9ebCc3EYWeZluFr+Gc9V54C8MFuU30Z0OAX4EeeNO4=;
        b=j0sh6GmgCEvHzD8+JCF6HbXk2Z1kgu+x7AtpIRiX+RLvJ4ZZleifIM5+7js7ii6t+U
         9gRolUI43Vs8Tx/NdGdVwj4nVsC91nUS9xaLGTvMu6O2nXZNQ2dJc/EEWiFCqQKpDC0z
         LUhcwjVRaoFM7VfAdJyxMzl/HWNifKEH51nPzUhbyter6FN9n5jEgw9B8g+wCplK6kda
         jWXDijj/8tEqiDhow0mHBECIx3G/CUoHuk5wAeeegBHCqXer5c7RaXKsS1wAXa5eHBE9
         Ll0rwwPDlquyaOp6ciK1zNxMMM5/HhAQWrcLVCJOMbBZcPus5YS1qtx04z7ll6C9FpP8
         WqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXpxP35Akvz7SLR2XjPVpOjXKL7MCPDdQAWjhuLNrp608V/HAMlZqUR/HGLzusCpUkbRrxCyvfu4CzAK0JF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bRfxUW2rt6l5uhTXpBAILQ0IaAkeI2GpgZNy3FaaXokxPEhS
	G/pSFFpRliHEQLGUKP/eQoPndZdaleoCggyVdehHyXERBYESmjMd/pzVYATUog4+2RLcXarbgtt
	uFSfwSSs/DAxlwie4N/9h1XADRnjs3ntLSZVC0J0geZ9coBuoaCOz+5w5E4Y=
X-Google-Smtp-Source: AGHT+IELaBpeQSNieN7/IoYZY894umNormK4Mp6jyBirEua9kaUQPMDz0tLlPmETimVtPfjauGYR0X0XzoCpqw9oMgyrZyedzw0A
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e8:b0:3df:4cf8:dd46 with SMTP id
 e9e14a558f8ab-3e05c31ae79mr7315355ab.10.1751478749817; Wed, 02 Jul 2025
 10:52:29 -0700 (PDT)
Date: Wed, 02 Jul 2025 10:52:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686571dd.a70a0220.2b31f5.0001.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: suspicious RCU usage in proc_sys_compare
From: syzbot <syzbot+268eaa983b2fb27e5e38@syzkaller.appspotmail.com>
To: joel.granados@kernel.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17c4d3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70c16e4e191115d4
dashboard link: https://syzkaller.appspot.com/bug?extid=268eaa983b2fb27e5e38
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15403770580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3d4ef6bedc5b/disk-50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15b7565dc0ef/vmlinux-50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3b397342a62b/bzImage-50c8770a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+268eaa983b2fb27e5e38@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.16.0-rc4-next-20250702-syzkaller #0 Not tainted
-----------------------------
fs/proc/proc_sysctl.c:934 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz-executor/5897:
 #0: ffff888074b98190 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:884 [inline]
 #0: ffff888074b98190 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: lookup_slow+0x46/0x70 fs/namei.c:1824
 #1: ffff88803150c0d0 (&lockref->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88803150c0d0 (&lockref->lock){+.+.}-{3:3}, at: d_wait_lookup fs/dcache.c:2537 [inline]
 #1: ffff88803150c0d0 (&lockref->lock){+.+.}-{3:3}, at: d_alloc_parallel+0xbe4/0x15e0 fs/dcache.c:2624

stack backtrace:
CPU: 0 UID: 0 PID: 5897 Comm: syz-executor Not tainted 6.16.0-rc4-next-20250702-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6871
 proc_sys_compare+0x27d/0x2c0 fs/proc/proc_sysctl.c:934
 d_same_name fs/dcache.c:2179 [inline]
 d_alloc_parallel+0x1060/0x15e0 fs/dcache.c:2637
 __lookup_slow+0x116/0x3d0 fs/namei.c:1793
 lookup_slow+0x53/0x70 fs/namei.c:1825
 walk_component fs/namei.c:2129 [inline]
 link_path_walk+0x935/0xea0 fs/namei.c:2497
 path_openat+0x28c/0x3830 fs/namei.c:4042
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1434
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fb218d211
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d 3a 83 1f 00 00 74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007ffcf4d54bd0 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007f0fb218d211
RDX: 0000000000080001 RSI: 00007f0fb21eeb68 RDI: 00000000ffffff9c
RBP: 00007f0fb21eeb68 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000007
R13: 00007ffcf4d54c70 R14: 0000000000000009 R15: 0000000000000000
 </TASK>


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

