Return-Path: <linux-fsdevel+bounces-70966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B76C4CACC5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC5130C2BBB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 09:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AB31A570;
	Mon,  8 Dec 2025 09:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37E3191D7
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186949; cv=none; b=PpDTYA2Opab7lYvhWj4HMNiwRmwvmqIK9RNVXtJy1rdkUNpDtEMHgdOr41AWkGaOOilyaGnbszIaoe10beCmClk6/1o5kvEbdoOEy8az9ykP6mrLycvgNO7s4egdTbE3KatwZBsCLN+pF9UX+0lDQuqQyoknMFTQa3kaRH4r6Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186949; c=relaxed/simple;
	bh=0iI55M+sBM4ese6DTuYRJRhlvxKMm6iVwG/YuY+p790=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hmscRMK/wRg9h8m+X2/BEu26iCzJIiOjQyKo/2IGOhUX5QUDMH/1so52ml+rdukwCo7sEPFleHn5Rsa6jyVYtANZOe9hx6OSE3j4TTqcwCMksx8pk9HyY7JIX+6i4kUqzgd4zyNDgkRk5VDKRkRHaYr7zG5Dk+JyKgjSxVps2lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7c75663feaeso4914635a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 01:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765186946; x=1765791746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH8CNd4DXN02lRhCXm2HKO0Vf/vVi/kx+lNSKoK74q4=;
        b=JKK3zxygGVq8HmQht9cWG7aNaoix/3+RgPo6BHn5xXeGdKkyiGBe7RnXqKUONHM5hV
         JRS4SEqnzofU1k2+bESvXRuuM8Qp4KLhIBlcE8fk2bd9zinwxJdeItz5U6Hbsq5+RqIQ
         aaJUph2FCxae1ZWebpkET7S4YwpgAYYtmAwaf/obNzb/C5dZml7pGMSPYLgF/KWOK5BU
         6pvUrZSmJdUH+4jf4sDK5dzEw71N5I3LKN6keztixwOVTGZ/IJk5nRKaB5zg5oK+FEsg
         EkYaFLYDiex+kbZGhWJ+nT1VH0JNhBLWzoH6y6fVYuzY2/4NGWX2ogdla+c5Mm2cK3fR
         VFKg==
X-Forwarded-Encrypted: i=1; AJvYcCXoCf9H6ikGaK4C+QPLZ0tRLsmVlGjALHTh9UtRlfJpwtvR327NVSswMlRVj1eTPQBtvI/we4LgQ7TSEFca@vger.kernel.org
X-Gm-Message-State: AOJu0Yy42MC6KIunMv9WvMNXmYoiVXqEtVG5sUHtAg08bWaeZKyM7XQH
	dBWpGc2qiWz6r9LSrNB5LHz46ZugTPFl8OnS1zdT2MeFkLONsn0UOMuOHsxO7WN162y6OJaJvKj
	V65aQvYUFPVjw7d7ttYZw2tcMZx626FRL/61Lpc5r06nLs5oLkvR+qEuGd1o=
X-Google-Smtp-Source: AGHT+IEsYAEyW+9pnvfjzU/dxOR7KiOv+b5tRe6u2/ZpZA3d4JqJcaGPvV98xhxHKIwftFwCeEi2csICmjehe0rdL1UNTPiMFPwv
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:61c:b0:659:9a49:90b5 with SMTP id
 006d021491bc7-6599a957819mr2718821eaf.52.1765186946533; Mon, 08 Dec 2025
 01:42:26 -0800 (PST)
Date: Mon, 08 Dec 2025 01:42:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69369d82.a70a0220.38f243.009f.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in debugfs_change_name
From: syzbot <syzbot+3d7ca9c802c547f8550a@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f7aa3d3c732 Merge tag 'net-next-6.19' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1350c01a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3bdbe6509b080086
dashboard link: https://syzkaller.appspot.com/bug?extid=3d7ca9c802c547f8550a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b9d192580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aceab4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/75704c8ef83a/disk-8f7aa3d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc039c7b45ea/vmlinux-8f7aa3d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80c77928126a/bzImage-8f7aa3d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d7ca9c802c547f8550a@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881110bb308 (size 8):
  comm "syz.0.17", pid 6090, jiffies 4294942958
  hex dump (first 8 bytes):
    2e 00 00 00 00 00 00 00                          ........
  backtrace (crc ecfc7064):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4953 [inline]
    slab_alloc_node mm/slub.c:5258 [inline]
    __do_kmalloc_node mm/slub.c:5651 [inline]
    __kmalloc_node_track_caller_noprof+0x3b2/0x670 mm/slub.c:5759
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    kstrdup_const+0x63/0x80 mm/util.c:104
    kvasprintf_const+0xca/0x110 lib/kasprintf.c:48
    debugfs_change_name+0xf6/0x5d0 fs/debugfs/inode.c:854
    cfg80211_dev_rename+0xd8/0x110 net/wireless/core.c:149
    nl80211_set_wiphy+0x102/0x1770 net/wireless/nl80211.c:3844
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210
    netlink_rcv_skb+0x93/0x1d0 net/netlink/af_netlink.c:2550
    genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
    netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
    netlink_unicast+0x3a3/0x4f0 net/netlink/af_netlink.c:1344
    netlink_sendmsg+0x335/0x6b0 net/netlink/af_netlink.c:1894
    sock_sendmsg_nosec net/socket.c:718 [inline]
    __sock_sendmsg net/socket.c:733 [inline]
    ____sys_sendmsg+0x562/0x5a0 net/socket.c:2608
    ___sys_sendmsg+0xc8/0x130 net/socket.c:2662
    __sys_sendmsg+0xc7/0x140 net/socket.c:2694

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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

