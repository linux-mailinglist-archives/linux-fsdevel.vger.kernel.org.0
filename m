Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09385EFE9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 22:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiI2UZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiI2UZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:25:39 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A374365
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 13:25:36 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id w2-20020a056e021c8200b002f5c95226e0so1959256ill.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Sep 2022 13:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UI22FiPQswYrRdyQExh609sgxrFQuRTQxjhukc8FmtY=;
        b=hDAhY0Ix1A07ZZMihxPyVEsWtu9I5DVFTc8/zKXA7vJ6TsP5pCq1ouG/jr7Gepej5+
         rRp8ajgYb1o1A4VWghuZDUjCTyN60TehPnDo/1y7QzF3C/ZiKeuWJm5vMvlyc8Ss4JQu
         WqQ9wnm1igI92r83QRodlOfvyenFpdDZHBZkIpxd+c5OsYO8rpBs0M//p6iaJCHX+Tft
         kFrjHf/auPGIdO4EiLN+86L1MvwRh8J8uFXd2fAG1kfPVioMt8LqxtRpBZ0VvrlTi2O6
         y3f9/Tndpf3GuZMKNb5LubFgJywKsOFnS+Q12EEwqKRGcw5P5Dpo/itiPGalJDOOJpky
         X1Zg==
X-Gm-Message-State: ACrzQf0/wkZ+sMa39bdhjcYWAuyGQU2fCO01Yz5gBjJG2fJnLvUQBrX3
        XfqOukZgyCVWDGzjir0cwdzN/GaFqe/GqVy1uPAbaekbhOz8
X-Google-Smtp-Source: AMsMyM5o85Rtnb05obKIDqqaLPG8PtoP4p4Pi7MiqLywo05g05XZZOFyq+i6zqz91zZ1dXiExdOAJpR3Uw2LjPMKg3Zvk5nY1UwT
MIME-Version: 1.0
X-Received: by 2002:a92:c5b0:0:b0:2f6:a5f1:9311 with SMTP id
 r16-20020a92c5b0000000b002f6a5f19311mr2391742ilt.55.1664483136081; Thu, 29
 Sep 2022 13:25:36 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:25:36 -0700
In-Reply-To: <0000000000008ea2da05e979435f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000f962805e9d6ae62@google.com>
Subject: Re: [syzbot] kernel panic: stack is corrupted in writeback_single_inode
From:   syzbot <syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=17ab519c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=84b7b87a6430a152c1f4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=157c2000880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105224b8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84b7b87a6430a152c1f4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8226
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: writeback_single_inode+0x8e7/0x8f0
CPU: 0 PID: 10213 Comm: syz-executor262 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 panic+0x2d6/0x715 kernel/panic.c:274
 __stack_chk_fail+0x12/0x20 kernel/panic.c:706
 writeback_single_inode+0x8e7/0x8f0
 write_inode_now+0x1cd/0x260 fs/fs-writeback.c:2723
 iput_final fs/inode.c:1735 [inline]
 iput+0x3e6/0x760 fs/inode.c:1774
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
RIP: 0033:0x7f5a7dd5549a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 98 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedfc06378 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f5a7dd5549a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffedfc06390
RBP: 00007ffedfc06390 R08: 00007ffedfc063d0 R09: 00005555563ee2c0
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffedfc063d0 R14: 0000000000000015 R15: 0000000020000db8
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..

