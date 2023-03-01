Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513126A77A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 00:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCAX34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 18:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCAX3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:29:53 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D414C6EF
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 15:29:51 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id k13-20020a5d9d4d000000b0074caed3a2d2so9988562iok.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Mar 2023 15:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhiQ0NPnixZ18d7XVcj1Niom7fwmeuEkVWBkWg6183g=;
        b=Fy4NmbiVaaY+K9XiUy8D4Y6POiB1R4xt894wLldD7xsiTIAqTq79w8dBjuI8DOd2P2
         ghkm4lDhSESOstRhX/MA2KnoxC2uHDfDg/uDlgWKdErP6//pNeI/c/qnUjKZTGUFMcdb
         Gk331Bi872pMKApaCKO+Tr1plMRFgIoSrHhF4kIduiTZMKBcNlWrhH1ez8WbyOsEiG5f
         C6CyRpYnUuf2V3r1YsY8xpbF7LHHOvDgUySVUJKu7K4BG3jBGAteRxt8sSGEpkK9zR3B
         rdATOUmeyk+OWekSz7mkVfHkeH9/1KnpriDV9KH43cR8ovEi0u7mby/A5bzj+ujL/Dj2
         BNZQ==
X-Gm-Message-State: AO0yUKWxpI8GdK4BrFfZsHgRLUqBdKvUaxusZk7n1Jh4v185plpHeRTN
        8Ol8v6r9wUfuNDfL7Ov92jqeMFMQffBztwBn7QlIxZyMtHzb
X-Google-Smtp-Source: AK7set/mO6KieVQvaPfhOZdYkS+PfkN337P/FcxV+jqzyznBAau/QrVL+3yra0uGRM1nJ7ufHoLvxroS8lMEc9xCCmJC4TkHuAD1
MIME-Version: 1.0
X-Received: by 2002:a02:3312:0:b0:3c4:dda2:da6e with SMTP id
 c18-20020a023312000000b003c4dda2da6emr3838091jae.4.1677713390630; Wed, 01 Mar
 2023 15:29:50 -0800 (PST)
Date:   Wed, 01 Mar 2023 15:29:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aefc5005f5df169b@google.com>
Subject: [syzbot] [ntfs?] KASAN: use-after-free Read in ntfs_attr_find (2)
From:   syzbot <syzbot+ef50f8eb00b54feb7ba2@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    489fa31ea873 Merge branch 'work.misc' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101dd650c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbfa7a73c540248d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef50f8eb00b54feb7ba2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145580a8c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1505a9f7480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6bea5d39bf58/disk-489fa31e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/265538df6fa2/vmlinux-489fa31e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f0a643c86ea/bzImage-489fa31e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b7a87da8b417/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef50f8eb00b54feb7ba2@syzkaller.appspotmail.com

ntfs: (device loop0): ntfs_end_buffer_async_read(): Buffer I/O error, logical block 0x4002.
syz-executor392: attempt to access beyond end of device
loop0: rw=0, sector=32774, nr_sectors = 2 limit=4096
ntfs: (device loop0): ntfs_end_buffer_async_read(): Buffer I/O error, logical block 0x4003.
ntfs: (device loop0): check_mft_mirror(): Failed to read $MFTMirr.
ntfs: (device loop0): load_system_files(): $MFTMirr does not match $MFT.  Will not be able to remount read-write.  Run ntfsfix and/or chkdsk.
==================================================================
BUG: KASAN: use-after-free in ntfs_attr_find+0x7d6/0xd50 fs/ntfs/attrib.c:609
Read of size 2 at addr ffff888074945152 by task syz-executor392/5071

CPU: 0 PID: 5071 Comm: syz-executor392 Not tainted 6.2.0-syzkaller-10827-g489fa31ea873 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x143/0x170 mm/kasan/report.c:536
 ntfs_attr_find+0x7d6/0xd50 fs/ntfs/attrib.c:609
 ntfs_attr_lookup+0x4e4/0x2390
 ntfs_read_locked_attr_inode fs/ntfs/inode.c:1239 [inline]
 ntfs_attr_iget+0x50a/0x2360 fs/ntfs/inode.c:238
 load_system_files+0x1333/0x4840 fs/ntfs/super.c:1808
 ntfs_fill_super+0x19b4/0x2bd0 fs/ntfs/super.c:2900
 mount_bdev+0x271/0x3a0 fs/super.c:1371
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3042
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd8fb0684fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 f8 03 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc35f01968 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd8fb0684fa
RDX: 000000002001f6c0 RSI: 000000002001f640 RDI: 00007ffc35f01970
RBP: 00007ffc35f01970 R08: 00007ffc35f019b0 R09: 000000000001f61d
R10: 0000000000008703 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555555fa63b8 R14: 00007ffc35f019b0 R15: 0000000000000000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001d25140 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x74945
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001d24dc8 ffffea0001d246c8 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 5071, tgid 5071 (syz-executor392), ts 54020629953, free_ts 54043005684
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x37e0/0x3970 mm/page_alloc.c:4325
 __alloc_pages+0x291/0x7f0 mm/page_alloc.c:5591
 __folio_alloc+0x13/0x30 mm/page_alloc.c:5623
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2244
 wp_page_copy mm/memory.c:3064 [inline]
 do_wp_page+0xb09/0x3620 mm/memory.c:3426
 handle_pte_fault mm/memory.c:4927 [inline]
 __handle_mm_fault mm/memory.c:5051 [inline]
 handle_mm_fault+0x23a0/0x51c0 mm/memory.c:5197
 do_user_addr_fault arch/x86/mm/fault.c:1407 [inline]
 handle_page_fault arch/x86/mm/fault.c:1498 [inline]
 exc_page_fault+0x685/0x8a0 arch/x86/mm/fault.c:1554
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare mm/page_alloc.c:1503 [inline]
 free_unref_page_prepare+0xf0e/0xf70 mm/page_alloc.c:3387
 free_unref_page_list+0x6be/0x960 mm/page_alloc.c:3528
 release_pages+0x219e/0x2470 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
 tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
 unmap_region+0x253/0x2a0 mm/mmap.c:2146
 do_vmi_align_munmap+0xba3/0x1200 mm/mmap.c:2395
 do_vmi_munmap+0x24a/0x2b0 mm/mmap.c:2452
 __vm_munmap+0x200/0x310 mm/mmap.c:2731
 __do_sys_munmap mm/mmap.c:2756 [inline]
 __se_sys_munmap mm/mmap.c:2753 [inline]
 __x64_sys_munmap+0x60/0x70 mm/mmap.c:2753
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888074945000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888074945080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888074945100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                 ^
 ffff888074945180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888074945200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
