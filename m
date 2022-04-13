Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DCF4FED9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiDMDgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 23:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiDMDgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813319C27;
        Tue, 12 Apr 2022 20:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D53DD61A6D;
        Wed, 13 Apr 2022 03:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A4C385A3;
        Wed, 13 Apr 2022 03:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649820866;
        bh=YI9/GXO98tFROhuUJNFN6H5ANr/U2vpshAJVqLVhc+0=;
        h=Date:From:To:Cc:Subject:From;
        b=E1+qC8iXuk9c0P618uRZc8pXtpbWLDV4nSZ1Mwa9OfQPrnZQXy2mptw0phaN13dcA
         KfJh39sFob9RqsA2fe3afTo0p3nliH1ElfS+x6y5kBvKELEAD2b+jchUsAipIwBtQi
         uUQ6J3x4v6vXlDOTthOvPEvbT3CU9T9LUg5lcLOTzX3dlYa0tNHQRQcoS80TzLf+9+
         Oox8eo9SZDl6sxt62A0ZEOPs67SO3+QEoRsU1BH8ua3s7RK8GwehFQVsIbIqXPKFam
         8rzT3oObOQOb5nXvvFsrzWdn4RFrtm8vgYMkD/ENGsFApI+oRSBXQyRHQ4DEN0ZYFw
         kgR/ARapE3wDQ==
Date:   Tue, 12 Apr 2022 20:34:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: generic/068 crash on 5.18-rc2?
Message-ID: <20220413033425.GM16799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm.  Two nights in a row I've seen the following crash.  Has anyone
else seen this, or should I keep digging?  This is a fairly boring
x86_64 VM with a XFS v5 filesystem + rmapbt.

mm/filemap.c:1653 is the BUG in:

void folio_end_writeback(struct folio *folio)
{
	/*
	 * folio_test_clear_reclaim() could be used here but it is an
	 * atomic operation and overkill in this particular case.
	 * Failing to shuffle a folio marked for immediate reclaim is
	 * too mild a gain to justify taking an atomic operation penalty
	 * at the end of every folio writeback.
	 */
	if (folio_test_reclaim(folio)) {
		folio_clear_reclaim(folio);
		folio_rotate_reclaimable(folio);
	}

	/*
	 * Writeback does not hold a folio reference of its own, relying
	 * on truncation to wait for the clearing of PG_writeback.
	 * But here we must make sure that the folio is not freed and
	 * reused before the folio_wake().
	 */
	folio_get(folio);
	if (!__folio_end_writeback(folio))
>>>>		BUG();

	smp_mb__after_atomic();
	folio_wake(folio, PG_writeback);
	acct_reclaim_writeback(folio);
	folio_put(folio);
}
EXPORT_SYMBOL(folio_end_writeback);


--D

run fstests generic/068 at 2022-04-12 17:57:11
XFS (sda3): Mounting V5 Filesystem
XFS (sda3): Ending clean mount
XFS (sda4): Mounting V5 Filesystem
XFS (sda4): Ending clean mount
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1653!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 1349866 Comm: 0:116 Tainted: G        W         5.18.0-rc2-djwx #rc2 19cc48221d47ada6c8e5859639b6a0946c9a3777
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
Workqueue: xfs-conv/sda4 xfs_end_io [xfs]
RIP: 0010:folio_end_writeback+0x79/0x80
Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5b067d0000 CR3: 000000010d1bb000 CR4: 00000000001506b0
Call Trace:
 <TASK>
 iomap_finish_ioend+0x19e/0x560
 iomap_finish_ioends+0x69/0x100
 xfs_end_ioend+0x5a/0x160 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
 xfs_end_io+0xb1/0xf0 [xfs 513857e2ae300a835ce1fbd8065a84dc5382e649]
 process_one_work+0x1df/0x3c0
 ? rescuer_thread+0x3b0/0x3b0
 worker_thread+0x53/0x3b0
 ? rescuer_thread+0x3b0/0x3b0
 kthread+0xea/0x110
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in: dm_snapshot dm_bufio dm_zero dm_flakey xfs libcrc32c xt_REDIRECT iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 auth_rpcgss oid_registry xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables overlay nfsv4 af_packet [last unloaded: scsi_debug]
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_end_writeback+0x79/0x80
Code: d2 75 1d f0 ff 4d 34 74 0e 5d c3 f0 80 67 02 fb e8 ac 29 01 00 eb ad 48 89 ef 5d e9 a1 0f 01 00 48 89 ee e8 b9 e8 01 00 eb d9 <0f> 0b 0f 1f 44 00 00 0f 1f 44 00 00 53 48 89 fb e8 62 f7 ff ff 48
RSP: 0018:ffffc9000286fd50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffea0007376840 RCX: 000000000000000c
RDX: ffff88810d2de000 RSI: ffffffff81e55f0b RDI: ffff88810d2de000
RBP: ffffea0007376840 R08: ffffea000b82c308 R09: ffffea000b82c308
R10: 0000000000000001 R11: 000000000000000c R12: 0000000000000000
R13: 000000000000c000 R14: 0000000000000005 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88843fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b94008278 CR3: 0000000101ac9000 CR4: 00000000001506b0

