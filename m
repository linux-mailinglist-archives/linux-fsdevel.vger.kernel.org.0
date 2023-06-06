Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605A6723759
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 08:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjFFGOJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 6 Jun 2023 02:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjFFGOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:14:08 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4160E100
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 23:13:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D93F8616B2CC;
        Tue,  6 Jun 2023 08:13:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VRpeKDLk3BOS; Tue,  6 Jun 2023 08:13:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3951A616B2CF;
        Tue,  6 Jun 2023 08:13:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AtPtdJJHZKmp; Tue,  6 Jun 2023 08:13:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1ACD5616B2CC;
        Tue,  6 Jun 2023 08:13:55 +0200 (CEST)
Date:   Tue, 6 Jun 2023 08:13:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <406990820.3686390.1686032035024.JavaMail.zimbra@nod.at>
In-Reply-To: <ZH6mixCMHce1S+vK@casper.infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org> <20230605165029.2908304-5-willy@infradead.org> <2059298337.3685966.1686001020185.JavaMail.zimbra@nod.at> <ZH6mixCMHce1S+vK@casper.infradead.org>
Subject: Re: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Convert do_writepage() to take a folio
Thread-Index: A5loe1Q509hPXo6nbPIZcSN7fgpWow==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew,

----- Ursprüngliche Mail -----
> Von: "Matthew Wilcox" <willy@infradead.org>
> len is folio_size(), which is not 0.
> 
>        len = offset_in_folio(folio, i_size);

offset_in_folio(folio, i_size) can give 0.

Further it will call do_writepage() with len being 0.
I can actually trigger this case.

By adding the following ubifs_assert() I can catch the write side.
If the file length is a multiple of PAGE_SIZE (4k), it will trigger.

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 67cf5138ccc48..dc39ea368ca2b 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1059,6 +1059,8 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
        folio_zero_segment(folio, offset_in_folio(folio, i_size), len);
        len = offset_in_folio(folio, i_size);
 
+       ubifs_assert(c, len > 0);
+
        if (i_size > synced_i_size) {
                err = inode->i_sb->s_op->write_inode(inode, NULL);
                if (err)

[   44.569110] UBIFS error (ubi0:0 pid 59): ubifs_assert_failed: UBIFS assert failed: len > 0, in fs/ubifs/file.c:1062
[   44.571359] UBIFS warning (ubi0:0 pid 59): ubifs_ro_mode.part.6: switched to read-only mode, error -22
[   44.572998] CPU: 1 PID: 59 Comm: kworker/u8:2 Not tainted 6.4.0-rc5-00004-gd504b815b71c-dirty #19
[   44.574139] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[   44.574141] Workqueue: writeback wb_workfn (flush-ubifs_0_0)
[   44.574148] Call Trace:
[   44.574162]  <TASK>
[   44.574165]  dump_stack_lvl+0x32/0x50
[   44.574172]  ubifs_writepage+0x25a/0x270
[   44.578096]  write_cache_pages+0x132/0x3a0
[   44.578103]  ? __pfx_ubifs_writepage+0x10/0x10
[   44.578107]  ? virtqueue_add_sgs+0x7b/0x90
[   44.578113]  do_writepages+0xd3/0x1a0
[   44.578116]  ? kvm_clock_read+0x14/0x30
[   44.578121]  ? kvm_sched_clock_read+0x5/0x20
[   44.578125]  __writeback_single_inode+0x3c/0x350
[   44.578128]  writeback_sb_inodes+0x1c9/0x460
[   44.578133]  __writeback_inodes_wb+0x5a/0xc0
[   44.582508]  wb_writeback+0x230/0x2c0
[   44.582513]  wb_workfn+0x301/0x430
[   44.582515]  ? kvm_clock_read+0x14/0x30
[   44.582519]  ? kvm_sched_clock_read+0x5/0x20
[   44.582523]  ? sched_clock_cpu+0xd/0x190
[   44.582527]  ? __smp_call_single_queue+0xa1/0x110
[   44.582532]  process_one_work+0x1f3/0x3f0
[   44.582538]  worker_thread+0x25/0x3b0
[   44.586196]  ? __pfx_worker_thread+0x10/0x10
[   44.586201]  kthread+0xde/0x110
[   44.586204]  ? __pfx_kthread+0x10/0x10
[   44.586207]  ret_from_fork+0x2c/0x50
[   44.586212]  </TASK>

Thanks,
//richard
