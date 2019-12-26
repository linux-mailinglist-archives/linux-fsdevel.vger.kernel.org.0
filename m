Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38A12AEE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLZVZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 16:25:18 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:38073 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfLZVZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 16:25:11 -0500
Received: by mail-io1-f70.google.com with SMTP id f18so17387182iol.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Dec 2019 13:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8ZrbSLJoE/0RZS4DLSJov6nnyIw6Iqi+6lQYHCGgk+I=;
        b=CGki3aKMO5N6i+6g8vCa0/lkEPYwhVwytNevMJyGtjEY/M/2uLAg0XK1cn9mNxcMCn
         GpMdq4C6mzjD9S21Q8djE6AHRYthoRmw5bs046S/c860Qb91ADsOG8Cg7NR74CcX5NGW
         bql7r59UM/KmBH9dubjwf43mEGTWqs4zhJXh2JfwPWd/2nORH6wudjWIqsYZe+xO7omJ
         63P97V4wFqH0TpsBqHqPXv8nd1WvDJpBA3aPCuuN3HY2hFOONJId3SvuC63Pyia50UPn
         tZSq/kK8hnluUI9n/7DQ2F+PraMvFdYE3U6bKsTNeZDAQHGwDONJXS3JdLrr6fM0RYj2
         9e1A==
X-Gm-Message-State: APjAAAVV8nznxDiq2muc33Sd316IymMsng+DS7lxfLIaX99t4PHmppvd
        bW65Y6QuZ/Q4V5K0669nuKq8mMOrN+0iJxx/KsFWeoB24ypu
X-Google-Smtp-Source: APXvYqyYQRL2CwPJ4BdRi56Er8MM1ohTatZXS8ZSvgqHxdkV3rcOxgNs1yyX/QDmSe/R9P/6U4kOD+F4kSgBCESoLFuc4pICdqUR
MIME-Version: 1.0
X-Received: by 2002:a5e:c014:: with SMTP id u20mr28827749iol.43.1577395508935;
 Thu, 26 Dec 2019 13:25:08 -0800 (PST)
Date:   Thu, 26 Dec 2019 13:25:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb27f1059aa202ea@google.com>
Subject: possible deadlock in pipe_lock (3)
From:   syzbot <syzbot+217d60b447573313b211@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    46cf053e Linux 5.5-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167281c1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=217d60b447573313b211
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116496c1e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10104649e00000

Bisection is inconclusive: the first bad commit could be any of:

9211bfbf netfilter: add missing IS_ENABLED(CONFIG_BRIDGE_NETFILTER) checks  
to header-file.
47e640af netfilter: add missing IS_ENABLED(CONFIG_NF_TABLES) check to  
header-file.
a1b2f04e netfilter: add missing includes to a number of header-files.
0abc8bf4 netfilter: add missing IS_ENABLED(CONFIG_NF_CONNTRACK) checks to  
some header-files.
bd96b4c7 netfilter: inline four headers files into another one.
43dd16ef netfilter: nf_tables: store data in offload context registers
78458e3e netfilter: add missing IS_ENABLED(CONFIG_NETFILTER) checks to some  
header-files.
20a9379d netfilter: remove "#ifdef __KERNEL__" guards from some headers.
bd8699e9 netfilter: nft_bitwise: add offload support
2a475c40 kbuild: remove all netfilter headers from header-test blacklist.
7e59b3fe netfilter: remove unnecessary spaces
1b90af29 ipvs: Improve robustness to the ipvs sysctl
5785cf15 netfilter: nf_tables: add missing prototypes.
0a30ba50 netfilter: nf_nat_proto: make tables static
e84fb4b3 netfilter: conntrack: use shared sysctl constants
10533343 netfilter: connlabels: prefer static lock initialiser
8c0bb787 netfilter: synproxy: rename mss synproxy_options field
c162610c Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114c96c1e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+217d60b447573313b211@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.5.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor691/10028 is trying to acquire lock:
ffff88809643c460 (&pipe->mutex/1){+.+.}, at: pipe_lock_nested fs/pipe.c:65  
[inline]
ffff88809643c460 (&pipe->mutex/1){+.+.}, at: pipe_lock+0x65/0x80  
fs/pipe.c:73

but task is already holding lock:
ffff888099382428 (sb_writers#4){.+.+}, at: file_start_write  
include/linux/fs.h:2885 [inline]
ffff888099382428 (sb_writers#4){.+.+}, at: do_splice+0xf48/0x1680  
fs/splice.c:1169

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_writers#4){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1674
        file_start_write include/linux/fs.h:2885 [inline]
        ovl_write_iter+0x91b/0xc20 fs/overlayfs/file.c:277
        call_write_iter include/linux/fs.h:1902 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        __kernel_write+0x11b/0x3b0 fs/read_write.c:515
        write_pipe_buf+0x15d/0x1f0 fs/splice.c:809
        splice_from_pipe_feed fs/splice.c:512 [inline]
        __splice_from_pipe+0x3ee/0x7c0 fs/splice.c:636
        splice_from_pipe+0x108/0x170 fs/splice.c:671
        default_file_splice_write+0x3c/0x90 fs/splice.c:821
        do_splice_from fs/splice.c:863 [inline]
        do_splice+0xba4/0x1680 fs/splice.c:1170
        __do_sys_splice fs/splice.c:1447 [inline]
        __se_sys_splice fs/splice.c:1427 [inline]
        __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_key[depth]){+.+.}:
        down_write+0x93/0x150 kernel/locking/rwsem.c:1534
        inode_lock include/linux/fs.h:791 [inline]
        ovl_write_iter+0x148/0xc20 fs/overlayfs/file.c:265
        call_write_iter include/linux/fs.h:1902 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        __kernel_write+0x11b/0x3b0 fs/read_write.c:515
        write_pipe_buf+0x15d/0x1f0 fs/splice.c:809
        splice_from_pipe_feed fs/splice.c:512 [inline]
        __splice_from_pipe+0x3ee/0x7c0 fs/splice.c:636
        splice_from_pipe+0x108/0x170 fs/splice.c:671
        default_file_splice_write+0x3c/0x90 fs/splice.c:821
        do_splice_from fs/splice.c:863 [inline]
        do_splice+0xba4/0x1680 fs/splice.c:1170
        __do_sys_splice fs/splice.c:1447 [inline]
        __se_sys_splice fs/splice.c:1427 [inline]
        __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&pipe->mutex/1){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
        pipe_lock_nested fs/pipe.c:65 [inline]
        pipe_lock+0x65/0x80 fs/pipe.c:73
        iter_file_splice_write+0x18b/0xc10 fs/splice.c:709
        do_splice_from fs/splice.c:863 [inline]
        do_splice+0xba4/0x1680 fs/splice.c:1170
        __do_sys_splice fs/splice.c:1447 [inline]
        __se_sys_splice fs/splice.c:1427 [inline]
        __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &pipe->mutex/1 --> &ovl_i_mutex_key[depth] --> sb_writers#4

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sb_writers#4);
                                lock(&ovl_i_mutex_key[depth]);
                                lock(sb_writers#4);
   lock(&pipe->mutex/1);

  *** DEADLOCK ***

1 lock held by syz-executor691/10028:
  #0: ffff888099382428 (sb_writers#4){.+.+}, at: file_start_write  
include/linux/fs.h:2885 [inline]
  #0: ffff888099382428 (sb_writers#4){.+.+}, at: do_splice+0xf48/0x1680  
fs/splice.c:1169

stack backtrace:
CPU: 1 PID: 10028 Comm: syz-executor691 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  __mutex_lock_common kernel/locking/mutex.c:956 [inline]
  __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
  pipe_lock_nested fs/pipe.c:65 [inline]
  pipe_lock+0x65/0x80 fs/pipe.c:73
  iter_file_splice_write+0x18b/0xc10 fs/splice.c:709
  do_splice_from fs/splice.c:863 [inline]
  do_splice+0xba4/0x1680 fs/splice.c:1170
  __do_sys_splice fs/splice.c:1447 [inline]
  __se_sys_splice fs/splice.c:1427 [inline]
  __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x448059
Code: e8 6c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 db 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6e364e9da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00000000006ddc28 RCX: 0000000000448059
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00000000006ddc20 R08: 0000000100000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc2c
R13: 00007ffdf34111cf R14: 00007f6e364ea9c0 R15: 00000000006ddc2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
