Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F9D1865A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 08:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgCPH0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 03:26:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:43439 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgCPH0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 03:26:14 -0400
Received: by mail-io1-f71.google.com with SMTP id b21so5588495iot.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2020 00:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QkyM0ZAEqmVZ45byMP9eq8r024Rg7yOIHRDL7H8ep+U=;
        b=EIHdGEJ4Aj4/zrEyvFot5FwOlJE//1KpWomQA2EgeBpVIgleDXf+LKJLN1envK71UP
         tUVW08wO7Vz6bw1vmCk5kE5CrIWzPqO9yldGtoq5fSmtLSl9zm/AhuoH+Vo3Nh4/W1xP
         BlGkWiNyOmAhY0F54OshlJ39ATZ2xbfx3dd3w8EdYgzam0xEl8bRnZa1NK7mn01C6JTc
         2ePureMqo1MTQk3u2x64gyglWadkU0gD7GcDTDBJO9TQnAuIveY1Vr7XIvki+rsMRf9a
         etrvKCG/w4Lb1I9Oa9XCzYOrxlWpoEa4WHUIAqIFh1lFo6JILYQ8oyD7sTmgjJ9upldN
         RDXA==
X-Gm-Message-State: ANhLgQ2IoN+arFO/kOHRmEkb8JmDiHTstflpDRtScPEpr+p3FnMHEKMq
        B+bEkjBZlK6XXpd07bcuMfhDYN4RmqvY+uiiT1xKti60vJTR
X-Google-Smtp-Source: ADFU+vuaiQTiBb13LHNwB6lFPVcgadMFWyzPCzZz8BECpWOsQLVjrTo+WiApTVbeWOgVyoWZouanYC3Vje6iv5zysevBt2TOjwdX
MIME-Version: 1.0
X-Received: by 2002:a6b:e70d:: with SMTP id b13mr21641021ioh.91.1584343572869;
 Mon, 16 Mar 2020 00:26:12 -0700 (PDT)
Date:   Mon, 16 Mar 2020 00:26:12 -0700
In-Reply-To: <0000000000002ef1120597b1bc92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcf6ef05a0f3bb1b@google.com>
Subject: Re: possible deadlock in lock_trace (3)
From:   syzbot <syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        casey@schaufler-ca.com, christian@brauner.io, guro@fb.com,
        kent.overstreet@gmail.com, khlebnikov@yandex-team.ru,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    a42a7bb6 Merge tag 'irq-urgent-2020-03-15' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1237321de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e311dba9a02ba9
dashboard link: https://syzkaller.appspot.com/bug?extid=985c8a3c7f3668d31a49
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1185f753e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+985c8a3c7f3668d31a49@syzkaller.appspotmail.com

overlayfs: './file0' not a directory
======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc5-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.3/11170 is trying to acquire lock:
ffff888097db9c50 (&sig->cred_guard_mutex){+.+.}, at: lock_trace+0x45/0xe0 fs/proc/base.c:408

but task is already holding lock:
ffff8880913eebe0 (&p->lock){+.+.}, at: seq_read+0x6b/0x1160 fs/seq_file.c:161

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
       seq_read+0x6b/0x1160 fs/seq_file.c:161
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_loop_readv_writev fs/read_write.c:701 [inline]
       do_iter_read+0x47f/0x650 fs/read_write.c:935
       vfs_readv+0xf0/0x160 fs/read_write.c:1053
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
       do_splice_to+0x10e/0x160 fs/splice.c:892
       splice_direct_to_actor+0x307/0x980 fs/splice.c:971
       do_splice_direct+0x1a8/0x270 fs/splice.c:1080
       do_sendfile+0x549/0xc40 fs/read_write.c:1520
       __do_sys_sendfile64 fs/read_write.c:1581 [inline]
       __se_sys_sendfile64 fs/read_write.c:1567 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1567
       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#4){.+.+}:
       percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
       __sb_start_write+0x21b/0x430 fs/super.c:1674
       sb_start_write include/linux/fs.h:1650 [inline]
       mnt_want_write+0x3a/0xb0 fs/namespace.c:354
       ovl_setattr+0xdd/0x8b0 fs/overlayfs/inode.c:27
       notify_change+0xb6d/0x1060 fs/attr.c:336
       do_truncate+0x134/0x1f0 fs/open.c:64
       handle_truncate fs/namei.c:3083 [inline]
       do_last fs/namei.c:3496 [inline]
       path_openat+0x291f/0x32b0 fs/namei.c:3607
       do_filp_open+0x192/0x260 fs/namei.c:3637
       do_sys_openat2+0x54c/0x740 fs/open.c:1146
       do_sys_open+0xc3/0x140 fs/open.c:1162
       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_key[depth]){+.+.}:
       down_write+0x8d/0x150 kernel/locking/rwsem.c:1534
       inode_lock include/linux/fs.h:792 [inline]
       process_measurement+0x68a/0x1740 security/integrity/ima/ima_main.c:230
       ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:442
       do_last fs/namei.c:3494 [inline]
       path_openat+0x127f/0x32b0 fs/namei.c:3607
       do_filp_open+0x192/0x260 fs/namei.c:3637
       do_open_execat+0x122/0x600 fs/exec.c:860
       __do_execve_file.isra.0+0x16d5/0x2270 fs/exec.c:1765
       do_execveat_common fs/exec.c:1871 [inline]
       do_execve fs/exec.c:1888 [inline]
       __do_sys_execve fs/exec.c:1964 [inline]
       __se_sys_execve fs/exec.c:1959 [inline]
       __x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2475 [inline]
       check_prevs_add kernel/locking/lockdep.c:2580 [inline]
       validate_chain kernel/locking/lockdep.c:2970 [inline]
       __lock_acquire+0x201b/0x3ca0 kernel/locking/lockdep.c:3954
       lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4484
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
       lock_trace+0x45/0xe0 fs/proc/base.c:408
       proc_pid_personality+0x17/0xc0 fs/proc/base.c:3052
       proc_single_show+0xf7/0x1c0 fs/proc/base.c:758
       seq_read+0x4b9/0x1160 fs/seq_file.c:229
       do_loop_readv_writev fs/read_write.c:714 [inline]
       do_loop_readv_writev fs/read_write.c:701 [inline]
       do_iter_read+0x47f/0x650 fs/read_write.c:935
       vfs_readv+0xf0/0x160 fs/read_write.c:1053
       kernel_readv fs/splice.c:365 [inline]
       default_file_splice_read+0x4fb/0xa20 fs/splice.c:422
       do_splice_to+0x10e/0x160 fs/splice.c:892
       splice_direct_to_actor+0x307/0x980 fs/splice.c:971
       do_splice_direct+0x1a8/0x270 fs/splice.c:1080
       do_sendfile+0x549/0xc40 fs/read_write.c:1520
       __do_sys_sendfile64 fs/read_write.c:1581 [inline]
       __se_sys_sendfile64 fs/read_write.c:1567 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1567
       do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &sig->cred_guard_mutex --> sb_writers#4 --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(sb_writers#4);
                               lock(&p->lock);
  lock(&sig->cred_guard_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor.3/11170:
 #0: ffff88809fa24428 (sb_writers#13){.+.+}, at: file_start_write include/linux/fs.h:2904 [inline]
 #0: ffff88809fa24428 (sb_writers#13){.+.+}, at: do_sendfile+0x939/0xc40 fs/read_write.c:1519
 #1: ffff8880913eebe0 (&p->lock){+.+.}, at: seq_read+0x6b/0x1160 fs/seq_file.c:161

stack backtrace:
CPU: 0 PID: 11170 Comm: syz-executor.3 Not tainted 5.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1808
 check_prev_add kernel/locking/lockdep.c:2475 [inline]
 check_prevs_add kernel/locking/lockdep.c:2580 [inline]
 validate_chain kernel/locking/lockdep.c:2970 [inline]
 __lock_acquire+0x201b/0x3ca0 kernel/locking/lockdep.c:3954
 lock_acqu

