Return-Path: <linux-fsdevel+bounces-20431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3338D3588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50DFA1C22F66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D17B51C;
	Wed, 29 May 2024 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvb/KCdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7714B973;
	Wed, 29 May 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981993; cv=none; b=R/8GZctHDH1ZT9m0Gy31Ryxyf3UGYir5JvI/SkcemhJ1SOsb0j1iAdRdjiU8zgC8oJRXA2FaoZxZxJUNs8eb0UyC82kpiQhFu9ur4eKbHZWTVaJ2KBFJiqHHFAlDGaHsh7Z41Kn0VmQvB/Ri9TllbC5bGGq9bKf/tSAUf+dQ7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981993; c=relaxed/simple;
	bh=fQ/W/XQvxztVD+KL+K6E/rTOhhZdplFlq7iK6NNvaf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gB9Q0Pl3OxbKGpc+nbkWMI/Ji9tlV6HbBYGIEu68l1NkwqxIH254X8ZZ2vrFCO25hzmXN/0r8j0lSf/+21yncq5N6Nlwu8T4mLtzjsGtAlNSmuoBtJhMbYFoWixlbiA+yiSWzrwRI9jhzwMADA27D7ZJVB7khTJZVNauw7+VpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvb/KCdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9139CC2BD10;
	Wed, 29 May 2024 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716981993;
	bh=fQ/W/XQvxztVD+KL+K6E/rTOhhZdplFlq7iK6NNvaf8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Fvb/KCdoPztX6z+7ql5DcFANYWdm5gb9goBNnMwmbGHzTlSl/+eyRFqBZnirh9xRj
	 ID7aXWhvqx+Rh8Yq6w+OO1yF1klvQIsHAicsPP3V+2Oj9wK9RtaRFQkWxo20fEeyzJ
	 ILjpt/fL24z/2y3gqaeNIINGn/xD10ssKAH/20rsCWO9o7sEQnxUmTKXyPLrP+SHyp
	 MR9l8/VPL6S2tWUZVNK5wUYZud+Q9hWGj8KCVnyWZQCw+MEwfswVNsIRZ+2JmblzSh
	 tZSb7KniBGi9boYWfS+wA8OnIKe6mHWbUyM1ro7t4qIh73w+wxUNzpBFk388vnJ3E3
	 6LD4ST2hhik+A==
Message-ID: <1f177444-0613-4843-98fe-bcdca2538a07@kernel.org>
Date: Wed, 29 May 2024 19:26:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 sanity_check_extent_cache
To: syzbot <syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <00000000000009beea061740a531@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <00000000000009beea061740a531@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip

On 2024/4/30 2:44, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e67572cd2204 Linux 6.9-rc6
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13724f0f180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
> dashboard link: https://syzkaller.appspot.com/bug?extid=74ebe2104433e9dc610d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16938440980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ae8517180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/526d150815dd/disk-e67572cd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/03cba3db92e8/vmlinux-e67572cd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ec3f54fc8985/bzImage-e67572cd.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/21aa65da230a/mount_0.gz
> 
> The issue was bisected to:
> 
> commit a53936361330e4c55c0654605178281387d9c761
> Author: Chao Yu <chao@kernel.org>
> Date:   Sun Dec 10 09:20:35 2023 +0000
> 
>      f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b78440980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b78440980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b78440980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com
> Fixes: a53936361330 ("f2fs: delete obsolete FI_FIRST_BLOCK_WRITTEN")
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3b853316dc
> R13: 00007f3b852f8160 R14: 0030656c69662f2e R15: 00007ffdc8faca88
>   </TASK>
> ==================================================================
> BUG: KASAN: slab-use-after-free in sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
> Read of size 4 at addr ffff8880739ab220 by task syz-executor200/5097
> 
> CPU: 0 PID: 5097 Comm: syz-executor200 Not tainted 6.9.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   sanity_check_extent_cache+0x370/0x410 fs/f2fs/extent_cache.c:46
>   do_read_inode fs/f2fs/inode.c:509 [inline]
>   f2fs_iget+0x33e1/0x46e0 fs/f2fs/inode.c:560
>   f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
>   generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
>   exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x495/0x650 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f3b852ab889
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3b85239228 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
> RAX: ffffffffffffffda RBX: 00007f3b853316d8 RCX: 00007f3b852ab889
> RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000004
> RBP: 00007f3b853316d0 R08: 00007ffdc8faca87 R09: 00007f3b852396c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3b853316dc
> R13: 00007f3b852f8160 R14: 0030656c69662f2e R15: 00007ffdc8faca88
>   </TASK>
> 
> Allocated by task 5092:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:312 [inline]
>   __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
>   kasan_slab_alloc include/linux/kasan.h:201 [inline]
>   slab_post_alloc_hook mm/slub.c:3798 [inline]
>   slab_alloc_node mm/slub.c:3845 [inline]
>   kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
>   f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2817 [inline]
>   f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2827 [inline]
>   __grab_extent_tree+0x183/0x400 fs/f2fs/extent_cache.c:334
>   f2fs_init_read_extent_tree+0x455/0x910 fs/f2fs/extent_cache.c:405
>   do_read_inode fs/f2fs/inode.c:506 [inline]
>   f2fs_iget+0x33d1/0x46e0 fs/f2fs/inode.c:560
>   f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
>   generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
>   exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x495/0x650 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Freed by task 5092:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>   poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
>   __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2106 [inline]
>   slab_free mm/slub.c:4280 [inline]
>   kmem_cache_free+0x10b/0x2c0 mm/slub.c:4344
>   __destroy_extent_tree+0x307/0x600 fs/f2fs/extent_cache.c:1132
>   f2fs_destroy_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1143
>   f2fs_evict_inode+0x44d/0x1550 fs/f2fs/inode.c:831
>   evict+0x2a8/0x630 fs/inode.c:667
>   f2fs_iget+0x1a68/0x46e0 fs/f2fs/inode.c:621
>   f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
>   generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
>   exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x495/0x650 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The buggy address belongs to the object at ffff8880739ab1a0
>   which belongs to the cache f2fs_extent_tree of size 144
> The buggy address is located 128 bytes inside of
>   freed 144-byte region [ffff8880739ab1a0, ffff8880739ab230)
> 
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x739ab
> flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffffff()
> raw: 00fff80000000800 ffff88801afb08c0 dead000000000122 0000000000000000
> raw: 0000000000000000 0000000080130013 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x12c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_RECLAIMABLE), pid 5076, tgid -326355158 (syz-executor200), ts 5083, free_ts 26740999480
>   set_page_owner include/linux/page_owner.h:32 [inline]
>   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
>   prep_new_page mm/page_alloc.c:1541 [inline]
>   get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
>   __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   alloc_slab_page+0x5f/0x160 mm/slub.c:2175
>   allocate_slab mm/slub.c:2338 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2391
>   ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
>   __slab_alloc mm/slub.c:3610 [inline]
>   __slab_alloc_node mm/slub.c:3663 [inline]
>   slab_alloc_node mm/slub.c:3835 [inline]
>   kmem_cache_alloc+0x252/0x340 mm/slub.c:3852
>   f2fs_kmem_cache_alloc_nofail fs/f2fs/f2fs.h:2817 [inline]
>   f2fs_kmem_cache_alloc fs/f2fs/f2fs.h:2827 [inline]
>   __grab_extent_tree+0x183/0x400 fs/f2fs/extent_cache.c:334
>   f2fs_init_read_extent_tree+0x455/0x910 fs/f2fs/extent_cache.c:405
>   do_read_inode fs/f2fs/inode.c:506 [inline]
>   f2fs_iget+0x33d1/0x46e0 fs/f2fs/inode.c:560
>   f2fs_nfs_get_inode+0x74/0x100 fs/f2fs/super.c:3237
>   generic_fh_to_dentry+0x9f/0xf0 fs/libfs.c:1413
>   exportfs_decode_fh_raw+0x152/0x5f0 fs/exportfs/expfs.c:444
>   exportfs_decode_fh+0x3c/0x80 fs/exportfs/expfs.c:584
>   do_handle_to_path fs/fhandle.c:155 [inline]
>   handle_to_path fs/fhandle.c:210 [inline]
>   do_handle_open+0x495/0x650 fs/fhandle.c:226
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
> page last free pid 1 tgid 1 stack trace:
>   reset_page_owner include/linux/page_owner.h:25 [inline]
>   free_pages_prepare mm/page_alloc.c:1141 [inline]
>   free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
>   free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
>   free_contig_range+0x9e/0x160 mm/page_alloc.c:6572
>   destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1036
>   debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1416
>   do_one_initcall+0x248/0x880 init/main.c:1245
>   do_initcall_level+0x157/0x210 init/main.c:1307
>   do_initcalls+0x3f/0x80 init/main.c:1323
>   kernel_init_freeable+0x435/0x5d0 init/main.c:1555
>   kernel_init+0x1d/0x2b0 init/main.c:1444
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> Memory state around the buggy address:
>   ffff8880739ab100: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>   ffff8880739ab180: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
>> ffff8880739ab200: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>                                 ^
>   ffff8880739ab280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8880739ab300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

