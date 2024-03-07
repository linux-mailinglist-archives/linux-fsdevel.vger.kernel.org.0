Return-Path: <linux-fsdevel+bounces-13841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E71C874947
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A1228660D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261DE64CD5;
	Thu,  7 Mar 2024 08:14:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE16341C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799265; cv=none; b=Acd4/QT7VEGz0TEOJ1zl6Wy76q09A7fuYhfCL0evdAXMklcXZvXGX1q46kBS6QsLq9lkRW6EZ6WrOc8dmKyHajWZFII4AS6lOaAaaef1bhKQYVHRe2Sn/88jsYFAxSXUz3Z0tAXILsYvRd+mGeE8+krECeuZPQ9KNfwy07sXTfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799265; c=relaxed/simple;
	bh=Svri/f9A8U2AZdaX+7YIfIbm+rf9BAcYNz68PRBESQw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NW4RbaJQMjiQZq8xHfCNnZbNLYWTvi1ygiqM36E7xHDLSu3xt6PlwKpiz03V6Lk1/Qf4qb0RXYmxDGACHEB1vbWXPx4f5WGPmCsTt1sFpgiwtcywzBf2M6yzBLRAgvCvLjIQjLlDldeE7wOT99y+FW2hZ08jtQcu3Ktk3AsZrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3652d6907a1so6090085ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 00:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799263; x=1710404063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8cqjM6fSi7foX5/6Dajg++6TmjtXRxa3ClU1ofYsKBc=;
        b=RJmukNxwZ8FWPUkVr6jdIOUX9TKibkZ4I3ga9EN1xQuRaVe8f1h1S99A2Jl6HLTS84
         VwxN0lHgAh4cSzhcweLIxJqTuXFsaqmul1OFnn9JipTNHgcZzILATSSs5jTdjkBMy+4l
         TcLlvv02c5TNWNLMRfnzJcGHQAMN3csuDTfpDk54NaNd1SJeVVhGJxZR3o2lMFp5qbfY
         bS/m4PH6nHHzYiRBQR5xtgxDS81BoOu36XIlBbkEayGE42xjoC0MK4q0pgFZaMVDomvj
         PYHkTJgLPg6qI994IF6YsS+j+bB+8lZ/0BXcmrfaNnVQZXG647uHNNlSqvKw5qAcWec+
         YfJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOddDnallgummRAH+8xoGLD26WKKBPT3E7Fd7uiEUJk7ZJorn46YSPa02GPaCUbscKk6pFlCTD/zFYLCIO/Vi/qcS7qfKI+BOHgVLNqA==
X-Gm-Message-State: AOJu0YzWwD1ux+6ovNrsEk/+4UNrmmDHoBsSmEw/DgbxXtf16ySroxF3
	VfT6NsC4xYmvF72UJdpznI0iH0CsiI8Nqk7nrhEqII4G6KbwmUT3gg9yBZSp1ajcaQUN5RbYOS4
	w8XO0U9LkcaFhN3kl55sOUhNVfJzoaimiphd2qqhkBB5kA/rAt+1doqQ=
X-Google-Smtp-Source: AGHT+IFqU+JnEDxjsiZfCpbs257JSrO+fKp3BzahvmY3jRqWm3+ve3xasD9xj9IlcrJ/Wf04LDjZXe15X1imhg6TMZULMeNuHqeR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:365:1c10:9cfa with SMTP id
 l3-20020a056e021c0300b003651c109cfamr960726ilh.5.1709799263196; Thu, 07 Mar
 2024 00:14:23 -0800 (PST)
Date: Thu, 07 Mar 2024 00:14:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b86c5e06130da9c6@google.com>
Subject: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150add9a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be0288b26c967205
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/926d19cdf690/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0754e78c2bc/bzImage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in p9_fid_destroy+0xb5/0xd0 net/9p/client.c:884
Read of size 8 at addr ffff888064295880 by task kworker/u16:0/11

CPU: 0 PID: 11 Comm: kworker/u16:0 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound v9fs_upload_to_server_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 p9_fid_destroy+0xb5/0xd0 net/9p/client.c:884
 p9_client_clunk+0x12a/0x170 net/9p/client.c:1456
 p9_fid_put include/net/9p/client.h:278 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:128
 netfs_free_request+0x225/0x670 fs/netfs/objects.c:97
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:130
 netfs_free_subrequest fs/netfs/objects.c:178 [inline]
 netfs_put_subrequest+0x3be/0x600 fs/netfs/objects.c:192
 v9fs_upload_to_server fs/9p/vfs_addr.c:36 [inline]
 v9fs_upload_to_server_worker+0x182/0x360 fs/9p/vfs_addr.c:44
 process_one_work+0x889/0x15e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x12a0 kernel/workqueue.c:2787
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 14429:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 p9_fid_create+0x45/0x470 net/9p/client.c:853
 p9_client_walk+0xc7/0x550 net/9p/client.c:1154
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x623/0xc30 fs/9p/vfs_file.c:56
 do_dentry_open+0x8da/0x18c0 fs/open.c:953
 do_open fs/namei.c:3645 [inline]
 path_openat+0x1e00/0x29a0 fs/namei.c:3802
 do_filp_open+0x1de/0x440 fs/namei.c:3829
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1404
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1430
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 18115:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:589
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 p9_client_destroy+0x14c/0x480 net/9p/client.c:1070
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:506
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:223
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:212
 do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff888064295880
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff888064295880, ffff8880642958e0)

The buggy address belongs to the physical page:
page:ffffea000190a540 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64295
ksm flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c42780 ffffea0000c8c240 dead000000000007
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 10902, tgid 10901 (syz-executor.3), ts 360371748345, free_ts 360348940469
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x3b8/0x440 mm/slub.c:3994
 kmalloc_array include/linux/slab.h:627 [inline]
 kcalloc include/linux/slab.h:658 [inline]
 ext4_find_extent+0x95c/0xce0 fs/ext4/extents.c:914
 ext4_ext_map_blocks+0x26b/0x5bb0 fs/ext4/extents.c:4143
 ext4_map_blocks+0x61d/0x17d0 fs/ext4/inode.c:623
 ext4_iomap_alloc fs/ext4/inode.c:3318 [inline]
 ext4_iomap_begin+0x472/0x7d0 fs/ext4/inode.c:3368
 iomap_iter+0x48b/0xff0 fs/iomap/iter.c:91
 __iomap_dio_rw+0x6c4/0x1bd0 fs/iomap/direct-io.c:658
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:748
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x12c6/0x1960 fs/ext4/file.c:696
 call_write_iter include/linux/fs.h:2087 [inline]
 iter_file_splice_write+0x908/0x10b0 fs/splice.c:743
page last free pid 5164 tgid 5164 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 skb_free_frag include/linux/skbuff.h:3270 [inline]
 skb_free_head+0xa6/0x1b0 net/core/skbuff.c:996
 skb_release_data+0x5c0/0x880 net/core/skbuff.c:1028
 skb_release_all net/core/skbuff.c:1094 [inline]
 __kfree_skb+0x51/0x70 net/core/skbuff.c:1108
 tcp_rcv_established+0xd72/0x20f0 net/ipv4/tcp_input.c:6080
 tcp_v4_do_rcv+0x6ab/0xa50 net/ipv4/tcp_ipv4.c:1906
 sk_backlog_rcv include/net/sock.h:1092 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:2972
 release_sock+0x5a/0x220 net/core/sock.c:3538
 tcp_sendmsg+0x38/0x50 net/ipv4/tcp.c:1342
 inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:850
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x4b8/0x5c0 net/socket.c:1160
 call_write_iter include/linux/fs.h:2087 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6de/0x1110 fs/read_write.c:590
 ksys_write+0x1f8/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff888064295780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888064295800: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888064295880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff888064295900: 00 00 00 00 00 00 00 00 03 fc fc fc fc fc fc fc
 ffff888064295980: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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

