Return-Path: <linux-fsdevel+bounces-31804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A7C99B5ED
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 17:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E5FB235FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3C3B1A4;
	Sat, 12 Oct 2024 15:45:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554E2745B
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747927; cv=none; b=JD7wHAqflWi/8GRa4ImrWkjiBym8nBL+onbGQYvlU23ESMF0+WAo/3jg1mMFEa5wa+v2xJ7+0NOU6K8e++RbzVLkIknFWxNuFNBAPOuqCkojvIcPWILC1xyIRk/MLm9NlH+iGlz/qeuC6PmrIjirdv3lNPjG5o0erzPl9jO8XBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747927; c=relaxed/simple;
	bh=wf213ejd6vyLBqUTHzHrqxhbItT7CCQyFxjOyhi/fio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SfaH/tdKjF6FDcL/tZPsbKIXH0cyMLNLE8mtUC1WCislY+v8O89VHbxMkV22p+NIfKkxfEw/ItYraJ4U65EY9YACaRJkNV3SXmO60BBjMsblVzYkEd2LIAwpGYG8+/GQh3i8Dj8VIUiwDgXItcrx08A2Coypal6vYYWUE95bfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1925177fdso29602755ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 08:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728747925; x=1729352725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0hNO37Ou6oUTE+IX4pYIabeouonkhA/bHVRDEad9No=;
        b=Wmms2kkf927NX6k73aVbhB+lsipM3noA6RqVSg3nxAcvAJ8Aa5I1aFSEg2wTvX5dcp
         TabsWPxvDMlk1+bD+ui4RGKQHXDDTDdtXDUCK+8n9sXMEOQiyCn6pLNc4DqjZ15f737E
         X5BolaC+6vPFp9BRTOVpZMJhHb0soG4UgAhMm9R2zpDnL4YPpizlao41OJG9icjcYyU1
         sNMh9AASv0/r/aix4NbXlsifP/JKSFK9ELP7nUQ+IPdGOuu87tT63d/7cXVBayVazmGh
         qaO9Ij8H5HKijxCfjugTy/27xhHf8vU2YCBfOeOQyWtErlCsQtxrhy/BAV4pt2bGicBh
         OXQg==
X-Forwarded-Encrypted: i=1; AJvYcCXdZGyPnMaG6yorw0w2LAEKFxoSMvmXYLOySa7n0Xn0ZC96kbR4gXlY5spjhzQXEpALBOZaa5bvDPcIkA56@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHVcHy6qt1FVG7t1kMtvLM8avrvkvrVJX/QQxZDz9e9NfxPnT
	hJNojuki0TRI0EPjLXRABbeAKckWQAGMbw1+Ub1LlH2KAqTkwjMFGncJfNpr9md8rhjfNO9LbgN
	GXWjay/ulHN4RbzFbxSh8CcbX5H+i7wqrK5BZ7TsFg9E3H/3iSzc8PoA=
X-Google-Smtp-Source: AGHT+IEYrwR9wGOAKI24lRXUlnVMYCv/QgpQekriCcxnx7o1esKksBNiBpaEymNDCmD/v3y3Meqia/EGhvw7r1R8w2K0R1OMSJyt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0b:b0:3a0:aa15:3497 with SMTP id
 e9e14a558f8ab-3a3b5f23e86mr57585895ab.1.1728747924781; Sat, 12 Oct 2024
 08:45:24 -0700 (PDT)
Date: Sat, 12 Oct 2024 08:45:24 -0700
In-Reply-To: <670658e6.050a0220.22840d.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670a9994.050a0220.4cbc0.0023.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] INFO: task hung in fdget_pos
From: syzbot <syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    09f6b0c8904b Merge tag 'linux_kselftest-fixes-6.12-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d43fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a7b27980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cee087980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-09f6b0c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3844cfd6d6b9/vmlinux-09f6b0c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8752e101c1ff/bzImage-09f6b0c8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f596198b5b58/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ee1ef35cf7e70ce55d7@syzkaller.appspotmail.com

INFO: task syz-executor219:5184 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00291-g09f6b0c8904b #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor219 state:D stack:28952 pid:5184  tgid:5133  ppid:5129   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 fdget_pos+0x24e/0x320 fs/file.c:1160
 ksys_read+0x7e/0x2b0 fs/read_write.c:703
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f59323ec4b9
RSP: 002b:00007f5932382238 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f593247d618 RCX: 00007f59323ec4b9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f593247d610 R08: 00007ffd45f51bd7 R09: 00007f59323826c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f59324400c0
R13: 000000000000006e R14: 00007ffd45f51af0 R15: 00007ffd45f51bd8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by kswapd0/75:
1 lock held by kswapd1/80:
 #0: ffff88801fc3ea98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
2 locks held by getty/4903:
 #0: ffff88801ece10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
4 locks held by syz-executor219/5142:
1 lock held by syz-executor219/5184:
 #0: ffff8880366bf478 (&f->f_pos_lock){+.+.}-{3:3}, at: fdget_pos+0x24e/0x320 fs/file.c:1160

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00291-g09f6b0c8904b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

