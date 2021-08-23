Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C453F4AFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbhHWMoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 08:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbhHWMoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:44:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A02BC061575;
        Mon, 23 Aug 2021 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XOyrIdXzfMrESojqV8HkmO0F0c3gOBeNhUoAvr7Sipw=; b=sQmlGFt1GrFClSH0QLjPYn9os8
        cME5Dnv3rz16jhTkbtvLd29cqfBUDlHR0GpsIvghh3OVkXqsYfYri9T8QDInHdR1gpfoB/34gWza0
        thCJObabKtWQr1bzgg/kV+p6DF6EE+AdwktNZxairi7YMHt0eqaiWrWPV13C3ydQ6hJIDUgmxmc57
        3NA/DVczRa4JnUSHv6uNVGGpzv9ToeTMBxEAPrjhprUnEM+Iq+yXkdBUNFXS7AiZRfX7OueP3cZUn
        Yz94d8vnfgOJ1xl9LhOnUiGj8REGeVzst2WG7ZMeTcn6kHURrcxdTqQ8k+1hXPThg13i0uUGji3ts
        ODVpeVdQ==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9G9-009jNV-T1; Mon, 23 Aug 2021 12:41:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 7/9] dax: stub out dax_supported for !CONFIG_FS_DAX
Date:   Mon, 23 Aug 2021 14:35:14 +0200
Message-Id: <20210823123516.969486-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210823123516.969486-1-hch@lst.de>
References: <20210823123516.969486-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

dax_supported calls into ->dax_supported which checks for fsdax support.
Don't bother building it for !CONFIG_FS_DAX as it will always return
false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c | 36 ++++++++++++++++++------------------
 include/linux/dax.h | 18 ++++++++++--------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e8ccb3e956b..eed02729add3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -201,6 +201,24 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return true;
 }
 EXPORT_SYMBOL_GPL(generic_fsdax_supported);
+
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len)
+{
+	bool ret = false;
+	int id;
+
+	if (!dax_dev)
+		return false;
+
+	id = dax_read_lock();
+	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
+		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
+						  start, len);
+	dax_read_unlock(id);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_supported);
 #endif /* CONFIG_FS_DAX */
 
 /**
@@ -350,24 +368,6 @@ long dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff, long nr_pages,
 }
 EXPORT_SYMBOL_GPL(dax_direct_access);
 
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len)
-{
-	bool ret = false;
-	int id;
-
-	if (!dax_dev)
-		return false;
-
-	id = dax_read_lock();
-	if (dax_alive(dax_dev) && dax_dev->ops->dax_supported)
-		ret = dax_dev->ops->dax_supported(dax_dev, bdev, blocksize,
-						  start, len);
-	dax_read_unlock(id);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dax_supported);
-
 size_t dax_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0a3ef9701e03..32dce5763f2c 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -57,8 +57,6 @@ static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	__set_dax_synchronous(dax_dev);
 }
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -101,12 +99,6 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
-static inline bool dax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t len)
-{
-	return false;
-}
 static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 				struct dax_device *dax_dev)
 {
@@ -127,6 +119,9 @@ bool generic_fsdax_supported(struct dax_device *dax_dev,
 		struct block_device *bdev, int blocksize, sector_t start,
 		sector_t sectors);
 
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len);
+
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 	put_dax(dax_dev);
@@ -149,6 +144,13 @@ static inline bool bdev_dax_supported(struct block_device *bdev,
 
 #define generic_fsdax_supported		NULL
 
+static inline bool dax_supported(struct dax_device *dax_dev,
+		struct block_device *bdev, int blocksize, sector_t start,
+		sector_t len)
+{
+	return false;
+}
+
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
-- 
2.30.2

