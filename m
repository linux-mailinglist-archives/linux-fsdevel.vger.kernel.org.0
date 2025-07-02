Return-Path: <linux-fsdevel+bounces-53740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE4DAF6519
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 00:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCEA4A18E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 22:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E36246773;
	Wed,  2 Jul 2025 22:25:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48591EC014
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495131; cv=none; b=cLYCmZrcuKemDESpYR/gfOWRIEJEAHPd6IskVw7lxch49x/CU0elhv7jZ8kzLIE/kMoGYOTEsHJpUFEyKqunxw06lJSI6e8iH6yVn0R74rIr4oZgysaLYEhwkHcJT+xPTnR4JuTqaKd+D4aiI0HVhxBsK95svNdqlfYHbM6cRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495131; c=relaxed/simple;
	bh=FwB4e6b9DTOqtJf7coY+vgdQ52tc5Z4DuBrnjuvcQCk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iOBbkNNa3TPM/El6cGeubnUaKVW3+TgpPaQ8WmyNbbMRCTThx4/q35HxT1G3LUiYeDijY4JQa4wCpZCg1xeyarfXTtYV3xofB8Vs5AMwmFG9rA5jGsgJO9JRGsJeMRyEDMJ3NqsTHTFc/4oaiLZznO0GfguoWHem/aWsNVMqA9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3df33d97436so3717335ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jul 2025 15:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495129; x=1752099929;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pErhI2u+uq8KWGvVut0ueMZ9mVMNWYhQEEkRMdxrjbE=;
        b=vEpEOQ7DRxpcOQkH29+iJWdKgxrh+zJopzNryoeFTgOFmt2hcrF2jMH5Zd/nkQP/Wq
         TUCCHsHud0nvMXM6uzZP+mEsVGV7rDiJaxL6T+cbVJ5jksfgx9Y4pUufoEL6Nh8dlEoX
         /RbaApXrzbdIwS3QU92Zk1lLybRuc2DdQY1l/zrtWroqcAT4+ipiUeFw8lYZjc1Hs3Kt
         C4nXZP9uBfMLGotw8JlzJ2YrGIwTwCKvqOXBUw4PWT8JlMOpxANKLPzmbiVuQHGb0QRI
         tYRm2eZDxcrqxf2q+zam129ee+m2tZIqzE5Ef21BK8ijhEvFCWxwKEF/Wwb+GG3SlO1D
         qQKA==
X-Forwarded-Encrypted: i=1; AJvYcCX8WM2TdzYFDEM7E93XAc4QaX9vnok4fi9MHG1fbyBJTqf3LcvOoTXB/7+She/qZlzGGWD3UGC+H+0JU/WZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BWQA++pcCWHMWYI8XiJlUQaB6y3WDlzKHnRwUfhF0FhnDihL
	4Flo0SShTlzF3qfORlqQAT+GoEdNtWSUG1/wXPHOrrKMWssUHLV/YPE0oUp06wWY+cvPNrr2PJ1
	3LmJZvf6oti2etuLi1Di0K7Ewc+eE78eLi5gp5J2V1OzTuYUiV/QI659wL8Q=
X-Google-Smtp-Source: AGHT+IEMfsXDKOrjk3mfsESFHHcRI3MnClkTMAWdQwp13B9+52qg3BbQun2vWaYTX8iX15bCjNG91w2PbqNKb/bucdCTpCNfNbHK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4f:b0:3df:3548:4961 with SMTP id
 e9e14a558f8ab-3e05c35212cmr17965975ab.6.1751495128983; Wed, 02 Jul 2025
 15:25:28 -0700 (PDT)
Date: Wed, 02 Jul 2025 15:25:28 -0700
In-Reply-To: <686571dd.a70a0220.2b31f5.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6865b1d8.a70a0220.5d25f.06c3.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: suspicious RCU usage in proc_sys_compare
From: syzbot <syzbot+268eaa983b2fb27e5e38@syzkaller.appspotmail.com>
To: joel.granados@kernel.org, kees@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    50c8770a42fa Add linux-next specific files for 20250702
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1656b48c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd831c9dfe03f77e=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3D268eaa983b2fb27e5=
e38
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-=
1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D117a148c58000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1050f982580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb40fda2e0ca/disk-=
50c8770a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cba4d214940c/vmlinux-=
50c8770a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b23ed647866/bzI=
mage-50c8770a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+268eaa983b2fb27e5e38@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: suspicious RCU usage
6.16.0-rc4-next-20250702-syzkaller #0 Not tainted
-----------------------------
fs/proc/proc_sysctl.c:934 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active =3D 2, debug_locks =3D 1
3 locks held by syz-executor847/5848:
 #0: ffff88805c84c428 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x41/0=
x90 fs/namespace.c:557
 #1: ffff888030198c30 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: inode_=
lock_shared include/linux/fs.h:884 [inline]
 #1: ffff888030198c30 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: open_l=
ast_lookups fs/namei.c:3806 [inline]
 #1: ffff888030198c30 (&sb->s_type->i_mutex_key#10){++++}-{4:4}, at: path_o=
penat+0x8cb/0x3830 fs/namei.c:4043
 #2: ffff88805d995560 (&lockref->lock){+.+.}-{3:3}, at: spin_lock include/l=
inux/spinlock.h:351 [inline]
 #2: ffff88805d995560 (&lockref->lock){+.+.}-{3:3}, at: d_alloc_parallel+0x=
ace/0x15e0 fs/dcache.c:2623

stack backtrace:
CPU: 1 UID: 0 PID: 5848 Comm: syz-executor847 Not tainted 6.16.0-rc4-next-2=
0250702-syzkaller #0 PREEMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6871
 proc_sys_compare+0x27d/0x2c0 fs/proc/proc_sysctl.c:934
 d_same_name fs/dcache.c:2179 [inline]
 d_alloc_parallel+0x1060/0x15e0 fs/dcache.c:2637
 lookup_open fs/namei.c:3630 [inline]
 open_last_lookups fs/namei.c:3807 [inline]
 path_openat+0xa3b/0x3830 fs/namei.c:4043
 do_filp_open+0x1fa/0x410 fs/namei.c:4073
 do_sys_openat2+0x121/0x1c0 fs/open.c:1434
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1460
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf9ff7a291
Code: 75 57 89 f0 25 00 00 41 00 3d 00 00 41 00 74 49 80 3d da ab 08 00 00 =
74 6d 89 da 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff f=
f 0f 87 93 00 00 00 48 8b 54 24 28 64 48 2b 14 25
RSP: 002b:00007fff03f8f390 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000080001 RCX: 00007faf9ff7a291
RDX: 0000000000080001 RSI: 00007faf9ffcb7d7 RDI: 00000000ffffff9c
RBP: 00007faf9ffcb7d7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff03f8f430
R13: 00007faf9fffa590 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
chnl_net:caif_netlink_parms(): no params data found
bridge0: port 1(bridge_slave_0) entered blocking state
bridge0: port 1(bridge_slave_0) entered disabled state
bridge_slave_0: entered allmulticast mode
bridge_slave_0: entered promiscuous mode
bridge0: port 2(bridge_slave_1) entered blocking state
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_1: entered allmulticast mode
bridge_slave_1: entered promiscuous mode
bond0: (slave bond_slave_0): Enslaving as an active interface with an up li=
nk
bond0: (slave bond_slave_1): Enslaving as an active interface with an up li=
nk
team0: Port device team_slave_0 added
team0: Port device team_slave_1 added
batman_adv: batadv0: Adding interface: batadv_slave_0
batman_adv: batadv0: The MTU of interface batadv_slave_0 is too small (1500=
) to handle the transport of batman-adv packets. Packets going over this in=
terface will be fragmented on layer2 which could impact the performance. Se=
tting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_0 (retrying later): i=
nterface not active
batman_adv: batadv0: Adding interface: batadv_slave_1
batman_adv: batadv0: The MTU of interface batadv_slave_1 is too small (1500=
) to handle the transport of batman-adv packets. Packets going over this in=
terface will be fragmented on layer2 which could impact the performance. Se=
tting the MTU to 1560 would solve the problem.
batman_adv: batadv0: Not using interface batadv_slave_1 (retrying later): i=
nterface not active
hsr_slave_0: entered promiscuous mode
hsr_slave_1: entered promiscuous mode
debugfs: 'hsr0' already exists in 'hsr'
Cannot create hsr debugfs directory
netdevsim netdevsim2 netdevsim0: renamed from eth0
netdevsim netdevsim2 netdevsim1: renamed from eth1
netdevsim netdevsim2 netdevsim2: renamed from eth2
netdevsim netdevsim2 netdevsim3: renamed from eth3
8021q: adding VLAN 0 to HW filter on device bond0
8021q: adding VLAN 0 to HW filter on device team0
8021q: adding VLAN 0 to HW filter on device batadv0
veth0_vlan: entered promiscuous mode
veth1_vlan: entered promiscuous mode
veth0_macvtap: entered promiscuous mode
veth1_macvtap: entered promiscuous mode


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

