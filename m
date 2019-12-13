Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7011ED64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 23:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMWEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 17:04:08 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37452 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMWEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:04:08 -0500
Received: by mail-io1-f71.google.com with SMTP id p2so793058iof.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 14:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=74hTEiXuIBBuX+wNO/qGUSsAN9bF7EIfe65xbl5pH6Q=;
        b=ArT3QmfnVpa7uBC18kLmDznuIScg0WFH5slWeXxkcsL9NY3ZLbjKHD5vrIijWX/LBx
         ma/KDumdlp96b5EK4NEvOHHNOiTEurxu4Sa7Hi0Yyr4+aW93FVsdKidLS9txjl6egxv3
         BYh+U8gyxGTIdhyQIPOnyUSWtKTgiDm0JjS47GO/ocGHPaLCW4EHXey/ycYpVGEoWDsI
         xpk1ggXU5CNsOFqwNj312IpbRAhqnX1ZaScTF0SFxLPqLqDTL/FviN/cRllmYrW8X/re
         ks5/MVCo6WtESE4IGOEfBb6JhTmosIYJnF4wwgeWDtfSFtdnFqwGKIni/t8iFmXlsRhC
         VVdw==
X-Gm-Message-State: APjAAAXliRfC+mwBDIUBlVgj6Hz8IyL5XuBJ3Z/BVTl8lhEODE9/zxmu
        ShRv2DzMteAmxwNX+lylNhD8WUVaqJzRyjZSNiCNHLX4+LfO
X-Google-Smtp-Source: APXvYqylWovhWQKc0/OSlbOTvzYKwq+BpoogqE6aMhNXYZrjpf4XHIQPpeaF7X4uEOpf6jmbE5EW4FR4gGvLFvoFx1v+vhzcuBr8
MIME-Version: 1.0
X-Received: by 2002:a6b:6310:: with SMTP id p16mr8895712iog.5.1576274648002;
 Fri, 13 Dec 2019 14:04:08 -0800 (PST)
Date:   Fri, 13 Dec 2019 14:04:07 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076760205999d0a3b@google.com>
Subject: KCSAN: data-race in link_path_walk.part.0 / page_get_link
From:   syzbot <syzbot+57b6149668c34058041c@syzkaller.appspotmail.com>
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

HEAD commit:    5863cc79 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=143b67cee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186a3142a4cdd1db
dashboard link: https://syzkaller.appspot.com/bug?extid=57b6149668c34058041c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+57b6149668c34058041c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in link_path_walk.part.0 / page_get_link

read to 0xffff88809b36e056 of 1 bytes by task 8667 on cpu 0:
  link_path_walk.part.0+0x2d7/0xa90 fs/namei.c:2109
  link_path_walk fs/namei.c:2259 [inline]
  path_lookupat.isra.0+0x77/0x5a0 fs/namei.c:2307
  filename_lookup+0x145/0x2b0 fs/namei.c:2338
  user_path_at_empty+0x4c/0x70 fs/namei.c:2598
  user_path_at include/linux/namei.h:49 [inline]
  do_mount+0xc8/0x1560 fs/namespace.c:3081
  ksys_mount+0xe8/0x160 fs/namespace.c:3352
  __do_sys_mount fs/namespace.c:3366 [inline]
  __se_sys_mount fs/namespace.c:3363 [inline]
  __x64_sys_mount+0x70/0x90 fs/namespace.c:3363
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff88809b36e056 of 1 bytes by task 8674 on cpu 1:
  nd_terminate_link include/linux/namei.h:75 [inline]
  page_get_link+0x115/0x280 fs/namei.c:4787
  get_link fs/namei.c:1069 [inline]
  trailing_symlink+0x505/0x5a0 fs/namei.c:2253
  path_openat+0x6cc/0x36e0 fs/namei.c:3527
  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 8674 Comm: syz-executor.5 Not tainted 5.4.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
