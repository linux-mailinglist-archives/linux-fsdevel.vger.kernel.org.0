Return-Path: <linux-fsdevel+bounces-42913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BBBA4B64D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F14C188E274
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 02:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B9A1CDA3F;
	Mon,  3 Mar 2025 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbeUBuOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960571C5F37;
	Mon,  3 Mar 2025 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970476; cv=none; b=uK40NeuC1WYX91iosJ5ISE+DC+apRjgDE0peCpWq08sC747Oyy5lY2oFimaGJomUZunEr0FyjtTC4WYOUHQVzTrJfxC43OJ2NSgRRofIgyDzvpiczDa8qYPLeFqmfVeiOVl1W0uuyKRUFzEGm0nvcOAf2wTs8SYO9AkF2AFYeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970476; c=relaxed/simple;
	bh=PyCetO3EHw/3dFJwl5n7SBBWq4UFc0+uUm5jN0DoxvM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cHgySjsYK0CMrgqLHWG98+71Dm2ZTjqHU2/qWo0nBdhnw7w9Aotq/tP83e3XacvbtAU1X97uR7l1uCTK7gyj+nnf2Xlc0oAhqSTv5iHBNr7FMFTK754p+Y1Gqe1wNGMYXW8NyrC/g3lhOfLSYM8BZ0bTAoic3BquoyNcOkZlxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbeUBuOJ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2bd2218ba4fso1024468fac.1;
        Sun, 02 Mar 2025 18:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740970473; x=1741575273; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r7Y8ANM7bjvUQEgoZS4HLxWYZ32I+TT4YbK4g45/Wuc=;
        b=UbeUBuOJYdBwx3wtjI/SqTE5Eb/TB9wsxaMBKzpmEM9qqVdx4yzbFY4okKiOMhcLUP
         Hq1Lit9U85HqkimTaZMIi37hT4TeMpuqiHjb9CgkBe9mk5lSKiE696+HBCYA2BmP6vOC
         ztKdu5LnZLe7FRe6mBElwKtd1Y0wo2GkIwTjKoyUxiPkb5zuaV6U9LvEmFMSUnlEloz3
         PKEyI4rsK/LII3ta27vBH/jnDgZd5+Tl1+KfZlOgTIUs29uEgDVaZJtS37Ol2bVr5iBz
         9Q5k4mVhfUDcXuUHXicp29MA1nQpY4zsnBRCEoPQn4mhRlmex6t6v5p+ciZegxsKtFZS
         dDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740970473; x=1741575273;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7Y8ANM7bjvUQEgoZS4HLxWYZ32I+TT4YbK4g45/Wuc=;
        b=XYMl8eh0T80iA0sPKKkCJd79R0v+LMSYUeNbzw5gjKRsybnz9MwMI8Tv2Ll/g9tJaY
         xHub752ZfyOj+lrPayf4OtdBZ3CbyNpcJF9gC+kvV6yiisCvlhXGI9gcOni5wcxeCOeo
         YUSESpRNFeM7BEmhAEIC8rdhSLB/SHDEvfCmvur85Qr3F/8nlQKb8Lv2anOnzv0m21Px
         3XADk4bh2MjAGSCnoWV3kk7BG54EM1f8UgviZRy1Tsk2+9RK1yVE8Iq1EvZKPSX5Cnsf
         Jee0FwuK30nX4v4PUr2dZcJQcpvQGkTku8BL9FIpqqO1GGO5LgbTW4IZknylbHbIXTNq
         8gOw==
X-Forwarded-Encrypted: i=1; AJvYcCUNTlLbqpCD0NotzbADFtNAx1Tfq0koIdTH0vYu+SKRpRI7SA/xM2FZcCK11GhCDmPty+0e5JlCrgIcimw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiTF7sbm9KEHGjNb+VuurZ3Yv7QJDSldN3J4sna4Ya+DACeDt
	u63qn7ZIwgOlVsD1oWzRPT1SVEltMxcwSSy1Ts5LqCR6xW0aMpf0bC7D8ZCWPAMcJhKXW9Y8YPx
	zByoIFqkfQJ19p/m21atLkkh9HsqnjLjaSPU9a6cm
X-Gm-Gg: ASbGncsttqRTy891NXrv8JzCtkhUq3YH0hUCgoSlp/maoEZSNkiQTZqd+P//7DyP3Lu
	9SGu6ebzjo0RnBvxlWuSL+9hrsHKTpyYhIYZmhcdvnE7Nx03E2I9V2rkDeWOfUYs581vdLiBlIo
	0fBY4wJaVXwAzo3auUS/TLgmz5OQ==
X-Google-Smtp-Source: AGHT+IHt4QX+U3W09fOKLCq2O594dVXwOzl0bzEuIYfRvIYV5wxIFCWRBumPY5rHwsEvMnqxt38PkkgTgZiLZZTXPW4=
X-Received: by 2002:a05:6870:5b81:b0:2bc:9116:8856 with SMTP id
 586e51a60fabf-2c1787be53cmr7159117fac.36.1740970473239; Sun, 02 Mar 2025
 18:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Strforexc yn <strforexc@gmail.com>
Date: Mon, 3 Mar 2025 10:54:22 +0800
X-Gm-Features: AQ5f1Jo5Cbm62tUkcpRh91P4lTA7nPMBDcawpHX8QiMCv6S6ymvc0BI6xtjo_-8
Message-ID: <CA+HokZp0ZrvS_Xcue0wx48jmgmfXodEk6Qy2SeN3Bz6XPvQW=Q@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Write in hfs_bnode_read
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Kernel commit: v6.14-rc4 (Commits on Feb 24, 2025)
Kernel Config : https://github.com/Strforexc/LinuxKernelbug/blob/main/.config
Kernel Log:  https://github.com/Strforexc/LinuxKernelbug/blob/main/KASAN_slab-out-of-bounds_Write_in_hfs_bnode_read/log0
Reproduce:  https://github.com/Strforexc/LinuxKernelbug/blob/main/KASAN_slab-out-of-bounds_Write_in_hfs_bnode_read/repro.cprog

This bug seems to have been reported and fixed in the old kernel,
which seems to be a regression issue? If you fix this issue, please
add the following tag to the commit:
Reported-by: Zhizhuo Tang strforexctzzchange@foxmail.com, Jianzhou
Zhao xnxc22xnxc22@qq.com, Haoran Liu <cherest_san@163.com>

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_page
include/linux/highmem.h:423 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read+0xc5/0x230 fs/hfs/bnode.c:35
Write of size 256 at addr ffff8880512bab80 by task syz.3.4/11486

CPU: 1 UID: 0 PID: 11486 Comm: syz.3.4 Not tainted 6.14.0-rc4 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
 print_address_description.constprop.0+0x2c/0x420 mm/kasan/report.c:408
 print_report+0xaa/0x270 mm/kasan/report.c:521
 kasan_report+0xbd/0x100 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x108/0x1e0 mm/kasan/generic.c:189
 __asan_memcpy+0x3d/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:423 [inline]
 hfs_bnode_read+0xc5/0x230 fs/hfs/bnode.c:35
 hfs_bnode_read_key+0x149/0x1f0 fs/hfs/bnode.c:70
 hfs_brec_insert+0x822/0xbd0 fs/hfs/brec.c:141
 hfs_cat_create+0x6a5/0x840 fs/hfs/catalog.c:131
 hfs_create+0x6b/0x100 fs/hfs/dir.c:202
 lookup_open.isra.0+0x1145/0x1540 fs/namei.c:3651
 open_last_lookups+0x82c/0x13b0 fs/namei.c:3750
 path_openat+0x182/0x6b0 fs/namei.c:3986
 do_filp_open+0x1f8/0x460 fs/namei.c:4016
 do_sys_openat2+0x16a/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x140/0x200 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f651abb85ad
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f651b9acf98 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f651ae45fa0 RCX: 00007f651abb85ad
RDX: 0000000000141842 RSI: 0000400000000380 RDI: ffffffffffffff9c
RBP: 00007f651ac6a8d6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f651ae45fa0 R15: 00007f651b98d000
 </TASK>

Allocated by task 11486:
 kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x40 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xba/0xc0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_noprof+0x212/0x580 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 hfs_find_init+0x95/0x260 fs/hfs/bfind.c:21
 hfs_cat_create+0x155/0x840 fs/hfs/catalog.c:96
 hfs_create+0x6b/0x100 fs/hfs/dir.c:202
 lookup_open.isra.0+0x1145/0x1540 fs/namei.c:3651
 open_last_lookups+0x82c/0x13b0 fs/namei.c:3750
 path_openat+0x182/0x6b0 fs/namei.c:3986
 do_filp_open+0x1f8/0x460 fs/namei.c:4016
 do_sys_openat2+0x16a/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x140/0x200 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcb/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880512bab80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 allocated 78-byte region [ffff8880512bab80, ffff8880512babce)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x512ba
ksm flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801b441280 ffffea000136d8c0 dead000000000003
raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 9758,
tgid 9758 (kworker/u8:3), ts 68385688828, free_ts 68344511646
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1a3/0x1d0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x8a5/0xfa0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x1d8/0x3b0 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1f2/0x550 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x229/0x310 mm/slub.c:2587
 ___slab_alloc+0x7f3/0x12b0 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xc0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0x280/0x450 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 nsim_fib_event_schedule_work+0xb3/0x8d0 drivers/net/netdevsim/fib.c:990
 nsim_fib_event_nb+0x14e/0x190 drivers/net/netdevsim/fib.c:1043
 notifier_call_chain+0xd7/0x250 kernel/notifier.c:85
 atomic_notifier_call_chain+0x71/0x1d0 kernel/notifier.c:223
 call_fib_notifiers+0x34/0x70 net/core/fib_notifier.c:35
 call_fib6_entry_notifiers net/ipv6/ip6_fib.c:397 [inline]
 fib6_add_rt2node+0x19fa/0x3160 net/ipv6/ip6_fib.c:1231
 fib6_add+0x4b2/0x1720 net/ipv6/ip6_fib.c:1488
 __ip6_ins_rt net/ipv6/route.c:1317 [inline]
 ip6_ins_rt+0xb6/0x120 net/ipv6/route.c:1327
page last free pid 9550 tgid 9550 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x71f/0xff0 mm/page_alloc.c:2660
 __put_partials+0x13b/0x190 mm/slub.c:3153
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x50/0x130 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a5/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x6f/0xa0 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x1c3/0x580 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 fib6_info_alloc+0x40/0x170 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x341/0x1930 net/ipv6/route.c:3766
 ip6_route_add+0x28/0x180 net/ipv6/route.c:3858
 addrconf_add_mroute+0x1de/0x360 net/ipv6/addrconf.c:2549
 addrconf_add_dev+0x154/0x1d0 net/ipv6/addrconf.c:2567
 inet6_addr_add+0x100/0x980 net/ipv6/addrconf.c:3029
 inet6_rtm_newaddr+0x93c/0xaa0 net/ipv6/addrconf.c:5054
 rtnetlink_rcv_msg+0x9f4/0xfc0 net/core/rtnetlink.c:6912
 netlink_rcv_skb+0x168/0x450 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
 netlink_unicast+0x552/0x800 net/netlink/af_netlink.c:1348

Memory state around the buggy address:
 ffff8880512baa80: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff8880512bab00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>ffff8880512bab80: 00 00 00 00 00 00 00 00 00 06 fc fc fc fc fc fc
                                              ^
 ffff8880512bac00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff8880512bac80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================
Thanks,
Zhizhuo Tang

