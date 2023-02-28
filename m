Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238206A5CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjB1P65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 10:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjB1P6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:58:55 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BE6526E
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 07:58:54 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so6435316ioo.15
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 07:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZoYcwriiDz1JVC+qEJ7hiihRvdZXKR0ltoGL+7jTA4=;
        b=Bck/5/iYmK/1lL7co89+7UMB7Syu3R0SIce5wfZ+FWh3Jw+nheiE9SUYGb0Cr2P1Lp
         xNV3pAGZb5iv+YhzYOLUxc6N0eA72EoAV5K/vzok3MjtZenuSS97SOFkkJxgduMBXe8t
         HDT0gPWX+yi3nBUDRRHfNuKYFBLwvmP4NeO88d749ap7aAVGiRaxYIAF8Llf3y2HELX8
         ZhPgoCCtRBcLdEyzA7ZnV/Yy2RW2EaaA/UKGDIihO298FKvI8oe7tjfes0A6v/bE3YKY
         ojpPXCBrfP3AMShg9AQStwZD4dFSvdOJeW+4iP6ABxf3fW9nEcJ1Z8UX1ciyOxY3bFUF
         4b1w==
X-Gm-Message-State: AO0yUKWetnQihtA87+/uOwP/34Wkt1hx1HH+TM6YDTCHPJHd2fCuYVqD
        f/G4yTj38zkFaQvjQShoQOLuPngolVLHpMYSCXb1EpFGjYDA
X-Google-Smtp-Source: AK7set/RZiAoSBwevk045HZZ2LFr6tLP5PM6QEqsFwyCLlbRN3KJBRX3viqUNJvlZWigpCFEt/ByJtZCFWvPX0Aq72bq4m+C2FAX
MIME-Version: 1.0
X-Received: by 2002:a02:84c9:0:b0:3a9:75c9:da25 with SMTP id
 f67-20020a0284c9000000b003a975c9da25mr1483118jai.1.1677599933963; Tue, 28 Feb
 2023 07:58:53 -0800 (PST)
Date:   Tue, 28 Feb 2023 07:58:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023a79f05f5c4ac51@google.com>
Subject: [syzbot] [mm?] [fs?] WARNING in __folio_mark_dirty (2)
From:   syzbot <syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    2fcd07b7ccd5 mm/mprotect: Fix successful vma_merge() of ne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=117bdb18c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e0edbbd23e5eb14
dashboard link: https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1247507f480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166fefd8c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/89d18c9cc43c/disk-2fcd07b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a91767bc5caa/vmlinux-2fcd07b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90ba2476f5c1/bzImage-2fcd07b7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/813b7d7d9dcd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e14d6cd6ec241f507ba7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5081 at include/linux/backing-dev.h:253 inode_to_wb include/linux/backing-dev.h:253 [inline]
WARNING: CPU: 0 PID: 5081 at include/linux/backing-dev.h:253 folio_account_dirtied mm/page-writeback.c:2656 [inline]
WARNING: CPU: 0 PID: 5081 at include/linux/backing-dev.h:253 __folio_mark_dirty+0xbcb/0xfa0 mm/page-writeback.c:2707
Modules linked in:
CPU: 0 PID: 5081 Comm: syz-executor253 Not tainted 6.2.0-syzkaller-12018-g2fcd07b7ccd5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:inode_to_wb include/linux/backing-dev.h:253 [inline]
RIP: 0010:folio_account_dirtied mm/page-writeback.c:2656 [inline]
RIP: 0010:__folio_mark_dirty+0xbcb/0xfa0 mm/page-writeback.c:2707
Code: 78 70 48 89 44 24 10 e8 73 f4 63 08 31 ff 89 c6 89 44 24 10 e8 46 78 d1 ff 8b 44 24 10 85 c0 0f 85 42 f9 ff ff e8 e5 7b d1 ff <0f> 0b e9 36 f9 ff ff e8 d9 7b d1 ff e8 64 a0 b9 ff 31 ff 41 89 c4
RSP: 0018:ffffc9000404fa28 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88802b47ba80 RSI: ffffffff81b3867b RDI: 0000000000000005
RBP: ffffea0001f93c80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000001
R13: ffffffff8e7847c0 R14: 0000000000000293 R15: ffff88802a46cc50
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd66b0fb000 CR3: 000000000c571000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mark_buffer_dirty+0x3e8/0x570 fs/buffer.c:1148
 gfs2_unpin+0x109/0xcf0 fs/gfs2/lops.c:111
 buf_lo_after_commit+0x144/0x210 fs/gfs2/lops.c:747
 lops_after_commit fs/gfs2/lops.h:49 [inline]
 gfs2_log_flush+0x140f/0x2900 fs/gfs2/log.c:1116
 gfs2_kill_sb+0x6a/0x430 fs/gfs2/ops_fstype.c:1789
 deactivate_locked_super+0x98/0x160 fs/super.c:331
 deactivate_super+0xb1/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1177
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad3/0x2a40 kernel/exit.c:869
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efcc6afa9c9
Code: Unable to access opcode bytes at 0x7efcc6afa99f.
RSP: 002b:00007ffcfb592d38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007efcc6ba7330 RCX: 00007efcc6afa9c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007efcc6ba1e40
R10: 00007ffcfb592c50 R11: 0000000000000246 R12: 00007efcc6ba7330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
