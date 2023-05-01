Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C961E6F39C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 23:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjEAV0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjEAV0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 17:26:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6852358C;
        Mon,  1 May 2023 14:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ABBE61FE5;
        Mon,  1 May 2023 21:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0534C433D2;
        Mon,  1 May 2023 21:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682976393;
        bh=3wPSj4VLaUYhylNYFSGwz99hRK6+ksVB1YpRLtzy6LQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfyST37LWpGo/2dPFfqaszmHqQQUfnF0sW8JZGvCZDwR02F0wbsYKFIH0rTq1+eQN
         h672zFWGscJK3z9kY7kfiqo90/dQHw3fYGy331sZL/5FT+qWSydvGKgXUSPk6eL7MO
         FN/p0LjXlzDCpUmMmqk7qlR9/85cvE06aZwyAVABfAG9QBzSezkL7WZf/446qfl0Tz
         XQN5bwSTTAjsXN6NQBAmJfXTMuXpxzNlb4CXUWKQeOrdATYMFl+ueCLKRVTGwZe7IU
         yGVvqeOeMzcVfkHgAHGw7uDL0vu7upuzlg30lERUZ0hZ4nM+/ebcgrdY2kOuuSVRCj
         LIcrMggdTnOZA==
Date:   Mon, 1 May 2023 14:26:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     syzbot <syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_getbmap
Message-ID: <20230501212633.GN59213@frogsfrogsfrogs>
References: <000000000000c5beb705faa6577d@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibA7EOz4zI+DGWOY"
Content-Disposition: inline
In-Reply-To: <000000000000c5beb705faa6577d@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ibA7EOz4zI+DGWOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 01, 2023 at 11:53:47AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e6af2c280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
> dashboard link: https://syzkaller.appspot.com/bug?extid=c103d3808a0de5faaf80
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e25f2c280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14945d10280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/60130779f509/disk-58390c8c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d7f0cdd29b71/vmlinux-58390c8c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/de415ad52ae4/bzImage-58390c8c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c94bae2c94e1/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com


#syz test: git://repo/address.git branch-or-commit-hash

--D


> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in xfs_getbmap+0x1c06/0x1c90 fs/xfs/xfs_bmap_util.c:561
> Read of size 4 at addr ffff88801872aa78 by task syz-executor294/5000
> 
> CPU: 1 PID: 5000 Comm: syz-executor294 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:351 [inline]
>  print_report+0x163/0x540 mm/kasan/report.c:462
>  kasan_report+0x176/0x1b0 mm/kasan/report.c:572
>  xfs_getbmap+0x1c06/0x1c90 fs/xfs/xfs_bmap_util.c:561
>  xfs_ioc_getbmap+0x243/0x7a0 fs/xfs/xfs_ioctl.c:1481
>  xfs_file_ioctl+0xbf5/0x16a0 fs/xfs/xfs_ioctl.c:1949
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fc886bade49
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc87f738208 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fc886c3c7b8 RCX: 00007fc886bade49
> RDX: 0000000020000140 RSI: 00000000c0205826 RDI: 0000000000000005
> RBP: 00007fc886c3c7b0 R08: 00007fc87f738700 R09: 0000000000000000
> R10: 00007fc87f738700 R11: 0000000000000246 R12: 00007fc886c3c7bc
> R13: 00007ffdc483022f R14: 00007fc87f738300 R15: 0000000000022000
>  </TASK>
> 
> Allocated by task 4450:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>  kasan_kmalloc include/linux/kasan.h:196 [inline]
>  __do_kmalloc_node mm/slab_common.c:966 [inline]
>  __kmalloc_node+0xb8/0x230 mm/slab_common.c:973
>  kmalloc_node include/linux/slab.h:579 [inline]
>  kvmalloc_node+0x72/0x180 mm/util.c:604
>  kvmalloc include/linux/slab.h:697 [inline]
>  simple_xattr_alloc+0x43/0xa0 fs/xattr.c:1073
>  shmem_initxattrs+0x8e/0x1e0 mm/shmem.c:3290
>  security_inode_init_security+0x2df/0x3f0 security/security.c:1630
>  shmem_mknod+0xba/0x1c0 mm/shmem.c:2947
>  lookup_open fs/namei.c:3492 [inline]
>  open_last_lookups fs/namei.c:3560 [inline]
>  path_openat+0x13df/0x3170 fs/namei.c:3788
>  do_filp_open+0x234/0x490 fs/namei.c:3818
>  do_sys_openat2+0x13f/0x500 fs/open.c:1356
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_openat fs/open.c:1388 [inline]
>  __se_sys_openat fs/open.c:1383 [inline]
>  __x64_sys_openat+0x247/0x290 fs/open.c:1383
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> The buggy address belongs to the object at ffff88801872aa00
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 79 bytes to the right of
>  allocated 41-byte region [ffff88801872aa00, ffff88801872aa29)
> 
> The buggy address belongs to the physical page:
> page:ffffea000061ca80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1872a
> flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000200 ffff888012441640 ffffea0000ad39c0 dead000000000002
> raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4439, tgid 4439 (S02sysctl), ts 15189537421, free_ts 15177747790
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1722
>  prep_new_page mm/page_alloc.c:1729 [inline]
>  get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3493
>  __alloc_pages+0x255/0x670 mm/page_alloc.c:4759
>  alloc_slab_page+0x6a/0x160 mm/slub.c:1851
>  allocate_slab mm/slub.c:1998 [inline]
>  new_slab+0x84/0x2f0 mm/slub.c:2051
>  ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
>  __slab_alloc mm/slub.c:3291 [inline]
>  __slab_alloc_node mm/slub.c:3344 [inline]
>  slab_alloc_node mm/slub.c:3441 [inline]
>  __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
>  kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1057
>  kmalloc include/linux/slab.h:559 [inline]
>  load_elf_binary+0x1cdb/0x2830 fs/binfmt_elf.c:910
>  search_binary_handler fs/exec.c:1737 [inline]
>  exec_binprm fs/exec.c:1779 [inline]
>  bprm_execve+0x90e/0x1740 fs/exec.c:1854
>  do_execveat_common+0x580/0x720 fs/exec.c:1962
>  do_execve fs/exec.c:2036 [inline]
>  __do_sys_execve fs/exec.c:2112 [inline]
>  __se_sys_execve fs/exec.c:2107 [inline]
>  __x64_sys_execve+0x92/0xa0 fs/exec.c:2107
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1302 [inline]
>  free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2555
>  free_unref_page_list+0x596/0x830 mm/page_alloc.c:2696
>  release_pages+0x2193/0x2470 mm/swap.c:1042
>  tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
>  tlb_flush_mmu+0x100/0x210 mm/mmu_gather.c:299
>  tlb_finish_mmu+0xd4/0x1f0 mm/mmu_gather.c:391
>  exit_mmap+0x3da/0xaf0 mm/mmap.c:3123
>  __mmput+0x115/0x3c0 kernel/fork.c:1351
>  exec_mmap+0x672/0x700 fs/exec.c:1035
>  begin_new_exec+0x665/0xf10 fs/exec.c:1294
>  load_elf_binary+0x95d/0x2830 fs/binfmt_elf.c:1001
>  search_binary_handler fs/exec.c:1737 [inline]
>  exec_binprm fs/exec.c:1779 [inline]
>  bprm_execve+0x90e/0x1740 fs/exec.c:1854
>  do_execveat_common+0x580/0x720 fs/exec.c:1962
>  do_execve fs/exec.c:2036 [inline]
>  __do_sys_execve fs/exec.c:2112 [inline]
>  __se_sys_execve fs/exec.c:2107 [inline]
>  __x64_sys_execve+0x92/0xa0 fs/exec.c:2107
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Memory state around the buggy address:
>  ffff88801872a900: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc
>  ffff88801872a980: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> >ffff88801872aa00: 00 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc
>                                                                 ^
>  ffff88801872aa80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff88801872ab00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

--ibA7EOz4zI+DGWOY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="023-xfs-bmap-fix-negative-array-access.patch"

From: Darrick J. Wong <djwong@kernel.org>
Subject: [PATCH] xfs: fix negative array access in xfs_getbmap

In commit 8ee81ed581ff, Ye Bin complained about an ASSERT in the bmapx
code that trips if we encounter a delalloc extent after flushing the
pagecache to disk.  The ioctl code does not hold MMAPLOCK so it's
entirely possible that a racing write page fault can create a delalloc
extent after the file has been flushed.  The proposed solution was to
replace the assertion with an early return that avoids filling out the
bmap recordset with a delalloc entry if the caller didn't ask for it.

At the time, I recall thinking that the forward logic sounded ok, but
felt hesitant because I suspected that changing this code would cause
something /else/ to burst loose due to some other subtlety.

syzbot of course found that subtlety.  If all the extent mappings found
after the flush are delalloc mappings, we'll reach the end of the data
fork without ever incrementing bmv->bmv_entries.  This is new, since
before we'd have emitted the delalloc mappings even though the caller
didn't ask for them.  Once we reach the end, we'll try to set
BMV_OF_LAST on the -1st entry (because bmv_entries is zero) and go
corrupt something else in memory.  Yay.

I really dislike all these stupid patches that fiddle around with debug
code and break things that otherwise worked well enough.  Nobody was
complaining that calling XFS_IOC_BMAPX without BMV_IF_DELALLOC would
return BMV_OF_DELALLOC records, and now we've gone from "weird behavior
that nobody cared about" to "bad behavior that must be addressed
immediately".

Maybe I'll just ignore anything from Huawei from now on for my own sake.

Reported-by: syzbot+c103d3808a0de5faaf80@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-xfs/20230412024907.GP360889@frogsfrogsfrogs/
Fixes: 8ee81ed581ff ("xfs: fix BUG_ON in xfs_getbmap()")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_bmap_util.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index f032d3a4b727..fbb675563208 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -558,7 +558,9 @@ xfs_getbmap(
 		if (!xfs_iext_next_extent(ifp, &icur, &got)) {
 			xfs_fileoff_t	end = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
 
-			out[bmv->bmv_entries - 1].bmv_oflags |= BMV_OF_LAST;
+			if (bmv->bmv_entries > 0)
+				out[bmv->bmv_entries - 1].bmv_oflags |=
+								BMV_OF_LAST;
 
 			if (whichfork != XFS_ATTR_FORK && bno < end &&
 			    !xfs_getbmap_full(bmv)) {

--ibA7EOz4zI+DGWOY--
