Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2C7AE7FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 10:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjIZI1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjIZI1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:27:44 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F208120
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 01:27:38 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1bf2e81ce17so18307599fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 01:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695716857; x=1696321657;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55XKxYhpepqWXUdY7SuK9vUe13bL5ShqPzIX2cS2KNs=;
        b=SDlNFDf2AQ9X1WbSGgBjoh80zuHWVNjTE1zDk/Ev55dmDA2K1jgG9G2Os0VK4wrz5O
         6KfDSA5fYS8D0R82ZuWDfGoB4ofgM6MBkcmtUzTxJxoTRMSyEO/4Sd2zAkja7GYT/jHb
         El+YTceTBDELb+kBkfkg7YUQUGYAMM3p9kYPCd6EsQpg93g6S0Wgn0wAzg8iJGZz7HjT
         1jo0am8LkLxMZ9QSg+K/SWgjOCwhA0K03h9KyoJFqvDpgs5th1L/KvUf4Ed4b4zcUDs1
         pSy+1UMfXx712vfIG/taUZ43suw3xA7+k6XEc7fVlGmRySczdahz+PT9Srnh45ak99WY
         9JkQ==
X-Gm-Message-State: AOJu0YxmfpKq2WcB8MgD5USi0tlEC10Byl+cnitzJdhAiTOsQ7TmBiNX
        taz0PeccMK1CXBnO/O4dTmP0uGQtmtmgEjrEdmPquLwKcVrg
X-Google-Smtp-Source: AGHT+IHn/Dc/iL1JhzuZy+gkTzxi+2Gj1EIRYbTwKpYUVoI17DDiTdctf9ir0JVL7V+W6jSBeYgPBPEFyMn6IybRoiAg8pBmepr1
MIME-Version: 1.0
X-Received: by 2002:a05:6870:a88f:b0:1d6:92f5:c1d2 with SMTP id
 eb15-20020a056870a88f00b001d692f5c1d2mr4416177oab.11.1695716857558; Tue, 26
 Sep 2023 01:27:37 -0700 (PDT)
Date:   Tue, 26 Sep 2023 01:27:37 -0700
In-Reply-To: <0000000000006777d506051db4fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef3b8a06063ed805@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in ntfs_write_bh
From:   syzbot <syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6465e260f487 Linux 6.6-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d78ffe680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb54ecdfa197f132
dashboard link: https://syzkaller.appspot.com/bug?extid=bc79f8d1898960d41073
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aa4e32680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171787b6680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b1a49bae59d/disk-6465e260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3226aa54969/vmlinux-6465e260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/225ee050173e/bzImage-6465e260.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/c217b59cb3bd/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/11dc567a19b3/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc79f8d1898960d41073@syzkaller.appspotmail.com

ntfs3: loop0: ino=0, attr_set_size
ntfs3: loop0: Mark volume as dirty due to NTFS errors
==================================================================
BUG: KASAN: slab-use-after-free in ntfs_write_bh+0x6b9/0x6e0 fs/ntfs3/fsntfs.c:1401
Read of size 8 at addr ffff888016aaa000 by task syz-executor201/5400

CPU: 1 PID: 5400 Comm: syz-executor201 Not tainted 6.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 ntfs_write_bh+0x6b9/0x6e0 fs/ntfs3/fsntfs.c:1401
 mi_write+0xc0/0x1e0 fs/ntfs3/record.c:346
 ni_write_inode+0x1025/0x2810 fs/ntfs3/frecord.c:3360
 write_inode fs/fs-writeback.c:1456 [inline]
 __writeback_single_inode+0xa81/0xe70 fs/fs-writeback.c:1668
 writeback_single_inode+0x2af/0x590 fs/fs-writeback.c:1724
 sync_inode_metadata+0xa5/0xe0 fs/fs-writeback.c:2786
 ntfs_set_state+0x3f0/0x6e0 fs/ntfs3/fsntfs.c:995
 attr_set_size+0x139c/0x2ca0 fs/ntfs3/attrib.c:866
 ntfs_extend_mft+0x29f/0x430 fs/ntfs3/fsntfs.c:527
 ntfs_look_free_mft+0x777/0xdd0 fs/ntfs3/fsntfs.c:590
 ni_create_attr_list+0x937/0x1520 fs/ntfs3/frecord.c:876
 ni_ins_attr_ext+0x23f/0xaf0 fs/ntfs3/frecord.c:974
 ni_insert_attr+0x310/0x870 fs/ntfs3/frecord.c:1141
 ni_insert_resident+0xd2/0x3a0 fs/ntfs3/frecord.c:1525
 ntfs_set_ea+0xf46/0x13d0 fs/ntfs3/xattr.c:437
 ntfs_save_wsl_perm+0x134/0x3d0 fs/ntfs3/xattr.c:946
 ntfs3_setattr+0x92e/0xb20 fs/ntfs3/file.c:708
 notify_change+0x742/0x11c0 fs/attr.c:499
 chown_common+0x596/0x660 fs/open.c:783
 do_fchownat+0x140/0x1f0 fs/open.c:814
 __do_sys_lchown fs/open.c:839 [inline]
 __se_sys_lchown fs/open.c:837 [inline]
 __x64_sys_lchown+0x7e/0xc0 fs/open.c:837
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0958017a59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0957fd4218 EFLAGS: 00000246 ORIG_RAX: 000000000000005e
RAX: ffffffffffffffda RBX: 00007f09580be6a8 RCX: 00007f0958017a59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000080
RBP: 00007f09580be6a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f09580be6ac
R13: 00007f095808b4ac R14: 0032656c69662f2e R15: 00007f095806c0c0
 </TASK>

Allocated by task 5038:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1023 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2a3/0x3b0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa8/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x6a/0xe0 security/security.c:2836
 do_dentry_open+0x538/0x1730 fs/open.c:916
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5038:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 tomoyo_realpath_from_path+0x1a6/0x710 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2a3/0x3b0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa8/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x6a/0xe0 security/security.c:2836
 do_dentry_open+0x538/0x1730 fs/open.c:916
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888016aaa000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 0 bytes inside of
 freed 4096-byte region [ffff888016aaa000, ffff888016aab000)

The buggy address belongs to the physical page:
page:ffffea00005aaa00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16aa8
head:ffffea00005aaa00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 3094771911, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2131
 alloc_pages+0x22a/0x270 mm/mempolicy.c:2293
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x340 mm/slub.c:3517
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kobject_uevent_env+0x24c/0x1800 lib/kobject_uevent.c:524
 kset_register+0x1b6/0x2a0 lib/kobject.c:873
 class_register+0x1cb/0x330 drivers/base/class.c:205
 ib_core_init+0xb9/0x300 drivers/infiniband/core/device.c:2780
 do_one_initcall+0x117/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x5c2/0x900 init/main.c:1547
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888016aa9f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888016aa9f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888016aaa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888016aaa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888016aaa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
