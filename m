Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E3E6AA449
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 23:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCCW0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjCCWZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:25:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9144164226;
        Fri,  3 Mar 2023 14:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7DC6185C;
        Fri,  3 Mar 2023 22:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F7C433EF;
        Fri,  3 Mar 2023 22:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677881278;
        bh=TUin5dJ6wozQ4pS9/Xwfz0PAwCO0bOaleI5RUw7nM5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4u6Y1cfyedCPK4JiZI9UhSiCl8Ya3YDVva5Mdk8nPYGkTjd/qEEYWZwLKfy73CfX
         b4sRiBbcd0Rj6bVbwIV4sdnA9ZS6++xyMUo/DHlSVVuLB/qS9LKFd1rggM5ZsbXIOX
         t3s7yJqFrWhY5FMarh/PX0BSm7LgOGDL8c3Q+B9ZvrMLWVzMJaCQpwGD/w1ri/TbWZ
         iMpYkP0+dyWQVqgPjlZTMqEhJaibj8tAlU8lNqhphNXefk9X9/twyte4IH5HSU9z5V
         RcpI8GicZ4BVzdFIn/lglbpzOGieosRurelA8gisT8HKtu2zPdqE9qXGf9TILtHIY1
         JGJmES8sjqeFA==
Date:   Fri, 3 Mar 2023 15:07:55 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAJvu2hZrHu816gj@kbusch-mbp.dhcp.thefacebook.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 03, 2023 at 01:45:48PM -0800, Luis Chamberlain wrote:
> 
> You'd hope most of it is left to FS + MM, but I'm not yet sure that's
> quite it yet. Initial experimentation shows just enabling > PAGE_SIZE
> physical & logical block NVMe devices gets brought down to 512 bytes.
> That seems odd to say the least. Would changing this be an issue now?

I think you're talking about removing this part:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc68..2c528f56c2973 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1828,17 +1828,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	unsigned short bs = 1 << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
-	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
-	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
-		capacity = 0;
-		bs = (1 << 9);
-	}
-
 	blk_integrity_unregister(disk);
-
 	atomic_bs = phys_bs = bs;
 	if (id->nabo == 0) {
 		/*
--

This is what happens today if the driver were to let the disk create with its
actual size (testing 8k LBA size on x86):

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP
 CPU: 10 PID: 115 Comm: kworker/u32:2 Not tainted 6.2.0-00032-gdb7183e3c314-dirty #105
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvme-wq nvme_scan_work
 RIP: 0010:create_empty_buffers+0x24/0x240
 Code: 66 0f 1f 44 00 00 0f 1f 44 00 00 41 54 49 89 d4 ba 01 00 00 00 55 53 48 89 fb e8 17 f5 ff ff 48 89 c5 48 89 c2 eb 03 48 89 ca <48> 8b 4a 08 4c 09 22 48 85 c9 75 f1 48 89 6a 08 48 8b 43 18 48 8d
 RSP: 0000:ffffc900004578f0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffea0000152580 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffea0000152580
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
 R10: ffff88803ecb6c18 R11: 0000000000000000 R12: 0000000000000000
 R13: ffffea0000152580 R14: 0000000000100cc0 R15: ffff888017030288
 FS:  0000000000000000(0000) GS:ffff88803ec80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000002c2a001 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? blkdev_readahead+0x20/0x20
  create_page_buffers+0x79/0x90
  block_read_full_folio+0x58/0x410
  ? blkdev_write_begin+0x20/0x20
  ? xas_store+0x56/0x5b0
  ? xas_load+0x8/0x40
  ? xa_get_order+0x51/0xe0
  ? __mod_memcg_lruvec_state+0x41/0x90
  ? blkdev_readahead+0x20/0x20
  ? blkdev_readahead+0x20/0x20
  filemap_read_folio+0x41/0x2a0
  ? scan_shadow_nodes+0x30/0x30
  ? blkdev_readahead+0x20/0x20
  ? folio_add_lru+0x2d/0x40
  ? blkdev_readahead+0x20/0x20
  do_read_cache_folio+0x103/0x420
  ? __switch_to_asm+0x3a/0x60
  ? __switch_to_asm+0x34/0x60
  ? get_page_from_freelist+0x735/0x1070
  read_part_sector+0x2f/0xa0
  read_lba+0xa2/0x150
  efi_partition+0xdb/0x760
  ? snprintf+0x49/0x60
  ? is_gpt_valid.part.5+0x3f0/0x3f0
  bdev_disk_changed+0x1ce/0x560
  blkdev_get_whole+0x73/0x80
  blkdev_get_by_dev+0x199/0x2e0
  disk_scan_partitions+0x63/0xd0
  device_add_disk+0x3c0/0x3d0
  nvme_scan_ns+0x574/0xcc0
  ? nvme_scan_work+0x23a/0x3f0
  nvme_scan_work+0x23a/0x3f0
  process_one_work+0x1da/0x3a0
  worker_thread+0x205/0x3a0
  ? process_one_work+0x3a0/0x3a0
  kthread+0xc0/0xe0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>
