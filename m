Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F264C4B8F41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 18:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiBPRfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 12:35:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiBPRfX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:35:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108B423BF0A;
        Wed, 16 Feb 2022 09:35:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68D61B81F95;
        Wed, 16 Feb 2022 17:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E652BC004E1;
        Wed, 16 Feb 2022 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645032905;
        bh=O5prr3Q4+8EaHJ+KbfsmM1HIuGFn0qoKvXik0pwt6e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAZqqUeYgbNF49cGldjUSxmCPdjxScC+wjfpsWwPQLOOlLGToY47L705yXsESeGYt
         H8sEEQX64S5W4skPaLxR8CMJYvPIt+7qzkuZ1fEXjztJ0tftNxCcQsqBfbgGOhwhFy
         ph3/vA/u7ET+/k/nv9dXXidBgfRgYQjxanMyPu4cmKR2wcS9b2AozOMVuE0jXj5Be7
         j3DNwBWSJTBvfh1EZvfl7w8mg9ebcMEbXjTnk4v2TT1sTEHLsot+HUAevq2E1iuX2i
         dkG83E2y7lcagp4TeFfOIjHcXFnUc5E3C8VHRWN0vBDPhkk9fYfn6sxuTv7w7bJXUO
         LEZtPkSXWjlpQ==
Date:   Wed, 16 Feb 2022 09:35:04 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Sachin Sant <sachinp@linux.ibm.com>
Cc:     linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        riteshh@linux.ibm.com, linux-next@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [next-20220215] WARNING at fs/iomap/buffered-io.c:75 with
 xfstests
Message-ID: <20220216173504.GM8313@magnolia>
References: <5AD0BD6A-2C31-450A-924E-A581CD454073@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AD0BD6A-2C31-450A-924E-A581CD454073@linux.ibm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[adding fsdevel to this party, since iomap is core code, not just XFS...]

On Wed, Feb 16, 2022 at 12:55:02PM +0530, Sachin Sant wrote:
> While running xfstests on IBM Power10 logical partition (LPAR) booted
> with 5.17.0-rc4-next-20220215 following warning was seen:
> 
> [ 2547.384210] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2547.389021] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x2bc2c0 len 32 error 5
> [ 2547.389020] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x15cede0 len 32 error 5
> [ 2547.389026] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0xc60 len 8 error 5
> [ 2547.389032] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x3bffa30 len 8 error 5
> [ 2547.389120] XFS (dm-0): log I/O error -5
> [ 2547.389135] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.

Hmm, the filesystem went down...

> [ 2547.389195] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2547.662818] ------------[ cut here ]------------
> [ 2547.662832] WARNING: CPU: 24 PID: 2463718 at fs/iomap/buffered-io.c:75 iomap_page_release+0x1b0/0x1e0

...and I think this is complaining about this debugging test in
iomap_page_release:

	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
			folio_test_uptodate(folio));

which checks that we're not releasing or invalidating a page that's
partially uptodate on a blocksize < pagesize filesystem (or so I gather
from "POWER10 LPAR" (64k pages?) and "XFS" (4k blocks?))...

> [ 2547.662840] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio loop dm_flakey xfs libcrc32c dm_mod rfkill bonding sunrpc pseries_rng xts vmx_crypto uio_pdrv_genirq uio sch_fq_codel ext4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: scsi_debug]
> [ 2547.662866] CPU: 24 PID: 2463718 Comm: umount Not tainted 5.17.0-rc4-next-20220215 #1
> [ 2547.662871] NIP:  c000000000565b80 LR: c000000000565aa0 CTR: c000000000565e40
> [ 2547.662874] REGS: c00000000f0035b0 TRAP: 0700   Not tainted  (5.17.0-rc4-next-20220215)
> [ 2547.662877] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44000228  XER: 20040000
> [ 2547.662885] CFAR: c000000000565ac8 IRQMASK: 0 
> [ 2547.662885] GPR00: c00000000037dd3c c00000000f003850 c000000002a03300 0000000000000001 
> [ 2547.662885] GPR04: 0000000000000010 0000000000010000 c0000000df6e7bc0 0000000000000001 
> [ 2547.662885] GPR08: fffffffffffeffff 0000000000000000 0000000000000010 0000000000000228 
> [ 2547.662885] GPR12: c000000000565e40 c000000abfcfe680 0000000000000000 0000000000000000 
> [ 2547.662885] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.662885] GPR20: 0000000000000000 0000000000000000 ffffffffffffffff fffffffffffffffe 
> [ 2547.662885] GPR24: 0000000000000000 ffffffffffffffff c00000000f0038e0 c0000000243db278 
> [ 2547.662885] GPR28: 0000000000000012 c0000000df6e7ae0 0000000000000010 c00c00000240c100 
> [ 2547.662920] NIP [c000000000565b80] iomap_page_release+0x1b0/0x1e0
> [ 2547.662924] LR [c000000000565aa0] iomap_page_release+0xd0/0x1e0
> [ 2547.662927] Call Trace:
> [ 2547.662928] [c00000000f003850] [c00000000f003890] 0xc00000000f003890 (unreliable)
> [ 2547.662932] [c00000000f003890] [c00000000037dd3c] truncate_cleanup_folio+0x7c/0x140
> [ 2547.662937] [c00000000f0038c0] [c00000000037f068] truncate_inode_pages_range+0x148/0x5e0
> [ 2547.662942] [c00000000f003a40] [c0000000004c2058] evict+0x248/0x270
> [ 2547.662946] [c00000000f003a80] [c0000000004c20fc] dispose_list+0x7c/0xb0
> [ 2547.662951] [c00000000f003ac0] [c0000000004c2314] evict_inodes+0x1e4/0x300
> [ 2547.662955] [c00000000f003b60] [c0000000004922d0] generic_shutdown_super+0x70/0x1e0

...but in this particular case, we're dumping pages (and inodes) as part
of unmounting the filesystem, in which case we've already flushed dirty
data to disk, because sync_filesystem gets called before evict_inodes
here...

> [ 2547.662959] [c00000000f003bd0] [c000000000492518] kill_block_super+0x38/0x90
> [ 2547.662964] [c00000000f003c00] [c0000000004926e8] deactivate_locked_super+0x78/0xf0
> [ 2547.662968] [c00000000f003c30] [c0000000004cde9c] cleanup_mnt+0xfc/0x1c0
> [ 2547.662972] [c00000000f003c80] [c000000000189448] task_work_run+0xf8/0x170
> [ 2547.662976] [c00000000f003cd0] [c000000000021b94] do_notify_resume+0x434/0x480
> [ 2547.662981] [c00000000f003d80] [c0000000000338b0] interrupt_exit_user_prepare_main+0x1a0/0x260
> [ 2547.662985] [c00000000f003de0] [c000000000033d74] syscall_exit_prepare+0x74/0x150
> [ 2547.662989] [c00000000f003e10] [c00000000000c658] system_call_common+0xf8/0x270
> [ 2547.662994] --- interrupt: c00 at 0x7fffa6bb7dfc
> [ 2547.662996] NIP:  00007fffa6bb7dfc LR: 00007fffa6bb7dcc CTR: 0000000000000000
> [ 2547.662999] REGS: c00000000f003e80 TRAP: 0c00   Not tainted  (5.17.0-rc4-next-20220215)
> [ 2547.663001] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000202  XER: 00000000
> [ 2547.663010] IRQMASK: 0 
> [ 2547.663010] GPR00: 0000000000000034 00007fffc7ca6a70 00007fffa6c87300 0000000000000000 
> [ 2547.663010] GPR04: 0000000000000000 00007fffc7ca6a88 0000000000000000 0000000166cf4e90 
> [ 2547.663010] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR12: 0000000000000000 00007fffa6f1d730 0000000000000000 0000000000000000 
> [ 2547.663010] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR24: 000000012d3b5f70 000000012d3b65d0 000000012d3cf6e8 0000000166cf0b50 
> [ 2547.663010] GPR28: 00007fffa6e701a4 0000000166cf4e90 0000000000000000 0000000166cf0970 
> [ 2547.663042] NIP [00007fffa6bb7dfc] 0x7fffa6bb7dfc
> [ 2547.663045] LR [00007fffa6bb7dcc] 0x7fffa6bb7dcc
> [ 2547.663047] --- interrupt: c00
> [ 2547.663048] Instruction dump:
> [ 2547.663050] 38210040 e9230000 ebe1fff8 4e800020 0fe00000 60000000 60000000 60000000 
> [ 2547.663056] 0fe00000 60000000 60000000 60000000 <0fe00000> 60000000 60000000 60000000 
> [ 2547.663062] ---[ end trace 0000000000000000 ]---
> [ 2547.663075] XFS (dm-0): Unmounting Filesystem
> 
> The warning is seen when test tries to unmount the file system. This problem is seen
> while running generic/475 sub test. Have attached captured messages during the test
> run of generic/475.

...aha!  The filesystem has gone down (hence the metadata IO errors at
the top of the report) during generic/475, which is a test that
exercises filesystem crash recovery.  It simulates a crash by calling
EXT4_IOC_SHUTDOWN and unmounting.

Given that in this case we've already cleared SB_ACTIVE from the
superblock s_flags, I wonder if we could amend that code to read:

	if (inode->i_sb->s_flags & SB_ACTIVE)
		WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
				folio_test_uptodate(folio));

Since we don't really care about memory pages that aren't fully up to
date if we're in the midst of freeing all the incore filesystem state.

Thoughts?

> xfstest is a recent add to upstream regression bucket.

Ooh, nice! :)

> I don’t have any previous data to attempt a git bisect. 

It's been there since the start of fs/iomap, so bisecting wouldn't help
much anyway.

--D

> Let me know if any additional information is required.
> 
> Thanks
> -Sachin
> 
> 

> [ 2523.250933] run fstests generic/475 at 2022-02-15 15:42:10
> [ 2523.366239] XFS (sdb1): Mounting V5 Filesystem
> [ 2523.376679] XFS (sdb1): Ending clean mount
> [ 2523.378107] xfs filesystem being mounted at /mnt/test supports timestamps until 2038 (0x7fffffff)
> [ 2523.502357] XFS (dm-0): Mounting V5 Filesystem
> [ 2523.508526] XFS (dm-0): Ending clean mount
> [ 2523.509735] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2524.516736] dm-0: writeback error on inode 33750928, offset 655360, sector 21228312
> [ 2524.517884] dm-0: writeback error on inode 100730311, offset 589824, sector 63235832
> [ 2524.518348] dm-0: writeback error on inode 67165541, offset 258371584, sector 42405248
> [ 2524.518625] dm-0: writeback error on inode 136194, offset 417792, sector 212888
> [ 2524.518727] dm-0: writeback error on inode 114612, offset 1052672, sector 295824
> [ 2524.518876] buffer_io_error: 6 callbacks suppressed
> [ 2524.518878] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2524.518888] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2524.518892] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2524.518895] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2524.518898] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2524.518901] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2524.518905] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2524.518908] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2524.518911] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2524.518914] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2524.519703] dm-0: writeback error on inode 67200889, offset 6684672, sector 42237480
> [ 2524.520249] dm-0: writeback error on inode 100772183, offset 30445568, sector 63105160
> [ 2524.520258] dm-0: writeback error on inode 100835769, offset 270336, sector 63079496
> [ 2524.520266] dm-0: writeback error on inode 114527, offset 40960, sector 84968
> [ 2524.520272] dm-0: writeback error on inode 67244195, offset 25001984, sector 42327408
> [ 2524.520710] XFS (dm-0): log I/O error -5
> [ 2524.520719] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2524.520780] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2524.793985] XFS (dm-0): Unmounting Filesystem
> [ 2524.870119] XFS (dm-0): Mounting V5 Filesystem
> [ 2525.015369] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2525.418197] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2525.419156] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2525.425641] XFS (dm-0): log I/O error -5
> [ 2525.425645] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x2c3c0 len 32 error 5
> [ 2525.425647] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x3bffa80 len 32 error 5
> [ 2525.425656] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2525.425711] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2525.592468] XFS (dm-0): Unmounting Filesystem
> [ 2525.609374] XFS (dm-0): Mounting V5 Filesystem
> [ 2525.681666] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2525.694463] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2525.696357] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2526.704897] XFS (dm-0): log I/O error -5
> [ 2526.704923] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2526.705029] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2526.948328] XFS (dm-0): Unmounting Filesystem
> [ 2527.040926] XFS (dm-0): Mounting V5 Filesystem
> [ 2527.216170] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2527.749123] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2527.750067] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2527.755047] XFS (dm-0): log I/O error -5
> [ 2527.755045] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x3bffa30 len 8 error 5
> [ 2527.755061] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x13ffe18 len 8 error 5
> [ 2527.755080] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2527.755161] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2527.923532] XFS (dm-0): Unmounting Filesystem
> [ 2527.940178] XFS (dm-0): Mounting V5 Filesystem
> [ 2527.999573] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2528.014009] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2528.016171] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2528.021163] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x15c0 len 32 error 5
> [ 2528.021161] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x13ffe80 len 32 error 5
> [ 2528.021247] XFS (dm-0): log I/O error -5
> [ 2528.021260] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2528.021319] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2528.261691] XFS (dm-0): Unmounting Filesystem
> [ 2528.278383] XFS (dm-0): Mounting V5 Filesystem
> [ 2528.337759] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2528.352023] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2528.354722] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2528.359910] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x1415598 len 8 error 5
> [ 2528.359909] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x3bffaa0 len 32 error 5
> [ 2528.360016] XFS (dm-0): xfs_imap_lookup: xfs_ialloc_read_agi() returned error -5, agno 0
> [ 2528.360045] XFS (dm-0): log I/O error -5
> [ 2528.360016] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x1415598 len 8 error 5
> [ 2528.360059] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2528.360128] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2528.603702] XFS (dm-0): Unmounting Filesystem
> [ 2528.620367] XFS (dm-0): Mounting V5 Filesystem
> [ 2528.629620] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2528.634048] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2528.635707] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2530.643300] buffer_io_error: 86 callbacks suppressed
> [ 2530.643303] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2530.643319] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2530.643323] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2530.643326] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2530.643330] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2530.643333] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2530.643336] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2530.643339] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2530.643342] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2530.643345] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2530.644362] iomap_finish_ioend: 221 callbacks suppressed
> [ 2530.644364] dm-0: writeback error on inode 34090876, offset 3014656, sector 22112200
> [ 2530.644538] dm-0: writeback error on inode 34427948, offset 786432, sector 22282544
> [ 2530.644760] dm-0: writeback error on inode 178971, offset 131072, sector 1225112
> [ 2530.645682] dm-0: writeback error on inode 178976, offset 327680, sector 857912
> [ 2530.645690] dm-0: writeback error on inode 101264072, offset 884736, sector 63870264
> [ 2530.645694] dm-0: writeback error on inode 178976, offset 331776, sector 1089144
> [ 2530.645699] dm-0: writeback error on inode 178976, offset 389120, sector 1089256
> [ 2530.652881] dm-0: writeback error on inode 67151740, offset 7122944, sector 43064768
> [ 2530.653420] dm-0: writeback error on inode 385792, offset 5693440, sector 1185032
> [ 2530.653602] dm-0: writeback error on inode 34090849, offset 2056192, sector 21840064
> [ 2530.653811] XFS (dm-0): log I/O error -5
> [ 2530.653819] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2530.653898] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2530.894975] XFS (dm-0): Unmounting Filesystem
> [ 2530.953709] XFS (dm-0): Mounting V5 Filesystem
> [ 2531.116725] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2531.619363] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2531.620537] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2533.630182] XFS (dm-0): log I/O error -5
> [ 2533.630204] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2533.630296] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2533.875912] XFS (dm-0): Unmounting Filesystem
> [ 2533.944095] XFS (dm-0): Mounting V5 Filesystem
> [ 2534.097933] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2534.545681] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2534.546748] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2534.552289] XFS (dm-0): log I/O error -5
> [ 2534.552294] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x86540 len 32 error 5
> [ 2534.552317] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2534.552363] XFS (dm-0): xfs_imap_lookup: xfs_ialloc_read_agi() returned error -5, agno 0
> [ 2534.552378] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2534.752003] XFS (dm-0): Unmounting Filesystem
> [ 2534.768805] XFS (dm-0): Mounting V5 Filesystem
> [ 2534.827769] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2534.841175] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2534.843039] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2536.849519] iomap_finish_ioend: 102 callbacks suppressed
> [ 2536.849523] dm-0: writeback error on inode 1413851, offset 89260032, sector 2095432
> [ 2536.850440] buffer_io_error: 38 callbacks suppressed
> [ 2536.850442] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2536.850453] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2536.850457] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2536.850460] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2536.850463] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2536.850467] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2536.850470] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2536.850473] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2536.850476] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2536.850479] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2536.851985] dm-0: writeback error on inode 1392803, offset 7856128, sector 2156768
> [ 2536.851989] dm-0: writeback error on inode 1358735, offset 32309248, sector 1874480
> [ 2536.852481] dm-0: writeback error on inode 102083501, offset 5750784, sector 65056496
> [ 2536.857616] dm-0: writeback error on inode 1369530, offset 786432, sector 1936752
> [ 2536.858012] dm-0: writeback error on inode 1729116, offset 1294336, sector 2157232
> [ 2536.858019] dm-0: writeback error on inode 68591248, offset 29708288, sector 44249952
> [ 2536.858025] dm-0: writeback error on inode 35290493, offset 67264512, sector 23190648
> [ 2536.858030] dm-0: writeback error on inode 35290493, offset 77107200, sector 23302296
> [ 2536.858035] dm-0: writeback error on inode 1369530, offset 868352, sector 1937336
> [ 2536.858192] XFS (dm-0): log I/O error -5
> [ 2536.858202] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2536.858282] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2537.084788] XFS (dm-0): Unmounting Filesystem
> [ 2537.125735] XFS (dm-0): Mounting V5 Filesystem
> [ 2537.252751] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2537.583254] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2537.584277] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2538.595093] XFS (dm-0): log I/O error -5
> [ 2538.595110] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2538.595196] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2538.864000] XFS (dm-0): Unmounting Filesystem
> [ 2538.905962] XFS (dm-0): Mounting V5 Filesystem
> [ 2539.096169] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2539.633947] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2539.634958] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2541.640724] XFS (dm-0): log I/O error -5
> [ 2541.640741] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2541.640802] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2541.935012] XFS (dm-0): Unmounting Filesystem
> [ 2541.988684] XFS (dm-0): Mounting V5 Filesystem
> [ 2542.116431] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2542.441152] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2542.442150] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2544.448191] iomap_finish_ioend: 46 callbacks suppressed
> [ 2544.448194] dm-0: writeback error on inode 36077872, offset 73859072, sector 24110792
> [ 2544.449711] buffer_io_error: 38 callbacks suppressed
> [ 2544.449712] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2544.449723] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2544.449727] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2544.449728] dm-0: writeback error on inode 2692401, offset 458752, sector 2775128
> [ 2544.449730] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2544.449735] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2544.449738] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2544.449742] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2544.449744] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2544.449748] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2544.449751] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2544.458404] dm-0: writeback error on inode 2391873, offset 466944, sector 2391824
> [ 2544.458447] dm-0: writeback error on inode 103160128, offset 937984, sector 65927664
> [ 2544.458543] dm-0: writeback error on inode 36054700, offset 33423360, sector 24188272
> [ 2544.458549] dm-0: writeback error on inode 103092984, offset 28631040, sector 65845792
> [ 2544.458553] dm-0: writeback error on inode 2392584, offset 74911744, sector 2755816
> [ 2544.458558] dm-0: writeback error on inode 69726030, offset 21921792, sector 44540328
> [ 2544.458563] dm-0: writeback error on inode 2669138, offset 1040384, sector 2801096
> [ 2544.458566] dm-0: writeback error on inode 2391873, offset 458752, sector 2391960
> [ 2544.458851] XFS (dm-0): log I/O error -5
> [ 2544.458858] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2544.458917] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2544.683010] XFS (dm-0): Unmounting Filesystem
> [ 2544.739531] XFS (dm-0): Mounting V5 Filesystem
> [ 2544.914316] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2545.426712] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2545.427672] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2546.438765] XFS (dm-0): log I/O error -5
> [ 2546.438781] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2546.438842] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2546.727004] XFS (dm-0): Unmounting Filesystem
> [ 2546.769608] XFS (dm-0): Mounting V5 Filesystem
> [ 2546.936362] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2547.383261] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2547.384210] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2547.389021] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x2bc2c0 len 32 error 5
> [ 2547.389020] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x15cede0 len 32 error 5
> [ 2547.389026] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0xc60 len 8 error 5
> [ 2547.389032] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x3bffa30 len 8 error 5
> [ 2547.389120] XFS (dm-0): log I/O error -5
> [ 2547.389135] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2547.389195] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2547.662818] ------------[ cut here ]------------
> [ 2547.662832] WARNING: CPU: 24 PID: 2463718 at fs/iomap/buffered-io.c:75 iomap_page_release+0x1b0/0x1e0
> [ 2547.662840] Modules linked in: dm_thin_pool dm_persistent_data dm_bio_prison dm_snapshot dm_bufio loop dm_flakey xfs libcrc32c dm_mod rfkill bonding sunrpc pseries_rng xts vmx_crypto uio_pdrv_genirq uio sch_fq_codel ext4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse [last unloaded: scsi_debug]
> [ 2547.662866] CPU: 24 PID: 2463718 Comm: umount Not tainted 5.17.0-rc4-next-20220215 #1
> [ 2547.662871] NIP:  c000000000565b80 LR: c000000000565aa0 CTR: c000000000565e40
> [ 2547.662874] REGS: c00000000f0035b0 TRAP: 0700   Not tainted  (5.17.0-rc4-next-20220215)
> [ 2547.662877] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44000228  XER: 20040000
> [ 2547.662885] CFAR: c000000000565ac8 IRQMASK: 0 
> [ 2547.662885] GPR00: c00000000037dd3c c00000000f003850 c000000002a03300 0000000000000001 
> [ 2547.662885] GPR04: 0000000000000010 0000000000010000 c0000000df6e7bc0 0000000000000001 
> [ 2547.662885] GPR08: fffffffffffeffff 0000000000000000 0000000000000010 0000000000000228 
> [ 2547.662885] GPR12: c000000000565e40 c000000abfcfe680 0000000000000000 0000000000000000 
> [ 2547.662885] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.662885] GPR20: 0000000000000000 0000000000000000 ffffffffffffffff fffffffffffffffe 
> [ 2547.662885] GPR24: 0000000000000000 ffffffffffffffff c00000000f0038e0 c0000000243db278 
> [ 2547.662885] GPR28: 0000000000000012 c0000000df6e7ae0 0000000000000010 c00c00000240c100 
> [ 2547.662920] NIP [c000000000565b80] iomap_page_release+0x1b0/0x1e0
> [ 2547.662924] LR [c000000000565aa0] iomap_page_release+0xd0/0x1e0
> [ 2547.662927] Call Trace:
> [ 2547.662928] [c00000000f003850] [c00000000f003890] 0xc00000000f003890 (unreliable)
> [ 2547.662932] [c00000000f003890] [c00000000037dd3c] truncate_cleanup_folio+0x7c/0x140
> [ 2547.662937] [c00000000f0038c0] [c00000000037f068] truncate_inode_pages_range+0x148/0x5e0
> [ 2547.662942] [c00000000f003a40] [c0000000004c2058] evict+0x248/0x270
> [ 2547.662946] [c00000000f003a80] [c0000000004c20fc] dispose_list+0x7c/0xb0
> [ 2547.662951] [c00000000f003ac0] [c0000000004c2314] evict_inodes+0x1e4/0x300
> [ 2547.662955] [c00000000f003b60] [c0000000004922d0] generic_shutdown_super+0x70/0x1e0
> [ 2547.662959] [c00000000f003bd0] [c000000000492518] kill_block_super+0x38/0x90
> [ 2547.662964] [c00000000f003c00] [c0000000004926e8] deactivate_locked_super+0x78/0xf0
> [ 2547.662968] [c00000000f003c30] [c0000000004cde9c] cleanup_mnt+0xfc/0x1c0
> [ 2547.662972] [c00000000f003c80] [c000000000189448] task_work_run+0xf8/0x170
> [ 2547.662976] [c00000000f003cd0] [c000000000021b94] do_notify_resume+0x434/0x480
> [ 2547.662981] [c00000000f003d80] [c0000000000338b0] interrupt_exit_user_prepare_main+0x1a0/0x260
> [ 2547.662985] [c00000000f003de0] [c000000000033d74] syscall_exit_prepare+0x74/0x150
> [ 2547.662989] [c00000000f003e10] [c00000000000c658] system_call_common+0xf8/0x270
> [ 2547.662994] --- interrupt: c00 at 0x7fffa6bb7dfc
> [ 2547.662996] NIP:  00007fffa6bb7dfc LR: 00007fffa6bb7dcc CTR: 0000000000000000
> [ 2547.662999] REGS: c00000000f003e80 TRAP: 0c00   Not tainted  (5.17.0-rc4-next-20220215)
> [ 2547.663001] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000202  XER: 00000000
> [ 2547.663010] IRQMASK: 0 
> [ 2547.663010] GPR00: 0000000000000034 00007fffc7ca6a70 00007fffa6c87300 0000000000000000 
> [ 2547.663010] GPR04: 0000000000000000 00007fffc7ca6a88 0000000000000000 0000000166cf4e90 
> [ 2547.663010] GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR12: 0000000000000000 00007fffa6f1d730 0000000000000000 0000000000000000 
> [ 2547.663010] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> [ 2547.663010] GPR24: 000000012d3b5f70 000000012d3b65d0 000000012d3cf6e8 0000000166cf0b50 
> [ 2547.663010] GPR28: 00007fffa6e701a4 0000000166cf4e90 0000000000000000 0000000166cf0970 
> [ 2547.663042] NIP [00007fffa6bb7dfc] 0x7fffa6bb7dfc
> [ 2547.663045] LR [00007fffa6bb7dcc] 0x7fffa6bb7dcc
> [ 2547.663047] --- interrupt: c00
> [ 2547.663048] Instruction dump:
> [ 2547.663050] 38210040 e9230000 ebe1fff8 4e800020 0fe00000 60000000 60000000 60000000 
> [ 2547.663056] 0fe00000 60000000 60000000 60000000 <0fe00000> 60000000 60000000 60000000 
> [ 2547.663062] ---[ end trace 0000000000000000 ]---
> [ 2547.663075] XFS (dm-0): Unmounting Filesystem
> [ 2547.679882] XFS (dm-0): Mounting V5 Filesystem
> [ 2547.733927] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2547.745633] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2547.748178] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2549.753836] iomap_finish_ioend: 43 callbacks suppressed
> [ 2549.753839] dm-0: writeback error on inode 103859326, offset 65249280, sector 66209096
> [ 2549.753854] dm-0: writeback error on inode 36109178, offset 6733824, sector 24398488
> [ 2549.753859] dm-0: writeback error on inode 70328836, offset 1802240, sector 45162048
> [ 2549.753863] dm-0: writeback error on inode 36480701, offset 108093440, sector 24428192
> [ 2549.753869] dm-0: writeback error on inode 69618107, offset 22708224, sector 45250888
> [ 2549.753873] dm-0: writeback error on inode 36521924, offset 104202240, sector 24543472
> [ 2549.753877] dm-0: writeback error on inode 36521924, offset 170885120, sector 24541200
> [ 2549.753881] dm-0: writeback error on inode 70357590, offset 3289088, sector 45331584
> [ 2549.753885] dm-0: writeback error on inode 103289852, offset 1003520, sector 66297216
> [ 2549.754924] XFS (dm-0): log I/O error -5
> [ 2549.754950] XFS (dm-0): log I/O error -5
> [ 2549.754940] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2549.755035] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2549.756230] buffer_io_error: 38 callbacks suppressed
> [ 2549.756233] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2549.756242] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2549.756246] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2549.756249] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2549.756252] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2549.756255] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2549.756259] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2549.756262] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2549.756265] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2549.756268] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2550.021468] XFS (dm-0): Unmounting Filesystem
> [ 2550.080673] XFS (dm-0): Mounting V5 Filesystem
> [ 2550.270646] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2550.760973] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2550.762099] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2551.767871] dm-0: writeback error on inode 70406127, offset 124911616, sector 45548040
> [ 2551.767885] XFS (dm-0): log I/O error -5
> [ 2551.768068] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2551.768140] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2552.001984] XFS (dm-0): Unmounting Filesystem
> [ 2552.033560] XFS (dm-0): Mounting V5 Filesystem
> [ 2552.202493] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2552.629573] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2552.630476] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2554.636725] XFS (dm-0): log I/O error -5
> [ 2554.636740] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2554.636803] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2554.906255] XFS (dm-0): Unmounting Filesystem
> [ 2554.964125] XFS (dm-0): Mounting V5 Filesystem
> [ 2555.118190] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2555.480176] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2555.481202] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2556.487342] XFS (dm-0): log I/O error -5
> [ 2556.487360] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2556.487423] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2556.487427] XFS (dm-0): log I/O error -5
> [ 2556.487429] XFS (dm-0): log I/O error -5
> [ 2556.487431] XFS (dm-0): log I/O error -5
> [ 2556.489554] buffer_io_error: 38 callbacks suppressed
> [ 2556.489556] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2556.489565] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2556.489569] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2556.489572] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2556.489575] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2556.489579] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2556.489582] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2556.489585] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2556.489588] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2556.489591] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2556.722895] XFS (dm-0): Unmounting Filesystem
> [ 2556.781571] XFS (dm-0): Mounting V5 Filesystem
> [ 2556.962599] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2557.386041] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2557.387016] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2558.400557] iomap_finish_ioend: 41 callbacks suppressed
> [ 2558.400560] dm-0: writeback error on inode 104621403, offset 393216, sector 66985016
> [ 2558.400788] dm-0: writeback error on inode 2973309, offset 3555328, sector 4043448
> [ 2558.400797] dm-0: writeback error on inode 3532245, offset 27906048, sector 4008328
> [ 2558.400802] dm-0: writeback error on inode 104656344, offset 114626560, sector 66996824
> [ 2558.400808] dm-0: writeback error on inode 104621424, offset 77824, sector 66916624
> [ 2558.400872] XFS (dm-0): log I/O error -5
> [ 2558.400880] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2558.400967] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2558.625070] XFS (dm-0): Unmounting Filesystem
> [ 2558.672009] XFS (dm-0): Mounting V5 Filesystem
> [ 2558.811196] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2559.196329] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2559.197243] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2559.202340] XFS (dm-0): log I/O error -5
> [ 2559.202345] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x3f19480 len 32 error 5
> [ 2559.202361] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2559.202420] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2559.432336] XFS (dm-0): Unmounting Filesystem
> [ 2559.449047] XFS (dm-0): Mounting V5 Filesystem
> [ 2559.490582] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2559.499664] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2559.501334] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2561.508579] buffer_io_error: 38 callbacks suppressed
> [ 2561.508582] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2561.508599] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2561.508603] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2561.508606] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2561.508609] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2561.508613] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2561.508615] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2561.508619] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2561.508622] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2561.508625] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2561.512702] dm-0: writeback error on inode 104703262, offset 147324928, sector 67200392
> [ 2561.523022] dm-0: writeback error on inode 37886195, offset 131072, sector 25502904
> [ 2561.550302] XFS (dm-0): log I/O error -5
> [ 2561.550316] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2561.550376] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2561.550380] XFS (dm-0): log I/O error -5
> [ 2561.550382] XFS (dm-0): log I/O error -5
> [ 2561.550384] XFS (dm-0): log I/O error -5
> [ 2561.789009] XFS (dm-0): Unmounting Filesystem
> [ 2561.873689] XFS (dm-0): Mounting V5 Filesystem
> [ 2562.009743] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2562.358919] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2562.359856] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2564.370069] dm-0: writeback error on inode 102464293, offset 2129920, sector 67036960
> [ 2564.370076] dm-0: writeback error on inode 37987634, offset 62914560, sector 25414248
> [ 2564.370102] dm-0: writeback error on inode 37987634, offset 128565248, sector 25743352
> [ 2564.370113] dm-0: writeback error on inode 4143566, offset 1355776, sector 4470760
> [ 2564.370119] dm-0: writeback error on inode 37386218, offset 1511424, sector 25184776
> [ 2564.370125] dm-0: writeback error on inode 71426166, offset 44986368, sector 46349904
> [ 2564.370130] dm-0: writeback error on inode 4233901, offset 22544384, sector 4480616
> [ 2564.370135] dm-0: writeback error on inode 37935212, offset 44507136, sector 25651960
> [ 2564.370141] dm-0: writeback error on inode 105027811, offset 581632, sector 67474168
> [ 2564.370147] dm-0: writeback error on inode 37886177, offset 34197504, sector 25582624
> [ 2564.370451] XFS (dm-0): log I/O error -5
> [ 2564.370460] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2564.370521] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2564.603752] XFS (dm-0): Unmounting Filesystem
> [ 2564.668356] XFS (dm-0): Mounting V5 Filesystem
> [ 2564.815810] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2565.223316] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2565.224235] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2567.231741] buffer_io_error: 22 callbacks suppressed
> [ 2567.231744] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2567.231762] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2567.231765] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2567.231768] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2567.231772] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2567.231775] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2567.231778] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2567.231781] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2567.231785] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2567.231788] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2567.442435] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x1c10 len 8 error 5
> [ 2567.446460] XFS (dm-0): log I/O error -5
> [ 2567.446469] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2567.446526] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2567.469623] XFS (dm-0): Unmounting Filesystem
> [ 2567.469653] XFS (dm-0): Failing async write on buffer block 0x421c00. Retrying async write.
> [ 2567.469660] XFS (dm-0): Failing async write on buffer block 0x421bd8. Retrying async write.
> [ 2567.469663] XFS (dm-0): Failing async write on buffer block 0x2c47ac8. Retrying async write.
> [ 2567.469666] XFS (dm-0): Failing async write on buffer block 0x3db7618. Retrying async write.
> [ 2567.469669] XFS (dm-0): Failing async write on buffer block 0x3d39bc0. Retrying async write.
> [ 2567.469672] XFS (dm-0): Failing async write on buffer block 0x3d39c00. Retrying async write.
> [ 2567.469675] XFS (dm-0): Failing async write on buffer block 0x2c46c70. Retrying async write.
> [ 2567.469679] XFS (dm-0): Failing async write on buffer block 0x1724220. Retrying async write.
> [ 2567.469683] XFS (dm-0): Failing async write on buffer block 0x3d39c08. Retrying async write.
> [ 2567.605306] XFS (dm-0): Mounting V5 Filesystem
> [ 2567.778964] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2568.250498] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2568.251454] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2570.257461] iomap_finish_ioend: 93 callbacks suppressed
> [ 2570.257465] dm-0: writeback error on inode 71736329, offset 557056, sector 46797816
> [ 2570.277368] dm-0: writeback error on inode 101747424, offset 798720, sector 4883144
> [ 2570.277386] dm-0: writeback error on inode 4112654, offset 65536, sector 4765656
> [ 2570.277392] dm-0: writeback error on inode 71576811, offset 24985600, sector 46689208
> [ 2570.277397] dm-0: writeback error on inode 71596503, offset 56389632, sector 46663520
> [ 2570.277403] dm-0: writeback error on inode 71596485, offset 70684672, sector 46728408
> [ 2570.277408] dm-0: writeback error on inode 105195353, offset 671744, sector 67776440
> [ 2570.277414] dm-0: writeback error on inode 71399352, offset 10092544, sector 46274472
> [ 2570.277419] dm-0: writeback error on inode 71399352, offset 34680832, sector 46800296
> [ 2570.277424] dm-0: writeback error on inode 4500080, offset 18259968, sector 4845360
> [ 2570.277599] XFS (dm-0): log I/O error -5
> [ 2570.277608] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2570.277680] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2570.509378] XFS (dm-0): Unmounting Filesystem
> [ 2570.565428] XFS (dm-0): Mounting V5 Filesystem
> [ 2570.757446] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2571.291433] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2571.292377] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2572.300294] buffer_io_error: 22 callbacks suppressed
> [ 2572.300297] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2572.300313] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2572.300317] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2572.300320] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2572.300323] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2572.300326] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2572.300329] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2572.300333] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2572.300336] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2572.300339] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2572.301248] XFS (dm-0): log I/O error -5
> [ 2572.301257] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2572.301329] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2572.524483] XFS (dm-0): Unmounting Filesystem
> [ 2572.561468] XFS (dm-0): Mounting V5 Filesystem
> [ 2572.702822] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2573.072094] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2573.073038] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2574.091592] XFS (dm-0): log I/O error -5
> [ 2574.091610] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2574.091672] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2574.332995] XFS (dm-0): Unmounting Filesystem
> [ 2574.368980] XFS (dm-0): Mounting V5 Filesystem
> [ 2574.511448] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2574.879902] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2574.880819] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2576.886825] iomap_finish_ioend: 23 callbacks suppressed
> [ 2576.886828] dm-0: writeback error on inode 5086277, offset 23314432, sector 5450480
> [ 2576.886844] dm-0: writeback error on inode 71905642, offset 63766528, sector 47007200
> [ 2576.886849] dm-0: writeback error on inode 38936684, offset 585728, sector 26394984
> [ 2576.886853] dm-0: writeback error on inode 71399332, offset 18481152, sector 47024616
> [ 2576.886858] dm-0: writeback error on inode 105806417, offset 839680, sector 68139328
> [ 2576.886863] dm-0: writeback error on inode 72124624, offset 13430784, sector 47057936
> [ 2576.886867] dm-0: writeback error on inode 72081362, offset 110592, sector 46913208
> [ 2576.886872] dm-0: writeback error on inode 3290291, offset 20537344, sector 5361800
> [ 2576.886876] dm-0: writeback error on inode 5270796, offset 569344, sector 5267992
> [ 2576.886880] dm-0: writeback error on inode 38888467, offset 1638400, sector 26450008
> [ 2576.886995] XFS (dm-0): log I/O error -5
> [ 2576.887009] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2576.887116] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2577.128229] XFS (dm-0): Unmounting Filesystem
> [ 2577.165577] XFS (dm-0): Mounting V5 Filesystem
> [ 2577.305996] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2577.711552] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2577.712499] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2577.717746] XFS (dm-0): log I/O error -5
> [ 2577.717743] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x13ffe18 len 8 error 5
> [ 2577.717749] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x3bffa18 len 8 error 5
> [ 2577.717755] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x1c10 len 8 error 5
> [ 2577.717797] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2577.717899] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2577.720017] buffer_io_error: 38 callbacks suppressed
> [ 2577.720019] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2577.720031] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2577.720035] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2577.720038] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2577.720042] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2577.720045] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2577.720048] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2577.720051] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2577.720054] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2577.720057] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2577.963247] XFS (dm-0): Unmounting Filesystem
> [ 2577.980236] XFS (dm-0): Mounting V5 Filesystem
> [ 2578.029315] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2578.040983] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2578.042968] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2580.048771] XFS (dm-0): log I/O error -5
> [ 2580.048789] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2580.048851] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2580.048855] XFS (dm-0): log I/O error -5
> [ 2580.048857] XFS (dm-0): log I/O error -5
> [ 2580.048860] XFS (dm-0): log I/O error -5
> [ 2580.048862] XFS (dm-0): log I/O error -5
> [ 2580.261156] XFS (dm-0): Unmounting Filesystem
> [ 2580.317309] XFS (dm-0): Mounting V5 Filesystem
> [ 2580.524344] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2581.064911] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2581.066023] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2582.071952] iomap_finish_ioend: 11 callbacks suppressed
> [ 2582.071956] dm-0: writeback error on inode 39381706, offset 417792, sector 26804152
> [ 2582.072263] dm-0: writeback error on inode 71802791, offset 50212864, sector 46680008
> [ 2582.072837] dm-0: writeback error on inode 104258031, offset 27787264, sector 68423688
> [ 2582.072956] dm-0: writeback error on inode 71802753, offset 3035136, sector 47233248
> [ 2582.073108] dm-0: writeback error on inode 105687197, offset 262144, sector 67937776
> [ 2582.073118] dm-0: writeback error on inode 105687197, offset 19116032, sector 68428184
> [ 2582.073126] dm-0: writeback error on inode 5290517, offset 897024, sector 5292776
> [ 2582.073134] dm-0: writeback error on inode 105828662, offset 162582528, sector 47243656
> [ 2582.073141] dm-0: writeback error on inode 5275003, offset 4661248, sector 5660280
> [ 2582.073149] dm-0: writeback error on inode 104258031, offset 54648832, sector 68428352
> [ 2582.073301] XFS (dm-0): log I/O error -5
> [ 2582.073312] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2582.073422] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2582.329214] XFS (dm-0): Unmounting Filesystem
> [ 2582.417520] XFS (dm-0): Mounting V5 Filesystem
> [ 2582.553350] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2582.842465] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2582.843363] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2584.848950] XFS (dm-0): log I/O error -5
> [ 2584.848969] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2584.849030] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2584.849033] XFS (dm-0): log I/O error -5
> [ 2584.849036] XFS (dm-0): log I/O error -5
> [ 2584.849038] XFS (dm-0): log I/O error -5
> [ 2584.849040] XFS (dm-0): log I/O error -5
> [ 2584.851337] buffer_io_error: 38 callbacks suppressed
> [ 2584.851340] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2584.851351] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2584.851355] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2584.851358] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2584.851362] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2584.851365] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2584.851368] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2584.851371] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2584.851374] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2584.851377] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2585.125926] XFS (dm-0): Unmounting Filesystem
> [ 2585.165412] XFS (dm-0): Mounting V5 Filesystem
> [ 2585.354102] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2585.860897] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2585.861828] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2586.870178] XFS (dm-0): log I/O error -5
> [ 2586.870200] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2586.870286] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2587.095054] XFS (dm-0): Unmounting Filesystem
> [ 2587.134976] XFS (dm-0): Mounting V5 Filesystem
> [ 2587.275993] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2587.537406] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2587.538293] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2587.543301] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x1415598 len 8 error 5
> [ 2587.543302] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2587.543303] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x3bffa18 len 8 error 5
> [ 2587.543299] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x40f09c0 len 32 error 5
> [ 2587.543358] XFS (dm-0): page discard on page 000000008449fa28, inode 0x64c7ea4, pos 589824.
> [ 2587.543371] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2587.543429] XFS (dm-0): log I/O error -5
> [ 2587.543450] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2587.543514] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2587.744847] XFS (dm-0): Unmounting Filesystem
> [ 2587.814615] XFS (dm-0): Mounting V5 Filesystem
> [ 2587.844735] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2587.853639] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2587.855380] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2588.861351] iomap_finish_ioend: 17 callbacks suppressed
> [ 2588.861355] dm-0: writeback error on inode 5669593, offset 1048576, sector 27217304
> [ 2588.861747] dm-0: writeback error on inode 72173797, offset 655360, sector 47498000
> [ 2588.863767] dm-0: writeback error on inode 5686085, offset 81920, sector 5856320
> [ 2588.864118] XFS (dm-0): log I/O error -5
> [ 2588.864129] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2588.864192] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2589.087112] XFS (dm-0): Unmounting Filesystem
> [ 2589.126196] XFS (dm-0): Mounting V5 Filesystem
> [ 2589.256674] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2589.542959] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2589.544017] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2590.551430] buffer_io_error: 54 callbacks suppressed
> [ 2590.551434] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2590.551450] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2590.551454] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2590.551457] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2590.551461] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2590.551464] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2590.551467] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2590.551470] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2590.551473] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2590.551476] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2590.776047] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2590.777568] dm-0: writeback error on inode 39082395, offset 2023424, sector 26498480
> [ 2590.777572] dm-0: writeback error on inode 4054818, offset 58073088, sector 5992088
> [ 2590.777578] dm-0: writeback error on inode 4054818, offset 173793280, sector 5998104
> [ 2590.777583] dm-0: writeback error on inode 4054818, offset 178622464, sector 5999312
> [ 2590.777587] dm-0: writeback error on inode 39629723, offset 909312, sector 27047544
> [ 2590.777592] dm-0: writeback error on inode 5686139, offset 26587136, sector 6010928
> [ 2590.777596] dm-0: writeback error on inode 72492761, offset 217088, sector 47563032
> [ 2590.777692] XFS (dm-0): log I/O error -5
> [ 2590.777699] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2590.777757] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2590.803098] XFS (dm-0): Unmounting Filesystem
> [ 2590.803127] XFS (dm-0): Failing async write on buffer block 0x4b0. Retrying async write.
> [ 2590.803136] XFS (dm-0): Failing async write on buffer block 0x171cf30. Retrying async write.
> [ 2590.803140] XFS (dm-0): Failing async write on buffer block 0x171d098. Retrying async write.
> [ 2590.803143] XFS (dm-0): Failing async write on buffer block 0x13ffe28. Retrying async write.
> [ 2590.803147] XFS (dm-0): Failing async write on buffer block 0x13ffe20. Retrying async write.
> [ 2590.803151] XFS (dm-0): Failing async write on buffer block 0x50. Retrying async write.
> [ 2590.803155] XFS (dm-0): Failing async write on buffer block 0x18. Retrying async write.
> [ 2590.803158] XFS (dm-0): Failing async write on buffer block 0x28. Retrying async write.
> [ 2590.803161] XFS (dm-0): Failing async write on buffer block 0x20. Retrying async write.
> [ 2590.898854] XFS (dm-0): Mounting V5 Filesystem
> [ 2591.015030] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2591.269532] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2591.270553] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2592.278892] XFS (dm-0): log I/O error -5
> [ 2592.278909] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2592.279024] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2592.534075] XFS (dm-0): Unmounting Filesystem
> [ 2592.573250] XFS (dm-0): Mounting V5 Filesystem
> [ 2592.700931] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2593.029802] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2593.030847] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2594.233003] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2594.233514] iomap_finish_ioend: 21 callbacks suppressed
> [ 2594.233516] dm-0: writeback error on inode 38125892, offset 651264, sector 27377000
> [ 2594.233526] dm-0: writeback error on inode 36841118, offset 83578880, sector 27377256
> [ 2594.233533] dm-0: writeback error on inode 3267698, offset 7778304, sector 6173120
> [ 2594.233540] dm-0: writeback error on inode 38125940, offset 524288, sector 27335560
> [ 2594.233546] dm-0: writeback error on inode 38125940, offset 1290240, sector 27335264
> [ 2594.233553] dm-0: writeback error on inode 3267673, offset 74072064, sector 6173256
> [ 2594.233677] XFS (dm-0): log I/O error -5
> [ 2594.233688] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2594.233789] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2594.250213] XFS (dm-0): Failing async write on buffer block 0x1869620. Retrying async write.
> [ 2594.250220] XFS (dm-0): Failing async write on buffer block 0x1869600. Retrying async write.
> [ 2594.259160] XFS (dm-0): Unmounting Filesystem
> [ 2594.259192] XFS (dm-0): Failing async write on buffer block 0x4b0. Retrying async write.
> [ 2594.259197] XFS (dm-0): Failing async write on buffer block 0x40a8590. Retrying async write.
> [ 2594.259201] XFS (dm-0): Failing async write on buffer block 0x50. Retrying async write.
> [ 2594.259205] XFS (dm-0): Failing async write on buffer block 0x19cb4a8. Retrying async write.
> [ 2594.259212] XFS (dm-0): Failing async write on buffer block 0x598438. Retrying async write.
> [ 2594.259215] XFS (dm-0): Failing async write on buffer block 0x2d560a0. Retrying async write.
> [ 2594.259221] XFS (dm-0): Failing async write on buffer block 0x14020b0. Retrying async write.
> [ 2594.358902] XFS (dm-0): Mounting V5 Filesystem
> [ 2594.463445] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2594.706900] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2594.707815] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2596.713662] dm-0: writeback error on inode 6257128, offset 716800, sector 6320832
> [ 2596.713668] dm-0: writeback error on inode 3509159, offset 10272768, sector 3534256
> [ 2596.713682] dm-0: writeback error on inode 105936492, offset 1105920, sector 68385744
> [ 2596.713687] dm-0: writeback error on inode 72828680, offset 1441792, sector 47710184
> [ 2596.713805] XFS (dm-0): log I/O error -5
> [ 2596.713816] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2596.713888] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2596.716177] buffer_io_error: 38 callbacks suppressed
> [ 2596.716179] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2596.716188] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2596.716191] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2596.716195] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2596.716198] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2596.716201] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2596.716204] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2596.716207] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2596.716210] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2596.716213] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2596.944807] XFS (dm-0): Unmounting Filesystem
> [ 2596.987515] XFS (dm-0): Mounting V5 Filesystem
> [ 2597.146921] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2597.506121] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2597.507036] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2598.694283] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x20 len 8 error 5
> [ 2598.695795] XFS (dm-0): log I/O error -5
> [ 2598.695803] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2598.695860] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2598.695864] XFS (dm-0): log I/O error -5
> [ 2598.695866] XFS (dm-0): log I/O error -5
> [ 2598.695868] XFS (dm-0): log I/O error -5
> [ 2598.695870] XFS (dm-0): log I/O error -5
> [ 2598.721263] XFS (dm-0): Unmounting Filesystem
> [ 2598.721294] XFS (dm-0): Failing async write on buffer block 0x4b0. Retrying async write.
> [ 2598.721301] XFS (dm-0): Failing async write on buffer block 0x14082c0. Retrying async write.
> [ 2598.721305] XFS (dm-0): Failing async write on buffer block 0x1402cf8. Retrying async write.
> [ 2598.721308] XFS (dm-0): Failing async write on buffer block 0x3c01d80. Retrying async write.
> [ 2598.721311] XFS (dm-0): Failing async write on buffer block 0x3c032d0. Retrying async write.
> [ 2598.721314] XFS (dm-0): Failing async write on buffer block 0x1869810. Retrying async write.
> [ 2598.721317] XFS (dm-0): Failing async write on buffer block 0x3c03808. Retrying async write.
> [ 2598.721320] XFS (dm-0): Failing async write on buffer block 0x4092918. Retrying async write.
> [ 2598.721324] XFS (dm-0): Failing async write on buffer block 0x680. Retrying async write.
> [ 2598.819903] XFS (dm-0): Mounting V5 Filesystem
> [ 2598.926017] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2599.185692] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2599.186561] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2599.232676] XFS (dm-0): log I/O error -5
> [ 2599.232679] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2599.232679] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x358b80 len 32 error 5
> [ 2599.232693] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2599.232755] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2599.463847] XFS (dm-0): Unmounting Filesystem
> [ 2599.480839] XFS (dm-0): Mounting V5 Filesystem
> [ 2599.512736] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2599.520518] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2599.522021] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2601.544049] iomap_finish_ioend: 13 callbacks suppressed
> [ 2601.544052] dm-0: writeback error on inode 6344500, offset 77398016, sector 6522176
> [ 2601.693208] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x20 len 8 error 5
> [ 2601.695457] dm-0: writeback error on inode 73002350, offset 69632, sector 47941664
> [ 2601.695637] dm-0: writeback error on inode 73002350, offset 180224, sector 47943056
> [ 2601.695645] dm-0: writeback error on inode 6211174, offset 1847296, sector 6452984
> [ 2601.695649] dm-0: writeback error on inode 72952535, offset 57147392, sector 47919256
> [ 2601.695653] dm-0: writeback error on inode 72967749, offset 46862336, sector 47943344
> [ 2601.695657] dm-0: writeback error on inode 106150432, offset 524288, sector 68803664
> [ 2601.695661] dm-0: writeback error on inode 106150432, offset 17850368, sector 69367752
> [ 2601.695665] dm-0: writeback error on inode 106502774, offset 84537344, sector 69368088
> [ 2601.695670] dm-0: writeback error on inode 6447171, offset 106463232, sector 6626344
> [ 2601.695792] XFS (dm-0): log I/O error -5
> [ 2601.695799] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2601.695857] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2601.725357] XFS (dm-0): Unmounting Filesystem
> [ 2601.725391] XFS (dm-0): Failing async write on buffer block 0x2d96240. Retrying async write.
> [ 2601.725396] XFS (dm-0): Failing async write on buffer block 0x3fca268. Retrying async write.
> [ 2601.725401] XFS (dm-0): Failing async write on buffer block 0x41f6820. Retrying async write.
> [ 2601.725404] XFS (dm-0): Failing async write on buffer block 0x41f6800. Retrying async write.
> [ 2601.725407] XFS (dm-0): Failing async write on buffer block 0x623aa0. Retrying async write.
> [ 2601.725410] XFS (dm-0): Failing async write on buffer block 0x623a80. Retrying async write.
> [ 2601.725413] XFS (dm-0): Failing async write on buffer block 0x280a380. Retrying async write.
> [ 2601.725416] XFS (dm-0): Failing async write on buffer block 0x2d96280. Retrying async write.
> [ 2601.725419] XFS (dm-0): Failing async write on buffer block 0x196c938. Retrying async write.
> [ 2601.880399] XFS (dm-0): Mounting V5 Filesystem
> [ 2602.048576] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2602.486670] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2602.487581] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2603.494852] buffer_io_error: 54 callbacks suppressed
> [ 2603.494855] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2603.494873] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2603.494877] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2603.494880] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2603.494883] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2603.494887] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2603.494889] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2603.494893] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2603.494896] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2603.494899] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2603.721652] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2603.723184] XFS (dm-0): log I/O error -5
> [ 2603.723194] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2603.723276] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2603.750782] XFS (dm-0): Unmounting Filesystem
> [ 2603.750814] XFS (dm-0): Failing async write on buffer block 0x4b0. Retrying async write.
> [ 2603.750820] XFS (dm-0): Failing async write on buffer block 0x1920760. Retrying async write.
> [ 2603.750823] XFS (dm-0): Failing async write on buffer block 0x3c02ea0. Retrying async write.
> [ 2603.750827] XFS (dm-0): Failing async write on buffer block 0x14020b0. Retrying async write.
> [ 2603.750840] XFS (dm-0): Failing async write on buffer block 0x41bb2a0. Retrying async write.
> [ 2603.750844] XFS (dm-0): Failing async write on buffer block 0x14155a0. Retrying async write.
> [ 2603.750847] XFS (dm-0): Failing async write on buffer block 0x13ffe20. Retrying async write.
> [ 2603.750850] XFS (dm-0): Failing async write on buffer block 0x3c01d80. Retrying async write.
> [ 2603.750859] XFS (dm-0): Failing async write on buffer block 0x42058e0. Retrying async write.
> [ 2603.911355] XFS (dm-0): Mounting V5 Filesystem
> [ 2604.039283] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2604.316945] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2604.317844] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2604.322964] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c07f78 len 8 error 5
> [ 2604.322964] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.323032] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.323042] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c07f78 len 8 error 5
> [ 2604.323088] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.323104] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c07f78 len 8 error 5
> [ 2604.323138] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.323169] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c07f78 len 8 error 5
> [ 2604.323188] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.323247] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2604.324979] XFS (dm-0): log I/O error -5
> [ 2604.324999] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2604.325082] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2604.554164] XFS (dm-0): Unmounting Filesystem
> [ 2604.571381] XFS (dm-0): Mounting V5 Filesystem
> [ 2604.613536] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2604.620050] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2604.621596] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2604.627298] XFS (dm-0): log I/O error -5
> [ 2604.627307] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x1869600 len 32 error 5
> [ 2604.627334] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2604.627438] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2604.813933] XFS (dm-0): Unmounting Filesystem
> [ 2604.830589] XFS (dm-0): Mounting V5 Filesystem
> [ 2604.875920] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2604.884974] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2604.886426] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2604.932799] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x174bee0 len 32 error 5
> [ 2604.932802] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x49a920 len 32 error 5
> [ 2604.932803] XFS (dm-0): metadata I/O error in "xfs_btree_read_buf_block.constprop.29+0xd0/0x110 [xfs]" at daddr 0x3bffa30 len 8 error 5
> [ 2604.932900] XFS (dm-0): log I/O error -5
> [ 2604.932915] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2604.932974] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2605.164824] XFS (dm-0): Unmounting Filesystem
> [ 2605.181637] XFS (dm-0): Mounting V5 Filesystem
> [ 2605.225897] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2605.232410] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2605.234452] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2607.239943] iomap_finish_ioend: 40 callbacks suppressed
> [ 2607.239946] dm-0: writeback error on inode 40220526, offset 31604736, sector 27637824
> [ 2607.239960] dm-0: writeback error on inode 40021920, offset 29814784, sector 27875352
> [ 2607.239965] dm-0: writeback error on inode 104667118, offset 105447424, sector 69504936
> [ 2607.239969] dm-0: writeback error on inode 104667118, offset 171417600, sector 69614576
> [ 2607.239974] dm-0: writeback error on inode 6344484, offset 25358336, sector 6857952
> [ 2607.240036] XFS (dm-0): log I/O error -5
> [ 2607.240049] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2607.240137] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2607.515399] XFS (dm-0): Unmounting Filesystem
> [ 2607.560484] XFS (dm-0): Mounting V5 Filesystem
> [ 2607.709693] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2608.076848] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2608.077772] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2608.082680] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x1404e80 len 8 error 5
> [ 2608.082679] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c060a8 len 8 error 5
> [ 2608.082679] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x49a920 len 32 error 5
> [ 2608.082680] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x3c07f78 len 8 error 5
> [ 2608.082758] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x1404e80 len 8 error 5
> [ 2608.082810] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x1404e80 len 8 error 5
> [ 2608.082862] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x1404e80 len 8 error 5
> [ 2608.082882] XFS (dm-0): metadata I/O error in "xfs_alloc_read_agfl+0x88/0xf0 [xfs]" at daddr 0x18 len 8 error 5
> [ 2608.082962] XFS (dm-0): log I/O error -5
> [ 2608.082977] XFS (dm-0): Metadata I/O Error (0x1) detected at xfs_trans_read_buf_map+0x31c/0x368 [xfs] (fs/xfs/xfs_trans_buf.c:296).  Shutting down filesystem.
> [ 2608.083049] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2608.083059] XFS (dm-0): xfs_imap_lookup: xfs_ialloc_read_agi() returned error -5, agno 0
> [ 2608.283930] XFS (dm-0): Unmounting Filesystem
> [ 2608.301209] XFS (dm-0): Mounting V5 Filesystem
> [ 2608.359920] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2608.370818] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2608.372848] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2608.377740] XFS (dm-0): log I/O error -5
> [ 2608.377743] XFS (dm-0): metadata I/O error in "xfs_da_read_buf+0x12c/0x1a0 [xfs]" at daddr 0x1404288 len 8 error 5
> [ 2608.377745] XFS (dm-0): metadata I/O error in "xfs_imap_to_bp+0x64/0x98 [xfs]" at daddr 0x3fc5f60 len 32 error 5
> [ 2608.377761] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2608.377823] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2608.603843] XFS (dm-0): Unmounting Filesystem
> [ 2608.620761] XFS (dm-0): Mounting V5 Filesystem
> [ 2608.682744] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2608.695059] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2608.696923] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2609.704216] buffer_io_error: 102 callbacks suppressed
> [ 2609.704219] Buffer I/O error on dev dm-0, logical block 10485488, async page read
> [ 2609.704235] Buffer I/O error on dev dm-0, logical block 10485489, async page read
> [ 2609.704239] Buffer I/O error on dev dm-0, logical block 10485490, async page read
> [ 2609.704242] Buffer I/O error on dev dm-0, logical block 10485491, async page read
> [ 2609.704246] Buffer I/O error on dev dm-0, logical block 10485492, async page read
> [ 2609.704249] Buffer I/O error on dev dm-0, logical block 10485493, async page read
> [ 2609.704252] Buffer I/O error on dev dm-0, logical block 10485494, async page read
> [ 2609.704255] Buffer I/O error on dev dm-0, logical block 10485495, async page read
> [ 2609.704258] Buffer I/O error on dev dm-0, logical block 10485496, async page read
> [ 2609.704261] Buffer I/O error on dev dm-0, logical block 10485497, async page read
> [ 2609.704971] dm-0: writeback error on inode 73088154, offset 87687168, sector 48133584
> [ 2609.868626] XFS (dm-0): metadata I/O error in "xfs_buf_ioend+0x310/0x6c0 [xfs]" at daddr 0x48 len 8 error 5
> [ 2609.869085] dm-0: writeback error on inode 40295105, offset 1048576, sector 27860880
> [ 2609.869194] dm-0: writeback error on inode 106528698, offset 983040, sector 68387864
> [ 2609.869443] dm-0: writeback error on inode 40295105, offset 479232, sector 27704168
> [ 2609.869452] dm-0: writeback error on inode 39669888, offset 46268416, sector 28022120
> [ 2609.869639] XFS (dm-0): log I/O error -5
> [ 2609.869650] XFS (dm-0): Log I/O Error (0x2) detected at xlog_ioend_work+0xb4/0x100 [xfs] (fs/xfs/xfs_log.c:1377).  Shutting down filesystem.
> [ 2609.869750] XFS (dm-0): Please unmount the filesystem and rectify the problem(s)
> [ 2609.897807] XFS (dm-0): Unmounting Filesystem
> [ 2609.897839] XFS (dm-0): Failing async write on buffer block 0x4b0. Retrying async write.
> [ 2609.897851] XFS (dm-0): Failing async write on buffer block 0x1404c08. Retrying async write.
> [ 2609.897855] XFS (dm-0): Failing async write on buffer block 0x17ced58. Retrying async write.
> [ 2609.897860] XFS (dm-0): Failing async write on buffer block 0x1402cf8. Retrying async write.
> [ 2609.897863] XFS (dm-0): Failing async write on buffer block 0x5937e8. Retrying async write.
> [ 2609.897866] XFS (dm-0): Failing async write on buffer block 0x680. Retrying async write.
> [ 2609.897882] XFS (dm-0): Failing async write on buffer block 0x657400. Retrying async write.
> [ 2609.897886] XFS (dm-0): Failing async write on buffer block 0x689620. Retrying async write.
> [ 2609.897888] XFS (dm-0): Failing async write on buffer block 0x689600. Retrying async write.
> [ 2610.051099] XFS (dm-0): Mounting V5 Filesystem
> [ 2610.163869] XFS (dm-0): Starting recovery (logdev: internal)
> [ 2610.426613] XFS (dm-0): Ending recovery (logdev: internal)
> [ 2610.427541] xfs filesystem being mounted at /mnt/scratch supports timestamps until 2038 (0x7fffffff)
> [ 2610.435505] XFS (dm-0): Unmounting Filesystem
> [ 2610.546863] XFS (sdb1): Unmounting Filesystem
> [ 2611.152679] run fstests generic/476 at 2022-02-15 15:43:38

