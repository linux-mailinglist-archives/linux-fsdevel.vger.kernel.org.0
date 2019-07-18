Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1060F6CDF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 14:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390303AbfGRMSJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 08:18:09 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54368 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390260AbfGRMSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 08:18:08 -0400
Received: by mail-io1-f71.google.com with SMTP id n8so30646203ioo.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 05:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=puUKYuR94Cgk2/T1XPn1EMT/4tNJCdW6qsdq1yUHLPk=;
        b=ioVYlzI5ioiCPeVx87dtJjZKHIRtk4GlOP9KzhhwtWUUe1E88bXI3SIYv/jXifo9FR
         g0N7sqhnxqR4/F6vb5YwkZD9YtjkdZQwoWDO6+SJLebwi09d8RwJHw+LXaVRckcW8dSJ
         lkLXx2ycx2/BCakoCM+SunlLqHWaf11gStrxL/g2dV2ZKwaP77FI0xe9MqYUt4P8WCTv
         D2g2vxVlP1f+zg9ay5f5uBNRpws8yjvS1ysT/HK+lASl5uQrAIRxMB1mSWbVwzjZqhfZ
         +WVfM2rjEZizawiKcTzJDWJTsgVSHQZWJQq7zjU6i0Z12XxLnv8KNDMbPEZke3tcejAp
         vzNQ==
X-Gm-Message-State: APjAAAV3ME0fEG9YQV4SB6dIo/1QDs3LDl1ku6XCyRUwnbtWJ4x+fyct
        vshWCAhF8XNxMAUBqmgW8khNGWidCCARq4iXy851nOhvFfvB
X-Google-Smtp-Source: APXvYqzpb126gAYM0q5d9sGeWgsi5RdaaYOBkwEpvaRLsmmbpPAguaHkeevyjBhoItW0sHseKgNBYlm+R6hNeULNAhYL6s/4crNy
MIME-Version: 1.0
X-Received: by 2002:a5d:8a06:: with SMTP id w6mr24846003iod.267.1563452287622;
 Thu, 18 Jul 2019 05:18:07 -0700 (PDT)
Date:   Thu, 18 Jul 2019 05:18:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2aeb058df39a3c@google.com>
Subject: general protection fault in kstrtouint (2)
From:   syzbot <syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, gregkh@linuxfoundation.org,
        kstewart@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e40115c0 Add linux-next specific files for 20190717
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d51b70600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
dashboard link: https://syzkaller.appspot.com/bug?extid=398343b7c1b1b989228d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e7434600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1399554c600000

The bug was bisected to:

commit 71cbb7570a9a0b830125163c20125a8b5e65ac45
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 25 16:38:31 2019 +0000

     vfs: Move the subtype parameter into fuse

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14323078600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16323078600000
console output: https://syzkaller.appspot.com/x/log.txt?x=12323078600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+398343b7c1b1b989228d@syzkaller.appspotmail.com
Fixes: 71cbb7570a9a ("vfs: Move the subtype parameter into fuse")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9017 Comm: syz-executor410 Not tainted 5.2.0-next-20190717 #40
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
RIP: 0010:kstrtouint+0x85/0x1a0 lib/kstrtox.c:222
Code: 04 00 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 6c 35  
35 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c  
89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 db 00 00 00
RSP: 0018:ffff8880997a79e0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880997a7b38 RCX: ffffffff81c482dc
RDX: 0000000000000000 RSI: ffffffff833d4f84 RDI: 0000000000000000
RBP: ffff8880997a7a70 R08: ffff8880a17ce100 R09: ffffed1015d06c84
R10: ffffed1015d06c83 R11: ffff8880ae83641b R12: 0000000000000000
R13: 1ffff110132f4f3d R14: ffff8880997a7a48 R15: 0000000000000000
FS:  0000555556585880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455340 CR3: 0000000095a49000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fs_parse+0xde1/0x1080 fs/fs_parser.c:209
  fuse_parse_param+0xac/0x750 fs/fuse/inode.c:491
  vfs_parse_fs_param+0x2ca/0x540 fs/fs_context.c:145
  vfs_parse_fs_string+0x105/0x170 fs/fs_context.c:188
  generic_parse_monolithic+0x181/0x200 fs/fs_context.c:228
  parse_monolithic_mount_data+0x69/0x90 fs/fs_context.c:708
  do_new_mount fs/namespace.c:2779 [inline]
  do_mount+0x1369/0x1c30 fs/namespace.c:3103
  ksys_mount+0xdb/0x150 fs/namespace.c:3312
  __do_sys_mount fs/namespace.c:3326 [inline]
  __se_sys_mount fs/namespace.c:3323 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3323
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440299
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff19b997e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff19b997f0 RCX: 0000000000440299
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00000000006cb018 R08: 00000000200002c0 R09: 65732f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b80
R13: 0000000000401c10 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 8c219e63b0160ea4 ]---
RIP: 0010:kstrtoull lib/kstrtox.c:123 [inline]
RIP: 0010:kstrtouint+0x85/0x1a0 lib/kstrtox.c:222
Code: 04 00 f3 f3 f3 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 6c 35  
35 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 4c  
89 e2 83 e2 07 38 d0 7f 08 84 c0 0f 85 db 00 00 00
RSP: 0018:ffff8880997a79e0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880997a7b38 RCX: ffffffff81c482dc
RDX: 0000000000000000 RSI: ffffffff833d4f84 RDI: 0000000000000000
RBP: ffff8880997a7a70 R08: ffff8880a17ce100 R09: ffffed1015d06c84
R10: ffffed1015d06c83 R11: ffff8880ae83641b R12: 0000000000000000
R13: 1ffff110132f4f3d R14: ffff8880997a7a48 R15: 0000000000000000
FS:  0000555556585880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455340 CR3: 0000000095a49000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
