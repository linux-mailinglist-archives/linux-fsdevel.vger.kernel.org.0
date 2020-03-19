Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC418BE9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgCSRpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 13:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgCSRpX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:45:23 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6745B2072D;
        Thu, 19 Mar 2020 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584639922;
        bh=Wvl1iUUTCM82XXrC8hvRa0JdvfiSgesiT/H02ViTLuE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=2fRvHjICUiVih2G5JFlbAi3hBdqjb3iYgREmNfoSuxAO119o4C3BsYb3IUONBEARY
         k5du134Hf9sTwV3u9LgbCpU5/HhGj2jPq+/uD8/6u/7g8AQZ+SgXS/ndcDzN7Gtta1
         KMg64CO+jKgg+G6z781N/IYq+LWYk3yKUtheP4Ic=
Message-ID: <42a37edb839a04addc16436e820f64625459fe0a.camel@kernel.org>
Subject: Re: crash due to "filelock: fix regression in unlock performance"
From:   Jeff Layton <jlayton@kernel.org>
To:     Qian Cai <cai@lca.pw>, yangerkun <yangerkun@huawei.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Mar 2020 13:45:20 -0400
In-Reply-To: <1583934553.7365.176.camel@lca.pw>
References: <1583934553.7365.176.camel@lca.pw>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-03-11 at 09:49 -0400, Qian Cai wrote:
> Reverted the linux-next commit 88a3248184e3 ("filelock: fix regression in unlock
> performance") fixed the issues when running LTP fcntl33 and fcntl36 tests.
> 
> [  360.431725][ T2087] BUG: KASAN: use-after-free in __break_lease+0x798/0xd40
> [  360.466394][ T2087] Read of size 8 at addr ffff888fd0acc008 by task
> fcntl33/2087
> [  360.501044][ T2087] 
> [  360.511400][ T2087] CPU: 31 PID: 2087 Comm: fcntl33 Not tainted 5.6.0-rc5-
> next-20200311+ #2
> [  360.551011][ T2087] Hardware name: HP ProLiant BL660c Gen9, BIOS I38
> 10/17/2018
> [  360.586335][ T2087] Call Trace:
> [  360.601485][ T2087]  dump_stack+0xa0/0xea
> [  360.620290][ T2087]  print_address_description.constprop.5.cold.7+0x9/0x384
> [  360.653799][ T2087]  __kasan_report.cold.8+0x7a/0xd0
> [  360.677082][ T2087]  ? __break_lease+0x798/0xd40
> [  360.698169][ T2087]  ? __break_lease+0x798/0xd40
> [  360.720167][ T2087]  kasan_report+0x4e/0x60
> [  360.740468][ T2087]  __asan_load8+0x86/0xb0
> [  360.760469][ T2087]  __break_lease+0x798/0xd40
> [  360.780861][ T2087]  ? locks_lock_inode_wait+0x2e0/0x2e0
> [  360.806283][ T2087]  ? finish_wait+0x110/0x110
> [  360.827087][ T2087]  vfs_truncate+0x218/0x2d0
> [  360.848062][ T2087]  ? do_truncate+0x160/0x160
> [  360.868678][ T2087]  do_sys_truncate.part.14+0xe7/0x100
> [  360.893753][ T2087]  ? vfs_truncate+0x2d0/0x2d0
> [  360.916305][ T2087]  ? __x64_sys_clock_gettime+0x151/0x1c0
> [  360.943385][ T2087]  ? __x64_sys_clock_settime+0x1d0/0x1d0
> [  360.970662][ T2087]  __x64_sys_truncate+0x36/0x50
> [  360.993336][ T2087]  do_syscall_64+0xcc/0xaec
> [  361.014403][ T2087]  ? syscall_return_slowpath+0x580/0x580
> [  361.040377][ T2087]  ? lockdep_hardirqs_off+0x1f/0x140
> [  361.065174][ T2087]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
> [  361.092490][ T2087]  ? trace_hardirqs_off_caller+0x3a/0x150
> [  361.118190][ T2087]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  361.142857][ T2087]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  361.170379][ T2087] RIP: 0033:0x7fce5325e29b
> [  361.190363][ T2087] Code: 8b 15 f1 7b 2c 00 f7 d8 64 89 02 b8 ff ff ff ff c3
> 66 0f 1f 44 00 00 48 89 d6 e9 f0 fe ff ff f3 0f 1e fa b8 4c 00 00 00 0f 05 <48>
> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 b9 7b 2c 00 f7 d8
> [  361.282444][ T2087] RSP: 002b:00007ffcaffb4c38 EFLAGS: 00000202 ORIG_RAX:
> 000000000000004c
> [  361.322255][ T2087] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007fce5325e29b
> [  361.359334][ T2087] RDX: 00007fce5325f99d RSI: 0000000000000000 RDI:
> 00000000004130b9
> [  361.396627][ T2087] RBP: 0000000000000003 R08: 000000000000000a R09:
> 0000000000000003
> [  361.434859][ T2087] R10: 0000000000000000 R11: 0000000000000202 R12:
> 0000000000000003
> [  361.474800][ T2087] R13: 0000000000000001 R14: 0000000000000000 R15:
> 0000000000000000
> [  361.512852][ T2087] 
> [  361.523457][ T2087] Allocated by task 2083:
> [  361.544036][ T2087]  save_stack+0x21/0x50
> [  361.562984][ T2087]  __kasan_kmalloc.constprop.13+0xc1/0xd0
> [  361.589410][ T2087]  kasan_slab_alloc+0x11/0x20
> [  361.610633][ T2087]  kmem_cache_alloc+0x17a/0x450
> [  361.632837][ T2087]  locks_alloc_lock+0x1d/0xd0
> [  361.654579][ T2087]  lease_alloc+0x20/0x130
> [  361.673887][ T2087]  fcntl_setlease+0xaf/0x1e0
> [  361.695199][ T2087]  __x64_sys_fcntl+0x94a/0xb60
> [  361.717155][ T2087]  do_syscall_64+0xcc/0xaec
> [  361.737644][ T2087]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  361.764729][ T2087] 
> [  361.775198][ T2087] Freed by task 2083:
> [  361.794168][ T2087]  save_stack+0x21/0x50
> [  361.813911][ T2087]  __kasan_slab_free+0x11c/0x170
> [  361.837366][ T2087]  kasan_slab_free+0xe/0x10
> [  361.858468][ T2087]  slab_free_freelist_hook+0x5f/0x1d0
> [  361.882953][ T2087]  kmem_cache_free+0x10c/0x3a0
> [  361.905026][ T2087]  locks_dispose_list+0xad/0xd0
> [  361.927054][ T2087]  generic_setlease+0x828/0xe30
> [  361.951457][ T2087]  vfs_setlease+0x8c/0xa0
> [  361.973163][ T2087]  fcntl_setlease+0x1ad/0x1e0
> [  361.995721][ T2087]  __x64_sys_fcntl+0x94a/0xb60
> [  362.017353][ T2087]  do_syscall_64+0xcc/0xaec
> [  362.038223][ T2087]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  362.065559][ T2087] 
> [  362.075821][ T2087] The buggy address belongs to the object at
> ffff888fd0acc008
> [  362.075821][ T2087]  which belongs to the cache file_lock_cache of size 264
> [  362.143451][ T2087] The buggy address is located 0 bytes inside of
> [  362.143451][ T2087]  264-byte region [ffff888fd0acc008, ffff888fd0acc110)
> [  362.205154][ T2087] The buggy address belongs to the page:
> [  362.232197][ T2087] page:ffffea003f42b300 refcount:1 mapcount:0
> mapping:00000000e70f16de index:0x0
> [  362.273879][ T2087] flags: 0x15fffe000000200(slab)
> [  362.297515][ T2087] raw: 015fffe000000200 ffffea003f5ddf08 ffff889053bf8e20
> ffff88984f8c3400
> [  362.338031][ T2087] raw: 0000000000000000 0000000000060006 00000001ffffffff
> 0000000000000000
> [  362.378599][ T2087] page dumped because: kasan: bad access detected
> [  362.407940][ T2087] page_owner tracks the page as allocated
> [  362.434531][ T2087] page last allocated via order 0, migratetype Unmovable,
> gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY)
> [  362.493982][ T2087]  prep_new_page+0x2ed/0x310
> [  362.515922][ T2087]  get_page_from_freelist+0x2025/0x2e90
> [  362.541322][ T2087]  __alloc_pages_nodemask+0x2e4/0x700
> [  362.566329][ T2087]  alloc_pages_current+0x9c/0x110
> [  362.589311][ T2087]  alloc_slab_page+0x357/0x530
> [  362.611363][ T2087]  allocate_slab+0x70/0x5d0
> [  362.632301][ T2087]  new_slab+0x46/0x70
> [  362.650612][ T2087]  ___slab_alloc+0x4ab/0x7b0
> [  362.671494][ T2087]  __slab_alloc+0x43/0x70
> [  362.691555][ T2087]  kmem_cache_alloc+0x2dd/0x450
> [  362.713932][ T2087]  locks_alloc_lock+0x1d/0xd0
> [  362.735704][ T2087]  lease_alloc+0x20/0x130
> [  362.755482][ T2087]  fcntl_setlease+0xaf/0x1e0
> [  362.776381][ T2087]  __x64_sys_fcntl+0x94a/0xb60
> [  362.798513][ T2087]  do_syscall_64+0xcc/0xaec
> [  362.818924][ T2087]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  362.846972][ T2087] page last free stack trace:
> [  362.868599][ T2087]  free_pcp_prepare+0x4bb/0x4e0
> [  362.890769][ T2087]  free_unref_page+0x2c/0x90
> [  362.911891][ T2087]  __free_pages+0x82/0xd0
> [  362.931594][ T2087]  __free_slab+0x38b/0x550
> [  362.951740][ T2087]  discard_slab+0x41/0x80
> [  362.971974][ T2087]  __slab_free+0x4cc/0x540
> [  362.993900][ T2087]  ___cache_free+0xc3/0x120
> [  363.016145][ T2087]  qlist_free_all+0x44/0xa0
> [  363.037009][ T2087]  quarantine_reduce+0x1b0/0x240
> [  363.059732][ T2087]  __kasan_kmalloc.constprop.13+0x98/0xd0
> [  363.086580][ T2087]  kasan_slab_alloc+0x11/0x20
> [  363.107991][ T2087]  __kmalloc+0x154/0x420
> [  363.128161][ T2087]  kmem_alloc+0xed/0x2e0 [xfs]
> [  363.150357][ T2087]  xlog_cil_push+0xe2/0x8f0 [xfs]
> [  363.173591][ T2087]  xlog_cil_push_work+0x25/0x30 [xfs]
> [  363.198960][ T2087]  process_one_work+0x576/0xb90
> [  363.221388][ T2087] 
> [  363.231583][ T2087] Memory state around the buggy address:
> [  363.258150][ T2087]  ffff888fd0acbf00: 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00
> [  363.295743][ T2087]  ffff888fd0acbf80: 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00
> [  363.333798][ T2087] >ffff888fd0acc000: fc fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [  363.371567][ T2087]                       ^
> [  363.391401][ T2087]  ffff888fd0acc080: fb fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb
> [  363.428824][ T2087]  ffff888fd0acc100: fb fb fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  363.466684][ T2087]
> ==================================================================
> 
> [  645.191439][ T2701] kernel BUG at fs/locks.c:359!
> [  645.191451][ T2701] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> [  645.191459][ T2701] CPU: 21 PID: 2701 Comm: fcntl36 Tainted:
> G    B             5.6.0-rc5-next-20200311+ #2
> [  645.191462][ T2701] Hardware name: HP ProLiant BL660c Gen9, BIOS I38
> 10/17/2018
> [  645.191478][ T2701] RIP: 0010:locks_release_private+0x167/0x1a0
> [  645.191484][ T2701] Code: 00 00 00 00 00 5b 41 5c 41 5d 41 5e 5d c3 0f 0b 48
> c7 c7 60 77 22 8b e8 89 17 11 00 0f 0b 48 c7 c7 20 77 22 8b e8 7b 17 11 00 <0f>
> 0b 48 c7 c7 e0 76 22 8b e8 6d 17 11 00 0f 0b 48 c7 c7 a0 76 22
> [  645.191487][ T2701] RSP: 0018:ffffc9000f3afc48 EFLAGS: 00010206
> [  645.191493][ T2701] RAX: ffff889ef8b909e0 RBX: ffff889f4f3dc9a8 RCX:
> ffffffff89d5a9e7
> [  645.191496][ T2701] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI:
> ffff889f4f3dc9d0
> [  645.191500][ T2701] RBP: ffffc9000f3afc68 R08: fffffbfff16a631d R09:
> fffffbfff16a631d
> [  645.191503][ T2701] R10: ffffffff8b5318e7 R11: fffffbfff16a631c R12:
> ffff889f4f3dc9d0
> [  645.191507][ T2701] R13: 0000000000000000 R14: ffff889f3e808740 R15:
> 0000000000000007
> [  645.191511][ T2701] FS:  00007fa1c7e8b700(0000) GS:ffff88a02bb80000(0000)
> knlGS:0000000000000000
> [  645.191514][ T2701] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  645.191517][ T2701] CR2: 00007fa1c7e89e98 CR3: 0000000fc64d8001 CR4:
> 00000000001606e0
> [  645.191519][ T2701] Call Trace:
> [  645.191525][ T2701]  fcntl_setlk+0x208/0x670
> [  645.191531][ T2701]  ? fcntl_getlk+0x300/0x300
> [  645.191541][ T2701]  ? __kasan_check_write+0x14/0x20
> [  645.191550][ T2701]  __x64_sys_fcntl+0x707/0xb60
> [  645.191555][ T2701]  ? f_getown+0x70/0x70
> [  645.191565][ T2701]  ? lock_repin_lock+0x210/0x210
> [  645.191575][ T2701]  ? schedule+0xc9/0x160
> [  645.191580][ T2701]  ? lockdep_hardirqs_on+0x16/0x2a0
> [  645.191586][ T2701]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  645.191594][ T2701]  do_syscall_64+0xcc/0xaec
> [  645.191599][ T2701]  ? syscall_return_slowpath+0x580/0x580
> [  645.191604][ T2701]  ? lockdep_hardirqs_off+0x1f/0x140
> [  645.191608][ T2701]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
> [  645.191615][ T2701]  ? trace_hardirqs_off_caller+0x3a/0x150
> [  645.191619][ T2701]  ? trace_hardirqs_off_thunk+0x1a/0x1c
> [  645.191625][ T2701]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  645.191629][ T2701] RIP: 0033:0x7fa1c9f7d2f7
> [  645.191634][ T2701] Code: 00 00 00 89 74 24 0c 89 7c 24 08 48 89 14 24 e8 7f
> c5 01 00 48 8b 14 24 8b 74 24 0c 41 89 c0 8b 7c 24 08 b8 48 00 00 00 0f 05 <48>
> 3d 00 f0 ff ff 77 13 44 89 c7 89 04 24 e8 b6 c5 01 00 8b 04 24
> [  645.191636][ T2701] RSP: 002b:00007fa1c7e89dd0 EFLAGS: 00000293 ORIG_RAX:
> 0000000000000048
> [  645.191641][ T2701] RAX: ffffffffffffffda RBX: 000000000000000b RCX:
> 00007fa1c9f7d2f7
> [  645.191644][ T2701] RDX: 00007fa1c7e8aea0 RSI: 0000000000000007 RDI:
> 000000000000000b
> [  645.191648][ T2701] RBP: 00007fa1c7e8aef0 R08: 0000000000000000 R09:
> 00007fa1c7e89ea0
> [  645.191650][ T2701] R10: 0000000000000000 R11: 0000000000000293 R12:
> 000000000000000a
> [  645.191654][ T2701] R13: 00007ffcc4f29f10 R14: 0000000000002800 R15:
> 00007fa1c7e89ea0
> [  645.191658][ T2701] Modules linked in: kvm_intel kvm irqbypass intel_cstate
> intel_uncore intel_rapl_perf dax_pmem efivars dax_pmem_core nls_iso8859_1
> nls_cp437 vfat fat ip_tables x_tables xfs sd_mod bnx2x hpsa scsi_transport_sas
> mdio firmware_class dm_mirror dm_region_hash dm_log dm_mod efivarfs
> [  645.191769][ T2701] ---[ end trace 1c9d450d36050f6d ]---
> [  645.191776][ T2701] RIP: 0010:locks_release_private+0x167/0x1a0
> [  645.191781][ T2701] Code: 00 00 00 00 00 5b 41 5c 41 5d 41 5e 5d c3 0f 0b 48
> c7 c7 60 77 22 8b e8 89 17 11 00 0f 0b 48 c7 c7 20 77 22 8b e8 7b 17 11 00 <0f>
> 0b 48 c7 c7 e0 76 22 8b e8 6d 17 11 00 0f 0b 48 c7 c7 a0 76 22
> [  645.191783][ T2701] RSP: 0018:ffffc9000f3afc48 EFLAGS: 00010206
> [  645.191788][ T2701] RAX: ffff889ef8b909e0 RBX: ffff889f4f3dc9a8 RCX:
> ffffffff89d5a9e7
> [  645.191792][ T2701] RDX: dffffc0000000000 RSI: dffffc0000000000 RDI:
> ffff889f4f3dc9d0
> [  645.191795][ T2701] RBP: ffffc9000f3afc68 R08: fffffbfff16a631d R09:
> fffffbfff16a631d
> [  645.191798][ T2701] R10: ffffffff8b5318e7 R11: fffffbfff16a631c R12:
> ffff889f4f3dc9d0
> [  645.191801][ T2701] R13: 0000000000000000 R14: ffff889f3e808740 R15:
> 0000000000000007
> [  645.191805][ T2701] FS:  00007fa1c7e8b700(0000) GS:ffff88a02bb80000(0000)
> knlGS:0000000000000000
> [  645.191809][ T2701] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  645.191812][ T2701] CR2: 00007fa1c7e89e98 CR3: 0000000fc64d8001 CR4:
> 00000000001606e0
> [  645.191815][ T2701] Kernel panic - not syncing: Fatal exception
> [  645.216416][ T2698] kernel BUG at fs/locks.c:359!
> [  646.250771][ T2701] Shutting down cpus with NMI
> [  646.256823][ T2695] kernel BUG at fs/locks.c:359!
> [  646.279307][ T2701] Kernel Offset: 0x8800000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  647.362932][ T2701] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> 
> 
> 
> [ 1650.986440][T13230] LTP: starting fcntl33
> [ 1650.998106][T28398] ------------[ cut here ]------------
> [ 1650.998140][T28398] WARNING: CPU: 71 PID: 28398 at fs/locks.c:1667
> __break_lease+0xe1c/0x10d0
> [ 1650.998154][T28398] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1650.998200][T28398] CPU: 71 PID: 28398 Comm: fcntl33 Not tainted 5.6.0-rc5-
> next-20200311+ #4
> [ 1650.998225][T28398] NIP:  c00000000058dc1c LR: c00000000058d540 CTR:
> c00000000016fb60
> [ 1650.998238][T28398] REGS: c00020020e60f700 TRAP: 0700   Not tainted  (5.6.0-
> rc5-next-20200311+)
> [ 1650.998271][T28398] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44024274  XER: 00000000
> [ 1650.998323][T28398] CFAR: c00000000058d554 IRQMASK: 0 
> [ 1650.998323][T28398] GPR00: c00000000058d540 c00020020e60f990 c000000001659600
> 0000000000000000 
> [ 1650.998323][T28398] GPR04: c00020182a5c6728 0000000000000000 0000000000000000
> 0000000000000047 
> [ 1650.998323][T28398] GPR08: 0000000000000010 6b6b6b6b6b6b6b6b c000200789ceaa80
> 0000000000000007 
> [ 1650.998323][T28398] GPR12: 0000000000004000 c000201fff7f5c00 c00020182a5ccbf0
> 0000000000000001 
> [ 1650.998323][T28398] GPR16: c00000000058b140 c000000000b3bb00 c00020182a5c6788
> c000000000b085e0 
> [ 1650.998323][T28398] GPR20: c00000000158e068 c00000000168b5d4 c00000000168b328
> c0000000015f97e0 
> [ 1650.998323][T28398] GPR24: c0000000004b47ec c00020182a5ccbf8 c0002013001ae830
> c00020020e60fa10 
> [ 1650.998323][T28398] GPR28: c00020042b86d000 c00000000158df50 0000000000000000
> c00020182a5c6728 
> [ 1650.998545][T28398] NIP [c00000000058dc1c] __break_lease+0xe1c/0x10d0
> [ 1650.998577][T28398] LR [c00000000058d540] __break_lease+0x740/0x10d0
> [ 1650.998598][T28398] Call Trace:
> [ 1650.998616][T28398] [c00020020e60f990] [c00000000058d540]
> __break_lease+0x740/0x10d0 (unreliable)
> [ 1650.998653][T28398] [c00020020e60fae0] [c0000000004b47ec]
> do_dentry_open+0x21c/0x4f0
> [ 1650.998678][T28398] [c00020020e60fb30] [c0000000004d657c]
> path_openat+0x5bc/0xaa0
> [ 1650.998701][T28398] [c00020020e60fc10] [c0000000004d816c]
> do_filp_open+0x8c/0x120
> [ 1650.998735][T28398] [c00020020e60fd40] [c0000000004b51c8]
> do_sys_openat2+0x2c8/0x3c0
> [ 1650.998769][T28398] [c00020020e60fdc0] [c0000000004b6f2c]
> do_sys_open+0x6c/0xc0
> [ 1650.998815][T28398] [c00020020e60fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1650.998849][T28398] Instruction dump:
> [ 1650.998868][T28398] 60000000 7c0004ac e90d0028 3d22fff3 e9294a08 387d00c0
> 7d49402e 394affff 
> [ 1650.998905][T28398] 7d49412e 4bb810e9 60000000 4bfff9c4 <0fe00000> 4bfff938
> 0fe00000 4bfffd2c 
> [ 1650.998932][T28398] irq event stamp: 0
> [ 1650.998940][T28398] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [ 1650.998953][T28398] hardirqs last disabled at (0): [<c0000000001032b8>]
> copy_process+0x6e8/0x1900
> [ 1650.998989][T28398] softirqs last  enabled at (0): [<c0000000001032b8>]
> copy_process+0x6e8/0x1900
> [ 1650.999023][T28398] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 1650.999056][T28398] ---[ end trace 7fba05e648f90a7d ]---
> 
> [ 1651.863071][T13230] LTP: starting fcntl36
> [ 1657.143774][T28976] ------------[ cut here ]------------
> [ 1657.143807][T28976] kernel BUG at fs/locks.c:359!
> [ 1657.143819][T28976] Oops: Exception in kernel mode, sig: 5 [#1]
> [ 1657.143843][T28976] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1657.143858][T28976] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1657.143923][T28976] CPU: 108 PID: 28976 Comm: fcntl36 Tainted:
> G        W         5.6.0-rc5-next-20200311+ #4
> [ 1657.143954][T28976] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1657.143981][T28976] REGS: c0002003d19cf9e0 TRAP: 0700   Tainted:
> G        W          (5.6.0-rc5-next-20200311+)
> [ 1657.144008][T28976] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004884  XER: 20040000
> [ 1657.144018][T28973] ------------[ cut here ]------------
> [ 1657.144040][T28976] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1657.144040][T28976] GPR00: c000000000591a88 c0002003d19cfc70 c000000001659600
> c0002011d2f44b08 
> [ 1657.144040][T28976] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 000000000000006c 
> [ 1657.144040][T28976] GPR08: c000200d0b869fa0 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1657.144040][T28976] GPR12: 0000000000004000 c000201fff677680 00007fffacb10000
> 00007fffab820000 
> [ 1657.144040][T28976] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544868
> 000000001001d098 
> [ 1657.144040][T28976] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1657.144040][T28976] GPR24: 0000000000000002 0000000000000058 c0002013001ae830
> c00000000168b5d4 
> [ 1657.144040][T28976] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c0002011d2f44b08 
> [ 1657.144077][T28973] kernel BUG at fs/locks.c:359!
> [ 1657.144436][T28976] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1657.144463][T28979] ------------[ cut here ]------------
> [ 1657.144483][T28976] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1657.144486][T28976] Call Trace:
> [ 1657.144513][T28979] kernel BUG at fs/locks.c:359!
> [ 1657.144538][T28976] [c0002003d19cfc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1657.144631][T28976] [c0002003d19cfca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1657.144682][T28976] [c0002003d19cfd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1657.144731][T28976] [c0002003d19cfdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1657.144770][T28976] [c0002003d19cfe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1657.144794][T28976] Instruction dump:
> [ 1657.144804][T28976] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1657.144845][T28976] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1657.144899][T28976] ---[ end trace 7fba05e648f90a7e ]---
> 
> 
> [ 1657.300559][T28973] Oops: Exception in kernel mode, sig: 5 [#2]
> [ 1657.300596][T28973] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1657.300632][T28973] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1657.300732][T28973] CPU: 88 PID: 28973 Comm: fcntl36 Tainted: G      D
> W         5.6.0-rc5-next-20200311+ #4
> [ 1657.300792][T28973] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1657.300826][T28973] REGS: c000201aaaa8f9e0 TRAP: 0700   Tainted: G      D
> W          (5.6.0-rc5-next-20200311+)
> [ 1657.300953][T28973] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004808  XER: 20040000
> [ 1657.301065][T28973] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1657.301065][T28973] GPR00: c000000000591a88 c000201aaaa8fc70 c000000001659600
> c000200d0b8693b0 
> [ 1657.301065][T28973] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 0000000000000058 
> [ 1657.301065][T28973] GPR08: c000201835d26508 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1657.301065][T28973] GPR12: 0000000000004000 c000201fff697700 0000000045fc7188
> 00007fff7d260000 
> [ 1657.301065][T28973] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544850
> 000000001001d098 
> [ 1657.301065][T28973] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1657.301065][T28973] GPR24: 0000000000000002 0000000000000040 c0002013001ae830
> c00000000168b5d4 
> [ 1657.301065][T28973] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c000200d0b8693b0 
> [ 1657.301632][T28973] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1657.301678][T28973] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1657.301740][T28973] Call Trace:
> [ 1657.301820][T28973] [c000201aaaa8fc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1657.301930][T28973] [c000201aaaa8fca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1657.302040][T28973] [c000201aaaa8fd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1657.302102][T28973] [c000201aaaa8fdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1657.302185][T28973] [c000201aaaa8fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1657.302265][T28973] Instruction dump:
> [ 1657.302340][T28973] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1657.302418][T28973] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1657.302509][T28973] ---[ end trace 7fba05e648f90a7f ]---
> [ 1657.774513][T28973] 
> [ 1657.774573][T29054] Oops: Exception in kernel mode, sig: 5 [#3]
> [ 1657.774607][T29054] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1657.774627][T29054] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1657.774690][T29054] CPU: 127 PID: 29054 Comm: fcntl36 Tainted: G      D
> W         5.6.0-rc5-next-20200311+ #4
> [ 1657.774733][T29054] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1657.774773][T29054] REGS: c00020146166f9e0 TRAP: 0700   Tainted: G      D
> W          (5.6.0-rc5-next-20200311+)
> [ 1657.774814][T29054] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004888  XER: 20040000
> [ 1657.774864][T29054] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1657.774864][T29054] GPR00: c000000000591a88 c00020146166fc70 c000000001659600
> c0002011d2f4ab20 
> [ 1657.774864][T29054] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 000000000000007f 
> [ 1657.774864][T29054] GPR08: c0002018358610a8 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1657.774864][T29054] GPR12: 0000000000004000 c000201fff668900 00007fffacb10000
> 00007fff84340000 
> [ 1657.774864][T29054] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544ad8
> 000000001001d098 
> [ 1657.774864][T29054] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1657.774864][T29054] GPR24: 0000000000000002 00000000000002c8 c0002013001ae830
> c00000000168b5d4 
> [ 1657.774864][T29054] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c0002011d2f4ab20 
> [ 1657.775161][T29054] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1657.775187][T29054] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1657.775212][T29054] Call Trace:
> [ 1657.775238][T29054] [c00020146166fc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1657.775280][T29054] [c00020146166fca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1657.775331][T29054] [c00020146166fd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1657.775371][T29054] [c00020146166fdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1657.775412][T29054] [c00020146166fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1657.775450][T29054] Instruction dump:
> [ 1657.775475][T29054] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1657.775520][T29054] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1657.775578][T29054] ---[ end trace 7fba05e648f90a80 ]---
> [ 1657.878207][T29054] 
> [ 1657.878232][T29036] Oops: Exception in kernel mode, sig: 5 [#4]
> [ 1657.878249][T29036] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1657.878268][T29036] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1657.878436][T29036] CPU: 121 PID: 29036 Comm: fcntl36 Tainted: G      D
> W         5.6.0-rc5-next-20200311+ #4
> [ 1657.878573][T29036] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1657.878693][T29036] REGS: c0002016e558f9e0 TRAP: 0700   Tainted: G      D
> W          (5.6.0-rc5-next-20200311+)
> [ 1657.878810][T29036] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004804  XER: 20040000
> [ 1657.878998][T29036] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1657.878998][T29036] GPR00: c000000000591a88 c0002016e558fc70 c000000001659600
> c000201835d2e108 
> [ 1657.878998][T29036] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 0000000000000079 
> [ 1657.878998][T29036] GPR08: c00020028cb469b8 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1657.878998][T29036] GPR12: 0000000000004000 c000201fff66d400 00007fffacb10000
> 00007fff8d460000 
> [ 1657.878998][T29036] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544a48
> 000000001001d098 
> [ 1657.878998][T29036] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1657.878998][T29036] GPR24: 0000000000000002 0000000000000238 c0002013001ae830
> c00000000168b5d4 
> [ 1657.878998][T29036] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c000201835d2e108 
> [ 1657.879976][T29036] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1657.880054][T29036] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1657.880125][T29036] Call Trace:
> [ 1657.880163][T29036] [c0002016e558fc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1657.880277][T29036] [c0002016e558fca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1657.880387][T29036] [c0002016e558fd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1657.880468][T29036] [c0002016e558fdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1657.880550][T29036] [c0002016e558fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1657.880637][T29036] Instruction dump:
> [ 1657.880678][T29036] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1657.880792][T29036] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1657.880954][T29036] ---[ end trace 7fba05e648f90a81 ]---
> [ 1657.985193][T29036] 
> [ 1657.985226][T29051] Oops: Exception in kernel mode, sig: 5 [#5]
> [ 1657.985263][T29051] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1657.985304][T29051] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1657.985589][T29051] CPU: 75 PID: 29051 Comm: fcntl36 Tainted: G      D
> W         5.6.0-rc5-next-20200311+ #4
> [ 1657.985707][T29051] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1657.985827][T29051] REGS: c0002016e550f9e0 TRAP: 0700   Tainted: G      D
> W          (5.6.0-rc5-next-20200311+)
> [ 1657.985953][T29051] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004804  XER: 20040000
> [ 1657.986133][T29051] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1657.986133][T29051] GPR00: c000000000591a88 c0002016e550fc70 c000000001659600
> c000201c15980260 
> [ 1657.986133][T29051] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 000000000000004b 
> [ 1657.986133][T29051] GPR08: c0002018358641e0 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1657.986133][T29051] GPR12: 0000000000004000 c000201fff7f2a00 00007fffacb10000
> 00007fff85b70000 
> [ 1657.986133][T29051] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544ac0
> 000000001001d098 
> [ 1657.986133][T29051] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1657.986133][T29051] GPR24: 0000000000000002 00000000000002b0 c0002013001ae830
> c00000000168b5d4 
> [ 1657.986133][T29051] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c000201c15980260 
> [ 1657.987072][T29051] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1657.987253][T29051] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1657.987344][T29051] Call Trace:
> [ 1657.987385][T29051] [c0002016e550fc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1657.987514][T29051] [c0002016e550fca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1657.987620][T29051] [c0002016e550fd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1657.987715][T29051] [c0002016e550fdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1657.987828][T29051] [c0002016e550fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1657.987915][T29051] Instruction dump:
> [ 1657.987960][T29051] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1657.988090][T29051] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1657.988209][T29051] ---[ end trace 7fba05e648f90a82 ]---
> [ 1658.093951][T29051] 
> [ 1658.093981][T29006] Oops: Exception in kernel mode, sig: 5 [#6]
> [ 1658.094025][T29006] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256
> DEBUG_PAGEALLOC NUMA PowerNV
> [ 1658.094087][T29006] Modules linked in: brd ext4 crc16 mbcache jbd2 loop
> ip_tables x_tables xfs sd_mod bnx2x tg3 mdio ahci libahci libphy firmware_class
> libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1658.094394][T29006] CPU: 82 PID: 29006 Comm: fcntl36 Tainted: G      D
> W         5.6.0-rc5-next-20200311+ #4
> [ 1658.094590][T29006] NIP:  c000000000588808 LR: c000000000591a88 CTR:
> 0000000000000000
> [ 1658.094684][T29006] REGS: c0002007f0a0f9e0 TRAP: 0700   Tainted: G      D
> W          (5.6.0-rc5-next-20200311+)
> [ 1658.094820][T29006] MSR:  900000000282b033
> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44004808  XER: 20040000
> [ 1658.095017][T29006] CFAR: c000000000591a84 IRQMASK: 0 
> [ 1658.095017][T29006] GPR00: c000000000591a88 c0002007f0a0fc70 c000000001659600
> c000200153127538 
> [ 1658.095017][T29006] GPR04: c00000000168b330 0000000000000000 0000000000000000
> 0000000000000052 
> [ 1658.095017][T29006] GPR08: c0002009200a9898 0000000000000001 0000000000000001
> 0000000000000000 
> [ 1658.095017][T29006] GPR12: 0000000000004000 c000201fff69c200 00007fffacb10000
> 00007fff9c640000 
> [ 1658.095017][T29006] GPR16: 00007fffaca94410 00007fffaca94420 00007ffff6544958
> 000000001001d098 
> [ 1658.095017][T29006] GPR20: 000000001001d088 000000001001d060 0000000010040560
> 0000000000000001 
> [ 1658.095017][T29006] GPR24: 0000000000000002 0000000000000148 c0002013001ae830
> c00000000168b5d4 
> [ 1658.095017][T29006] GPR28: 0000000000000000 c00000000168b328 0000000000000008
> c000200153127538 
> [ 1658.096113][T29006] NIP [c000000000588808] locks_release_private+0x58/0x120
> [ 1658.096263][T29006] LR [c000000000591a88] fcntl_setlk+0x158/0x600
> [ 1658.096366][T29006] Call Trace:
> [ 1658.096417][T29006] [c0002007f0a0fc70] [c0000000009a9950]
> _raw_spin_unlock+0x30/0x70 (unreliable)
> [ 1658.096573][T29006] [c0002007f0a0fca0] [c000000000591c18]
> fcntl_setlk+0x2e8/0x600
> [ 1658.096678][T29006] [c0002007f0a0fd40] [c0000000004da940]
> do_fcntl+0x650/0xa80
> [ 1658.096768][T29006] [c0002007f0a0fdd0] [c0000000004db1c8]
> sys_fcntl+0x78/0x110
> [ 1658.096880][T29006] [c0002007f0a0fe20] [c00000000000b378]
> system_call+0x5c/0x68
> [ 1658.096998][T29006] Instruction dump:
> [ 1658.097049][T29006] 7fa94000 7d20579e 0b090000 7c691b78 e9090009 7fa94000
> 7d20579e 0b090000 
> [ 1658.097239][T29006] e9030028 39230028 7fa94000 7d20579e <0b090000> e9030038
> 39230038 7fa94000 
> [ 1658.097374][T29006] ---[ end trace 7fba05e648f90a83 ]---
> [ 1658.300668][T28976] Kernel panic - not syncing: Fatal exception
> 
> [  812.828970][ T5544] ------------[ cut here ]------------
> [  812.832371][ T5547] ------------[ cut here ]------------
> [  812.834321][ T5544] kernel BUG at fs/locks.c:359!
> [  812.836280][ T5550] ------------[ cut here ]------------
> [  812.836292][ T5550] kernel BUG at fs/locks.c:359!
> [  812.836302][ T5550] Internal error: Oops - BUG: 0 [#1] SMP
> [  812.836310][ T5550] Modules linked in: thunderx2_pmu processor ip_tables xfs
> libcrc32c sd_mod ahci libahci mlx5_core libata dm_mirror dm_region_hash dm_log
> dm_mod efivarfs
> [  812.836372][ T5550] CPU: 56 PID: 5550 Comm: fcntl36 Tainted:
> G             L    5.6.0-rc5-next-20200311+ #3
> [  812.836379][ T5550] Hardware name: HPE Apollo
> 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  812.836391][ T5550] pstate: 20400009 (nzCv daif +PAN -UAO)
> [  812.836409][ T5550] pc : locks_release_private+0x190/0x1b8
> [  812.836418][ T5550] lr : locks_release_private+0x54/0x1b8
> [  812.836423][ T5550] sp : 44ff009524ecfce0
> [  812.836430][ T5550] x29: 44ff009524ecfd00 x28: 8fff00082bc07340 
> [  812.836442][ T5550] x27: 11ff0088239a8f08 x26: 0000000000000007 
> [  812.836454][ T5550] x25: 74ff000a4c282284 x24: 0000000000000000 
> [  812.836465][ T5550] x23: 0000000000000001 x22: 0000000000000000 
> [  812.836476][ T5550] x21: b9ff008bbe1452d8 x20: 74ff000a4c282258 
> [  812.836488][ T5550] x19: 74ff000a4c282230 x18: 0000000000000000 
> [  812.836499][ T5550] x17: 0000000000000000 x16: 0000000000000000 
> [  812.836510][ T5550] x15: 0000000000000000 x14: 000000000000e8e8 
> [  812.836521][ T5550] x13: 00000000abc00dd2 x12: ffff900010083524 
> [  812.836532][ T5550] x11: 0000000000000074 x10: ffff8000a4c28226 
> [  812.836543][ T5550] x9 : ffff8000a4c28225 x8 : 61ff009523ee0ac8 
> [  812.836555][ T5550] x7 : ffff900010530d1c x6 : 0000000000000000 
> [  812.836565][ T5550] x5 : 0000000000000000 x4 : 0000000000000001 
> [  812.836576][ T5550] x3 : ffff90001052c138 x2 : 0000000000000000 
> [  812.836588][ T5550] x1 : 0000000000000008 x0 : ffff900013063530 
> [  812.836599][ T5550] Call trace:
> [  812.836611][ T5550]  locks_release_private+0x190/0x1b8
> [  812.836620][ T5550]  fcntl_setlk+0x2d0/0x5d4
> [  812.836631][ T5550]  do_fcntl+0xb40/0x17c8
> [  812.836640][ T5550]  __arm64_sys_fcntl+0x84/0xf4
> [  812.836650][ T5550]  do_el0_svc+0x170/0x240
> [  812.836660][ T5550]  el0_sync_handler+0x150/0x250
> [  812.836668][ T5550]  el0_sync+0x164/0x180
> [  812.836685][ T5550] Code: d4210000 94046846 f00159a0 9114c000 (d4210000) 
> [  812.837092][ T5550] ---[ end trace 2e670f80ae21d9a2 ]---
> [  812.837101][ T5550] Kernel panic - not syncing: Fatal exception
> [  812.837409][ T5550] SMP: stopping secondary CPUs
> [  812.839632][ T5547] kernel BUG at fs/locks.c:359!
> [  813.907661][ T5550] SMP: failed to stop secondary CPUs 0,56,130
> [  813.913586][ T5550] Kernel Offset: disabled
> [  813.917771][ T5550] CPU features: 0x06002,61000c18
> [  813.922561][ T5550] Memory Limit: none
> [  813.926619][ T5550] ---[ end Kernel panic - not syncing: Fatal exception ]---

My apologies for not seeing this mail sooner. This should be fixed by
the version in the current linux-next branch. Please let me know if
you're still seeing this.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

