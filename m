Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A659E64F976
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Dec 2022 15:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLQOmg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Dec 2022 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLQOmf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:42:35 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE2110FD0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 06:42:34 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso2464118ioh.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Dec 2022 06:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMGieSaukOiZ2Q8PrYXHoxg+WhbcWSuDy0RoRWn1Bxw=;
        b=GYVio+GaYKuM/6PJca8Qw29c9aqTUW8QGNhoaB6mm+eptvs35m0dvuO4ZXJAVP4h3z
         wPKA6UE61hdVgqWw5YxSkEJN3j30kiIGVRpSBLDMiLURlgvDYiAThnCur7CwLq5iqgYy
         AIWECRefIHND/epx3VXE/WYxEV/to/v0C8fDM0m7bxewB4RXhXTt0t2nfrCro/+hL4OX
         Oe6nyI2V6aA6/H9IOOSmiAa5nlEODI3kK+k2GwmeiF6aCgRs+7Z3YeyFx5Z8kXpoel9f
         /YTD95S7c4S6SUOCtycRMDGfsrU2BMVDRS1yGnBXr1ouje2BnpkpNt37JctA0RU93yJN
         WLfw==
X-Gm-Message-State: ANoB5pnTNA2M0UZXl50ihQBYFlwVc9b3fmQIyJXMTiKax49LaOmWo/5x
        fkSDlaV44j8b4huIlkyE3Cvu9KUTgyI4G4GV37adr+VAXlXf
X-Google-Smtp-Source: AA0mqf6T81tv4jCyDdppv7PQ+bQ2GrEPLR3W8EShlx9x+SiJ9+kxaE4puUeiLDu8v7PG6pYZsxD0Un1gN4GmgNNCu6yaRGG8VvVN
MIME-Version: 1.0
X-Received: by 2002:a02:2417:0:b0:376:e17:5eaf with SMTP id
 f23-20020a022417000000b003760e175eafmr47044523jaa.56.1671288154097; Sat, 17
 Dec 2022 06:42:34 -0800 (PST)
Date:   Sat, 17 Dec 2022 06:42:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be147305f0071869@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in hfs_cat_keycmp
From:   syzbot <syzbot+883fa6a25abf9dd035ef@syzkaller.appspotmail.com>
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

HEAD commit:    3a28c2c89f4b Merge tag 'unsigned-char-6.2-for-linus' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12253e3b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f3de84cba2ef4a23
dashboard link: https://syzkaller.appspot.com/bug?extid=883fa6a25abf9dd035ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1261813b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114306af880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9374b222f430/disk-3a28c2c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/161c182658ff/vmlinux-3a28c2c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da0159b90f5a/bzImage-3a28c2c8.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/07b3c29e7ecc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+883fa6a25abf9dd035ef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in hfs_strcmp+0x147/0x170 fs/hfs/string.c:84
Read of size 1 at addr ffff8880204501ce by task kworker/u4:5/1091

CPU: 0 PID: 1091 Comm: kworker/u4:5 Not tainted 6.1.0-syzkaller-00071-g3a28c2c89f4b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 hfs_strcmp+0x147/0x170 fs/hfs/string.c:84
 hfs_cat_keycmp+0x17d/0x1d0 fs/hfs/catalog.c:181
 __hfs_brec_find+0x1d0/0x4d0 fs/hfs/bfind.c:75
 hfs_brec_find+0x202/0x4e0 fs/hfs/bfind.c:138
 hfs_write_inode+0x349/0x980 fs/hfs/inode.c:462
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1652
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1878
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2052
 wb_do_writeback fs/fs-writeback.c:2195 [inline]
 wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2235
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 1091:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0x5a/0xd0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:569 [inline]
 hfs_find_init+0x95/0x240 fs/hfs/bfind.c:21
 hfs_write_inode+0x225/0x980 fs/hfs/inode.c:457
 write_inode fs/fs-writeback.c:1440 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1652
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1878
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2052
 wb_do_writeback fs/fs-writeback.c:2195 [inline]
 wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2235
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888020450180
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 78 bytes inside of
 96-byte region [ffff888020450180, ffff8880204501e0)

The buggy address belongs to the physical page:
page:ffffea0000811400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20450
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00005f3e40 dead000000000002 ffff888012041780
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 9, tgid 9 (kworker/u4:0), ts 7013039595, free_ts 7011439514
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4291
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5558
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x199/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:564 [inline]
 kzalloc include/linux/slab.h:700 [inline]
 blk_mq_alloc_ctxs block/blk-mq.c:3921 [inline]
 blk_mq_init_allocated_queue+0x1ad/0x1470 block/blk-mq.c:4162
 blk_mq_init_queue_data block/blk-mq.c:3982 [inline]
 blk_mq_init_queue+0xc7/0x150 block/blk-mq.c:3992
 scsi_alloc_sdev+0x852/0xd90 drivers/scsi/scsi_scan.c:335
 scsi_probe_and_add_lun+0x208b/0x34d0 drivers/scsi/scsi_scan.c:1183
 __scsi_scan_target+0x21f/0xda0 drivers/scsi/scsi_scan.c:1665
 scsi_scan_channel drivers/scsi/scsi_scan.c:1753 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1729
 scsi_scan_host_selected+0x2e3/0x3b0 drivers/scsi/scsi_scan.c:1782
 do_scsi_scan_host+0x1e8/0x260 drivers/scsi/scsi_scan.c:1921
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0x176/0xc40 mm/page_alloc.c:3529
 release_pages+0xc8a/0x1360 mm/swap.c:1055
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:59
 tlb_flush_mmu_free mm/mmu_gather.c:254 [inline]
 tlb_flush_mmu mm/mmu_gather.c:261 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:361
 exit_mmap+0x202/0x7b0 mm/mmap.c:3096
 __mmput+0x128/0x4c0 kernel/fork.c:1185
 mmput+0x60/0x70 kernel/fork.c:1207
 free_bprm+0x65/0x2e0 fs/exec.c:1486
 kernel_execve+0x3fe/0x500 fs/exec.c:2004
 call_usermodehelper_exec_async+0x2e7/0x580 kernel/umh.c:113
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff888020450080: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888020450100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff888020450180: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff888020450200: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888020450280: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
