Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0370A70AB8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 00:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjETWOD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 May 2023 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETWOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 May 2023 18:14:03 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2445184
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 15:14:00 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76c4c85d605so174876439f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 May 2023 15:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684620840; x=1687212840;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phVjbSew9ZM8CBTOL6mgsk8hmTvWd23s0NrgeLLExb8=;
        b=C+k6DE4M2bi8G0uShiJXIGUeLGv/r1uTt5x57eoT2lotCY2H/5v+bAyyXb2U/DQgq6
         MtTpSghnEuj7gZZwkRl0tiF2H5dt3TA7rJ9mgk5yzqXiIoN/NEzclAU0NVlooXSOGtgo
         LHIV9TxnI7O7CO5zaEX2fErh/pesH2nRojNYMKp3uvNt47Zp2j+XbYDJ5kORbu1LfUw0
         vQhNFa2VvI0bjIvUv0ICiioacrHKFy8Q9/0tAvD0/BlkV+wXJ4ybANNrBLHjoEbpOmtm
         X9RvClHycts8aYiiw3GvpZqGs4LYN46yQwYRAer6JuV7qWBMqirsEmFVMU3/PPLS/Wgv
         OSxQ==
X-Gm-Message-State: AC+VfDzHG+YRhFnlBt+1y6VdpigzG5l85k1kYN3IkLMWnYYRmk6jFrjv
        two8deSslBldlRLfv8vVNlkH/7U+mhwndF3L6mY/a2SqrMoO
X-Google-Smtp-Source: ACHHUZ79g/TnEGwpYJweg5O7XU1BAFLyCZYzIqHpEWbn3eLfpK0OSceFGzLQU4dwafL9XnPrzN5jtTskVctvMoj6qwD6CTWIMwKj
MIME-Version: 1.0
X-Received: by 2002:a02:9643:0:b0:41a:dd1b:23ca with SMTP id
 c61-20020a029643000000b0041add1b23camr255641jai.4.1684620839674; Sat, 20 May
 2023 15:13:59 -0700 (PDT)
Date:   Sat, 20 May 2023 15:13:59 -0700
In-Reply-To: <0000000000004f938b05fad48ee6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baea9905fc275a49@google.com>
Subject: Re: [syzbot] [fs?] INFO: task hung in synchronize_rcu (4)
From:   syzbot <syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        jack@suse.cz, kafai@fb.com, kuba@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    dcbe4ea1985d Merge branch '1GbE' of git://git.kernel.org/p..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123ebd91280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f20b05fe035db814
dashboard link: https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1495596a280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1529326a280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/41b9dda0e686/disk-dcbe4ea1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/64d9bece8f89/vmlinux-dcbe4ea1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42429896dca0/bzImage-dcbe4ea1.xz

The issue was bisected to:

commit 3b5d4ddf8fe1f60082513f94bae586ac80188a03
Author: Martin KaFai Lau <kafai@fb.com>
Date:   Wed Mar 9 09:04:50 2022 +0000

    bpf: net: Remove TC_AT_INGRESS_OFFSET and SKB_MONO_DELIVERY_TIME_OFFSET macro

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=153459d7c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=173459d7c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=133459d7c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+222aa26d0a5dbc2e84fe@syzkaller.appspotmail.com
Fixes: 3b5d4ddf8fe1 ("bpf: net: Remove TC_AT_INGRESS_OFFSET and SKB_MONO_DELIVERY_TIME_OFFSET macro")

INFO: task dhcpcd:10860 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc2-syzkaller-00481-gdcbe4ea1985d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:29024 pid:10860 ppid:4670   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 exp_funnel_lock kernel/rcu/tree_exp.h:316 [inline]
 synchronize_rcu_expedited+0x6f8/0x770 kernel/rcu/tree_exp.h:992
 synchronize_rcu+0x2f1/0x3a0 kernel/rcu/tree.c:3499
 synchronize_net+0x4e/0x60 net/core/dev.c:10791
 __unregister_prot_hook+0x4b3/0x5c0 net/packet/af_packet.c:380
 packet_do_bind+0x93f/0xe30 net/packet/af_packet.c:3235
 packet_bind+0x15f/0x1c0 net/packet/af_packet.c:3319
 __sys_bind+0x1ed/0x260 net/socket.c:1803
 __do_sys_bind net/socket.c:1814 [inline]
 __se_sys_bind net/socket.c:1812 [inline]
 __x64_sys_bind+0x73/0xb0 net/socket.c:1812
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f522deb3677
RSP: 002b:00007ffec7fc94f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 000055e71e865ca3 RCX: 00007f522deb3677
RDX: 0000000000000014 RSI: 00007ffec7fc9508 RDI: 0000000000000005
RBP: 0000000000000000 R08: 000055e7200048a0 R09: 0000000000000004
R10: 000000000000006d R11: 0000000000000217 R12: 000055e71ffff250
R13: 000055e720004788 R14: 00007ffec7fe9dec R15: 000055e720004754
 </TASK>
INFO: task dhcpcd:10906 blocked for more than 145 seconds.
      Not tainted 6.4.0-rc2-syzkaller-00481-gdcbe4ea1985d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:28864 pid:10906 ppid:4670   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 exp_funnel_lock kernel/rcu/tree_exp.h:316 [inline]
 synchronize_rcu_expedited+0x6f8/0x770 kernel/rcu/tree_exp.h:992
 synchronize_rcu+0x2f1/0x3a0 kernel/rcu/tree.c:3499
 synchronize_net+0x4e/0x60 net/core/dev.c:10791
 __unregister_prot_hook+0x4b3/0x5c0 net/packet/af_packet.c:380
 packet_do_bind+0x93f/0xe30 net/packet/af_packet.c:3235
 packet_bind+0x15f/0x1c0 net/packet/af_packet.c:3319
 __sys_bind+0x1ed/0x260 net/socket.c:1803
 __do_sys_bind net/socket.c:1814 [inline]
 __se_sys_bind net/socket.c:1812 [inline]
 __x64_sys_bind+0x73/0xb0 net/socket.c:1812
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f522deb3677
RSP: 002b:00007ffec7fc94f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 000055e71e865ca3 RCX: 00007f522deb3677
RDX: 0000000000000014 RSI: 00007ffec7fc9508 RDI: 0000000000000005
RBP: 0000000000000000 R08: 000055e720004a20 R09: 0000000000000004
R10: 000000000000006d R11: 0000000000000217 R12: 000055e71ffff250
R13: 000055e720004908 R14: 00007ffec7fe9dec R15: 000055e7200048d4
 </TASK>
INFO: task dhcpcd:11298 blocked for more than 147 seconds.
      Not tainted 6.4.0-rc2-syzkaller-00481-gdcbe4ea1985d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:29008 pid:11298 ppid:4670   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 exp_funnel_lock kernel/rcu/tree_exp.h:316 [inline]
 synchronize_rcu_expedited+0x6f8/0x770 kernel/rcu/tree_exp.h:992
 synchronize_rcu+0x2f1/0x3a0 kernel/rcu/tree.c:3499
 synchronize_net+0x4e/0x60 net/core/dev.c:10791
 __unregister_prot_hook+0x4b3/0x5c0 net/packet/af_packet.c:380
 packet_do_bind+0x93f/0xe30 net/packet/af_packet.c:3235
 packet_bind+0x15f/0x1c0 net/packet/af_packet.c:3319
 __sys_bind+0x1ed/0x260 net/socket.c:1803
 __do_sys_bind net/socket.c:1814 [inline]
 __se_sys_bind net/socket.c:1812 [inline]
 __x64_sys_bind+0x73/0xb0 net/socket.c:1812
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f522deb3677
RSP: 002b:00007ffec7fc94f8 EFLAGS: 00000217
 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 000055e71e865ca3 RCX: 00007f522deb3677
RDX: 0000000000000014 RSI: 00007ffec7fc9508 RDI: 0000000000000005
RBP: 0000000000000000 R08: 000055e720004420 R09: 0000000000000004
R10: 000000000000006d R11: 0000000000000217 R12: 000055e71ffff250
R13: 000055e720004a88 R14: 00007ffec7fe9dec R15: 000055e720004a54
 </TASK>
INFO: task dhcpcd:11328 blocked for more than 149 seconds.
      Not tainted 6.4.0-rc2-syzkaller-00481-gdcbe4ea1985d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:28320 pid:11328 ppid:4670   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 exp_funnel_lock kernel/rcu/tree_exp.h:316 [inline]
 synchronize_rcu_expedited+0x6f8/0x770 kernel/rcu/tree_exp.h:992
 synchronize_rcu+0x2f1/0x3a0 kernel/rcu/tree.c:3499
 synchronize_net+0x4e/0x60 net/core/dev.c:10791
 __unregister_prot_hook+0x4b3/0x5c0 net/packet/af_packet.c:380
 packet_do_bind+0x93f/0xe30 net/packet/af_packet.c:3235
 packet_bind+0x15f/0x1c0 net/packet/af_packet.c:3319
 __sys_bind+0x1ed/0x260 net/socket.c:1803
 __do_sys_bind net/socket.c:1814 [inline]
 __se_sys_bind net/socket.c:1812 [inline]
 __x64_sys_bind+0x73/0xb0 net/socket.c:1812
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f522deb3677
RSP: 002b:00007ffec7fc94f8 EFLAGS: 00000217 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 000055e71e865ca3 RCX: 00007f522deb3677
RDX: 0000000000000014 RSI: 00007ffec7fc9508 RDI: 0000000000000005
RBP: 0000000000000000 R08: 000055e720004420 R09: 0000000000000004
R10: 000000000000006d R11: 0000000000000217 R12: 000055e71ffff250
R13: 000055e720004c08 R14: 00007ffec7fe9dec R15: 000055e720004bd4
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c798430 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c798130 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffffffff8c799040 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6545
1 lock held by kswapd0/84:
2 locks held by kswapd1/85:
3 locks held by kworker/0:2/760:
3 locks held by kworker/1:2/1126:
1 lock held by syslogd/4438:
2 locks held by klogd/4445:
1 lock held by dhcpcd/4669:
2 locks held by getty/4756:
 #0: ffff8880286bf098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
2 locks held by sshd/5018:
2 locks held by syz-executor300/5025:
2 locks held by dhcpcd/10797:
 #0: ffff8880734ebe10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:775 [inline]
 #0: ffff8880734ebe10 (&sb->s_type->i_mutex_key#10){+.+.}-{3:3}, at: __sock_release+0x86/0x290 net/socket.c:652
 #1: ffffffff8c7a44b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:325 [inline]
 #1: ffffffff8c7a44b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3e8/0x770 kernel/rcu/tree_exp.h:992
2 locks held by dhcpcd/10818:
 #0: ffff8880217f2130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
 #0: ffff8880217f2130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2f/0xe30 net/packet/af_packet.c:3202
 #1: ffffffff8c7a44b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:325 [inline]
 #1: ffffffff8c7a44b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3e8/0x770 kernel/rcu/tree_exp.h:992
1 lock held by dhcpcd/10860:
 #0: ffff88807b95c130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
 #0: ffff88807b95c130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2f/0xe30 net/packet/af_packet.c:3202
1 lock held by dhcpcd/10906:
 #0: ffff888076080130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
 #0: ffff888076080130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2f/0xe30 net/packet/af_packet.c:3202
1 lock held by dhcpcd/11298:
 #0: ffff888027a66130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
 #0: ffff888027a66130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2f/0xe30 net/packet/af_packet.c:3202


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
