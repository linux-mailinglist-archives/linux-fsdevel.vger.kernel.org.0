Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9173F1A4E95
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Apr 2020 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgDKHjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Apr 2020 03:39:16 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54778 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgDKHjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:39:15 -0400
Received: by mail-il1-f198.google.com with SMTP id m2so4703936ilb.21
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2020 00:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SR2YA+gRBOnmPYpzAYGHcg7N4JVcFTNfL3ArWCrn61U=;
        b=riwIoob+9I7H3ffHDCIzPlsfv9Z2yJikflm8klcGR2tOFzsMcSRbgr84et6YxYSKcl
         gwXw3X5cznnChKBKISUFDb4Mtqvj4WK3DddriXPhNHwyaKcpLhZEUwoLwhEc4lOA4jYi
         QAn/PrRQeNYy7M5WWTWHLU/mswu0I8VbFEvOmOH1t7Ag1b2HWA01ye5Hwrs3Jxqn7dJS
         z9kDHmGHGLQ2yA45AuYnkffJ0r83Qp2t+yVB2Fv1N84sTndyzEDQDt60MPNntvZu1nsd
         3AG0oqYT9stQcaxR506KOjh+orBL4flA8u/a+nN11NxHcvBFNmzwdeie1NuZFkKG8yWm
         QRyw==
X-Gm-Message-State: AGi0PuYDau20zTjveg5WxJkVdrOejKGmJaTG787vtHJaJOWpvcp8r4iT
        WsaFo5otrHE1al477W55lM818NN7M+2kPHtZvBXQBeaAP8cW
X-Google-Smtp-Source: APiQypI3tcC2+zogyWgZTHezJzC93BzR1M5g+tow2+klS5qw7OmdMte71Ullm0LN6WWRwCyJ7BJ2oWjjgBvPZcBv/jVJoZ7IzUDc
MIME-Version: 1.0
X-Received: by 2002:a5d:9494:: with SMTP id v20mr7621253ioj.101.1586590753770;
 Sat, 11 Apr 2020 00:39:13 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:39:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048518b05a2fef23a@google.com>
Subject: WARNING in iomap_apply
From:   syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>
To:     darrick.wong@oracle.com, hch@infradead.org, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127ebeb3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
dashboard link: https://syzkaller.appspot.com/bug?extid=77fa5bdb65cc39711820
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196f257e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c336c7e00000

The bug was bisected to:

commit d3b6f23f71670007817a5d59f3fbafab2b794e8c
Author: Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri Feb 28 09:26:58 2020 +0000

    ext4: move ext4_fiemap to use iomap framework

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c62a57e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15c62a57e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c62a57e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
Fixes: d3b6f23f7167 ("ext4: move ext4_fiemap to use iomap framework")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7023 at fs/iomap/apply.c:51 iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7023 Comm: syz-executor296 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:iomap_apply+0xa0c/0xcb0 fs/iomap/apply.c:51
Code: ff e9 0e fd ff ff e8 23 30 96 ff 0f 0b e9 07 f7 ff ff e8 17 30 96 ff 0f 0b 49 c7 c4 fb ff ff ff e9 35 f9 ff ff e8 04 30 96 ff <0f> 0b 49 c7 c4 fb ff ff ff e9 22 f9 ff ff e8 f1 2f 96 ff 0f 0b e9
RSP: 0018:ffffc90000f87968 EFLAGS: 00010293
RAX: ffff8880a1b00480 RBX: ffffc90000f879c8 RCX: ffffffff81dcf934
RDX: 0000000000000000 RSI: ffffffff81dd016c RDI: 0000000000000007
RBP: 0000000000000000 R08: ffff8880a1b00480 R09: ffffed1015cc70fc
R10: ffff8880ae6387db R11: ffffed1015cc70fb R12: 0000000000000000
R13: ffff888085e716b8 R14: 0000000000000000 R15: ffffc90000f87b50
 iomap_fiemap+0x184/0x2c0 fs/iomap/fiemap.c:88
 _ext4_fiemap+0x178/0x4f0 fs/ext4/extents.c:4860
 ovl_fiemap+0x13f/0x200 fs/overlayfs/inode.c:467
 ioctl_fiemap fs/ioctl.c:226 [inline]
 do_vfs_ioctl+0x8d7/0x12d0 fs/ioctl.c:715
 ksys_ioctl+0xa3/0x180 fs/ioctl.c:761
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl fs/ioctl.c:770 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x440309
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff2dba7508 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440309
RDX: 00000000200003c0 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b90
R13: 0000000000401c20 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
