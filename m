Return-Path: <linux-fsdevel+bounces-41377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8CBA2E67E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 09:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964A31887CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649471C4A16;
	Mon, 10 Feb 2025 08:29:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312B1C07CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176172; cv=none; b=HaTQHj1M0f1WGMtKEvOLVqD+DYaMET6J83Ps/akpYrlF7Xaa+Po2sKoPaLNiEyXfLuiPeXy6RfGuHT10hhsYLRu6+yodEItD/BinFJ6yE6wAvDnPkfRxHcSzH8jsTawirCnkwPGzItbRybS1oWV+EDGf8rh1NkDgt4H+3GCEIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176172; c=relaxed/simple;
	bh=7938q8AnA0hMeVIzfJLONwps0O+OO1QbPeewyDUWH24=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fjdMyD+ddcDNQ5E4KWYAQbpEsKznM89pkQZi69H8WWmpHEqtJw9sj/ISrk8WGjzOxpu0tTzzgYOhV1MX+LIsVUwXWxi97WYlB7Grs/YzAmlPi3e4aNlcsikFOA4z6oJfESd9D6CIp6dgfs6X6T95pcY2Pl83Q05Y+Sdh4cf/B4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d143f1353bso19234575ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 00:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176170; x=1739780970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3sAVkUamsLtJGXltAHhfleuj89fqfg3E/LzMxbuIXk=;
        b=TkZeMQNnFuIpwm0hKVVxrqYboXtQkAkNFCShe1+s2fQ/+8McMmtNd05/8iUDXiRG6A
         1KjTrvZoYL0rxOIql3WxLZdQLV1uz4FoIDbQGHaLVrzMaJ5PMzQctiQ3I8DCPsREhPhd
         2rs8SPCDYn+I3IDj5s0EETHV06HnCAVhbANBZ9PHEDmhYm9G6RUlNT3d49S6ZOv6gzOC
         C8oxJ3xzEy7AH0PIIkG/m/OFFxLHyi5VJvCtJ+13n9SZ2oW+GXyIVTIyDjq/bk71UCIR
         /bINoNBXuG5CkoID13fR2mWXTU5pPXEO8yfE52Hg91f4UcYLLtD8q7E+eZbbdDlYMR/c
         K+7A==
X-Forwarded-Encrypted: i=1; AJvYcCXzL19m58/5KkwXQioXo19wsxIDtZW6YwiPUSF0vp84odwP4h5w4gzA8QlYfZ2l3KA5S277hZTiPiK0qOyt@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpBvnHhRA2YemBWSuCRDatumXUXHX9iHvrywGSfMGCgGsBAVk
	BGQAEsipRmmmA4mPDaMJCzJWQKQouDm4Be3V6asXhyHeanhNCoN6Ik1LlAKMr/+5iz5YfyHN9hn
	HrD2Sbl9WOFx/GMksjpvwgB2UJ/V8yI5me5elKaekSbi2rNDsfx+dxBQ=
X-Google-Smtp-Source: AGHT+IHQ6+iooeSmBNXjvZbNprLgp2a0Kka2sv0k5zC9Da5Uc0QTRl7BsPBxYEx6qfDaFX6JclCu2RHch4eysudJCz7RFHhYoDOF
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4d:b0:3cf:ae67:4115 with SMTP id
 e9e14a558f8ab-3d13dd2547dmr56019635ab.8.1739176169829; Mon, 10 Feb 2025
 00:29:29 -0800 (PST)
Date: Mon, 10 Feb 2025 00:29:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a9b8e9.050a0220.3d72c.004c.GAE@google.com>
Subject: [syzbot] [net?] [bcachefs?] general protection fault in ipv6_get_saddr_eval
From: syzbot <syzbot+94c6d316eec8a68cc993@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kent.overstreet@linux.dev, kuba@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69b8923f5003 Merge tag 'for-linus-6.14-ofs4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15912eb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57ab43c279fa614d
dashboard link: https://syzkaller.appspot.com/bug?extid=94c6d316eec8a68cc993
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169983df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea84ac864e92/disk-69b8923f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a465997b4e0/vmlinux-69b8923f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d72b67b2bd15/bzImage-69b8923f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0073f7fa8a9c/mount_0.gz

The issue was bisected to:

commit 14152654805256d760315ec24e414363bfa19a06
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Mon Nov 25 05:21:27 2024 +0000

    bcachefs: Bad btree roots are now autofix

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13505df8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10d05df8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17505df8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94c6d316eec8a68cc993@syzkaller.appspotmail.com
Fixes: 141526548052 ("bcachefs: Bad btree roots are now autofix")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.13.0-syzkaller-09793-g69b8923f5003 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:ipv6_get_saddr_eval+0x511/0xf50 net/ipv6/addrconf.c:1666
Code: e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 98 a9 97 f7 48 89 6c 24 08 4d 8b 2e 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 71 a9 97 f7 41 be e0 00 00 00 4d 03
RSP: 0018:ffffc900001168b8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888024f99e40 RCX: dffffc0000000000
RDX: ffff88805fc0dc00 RSI: ffffffff8fdb28c0 RDI: ffffc900001169e8
RBP: 0000000000000006 R08: 0000000000000005 R09: ffffffff8a8bbc59
R10: 000000000000000b R11: ffff88801c285a00 R12: ffffc90000116a40
R13: 0000000000000000 R14: ffff88805fc0dd38 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3ddba7bac CR3: 0000000024428000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ipv6_dev_get_saddr+0x1d3/0x4b0 net/ipv6/addrconf.c:1753
 ipv6_dev_get_saddr+0x555/0xc10 net/ipv6/addrconf.c:1889
 ip6_route_get_saddr include/net/ip6_route.h:147 [inline]
 ip6_dst_lookup_tail+0xf18/0x14f0 net/ipv6/ip6_output.c:1133
 ip6_dst_lookup_flow+0xb9/0x180 net/ipv6/ip6_output.c:1259
 udp_tunnel6_dst_lookup+0x2be/0x520 net/ipv6/ip6_udp_tunnel.c:165
 geneve6_xmit_skb drivers/net/geneve.c:950 [inline]
 geneve_xmit+0xcf2/0x2cf0 drivers/net/geneve.c:1036
 __netdev_start_xmit include/linux/netdevice.h:5144 [inline]
 netdev_start_xmit include/linux/netdevice.h:5153 [inline]
 xmit_one net/core/dev.c:3735 [inline]
 dev_hard_start_xmit+0x27a/0x7d0 net/core/dev.c:3751
 __dev_queue_xmit+0x1b73/0x3f50 net/core/dev.c:4584
 dev_queue_xmit include/linux/netdevice.h:3305 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip6_finish_output2+0x1263/0x1780 net/ipv6/ip6_output.c:141
 ip6_finish_output+0x41e/0x840 net/ipv6/ip6_output.c:226
 NF_HOOK+0x9e/0x430 include/linux/netfilter.h:314
 mld_sendpack+0x843/0xdb0 net/ipv6/mcast.c:1862
 ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2288
 addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4336
 addrconf_dad_work+0xdbc/0x16a0
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ipv6_get_saddr_eval+0x511/0xf50 net/ipv6/addrconf.c:1666
Code: e8 03 42 80 3c 28 00 74 08 4c 89 f7 e8 98 a9 97 f7 48 89 6c 24 08 4d 8b 2e 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 71 a9 97 f7 41 be e0 00 00 00 4d 03
RSP: 0018:ffffc900001168b8 EFLAGS: 00010246

RAX: 0000000000000000 RBX: ffff888024f99e40 RCX: dffffc0000000000
RDX: ffff88805fc0dc00 RSI: ffffffff8fdb28c0 RDI: ffffc900001169e8
RBP: 0000000000000006 R08: 0000000000000005 R09: ffffffff8a8bbc59
R10: 000000000000000b R11: ffff88801c285a00 R12: ffffc90000116a40
R13: 0000000000000000 R14: ffff88805fc0dd38 R15: 0000000000000006
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa3ddba7bac CR3: 0000000024428000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e8 03 42 80 3c       	call   0x3c804208
   5:	28 00                	sub    %al,(%rax)
   7:	74 08                	je     0x11
   9:	4c 89 f7             	mov    %r14,%rdi
   c:	e8 98 a9 97 f7       	call   0xf797a9a9
  11:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
  16:	4d 8b 2e             	mov    (%r14),%r13
  19:	4c 89 e8             	mov    %r13,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ef             	mov    %r13,%rdi
  33:	e8 71 a9 97 f7       	call   0xf797a9a9
  38:	41 be e0 00 00 00    	mov    $0xe0,%r14d
  3e:	4d                   	rex.WRB
  3f:	03                   	.byte 0x3


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

