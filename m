Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1085EDBDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiI1Lfn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 07:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiI1Lfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:35:40 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF23F1D8
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 04:35:39 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h10-20020a92c26a000000b002f57c5ac7dbso9632424ild.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 04:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pRZJ1OlsJSNPMbfM7HJvwOM1y5KXyx9UDn2zTMz2krQ=;
        b=JkKXWBUxHo5lw7aKNepPwRbz5htvhzyScSaW2sCIzQzM7IlZjKFCZoquChDzJy1bWw
         OO7+F1R95lG8bDZghIvp/LDkL4JbkqMxZNxmG5AG8Arphle7Rt4qyr5Bm7lv3dS2h19N
         1EhDdvYp5PJ76240IqLOAriav1GCzYnuCAlLNCCUIBR1irK3RItkC4bvXb2MwcDaJVeJ
         kuqvpK9vtBPgvoa/4G2yAjzaXhgHM9dUZk56LQwhtjXkk2S+KHevfePtfXbDmuF70zzt
         Z+AfxbXU5ALD8hzk8XyQm6YE8W+pWYCcK8gOckSlDwfHopDrs5Yf/xUxrdY8QI3eWAjg
         foTg==
X-Gm-Message-State: ACrzQf0BGdMkMPpa6xr6LSbI+E0P6Jz8NERE70AWpJ7pTFQH8peL6SoE
        /xrUR65xSJysqrv4bov0W8n75PE0omE2/C7W9tl2m+WxyXXM
X-Google-Smtp-Source: AMsMyM6li4R36u/SPMJT8QqfPWAd8mDFnmkYbMN0aBRezWz8+9oPgT9vlVDycKlx9AqEKKj8JrRC54fS+7wc2/TO712hp/ikx0qd
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:2f1:9b43:9157 with SMTP id
 v13-20020a056e02164d00b002f19b439157mr15185688ilu.94.1664364938555; Wed, 28
 Sep 2022 04:35:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 04:35:38 -0700
In-Reply-To: <000000000000f121b705df9f5a0a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f07a0e05e9bb2866@google.com>
Subject: Re: [syzbot] WARNING in folio_account_dirtied
From:   syzbot <syzbot+8d1d62bfb63d6a480be1@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, akpm@linux-foundation.org,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    46452d3786a8 Merge tag 'sound-6.0-rc8' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=160fa19c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1d62bfb63d6a480be1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1208f950880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14864e9c880000

Downloadable assets:
disk image: https://storage.googleapis.com/a6170e8216df/disk-46452d37.raw.xz
vmlinux: https://storage.googleapis.com/cbd307bfbc89/vmlinux-46452d37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d1d62bfb63d6a480be1@syzkaller.appspotmail.com

gfs2: fsid=loop0.0: found 19 quota changes
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3609 at include/linux/backing-dev.h:246 folio_account_dirtied+0x61a/0x720 mm/page-writeback.c:2564
Modules linked in:
CPU: 1 PID: 3609 Comm: syz-executor421 Not tainted 6.0.0-rc7-syzkaller-00042-g46452d3786a8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:inode_to_wb include/linux/backing-dev.h:243 [inline]
RIP: 0010:folio_account_dirtied+0x61a/0x720 mm/page-writeback.c:2564
Code: ff ff e9 6e fd ff ff e8 a4 48 d1 ff 4c 89 f7 4c 89 e6 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3b ed 2a 00 e8 86 48 d1 ff <0f> 0b 43 80 3c 3c 00 0f 85 36 fd ff ff e9 39 fd ff ff 48 c7 c1 54
RSP: 0018:ffffc90003b3f6b8 EFLAGS: 00010093
RAX: ffffffff81b640fa RBX: 0000000000000000 RCX: ffff88807c9a1d80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888012427578 R08: ffffffff81b640be R09: ffffed1002484eb0
R10: ffffed1002484eb0 R11: 1ffff11002484eaf R12: 1ffff11002484eaf
R13: 0000000000000001 R14: ffffea0001f30480 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdce840000 CR3: 0000000027af8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __folio_mark_dirty+0x125/0x260 mm/page-writeback.c:2615
 __set_page_dirty include/linux/pagemap.h:1057 [inline]
 mark_buffer_dirty+0x253/0x550 fs/buffer.c:1105
 gfs2_unpin+0x10b/0xa20 fs/gfs2/lops.c:111
 buf_lo_after_commit+0x172/0x1d0 fs/gfs2/lops.c:747
 lops_after_commit fs/gfs2/lops.h:49 [inline]
 gfs2_log_flush+0x1179/0x26a0 fs/gfs2/log.c:1107
 do_sync+0xa3c/0xc80 fs/gfs2/quota.c:979
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1322
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:642
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x55e/0x20a0 kernel/exit.c:795
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8d10697139
Code: Unable to access opcode bytes at RIP 0x7f8d1069710f.
RSP: 002b:00007ffdce83f9e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8d10745330 RCX: 00007f8d10697139
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00005555574d02c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d10745330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

