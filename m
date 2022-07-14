Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648C57509C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbiGNOST (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239104AbiGNOSS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:18:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BE643CB;
        Thu, 14 Jul 2022 07:18:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A4881F926;
        Thu, 14 Jul 2022 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657808294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ahtBmMFVqn+iStyYp+fe1qrCLV3kGTdnrSb81jBiVNM=;
        b=Vu2ZFAOu2QVTU7sNzBQDz+5lBTeTKy3a2qucZ1eW/1gpiisz6U+Ly/5WUtDUuGBWwqTi+p
        bt4naTaMeg1PCOmXG0KbvAkJ9GKk6u0BrunBK/mjXlSnE4VRmeSCerDS6k07E77R4JOqS5
        HaxPYzcE0DWHbzaBqhZwWfhV2b6Jbto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657808294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ahtBmMFVqn+iStyYp+fe1qrCLV3kGTdnrSb81jBiVNM=;
        b=An7OdbqbbK79nbXw8d2fs37p9OVp53SCkstx7OQucB7A43pwzAFqJUAWjC7G5IHNlnYiLV
        ZW3IR/TGBqIHq1Ag==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 672E92C141;
        Thu, 14 Jul 2022 14:18:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D36FA0659; Thu, 14 Jul 2022 16:18:13 +0200 (CEST)
Date:   Thu, 14 Jul 2022 16:18:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     linux-mm@kvack.org
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] possible deadlock in start_this_handle (3)
Message-ID: <20220714141813.yi5p4o2tiyvkao6b@quack3>
References: <000000000000471c2905e3c2c2c2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000471c2905e3c2c2c2@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

so this lockdep report looks real but is more related to OOM handling than
to ext4 as such. The immediate problem I can see is that
mem_cgroup_print_oom_meminfo() which is called under oom_lock calls
memory_stat_format() which does GFP_KERNEL allocations to allocate buffers
for dumping of MM statistics. This creates oom_lock -> fs reclaim
dependency and because OOM can be hit (and thus oom_lock acquired) in
practically any allocation (regardless of GFP_NOFS) this has a potential of
creating real deadlock cycles.

So should mem_cgroup_print_oom_meminfo() be using
memalloc_nofs_save/restore() to avoid such deadlocks? Or perhaps someone
sees another solution? Generally allocating memory to report OOM looks a
bit dangerous to me ;).

								Honza

On Thu 14-07-22 05:08:26, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5a29232d870d Merge tag 'for-5.19-rc6-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16619ce8080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=525bc0635a2b942a
> dashboard link: https://syzkaller.appspot.com/bug?extid=2d2aeadc6ce1e1f11d45
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2d2aeadc6ce1e1f11d45@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.19.0-rc6-syzkaller-00026-g5a29232d870d #0 Not tainted
> ------------------------------------------------------
> khugepaged/48 is trying to acquire lock:
> ffff888044598990 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xfb4/0x14a0 fs/jbd2/transaction.c:461
> 
> but task is already holding lock:
> ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4638 [inline]
> ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
> ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x9e1/0x2160 mm/page_alloc.c:5066
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:4589 [inline]
>        fs_reclaim_acquire+0x115/0x160 mm/page_alloc.c:4603
>        might_alloc include/linux/sched/mm.h:271 [inline]
>        slab_pre_alloc_hook mm/slab.h:723 [inline]
>        slab_alloc_node mm/slub.c:3157 [inline]
>        slab_alloc mm/slub.c:3251 [inline]
>        kmem_cache_alloc_trace+0x40/0x3f0 mm/slub.c:3282
>        kmalloc include/linux/slab.h:600 [inline]
>        memory_stat_format+0x95/0xae0 mm/memcontrol.c:1468
>        mem_cgroup_print_oom_meminfo.cold+0x50/0x7e mm/memcontrol.c:1594
>        dump_header+0x13f/0x7f9 mm/oom_kill.c:462
>        oom_kill_process.cold+0x10/0x15 mm/oom_kill.c:1037
>        out_of_memory+0x358/0x14b0 mm/oom_kill.c:1175
>        mem_cgroup_out_of_memory+0x206/0x270 mm/memcontrol.c:1650
>        memory_max_write+0x25c/0x3b0 mm/memcontrol.c:6299
>        cgroup_file_write+0x1de/0x770 kernel/cgroup/cgroup.c:3882
>        kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:290
>        call_write_iter include/linux/fs.h:2058 [inline]
>        new_sync_write+0x38a/0x560 fs/read_write.c:504
>        vfs_write+0x7c0/0xac0 fs/read_write.c:591
>        ksys_write+0x127/0x250 fs/read_write.c:644
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x53/0x62
> 
> -> #1 (oom_lock){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:603 [inline]
>        __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
>        mem_cgroup_out_of_memory+0x8d/0x270 mm/memcontrol.c:1640
>        mem_cgroup_oom mm/memcontrol.c:1880 [inline]
>        try_charge_memcg+0xef9/0x1380 mm/memcontrol.c:2670
>        obj_cgroup_charge_pages mm/memcontrol.c:2999 [inline]
>        obj_cgroup_charge+0x2ab/0x5e0 mm/memcontrol.c:3289
>        memcg_slab_pre_alloc_hook mm/slab.h:505 [inline]
>        slab_pre_alloc_hook mm/slab.h:728 [inline]
>        slab_alloc_node mm/slub.c:3157 [inline]
>        slab_alloc mm/slub.c:3251 [inline]
>        __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
>        kmem_cache_alloc+0x92/0x3b0 mm/slub.c:3268
>        kmem_cache_zalloc include/linux/slab.h:723 [inline]
>        alloc_buffer_head+0x20/0x140 fs/buffer.c:3294
>        alloc_page_buffers+0x285/0x7a0 fs/buffer.c:829
>        grow_dev_page fs/buffer.c:965 [inline]
>        grow_buffers fs/buffer.c:1011 [inline]
>        __getblk_slow+0x525/0x1080 fs/buffer.c:1038
>        __getblk_gfp+0x6e/0x80 fs/buffer.c:1333
>        sb_getblk include/linux/buffer_head.h:326 [inline]
>        ext4_getblk+0x20d/0x7c0 fs/ext4/inode.c:866
>        ext4_bread+0x2a/0x1c0 fs/ext4/inode.c:912
>        ext4_append+0x177/0x3a0 fs/ext4/namei.c:67
>        ext4_init_new_dir+0x25e/0x4d0 fs/ext4/namei.c:2920
>        ext4_mkdir+0x3cf/0xb20 fs/ext4/namei.c:2966
>        vfs_mkdir+0x1c3/0x3b0 fs/namei.c:3975
>        do_mkdirat+0x285/0x300 fs/namei.c:4001
>        __do_sys_mkdirat fs/namei.c:4016 [inline]
>        __se_sys_mkdirat fs/namei.c:4014 [inline]
>        __ia32_sys_mkdirat+0x81/0xa0 fs/namei.c:4014
>        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
>        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
>        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
>        entry_SYSENTER_compat_after_hwframe+0x53/0x62
> 
> -> #0 (jbd2_handle){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3095 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>        validate_chain kernel/locking/lockdep.c:3829 [inline]
>        __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
>        lock_acquire kernel/locking/lockdep.c:5665 [inline]
>        lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
>        start_this_handle+0xfe7/0x14a0 fs/jbd2/transaction.c:463
>        jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
>        __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
>        __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
>        ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5949
>        __mark_inode_dirty+0x495/0x1050 fs/fs-writeback.c:2381
>        mark_inode_dirty_sync include/linux/fs.h:2337 [inline]
>        iput.part.0+0x57/0x820 fs/inode.c:1767
>        iput+0x58/0x70 fs/inode.c:1760
>        dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
>        __dentry_kill+0x3c0/0x640 fs/dcache.c:607
>        shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
>        prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
>        super_cache_scan+0x336/0x590 fs/super.c:104
>        do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:770
>        shrink_slab+0x17c/0x6f0 mm/vmscan.c:930
>        shrink_node_memcgs mm/vmscan.c:3124 [inline]
>        shrink_node+0x8b3/0x1db0 mm/vmscan.c:3245
>        shrink_zones mm/vmscan.c:3482 [inline]
>        do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3540
>        try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3775
>        __perform_reclaim mm/page_alloc.c:4641 [inline]
>        __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
>        __alloc_pages_slowpath.constprop.0+0xa8a/0x2160 mm/page_alloc.c:5066
>        __alloc_pages+0x436/0x510 mm/page_alloc.c:5439
>        __alloc_pages_node include/linux/gfp.h:587 [inline]
>        khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:859
>        collapse_huge_page mm/khugepaged.c:1062 [inline]
>        khugepaged_scan_pmd mm/khugepaged.c:1348 [inline]
>        khugepaged_scan_mm_slot mm/khugepaged.c:2170 [inline]
>        khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>        khugepaged+0x3473/0x66a0 mm/khugepaged.c:2296
>        kthread+0x2e9/0x3a0 kernel/kthread.c:376
>        ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   jbd2_handle --> oom_lock --> fs_reclaim
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(oom_lock);
>                                lock(fs_reclaim);
>   lock(jbd2_handle);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by khugepaged/48:
>  #0: ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:4638 [inline]
>  #0: ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
>  #0: ffffffff8bebdb20 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x9e1/0x2160 mm/page_alloc.c:5066
>  #1: ffffffff8be7d850 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab+0xc9/0x6f0 mm/vmscan.c:920
>  #2: ffff8880445800e0 (&type->s_umount_key#33){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
>  #2: ffff8880445800e0 (&type->s_umount_key#33){++++}-{3:3}, at: super_cache_scan+0x6c/0x590 fs/super.c:79
> 
> stack backtrace:
> CPU: 2 PID: 48 Comm: khugepaged Not tainted 5.19.0-rc6-syzkaller-00026-g5a29232d870d #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3095 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3214 [inline]
>  validate_chain kernel/locking/lockdep.c:3829 [inline]
>  __lock_acquire+0x2abe/0x5660 kernel/locking/lockdep.c:5053
>  lock_acquire kernel/locking/lockdep.c:5665 [inline]
>  lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5630
>  start_this_handle+0xfe7/0x14a0 fs/jbd2/transaction.c:463
>  jbd2__journal_start+0x399/0x930 fs/jbd2/transaction.c:520
>  __ext4_journal_start_sb+0x3a8/0x4a0 fs/ext4/ext4_jbd2.c:105
>  __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
>  ext4_dirty_inode+0x9d/0x110 fs/ext4/inode.c:5949
>  __mark_inode_dirty+0x495/0x1050 fs/fs-writeback.c:2381
>  mark_inode_dirty_sync include/linux/fs.h:2337 [inline]
>  iput.part.0+0x57/0x820 fs/inode.c:1767
>  iput+0x58/0x70 fs/inode.c:1760
>  dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
>  __dentry_kill+0x3c0/0x640 fs/dcache.c:607
>  shrink_dentry_list+0x23c/0x800 fs/dcache.c:1201
>  prune_dcache_sb+0xe7/0x140 fs/dcache.c:1282
>  super_cache_scan+0x336/0x590 fs/super.c:104
>  do_shrink_slab+0x42d/0xbd0 mm/vmscan.c:770
>  shrink_slab+0x17c/0x6f0 mm/vmscan.c:930
>  shrink_node_memcgs mm/vmscan.c:3124 [inline]
>  shrink_node+0x8b3/0x1db0 mm/vmscan.c:3245
>  shrink_zones mm/vmscan.c:3482 [inline]
>  do_try_to_free_pages+0x3b5/0x1700 mm/vmscan.c:3540
>  try_to_free_pages+0x2ac/0x840 mm/vmscan.c:3775
>  __perform_reclaim mm/page_alloc.c:4641 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:4663 [inline]
>  __alloc_pages_slowpath.constprop.0+0xa8a/0x2160 mm/page_alloc.c:5066
>  __alloc_pages+0x436/0x510 mm/page_alloc.c:5439
>  __alloc_pages_node include/linux/gfp.h:587 [inline]
>  khugepaged_alloc_page+0xa0/0x170 mm/khugepaged.c:859
>  collapse_huge_page mm/khugepaged.c:1062 [inline]
>  khugepaged_scan_pmd mm/khugepaged.c:1348 [inline]
>  khugepaged_scan_mm_slot mm/khugepaged.c:2170 [inline]
>  khugepaged_do_scan mm/khugepaged.c:2251 [inline]
>  khugepaged+0x3473/0x66a0 mm/khugepaged.c:2296
>  kthread+0x2e9/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:302
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
