Return-Path: <linux-fsdevel+bounces-8041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2AF82EB79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7442A2826D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B25D12B8C;
	Tue, 16 Jan 2024 09:27:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEB712B72
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3618c6a1cceso1883425ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 01:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397241; x=1706002041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOsxNLpBRTGiUU6lZBOr9zV8xafpZmwbpi5r0C8L1zg=;
        b=AZdorMzbJ3ST6A2v3nJFWlJdg8RpH7OKuTWRzxVgOK0BEdFNKPVbljnhTIBqOVZi61
         GMkTo6O5GbKOzrAGAd/jPmKyxV/kpFwEn+V0nkoQPYarP6s7Oq3MJSvPUfnEf/wTHJo9
         EPVOvfT+dGjuZWLz3vOuumkWt5DgUBJMlVup8zQEgDLnllgLWJqMpIsPX6JcnMNC5E+N
         z9KesiVD2JNYJBRPIeY7zZ0LuAJ4MbJB/PVk+u+xFuct8d/fgbxp5EhXJpw5fyx4Vv56
         6BWKw1l9JatUBLLPDs7xs1pGX4BdJyJCNo2wVyPjNog3d8m7jjIrOqW2RcmLReDrV30s
         wmTA==
X-Gm-Message-State: AOJu0YzaUbUmdVqLTT4h2ZxkISn3SHRHK6ruX8+AThropi3S74sgkwje
	8INKVkVeFWUDEL0yed7aWSlDQ3Nn5Ade+M16/5INcIDo/oNW
X-Google-Smtp-Source: AGHT+IFSriItWy/h+LU6Lr8mhhRE9S5UJnpA1nLIi1CBILH2BJvuTvAJglPqCxymAvNQo4joBj6nnYdmsRVo4L5SxnTw7Mqn9f44
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:d5ea:8a86 with SMTP id
 s7-20020a056e021a0700b0035fd5ea8a86mr937528ild.5.1705397240898; Tue, 16 Jan
 2024 01:27:20 -0800 (PST)
Date: Tue, 16 Jan 2024 01:27:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000beadc4060f0cbc23@google.com>
Subject: [syzbot] [btrfs?] memory leak in corrupted
From: syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, clm@fb.com, 
	davem@davemloft.net, dsterba@suse.com, edumazet@google.com, 
	josef@toxicpanda.com, kuba@kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14620debe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7031f9e71583b4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a344c1e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82a7201eef4c/disk-052d5343.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca12b4c31826/vmlinux-052d5343.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f07360ba5a8/bzImage-052d5343.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811c71a980 (size 64):
  comm "syz-executor.7", pid 5063, jiffies 4294953937
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 8e 7e 1c 81 88 ff ff  ........ .~.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 9f8721dd):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199

BUG: memory leak
unreferenced object 0xffff88811c8561c0 (size 64):
  comm "syz-executor.0", pid 5062, jiffies 4294953941
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 ce 7e 1c 81 88 ff ff  ........ .~.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 7256c890):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199

BUG: memory leak
unreferenced object 0xffff88811cd88cc0 (size 64):
  comm "syz-executor.5", pid 5078, jiffies 4294953981
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 8e 05 1d 81 88 ff ff  ........ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc a919e6d6):
    [<ffffffff815f7d53>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f7d53>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f7d53>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f7d53>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84aae617>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84aae617>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84aae617>] batadv_tvlv_handler_register+0xf7/0x2a0 net/batman-adv/tvlv.c:560
    [<ffffffff84a8d09f>] batadv_mcast_init+0x4f/0xc0 net/batman-adv/multicast.c:1926
    [<ffffffff84a895b9>] batadv_mesh_init+0x209/0x2f0 net/batman-adv/main.c:231
    [<ffffffff84a9fa88>] batadv_softif_init_late+0x1f8/0x280 net/batman-adv/soft-interface.c:812
    [<ffffffff83f48559>] register_netdevice+0x189/0xca0 net/core/dev.c:10188
    [<ffffffff84a9f255>] batadv_softif_newlink+0x55/0x70 net/batman-adv/soft-interface.c:1088
    [<ffffffff83f61dc0>] rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
    [<ffffffff83f61dc0>] __rtnl_newlink+0xb10/0xec0 net/core/rtnetlink.c:3735
    [<ffffffff83f621bc>] rtnl_newlink+0x4c/0x70 net/core/rtnetlink.c:3748
    [<ffffffff83f5cd1f>] rtnetlink_rcv_msg+0x22f/0x5b0 net/core/rtnetlink.c:6615
    [<ffffffff84093291>] netlink_rcv_skb+0x91/0x1d0 net/netlink/af_netlink.c:2543
    [<ffffffff84092242>] netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
    [<ffffffff84092242>] netlink_unicast+0x2c2/0x440 net/netlink/af_netlink.c:1367
    [<ffffffff84092701>] netlink_sendmsg+0x341/0x690 net/netlink/af_netlink.c:1908
    [<ffffffff83ef2912>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ef2912>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ef5af4>] __sys_sendto+0x164/0x1e0 net/socket.c:2191
    [<ffffffff83ef5b98>] __do_sys_sendto net/socket.c:2203 [inline]
    [<ffffffff83ef5b98>] __se_sys_sendto net/socket.c:2199 [inline]
    [<ffffffff83ef5b98>] __x64_sys_sendto+0x28/0x30 net/socket.c:2199



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

