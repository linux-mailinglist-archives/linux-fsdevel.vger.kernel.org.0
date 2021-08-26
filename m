Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE05E3F899E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhHZOCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbhHZOCi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:02:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FCC061757;
        Thu, 26 Aug 2021 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kgSmPWR5PspFMBRZCn1nlJnOJdMWJ8tZQVh2hpCykpQ=; b=tDPXsiKr+QWUJwIzayCEfrLgUK
        2dAgWBg3MTZGzTi8NXjSmF4MDMNf99cjwP+gWTk2KHtD1vywrltU+qLScFW4uKMl3bWGrm9nK/uVK
        J0Fmx0DwGgpBYLrTGljEMSu6mF/zC6W+o+6OS6k9+hljCtL40an/ttmRYoap0H+2IhdXsQgSsaNB4
        nZvAGYQ49KifRXyeY1U3PkuyDJFSr2FUtf3u65l6OHZiVfVNo1LwP39RLxTm+Frs3NhjAQ6MdzqfD
        mrDaj64VPH0n65IFK86/sfc7nlXa070vkOnkGiWFRBqamV03MyymeOfOmIycgbycgeLdk0dh1J6to
        bbTRlzzw==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFu6-00DME9-1Y; Thu, 26 Aug 2021 13:59:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 4/9] dax: mark dax_get_by_host static
Date:   Thu, 26 Aug 2021 15:55:05 +0200
Message-Id: <20210826135510.6293-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826135510.6293-1-hch@lst.de>
References: <20210826135510.6293-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And move the code around a bit to avoid a forward declaration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c | 109 ++++++++++++++++++++++----------------------
 include/linux/dax.h |   5 --
 2 files changed, 54 insertions(+), 60 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 3e6d7e9ee34f..e13fde57c33e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -17,6 +17,24 @@
 #include <linux/fs.h>
 #include "dax-private.h"
 
+/**
+ * struct dax_device - anchor object for dax services
+ * @inode: core vfs
+ * @cdev: optional character interface for "device dax"
+ * @host: optional name for lookups where the device path is not available
+ * @private: dax driver private data
+ * @flags: state and boolean properties
+ */
+struct dax_device {
+	struct hlist_node list;
+	struct inode inode;
+	struct cdev cdev;
+	const char *host;
+	void *private;
+	unsigned long flags;
+	const struct dax_operations *ops;
+};
+
 static dev_t dax_devt;
 DEFINE_STATIC_SRCU(dax_srcu);
 static struct vfsmount *dax_mnt;
@@ -40,6 +58,42 @@ void dax_read_unlock(int id)
 }
 EXPORT_SYMBOL_GPL(dax_read_unlock);
 
+static int dax_host_hash(const char *host)
+{
+	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
+}
+
+/**
+ * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
+ * @host: alternate name for the device registered by a dax driver
+ */
+static struct dax_device *dax_get_by_host(const char *host)
+{
+	struct dax_device *dax_dev, *found = NULL;
+	int hash, id;
+
+	if (!host)
+		return NULL;
+
+	hash = dax_host_hash(host);
+
+	id = dax_read_lock();
+	spin_lock(&dax_host_lock);
+	hlist_for_each_entry(dax_dev, &dax_host_list[hash], list) {
+		if (!dax_alive(dax_dev)
+				|| strcmp(host, dax_dev->host) != 0)
+			continue;
+
+		if (igrab(&dax_dev->inode))
+			found = dax_dev;
+		break;
+	}
+	spin_unlock(&dax_host_lock);
+	dax_read_unlock(id);
+
+	return found;
+}
+
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 
@@ -202,24 +256,6 @@ enum dax_device_flags {
 	DAXDEV_SYNC,
 };
 
-/**
- * struct dax_device - anchor object for dax services
- * @inode: core vfs
- * @cdev: optional character interface for "device dax"
- * @host: optional name for lookups where the device path is not available
- * @private: dax driver private data
- * @flags: state and boolean properties
- */
-struct dax_device {
-	struct hlist_node list;
-	struct inode inode;
-	struct cdev cdev;
-	const char *host;
-	void *private;
-	unsigned long flags;
-	const struct dax_operations *ops;
-};
-
 static ssize_t write_cache_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -417,11 +453,6 @@ bool dax_alive(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_alive);
 
-static int dax_host_hash(const char *host)
-{
-	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
-}
-
 /*
  * Note, rcu is not protecting the liveness of dax_dev, rcu is ensuring
  * that any fault handlers or operations that might have seen
@@ -618,38 +649,6 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
-/**
- * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
- * @host: alternate name for the device registered by a dax driver
- */
-struct dax_device *dax_get_by_host(const char *host)
-{
-	struct dax_device *dax_dev, *found = NULL;
-	int hash, id;
-
-	if (!host)
-		return NULL;
-
-	hash = dax_host_hash(host);
-
-	id = dax_read_lock();
-	spin_lock(&dax_host_lock);
-	hlist_for_each_entry(dax_dev, &dax_host_list[hash], list) {
-		if (!dax_alive(dax_dev)
-				|| strcmp(host, dax_dev->host) != 0)
-			continue;
-
-		if (igrab(&dax_dev->inode))
-			found = dax_dev;
-		break;
-	}
-	spin_unlock(&dax_host_lock);
-	dax_read_unlock(id);
-
-	return found;
-}
-EXPORT_SYMBOL_GPL(dax_get_by_host);
-
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b52f084aa643..379739b55408 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -41,7 +41,6 @@ struct dax_operations {
 extern struct attribute_group dax_attribute_group;
 
 #if IS_ENABLED(CONFIG_DAX)
-struct dax_device *dax_get_by_host(const char *host);
 struct dax_device *alloc_dax(void *private, const char *host,
 		const struct dax_operations *ops, unsigned long flags);
 void put_dax(struct dax_device *dax_dev);
@@ -73,10 +72,6 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
-static inline struct dax_device *dax_get_by_host(const char *host)
-{
-	return NULL;
-}
 static inline struct dax_device *alloc_dax(void *private, const char *host,
 		const struct dax_operations *ops, unsigned long flags)
 {
-- 
2.30.2

