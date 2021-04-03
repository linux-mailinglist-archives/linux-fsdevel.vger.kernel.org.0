Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8620353225
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Apr 2021 04:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhDCCwU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 22:52:20 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47599 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhDCCwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 22:52:20 -0400
Received: by mail-il1-f200.google.com with SMTP id h21so6870214ila.14
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 19:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ma7VF6roljBK4DbYwNgDU/vzAcnMAM5dtjvOWYDxWQM=;
        b=stOOUHqbVnU1Bgnq9ktDmnJt2zrSu5G+M7V7Vou3nPPr/SCxDWy1lFlljo7wY+egu+
         FQeUQbDWr8zLCX0AwUg/ynFifllrfnu+yVKrppPeYCkHSJlYPwGjzpFtC/b88ZpJCmGg
         0uWXXXQp8HfWYS1Me63sPKWPK5f4TtW/byrm4sM5vkJlhGsr+vzAr0tDktrjfIhPe6sc
         8J0FVO7SMr1zsKQysqTvT9BsbiRlj8bmgz2Wgj3VAY1tteqXnXzZ6WU+/AiRVzWowp6H
         3M0EJgZ0tV/FSG6sLKjocCPtMXOl/DT/X8nGaqbiJ6BovJck0JE+Su+/ols65At2QfFO
         +TVQ==
X-Gm-Message-State: AOAM533P6YAeowOe8w6l7kV2x2dBHKAS9PL6V0KUtSxVR8Zr+Tai5LkI
        6FXxElPBFpxozXiOaOevblveLLJcA8Qs801SA1l393lVfvLJ
X-Google-Smtp-Source: ABdhPJyifBxl12tbnlmliX5i6Pxo8oIEa4JsMQJcBKfFcoEm2j0tTNbGQgi7MRNHas8zIxmM9CRioKZPrNuUcxktxwf+clAklYDB
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184b:: with SMTP id b11mr12923820ilv.29.1617418337797;
 Fri, 02 Apr 2021 19:52:17 -0700 (PDT)
Date:   Fri, 02 Apr 2021 19:52:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a4aad05bf088d43@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in dput
From:   syzbot <syzbot+bdef67a6b28a89e6fe71@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d76301d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78ef1d159159890
dashboard link: https://syzkaller.appspot.com/bug?extid=bdef67a6b28a89e6fe71

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bdef67a6b28a89e6fe71@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
no locks held by systemd-udevd/4825.

stack backtrace:
CPU: 1 PID: 4825 Comm: systemd-udevd Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
 dput+0x4d/0xbc0 fs/dcache.c:870
 step_into+0x2cf/0x1c80 fs/namei.c:1778
 walk_component+0x171/0x6a0 fs/namei.c:1945
 link_path_walk.part.0+0x712/0xc90 fs/namei.c:2266
 link_path_walk fs/namei.c:2190 [inline]
 path_lookupat+0xb7/0x830 fs/namei.c:2419
 filename_lookup+0x19f/0x560 fs/namei.c:2453
 do_readlinkat+0xcd/0x2f0 fs/stat.c:417
 __do_sys_readlinkat fs/stat.c:444 [inline]
 __se_sys_readlinkat fs/stat.c:441 [inline]
 __x64_sys_readlinkat+0x93/0xf0 fs/stat.c:441
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fb5a7e200ba
Code: 48 8b 0d e1 bd 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 0b 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ae bd 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc9c440e38 EFLAGS: 00000202 ORIG_RAX: 000000000000010b
RAX: ffffffffffffffda RBX: 00005604089e4380 RCX: 00007fb5a7e200ba
RDX: 00005604089e4380 RSI: 00007ffc9c440ec0 RDI: 00000000ffffff9c
RBP: 0000000000000064 R08: 00007fb5a80dcbc8 R09: 0000000000000070
R10: 0000000000000063 R11: 0000000000000202 R12: 00007ffc9c440ec0
R13: 00000000ffffff9c R14: 00007ffc9c440e90 R15: 0000000000000063


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
