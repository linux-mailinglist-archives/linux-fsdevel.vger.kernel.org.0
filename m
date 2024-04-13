Return-Path: <linux-fsdevel+bounces-16852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3218A3BAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 10:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C811C2117A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577E0208B8;
	Sat, 13 Apr 2024 08:40:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DB1C2BD
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712997607; cv=none; b=dBcNkEdnL94HKtdq6pJlLCjBQMtsBYa/ep0gv7t4X+CBIX+Ifu6ndRaGbwPcpcKwwsAneqWL6HvvKmdnqbmGxZla+bRS+5fR25sLPWZC/3svYcp6WWXN0xMqfWNDgvgPAda9+4EPYVOhqPcP8rSEcjlOYf5Sl7Ii3Ed3MLE3v2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712997607; c=relaxed/simple;
	bh=27E8P3ZBsL14S2aSLpKktIVWxSqGjTwZl3jtfttXV6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EXKnCDPxlrTwGn0udfQV7ctKz+m08iuTwBW3kFkyy++J7K4scg0psCfzWRtA0uaezALUpciPsOiusEWE8tYiT9euIysKi0xDJGb8n0mGHPcVdPE3kdtg3hY9qnIO+3pYBOc+dsCtOhm5RxBYIiMkKluR0YRGvG8eBWK2GSkBIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a38d56655so18795515ab.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 01:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712997604; x=1713602404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaD6rHnRr+UO0RDt+hXRIVWhn0L9J1aYEKiuKo/SxRY=;
        b=f3jW7wsRw6tBkJixKfcUIn1gKzNIn6iJ7XYB0i52dN6V7VezPMCtUc9x9ILlt6Kmu9
         WnlZUfsaOG47HINJgJaxEda52kZVgiOO2pVvJrai9zUTuj+yy09n16U09bfPC2qNoglk
         sd8uEpE7jorWOqC+0Rpj48gWRqanbhI54/aYazSFVTlHKZeLUOWIwTXwcGwLNrR7aYDz
         p+9erapDXVnuldL9EW0SA6D4uiMIi+gOmCub8smxf2ii6bMd/AKoZzgZEOeJUMLTpJm+
         hlLs44ivbB/rxJx/CihArwfFghaWBz/uyLhzPmrtBmSFA5vne1iZ6FBIrlfYb2sgcQtK
         uSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5IUL4vR6n7OttASyojtpJOmK6oG/45T7ntZIe+G3vRrmzWttHMozdeugpBkDjO6lRKOab1/AXkLMavOz8m/TCuk673zHMjB3S2hp3w==
X-Gm-Message-State: AOJu0YzRctZN1j9guGecepBLzhhmCSj2yCTf1vyzWBzfVdO0SkUe+rZE
	v8FRPlmyfkw0qHUSVUIVxmGEnMTuYs3IsyQLr9xk9UnqdSPDmijmfR1TACFB83Mx+WhweTu3ekA
	BU3ZjrllbAhlCucsfWeSDiUPEw9QLsl8B2x2+7XgZLFKTPwxQuYLTtac=
X-Google-Smtp-Source: AGHT+IFIUS3JLgFYhJNu8QZ/gjsE+yL74gjM7TpYOk20YJBNz95Fsv8N/1o5bFhbgZVF3Y6CP8Q32y5Z67FyjtLBNM3/7VFYHDLg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:36a:3fb0:c96b with SMTP id
 h11-20020a056e021d8b00b0036a3fb0c96bmr389961ila.1.1712997604775; Sat, 13 Apr
 2024 01:40:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 01:40:04 -0700
In-Reply-To: <20240413014033.1722-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbf1d90615f65592@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in fsnotify

Quota error (device loop0): do_check_range: Getting block 0 out of range 1-5
EXT4-fs error (device loop0): ext4_release_dquot:6905: comm kworker/u8:4: Failed to release dquot type 1
==================================================================
BUG: KASAN: slab-use-after-free in fsnotify+0x3e5/0x1f00 fs/notify/fsnotify.c:541
Read of size 8 at addr ffff88802d133300 by task kworker/u8:4/62

CPU: 0 PID: 62 Comm: kworker/u8:4 Not tainted 6.9.0-rc3-next-20240410-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound quota_release_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 fsnotify+0x3e5/0x1f00 fs/notify/fsnotify.c:541
 fsnotify_sb_error include/linux/fsnotify.h:456 [inline]
 __ext4_error+0x255/0x3b0 fs/ext4/super.c:843
 ext4_release_dquot+0x326/0x450 fs/ext4/super.c:6903
 quota_release_workfn+0x39f/0x650 fs/quota/dquot.c:840
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5511:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace_noprof+0x19c/0x2b0 mm/slub.c:4109
 kmalloc_noprof include/linux/slab.h:660 [inline]
 kzalloc_noprof include/linux/slab.h:775 [inline]
 fsnotify_attach_info_to_sb fs/notify/mark.c:600 [inline]
 fsnotify_add_mark_list fs/notify/mark.c:692 [inline]
 fsnotify_add_mark_locked+0x3b2/0xe60 fs/notify/mark.c:777
 fanotify_add_new_mark fs/notify/fanotify/fanotify_user.c:1267 [inline]
 fanotify_add_mark+0xbbd/0x1330 fs/notify/fanotify/fanotify_user.c:1334
 do_fanotify_mark+0xbcc/0xd90 fs/notify/fanotify/fanotify_user.c:1896
 __do_sys_fanotify_mark fs/notify/fanotify/fanotify_user.c:1919 [inline]
 __se_sys_fanotify_mark fs/notify/fanotify/fanotify_user.c:1915 [inline]
 __x64_sys_fanotify_mark+0xb5/0xd0 fs/notify/fanotify/fanotify_user.c:1915
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5442:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kfree+0x149/0x350 mm/slub.c:4514
 fsnotify_sb_delete+0x692/0x6f0 fs/notify/fsnotify.c:106
 generic_shutdown_super+0xa5/0x2d0 fs/super.c:632
 kill_block_super+0x44/0x90 fs/super.c:1675
 ext4_kill_sb+0x68/0xa0 fs/ext4/super.c:7323
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802d133300
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88802d133300, ffff88802d133320)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802d133180 pfn:0x2d133
flags: 0xfff80000000200(workingset|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000200 ffff888015041500 ffffea00007c7590 ffffea0001aa96d0
raw: ffff88802d133180 000000000040003d 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 177503641 (swapper/0), ts 1, free_ts 13042593494
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2259
 allocate_slab+0x5a/0x2e0 mm/slub.c:2422
 new_slab mm/slub.c:2475 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
 __slab_alloc+0x58/0xa0 mm/slub.c:3714
 __slab_alloc_node mm/slub.c:3767 [inline]
 slab_alloc_node mm/slub.c:3945 [inline]
 __do_kmalloc_node mm/slub.c:4077 [inline]
 kmalloc_node_track_caller_noprof+0x286/0x440 mm/slub.c:4098
 __do_krealloc mm/slab_common.c:1190 [inline]
 krealloc_noprof+0x7d/0x120 mm/slab_common.c:1223
 add_sysfs_param+0x137/0x7f0 kernel/params.c:663
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x248/0x880 init/main.c:1263
 do_initcall_level+0x157/0x210 init/main.c:1325
 do_initcalls+0x3f/0x80 init/main.c:1341
page last free pid 782 tgid 782 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2601
 vfree+0x186/0x2e0 mm/vmalloc.c:3338
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:3259
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff88802d133200: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88802d133280: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
>ffff88802d133300: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                   ^
 ffff88802d133380: 00 00 00 fc fc fc fc fc 00 00 00 04 fc fc fc fc
 ffff88802d133400: 00 00 00 fc fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================


Tested on:

commit:         6ebf211b Add linux-next specific files for 20240410
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c3ac7d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662
dashboard link: https://syzkaller.appspot.com/bug?extid=5e3f9b2a67b45f16d4e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165b0243180000


