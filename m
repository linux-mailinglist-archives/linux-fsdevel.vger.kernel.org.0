Return-Path: <linux-fsdevel+bounces-20333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2AA8D187C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319E2286C57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF816B73D;
	Tue, 28 May 2024 10:24:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6616ABD7
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891872; cv=none; b=XEJ5bknuuapK/cKMIjhBLNlGTihUzkU+svqyFWYBfPdqGawxCUFqk3pe8q6kjCL9OkJ8UuNvJA2YFrEWKaEvlivKFNKl3gKMku4/De38bQrBJyAzEelWfmVB5/F99ss3jN84tODDaXVYAHUEKUDCIMO2UAT5d1e8WvFWOjblnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891872; c=relaxed/simple;
	bh=31OGuaV9aenUbYstvP3OWUzHmKJ/s7yx5CfFt82fx6g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TU8tDY7QROlvVjmRjmn2eOa2o424sphZlWXh9UmfEeqY3HBJcIcOdbNtmvqwBsEyx4wssW/O1ukVWsNPRwOXg2d1Nh5rDb3KKm1C4WNKBGhdWKm4RACpUcOFSXFZVzHcvYqtH4jg4w48LxIXr4rv0Z9ZomXxcIdUDMWEeyuVhfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7eac4d26336so81054639f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 03:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716891870; x=1717496670;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQWTSLy1P083So9rNiEd0kJbhrBWsk01pnRr27WGpzI=;
        b=QenCy/rlEOhmueYGc4ev6AK181THMObpCyihhtJtdApcL2dPp2/Gzk37o534r+iPW0
         K/eFheHmza5GWd52T+dRz5NTS1yPelb31IG8IteHFv31kLAy0xRLWY0LSPbbmtpMvxGx
         /uRTh3G9P9ibuLYVtCT8kVstYHIT0OEdnJP39SAqLdIpNpBeR09iXakP8bTZWBlQp1E7
         8E51KMWwQSuwHvK1CQtPFtPw97GHLXo2H7287KmBw72x9NVYl4GSOuDD0haER2uFfXeT
         xIu8+BGVcP/Cylg/OQRLsQM51hKtBBbvi6Ttp5652UgzoOHkyVPq3JS18CbbLBQxJPUJ
         AD3w==
X-Forwarded-Encrypted: i=1; AJvYcCXbBGrgfPY9l2CFaCiHMLC4tZbaZkAwFipzKOjQJGYquWbj5DwtDoWYewhkyM7PdiU3YtzUfr1exMjwNraisngNJKIarB7YxfDBIt/yyQ==
X-Gm-Message-State: AOJu0Yzmu2ZWs/Gz/DHedw8G+JDH7aVLJR5AnPBmkvi6667zJsERnEZR
	8lS6WDVEVJA8vgdgfSUU/GgmM95MqKY7nHvr5yQskllNKT+2YmcTmUKexwbRqatDbxv7jiFL/t1
	xm+qf02By91RKRbkQxeUgLKMyVQ041MVgCgjlrkClA5VzL8ymM8ab1a8=
X-Google-Smtp-Source: AGHT+IEA1yjeVzYff20hYz3dpAq2rdmd7ayPkp3OjIeHTBR97cXcpfVxXBUAA+MkE0kWKd5QOBWOKZa7TWFztFbU+KB4Ey6E9+YH
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d5:b0:7da:5250:5bf8 with SMTP id
 ca18e2360f4ac-7e8c73e7d2fmr66795439f.4.1716891870319; Tue, 28 May 2024
 03:24:30 -0700 (PDT)
Date: Tue, 28 May 2024 03:24:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c68660619810ae1@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in sock_map_update_common (2)
From: syzbot <syzbot+ec4e4d5b7c4c6e654865@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f980f13e4eb2 bpf, docs: Clarify call local offset
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13826cd8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4e4d5b7c4c6e654865
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1344980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2cfa4980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32f23b88a8fb/disk-f980f13e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b8362511367/vmlinux-f980f13e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a15c1af52d3/bzImage-f980f13e.xz

The issue was bisected to:

commit 68ca5d4eebb8c4de246ee5f634eee26bc689562d
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Mar 19 23:38:50 2024 +0000

    bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11813c64980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13813c64980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15813c64980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec4e4d5b7c4c6e654865@syzkaller.appspotmail.com
Fixes: 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs")

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08566-gf980f13e4eb2 #0 Not tainted
------------------------------------------------------
syz-executor324/5101 is trying to acquire lock:
ffff8880299562b0 (&psock->link_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880299562b0 (&psock->link_lock){+...}-{2:2}, at: sock_map_add_link net/core/sock_map.c:146 [inline]
ffff8880299562b0 (&psock->link_lock){+...}-{2:2}, at: sock_map_update_common+0x31c/0x5b0 net/core/sock_map.c:515

but task is already holding lock:
ffff88805d83da20 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff88805d83da20 (&stab->lock){+.-.}-{2:2}, at: sock_map_update_common+0x1b6/0x5b0 net/core/sock_map.c:505

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&stab->lock){+.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       __sock_map_delete net/core/sock_map.c:429 [inline]
       sock_map_delete_elem+0x175/0x250 net/core/sock_map.c:461
       bpf_prog_5f1d5fee127b8728+0x42/0x4b
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
       trace_kfree include/trace/events/kmem.h:94 [inline]
       kfree+0x2bd/0x3b0 mm/slub.c:4450
       sk_psock_free_link include/linux/skmsg.h:425 [inline]
       sock_map_del_link net/core/sock_map.c:170 [inline]
       sock_map_unref+0x3ac/0x5e0 net/core/sock_map.c:192
       sock_hash_delete_elem+0x392/0x400 net/core/sock_map.c:961
       bpf_prog_2c29ac5cdc6b1842+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run1+0x2ca/0x520 kernel/trace/bpf_trace.c:2443
       trace_ext4_da_reserve_space include/trace/events/ext4.h:1248 [inline]
       ext4_da_reserve_space+0x4c4/0x530 fs/ext4/inode.c:1477
       ext4_insert_delayed_block fs/ext4/inode.c:1652 [inline]
       ext4_da_map_blocks fs/ext4/inode.c:1777 [inline]
       ext4_da_get_block_prep+0x955/0x1420 fs/ext4/inode.c:1817
       ext4_block_write_begin+0x53b/0x1850 fs/ext4/inode.c:1055
       ext4_da_write_begin+0x5f8/0xa70 fs/ext4/inode.c:2894
       generic_perform_write+0x322/0x640 mm/filemap.c:3974
       ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x1de/0x1a10
       call_write_iter include/linux/fs.h:2120 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa2d/0xc50 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&psock->link_lock){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
       _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
       spin_lock_bh include/linux/spinlock.h:356 [inline]
       sock_map_add_link net/core/sock_map.c:146 [inline]
       sock_map_update_common+0x31c/0x5b0 net/core/sock_map.c:515
       sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:594
       map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
       __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5675
       __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&stab->lock);
                               lock(&psock->link_lock);
                               lock(&stab->lock);
  lock(&psock->link_lock);

 *** DEADLOCK ***

3 locks held by syz-executor324/5101:
 #0: ffff888076792718 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1595 [inline]
 #0: ffff888076792718 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_sk_acquire net/core/sock_map.c:129 [inline]
 #0: ffff888076792718 (sk_lock-AF_INET){+.+.}-{0:0}, at: sock_map_update_elem_sys+0x1cc/0x910 net/core/sock_map.c:590
 #1: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: sock_map_sk_acquire net/core/sock_map.c:130 [inline]
 #1: ffffffff8e333d20 (rcu_read_lock){....}-{1:2}, at: sock_map_update_elem_sys+0x1d8/0x910 net/core/sock_map.c:590
 #2: ffff88805d83da20 (&stab->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
 #2: ffff88805d83da20 (&stab->lock){+.-.}-{2:2}, at: sock_map_update_common+0x1b6/0x5b0 net/core/sock_map.c:505

stack backtrace:
CPU: 0 PID: 5101 Comm: syz-executor324 Not tainted 6.9.0-syzkaller-08566-gf980f13e4eb2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x35/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_map_add_link net/core/sock_map.c:146 [inline]
 sock_map_update_common+0x31c/0x5b0 net/core/sock_map.c:515
 sock_map_update_elem_sys+0x55f/0x910 net/core/sock_map.c:594
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1654
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5675
 __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f869864f729
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0c535468 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f869864f729
RDX: 0000000000000020 RSI: 00000000200000c0 RDI: 0000000000000002
RBP: 0000000000000000 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

