Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94973F4AF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHWMnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 08:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhHWMnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22464C061575;
        Mon, 23 Aug 2021 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5wCAc1UigPg83bYAOPKIh03rONFurX2QJOPBFrqOt18=; b=ApPcK6u+P+2G58ttWAohDIRExJ
        ZkLPdCqbsS3mDMgB2Rem97WENKK4A9V64ps9JC+6tsRb0CeBlmszdVNsUxngiXq4/sLLB6WkdVtkQ
        MOM5i64BZF0q8Y4YkzWhnSEZJ7fBU9TfXKd4/SLhzEtB0Pk+oO0phR1kBqKfnFsvTYmVJg6T2QD2b
        meZ7CFMAwGF0zECawe56cHWZEp/lcn1ybnKWKw9aDXeasgrbNc573j0iSNIWuxOAEo8Q3Bw56ZPt6
        rmDi4wsIK7I+6nqdxl72l25a+0Sw9aLJFTaFOjlFWUciGjQYEUyr3ZQ5b/daWS5LFXDgavuB/sP/F
        fIqV391A==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9Eo-009jGx-3q; Mon, 23 Aug 2021 12:40:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 6/9] dax: remove __generic_fsdax_supported
Date:   Mon, 23 Aug 2021 14:35:13 +0200
Message-Id: <20210823123516.969486-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823123516.969486-1-hch@lst.de>
References: <20210823123516.969486-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just implement generic_fsdax_supported directly out of line instead of
adding a wrapper.  Given that generic_fsdax_supported is only supplied
for CONFIG_FS_DAX builds this also allows to not provide it at all for
!CONFIG_FS_DAX builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c |  8 ++++----
 include/linux/dax.h | 16 ++--------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0f74f83101ab..8e8ccb3e956b 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -119,9 +119,8 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
 	return dax_get_by_host(bdev->bd_disk->disk_name);
 }
 EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);
-#endif
 
-bool __generic_fsdax_supported(struct dax_device *dax_dev,
+bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors)
 {
@@ -201,7 +200,8 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	}
 	return true;
 }
-EXPORT_SYMBOL_GPL(__generic_fsdax_supported);
+EXPORT_SYMBOL_GPL(generic_fsdax_supported);
+#endif /* CONFIG_FS_DAX */
 
 /**
  * __bdev_dax_supported() - Check if the device supports dax for filesystem
@@ -360,7 +360,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 		return false;
 
 	id = dax_read_lock();
-	if (dax_alive(dax_dev))
+	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
 		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
 						  start, len);
 	dax_read_unlock(id);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 379739b55408..0a3ef9701e03 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -123,16 +123,9 @@ static inline bool bdev_dax_supported(struct block_device *bdev, int blocksize)
 	return __bdev_dax_supported(bdev, blocksize);
 }
 
-bool __generic_fsdax_supported(struct dax_device *dax_dev,
+bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors);
-static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t sectors)
-{
-	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
-			sectors);
-}
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -154,12 +147,7 @@ static inline bool bdev_dax_supported(struct block_device *bdev,
 	return false;
 }
 
-static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t sectors)
-{
-	return false;
-}
+#define generic_fsdax_supported		NULL
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
-- 
2.30.2

