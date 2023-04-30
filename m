Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113746F27DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjD3Gml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjD3Gmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 02:42:40 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A60194
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:42:38 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-328f6562564so21326675ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Apr 2023 23:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682836957; x=1685428957;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0t7JmHsKb1CxLcpeRqlieyAnnyFbgqZ6o3lYscFRxs=;
        b=HJOmbyIy20cyFtdIWnG5v0giOpzim38ejM24jr5y6Vcq7Zo83IgFUd4dlHRhbJ9edt
         OLYRcSyyASrPsBN6y+yULTXemfv6BYdoPH4MZE1DPPTDZ4m1j7oZ3d8NXJzeJSbqAZqd
         Ld3hkhb/k8gVuhwflnmbYKhQDvyPLF7YGrC3REm51WkTSol2nuZgvFx1HYWOA26jYaL/
         EgHYEOfrCwApvFY5R2WPEdHRHqCQJOFhwsPqu9Za5wcuxGQCh6ZZoicVvmHHv6f2HwCJ
         B7onu5oijZ/FTQkr0PqDINi9cs1WhBiId5qaXnw5zOgHVcOiQ4aHg2tDUkXr60jq1KEi
         ptsQ==
X-Gm-Message-State: AC+VfDzCXmLwNlnSlZb7ymPLqDWQOr0D0jhO/KeQD6GUwkVxqiuTrRAL
        Ld4jSzrWJPUB1jW/v9HVG1viAt6SzcDoX3mbf6mbOwUXI+J7
X-Google-Smtp-Source: ACHHUZ4eV9iZGQSPv3nARd4QiBGYsrPiFRTyxKn6P0IOwZLOZDId0rxWBoW84malTBJzGyjtxziwtZucINE1fZoEEsoCNdUEd8UN
MIME-Version: 1.0
X-Received: by 2002:a92:c0c6:0:b0:330:990e:1ae8 with SMTP id
 t6-20020a92c0c6000000b00330990e1ae8mr1123775ilf.0.1682836957658; Sat, 29 Apr
 2023 23:42:37 -0700 (PDT)
Date:   Sat, 29 Apr 2023 23:42:37 -0700
In-Reply-To: <00000000000014b32705fa5f3585@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013882105fa88034b@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_orphan_cleanup
From:   syzbot <syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    1ae78a14516b Merge tag '6.4-rc-ksmbd-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1795c2f7c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50dff7d7b2557ef1
dashboard link: https://syzkaller.appspot.com/bug?extid=2e15a1e4284bf8517741
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1255f594280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165b28f8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4818953c9914/disk-1ae78a14.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a78b3bf3e929/vmlinux-1ae78a14.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dae163980240/bzImage-1ae78a14.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dd0e91b2ac87/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e15a1e4284bf8517741@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000001a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000d0-0x00000000000000d7]
CPU: 0 PID: 5860 Comm: syz-executor269 Not tainted 6.3.0-syzkaller-11301-g1ae78a14516b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:iput+0x40/0x8f0 fs/inode.c:1763
Code: 06 2a 91 ff 48 85 ed 0f 84 56 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 9d d8 00 00 00 48 89 d9 48 c1 e9 03 48 89 4c 24 08 <80> 3c 01 00 74 08 48 89 df e8 f2 f4 e8 ff 48 89 1c 24 48 8b 1b 48
RSP: 0018:ffffc9000aa87a10 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000000000d6 RCX: 000000000000001a
RDX: 0000000000000000 RSI: 0000000000000004 RDI: fffffffffffffffe
RBP: fffffffffffffffe R08: dffffc0000000000 R09: ffffed100dab82ef
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88806e6e0000
R13: fffffffffffffffc R14: 00000000fffffffe R15: dffffc0000000000
FS:  00007fbc4e794700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc55c5d908 CR3: 0000000071785000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_orphan_cleanup+0xa55/0xcf0 fs/btrfs/inode.c:3629
 create_snapshot+0x520/0x7e0 fs/btrfs/ioctl.c:852
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:994
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1040
 __btrfs_ioctl_snap_create+0x338/0x450 fs/btrfs/ioctl.c:1293
 btrfs_ioctl_snap_create+0x136/0x190 fs/btrfs/ioctl.c:1320
 btrfs_ioctl+0xbbc/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbc55c0cda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc4e7942f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbc55c987f0 RCX: 00007fbc55c0cda9
RDX: 0000000020001380 RSI: 0000000050009401 RDI: 0000000000000007
RBP: 00007fbc55c645ec R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007fbc55c635f0 R14: 697265765f666572 R15: 00007fbc55c987f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x40/0x8f0 fs/inode.c:1763
Code: 06 2a 91 ff 48 85 ed 0f 84 56 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 9d d8 00 00 00 48 89 d9 48 c1 e9 03 48 89 4c 24 08 <80> 3c 01 00 74 08 48 89 df e8 f2 f4 e8 ff 48 89 1c 24 48 8b 1b 48
RSP: 0018:ffffc9000aa87a10 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 00000000000000d6 RCX: 000000000000001a
RDX: 0000000000000000 RSI: 0000000000000004 RDI: fffffffffffffffe
RBP: fffffffffffffffe R08: dffffc0000000000 R09: ffffed100dab82ef
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88806e6e0000
R13: fffffffffffffffc R14: 00000000fffffffe R15: dffffc0000000000
FS:  00007fbc4e794700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005578470fb7a0 CR3: 0000000071785000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	2a 91 ff 48 85 ed    	sub    -0x127ab701(%rcx),%dl
   6:	0f 84 56 03 00 00    	je     0x362
   c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  13:	fc ff df
  16:	48 8d 9d d8 00 00 00 	lea    0xd8(%rbp),%rbx
  1d:	48 89 d9             	mov    %rbx,%rcx
  20:	48 c1 e9 03          	shr    $0x3,%rcx
  24:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
* 29:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1) <-- trapping instruction
  2d:	74 08                	je     0x37
  2f:	48 89 df             	mov    %rbx,%rdi
  32:	e8 f2 f4 e8 ff       	callq  0xffe8f529
  37:	48 89 1c 24          	mov    %rbx,(%rsp)
  3b:	48 8b 1b             	mov    (%rbx),%rbx
  3e:	48                   	rex.W


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
