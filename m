Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02F79D78C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 19:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjILRab (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjILRab (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:30:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD1010D9;
        Tue, 12 Sep 2023 10:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308F1C433C8;
        Tue, 12 Sep 2023 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694539827;
        bh=dEk2IZGcrWfEGSCP94z3kUd9pZb7zq7xnx81DcVGpa4=;
        h=Date:From:To:Cc:Subject:From;
        b=DupM0LnOUkRbGBRuMPwLmFbLJ1wpbv/jSi47CYnaCAIsDQHXG1so3XbAWa0ydFtDd
         MJm1nt29gzlYowglB4ZjQik5FPsF8UOnRZGEjVE+nvRCG14WPH/vbSXvlNgzYnXdEH
         uTfxCsNe6K15xiXAcCtz/6rGzQZz8CGnLSlXmtnkQKEty7iiUEQVbl//r2MZ1iOxVH
         KLdpriXsAe1vsTDhuId06leHa3c+vftF+V0EGWQ89svY+ynXYDc2hnh3hs4Yhdv7Mz
         1d23pTxcdPh0V4t8xsi+UzF2hlJX3fTXbgCTKAoMFIVFZFzYx5iKEVgWBkr6hW3+wS
         hc57eKgrViNfA==
Date:   Tue, 12 Sep 2023 10:30:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: dentry UAF bugs crashing arm64 machines on 6.5/6.6?
Message-ID: <20230912173026.GA3389127@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone,

Shortly after 6.5 was tagged, I started seeing the following stacktraces
when running xfs through fstests on arm64.  Curiously, x86_64 does not
seem affected.

At first I thought this might be caused by the bug fixes in my
development tree, so I started bisecting them.  Bisecting identified a
particular patchset[1] that didn't seem like it was the culprit.  A
couple of days later, one of my arm64 vms with that patch reverted
crashed in the same way.  So, clearly not the culprit.

[1] https://lore.kernel.org/linux-xfs/169335056933.3525521.6054773682023937525.stgit@frogsfrogsfrogs/

  run fstests generic/162 at 2023-09-11 22:06:42
  spectre-v4 mitigation disabled by command-line option
  XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
  XFS (sda2): Ending clean mount
  XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda3): Mounting V5 Filesystem 0c328923-fa81-458f-846c-45bb6828aa0f
  XFS (sda3): Ending clean mount
  XFS (sda3): Quotacheck needed: Please wait.
  XFS (sda3): Quotacheck: Done.
  XFS (sda3): Unmounting Filesystem 0c328923-fa81-458f-846c-45bb6828aa0f
  XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  XFS (sda3): Ending clean mount
  XFS (sda3): Quotacheck needed: Please wait.
  XFS (sda3): Quotacheck: Done.
  XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  XFS (sda3): Ending clean mount
  ==================================================================
  BUG: KASAN: slab-use-after-free in d_alloc_parallel+0x850/0xa00
  Read of size 4 at addr fffffc0176c88360 by task xfs_io/1341106
  
  CPU: 0 PID: 1341106 Comm: xfs_io Not tainted 6.5.0-xfsa #12 7284e9be14b81c73627c489aa5df798cf1143960
  Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
  Call trace:
   dump_backtrace+0x9c/0x100
   show_stack+0x20/0x38
   dump_stack_lvl+0x48/0x60
   print_report+0xf4/0x5b0
   kasan_report+0xa4/0xf0
   __asan_report_load4_noabort+0x20/0x30
   d_alloc_parallel+0x850/0xa00
   __lookup_slow+0x11c/0x2e8
   walk_component+0x1f8/0x498
   link_path_walk.part.0.constprop.0+0x41c/0x960
   path_lookupat+0x70/0x590
   filename_lookup+0x144/0x368
   user_path_at_empty+0x54/0x88
   do_faccessat+0x3f0/0x7c0
   __arm64_sys_faccessat+0x78/0xb0
   do_el0_svc+0x124/0x318
   el0_svc+0x34/0xe8
   el0t_64_sync_handler+0x13c/0x158
   el0t_64_sync+0x190/0x198
  
  Allocated by task 1340914:
   kasan_save_stack+0x2c/0x58
   kasan_set_track+0x2c/0x40
   kasan_save_alloc_info+0x24/0x38
   __kasan_slab_alloc+0x74/0x90
   kmem_cache_alloc_lru+0x180/0x440
   __d_alloc+0x40/0x830
   d_alloc+0x3c/0x1c8
   d_alloc_parallel+0xe4/0xa00
   __lookup_slow+0x11c/0x2e8
   walk_component+0x1f8/0x498
   path_lookupat+0x10c/0x590
   filename_lookup+0x144/0x368
   user_path_at_empty+0x54/0x88
   do_readlinkat+0xcc/0x250
   __arm64_sys_readlinkat+0x90/0xe0
   do_el0_svc+0x124/0x318
   el0_svc+0x34/0xe8
   el0t_64_sync_handler+0x13c/0x158
   el0t_64_sync+0x190/0x198
  
  Last potentially related work creation:
   kasan_save_stack+0x2c/0x58
   __kasan_record_aux_stack+0x9c/0xc8
   kasan_record_aux_stack_noalloc+0x14/0x20
   __call_rcu_common.constprop.0+0x74/0x5b0
   call_rcu+0x18/0x30
   dentry_free+0x9c/0x158
   __dentry_kill+0x434/0x578
   dput+0x30c/0x6b8
   step_into+0xa50/0x1680
   walk_component+0xb0/0x498
   path_lookupat+0x10c/0x590
   filename_lookup+0x144/0x368
   user_path_at_empty+0x54/0x88
   do_readlinkat+0xcc/0x250
   __arm64_sys_readlinkat+0x90/0xe0
   do_el0_svc+0x124/0x318
   el0_svc+0x34/0xe8
   el0t_64_sync_handler+0x13c/0x158
   el0t_64_sync+0x190/0x198
  
  Second to last potentially related work creation:
   kasan_save_stack+0x2c/0x58
   __kasan_record_aux_stack+0x9c/0xc8
   kasan_record_aux_stack_noalloc+0x14/0x20
   __call_rcu_common.constprop.0+0x74/0x5b0
   call_rcu+0x18/0x30
   dentry_free+0x9c/0x158
   __dentry_kill+0x434/0x578
   dput+0x30c/0x6b8
   step_into+0xa50/0x1680
   walk_component+0xb0/0x498
   path_lookupat+0x10c/0x590
   filename_lookup+0x144/0x368
   user_path_at_empty+0x54/0x88
   do_readlinkat+0xcc/0x250
   __arm64_sys_readlinkat+0x90/0xe0
   do_el0_svc+0x124/0x318
   el0_svc+0x34/0xe8
   el0t_64_sync_handler+0x13c/0x158
   el0t_64_sync+0x190/0x198
  
  The buggy address belongs to the object at fffffc0176c88340
   which belongs to the cache dentry of size 216
  The buggy address is located 32 bytes inside of
   freed 216-byte region [fffffc0176c88340, fffffc0176c88418)
  
  The buggy address belongs to the physical page:
  page:ffffffff005db200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xfffffc0176c86900 pfn:0x1b6c8
  memcg:fffffc004195a001
  flags: 0x1ffe000000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
  page_type: 0xffffffff()
  raw: 1ffe000000000200 fffffc00e0016b80 ffffffff0052bb90 ffffffff00405350
  raw: fffffc0176c86900 0000000000ea0037 00000001ffffffff fffffc004195a001
  page dumped because: kasan: bad access detected
  
  Memory state around the buggy address:
   fffffc0176c88200: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
   fffffc0176c88280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  >fffffc0176c88300: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
                                                         ^
   fffffc0176c88380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   fffffc0176c88400: fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb fb
  ==================================================================
  Disabling lock debugging due to kernel taint
  XFS (sda2): Unmounting Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
  XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
  XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=1343704 'xfs_repair'
  XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda3): Mounting V5 Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  XFS (sda3): Ending clean mount
  XFS (sda3): Unmounting Filesystem 287e61f0-a509-4dd1-b788-70076dda0efd
  run fstests generic/137 at 2023-09-11 22:06:59
  spectre-v4 mitigation disabled by command-line option
  XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
  XFS (sda2): Ending clean mount
  XFS (sda2): Unmounting Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
  XFS (sda2): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL realtime allocation group feature in use. Use at your own risk!
  XFS (sda2): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
  XFS (sda2): Mounting V5 Filesystem ec3b0e05-f8c2-4fe5-a6cf-d8c5819c6ee7
  XFS (sda2): Ending clean mount
  Unable to handle kernel paging request at virtual address e0c83a00c0029201
  KASAN: maybe wild-memory-access in range [0x0641e00600149008-0x0641e0060014900f]
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [e0c83a00c0029201] address between user and kernel address ranges
  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
  Dumping ftrace buffer:
     (ftrace buffer empty)
  Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison xfs ext2 mbcache dm_flakey dm_snapshot dm_bufio dm_zero nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp crct10dif_ce bfq ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables libcrc32c sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
  CPU: 1 PID: 1348080 Comm: md5sum Tainted: G    B              6.5.0-xfsa #12 7284e9be14b81c73627c489aa5df798cf1143960
  Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
  pstate: 40401005 (nZcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
  pc : d_alloc_parallel+0x250/0xa00
  lr : d_alloc_parallel+0x85c/0xa00
  sp : fffffe008b8cf720
  x29: fffffe008b8cf720 x28: 00c83c00c0029201 x27: fffffc00fa39e340
  x26: 000000003c7f8e47 x25: dffffe0000000000 x24: fffffe0082ab9d90
  x23: 0000000000000003 x22: fffffc014dd9df20 x21: 0641e006001490b0
  x20: 0641e00600149008 x19: fffffe00825a55c0 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  x14: 0000000000000001 x13: 80808080807fffff x12: fffffdc0105573b3
  x11: 1fffffc0105573b2 x10: fffffdc0105573b2 x9 : dffffe0000000000
  x8 : 0000023fefaa8c4e x7 : fffffe0082ab9d97 x6 : 0000000000000001
  x5 : fffffe0082ab9d90 x4 : 0000000000000000 x3 : fffffe008070fad4
  x2 : 0000000000000000 x1 : fffffe0082a9e9d8 x0 : 0000000000000000
  Call trace:
   d_alloc_parallel+0x250/0xa00
   path_openat+0x1030/0x23d0
   do_filp_open+0x15c/0x338
   do_sys_openat2+0x12c/0x168
   __arm64_sys_openat+0x138/0x1d0
   do_el0_svc+0x124/0x318
   el0_svc+0x34/0xe8
   el0t_64_sync_handler+0x13c/0x158
   el0t_64_sync+0x190/0x198
  Code: f94002b5 b4001375 d102a2b4 d343fe9c (38f96b80) 
  ---[ end trace 0000000000000000 ]---
  note: md5sum[1348080] exited with preempt_count 1

I tried popping /all/ the bugfixes, and for 6.5 that seemed to make
fstests settle down.  But then 6.6-rc1 came out, and the crashes
returned.  In addition, there's a new crash:

  run fstests xfs/711 at 2023-09-11 20:25:35
  spectre-v4 mitigation disabled by command-line option
  XFS (sda3): Mounting V5 Filesystem add44358-2799-4361-b909-073e50305a53
  XFS (sda3): Ending clean mount
  XFS (sda3): Quotacheck needed: Please wait.
  XFS (sda3): Quotacheck: Done.
  XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
  Unable to handle kernel execute from non-executable memory at virtual address fffffe0082e85070
  KASAN: probably user-memory-access in range [0x0000000417428380-0x0000000417428387]
  Mem abort info:
    ESR = 0x000000008600000f
    EC = 0x21: IABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x0f: level 3 permission fault
  swapper pgtable: 64k pages, 42-bit VAs, pgdp=0000000041d40000
  [fffffe0082e85070] pgd=100000023fff0003, p4d=100000023fff0003, pud=100000023fff0003, pmd=100000023fff0003, pte=0068000042e80703
  Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
  Dumping ftrace buffer:
     (ftrace buffer empty)
  Modules linked in: xfs nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set bfq nf_tables libcrc32c crct10dif_ce nfnetlink sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0-rc1-djwa #rc1 31f6bcd5927f495a7ed31b02fb778f37562278b5
  Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
  pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
  pc : in_lookup_hashtable+0x16b0/0x2020
  lr : rcu_core+0xadc/0x13a8
  sp : fffffe0082f2fdc0
  x29: fffffe0082f2fdc0 x28: fffffd801c1228a1 x27: fffffc00e0914500
  x26: 0000000000000003 x25: fffffc01bea6aa38 x24: fffffe0082f2fea0
  x23: 1fffffc0105e5fd0 x22: fffffe00826459f8 x21: dffffe0000000000
  x20: 0000000000000003 x19: fffffc01bea6a9c0 x18: 0000000000000000
  x17: fffffe013cac0000 x16: fffffe0082f20000 x15: 0000000000000000
  x14: 0000000000000000 x13: 1fffffc0102ff4f1 x12: fffffdc0104dafc9
  x11: 1fffffc0104dafc8 x10: fffffdc0104dafc8 x9 : fffffe00802188dc
  x8 : fffffd802037eb51 x7 : fffffe0082f2fab8 x6 : 0000000000000002
  x5 : 0000000000000050 x4 : fffffc01bd7f34e8 x3 : 0000000000000118
  x2 : fffffe0082e85070 x1 : fffffc0101bfa078 x0 : fffffc0101bfa078
  Call trace:
   in_lookup_hashtable+0x16b0/0x2020
   rcu_core_si+0x18/0x30
   __do_softirq+0x280/0xad4
   ____do_softirq+0x18/0x30
   call_on_irq_stack+0x24/0x58
   do_softirq_own_stack+0x24/0x38
   irq_exit_rcu+0x198/0x238
   el1_interrupt+0x38/0x58
   el1h_64_irq_handler+0x18/0x28
   el1h_64_irq+0x64/0x68
   arch_local_irq_enable+0x4/0x8
   do_idle+0x32c/0x450
   cpu_startup_entry+0x2c/0x40
   secondary_start_kernel+0x230/0x2e0
   __secondary_switched+0xb8/0xc0
  Code: 00000000 00000000 00000000 00000000 (01bfa078) 
  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Oops: Fatal exception in interrupt
  SMP: stopping secondary CPUs
  Dumping ftrace buffer:
     (ftrace buffer empty)
  Kernel Offset: disabled
  CPU features: 0x00000000,70020043,1001700b
  Memory Limit: none
  ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

IDGI.  Has anyone else seen this sort of crash?  They all seem to
revolve around UAF bugs with dentries that look like they've been
rcu-freed recently.

Kent said he's affected by some crash on arm64 too, so I cc'd him.

I also haven't any clue why this hasn't triggered at all on x86_64.

--D
