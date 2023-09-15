Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA4A7A298A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 23:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbjIOVdd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbjIOVdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:33:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D5B8;
        Fri, 15 Sep 2023 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hsCbEbpQePNsNlaxz4E9IonlUtvi5CZw112iATZuYCc=; b=aZkcYzqyB48MzWjwPzdWMDhnaS
        36unGgvgZVmx44ucFkaeDQD30sty+H/nNJyNc4PVX0IXLz6eD9/cB7me475sIol2vyN7fYQx1l1Am
        mSvqthZp/qFLxkk+BeosmOvQUZ8A1E8FGSjBLsIf9RsQC7plzVR1SbO6qZNYLP5CwXOfod9R+IjDE
        +Rge5ByL8PoOTza2K1k8kHSwNczsNsE42mHkUBxS0CMU3Hk/sFrhiJjzpe40voK+YXIe9YMVPzELz
        b+Po4D0c5miORXLMmY9pFMtmWJwfnOpvAt3A7dOo8k2lyjC8WDy0QyFTJDCWMuLJCj85gIOPDzRoI
        SHnevtWQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhGQq-00BQnW-1G;
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
Subject: [RFC v2 07/10] nvme: enhance max supported LBA format check
Date:   Fri, 15 Sep 2023 14:32:51 -0700
Message-Id: <20230915213254.2724586-8-mcgrof@kernel.org>
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

Only pure-iomap configurations, systems where CONFIG_BUFFER_HEAD is
disabled can enable NVMe devices with LBA formats with a blocksize
larger then the PAGE_SIZE.

Systems with buffer-heads enabled cannot currently make use of these
devices, but this will eventually get fixed. We cap the max supported
LBA format to 19, 512 KiB as support for 1 MiB LBA format still needs
some work.

Also, add a debug module parameter nvme_core.debug_large_lbas to enable
folks to shoot themselves on their foot though if they want to test
and expand support beyond what is supported, only to be used on
pure-iomap configurations.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3a01b79148c..0365f260c514 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -88,6 +88,10 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
+static bool debug_large_lbas;
+module_param(debug_large_lbas, bool, 0644);
+MODULE_PARM_DESC(debug_large_lbas, "allow LBAs > PAGE_SIZE");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1878,6 +1882,29 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+/* XXX: shift 20 (1 MiB LBA) crashes on pure-iomap */
+#define NVME_MAX_SHIFT_SUPPORTED 19
+
+static bool nvme_lba_shift_supported(struct nvme_ns *ns)
+{
+	if (ns->lba_shift <= PAGE_SHIFT)
+		return true;
+
+	if (IS_ENABLED(CONFIG_BUFFER_HEAD))
+		return false;
+
+	if (ns->lba_shift <= NVME_MAX_SHIFT_SUPPORTED)
+		return true;
+
+	if (debug_large_lbas) {
+		dev_warn(ns->ctrl->device,
+			"forcibly allowing LBAS > 1 MiB due to nvme_core.debug_large_lbas -- use at your own risk\n");
+		return true;
+	}
+
+	return false;
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
@@ -1885,13 +1912,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	u32 bs = 1U << ns->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
-	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
-	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (!nvme_lba_shift_supported(ns)) {
 		capacity = 0;
 		bs = (1 << 9);
+		dev_warn(ns->ctrl->device, "I'm sorry dave, I'm afraid I can't do that\n");
 	}
 
 	blk_integrity_unregister(disk);
-- 
2.39.2

