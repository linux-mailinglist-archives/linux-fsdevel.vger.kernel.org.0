Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A8FF303
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Nov 2019 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKPPnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Nov 2019 10:43:03 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:56582 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728543AbfKPPnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:02 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C09822E0DE5;
        Sat, 16 Nov 2019 18:42:59 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id netFG6C4VG-gusi6Wc9;
        Sat, 16 Nov 2019 18:42:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573918979; bh=6OWgJ/D1bA0jYWwhhbhnmnOKbAnNBP1YmMdV9P9HUxM=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=h5EJi9fKSV4BLLS9RXZAyGKW34uyJOFzDiECn7EPINx4wVWWILagKHDE/LaI6exYG
         EjRWrU1L9WnavsHYawOXTqt7rXekWFNbe5krHuUQNIZBmUAx7SKeVepEXGx7dvr3Cw
         ns2jR6nm7JdtZmb+m1EXHbs/wLVGo86xDXm+8muI=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:1009:4fae:ad87:4eae])
        by vla5-2bf13a090f43.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Ek98rnroKw-guXC19OO;
        Sat, 16 Nov 2019 18:42:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: possible deadlock in proc_pid_syscall
To:     syzbot <syzbot+ffc5f92d13ebf6b3e760@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io,
        keescook@chromium.org, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <0000000000008026b8059777575c@google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ed10dd02-09cf-ebc6-f123-208f7ad88578@yandex-team.ru>
Date:   Sat, 16 Nov 2019 18:42:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0000000000008026b8059777575c@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/11/2019 17.15, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    eb70e26c Merge tag 'arm64-fixes' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10a38772e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7654f9089a2e8c85
> dashboard link: https://syzkaller.appspot.com/bug?extid=ffc5f92d13ebf6b3e760
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+ffc5f92d13ebf6b3e760@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.4.0-rc7+ #0 Not tainted
> ------------------------------------------------------
> syz-executor.4/16763 is trying to acquire lock:
> ffff8880916fc710 (&sig->cred_guard_mutex){+.+.}, at: lock_trace fs/proc/base.c:406 [inline]
> ffff8880916fc710 (&sig->cred_guard_mutex){+.+.}, at: proc_pid_syscall+0x66/0x3a0 fs/proc/base.c:635
> 
> but task is already holding lock:
> ffff8880a02001c0 (&p->lock){+.+.}, at: seq_read+0x6e/0xd70 fs/seq_file.c:161
> 
> which lock already depends on the new lock.
> 

It seems reason is similar to this problem
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eb94cd96e05d6c65a07937e66a04ea265c1b767d
but this chain is more complicated.

Exec grabs task->signal->cred_guard_mutex in prepare_bprm_creds() and
then open file -- vfs locks nests inside cred_guard_mutex.

Procfs grabs cred_guard_mutex in lock_trace when reads files like "syscall".
inside "p->lock" (mutex inside seq_file which serialize read and seek).

Seq_file usually are not executable (exec /proc/self/syscall will fail before calling read).
It seems there is no trivial deadlock, but really might be some chain with vfs locks.

> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (&p->lock){+.+.}:
>         lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
>         __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
>         __mutex_lock kernel/locking/mutex.c:1103 [inline]
>         mutex_lock_nested+0x1b/0x30 kernel/locking/mutex.c:1118
>         seq_read+0x6e/0xd70 fs/seq_file.c:161
>         proc_reg_read+0x1e2/0x2d0 fs/proc/inode.c:223
>         do_loop_readv_writev fs/read_write.c:714 [inline]
>         do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
>         vfs_readv+0xc2/0x120 fs/read_write.c:997
>         kernel_readv fs/splice.c:359 [inline]
>         default_file_splice_read+0x544/0x8d0 fs/splice.c:414
>         do_splice_to fs/splice.c:877 [inline]
>         splice_direct_to_actor+0x39c/0xac0 fs/splice.c:954
>         do_splice_direct+0x200/0x330 fs/splice.c:1063
>         do_sendfile+0x7e4/0xfd0 fs/read_write.c:1464
>         __do_sys_sendfile64 fs/read_write.c:1525 [inline]
>         __se_sys_sendfile64 fs/read_write.c:1511 [inline]
>         __x64_sys_sendfile64+0x176/0x1b0 fs/read_write.c:1511
>         do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #2 (sb_writers#3){.+.+}:
>         lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
>         percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
>         __sb_start_write+0xeb/0x430 fs/super.c:1672
>         sb_start_write include/linux/fs.h:1650 [inline]
>         mnt_want_write+0x4a/0xa0 fs/namespace.c:354
>         ovl_want_write+0x77/0x80 fs/overlayfs/util.c:21
>         ovl_create_object+0xaf/0x2d0 fs/overlayfs/dir.c:596
>         ovl_create+0x29/0x30 fs/overlayfs/dir.c:627
>         lookup_open fs/namei.c:3224 [inline]
>         do_last fs/namei.c:3314 [inline]
>         path_openat+0x2236/0x4420 fs/namei.c:3525
>         do_filp_open+0x192/0x3d0 fs/namei.c:3555
>         do_sys_open+0x29f/0x560 fs/open.c:1097
>         ksys_open include/linux/syscalls.h:1385 [inline]
>         __do_sys_creat fs/open.c:1155 [inline]
>         __se_sys_creat fs/open.c:1153 [inline]
>         __x64_sys_creat+0x65/0x70 fs/open.c:1153
>         do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
>         lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
>         down_read+0x39/0x50 kernel/locking/rwsem.c:1495
>         inode_lock_shared include/linux/fs.h:801 [inline]
>         do_last fs/namei.c:3313 [inline]
>         path_openat+0xa9a/0x4420 fs/namei.c:3525
>         do_filp_open+0x192/0x3d0 fs/namei.c:3555
>         do_open_execat+0xff/0x610 fs/exec.c:857
>         __do_execve_file+0x766/0x1cc0 fs/exec.c:1762
>         do_execveat_common fs/exec.c:1868 [inline]
>         do_execve fs/exec.c:1885 [inline]
>         __do_sys_execve fs/exec.c:1961 [inline]
>         __se_sys_execve fs/exec.c:1956 [inline]
>         __x64_sys_execve+0x94/0xb0 fs/exec.c:1956
>         do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> -> #0 (&sig->cred_guard_mutex){+.+.}:
>         check_prev_add kernel/locking/lockdep.c:2476 [inline]
>         check_prevs_add kernel/locking/lockdep.c:2581 [inline]
>         validate_chain+0x161e/0x7bc0 kernel/locking/lockdep.c:2971
>         __lock_acquire+0xc75/0x1be0 kernel/locking/lockdep.c:3955
>         lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
>         __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
>         __mutex_lock kernel/locking/mutex.c:1103 [inline]
>         mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
>         lock_trace fs/proc/base.c:406 [inline]
>         proc_pid_syscall+0x66/0x3a0 fs/proc/base.c:635
>         proc_single_show+0xd8/0x120 fs/proc/base.c:756
>         seq_read+0x4cd/0xd70 fs/seq_file.c:229
>         do_loop_readv_writev fs/read_write.c:714 [inline]
>         do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
>         vfs_readv fs/read_write.c:997 [inline]
>         do_preadv+0x178/0x290 fs/read_write.c:1089
>         __do_sys_preadv fs/read_write.c:1139 [inline]
>         __se_sys_preadv fs/read_write.c:1134 [inline]
>         __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
>         do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> other info that might help us debug this:
> 
> Chain exists of:
>    &sig->cred_guard_mutex --> sb_writers#3 --> &p->lock
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(&p->lock);
>                                 lock(sb_writers#3);
>                                 lock(&p->lock);
>    lock(&sig->cred_guard_mutex);
> 
>   *** DEADLOCK ***
> 
> 1 lock held by syz-executor.4/16763:
>   #0: ffff8880a02001c0 (&p->lock){+.+.}, at: seq_read+0x6e/0xd70 fs/seq_file.c:161
> 
> stack backtrace:
> CPU: 0 PID: 16763 Comm: syz-executor.4 Not tainted 5.4.0-rc7+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1fb/0x318 lib/dump_stack.c:118
>   print_circular_bug+0xc2d/0xe60 kernel/locking/lockdep.c:1685
>   check_noncircular+0x206/0x3a0 kernel/locking/lockdep.c:1809
>   check_prev_add kernel/locking/lockdep.c:2476 [inline]
>   check_prevs_add kernel/locking/lockdep.c:2581 [inline]
>   validate_chain+0x161e/0x7bc0 kernel/locking/lockdep.c:2971
>   __lock_acquire+0xc75/0x1be0 kernel/locking/lockdep.c:3955
>   lock_acquire+0x158/0x250 kernel/locking/lockdep.c:4487
>   __mutex_lock_common+0x14c/0x2e20 kernel/locking/mutex.c:956
>   __mutex_lock kernel/locking/mutex.c:1103 [inline]
>   mutex_lock_killable_nested+0x1b/0x30 kernel/locking/mutex.c:1133
>   lock_trace fs/proc/base.c:406 [inline]
>   proc_pid_syscall+0x66/0x3a0 fs/proc/base.c:635
>   proc_single_show+0xd8/0x120 fs/proc/base.c:756
>   seq_read+0x4cd/0xd70 fs/seq_file.c:229
>   do_loop_readv_writev fs/read_write.c:714 [inline]
>   do_iter_read+0x4b1/0x5b0 fs/read_write.c:935
>   vfs_readv fs/read_write.c:997 [inline]
>   do_preadv+0x178/0x290 fs/read_write.c:1089
>   __do_sys_preadv fs/read_write.c:1139 [inline]
>   __se_sys_preadv fs/read_write.c:1134 [inline]
>   __x64_sys_preadv+0x9e/0xb0 fs/read_write.c:1134
>   do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45a669
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 
> 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ff34e552c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000045a669
> RDX: 00000000000001e3 RSI: 00000000200013c0 RDI: 0000000000000004
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff34e5536d4
> R13: 00000000004c7ef1 R14: 00000000004dde10 R15: 00000000ffffffff
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
