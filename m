Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39045F898B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 07:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJIFzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJIFzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 01:55:40 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8862F38B
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Oct 2022 22:55:35 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a9-20020a056e0208a900b002f6b21181f5so6674311ilt.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Oct 2022 22:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1e49F6pdV+AWMuuc3KbRnlfX9XsIRyk9pFi0eLPFLzI=;
        b=bDygCkOcGXQoxAydtS9O7BoWh8/BdgaHW+eT/b1QVvK5K1+AAeladdi1wtFMPk5uFR
         a87MovIl9VIUmGdg5Wm4vkGX/9TgY54y55fqyiHYSa4Nd3f1BL4vaPOynl9yfPPQXmxT
         Bu74Rox7BHaoE4zJ/a0u4xBUjDqgs0Fy2sT98hHBg5kKDFfK5yGDrX/Vvs3N+oYQyvRG
         HScBpnij9z+jGeIWoikUcfj1fb35xhxfWgKj9tB1R7Klyur8GUDdMpIoHh85qxpQzsHf
         Ii+3C0gW5CEsxyUnVTDMF8Mu/AfWieSWBwOfPiVcRlqfVQBvzfUhwl0irnLCfexQe/Wd
         bVmg==
X-Gm-Message-State: ACrzQf2I9xNzHROU4bJ52VLYhWA3krNrMBU257mLDGuq5QyLtLm7UARR
        E9RW6Vb9WQAvnJQ1rVilye2tcx3bhaqfrxZfwnBaS8bU+Q4y
X-Google-Smtp-Source: AMsMyM7JfrVM7uYLXXaZRLXDOALw+Kpkyol8U8DnxEbbYe9HVN1B+TnzFqpzH2lUNzmB0rplo6I1/rKLlVBTw/ge+E0EUV1PfVVX
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1592:b0:6a2:1feb:4809 with SMTP id
 e18-20020a056602159200b006a21feb4809mr5943533iow.214.1665294934647; Sat, 08
 Oct 2022 22:55:34 -0700 (PDT)
Date:   Sat, 08 Oct 2022 22:55:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006aa2405ea93b166@google.com>
Subject: [syzbot] BUG: scheduling while atomic in exit_to_user_mode_loop
From:   syzbot <syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15b1382a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d323d85b1f8a4ed7
dashboard link: https://syzkaller.appspot.com/bug?extid=cceb1394467dba9c62d9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1755e8b2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c40d70ae7512/disk-0326074f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3603ce065271/vmlinux-0326074f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/738016e3c6ba/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cceb1394467dba9c62d9@syzkaller.appspotmail.com

ntfs3: loop2: Different NTFS' sector size (1024) and media sector size (512)
BUG: scheduling while atomic: syz-executor.2/9901/0x00000002
2 locks held by syz-executor.2/9901:
 #0: ffff888075f880e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0x212/0x920 fs/super.c:228
 #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #1: ffff8880678e78f0 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0
Kernel panic - not syncing: scheduling while atomic
CPU: 1 PID: 9901 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __schedule_bug+0x1ff/0x250 kernel/sched/core.c:5725
 schedule_debug+0x1d3/0x3c0 kernel/sched/core.c:5754
 __schedule+0xfb/0xdf0 kernel/sched/core.c:6389
 schedule+0xcb/0x190 kernel/sched/core.c:6571
 exit_to_user_mode_loop+0xe5/0x150 kernel/entry/common.c:157
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 irqentry_exit_to_user_mode+0x5/0x30 kernel/entry/common.c:307
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 000f:lock_acquire+0x1e1/0x3c0
RSP: 0018:ffffc9000563f900 EFLAGS: 00000206
RAX: 1ffff92000ac7f28 RBX: 0000000000000001 RCX: ffff8880753be2f0
RDX: dffffc0000000000 RSI: ffffffff8a8d9060 RDI: ffffffff8aecb5e0
RBP: ffffc9000563fa28 R08: dffffc0000000000 R09: fffffbfff1fc4229
R10: fffffbfff1fc4229 R11: 1ffffffff1fc4228 R12: dffffc0000000000
R13: 1ffff92000ac7f24 R14: ffffc9000563f940 R15: 0000000000000246
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
