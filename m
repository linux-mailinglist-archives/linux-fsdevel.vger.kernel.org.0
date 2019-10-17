Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7BDAC67
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 14:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502453AbfJQMgJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 08:36:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:33367 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391564AbfJQMgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:36:09 -0400
Received: by mail-io1-f71.google.com with SMTP id g15so3132488ioc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2019 05:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5t4yqDt+mBIkGJEjjJGiGmX6FdFp97lRinnPxkeZsbg=;
        b=KkQLU+1O9Tfp7yOqD6RMZCFYOrbyHx8WaEns8JWUnUJ6y/L6KIw9l3eEEKfqx50MaG
         lPtNLOWEIkMCTuNAf0yvj/H+Svhxi25vJlNQQgoCjC1p9VemuATroJOb7+qhzoFtB1bO
         x4G4YS2UiEtmY2gYXblqo/J24B9UeALp3Tz7fCMn+Ny2Md6Gl60pmPLzhOqUCtRwBjU6
         pPLJc3YxJCr17OzCXJFs8MpcZckPzF8nBsbRjEeuOD/1qce7i7iWkb1DirH78XzHhwKu
         xFa4sA1AYvkVDIq6QtroatrDaBxKv02dERaYKOUrYjSJRtHrhf+rh7rc3L7OTm7o7nSR
         PwqQ==
X-Gm-Message-State: APjAAAUrZWsXppyJ6/Ek9n26gWRGz7J9PHgnXGbX9B8nWo5pte7Qlp9e
        8d/dDBDeOnT2aZWB86buySY53xiEDtb1UL0jrX2oAPSdhxIP
X-Google-Smtp-Source: APXvYqzB8gJtlUXLPgJonp1LfCe0tLXtXHbbpq4ADGFI8YMv/2ntWneIkikxCxslAZV/kWQ6JCcMn2qAGmAut/KPw4CjeFynQQ4/
MIME-Version: 1.0
X-Received: by 2002:a02:bb01:: with SMTP id y1mr3062982jan.117.1571315768264;
 Thu, 17 Oct 2019 05:36:08 -0700 (PDT)
Date:   Thu, 17 Oct 2019 05:36:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000328b2905951a7667@google.com>
Subject: KCSAN: data-race in task_dump_owner / task_dump_owner
From:   syzbot <syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        casey@schaufler-ca.com, christian@brauner.io, elver@google.com,
        keescook@chromium.org, kent.overstreet@gmail.com,
        khlebnikov@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d724f94f x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=17884db3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0906aa620713d80
dashboard link: https://syzkaller.appspot.com/bug?extid=e392f8008a294fdf8891
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e392f8008a294fdf8891@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in task_dump_owner / task_dump_owner

write to 0xffff8881255bb7fc of 4 bytes by task 7804 on cpu 0:
  task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
  pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
  pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
  d_revalidate fs/namei.c:765 [inline]
  d_revalidate fs/namei.c:762 [inline]
  lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
  walk_component+0x6d/0xe80 fs/namei.c:1804
  link_path_walk.part.0+0x5d3/0xa90 fs/namei.c:2139
  link_path_walk fs/namei.c:2070 [inline]
  path_openat+0x14f/0x3530 fs/namei.c:3532
  do_filp_open+0x11e/0x1b0 fs/namei.c:3563
  do_sys_open+0x3b3/0x4f0 fs/open.c:1089
  __do_sys_open fs/open.c:1107 [inline]
  __se_sys_open fs/open.c:1102 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1102
  do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff8881255bb7fc of 4 bytes by task 7813 on cpu 1:
  task_dump_owner+0xd8/0x260 fs/proc/base.c:1742
  pid_update_inode+0x3c/0x70 fs/proc/base.c:1818
  pid_revalidate+0x91/0xd0 fs/proc/base.c:1841
  d_revalidate fs/namei.c:765 [inline]
  d_revalidate fs/namei.c:762 [inline]
  lookup_fast+0x7cb/0x7e0 fs/namei.c:1613
  walk_component+0x6d/0xe80 fs/namei.c:1804
  lookup_last fs/namei.c:2271 [inline]
  path_lookupat.isra.0+0x13a/0x5a0 fs/namei.c:2316
  filename_lookup+0x145/0x2d0 fs/namei.c:2346
  user_path_at_empty+0x4c/0x70 fs/namei.c:2606
  user_path_at include/linux/namei.h:60 [inline]
  vfs_statx+0xd9/0x190 fs/stat.c:187
  vfs_stat include/linux/fs.h:3188 [inline]
  __do_sys_newstat+0x51/0xb0 fs/stat.c:341
  __se_sys_newstat fs/stat.c:337 [inline]
  __x64_sys_newstat+0x3a/0x50 fs/stat.c:337
  do_syscall_64+0xcf/0x2f0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 7813 Comm: ps Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
