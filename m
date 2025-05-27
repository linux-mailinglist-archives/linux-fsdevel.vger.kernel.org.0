Return-Path: <linux-fsdevel+bounces-49912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4CFAC5020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F77A50A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311D274FCF;
	Tue, 27 May 2025 13:44:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90801272E6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748353487; cv=none; b=BPcRrWAHVHwiwS3IHEAg6XgZql0ugRVgADggZmboDoZ8sBd19NSxTIiDbjERy72OWUBqRg9st2qBUptn9ybRMWNNTgtAu00Hzx1FIfnUeVX8OEOUwMK8n552Qvt37YjNiF+4yIKOmW42oZmST5Np1A+gwsZ5sZ8eU8Q6s6WmCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748353487; c=relaxed/simple;
	bh=xFr03H+Ak52yurWUvO7RyYjKfcHsP+87Mrfjhd4Nkk0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rOy9P57gZMU3OG20P7liIt6nWoxLUgVPwqz3miixF66XlUzDTxx0MW/DqP9njKI2hnTwbu9SH5DCpx3YG1E/D0KlIfLdhx+anLrPxR+UVxqUQDT4SkHpQCuEca+GviQ8stK4wo4WhaDvKl1+iHS6m4uLw2v5HPwOOomEgLhfYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-73e0094706bso4430696b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 May 2025 06:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748353485; x=1748958285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LnauR2bJYxpR1/dneWiXonBkmAsI4iVDu7A9+fVdo+o=;
        b=Zlv61aY4URxV6VQUCKZ0iWm2UbDEajL8lcU6fJoVo4PB5RGW60jAj5aB4Ko2Hts136
         CTkPuzYfFttcq9KyMNXEjk9l/B1Wl0UXBLND6Ft7fDrtpg3OTIn5oJesv9SsudV8qGV/
         W29ctmdjN34G3gieNJHEXbk+75ZYs+oxwiRk3VYOqqGnfodSUBOeOxDLr4JS0Jw+g9EW
         Ohhw2DrnsuaTpAEHR9htmorxl61vojU3TZpc4hg+ILiAH7ooVC2Gn6rsng/+uaYE9O9x
         5QCoUBAf/8nyxJhTaUIE9059MlrpoOeFFp6Q5aLdmpZ4oILnaKL10FVojn/52h2x1mhq
         Wkbw==
X-Forwarded-Encrypted: i=1; AJvYcCVutNsYijMpw2pGZORXaanvv5f+KVUTqeTp5YQn2WyDDbNvpMuAFURC9EO2maXrGcVPxjruIYTLn46+Pw7W@vger.kernel.org
X-Gm-Message-State: AOJu0YzeceFJAViFwe7LW9VZByGOzvMeMiHT2HlN4a8imxQ93YPXNIDO
	Mbdti5PafV/o2TtL1wDMWKudicj8I0zCEgUBqcOHobHm/TjmA6KaIggN1ywWWu/nHBVk7ouJR0L
	CMzUdqK0y55gP7FbcVvJo49S2yKFGPuSc/wELpz6NrD1nPBn2mvlWLc4PzjE=
X-Google-Smtp-Source: AGHT+IHUieZUH6jOwhgq7Ra47fjESi7n3L8KVFsqYLl9NuheC0NoYyiIhox6qK4DPZyyKDGvTIP6e+1d+P7Ex7vyhHgbZz7IilrL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4896:b0:864:657e:caec with SMTP id
 ca18e2360f4ac-86cbb88d3f7mr1091862439f.10.1748353474180; Tue, 27 May 2025
 06:44:34 -0700 (PDT)
Date: Tue, 27 May 2025 06:44:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6835c1c2.a70a0220.253bc2.00b8.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in send_sigio
From: syzbot <syzbot+c92740e8b0e38efece9d@syzkaller.appspotmail.com>
To: amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5723cc3450bc Merge tag 'dmaengine-fix-6.15' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148a12d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea35e429f965296e
dashboard link: https://syzkaller.appspot.com/bug?extid=c92740e8b0e38efece9d
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68366eed8771/disk-5723cc34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd760cf09e4a/vmlinux-5723cc34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d909adbad7f/bzImage-5723cc34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c92740e8b0e38efece9d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
BUG: KASAN: slab-use-after-free in _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
Read of size 1 at addr ffff88807b547520 by task syz.9.317/9218

CPU: 1 UID: 0 PID: 9218 Comm: syz.9.317 Not tainted 6.15.0-rc6-syzkaller-00346-g5723cc3450bc #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xb4/0x290 mm/kasan/report.c:521
 kasan_report+0x118/0x150 mm/kasan/report.c:634
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:557
 kasan_check_byte include/linux/kasan.h:399 [inline]
 lock_acquire+0x8d/0x360 kernel/locking/lockdep.c:5840
 __raw_read_lock_irqsave include/linux/rwlock_api_smp.h:160 [inline]
 _raw_read_lock_irqsave+0xaf/0x100 kernel/locking/spinlock.c:236
 send_sigio+0x38/0x370 fs/fcntl.c:907
 dnotify_handle_event+0x169/0x440 fs/notify/dnotify/dnotify.c:113
 fsnotify_handle_event fs/notify/fsnotify.c:350 [inline]
 send_to_group fs/notify/fsnotify.c:424 [inline]
 fsnotify+0x1671/0x1a80 fs/notify/fsnotify.c:641
 __fsnotify_parent+0x3fe/0x540 fs/notify/fsnotify.c:287
 do_sendfile+0x558/0x7d0 fs/read_write.c:1381
 __do_sys_sendfile64 fs/read_write.c:1429 [inline]
 __se_sys_sendfile64+0x13e/0x190 fs/read_write.c:1415
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2e0918e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2e06ff6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f2e093b5fa0 RCX: 00007f2e0918e969
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000007
RBP: 00007f2e09210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000fffa83 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2e093b5fa0 R15: 00007ffee7bcf658
 </TASK>

Allocated by task 9218:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x230/0x3d0 mm/slub.c:4358
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 file_f_owner_allocate+0x7e/0x110 fs/fcntl.c:103
 fcntl_dirnotify+0x207/0x690 fs/notify/dnotify/dnotify.c:318
 do_fcntl+0x6c7/0x1910 fs/fcntl.c:539
 __do_sys_fcntl fs/fcntl.c:591 [inline]
 __se_sys_fcntl+0xc8/0x150 fs/fcntl.c:576
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 9217:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x62/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2380 [inline]
 slab_free mm/slub.c:4642 [inline]
 kfree+0x193/0x440 mm/slub.c:4841
 __fput+0x53f/0xa70 fs/file_table.c:471
 task_work_run+0x1d4/0x260 kernel/task_work.c:227
 resume_user_mode_work+0x5e/0x80 include/linux/resume_user_mode.h:50
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x9a/0x120 kernel/entry/common.c:218
 do_syscall_64+0x103/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807b547500
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 32 bytes inside of
 freed 96-byte region [ffff88807b547500, ffff88807b547560)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b547
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801a041280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5823, tgid 5823 (syz-executor), ts 94438608453, free_ts 94438238312
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1d8/0x230 mm/page_alloc.c:1714
 prep_new_page mm/page_alloc.c:1722 [inline]
 get_page_from_freelist+0x21c7/0x22a0 mm/page_alloc.c:3684
 __alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:4966
 alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2301
 alloc_slab_page mm/slub.c:2450 [inline]
 allocate_slab+0x8a/0x3b0 mm/slub.c:2618
 new_slab mm/slub.c:2672 [inline]
 ___slab_alloc+0xbfc/0x1480 mm/slub.c:3858
 __slab_alloc mm/slub.c:3948 [inline]
 __slab_alloc_node mm/slub.c:4023 [inline]
 slab_alloc_node mm/slub.c:4184 [inline]
 __kmalloc_cache_node_noprof+0x29a/0x3d0 mm/slub.c:4366
 kmalloc_node_noprof include/linux/slab.h:928 [inline]
 __get_vm_area_node+0x13f/0x300 mm/vmalloc.c:3127
 __vmalloc_node_range_noprof+0x2f1/0x12c0 mm/vmalloc.c:3805
 __vmalloc_node_noprof mm/vmalloc.c:3908 [inline]
 vzalloc_noprof+0x79/0x90 mm/vmalloc.c:3981
 alloc_counters+0xd3/0x6d0 net/ipv4/netfilter/ip_tables.c:799
 copy_entries_to_user net/ipv4/netfilter/ip_tables.c:821 [inline]
 get_entries net/ipv4/netfilter/ip_tables.c:1022 [inline]
 do_ipt_get_ctl+0xaac/0x1180 net/ipv4/netfilter/ip_tables.c:1668
 nf_getsockopt+0x26e/0x290 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x1c4/0x220 net/ipv4/ip_sockglue.c:1777
 do_sock_getsockopt+0x35d/0x650 net/socket.c:2357
 __sys_getsockopt net/socket.c:2386 [inline]
 __do_sys_getsockopt net/socket.c:2393 [inline]
 __se_sys_getsockopt net/socket.c:2390 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2390
page last free pid 5823 tgid 5823 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1258 [inline]
 __free_frozen_pages+0xb05/0xcd0 mm/page_alloc.c:2721
 vfree+0x1a6/0x330 mm/vmalloc.c:3384
 copy_entries_to_user net/ipv4/netfilter/ip_tables.c:866 [inline]
 get_entries net/ipv4/netfilter/ip_tables.c:1022 [inline]
 do_ipt_get_ctl+0xebc/0x1180 net/ipv4/netfilter/ip_tables.c:1668
 nf_getsockopt+0x26e/0x290 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x1c4/0x220 net/ipv4/ip_sockglue.c:1777
 do_sock_getsockopt+0x35d/0x650 net/socket.c:2357
 __sys_getsockopt net/socket.c:2386 [inline]
 __do_sys_getsockopt net/socket.c:2393 [inline]
 __se_sys_getsockopt net/socket.c:2390 [inline]
 __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2390
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807b547400: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff88807b547480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88807b547500: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                               ^
 ffff88807b547580: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807b547600: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
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

