Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B579D7E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjILRsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjILRsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:48:17 -0400
Received: from out-223.mta1.migadu.com (out-223.mta1.migadu.com [95.215.58.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE98C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 10:48:13 -0700 (PDT)
Date:   Tue, 12 Sep 2023 13:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694540892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3AKq9RT91szu7HmizTPYNhFDsGrbfiTiwTgh4bXvz+Q=;
        b=Yq5GDyuXneUeqnuaYtaGWD9bhNeCgA4taCJowMj2wjt8I1AlEBIKywP44whNLYwbCZPX7r
        5h8yzXGuJNFfvSJmPsogKyKhB4Ij4/paNbTqzDTHrmQjTe1Dd7A5ppmE4bAmIBhO1OrWYB
        UuqLnVGFc6OVvobuIv8/spzoBtYpK4o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: dentry UAF bugs crashing arm64 machines on 6.5/6.6?
Message-ID: <20230912174808.acs24pvg4hbzjxm4@moria.home.lan>
References: <20230912173026.GA3389127@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912173026.GA3389127@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:30:26AM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> Shortly after 6.5 was tagged, I started seeing the following stacktraces
> when running xfs through fstests on arm64.  Curiously, x86_64 does not
> seem affected.
> 
> At first I thought this might be caused by the bug fixes in my
> development tree, so I started bisecting them.  Bisecting identified a
> particular patchset[1] that didn't seem like it was the culprit.  A
> couple of days later, one of my arm64 vms with that patch reverted
> crashed in the same way.  So, clearly not the culprit.
> 
> [1] https://lore.kernel.org/linux-xfs/169335056933.3525521.6054773682023937525.stgit@frogsfrogsfrogs/
> 
>   run fstests generic/162 at 2023-09-11 22:06:42
>   spectre-v4 mitigation disabled by command-line option
>   XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
>   XFS (sda2): Ending clean mount
>   XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda3): Mounting V5 Filesystem 0c328923-fa81-458f-846c-45bb6828aa0f
>   XFS (sda3): Ending clean mount
>   XFS (sda3): Quotacheck needed: Please wait.
>   XFS (sda3): Quotacheck: Done.
>   XFS (sda3): Unmounting Filesystem 0c328923-fa81-458f-846c-45bb6828aa0f
>   XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   XFS (sda3): Ending clean mount
>   XFS (sda3): Quotacheck needed: Please wait.
>   XFS (sda3): Quotacheck: Done.
>   XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   XFS (sda3): Ending clean mount
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in d_alloc_parallel+0x850/0xa00
>   Read of size 4 at addr fffffc0176c88360 by task xfs_io/1341106
>   
>   CPU: 0 PID: 1341106 Comm: xfs_io Not tainted 6.5.0-xfsa #12 7284e9be14b81c73627c489aa5df798cf1143960
>   Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
>   Call trace:
>    dump_backtrace+0x9c/0x100
>    show_stack+0x20/0x38
>    dump_stack_lvl+0x48/0x60
>    print_report+0xf4/0x5b0
>    kasan_report+0xa4/0xf0
>    __asan_report_load4_noabort+0x20/0x30
>    d_alloc_parallel+0x850/0xa00
>    __lookup_slow+0x11c/0x2e8
>    walk_component+0x1f8/0x498
>    link_path_walk.part.0.constprop.0+0x41c/0x960
>    path_lookupat+0x70/0x590
>    filename_lookup+0x144/0x368
>    user_path_at_empty+0x54/0x88
>    do_faccessat+0x3f0/0x7c0
>    __arm64_sys_faccessat+0x78/0xb0
>    do_el0_svc+0x124/0x318
>    el0_svc+0x34/0xe8
>    el0t_64_sync_handler+0x13c/0x158
>    el0t_64_sync+0x190/0x198
>   
>   Allocated by task 1340914:
>    kasan_save_stack+0x2c/0x58
>    kasan_set_track+0x2c/0x40
>    kasan_save_alloc_info+0x24/0x38
>    __kasan_slab_alloc+0x74/0x90
>    kmem_cache_alloc_lru+0x180/0x440
>    __d_alloc+0x40/0x830
>    d_alloc+0x3c/0x1c8
>    d_alloc_parallel+0xe4/0xa00
>    __lookup_slow+0x11c/0x2e8
>    walk_component+0x1f8/0x498
>    path_lookupat+0x10c/0x590
>    filename_lookup+0x144/0x368
>    user_path_at_empty+0x54/0x88
>    do_readlinkat+0xcc/0x250
>    __arm64_sys_readlinkat+0x90/0xe0
>    do_el0_svc+0x124/0x318
>    el0_svc+0x34/0xe8
>    el0t_64_sync_handler+0x13c/0x158
>    el0t_64_sync+0x190/0x198
>   
>   Last potentially related work creation:
>    kasan_save_stack+0x2c/0x58
>    __kasan_record_aux_stack+0x9c/0xc8
>    kasan_record_aux_stack_noalloc+0x14/0x20
>    __call_rcu_common.constprop.0+0x74/0x5b0
>    call_rcu+0x18/0x30
>    dentry_free+0x9c/0x158
>    __dentry_kill+0x434/0x578
>    dput+0x30c/0x6b8
>    step_into+0xa50/0x1680
>    walk_component+0xb0/0x498
>    path_lookupat+0x10c/0x590
>    filename_lookup+0x144/0x368
>    user_path_at_empty+0x54/0x88
>    do_readlinkat+0xcc/0x250
>    __arm64_sys_readlinkat+0x90/0xe0
>    do_el0_svc+0x124/0x318
>    el0_svc+0x34/0xe8
>    el0t_64_sync_handler+0x13c/0x158
>    el0t_64_sync+0x190/0x198
>   
>   Second to last potentially related work creation:
>    kasan_save_stack+0x2c/0x58
>    __kasan_record_aux_stack+0x9c/0xc8
>    kasan_record_aux_stack_noalloc+0x14/0x20
>    __call_rcu_common.constprop.0+0x74/0x5b0
>    call_rcu+0x18/0x30
>    dentry_free+0x9c/0x158
>    __dentry_kill+0x434/0x578
>    dput+0x30c/0x6b8
>    step_into+0xa50/0x1680
>    walk_component+0xb0/0x498
>    path_lookupat+0x10c/0x590
>    filename_lookup+0x144/0x368
>    user_path_at_empty+0x54/0x88
>    do_readlinkat+0xcc/0x250
>    __arm64_sys_readlinkat+0x90/0xe0
>    do_el0_svc+0x124/0x318
>    el0_svc+0x34/0xe8
>    el0t_64_sync_handler+0x13c/0x158
>    el0t_64_sync+0x190/0x198
>   
>   The buggy address belongs to the object at fffffc0176c88340
>    which belongs to the cache dentry of size 216
>   The buggy address is located 32 bytes inside of
>    freed 216-byte region [fffffc0176c88340, fffffc0176c88418)
>   
>   The buggy address belongs to the physical page:
>   page:ffffffff005db200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xfffffc0176c86900 pfn:0x1b6c8
>   memcg:fffffc004195a001
>   flags: 0x1ffe000000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
>   page_type: 0xffffffff()
>   raw: 1ffe000000000200 fffffc00e0016b80 ffffffff0052bb90 ffffffff00405350
>   raw: fffffc0176c86900 0000000000ea0037 00000001ffffffff fffffc004195a001
>   page dumped because: kasan: bad access detected
>   
>   Memory state around the buggy address:
>    fffffc0176c88200: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
>    fffffc0176c88280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   >fffffc0176c88300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
>                                                          ^
>    fffffc0176c88380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    fffffc0176c88400: fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb fb
>   ==================================================================
>   Disabling lock debugging due to kernel taint
>   XFS (sda2): Unmounting Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
>   XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
>   XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1343704 'xfs_repair'
>   XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   XFS (sda3): Ending clean mount
>   XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
>   run fstests generic/137 at 2023-09-11 22:06:59
>   spectre-v4 mitigation disabled by command-line option
>   XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
>   XFS (sda2): Ending clean mount
>   XFS (sda2): Unmounting Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
>   XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
>   XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
>   XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
>   XFS (sda2): Ending clean mount
>   Unable to handle kernel paging request at virtual address e0c83a00c0029201
>   KASAN: maybe wild-memory-access in range [0x0641e00600149008-0x0641e0060014900f]
>   Mem abort info:
>     ESR = 0x0000000096000004
>     EC = 0x25: DABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x04: level 0 translation fault
>   Data abort info:
>     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>   [e0c83a00c0029201] address between user and kernel address ranges
>   Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison xfs ext2 mbcache dm_flakey dm_snapshot dm_bufio dm_zero nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp crct10dif_ce bfq ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables libcrc32c sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
>   CPU: 1 PID: 1348080 Comm: md5sum Tainted: G    B              6.5.0-xfsa #12 7284e9be14b81c73627c489aa5df798cf1143960
>   Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
>   pstate: 40401005 (nZcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
>   pc : d_alloc_parallel+0x250/0xa00
>   lr : d_alloc_parallel+0x85c/0xa00
>   sp : fffffe008b8cf720
>   x29: fffffe008b8cf720 x28: 00c83c00c0029201 x27: fffffc00fa39e340
>   x26: 000000003c7f8e47 x25: dffffe0000000000 x24: fffffe0082ab9d90
>   x23: 0000000000000003 x22: fffffc014dd9df20 x21: 0641e006001490b0
>   x20: 0641e00600149008 x19: fffffe00825a55c0 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>   x14: 0000000000000001 x13: 80808080807fffff x12: fffffdc0105573b3
>   x11: 1fffffc0105573b2 x10: fffffdc0105573b2 x9 : dffffe0000000000
>   x8 : 0000023fefaa8c4e x7 : fffffe0082ab9d97 x6 : 0000000000000001
>   x5 : fffffe0082ab9d90 x4 : 0000000000000000 x3 : fffffe008070fad4
>   x2 : 0000000000000000 x1 : fffffe0082a9e9d8 x0 : 0000000000000000
>   Call trace:
>    d_alloc_parallel+0x250/0xa00
>    path_openat+0x1030/0x23d0
>    do_filp_open+0x15c/0x338
>    do_sys_openat2+0x12c/0x168
>    __arm64_sys_openat+0x138/0x1d0
>    do_el0_svc+0x124/0x318
>    el0_svc+0x34/0xe8
>    el0t_64_sync_handler+0x13c/0x158
>    el0t_64_sync+0x190/0x198
>   Code: f94002b5 b4001375 d102a2b4 d343fe9c (38f96b80) 
>   ---[ end trace 0000000000000000 ]---
>   note: md5sum[1348080] exited with preempt_count 1
> 
> I tried popping /all/ the bugfixes, and for 6.5 that seemed to make
> fstests settle down.  But then 6.6-rc1 came out, and the crashes
> returned.  In addition, there's a new crash:
> 
>   run fstests xfs/711 at 2023-09-11 20:25:35
>   spectre-v4 mitigation disabled by command-line option
>   XFS (sda3): Mounting V5 Filesystem add44358-2799-4361-b909-073e50305a53
>   XFS (sda3): Ending clean mount
>   XFS (sda3): Quotacheck needed: Please wait.
>   XFS (sda3): Quotacheck: Done.
>   XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
>   Unable to handle kernel execute from non-executable memory at virtual address fffffe0082e85070
>   KASAN: probably user-memory-access in range [0x0000000417428380-0x0000000417428387]
>   Mem abort info:
>     ESR = 0x000000008600000f
>     EC = 0x21: IABT (current EL), IL = 32 bits
>     SET = 0, FnV = 0
>     EA = 0, S1PTW = 0
>     FSC = 0x0f: level 3 permission fault
>   swapper pgtable: 64k pages, 42-bit VAs, pgdp=0000000041d40000
>   [fffffe0082e85070] pgd=100000023fff0003, p4d=100000023fff0003, pud=100000023fff0003, pmd=100000023fff0003, pte=0068000042e80703
>   Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Modules linked in: xfs nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set bfq nf_tables libcrc32c crct10dif_ce nfnetlink sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4
>   CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0-rc1-djwa #rc1 31f6bcd5927f495a7ed31b02fb778f37562278b5
>   Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
>   pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
>   pc : in_lookup_hashtable+0x16b0/0x2020
>   lr : rcu_core+0xadc/0x13a8
>   sp : fffffe0082f2fdc0
>   x29: fffffe0082f2fdc0 x28: fffffd801c1228a1 x27: fffffc00e0914500
>   x26: 0000000000000003 x25: fffffc01bea6aa38 x24: fffffe0082f2fea0
>   x23: 1fffffc0105e5fd0 x22: fffffe00826459f8 x21: dffffe0000000000
>   x20: 0000000000000003 x19: fffffc01bea6a9c0 x18: 0000000000000000
>   x17: fffffe013cac0000 x16: fffffe0082f20000 x15: 0000000000000000
>   x14: 0000000000000000 x13: 1fffffc0102ff4f1 x12: fffffdc0104dafc9
>   x11: 1fffffc0104dafc8 x10: fffffdc0104dafc8 x9 : fffffe00802188dc
>   x8 : fffffd802037eb51 x7 : fffffe0082f2fab8 x6 : 0000000000000002
>   x5 : 0000000000000050 x4 : fffffc01bd7f34e8 x3 : 0000000000000118
>   x2 : fffffe0082e85070 x1 : fffffc0101bfa078 x0 : fffffc0101bfa078
>   Call trace:
>    in_lookup_hashtable+0x16b0/0x2020
>    rcu_core_si+0x18/0x30
>    __do_softirq+0x280/0xad4
>    ____do_softirq+0x18/0x30
>    call_on_irq_stack+0x24/0x58
>    do_softirq_own_stack+0x24/0x38
>    irq_exit_rcu+0x198/0x238
>    el1_interrupt+0x38/0x58
>    el1h_64_irq_handler+0x18/0x28
>    el1h_64_irq+0x64/0x68
>    arch_local_irq_enable+0x4/0x8
>    do_idle+0x32c/0x450
>    cpu_startup_entry+0x2c/0x40
>    secondary_start_kernel+0x230/0x2e0
>    __secondary_switched+0xb8/0xc0
>   Code: 00000000 00000000 00000000 00000000 (01bfa078) 
>   ---[ end trace 0000000000000000 ]---
>   Kernel panic - not syncing: Oops: Fatal exception in interrupt
>   SMP: stopping secondary CPUs
>   Dumping ftrace buffer:
>      (ftrace buffer empty)
>   Kernel Offset: disabled
>   CPU features: 0x00000000,70020043,1001700b
>   Memory Limit: none
>   ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---
> 
> IDGI.  Has anyone else seen this sort of crash?  They all seem to
> revolve around UAF bugs with dentries that look like they've been
> rcu-freed recently.
> 
> Kent said he's affected by some crash on arm64 too, so I cc'd him.
> 
> I also haven't any clue why this hasn't triggered at all on x86_64.
> 
> --D

This is the one that started popping up for me on 6.5, possibly related?

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0100  6531  100  6531    0     0  87798      0 --:--:-- --:--:-- --:--:-- 88256
00284 ========= TEST   stress_ng
00284 
00284 WATCHDOG 300
00285 bcachefs (vdb): mounting version 0.11: inode_btree_change
00285 bcachefs (vdb): initializing new filesystem
00285 bcachefs (vdb): going read-write
00285 bcachefs (vdb): marking superblocks
00285 bcachefs (vdb): initializing freespace
00285 bcachefs (vdb): done initializing freespace
00285 bcachefs (vdb): reading snapshots table
00285 bcachefs (vdb): reading snapshots done
00285 stress-ng: debug: [7064] invoked with 'stress-ng -v -t 60 --class filesystem --all 1' by user 0 'root'
00285 stress-ng: debug: [7064] stress-ng 0.15.08
00285 stress-ng: debug: [7064] system: Linux Debian-1103-bullseye-arm64-base-kvm 6.5.0-ktest-ga2e02e2d17e1 #4586 SMP Sun Sep 10 01:20:24 UTC 2023 aarch64
00285 stress-ng: debug: [7064] RAM total: 3.8G, RAM free: 3.5G, swap free: 0.0
00285 stress-ng: debug: [7064] temporary file path: '.', filesystem type: unknown 0xca451a4e
00285 stress-ng: debug: [7064] 16 processors online, 16 processors configured
00285 stress-ng: info:  [7064] setting to a 60 second run per stressor
00285 stress-ng: info:  [7064] dnotify stressor will be skipped, cannot open '/proc/sys/fs/dir-notify-enable', CONFIG_DNOTIFY is probably not set
00285 stress-ng: info:  [7064] fanotify stressor will be skipped, : system call not supported
00285 stress-ng: info:  [7064] dispatching hogs: 1 access, 1 binderfs, 1 chattr, 1 chdir, 1 chmod, 1 chown, 1 copy-file, 1 dentry, 1 dir, 1 dirdeep, 1 dirmany, 1 dup, 1 eventfd, 1 fallocate, 1 fcntl, 1 fiemap, 1 file-ioctl, 1 filename, 1 flock, 1 fpunch, 1 fsize, 1 fstat, 1 getdent, 1 handle, 1 hdd, 1 inode-flags, 1 inotify, 1 io, 1 iomix, 1 ioprio, 1 lease, 1 link, 1 locka, 1 lockf, 1 lockofd, 1 mknod, 1 open, 1 procfs, 1 rename, 1 symlink, 1 sync-file, 1 touch, 1 utime, 1 verity, 1 xattr
00285 stress-ng: debug: [7064] cache allocate: using defaults, cannot determine cache level details
00285 stress-ng: debug: [7064] cache allocate: shared cache buffer size: 2048K
00285 stress-ng: debug: [7064] starting stressors
00285 stress-ng: debug: [7071] access: started [7071] (instance 0)
00285 stress-ng: debug: [7073] chattr: started [7073] (instance 0)
00285 stress-ng: debug: [7075] chmod: started [7075] (instance 0)
00285 stress-ng: debug: [7076] chown: started [7076] (instance 0)
00285 stress-ng: debug: [7077] copy-file: started [7077] (instance 0)
00285 stress-ng: debug: [7081] dir: started [7081] (instance 0)
00285 stress-ng: debug: [7084] dup: started [7084] (instance 0)
00285 stress-ng: debug: [7082] dirdeep: started [7082] (instance 0)
00285 stress-ng: debug: [7087] fcntl: started [7087] (instance 0)
00285 stress-ng: debug: [7090] filename: started [7090] (instance 0)
00285 stress-ng: debug: [7092] fpunch: started [7092] (instance 0)
00285 stress-ng: debug: [7093] fsize: started [7093] (instance 0)
00285 stress-ng: debug: [7097] getdent: started [7097] (instance 0)
00285 stress-ng: debug: [7095] fstat: started [7095] (instance 0)
00285 stress-ng: debug: [7102] inotify: started [7102] (instance 0)
00285 stress-ng: debug: [7104] iomix: started [7104] (instance 0)
00285 stress-ng: debug: [7109] lockf: started [7109] (instance 0)
00285 stress-ng: debug: [7110] lockofd: started [7110] (instance 0)
00285 stress-ng: debug: [7108] locka: started [7108] (instance 0)
00285 stress-ng: debug: [7114] rename: started [7114] (instance 0)
00285 stress-ng: debug: [7116] sync-file: started [7116] (instance 0)
00285 stress-ng: debug: [7072] binderfs: started [7072] (instance 0)
00285 stress-ng: debug: [7074] chdir: started [7074] (instance 0)
00285 spectre-v4 mitigation disabled by command-line option
00285 stress-ng: debug: [7083] dirmany: started [7083] (instance 0)
00285 stress-ng: debug: [7083] dirmany: 0 byte file size
00285 stress-ng: debug: [7088] fiemap: started [7088] (instance 0)
00285 stress-ng: debug: [7089] file-ioctl: started [7089] (instance 0)
00285 stress-ng: debug: [7100] hdd: started [7100] (instance 0)
00285 stress-ng: debug: [7103] io: started [7103] (instance 0)
00285 stress-ng: debug: [7105] ioprio: started [7105] (instance 0)
00285 stress-ng: debug: [7111] mknod: started [7111] (instance 0)
00285 stress-ng: debug: [7082] dirdeep: 61115144 inodes available, exercising up to 61115144 inodes
00285 stress-ng: debug: [7091] flock: started [7091] (instance 0)
00285 stress-ng: debug: [7107] link: started [7107] (instance 0)
00285 stress-ng: debug: [7117] touch: started [7117] (instance 0)
00285 stress-ng: info:  [7072] binderfs: binderfs not supported, errno=19 (No such device), skipping stress test
00285 stress-ng-flock(7361): Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
00285 stress-ng: debug: [7072] binderfs: exited [7072] (instance 0)
00286 stress-ng: debug: [7086] fallocate: started [7086] (instance 0)
00286 stress-ng: debug: [7079] dentry: started [7079] (instance 0)
00286 stress-ng: debug: [7099] handle: started [7099] (instance 0)
00286 stress-ng: debug: [7101] inode-flags: started [7101] (instance 0)
00286 stress-ng: debug: [7112] open: started [7112] (instance 0)
00286 stress-ng: info:  [7112] open: using a maximum of 524288 file descriptors
00286 stress-ng: debug: [7122] utime: started [7122] (instance 0)
00286 stress-ng: debug: [7113] procfs: started [7113] (instance 0)
00286 stress-ng: debug: [7115] symlink: started [7115] (instance 0)
00286 stress-ng: debug: [7085] eventfd: started [7085] (instance 0)
00286 stress-ng: info:  [7103] io: this is a legacy I/O sync stressor, consider using iomix instead
00286 stress-ng: debug: [7106] lease: started [7106] (instance 0)
00286 stress-ng: debug: [7123] verity: started [7123] (instance 0)
00286 stress-ng: debug: [7124] xattr: started [7124] (instance 0)
00286 stress-ng: debug: [7064] 45 stressors started
00288 ICMPv6: process `stress-ng-procf' is using deprecated sysctl (syscall) net.ipv6.neigh.lo.retrans_time - use net.ipv6.neigh.lo.retrans_time_ms instead
00288 stress-ng: debug: [7090] filename: filesystem allows 254 unique characters in a 512 character long filename
00289 stress-ng-iomix (7167): drop_caches: 1
00290 stress-ng: info:  [7123] verity: verity is not supported on the file system or by the kernel, skipping stress test
00290 stress-ng: debug: [7123] verity: exited [7123] (instance 0)
00297 stress-ng: info:  [7093] fsize: allocating file to 262144 (0x40000) bytes failed, errno=28 (No space left on device), skipping stressor
00297 stress-ng: debug: [7093] fsize: exited [7093] (instance 0)
00298 stress-ng-iomix (7167): drop_caches: 2
00308 stress-ng: fail:  [9792] filename: open failed on file of length 511 bytes, errno=28 (No space left on device)
00311 stress-ng-iomix (7167): drop_caches: 3
00318 stress-ng-iomix (7167): drop_caches: 1
00324 stress-ng-iomix (7167): drop_caches: 2
00331 stress-ng-iomix (7167): drop_caches: 3
00345 stress-ng: debug: [7075] chmod: exited [7075] (instance 0)
00345 stress-ng: debug: [7085] eventfd: exited [7085] (instance 0)
00345 stress-ng: debug: [7084] dup: dup2: 2662 races from 6205 attempts (42.90%)
00345 stress-ng: debug: [7084] dup: exited [7084] (instance 0)
00345 stress-ng: debug: [7099] handle: exited [7099] (instance 0)
00345 stress-ng: debug: [7097] getdent: exited [7097] (instance 0)
00345 stress-ng: debug: [7095] fstat: exited [7095] (instance 0)
00345 stress-ng: debug: [7073] chattr: exited [7073] (instance 0)
00345 stress-ng: debug: [7086] fallocate: exited [7086] (instance 0)
00345 stress-ng: debug: [7071] access: exited [7071] (instance 0)
00345 stress-ng: debug: [7064] process [7071] terminated
00345 stress-ng: warn:  [7064] process [7072] (binderfs) aborted early, out of system resources
00345 stress-ng: debug: [7064] process [7072] terminated
00345 stress-ng: debug: [7076] chown: exited [7076] (instance 0)
00345 stress-ng: debug: [7101] inode-flags: exited [7101] (instance 0)
00345 stress-ng: debug: [7091] flock: exited [7091] (instance 0)
00345 stress-ng: debug: [7106] lease: 594984 lease sigio interrupts caught
00345 stress-ng: debug: [7106] lease: exited [7106] (instance 0)
00345 stress-ng: debug: [7100] hdd: exited [7100] (instance 0)
00345 stress-ng: debug: [7116] sync-file: exited [7116] (instance 0)
00345 stress-ng: debug: [7089] file-ioctl: exited [7089] (instance 0)
00345 stress-ng: debug: [7090] filename: exited [7090] (instance 0)
00345 stress-ng: debug: [7064] process [7073] terminated
00345 stress-ng: debug: [7113] procfs: exited [7113] (instance 0)
00345 stress-ng: debug: [7087] fcntl: exited [7087] (instance 0)
00345 stress-ng: debug: [7108] locka: exited [7108] (instance 0)
00345 stress-ng: debug: [7088] fiemap: exited [7088] (instance 0)
00345 stress-ng: debug: [7122] utime: exited [7122] (instance 0)
00345 stress-ng: debug: [7124] xattr: exited [7124] (instance 0)
00345 stress-ng: debug: [7092] fpunch: exited [7092] (instance 0)
00345 stress-ng: debug: [7105] ioprio: exited [7105] (instance 0)
00346 stress-ng: debug: [7107] link: exited [7107] (instance 0)
00346 stress-ng: debug: [7114] rename: exited [7114] (instance 0)
00346 stress-ng: debug: [7109] lockf: exited [7109] (instance 0)
00346 stress-ng: debug: [7110] lockofd: exited [7110] (instance 0)
00346 stress-ng: debug: [7115] symlink: exited [7115] (instance 0)
00346 stress-ng: debug: [7077] copy-file: exited [7077] (instance 0)
00346 stress-ng: debug: [7074] chdir: exited [7074] (instance 0)
00346 stress-ng: debug: [7064] process [7074] terminated
00346 stress-ng: debug: [7064] process [7075] terminated
00346 stress-ng: debug: [7064] process [7076] terminated
00346 stress-ng: debug: [7064] process [7077] terminated
00346 stress-ng: info:  [7079] dentry: 208498 dentries allocated
00346 stress-ng: debug: [7111] mknod: exited [7111] (instance 0)
00346 stress-ng: debug: [7103] io: exited [7103] (instance 0)
00346 stress-ng: fail:  [7138] iomix: write failed, errno=4 (Interrupted system call), filesystem type: unknown 0xca451a4e
00346 stress-ng: debug: [7081] dir: exited [7081] (instance 0)
00346 stress-ng-iomix (7167): drop_caches: 1
00346 stress-ng: debug: [7117] touch: exited [7117] (instance 0)
00346 stress-ng: debug: [7104] iomix: exited [7104] (instance 0)
00346 stress-ng: debug: [7079] dentry: exited [7079] (instance 0)
00346 stress-ng: debug: [7064] process [7079] terminated
00346 stress-ng: debug: [7064] process [7081] terminated
00346 stress-ng: debug: [7102] inotify: exited [7102] (instance 0)
00347 stress-ng: debug: [7112] open: exited [7112] (instance 0)
00347 stress-ng: debug: [7082] dirdeep: 60936952 inodes exercised
00347 stress-ng: info:  [7082] dirdeep: note: specifying a larger --dirdeep or --dirdeep-dirs settings or running the stressor for longer will use more inodes
00347 stress-ng: debug: [7082] dirdeep: exited [7082] (instance 0)
00347 stress-ng: debug: [7064] process [7082] terminated
00347 stress-ng: debug: [7083] dirmany: exited [7083] (instance 0)
00347 stress-ng: debug: [7064] process [7083] terminated
00347 stress-ng: debug: [7064] process [7084] terminated
00347 stress-ng: debug: [7064] process [7085] terminated
00347 stress-ng: debug: [7064] process [7086] terminated
00347 stress-ng: debug: [7064] process [7087] terminated
00347 stress-ng: debug: [7064] process [7088] terminated
00347 stress-ng: debug: [7064] process [7089] terminated
00347 stress-ng: debug: [7064] process [7090] terminated
00347 stress-ng: debug: [7064] process [7091] terminated
00347 stress-ng: debug: [7064] process [7092] terminated
00347 stress-ng: warn:  [7064] process [7093] (fsize) aborted early, out of system resources
00347 stress-ng: debug: [7064] process [7093] terminated
00347 stress-ng: debug: [7064] process [7095] terminated
00347 stress-ng: debug: [7064] process [7097] terminated
00347 stress-ng: debug: [7064] process [7099] terminated
00347 stress-ng: debug: [7064] process [7100] terminated
00347 stress-ng: debug: [7064] process [7101] terminated
00347 stress-ng: debug: [7064] process [7102] terminated
00347 stress-ng: debug: [7064] process [7103] terminated
00347 stress-ng: debug: [7064] process [7104] terminated
00347 stress-ng: debug: [7064] process [7105] terminated
00347 stress-ng: debug: [7064] process [7106] terminated
00347 stress-ng: debug: [7064] process [7107] terminated
00347 stress-ng: debug: [7064] process [7108] terminated
00347 stress-ng: debug: [7064] process [7109] terminated
00347 stress-ng: debug: [7064] process [7110] terminated
00347 stress-ng: debug: [7064] process [7111] terminated
00348 stress-ng: debug: [7064] process [7112] terminated
00348 stress-ng: debug: [7064] process [7113] terminated
00348 stress-ng: debug: [7064] process [7114] terminated
00348 stress-ng: debug: [7064] process [7115] terminated
00348 stress-ng: debug: [7064] process [7116] terminated
00348 stress-ng: debug: [7064] process [7117] terminated
00348 stress-ng: debug: [7064] process [7122] terminated
00348 stress-ng: debug: [7064] process [7123] terminated
00348 stress-ng: debug: [7064] process [7124] terminated
00348 stress-ng: metrc: [7064] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
00348 stress-ng: metrc: [7064]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
00348 stress-ng: metrc: [7064] access            92728     60.02      1.43     32.95      1544.86        2696.69        57.29          2488
00348 stress-ng: metrc: [7064] binderfs              0      0.06      0.00      0.01         0.00           0.00        14.38          2616
00348 stress-ng: metrc: [7064] chattr              693     60.01      0.03      3.94        11.55         174.36         6.62          2744
00348 stress-ng: metrc: [7064] chdir              1490     60.32      4.62     21.25        24.70          57.60        42.88          3256
00348 stress-ng: metrc: [7064] chmod             10069     60.00      0.12     12.05       167.82         827.48        20.28          4536
00348 stress-ng: metrc: [7064] chown             24665     60.03      0.04      6.24       410.91        3925.12        10.47          2488
00348 stress-ng: metrc: [7064] copy-file          6075     60.38      0.03      4.34       100.62        1390.06         7.24          2488
00348 stress-ng: metrc: [7064] dentry            30720     60.69      0.17      3.61       506.14        8123.03         6.23          2616
00348 stress-ng: metrc: [7064] dir               40965     60.75      1.01     14.37       674.35        2663.57        25.32          2616
00348 stress-ng: metrc: [7064] dirdeep            2033     62.06      0.02      3.42        32.76         591.24         5.54          3128
00348 stress-ng: metrc: [7064] dirmany          132601     62.07      0.17     12.14      2136.38       10768.49        19.84          2488
00348 stress-ng: metrc: [7064] dup                6209     60.00      1.78      3.40       103.48        1199.94         8.62          4536
00348 stress-ng: metrc: [7064] eventfd         2629748     59.70      2.06     20.49     44050.14      116597.36        37.78          2488
00348 stress-ng: metrc: [7064] fallocate           247     59.82      0.03      4.48         4.13          54.70         7.55          2616
00348 stress-ng: metrc: [7064] fcntl             60490     60.01      0.21      6.24      1008.03        9379.51        10.75          4664
00348 stress-ng: metrc: [7064] fiemap           104902     59.93      0.22     88.95      1750.50        1176.46       148.79          4536
00348 stress-ng: metrc: [7064] file-ioctl        68726     59.93      0.13     12.55      1146.85        5418.40        21.17          2488
00348 stress-ng: metrc: [7064] filename           6886     60.03      0.28      7.24       114.70         915.65        12.53          4664
00348 stress-ng: metrc: [7064] flock          40473424     59.92     11.14     49.19    675509.94      670963.20       100.68          2488
00348 stress-ng: metrc: [7064] fpunch              127     60.03      0.01     10.24         2.12          12.39        17.07          2488
00348 stress-ng: metrc: [7064] fsize               751     11.72      0.03      2.30        64.09         322.55        19.87          4664
00348 stress-ng: metrc: [7064] fstat              9044     60.00      0.34      2.87       150.73        2819.63         5.35          5176
00348 stress-ng: metrc: [7064] getdent         4398565     60.00      2.45     24.15     73308.10      165350.47        44.33          3788
00348 stress-ng: metrc: [7064] handle          5622379     59.80      3.52     23.81     94019.84      205719.19        45.70          4664
00348 stress-ng: metrc: [7064] hdd              571562     59.92      5.82     10.71      9538.06       34577.07        27.58          2616
00348 stress-ng: metrc: [7064] inode-flags       60300     59.82      0.32     43.96      1008.05        1361.83        74.02          5432
00348 stress-ng: metrc: [7064] inotify             220     61.03      0.04      1.33         3.60         161.30         2.23          2616
00348 stress-ng: metrc: [7064] io                  157     60.63      0.00      0.13         2.59        1229.93         0.21          2616
00348 stress-ng: metrc: [7064] iomix            150775     60.85      1.14     14.76      2478.00        9481.86        26.13          4536
00348 stress-ng: metrc: [7064] ioprio             1111     60.03      0.03      3.33        18.51         330.16         5.61          2488
00348 stress-ng: metrc: [7064] lease           1974293     59.72      2.63     33.23     33061.05       55060.35        60.05          2488
00348 stress-ng: metrc: [7064] link                 42     60.09      0.67     14.97         0.70           2.69        26.02          2616
00348 stress-ng: metrc: [7064] locka         153825894     60.02     18.61     39.55   2563114.06     2645301.83        96.89          2488
00348 stress-ng: metrc: [7064] lockf            613600     60.02      0.20     14.88     10222.82       40697.59        25.12          4408
00348 stress-ng: metrc: [7064] lockofd       139472162     60.03     16.49     37.50   2323462.35     2583218.55        89.94          2488
00348 stress-ng: metrc: [7064] mknod              1105     60.63      0.01      1.38        18.23         798.07         2.28          2488
00348 stress-ng: metrc: [7064] open             114688     61.36      0.17      5.39      1868.95       20610.46         9.07          5048
00348 stress-ng: metrc: [7064] procfs            29595     59.83     17.77     69.28       494.63         340.00       145.48          5464
00348 stress-ng: metrc: [7064] rename            35670     60.02      0.23      4.84       594.29        7043.28         8.44          2616
00348 stress-ng: metrc: [7064] symlink               8     60.03      0.26      8.96         0.13           0.87        15.36          2616
00348 stress-ng: metrc: [7064] sync-file          1499     60.02      1.83      7.29        24.98         164.41        15.19          2488
00348 stress-ng: metrc: [7064] touch            166656     60.65      0.48     26.67      2747.61        6138.06        44.76          2488
00348 stress-ng: metrc: [7064] utime            190047     59.82      0.18     15.71      3177.04       11960.59        26.56          2488
00348 stress-ng: metrc: [7064] verity                0      4.04      0.00      0.00         0.00           0.00         0.05          2488
00348 stress-ng: metrc: [7064] xattr                70     59.72      0.21     12.61         1.17           5.46        21.48          2616
00348 stress-ng: metrc: [7064] miscellaneous metrics:
00348 stress-ng: metrc: [7064] access           3653537.23 access calls per sec (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] binderfs               0.00 microsecs per mount (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] binderfs               0.00 microsecs per umount (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] chdir             876899.92 chdir calls per sec (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] copy-file            310.43 MB per sec copy rate (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dentry            232354.07 nanosecs per file creation (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dentry              4143.11 nanosecs per file access (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dentry             13477.61 nanosecs per bogus file access (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dentry             12898.00 nanosecs per bogus file unlink (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dirmany               33.20 % of time creating directories (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dirmany               66.80 % of time removing directories (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] dup                 1555.98 nanosecs per dup call (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] flock               2017.39 nanosecs per flock lock call (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] flock               2712.21 nanosecs per flock unlock call (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] fpunch              2051.00 extents per file (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] fsize               4103.66 SIGXFSZ signals per sec (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] getdent             1979.83 nanosecs per getdents call (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] hdd                 3096.11 MB/sec read rate (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] hdd                  630.51 MB/sec write rate (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] hdd                 1046.94 MB/sec read/write combined rate (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] lease               9972.44 lease sigio interrupts per sec (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] open              121684.82 nanosecs per open (geometric mean of 1 instances)
00348 stress-ng: metrc: [7064] utime              69134.88 utime calls per sec (geometric mean of 1 instances)
00348 stress-ng: debug: [7064] metrics-check: all stressor metrics validated and sane
00348 stress-ng: info:  [7064] passed: 42: access (1) chattr (1) chdir (1) chmod (1) chown (1) copy-file (1) dentry (1) dir (1) dirdeep (1) dirmany (1) dup (1) eventfd (1) fallocate (1) fcntl (1) fiemap (1) file-ioctl (1) filename (1) flock (1) fpunch (1) fstat (1) getdent (1) handle (1) hdd (1) inode-flags (1) inotify (1) io (1) iomix (1) ioprio (1) lease (1) link (1) locka (1) lockf (1) lockofd (1) mknod (1) open (1) procfs (1) rename (1) symlink (1) sync-file (1) touch (1) utime (1) xattr (1)
00348 stress-ng: info:  [7064] failed: 0
00348 stress-ng: info:  [7064] skipped: 3: binderfs (1) fsize (1) verity (1)
00348 stress-ng: info:  [7064] successful run completed in 62.21s (1 min, 2.21 secs)
00348 stress-ng: debug: [59106] invoked with 'stress-ng -v -t 60 --class filesystem --all 2' by user 0 'root'
00348 stress-ng: debug: [59106] stress-ng 0.15.08
00348 stress-ng: debug: [59106] system: Linux Debian-1103-bullseye-arm64-base-kvm 6.5.0-ktest-ga2e02e2d17e1 #4586 SMP Sun Sep 10 01:20:24 UTC 2023 aarch64
00348 stress-ng: debug: [59106] RAM total: 3.8G, RAM free: 3.3G, swap free: 0.0
00348 stress-ng: debug: [59106] temporary file path: '.', filesystem type: unknown 0xca451a4e
00348 stress-ng: debug: [59106] 16 processors online, 16 processors configured
00348 stress-ng: info:  [59106] setting to a 60 second run per stressor
00348 stress-ng: info:  [59106] dnotify stressor will be skipped, cannot open '/proc/sys/fs/dir-notify-enable', CONFIG_DNOTIFY is probably not set
00348 stress-ng: info:  [59106] fanotify stressor will be skipped, : system call not supported
00348 stress-ng: info:  [59106] dispatching hogs: 2 access, 2 binderfs, 2 chattr, 2 chdir, 2 chmod, 2 chown, 2 copy-file, 2 dentry, 2 dir, 2 dirdeep, 2 dirmany, 2 dup, 2 eventfd, 2 fallocate, 2 fcntl, 2 fiemap, 2 file-ioctl, 2 filename, 2 flock, 2 fpunch, 2 fsize, 2 fstat, 2 getdent, 2 handle, 2 hdd, 2 inode-flags, 2 inotify, 2 io, 2 iomix, 2 ioprio, 2 lease, 2 link, 2 locka, 2 lockf, 2 lockofd, 2 mknod, 2 open, 2 procfs, 2 rename, 2 symlink, 2 sync-file, 2 touch, 2 utime, 2 verity, 2 xattr
00348 stress-ng: debug: [59106] cache allocate: using defaults, cannot determine cache level details
00348 stress-ng: debug: [59106] cache allocate: shared cache buffer size: 2048K
00348 stress-ng: debug: [59106] starting stressors
00348 stress-ng: debug: [59107] access: started [59107] (instance 0)
00348 stress-ng: debug: [59109] binderfs: started [59109] (instance 0)
00348 stress-ng: debug: [59111] chattr: started [59111] (instance 0)
00348 stress-ng: debug: [59115] chdir: started [59115] (instance 0)
00348 spectre-v4 mitigation disabled by command-line ostress-ng: debug: [59118] chmod: started [59118] (instance 0)ption
00348 
00348 stress-ng: debug: [59121] chown: started [59121] (instance 1)
00348 stress-ng: debug: [59123] copy-file: started [59123] (instance 1)
00348 stress-ng: debug: [59125] dentry: started [59125] (instance 1)
00348 stress-ng: debug: [59127] dir: started [59127] (instance 1)
00348 stress-ng: debug: [59129] dirdeep: started [59129] (instance 1)
00348 stress-ng: debug: [59131] dirmany: started [59131] (instance 1)
00348 stress-ng: debug: [59135] eventfd: started [59135] (instance 0)
00348 stress-ng: debug: [59137] fallocate: started [59137] (instance 0)
00348 stress-ng: debug: [59138] fallocate: started [59138] (instance 1)
00348 stress-ng: debug: [59143] fiemap: started [59143] (instance 1)
00348 stress-ng: debug: [59144] file-ioctl: started [59144] (instance 0)
00348 stress-ng: debug: [59150] filename: started [59150] (instance 0)
00348 stress-ng: debug: [59155] flock: started [59155] (instance 1)
00348 stress-ng: debug: [59158] fsize: started [59158] (instance 0)
00348 stress-ng: debug: [59160] fstat: started [59160] (instance 0)
00348 stress-ng: debug: [59164] getdent: started [59164] (instance 1)
00348 stress-ng: debug: [59168] handle: started [59168] (instance 1)
00348 stress-ng: debug: [59171] hdd: started [59171] (instance 1)
00348 stress-ng: debug: [59174] inotify: started [59174] (instance 0)
00348 stress-ng: debug: [59176] io: started [59176] (instance 0)
00348 stress-ng: info:  [59176] io: this is a legacy I/O sync stressor, consider using iomix instead
00348 stress-ng: debug: [59187] lease: started [59187] (instance 0)
00348 stress-ng-flock(59190): Attempt to set a LOCK_MAND lock via flock(2). This support has been removed and the request ignored.
00348 stress-ng: debug: [59191] link: started [59191] (instance 1)
00348 stress-ng: debug: [59205] lockofd: started [59205] (instance 1)
00348 stress-ng: debug: [59212] procfs: started [59212] (instance 1)
00348 stress-ng: debug: [59216] symlink: started [59216] (instance 1)
00348 stress-ng: debug: [59218] sync-file: started [59218] (instance 1)
00348 stress-ng: debug: [59221] utime: started [59221] (instance 0)
00348 stress-ng: debug: [59217] sync-file: started [59217] (instance 0)
00348 stress-ng: debug: [59223] verity: started [59223] (instance 0)
00348 stress-ng: debug: [59214] rename: started [59214] (instance 1)
00348 stress-ng: debug: [59108] access: started [59108] (instance 1)
00348 stress-ng: debug: [59112] chattr: started [59112] (instance 1)
00348 stress-ng: debug: [59120] chown: started [59120] (instance 0)
00348 stress-ng: debug: [59122] copy-file: started [59122] (instance 0)
00348 stress-ng: debug: [59126] dir: started [59126] (instance 0)
00348 stress-ng: debug: [59128] dirdeep: started [59128] (instance 0)
00348 stress-ng: debug: [59128] dirdeep: 33991688 inodes available, exercising up to 33991688 inodes
00348 stress-ng: debug: [59133] dup: started [59133] (instance 0)
00348 stress-ng: debug: [59134] dup: started [59134] (instance 1)
00348 stress-ng: debug: [59141] fcntl: started [59141] (instance 1)
00348 stress-ng: debug: [59142] fiemap: started [59142] (instance 0)
00348 stress-ng: debug: [59145] file-ioctl: started [59145] (instance 1)
00348 stress-ng: debug: [59154] flock: started [59154] (instance 0)
00348 stress-ng: debug: [59151] filename: started [59151] (instance 1)
00348 stress-ng: debug: [59159] fsize: started [59159] (instance 1)
00348 stress-ng: debug: [59161] fstat: started [59161] (instance 1)
00348 stress-ng: debug: [59166] handle: started [59166] (instance 0)
00348 stress-ng: debug: [59170] hdd: started [59170] (instance 0)
00348 stress-ng: debug: [59177] io: started [59177] (instance 1)
00348 stress-ng: debug: [59184] iomix: started [59184] (instance 1)
00348 stress-ng: debug: [59188] lease: started [59188] (instance 1)
00348 stress-ng: debug: [59196] lockf: started [59196] (instance 0)
00348 stress-ng: debug: [59195] locka: started [59195] (instance 1)
00348 stress-ng: debug: [59208] open: started [59208] (instance 0)
00348 stress-ng: debug: [59210] open: started [59210] (instance 1)
00348 stress-ng: debug: [59173] inode-flags: started [59173] (instance 1)
00348 stress-ng: debug: [59211] procfs: started [59211] (instance 0)
00348 stress-ng: debug: [59213] rename: started [59213] (instance 0)
00348 stress-ng: debug: [59219] touch: started [59219] (instance 0)
00348 stress-ng: debug: [59224] verity: started [59224] (instance 1)
00348 stress-ng: debug: [59220] touch: started [59220] (instance 1)
00348 stress-ng: info:  [59208] open: using a maximum of 524288 file descriptors
00348 stress-ng: info:  [59109] binderfs: binderfs not supported, errno=19 (No such device), skipping stress test
00348 stress-ng: debug: [59202] lockf: started [59202] (instance 1)
00348 stress-ng: debug: [59193] locka: started [59193] (instance 0)
00348 stress-ng: debug: [59109] binderfs: exited [59109] (instance 0)
00348 stress-ng: debug: [59110] binderfs: started [59110] (instance 1)
00348 stress-ng: debug: [59117] chdir: started [59117] (instance 1)
00348 stress-ng: debug: [59119] chmod: started [59119] (instance 1)
00348 stress-ng: debug: [59124] dentry: started [59124] (instance 0)
00348 stress-ng: debug: [59130] dirmany: started [59130] (instance 0)
00348 stress-ng: debug: [59136] eventfd: started [59136] (instance 1)
00348 stress-ng: debug: [59139] fcntl: started [59139] (instance 0)
00348 stress-ng: debug: [59156] fpunch: started [59156] (instance 0)
00348 stress-ng: debug: [59162] getdent: started [59162] (instance 0)
00348 stress-ng: debug: [59157] fpunch: started [59157] (instance 1)
00348 stress-ng: debug: [59172] inode-flags: started [59172] (instance 0)
00348 stress-ng: debug: [59175] inotify: started [59175] (instance 1)
00348 stress-ng: debug: [59179] iomix: started [59179] (instance 0)
00348 stress-ng: debug: [59185] ioprio: started [59185] (instance 0)
00348 stress-ng: debug: [59186] ioprio: started [59186] (instance 1)
00348 stress-ng: debug: [59189] link: started [59189] (instance 0)
00348 stress-ng: debug: [59207] mknod: started [59207] (instance 1)
00348 stress-ng: debug: [59215] symlink: started [59215] (instance 0)
00348 stress-ng: debug: [59206] mknod: started [59206] (instance 0)
00348 stress-ng: debug: [59106] 90 stressors started
00348 stress-ng: debug: [59225] xattr: started [59225] (instance 0)
00348 stress-ng: debug: [59226] xattr: started [59226] (instance 1)
00348 stress-ng: debug: [59204] lockofd: started [59204] (instance 0)
00348 stress-ng: info:  [59110] binderfs: binderfs not supported, errno=19 (No such device), skipping stress test
00348 stress-ng: debug: [59130] dirmany: 0 byte file size
00348 stress-ng: debug: [59222] utime: started [59222] (instance 1)
00348 stress-ng: debug: [59110] binderfs: exited [59110] (instance 1)
00355 stress-ng: info:  [59159] fsize: allocating file to 262144 (0x40000) bytes failed, errno=28 (No space left on device), skipping stressor
00355 stress-ng: debug: [59159] fsize: exited [59159] (instance 1)
00358 stress-ng: debug: [59150] filename: filesystem allows 254 unique characters in a 512 character long filename
00372 stress-ng: info:  [59223] verity: verity is not supported on the file system or by the kernel, skipping stress test
00372 stress-ng: debug: [59223] verity: exited [59223] (instance 0)
00375 stress-ng-iomix (59356): drop_caches: 1
00378 stress-ng-iomix (59486): drop_caches: 1
00383 stress-ng: debug: [59224] verity: exited [59224] (instance 1)
00385 ------------[ cut here ]------------
00385 kernel BUG at fs/dcache.c:2032!
00385 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
00385 Modules linked in:
00385 CPU: 15 PID: 59330 Comm: stress-ng-touch Not tainted 6.5.0-ktest-ga2e02e2d17e1 #4586
00385 Hardware name: linux,dummy-virt (DT)
00385 pstate: 80001005 (Nzcv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=--)
00385 pc : d_instantiate+0x6c/0x80
00385 lr : bch2_create+0x44/0x68
00385 sp : ffffff80d4af3bb0
00385 x29: ffffff80d4af3bb0 x28: ffffffc081079070 x27: ffffff80d4af3cb8
00385 x26: ffffff8016dfe600 x25: 0000000000020041 x24: 0000000000000040
00385 x23: 0000000000000001 x22: ffffff80e8646600 x21: ffffff80c7015000
00385 x20: ffffff80d4af3ddc x19: ffffff8016dfe600 x18: 3be2c5ba00000000
00385 x17: 0000000000000003 x16: ffffff80ab94a748 x15: 0000000000000000
00385 x14: 0000000000000000 x13: 00000000500086d4 x12: 0000000000000000
00385 x11: 0000000000000000 x10: 0000000000000000 x9 : ffffffc08055174c
00385 x8 : 000000000003ffff x7 : 00000000ee38ca36 x6 : 0000000000000000
00385 x5 : 0000000000031af8 x4 : 0000000000000000 x3 : ffffff801b5c4000
00385 x2 : ffffffc0811b6598 x1 : ffffff8001a49cc0 x0 : ffffff8016dfe600
00385 Call trace:
00385  d_instantiate+0x6c/0x80
00385  path_openat+0x3d0/0xc90
00385  do_filp_open+0x74/0x108
00385  do_sys_openat2+0x98/0xc8
00385  __arm64_sys_openat+0x5c/0x90
00385  invoke_syscall.constprop.0+0x54/0xf0
00385  do_el0_svc+0x48/0xd0
00385  el0_svc+0x14/0x48
00385  el0t_64_sync_handler+0xb8/0xc0
00385  el0t_64_sync+0x14c/0x150
00385 Code: 089ffc1f a94153f3 a8c27bfd d65f03c0 (d4210000) 
00385 ---[ end trace 0000000000000000 ]---
00385 Kernel panic - not syncing: Oops - BUG: Fatal exception
00385 SMP: stopping secondary CPUs
00385 Kernel Offset: disabled
00385 CPU features: 0x00000000,38000000,8840500b
00385 Memory Limit: none
00385 ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
00390 ========= FAILED TIMEOUT stress_ng in 300s

