Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD084BA119
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 14:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiBQN2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 08:28:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiBQN2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:28:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD61AE733;
        Thu, 17 Feb 2022 05:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mP4mYKtq70+ShGRf5quFoI/R+rvs29MJfH/eQ3IbnHk=; b=JKDwYOcgcvd+Obw9Dv8Z2E21GJ
        uFLITVmqgAit67dPk51n+BCX1oGDw/6nRIjHQrp/huhmV2BkeV8ILF1NMhBJdo25TsiSve3rS9Ztq
        ngzuo42XQCdfMwF0xTg6orlVW9wT7NV7RzZaEv7T1VojfuC6zp0UQHNHXn46GlAGuQXA/4lKInLXv
        mlHiIOb73utWZyZPmq6weSsZ0K/hzX8xuMBq+6KIOLG2TLe7FmIVA6944A0uBz4ZSq8tgw/gybTdv
        XcfCewPjowxth6ZW+HdiEE5BzoOKfgFcVt08z+qljOWDXRZzO5hFtqiZ4IBybCp4fEOpE/CZI+OHU
        l5gYnK0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKgow-00Fdgd-Ou; Thu, 17 Feb 2022 13:27:42 +0000
Date:   Thu, 17 Feb 2022 13:27:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        david@fromorbit.com, amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: Re: Report 1 in ext4 and journal based on v5.17-rc1
Message-ID: <Yg5NTs2RlhdTmSQj@casper.infradead.org>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
 <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645096204-31670-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:10:03PM +0900, Byungchul Park wrote:
> [    7.009608] ===================================================
> [    7.009613] DEPT: Circular dependency has been detected.
> [    7.009614] 5.17.0-rc1-00014-g8a599299c0cb-dirty #30 Tainted: G        W
> [    7.009616] ---------------------------------------------------
> [    7.009617] summary
> [    7.009618] ---------------------------------------------------
> [    7.009618] *** DEADLOCK ***
> [    7.009618]
> [    7.009619] context A
> [    7.009619]     [S] (unknown)(&(bit_wait_table + i)->dmap:0)

Why is the context unknown here?  I don't see a way to debug this
without knowing where we acquired the bit wait lock.

> [    7.009621]     [W] down_write(&ei->i_data_sem:0)
> [    7.009623]     [E] event(&(bit_wait_table + i)->dmap:0)
> [    7.009624]
> [    7.009625] context B
> [    7.009625]     [S] down_read(&ei->i_data_sem:0)
> [    7.009626]     [W] wait(&(bit_wait_table + i)->dmap:0)
> [    7.009627]     [E] up_read(&ei->i_data_sem:0)
> [    7.009628]
> [    7.009629] [S]: start of the event context
> [    7.009629] [W]: the wait blocked
> [    7.009630] [E]: the event not reachable
> [    7.009631] ---------------------------------------------------
> [    7.009631] context A's detail
> [    7.009632] ---------------------------------------------------
> [    7.009632] context A
> [    7.009633]     [S] (unknown)(&(bit_wait_table + i)->dmap:0)
> [    7.009634]     [W] down_write(&ei->i_data_sem:0)
> [    7.009635]     [E] event(&(bit_wait_table + i)->dmap:0)
> [    7.009636]
> [    7.009636] [S] (unknown)(&(bit_wait_table + i)->dmap:0):
> [    7.009638] (N/A)
> [    7.009638]
> [    7.009639] [W] down_write(&ei->i_data_sem:0):
> [    7.009639] ext4_truncate (fs/ext4/inode.c:4187) 
> [    7.009645] stacktrace:
> [    7.009646] down_write (kernel/locking/rwsem.c:1514) 
> [    7.009648] ext4_truncate (fs/ext4/inode.c:4187) 
> [    7.009650] ext4_da_write_begin (./include/linux/fs.h:827 fs/ext4/truncate.h:23 fs/ext4/inode.c:2963) 
> [    7.009652] generic_perform_write (mm/filemap.c:3784) 
> [    7.009654] ext4_buffered_write_iter (fs/ext4/file.c:269) 
> [    7.009657] ext4_file_write_iter (fs/ext4/file.c:677) 
> [    7.009659] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
> [    7.009662] vfs_write (fs/read_write.c:590) 
> [    7.009663] ksys_write (fs/read_write.c:644) 
> [    7.009664] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [    7.009667] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [    7.009669]
> [    7.009670] [E] event(&(bit_wait_table + i)->dmap:0):
> [    7.009671] __wake_up_common (kernel/sched/wait.c:108) 
> [    7.009673] stacktrace:
> [    7.009674] dept_event (kernel/dependency/dept.c:2337) 
> [    7.009677] __wake_up_common (kernel/sched/wait.c:109) 
> [    7.009678] __wake_up_common_lock (./include/linux/spinlock.h:428 (discriminator 1) kernel/sched/wait.c:141 (discriminator 1)) 
> [    7.009679] __wake_up_bit (kernel/sched/wait_bit.c:127) 
> [    7.009681] ext4_orphan_del (fs/ext4/orphan.c:282) 
> [    7.009683] ext4_truncate (fs/ext4/inode.c:4212) 
> [    7.009685] ext4_da_write_begin (./include/linux/fs.h:827 fs/ext4/truncate.h:23 fs/ext4/inode.c:2963) 
> [    7.009687] generic_perform_write (mm/filemap.c:3784) 
> [    7.009688] ext4_buffered_write_iter (fs/ext4/file.c:269) 
> [    7.009690] ext4_file_write_iter (fs/ext4/file.c:677) 
> [    7.009692] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
> [    7.009694] vfs_write (fs/read_write.c:590) 
> [    7.009695] ksys_write (fs/read_write.c:644) 
> [    7.009696] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [    7.009698] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [    7.009700] ---------------------------------------------------
> [    7.009700] context B's detail
> [    7.009701] ---------------------------------------------------
> [    7.009702] context B
> [    7.009702]     [S] down_read(&ei->i_data_sem:0)
> [    7.009703]     [W] wait(&(bit_wait_table + i)->dmap:0)
> [    7.009704]     [E] up_read(&ei->i_data_sem:0)
> [    7.009705]
> [    7.009706] [S] down_read(&ei->i_data_sem:0):
> [    7.009707] ext4_map_blocks (./arch/x86/include/asm/bitops.h:207 ./include/asm-generic/bitops/instrumented-non-atomic.h:135 fs/ext4/ext4.h:1918 fs/ext4/inode.c:562) 
> [    7.009709] stacktrace:
> [    7.009709] down_read (kernel/locking/rwsem.c:1461) 
> [    7.009711] ext4_map_blocks (./arch/x86/include/asm/bitops.h:207 ./include/asm-generic/bitops/instrumented-non-atomic.h:135 fs/ext4/ext4.h:1918 fs/ext4/inode.c:562) 
> [    7.009712] ext4_getblk (fs/ext4/inode.c:851) 
> [    7.009714] ext4_bread (fs/ext4/inode.c:903) 
> [    7.009715] __ext4_read_dirblock (fs/ext4/namei.c:117) 
> [    7.009718] dx_probe (fs/ext4/namei.c:789) 
> [    7.009720] ext4_dx_find_entry (fs/ext4/namei.c:1721) 
> [    7.009722] __ext4_find_entry (fs/ext4/namei.c:1571) 
> [    7.009723] ext4_lookup (fs/ext4/namei.c:1770) 
> [    7.009725] lookup_open (./include/linux/dcache.h:361 fs/namei.c:3310) 
> [    7.009727] path_openat (fs/namei.c:3401 fs/namei.c:3605) 
> [    7.009729] do_filp_open (fs/namei.c:3637) 
> [    7.009731] do_sys_openat2 (fs/open.c:1215) 
> [    7.009732] do_sys_open (fs/open.c:1231) 
> [    7.009734] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [    7.009736] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [    7.009738]
> [    7.009738] [W] wait(&(bit_wait_table + i)->dmap:0):
> [    7.009739] prepare_to_wait (kernel/sched/wait.c:275) 
> [    7.009741] stacktrace:
> [    7.009741] __schedule (kernel/sched/sched.h:1318 kernel/sched/sched.h:1616 kernel/sched/core.c:6213) 
> [    7.009743] schedule (kernel/sched/core.c:6373 (discriminator 1)) 
> [    7.009744] io_schedule (./arch/x86/include/asm/current.h:15 kernel/sched/core.c:8392 kernel/sched/core.c:8418) 
> [    7.009745] bit_wait_io (./arch/x86/include/asm/current.h:15 kernel/sched/wait_bit.c:210) 
> [    7.009746] __wait_on_bit (kernel/sched/wait_bit.c:49) 
> [    7.009748] out_of_line_wait_on_bit (kernel/sched/wait_bit.c:65) 
> [    7.009749] ext4_read_bh (./arch/x86/include/asm/bitops.h:207 ./include/asm-generic/bitops/instrumented-non-atomic.h:135 ./include/linux/buffer_head.h:120 fs/ext4/super.c:201) 
> [    7.009752] __read_extent_tree_block (fs/ext4/extents.c:545) 
> [    7.009754] ext4_find_extent (fs/ext4/extents.c:928) 
> [    7.009756] ext4_ext_map_blocks (fs/ext4/extents.c:4099) 
> [    7.009757] ext4_map_blocks (fs/ext4/inode.c:563) 
> [    7.009759] ext4_getblk (fs/ext4/inode.c:851) 
> [    7.009760] ext4_bread (fs/ext4/inode.c:903) 
> [    7.009762] __ext4_read_dirblock (fs/ext4/namei.c:117) 
> [    7.009764] dx_probe (fs/ext4/namei.c:789) 
> [    7.009765] ext4_dx_find_entry (fs/ext4/namei.c:1721) 
> [    7.009767]
> [    7.009768] [E] up_read(&ei->i_data_sem:0):
> [    7.009769] ext4_map_blocks (fs/ext4/inode.c:593) 
> [    7.009771] stacktrace:
> [    7.009771] up_read (kernel/locking/rwsem.c:1556) 
> [    7.009774] ext4_map_blocks (fs/ext4/inode.c:593) 
> [    7.009775] ext4_getblk (fs/ext4/inode.c:851) 
> [    7.009777] ext4_bread (fs/ext4/inode.c:903) 
> [    7.009778] __ext4_read_dirblock (fs/ext4/namei.c:117) 
> [    7.009780] dx_probe (fs/ext4/namei.c:789) 
> [    7.009782] ext4_dx_find_entry (fs/ext4/namei.c:1721) 
> [    7.009784] __ext4_find_entry (fs/ext4/namei.c:1571) 
> [    7.009786] ext4_lookup (fs/ext4/namei.c:1770) 
> [    7.009788] lookup_open (./include/linux/dcache.h:361 fs/namei.c:3310) 
> [    7.009789] path_openat (fs/namei.c:3401 fs/namei.c:3605) 
> [    7.009791] do_filp_open (fs/namei.c:3637) 
> [    7.009792] do_sys_openat2 (fs/open.c:1215) 
> [    7.009794] do_sys_open (fs/open.c:1231) 
> [    7.009795] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [    7.009797] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [    7.009799] ---------------------------------------------------
> [    7.009800] information that might be helpful
> [    7.009800] ---------------------------------------------------
> [    7.009801] CPU: 0 PID: 611 Comm: rs:main Q:Reg Tainted: G        W         5.17.0-rc1-00014-g8a599299c0cb-dirty #30
> [    7.009804] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [    7.009805] Call Trace:
> [    7.009806]  <TASK>
> [    7.009807] dump_stack_lvl (lib/dump_stack.c:107) 
> [    7.009809] print_circle (./arch/x86/include/asm/atomic.h:108 ./include/linux/atomic/atomic-instrumented.h:258 kernel/dependency/dept.c:157 kernel/dependency/dept.c:762) 
> [    7.009812] ? print_circle (kernel/dependency/dept.c:1086) 
> [    7.009814] cb_check_dl (kernel/dependency/dept.c:1104) 
> [    7.009815] bfs (kernel/dependency/dept.c:860) 
> [    7.009818] add_dep (kernel/dependency/dept.c:1423) 
> [    7.009820] do_event.isra.25 (kernel/dependency/dept.c:1650) 
> [    7.009822] ? __wake_up_common (kernel/sched/wait.c:108) 
> [    7.009824] dept_event (kernel/dependency/dept.c:2337) 
> [    7.009826] __wake_up_common (kernel/sched/wait.c:109) 
> [    7.009828] __wake_up_common_lock (./include/linux/spinlock.h:428 (discriminator 1) kernel/sched/wait.c:141 (discriminator 1)) 
> [    7.009830] __wake_up_bit (kernel/sched/wait_bit.c:127) 
> [    7.009832] ext4_orphan_del (fs/ext4/orphan.c:282) 
> [    7.009835] ? dept_ecxt_exit (./arch/x86/include/asm/current.h:15 kernel/dependency/dept.c:241 kernel/dependency/dept.c:999 kernel/dependency/dept.c:1043 kernel/dependency/dept.c:2478) 
> [    7.009837] ext4_truncate (fs/ext4/inode.c:4212) 
> [    7.009839] ext4_da_write_begin (./include/linux/fs.h:827 fs/ext4/truncate.h:23 fs/ext4/inode.c:2963) 
> [    7.009842] generic_perform_write (mm/filemap.c:3784) 
> [    7.009845] ext4_buffered_write_iter (fs/ext4/file.c:269) 
> [    7.009848] ext4_file_write_iter (fs/ext4/file.c:677) 
> [    7.009851] new_sync_write (fs/read_write.c:504 (discriminator 1)) 
> [    7.009854] vfs_write (fs/read_write.c:590) 
> [    7.009856] ksys_write (fs/read_write.c:644) 
> [    7.009857] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:65) 
> [    7.009860] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [    7.009862] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
> [    7.009865] RIP: 0033:0x7f3b160b335d
> [ 7.009867] Code: e1 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce fa ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 17 fb ff ff 48 89 d0 48 83 c4 08 48 3d 01
> All code
> ========
>    0:	e1 20                	loope  0x22
>    2:	00 00                	add    %al,(%rax)
>    4:	75 10                	jne    0x16
>    6:	b8 01 00 00 00       	mov    $0x1,%eax
>    b:	0f 05                	syscall 
>    d:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>   13:	73 31                	jae    0x46
>   15:	c3                   	retq   
>   16:	48 83 ec 08          	sub    $0x8,%rsp
>   1a:	e8 ce fa ff ff       	callq  0xfffffffffffffaed
>   1f:	48 89 04 24          	mov    %rax,(%rsp)
>   23:	b8 01 00 00 00       	mov    $0x1,%eax
>   28:	0f 05                	syscall 
>   2a:*	48 8b 3c 24          	mov    (%rsp),%rdi		<-- trapping instruction
>   2e:	48 89 c2             	mov    %rax,%rdx
>   31:	e8 17 fb ff ff       	callq  0xfffffffffffffb4d
>   36:	48 89 d0             	mov    %rdx,%rax
>   39:	48 83 c4 08          	add    $0x8,%rsp
>   3d:	48                   	rex.W
>   3e:	3d                   	.byte 0x3d
>   3f:	01                   	.byte 0x1
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 8b 3c 24          	mov    (%rsp),%rdi
>    4:	48 89 c2             	mov    %rax,%rdx
>    7:	e8 17 fb ff ff       	callq  0xfffffffffffffb23
>    c:	48 89 d0             	mov    %rdx,%rax
>    f:	48 83 c4 08          	add    $0x8,%rsp
>   13:	48                   	rex.W
>   14:	3d                   	.byte 0x3d
>   15:	01                   	.byte 0x1
> [    7.009869] RSP: 002b:00007f3b1340f180 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> [    7.009871] RAX: ffffffffffffffda RBX: 00007f3b040010a0 RCX: 00007f3b160b335d
> [    7.009873] RDX: 0000000000000300 RSI: 00007f3b040010a0 RDI: 0000000000000001
> [    7.009874] RBP: 0000000000000000 R08: fffffffffffffa15 R09: fffffffffffffa05
> [    7.009875] R10: 0000000000000000 R11: 0000000000000293 R12: 00007f3b04000df0
> [    7.009876] R13: 00007f3b1340f1a0 R14: 0000000000000220 R15: 0000000000000300
> [    7.009879]  </TASK>
