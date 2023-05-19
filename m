Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD559708EC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 06:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjESERu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 00:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjESERs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 00:17:48 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9270C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 21:17:46 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76998d984b0so442177539f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 21:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684469866; x=1687061866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tc+QgITTH/gkKsxHHtnoPOgcymm5d5ok1OXbujAWnPc=;
        b=OnzwJ27aZ7gWwy9hClevl87pZfn392XrTJFmLG7cDanhgvkhev/w4kOIhymIsClGWB
         96FkD4bx/E+nm/IIFKHToeHgIkB7KzdQICmD55FCQv49qHuVo1q+pNxYB/Kc8fkp2gkS
         sEI3mKUJZ4TnBZEEs4TVLDLHh9WWy/xg1ao6KyUqP2btLs8I3MLYIEkE1QMP25n8xPlL
         yI/Z5VqewLPeXmtR19UdTv9I+eKpWhdgsGSX4HrISPfM4U6FG2focShC0wtBgCsoOrAW
         V5v0dshu88McLKExE03LBp55rlYyTZAMHoe0ZDj9y4tqZ6REUQ/FeMs371MLr3zl9Yib
         M7XQ==
X-Gm-Message-State: AC+VfDxcuANrctekNLrVWgIrmG7pvF7XrEL79FT2MuPwqXu2u0YbJos3
        rtCzn++IcwV/WlSNX16LTizqhEAFMb0qbjT/1m7VA0G+iH90
X-Google-Smtp-Source: ACHHUZ6Pxkzaj684Xi0n7XISmnXX2HRUkz8pcEyJz4o3XSZ/qV18TiBVepbjGZsHRU2whpFOyz1PXPxaO4y5a2LZxhyWGRK1dldM
MIME-Version: 1.0
X-Received: by 2002:a02:9441:0:b0:3a7:e46e:ab64 with SMTP id
 a59-20020a029441000000b003a7e46eab64mr186729jai.1.1684469866144; Thu, 18 May
 2023 21:17:46 -0700 (PDT)
Date:   Thu, 18 May 2023 21:17:46 -0700
In-Reply-To: <000000000000d74cac05f1450646@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001aa4c05fc0434a0@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: use-after-free Read in release_metapage
From:   syzbot <syzbot+f1521383cec5f7baaa94@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        jfs-discussion@lists.sourceforge.net, jlayton@kernel.org,
        kch@nvidia.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4d6d4c7f541d Merge tag 'linux-kselftest-fixes-6.4-rc3' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166d0691280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
dashboard link: https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13385bd6280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c11186280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ded3ca087ccf/disk-4d6d4c7f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/75c4212eadbe/vmlinux-4d6d4c7f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ffc937ead4f/bzImage-4d6d4c7f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8ae1719fba02/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1521383cec5f7baaa94@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in drop_metapage fs/jfs/jfs_metapage.c:223 [inline]
BUG: KASAN: slab-use-after-free in release_metapage+0x5a7/0x870 fs/jfs/jfs_metapage.c:786
Read of size 8 at addr ffff888029b76218 by task syz-executor361/5082

CPU: 1 PID: 5082 Comm: syz-executor361 Not tainted 6.4.0-rc2-syzkaller-00018-g4d6d4c7f541d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 drop_metapage fs/jfs/jfs_metapage.c:223 [inline]
 release_metapage+0x5a7/0x870 fs/jfs/jfs_metapage.c:786
 write_metapage fs/jfs/jfs_metapage.h:75 [inline]
 flush_metapage fs/jfs/jfs_metapage.h:81 [inline]
 ea_put fs/jfs/xattr.c:614 [inline]
 __jfs_setxattr+0xad9/0x11d0 fs/jfs/xattr.c:783
 jfs_initxattrs+0x128/0x1d0 fs/jfs/xattr.c:1016
 security_inode_init_security+0x2df/0x3f0 security/security.c:1630
 jfs_init_security+0xa9/0x110 fs/jfs/xattr.c:1028
 jfs_mkdir+0x2c7/0xbb0 fs/jfs/namei.c:240
 vfs_mkdir+0x29d/0x450 fs/namei.c:4115
 do_mkdirat+0x264/0x520 fs/namei.c:4138
 __do_sys_mkdir fs/namei.c:4158 [inline]
 __se_sys_mkdir fs/namei.c:4156 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4156
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fce4779cec9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce40327318 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fce478287b8 RCX: 00007fce4779cec9
RDX: 00007fce40327700 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007fce478287b0 R08: 00007fce40327700 R09: 0000000000000000
R10: 00007fce40327700 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 00007ffcc2233f3f R14: 00007fce40327400 R15: 0000000000022000
 </TASK>

Allocated by task 5082:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x11f/0x2e0 mm/slub.c:3475
 mempool_alloc+0x194/0x580 mm/mempool.c:398
 alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
 __get_metapage+0x574/0x10e0 fs/jfs/jfs_metapage.c:651
 ea_get+0xb3f/0x1280 fs/jfs/xattr.c:526
 __jfs_setxattr+0x4ba/0x11d0 fs/jfs/xattr.c:718
 jfs_initxattrs+0x128/0x1d0 fs/jfs/xattr.c:1016
 security_inode_init_security+0x2df/0x3f0 security/security.c:1630
 jfs_init_security+0xa9/0x110 fs/jfs/xattr.c:1028
 jfs_mkdir+0x2c7/0xbb0 fs/jfs/namei.c:240
 vfs_mkdir+0x29d/0x450 fs/namei.c:4115
 do_mkdirat+0x264/0x520 fs/namei.c:4138
 __do_sys_mkdir fs/namei.c:4158 [inline]
 __se_sys_mkdir fs/namei.c:4156 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4156
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5074:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0x297/0x520 mm/slub.c:3808
 free_metapage fs/jfs/jfs_metapage.c:191 [inline]
 metapage_release_folio+0x5cc/0x730 fs/jfs/jfs_metapage.c:551
 shrink_folio_list+0x26f1/0x8940 mm/vmscan.c:2076
 shrink_inactive_list mm/vmscan.c:2602 [inline]
 shrink_list mm/vmscan.c:2843 [inline]
 shrink_lruvec+0x16e6/0x2d30 mm/vmscan.c:6279
 shrink_node_memcgs mm/vmscan.c:6466 [inline]
 shrink_node+0x115c/0x2790 mm/vmscan.c:6501
 shrink_zones mm/vmscan.c:6736 [inline]
 do_try_to_free_pages+0x67e/0x1900 mm/vmscan.c:6798
 try_to_free_mem_cgroup_pages+0x455/0xa50 mm/vmscan.c:7113
 try_charge_memcg+0x5de/0x16d0 mm/memcontrol.c:2724
 try_charge mm/memcontrol.c:2866 [inline]
 mem_cgroup_charge_skmem+0xad/0x2b0 mm/memcontrol.c:7351
 sock_reserve_memory+0x101/0x610 net/core/sock.c:1025
 sk_setsockopt+0xc8e/0x3430 net/core/sock.c:1520
 __sys_setsockopt+0x47b/0x980 net/socket.c:2269
 __do_sys_setsockopt net/socket.c:2284 [inline]
 __se_sys_setsockopt net/socket.c:2281 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2281
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888029b761f0
 which belongs to the cache jfs_mp of size 184
The buggy address is located 40 bytes inside of
 freed 184-byte region [ffff888029b761f0, ffff888029b762a8)

The buggy address belongs to the physical page:
page:ffffea0000a6dd80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29b76
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888142ae6000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x192800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5082, tgid 5073 (syz-executor361), ts 74009954920, free_ts 73972179887
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x1b9/0x2e0 mm/slub.c:3475
 mempool_alloc+0x194/0x580 mm/mempool.c:398
 alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
 __get_metapage+0x574/0x10e0 fs/jfs/jfs_metapage.c:651
 diNewExt+0xbe0/0x4000 fs/jfs/jfs_imap.c:2265
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0xbe8/0x1e50 fs/jfs/jfs_imap.c:1662
 diAlloc+0x3e1/0x1720 fs/jfs/jfs_imap.c:1583
 ialloc+0x8f/0x980 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xbb0 fs/jfs/namei.c:225
 vfs_mkdir+0x29d/0x450 fs/namei.c:4115
 do_mkdirat+0x264/0x520 fs/namei.c:4138
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x14c/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node+0xa7/0x230 mm/slab_common.c:973
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:604
 kvmalloc include/linux/slab.h:697 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x202/0xd10 fs/seq_file.c:210
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x788/0xb00 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888029b76100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888029b76180: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb
>ffff888029b76200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888029b76280: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff888029b76300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
