Return-Path: <linux-fsdevel+bounces-72241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE851CE97BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 11:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC4F83035260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C2A2E6CDF;
	Tue, 30 Dec 2025 10:53:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74228466C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092004; cv=none; b=XFlFvMNKdOGwJAmJkdGhR8AWHiL8rcSvBXy8PdnU67uA+CJL1fC3bXmd5pKabiPYUjNgrfxruPnMdYVSwMMm9EH30YLKZbB9ioUwQUGkagYvGjLi8TiZ9aFRlR4rvNyZIP87S2s84LDV1voq+smi//+Vr1g0L1PSXGtxCc2crfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092004; c=relaxed/simple;
	bh=ABFwqtvt+AV6o0CBVtWCki9AA0RaGRZcbwLynDMpLTc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dfdkPtK77YqA6/75XD1ftjAKmAPntRJWb53TTQgzgBIMvAdBfaRj7HbkHTY7pqAnlvi9PR14b+RPDGPwSkYnuTso0yr0qn5TufRRjFdjYmt5X/ANWEQdPvsSutJqT7H5fVM8oqeaDUsiUibC04WlDV54x3J0WXUzCbMYmzAIalc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-65744e10b91so9485797eaf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 02:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092001; x=1767696801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzSYeOAS+hYcYZ7O2pNy9JMax1N9RPFrfksQCafPXhk=;
        b=gm868Yy9dubzK2Pz/4NuXXKUoOd9s0sVL2388Q88+8ZToNXBTsydVgqfNBps5Ych5r
         IMUD5Codwd4kYY0jYLznyD4HPM3UdtodefHAGrzJTyGa7kksp+vt2ltsX+NqEgp7HjVy
         O+tFBUVzlb+UHkDDw6naUHl6XyLLsGOZyqhzrWTCxB9EDJVKv5t3dhR466wLej9Z6s8S
         vpZugwIdwb3O1KdWP9DjaxImTAFJJ5ny6V69+xJaZlr9jSjDi744XyIP410+x1nGG8Mz
         byCEi0D3M5FC1D1uIvahxFkHubf88b8wqtxTWIAbADNYBLHWruk10iOex25hgGsVgSO5
         Dkug==
X-Gm-Message-State: AOJu0YzC40FX8FPm17Y+vLskWNK3INhcdeTSvMrA8gp5+ln7J5n62V+w
	pwxNBbCRl/rJIjdnkEBJ6ox2bbe9TuQGmfvM42RsI/9iUsY9p4U7lMUo0j0mzoOpjEd+TNivxv8
	Loz91U9byN+7CiBhDbja7D10DA9vVRwwlpJhawL1hLf20RpdeZ9ae3uVEc6N3hQ==
X-Google-Smtp-Source: AGHT+IHKwNWD1GMvBkrQbHY+kfgyK6AWaYve+yqRvMIYOeJI6ZiQ1K/kQL5JXzLxQE9IjHgOrbk5wpoM/P9bPP1xK3bH8oO29Cto
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2e95:b0:65f:7e:ebba with SMTP id
 006d021491bc7-65f007eed69mr199201eaf.51.1767092001386; Tue, 30 Dec 2025
 02:53:21 -0800 (PST)
Date: Tue, 30 Dec 2025 02:53:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6953af21.050a0220.329c0f.0585.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in proc_pid_attr_write (3)
From: syzbot <syzbot+81fd625ea55fd3b6c065@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7839932417dd Merge tag 'sched_ext-for-6.19-rc3-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117efcfc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=81fd625ea55fd3b6c065
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2f55b7baab3/disk-78399324.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60100f150ad1/vmlinux-78399324.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a223b3daaf7/bzImage-78399324.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81fd625ea55fd3b6c065@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.842/9892 is trying to acquire lock:
ffff88802f7f9460 (&sig->cred_guard_mutex){+.+.}-{4:4}, at: proc_pid_attr_write+0x547/0x630 fs/proc/base.c:2837

but task is already holding lock:
ffff888056f74420 (sb_writers#3){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
ffff888056f74420 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x211/0xb30 fs/read_write.c:682

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs/super.h:125
       mnt_want_write+0x41/0x90 fs/namespace.c:499
       open_last_lookups fs/namei.c:4529 [inline]
       path_openat+0xadd/0x3dd0 fs/namei.c:4784
       do_filp_open+0x1fa/0x410 fs/namei.c:4814
       io_openat2+0x3e0/0x5c0 io_uring/openclose.c:143
       __io_issue_sqe+0x181/0x4b0 io_uring/io_uring.c:1792
       io_issue_sqe+0x165/0x1060 io_uring/io_uring.c:1815
       io_queue_sqe io_uring/io_uring.c:2042 [inline]
       io_submit_sqe io_uring/io_uring.c:2320 [inline]
       io_submit_sqes+0xbf4/0x2140 io_uring/io_uring.c:2434
       __do_sys_io_uring_enter io_uring/io_uring.c:3280 [inline]
       __se_sys_io_uring_enter+0x2e0/0x2b60 io_uring/io_uring.c:3219
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ctx->uring_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       io_uring_del_tctx_node+0xf0/0x2c0 io_uring/tctx.c:179
       io_uring_clean_tctx+0xd4/0x1a0 io_uring/tctx.c:195
       io_uring_cancel_generic+0x6ca/0x7d0 io_uring/cancel.c:646
       io_uring_task_cancel include/linux/io_uring.h:24 [inline]
       begin_new_exec+0x10ed/0x2440 fs/exec.c:1131
       load_elf_binary+0x9f8/0x2d70 fs/binfmt_elf.c:1010
       search_binary_handler fs/exec.c:1669 [inline]
       exec_binprm fs/exec.c:1701 [inline]
       bprm_execve+0x92e/0x1400 fs/exec.c:1753
       do_execveat_common+0x510/0x6a0 fs/exec.c:1859
       do_execveat fs/exec.c:1944 [inline]
       __do_sys_execveat fs/exec.c:2018 [inline]
       __se_sys_execveat fs/exec.c:2012 [inline]
       __x64_sys_execveat+0xc4/0xe0 fs/exec.c:2012
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sig->cred_guard_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       proc_pid_attr_write+0x547/0x630 fs/proc/base.c:2837
       vfs_write+0x27e/0xb30 fs/read_write.c:684
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &sig->cred_guard_mutex --> &ctx->uring_lock --> sb_writers#3

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#3);
                               lock(&ctx->uring_lock);
                               lock(sb_writers#3);
  lock(&sig->cred_guard_mutex);

 *** DEADLOCK ***

2 locks held by syz.2.842/9892:
 #0: ffff88807b3a3cf8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1255
 #1: ffff888056f74420 (sb_writers#3){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
 #1: ffff888056f74420 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x211/0xb30 fs/read_write.c:682

stack backtrace:
CPU: 1 UID: 0 PID: 9892 Comm: syz.2.842 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:614 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
 proc_pid_attr_write+0x547/0x630 fs/proc/base.c:2837
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f23bc18f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23ba3f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f23bc3e5fa0 RCX: 00007f23bc18f749
RDX: 00000000000000f4 RSI: 0000200000000240 RDI: 0000000000000006
RBP: 00007f23bc213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f23bc3e6038 R14: 00007f23bc3e5fa0 R15: 00007f23bc50fa28
 </TASK>


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

