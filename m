Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1907A2983
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjIOVda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbjIOVdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6E193;
        Fri, 15 Sep 2023 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=klgxghukoLB077BcGmD37gwuwN5TiuVyvr8uJe/6qJU=; b=xTeTtvE1PB+sCk5jYN9CsRNDcC
        oq2rbg1f2LevVKTppTb9rvS7a6d9knnti9jQdDdUKPFipV/7xRYRi9bXw1loPY9YRQLYncMi0eTH0
        eSA7OvBPVYDjb/pTBadQaMypikILS+6vmRakqpcosKTLfq6mA5A9nT5TFdX/6+BWkToM79mGvZ7C/
        tfJjEHFIAWrCbPalQvlsnGYZpiYB2i4a7P6av3qMHhcJxJ08e6/CKkcCSA5aVBYA0JrWxd6Hx1R0v
        HvwVgB8hOjoe2H7UeTLiZRP+Ab6e+CWQp+OvTodpFSnvw6ER3Zk057IRQNPe4YstyGZWoX/Y8EDtM
        kClVBvPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQna-1Y;
        Fri, 15 Sep 2023 21:32:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc:     willy@infradead.org, brauner@kernel.org, hare@suse.de,
        ritesh.list@gmail.com, rgoldwyn@suse.com, jack@suse.cz,
        ziy@nvidia.com, ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com, mcgrof@kernel.org
Subject: [RFC v2 09/10] nvme: add nvme_core.debug_large_atomics to force high awun as phys_bs
Date:   Fri, 15 Sep 2023 14:32:53 -0700
Message-Id: <20230915213254.2724586-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230915213254.2724586-1-mcgrof@kernel.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A drive with atomic write support should have awun / nawun defined,
for these drives it should be possible to play with and experiment
safely with LBS support up to awun / nawun settings if you are
completely ignoring power failure situations. Add support to
experiment with this. The rationale to limit to awun / nawun is
to avoid races with other on flight commands which otherwise
could cause unexpected results.

This also means this debug module parameter feature is not supported
if your drive does not support atomics / awun / nawun.

Suggested-by: Dan Helmick <dan.helmick@samsung.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a3c51ac13bd..c1f9d8e3ea93 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -92,6 +92,10 @@ static bool debug_large_lbas;
 module_param(debug_large_lbas, bool, 0644);
 MODULE_PARM_DESC(debug_large_lbas, "allow LBAs > PAGE_SIZE");
 
+static unsigned int debug_large_atomics;
+module_param(debug_large_atomics, uint, 0644);
+MODULE_PARM_DESC(debug_large_atomics, "allow large atomics <= awun or nawun <= mdts");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1958,6 +1962,20 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		 * be aware of out of order reads/writes as npwg and nows
 		 * are purely performance optimizations.
 		 */
+
+		/*
+		 * If you're not concerned about power failure, in theory,
+		 * you should be able to experiment up to awun rather safely.
+		 *
+		 * Ignore qemu awun value of 1.
+		 */
+		if (debug_large_atomics && awun != 1) {
+			debug_large_atomics = min(awun_bs, debug_large_atomics);
+			phys_bs = atomic_bs = debug_large_atomics;
+			dev_info(ns->ctrl->device,
+				 "Forcing large atomic: %u (awun_bs: %u awun: %u)\n",
+				 debug_large_atomics, awun_bs, awun);
+		}
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
-- 
2.39.2

