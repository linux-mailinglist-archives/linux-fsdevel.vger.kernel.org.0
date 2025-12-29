Return-Path: <linux-fsdevel+bounces-72166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAECE6771
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D86B63000936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23222FB99D;
	Mon, 29 Dec 2025 11:10:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917222F6904
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006625; cv=none; b=FBgt5O1A3cKlH0xa30JdhqrsAXB+NOGyOejpAtxV8U/AZ26PApDiW/hU5pOoZFDzerDwugFpMVv8e2CybcySg4Blr8lG9T9PzIH9WEkA16617ed7V6EDksbSRgjDev2wlHU2+2Y6aOkGn27t9ZNXnqU5yVAlmCaXz213RUdsEa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006625; c=relaxed/simple;
	bh=yWwG4b3KjNCTp/4LIl1u4VHdMYv1oKH9APJ1N5QE+iM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rG73FqDo5WILWD5EAmZhxt0Vs9IAc6QbYeVS+nyhLs10phKeuzuhrbIT220zb+K31e3zZPfcjkSRSWR8SET1V0EoBZ1KcMoQS9zGZ5N7dSp8fDK8dGqR4Dlc0QKDM/CE82vnYopoF4krD73TEWH9n5fMfAOqZSSga2IGlCyCLSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7cac9cda2d0so18757599a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006621; x=1767611421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVswuzew5+X9r2+dvHCiCbbY0WwOc10DsheFTZteNvg=;
        b=l/gc2PP/qfnuUfqrxa3BK3NDkftNNZa5KHjnjMUmbjrYhuJExn4eUNr+/D3Qynd7qC
         eM6ga1h66oNqMehXAYlAGaPGiIk5IcKPJP1ATyacxGTon57ihuIfwkSoBKZPu2XHjKBc
         43NcxtGZRRCiLaNwGhZ3XjD456Uq2HCHJkxwULQTjIWzHfhB/m9iRtEW5vgD9PJro2S3
         WuEyND9RuPZAB/k1LsdZaxyItrIzZwKu0q4KqUn/8jXSHrflEnqjJG5kPJhof8aBnw8O
         hYSrZfHCUIDNAVX4PbmiY4BNWyfsJY2zdnH546qprm0SN6rCijFvsR2AFxka0dhxIoku
         H0FQ==
X-Gm-Message-State: AOJu0Yy8Hh0RsQZ3hkjgvacrjnQG0xR7a6uVsRflmgP9Rn5Dru65RvVN
	up6Az+5Xzdyd3HItRDjR0YEppF3gZixJB2ZpndcmvPLY6oV63ta3CqY4Q2A5j3y74z34JR0UkvD
	pJ+Bm8NGm1mBm9NETXuvdZydHHmdC8iTwWyTqyV7ahMi3aH0vvVZVjkyKurwiUA==
X-Google-Smtp-Source: AGHT+IHXULmBtCPF6AOvzg7RVKTWxVRR9Q12mp+YEf8zqQcWbxfGVClqRWwChm8VkdoLjg9gJjdt6PdoiOL9aARzkK/8H6ivaV5p
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1507:b0:65c:f046:bb72 with SMTP id
 006d021491bc7-65d0e932cccmr14990830eaf.7.1767006621621; Mon, 29 Dec 2025
 03:10:21 -0800 (PST)
Date: Mon, 29 Dec 2025 03:10:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6952619d.050a0220.3b1790.0009.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in mnt_want_write (7)
From: syzbot <syzbot+29e107ef90787b28d121@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9094662f6707 Merge tag 'ata-6.19-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c70b1a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=29e107ef90787b28d121
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df3fce69c21a/disk-9094662f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/182b66a92309/vmlinux-9094662f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0cccba3c045d/bzImage-9094662f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29e107ef90787b28d121@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.647/8372 is trying to acquire lock:
ffff8880259d8420 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499

but task is already holding lock:
ffff88803403a0a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __do_sys_io_uring_enter io_uring/io_uring.c:3279 [inline]
ffff88803403a0a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __se_sys_io_uring_enter+0x2d5/0x2b60 io_uring/io_uring.c:3219

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ctx->uring_lock){+.+.}-{4:4}:
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

-> #1 (&sig->cred_guard_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:776
       proc_pid_attr_write+0x547/0x630 fs/proc/base.c:2837
       vfs_write+0x27e/0xb30 fs/read_write.c:684
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a6/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
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

other info that might help us debug this:

Chain exists of:
  sb_writers#3 --> &sig->cred_guard_mutex --> &ctx->uring_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ctx->uring_lock);
                               lock(&sig->cred_guard_mutex);
                               lock(&ctx->uring_lock);
  rlock(sb_writers#3);

 *** DEADLOCK ***

1 lock held by syz.0.647/8372:
 #0: ffff88803403a0a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __do_sys_io_uring_enter io_uring/io_uring.c:3279 [inline]
 #0: ffff88803403a0a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __se_sys_io_uring_enter+0x2d5/0x2b60 io_uring/io_uring.c:3219

stack backtrace:
CPU: 0 UID: 0 PID: 8372 Comm: syz.0.647 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7fcffab8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcffb980038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 00007fcffade5fa0 RCX: 00007fcffab8f749
RDX: 0000000000000000 RSI: 0000000000003516 RDI: 0000000000000009
RBP: 00007fcffac13f91 R08: 0000000000000000 R09: 00000000fffffdcf
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcffade6038 R14: 00007fcffade5fa0 R15: 00007fcffaf0fa28
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

