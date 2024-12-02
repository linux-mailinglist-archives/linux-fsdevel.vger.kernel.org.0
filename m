Return-Path: <linux-fsdevel+bounces-36259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8AF9E02EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513F32851A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349621FDE05;
	Mon,  2 Dec 2024 13:10:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DB1D8A14
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733145034; cv=none; b=Sx4Dc1u3IKqT3FMYGZQN3D21cJ6XKM3VwXH0cP7x+nowzzS8gwZ4MZSJdKCaILHjVEq5Ifp9viVySKSJRpamwrKYfNEq6ApNhN64p1hwPBL7KcoEB8PCJ+Rk9PbNjz0j6cBu+c8VbPORFGIVV570G2+pA/jZPq98EU6mJ4npDsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733145034; c=relaxed/simple;
	bh=o9LSHzaiKGOEmotj5ZEVaMpfozhxboRlUJsatuCzoGs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WfgdA6ucd4/EJ/SCUTi9ZuTTjuufjVhyvLY7nfZ54Oqbp+VfByamKC5jakSFv+mrva4zVgNTCv2OrlRiiiyWTkDGRisIY0C7OU7ir0pbmeokiWKzKJoPIbe36CJEUsba0/907HdGA0e6V8YCahL+00F+RA6NMquKG56VzkQl3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a77d56e862so32086845ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 05:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733145031; x=1733749831;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+JgE0/nm7p4/nolG3NNGcdhhhlyAWVj0P6zgw0E6yk=;
        b=Mjzb37Xc98dc1AxCnQapqDwEifETWmmvsjHbpkYNRlnUmEcZ8/gCap7/jT963C/ZPg
         Bii003uJn7qmyDUJUetVcWvaR4SDX4VFBsSsjcSKA+3MWrzYbegu9hmistJAqdhYcgnX
         Gq5V9cP3xDBH1xsseczOYEE6ei6NGQU1DfFvnHCfN5djR8Bpq+LxM/w/+2AkyCVBiavi
         MUzEX/8s1O069wUGeQtwp20EQp8sftiABcTURF5Qe/to3bU/0L2NMv54N9P0kztsZJEo
         OiUnvIO4rt6+y+AifnVsZoiDjMtFLqDGgHeYQPLRsRpW/4p74ocLfW27G/jUiwgeD3qp
         3t3g==
X-Forwarded-Encrypted: i=1; AJvYcCXvQg+eln9Fg4MQjWC72svW1bkS2b+7Ov0njyrpmo2xbZknEVeoiLtVcm1QqtWcOSGVrUhpDhkPKiHMmUaH@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEbDf0YCJJaJ9RRPOxpG9jubdh/Aa0T5uWa2Jg0lJJR6yjtQ7
	BrAas5pV/L7nsS+jCyDLN1j2s4HRoPNJnqLDZ9Za3BVXpL9RHIDEA4Vy51/2i5xresG3DPvXkRg
	W1gwXMOfXAuGvEIoPtyi2pnXqhrRoWTuMO+EyQZdlJV0M0zhDJ5m3hLE=
X-Google-Smtp-Source: AGHT+IG4nqW0pcE1NvhOdlULAAYxMIWA7N50kddx+FYd4JTvtfeywQt+7yN8z/78kWrcTwQ4em6uxfo9OOq3BIsjOEiinyhPWw8L
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:3a7:c2ea:1095 with SMTP id
 e9e14a558f8ab-3a7c55241b7mr273052445ab.1.1733145031384; Mon, 02 Dec 2024
 05:10:31 -0800 (PST)
Date: Mon, 02 Dec 2024 05:10:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674db1c7.050a0220.ad585.0051.GAE@google.com>
Subject: [syzbot] [bcachefs?] INFO: task hung in vfs_unlink (5)
From: syzbot <syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40384c840ea1 Linux 6.13-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14faff78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92994d383dd8/disk-40384c84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5296b519dbbf/vmlinux-40384c84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/284141b3f7b6/bzImage-40384c84.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6983c03a6a28616e362f@syzkaller.appspotmail.com

INFO: task syz-executor:6013 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20304 pid:6013  tgid:6013  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:818 [inline]
 vfs_unlink+0xe4/0x650 fs/namei.c:4512
 do_unlinkat+0x4ae/0x830 fs/namei.c:4587
 __do_sys_unlink fs/namei.c:4635 [inline]
 __se_sys_unlink fs/namei.c:4633 [inline]
 __x64_sys_unlink+0x47/0x50 fs/namei.c:4633
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f27b7fdf7
RSP: 002b:00007ffe4ad49ab8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2f27b7fdf7
RDX: 00007ffe4ad49ae0 RSI: 00007ffe4ad49b70 RDI: 00007ffe4ad49b70
RBP: 00007ffe4ad49b70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 00007ffe4ad4abf0
R13: 00007f2f27bf3824 R14: 000000000006431a R15: 00007ffe4ad4ac30
 </TASK>
INFO: task syz-executor:9080 blocked for more than 144 seconds.
      Not tainted 6.13.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21280 pid:9080  tgid:9080  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
 rtnl_newlink+0xd04/0x24f0 net/core/rtnetlink.c:4006
 rtnetlink_rcv_msg+0x793/0xcf0 net/core/rtnetlink.c:6917
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ccb9826dc
RSP: 002b:00007fff40009f90 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4ccc674620 RCX: 00007f4ccb9826dc
RDX: 000000000000003c RSI: 00007f4ccc674670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff40009fe4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f4ccc674670 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:9086 blocked for more than 145 seconds.
      Not tainted 6.13.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22912 pid:9086  tgid:9086  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 __mutex_lock_common kernel/locking/mutex.c:665 [inline]
 __mutex_lock+0x7e7/0xee0 kernel/locking/mutex.c:735
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6923
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fca51b826dc
RSP: 002b:00007ffd8c302d30 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fca52874620 RCX: 00007fca51b826dc
RDX: 0000000000000040 RSI: 00007fca52874670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd8c302d84 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fca52874670 R15: 0000000000000000
 </TASK>
INFO: task syz.0.881:9104 blocked for more than 146 seconds.
      Not tainted 6.13.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.881       state:D stack:25312 pid:9104  tgid:9103  ppid:5842   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 exp_funnel_lock kernel/rcu/tree_exp.h:320 [inline]
 synchronize_rcu_expedited+0x70a/0x830 kernel/rcu/tree_exp.h:976
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1377
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1403
 qdisc_graft+0x8ad/0x1660 net/sched/sch_api.c:1136
 tc_modify_qdisc+0xf47/0x1e40 net/sched/sch_api.c:1793
 rtnetlink_rcv_msg+0x741/0xcf0 net/core/rtnetlink.c:6926
 netlink_rcv_skb+0x1e5/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f8/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x223/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmmsg+0x36a/0x720 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25f2180849
RSP: 002b:00007f25efff6058 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f25f2345fa0 RCX: 00007f25f2180849
RDX: 040000000000009f RSI: 00000000200002c0 RDI: 0000000000000004
RBP: 00007f25f21f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f25f2345fa0 R15: 00007fff43e6fd08
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:1/9:
3 locks held by kworker/u8:1/12:
 #0: ffff88814cbfc148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814cbfc148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000117d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000117d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4755
1 lock held by khungtaskd/30:
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
4 locks held by kworker/u9:0/55:
 #0: ffff88806ecea948 ((wq_completion)hci19#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88806ecea948 ((wq_completion)hci19#2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88809d84c078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x97/0xaa0 net/bluetooth/hci_event.c:3692
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x473/0xaa0 net/bluetooth/hci_event.c:3726
2 locks held by getty/5586:
 #0: ffff88814ccac0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5828:
 #0: ffffffff8e93cfb8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #0: ffffffff8e93cfb8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
5 locks held by kworker/u9:4/5839:
 #0: ffff8880702da948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8880702da948 ((wq_completion)hci2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003c8fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003c8fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88802b214d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88802b214078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266
5 locks held by kworker/u9:5/5840:
 #0: ffff88807b4f1948 ((wq_completion)hci6){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88807b4f1948 ((wq_completion)hci6){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc90003c6fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003c6fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888021bf8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff888021bf8078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266
4 locks held by kworker/0:4/5894:
2 locks held by kworker/0:5/5933:
3 locks held by syz-executor/6013:
 #0: ffff888031b08420 (sb_writers#5){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff888057bbd128 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:853 [inline]
 #1: ffff888057bbd128 (&type->i_mutex_dir_key#5/1){+.+.}-{4:4}, at: do_unlinkat+0x26a/0x830 fs/namei.c:4574
 #2: ffff88805b8a3708 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #2: ffff88805b8a3708 (&sb->s_type->i_mutex_key#12){+.+.}-{4:4}, at: vfs_unlink+0xe4/0x650 fs/namei.c:4512
2 locks held by syz-executor/9080:
 #0: ffffffff901980e0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff901980e0 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff901980e0 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
 #1: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #1: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
 #1: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd04/0x24f0 net/core/rtnetlink.c:4006
1 lock held by syz-executor/9086:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6923
3 locks held by syz.6.876/9095:
2 locks held by syz.4.879/9096:
 #0: ffff88805a9b2c08 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff88805a9b2c08 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release net/socket.c:639 [inline]
 #0: ffff88805a9b2c08 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: sock_close+0x90/0x240 net/socket.c:1408
 #1: ffffffff8e93cfb8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #1: ffffffff8e93cfb8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
1 lock held by syz.0.881/9104:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6923
1 lock held by syz-executor/9110:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9113:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9117:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9120:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9124:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9128:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by dhcpcd/9130:
 #0: ffff888096c4a258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff888096c4a258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9131:
 #0: ffff888070ec6258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff888070ec6258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9133:
 #0: ffff888012018258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff888012018258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by syz-executor/9137:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9142:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9144:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9146:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by dhcpcd/9148:
 #0: ffff888096f82258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff888096f82258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9149:
 #0: ffff88803ea52258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88803ea52258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9150:
 #0: ffff88803ea50258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88803ea50258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9151:
 #0: ffff88803ea4e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88803ea4e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9152:
 #0: ffff88803fa8e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88803fa8e258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9153:
 #0: ffff88803defe258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88803defe258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by dhcpcd/9154:
 #0: ffff88805ca12258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1617 [inline]
 #0: ffff88805ca12258 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x32/0xcb0 net/packet/af_packet.c:3267
1 lock held by syz-executor/9157:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9161:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
5 locks held by kworker/u9:1/9163:
 #0: ffff888059088148 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888059088148 ((wq_completion)hci9){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000443fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000443fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff8880346f8d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff8880346f8078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266
1 lock held by syz-executor/9168:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
1 lock held by syz-executor/9169:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
4 locks held by kworker/u9:2/9171:
 #0: ffff88806ecef948 ((wq_completion)hci20#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88806ecef948 ((wq_completion)hci20#2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900043efd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900043efd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88803af30078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x97/0xaa0 net/bluetooth/hci_event.c:3692
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x473/0xaa0 net/bluetooth/hci_event.c:3726
5 locks held by kworker/u9:3/9173:
 #0: ffff888059b72148 ((wq_completion)hci10){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888059b72148 ((wq_completion)hci10){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc900043afd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900043afd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff888057cd4d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff888057cd4078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266
1 lock held by syz-executor/9175:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
4 locks held by kworker/u9:6/9176:
 #0: ffff88807b7d2948 ((wq_completion)hci21#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88807b7d2948 ((wq_completion)hci21#2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000438fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000438fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff8880a34f8078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x97/0xaa0 net/bluetooth/hci_event.c:3692
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x473/0xaa0 net/bluetooth/hci_event.c:3726
1 lock held by syz-executor/9180:
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:128 [inline]
 #0: ffffffff8fcaf448 (rtnl_mutex){+.+.}-{4:4}, at: inet_rtm_newaddr+0x47e/0x1bd0 net/ipv4/devinet.c:987
4 locks held by kworker/u9:7/9181:
 #0: ffff888052ebc148 ((wq_completion)hci22#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888052ebc148 ((wq_completion)hci22#2){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000436fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000436fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88809b184078 (&hdev->lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x97/0xaa0 net/bluetooth/hci_event.c:3692
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #3: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_remote_features_evt+0x473/0xaa0 net/bluetooth/hci_event.c:3726
5 locks held by kworker/u9:9/9184:
 #0: ffff88805b4fb948 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88805b4fb948 ((wq_completion)hci8){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000433fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000433fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88805ddf0d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88805ddf0078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266
5 locks held by kworker/u9:10/9185:
 #0: ffff8880593dc948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff8880593dc948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000432fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000432fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffff88805d85cd80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:331
 #3: ffff88805d85c078 (&hdev->lock){+.+.}-{4:4}, at: hci_abort_conn_sync+0x1ea/0xe00 net/bluetooth/hci_sync.c:5584
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2032 [inline]
 #4: ffffffff8fe0fda8 (hci_cb_list_lock){+.+.}-{4:4}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1266

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_power_efficient wg_ratelimiter_gc_entries
RIP: 0010:validate_chain+0x5e9/0x5920 kernel/locking/lockdep.c:3916
Code: 04 0c 00 00 00 00 49 c7 44 0c 09 00 00 00 00 49 c7 44 0c 11 00 00 00 00 49 c7 44 0c 1f 00 00 00 00 49 c7 44 0c 2b 00 00 00 00 <41> c6 44 0c 33 00 65 48 8b 0c 25 28 00 00 00 48 3b 8c 24 a0 02 00
RSP: 0018:ffffc900000073a0 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffffffff9440ed60 RCX: 1ffff92000000e94
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff942b88f8
RBP: ffffc900000076a0 R08: ffffffff942b88ff R09: 1ffffffff285711f
R10: dffffc0000000000 R11: fffffbfff2857120 R12: dffffc0000000000
R13: ffff88801c2b0b78 R14: ec45c658ccca9fd1 R15: ffffffff9440ed78
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3040eff8 CR3: 000000000e736000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 usb_hcd_unlink_urb_from_ep+0x2c/0x110 drivers/usb/core/hcd.c:1224
 dummy_timer+0x83a/0x4620 drivers/usb/gadget/udc/dummy_hcd.c:1991
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59d/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1820
 handle_softirqs+0x2d6/0x9b0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:655
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:671
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:wg_ratelimiter_gc_entries+0x3ae/0x470 drivers/net/wireguard/ratelimiter.c:76
Code: 00 75 9c eb a2 e8 b2 7d 1e fb e9 19 ff ff ff e8 a8 7d 1e fb eb 05 e8 a1 7d 1e fb 48 c7 c7 20 48 43 8f e8 15 1a 52 05 4d 85 ff <48> 8b 5c 24 18 74 35 e8 86 7d 1e fb 48 c7 c7 40 aa 96 8c be 4e 00
RSP: 0018:ffffc900000e7b68 EFLAGS: 00000282
RAX: 0000000000000000 RBX: ffff88805d45f758 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffffc900000e7dc0 R08: ffffffff8f434823 R09: 1ffffffff1e86904
R10: dffffc0000000000 R11: fffffbfff1e86905 R12: 0000000000000000
R13: dffffc0000000000 R14: 00000084c44054c5 R15: ffffffff8f434940
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

