Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED7155D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgBGRoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:44:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:49581 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgBGRoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:44:11 -0500
Received: by mail-il1-f200.google.com with SMTP id p67so341371ill.16
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2020 09:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KswKyf5+gTM/GWQOrvGPuLAwNlzU8ivMu85nCLzbl2U=;
        b=F9PSo7Y7/a9HMD8KqFzWpnXoa2LiX2s5OAhp1VcN/RR4xodlo5J4Vu9QZRv9geRnja
         USfMQ6HCfSnujiirfFGAdClGqJNdRdM9C4i+oQAaCSxMF01nhwIeqO0eDPLqm13HK+FM
         5Ot5OeXLSSGs8LifK+ZcPq5NBSFsqFoocZP8ugl/nN+rojKSENhWM49TBqWheuJRo+Rc
         pLf6paG5hSU10QsdRBZaPZPXOH/ZlwOBKSszBW+j4RUXvnA7fMnnkdJD/EtalhJRdcKC
         Tz57Z/HEjbo0R1JA6Qu/pNNgoNudKeEGd43G7v4uMAZIrGbRP7L6Sgha4qaMSI9seaG/
         nG3A==
X-Gm-Message-State: APjAAAWwPcT7NunsTaZDq5fSHlf53Nv/HymImnWyNmilrTnF+QV+y5Tm
        LdJxZxKQq8RX7Kw5rx0L9PoUeXCDX4aJTuZ31ODCcl/lpfI5
X-Google-Smtp-Source: APXvYqyorQikzFvtwkZdVZMWyfx4SiaVTvIOJ4zVKOI6mYJjyqUXSXjoRR5uj9C81rBsQzLDv4IOdnfxVn9yyXvWLQn3GeVtb29B
MIME-Version: 1.0
X-Received: by 2002:a5d:8143:: with SMTP id f3mr413861ioo.12.1581097450395;
 Fri, 07 Feb 2020 09:44:10 -0800 (PST)
Date:   Fri, 07 Feb 2020 09:44:10 -0800
In-Reply-To: <000000000000d895bd059dffb65c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2de9d059dffefe3@google.com>
Subject: Re: BUG: sleeping function called from invalid context in __kmalloc
From:   syzbot <syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    90568ecf Merge tag 'kvm-5.6-2' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b26831e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69fa012479f9a62
dashboard link: https://syzkaller.appspot.com/bug?extid=98704a51af8e3d9425a9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172182b5e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1590aab5e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+98704a51af8e3d9425a9@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at mm/slab.h:565
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 8873, name: syz-executor545
1 lock held by syz-executor545/8873:
 #0: ffffffff89310218 (sb_lock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
 #0: ffffffff89310218 (sb_lock){+.+.}, at: sget_fc+0xdc/0x640 fs/super.c:521
Preemption disabled at:
[<ffffffff81be818c>] spin_lock include/linux/spinlock.h:338 [inline]
[<ffffffff81be818c>] sget_fc+0xdc/0x640 fs/super.c:521
CPU: 1 PID: 8873 Comm: syz-executor545 Not tainted 5.5.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 ___might_sleep+0x449/0x5e0 kernel/sched/core.c:6800
 __might_sleep+0x8f/0x100 kernel/sched/core.c:6753
 slab_pre_alloc_hook mm/slab.h:565 [inline]
 slab_alloc mm/slab.c:3306 [inline]
 __do_kmalloc mm/slab.c:3654 [inline]
 __kmalloc+0x6f/0x340 mm/slab.c:3665
 kmalloc include/linux/slab.h:560 [inline]
 path_remove_extra_slash+0xae/0x2a0 fs/ceph/super.c:495
 compare_mount_options fs/ceph/super.c:553 [inline]
 ceph_compare_super+0x1d4/0x560 fs/ceph/super.c:1052
 sget_fc+0x139/0x640 fs/super.c:524
 ceph_get_tree+0x467/0x1540 fs/ceph/super.c:1127
 vfs_get_tree+0x8b/0x2a0 fs/super.c:1547
 do_new_mount fs/namespace.c:2822 [inline]
 do_mount+0x18ee/0x25a0 fs/namespace.c:3142
 __do_sys_mount fs/namespace.c:3351 [inline]
 __se_sys_mount+0xdd/0x110 fs/namespace.c:3328
 __x64_sys_mount+0xbf/0xd0 fs/namespace.c:3328
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441289
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffe85f476d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441289
RDX: 0000000020000140 RSI: 00000000200000c0 RDI: 0000000020000040
RBP: 00000000006cb018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402000
R13: 0000000000402090 R14: 0000000000000000 R15: 0000000000000000
ceph: No mds server is up or the cluster is laggy

