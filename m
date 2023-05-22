Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDC70BEE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjEVM56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjEVM55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 08:57:57 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1E137;
        Mon, 22 May 2023 05:57:42 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QPy6c0DBwz18Lcq;
        Mon, 22 May 2023 20:53:12 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 20:57:38 +0800
Subject: Re: [syzbot] [ext4?] KASAN: use-after-free Read in ext4_search_dir
To:     syzbot <syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>
References: <000000000000d8632905fbdea615@google.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <646B66C1.6080905@huawei.com>
Date:   Mon, 22 May 2023 20:57:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <000000000000d8632905fbdea615@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/5/17 15:29, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    f1fcbaa18b28 Linux 6.4-rc2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1064d8fc280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
> dashboard link: https://syzkaller.appspot.com/bug?extid=34a0f26f0f61c4888ea4
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1172c85a280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1694e5ce280000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2ddd2c9b7bc9/disk-f1fcbaa1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f999d7594125/vmlinux-f1fcbaa1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/eff89a0460f3/bzImage-f1fcbaa1.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e79f7be33fee/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/0571f920dadd/mount_7.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+34a0f26f0f61c4888ea4@syzkaller.appspotmail.com
>
> EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> EXT4-fs (loop0): 1 truncate cleaned up
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1539
> Read of size 1 at addr ffff88801f58d3ed by task syz-executor303/4999
>
> CPU: 0 PID: 4999 Comm: syz-executor303 Not tainted 6.4.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:351 [inline]
>   print_report+0x163/0x540 mm/kasan/report.c:462
>   kasan_report+0x176/0x1b0 mm/kasan/report.c:572
>   ext4_search_dir+0xf2/0x1b0 fs/ext4/namei.c:1539
>   ext4_find_inline_entry+0x4ba/0x5e0 fs/ext4/inline.c:1719
>   __ext4_find_entry+0x2b4/0x1b30 fs/ext4/namei.c:1612
>   ext4_lookup_entry fs/ext4/namei.c:1767 [inline]
>   ext4_lookup+0x17a/0x750 fs/ext4/namei.c:1835
>   lookup_open fs/namei.c:3470 [inline]
>   open_last_lookups fs/namei.c:3560 [inline]
>   path_openat+0x11e9/0x3170 fs/namei.c:3788
>   do_filp_open+0x234/0x490 fs/namei.c:3818
>   do_sys_openat2+0x13f/0x500 fs/open.c:1356
>   do_sys_open fs/open.c:1372 [inline]
>   __do_sys_open fs/open.c:1380 [inline]
>   __se_sys_open fs/open.c:1376 [inline]
>   __x64_sys_open+0x225/0x270 fs/open.c:1376
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fd8cce6ccf9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff8e028488 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 0000000000010c1d RCX: 00007fd8cce6ccf9
> RDX: 0000000000000000 RSI: 0000000000141042 RDI: 0000000020000100
> RBP: 0000000000000000 R08: 000000000001f210 R09: 00000000200012c0
> R10: 00007fd8bc65f000 R11: 0000000000000246 R12: 00007fff8e0284bc
> R13: 00007fff8e0284f0 R14: 00007fff8e0284d0 R15: 0000000000000004
>   </TASK>
>
> Allocated by task 4730:
>   kasan_save_stack mm/kasan/common.c:45 [inline]
>   kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>   __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
>   kasan_slab_alloc include/linux/kasan.h:186 [inline]
>   slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
>   kmem_cache_alloc_bulk+0x3d2/0x4b0 mm/slub.c:4033
>   mt_alloc_bulk lib/maple_tree.c:164 [inline]
>   mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1309
>   mas_node_count_gfp lib/maple_tree.c:1367 [inline]
>   mas_preallocate+0x131/0x350 lib/maple_tree.c:5781
>   vma_iter_prealloc mm/internal.h:1029 [inline]
>   __split_vma+0x1e0/0x7f0 mm/mmap.c:2253
>   do_vmi_align_munmap+0x4ac/0x1820 mm/mmap.c:2398
>   do_vmi_munmap+0x24a/0x2b0 mm/mmap.c:2530
>   mmap_region+0x811/0x2250 mm/mmap.c:2578
>   do_mmap+0x8c9/0xf70 mm/mmap.c:1394
>   vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
>   ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Freed by task 4730:
>   kasan_save_stack mm/kasan/common.c:45 [inline]
>   kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>   kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
>   ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>   kasan_slab_free include/linux/kasan.h:162 [inline]
>   slab_free_hook mm/slub.c:1781 [inline]
>   slab_free_freelist_hook mm/slub.c:1807 [inline]
>   slab_free mm/slub.c:3786 [inline]
>   kmem_cache_free_bulk+0x506/0x760 mm/slub.c:3904
>   mt_free_bulk lib/maple_tree.c:169 [inline]
>   mas_destroy+0x1c50/0x2310 lib/maple_tree.c:5836
>   mas_store_prealloc+0x351/0x460 lib/maple_tree.c:5766
>   vma_complete+0x1ec/0xb40 mm/mmap.c:585
>   __split_vma+0x7c2/0x7f0 mm/mmap.c:2290
>   do_vmi_align_munmap+0x4ac/0x1820 mm/mmap.c:2398
>   do_vmi_munmap+0x24a/0x2b0 mm/mmap.c:2530
>   mmap_region+0x811/0x2250 mm/mmap.c:2578
>   do_mmap+0x8c9/0xf70 mm/mmap.c:1394
>   vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
>   ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> The buggy address belongs to the object at ffff88801f58d200
>   which belongs to the cache maple_node of size 256
> The buggy address is located 237 bytes to the right of
>   allocated 256-byte region [ffff88801f58d200, ffff88801f58d300)
>
> The buggy address belongs to the physical page:
> page:ffffea00007d6300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f58c
> head:ffffea00007d6300 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000010200 ffff888012e4d000 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4730, tgid 4730 (S50sshd), ts 42005657182, free_ts 36967331489
>   set_page_owner include/linux/page_owner.h:31 [inline]
>   post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1731
>   prep_new_page mm/page_alloc.c:1738 [inline]
>   get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3502
>   __alloc_pages+0x255/0x670 mm/page_alloc.c:4768
>   alloc_slab_page+0x6a/0x160 mm/slub.c:1851
>   allocate_slab mm/slub.c:1998 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2051
>   ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
>   __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
>   kmem_cache_alloc_bulk+0x196/0x4b0 mm/slub.c:4026
>   mt_alloc_bulk lib/maple_tree.c:164 [inline]
>   mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1309
>   mas_node_count_gfp lib/maple_tree.c:1367 [inline]
>   mas_preallocate+0x131/0x350 lib/maple_tree.c:5781
>   vma_iter_prealloc mm/internal.h:1029 [inline]
>   mmap_region+0x1342/0x2250 mm/mmap.c:2711
>   do_mmap+0x8c9/0xf70 mm/mmap.c:1394
>   vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
>   ksys_mmap_pgoff+0x4f9/0x6d0 mm/mmap.c:1440
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>   reset_page_owner include/linux/page_owner.h:24 [inline]
>   free_pages_prepare mm/page_alloc.c:1302 [inline]
>   free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2564
>   free_unref_page+0x37/0x3f0 mm/page_alloc.c:2659
>   qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
>   kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
>   __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
>   kasan_slab_alloc include/linux/kasan.h:186 [inline]
>   slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
>   slab_alloc_node mm/slub.c:3451 [inline]
>   slab_alloc mm/slub.c:3459 [inline]
>   __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
>   kmem_cache_alloc_lru+0x11f/0x2e0 mm/slub.c:3482
>   __d_alloc+0x31/0x710 fs/dcache.c:1769
>   d_alloc fs/dcache.c:1849 [inline]
>   d_alloc_parallel+0xce/0x13a0 fs/dcache.c:2638
>   lookup_open fs/namei.c:3417 [inline]
>   open_last_lookups fs/namei.c:3560 [inline]
>   path_openat+0x90e/0x3170 fs/namei.c:3788
>   do_filp_open+0x234/0x490 fs/namei.c:3818
>   do_sys_openat2+0x13f/0x500 fs/open.c:1356
>   do_sys_open fs/open.c:1372 [inline]
>   __do_sys_openat fs/open.c:1388 [inline]
>   __se_sys_openat fs/open.c:1383 [inline]
>   __x64_sys_openat+0x247/0x290 fs/open.c:1383
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> Memory state around the buggy address:
>   ffff88801f58d280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88801f58d300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff88801f58d380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>                                                            ^
>   ffff88801f58d400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88801f58d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> .
According  to  C reproducer: 
https://syzkaller.appspot.com/x/repro.c?x=1694e5ce280000.
Above issue is is caused by write raw block device.

...
syz_mount_image(0x20000080, 0x20000480, 0xc0ed0006, 0x20000140, 0xfe, 0x43e,
                   0x200004c0);
   memcpy((void*)0x20000040, "./bus\000", 6);
   syscall(__NR_creat, 0x20000040ul, 0ul);
   memcpy((void*)0x20001280, "/dev/loop", 9);
   *(uint8_t*)0x20001289 = 0x30;
   *(uint8_t*)0x2000128a = 0;
   memcpy((void*)0x20001240, "./bus\000", 6);
   syscall(__NR_mount, 0x20001280ul, 0x20001240ul, 0ul, 0x1000ul, 0ul);  --> 'bus' is mounted bind to /dev/loop0
   memcpy((void*)0x20000780, "./bus\000", 6);
   res = syscall(__NR_open, 0x20000780ul, 0x14103eul, 0ul);
   if (res != -1)
     r[0] = res;
   memcpy((void*)0x20000040, "./file0\000", 8);
   syscall(__NR_chdir, 0x20000040ul);
   memcpy((void*)0x20000000, "cpuacct.usage_sys\000", 18);
   syscall(__NR_openat, 0xffffff9c, 0x20000000ul, 0x275aul, 0ul);
   syscall(__NR_mmap, 0x20000000ul, 0x600000ul, 0x2000002ul, 0x11ul, r[0], 0ul);  --> mmap 'bus'
   memcpy((void*)0x20000200, "ntfs3\000", 6);
   memcpy((void*)0x20000100, "./bus\000", 6);
   sprintf((char*)0x20000240, "0x%016llx", (long long)-1);
   sprintf((char*)0x20000252, "0x%016llx", (long long)-1);
   *(uint8_t*)0x20000264 = r[0];
   memcpy(
       (void*)0x200012c0,
       "\x78\x9c\xec\xdd\x09\x9c\x4d\xe5\xff\x07\xf0\xe7\xec\xfb\xbe\x5c\xbb\xc1"
       "\x58\x43\xb6\x44\xb2\xef\xb2\x6f\x21\xd9\xb2\xef\xd9\x42\x2a\x24\x5b\x92"
       "\x22\x24\x5b\x92\x2d\x49\xa8\x24\x89\x24\x5a\x44\x65\x4b\x48\x92\x24\x49"
       "\x25\x24\xf1\x7f\xcd\x9d\x3b\x93\x99\xb9\x7e\x35\xea\x5f\xe9\xf9\xbc\x5f"
       "\x2f\x73\xee\x3d\xf7\x9c\xe7\x39\xe7\x7c\xee\x19\xf3\x3d\xe7\xdc\x73\xbf"

...

