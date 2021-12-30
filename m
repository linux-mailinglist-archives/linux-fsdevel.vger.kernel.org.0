Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E596A481FF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Dec 2021 20:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhL3TmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Dec 2021 14:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbhL3TmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:42:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC9CC061574;
        Thu, 30 Dec 2021 11:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 967A0B80D79;
        Thu, 30 Dec 2021 19:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF119C36AE7;
        Thu, 30 Dec 2021 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640893330;
        bh=eMR0tvHVOQo/1yPDkxQiD3FBPdafGb59FcSG8xMBqMM=;
        h=From:To:Cc:Subject:Date:From;
        b=neX9+lIdHzTOaGWKjbwfwSOsorZ3m+SR0olKKHG7aOuQUc6jwtuoZreRd8NhQccFU
         IvNwi9ooC/XzWowvdx/u/k00bJMZQTxQ8tNvkM3vhlwZHVKJozURIsRdICV6aPb8sw
         V5K+xRqyzo566tQwbz3JSJbJPocGIjyJCYQ4rhrRTuB7pyl2NmwuB/+45/Bs6053Aj
         Bs0x3yB1BqCwhPWOW+vSglPkl8eQzADpNKUvKruKnQS9hMHQ6Lgaa9zvEMe1uxIV9z
         mh2owZ1rzJZB2BL+41Q0SL0dRZ54WhYrrVWIs1Q85nWW3C+hVDjPdSRUIuUDR3KmH1
         JDVCtpistdxXw==
From:   trondmy@kernel.org
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] iomap: Address soft lockup in iomap_finish_ioend()
Date:   Thu, 30 Dec 2021 14:35:22 -0500
Message-Id: <20211230193522.55520-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We're observing the following stack trace using various kernels when
running in the Azure cloud.

 watchdog: BUG: soft lockup - CPU#12 stuck for 23s! [kworker/12:1:3106]
 Modules linked in: raid0 ipt_MASQUERADE nf_conntrack_netlink xt_addrtype nft_chain_nat nf_nat br_netfilter bridge stp llc ext4 mbcache jbd2 overlay xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_counter rpcrdma rdma_ucm xt_owner ib_srpt nft_compat intel_rapl_msr ib_isert intel_rapl_common nf_tables iscsi_target_mod isst_if_mbox_msr isst_if_common nfnetlink target_core_mod nfit ib_iser libnvdimm libiscsi scsi_transport_iscsi ib_umad kvm_intel ib_ipoib rdma_cm iw_cm vfat ib_cm fat kvm irqbypass crct10dif_pclmul crc32_pclmul mlx5_ib ghash_clmulni_intel rapl ib_uverbs ib_core i2c_piix4 pcspkr hyperv_fb hv_balloon hv_utils joydev nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c mlx5_core mlxfw tls pci_hyperv pci_hyperv_intf sd_mod t10_pi sg ata_generic hv_storvsc hv_netvsc scsi_transport_fc hyperv_keyboard hid_hyperv ata_piix libata crc32c_intel hv_vmbus serio_raw fuse
 CPU: 12 PID: 3106 Comm: kworker/12:1 Not tainted 4.18.0-305.10.2.el8_4.x86_64 #1
 Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
 Workqueue: xfs-conv/md127 xfs_end_io [xfs]
 RIP: 0010:_raw_spin_unlock_irqrestore+0x11/0x20
 Code: 7c ff 48 29 e8 4c 39 e0 76 cf 80 0b 08 eb 8c 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 e8 e6 db 7e ff 66 90 48 89 f7 57 9d <0f> 1f 44 00 00 c3 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 07
 RSP: 0018:ffffac51d26dfd18 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff12
 RAX: 0000000000000001 RBX: ffffffff980085a0 RCX: dead000000000200
 RDX: ffffac51d3893c40 RSI: 0000000000000202 RDI: 0000000000000202
 RBP: 0000000000000202 R08: ffffac51d3893c40 R09: 0000000000000000
 R10: 00000000000000b9 R11: 00000000000004b3 R12: 0000000000000a20
 R13: ffffd228f3e5a200 R14: ffff963cf7f58d10 R15: ffffd228f3e5a200
 FS:  0000000000000000(0000) GS:ffff9625bfb00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f5035487500 CR3: 0000000432810004 CR4: 00000000003706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  wake_up_page_bit+0x8a/0x110
  iomap_finish_ioend+0xd7/0x1c0
  iomap_finish_ioends+0x7f/0xb0
  xfs_end_ioend+0x6b/0x100 [xfs]
  ? xfs_setfilesize_ioend+0x60/0x60 [xfs]
  xfs_end_io+0xb9/0xe0 [xfs]
  process_one_work+0x1a7/0x360
  worker_thread+0x1fa/0x390
  ? create_worker+0x1a0/0x1a0
  kthread+0x116/0x130
  ? kthread_flush_work_fn+0x10/0x10
  ret_from_fork+0x35/0x40

Jens suggested adding a latency-reducing cond_resched() to the loop in
iomap_finish_ioends().

Suggested-by: Jens Axboe <axboe@kernel.dk>
Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/iomap/buffered-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71a36ae120ee..e39a53923f9d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1052,9 +1052,11 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk each page on bio, ending page IO on them */
-		bio_for_each_segment_all(bv, bio, iter_all)
+		bio_for_each_segment_all(bv, bio, iter_all) {
 			iomap_finish_page_writeback(inode, bv->bv_page, error,
 					bv->bv_len);
+			cond_resched();
+		}
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
-- 
2.33.1

