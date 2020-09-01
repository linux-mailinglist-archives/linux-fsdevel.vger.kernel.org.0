Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1725960E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 17:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbgIAP6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbgIAP6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:58:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8268BC061258;
        Tue,  1 Sep 2020 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nRA6JK+4aMp60Yu0KbqG4/pNdu09ibxhHSJ5/A99bDI=; b=k2qZddWw1U3EZJUTGVu0rHSLJs
        W5NgwgDkMU4Tctn8sp6QDS8uXrMAVU8TzWoAL6ToIpC7KJoKBS+hR10VJaRx7HUlCrn23sdr2GXXV
        PivvROx3tTElb1yMRSSSuseDaTpRWJpVWM5KD/wTw/IT+YTPLspEFsL9wpeIKfruOS68OSavOcO3b
        eKoyZN9jt6fhjHPyiO1n+Ltd23usEmrStZ0nhKSCgpp0vMkbLWmtuxBHj1SB6Hdbonp7qcS/5sHw1
        h6xT9GKSHXVkxt4Y/hHRE/O0vpV4ONoMUaFGKU12gPJqvqq6SOLh88NGCQe1kbJ3s68Vas9hCHfw2
        AZ8ApNWw==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD8fa-0004R3-Ip; Tue, 01 Sep 2020 15:58:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 7/9] sd: open code revalidate_disk
Date:   Tue,  1 Sep 2020 17:57:46 +0200
Message-Id: <20200901155748.2884-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of calling revalidate_disk just do the work directly by
calling sd_revalidate_disk, and revalidate_disk_size where needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 95018e650f2d0c..2bec8cd526164d 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -217,7 +217,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 			sd_print_sense_hdr(sdkp, &sshdr);
 		return -EINVAL;
 	}
-	revalidate_disk(sdkp->disk);
+	sd_revalidate_disk(sdkp->disk);
 	return count;
 }
 
@@ -1706,8 +1706,10 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 static void sd_rescan(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	int ret;
 
-	revalidate_disk(sdkp->disk);
+	ret = sd_revalidate_disk(sdkp->disk);
+	revalidate_disk_size(sdkp->disk, ret == 0);
 }
 
 static int sd_ioctl(struct block_device *bdev, fmode_t mode,
-- 
2.28.0

