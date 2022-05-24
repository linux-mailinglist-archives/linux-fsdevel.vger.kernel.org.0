Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03005322CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 08:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiEXGCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 02:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiEXGC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 02:02:29 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7348262114
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 23:02:23 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 24 May 2022 15:02:21 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 24 May 2022 15:02:21 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Tue, 24 May 2022 15:00:29 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jack@suse.com,
        jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        djwong@kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com
Subject: Re: [PATCH RFC v6 07/21] dept: Apply Dept to seqlock
Message-ID: <20220524060029.GA1014@X58A-UD3R>
References: <1651652269-15342-8-git-send-email-byungchul.park@lge.com>
 <Yoh3zzMPkCo2OP39@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoh3zzMPkCo2OP39@hyeyoo>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2022 at 02:25:35PM +0900, Hyeonggon Yoo wrote:
> Hello I got new report from dept, related to seqlock.
> I applied dept 1.20 series on v5.18-rc7.
> 
> Below is what DEPT reported.
> I think this is bogus because reader of p->alloc_lock cannot block
> its writer. Or please kindly tell me if I'm missing something ;)

Hi,

Yes, it should've been silent. I will fix it. Thank you!

Just FYI, a reader of seq-reader is a wait blocking the following event
e.i. spin_unlock(&host->lock) in here, not its writer. This report tells
the writer is blocked by __raw_spin_lock(&dentry->d_lock), not by its
reader. I've explained it just for your information. (:

Thank you!

	Byungchul


> 
> Thanks.
> 
> [    8.032674] ===================================================
> [    8.032676] DEPT: Circular dependency has been detected.
> [    8.032677] 5.18.0-rc7-dept+ #10 Tainted: G            E
> [    8.032677] ---------------------------------------------------
> [    8.032678] summary
> [    8.032678] ---------------------------------------------------
> [    8.032679] *** DEADLOCK ***
> 
> [    8.032679] context A
> [    8.032679]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> [    8.032681]     [W] __seqprop_spinlock_wait(&p->alloc_lock:0)
> [    8.032681]     [E] spin_unlock(&host->lock:0)
> 
> [    8.032682] context B
> [    8.032682]     [S] __raw_spin_lock(&dentry->d_lock:0)
> [    8.032683]     [W] __raw_spin_lock(&host->lock:0)
> [    8.032684]     [E] spin_unlock(&dentry->d_lock:0)
> 
> [    8.032684] context C
> [    8.032685]     [S] __raw_spin_lock(&p->alloc_lock:0)
> [    8.032685]     [W] __raw_spin_lock(&dentry->d_lock:0)
> [    8.032685]     [E] spin_unlock(&p->alloc_lock:0)
> 
> [    8.032686] [S]: start of the event context
> [    8.032686] [W]: the wait blocked
> [    8.032687] [E]: the event not reachable
> [    8.032687] ---------------------------------------------------
> [    8.032687] context A's detail
> [    8.032688] ---------------------------------------------------
> [    8.032688] context A
> [    8.032688]     [S] __raw_spin_lock_irqsave(&host->lock:0)
> [    8.032689]     [W] __seqprop_spinlock_wait(&p->alloc_lock:0)
> [    8.032689]     [E] spin_unlock(&host->lock:0)
> 
> [    8.032690] [S] __raw_spin_lock_irqsave(&host->lock:0):
> [    8.032690] ata_scsi_queuecmd (drivers/ata/libata-scsi.c:2734 drivers/ata/libata-scsi.c:4017) 
> [    8.032694] stacktrace:
> [    8.032694] ata_scsi_queuecmd (drivers/ata/libata-scsi.c:2734 drivers/ata/libata-scsi.c:4017) 
> [    8.032696] scsi_queue_rq (drivers/scsi/scsi_lib.c:1517 drivers/scsi/scsi_lib.c:1745) 
> [    8.032697] blk_mq_dispatch_rq_list (block/blk-mq.c:1858) 
> [    8.032700] blk_mq_do_dispatch_sched (block/blk-mq-sched.c:173 block/blk-mq-sched.c:187) 
> [    8.032701] __blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:313) 
> [    8.032702] blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:339) 
> [    8.032703] __blk_mq_run_hw_queue (./include/linux/rcupdate.h:723 block/blk-mq.c:1974) 
> [    8.032704] __blk_mq_delay_run_hw_queue (block/blk-mq.c:2052) 
> [    8.032705] blk_mq_run_hw_queue (block/blk-mq.c:2103) 
> [    8.032706] blk_mq_sched_insert_requests (./include/linux/rcupdate.h:692 ./include/linux/percpu-refcount.h:330 ./include/linux/percpu-refcount.h:351 block/blk-mq-sched.c:495) 
> [    8.032707] blk_mq_flush_plug_list (block/blk-mq.c:2640) 
> [    8.032708] __blk_flush_plug (block/blk-core.c:1247) 
> [    8.032709] blk_finish_plug (block/blk-core.c:1265 block/blk-core.c:1261) 
> [    8.032710] read_pages (mm/readahead.c:181) 
> [    8.032712] page_cache_ra_unbounded (./include/linux/fs.h:815 mm/readahead.c:262) 
> [    8.032713] page_cache_ra_order (mm/readahead.c:547) 
> 
> [    8.032714] [W] __seqprop_spinlock_wait(&p->alloc_lock:0):
> [    8.032714] __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032717] stacktrace:
> [    8.032717] dept_wait (./arch/x86/include/asm/current.h:15 kernel/dependency/dept.c:227 kernel/dependency/dept.c:1013 kernel/dependency/dept.c:1057 kernel/dependency/dept.c:2216) 
> [    8.032719] ___slab_alloc (./include/linux/seqlock.h:326 ./include/linux/cpuset.h:151 mm/slub.c:2223 mm/slub.c:2266 mm/slub.c:3000) 
> [    8.032720] __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032721] kmem_cache_alloc (mm/slub.c:3183 mm/slub.c:3225 mm/slub.c:3232 mm/slub.c:3242) 
> [    8.032722] alloc_iova (./include/linux/slab.h:704 drivers/iommu/iova.c:240 drivers/iommu/iova.c:316) 
> [    8.032724] alloc_iova_fast (drivers/iommu/iova.c:455) 
> [    8.032725] iommu_dma_alloc_iova (drivers/iommu/dma-iommu.c:628) 
> [    8.032726] iommu_dma_map_sg (drivers/iommu/dma-iommu.c:1201) 
> [    8.032727] __dma_map_sg_attrs (kernel/dma/mapping.c:195) 
> [    8.032729] dma_map_sg_attrs (kernel/dma/mapping.c:232) 
> [    8.032730] ata_qc_issue (drivers/ata/libata-core.c:4530 drivers/ata/libata-core.c:4876) 
> [    8.032731] __ata_scsi_queuecmd (drivers/ata/libata-scsi.c:1710 drivers/ata/libata-scsi.c:3974) 
> [    8.032732] ata_scsi_queuecmd (drivers/ata/libata-scsi.c:4019) 
> [    8.032734] scsi_queue_rq (drivers/scsi/scsi_lib.c:1517 drivers/scsi/scsi_lib.c:1745) 
> [    8.032734] blk_mq_dispatch_rq_list (block/blk-mq.c:1858) 
> [    8.032735] blk_mq_do_dispatch_sched (block/blk-mq-sched.c:173 block/blk-mq-sched.c:187) 
> 
> [    8.032736] [E] spin_unlock(&host->lock:0):
> [    8.032737] (N/A)
> [    8.032737] ---------------------------------------------------
> [    8.032738] context B's detail
> [    8.032738] ---------------------------------------------------
> [    8.032738] context B
> [    8.032738]     [S] __raw_spin_lock(&dentry->d_lock:0)
> [    8.032739]     [W] __raw_spin_lock(&host->lock:0)
> [    8.032740]     [E] spin_unlock(&dentry->d_lock:0)
> 
> [    8.032740] [S] __raw_spin_lock(&dentry->d_lock:0):
> [    8.032741] lockref_get (./include/linux/spinlock.h:410 lib/lockref.c:54) 
> [    8.032743] stacktrace:
> [    8.032743] lockref_get (./include/linux/spinlock.h:410 lib/lockref.c:54) 
> [    8.032744] path_get (fs/namei.c:546) 
> [    8.032746] do_dentry_open (fs/open.c:778) 
> [    8.032747] vfs_open (fs/open.c:959) 
> [    8.032748] path_openat (fs/namei.c:3583 fs/namei.c:3602) 
> [    8.032749] do_filp_open (fs/namei.c:3636) 
> [    8.032750] do_sys_openat2 (fs/open.c:1213) 
> [    8.032751] __x64_sys_openat (fs/open.c:1240) 
> [    8.032752] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [    8.032754] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> 
> [    8.032756] [W] __raw_spin_lock(&host->lock:0):
> [    8.032756] ahci_single_level_irq_intr (drivers/ata/libahci.c:1970) libahci
> [    8.032759] stacktrace:
> [    8.032760] ahci_single_level_irq_intr (drivers/ata/libahci.c:1970) libahci
> [    8.032761] __handle_irq_event_percpu (kernel/irq/handle.c:158) 
> [    8.032763] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210) 
> [    8.032763] handle_edge_irq (kernel/irq/chip.c:819) 
> [    8.032764] __common_interrupt (./include/asm-generic/irq_regs.h:28 (discriminator 22) arch/x86/kernel/irq.c:263 (discriminator 22)) 
> [    8.032766] common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
> [    8.032768] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636) 
> [    8.032769] lock_release (kernel/locking/lockdep.c:5665) 
> [    8.032771] _raw_spin_unlock (./include/linux/spinlock_api_smp.h:141 kernel/locking/spinlock.c:186) 
> [    8.032772] lockref_get (lib/lockref.c:55) 
> [    8.032772] path_get (fs/namei.c:546) 
> [    8.032774] do_dentry_open (fs/open.c:778) 
> [    8.032774] vfs_open (fs/open.c:959) 
> [    8.032775] path_openat (fs/namei.c:3583 fs/namei.c:3602) 
> [    8.032776] do_filp_open (fs/namei.c:3636) 
> [    8.032777] do_sys_openat2 (fs/open.c:1213) 
> 
> [    8.032778] [E] spin_unlock(&dentry->d_lock:0):
> [    8.032778] (N/A)
> [    8.032779] ---------------------------------------------------
> [    8.032779] context C's detail
> [    8.032779] ---------------------------------------------------
> [    8.032780] context C
> [    8.032780]     [S] __raw_spin_lock(&p->alloc_lock:0)
> [    8.032780]     [W] __raw_spin_lock(&dentry->d_lock:0)
> [    8.032781]     [E] spin_unlock(&p->alloc_lock:0)
> 
> [    8.032781] [S] __raw_spin_lock(&p->alloc_lock:0):
> [    8.032782] proc_root_link (fs/proc/base.c:177 fs/proc/base.c:208) 
> [    8.032784] stacktrace:
> [    8.032784] proc_root_link (fs/proc/base.c:177 fs/proc/base.c:208) 
> [    8.032784] proc_pid_get_link.part.0 (fs/proc/base.c:1756) 
> [    8.032785] proc_pid_get_link (fs/proc/base.c:1762) 
> [    8.032786] step_into (fs/namei.c:1819 fs/namei.c:1876) 
> [    8.032787] walk_component (fs/namei.c:2027) 
> [    8.032788] path_lookupat (fs/namei.c:2475 fs/namei.c:2499) 
> [    8.032789] filename_lookup (fs/namei.c:2528) 
> [    8.032790] vfs_statx (fs/stat.c:229) 
> [    8.032791] vfs_fstatat (fs/stat.c:256) 
> [    8.032792] __do_sys_newfstatat (fs/stat.c:426) 
> [    8.032793] __x64_sys_newfstatat (fs/stat.c:419) 
> [    8.032793] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [    8.032794] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> 
> [    8.032796] [W] __raw_spin_lock(&dentry->d_lock:0):
> [    8.032796] lockref_get (./include/linux/spinlock.h:410 lib/lockref.c:54) 
> [    8.032797] stacktrace:
> [    8.032797] lockref_get (./include/linux/spinlock.h:410 lib/lockref.c:54) 
> [    8.032798] path_get (fs/namei.c:546) 
> [    8.032799] proc_root_link (./include/linux/spinlock.h:410 ./include/linux/fs_struct.h:32 fs/proc/base.c:178 fs/proc/base.c:208) 
> [    8.032800] proc_pid_get_link.part.0 (fs/proc/base.c:1756) 
> [    8.032801] proc_pid_get_link (fs/proc/base.c:1762) 
> [    8.032801] step_into (fs/namei.c:1819 fs/namei.c:1876) 
> [    8.032802] walk_component (fs/namei.c:2027) 
> [    8.032803] path_lookupat (fs/namei.c:2475 fs/namei.c:2499) 
> [    8.032805] filename_lookup (fs/namei.c:2528) 
> [    8.032805] vfs_statx (fs/stat.c:229) 
> [    8.032806] vfs_fstatat (fs/stat.c:256) 
> [    8.032807] __do_sys_newfstatat (fs/stat.c:426) 
> [    8.032808] __x64_sys_newfstatat (fs/stat.c:419) 
> [    8.032808] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [    8.032809] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> 
> [    8.032810] [E] spin_unlock(&p->alloc_lock:0):
> [    8.032811] (N/A)
> [    8.032811] ---------------------------------------------------
> [    8.032811] information that might be helpful
> [    8.032812] ---------------------------------------------------
> [    8.032812] CPU: 4 PID: 534 Comm: systemd-tmpfile Tainted: G            E     5.18.0-rc7-dept+ #10
> [    8.032814] Hardware name: ASUS System Product Name/TUF GAMING B550-PLUS (WI-FI), BIOS 1401 12/03/2020
> [    8.032814] Call Trace:
> [    8.032815]  <TASK>
> [    8.032816] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
> [    8.032819] dump_stack (lib/dump_stack.c:114) 
> [    8.032820] print_circle.cold (./arch/x86/include/asm/atomic.h:108 ./include/linux/atomic/atomic-instrumented.h:258 kernel/dependency/dept.c:143 kernel/dependency/dept.c:776) 
> [    8.032822] ? print_circle (kernel/dependency/dept.c:1107) 
> [    8.032824] cb_check_dl (kernel/dependency/dept.c:1133) 
> [    8.032825] bfs (kernel/dependency/dept.c:874) 
> [    8.032826] add_dep (kernel/dependency/dept.c:1457) 
> [    8.032828] add_wait (kernel/dependency/dept.c:1505) 
> [    8.032829] ? __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032831] __dept_wait (kernel/dependency/dept.c:2156 (discriminator 2)) 
> [    8.032832] ? __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032833] ? __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032834] dept_wait (./arch/x86/include/asm/current.h:15 kernel/dependency/dept.c:227 kernel/dependency/dept.c:1013 kernel/dependency/dept.c:1057 kernel/dependency/dept.c:2216) 
> [    8.032836] ___slab_alloc (./include/linux/seqlock.h:326 ./include/linux/cpuset.h:151 mm/slub.c:2223 mm/slub.c:2266 mm/slub.c:3000) 
> [    8.032837] ? alloc_iova (./include/linux/slab.h:704 drivers/iommu/iova.c:240 drivers/iommu/iova.c:316) 
> [    8.032839] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:27 (discriminator 1)) 
> [    8.032841] ? alloc_iova (./include/linux/slab.h:704 drivers/iommu/iova.c:240 drivers/iommu/iova.c:316) 
> [    8.032842] __slab_alloc.constprop.0 (mm/slub.c:3092) 
> [    8.032844] kmem_cache_alloc (mm/slub.c:3183 mm/slub.c:3225 mm/slub.c:3232 mm/slub.c:3242) 
> [    8.032845] ? alloc_iova (./include/linux/slab.h:704 drivers/iommu/iova.c:240 drivers/iommu/iova.c:316) 
> [    8.032846] alloc_iova (./include/linux/slab.h:704 drivers/iommu/iova.c:240 drivers/iommu/iova.c:316) 
> [    8.032847] ? dept_ecxt_exit (kernel/dependency/dept.c:2506 (discriminator 1)) 
> [    8.032849] alloc_iova_fast (drivers/iommu/iova.c:455) 
> [    8.032851] iommu_dma_alloc_iova (drivers/iommu/dma-iommu.c:628) 
> [    8.032852] iommu_dma_map_sg (drivers/iommu/dma-iommu.c:1201) 
> [    8.032854] ? ata_scsi_mode_select_xlat (drivers/ata/libata-scsi.c:1503) 
> [    8.032855] __dma_map_sg_attrs (kernel/dma/mapping.c:195) 
> [    8.032856] dma_map_sg_attrs (kernel/dma/mapping.c:232) 
> [    8.032858] ata_qc_issue (drivers/ata/libata-core.c:4530 drivers/ata/libata-core.c:4876) 
> [    8.032859] __ata_scsi_queuecmd (drivers/ata/libata-scsi.c:1710 drivers/ata/libata-scsi.c:3974) 
> [    8.032861] ata_scsi_queuecmd (drivers/ata/libata-scsi.c:4019) 
> [    8.032862] scsi_queue_rq (drivers/scsi/scsi_lib.c:1517 drivers/scsi/scsi_lib.c:1745) 
> [    8.032864] blk_mq_dispatch_rq_list (block/blk-mq.c:1858) 
> [    8.032866] ? sbitmap_get (lib/sbitmap.c:179 lib/sbitmap.c:206 lib/sbitmap.c:231) 
> [    8.032869] blk_mq_do_dispatch_sched (block/blk-mq-sched.c:173 block/blk-mq-sched.c:187) 
> [    8.032871] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [    8.032872] __blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:313) 
> [    8.032874] blk_mq_sched_dispatch_requests (block/blk-mq-sched.c:339) 
> [    8.032875] __blk_mq_run_hw_queue (./include/linux/rcupdate.h:723 block/blk-mq.c:1974) 
> [    8.032876] __blk_mq_delay_run_hw_queue (block/blk-mq.c:2052) 
> [    8.032877] blk_mq_run_hw_queue (block/blk-mq.c:2103) 
> [    8.032879] blk_mq_sched_insert_requests (./include/linux/rcupdate.h:692 ./include/linux/percpu-refcount.h:330 ./include/linux/percpu-refcount.h:351 block/blk-mq-sched.c:495) 
> [    8.032880] blk_mq_flush_plug_list (block/blk-mq.c:2640) 
> [    8.032882] __blk_flush_plug (block/blk-core.c:1247) 
> [    8.032883] ? lock_release (./arch/x86/include/asm/paravirt.h:704 (discriminator 1) ./arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/locking/lockdep.c:5664 (discriminator 1)) 
> [    8.032885] blk_finish_plug (block/blk-core.c:1265 block/blk-core.c:1261) 
> [    8.032886] read_pages (mm/readahead.c:181) 
> [    8.032888] page_cache_ra_unbounded (./include/linux/fs.h:815 mm/readahead.c:262) 
> [    8.032890] page_cache_ra_order (mm/readahead.c:547) 
> [    8.032892] ondemand_readahead (mm/readahead.c:669) 
> [    8.032893] page_cache_sync_ra (mm/readahead.c:696) 
> [    8.032894] filemap_get_pages (mm/filemap.c:2613) 
> [    8.032896] ? lock_is_held_type (./arch/x86/include/asm/paravirt.h:704 (discriminator 1) ./arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/locking/lockdep.c:5686 (discriminator 1)) 
> [    8.032898] filemap_read (mm/filemap.c:2698) 
> [    8.032900] ? lock_is_held_type (./arch/x86/include/asm/paravirt.h:704 (discriminator 1) ./arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/locking/lockdep.c:5686 (discriminator 1)) 
> [    8.032901] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [    8.032901] ? lock_is_held_type (./arch/x86/include/asm/paravirt.h:704 (discriminator 1) ./arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/locking/lockdep.c:5686 (discriminator 1)) 
> [    8.032903] ? sched_clock (arch/x86/kernel/tsc.c:254) 
> [    8.032904] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> [    8.032905] ? lock_release (./arch/x86/include/asm/paravirt.h:704 (discriminator 1) ./arch/x86/include/asm/irqflags.h:138 (discriminator 1) kernel/locking/lockdep.c:5664 (discriminator 1)) 
> [    8.032907] generic_file_read_iter (mm/filemap.c:2845) 
> [    8.032908] ? aa_file_perm (security/apparmor/file.c:644) 
> [    8.032910] ext4_file_read_iter (fs/ext4/file.c:133) 
> [    8.032912] new_sync_read (fs/read_write.c:402 (discriminator 1)) 
> [    8.032915] vfs_read (fs/read_write.c:482) 
> [    8.032916] ksys_read (fs/read_write.c:620) 
> [    8.032918] __x64_sys_read (fs/read_write.c:628) 
> [    8.032919] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> [    8.032920] ? do_syscall_64 (arch/x86/entry/common.c:89) 
> [    8.032921] ? syscall_exit_to_user_mode (kernel/entry/common.c:297) 
> [    8.032922] ? do_syscall_64 (arch/x86/entry/common.c:89) 
> [    8.032924] ? do_syscall_64 (arch/x86/entry/common.c:89) 
> [    8.032925] ? do_syscall_64 (./arch/x86/include/asm/jump_label.h:27 arch/x86/entry/common.c:77) 
> [    8.032926] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
> [    8.032927] RIP: 0033:0x7f66de513932
> [ 8.032928] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 3a b9 0c 00 e8 15 1a 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> All code
> ========
>    0:	c0 e9 b2             	shr    $0xb2,%cl
>    3:	fe                   	(bad)  
>    4:	ff                   	(bad)  
>    5:	ff 50 48             	call   *0x48(%rax)
>    8:	8d 3d 3a b9 0c 00    	lea    0xcb93a(%rip),%edi        # 0xcb948
>    e:	e8 15 1a 02 00       	call   0x21a28
>   13:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   18:	f3 0f 1e fa          	endbr64 
>   1c:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
>   23:	00 
>   24:	85 c0                	test   %eax,%eax
>   26:	75 10                	jne    0x38
>   28:	0f 05                	syscall 
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 56                	ja     0x88
>   32:	c3                   	ret    
>   33:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>   38:	48 83 ec 28          	sub    $0x28,%rsp
>   3c:	48                   	rex.W
>   3d:	89                   	.byte 0x89
>   3e:	54                   	push   %rsp
>   3f:	24                   	.byte 0x24
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 56                	ja     0x5e
>    8:	c3                   	ret    
>    9:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
>    e:	48 83 ec 28          	sub    $0x28,%rsp
>   12:	48                   	rex.W
>   13:	89                   	.byte 0x89
>   14:	54                   	push   %rsp
>   15:	24                   	.byte 0x24
> [    8.032929] RSP: 002b:00007ffcdce2cee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> [    8.032931] RAX: ffffffffffffffda RBX: 000056271b3552d0 RCX: 00007f66de513932
> [    8.032932] RDX: 0000000000001000 RSI: 000056271b357f00 RDI: 0000000000000004
> [    8.032932] RBP: 00007f66de616600 R08: 0000000000000004 R09: 000056271b358f00
> [    8.032933] R10: 000056271b357ef0 R11: 0000000000000246 R12: 00007f66de62aec0
> [    8.032934] R13: 0000000000000d68 R14: 00007f66de615a00 R15: 0000000000000d68
> [    8.032936]  </TASK>
> 
> -- 
> Thanks,
> Hyeonggon
