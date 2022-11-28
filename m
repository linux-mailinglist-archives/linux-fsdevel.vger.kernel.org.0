Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35D63A58F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 11:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiK1KBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 05:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiK1KBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:01:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5519C1C
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so8425476ild.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 02:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJ0zAetKM8xqYx9w6CjW4M0IZYfMI1Loa5QARS4sYzI=;
        b=1ijtnZU9ozfCfFVcysw4qLwcL6tAs0ddt+vUDt5yLTmJhDBRoMrq+WLx3bOfsOXvVX
         nZJMRWUfea20j8JN5iZRs//O4nzRUed8bb9f/PIeH6oqpYgRiotLIJWQ3TnIQ1/Unho5
         ILdSwxuS6LMMp/3TckdDdv/G2OwVFujXB5lDaRFfozBnVwaUmWbLM1qtvDNIBdSxfb94
         q42coiFg+ho3xPlyurmYLbMzCAflTOcWPJa6RAls5YGk0PcHMqXxKeND7so8aatY5oCa
         k4VEEE0AIFGvFxW+K1G5xCkQ1zBEHbEPbw3ZHxD8U4OnBU0xs0L0SCuhJtPVFazxgLF9
         Ky2w==
X-Gm-Message-State: ANoB5pmVOxaUPKEVkRZyN2dLK5lj/lciUtg1Nq5w5NCU50JubU1RB5Q1
        gK/ja3v/9DhG9duU5MdbxLxYsHQDlwI8sA/EfpLzKSu6Lkka
X-Google-Smtp-Source: AA0mqf6KXEH77nYqKL8zqlC58k8MYOZN4h73m0W4KxB7ArRGAhJb3jExXOrexCyHq5DNySvyseaIeM3u0mmdItZwHITHu4EufJNQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:485:b0:302:c316:caf3 with SMTP id
 b5-20020a056e02048500b00302c316caf3mr12850444ils.295.1669629698362; Mon, 28
 Nov 2022 02:01:38 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:01:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013d47505ee84f53f@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in __hfs_brec_find
From:   syzbot <syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13139a87880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=e836ff7133ac02be825f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a6d5bb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14212d8d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/97e079d270b2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e836ff7133ac02be825f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hfs_strcmp+0x117/0x190 fs/hfs/string.c:84
Read of size 1 at addr ffff88807eb62c4e by task kworker/u4:1/11

CPU: 1 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 hfs_strcmp+0x117/0x190 fs/hfs/string.c:84
 __hfs_brec_find+0x213/0x5c0 fs/hfs/bfind.c:75
 hfs_brec_find+0x276/0x520 fs/hfs/bfind.c:138
 hfs_write_inode+0x34c/0xb40 fs/hfs/inode.c:462
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2052
 wb_do_writeback fs/fs-writeback.c:2195 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2235
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 11:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 hfs_find_init+0x8b/0x1e0 fs/hfs/bfind.c:21
 hfs_write_inode+0x2e6/0xb40 fs/hfs/inode.c:457
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
 writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
 wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2052
 wb_do_writeback fs/fs-writeback.c:2195 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2235
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88807eb62c00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 78 bytes inside of
 96-byte region [ffff88807eb62c00, ffff88807eb62c60)

The buggy address belongs to the physical page:
page:ffffea0001fad880 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7eb62
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000620500 dead000000000004 ffff888012841780
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 2973, tgid 2973 (init), ts 13043103035, free_ts 13014326159
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x9e/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 tomoyo_get_name+0x225/0x550 security/tomoyo/memory.c:173
 tomoyo_assign_domain+0x369/0x7d0 security/tomoyo/domain.c:569
 tomoyo_find_next_domain+0xdfc/0x1d80 security/tomoyo/domain.c:847
 tomoyo_bprm_check_security+0xe3/0x130 security/tomoyo/tomoyo.c:101
 security_bprm_check+0x50/0xb0 security/security.c:869
 search_binary_handler fs/exec.c:1715 [inline]
 exec_binprm fs/exec.c:1768 [inline]
 bprm_execve+0x817/0x1590 fs/exec.c:1837
 do_execveat_common+0x598/0x750 fs/exec.c:1942
 do_execve fs/exec.c:2016 [inline]
 __do_sys_execve fs/exec.c:2092 [inline]
 __se_sys_execve fs/exec.c:2087 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2087
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3529
 release_pages+0x232a/0x25c0 mm/swap.c:1055
 tlb_batch_pages_flush mm/mmu_gather.c:59 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:256 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:263
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
 exit_mmap+0x275/0x630 mm/mmap.c:3105
 __mmput+0x114/0x3b0 kernel/fork.c:1185
 exit_mm+0x1f5/0x2d0 kernel/exit.c:516
 do_exit+0x5e7/0x2070 kernel/exit.c:807
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807eb62b00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807eb62b80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff88807eb62c00: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff88807eb62c80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807eb62d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
