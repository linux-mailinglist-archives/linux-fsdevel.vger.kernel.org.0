Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C1727D57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjFHK45 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Jun 2023 06:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjFHK4y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:56:54 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F6269A
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 03:56:50 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77accdaa0e0so38116239f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 03:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686221809; x=1688813809;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56P43OZeMl15DbELWqp1RKpvGY+TPkEjkZ30u6bGsgM=;
        b=HqGPMrm8Q3RGgIti23un04PrGN45dELOec6utkQd1A2AbXNpvpII3trApKSRuMAldM
         /hIDpfeRnOx0+aZpYJ8YTprhwb/mp9RCAwsPDKuvu6r7VU/0oq0gmgoq2KoQgNgHukp0
         ouRqpUzpaoF90IiBn9HmezZ1AcxnsTkZVVF7acwVDXIGcvI4CgQkdfeu8Mpe6J5JGRdZ
         DdSwyq2swo6F9tlkeR3Oefpk1Ht3a4GJj7wHJWkMhqKbzr/Ox8UNtXF6LIAobywVea5i
         Txp1v8ChiQUzfCjP78oI9QArzNKrhltBX4w35DzYpuYQEm9q37mqoLzUUuZL0h83OxJO
         sCoA==
X-Gm-Message-State: AC+VfDyglmNoK8Wi4KsJFqcDL0gow3LbfqB9mvQkMbTxvcyikyxudHNi
        6jaGKhlGTIhSU8RFHQMtTKe390LE9r6M9eT89hoAHaewpplF
X-Google-Smtp-Source: ACHHUZ4CQcs+o2Hmzc7fVYZMWF1iIF5QPeZVYyIgsChz/EHPCazmwosvqFMYbuCcxWASDAuV9jqktsxXGz1TQhq69lLCa0ZhihS1
MIME-Version: 1.0
X-Received: by 2002:a92:4a0f:0:b0:331:9a82:33f8 with SMTP id
 m15-20020a924a0f000000b003319a8233f8mr4000200ilf.3.1686221809674; Thu, 08 Jun
 2023 03:56:49 -0700 (PDT)
Date:   Thu, 08 Jun 2023 03:56:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fa721205fd9c1b6b@google.com>
Subject: [syzbot] [virt?] [reiserfs?] general protection fault in psi_account_irqtime
From:   syzbot <syzbot+85fda6d9c9dfad58eaca@syzkaller.appspotmail.com>
To:     david@redhat.com, jasowang@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1205c5c9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=85fda6d9c9dfad58eaca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ddc72b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1271e63b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1c84902de2f0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85fda6d9c9dfad58eaca@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000001ff1: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x000000000000ff88-0x000000000000ff8f]
CPU: 1 PID: 262176 Comm: � Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:task_dfl_cgroup include/linux/cgroup.h:493 [inline]
RIP: 0010:task_psi_group kernel/sched/psi.c:884 [inline]
RIP: 0010:psi_account_irqtime+0xeb/0x520 kernel/sched/psi.c:1013
Code: 38 13 00 00 e8 06 ef ac 08 85 c0 0f 85 b6 02 00 00 49 8d bc 24 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 03 00 00 49 8b 9c 24 88 00 00 00 48 b8 00 00
RSP: 0018:ffffc900001e0c18 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff888079e20000 RCX: 0000000000000001
RDX: 0000000000001ff1 RSI: 000000000000a9cf RDI: 000000000000ff89
RBP: 000000000072af41 R08: 0000000bfb3e0a35 R09: fffff5200003c17f
R10: 0000000000000003 R11: 0000000000000000 R12: 000000000000ff01
R13: 0000000000000001 R14: 0000000bfb3e0a35 R15: ffff8880b993cfd8
FS:  00005555567f03c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc77214000 CR3: 0000000029760000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 update_rq_clock_task kernel/sched/core.c:725 [inline]
 update_rq_clock kernel/sched/core.c:769 [inline]
 update_rq_clock+0x241/0xb40 kernel/sched/core.c:750
 ttwu_queue kernel/sched/core.c:3984 [inline]
 try_to_wake_up+0xba2/0x1a50 kernel/sched/core.c:4307
 wake_up_worker kernel/workqueue.c:863 [inline]
 insert_work+0x287/0x360 kernel/workqueue.c:1373
 __queue_work+0x5c6/0xfb0 kernel/workqueue.c:1526
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1556
 queue_work include/linux/workqueue.h:505 [inline]
 stats_request+0xf2/0x130 drivers/virtio/virtio_balloon.c:369
 vring_interrupt drivers/virtio/virtio_ring.c:2501 [inline]
 vring_interrupt+0x2a1/0x3d0 drivers/virtio/virtio_ring.c:2476
 __handle_irq_event_percpu+0x22b/0x730 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
 handle_edge_irq+0x263/0xd00 kernel/irq/chip.c:819
 generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
 handle_irq arch/x86/kernel/irq.c:231 [inline]
 __common_interrupt+0xa1/0x220 arch/x86/kernel/irq.c:250
 common_interrupt+0xa8/0xd0 arch/x86/kernel/irq.c:240
 </IRQ>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:task_dfl_cgroup include/linux/cgroup.h:493 [inline]
RIP: 0010:task_psi_group kernel/sched/psi.c:884 [inline]
RIP: 0010:psi_account_irqtime+0xeb/0x520 kernel/sched/psi.c:1013
Code: 38 13 00 00 e8 06 ef ac 08 85 c0 0f 85 b6 02 00 00 49 8d bc 24 88 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 e7 03 00 00 49 8b 9c 24 88 00 00 00 48 b8 00 00
RSP: 0018:ffffc900001e0c18 EFLAGS: 00010002
RAX: dffffc0000000000 RBX: ffff888079e20000 RCX: 0000000000000001
RDX: 0000000000001ff1 RSI: 000000000000a9cf RDI: 000000000000ff89
RBP: 000000000072af41 R08: 0000000bfb3e0a35 R09: fffff5200003c17f
R10: 0000000000000003 R11: 0000000000000000 R12: 000000000000ff01
R13: 0000000000000001 R14: 0000000bfb3e0a35 R15: ffff8880b993cfd8
FS:  00005555567f03c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc77214000 CR3: 0000000029760000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	38 13                	cmp    %dl,(%rbx)
   2:	00 00                	add    %al,(%rax)
   4:	e8 06 ef ac 08       	callq  0x8acef0f
   9:	85 c0                	test   %eax,%eax
   b:	0f 85 b6 02 00 00    	jne    0x2c7
  11:	49 8d bc 24 88 00 00 	lea    0x88(%r12),%rdi
  18:	00
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 e7 03 00 00    	jne    0x41b
  34:	49 8b 9c 24 88 00 00 	mov    0x88(%r12),%rbx
  3b:	00
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8


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
