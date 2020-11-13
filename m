Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE362B21D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 18:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMRRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 12:17:19 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:48418 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgKMRRT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:17:19 -0500
Received: by mail-il1-f200.google.com with SMTP id o5so7014558ilh.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 09:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AoVMm0F0BfO3BX7DOFKEUiRvpD+PX2QeLVOvFi7bkcM=;
        b=rEKnZGWOO891MvayJFEa4CmH6W4oagHFSvPseVAgZOZFaA5nOVx/9boBodjnSoUc04
         8JU6cZxUz737Dto+CgrrBp6YSTtfvJUC0utCG5tERIXIkdUDjXWocP/gvtVacf7ooG4P
         IyMG4KG6rMq63jykYkfWPBw5V8Q8JcxWlnztQDxNsU6nG0kLtb1Lrg3Crn9wPnc8Obzc
         zfOIKySCH1SlVO06XdVc6k+Ci6P11yTKQXdcP2hLAqCo6xx1KrP0qMWgIYr7fMyGcPd7
         1gPoMIBRTBVuZZSfM6brm0aEh8UDsYjPUZPqBm0wkqhvzK1o5c1k/CdW5VSC7iNaN7RF
         Sy+A==
X-Gm-Message-State: AOAM531nIYQZbm8X+UKus+aT7URGIabLItzthh0MudqAroXHjoFkq2g+
        l++zZf2+9/JdhZgo7GUqctxrrW18cx2M5vp8mIRJkMImOWtg
X-Google-Smtp-Source: ABdhPJypk6Mtb4JhlkbUSWPQMaAGnlH+/9mixnEt5vFWHVLIpKop1ODS3gSu6+q8vsEchftOxQ2/+1UhED8lELPES0ZXN6qO9ZV5
MIME-Version: 1.0
X-Received: by 2002:a92:cf51:: with SMTP id c17mr641766ilr.113.1605287851739;
 Fri, 13 Nov 2020 09:17:31 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:17:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a530d05b400349b@google.com>
Subject: memory leak in generic_parse_monolithic
From:   syzbot <syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    af5043c8 Merge tag 'acpi-5.10-rc4' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e8c906500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f13716fa0212fd
dashboard link: https://syzkaller.appspot.com/bug?extid=86dc6632faaca40133ab
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102a57dc500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129ca3d6500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+86dc6632faaca40133ab@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.84' (ECDSA) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff888111f15a80 (size 32):
  comm "syz-executor841", pid 8507, jiffies 4294942125 (age 14.070s)
  hex dump (first 32 bytes):
    25 5e 5d 24 5b 2b 25 5d 28 24 7b 3a 0f 6b 5b 29  %^]$[+%](${:.k[)
    2d 3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00  -:..............
  backtrace:
    [<000000005c6f565d>] kmemdup_nul+0x2d/0x70 mm/util.c:151
    [<0000000054985c27>] vfs_parse_fs_string+0x6e/0xd0 fs/fs_context.c:155
    [<0000000077ef66e4>] generic_parse_monolithic+0xe0/0x130 fs/fs_context.c:201
    [<00000000d4d4a652>] do_new_mount fs/namespace.c:2871 [inline]
    [<00000000d4d4a652>] path_mount+0xbbb/0x1170 fs/namespace.c:3205
    [<00000000f43f0071>] do_mount fs/namespace.c:3218 [inline]
    [<00000000f43f0071>] __do_sys_mount fs/namespace.c:3426 [inline]
    [<00000000f43f0071>] __se_sys_mount fs/namespace.c:3403 [inline]
    [<00000000f43f0071>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403
    [<00000000dc5fffd5>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000004e665669>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
