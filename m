Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1816654B07C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 14:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiFNMXj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiFNMXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:23:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294CE1F2CA;
        Tue, 14 Jun 2022 05:23:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FC5F21A66;
        Tue, 14 Jun 2022 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655209415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cytmGLkOXP0ZKr75iGxDdhwnxTw03pqO4oTaHscD8us=;
        b=Y997rf9wM+mMkcXEZvmkhYR8CN3MIE9GMweLOZSWiflnDZT6Qg92Dy2UJXifLckTpdKuBu
        F170nZv90IUnj2MeGFjB+vTofOYBepCXv/CkJlcDeSCD9FAL2z65B44yeC1JzxUITZlndE
        hKzHBR0CsR+cNk8aDSPAyv63o6hRPzg=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 231A52C141;
        Tue, 14 Jun 2022 12:23:35 +0000 (UTC)
Date:   Tue, 14 Jun 2022 14:23:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>, jack@suse.cz
Cc:     sunjunchao2870@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <Yqh9xIwBVcabpSLe@alley>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqdry+IghSWnJ6pe@monolith.localdoman>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2022-06-13 17:54:35, Alexandru Elisei wrote:
> Hi,
> 
> (Apologies for the long To: list, I've added everyone that
> scripts/get_maintainer.pl listed for fs/{fs-writeback,inode}.c, for the
> rockchip boards, for printk.c and for the tty layer)
> 
> When booting a kernel built from tag v5.19-rc2, my rockpro64-v2 hangs at
> boot with this log:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.19.0-rc2 (alex@redacted) (aarch64-linux-gnu-gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 2.38) #90 SMP PREEMPT Mon Jun 13 17:13:12 BST 2022
> [    0.000000] Machine model: Pine64 RockPro64 v2.0
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options '1500000n8')
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x00000000f7ffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0xf77dc140-0xf77ddfff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000200000-0x00000000f7ffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000200000-0x00000000f7ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000200000-0x00000000f7ffffff]
> [    0.000000] On node 0, zone DMA: 512 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x00000000f0000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] percpu: Embedded 20 pages/cpu s41768 r8192 d31960 u81920
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] Fallback order for Node 0: 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 999432
> [    0.000000] Policy zone: DMA
> [    0.000000] Kernel command line: root=PARTUUID=7f4aab92-69d8-47f3-be10-624da40a71f9 rw earlycon rootwait
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 3915796K/4061184K available (15552K kernel code, 2758K rwdata, 8668K rodata, 6336K init, 564K bss, 112620K reserved, 32768K cma-reserved)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
> [    0.000000] rcu: Preemptible hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
> [    0.000000] GICv3: 256 SPIs implemented
> [    0.000000] GICv3: 0 Extended SPIs implemented
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] GICv3: GICv3 features: 16 PPIs
> [    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x00000000fef00000
> [    0.000000] ITS [mem 0xfee20000-0xfee3ffff]
> [    0.000000] ITS@0x00000000fee20000: allocated 65536 Devices @480000 (flat, esz 8, psz 64K, shr 0)
> [    0.000000] ITS: using cache flushing for cmd queue
> [    0.000000] GICv3: using LPI property table @0x0000000000440000
> [    0.000000] GIC: using cache flushing for LPI property table
> [    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000000000450000
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] { /cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
> [    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] { /cpus/cpu@100[4] /cpus/cpu@101[5] }
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
> [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
> [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.005107] Console: colour dummy device 80x25
> [    0.005549] printk: console [tty0] enabled
> [    0.005956] printk: bootconsole [uart0] disabled
> 
> Config can be found at [1] (expires after 6 months). I've also built the
> kernel with gcc 10.3.1 [2] (aarch64-none-linux-gnu), same issue.
> 
> I've bisected the build failure to commit 10e14073107d ("writeback: Fix
> inode->i_io_list not be protected by inode->i_lock error"); I've confirmed
> that that commit is responsible by successfully booting the board with a
> kernel built from v5.19-rc2 + the above commit reverted.

It is strange. I can't see how consoles are related to filesystem
writeback.

Anyway, the commit 10e14073107d ("writeback: Fix inode->i_io_list not
be protected by inode->i_lock error") modifies some locking and
might be source of possible deadlocks.

I am not familiar with the fs code. But I noticed the following.
The patch adds:

+               if (!was_dirty) {
+                       wb = locked_inode_to_wb_and_lock_list(inode);
+                       spin_lock(&inode->i_lock);

And locked_inode_to_wb_and_lock_list() is defined this way:

/**
 * locked_inode_to_wb_and_lock_list - determine a locked inode's wb and lock it
 * @inode: inode of interest with i_lock held
 *
 * Returns @inode's wb with its list_lock held.  @inode->i_lock must be
 * held on entry and is released on return.  The returned wb is guaranteed
 * to stay @inode's associated wb until its list_lock is released.
 */
static struct bdi_writeback *
locked_inode_to_wb_and_lock_list(struct inode *inode)
	__releases(&inode->i_lock)
	__acquires(&wb->list_lock)
{
	while (true) {
		struct bdi_writeback *wb = inode_to_wb(inode);

		/*
		 * inode_to_wb() association is protected by both
		 * @inode->i_lock and @wb->list_lock but list_lock nests
		 * outside i_lock.  Drop i_lock and verify that the
		 * association hasn't changed after acquiring list_lock.
		 */
		wb_get(wb);
		spin_unlock(&inode->i_lock);

It expects that inode->i_lock is taken before. But the problematic
commit takes it later. It might mess the lock and cause a deadlock.

Jack?


> I tried to do some investigating, it seems that the kernel is stuck at
> printk.c::console_init() -> drivers/tty/vt/vt.c::con_init() ->
> printk.c::register_console() -> unregister_console() -> console_lock().
> This has been determined by adding pr_info statements.

So, you tried something like:

int unregister_console(struct console *console)
{
	struct task_struct *thd;
	struct console *con;
	int res;

	con_printk(KERN_INFO, console, "disabled\n");
[...]

+	pr_info("Stage 1\n");
	console_lock();
+	pr_info("Stage 2\n");

[...]

	console_unlock();
+	pr_info("Stage 3\n");
[...]
}

And "Stage 1" was the last message on the console ?

Does the system boot when you avoid "earlycon" parameter?


> I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the offending
> commit fiddles with locks, but no splat was produced that would explain the
> hang. I've also tried to boot a v5,19-rc2 kernel on my odroid-c4, the board
> is booting just fine, so I'm guessing it only affects of subset of arm64
> boards.

You might try to switch the order of console_init() and lockdep_init()
in start_kernel() in init/main.c

Best Regards,
Petr
