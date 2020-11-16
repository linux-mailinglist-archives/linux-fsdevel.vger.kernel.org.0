Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA352B479A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgKPO7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgKPO7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7533C0613D3;
        Mon, 16 Nov 2020 06:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=soDf5n/4IHZXpRDONsC4iRIWKhhdabm7wm1Ix3YyzkY=; b=sXKHf4+KcwIa5fuTcLVQORl6vc
        Y03Gwu4v2aKXYxB2gC70w5AjOtoQE1Q1pXkpIHcqxu1afca2PvwHAIEb13ajBGY5qll0Bc+WJnuHt
        TgCIRD/tv9h7SIzJyRqtqrpqxOYCL5TBFCCOpqvnrOBTaKdroJMy4aFUM6Eu1+1BjsZPfN+VBECoA
        VBKTChEgoSg7gTk+HdF7LfwwqhGnCtekD9xT9Y736twxTwR4aWyi6Skc6DBIDj8x5uz90PEkL1KLh
        CVLnyiuFwPdIlcsawji6tbe7dqrYAdB98VJPkjxf9YLh+GLVDgz+CUZ/XticM28L06ss6gSMN118i
        lq40xEVw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyH-0003yd-CW; Mon, 16 Nov 2020 14:59:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 42/78] sd: use __register_blkdev to avoid a modprobe for an unregistered dev_t
Date:   Mon, 16 Nov 2020 15:57:33 +0100
Message-Id: <20201116145809.410558-43-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch from using blk_register_region to the probe callback passed to
__register_blkdev to disable the request_module call for an unclaimed
dev_t in the SD majors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/sd.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a2a4f385833d6c..679c2c02504763 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -630,13 +630,11 @@ static struct scsi_driver sd_template = {
 };
 
 /*
- * Dummy kobj_map->probe function.
- * The default ->probe function will call modprobe, which is
- * pointless as this module is already loaded.
+ * Don't request a new module, as that could deadlock in multipath
+ * environment.
  */
-static struct kobject *sd_default_probe(dev_t devt, int *partno, void *data)
+static void sd_default_probe(dev_t devt)
 {
-	return NULL;
 }
 
 /*
@@ -3525,9 +3523,6 @@ static int sd_remove(struct device *dev)
 
 	free_opal_dev(sdkp->opal_dev);
 
-	blk_register_region(devt, SD_MINORS, NULL,
-			    sd_default_probe, NULL, NULL);
-
 	mutex_lock(&sd_ref_mutex);
 	dev_set_drvdata(dev, NULL);
 	put_device(&sdkp->dev);
@@ -3717,11 +3712,9 @@ static int __init init_sd(void)
 	SCSI_LOG_HLQUEUE(3, printk("init_sd: sd driver entry point\n"));
 
 	for (i = 0; i < SD_MAJORS; i++) {
-		if (register_blkdev(sd_major(i), "sd") != 0)
+		if (__register_blkdev(sd_major(i), "sd", sd_default_probe))
 			continue;
 		majors++;
-		blk_register_region(sd_major(i), SD_MINORS, NULL,
-				    sd_default_probe, NULL, NULL);
 	}
 
 	if (!majors)
@@ -3794,10 +3787,8 @@ static void __exit exit_sd(void)
 
 	class_unregister(&sd_disk_class);
 
-	for (i = 0; i < SD_MAJORS; i++) {
-		blk_unregister_region(sd_major(i), SD_MINORS);
+	for (i = 0; i < SD_MAJORS; i++)
 		unregister_blkdev(sd_major(i), "sd");
-	}
 }
 
 module_init(init_sd);
-- 
2.29.2

