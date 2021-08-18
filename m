Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9D3F09CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 19:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhHRRC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 13:02:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229883AbhHRRC1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:02:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A88606A5;
        Wed, 18 Aug 2021 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629306112;
        bh=2aGXcgHAr3/FRypErIIOo5rr+NL0/eGBe2F4C7j3IPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7ZQjQse2BavvKui2gg7TwUw0Q3SxoMQVTAJW8kkdXTJuArZgZCnOa24CfPENv3sJ
         Ht3C7yBCVaAl/vAPpUaB3aSvvrrz+t00Wru2a32eO60CETCTLJ9M/LY4fy+ZHanqxY
         jv9alw1WSlxrH78PVlqSPU6s9d6ifPHcchRPgFgf+N/5+GO3/oo/9UlsmARK4jitCI
         xH3wnMOzEg1J6RlMQwSu03aFixRfSqph92asD2BGnFGGxDm7ixqubuub4qXLaA8TDd
         0KVrQB2v/tvz0VWAPPbKAtCzkDTxiNdwOpsqqsoJdQlBCDXDp0O8ijuCYzquo4yqqB
         k7/5+vWJUgEFQ==
Date:   Wed, 18 Aug 2021 10:01:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Xu Yu <xuyu@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, riteshh@linux.ibm.com, tytso@mit.edu,
        gavin.dg@linux.alibaba.com
Subject: Re: [PATCH] mm/swap: consider max pages in iomap_swapfile_add_extent
Message-ID: <20210818170152.GG12664@magnolia>
References: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db99c25a8e2a662046e498fd13e5f0c35364164a.1629286473.git.xuyu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 07:36:51PM +0800, Xu Yu wrote:
> When the max pages (last_page in the swap header + 1) is smaller than
> the total pages (inode size) of the swapfile, iomap_swapfile_activate
> overwrites sis->max with total pages.
> 
> However, frontswap_map is allocated using max pages, but cleared using
> sis->max in __frontswap_invalidate_area(). The consequence is that the
> neighbors of frontswap_map bitmap may be overwritten, and then slab is
> polluted.
> 
> This fixes the issue by considering the limitation of max pages of swap
> info in iomap_swapfile_add_extent().
> 
> To reproduce the case, compile kernel with slub RED ZONE, then run test:
> $ sudo stress-ng -a 1 -x softlockup,resources -t 72h --metrics --times \
>  --verify -v -Y /root/tmpdir/stress-ng/stress-statistic-12.yaml \
>  --log-file /root/tmpdir/stress-ng/stress-logfile-12.txt \
>  --temp-path /root/tmpdir/stress-ng/

72 hours?  That's not really a targeted reproducer test.

Oh, very interesting!  maxpages comes from the swap header.

# fallocate -l 100m /mnt/a
# mkswap /mnt/a
mkswap: /mnt/a: insecure permissions 0644, 0600 suggested.
Setting up swapspace version 1, size = 100 MiB (104853504 bytes)
no label, UUID=c6c93d94-3b91-47cc-9684-9c0edbd04759
# swapon /mnt/a
swapon: /mnt/a: insecure permissions 0644, 0600 suggested.
[   68.267848] Adding 102396k swap on /mnt/a.  Priority:-2 extents:1 across:102396k SS


Ok, ~100M of swap...

# swapoff /mnt/a
# fallocate -l 200m /mnt/a
# swapon /mnt/a
swapon: /mnt/a: insecure permissions 0644, 0600 suggested.
[   84.458713] Adding 204796k swap on /mnt/a.  Priority:-2 extents:1 across:204796k SS

Huh.  200MB of swap, even though we haven't touched the swap header:

# dd if=/mnt/a bs=4096 count=1 | od -tx1 -Ad -c
0000000  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
         \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0001024  01  00  00  00  ff  63  00  00  00  00  00  00  66  40  eb  42
        001  \0  \0  \0 377   c  \0  \0  \0  \0  \0  \0   f   @ 353   B

Version 1 swap header, 0x63ff pages (~102396kb), 0 bad pages...

0001040  8e  81  4e  4e  92  a1  f9  98  d9  43  2f  cc  00  00  00  00
        216 201   N   N 222 241 371 230 331   C   / 314  \0  \0  \0  \0
0001056  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
         \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0  \0
*
0004080  00  00  00  00  00  00  53  57  41  50  53  50  41  43  45  32
         \0  \0  \0  \0  \0  \0   S   W   A   P   S   P   A   C   E   2
0004096

So yes, iomap_swapfile_* is incorrect.  Even better, we have a targeted
way to test this now. :)

> We'll get the error log as below:
> 
> [ 1151.015141] =============================================================================
> [ 1151.016489] BUG kmalloc-16 (Not tainted): Right Redzone overwritten
> [ 1151.017486] -----------------------------------------------------------------------------
> [ 1151.017486]
> [ 1151.018997] Disabling lock debugging due to kernel taint
> [ 1151.019873] INFO: 0x0000000084e43932-0x0000000098d17cae @offset=7392. First byte 0x0 instead of 0xcc
> [ 1151.021303] INFO: Allocated in __do_sys_swapon+0xcf6/0x1170 age=43417 cpu=9 pid=3816
> [ 1151.022538]  __slab_alloc+0xe/0x20
> [ 1151.023069]  __kmalloc_node+0xfd/0x4b0
> [ 1151.023704]  __do_sys_swapon+0xcf6/0x1170
> [ 1151.024346]  do_syscall_64+0x33/0x40
> [ 1151.024925]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1151.025749] INFO: Freed in put_cred_rcu+0xa1/0xc0 age=43424 cpu=3 pid=2041
> [ 1151.026889]  kfree+0x276/0x2b0
> [ 1151.027405]  put_cred_rcu+0xa1/0xc0
> [ 1151.027949]  rcu_do_batch+0x17d/0x410
> [ 1151.028566]  rcu_core+0x14e/0x2b0
> [ 1151.029084]  __do_softirq+0x101/0x29e
> [ 1151.029645]  asm_call_irq_on_stack+0x12/0x20
> [ 1151.030381]  do_softirq_own_stack+0x37/0x40
> [ 1151.031037]  do_softirq.part.15+0x2b/0x30
> [ 1151.031710]  __local_bh_enable_ip+0x4b/0x50
> [ 1151.032412]  copy_fpstate_to_sigframe+0x111/0x360
> [ 1151.033197]  __setup_rt_frame+0xce/0x480
> [ 1151.033809]  arch_do_signal+0x1a3/0x250
> [ 1151.034463]  exit_to_user_mode_prepare+0xcf/0x110
> [ 1151.035242]  syscall_exit_to_user_mode+0x27/0x190
> [ 1151.035970]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1151.036795] INFO: Slab 0x000000003b9de4dc objects=44 used=9 fp=0x00000000539e349e flags=0xfffffc0010201
> [ 1151.038323] INFO: Object 0x000000004855ba01 @offset=7376 fp=0x0000000000000000
> [ 1151.038323]
> [ 1151.039683] Redzone  000000008d0afd3d: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
> [ 1151.041180] Object   000000004855ba01: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> [ 1151.042714] Redzone  0000000084e43932: 00 00 00 c0 cc cc cc cc                          ........
> [ 1151.044120] Padding  000000000864c042: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
> [ 1151.045615] CPU: 5 PID: 3816 Comm: stress-ng Tainted: G    B             5.10.50+ #7
> [ 1151.046846] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> [ 1151.048633] Call Trace:
> [ 1151.049072]  dump_stack+0x57/0x6a
> [ 1151.049585]  check_bytes_and_report+0xed/0x110
> [ 1151.050320]  check_object+0x1eb/0x290
> [ 1151.050924]  ? __x64_sys_swapoff+0x39a/0x540
> [ 1151.051646]  free_debug_processing+0x151/0x350
> [ 1151.052333]  __slab_free+0x21a/0x3a0
> [ 1151.052938]  ? _cond_resched+0x2d/0x40
> [ 1151.053529]  ? __vunmap+0x1de/0x220
> [ 1151.054139]  ? __x64_sys_swapoff+0x39a/0x540
> [ 1151.054796]  ? kfree+0x276/0x2b0
> [ 1151.055307]  kfree+0x276/0x2b0
> [ 1151.055832]  __x64_sys_swapoff+0x39a/0x540
> [ 1151.056466]  do_syscall_64+0x33/0x40
> [ 1151.057084]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1151.057866] RIP: 0033:0x150340b0ffb7
> [ 1151.058481] Code: Unable to access opcode bytes at RIP 0x150340b0ff8d.
> [ 1151.059537] RSP: 002b:00007fff7f4ee238 EFLAGS: 00000246 ORIG_RAX: 00000000000000a8
> [ 1151.060768] RAX: ffffffffffffffda RBX: 00007fff7f4ee66c RCX: 0000150340b0ffb7
> [ 1151.061904] RDX: 000000000000000a RSI: 0000000000018094 RDI: 00007fff7f4ee860
> [ 1151.063033] RBP: 00007fff7f4ef980 R08: 0000000000000000 R09: 0000150340a672bd
> [ 1151.064135] R10: 00007fff7f4edca0 R11: 0000000000000246 R12: 0000000000018094
> [ 1151.065253] R13: 0000000000000005 R14: 000000000160d930 R15: 00007fff7f4ee66c
> [ 1151.066413] FIX kmalloc-16: Restoring 0x0000000084e43932-0x0000000098d17cae=0xcc
> [ 1151.066413]
> [ 1151.067890] FIX kmalloc-16: Object at 0x000000004855ba01 not freed
> 
> Fixes: 0e6895ba00b7 ("ext4: implement swap_activate aops using iomap")
> Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>

Looks good; I'll cc you both when I send out the regression test.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/swapfile.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
> index 6250ca6a1f85..4ecf4e1f68ef 100644
> --- a/fs/iomap/swapfile.c
> +++ b/fs/iomap/swapfile.c
> @@ -31,11 +31,16 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
>  {
>  	struct iomap *iomap = &isi->iomap;
>  	unsigned long nr_pages;
> +	unsigned long max_pages;
>  	uint64_t first_ppage;
>  	uint64_t first_ppage_reported;
>  	uint64_t next_ppage;
>  	int error;
>  
> +	if (unlikely(isi->nr_pages >= isi->sis->max))
> +		return 0;
> +	max_pages = isi->sis->max - isi->nr_pages;
> +
>  	/*
>  	 * Round the start up and the end down so that the physical
>  	 * extent aligns to a page boundary.
> @@ -48,6 +53,7 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
>  	if (first_ppage >= next_ppage)
>  		return 0;
>  	nr_pages = next_ppage - first_ppage;
> +	nr_pages = min(nr_pages, max_pages);
>  
>  	/*
>  	 * Calculate how much swap space we're adding; the first page contains
> -- 
> 2.20.1.2432.ga663e714
> 
