Return-Path: <linux-fsdevel+bounces-13385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A286F3E3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 08:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B031C20FC3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 07:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED04945A;
	Sun,  3 Mar 2024 07:29:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B58F45
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709450965; cv=none; b=MQeASHjWFHT0XLnUt9P6LFZ9PFklgbZrukeCuMkZp2f160EwVAYfLeTAnEKC8ZyvOFeKUxGyZcxwANQW+n9rFF5KFqHvDmpDEBv+7rMSbAeJWaOst/MRwwUP+5SB7TgFf7TsMXlQU31R9YtD1F+FHTCA0e6WfJ6DgAFm4IBHZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709450965; c=relaxed/simple;
	bh=eDBWNXGkt2HNREgys8jr4BggHD/fWJwl1femLaqyBOA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=erBeJ9Kbssxwx2Yqe8sqdBbDTjElEIpXLMNo6s84eLD0if+kjzEpYawq6D2dH0H/k7yocv6V8spk0MIPseMnOpKGzvT4gG56N6JQizAraaK5bmX0k3MtqF9h5bPsBLSJZQ72knTpaMKCLZ+HqYLab6eTWkl+RhpgF7hx1ZMf3Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3650bfcb2bfso27967145ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 23:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709450963; x=1710055763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uu6uL8Rs3cLGC6BUug8X2PqA1JlhV50xGJasY/lk9uk=;
        b=gA6jdfmhzMiiuhpbJp3G2bNBQOyomhRleK0fMnT3gler4TLIhjicenB1SIngqcFtKB
         Hsov63q484WcGArpxEav5iXn0IsnvJsSlMOr7MQIW0XCk9BTcNLbcC/V0sBZwaql2kKt
         XT3lKcDbP3NIn2ApRCkuN2ESIE8KpDuJyh0ZeVmQqyBK0/7tMHMdGfuDKlqKfaELAxXv
         atDtkOZESBaI+9EW7Jp3bdIGC0HJZnSIXg0hFTs5pCXB4u9C5yhWht2JmNvcCtKNiL7h
         Hvuh0iRI4D18ChUBS4AwV/S5Cg5tvLeuVG60XWbDLJ2/crGL9rRZTR9svTwlgAfrGbwj
         P5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUINcFh0kKZGlY25T8qz/RFIc/zt4D2SkrEJLlJcilFm+fxav0VAuaBg5vgPLmh2fp7ex7Po7WwMS8Zg+6IvGzaYnVAuUNse1dkUFQU6g==
X-Gm-Message-State: AOJu0YyEe5AmbhdsppixzuXGWrTQFE8d2CnpcgXlun8SvbciCJy+tHV6
	+VEK0c2YylLxy+tuv4YKMqFD1uLr8zBoQbKGtwf01XEcs3b5rj0QyF4A6nm+ayjhJVouNyBR5fY
	VmTJBx1M7GtCb6pHXRCpHIEzjFydR7DbL+CWpTuliEhkfK0IfXQJlc2o=
X-Google-Smtp-Source: AGHT+IFZbzZwb0TLQcn4KoKpPXqt+t2XpYoJlQeGbo1o6Cj9irEv2sR9cGJxnCWMM3vBgPmm+mb/CDnhGPLJrhPsV2JdCke/jiNi
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:365:c659:5916 with SMTP id
 k6-20020a92c246000000b00365c6595916mr362761ilo.0.1709450963007; Sat, 02 Mar
 2024 23:29:23 -0800 (PST)
Date: Sat, 02 Mar 2024 23:29:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006945730612bc9173@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
From: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
To: bcrl@kvack.org, brauner@kernel.org, bvanassche@acm.org, jack@suse.cz, 
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5ad3cb0ed525 Merge tag 'for-v6.8-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e39306180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=b91eb2ed18f599dd3c31
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149defac180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13877412180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/16eec3abf3df/disk-5ad3cb0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a72615a6fd4/vmlinux-5ad3cb0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f728d92d6c1/bzImage-5ad3cb0e.xz

The issue was bisected to:

commit 54cbc058d86beca3515c994039b5c0f0a34f53dd
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Thu Feb 15 20:47:39 2024 +0000

    fs/aio: Make io_cancel() generate completions again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1748740e180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c8740e180000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c8740e180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com
Fixes: 54cbc058d86b ("fs/aio: Make io_cancel() generate completions again")

==================================================================
BUG: KASAN: slab-use-after-free in __do_sys_io_cancel fs/aio.c:2207 [inline]
BUG: KASAN: slab-use-after-free in __se_sys_io_cancel+0x2c7/0x2d0 fs/aio.c:2174
Read of size 4 at addr ffff88801f857020 by task syz-executor142/5065

CPU: 0 PID: 5065 Comm: syz-executor142 Not tainted 6.8.0-rc6-syzkaller-00238-g5ad3cb0ed525 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 __do_sys_io_cancel fs/aio.c:2207 [inline]
 __se_sys_io_cancel+0x2c7/0x2d0 fs/aio.c:2174
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f1c0c3bd3e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5ffcdc98 EFLAGS: 00000246 ORIG_RAX: 00000000000000d2
RAX: ffffffffffffffda RBX: 00007ffe5ffcde68 RCX: 00007f1c0c3bd3e9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 00007f1c0c349000
RBP: 00007f1c0c430610 R08: 00007ffe5ffcde68 R09: 00007ffe5ffcde68
R10: 00007ffe5ffcde68 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe5ffcde58 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5065:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 aio_get_req fs/aio.c:1060 [inline]
 io_submit_one+0x154/0x18b0 fs/aio.c:2050
 __do_sys_io_submit fs/aio.c:2113 [inline]
 __se_sys_io_submit+0x17f/0x300 fs/aio.c:2083
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 4812:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
 aio_poll_complete_work+0x467/0x670 fs/aio.c:1767
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:551
 insert_work+0x3e/0x330 kernel/workqueue.c:1653
 __queue_work+0xbf4/0x1000 kernel/workqueue.c:1802
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1837
 queue_work include/linux/workqueue.h:548 [inline]
 schedule_work include/linux/workqueue.h:609 [inline]
 aio_poll_cancel+0xbb/0x130 fs/aio.c:1779
 __do_sys_io_cancel fs/aio.c:2196 [inline]
 __se_sys_io_cancel+0x126/0x2d0 fs/aio.c:2174
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88801f857000
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 32 bytes inside of
 freed 216-byte region [ffff88801f857000, ffff88801f8570d8)

The buggy address belongs to the physical page:
page:ffffea00007e15c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f857
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff88801a6a9500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5065, tgid 5065 (syz-executor142), ts 69523425470, free_ts 63195641417
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc+0x24d/0x340 mm/slub.c:3867
 aio_get_req fs/aio.c:1060 [inline]
 io_submit_one+0x154/0x18b0 fs/aio.c:2050
 __do_sys_io_submit fs/aio.c:2113 [inline]
 __se_sys_io_submit+0x17f/0x300 fs/aio.c:2083
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 4504 tgid 4504 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 __slab_free+0x349/0x410 mm/slub.c:4211
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 getname_flags+0xbc/0x4f0 fs/namei.c:140
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1398
 do_sys_open fs/open.c:1419 [inline]
 __do_sys_openat fs/open.c:1435 [inline]
 __se_sys_openat fs/open.c:1430 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1430
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff88801f856f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801f856f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801f857000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801f857080: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
 ffff88801f857100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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

