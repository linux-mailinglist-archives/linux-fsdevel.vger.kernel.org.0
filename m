Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719051237F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLQUnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 15:43:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:36878 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbfLQUnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:43:11 -0500
Received: by mail-il1-f197.google.com with SMTP id t19so10427388ila.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 12:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZsG4GGhI1HdtobOHo0iYGQ381sBQZXGjK6JsTLf54tI=;
        b=tvoUqA3uOQBkcmKbl5Gm5FZbNNV0yQT9pFKECYdbLjBA0nW2WlXfZ/yEZMDT7vWU4u
         kzCPkc2fioBsGOt+jVsdxibg4SlYU4cKxVYsY6TAPCQQdL6zlqxPIodIBTbm5tjxCHDV
         gFjzPP9pFWjt53tEu8JxhejrV7UchwPZ16iVGeTDFKZcumHkgm7LINDi0lP7sBGGRNp4
         WFllTR7Q99jzzZ37kukpAy/BpujxzGhON9qeAU5vnqm3IhhIjX1sOR3+CJnGGP1Co/TC
         x/C9K9dYS0z6lm7S4R42Ntv5Z2Teyg4ZppdrRnHDKbemZx5+iEqoZcMxPyS55Nd7Y+fV
         c8Rw==
X-Gm-Message-State: APjAAAU4OPn6W5aLjeeznQtc/hnsHNFTGxg6qUGNYw0UoKZ7KWUfKir/
        Vv8H6YMYuOXRiGowd9S2wdBwM5epBMuevWzu4s2GVj4xensc
X-Google-Smtp-Source: APXvYqyu7jeTkwiEQsSvZo2qq1J2Cge2aNKRqMbtsXfHs+JssScBIJRW+W5oExAps69/GWTSttKC9a6p9iUPVSEaeSZY/T6eo+Tx
MIME-Version: 1.0
X-Received: by 2002:a5e:8417:: with SMTP id h23mr5163006ioj.17.1576615388758;
 Tue, 17 Dec 2019 12:43:08 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:43:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031cefb0599ec600b@google.com>
Subject: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake (3)
From:   syzbot <syzbot+9b3fb64bcc8c1d807595@syzkaller.appspotmail.com>
To:     elver@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=11beba8ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a38292766f8efdaa
dashboard link: https://syzkaller.appspot.com/bug?extid=9b3fb64bcc8c1d807595
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9b3fb64bcc8c1d807595@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in poll_schedule_timeout.constprop.0 / pollwake

write to 0xffffc90001043c30 of 4 bytes by task 17695 on cpu 0:
  __pollwake fs/select.c:197 [inline]
  pollwake+0xe3/0x140 fs/select.c:217
  __wake_up_common+0x7b/0x180 kernel/sched/wait.c:93
  __wake_up_common_lock+0x77/0xb0 kernel/sched/wait.c:123
  __wake_up+0xe/0x10 kernel/sched/wait.c:142
  signalfd_notify include/linux/signalfd.h:22 [inline]
  signalfd_notify include/linux/signalfd.h:19 [inline]
  __send_signal+0x70e/0x870 kernel/signal.c:1158
  send_signal+0x224/0x2b0 kernel/signal.c:1236
  __group_send_sig_info kernel/signal.c:1275 [inline]
  do_notify_parent+0x55b/0x5e0 kernel/signal.c:1992
  exit_notify kernel/exit.c:670 [inline]
  do_exit+0x16ef/0x18c0 kernel/exit.c:818
  do_group_exit+0xb4/0x1c0 kernel/exit.c:895
  __do_sys_exit_group kernel/exit.c:906 [inline]
  __se_sys_exit_group kernel/exit.c:904 [inline]
  __x64_sys_exit_group+0x2e/0x30 kernel/exit.c:904
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffc90001043c30 of 4 bytes by task 15995 on cpu 1:
  poll_schedule_timeout.constprop.0+0x50/0xc0 fs/select.c:242
  do_poll fs/select.c:951 [inline]
  do_sys_poll+0x66d/0x990 fs/select.c:1001
  __do_sys_poll fs/select.c:1059 [inline]
  __se_sys_poll fs/select.c:1047 [inline]
  __x64_sys_poll+0x10f/0x250 fs/select.c:1047
  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15995 Comm: udevd Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
