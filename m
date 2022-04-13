Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6F64FFB1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiDMQ0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiDMQ0Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:26:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC4F2E083;
        Wed, 13 Apr 2022 09:23:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E16CB82595;
        Wed, 13 Apr 2022 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE30BC385A4;
        Wed, 13 Apr 2022 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649867031;
        bh=LwjIMdi2kmjgYiucJtnPmoWomm0qvLgSuC5QQ95UgVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nS9ShLTCZozkAEs5XfpoH4GJH8hfyNcKD7O1GVZZmo65BpmCYKPZG/njwTr+9Fysq
         gnfu0Kqo93daiU2zQeWUqUVUd9vVqjoQZDbG1u5jGv454e1Iif7ww8hI9LI6aYqcBd
         NQgGZzasoBg/TyGOAFETyci9pnE5a9bZIYlxZQBQjT2ybFj/hD+BnU9QF1hErqsbX1
         Hv9oHH2AXThf2uX/bMQQtu9Viobob4BCGurkDw2KuGXxmfYKL4EjoQKuByesVanmXQ
         ZcuaV9pNtTGLAiyWgExwU8U+tCrrknSCpuVAg+xFT8XBs2XHUls3M6B1u9a4UHIsEj
         LoiR3wA/zWAZw==
Date:   Wed, 13 Apr 2022 09:23:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <20220413162351.GA205970@magnolia>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlbjOPEQP66gc1WQ@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:50:32PM +0100, Matthew Wilcox wrote:
> On Tue, Apr 12, 2022 at 08:34:25PM -0700, Darrick J. Wong wrote:
> > Hmm.  Two nights in a row I've seen the following crash.  Has anyone
> > else seen this, or should I keep digging?  This is a fairly boring
> > x86_64 VM with a XFS v5 filesystem + rmapbt.
> 
> I have not seen this before.  I test with:
> MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc
> 
> Maybe I should try a 4096 byte block size.
> 
> > mm/filemap.c:1653 is the BUG in:
> > 
> > void folio_end_writeback(struct folio *folio)
> > {
> > 	/*
> > 	 * folio_test_clear_reclaim() could be used here but it is an
> > 	 * atomic operation and overkill in this particular case.
> > 	 * Failing to shuffle a folio marked for immediate reclaim is
> > 	 * too mild a gain to justify taking an atomic operation penalty
> > 	 * at the end of every folio writeback.
> > 	 */
> > 	if (folio_test_reclaim(folio)) {
> > 		folio_clear_reclaim(folio);
> > 		folio_rotate_reclaimable(folio);
> > 	}
> > 
> > 	/*
> > 	 * Writeback does not hold a folio reference of its own, relying
> > 	 * on truncation to wait for the clearing of PG_writeback.
> > 	 * But here we must make sure that the folio is not freed and
> > 	 * reused before the folio_wake().
> > 	 */
> > 	folio_get(folio);
> > 	if (!__folio_end_writeback(folio))
> > >>>>		BUG();
> 
> Grr, that should have been a VM_BUG_ON_FOLIO(1, folio) so we get useful
> information about the folio (like whether it has an iop, or what order
> the folio is).  Can you make that change and try to reproduce?
> 
> What's going on here is that we've called folio_end_writeback() on a
> folio which does not have the writeback flag set.  That _should_ be
> impossible, hence the use of BUG().  Either we've called
> folio_end_writeback() twice on the same folio, or we neglected to set
> the writeback flag on the folio.  I don't immediately see why either
> of those two things would happen.

Ok, will do.

An ARM VM also tripped over this last night (64k pages, 4k fsblocksize)
and it had even more to say:

run fstests generic/068 at 2022-04-12 20:49:17
spectre-v4 mitigation disabled by command-line option
XFS (sda2): Mounting V5 Filesystem
XFS (sda2): Ending clean mount
XFS (sda3): Mounting V5 Filesystem
XFS (sda3): Ending clean mount
XFS (sda3): Quotacheck needed: Please wait.
XFS (sda3): Quotacheck: Done.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1214302 at fs/iomap/buffered-io.c:1020 iomap_finish_ioend+0x29c/0x37c
Modules linked in: dm_zero ext2 dm_delay xfs dm_snapshot ext4 mbcache jbd2 dm_log_writes dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_flakey libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 rpcsec_gss_krb5 auth_rpcgss xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink crct10dif_ce bfq ip6table_filter ip6_tables iptable_filter sch_fq_codel efivarfs ip_tables x_tables overlay nfsv4 [last unloaded: scsi_debug]
CPU: 0 PID: 1214302 Comm: 0:4 Tainted: G        W         5.18.0-rc2-djwa #rc2 541bf598c49d4450e32c1bfc9b8fb32b7009548e
Hardware name: QEMU KVM Virtual Machine, BIOS 1.5.1 06/16/2021
Workqueue: xfs-conv/sda3 xfs_end_io [xfs]
pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : iomap_finish_ioend+0x29c/0x37c
lr : iomap_finish_ioend+0x19c/0x37c
sp : fffffe000f08fc20
x29: fffffe000f08fc20 x28: 0000000000040000 x27: 0000000000010000
x26: ffffffff00775040 x25: 0000000000000000 x24: 0000000000000001
x23: fffffc00e1014cc0 x22: fffffc01a44fac40 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
x17: 620000006b290000 x16: 4dae6b4802000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000001ae0 x9 : fffffe00088ebff4
x8 : fffffe01f6840000 x7 : fffffe0008fe92f0 x6 : 0000000000000387
x5 : 00000000f0000000 x4 : 0000000000000000 x3 : 0000000000010000
x2 : fffffc00e2623e80 x1 : 000000000000000d x0 : 0000000000000008
Call trace:
 iomap_finish_ioend+0x29c/0x37c
 iomap_finish_ioends+0x80/0x130
 xfs_end_ioend+0x68/0x164 [xfs ccff30bab1b631f6755d8bbcebc428122f4b51e0]
 xfs_end_io+0xcc/0x12c [xfs ccff30bab1b631f6755d8bbcebc428122f4b51e0]
 process_one_work+0x1e8/0x480
 worker_thread+0x7c/0x430
 kthread+0x108/0x114
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------

I tracked that assertion to:

static void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
		size_t len, int error)
{
	struct iomap_page *iop = to_iomap_page(folio);

	if (error) {
		folio_set_error(folio);
		mapping_set_error(inode->i_mapping, error);
	}

>>>>	WARN_ON_ONCE(i_blocks_per_folio(inode, folio) > 1 && !iop);
	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) <= 0);

	if (!iop || atomic_sub_and_test(len, &iop->write_bytes_pending))
		folio_end_writeback(folio);
}

...before it also tripped over the same BUG at mm/filemap.c:1653.

--D

> > 
> > 
> > --D
> > 
> > run fstests generic/068 at 2022-04-12 17:57:11
> > XFS (sda3): Mounting V5 Filesystem
> > XFS (sda3): Ending clean mount
> > XFS (sda4): Mounting V5 Filesystem
> > XFS (sda4): Ending clean mount
> > ------------[ cut here ]------------
> > kernel BUG at mm/filemap.c:1653!
> > invalid opcode: 0000 [#1] PREEMPT SMP
> > CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> > Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> > RIP: 0010:folio_end_writeback+0x79/0x80
> > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
> > Call Trace:
> >  <TASK>
> >  iomap_finish_ioend+0x19e/0x560
> >  iomap_finish_ioends+0x69/0x100
> >  xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> >  xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
> >  process_one_work+0x1df/0x3c0
> >  ? rescuer_thread+0x3b0/0x3b0
> >  worker_thread+0x53/0x3b0
> >  ? rescuer_thread+0x3b0/0x3b0
> >  kthread+0xea/0x110
> >  ? kthread_complete_and_exit+0x20/0x20
> >  ret_from_fork+0x1f/0x30
> >  </TASK>
> > Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:folio_end_writeback+0x79/0x80
> > Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> > RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> > RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> > RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> > R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> > R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0
> > 
