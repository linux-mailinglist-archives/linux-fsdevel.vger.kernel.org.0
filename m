Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97519D6D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 14:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403961AbgDCMgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 08:36:16 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44258 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403945AbgDCMgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:36:16 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so5907446ior.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2020 05:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UvbA5A0WRpymYAsYKP+Bj3BYcaBTCY3Et4nTEY3sA68=;
        b=Dgv7M7iIQY/6e5Tx0JvIOM/+HjCBY3AWvADX/GuR0UFNcSbI5F05a8Vntw2EXh4U8I
         DcQE9EER8xbjGrhJFS4Bc/lOCknK5bmSeBEg19eUIPrIq2IelVxo+G7jR4nKJcN8cyHe
         CvXAYSwoB4ngeLGVdG9IhJDgBKmPtMUkM0luEtdbCZshi/4706jhv76tG/UeFktkX/aK
         bcXozOVILjFCY2H3tiT2I9p3z6+LwQQP4VEnTuy0BseuRotpyjtTGda+pHK5IGg2Nl5G
         GXVW+qh9c0yVvvhuv/+W0mgH91jHYnk2J0wBOOP7JXWvyCId4DSF4Gim3PjA/tmuvQ45
         7RTg==
X-Gm-Message-State: AGi0PuapUp9WvxHYw5S2mxzoGwFLLx64hatocLoqGB0/wGwEUBqFQTRV
        WmFWvm05o0422kWOrfBr5mpXuV3+/CmwC0nmnRSefKXQzD+f
X-Google-Smtp-Source: APiQypKOeoi0/P/oER14D0BMRYIlvEPJDDZYRsE3CVFtPY/rAhRbh3XQ0qTPgH1RkKPtTOdK7QS/ERRL6nw/T4NRjAitrkvExrTK
MIME-Version: 1.0
X-Received: by 2002:a92:778e:: with SMTP id s136mr8654364ilc.256.1585917375308;
 Fri, 03 Apr 2020 05:36:15 -0700 (PDT)
Date:   Fri, 03 Apr 2020 05:36:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc687e05a26229d2@google.com>
Subject: KCSAN: data-race in fuse_lock_inode / process_init_reply
From:   syzbot <syzbot+e9c2dec6b40030f721c6@syzkaller.appspotmail.com>
To:     elver@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=12a7d9a5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4b9db179318d21f
dashboard link: https://syzkaller.appspot.com/bug?extid=e9c2dec6b40030f721c6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e9c2dec6b40030f721c6@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fuse_lock_inode / process_init_reply

read to 0xffff888099cc4d2d of 1 bytes by task 14548 on cpu 1:
 fuse_lock_inode+0x4c/0x90 fs/fuse/inode.c:351
 fuse_lookup+0x3f/0x210 fs/fuse/dir.c:389
 __lookup_hash+0xcb/0x110 fs/namei.c:1544
 filename_create+0x102/0x2d0 fs/namei.c:3639
 user_path_create fs/namei.c:3696 [inline]
 do_linkat+0xff/0x640 fs/namei.c:4298
 __do_sys_link fs/namei.c:4342 [inline]
 __se_sys_link fs/namei.c:4340 [inline]
 __x64_sys_link+0x47/0x60 fs/namei.c:4340
 do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff888099cc4d2d of 6 bytes by task 14532 on cpu 0:
 process_init_reply+0x7a/0xb90 fs/fuse/inode.c:891
 fuse_request_end+0x324/0x530 fs/fuse/dev.c:328
 end_requests+0x100/0x160 fs/fuse/dev.c:2056
 fuse_abort_conn+0x737/0x7d0 fs/fuse/dev.c:2151
 fuse_dev_release+0x26b/0x290 fs/fuse/dev.c:2186
 __fput+0x1e1/0x520 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xf6/0x130 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:164
 prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
 do_syscall_64+0x384/0x3a0 arch/x86/entry/common.c:304
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 14532 Comm: syz-executor.1 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
