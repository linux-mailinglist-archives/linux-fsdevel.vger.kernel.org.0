Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5E691F04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjBJMVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 07:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjBJMVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:21:51 -0500
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA538F74A
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 04:21:49 -0800 (PST)
Received: by mail-io1-f80.google.com with SMTP id d14-20020a05660225ce00b00734acc87739so3349898iop.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Feb 2023 04:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJnVo6GiiOg0ZPf0WIkzNgdFDfP24rpT6M3MYyDpW9A=;
        b=DuyGZLDx8AnG8dRU+YRZA+sElb9hecgGfkQEe+nKidD9dRzroexr7ms1J3etx8py3i
         unyBbYJkn8czThlXzyFF+GguHn7MOwn23CMnsgztQydRzjV553D8gcGmimbM/DQNDYJc
         P8OkiDhM1tAiyC6b6ZdhxNqLRn7G5T+0xkfclutZcb8/iMMhB+IGEaZfBmExPrgbXjZH
         5uDtzTu8C9oID3gXgwyE9bmSqRpB1GubiOjWzF9wZSRGI4PCwsaz7dv8J2O0d5ddqqZU
         fXb7OhVex5bMjTSXlWuuxsPFFoG1ku6uAwO21926uQSPZ6j1CzjfVxtcHiGP0L4TreAw
         1KeA==
X-Gm-Message-State: AO0yUKW/Djzh235N7KemVJjMkx4OoAYLgsUB15uozFx2bq74lQuCQBmB
        ETdOg5yL8CfgoYycbPKHi+XAGuKFl9N+e1AvFdRdhiFtbpji
X-Google-Smtp-Source: AK7set98R9Z2TDA/xUQK9168H/KNu7WugByGiaNfuN2YtMIUGD9dryMohEYLAsP4lTbXaDWJiCyWFN7HoAmkx0P85xtC0/xJ4txu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c2b:b0:30e:eb5d:d15d with SMTP id
 q11-20020a056e020c2b00b0030eeb5dd15dmr8935092ilg.88.1676031709046; Fri, 10
 Feb 2023 04:21:49 -0800 (PST)
Date:   Fri, 10 Feb 2023 04:21:49 -0800
In-Reply-To: <0000000000005ad04005ee48897f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a66c7705f4578aaa@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_revalidate_dentry
From:   syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    8c89ecf5c13b kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10b53fff480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91d3152219aa6b45
dashboard link: https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1409f0b3480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c76993480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa537cffb53c/disk-8c89ecf5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b9d03c04a3e/vmlinux-8c89ecf5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/55c166dec3af/bzImage-8c89ecf5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b234e4e5c704/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com

=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
=====================================================
BUG: KMSAN: uninit-value in hfs_ext_read_extent fs/hfs/extent.c:196 [inline]
BUG: KMSAN: uninit-value in hfs_get_block+0x92d/0x1620 fs/hfs/extent.c:366
 hfs_ext_read_extent fs/hfs/extent.c:196 [inline]
 hfs_get_block+0x92d/0x1620 fs/hfs/extent.c:366
 block_read_full_folio+0x4ff/0x11b0 fs/buffer.c:2271
 hfs_read_folio+0x55/0x60 fs/hfs/inode.c:39
 filemap_read_folio+0x148/0x4f0 mm/filemap.c:2426
 do_read_cache_folio+0x7c8/0xd90 mm/filemap.c:3553
 do_read_cache_page mm/filemap.c:3595 [inline]
 read_cache_page+0xfb/0x2f0 mm/filemap.c:3604
 read_mapping_page include/linux/pagemap.h:755 [inline]
 hfs_btree_open+0x928/0x1ae0 fs/hfs/btree.c:78
 hfs_mdb_get+0x260c/0x3000 fs/hfs/mdb.c:204
 hfs_fill_super+0x1fb1/0x2790 fs/hfs/super.c:406
 mount_bdev+0x628/0x920 fs/super.c:1359
 hfs_mount+0xcd/0xe0 fs/hfs/super.c:456
 legacy_get_tree+0x167/0x2e0 fs/fs_context.c:610
 vfs_get_tree+0xdc/0x5d0 fs/super.c:1489
 do_new_mount+0x7a9/0x16f0 fs/namespace.c:3145
 path_mount+0xf98/0x26a0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x919/0x9e0 fs/namespace.c:3674
 __ia32_sys_mount+0x15b/0x1b0 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x926/0x10a0 mm/page_alloc.c:5572
 alloc_pages+0xb4b/0xec0
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x5c5/0x19b0 mm/slub.c:2051
 ___slab_alloc+0x132b/0x3790 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x72f/0xb80 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 hfs_alloc_inode+0x80/0xf0 fs/hfs/super.c:165
 alloc_inode+0xad/0x4b0 fs/inode.c:259
 iget_locked+0x340/0xf80 fs/inode.c:1286
 hfs_btree_open+0x20d/0x1ae0 fs/hfs/btree.c:38
 hfs_mdb_get+0x2519/0x3000 fs/hfs/mdb.c:199
 hfs_fill_super+0x1fb1/0x2790 fs/hfs/super.c:406
 mount_bdev+0x628/0x920 fs/super.c:1359
 hfs_mount+0xcd/0xe0 fs/hfs/super.c:456
 legacy_get_tree+0x167/0x2e0 fs/fs_context.c:610
 vfs_get_tree+0xdc/0x5d0 fs/super.c:1489
 do_new_mount+0x7a9/0x16f0 fs/namespace.c:3145
 path_mount+0xf98/0x26a0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x919/0x9e0 fs/namespace.c:3674
 __ia32_sys_mount+0x15b/0x1b0 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 1 PID: 5015 Comm: syz-executor119 Not tainted 6.2.0-rc7-syzkaller-80760-g8c89ecf5c13b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
=====================================================

