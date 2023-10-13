Return-Path: <linux-fsdevel+bounces-262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09907C88B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A6DB20979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 15:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797B1B29D;
	Fri, 13 Oct 2023 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900D1A266
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 15:30:54 +0000 (UTC)
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63FBD
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:30:53 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1e170528d43so2617519fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 08:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697211052; x=1697815852;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhJ4hNQE1jF7Xc7uGs+UQjjw34bM64JOf7BnAqEBrGs=;
        b=mRpzdbbvk7deKWSl4gBLZmwbQLMvu/L+GRCGtD2c9UB5rzGhAi83OFFXrazlFpybew
         M767Uh4vrBx2Gebjce2TdvyHHeHKcjkdYwAAIl1nCswbn07VbWmt55tS3UT2zZ+qZauO
         AFGzxJZB/xdokPb4GdeAoWKIsY27DTgdrK457/F7k5AIXbCrAgCCwrFCk5v/WIr1yeuo
         /s+TQ+MwhGWaUBW2GPV3Xcq1pHpukAGCsWRDJoCKGdli7Ozry6Pp9+X7bcJ3OUQdTW3J
         mSW7KXkzFZGurxr9iqIV2zcEqciORVZJtoRnbymcYdh9ZFz5dYa6S/v40EWSzEOEx3bD
         Gzfw==
X-Gm-Message-State: AOJu0YwTX7gpJhd6fq+H2ZmLqx9XtbaCYjnYLHx4UvFZdrbCF+O82WAN
	Ffl313pFfn9KUhqWMwS8YxSDt7uYpe14AwknJ0DjlgCmPx2k
X-Google-Smtp-Source: AGHT+IGHrc+EEUWgxVOKQQwB6eTUTwuRMO/wXYfx22aThVpmlW75dhx20KUPMKtI7FNZztc322nCN4qtWZtpxG2MQN83M1QVZ5cn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:718f:b0:1e9:c362:a397 with SMTP id
 d15-20020a056870718f00b001e9c362a397mr1546778oah.10.1697211052430; Fri, 13
 Oct 2023 08:30:52 -0700 (PDT)
Date: Fri, 13 Oct 2023 08:30:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e39e0e06079abd8e@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in __d_lookup_rcu / dont_mount
From: syzbot <syzbot+b015897b5913b3aa2ecd@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

syzbot found the following issue on:

HEAD commit:    94f6f0550c62 Linux 6.6-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152d6bee680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70d8e328e7a4e377
dashboard link: https://syzkaller.appspot.com/bug?extid=b015897b5913b3aa2ecd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a29ef1a56e4/disk-94f6f055.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24e09ea50a82/vmlinux-94f6f055.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1365bbf9b381/bzImage-94f6f055.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b015897b5913b3aa2ecd@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __d_lookup_rcu / dont_mount

read to 0xffff8881382e76c0 of 4 bytes by task 3386 on cpu 0:
 __d_lookup_rcu+0x42/0x290 fs/dcache.c:2360
 lookup_fast+0x8e/0x290 fs/namei.c:1628
 walk_component+0x3f/0x230 fs/namei.c:1997
 lookup_last fs/namei.c:2458 [inline]
 path_lookupat+0x10a/0x2a0 fs/namei.c:2482
 filename_lookup+0x126/0x300 fs/namei.c:2511
 vfs_statx+0xa2/0x430 fs/stat.c:240
 vfs_fstatat+0xcd/0x100 fs/stat.c:295
 __do_sys_newfstatat fs/stat.c:459 [inline]
 __se_sys_newfstatat+0x58/0x260 fs/stat.c:453
 __x64_sys_newfstatat+0x55/0x60 fs/stat.c:453
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read-write to 0xffff8881382e76c0 of 4 bytes by task 3374 on cpu 1:
 dont_mount+0x27/0x40 include/linux/dcache.h:351
 vfs_rmdir+0x2a9/0x2f0 fs/namei.c:4209
 do_rmdir+0x194/0x310 fs/namei.c:4262
 __do_sys_rmdir fs/namei.c:4281 [inline]
 __se_sys_rmdir fs/namei.c:4279 [inline]
 __x64_sys_rmdir+0x30/0x40 fs/namei.c:4279
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 3374 Comm: udevd Not tainted 6.6.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

