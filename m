Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C506D2C54AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 14:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389923AbgKZNHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 08:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbgKZNHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:07:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1CAC0613D4;
        Thu, 26 Nov 2020 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aXV3aDcarMWm87S3K48qh326Jqh2T5iEz0okUiuykIU=; b=CdbC5hlwj31l+0IcsFPnJP1nL1
        +kxO6fnofY15Q8oWyZkGLPmr7gioA2In6NDJY5N83HYYS68cvToFcHGWLrMo7DDpM//js2sxCscAV
        70J3mUQiLizIOkrp+AWra1+ubkP00mS52zOg4rtxpHO5F2qyOwxNAAq+8RfKOFTNzFchlm1NnwdFy
        B9vQoYXRi4VrsNweREv2Bi5/AEghh77WnXpyFZqpajHkQOfvk9ozHa05FKD6BAXWpjbiQduV+184Z
        BnJS0sT1e1hyRM1MlkFl6avl9qflwdCVAnriAgpt09AQLVsFImFuQvsKjpG3KoJpbzehpvTz5cfpc
        afAK1+Sg==;
Received: from [2001:4bb8:18c:1dd6:27b8:b8a1:c13e:ceb1] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGz9-00040j-PL; Thu, 26 Nov 2020 13:06:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 16/44] init: refactor name_to_dev_t
Date:   Thu, 26 Nov 2020 14:03:54 +0100
Message-Id: <20201126130422.92945-17-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126130422.92945-1-hch@lst.de>
References: <20201126130422.92945-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split each case into a self-contained helper, and move the block
dependent code entirely under the pre-existing #ifdef CONFIG_BLOCK.
This allows to remove the blk_lookup_devt stub in genhd.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/genhd.h |   7 +-
 init/do_mounts.c      | 183 +++++++++++++++++++++---------------------
 2 files changed, 91 insertions(+), 99 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 22f5b9fd96f8bf..ca5e356084c353 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -388,18 +388,13 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 }
 #endif /* CONFIG_SYSFS */
 
+dev_t blk_lookup_devt(const char *name, int partno);
 #ifdef CONFIG_BLOCK
 void printk_all_partitions(void);
-dev_t blk_lookup_devt(const char *name, int partno);
 #else /* CONFIG_BLOCK */
 static inline void printk_all_partitions(void)
 {
 }
-static inline dev_t blk_lookup_devt(const char *name, int partno)
-{
-	dev_t devt = MKDEV(0, 0);
-	return devt;
-}
 #endif /* CONFIG_BLOCK */
 
 #endif /* _LINUX_GENHD_H */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index b5f9604d0c98a2..aef2f24461c7f1 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -90,7 +90,6 @@ static int match_dev_by_uuid(struct device *dev, const void *data)
 	return 0;
 }
 
-
 /**
  * devt_from_partuuid - looks up the dev_t of a partition by its UUID
  * @uuid_str:	char array containing ascii UUID
@@ -186,7 +185,83 @@ static int match_dev_by_label(struct device *dev, const void *data)
 
 	return 0;
 }
-#endif
+
+static dev_t devt_from_partlabel(const char *label)
+{
+	struct device *dev;
+	dev_t devt = 0;
+
+	dev = class_find_device(&block_class, NULL, label, &match_dev_by_label);
+	if (dev) {
+		devt = dev->devt;
+		put_device(dev);
+	}
+
+	return devt;
+}
+
+static dev_t devt_from_devname(const char *name)
+{
+	dev_t devt = 0;
+	int part;
+	char s[32];
+	char *p;
+
+	if (strlen(name) > 31)
+		return 0;
+	strcpy(s, name);
+	for (p = s; *p; p++) {
+		if (*p == '/')
+			*p = '!';
+	}
+
+	devt = blk_lookup_devt(s, 0);
+	if (devt)
+		return devt;
+
+	/*
+	 * Try non-existent, but valid partition, which may only exist after
+	 * opening the device, like partitioned md devices.
+	 */
+	while (p > s && isdigit(p[-1]))
+		p--;
+	if (p == s || !*p || *p == '0')
+		return 0;
+
+	/* try disk name without <part number> */
+	part = simple_strtoul(p, NULL, 10);
+	*p = '\0';
+	devt = blk_lookup_devt(s, part);
+	if (devt)
+		return devt;
+
+	/* try disk name without p<part number> */
+	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
+		return 0;
+	p[-1] = '\0';
+	return blk_lookup_devt(s, part);
+}
+#endif /* CONFIG_BLOCK */
+
+static dev_t devt_from_devnum(const char *name)
+{
+	unsigned maj, min, offset;
+	dev_t devt = 0;
+	char *p, dummy;
+
+	if (sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2 ||
+	    sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset, &dummy) == 3) {
+		devt = MKDEV(maj, min);
+		if (maj != MAJOR(devt) || min != MINOR(devt))
+			return 0;
+	} else {
+		devt = new_decode_dev(simple_strtoul(name, &p, 16));
+		if (*p)
+			return 0;
+	}
+
+	return devt;
+}
 
 /*
  *	Convert a name into device number.  We accept the following variants:
@@ -218,101 +293,23 @@ static int match_dev_by_label(struct device *dev, const void *data)
  *	name contains slashes, the device name has them replaced with
  *	bangs.
  */
-
 dev_t name_to_dev_t(const char *name)
 {
-	char s[32];
-	char *p;
-	dev_t res = 0;
-	int part;
-
+	if (strcmp(name, "/dev/nfs") == 0)
+		return Root_NFS;
+	if (strcmp(name, "/dev/cifs") == 0)
+		return Root_CIFS;
+	if (strcmp(name, "/dev/ram") == 0)
+		return Root_RAM0;
 #ifdef CONFIG_BLOCK
-	if (strncmp(name, "PARTUUID=", 9) == 0) {
-		name += 9;
-		res = devt_from_partuuid(name);
-		if (!res)
-			goto fail;
-		goto done;
-	} else if (strncmp(name, "PARTLABEL=", 10) == 0) {
-		struct device *dev;
-
-		dev = class_find_device(&block_class, NULL, name + 10,
-					&match_dev_by_label);
-		if (!dev)
-			goto fail;
-
-		res = dev->devt;
-		put_device(dev);
-		goto done;
-	}
+	if (strncmp(name, "PARTUUID=", 9) == 0)
+		return devt_from_partuuid(name + 9);
+	if (strncmp(name, "PARTLABEL=", 10) == 0)
+		return devt_from_partlabel(name + 10);
+	if (strncmp(name, "/dev/", 5) == 0)
+		return devt_from_devname(name + 5);
 #endif
-
-	if (strncmp(name, "/dev/", 5) != 0) {
-		unsigned maj, min, offset;
-		char dummy;
-
-		if ((sscanf(name, "%u:%u%c", &maj, &min, &dummy) == 2) ||
-		    (sscanf(name, "%u:%u:%u:%c", &maj, &min, &offset, &dummy) == 3)) {
-			res = MKDEV(maj, min);
-			if (maj != MAJOR(res) || min != MINOR(res))
-				goto fail;
-		} else {
-			res = new_decode_dev(simple_strtoul(name, &p, 16));
-			if (*p)
-				goto fail;
-		}
-		goto done;
-	}
-
-	name += 5;
-	res = Root_NFS;
-	if (strcmp(name, "nfs") == 0)
-		goto done;
-	res = Root_CIFS;
-	if (strcmp(name, "cifs") == 0)
-		goto done;
-	res = Root_RAM0;
-	if (strcmp(name, "ram") == 0)
-		goto done;
-
-	if (strlen(name) > 31)
-		goto fail;
-	strcpy(s, name);
-	for (p = s; *p; p++)
-		if (*p == '/')
-			*p = '!';
-	res = blk_lookup_devt(s, 0);
-	if (res)
-		goto done;
-
-	/*
-	 * try non-existent, but valid partition, which may only exist
-	 * after revalidating the disk, like partitioned md devices
-	 */
-	while (p > s && isdigit(p[-1]))
-		p--;
-	if (p == s || !*p || *p == '0')
-		goto fail;
-
-	/* try disk name without <part number> */
-	part = simple_strtoul(p, NULL, 10);
-	*p = '\0';
-	res = blk_lookup_devt(s, part);
-	if (res)
-		goto done;
-
-	/* try disk name without p<part number> */
-	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		goto fail;
-	p[-1] = '\0';
-	res = blk_lookup_devt(s, part);
-	if (res)
-		goto done;
-
-fail:
-	return 0;
-done:
-	return res;
+	return devt_from_devnum(name);
 }
 EXPORT_SYMBOL_GPL(name_to_dev_t);
 
-- 
2.29.2

