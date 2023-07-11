Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C974E3C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 03:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGKBxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 21:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjGKBxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:53:49 -0400
Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42DB6
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:53:47 -0700 (PDT)
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-1b88decb2a9so85102425ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689040426; x=1691632426;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MgFPXQ8D4Hg7lbUv1V/6m4r7uD/Fzh2LAEZUXUXNtBk=;
        b=DtwmuSQqAEUDXvTN0CzHg38LSbGtQxLMzYYTfqvuoEa7nbi/RFNG6glg3YWOrj861k
         5Resfe+lWymXArEIEVNcEMh7z1HnIxtcmJHAB0LMDo/a3X58HMEneziex8Ze5h+ggF3r
         OB5HAmK787GFioP4LP19lR2uVnGG0ybThW2nocNbqQ4uy5RXyizBl/GVgNGXNleWDhS6
         Dmw8AOjzH++xOhND2j8a6thLFrYSfdQaqDonLLZBRnaV1acdtBSMMIJF6KboerPDewQr
         JYWqjpsQl90Lr8x5OReZJQahKOt7ey9H6UT5IovRc+6A40f1sAlrj3C8zhwQVXzLdhKO
         Xg1A==
X-Gm-Message-State: ABy/qLYnKq3b2m6scqU8zy2elFOivsL8h07Zc72OVfGYqibG0iGH7foo
        VmX31n8GDHU9SPCHuBjtIWbqtge4LSCEnTTYbB/y2AvKBeNd
X-Google-Smtp-Source: APBJJlENDWFc0+lL6ohczLjG5T+JNrFBua6b/Jrk5GfKVdt7O3MLJ2njSpp6SMyhG04IdPCd4ztN+pxqXN71CC6BPnoc6qF2TK7+
MIME-Version: 1.0
X-Received: by 2002:a17:902:ab81:b0:1b9:e97b:99e9 with SMTP id
 f1-20020a170902ab8100b001b9e97b99e9mr1701115plr.3.1689040426671; Mon, 10 Jul
 2023 18:53:46 -0700 (PDT)
Date:   Mon, 10 Jul 2023 18:53:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4a46106002c5e42@google.com>
Subject: [syzbot] [bpf?] [reiserfs?] WARNING: locking bug in corrupted (2)
From:   syzbot <syzbot+3779764ddb7a3e19437f@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, jack@suse.cz, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luto@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
        peterz@infradead.org, reiserfs-devel@vger.kernel.org,
        sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, yhs@fb.com, yukuai3@huawei.com
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

HEAD commit:    c17414a273b8 Merge tag 'sh-for-v6.5-tag1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cc4baca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ad417033279f15a
dashboard link: https://syzkaller.appspot.com/bug?extid=3779764ddb7a3e19437f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bbd544a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13fd50b0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea495e93586c/disk-c17414a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdb03e817e47/vmlinux-c17414a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/20ba23616f1f/bzImage-c17414a2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/98d086ce1a87/mount_0.gz

The issue was bisected to:

commit 2acf15b94d5b8ea8392c4b6753a6ffac3135cd78
Author: Yu Kuai <yukuai3@huawei.com>
Date:   Fri Jul 2 04:07:43 2021 +0000

    reiserfs: add check for root_inode in reiserfs_fill_super

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=143b663ca80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=163b663ca80000
console output: https://syzkaller.appspot.com/x/log.txt?x=123b663ca80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3779764ddb7a3e19437f@syzkaller.appspotmail.com
Fixes: 2acf15b94d5b ("reiserfs: add check for root_inode in reiserfs_fill_super")

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(depth >= MAX_LOCK_DEPTH)
WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:5045 __lock_acquire+0x164b/0x5e20 kernel/locking/lockdep.c:5045
Modules linked in:
CPU: 0 PID: 0 Comm:  Not tainted 6.4.0-syzkaller-12069-gc17414a273b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__lock_acquire+0x164b/0x5e20 kernel/locking/lockdep.c:5045
Code: d2 0f 85 be 47 00 00 44 8b 3d 0d b3 44 0d 45 85 ff 0f 85 40 f8 ff ff 48 c7 c6 40 9f 6c 8a 48 c7 c7 e0 6e 6c 8a e8 b5 46 e6 ff <0f> 0b e9 29 f8 ff ff 48 8d 7d f8 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc90000007ca8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 1ffff92000000fc7 RCX: 0000000000000000
RDX: ffff8880779d5940 RSI: ffffffff814c34f7 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880779d5940
R13: ffff8880b982b898 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555573b8300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde3197000 CR3: 00000000173e2000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_plugin.h:431 arch_local_irq_enable arch/x86/include/asm/irqflags.h:78 [inline]
WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_plugin.h:431 arch_local_irq_restore arch/x86/include/asm/irqflags.h:135 [inline]
WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_plugin.h:431 rcu_read_unlock_special kernel/rcu/tree_plugin.h:678 [inline]
WARNING: CPU: 0 PID: 0 at kernel/rcu/tree_plugin.h:431 __rcu_read_unlock+0x24b/0x570 kernel/rcu/tree_plugin.h:426
Modules linked in:
CPU: 0 PID: 0 Comm:  Not tainted 6.4.0-syzkaller-12069-gc17414a273b8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:__rcu_read_unlock+0x24b/0x570 kernel/rcu/tree_plugin.h:431
Code: 00 e8 49 4f df ff 4d 85 f6 74 05 e8 cf c3 1c 00 9c 58 f6 c4 02 0f 85 78 02 00 00 4d 85 f6 0f 84 83 fe ff ff fb e9 7d fe ff ff <0f> 0b 5b 5d 41 5c 41 5d 41 5e c3 e8 25 50 69 00 e9 2a fe ff ff e8
RSP: 0018:ffffc900000079d8 EFLAGS: 00010096
RAX: 00000000ffff8880 RBX: ffff8880779d5940 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8192bb90 RDI: ffff8880779d5d7c
RBP: ffff8880779d5940 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880779d5940
R13: ffffc90000007bf8 R14: 0000000000000000 R15: ffffc90000007a98
FS:  00005555573b8300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffde3197000 CR3: 00000000173e2000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 rcu_read_unlock include/linux/rcupdate.h:781 [inline]
 is_bpf_text_address+0x85/0x1b0 kernel/bpf/core.c:721
 kernel_text_address kernel/extable.c:125 [inline]
 kernel_text_address+0x3d/0x80 kernel/extable.c:94
 __kernel_text_address+0xd/0x30 kernel/extable.c:79
 show_trace_log_lvl+0x1c7/0x390 arch/x86/kernel/dumpstack.c:259
 __warn+0xe6/0x390 kernel/panic.c:671
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2da/0x500 lib/bug.c:219
 handle_bug+0x3c/0x70 arch/x86/kernel/traps.c:324
 exc_invalid_op+0x18/0x50 arch/x86/kernel/traps.c:345
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:568
RIP: 0010:__lock_acquire+0x164b/0x5e20 kernel/locking/lockdep.c:5045
Code: d2 0f 85 be 47 00 00 44 8b 3d 0d b3 44 0d 45 85 ff 0f 85 40 f8 ff ff 48 c7 c6 40 9f 6c 8a 48 c7 c7 e0 6e 6c 8a e8 b5 46 e6 ff <0f> 0b e9 29 f8 ff ff 48 8d 7d f8 48 b8 00 00 00 00 00 fc ff df 48
RSP: 0018:ffffc90000007ca8 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 1ffff92000000fc7 RCX: 0000000000000000
RDX: ffff8880779d5940 RSI: ffffffff814c34f7 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff8880779d5940
R13: ffff8880b982b898 R14: 0000000000000000 R15: 0000000000000000
 lock_acquire kernel/locking/lockdep.c:5761 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 hrtimer_interrupt+0x107/0x7b0 kernel/time/hrtimer.c:1795
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1098 [inline]
 __sysvec_apic_timer_interrupt+0x14a/0x430 arch/x86/kernel/apic/apic.c:1115
 sysvec_apic_timer_interrupt+0x92/0xc0 arch/x86/kernel/apic/apic.c:1109
 </IRQ>


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
