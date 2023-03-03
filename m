Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326D56AA2D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjCCVv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 16:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjCCVtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:49:18 -0500
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCC467039
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Mar 2023 13:45:51 -0800 (PST)
Received: by mail-io1-xd45.google.com with SMTP id p188-20020a6b8dc5000000b0074c96ca271bso2078489iod.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Mar 2023 13:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=imuLu9SO+D8i258J/SyTaA2l+06SMEdt81hfYPO+LcE=;
        b=FqYPrweCUdM0CSZdF6xkBXL6wf2Jr5CaZrZ8y5k1W+ODqgigkGxYuGYcx3BLHEw+3o
         ffgO9mbd1gCjZOFDfPNniDthR20wEm2Cus8JwtrYfaavAVBQfkvRl8m+SApMfoOzk/ie
         /9Tc6sJPkA59HiyZTAG7xRBHV6dnrgq1lJsfqQ5prfCD2uzKOT2Asy1WgEEHUeLpfn+Y
         mCHjF7ZeT91j0O/C4iDmTpHJE5/0AecnGyAuACvP3qid8OffvFvvXlx/1lQ+4K7O6Cjx
         7gOMD7XJqPg15aZOah8rZL4y/lhuRCJaSg/U34tx4s2Gq/E/8Z2HWGloZSsBdXq+7X5l
         pC3g==
X-Gm-Message-State: AO0yUKUfqf7dMRtsPBdYKk+dUZx7x6szhTgyMMKZC/XMXRtgKLxs6AIo
        aO2o/VJ9FAvR4Qt0xbjKePe9DAT+UI05VAu8UropI2wn2E4w
X-Google-Smtp-Source: AK7set9YuSm2/pz0nTOVFSMkJevmjTlgfb6KKMvziPbawz4HeK5Hpw7Y6gGMGpvpG/znK7/nFAjJlsKSphU9NXAuvSj7Bi0zXBM0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:96c:b0:310:c810:44c0 with SMTP id
 q12-20020a056e02096c00b00310c81044c0mr1520188ilt.5.1677879817645; Fri, 03 Mar
 2023 13:43:37 -0800 (PST)
Date:   Fri, 03 Mar 2023 13:43:37 -0800
In-Reply-To: <000000000000ece18705f3b20934@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081b83a05f605d613@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_group_desc_csum
From:   syzbot <syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, joneslee@google.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        tudor.ambarus@linaro.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    596b6b709632 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1151054cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3519974f3f27816d
dashboard link: https://syzkaller.appspot.com/bug?extid=8785e41224a3afd04321
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ce3de4c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b02598c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/06e2210b88a3/disk-596b6b70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79e6930ab577/vmlinux-596b6b70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/56b95e6bcb5c/Image-596b6b70.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a765d6554060/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8785e41224a3afd04321@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in crc16+0xc0/0x104 lib/crc16.c:58
Read of size 1 at addr ffff0000d5eff0a8 by task syz-executor175/8245

CPU: 1 PID: 8245 Comm: syz-executor175 Not tainted 6.2.0-syzkaller-18302-g596b6b709632 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x174/0x4c0 mm/kasan/report.c:417
 kasan_report+0xd4/0x130 mm/kasan/report.c:517
 __asan_report_load1_noabort+0x2c/0x38 mm/kasan/report_generic.c:348
 crc16+0xc0/0x104 lib/crc16.c:58
 ext4_group_desc_csum+0x6a8/0x99c fs/ext4/super.c:3187
 ext4_group_desc_csum_set+0x17c/0x210 fs/ext4/super.c:3210
 __ext4_new_inode+0x20dc/0x3acc fs/ext4/ialloc.c:1227
 ext4_create+0x234/0x480 fs/ext4/namei.c:2809
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0xe6c/0x2578 fs/namei.c:3711
 do_filp_open+0x1bc/0x3cc fs/namei.c:3741
 do_sys_openat2+0x128/0x3d8 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Allocated by task 5961:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x80 mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:512
 __kasan_slab_alloc+0x74/0x8c mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook+0x80/0x478 mm/slab.h:761
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x288/0x37c mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 __kernfs_new_node+0xe4/0x66c fs/kernfs/dir.c:614
 kernfs_new_node+0x98/0x184 fs/kernfs/dir.c:676
 __kernfs_create_file+0x60/0x2d4 fs/kernfs/file.c:1047
 sysfs_add_file_mode_ns+0x1dc/0x298 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x428/0xbec fs/sysfs/group.c:148
 internal_create_groups fs/sysfs/group.c:188 [inline]
 sysfs_create_groups+0x60/0x130 fs/sysfs/group.c:214
 create_dir lib/kobject.c:68 [inline]
 kobject_add_internal+0x5d4/0xb14 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_init_and_add+0x130/0x1a0 lib/kobject.c:441
 netdev_queue_add_kobject net/core/net-sysfs.c:1666 [inline]
 netdev_queue_update_kobjects+0x1d8/0x470 net/core/net-sysfs.c:1718
 register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
 netdev_register_kobject+0x22c/0x2d8 net/core/net-sysfs.c:2019
 register_netdevice+0xcb8/0x1270 net/core/dev.c:10037
 bond_newlink+0x50/0xa8 drivers/net/bonding/bond_netlink.c:560
 rtnl_newlink_create net/core/rtnetlink.c:3407 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3624 [inline]
 rtnl_newlink+0x1174/0x1b1c net/core/rtnetlink.c:3637
 rtnetlink_rcv_msg+0x6ec/0xc8c net/core/rtnetlink.c:6141
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2574
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6159
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x660/0x8d4 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x800/0xae0 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 __sys_sendto+0x3b4/0x504 net/socket.c:2120
 __do_sys_sendto net/socket.c:2132 [inline]
 __se_sys_sendto net/socket.c:2128 [inline]
 __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2128
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x168 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

The buggy address belongs to the object at ffff0000d5eff000
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 0 bytes to the right of
 168-byte region [ffff0000d5eff000, ffff0000d5eff0a8)

The buggy address belongs to the physical page:
page:0000000016584f53 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x115eff
flags: 0x5ffc00000000200(slab|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000200 ffff0000c0844c00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d5efef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000d5eff000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000d5eff080: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
                                  ^
 ffff0000d5eff100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000d5eff180: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
==================================================================
EXT4-fs error (device loop3): __ext4_get_inode_loc:4560: comm syz-executor175: Invalid inode table block 4 in block_group 0
EXT4-fs error (device loop3) in ext4_reserve_inode_write:5906: Corrupt filesystem
EXT4-fs error (device loop3): __ext4_get_inode_loc:4560: comm syz-executor175: Invalid inode table block 4 in block_group 0
EXT4-fs error (device loop3) in ext4_reserve_inode_write:5906: Corrupt filesystem
EXT4-fs error (device loop3): ext4_evict_inode:279: inode #18: comm syz-executor175: mark_inode_dirty error
EXT4-fs warning (device loop3): ext4_evict_inode:282: couldn't mark inode dirty (err -117)

