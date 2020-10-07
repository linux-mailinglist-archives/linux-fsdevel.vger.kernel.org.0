Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E61285BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgJGJSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 05:18:22 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:55647 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgJGJSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:18:21 -0400
Received: by mail-il1-f207.google.com with SMTP id 9so1031471ile.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2020 02:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=siXcRoWiOT6IB9ZzaXzxLDjCcyJ5bZ2i3vOd6vwCjbw=;
        b=SLRli5sNp4q8x7RsYUcS2XoLjtXoztY4rVIHa4gAIC01cfNuCUNt8cJ0ndIfCco1Li
         XdwR0qCEADfyCC8zdIffEpgl69q+/78SLltbInUGLMBsQQmuBU902nhv2msPSfmUSsLh
         SC6HsIryiw7OoiJ1cDUHK5TsEruAoapB4Z1nWXnKpfLdqgZZuQonERrMe4LQ8h0d9StI
         +g7Jb1TDnYi0X7Owq0SNS1VdLYaMFyM3ax3I8IvL7P2dKqfv8NoZJZ0r2uLXG0qbxUFG
         FgphwS/7Qe/1KlJRVaGV2kRBpu7c54rt1H0/2JtcWpuD0UXKPYOQvwgzeLevbyzZC24E
         yKAQ==
X-Gm-Message-State: AOAM533VxKVVGs2vH6e5MgMwDtyGb+YJWb/OiIHUHCugsI2L2T4NtdQz
        cCoQGHjZkAkP7JK6V9Av90+q4wvPxICTR/HKxFYzyHuHo/QZ
X-Google-Smtp-Source: ABdhPJwRwQWBq/XDdggILHJlcQJx0ogR/9jrp5LVj/8pJOUvdHwJXhwKqwA5ycytcwbJQgu8c4O6XYyQI5PNgqcyIvh+6jgeRGpJ
MIME-Version: 1.0
X-Received: by 2002:a5d:9e47:: with SMTP id i7mr1641257ioi.52.1602062299375;
 Wed, 07 Oct 2020 02:18:19 -0700 (PDT)
Date:   Wed, 07 Oct 2020 02:18:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000432c5405b1113296@google.com>
Subject: INFO: task can't die in corrupted
From:   syzbot <syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a804ab08 Add linux-next specific files for 20201006
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17fe30bf900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26c1b4cc4a62ccb
dashboard link: https://syzkaller.appspot.com/bug?extid=ee250ac8137be41d7b13
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336413b900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f7392b900000

The issue was bisected to:

commit eede846af512572b1f30b34f9889d7df64c017d4
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Fri Oct 2 21:17:35 2020 +0000

    f2fs: f2fs_get_meta_page_nofail should not be failed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a8aafb900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8aafb900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee250ac8137be41d7b13@syzkaller.appspotmail.com
Fixes: eede846af512 ("f2fs: f2fs_get_meta_page_nofail should not be failed")

INFO: task syz-executor178:6870 can't die for more than 143 seconds.
task:syz-executor178 state:R
 stack:26960 pid: 6870 ppid:  6869 flags:0x00004006
Call Trace:

Showing all locks held in the system:
1 lock held by khungtaskd/1179:
 #0: ffffffff8a554da0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6242
1 lock held by systemd-journal/3920:
1 lock held by in:imklog/6769:
 #0: ffff88809eebc130 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
1 lock held by syz-executor178/6870:
 #0: ffff8880925120e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x201/0xaf0 fs/super.c:229

=============================================

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 1179 Comm: khungtaskd Not tainted 5.9.0-rc8-next-20201006-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 panic+0x382/0x7fb kernel/panic.c:231
 check_hung_uninterruptible_tasks kernel/hung_task.c:257 [inline]
 watchdog.cold+0x23e/0x248 kernel/hung_task.c:339
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
