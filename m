Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE177131C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Aug 2023 02:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjHFAi6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 5 Aug 2023 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHFAi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 20:38:56 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B705C2105
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Aug 2023 17:38:54 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1bb6fe22b11so4753804fac.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Aug 2023 17:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691282334; x=1691887134;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENFXuACmZMZpQtX2wkxXaz6xdMvAYlZ0UmbIse7Psl4=;
        b=YxeJ7tQhhI3obIzhHNyLdoW/dBlkaYtL42dInd+nIXvdAL/P7Mo0ZJN597y5Zuhu7p
         dVtQgehfLv0Lw/27mb5LAyVl+Z+ss1VJPTKdWxho0UIvsrlr/GdmLxQ9XkwhVRx9wigA
         0xmNzOEMXunVhAynuQ1W4rLGyHqnGGJ4PA5WYAHwPqtx8u6izjJRWlzlxEruNmiv10LE
         FD+ZqkeIpK65+L7Nf6YqkX6SQefg8U+Zrt1E7MvytDfKTa8RFJt+2m9n7A/gcmcZ4rdU
         nw4aviVg/mQFtJepKixm3vvDQ4iWls5y8cUDHFtUo51QRoRCWttY2q7WSSXTsyHVcGdU
         0lNQ==
X-Gm-Message-State: AOJu0Yxdkg+u2sZJAKPLozFwgsSyFWt7bFg0xTJe8eg2VXn/X9s1Glnv
        JNMQa+cTCLnYKXjsCDQltFyl0vLkG3TvNqe1cde8hzPaP34T
X-Google-Smtp-Source: AGHT+IGDxYfmsuzOmH678RsV5gUzhAXsWSkYtbkKlAqQ+CAbddXmv8whikeg8KuRG1l3o/oMXFEENzkt9aNsinJhdRydBdnS/N6+
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aaf:b0:1bf:52d2:aea2 with SMTP id
 dt47-20020a0568705aaf00b001bf52d2aea2mr6246214oab.0.1691282334029; Sat, 05
 Aug 2023 17:38:54 -0700 (PDT)
Date:   Sat, 05 Aug 2023 17:38:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc20180602365ab0@google.com>
Subject: [syzbot] [gfs2?] general protection fault in gfs2_lookup_simple
From:   syzbot <syzbot+57e590d90f42e6e925df@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a73466257270 Add linux-next specific files for 20230801
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a48e75a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b55cb25bac8948c
dashboard link: https://syzkaller.appspot.com/bug?extid=57e590d90f42e6e925df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1263b929a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160bbe31a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d893efe5006c/disk-a7346625.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5a2ea2e3ba30/vmlinux-a7346625.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66f8ff91348f/bzImage-a7346625.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e94e695a9f21/mount_0.gz

The issue was bisected to:

commit 8f18190e31734e434a650d3435da072f03fe485f
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed Jul 26 21:17:53 2023 +0000

    gfs2: Use mapping->gfp_mask for metadata inodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1338d136a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b8d136a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1738d136a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57e590d90f42e6e925df@syzkaller.appspotmail.com
Fixes: 8f18190e3173 ("gfs2: Use mapping->gfp_mask for metadata inodes")

gfs2: fsid=no�Šar?d: Trying to join cluster "lock_nolock", "no�Šar?d"
gfs2: fsid=no�Šar?d: Now mounting FS (format 1801)...
syz-executor418: attempt to access beyond end of device
loop0: rw=12288, sector=131072, nr_sectors = 8 limit=32768
general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 PID: 5032 Comm: syz-executor418 Not tainted 6.5.0-rc4-next-20230801-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
RIP: 0010:gfs2_lookup_simple+0xc6/0x160 fs/gfs2/inode.c:286
Code: 74 24 20 f7 d0 89 44 24 20 e8 66 d3 ff ff 48 85 c0 0f 84 85 00 00 00 48 89 c3 e8 e5 01 e3 fd 48 8d 7b 30 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 75 7b 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 30 49
RSP: 0018:ffffc900039ef848 EFLAGS: 00010206
RAX: 0000000000000005 RBX: fffffffffffffffb RCX: 0000000000000000
RDX: ffff888015bf8000 RSI: ffffffff83a38d4b RDI: 000000000000002b
RBP: 1ffff9200073df09 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffffff8ab99700 R14: ffff888019f94000 R15: ffff8880783f06b8
FS:  00005555558fa380(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557976244798 CR3: 0000000074978000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 init_journal fs/gfs2/ops_fstype.c:742 [inline]
 init_inodes+0x495/0x2e30 fs/gfs2/ops_fstype.c:885
 gfs2_fill_super+0x1a9e/0x2b10 fs/gfs2/ops_fstype.c:1248
 get_tree_bdev+0x390/0x6a0 fs/super.c:1345
 gfs2_get_tree+0x4e/0x280 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x88/0x350 fs/super.c:1521
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6d772a2c3a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3af18918 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff3af18920 RCX: 00007f6d772a2c3a
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007fff3af18920
RBP: 0000000000000004 R08: 00007fff3af18960 R09: 00000000000125fe
R10: 0000000000000819 R11: 0000000000000282 R12: 00007fff3af18960
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_lookup_simple+0xc6/0x160 fs/gfs2/inode.c:286
Code: 74 24 20 f7 d0 89 44 24 20 e8 66 d3 ff ff 48 85 c0 0f 84 85 00 00 00 48 89 c3 e8 e5 01 e3 fd 48 8d 7b 30 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 75 7b 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 30 49
RSP: 0018:ffffc900039ef848 EFLAGS: 00010206
RAX: 0000000000000005 RBX: fffffffffffffffb RCX: 0000000000000000
RDX: ffff888015bf8000 RSI: ffffffff83a38d4b RDI: 000000000000002b
RBP: 1ffff9200073df09 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: ffffffff8ab99700 R14: ffff888019f94000 R15: ffff8880783f06b8
FS:  00005555558fa380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564e741eb538 CR3: 0000000074978000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	20 f7                	and    %dh,%bh
   4:	d0 89 44 24 20 e8    	rorb   -0x17dfdbbc(%rcx)
   a:	66 d3 ff             	sar    %cl,%di
   d:	ff 48 85             	decl   -0x7b(%rax)
  10:	c0 0f 84             	rorb   $0x84,(%rdi)
  13:	85 00                	test   %eax,(%rax)
  15:	00 00                	add    %al,(%rax)
  17:	48 89 c3             	mov    %rax,%rbx
  1a:	e8 e5 01 e3 fd       	call   0xfde30204
  1f:	48 8d 7b 30          	lea    0x30(%rbx),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	75 7b                	jne    0xac
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	4c 8b 63 30          	mov    0x30(%rbx),%r12
  3f:	49                   	rex.WB


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
