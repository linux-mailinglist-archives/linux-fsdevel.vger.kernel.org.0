Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A235BC255
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 06:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiISEuN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISEuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:50:10 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED164DEFD;
        Sun, 18 Sep 2022 21:50:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-149-49.pa.vic.optusnet.com.au [49.186.149.49])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 09FA41100976;
        Mon, 19 Sep 2022 14:50:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oa8jL-009Tlv-Ii; Mon, 19 Sep 2022 14:50:03 +1000
Date:   Mon, 19 Sep 2022 14:50:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org,
        dan.j.williams@intel.com
Subject: Re: [RFC PATCH] xfs: drop experimental warning for fsdax
Message-ID: <20220919045003.GJ3600936@dread.disaster.area>
References: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=6327f4ff
        a=XTRC1Ovx3SkpaCW1YxGVGA==:117 a=XTRC1Ovx3SkpaCW1YxGVGA==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=omOdbC7AAAAA:8 a=7-415B0cAAAA:8
        a=cZ0BD_UQd1uDEiw8krIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 15, 2022 at 09:26:42AM +0000, Shiyang Ruan wrote:
> Since reflink&fsdax can work together now, the last obstacle has been
> resolved.  It's time to remove restrictions and drop this warning.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

I haven't looked at reflink+DAX for some time, and I haven't tested
it for even longer. So I'm currently running a v6.0-rc6 kernel with
"-o dax=always" fstests run with reflink enabled and it's not
looking very promising.

All of the fsx tests are failing with data corruption, several
reflink/clone tests are failing with -EINVAL (e.g. g/16[45]) and
*lots* of tests are leaving stack traces from WARN() conditions in
DAx operations such as dax_insert_entry(), dax_disassociate_entry(),
dax_writeback_mapping_range(), iomap_iter() (called from
dax_dedupe_file_range_compare()), and so on.

At thsi point - the tests are still running - I'd guess that there's
going to be at least 50 test failures by the time it completes -
in comparison using "-o dax=never" results in just a single test
failure and a lot more tests actually being run.

Given that a non-reflink DAX filesystem doesn't seem to have all
these problems, it's pointing to the dax+reflink interactions still
containing various bugs. Unless I'm doing something obviously wrong
that causes all these problems, I really don't think this code is
production ready.

We really need reflink enabled DAX filesystems to pass fstests
cleanly before we can remove the experimental tag, so if you've got
any ideas what is causing the stack traces and data corruptions
below, I'm all ears...

-Dave.

Example 1:

[22204.239656] run fstests xfs/013 at 2022-09-19 14:11:02
[22205.282787] XFS (pmem1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[22205.284976] XFS (pmem1): Mounting V5 Filesystem
[22205.291254] XFS (pmem1): Ending clean mount
[22205.296381] XFS (pmem1): Unmounting Filesystem
[22205.366439] XFS (pmem1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[22205.368682] XFS (pmem1): Mounting V5 Filesystem
[22205.373097] XFS (pmem1): Ending clean mount
[22318.643280] ------------[ cut here ]------------
[22318.644658] WARNING: CPU: 0 PID: 1548358 at fs/dax.c:380 dax_insert_entry+0x2ab/0x320
[22318.646728] Modules linked in:
[22318.647571] CPU: 0 PID: 1548358 Comm: fsstress Tainted: G        W          6.0.0-rc6-dgc+ #1543
[22318.649869] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[22318.652035] RIP: 0010:dax_insert_entry+0x2ab/0x320
[22318.653328] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 84 b1 5a 00 eb a4 48 81 e6
[22318.657862] RSP: 0000:ffffc900111ffb78 EFLAGS: 00010002
[22318.659085] RAX: ffffea0018100600 RBX: 0000000000000001 RCX: 0000000000000001
[22318.660741] RDX: ffffea0000000000 RSI: 0000000000000221 RDI: ffffea0018100640
[22318.662377] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
[22318.663953] R10: ffff88838b8f3518 R11: 0000000000000001 R12: ffffc900111ffc58
[22318.665550] R13: ffff88838b8f3518 R14: ffffc900111ffe20 R15: 0000000000000000
[22318.667042] FS:  00007fc5af1f0b80(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
[22318.668751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22318.669960] CR2: 00007fc5af1e5000 CR3: 0000000120a30004 CR4: 0000000000060ef0
[22318.671407] Call Trace:
[22318.671918]  <TASK>
[22318.672370]  dax_fault_iter+0x243/0x600
[22318.673175]  dax_iomap_pte_fault+0x199/0x360
[22318.674058]  __xfs_filemap_fault+0x1e3/0x2c0
[22318.674940]  __do_fault+0x31/0x1d0
[22318.675651]  __handle_mm_fault+0xd6d/0x1650
[22318.676504]  ? do_mmap+0x348/0x540
[22318.677223]  handle_mm_fault+0x7a/0x1d0
[22318.678011]  ? __kvm_handle_async_pf+0x12/0xb0
[22318.678931]  exc_page_fault+0x1d9/0x810
[22318.679714]  asm_exc_page_fault+0x22/0x30
[22318.680531] RIP: 0033:0x7fc5af299c23
[22318.681282] Code: 47 10 f3 0f 7f 44 17 e0 f3 0f 7f 47 20 f3 0f 7f 44 17 d0 f3 0f 7f 47 30 f3 0f 7f 44 17 c0 48 01 fa 48 83 e2 c0 48 39 d1 74 c0 <66> 0f 7f 01 66 0f 7f 41 10 66 0f 7f 41 20 66 0f 7f 41 30 48 83 c1
[22318.684968] RSP: 002b:00007ffda7a10968 EFLAGS: 00010206
[22318.686025] RAX: 00007fc5af1df000 RBX: 00000000004c4b40 RCX: 00007fc5af1e5000
[22318.687460] RDX: 00007fc5af1ef000 RSI: 000000000000009c RDI: 00007fc5af1df000
[22318.688889] RBP: 000000000021b000 R08: 0000000000000000 R09: 000000000021b000
[22318.690331] R10: 0000000000000008 R11: 0000000000000246 R12: 000000000001002d
[22318.691754] R13: 8f5c28f5c28f5c29 R14: 0000000000000cf0 R15: 0000559cb18f8a30
[22318.693187]  </TASK>
[22318.693647] ---[ end trace 0000000000000000 ]---
[22329.938572] ------------[ cut here ]------------
[22329.940847] WARNING: CPU: 3 PID: 1548359 at fs/dax.c:404 dax_disassociate_entry+0x4f/0xb0
[22329.944510] Modules linked in:
[22329.946006] CPU: 3 PID: 1548359 Comm: fsstress Tainted: G        W          6.0.0-rc6-dgc+ #1543
[22329.950190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[22329.954167] RIP: 0010:dax_disassociate_entry+0x4f/0xb0
[22329.956722] Code: ba 00 00 00 00 00 ea ff ff 48 c1 e0 06 48 8d 9e 00 02 00 00 48 01 d0 48 89 f2 4c 8d 5e 01 eb 24 4c 39 d1 74 07 48 85 c9 74 02 <0f> 0b 48 c7 40 18 00 00 00 00 48 c7 40 20 00 00 00 00 48 83 c2 01
[22329.965158] RSP: 0018:ffffc90010573a98 EFLAGS: 00010086
[22329.967588] RAX: ffffea001c666c80 RBX: 0000000000719bb2 RCX: ffff8882c5572618
[22329.970851] RDX: 00000000007199b2 RSI: 00000000007199b2 RDI: 0000000000000000
[22329.973898] RBP: 000000000e333641 R08: 0000000000000001 R09: 0000000000000000
[22329.977060] R10: ffff8881e54f5318 R11: 00000000007199b3 R12: 0000000000000001
[22329.980058] R13: 0000000000000000 R14: 0000000000000001 R15: 000000000e333641
[22329.982888] FS:  00007fc5af1f0b80(0000) GS:ffff888237d80000(0000) knlGS:0000000000000000
[22329.986097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22329.988303] CR2: 0000559cb198eb20 CR3: 000000010b004004 CR4: 0000000000060ee0
[22329.990846] Call Trace:
[22329.991813]  <TASK>
[22329.992566]  __dax_invalidate_entry+0x93/0x140
[22329.994127]  dax_delete_mapping_entry+0xf/0x20
[22329.995651]  truncate_folio_batch_exceptionals.part.0+0x1e8/0x210
[22329.997686]  truncate_inode_pages_range+0xdd/0x520
[22329.999319]  ? down_read+0x1a/0x110
[22330.000459]  ? unmap_mapping_range+0x70/0x140
[22330.001800]  truncate_pagecache+0x44/0x60
[22330.002855]  xfs_setattr_size+0x164/0x480
[22330.004093]  xfs_vn_setattr+0x78/0x140
[22330.005240]  notify_change+0x315/0x570
[22330.006385]  ? avc_has_perm_noaudit+0x90/0x110
[22330.007736]  ? cp_new_stat+0x150/0x180
[22330.008953]  ? do_truncate+0x7d/0xd0
[22330.010028]  do_truncate+0x7d/0xd0
[22330.010922]  vfs_truncate+0x12a/0x160
[22330.012002]  do_sys_truncate.part.0+0x8a/0xa0
[22330.013208]  do_syscall_64+0x35/0x80
[22330.014237]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[22330.015592] RIP: 0033:0x7fc5af2e7eb7
[22330.016532] Code: 48 8b 4c 24 28 64 48 2b 0c 25 28 00 00 00 75 05 48 83 c4 38 c3 e8 c9 61 01 00 66 0f 1f 84 00 00 00 00 00 b8 4c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 09 69 0c 00 f7 d8 64 89 02 b8
[22330.021406] RSP: 002b:00007ffda7a10918 EFLAGS: 00000202 ORIG_RAX: 000000000000004c
[22330.023392] RAX: ffffffffffffffda RBX: 00007ffda7a10a70 RCX: 00007fc5af2e7eb7
[22330.025280] RDX: 000000000072ce0a RSI: 000000000072ce0a RDI: 0000559cb19d2320
[22330.027103] RBP: 000000000072ce0a R08: 000000000000006e R09: 00007ffda7a10a6c
[22330.028828] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000056e3
[22330.030423] R13: 0000000000000000 R14: 000000000072ce0a R15: 0000559cb18f6fd0
[22330.032275]  </TASK>
[22330.032886] ---[ end trace 0000000000000000 ]---

Example 2:

[21734.636758] run fstests generic/648 at 2022-09-19 14:03:13
[21735.560616] XFS (pmem1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[21735.562436] XFS (pmem1): Mounting V5 Filesystem
[21735.566584] XFS (pmem1): Ending clean mount
[21735.582422] XFS (pmem1): Unmounting Filesystem
[21735.769107] run fstests generic/649 at 2022-09-19 14:03:14
[21737.192943] ------------[ cut here ]------------
[21737.194955] WARNING: CPU: 5 PID: 1396611 at fs/dax.c:923 dax_writeback_mapping_range+0x2f2/0x5e0
[21737.198197] Modules linked in:
[21737.199356] CPU: 5 PID: 1396611 Comm: xfs_io Tainted: G        W          6.0.0-rc6-dgc+ #1543
[21737.202483] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[21737.205507] RIP: 0010:dax_writeback_mapping_range+0x2f2/0x5e0
[21737.207627] Code: 24 20 48 8d 7c 24 38 ba 02 00 00 00 e8 87 9f 5a 00 48 85 c0 49 89 c7 0f 84 33 01 00 00 41 f6 c7 01 4d 89 fc 0f 85 2c fe ff ff <0f> 0b 48 8b 5c 24 08 be fb ff ff ff 48 89 df e8 7a 55 ee ff 48 8b
[21737.214372] RSP: 0018:ffffc9000c1dbc68 EFLAGS: 00010046
[21737.216276] RAX: ffffea000a6798c0 RBX: 00000000000009ff RCX: ffff888819d6ba20
[21737.218876] RDX: 0000000000000000 RSI: ffff8881264eab58 RDI: 00000000000009ff
[21737.221480] RBP: ffffc9000c1dbda0 R08: 0000000000000002 R09: 0000000000000238
[21737.224074] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffffea000a6798c0
[21737.226564] R13: ffff88824214d000 R14: ffff88824214d0b8 R15: ffffea000a6798c0
[21737.228978] FS:  00007f3064a15c40(0000) GS:ffff8883b9c80000(0000) knlGS:0000000000000000
[21737.231676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21737.233597] CR2: 00007f3064a13e38 CR3: 0000000275832003 CR4: 0000000000060ee0
[21737.235835] Call Trace:
[21737.236639]  <TASK>
[21737.237335]  do_writepages+0xbe/0x1a0
[21737.238436]  __filemap_fdatawrite_range+0x8f/0xa0
[21737.239831]  filemap_write_and_wait_range+0x31/0x80
[21737.241279]  xfs_reflink_unshare+0x6e/0x150
[21737.242445]  xfs_file_fallocate+0x3a0/0x450
[21737.243660]  ? inode_security+0x2e/0x70
[21737.244752]  ? selinux_file_permission+0x104/0x150
[21737.246043]  vfs_fallocate+0x148/0x340
[21737.247042]  __x64_sys_fallocate+0x3c/0x70
[21737.248128]  do_syscall_64+0x35/0x80
[21737.249095]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[21737.250331] RIP: 0033:0x7f3064d97b67
[21737.251228] Code: 89 7c 24 08 48 89 4c 24 18 e8 45 14 f9 ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 7c 24 08 b8 1d 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 89 44 24 08 e8 95 14 f9 ff 8b 44
[21737.255732] RSP: 002b:00007ffc58fcc490 EFLAGS: 00000293 ORIG_RAX: 000000000000011d
[21737.257565] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3064d97b67
[21737.259256] RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000003
[21737.260941] RBP: 00005623ed763e10 R08: 0000000000000000 R09: 0000000000000000
[21737.262515] R10: 0000000000a00000 R11: 0000000000000293 R12: 00005623ed74e6f8
[21737.264088] R13: 00005623ed74e345 R14: 00005623ed763df0 R15: 00005623ed763e10
[21737.265644]  </TASK>
[21737.266125] ---[ end trace 0000000000000000 ]---
[21737.395835] ------------[ cut here ]------------
[21737.397379] WARNING: CPU: 12 PID: 1332319 at fs/dax.c:923 dax_writeback_mapping_range+0x2f2/0x5e0
[21737.402484] Modules linked in:
[21737.404179] CPU: 12 PID: 1332319 Comm: kworker/u36:4 Tainted: G        W          6.0.0-rc6-dgc+ #1543
[21737.409349] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[21737.414002] Workqueue: writeback wb_workfn (flush-259:1)
[21737.417043] RIP: 0010:dax_writeback_mapping_range+0x2f2/0x5e0
[21737.420347] Code: 24 20 48 8d 7c 24 38 ba 02 00 00 00 e8 87 9f 5a 00 48 85 c0 49 89 c7 0f 84 33 01 00 00 41 f6 c7 01 4d 89 fc 0f 85 2c fe ff ff <0f> 0b 48 8b 5c 24 08 be fb ff ff ff 48 89 df e8 7a 55 ee ff 48 8b
[21737.430816] RSP: 0018:ffffc90004123b58 EFLAGS: 00010046
[21737.433779] RAX: ffffea000a6798c0 RBX: 0007ffffffffffff RCX: ffff888819d6ba20
[21737.437822] RDX: 0000000000000000 RSI: ffff8881264eab58 RDI: 0007ffffffffffff
[21737.441847] RBP: ffffc90004123d10 R08: 0000000000000002 R09: 0000000000000238
[21737.445461] R10: ffffffffffffffff R11: ffffffffffffffc0 R12: ffffea000a6798c0
[21737.449156] R13: ffff88824214d000 R14: ffffc9000c1d3df8 R15: ffffea000a6798c0
[21737.452625] FS:  0000000000000000(0000) GS:ffff88883ec00000(0000) knlGS:0000000000000000
[21737.456219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21737.458673] CR2: 0000556b4a0b69b8 CR3: 0000000802f7d003 CR4: 0000000000060ee0
[21737.461577] Call Trace:
[21737.462526]  <TASK>
[21737.463338]  do_writepages+0xbe/0x1a0
[21737.464754]  __writeback_single_inode+0x41/0x340
[21737.466447]  writeback_sb_inodes+0x1f4/0x4a0
[21737.468033]  wb_writeback+0xae/0x2c0
[21737.469311]  wb_workfn+0xc1/0x4a0
[21737.470473]  ? psi_task_switch+0xba/0x1f0
[21737.471858]  ? do_raw_spin_unlock+0x4b/0xa0
[21737.473299]  ? _raw_spin_unlock+0xa/0x20
[21737.474609]  ? finish_task_switch.isra.0+0x8f/0x2b0
[21737.476223]  process_one_work+0x1a9/0x390
[21737.477539]  worker_thread+0x53/0x3b0
[21737.478759]  ? rescuer_thread+0x3b0/0x3b0
[21737.480073]  kthread+0xe1/0x110
[21737.481174]  ? kthread_complete_and_exit+0x20/0x20
[21737.482719]  ret_from_fork+0x1f/0x30
[21737.483852]  </TASK>
[21737.484522] ---[ end trace 0000000000000000 ]---
[21737.487264] XFS (pmem0): Unmounting Filesystem

Example 3:

[21169.477060] run fstests generic/561 at 2022-09-19 13:53:48
[21170.275214] XFS (pmem0): Mounting V5 Filesystem
[21170.280858] XFS (pmem0): Ending clean mount
[21170.413362] XFS (pmem1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[21170.417289] XFS (pmem1): Mounting V5 Filesystem
[21170.424950] XFS (pmem1): Ending clean mount
[21170.460522] XFS (pmem1): Unmounting Filesystem
[21170.588642] XFS (pmem1): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
[21170.590973] XFS (pmem1): Mounting V5 Filesystem
[21170.595628] XFS (pmem1): Ending clean mount
[21170.792719] ------------[ cut here ]------------
[21170.794438] WARNING: CPU: 10 PID: 1296037 at fs/dax.c:380 dax_insert_entry+0x2ab/0x320
[21170.797498] Modules linked in:
[21170.798726] CPU: 10 PID: 1296037 Comm: fsstress Tainted: G        W          6.0.0-rc6-dgc+ #1543
[21170.801857] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[21170.804586] RIP: 0010:dax_insert_entry+0x2ab/0x320
[21170.806171] Code: 08 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 58 20 48 8d 53 01 e9 65 ff ff ff 48 8b 58 20 48 8d 53 01 e9 50 ff ff ff <0f> 0b e9 70 ff ff ff 31 f6 4c 89 e7 e8 84 b1 5a 00 eb a4 48 81 e6
[21170.812248] RSP: 0000:ffffc9000d493b78 EFLAGS: 00010002
[21170.813956] RAX: ffffea001c121dc0 RBX: 0000000000000001 RCX: 0000000000000001
[21170.816567] RDX: ffffea0000000000 RSI: 0000000000000265 RDI: ffffea001c121e00
[21170.818965] RBP: 0000000000000011 R08: 0000000000000000 R09: 0000000000000000
[21170.821311] R10: ffff8882ebe94e18 R11: 0000000000000001 R12: ffffc9000d493c58
[21170.823638] R13: ffff8882ebe94e18 R14: ffffc9000d493e20 R15: 0000000000000000
[21170.825973] FS:  00007f16ab980b80(0000) GS:ffff8885fed00000(0000) knlGS:0000000000000000
[21170.828595] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21170.830491] CR2: 00007f16abb85000 CR3: 0000000802153002 CR4: 0000000000060ee0
[21170.832871] Call Trace:
[21170.833719]  <TASK>
[21170.834423]  dax_fault_iter+0x243/0x600
[21170.835732]  dax_iomap_pte_fault+0x199/0x360
[21170.837164]  __xfs_filemap_fault+0x1e3/0x2c0
[21170.838608]  __do_fault+0x31/0x1d0
[21170.839811]  __handle_mm_fault+0xd6d/0x1650
[21170.841239]  ? do_mmap+0x348/0x540
[21170.842415]  handle_mm_fault+0x7a/0x1d0
[21170.843716]  ? __kvm_handle_async_pf+0x12/0xb0
[21170.845228]  exc_page_fault+0x1d9/0x810
[21170.846539]  asm_exc_page_fault+0x22/0x30
[21170.847877] RIP: 0033:0x7f16aba29c23
[21170.849050] Code: 47 10 f3 0f 7f 44 17 e0 f3 0f 7f 47 20 f3 0f 7f 44 17 d0 f3 0f 7f 47 30 f3 0f 7f 44 17 c0 48 01 fa 48 83 e2 c0 48 39 d1 74 c0 <66> 0f 7f 01 66 0f 7f 41 10 66 0f 7f 41 20 66 0f 7f 41 30 48 83 c1
[21170.855017] RSP: 002b:00007fff5a0080c8 EFLAGS: 00010202
[21170.856723] RAX: 00007f16abb7e000 RBX: 00000000000001f4 RCX: 00007f16abb85000
[21170.859043] RDX: 00007f16abb87440 RSI: 000000000000006f RDI: 00007f16abb7e000
[21170.861300] RBP: 000000000025e000 R08: 0000000000000000 R09: 000000000025e000
[21170.863682] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000009441
[21170.865898] R13: 8f5c28f5c28f5c29 R14: 000000000000023d R15: 00005586824b5a30
[21170.868054]  </TASK>
[21170.868700] ---[ end trace 0000000000000000 ]---
[21202.422505] ------------[ cut here ]------------
[21202.424148] WARNING: CPU: 7 PID: 1296033 at fs/dax.c:404 dax_disassociate_entry+0x4f/0xb0
[21202.426317] Modules linked in:
[21202.427058] CPU: 7 PID: 1296033 Comm: fsstress Tainted: G        W          6.0.0-rc6-dgc+ #1543
[21202.429540] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[21202.431873] RIP: 0010:dax_disassociate_entry+0x4f/0xb0
[21202.433195] Code: ba 00 00 00 00 00 ea ff ff 48 c1 e0 06 48 8d 9e 00 02 00 00 48 01 d0 48 89 f2 4c 8d 5e 01 eb 24 4c 39 d1 74 07 48 85 c9 74 02 <0f> 0b 48 c7 40 18 00 00 00 00 48 c7 40 20 00 00 00 00 48 83 c2 01
[21202.437394] RSP: 0018:ffffc9000ce2fc38 EFLAGS: 00010086
[21202.438554] RAX: ffffea001c18e0c0 RBX: 0000000000706583 RCX: ffff888293279718
[21202.440065] RDX: 0000000000706383 RSI: 0000000000706383 RDI: 0000000000000000
[21202.441602] RBP: 000000000e0c7061 R08: 0000000000000001 R09: 0000000000000000
[21202.443069] R10: ffff88880ed6e218 R11: 0000000000706384 R12: 0000000000000001
[21202.444491] R13: 0000000000000001 R14: 0000000000000001 R15: 000000000e0c7061
[21202.445910] FS:  00007f16ab980b80(0000) GS:ffff8883b9d80000(0000) knlGS:0000000000000000
[21202.447519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21202.448675] CR2: 000055868285ede8 CR3: 0000000802c83005 CR4: 0000000000060ee0
[21202.450097] Call Trace:
[21202.450616]  <TASK>
[21202.451060]  __dax_invalidate_entry+0x93/0x140
[21202.451968]  dax_delete_mapping_entry+0xf/0x20
[21202.452869]  truncate_folio_batch_exceptionals.part.0+0x1e8/0x210
[21202.454094]  truncate_inode_pages_range+0xdd/0x520
[21202.455071]  evict+0x1ad/0x1c0
[21202.455708]  do_unlinkat+0x1db/0x2e0
[21202.456446]  __x64_sys_unlink+0x3e/0x60
[21202.457227]  do_syscall_64+0x35/0x80
[21202.457961]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[21202.458985] RIP: 0033:0x7f16aba71897
[21202.459719] Code: f0 ff ff 73 01 c3 48 8b 0d 56 cf 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 cf 0c 00 f7 d8 64 89 01 48
[21202.463395] RSP: 002b:00007fff5a0084f8 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
[21202.464899] RAX: ffffffffffffffda RBX: 00007fff5a008660 RCX: 00007f16aba71897
[21202.466330] RDX: 0058583735353166 RSI: 0000000000000000 RDI: 00005586825368e0
[21202.467752] RBP: 00007fff5a008660 R08: 00007f16abb3fba0 R09: 00007fff5a00864c
[21202.469173] R10: 0000000000001557 R11: 0000000000000206 R12: 0000000000000053
[21202.470599] R13: 8f5c28f5c28f5c29 R14: 0000000000000053 R15: 00005586824b42d0
[21202.472021]  </TASK>
[21202.472483] ---[ end trace 0000000000000000 ]---
[21205.629857] ------------[ cut here ]------------
[21205.631228] WARNING: CPU: 6 PID: 1298701 at fs/iomap/iter.c:16 iomap_iter+0x294/0x2c0
[21205.633789] Modules linked in:
[21205.634773] CPU: 6 PID: 1298701 Comm: pool Tainted: G        W          6.0.0-rc6-dgc+ #1543
[21205.637501] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[21205.639893] RIP: 0010:iomap_iter+0x294/0x2c0
[21205.641304] Code: 50 03 48 85 c0 74 0c 48 8b 78 08 4c 89 ea e8 53 f3 ff ff 65 ff 0d bc 14 c7 7e 0f 85 e7 fe ff ff e8 0d 8f c5 ff e9 dd fe ff ff <0f> 0b b8 fb ff ff ff e9 d6 fe ff ff 0f 0b e9 b7 fe ff ff 0f 0b e9
[21205.647322] RSP: 0018:ffffc90005d23a88 EFLAGS: 00010216
[21205.649063] RAX: 0000000000000167 RBX: ffffc90005d23b88 RCX: 0000000000001000
[21205.651352] RDX: 0000000000000167 RSI: 00000000002c3000 RDI: ffffc90005d23b88
[21205.653832] RBP: ffffffff824af4f0 R08: ffffc90005d23ac0 R09: 0000000000000000
[21205.656147] R10: ffffc90005d23988 R11: ffff8881095d60b0 R12: ffffc90005d23ce8
[21205.658367] R13: 00000000002c3000 R14: 0000000000001000 R15: 0000000000000000
[21205.660594] FS:  00007f43827fc640(0000) GS:ffff8883b9d00000(0000) knlGS:0000000000000000
[21205.663213] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21205.665104] CR2: 00007ff01e6fae58 CR3: 0000000801670002 CR4: 0000000000060ee0
[21205.667315] Call Trace:
[21205.668121]  <TASK>
[21205.668828]  dax_dedupe_file_range_compare+0xd3/0x210
[21205.670547]  __generic_remap_file_range_prep+0x28b/0x790
[21205.672241]  xfs_reflink_remap_prep+0xeb/0x240
[21205.673694]  xfs_file_remap_range+0x8c/0x330
[21205.675103]  vfs_dedupe_file_range_one+0x15d/0x1f0
[21205.676670]  vfs_dedupe_file_range+0x15b/0x1f0
[21205.678161]  do_vfs_ioctl+0x489/0x8f0
[21205.679330]  __x64_sys_ioctl+0x61/0xb0
[21205.680591]  do_syscall_64+0x35/0x80
[21205.681782]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[21205.683418] RIP: 0033:0x7f4391eafb07
[21205.684604] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 8c 0c 00 f7 d8 64 89 01 48
[21205.690413] RSP: 002b:00007f43827fbc38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[21205.692772] RAX: ffffffffffffffda RBX: 00007f434882bc90 RCX: 00007f4391eafb07
[21205.695028] RDX: 00007f434882bb10 RSI: 00000000c0189436 RDI: 000000000000000b
[21205.697249] RBP: 00007f434882bce0 R08: 0000000000000001 R09: 00007f4391f3e0c0
[21205.699566] R10: 00000000002bb000 R11: 0000000000000246 R12: 00007f434882bcc8
[21205.701851] R13: 00007f434882bb10 R14: 00007f434882bce0 R15: 00007f434882bcd0
[21205.704221]  </TASK>
[21205.705048] ---[ end trace 0000000000000000 ]---

example 4:

eneric/164 18s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_dax/generic/164.out.bad)
    --- tests/generic/164.out   2017-08-29 16:31:54.080531203 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs_dax/generic/164.out.bad        2022-09-19 12:45:04.092345397 +1000
    @@ -2,4 +2,1028 @@
     Format and mount
     Initialize files
     Reflink and reread the files!
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    ...
    (Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/164.out /home/dave/src/xfstests-dev/results//xfs_dax/generic/164.out.bad'  to see the entire diff)
generic/165 17s ... - output mismatch (see /home/dave/src/xfstests-dev/results//xfs_dax/generic/165.out.bad)
    --- tests/generic/165.out   2017-08-29 16:31:54.080531203 +1000
    +++ /home/dave/src/xfstests-dev/results//xfs_dax/generic/165.out.bad        2022-09-19 12:45:20.105830232 +1000
    @@ -2,4 +2,1028 @@
     Format and mount
     Initialize files
     Reflink and dio reread the files!
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    +XFS_IOC_CLONE_RANGE: Invalid argument
    ...
    (Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/165.out /home/dave/src/xfstests-dev/results//xfs_dax/generic/165.out.bad'  to see 

Example 5 - fsx failure with data beyond EOF from g/112:

220 read        0x12ec9 thru    0x1904b (0x6183 bytes)
221 falloc      from 0xc24c to 0x1020a (0x3fbe bytes)
222 mapwrite    0x8f95 thru     0x127ef (0x985b bytes)
223 mapread     0x10d03 thru    0x19207 (0x8505 bytes)
224 mapwrite    0x2f87c thru    0x3f87b (0x10000 bytes)
Mapped Write: non-zero data past EOF (0x3f87b) page offset 0x87c is 0x7552
LOG DUMP (224 total operations):
1(  1 mod 256): SKIPPED (no operation)
2(  2 mod 256): SKIPPED (no operation)
3(  3 mod 256): MAPWRITE 0x36182 thru 0x3ede1   (0x8c60 bytes)
4(  4 mod 256): COLLAPSE 0x2000 thru 0x8fff     (0x7000 bytes)
5(  5 mod 256): ZERO     0xe201 thru 0x18bc4    (0xa9c4 bytes)
6(  6 mod 256): WRITE    0x37fe1 thru 0x3804c   (0x6c bytes) HOLE
7(  7 mod 256): ZERO     0x2f52 thru 0x5c84     (0x2d33 bytes)

Example 6 fsx, g/127

A output created by 127
=== FSX Light Mode, No Memory Mapping ===
All 100000 operations completed A-OK!
=== FSX Light Mode, Memory Mapping ===
All 100000 operations completed A-OK!
=== FSX Standard Mode, No Memory Mapping ===
ltp/fsx -q -l 262144 -o 65536 -S 191110531 -N 100000 -R -W fsx_std_nommap
READ BAD DATA: offset = 0x39356, size = 0x1308, fname = /mnt/test/fsx_std_nommap
OFFSET  GOOD    BAD     RANGE
0x3a000 0x0000  0x756e  0x00000
operation# (mod 256) for the bad data may be 117
0x3a001 0x0000  0x6e75  0x00001
operation# (mod 256) for the bad data may be 117
0x3a002 0x0000  0x75ca  0x00002
operation# (mod 256) for the bad data may be 117
0x3a003 0x0000  0xca75  0x00003
operation# (mod 256) for the bad data may be 117
0x3a004 0x0000  0x752d  0x00004
operation# (mod 256) for the bad data may be 117
0x3a005 0x0000  0x2d75  0x00005
operation# (mod 256) for the bad data may be 117
0x3a006 0x0000  0x7541  0x00006
operation# (mod 256) for the bad data may be 117
0x3a007 0x0000  0x4175  0x00007
operation# (mod 256) for the bad data may be 117
0x3a008 0x0000  0x7599  0x00008
operation# (mod 256) for the bad data may be 117
0x3a009 0x0000  0x9975  0x00009
operation# (mod 256) for the bad data may be 117
0x3a00a 0x0000  0x7537  0x0000a
operation# (mod 256) for the bad data may be 117
0x3a00b 0x0000  0x3775  0x0000b
operation# (mod 256) for the bad data may be 117
0x3a00c 0x0000  0x7510  0x0000c
operation# (mod 256) for the bad data may be 117
0x3a00d 0x0000  0x1075  0x0000d
operation# (mod 256) for the bad data may be 117
0x3a00e 0x0000  0x75ba  0x0000e
operation# (mod 256) for the bad data may be 117
0x3a00f 0x0000  0xba75  0x0000f
operation# (mod 256) for the bad data may be 117
LOG DUMP (122 total operations):
1(  1 mod 256): WRITE    0x39381 thru 0x3ffff   (0x6c7f bytes) HOLE     ***WWWW
2(  2 mod 256): DEDUPE 0x16000 thru 0x24fff     (0xf000 bytes) to 0x3000 thru 0x11fff
3(  3 mod 256): DEDUPE 0x29000 thru 0x29fff     (0x1000 bytes) to 0x19000 thru 0x19fff
4(  4 mod 256): COPY 0x17cf1 thru 0x203e2       (0x86f2 bytes) to 0x8c59 thru 0x1134a
5(  5 mod 256): PUNCH    0x2f78d thru 0x33379   (0x3bed bytes)
6(  6 mod 256): TRUNCATE DOWN   from 0x40000 to 0x28b68 ******WWWW
7(  7 mod 256): COLLAPSE 0x14000 thru 0x14fff   (0x1000 bytes)
8(  8 mod 256): TRUNCATE UP     from 0x27b68 to 0x3a9c4 ******WWWW
9(  9 mod 256): READ     0x9cb7 thru 0x19799    (0xfae3 bytes)
10( 10 mod 256): PUNCH    0x1b3a8 thru 0x1dff8  (0x2c51 bytes)
....

-- 
Dave Chinner
david@fromorbit.com
