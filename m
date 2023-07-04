Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B617466B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 03:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGDBA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 21:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGDBAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:00:55 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67360E5F
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 18:00:54 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-5578082558eso4935227a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Jul 2023 18:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688432454; x=1691024454;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4dIGmrJnerN2APUK9vIkWuNtSLXO20WTEc2d/iDcUI=;
        b=HVE2w3H+Ixm3+gExcbZ6RafD6agA9UegLD0tALesHYBUQmnKoiGOZCe0tIGw+OJ5uJ
         MbkIY1yvmkh9zTvt57KLrfmvX5B8mrTgaIDSrr7jJf35KRwduEoLTzAD3PZyX6vkWGbQ
         YMhP+X0tVDCzTqgb4/6sZfiDzAAXoqPg5Xa6QRSTIsnOnfpIIEqoo+jUx366AWJcPGRC
         +VYh+gTPm7p0U+0ERsrN2MgxckP/0GtZx5isqoll04oCGzBmyDXeiHP8FUJTrDDwulxq
         LnTlSwm2UTZErA+gLsAVfk90KvBfTT4XL64ZruI+xFfWJmhwGon/+8I5ZBc2fnZzicCZ
         q5JA==
X-Gm-Message-State: ABy/qLbEMYGWPjCr9lDqgokX08ydTUVnE5Z1NzU/cLACb4PJXLr6Dh3G
        qUVDEnf+TzF9QTP2700d415r8WIIEsoGNj19rOU6xrvoOKct
X-Google-Smtp-Source: APBJJlHCOJtR1+j9evnXwzg9q/NGJZBqKkw5h5lASg8ub/FShATqVSjFXkhuXC8hRPQYGdEYUZWBve53gFBIvx/3BpJzDQRrx3d7
MIME-Version: 1.0
X-Received: by 2002:a63:561b:0:b0:54f:d553:fbe6 with SMTP id
 k27-20020a63561b000000b0054fd553fbe6mr6790216pgb.2.1688432453963; Mon, 03 Jul
 2023 18:00:53 -0700 (PDT)
Date:   Mon, 03 Jul 2023 18:00:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a557cb05ff9ed03b@google.com>
Subject: [syzbot] [ext4?] general protection fault in ext4_finish_bio
From:   syzbot <syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11fe4cb8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=689ec3afb1ef07b766b2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136b9d48a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10223cb8a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c060db03f09/disk-ae230642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b9b937ece91/vmlinux-ae230642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c7eb1c82bf0/bzImage-ae230642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+689ec3afb1ef07b766b2@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 2858 Comm: kworker/u4:5 Not tainted 6.4.0-rc7-syzkaller-01948-gae230642190a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
RIP: 0010:_compound_head include/linux/page-flags.h:245 [inline]
RIP: 0010:bio_first_folio include/linux/bio.h:284 [inline]
RIP: 0010:ext4_finish_bio+0xdc/0x1090 fs/ext4/page-io.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 43 0f 00 00 48 8b 45 00 48 8d 78 08 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4c 0f 00 00 48 8b 04 24 31 ff 4c 8b 60 08 4c 89
RSP: 0018:ffffc9000d047b60 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8234c972 RDI: 0000000000000008
RBP: ffff88807d609100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000094001 R12: ffff888074f111e0
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff888074c416b0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020241040 CR3: 0000000024e17000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_release_io_end+0x118/0x3b0 fs/ext4/page-io.c:160
 ext4_end_io_end fs/ext4/page-io.c:194 [inline]
 ext4_do_flush_completed_IO fs/ext4/page-io.c:259 [inline]
 ext4_end_io_rsv_work+0x156/0x670 fs/ext4/page-io.c:273
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_compound_head include/linux/page-flags.h:245 [inline]
RIP: 0010:bio_first_folio include/linux/bio.h:284 [inline]
RIP: 0010:ext4_finish_bio+0xdc/0x1090 fs/ext4/page-io.c:104
Code: c1 ea 03 80 3c 02 00 0f 85 43 0f 00 00 48 8b 45 00 48 8d 78 08 48 89 04 24 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4c 0f 00 00 48 8b 04 24 31 ff 4c 8b 60 08 4c 89
RSP: 0018:ffffc9000d047b60 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff8234c972 RDI: 0000000000000008
RBP: ffff88807d609100 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000094001 R12: ffff888074f111e0
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff888074c416b0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020241040 CR3: 000000007a4d9000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 43 0f 00 00    	jne    0xf50
   d:	48 8b 45 00          	mov    0x0(%rbp),%rax
  11:	48 8d 78 08          	lea    0x8(%rax),%rdi
  15:	48 89 04 24          	mov    %rax,(%rsp)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4c 0f 00 00    	jne    0xf80
  34:	48 8b 04 24          	mov    (%rsp),%rax
  38:	31 ff                	xor    %edi,%edi
  3a:	4c 8b 60 08          	mov    0x8(%rax),%r12
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
