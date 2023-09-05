Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708167924CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjIEP7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354175AbjIEKEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:04:36 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5C1B6
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Sep 2023 03:04:32 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-271bb60d8a8so3350522a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Sep 2023 03:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908272; x=1694513072;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwZYeHvtD9GZdB9/hKTalrH/ocSz88uD/tT+zhW9brI=;
        b=Vt+zgznxrM7ojT7ZjTymKYwI2aDiNGl3aZXitoUY4Yag0QuoE4QbhfboPgY8jc8uUZ
         sYwohLfy2btFuFA3oOBsrQ0TnZtMfg6mgvP7hhIvSBEodNkQ4OpdkU9+8kp6XjaxT2UT
         8NlEJcTlw/tqHfBSsdUZfl45FT/btY+qTlA2+UMYG1AwmH9jKM0rV1J4UHadTP8AUWse
         XkYTdsop/Hl4Kwc1wWh5/Rw2SflBMxKmwSDEOTDYHbrK6sIW81kwbR89/iALDDcRoH/9
         UfkW/szK7DDbgstByDbcV5UjynsnKhPQqIfD1+oBCteuB1+lPayJSXXlxV5MClKQEkJX
         Rmtw==
X-Gm-Message-State: AOJu0YzYfdhjeL7DGDS+k9FhHr2x/Jo4SfNCbmgA6N/zl3EpSmti0ypY
        n01DRvqGJmC1ovhLUNvpR0GAyYbBYkguKkCxBxqJ413YlkE/
X-Google-Smtp-Source: AGHT+IHikA7EnkeoU+BIWTDaP4XZIFS90veVBj/F+9Kv4krrGsmoDY8YF039ZFFbOkLb9ZOdVyHzzQ05/3mjkQGls8eEuUPFLn53
MIME-Version: 1.0
X-Received: by 2002:a17:902:f344:b0:1bb:a13a:c21e with SMTP id
 q4-20020a170902f34400b001bba13ac21emr3542263ple.10.1693908272272; Tue, 05 Sep
 2023 03:04:32 -0700 (PDT)
Date:   Tue, 05 Sep 2023 03:04:32 -0700
In-Reply-To: <CANp29Y65sCETzq3CttPHww40W_tQ2S=0HockV-aSUi9dE8HGow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9daf4060499c0c9@google.com>
Subject: Re: [syzbot] [block] kernel BUG in __block_write_begin_int
From:   syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, djwong@kernel.org, hch@infradead.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nogikh@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, yukuai3@huawei.com,
        zhang_shurong@foxmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __kthread_create_on_node

------------[ cut here ]------------
different return values (11 and 6) from vsnprintf("kmmpd-%.*s", ...)
WARNING: CPU: 1 PID: 12350 at lib/kasprintf.c:31 kvasprintf+0x17b/0x190 lib/kasprintf.c:30
Modules linked in:
CPU: 1 PID: 12350 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller-11705-gfd19eb3c02e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
RIP: 0010:kvasprintf+0x17b/0x190 lib/kasprintf.c:30
Code: 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 cb db 55 fd 48 c7 c7 a0 0a 59 8b 44 89 e6 89 da 48 8b 4c 24 18 e8 65 56 1c fd <0f> 0b eb 98 e8 2c 46 90 06 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3
RSP: 0018:ffffc90003507620 EFLAGS: 00010246
RAX: 2ce359f82b370100 RBX: 0000000000000006 RCX: ffff88806a543b80
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900035076f0 R08: ffffffff81541672 R09: 1ffff1101732516a
R10: dffffc0000000000 R11: ffffed101732516b R12: 000000000000000b
R13: ffffc90003507880 R14: 1ffff920006a0ec8 R15: ffff888025476fa0
FS:  00007f224ed5d6c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c420000 CR3: 00000000691b6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kthread_create_on_node+0x1a9/0x3c0 kernel/kthread.c:444
 kthread_create_on_node+0xde/0x120 kernel/kthread.c:512
 ext4_multi_mount_protect+0x792/0x9f0 fs/ext4/mmp.c:392
 __ext4_fill_super fs/ext4/super.c:5363 [inline]
 ext4_fill_super+0x4495/0x6d10 fs/ext4/super.c:5703
 get_tree_bdev+0x416/0x5b0 fs/super.c:1577
 vfs_get_tree+0x8c/0x280 fs/super.c:1750
 do_new_mount+0x28f/0xae0 fs/namespace.c:3335
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f224e07e1ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f224ed5cee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f224ed5cf80 RCX: 00007f224e07e1ea
RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007f224ed5cf40
RBP: 0000000020000040 R08: 00007f224ed5cf80 R09: 0000000000004500
R10: 0000000000004500 R11: 0000000000000246 R12: 0000000020000500
R13: 00007f224ed5cf40 R14: 00000000000004b4 R15: 0000000020000540
 </TASK>


Tested on:

commit:         fd19eb3c iomap: handle error conditions more gracefull..
git tree:       git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=11955af0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=4a08ffdf3667b36650a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
