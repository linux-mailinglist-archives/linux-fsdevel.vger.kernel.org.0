Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0680225A5E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgIBG5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 02:57:32 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55122 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIBG5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:57:23 -0400
Received: by mail-io1-f70.google.com with SMTP id o18so2623142ioa.21
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vVhH60e9fj5cgVGa44bdaFJhul6+UjTv5zPn3UCBUNI=;
        b=mkud/UXV/GTu1HMGSIIxHjPplyEfSVTWuLJ0KuHiI3Qo2+Kwhdr/WGQE3teb+zm3xW
         rXQUiDxoUf/Ti1I6KFEAyZp5KjGwCzfhgLiEZUGnYmdZQhK9tyl4ak80s/65fl41VR1J
         q2L70y86bn+f1FVRrliX4Aveco/QUUwuM3eWFCSG2/b7LuHkZE1ezC7nMM9/yQ6YE5oH
         mJWE8xnMoLRQWWW3Ett5tt7jVMFmn39xT4O13XdIR931+MUeuJEMHgqI20gsHByGP2da
         noOfPevZI0n+xZS/wYTG38Z/d/xxBWFQgndWvbvAlWta5Www1uiw2SNtoqfeflcQAv5c
         gKBg==
X-Gm-Message-State: AOAM531cMXG7gehlQrTV+C6gFRuPNnEB9S54v7pIx//VeQogmiPpyTqS
        RQnmjsgPnSJTqQeeX7Z6CoP43lVtLr4Mi3HckavIWAfGCR4u
X-Google-Smtp-Source: ABdhPJwqEXqxJvgARrBXodvsncu4+BWSCzjCpyIGvhljnIadgWY5b8Sy4JKFyVHF+q3XHzMj7eicgnlID252zECoEMpHsin4Bopq
MIME-Version: 1.0
X-Received: by 2002:a92:2605:: with SMTP id n5mr2494721ile.275.1599029842630;
 Tue, 01 Sep 2020 23:57:22 -0700 (PDT)
Date:   Tue, 01 Sep 2020 23:57:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c15ee205ae4f2531@google.com>
Subject: general protection fault in snd_ctl_release
From:   syzbot <syzbot+dd94e1d44f61c258d538@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, dan.carpenter@oracle.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, o-takashi@sakamocchi.jp, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b51594df Merge tag 'docs-5.9-3' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=172fea15900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
dashboard link: https://syzkaller.appspot.com/bug?extid=dd94e1d44f61c258d538
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179811c1900000

The issue was bisected to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14406199900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16406199900000
console output: https://syzkaller.appspot.com/x/log.txt?x=12406199900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd94e1d44f61c258d538@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 7429 Comm: syz-executor.0 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:snd_ctl_release+0x69/0x3e0 sound/core/control.c:114
Code: 44 24 10 4c 8b b0 b0 01 00 00 48 c7 80 b0 01 00 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f7 02 00 00 49 8b 46 10 4d 8d 6e 08 4c 8d a0 48
RSP: 0018:ffffc900073bfe10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a2a9fcc0 RCX: 1ffffffff11eb3f0
RDX: 0000000000000002 RSI: ffffffff860cbd2b RDI: 0000000000000010
RBP: ffff8880a2a9fcc0 R08: 0000000000000001 R09: ffffffff89cc5567
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a2a9fd44
R13: ffff8880a2a9fce8 R14: 0000000000000000 R15: ffff8880a4bc1468
FS:  00007f30f5cd0700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000096ced000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x1e1/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f30f5ccfc78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: 0000000000000000 RBX: 0000000000002ac0 RCX: 000000000045d5b9
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000006
RBP: 000000000118cf88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000180 R11: 0000000000000246 R12: 000000000118cf4c
R13: 000000000169fb6f R14: 00007f30f5cd09c0 R15: 000000000118cf4c
Modules linked in:
---[ end trace d1d5678dff9246de ]---
RIP: 0010:snd_ctl_release+0x69/0x3e0 sound/core/control.c:114
Code: 44 24 10 4c 8b b0 b0 01 00 00 48 c7 80 b0 01 00 00 00 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f7 02 00 00 49 8b 46 10 4d 8d 6e 08 4c 8d a0 48
RSP: 0018:ffffc900073bfe10 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a2a9fcc0 RCX: 1ffffffff11eb3f0
RDX: 0000000000000002 RSI: ffffffff860cbd2b RDI: 0000000000000010
RBP: ffff8880a2a9fcc0 R08: 0000000000000001 R09: ffffffff89cc5567
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a2a9fd44
R13: ffff8880a2a9fce8 R14: 0000000000000000 R15: ffff8880a4bc1468
FS:  00007f30f5cd0700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000096ced000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
