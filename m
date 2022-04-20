Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C4507DAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 02:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358572AbiDTAkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 20:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDTAkV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:40:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886CBB857;
        Tue, 19 Apr 2022 17:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18802B81244;
        Wed, 20 Apr 2022 00:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D1BC385A7;
        Wed, 20 Apr 2022 00:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650415053;
        bh=crX7LfMw2c5NNQLoS9LDfSjFx6YzubBYnKnfKAIGIcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DU2FpNBtMEMfbb4tIaBxY+0AVFaHu4cDFdGrkOO1OkB1KDA6avk/umf0xNCwqe4Py
         hATkAtFgEL+JNnWYFhM/GUDMEcO4AfJ7V/QWnPxsrD4ixHKiTUwMIvGjr4npbmV0ey
         OeA/QQOlATjD7NxWAo+JzKq1q0GQpPkL/bNkI/8lPsM+r09vzd1ghIe419FtR1S7RU
         b8GtL1vO+/guNdVTuo5nybnvvud2bV6lkYoiH4QtcSJnSElzL90HqhJL7AUQrmwaKq
         /SZMoJHyc0RFQDrwBhbVa80LwjNOWuVJa7x4IfDJAoFjgJ2ORT25UmhZwglHzAAPKz
         lTPLsfBKsMGKQ==
Date:   Tue, 19 Apr 2022 17:37:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220420003733.GB16996@magnolia>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418174747.GF17025@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 18, 2022 at 10:47:47AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 13, 2022 at 03:50:32PM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 12, 2022 at 08:34:25PM -0700, Darrick J. Wong wrote:
> > > Hmm.  Two nights in a row I've seen the following crash.  Has anyone
> > > else seen this, or should I keep digging?  This is a fairly boring
> > > x86_64 VM with a XFS v5 filesystem + rmapbt.
> > 
> > I have not seen this before.  I test with:
> > MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc
> > 
> > Maybe I should try a 4096 byte block size.
> > 
> > > mm/filemap.c:1653 is the BUG in:
> > > 
> > > void folio_end_writeback(struct folio *folio)
> > > {
> > > 	/*
> > > 	 * folio_test_clear_reclaim() could be used here but it is an
> > > 	 * atomic operation and overkill in this particular case.
> > > 	 * Failing to shuffle a folio marked for immediate reclaim is
> > > 	 * too mild a gain to justify taking an atomic operation penalty
> > > 	 * at the end of every folio writeback.
> > > 	 */
> > > 	if (folio_test_reclaim(folio)) {
> > > 		folio_clear_reclaim(folio);
> > > 		folio_rotate_reclaimable(folio);
> > > 	}
> > > 
> > > 	/*
> > > 	 * Writeback does not hold a folio reference of its own, relying
> > > 	 * on truncation to wait for the clearing of PG_writeback.
> > > 	 * But here we must make sure that the folio is not freed and
> > > 	 * reused before the folio_wake().
> > > 	 */
> > > 	folio_get(folio);
> > > 	if (!__folio_end_writeback(folio))
> > > >>>>		BUG();
> > 
> > Grr, that should have been a VM_BUG_ON_FOLIO(1, folio) so we get useful
> > information about the folio (like whether it has an iop, or what order
> > the folio is).  Can you make that change and try to reproduce?
> 
> > What's going on here is that we've called folio_end_writeback() on a
> > folio which does not have the writeback flag set.  That _should_ be
> > impossible, hence the use of BUG().  Either we've called
> > folio_end_writeback() twice on the same folio, or we neglected to set
> > the writeback flag on the folio.  I don't immediately see why either
> > of those two things would happen.
> 
> Well, I made that change and rebased to -rc3 to see if reverting that
> ZERO_PAGE thing would produce better results, I think I just got the
> same crash.  Curiously, the only VM that died this time was the one
> running the realtime configuration, but it's still generic/068:
> 
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 oci-mtr28 5.18.0-rc3-djwx #rc3 SMP PREEMPT_DYNAMIC Sun Apr 17 14:42:49 PDT 2022
> MKFS_OPTIONS  -- -f -rrtdev=/dev/sdb4 -llogdev=/dev/sdb2 -m reflink=0,rmapbt=0, -d rtinherit=1, /dev/sda4
> MOUNT_OPTIONS -- -ortdev=/dev/sdb4 -ologdev=/dev/sdb2 /dev/sda4 /opt
> 
> I don't know if it'll help, but here's the sequence of tests that we
> were running just prior to crashing:
> 
> generic/445      3s
> generic/225      76s
> xfs/306  22s
> xfs/290  3s
> generic/155     [not run] Reflink not supported by test filesystem type: xfs
> generic/525      6s
> generic/269      89s
> generic/1206    [not run] xfs_io swapext -v vfs -s 64k -l 64k ioctl support is missing
> xfs/504  198s
> xfs/192 [not run] Reflink not supported by scratch filesystem type: xfs
> xfs/303  1s
> generic/346      6s
> generic/512      5s
> xfs/227  308s
> generic/147     [not run] Reflink not supported by test filesystem type: xfs
> generic/230     [not run] Quotas not supported on realtime test device
> generic/008      4s
> generic/108      4s
> xfs/264  12s
> generic/200     [not run] Reflink not supported by scratch filesystem type: xfs
> generic/493     [not run] Dedupe not supported by scratch filesystem type: xfs
> xfs/021  5s
> generic/672     [not run] Reflink not supported by scratch filesystem type: xfs
> xfs/493  5s
> xfs/146  13s
> xfs/315 [not run] Reflink not supported by scratch filesystem type: xfs
> generic/068     
> 
> And the dmesg output:
> 
> run fstests generic/068 at 2022-04-17 16:57:16
> XFS (sda4): Mounting V5 Filesystem
> XFS (sda4): Ending clean mount
> page:ffffea0004a39c40 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x128e71
> flags: 0x17ff80000000000(node=0|zone=2|lastcpupid=0xfff)
> raw: 017ff80000000000 0000000000000000 ffffffff00000203 0000000000000000
> raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_FOLIO(((unsigned int) folio_ref_count(folio) + 127u <= 127u))
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:1164!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 3 PID: 1094085 Comm: 3:0 Tainted: G        W         5.18.0-rc3-djwx #rc3 0a707744ee7c555d54e50726c5b02515710a6aae
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> RIP: 0010:folio_end_writeback+0xd0/0x110
> Code: 80 60 02 fb 48 89 ef e8 5e 6d 01 00 8b 45 34 83 c0 7f 83 f8 7f 0f 87 6a ff ff ff 48 c7 c6 40 c7 e2 81 48 89 ef e8 30 69 04 00 <0f> 0b 48 89 ee e8 b6 51 02 00 eb 9a 48 c7 c6 c0 ad e5 81 48 89 ef
> RSP: 0018:ffffc900084f3d48 EFLAGS: 00010246
> RAX: 000000000000005c RBX: 0000000000001000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81e56da3 RDI: 00000000ffffffff
> RBP: ffffea0004a39c40 R08: 0000000000000000 R09: ffffffff8205fe40
> R10: 0000000000017578 R11: 00000000000175f0 R12: 0000000000004000
> R13: ffff88814dc5cd40 R14: 000000000000002e R15: ffffea0004a39c40
> FS:  0000000000000000(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2b0ea47010 CR3: 000000043f00c000 CR4: 00000000001506a0
> Call Trace:
>  <TASK>
>  iomap_finish_ioend+0x1ee/0x6a0
>  iomap_finish_ioends+0x69/0x100
>  xfs_end_ioend+0x5a/0x160 [xfs e8251de1111d7958449fd159d84af12a2afc12f2]
>  xfs_end_io+0xb1/0xf0 [xfs e8251de1111d7958449fd159d84af12a2afc12f2]
>  process_one_work+0x1df/0x3c0
>  ? rescuer_thread+0x3b0/0x3b0
>  worker_thread+0x53/0x3b0
>  ? rescuer_thread+0x3b0/0x3b0
>  kthread+0xea/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>  </TASK>
> Modules linked in: xfs dm_zero btrfs blake2b_generic xor lzo_compress lzo_decompress zlib_deflate raid6_pq zstd_compress dm_delay dm_snapshot dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:folio_end_writeback+0xd0/0x110
> Code: 80 60 02 fb 48 89 ef e8 5e 6d 01 00 8b 45 34 83 c0 7f 83 f8 7f 0f 87 6a ff ff ff 48 c7 c6 40 c7 e2 81 48 89 ef e8 30 69 04 00 <0f> 0b 48 89 ee e8 b6 51 02 00 eb 9a 48 c7 c6 c0 ad e5 81 48 89 ef
> RSP: 0018:ffffc900084f3d48 EFLAGS: 00010246
> RAX: 000000000000005c RBX: 0000000000001000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff81e56da3 RDI: 00000000ffffffff
> RBP: ffffea0004a39c40 R08: 0000000000000000 R09: ffffffff8205fe40
> R10: 0000000000017578 R11: 00000000000175f0 R12: 0000000000004000
> R13: ffff88814dc5cd40 R14: 000000000000002e R15: ffffea0004a39c40
> FS:  0000000000000000(0000) GS:ffff88843fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2b0ea47010 CR3: 000000043f00c000 CR4: 00000000001506a0
> 
> --D


Today I managed to capture stack traces of all the D state processes on
a system with the hang described above:

/proc/41/comm = khugepaged
/proc/41/stack : [<0>] flush_work+0x5c/0x80
[<0>] __lru_add_drain_all+0x134/0x1c0
[<0>] khugepaged+0x6c/0x2460
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30

Not sure if this is involved, but it might be?
These systems /do/ have KSM and HUGEPAGE_ALWAYS turned on.

/proc/411335/comm = u8:1+events_unbound
/proc/411335/stack : [<0>] __synchronize_srcu.part.0+0x86/0xf0
[<0>] fsnotify_mark_destroy_workfn+0x7c/0x110
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30
/proc/973682/comm = u8:0+flush-8:0
/proc/973682/stack : [<0>] down+0x54/0x70
[<0>] xfs_buf_lock+0x2d/0xe0 [xfs]
[<0>] xfs_buf_find+0x356/0x880 [xfs]
[<0>] xfs_buf_get_map+0x46/0x3b0 [xfs]
[<0>] xfs_buf_read_map+0x52/0x2f0 [xfs]
[<0>] xfs_trans_read_buf_map+0x1bb/0x4a0 [xfs]
[<0>] xfs_btree_read_buf_block.constprop.0+0x96/0xd0 [xfs]
[<0>] xfs_btree_lookup_get_block+0x97/0x170 [xfs]
[<0>] xfs_btree_lookup+0xdd/0x540 [xfs]
[<0>] xfs_rmap_map+0xd0/0x860 [xfs]
[<0>] xfs_rmap_finish_one+0x243/0x300 [xfs]
[<0>] xfs_rmap_update_finish_item+0x37/0x70 [xfs]
[<0>] xfs_defer_finish_noroll+0x20a/0x6f0 [xfs]
[<0>] __xfs_trans_commit+0x153/0x3e0 [xfs]
[<0>] xfs_bmapi_convert_delalloc+0x495/0x5e0 [xfs]
[<0>] xfs_map_blocks+0x1ed/0x540 [xfs]
[<0>] iomap_do_writepage+0x2a3/0xae0
[<0>] write_cache_pages+0x224/0x6f0
[<0>] iomap_writepages+0x1c/0x40
[<0>] xfs_vm_writepages+0x7a/0xb0 [xfs]
[<0>] do_writepages+0xcc/0x1c0
[<0>] __writeback_single_inode+0x41/0x340
[<0>] writeback_sb_inodes+0x207/0x4a0
[<0>] __writeback_inodes_wb+0x4c/0xe0
[<0>] wb_writeback+0x1da/0x2c0
[<0>] wb_workfn+0x28c/0x500
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30

Writeback is stuck in an rmapbt update...

/proc/1139791/comm = u8:2+events_unbound
/proc/1139791/stack : [<0>] __synchronize_srcu.part.0+0x86/0xf0
[<0>] fsnotify_connector_destroy_workfn+0x3c/0x60
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30
/proc/1274752/comm = u8:3+xfs-blockgc/sda4
/proc/1274752/stack : [<0>] down+0x54/0x70
[<0>] xfs_buf_lock+0x2d/0xe0 [xfs]
[<0>] xfs_buf_find+0x356/0x880 [xfs]
[<0>] xfs_buf_get_map+0x46/0x3b0 [xfs]
[<0>] xfs_buf_read_map+0x52/0x2f0 [xfs]
[<0>] xfs_trans_read_buf_map+0x1bb/0x4a0 [xfs]
[<0>] xfs_read_agf+0xb2/0x1b0 [xfs]
[<0>] xfs_alloc_read_agf+0x54/0x370 [xfs]
[<0>] xfs_alloc_fix_freelist+0x38e/0x510 [xfs]
[<0>] xfs_free_extent_fix_freelist+0x61/0xa0 [xfs]
[<0>] xfs_rmap_finish_one+0xd9/0x300 [xfs]
[<0>] xfs_rmap_update_finish_item+0x37/0x70 [xfs]
[<0>] xfs_defer_finish_noroll+0x20a/0x6f0 [xfs]
[<0>] xfs_defer_finish+0x11/0xa0 [xfs]
[<0>] xfs_itruncate_extents_flags+0x14b/0x4b0 [xfs]
[<0>] xfs_free_eofblocks+0xe9/0x150 [xfs]
[<0>] xfs_icwalk_ag+0x4a7/0x800 [xfs]
[<0>] xfs_blockgc_worker+0x31/0x110 [xfs]
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30

Stuck waiting for the AGF to do an rmapbt update...

/proc/1315282/comm = fstest
/proc/1315282/stack : [<0>] folio_wait_bit_common+0x148/0x460
[<0>] folio_wait_writeback+0x22/0x80
[<0>] truncate_inode_pages_range+0x3fe/0x6f0
[<0>] truncate_pagecache+0x44/0x60
[<0>] xfs_setattr_size+0x163/0x4d0 [xfs]
[<0>] xfs_vn_setattr+0x75/0x180 [xfs]
[<0>] notify_change+0x306/0x500
[<0>] do_truncate+0x7d/0xd0
[<0>] path_openat+0xc60/0x1060
[<0>] do_filp_open+0xa9/0x150
[<0>] do_sys_openat2+0x97/0x160
[<0>] __x64_sys_openat+0x54/0x90
[<0>] do_syscall_64+0x35/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
/proc/1315283/comm = fstest
/proc/1315283/stack : [<0>] folio_wait_bit_common+0x148/0x460
[<0>] folio_wait_writeback+0x22/0x80
[<0>] __filemap_fdatawait_range+0x8c/0x250
[<0>] filemap_write_and_wait_range+0x85/0xf0
[<0>] xfs_setattr_size+0x103/0x4d0 [xfs]
[<0>] xfs_vn_setattr+0x75/0x180 [xfs]
[<0>] notify_change+0x306/0x500
[<0>] do_truncate+0x7d/0xd0
[<0>] path_openat+0xc60/0x1060
[<0>] do_filp_open+0xa9/0x150
[<0>] do_sys_openat2+0x97/0x160
[<0>] __x64_sys_openat+0x54/0x90
[<0>] do_syscall_64+0x35/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae
/proc/1315287/comm = fsstress
/proc/1315287/stack : [<0>] folio_wait_bit_common+0x148/0x460
[<0>] folio_wait_writeback+0x22/0x80
[<0>] __filemap_fdatawait_range+0x8c/0x250
[<0>] filemap_write_and_wait_range+0x85/0xf0
[<0>] xfs_setattr_size+0x2da/0x4d0 [xfs]
[<0>] xfs_vn_setattr+0x75/0x180 [xfs]
[<0>] notify_change+0x306/0x500
[<0>] do_truncate+0x7d/0xd0
[<0>] vfs_truncate+0x108/0x140
[<0>] do_sys_truncate.part.0+0x8a/0xa0
[<0>] do_syscall_64+0x35/0x80
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Clearly stuck on writeback, not sure if it's the same file as the one
that tripped the assertion...

/proc/1315478/comm = u8:4+xfs-blockgc/sda4
/proc/1315478/stack : [<0>] down+0x54/0x70
[<0>] xfs_buf_lock+0x2d/0xe0 [xfs]
[<0>] xfs_buf_find+0x356/0x880 [xfs]
[<0>] xfs_buf_get_map+0x46/0x3b0 [xfs]
[<0>] xfs_buf_read_map+0x52/0x2f0 [xfs]
[<0>] xfs_trans_read_buf_map+0x1bb/0x4a0 [xfs]
[<0>] xfs_imap_to_bp+0x4e/0x70 [xfs]
[<0>] xfs_trans_log_inode+0x1da/0x350 [xfs]
[<0>] __xfs_bunmapi+0x7e8/0xd30 [xfs]
[<0>] xfs_itruncate_extents_flags+0x13d/0x4b0 [xfs]
[<0>] xfs_free_eofblocks+0xe9/0x150 [xfs]
[<0>] xfs_icwalk_ag+0x4a7/0x800 [xfs]
[<0>] xfs_blockgc_worker+0x31/0x110 [xfs]
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30
/proc/1315479/comm = u8:5+xfs-blockgc/sda4
/proc/1315479/stack : [<0>] down+0x54/0x70
[<0>] xfs_buf_lock+0x2d/0xe0 [xfs]
[<0>] xfs_buf_find+0x356/0x880 [xfs]
[<0>] xfs_buf_get_map+0x46/0x3b0 [xfs]
[<0>] xfs_buf_read_map+0x52/0x2f0 [xfs]
[<0>] xfs_trans_read_buf_map+0x1bb/0x4a0 [xfs]
[<0>] xfs_imap_to_bp+0x4e/0x70 [xfs]
[<0>] xfs_trans_log_inode+0x1da/0x350 [xfs]
[<0>] __xfs_bunmapi+0x7e8/0xd30 [xfs]
[<0>] xfs_itruncate_extents_flags+0x13d/0x4b0 [xfs]
[<0>] xfs_free_eofblocks+0xe9/0x150 [xfs]
[<0>] xfs_icwalk_ag+0x4a7/0x800 [xfs]
[<0>] xfs_blockgc_worker+0x31/0x110 [xfs]
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30

Both of these threads are stuck on the inode cluster buffer.  If I had
to bet, I'd guess it's the one underlying the inode being processed by
pid 973682.

/proc/1315480/comm = u8:6+xfs-blockgc/sda4
/proc/1315480/stack : [<0>] down+0x54/0x70
[<0>] xfs_buf_lock+0x2d/0xe0 [xfs]
[<0>] xfs_buf_find+0x356/0x880 [xfs]
[<0>] xfs_buf_get_map+0x46/0x3b0 [xfs]
[<0>] xfs_buf_read_map+0x52/0x2f0 [xfs]
[<0>] xfs_trans_read_buf_map+0x1bb/0x4a0 [xfs]
[<0>] xfs_read_agf+0xb2/0x1b0 [xfs]
[<0>] xfs_alloc_read_agf+0x54/0x370 [xfs]
[<0>] xfs_alloc_fix_freelist+0x38e/0x510 [xfs]
[<0>] xfs_free_extent_fix_freelist+0x61/0xa0 [xfs]
[<0>] xfs_rmap_finish_one+0xd9/0x300 [xfs]
[<0>] xfs_rmap_update_finish_item+0x37/0x70 [xfs]
[<0>] xfs_defer_finish_noroll+0x20a/0x6f0 [xfs]
[<0>] xfs_defer_finish+0x11/0xa0 [xfs]
[<0>] xfs_itruncate_extents_flags+0x14b/0x4b0 [xfs]
[<0>] xfs_free_eofblocks+0xe9/0x150 [xfs]
[<0>] xfs_icwalk_ag+0x4a7/0x800 [xfs]
[<0>] xfs_blockgc_worker+0x31/0x110 [xfs]
[<0>] process_one_work+0x1df/0x3c0
[<0>] worker_thread+0x53/0x3b0
[<0>] kthread+0xea/0x110
[<0>] ret_from_fork+0x1f/0x30

Speculative preallocation garbage collection also got stuck waiting for
the AGF to do an rmapbt update.

--D

> 
> > 
> > > 
> > > 
> > > --D
> > > 
> > > run fstests generic/068 at 2022-04-12 17:57:11
> > > XFS (sda3): Mounting V5 Filesystem
> > > XFS (sda3): Ending clean mount
> > > XFS (sda4): Mounting V5 Filesystem
> > > XFS (sda4): Ending clean mount
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/filemap.c:1653!
> > > invalid opcode: 0000 [#1] PREEMPT SMP
> > > CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> > > Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
> > > Call Trace:
> > >  <TASK>
> > >  iomap_finish_ioend+0x19e/0x560
> > >  iomap_finish_ioends+0x69/0x100
> > >  xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > >  xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > >  process_one_work+0x1df/0x3c0
> > >  ? rescuer_thread+0x3b0/0x3b0
> > >  worker_thread+0x53/0x3b0
> > >  ? rescuer_thread+0x3b0/0x3b0
> > >  kthread+0xea/0x110
> > >  ? kthread_complete_and_exit+0x20/0x20
> > >  ret_from_fork+0x1f/0x30
> > >  </TASK>
> > > Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> > > Dumping ftrace buffer:
> > >    (ftrace buffer empty)
> > > ---[ end trace 0000000000000000 ]---
> > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0
> > > 
