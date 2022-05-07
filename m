Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FABF51E767
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 15:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385216AbiEGNbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 May 2022 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377186AbiEGNbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 May 2022 09:31:07 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8180186D8
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 May 2022 06:27:20 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ay38-20020a5d9da6000000b0065adc1f932bso244476iob.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 May 2022 06:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=J+Bej5ZpoBm/gMBTL/LrXbQDx5WmOQgVK8bCmav5T6w=;
        b=iUqmKb7RVjD9NlpLoxRj5E2DITcG4snFo4PIYMUk8nmx6egbWMWMeLrEEeowWnzEv5
         CBaH4GCxt/aJl/3twLpSUJAYUavNnkhF12m83AIFaIsxLLfkN/FdbIujy529ZA6nIilu
         7YcSJ+0TawiaDK0ITl0E5/3lA3jDWM9T1n1fWSkDpmB9rqr1lKaazoTYUaqxwYk3A41P
         smhmF1O4TqGfL9w1WUvYcYMYn4vc1cbMjdcswsEa/APr93vwNT26M96SXn0GsKqLvvaa
         NWgAtf5AqhjbLM39UelJWBWyhHW0A3R3HRVP7Fi9VaUi2I/KGSz/Z9xCkAPNyXp8mFCT
         uESw==
X-Gm-Message-State: AOAM533ypuqnfKdUkilp+FtoCrNSwSsQexLr+vbUbwjZfwndX/XJmUMX
        6s0LP3FakWNG6ypsUPKmNXYfaHqgFIZ7Kml3Y7ejnuzVh7Dg
X-Google-Smtp-Source: ABdhPJzCYviIpRnTxq7ljtByJ36DYz0i/Ppwyct1u2/SH2lMa4OD2RvdQP8c1uKuIJ+zcNoouIjj30RZEnM7BH1HLhS1TqJu0fMN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22ca:b0:32b:71de:8f04 with SMTP id
 j10-20020a05663822ca00b0032b71de8f04mr3255103jat.128.1651930040245; Sat, 07
 May 2022 06:27:20 -0700 (PDT)
Date:   Sat, 07 May 2022 06:27:20 -0700
In-Reply-To: <0000000000005b04fa05dd71e0e0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e29af05de6bef3c@google.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Write in end_buffer_read_sync
From:   syzbot <syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4b97bac0756a Merge tag 'for-5.18-rc5-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba2e16f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f179a672dc8535fc
dashboard link: https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a34afef00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177360b2f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f7f291a3d327486073c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: out-of-bounds in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: out-of-bounds in atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
BUG: KASAN: out-of-bounds in put_bh include/linux/buffer_head.h:284 [inline]
BUG: KASAN: out-of-bounds in end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
Write of size 4 at addr ffffc900035879d8 by task ksoftirqd/3/33

CPU: 3 PID: 33 Comm: ksoftirqd/3 Not tainted 5.18.0-rc5-syzkaller-00163-g4b97bac0756a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xf/0x467 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
 put_bh include/linux/buffer_head.h:284 [inline]
 end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
 end_bio_bh_io_sync+0xda/0x130 fs/buffer.c:2999
 bio_endio+0x5fe/0x780 block/bio.c:1541
 req_bio_endio block/blk-mq.c:686 [inline]
 blk_update_request+0x401/0x1310 block/blk-mq.c:815
 blk_mq_end_request+0x4b/0x80 block/blk-mq.c:941
 lo_complete_rq+0x1c2/0x280 drivers/block/loop.c:369
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1012
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90003580000, ffffc90003589000) created by:
 kernel_clone+0xe7/0xab0 kernel/fork.c:2639

------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:660!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 33 Comm: ksoftirqd/3 Not tainted 5.18.0-rc5-syzkaller-00163-g4b97bac0756a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:vmalloc_to_page+0x46e/0x4f0 mm/vmalloc.c:660
Code: c1 ff 4d 31 fc 4d 21 f4 49 c1 ec 0c 4c 01 e3 49 bc 00 00 00 00 00 ea ff ff 48 c1 e3 06 49 01 dc e9 35 ff ff ff e8 d2 d5 c1 ff <0f> 0b e8 cb d5 c1 ff 0f 0b 45 31 e4 e9 1f ff ff ff e8 bc d5 c1 ff
RSP: 0018:ffffc900007cfbe8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888011b80200 RSI: ffffffff81b69dfe RDI: 0000000000000003
RBP: ffffffff8ba8e000 R08: 00001ffffffffffe R09: 0000000000000000
R10: ffffffff81b69a16 R11: 0000000000000000 R12: 0000370000000000
R13: 0000000000000000 R14: ffff888011b80200 R15: ffff8880231b6188
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562fada51cf8 CR3: 000000001d3dd000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 print_address_description.constprop.0.cold+0x2ce/0x467 mm/kasan/report.c:350
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:257 [inline]
 put_bh include/linux/buffer_head.h:284 [inline]
 end_buffer_read_sync+0x24/0x30 fs/buffer.c:160
 end_bio_bh_io_sync+0xda/0x130 fs/buffer.c:2999
 bio_endio+0x5fe/0x780 block/bio.c:1541
 req_bio_endio block/blk-mq.c:686 [inline]
 blk_update_request+0x401/0x1310 block/blk-mq.c:815
 blk_mq_end_request+0x4b/0x80 block/blk-mq.c:941
 lo_complete_rq+0x1c2/0x280 drivers/block/loop.c:369
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1012
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vmalloc_to_page+0x46e/0x4f0 mm/vmalloc.c:660
Code: c1 ff 4d 31 fc 4d 21 f4 49 c1 ec 0c 4c 01 e3 49 bc 00 00 00 00 00 ea ff ff 48 c1 e3 06 49 01 dc e9 35 ff ff ff e8 d2 d5 c1 ff <0f> 0b e8 cb d5 c1 ff 0f 0b 45 31 e4 e9 1f ff ff ff e8 bc d5 c1 ff
RSP: 0018:ffffc900007cfbe8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000100
RDX: ffff888011b80200 RSI: ffffffff81b69dfe RDI: 0000000000000003
RBP: ffffffff8ba8e000 R08: 00001ffffffffffe R09: 0000000000000000
R10: ffffffff81b69a16 R11: 0000000000000000 R12: 0000370000000000
R13: 0000000000000000 R14: ffff888011b80200 R15: ffff8880231b6188
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562fada51cf8 CR3: 000000001d3dd000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

