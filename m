Return-Path: <linux-fsdevel+bounces-18604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACA8BAB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF397B217BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E093152E1D;
	Fri,  3 May 2024 11:33:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12D152DE3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736011; cv=none; b=F3nV61Ab8X8Skrnqodx/tPTPtPvzVqnGoeq0MvNxaJkPZ9WgLaH/szB6/nOy22Mz5svEfOwQA0qnBUQirPjBCx0CgKj9z5DmkoSIzGtIkQn9XwE01E6/pvd65FeoHWMcODewS3mvi3Aa3MVLCxjb2l/TlH4S6E9wyFqtEUpT+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736011; c=relaxed/simple;
	bh=v7Spp7lzlnmbJdK6x1KTLdUk+tlB+DnEu2p/JVTdnVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YGwU/B3n/pbxzBc0BIMU/whpJVEbTJhQ158zgOHaFL78CuUbhocT9ni3uPvCW45+H+iLg5B42MPcSmSqOqr1awi15eDjkqYqKV5p5sYSvq/QdStjiXK3DCSDdOJf6xXCkg54gH6C0M2ISM71NWwnV/JhRSPOQ00cnEsMwMB1YN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec4e29827so596168639f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2024 04:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714736009; x=1715340809;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lEHx/Vuj5CasLNJSF5ikJxh7MNpkQfezTNEeHHcHggA=;
        b=lKG3uSlk7LV6qBcwj4cSMYC/GpZxMP5naCGvEIO8nrFvm7HIAVLXfxU58Fdqo12bOW
         okAi0CrGuBKfcbBcodVZWRWDQbyeBMWKz3ejnvUl1sfL9cLIbPxzAU9nCTpv2ItmQqEV
         Bw5/k6nxiowDUah885UJNaXQmcIOtBtb0PkKWWSvd+vczKd53cdden5CxmIamPaHCC5O
         Y1RQ3FlGJZLpwHBU/NwkeC3XYn6BPtjXHfA3wFqgovhUs4psFnNcEk0i0Gq1o0bmU2dQ
         E14iwC9bRkg+0VbNat4LPwvupjwkofXk91fpC/riHV7bt7RCZCIzUIY40pflWGiWquLx
         KRzA==
X-Forwarded-Encrypted: i=1; AJvYcCURmjHOZiOSGDPHXbqDlgb+0K/8kfHEXazuCBUAiTLvQB8NAg0F7mLGOnj5DAhe77fRvRgm9vmcyaYQFEw5p97tja6Q1n5JZEzbC+U2Bw==
X-Gm-Message-State: AOJu0Yxnp6m4cUPblMV1HKx+iR/CsWVDM8sogPkl0JHjXppE+stl/NxH
	or1ispBov3Jzo4vX1y5Pp77GvOJkistg4Gkxh7HeqJRwg//vtSNZGPtpnupbfkVtidc5CA+qrhR
	Pom/Q/iaflZEES7enV8l5pUz2m5HURc+YQmHrs+riZWxyV1mO5Wwm81c=
X-Google-Smtp-Source: AGHT+IHkIqMQ2kT4NXHBhyk9LQlJN3sZcH2El3byPvnCL0ZzZeSRWrIxUtDstJiXzZPp68IuHO80vWILgI2Amq5t8/6g+zDwQ0+P
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d1b:b0:487:30aa:adb6 with SMTP id
 he27-20020a0566386d1b00b0048730aaadb6mr68453jab.2.1714736008441; Fri, 03 May
 2024 04:33:28 -0700 (PDT)
Date: Fri, 03 May 2024 04:33:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aac1fe06178b16ec@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-use-after-free Read in dbAllocAG
From: syzbot <syzbot+4f473fdf2d6579286e09@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c8159388952 Merge tag 'rust-fixes-6.9' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1165d2f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d46aa9d7a44f40d
dashboard link: https://syzkaller.appspot.com/bug?extid=4f473fdf2d6579286e09
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4173768ac07/disk-2c815938.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/060f21ef407d/vmlinux-2c815938.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a38eae39bb35/bzImage-2c815938.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f473fdf2d6579286e09@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in dbAllocAG+0x2ef/0x10b0 fs/jfs/jfs_dmap.c:1366
Read of size 8 at addr ffff888075115038 by task syz-executor.2/9494

CPU: 0 PID: 9494 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00355-g2c8159388952 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 dbAllocAG+0x2ef/0x10b0 fs/jfs/jfs_dmap.c:1366
 dbDiscardAG+0x352/0xa10 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdb3c7dea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdb4a7f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007efdb3dac050 RCX: 00007efdb3c7dea9
RDX: 0000000020000380 RSI: 00000000c0185879 RDI: 0000000000000005
RBP: 00007efdb3cca4a4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007efdb3dac050 R15: 00007ffc27e05ad8
 </TASK>

Allocated by task 9466:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 dbMount+0x58/0x9b0 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1e0/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x59c/0xc50 fs/jfs/super.c:556
 mount_bdev+0x20a/0x2d0 fs/super.c:1658
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9466:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 dbUnmount+0x11d/0x190 fs/jfs/jfs_dmap.c:278
 jfs_mount_rw+0x4ac/0x6a0 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3d1/0x6b0 fs/jfs/super.c:454
 reconfigure_super+0x445/0x880 fs/super.c:1071
 vfs_cmd_reconfigure fs/fsopen.c:267 [inline]
 vfs_fsconfig_locked fs/fsopen.c:296 [inline]
 __do_sys_fsconfig fs/fsopen.c:476 [inline]
 __se_sys_fsconfig+0xab5/0xec0 fs/fsopen.c:349
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888075115000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 56 bytes inside of
 freed 2048-byte region [ffff888075115000, ffff888075115800)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75110
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015042000 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015042000 dead000000000100 dead000000000122
head: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0001d44401 dead000000000122 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5082, tgid -1007036727 (syz-executor.1), ts 5082, free_ts 63122226324
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x2e5/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 ieee80211_register_hw+0x1bb2/0x3d80 net/mac80211/main.c:1328
 mac80211_hwsim_new_radio+0x25ac/0x4550 drivers/net/wireless/virtual/mac80211_hwsim.c:5454
 hwsim_new_radio_nl+0xe4c/0x21d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6135
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1113 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1193 [inline]
 genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1208
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1217
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
page last free pid 4524 tgid 4524 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x1e2/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0xd8/0x130 security/security.c:2269
 vfs_getattr+0x45/0x430 fs/stat.c:173
 vfs_fstat fs/stat.c:198 [inline]
 vfs_fstatat+0xd6/0x190 fs/stat.c:300
 __do_sys_newfstatat fs/stat.c:468 [inline]
 __se_sys_newfstatat fs/stat.c:462 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:462
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffff888075114f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888075114f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888075115000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888075115080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075115100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

