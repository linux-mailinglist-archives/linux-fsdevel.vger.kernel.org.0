Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB1A595774
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiHPKEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiHPKDQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:03:16 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44336DFA6
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:35:30 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id c7-20020a056e020bc700b002e59be6ce85so4098504ilu.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Aug 2022 01:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=NgcNh9hGYMMKhnfBIfJrWbvhBMoFkUA+1l4p5wBQ3DU=;
        b=Ieij7WgvWcQZJTnr0jnyFv+SChdR2Upg250oOn+IA75fIRfIwbzIWuperCiPqF1oeG
         0gXXlakBiR/N4yplmnxsKdoZGSAufTuti24FPgZ5qW55mO4qj4MxPKnEVQ0+PsFq++UM
         CFnykegFs9MjDqG/lAWrx8nYtPhGxQzVnqVsjQ1j8YyWL22FUfFBPOqmg5gLA6rRlt0c
         M+bcdXUgmfxESbl/NpOgx0QhMghFRhptZ0ZZRZ4LvliwXEeQaucg4S3UVoJirBMzzZ66
         UyIFKDqHwpmlXc4Szf0TSV43IKNg+Eg35Omi19xoiv4X7RuvrkdPJsnQJFYZJisq1lUP
         fElQ==
X-Gm-Message-State: ACgBeo33C7eICcTa8jJ68qRCSzzinoQVu9DgBtG8DVNqFx9AaIEdC16S
        Od/h+ghU/in+efIYa84oOqUqmDwSXbUg/CNm99kto8ObUF/1
X-Google-Smtp-Source: AA6agR56TxC88eTs+iGMTx7PQOgSBTljyVxXWhZNcSU23UjwkVpaJ7zKU3LdEG4fjb/KSq+5/Nm6cIEzXO4NV3UTU3fEfIchPS+4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3047:b0:341:de2b:e489 with SMTP id
 u7-20020a056638304700b00341de2be489mr9333112jak.273.1660638930094; Tue, 16
 Aug 2022 01:35:30 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:35:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087559605e657a1fc@google.com>
Subject: [syzbot] upstream boot error: kernel BUG in __phys_addr
From:   syzbot <syzbot+ec21a071f40cfb3fb6b5@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    568035b01cfb Linux 6.0-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145ae2d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e706e91b2a433db
dashboard link: https://syzkaller.appspot.com/bug?extid=ec21a071f40cfb3fb6b5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec21a071f40cfb3fb6b5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at arch/x86/mm/physaddr.c:28!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 2983 Comm: udevd Not tainted 6.0.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:__phys_addr+0xd3/0x140 arch/x86/mm/physaddr.c:28
Code: e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 f6 50 44 00 48 85 db 75 0f e8 0c 54 44 00 4c 89 e0 5b 5d 41 5c 41 5d c3 e8 fd 53 44 00 <0f> 0b e8 f6 53 44 00 48 c7 c0 10 50 cb 8b 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003127dc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff000000000000 RCX: 0000000000000000
RDX: ffff888078d58100 RSI: ffffffff8136e1a3 RDI: 0000000000000006
RBP: ffff000080000000 R08: 0000000000000006 R09: ffff000080000000
R10: ffff778000000000 R11: 0000000000000000 R12: ffff778000000000
R13: ffff888020ba8000 R14: ffff888020ba8000 R15: 0000000000000000
FS:  00007f11282be840(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560bd6dbe018 CR3: 0000000078ea0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 virt_to_folio include/linux/mm.h:856 [inline]
 virt_to_slab mm/kasan/../slab.h:175 [inline]
 qlink_to_cache mm/kasan/quarantine.c:131 [inline]
 qlist_free_all+0x102/0x1b0 mm/kasan/quarantine.c:184
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc mm/slab.c:3294 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
 kmem_cache_alloc+0x214/0x520 mm/slab.c:3491
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags include/linux/audit.h:320 [inline]
 getname fs/namei.c:218 [inline]
 __do_sys_unlink fs/namei.c:4345 [inline]
 __se_sys_unlink fs/namei.c:4343 [inline]
 __x64_sys_unlink+0xb1/0x110 fs/namei.c:4343
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1127f272d7
Code: f0 ff ff 73 01 c3 48 8b 0d 9e db 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 71 db 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fff542a8478 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1127f272d7
RDX: 0000000000000000 RSI: 0000560bd6dd3fbf RDI: 00007fff542a8498
RBP: 0000560bd6dd3540 R08: 0000000000000000 R09: 0000560bd6dd0d10
R10: 00007f1127fb4fc0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff542a8498 R14: 0000560bd6dd3fb0 R15: 0000560bd53c6160
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__phys_addr+0xd3/0x140 arch/x86/mm/physaddr.c:28
Code: e3 44 89 e9 31 ff 48 d3 eb 48 89 de e8 f6 50 44 00 48 85 db 75 0f e8 0c 54 44 00 4c 89 e0 5b 5d 41 5c 41 5d c3 e8 fd 53 44 00 <0f> 0b e8 f6 53 44 00 48 c7 c0 10 50 cb 8b 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003127dc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff000000000000 RCX: 0000000000000000
RDX: ffff888078d58100 RSI: ffffffff8136e1a3 RDI: 0000000000000006
RBP: ffff000080000000 R08: 0000000000000006 R09: ffff000080000000
R10: ffff778000000000 R11: 0000000000000000 R12: ffff778000000000
R13: ffff888020ba8000 R14: ffff888020ba8000 R15: 0000000000000000
FS:  00007f11282be840(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560bd6dbe018 CR3: 0000000078ea0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
