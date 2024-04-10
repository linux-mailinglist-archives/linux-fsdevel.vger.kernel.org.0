Return-Path: <linux-fsdevel+bounces-16538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677AF89F290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC47B24932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE215B541;
	Wed, 10 Apr 2024 12:45:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863A15920D
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753120; cv=none; b=rsi0WvLledRcsZMKaq9aFXQ1uNLjicqZoOBWT6GAVBoPgSub6NMYk4nnFNcewJH+3Fq0fy4YXW+1Avb1NNCWoPpB7unw0h7ns93AW7Fq2LM0z3NvL3W9olAu62ADq3QcevOrqkFV/meNtSk3s7HsDsRQHgsxvvUORbxshbTihZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753120; c=relaxed/simple;
	bh=zE0MPhiUExhhZJCSbZ04dwAd/lbO0K59CzmR1iW89P8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rZdmBIwh1LtexHtZyyigipekaxdu7eR9dMZyloh+hSDa+JYb/amVIhVVyxZUE6XZHLRtSRX1tgWgr/Ns63x070aGsbsyS0fkauDTAJeWF7A5qPxXuBgy0eCv0pgIytNQiDHW0Ku9SCEfPB2C9OWs5DNkWfOys92xgfhTw0szeHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so414777339f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 05:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753117; x=1713357917;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kNWUMJ3DCD0K91UBuJhSyWUGhiggaPpECWUh6Le1yA=;
        b=vqovLZPoJcE8lfnnmX1+dDHSk/dfIPv1Lw/xW2MpWmhecthrfoT2kcNrPt7PZPMlbO
         NuNMPjaIQKwCij3aQNYEMJ54QjmS6P7CnrGHclH+u0QUbMtnqf9VNoWANmugQ16Hl2WC
         K84Qi34y8XoXs6wB1jptVPHDc3kBqf8A76JlOjxz6UBYMEzSEMieU8IeBfUPU+3+bWZp
         0Aio9mTgoKurot8k0PJTr0NRdK9bf9onmtBzo4V+QuG7TgYlvzga9Z/XkWpN4U/6AHFY
         6nglu37kby+7vPVWUe3Z1FgaaL0LTnwWh3AjKdF9e1aopWycsDFvSMiyvleK++vwkpDm
         smxA==
X-Forwarded-Encrypted: i=1; AJvYcCWjoVRPZg6xoUcs7/zFp9Nrwl7T66iV+PTn+67/VnxKPGw2dt401t1dYw7z63u1khjYMVGtaR/n9UKcHJP8xyESwSbm9UlFDS4zhPjLgg==
X-Gm-Message-State: AOJu0Yyge/tJcm0rq+yT7xV1MUW2CkWt2Kw0547zEQ00hD7fZaVAw6uz
	0YXjYnMCOaPKRDBaeEY2AiAb6potE7fGhG+vPjPAlQBKkEEcniJXHrf9MfKgMqBh3ky4X7epKHM
	8mLaKysvTjmtY3v+Ggd5wcHkOxU6vv0PqIecJdZjfuoGtWkRIfrlDuQ8=
X-Google-Smtp-Source: AGHT+IFVEpX4wfLojEnNH7MhR90glZV/P7PZ7NGpZg5J8pV6K3Mp6rj30GZWGCBBrmgKkBAGHgk6LdRKIqLCvfqzgE3ecPhQLnC1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d3:b0:482:bdf8:f269 with SMTP id
 y19-20020a05663824d300b00482bdf8f269mr37311jat.3.1712753117683; Wed, 10 Apr
 2024 05:45:17 -0700 (PDT)
Date: Wed, 10 Apr 2024 05:45:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002af6530615bd6932@google.com>
Subject: [syzbot] [xfs?] KASAN: slab-use-after-free Read in xfs_inode_item_push
From: syzbot <syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=168b2fe3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a28995e12fd13faa44e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in xfs_inode_item_push+0x248/0x290 fs/xfs/xfs_inode_item.c:743
Read of size 8 at addr ffff0000ddfe0bb8 by task xfsaild/loop0/7856

CPU: 0 PID: 7856 Comm: xfsaild/loop0 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 xfs_inode_item_push+0x248/0x290 fs/xfs/xfs_inode_item.c:743
 xfsaild_push_item fs/xfs/xfs_trans_ail.c:414 [inline]
 xfsaild_push fs/xfs/xfs_trans_ail.c:486 [inline]
 xfsaild+0xbe8/0x2c18 fs/xfs/xfs_trans_ail.c:671
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Allocated by task 7816:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:575
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x1dc/0x488 mm/slub.c:3867
 kmem_cache_zalloc include/linux/slab.h:701 [inline]
 xfs_inode_item_init+0x3c/0xc0 fs/xfs/xfs_inode_item.c:838
 xfs_trans_ijoin+0xd8/0x114 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_create+0x8a4/0xf9c fs/xfs/xfs_inode.c:1040
 xfs_generic_create+0x3c8/0xb10 fs/xfs/xfs_iops.c:199
 xfs_vn_create+0x44/0x58 fs/xfs/xfs_iops.c:275
 lookup_open fs/namei.c:3500 [inline]
 open_last_lookups fs/namei.c:3569 [inline]
 path_openat+0xfb4/0x2830 fs/namei.c:3799
 do_filp_open+0x1bc/0x3cc fs/namei.c:3829
 do_sys_openat2+0x124/0x1b8 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1430
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 22:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x54/0x6c mm/kasan/generic.c:589
 poison_slab_object+0x124/0x18c mm/kasan/common.c:240
 __kasan_slab_free+0x3c/0x70 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x15c/0x3d4 mm/slub.c:4363
 xfs_inode_item_destroy+0x80/0x94 fs/xfs/xfs_inode_item.c:860
 xfs_inode_free_callback+0x154/0x1cc fs/xfs/xfs_icache.c:145
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x890/0x1b34 kernel/rcu/tree.c:2465
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2482
 __do_softirq+0x2d8/0xce4 kernel/softirq.c:553

The buggy address belongs to the object at ffff0000ddfe0b88
 which belongs to the cache xfs_ili of size 264
The buggy address is located 48 bytes inside of
 freed 264-byte region [ffff0000ddfe0b88, ffff0000ddfe0c90)

The buggy address belongs to the physical page:
page:00000000b7c34688 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000ddfe0668 pfn:0x11dfe0
flags: 0x5ffc00000000800(slab|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000800 ffff0000c559d140 dead000000000122 0000000000000000
raw: ffff0000ddfe0668 00000000800c0004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ddfe0a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000ddfe0b00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff0000ddfe0b80: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff0000ddfe0c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000ddfe0c80: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
==================================================================


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

