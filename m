Return-Path: <linux-fsdevel+bounces-72165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A1CE676E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0AE30036D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09512FB97B;
	Mon, 29 Dec 2025 11:10:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FB26E719
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767006625; cv=none; b=Aa6RtwVm0RbnDz4lsG9jdM4Ln0OEabuAWO/+S6vBZP8sqGDoikXCR0xnIMrRzjw5JNGNHdQhTZZuTmDcAgcuzQlP0fCQnx9e/TtcCX6DNrOPiXP4zeAnpRnvN1XrLm9+T5+pYFYW3dvWTLS9e5l0sX0hPPBJJBjoFQUNO2vvrHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767006625; c=relaxed/simple;
	bh=0SdRmMXNbDJvDEAy67oOJPyeVFr8blASiqYpFErQYOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nyvCVDAxFi2mDSghLDXzp7XVwsag3gWJmLTKdShl8LsCJx14PspI1xXHZ4CFICAWElVsGvCyqVv9urKJb7l3GGy7I8TOAu+wvRq32MOEh6CEh05uLXpqbtvlBFUhbnjercYGP37mAMF+Vz0rM/v1oq+aU4qgwZ+snGcaf0nhffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c76977192eso31325948a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 03:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767006621; x=1767611421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+BsTIPtNt9M1Pa94iJghV70an12nmDiC2G94hHDx0Q=;
        b=of5CgFobGf8MOhcPXxBNBI9gnjZXXkkHzyRIAdN0BkbmhGjuOzpgmBjyzDbAZKO3d5
         p59/xEaSgHb6nvCtIMhsDunNLOy+hizk2mKiloCOz/wMYeRMQUvU1IBqaf0YVbjxhrEb
         pkB6NvXPH4Y9FmMv/ZUYt92Eo61VMNRtaS0sIXJo8AOmnEZq0lpc7JV82BnIDzzQoh1R
         IAW1yFIhZES+vHKMmbW3szAu2bFo9TgfA/UpSe8SIc58K87Nz+zt7Y4EVQfkbblyCnuW
         RlmwcwZozmAG6UOdYQGUC7QFXVAIR78YIYDdL9YJTOGRENg0uP+00wCjsa7yBVsV5Ao9
         /Feg==
X-Gm-Message-State: AOJu0YzpOPrcTXdyRq+zcMUfRVW+TW3qQP7zxTxa+0y0wSMsTH6siE+d
	1JmlK3W1PqwEDfvLsv076tQFHXmTqMpNdl0iySbNvtxwR6OYQBZjfzRq/lQlQNVBT4KBBciUVQ9
	Bi9nKGuzAf8xhGImalYHx4rzdzbFbc4Lh87Oodb7zqP0XhhcsJFrOmlPfz7eTpQ==
X-Google-Smtp-Source: AGHT+IFvD4Q8kAad6miy+5d9+15xGqIbl135ljD0fO+OS7Fsk5yenx36DZoP8cXeYIbg/QbKSwmJaZwYn3bM3aBp5vI0glAcFHcc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f029:b0:65d:c57:70b3 with SMTP id
 006d021491bc7-65d0e94d36bmr16070411eaf.12.1767006621430; Mon, 29 Dec 2025
 03:10:21 -0800 (PST)
Date: Mon, 29 Dec 2025 03:10:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6952619d.050a0220.3b1790.0008.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in path_openat (4)
From: syzbot <syzbot+2a72778c820449646330@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40fbbd64bba6 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13535dc2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=2a72778c820449646330
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-40fbbd64.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c1de727c8d2/vmlinux-40fbbd64.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3057920c151c/bzImage-40fbbd64.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a72778c820449646330@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.2.849/9100 is trying to acquire lock:
ffff888037026420 (sb_writers#3){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:4529 [inline]
ffff888037026420 (sb_writers#3){.+.+}-{0:0}, at: path_openat+0x183a/0x3140 fs/namei.c:4784

but task is already holding lock:
ffff88802e7520a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __do_sys_io_uring_enter+0xd60/0x1630 io_uring/io_uring.c:3279

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ctx->uring_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1aa/0x1ca0 kernel/locking/mutex.c:776
       io_uring_del_tctx_node+0x109/0x350 io_uring/tctx.c:179
       io_uring_clean_tctx+0xc2/0x190 io_uring/tctx.c:195
       io_uring_cancel_generic+0x69c/0x9a0 io_uring/cancel.c:646
       io_uring_task_cancel include/linux/io_uring.h:24 [inline]
       begin_new_exec+0xd1a/0x3770 fs/exec.c:1131
       load_elf_binary+0x8e7/0x4fe0 fs/binfmt_elf.c:1010
       search_binary_handler fs/exec.c:1669 [inline]
       exec_binprm fs/exec.c:1701 [inline]
       bprm_execve fs/exec.c:1753 [inline]
       bprm_execve+0x8c2/0x1620 fs/exec.c:1729
       do_execveat_common.isra.0+0x4a5/0x610 fs/exec.c:1859
       do_execveat fs/exec.c:1944 [inline]
       __do_sys_execveat fs/exec.c:2018 [inline]
       __se_sys_execveat fs/exec.c:2012 [inline]
       __x64_sys_execveat+0xda/0x120 fs/exec.c:2012
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1
 (&sig->cred_guard_mutex
){+.+.}-{4:4}
:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1aa/0x1ca0 kernel/locking/mutex.c:776
       proc_pid_attr_write+0x291/0x790 fs/proc/base.c:2837
       vfs_write+0x2a0/0x11d0 fs/read_write.c:684
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#3){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x450 fs/namespace.c:499
       open_last_lookups fs/namei.c:4529 [inline]
       path_openat+0x183a/0x3140 fs/namei.c:4784
       do_filp_open+0x20b/0x470 fs/namei.c:4814
       io_openat2+0x206/0x850 io_uring/openclose.c:143
       __io_issue_sqe+0xe8/0x7c0 io_uring/io_uring.c:1792
       io_issue_sqe+0x85/0x1410 io_uring/io_uring.c:1815
       io_queue_sqe io_uring/io_uring.c:2042 [inline]
       io_submit_sqe io_uring/io_uring.c:2320 [inline]
       io_submit_sqes+0xb24/0x28e0 io_uring/io_uring.c:2434
       __do_sys_io_uring_enter+0xd6b/0x1630 io_uring/io_uring.c:3280
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
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

1 lock held by syz.2.849/9100:
 #0: ffff88802e7520a8 (&ctx->uring_lock){+.+.}-{4:4}, at: __do_sys_io_uring_enter+0xd60/0x1630 io_uring/io_uring.c:3279

stack backtrace:
CPU: 1 UID: 0 PID: 9100 Comm: syz.2.849 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x340 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1669/0x2890 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x330 kernel/locking/lockdep.c:5825
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write include/linux/fs/super.h:125 [inline]
 mnt_want_write+0x6f/0x450 fs/namespace.c:499
 open_last_lookups fs/namei.c:4529 [inline]
 path_openat+0x183a/0x3140 fs/namei.c:4784
 do_filp_open+0x20b/0x470 fs/namei.c:4814
 io_openat2+0x206/0x850 io_uring/openclose.c:143
 __io_issue_sqe+0xe8/0x7c0 io_uring/io_uring.c:1792
 io_issue_sqe+0x85/0x1410 io_uring/io_uring.c:1815
 io_queue_sqe io_uring/io_uring.c:2042 [inline]
 io_submit_sqe io_uring/io_uring.c:2320 [inline]
 io_submit_sqes+0xb24/0x28e0 io_uring/io_uring.c:2434
 __do_sys_io_uring_enter+0xd6b/0x1630 io_uring/io_uring.c:3280
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f39e378f7c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39e46bb038 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 00007f39e39e5fa0 RCX: 00007f39e378f7c9
RDX: 0000000000000000 RSI: 0000000000003516 RDI: 0000000000000006
RBP: 00007f39e3813f91 R08: 0000000000000000 R09: 00000000fffffdcf
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f39e39e6038 R14: 00007f39e39e5fa0 R15: 00007ffed0e79908
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

