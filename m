Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D28505E0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347440AbiDRSqy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Apr 2022 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347448AbiDRSqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:46:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878D52E697;
        Mon, 18 Apr 2022 11:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18596B80EDE;
        Mon, 18 Apr 2022 18:44:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DEBC385A7;
        Mon, 18 Apr 2022 18:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650307449;
        bh=ONuB1xgwuH8BOLKmPjwdW4pIY5gBPxI0R3sSTgBLapE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLus1Nh1IHeAiccoC52Il8kCC/XjpNtO6eYrU7pIkIe52vrDR3iUPQNZdEGvg8kV8
         raNthDctfgqVlzCKmXS/U5eL+LgaxPvboKh8/1Laao09BEUyNZQKH812PwgJomALIt
         Z+CteRwXienOvfZGzbPibYAJGSOFdq/ZRXIY0OSR4VKBlX8IknzXSbwgJnv0g2CddW
         c746ZHhprV1CROiwam4yCgmZtWZY7whIpvTgUyfoT58Cv0SXb19ZDd6j9C4DfUwcB/
         VuvM1DmB0QvREsklQZ60+g9C+ZR3ZW8C91SgBimk49C0VM01lV1fE1yxcPSFZZrtoR
         Q71vawHa0vEcg==
Date:   Mon, 18 Apr 2022 11:44:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220418184409.GG17025@magnolia>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220413162351.GA205970@magnolia>
 <Ylb707Ci5oiurdXr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylb707Ci5oiurdXr@casper.infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 05:35:31PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 13, 2022 at 09:23:51AM -0700, Darrick J. Wong wrote:
> > On Wed, Apr 13, 2022 at 03:50:32PM +0100, Matthew Wilcox wrote:
> > > On Tue, Apr 12, 2022 at 08:34:25PM -0700, Darrick J. Wong wrote:
> > > > Hmm.  Two nights in a row I've seen the following crash.  Has anyone
> > > > else seen this, or should I keep digging?  This is a fairly boring
> > > > x86_64 VM with a XFS v5 filesystem + rmapbt.
> > > 
> > > I have not seen this before.  I test with:
> > > MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc
> > > 
> > > Maybe I should try a 4096 byte block size.
> > > 
> > > > mm/filemap.c:1653 is the BUG in:
> > > > 
> > > > void folio_end_writeback(struct folio *folio)
> > > > {
> > > > 	/*
> > > > 	 * folio_test_clear_reclaim() could be used here but it is an
> > > > 	 * atomic operation and overkill in this particular case.
> > > > 	 * Failing to shuffle a folio marked for immediate reclaim is
> > > > 	 * too mild a gain to justify taking an atomic operation penalty
> > > > 	 * at the end of every folio writeback.
> > > > 	 */
> > > > 	if (folio_test_reclaim(folio)) {
> > > > 		folio_clear_reclaim(folio);
> > > > 		folio_rotate_reclaimable(folio);
> > > > 	}
> > > > 
> > > > 	/*
> > > > 	 * Writeback does not hold a folio reference of its own, relying
> > > > 	 * on truncation to wait for the clearing of PG_writeback.
> > > > 	 * But here we must make sure that the folio is not freed and
> > > > 	 * reused before the folio_wake().
> > > > 	 */
> > > > 	folio_get(folio);
> > > > 	if (!__folio_end_writeback(folio))
> > > > >>>>		BUG();
> > > 
> > > Grr, that should have been a VM_BUG_ON_FOLIO(1, folio) so we get useful
> > > information about the folio (like whether it has an iop, or what order
> > > the folio is).  Can you make that change and try to reproduce?
> > > 
> > > What's going on here is that we've called folio_end_writeback() on a
> > > folio which does not have the writeback flag set.  That _should_ be
> > > impossible, hence the use of BUG().  Either we've called
> > > folio_end_writeback() twice on the same folio, or we neglected to set
> > > the writeback flag on the folio.  I don't immediately see why either
> > > of those two things would happen.
> > 
> > Ok, will do.
> > 
> > An ARM VM also tripped over this last night (64k pages, 4k fsblocksize)
> > and it had even more to say:
> > 
> > run fstests generic/068 at 2022-04-12 20:49:17
> > spectre-v4 mitigation disabled by command-line option
> > XFS (sda2): Mounting V5 Filesystem
> > XFS (sda2): Ending clean mount
> > XFS (sda3): Mounting V5 Filesystem
> > XFS (sda3): Ending clean mount
> > XFS (sda3): Quotacheck needed: Please wait.
> > XFS (sda3): Quotacheck: Done.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1214302 at fs/iomap/buffered-io.c:1020 iomap_finish_ioend+0x29c/0x37c
> > Modules linked in: dm_zero ext2 dm_delay xfs dm_snapshot ext4 mbcache jbd2 dm_log_writes dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink crct10dif_ce bfq ip6table_filter ip6_tables iptable_filter sch_fq_codel efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
> > CPU: 0 PID: 1214302 Comm: 0:4 Tainted: G        W         5.18.0-rc2-djwa #rc2 541bf598c49d4450e32c1bfc9b8fb32b7009548e
> > Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
> > Workqueue: xfs-conv/sda3 xfs_end_io [xfs]
> > pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> > pc : iomap_finish_ioend+0x29c/0x37c
> > lr : iomap_finish_ioend+0x19c/0x37c
> > sp : fffffe000f08fc20
> > x29: fffffe000f08fc20 x28: 0000000000040000 x27: 0000000000010000
> > x26: ffffffff00775040 x25: 0000000000000000 x24: 0000000000000001
> > x23: fffffc00e1014cc0 x22: fffffc01a44fac40 x21: 0000000000000000
> > x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
> > x17: 620000006b290000 x16: 4dae6b4802000000 x15: 0000000000000000
> > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > x11: 0000000000000000 x10: 0000000000001ae0 x9 : fffffe00088ebff4
> > x8 : fffffe01f6840000 x7 : fffffe0008fe92f0 x6 : 0000000000000387
> > x5 : 00000000f0000000 x4 : 0000000000000000 x3 : 0000000000010000
> > x2 : fffffc00e2623e80 x1 : 000000000000000d x0 : 0000000000000008
> > Call trace:
> >  iomap_finish_ioend+0x29c/0x37c
> >  iomap_finish_ioends+0x80/0x130
> >  xfs_end_ioend+0x68/0x164 [xfs ccff30bab1b631f6755d8bbcebc428122f4b51e0]
> >  xfs_end_io+0xcc/0x12c [xfs ccff30bab1b631f6755d8bbcebc428122f4b51e0]
> >  process_one_work+0x1e8/0x480
> >  worker_thread+0x7c/0x430
> >  kthread+0x108/0x114
> >  ret_from_fork+0x10/0x20
> > ---[ end trace 0000000000000000 ]---
> > ------------[ cut here ]------------
> > 
> > I tracked that assertion to:
> > 
> > static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
> > 		size_t len, int error)
> > {
> > 	struct iomap_page *iop = to_iomap_page(folio);
> > 
> > 	if (error) {
> > 		folio_set_error(folio);
> > 		mapping_set_error(inode->i_mapping, error);
> > 	}
> > 
> > >>>>	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
> 
> Oho, that's interesting.  I wonder if we have something that's stripping
> the iop off the folio while writes are in progress?  Although we should
> catch that:
> 
>         WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>         WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
>         WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>                         folio_test_uptodate(folio));

Hmm.  Today's splat looked like this:

run fstests xfs/313 at 2022-04-17 15:04:37
spectre-v4 mitigation disabled by command-line option
XFS (sda2): Mounting V5 Filesystem
XFS (sda2): Ending clean mount
XFS (sda3): Mounting V5 Filesystem
XFS (sda3): Ending clean mount
XFS (sda3): Quotacheck needed: Please wait.
XFS (sda3): Quotacheck: Done.
XFS (sda3): Unmounting Filesystem
XFS (sda3): Mounting V5 Filesystem
XFS (sda3): Ending clean mount
XFS (sda3): Quotacheck needed: Please wait.
XFS (sda3): Quotacheck: Done.
XFS (sda3): Injecting error (false) at file fs/xfs/libxfs/xfs_refcount.c, line 1162, on filesystem "sda3"
XFS (sda3): Corruption of in-memory data (0x8) detected at xfs_defer_finish_noroll+0x580/0x88c [xfs] (fs/xfs/libxfs/xfs_defer.c:533).  Shutting down filesystem.
XFS (sda3): Please unmount the filesystem and rectify the problem(s)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1670507 at fs/iomap/buffered-io.c:73 iomap_page_release+0x120/0x14c

I chased that down to:

static void iomap_page_release(struct folio *folio)
{
	struct iomap_page *iop = folio_detach_private(folio);
	struct inode *inode = folio->mapping->host;
	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);

	if (!iop)
		return;
	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>>>>	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
			folio_test_uptodate(folio));
	kfree(iop);
}

Modules linked in: dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq crct10dif_ce sch_fq_codel efivarfs ip_toverlay nfsv4
CPU: 0 PID: 1670507 Comm: xfs_io Not tainted 5.18.0-rc3-djwa #rc3 ec810768ab31b0e167ac04d847f3cdf695827dae
Hardware name: QEMU KVM Virtual Machine, BIOS 1.4.1 12/03/2020
pstate: 80401005 (Nzcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : iomap_page_release+0x120/0x14c
lr : iomap_page_release+0x24/0x14c
sp : fffffe00213af870
x29: fffffe00213af870 x28: fffffe00213afb78 x27: fffffe00213af9e8
x26: 000000000000000c x25: fffffc0105552ac0 x24: fffffc0105552c00
x23: 000000000000000c x22: 000000000000000c x21: fffffc00e3ffac00
x20: 0000000000000040 x19: ffffffff007cbc00 x18: 0000000000000030
x17: 656c626f72702065 x16: 6874207966697463 x15: 657220646e61206d
x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
x11: fffffe00213af470 x10: fffffe0001658ea0 x9 : fffffe000836b8c0
x8 : fffffc00f0ed8400 x7 : 00000000ffffffc0 x6 : 000000000038fc58
x5 : 00000000fffffffb x4 : fffffc01ff5ee480 x3 : fffffe00015a7d44
x2 : 0000000000000002 x1 : 0000000000010000 x0 : 0000000000020000
Call trace:
 iomap_page_release+0x120/0x14c
 iomap_invalidate_folio+0x138/0x1c4
 xfs_discard_folio+0xcc/0x26c [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 iomap_do_writepage+0x83c/0x980
 write_cache_pages+0x200/0x4a0
 iomap_writepages+0x38/0x60
 xfs_vm_writepages+0x98/0xe0 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 do_writepages+0x94/0x1d0
 filemap_fdatawrite_wbc+0x8c/0xc0
 file_write_and_wait_range+0xc0/0x100
 xfs_file_fsync+0x64/0x260 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 vfs_fsync_range+0x44/0x90
 do_fsync+0x44/0x90
 __arm64_sys_fsync+0x24/0x34
 invoke_syscall.constprop.0+0x58/0xf0
 do_el0_svc+0x5c/0x160
 el0_svc+0x3c/0x184
 el0t_64_sync_handler+0x1a8/0x1b0
 el0t_64_sync+0x18c/0x190
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1670507 at fs/iomap/buffered-io.c:1020 iomap_finish_ioend+0x3a4/0x550

And then this one is the same crash as last week:

static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
		size_t len, int error)
{
	struct iomap_page *iop = to_iomap_page(folio);

	if (error) {
		folio_set_error(folio);
		mapping_set_error(inode->i_mapping, error);
	}

>>>>	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
	VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop, folio);
	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);

	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
		folio_end_writeback(folio);
}

(Note that I added a VM_BUG_ON_FOLIO for fun!)

I think iomap_add_to_ioend created a bio for writeback, added a sub-page
block to the bio, and then the fs went down.

Unfortunately, iomap_writepage_map called ->map_blocks to schedule
writeback for the first block on the same page.  That fails because the
fs went down, so we call ->discard_folio with @pos set to the start of
the folio.  xfs_discard_folio tries to discard the entire folio, which
because offset_in_folio(@pos) was zero, means we tear down the iop.

Regrettably, the iop still has write_bytes_pending>0, so we blow up.
I guess this means we started writeback on a block that wasn't the first
one in the folio, and then writeback failed on block zero?

Modules linked in: dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq crct10dif_ce sch_fq_codel efivarfs ip_toverlay nfsv4
CPU: 0 PID: 1670507 Comm: xfs_io Tainted: G        W         5.18.0-rc3-djwa #rc3 ec810768ab31b0e167ac04d847f3cdf695827dae
Hardware name: QEMU KVM Virtual Machine, BIOS 1.4.1 12/03/2020
pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : iomap_finish_ioend+0x3a4/0x550
lr : iomap_finish_ioend+0x26c/0x550
sp : fffffe00213afa00
x29: fffffe00213afa00 x28: 0000000000000000 x27: ffffffff007cbc00
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 00000000fffffffb x22: fffffc0105552c00 x21: fffffc00e23f3dc0
x20: 0000000000020000 x19: 0000000000020000 x18: 0000000000000030
x17: 656c626f72702065 x16: 6874207966697463 x15: 657220646e61206d
x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
x11: fffffe00213af470 x10: fffffe0001658ea0 x9 : fffffe000836f6f0
x8 : 0000000000000238 x7 : 0000000000011000 x6 : 000000000000000c
x5 : 0000000000000040 x4 : 0000000000000005 x3 : fffffc00f1b11524
x2 : 0000000000000002 x1 : 0000000000010000 x0 : 1ffe000000018116
Call trace:
 iomap_finish_ioend+0x3a4/0x550
 iomap_writepage_end_bio+0x38/0x300
 bio_endio+0x174/0x214
 iomap_submit_ioend+0x94/0xb0
 iomap_writepages+0x4c/0x60
 xfs_vm_writepages+0x98/0xe0 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 do_writepages+0x94/0x1d0
 filemap_fdatawrite_wbc+0x8c/0xc0
 file_write_and_wait_range+0xc0/0x100
 xfs_file_fsync+0x64/0x260 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 vfs_fsync_range+0x44/0x90
 do_fsync+0x44/0x90
 __arm64_sys_fsync+0x24/0x34
 invoke_syscall.constprop.0+0x58/0xf0
 do_el0_svc+0x5c/0x160
 el0_svc+0x3c/0x184
 el0t_64_sync_handler+0x1a8/0x1b0
 el0t_64_sync+0x18c/0x190
---[ end trace 0000000000000000 ]---
page:ffffffff007cbc00 refcount:4 mapcount:0 mapping:fffffc0105552da8 index:0x8 pfn:0x232f0
head:ffffffff007cbc00 order:2 compound_mapcount:0 compound_pincount:0
memcg:fffffc00f24de000
aops:xfs_address_space_operations [xfs] ino:87 dentry name:"file2"
flags: 0x1ffe000000018116(error|referenced|uptodate|lru|writeback|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 1ffe000000018116 ffffffff004cf408 ffffffff007b4c08 fffffc0105552da8
raw: 0000000000000008 0000000000000000 00000004ffffffff fffffc00f24de000
page dumped because: VM_BUG_ON_FOLIO(i_blocks_per_folio(inode, folio) > 1 && !iop)
------------[ cut here ]------------
kernel BUG at fs/iomap/buffered-io.c:1021!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in: dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq crct10dif_ce sch_fq_codel efivarfs ip_toverlay nfsv4
CPU: 0 PID: 1670507 Comm: xfs_io Tainted: G        W         5.18.0-rc3-djwa #rc3 ec810768ab31b0e167ac04d847f3cdf695827dae
Hardware name: QEMU KVM Virtual Machine, BIOS 1.4.1 12/03/2020
pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : iomap_finish_ioend+0x3c0/0x550
lr : iomap_finish_ioend+0x3c0/0x550
sp : fffffe00213afa00
x29: fffffe00213afa00 x28: 0000000000000000 x27: ffffffff007cbc00
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 00000000fffffffb x22: fffffc0105552c00 x21: fffffc00e23f3dc0
x20: 0000000000020000 x19: 0000000000020000 x18: 0000000000000030
x17: 66202c65646f6e69 x16: 286f696c6f665f72 x15: 65705f736b636f6c
x14: 625f69284f494c4f x13: 29706f6921202626 x12: 2031203e20296f69
x11: 000000010000025e x10: 000000010000025e x9 : fffffe00080ca428
x8 : 00000000000008d0 x7 : c00000010000025e x6 : 0000000000000468
x5 : 0000000000000000 x4 : 0000000000000002 x3 : 0000000000000000
x2 : 0000000000000000 x1 : fffffc00e60d1940 x0 : 0000000000000052
Call trace:
 iomap_finish_ioend+0x3c0/0x550
 iomap_writepage_end_bio+0x38/0x300
 bio_endio+0x174/0x214
 iomap_submit_ioend+0x94/0xb0
 iomap_writepages+0x4c/0x60
 xfs_vm_writepages+0x98/0xe0 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 do_writepages+0x94/0x1d0
 filemap_fdatawrite_wbc+0x8c/0xc0
 file_write_and_wait_range+0xc0/0x100
 xfs_file_fsync+0x64/0x260 [xfs e4acf345e615d04c4712ff9d0ad149b9f1983c65]
 vfs_fsync_range+0x44/0x90
 do_fsync+0x44/0x90
 __arm64_sys_fsync+0x24/0x34
 invoke_syscall.constprop.0+0x58/0xf0
 do_el0_svc+0x5c/0x160
 el0_svc+0x3c/0x184
 el0t_64_sync_handler+0x1a8/0x1b0
 el0t_64_sync+0x18c/0x190
Code: aa1b03e0 90003f61 91212021 97fb3939 (d4210000) 
---[ end trace 0000000000000000 ]---
note: xfs_io[1670507] exited with preempt_count 1
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:624 rcu_eqs_enter.constprop.0+0x88/0x90
Modules linked in: dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq crct10dif_ce sch_fq_codel efivarfs ip_toverlay nfsv4
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W         5.18.0-rc3-djwa #rc3 ec810768ab31b0e167ac04d847f3cdf695827dae
Hardware name: QEMU KVM Virtual Machine, BIOS 1.4.1 12/03/2020
pstate: 204010c5 (nzCv daIF +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : rcu_eqs_enter.constprop.0+0x88/0x90
lr : rcu_eqs_enter.constprop.0+0x14/0x90
sp : fffffe0008fefd30
x29: fffffe0008fefd30 x28: 0000000040c80018 x27: fffffe0008b3d238
x26: fffffe000900e140 x25: 0000000000000000 x24: 0000000000000000
x23: fffffe0008b22688 x22: fffffe0008dc7100 x21: fffffe00090059f0
x20: fffffe0009005a98 x19: fffffc01ff5e9180 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000001 x13: 0000000000000000 x12: 0000000000000003
x11: 0000000000000000 x10: 0000000000001ae0 x9 : fffffe0008903184
x8 : fffffe000900fc80 x7 : 0000000100012faa x6 : 000027a0835a48ce
x5 : 00ffffffffffffff x4 : 0000000000000001 x3 : fffffe0008d40008
x2 : 4000000000000000 x1 : fffffe0009009310 x0 : 4000000000000002
Call trace:
 rcu_eqs_enter.constprop.0+0x88/0x90
 rcu_idle_enter+0x1c/0x30
 default_idle_call+0x34/0x188
 do_idle+0x230/0x2a4
 cpu_startup_entry+0x30/0x3c
 rest_init+0xec/0x100
 arch_call_rest_init+0x1c/0x28
 start_kernel+0x6ec/0x72c
 __primary_switched+0xa4/0xac
---[ end trace 0000000000000000 ]---
hrtimer: interrupt took 16422000 ns

--D


> > 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);
> > 
> > 	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
> > 		folio_end_writeback(folio);
> > }
> > 
> > ...before it also tripped over the same BUG at mm/filemap.c:1653.
> > 
> > --D
> > 
> > > > 
> > > > 
> > > > --D
> > > > 
> > > > run fstests generic/068 at 2022-04-12 17:57:11
> > > > XFS (sda3): Mounting V5 Filesystem
> > > > XFS (sda3): Ending clean mount
> > > > XFS (sda4): Mounting V5 Filesystem
> > > > XFS (sda4): Ending clean mount
> > > > ------------[ cut here ]------------
> > > > kernel BUG at mm/filemap.c:1653!
> > > > invalid opcode: 0000 [#1] PREEMPT SMP
> > > > CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
> > > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> > > > Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> > > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
> > > > Call Trace:
> > > >  <TASK>
> > > >  iomap_finish_ioend+0x19e/0x560
> > > >  iomap_finish_ioends+0x69/0x100
> > > >  xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > > >  xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> > > >  process_one_work+0x1df/0x3c0
> > > >  ? rescuer_thread+0x3b0/0x3b0
> > > >  worker_thread+0x53/0x3b0
> > > >  ? rescuer_thread+0x3b0/0x3b0
> > > >  kthread+0xea/0x110
> > > >  ? kthread_complete_and_exit+0x20/0x20
> > > >  ret_from_fork+0x1f/0x30
> > > >  </TASK>
> > > > Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> > > > Dumping ftrace buffer:
> > > >    (ftrace buffer empty)
> > > > ---[ end trace 0000000000000000 ]---
> > > > RIP: 0010:folio_end_writeback+0x79/0x80
> > > > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > > > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > > > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > > > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > > > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > > > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > > > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > > > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0
> > > > 
