Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA73274A4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhB1VjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 16:39:00 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:33070 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhB1VjA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:39:00 -0500
Received: by mail-io1-f69.google.com with SMTP id m3so11801323ioy.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Feb 2021 13:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Eans+Y8M5kEDbsfDM4w+vnrR9uMK3i6NDK+ASbnwiqw=;
        b=h17QDm0sUDj3TcOA6QURvKz0YHNXRDmGlYRadlozMR60JO4tSgOx6mUDEw7SF1x+mz
         /SR/RvBWBo+s94IpZ70DgdcLhuJyBpymH2CTnnB0YFMNeTySoWi6BcpJZPNcR5f7XNDA
         kQa7Z/z++6gGLiwz6NPUh/jq2Ux36+K2i5iOqWOGB+CN62cwkrxtWn+frnqieYl7KQjP
         ItGD0tJYfBvdVmE8niYGCThjbqquSXjk1ZT+kmAp1p1C9sBzD6lq18/wYfXOkXW1oGr1
         x+T74xbhrN318rzfVwLdpED467/eE0zYkjGE+oOX9jtnt70KXQ25pimcx/uPFuE2BrJV
         +rtQ==
X-Gm-Message-State: AOAM530jBcls1jqafam76pAa00GVQqwJ4pBWwLQfl7djfnILa9ik5Di+
        zyLL+6h3Tq1FR4FKtlF0Ojk6u4+jcAcdiaLem5bmayIoTM7u
X-Google-Smtp-Source: ABdhPJzSIoA34gS/Jw7BAERzxmfGTaBs67RN3urq1p5QkgRKW2vregW0I/rm33/bQextDyUbE9nUgN4A5Z1G8E4jAT3GH/WXyRSH
MIME-Version: 1.0
X-Received: by 2002:a92:d7c7:: with SMTP id g7mr10592113ilq.305.1614548299301;
 Sun, 28 Feb 2021 13:38:19 -0800 (PST)
Date:   Sun, 28 Feb 2021 13:38:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da67e105bc6c51d4@google.com>
Subject: WARNING: suspicious RCU usage in __inode_security_revalidate
From:   syzbot <syzbot+1058632e58766789d9f2@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    719bbd4a Merge tag 'vfio-v5.12-rc1' of git://github.com/aw..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b131b6d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d398c54d51d75eb
dashboard link: https://syzkaller.appspot.com/bug?extid=1058632e58766789d9f2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1058632e58766789d9f2@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.11.0-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8296 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
2 locks held by syz-executor.0/10588:
 #0: ffff88801ec94460 (sb_writers#5){.+.+}-{0:0}, at: do_unlinkat+0x190/0x690 fs/namei.c:4075
 #1: ffff888024cc2548 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff888024cc2548 (&type->i_mutex_dir_key#4/1){+.+.}-{3:3}, at: do_unlinkat+0x27d/0x690 fs/namei.c:4079

stack backtrace:
CPU: 1 PID: 10588 Comm: syz-executor.0 Not tainted 5.11.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0xfa/0x151 lib/dump_stack.c:120
 ___might_sleep+0x266/0x2c0 kernel/sched/core.c:8296
 __inode_security_revalidate+0x112/0x140 security/selinux/hooks.c:259
 inode_security_rcu security/selinux/hooks.c:285 [inline]
 selinux_inode_permission+0x2e1/0x670 security/selinux/hooks.c:3137
 security_inode_permission+0x92/0xf0 security/security.c:1268
 inode_permission.part.0+0x119/0x440 fs/namei.c:521
 inode_permission fs/namei.c:2812 [inline]
 may_delete+0x318/0x750 fs/namei.c:2790
 vfs_unlink+0x53/0x610 fs/namei.c:4012
 do_unlinkat+0x3de/0x690 fs/namei.c:4096
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465837
Code: 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb29f6728 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000465837
RDX: 00007ffdb29f6760 RSI: 00007ffdb29f6760 RDI: 00007ffdb29f67f0
RBP: 00007ffdb29f67f0 R08: 0000000000000001 R09: 00007ffdb29f65c0
R10: 000000000253588b R11: 0000000000000206 R12: 00000000004bbe42
R13: 00007ffdb29f78c0 R14: 0000000002535810 R15: 00007ffdb29f7900


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
