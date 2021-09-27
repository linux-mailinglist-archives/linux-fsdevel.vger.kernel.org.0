Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0164141A2B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 00:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbhI0WKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhI0WJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:09:56 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1DCC08E870;
        Mon, 27 Sep 2021 15:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NSa3Hc3QelnUxQ+cXABVnHVUgnn9TSfKMH79tpEpz9k=; b=olC0Eh+a79EwdFLpg94sReES7g
        zIIWqlDYfSX+JEAD7km/lvvUItHvyCJKk3lCoeSUW/FTenHdat9NwotAFsMRFOYGpmnhgBpAWkH0S
        xk+Tb/3sJw2mxnq1PPZNxGNhvdZ9+l0UwndhCCDTCj2i6YjLqdgmJSoJq0/nnX2F4yhvy4VEC9oWT
        H6pCoRve7NNVs2t9Ao8PPlgwMTXqCeYPmhaoXuKX+/iV3Btc2+GDu8+RW56yNcM8CyZVxSIAfnqCl
        Z4DfzsGRc87G7D+k+foRo2hrwIaHX4MbDg0ACVzgFwvFqMqf8cOhYkpkR2HerDu4ol/xdiBshE8q6
        DEsXnGrA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyij-004Vab-84; Mon, 27 Sep 2021 22:03:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/2] block: add __must_check for *add_disk*() callers
Date:   Mon, 27 Sep 2021 15:03:32 -0700
Message-Id: <20210927220332.1074647-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220332.1074647-1-mcgrof@kernel.org>
References: <20210927220332.1074647-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have done a spring cleaning on all drivers and added
error checking / handling, let's keep it that way and ensure
no new drivers fail to stick with it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c         | 6 +++---
 include/linux/genhd.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a5a41628aa59..44c630e3377a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -394,8 +394,8 @@ static void disk_scan_partitions(struct gendisk *disk)
  * This function registers the partitioning information in @disk
  * with the kernel.
  */
-int device_add_disk(struct device *parent, struct gendisk *disk,
-		     const struct attribute_group **groups)
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups)
 
 {
 	struct device *ddev = disk_to_dev(disk);
@@ -540,7 +540,7 @@ int device_add_disk(struct device *parent, struct gendisk *disk,
 out_free_ext_minor:
 	if (disk->major == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(disk->first_minor);
-	return WARN_ON_ONCE(ret); /* keep until all callers handle errors */
+	return ret;
 }
 EXPORT_SYMBOL(device_add_disk);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5828ecda5c49..8d78d36c424e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -214,9 +214,9 @@ static inline dev_t disk_devt(struct gendisk *disk)
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
 /* block/genhd.c */
-int device_add_disk(struct device *parent, struct gendisk *disk,
-		const struct attribute_group **groups);
-static inline int add_disk(struct gendisk *disk)
+int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
+				 const struct attribute_group **groups);
+static inline int __must_check add_disk(struct gendisk *disk)
 {
 	return device_add_disk(NULL, disk, NULL);
 }
-- 
2.30.2

