Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FB4FF96F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 16:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiDMOw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 10:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiDMOwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:52:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9819462BF4;
        Wed, 13 Apr 2022 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=63LGzdJ+rBOxLVa4z4PD5/fg8xEprEpc+De/pW77Cxw=; b=o8XB+lZ0lB9rWv4io9d6Ih/fau
        0kasYrXDf0Grj4KH0MpJn/SebHTArY+7G0dfuRi0yh1TJthjcz/e6HY5MthCfyM0cADzO9YPGaDiC
        3fL5oU1wdKyh2IR5DcaWLmn1LbS7ViKHhfKmX01sQUv3uPQSTBEZn/ekoJleaCIFIdVlgzxHVgXar
        0Hx7z0HeGoZqBZp2aWnOeIqYrYjt055ZIJ8BxIplleWIsEZzExsiJqJEtVmpUMTmOWymVMs0oCsE2
        x0y36mBjqMBh5pVjjdmVTjysgyyf3kdYuNnMnPGrOUe6NdYwjzCx1KprfTFKsuz1XxeQk6nK7ARuh
        5oHMJNBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neeKG-00EKu3-V2; Wed, 13 Apr 2022 14:50:32 +0000
Date:   Wed, 13 Apr 2022 15:50:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>, fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <YlbjOPEQP66gc1WQ@casper.infradead.org>
References: <20220413033425.GM16799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413033425.GM16799@magnolia>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 12, 2022 at 08:34:25PM -0700, Darrick J. Wong wrote:
> Hmm.  Two nights in a row I've seen the following crash.  Has anyone
> else seen this, or should I keep digging?  This is a fairly boring
> x86_64 VM with a XFS v5 filesystem + rmapbt.

I have not seen this before.  I test with:
MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1 -b size=1024 /dev/sdc

Maybe I should try a 4096 byte block size.

> mm/filemap.c:1653 is the BUG in:
> 
> void folio_end_writeback(struct folio *folio)
> {
> 	/*
> 	 * folio_test_clear_reclaim() could be used here but it is an
> 	 * atomic operation and overkill in this particular case.
> 	 * Failing to shuffle a folio marked for immediate reclaim is
> 	 * too mild a gain to justify taking an atomic operation penalty
> 	 * at the end of every folio writeback.
> 	 */
> 	if (folio_test_reclaim(folio)) {
> 		folio_clear_reclaim(folio);
> 		folio_rotate_reclaimable(folio);
> 	}
> 
> 	/*
> 	 * Writeback does not hold a folio reference of its own, relying
> 	 * on truncation to wait for the clearing of PG_writeback.
> 	 * But here we must make sure that the folio is not freed and
> 	 * reused before the folio_wake().
> 	 */
> 	folio_get(folio);
> 	if (!__folio_end_writeback(folio))
> >>>>		BUG();

Grr, that should have been a VM_BUG_ON_FOLIO(1, folio) so we get useful
information about the folio (like whether it has an iop, or what order
the folio is).  Can you make that change and try to reproduce?

What's going on here is that we've called folio_end_writeback() on a
folio which does not have the writeback flag set.  That _should_ be
impossible, hence the use of BUG().  Either we've called
folio_end_writeback() twice on the same folio, or we neglected to set
the writeback flag on the folio.  I don't immediately see why either
of those two things would happen.

> 
> 
> --D
> 
> run fstests generic/068 at 2022-04-12 17:57:11
> XFS (sda3): Mounting V5 Filesystem
> XFS (sda3): Ending clean mount
> XFS (sda4): Mounting V5 Filesystem
> XFS (sda4): Ending clean mount
> ------------[ cut here ]------------
> kernel BUG at mm/filemap.c:1653!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
> Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
> RIP: 0010:folio_end_writeback+0x79/0x80
> Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
> Call Trace:
>  <TASK>
>  iomap_finish_ioend+0x19e/0x560
>  iomap_finish_ioends+0x69/0x100
>  xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
>  xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
>  process_one_work+0x1df/0x3c0
>  ? rescuer_thread+0x3b0/0x3b0
>  worker_thread+0x53/0x3b0
>  ? rescuer_thread+0x3b0/0x3b0
>  kthread+0xea/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>  </TASK>
> Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:folio_end_writeback+0x79/0x80
> Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
> RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
> RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
> RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
> R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
> R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0
> 
