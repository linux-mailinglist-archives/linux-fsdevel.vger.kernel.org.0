Return-Path: <linux-fsdevel+bounces-73147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EBD0E221
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 08:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45C9B3009944
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EC2FD69B;
	Sun, 11 Jan 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UWHOjGnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EF2FD1CA
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768118078; cv=none; b=t+GqS/Y7gv/qorYa9YMpcSekVwk3POhhz23da97zVehzW5y7GOKkOfNVp0EJauYy/ouWJPBpmHt4dlTa+jyzZivL7tmlvOoioZp96rPQ9RW6/YzbVRJ2GwEcpYXs1JSsg2syMn7E4uG2uOVvWdt32rKZSy9/pJ8gJcWX2mAUn0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768118078; c=relaxed/simple;
	bh=u1NJ6Am6ctVzYy6h2acDjPz9QxsqClifr2m3yqu6pnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD7uN08s7FVy6vTpCjm6TKit76IkAysoKUUJHfl/EaRakAC6CqSnV9b0jB/GzEtyk+EAunfP9chUfBf+cDcLmF9mrYsU8JZYa/GmDiBOYEoZTJkxSOBuTAp5L9ey3jhEedUg+i5HIDF+cwfXZKS3QqYqwKu7ChpCLVHivofYiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UWHOjGnz; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768118071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HY8KjjUcgtvFOC7nSoYoDmOoEPZ2/d0O52LO5N+zOQA=;
	b=UWHOjGnzGVPe8SVOhJn+TQIpRf+kUUkzWMBlwML/k/nPctKVxDWRAByA+67PGOUI3kOHVMHJNVyoeEtzaH9ZW0u8uWbvYeewEsIo5rcBSBmA0V2YiGC07QhIF6XeDkzA4ooHjUpA1HonAeHb50BPkAlq/IZmkDDYq6K2FdLFB5U=
Received: from 30.180.152.220(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Wwlo2w9_1768117751 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 11 Jan 2026 15:49:11 +0800
Message-ID: <58f23bd0-a522-4249-9b3a-fdeda4c5393c@linux.alibaba.com>
Date: Sun, 11 Jan 2026 15:49:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lockdep issues due to fi->lock in fuse_writepage_finish()
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Horst Birthelmer
 <hbirthelmer@ddn.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/26 10:05 PM, Bernd Schubert wrote:
> Hi Joanne,
> 
> I run in lockdep issues on testing 6.19. And I think it is due to
> holding fi->lock in fuse_writepage_end() until fuse_writepage_finish() is
> complete
> 
> Proposed patch is
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 01bc894e9c2b..b2cd270c75d8 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2000,8 +2000,8 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
>         spin_lock(&fi->lock);
>         fi->writectr--;
> -       fuse_writepage_finish(wpa);
>         spin_unlock(&fi->lock);
> +       fuse_writepage_finish(wpa);
>         fuse_writepage_free(wpa);
>  }
>  
> 
> But then there is this comment in fuse_writepage_finish
> 
> 		/*
> 		 * Benchmarks showed that ending writeback within the
> 		 * scope of the fi->lock alleviates xarray lock
> 		 * contention and noticeably improves performance.
> 		 */
> 

Sorry I have not dived into the detailed lockdep log yet, but FYI this
optimization mentioned by the comment here is mainly for the writeback
before large folio is implemented, where every e.g. 4K page will contend
for xa->xa_lock.


> 
> 
> 
> squeeze1 login: [  197.732702] systemd-journald[198]: Failed to set ACL on /var/log/journal/3bea975da8fca024602b8e81000009fb/user-1003.journal, ignoring: Operation not supported
> [  816.584395] fuse: loading out-of-tree module taints kernel.
> [  816.596824] fuse: init (API version 7.45)
> [  817.943859] fuse: init (API version 7.45)
> [  839.715388] systemd-journald[198]: Failed to set ACL on /var/log/journal/3bea975da8fca024602b8e81000009fb/user-1007.journal, ignoring: Operation not supported
> [  863.321964] NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030
> [  864.186114] kmemleak: Automatic memory scanning thread ended
> [  869.079062] run fstests generic/074 at 2026-01-10 14:01:08
> [  872.464683] 
> [  872.465022] =====================================================
> [  872.465706] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> [  872.466414] 6.19.0-rc1+ #15 Tainted: G           O       
> [  872.467052] -----------------------------------------------------
> [  872.467742] fuse-ring-0/1141 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [  872.468488] ffffffff83666740 (&p->sequence){+.-.}-{0:0}, at: __fprop_add_percpu_max+0xa2/0x120
> [  872.469433] 
> [  872.469433] and this task is already holding:
> [  872.470208] ffff88812b1ca090 (&xa->xa_lock#4){-.-.}-{3:3}, at: __folio_end_writeback+0x64/0x250
> [  872.471281] which would create a new lock dependency:
> [  872.471911]  (&xa->xa_lock#4){-.-.}-{3:3} -> (&p->sequence){+.-.}-{0:0}
> [  872.472717] 
> [  872.472717] but this new dependency connects a HARDIRQ-irq-safe lock:
> [  872.473677]  (&xa->xa_lock#4){-.-.}-{3:3}
> [  872.473680] 
> [  872.473680] ... which became HARDIRQ-irq-safe at:
> [  872.474996]   lock_acquire+0xe1/0x260
> [  872.475502]   _raw_spin_lock_irqsave+0x69/0xc0
> [  872.476072]   __folio_end_writeback+0x64/0x250
> [  872.476637]   folio_end_writeback_no_dropbehind+0x55/0x120
> [  872.477304]   folio_end_writeback+0x2d/0x80
> [  872.477863]   end_bio_bh_io_sync+0x24/0x40
> [  872.478384]   blk_update_request+0x152/0x3b0
> [  872.478942]   blk_mq_end_request+0x18/0x30
> [  872.479466]   virtblk_done+0x98/0x110 [virtio_blk]
> [  872.480067]   vring_interrupt+0xb4/0x150
> [  872.480611]   __handle_irq_event_percpu+0xce/0x2e0
> [  872.481205]   handle_irq_event+0x35/0x70
> [  872.481717]   handle_edge_irq+0x9b/0x190
> [  872.482226]   __common_interrupt+0x8d/0xe0
> [  872.482760]   common_interrupt+0x7c/0x90
> [  872.483258]   asm_common_interrupt+0x26/0x40
> [  872.483826]   pv_native_safe_halt+0x13/0x20
> [  872.484359]   default_idle+0x9/0x10
> [  872.486483]   default_idle_call+0x71/0xa0
> [  872.487025]   do_idle+0xcb/0x230
> [  872.487489]   cpu_startup_entry+0x2a/0x30
> [  872.488020]   rest_init+0x1eb/0x1f0
> [  872.488516]   start_kernel+0x3a7/0x400
> [  872.489072]   x86_64_start_reservations+0x24/0x30
> [  872.489662]   x86_64_start_kernel+0x142/0x150
> [  872.490210]   common_startup_64+0x13e/0x147
> [  872.490744] 
> [  872.490744] to a HARDIRQ-irq-unsafe lock:
> [  872.491452]  (&p->sequence){+.-.}-{0:0}
> [  872.491455] 
> [  872.491455] ... which became HARDIRQ-irq-unsafe at:
> [  872.492770] ...
> [  872.492772]   lock_acquire+0xe1/0x260
> [  872.493575]   fprop_new_period+0xac/0x110
> [  872.494083]   writeout_period+0x3e/0x90
> [  872.494706]   call_timer_fn+0xca/0x220
> [  872.495217]   run_timer_softirq+0x322/0x480
> [  872.495758]   handle_softirqs+0x16e/0x430
> [  872.496279]   __irq_exit_rcu+0x58/0xc0
> [  872.496771]   irq_exit_rcu+0xe/0x20
> [  872.497235]   sysvec_apic_timer_interrupt+0x36/0x80
> [  872.497848]   asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  872.498491] 
> [  872.498491] other info that might help us debug this:
> [  872.498491] 
> [  872.499480]  Possible interrupt unsafe locking scenario:
> [  872.499480] 
> [  872.500326]        CPU0                    CPU1
> [  872.500906]        ----                    ----
> [  872.501464]   lock(&p->sequence);
> [  872.501923]                                local_irq_disable();
> [  872.502615]                                lock(&xa->xa_lock#4);
> [  872.503327]                                lock(&p->sequence);
> [  872.504116]   <Interrupt>
> [  872.504513]     lock(&xa->xa_lock#4);
> [  872.505000] 
> [  872.505000]  *** DEADLOCK ***
> [  872.505000] 
> [  872.505815] 3 locks held by fuse-ring-0/1141:
> [  872.506375]  #0: ffff8881270710b0 (&ctx->uring_lock){+.+.}-{4:4}, at: __x64_sys_io_uring_enter+0x127/0xd40
> [  872.507500]  #1: ffff88812b1ca4d0 (&fi->lock){+.+.}-{3:3}, at: fuse_writepage_end+0x58/0x120 [fuse]
> [  872.508599]  #2: ffff88812b1ca090 (&xa->xa_lock#4){-.-.}-{3:3}, at: __folio_end_writeback+0x64/0x250
> [  872.509699] 
> [  872.509699] the dependencies between HARDIRQ-irq-safe lock and the holding lock:
> [  872.510810] -> (&xa->xa_lock#4){-.-.}-{3:3} {
> [  872.511375]    IN-HARDIRQ-W at:
> [  872.511809]                     lock_acquire+0xe1/0x260
> [  872.512436]                     _raw_spin_lock_irqsave+0x69/0xc0
> [  872.513170]                     __folio_end_writeback+0x64/0x250
> [  872.513912]                     folio_end_writeback_no_dropbehind+0x55/0x120
> [  872.514758]                     folio_end_writeback+0x2d/0x80
> [  872.515444]                     end_bio_bh_io_sync+0x24/0x40
> [  872.516888]                     blk_update_request+0x152/0x3b0
> [  872.517631]                     blk_mq_end_request+0x18/0x30
> [  872.518359]                     virtblk_done+0x98/0x110 [virtio_blk]
> [  872.519170]                     vring_interrupt+0xb4/0x150
> [  872.519872]                     __handle_irq_event_percpu+0xce/0x2e0
> [  872.520615]                     handle_irq_event+0x35/0x70
> [  872.521263]                     handle_edge_irq+0x9b/0x190
> [  872.521944]                     __common_interrupt+0x8d/0xe0
> [  872.522649]                     common_interrupt+0x7c/0x90
> [  872.523326]                     asm_common_interrupt+0x26/0x40
> [  872.524047]                     pv_native_safe_halt+0x13/0x20
> [  872.524757]                     default_idle+0x9/0x10
> [  872.525394]                     default_idle_call+0x71/0xa0
> [  872.526048]                     do_idle+0xcb/0x230
> [  872.526637]                     cpu_startup_entry+0x2a/0x30
> [  872.527317]                     rest_init+0x1eb/0x1f0
> [  872.527962]                     start_kernel+0x3a7/0x400
> [  872.528629]                     x86_64_start_reservations+0x24/0x30
> [  872.529373]                     x86_64_start_kernel+0x142/0x150
> [  872.530071]                     common_startup_64+0x13e/0x147
> [  872.530780]    IN-SOFTIRQ-W at:
> [  872.531236]                     lock_acquire+0xe1/0x260
> [  872.531869]                     _raw_spin_lock_irqsave+0x69/0xc0
> [  872.532595]                     __folio_end_writeback+0x64/0x250
> [  872.533296]                     folio_end_writeback_no_dropbehind+0x55/0x120
> [  872.534119]                     folio_end_writeback+0x2d/0x80
> [  872.534808]                     ext4_finish_bio+0x21c/0x400 [ext4]
> [  872.535583]                     ext4_end_bio+0xf8/0x170 [ext4]
> [  872.536303]                     blk_update_request+0x152/0x3b0
> [  872.537005]                     blk_mq_end_request+0x18/0x30
> [  872.537699]                     virtblk_done+0x98/0x110 [virtio_blk]
> [  872.538432]                     vring_interrupt+0xb4/0x150
> [  872.539107]                     __handle_irq_event_percpu+0xce/0x2e0
> [  872.539881]                     handle_irq_event+0x35/0x70
> [  872.540552]                     handle_edge_irq+0x9b/0x190
> [  872.541227]                     __common_interrupt+0x8d/0xe0
> [  872.541927]                     common_interrupt+0x7c/0x90
> [  872.542604]                     asm_common_interrupt+0x26/0x40
> [  872.543308]                     _raw_spin_unlock_irqrestore+0x3d/0x50
> [  872.544068]                     __slab_free+0x237/0x250
> [  872.544742]                     kmem_cache_free+0x3a7/0x4e0
> [  872.545434]                     rcu_core+0x388/0x7e0
> [  872.546753]                     handle_softirqs+0x16e/0x430
> [  872.547464]                     run_ksoftirqd+0x49/0x80
> [  872.548148]                     smpboot_thread_fn+0x124/0x1e0
> [  872.548885]                     kthread+0x216/0x250
> [  872.549512]                     ret_from_fork+0x1b8/0x2c0
> [  872.550172]                     ret_from_fork_asm+0x11/0x20
> [  872.550859]    INITIAL USE at:
> [  872.551277]                    lock_acquire+0xe1/0x260
> [  872.551903]                    _raw_spin_lock_irq+0x65/0xb0
> [  872.552567]                    __filemap_add_folio+0x23d/0x580
> [  872.553276]                    filemap_add_folio+0xf2/0x1d0
> [  872.553952]                    __filemap_get_folio_mpol+0x1c1/0x340
> [  872.554704]                    simple_write_begin+0x36/0x170
> [  872.555396]                    page_symlink+0xc2/0x150
> [  872.556046]                    ramfs_symlink+0xa8/0xf0
> [  872.556675]                    vfs_symlink+0xbe/0x120
> [  872.557303]                    init_symlink+0x63/0xa0
> [  872.557920]                    do_symlink+0x82/0x120
> [  872.558524]                    flush_buffer+0x43/0xb0
> [  872.559163]                    __unzstd+0x301/0x380
> [  872.559785]                    unpack_to_rootfs+0x16e/0x280
> [  872.560442]                    do_populate_rootfs+0xc0/0x140
> [  872.561118]                    async_run_entry_fn+0x2b/0x150
> [  872.561803]                    process_scheduled_works+0x29a/0x5e0
> [  872.562515]                    worker_thread+0x227/0x330
> [  872.563175]                    kthread+0x216/0x250
> [  872.563774]                    ret_from_fork+0x1b8/0x2c0
> [  872.564427]                    ret_from_fork_asm+0x11/0x20
> [  872.565085]  }
> [  872.565396]  ... key      at: [<ffffffff84579778>] xa_init_flags.__key+0x0/0x10
> [  872.566306] 
> [  872.566306] the dependencies between the lock to be acquired
> [  872.566308]  and HARDIRQ-irq-unsafe lock:
> [  872.567732] -> (&p->sequence){+.-.}-{0:0} {
> [  872.568261]    HARDIRQ-ON-W at:
> [  872.568699]                     lock_acquire+0xe1/0x260
> [  872.569333]                     fprop_new_period+0xac/0x110
> [  872.570056]                     writeout_period+0x3e/0x90
> [  872.570727]                     call_timer_fn+0xca/0x220
> [  872.571363]                     run_timer_softirq+0x322/0x480
> [  872.572068]                     handle_softirqs+0x16e/0x430
> [  872.572754]                     __irq_exit_rcu+0x58/0xc0
> [  872.573391]                     irq_exit_rcu+0xe/0x20
> [  872.574005]                     sysvec_apic_timer_interrupt+0x36/0x80
> [  872.574761]                     asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  872.575557]    IN-SOFTIRQ-W at:
> [  872.576640]                     lock_acquire+0xe1/0x260
> [  872.577299]                     fprop_new_period+0xac/0x110
> [  872.578020]                     writeout_period+0x3e/0x90
> [  872.578691]                     call_timer_fn+0xca/0x220
> [  872.582698]                     run_timer_softirq+0x322/0x480
> [  872.583399]                     handle_softirqs+0x16e/0x430
> [  872.584149]                     __irq_exit_rcu+0x58/0xc0
> [  872.584790]                     irq_exit_rcu+0xe/0x20
> [  872.585409]                     sysvec_apic_timer_interrupt+0x36/0x80
> [  872.586195]                     asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  872.587018]    INITIAL USE at:
> [  872.587467]                    lock_acquire+0xe1/0x260
> [  872.588127]                    fprop_new_period+0xac/0x110
> [  872.588786]                    writeout_period+0x3e/0x90
> [  872.589424]                    call_timer_fn+0xca/0x220
> [  872.590085]                    run_timer_softirq+0x322/0x480
> [  872.590786]                    handle_softirqs+0x16e/0x430
> [  872.591462]                    __irq_exit_rcu+0x58/0xc0
> [  872.592109]                    irq_exit_rcu+0xe/0x20
> [  872.592715]                    sysvec_apic_timer_interrupt+0x36/0x80
> [  872.593464]                    asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  872.594271]    INITIAL READ USE at:
> [  872.594750]                         lock_acquire+0xe1/0x260
> [  872.595414]                         fprop_fraction_percpu+0xba/0x140
> [  872.596177]                         __wb_calc_thresh+0x42/0x1a0
> [  872.596897]                         domain_over_bg_thresh+0x110/0x180
> [  872.597686]                         wb_over_bg_thresh+0x150/0x190
> [  872.598402]                         wb_workfn+0x37e/0x550
> [  872.599084]                         process_scheduled_works+0x29a/0x5e0
> [  872.599886]                         worker_thread+0x227/0x330
> [  872.600569]                         kthread+0x216/0x250
> [  872.601193]                         ret_from_fork+0x1b8/0x2c0
> [  872.601898]                         ret_from_fork_asm+0x11/0x20
> [  872.602618]  }
> [  872.602931]  ... key      at: [<ffffffff8472dbe0>] fprop_global_init.__key.1+0x0/0x10
> [  872.603879]  ... acquired at:
> [  872.604310]    fprop_fraction_percpu+0x84/0x140
> [  872.604884]    __fprop_add_percpu_max+0xa2/0x120
> [  872.605449]    __wb_writeout_add+0x48/0xf0
> [  872.606612]    __folio_end_writeback+0x11b/0x250
> [  872.607208]    folio_end_writeback_no_dropbehind+0x55/0x120
> [  872.607948]    folio_end_writeback+0x2d/0x80
> [  872.608482]    fuse_writepage_end+0x93/0x120 [fuse]
> [  872.609088]    fuse_request_end+0x276/0x310 [fuse]
> [  872.609683]    fuse_uring_commit_fetch+0x1b9/0x3f0 [fuse]
> [  872.610352]    fuse_uring_cmd+0x183/0x220 [fuse]
> [  872.610956]    io_uring_cmd+0x9a/0x180
> [  872.611452]    io_issue_sqe+0x8d/0x4f0
> [  872.611947]    io_submit_sqes+0x2f4/0x840
> [  872.612456]    __x64_sys_io_uring_enter+0x132/0xd40
> [  872.613065]    do_syscall_64+0x80/0xfc0
> [  872.613567]    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  872.614189] 
> [  872.614462] 
> [  872.614462] stack backtrace:
> [  872.615063] CPU: 0 UID: 0 PID: 1141 Comm: fuse-ring-0 Tainted: G           O        6.19.0-rc1+ #15 NONE 
> [  872.615067] Tainted: [O]=OOT_MODULE
> [  872.615068] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  872.615069] Call Trace:
> [  872.615071]  <TASK>
> [  872.615072]  dump_stack_lvl+0x82/0xc0
> [  872.615076]  __lock_acquire+0x3138/0x33f0
> [  872.615080]  ? __lock_acquire+0x15b4/0x33f0
> [  872.615083]  ? save_trace+0x4d/0x340
> [  872.615086]  lock_acquire+0xe1/0x260
> [  872.615088]  ? __fprop_add_percpu_max+0xa2/0x120
> [  872.615091]  ? lock_is_held_type+0x97/0x140
> [  872.615095]  ? __fprop_add_percpu_max+0xa2/0x120
> [  872.615097]  fprop_fraction_percpu+0x84/0x140
> [  872.615099]  ? __fprop_add_percpu_max+0xa2/0x120
> [  872.615102]  __fprop_add_percpu_max+0xa2/0x120
> [  872.615104]  ? __xa_clear_mark+0x69/0x90
> [  872.615106]  __wb_writeout_add+0x48/0xf0
> [  872.615108]  __folio_end_writeback+0x11b/0x250
> [  872.615110]  folio_end_writeback_no_dropbehind+0x55/0x120
> [  872.615113]  ? fuse_writepage_end+0x58/0x120 [fuse]
> [  872.615120]  folio_end_writeback+0x2d/0x80
> [  872.615122]  fuse_writepage_end+0x93/0x120 [fuse]
> [  872.615129]  fuse_request_end+0x276/0x310 [fuse]
> [  872.615136]  fuse_uring_commit_fetch+0x1b9/0x3f0 [fuse]
> [  872.615144]  fuse_uring_cmd+0x183/0x220 [fuse]
> [  872.615151]  io_uring_cmd+0x9a/0x180
> [  872.615153]  io_issue_sqe+0x8d/0x4f0
> [  872.615156]  io_submit_sqes+0x2f4/0x840
> [  872.615159]  __x64_sys_io_uring_enter+0x132/0xd40
> [  872.615163]  ? kvm_sched_clock_read+0x11/0x20
> [  872.615165]  ? local_clock_noinstr+0xc/0xb0
> [  872.615168]  ? local_clock+0x15/0x20
> [  872.615174]  ? lock_release+0x131/0x4b0
> [  872.615176]  ? exc_page_fault+0xcd/0x1f0
> [  872.615180]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  872.615182]  do_syscall_64+0x80/0xfc0
> [  872.615184]  ? exc_page_fault+0xed/0x1f0
> [  872.615187]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [  872.615192] RIP: 0033:0x7f1b65f2eb95
> [  872.615194] Code: 00 00 00 44 89 d0 41 b9 08 00 00 00 83 c8 10 f6 87 d0 00 00 00 01 8b bf cc 00 00 00 44 0f 45 d0 45 31 c0 b8 aa 01 00 00 0f 05 <c3> 66 2e 0f 1f 84 00 00 00 00 00 41 83 e2 02 74 c2 f0 48 83 0c 24
> [  872.615196] RSP: 002b:00007f1b60ef4428 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
> [  872.615199] RAX: ffffffffffffffda RBX: 000000000000a1a4 RCX: 00007f1b65f2eb95
> [  872.615200] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000006
> [  872.615201] RBP: 00007f1b60ef4490 R08: 0000000000000000 R09: 0000000000000008
> [  872.615202] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [  872.615203] R13: 00007f1b5fd964e0 R14: 00007f1b60ef4640 R15: 00007f1b60ef4560
> [  872.615206]  </TASK>
> 
> 
> Thanks,
> Bernd

-- 
Thanks,
Jingbo


