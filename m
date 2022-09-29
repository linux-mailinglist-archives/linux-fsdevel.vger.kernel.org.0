Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809ED5EFBFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiI2R2l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 13:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbiI2R2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:28:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2441EC9A4
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 10:28:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f32d0d9fceso1614067ilb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 10:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z807byplhOGZeSne3bS7/T5I0SV4CoEzJ41CZMrCPjU=;
        b=0wMHL9tJcPDOOtPxwqZ6eAf87mhUbkNAn4Ke53TnvW0KX15r0MiOB65kNhkP6zrSGv
         u5boQMWkEfVCk48we3bhLne75WcVlSbEYf4W0mgply/1n6Lycf7tQQA8DT7yBQqZbX8u
         6LgxKF6cSxKHZKHDrZzJ5gBPS0drnNZeUe1aAPNYQmyyrymoV6LF9ocicSY5CiS8SkJl
         0Pn3rEngjIZfmq43DOUTiAN3e6AVSPwUYc8Slsi/hl9abmchOIjtKdg00qnq4MxVb1J3
         8VtYcbf1QO+++DqfyIBWezJybSeHsF4kRHXv+uuHp28XUY7kb2mRbdILIEE0l9CU42zY
         AIBQ==
X-Gm-Message-State: ACrzQf3oziKcFWFG5GPidFUoAR6RK6+vSoa29xDIRf01p+3imxW3eKR3
        TPZ7/uZnwVc8OJti/tT9h4JZYaC8cyWFR3p1TnHvf+HiTAQb
X-Google-Smtp-Source: AMsMyM6h+HKCxdz50xpWjeagQWWb6eVYQwOvxxOGx127EMSPRUCrwyGYyT89g9Fiww3+Nt/C1/wQopT36G/UGvY63eexiU9BIxOb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:448d:b0:35a:81aa:939d with SMTP id
 bv13-20020a056638448d00b0035a81aa939dmr2332302jab.312.1664472518262; Thu, 29
 Sep 2022 10:28:38 -0700 (PDT)
Date:   Thu, 29 Sep 2022 10:28:38 -0700
In-Reply-To: <00000000000019db4e05e9712237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000308e1605e9d4351e@google.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in lock_acquire (2)
From:   syzbot <syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16bfb000880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=db99576f362a5c1e9f7a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136be2bc880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1595fe98880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db99576f362a5c1e9f7a@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8226
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: lock_acquire+0x3b6/0x3c0
CPU: 0 PID: 9298 Comm: syz-executor656 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 lock_acquire+0x3b6/0x3c0
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 inode_wait_for_writeback+0x89/0x2c0 fs/fs-writeback.c:1472
 evict+0x277/0x620 fs/inode.c:662
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1b636bcdda
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 d8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1b63666078 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1b636bcdda
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f1b63666090
RBP: 0000000000000004 R08: 00007f1b636660d0 R09: 00007f1b636666b8
R10: 0000000000000000 R11: 0000000000000286 R12: 00007f1b636660d0
R13: 0000000000000015 R14: 00007f1b63666090 R15: 0000000020000db8
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

