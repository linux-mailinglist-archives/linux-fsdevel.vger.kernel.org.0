Return-Path: <linux-fsdevel+bounces-16714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAB58A1C54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCDD1C22EFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C4161326;
	Thu, 11 Apr 2024 16:17:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F9916C87E
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852262; cv=none; b=jXAcCOR2FuPq7/dxG8dCFTe+22wgvCnSRDPWvulkhmZb689mxVSd3AZPDaIHZuyh2WCDn1Sb0feD+eBkwt+EVrAe/o5VzBgJR9H0ZnkpKwpVG4MVP9Cqc3KN3YN2Uyy+aly9ejO6JG67BlX3QjpFL9KHzyNRy4tsCDbdcPok+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852262; c=relaxed/simple;
	bh=RtuHXctgfiOYrGiYfq+e/OTERtXigR4+wb783+m1Dp8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dFAjtUWyFQxNlxuBb9P0eizEV83wDyuMSrSbFqnhFC558aKrfTcR31SLbZ7M89v6hY56BJGH7tJoOxbiD1Y3FzjGZygqr5OkxBFMgU5kS981jcZq5lh/b1QOlpyBQWplb3YLUMpCZavoFH/HibRfzvza2yHg/UXWd1GZjAoPHKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a0f6b6348so128455ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 09:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712852256; x=1713457056;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1d7kQPd3I2BsF0hyHoGzV2RNfmF4ykWGkYznWmyDBko=;
        b=W4AqGKdGz9Lpv6o5Gw5zNLdEDnrC8EAXyv5O3JWCiwRjawRC+Qi3CTY8+Q++VlWZKu
         KBOJO+EMmr8OwHn5abwoyROd6Qcw8Z6nMPVuUPbQelonX7a9fkIPWg+63qxzWNJlW1HA
         k8Eg0wp/SWGisyJ47ICgNSCNGk7UstqsTo1Uu4u/XnrNyvpdzocM+WrGW07p8a+Pq0EG
         DagR7t88asCQFCuR/jvarQjgci8Df2V4qHIQshmkjvbMdXeKq91iovTikd70FkV5AMR/
         2H0v/khQwklD3PxGRrRU2ttPmJRNfOjI+AP7nDli+3cQz/SeFHYGXb3w+tMz4o6RjWfS
         XfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgiwz7NzjUgjdN7ZiYgX9QAaQ/G4uBTJy5vdKNe6n+u/IRCmj+tRTFVQJqPKFdT+ErGm841d2TmNogX+iUnNAWCnM1biPj6DoEqWFE9Q==
X-Gm-Message-State: AOJu0YzwNUeLRaGx3vgNGoienVoDnaF3GCrQ5961JnvOltjMCqxaLg7P
	NowFa4nNqAFDrdw89eBrFGC3aZfKSlPyy1M/BhClhAqzt3NNPLSLn4zw7mFYUtseK6XsFIwcXyp
	aS06y5Xhg5l7OveM1hNqToZL4Xo+xzseS3VZQb5yhS/VY0JYShb0mGxU=
X-Google-Smtp-Source: AGHT+IHv2a4kUISj8aISAEEpksJbCdjrcpVuiOr291qVbATDu1HYshEyLe1Jk8+7jNl/4NvppSY2vjK2El4KJcG04q6rYzgQ3OCz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:36a:20a2:e47b with SMTP id
 k6-20020a056e02156600b0036a20a2e47bmr406669ilu.6.1712852256636; Thu, 11 Apr
 2024 09:17:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:17:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f557c0615d47e6d@google.com>
Subject: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8c39d0f57f3 Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ce66a3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16892dcb180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130547bd180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-e8c39d0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d33b002ae0bf/vmlinux-e8c39d0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/047d0bfb2db7/bzImage-e8c39d0f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/749aec76707a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in gfs2_discard fs/gfs2/aops.c:617 [inline]
BUG: KASAN: slab-use-after-free in gfs2_invalidate_folio+0x718/0x820 fs/gfs2/aops.c:655
Read of size 8 at addr ffff88801db08168 by task syz-executor595/5186

CPU: 3 PID: 5186 Comm: syz-executor595 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 list_empty include/linux/list.h:373 [inline]
 gfs2_discard fs/gfs2/aops.c:617 [inline]
 gfs2_invalidate_folio+0x718/0x820 fs/gfs2/aops.c:655
 folio_invalidate mm/truncate.c:158 [inline]
 truncate_cleanup_folio+0x2ac/0x3e0 mm/truncate.c:178
 truncate_inode_pages_range+0x271/0xe90 mm/truncate.c:358
 gfs2_evict_inode+0x75b/0x1460 fs/gfs2/super.c:1508
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 gfs2_put_super+0x2bd/0x760 fs/gfs2/super.c:625
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe708777789
Code: Unable to access opcode bytes at 0x7fe70877775f.
RSP: 002b:00007ffd15e3f838 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007fe708777789
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 00007fe7088122b0 R08: ffffffffffffffb8 R09: 000000000001f6db
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe7088122b0
R13: 0000000000000000 R14: 00007fe708813020 R15: 00007fe708745cc0
 </TASK>

Allocated by task 5186:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_data+0x4b3/0x7f0 fs/gfs2/trans.c:209
 gfs2_unstuffer_folio fs/gfs2/bmap.c:81 [inline]
 __gfs2_unstuff_inode fs/gfs2/bmap.c:119 [inline]
 gfs2_unstuff_dinode+0xad9/0x1460 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa73/0xd30 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5186:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 trans_drain fs/gfs2/log.c:1028 [inline]
 gfs2_log_flush+0x1486/0x29b0 fs/gfs2/log.c:1167
 do_sync+0x550/0xd30 fs/gfs2/quota.c:1010
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa7d/0x2c10 kernel/exit.c:878
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801db08150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff88801db08150, ffff88801db081a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1db08
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff88801a5aedc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 5186, tgid 5186 (syz-executor595), ts 45296183443, free_ts 44935801807
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_meta+0xade/0xf50 fs/gfs2/trans.c:251
 gfs2_alloc_extent fs/gfs2/rgrp.c:2239 [inline]
 gfs2_alloc_blocks+0x46c/0x19c0 fs/gfs2/rgrp.c:2449
 __gfs2_unstuff_inode fs/gfs2/bmap.c:107 [inline]
 gfs2_unstuff_dinode+0x499/0x1460 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa73/0xd30 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
page last free pid 4684 tgid 4684 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 __put_partials+0x14c/0x170 mm/slub.c:2906
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9b/0xf0 include/linux/audit.h:322
 vfs_fstatat+0x9a/0x150 fs/stat.c:303
 __do_sys_newfstatat+0x98/0x120 fs/stat.c:468
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801db08000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff88801db08080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff88801db08100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff88801db08180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88801db08200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

