Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E77B1B87C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDYQr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 12:47:29 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:49432 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgDYQr3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:47:29 -0400
Received: from comp-core-i7-2640m-0182e6 (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 998A1209B8;
        Sat, 25 Apr 2020 16:46:36 +0000 (UTC)
Date:   Sat, 25 Apr 2020 18:46:32 +0200
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: out-of-bounds in pid_nr_ns() due to "proc: modernize proc to
 support multiple private instances"
Message-ID: <20200425164632.lutodivpbng7wofw@comp-core-i7-2640m-0182e6>
References: <06B50A1C-406F-4057-BFA8-3A7729EA7469@lca.pw>
 <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B818B796-3A09-46B9-B6CE-4EB047567755@lca.pw>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Sat, 25 Apr 2020 16:47:26 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:11:48PM -0400, Qian Cai wrote:
> Eric, Stephen, can you pull out this series while Alexey is getting to the bottom of this slab-out-of-bounds?

Hi! I fixed this in the new version (v13) of my patch set.

https://lore.kernel.org/lkml/20200423200316.164518-1-gladkov.alexey@gmail.com/

> > On Apr 22, 2020, at 3:35 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > Reverted the whole series from linux-next,
> > 
> > 20d3928579da proc: use named enums for better readability
> > e9fc842e1fb6 proc: use human-readable values for hidepid
> > 3ef9b8afc054 docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior
> > f1031df957fa proc: add option to mount only a pids subset
> > 9153c0921a1e proc: instantiate only pids that we can ptrace on 'hidepid=4' mount option
> > 1ef97cee07dd proc: allow to mount many instances of proc in one pid namespace
> > 39f8e6256b4b proc: rename struct proc_fs_info to proc_fs_opts 
> > 
> > fixed out-of-bounds in pid_nr_ns() while reading proc files.
> > 
> > === arm64 ===
> > [12140.366814] LTP: starting proc01 (proc01 -m 128)
> > [12149.580943] ==================================================================
> > [12149.589521] BUG: KASAN: out-of-bounds in pid_nr_ns+0x2c/0x90
> > pid_nr_ns at kernel/pid.c:456
> > [12149.595939] Read of size 4 at addr 1bff000bfa8c0388 by task proc01/50298
> > [12149.603392] Pointer tag: [1b], memory tag: [fe]
> > 
> > [12149.610906] CPU: 69 PID: 50298 Comm: proc01 Tainted: G             L    5.7.0-rc2-next-20200422 #6
> > [12149.620585] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> > [12149.631074] Call trace:
> > [12149.634304]  dump_backtrace+0x0/0x22c
> > [12149.638745]  show_stack+0x28/0x34
> > [12149.642839]  dump_stack+0x104/0x194
> > [12149.647110]  print_address_description+0x70/0x3a4
> > [12149.652576]  __kasan_report+0x188/0x238
> > [12149.657169]  kasan_report+0x3c/0x58
> > [12149.661430]  check_memory_region+0x98/0xa0
> > [12149.666303]  __hwasan_load4_noabort+0x18/0x20
> > [12149.671431]  pid_nr_ns+0x2c/0x90
> > [12149.675446]  locks_translate_pid+0xf4/0x1a0
> > [12149.680382]  locks_show+0x68/0x110
> > [12149.684536]  seq_read+0x380/0x930
> > [12149.688604]  pde_read+0x5c/0x78
> > [12149.692498]  proc_reg_read+0x74/0xc0
> > [12149.696813]  __vfs_read+0x84/0x1d0
> > [12149.700939]  vfs_read+0xec/0x124
> > [12149.704889]  ksys_read+0xb0/0x120
> > [12149.708927]  __arm64_sys_read+0x54/0x88
> > [12149.713485]  do_el0_svc+0x128/0x1dc
> > [12149.717697]  el0_sync_handler+0x150/0x250
> > [12149.722428]  el0_sync+0x164/0x180
> > 
> > [12149.728672] Allocated by task 1:
> > [12149.732624]  __kasan_kmalloc+0x124/0x188
> > [12149.737269]  kasan_kmalloc+0x10/0x18
> > [12149.741568]  kmem_cache_alloc_trace+0x2e4/0x3d4
> > [12149.746820]  proc_fill_super+0x48/0x1fc
> > [12149.751377]  vfs_get_super+0xcc/0x170
> > [12149.755760]  get_tree_nodev+0x28/0x34
> > [12149.760143]  proc_get_tree+0x24/0x30
> > [12149.764439]  vfs_get_tree+0x54/0x158
> > [12149.768736]  do_mount+0x80c/0xaf0
> > [12149.772774]  __arm64_sys_mount+0xe0/0x18c
> > [12149.777504]  do_el0_svc+0x128/0x1dc
> > [12149.781715]  el0_sync_handler+0x150/0x250
> > [12149.786445]  el0_sync+0x164/0x180
> > 
> > [12149.792687] Freed by task 0:
> > [12149.796285] (stack is not available)
> > 
> > [12149.802792] The buggy address belongs to the object at ffff000bfa8c0300
> >                which belongs to the cache kmalloc-128 of size 128
> > [12149.816727] The buggy address is located 8 bytes to the right of
> >                128-byte region [ffff000bfa8c0300, ffff000bfa8c0380)
> > [12149.830223] The buggy address belongs to the page:
> > [12149.835740] page:ffffffe002dea300 refcount:1 mapcount:0 mapping:0000000037c9e9b5 index:0x31ff000bfa8c9e00
> > [12149.846027] flags: 0x5ffffffe000200(slab)
> > [12149.850765] raw: 005ffffffe000200 ffffffe022175788 ffffffe02215b788 17ff0087a0020480
> > [12149.859232] raw: 31ff000bfa8c9e00 0000000000660065 00000001ffffffff 0000000000000000
> > [12149.867693] page dumped because: kasan: bad access detected
> > [12149.873984] page_owner tracks the page as allocated
> > [12149.879585] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY)
> > [12149.891438]  post_alloc_hook+0x94/0xd4
> > [12149.895908]  prep_new_page+0x34/0xcc
> > [12149.900206]  get_page_from_freelist+0x4c4/0x60c
> > [12149.905458]  __alloc_pages_nodemask+0x1c0/0x2e8
> > [12149.910712]  alloc_page_interleave+0x38/0x18c
> > [12149.915791]  alloc_pages_current+0x80/0xe0
> > [12149.920610]  alloc_slab_page+0x154/0x3b4
> > [12149.925254]  new_slab+0xc8/0x5f4
> > [12149.929203]  ___slab_alloc+0x248/0x440
> > [12149.933675]  kmem_cache_alloc_trace+0x368/0x3d4
> > [12149.938928]  ftrace_free_mem+0x258/0x7ac
> > [12149.943575]  ftrace_free_init_mem+0x20/0x28
> > [12149.948482]  kernel_init+0x1c/0x204
> > [12149.952692]  ret_from_fork+0x10/0x18
> > [12149.956986] page_owner free stack trace missing
> > 
> > [12149.964443] Memory state around the buggy address:
> > [12149.969956]  ffff000bfa8c0100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > [12149.977899]  ffff000bfa8c0200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > [12149.985841] >ffff000bfa8c0300: 1b 1b 1b fe fe fe fe fe fe fe fe fe fe fe fe fe
> > [12149.993781]                                            ^
> > [12149.999814]  ffff000bfa8c0400: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
> > [12150.007757]  ffff000bfa8c0500: fe fe fe fe fe fe fe fe 6c 6c 6c 6c 6c 6c 6c 6c
> > [12150.015697] ==================================================================
> > [12150.023638] Disabling lock debugging due to kernel taint
> > 
> > === s390 ===
> > [14452.527006] LTP: starting proc01 (proc01 -m 128)
> > [14455.663026] ==================================================================
> > [14455.664078] BUG: KASAN: slab-out-of-bounds in pid_nr_ns+0x34/0xa8
> > [14455.664120] Read of size 4 at addr 000000000dabacc8 by task proc01/41628
> > 
> > [14455.664205] CPU: 1 PID: 41628 Comm: proc01 Not tainted 5.7.0-rc2-next-20200422 #2
> > [14455.664248] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
> > [14455.664288] Call Trace:
> > [14455.664335]  [<00000000084be28a>] show_stack+0x11a/0x1c8 
> > [14455.664382]  [<0000000008b147f4>] dump_stack+0x134/0x180 
> > [14455.664434]  [<00000000088b56c4>] print_address_description.isra.9+0x5c/0x3e8 
> > [14455.664480]  [<00000000088b5cac>] __kasan_report+0x114/0x140 
> > [14455.664523]  [<00000000088b4bf4>] kasan_report+0x4c/0x58 
> > [14455.666150]  [<0000000008532a24>] pid_nr_ns+0x34/0xa8 
> > [14455.666203]  [<00000000089ee806>] locks_translate_pid+0xee/0x1c8 
> > [14455.666246]  [<00000000089eeea4>] locks_show+0x84/0x130 
> > [14455.666295]  [<0000000008958c3e>] seq_read+0x25e/0x7f0 
> > [14455.666343]  [<0000000008a14e70>] proc_reg_read+0x100/0x168 
> > [14455.666389]  [<000000000890fa22>] vfs_read+0x92/0x150 
> > [14455.666432]  [<000000000890feda>] ksys_read+0xe2/0x188 
> > [14455.666483]  [<0000000008e671d0>] system_call+0xd8/0x2b4 
> > [14455.666525] 5 locks held by proc01/41628:
> > [14455.666562]  #0: 000000003e0e0c10 (&p->lock){+.+.}-{3:3}, at: seq_read+0x5e/0x7f0
> > [14455.666630]  #1: 00000000095deff0 (file_rwsem){++++}-{0:0}, at: locks_start+0x66/0x98
> > [14455.666695]  #2: 00000000095deed8 (blocked_lock_lock){+.+.}-{2:2}, at: locks_start+0x72/0x98
> > [14455.673879]  #3: 0000000009393b60 (rcu_read_lock){....}-{1:2}, at: locks_translate_pid+0x5e/0x1c8
> > [14455.673967]  #4: 00000000095367d0 (report_lock){....}-{2:2}, at: __kasan_report+0x6e/0x140
> > 
> > [14455.674077] Allocated by task 1:
> > [14455.674128]  stack_trace_save+0xba/0xd0
> > [14455.674169]  save_stack+0x30/0x58
> > [14455.674211]  __kasan_kmalloc.isra.19+0xd4/0xe8
> > [14455.674253]  kmem_cache_alloc_trace+0x246/0x390
> > [14455.674296]  proc_fill_super+0x60/0x2e0
> > [14455.674339]  vfs_get_super+0x10a/0x1a8
> > [14455.674379]  vfs_get_tree+0x5e/0x158
> > [14455.674424]  do_mount+0xbd2/0xe28
> > [14455.674465]  __s390x_sys_mount+0xe2/0xf8
> > [14455.674509]  system_call+0xd8/0x2b4
> > 
> > [14455.674582] Freed by task 1:
> > [14455.674622]  stack_trace_save+0xba/0xd0
> > [14455.674663]  save_stack+0x30/0x58
> > [14455.674704]  __kasan_slab_free+0x130/0x198
> > [14455.674745]  slab_free_freelist_hook+0x7a/0x240
> > [14455.674786]  kfree+0x10a/0x508
> > [14455.674831]  __kthread_create_on_node+0x206/0x2f0
> > [14455.674873]  kthread_create_on_node+0xa0/0xb8
> > [14455.674915]  init_rescuer.part.13+0x66/0xf8
> > [14455.674966]  workqueue_init+0x40e/0x658
> > [14455.675010]  kernel_init_freeable+0x21e/0x590
> > [14455.675056]  kernel_init+0x22/0x180
> > [14455.675096]  ret_from_fork+0x30/0x34
> > 
> > [14455.675296] The buggy address belongs to the object at 000000000dabac40
> >                which belongs to the cache kmalloc-64 of size 64
> > [14455.675345] The buggy address is located 72 bytes to the right of
> >                64-byte region [000000000dabac40, 000000000dabac80)
> > [14455.675391] The buggy address belongs to the page:
> > [14455.675441] page:000003d08036ae80 refcount:1 mapcount:0 mapping:00000000c06a91d7 index:0xdabae40
> > [14455.675489] flags: 0x1fffe00000000200(slab)
> > [14455.675536] raw: 1fffe00000000200 000003d0817ad788 000003d080c04908 000000000ff8c600
> > [14455.675582] raw: 000000000dabae40 0006001000000000 ffffffff00000001 0000000000000000
> > [14455.675624] page dumped because: kasan: bad access detected
> > [14455.675666] page_owner tracks the page as allocated
> > [14455.675707] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x0()
> > [14455.675753]  stack_trace_save+0xba/0xd0
> > [14455.675797]  register_early_stack+0x8c/0xb8
> > [14455.675840]  init_page_owner+0x60/0x510
> > [14455.675881]  kernel_init_freeable+0x278/0x590
> > [14455.675919] page_owner free stack trace missing
> > 
> > [14455.675993] Memory state around the buggy address:
> > [14455.676034]  000000000dabab80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [14455.676078]  000000000dabac00: fc fc fc fc fc fc fc fc 00 00 00 00 00 fc fc fc
> > [14455.676122] >000000000dabac80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [14455.676171]                                               ^
> > [14455.676213]  000000000dabad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [14455.676257]  000000000dabad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > [14455.676299] ==================================================================
> > [14455.676339] Disabling lock debugging due to kernel taint
> > 
> > 
> 

-- 
Rgrds, legion

