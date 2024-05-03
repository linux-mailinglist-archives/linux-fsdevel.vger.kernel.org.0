Return-Path: <linux-fsdevel+bounces-18548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67508BA44D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA0283ED8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAA41370;
	Fri,  3 May 2024 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gIsfy8Gp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091BD360;
	Fri,  3 May 2024 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694874; cv=none; b=FKxCGgJvEOmW48K96MbM/7E2MeU1RSERigmwAfli/BEKc/Md35KmbzY55+W7loAd5UZVuM3uLNPNnyWDZc0wO1qdQzYhoIOk07glTA8rRpNXcI/4nOLaeQmIkkP3QXJnYGVID31V00X6crq314CtwJ+zVU7VGP3ZROneRg/7a0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694874; c=relaxed/simple;
	bh=m2aZ1DeTWeEYs4Hfg2zynhEj7mEerAUtys8ZINR/T5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWWcFaZbLKoh77xhDKjty6mboVaqEIeEpx8OqPOQvXSxC5U9W4esp6hCXuuXaIeGs+4c7YQSEV3xNjvn+7DuJcjMdGEnNPX1zYEFV9CXk1q4VSJwuNZW6FUHhuoaIhxG4ffrCG9x785M8a65bLnWHwWeXmIeMa+acMNoJkedegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gIsfy8Gp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Dp0BIALSGxgiIBh3V0yvPHXGeHmC+LFW7q/zZU4J9c=; b=gIsfy8Gpio0FFLsJWp6E/p1dvV
	u0CiXqtQ02hmaCjyQRYw5eOh+qb+hW42DgnnUzhyjVcvBX2QzZ7lY5Hy9RBWaPBcVWDWhRCCVhzLA
	0a4rURyEZntY2CB15nxawGPc/no6p7c2Wlu1MCgmch3XSPsPF0Zf97txzGO709vGRNbHD5wirZwVP
	pew3StXDVILVIqtGLG13ipVmQ+RvP7iOenD/pySNH1tJfgp0JlFn2NyvklAHn7aagkwykm4NARxeX
	txK3OOoFw2fZfHZ/0AU1P0zD2RKhF2GgY1ckZttsbkVTmgzecBdQoCP663UVc2yabIDoRqvclDMh0
	zBJR8a4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gSt-009tHH-0H;
	Fri, 03 May 2024 00:07:51 +0000
Date: Fri, 3 May 2024 01:07:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] wrapper for access to ->bd_partno
Message-ID: <20240503000751.GB2357260@ZenIV>
References: <20240428051232.GU2118490@ZenIV>
 <20240429052315.GB32688@lst.de>
 <20240429073107.GZ2118490@ZenIV>
 <20240429170209.GA2118490@ZenIV>
 <20240429181300.GB2118490@ZenIV>
 <20240429183041.GC2118490@ZenIV>
 <20240503000647.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503000647.GQ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On the next step it's going to get folded into a field where flags will go.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/early-lookup.c    |  2 +-
 block/partitions/core.c | 12 ++++++------
 include/linux/blkdev.h  |  7 ++++++-
 lib/vsprintf.c          |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3effbd0d35e9..3fb57f7d2b12 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -78,7 +78,7 @@ static int __init devt_from_partuuid(const char *uuid_str, dev_t *devt)
 		 * to the partition number found by UUID.
 		 */
 		*devt = part_devt(dev_to_disk(dev),
-				  dev_to_bdev(dev)->bd_partno + offset);
+				  bdev_partno(dev_to_bdev(dev)) + offset);
 	} else {
 		*devt = dev->devt;
 	}
diff --git a/block/partitions/core.c b/block/partitions/core.c
index b11e88c82c8c..edd5309dc4ba 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -173,7 +173,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 static ssize_t part_partition_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_partno);
+	return sprintf(buf, "%d\n", bdev_partno(dev_to_bdev(dev)));
 }
 
 static ssize_t part_start_show(struct device *dev,
@@ -250,7 +250,7 @@ static int part_uevent(const struct device *dev, struct kobj_uevent_env *env)
 {
 	const struct block_device *part = dev_to_bdev(dev);
 
-	add_uevent_var(env, "PARTN=%u", part->bd_partno);
+	add_uevent_var(env, "PARTN=%u", bdev_partno(part));
 	if (part->bd_meta_info && part->bd_meta_info->volname[0])
 		add_uevent_var(env, "PARTNAME=%s", part->bd_meta_info->volname);
 	return 0;
@@ -267,7 +267,7 @@ void drop_partition(struct block_device *part)
 {
 	lockdep_assert_held(&part->bd_disk->open_mutex);
 
-	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
+	xa_erase(&part->bd_disk->part_tbl, bdev_partno(part));
 	kobject_put(part->bd_holder_dir);
 
 	device_del(&part->bd_device);
@@ -338,8 +338,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	pdev->parent = ddev;
 
 	/* in consecutive minor range? */
-	if (bdev->bd_partno < disk->minors) {
-		devt = MKDEV(disk->major, disk->first_minor + bdev->bd_partno);
+	if (bdev_partno(bdev) < disk->minors) {
+		devt = MKDEV(disk->major, disk->first_minor + bdev_partno(bdev));
 	} else {
 		err = blk_alloc_ext_minor();
 		if (err < 0)
@@ -404,7 +404,7 @@ static bool partition_overlaps(struct gendisk *disk, sector_t start,
 
 	rcu_read_lock();
 	xa_for_each_start(&disk->part_tbl, idx, part, 1) {
-		if (part->bd_partno != skip_partno &&
+		if (bdev_partno(part) != skip_partno &&
 		    start < part->bd_start_sect + bdev_nr_sectors(part) &&
 		    start + length > part->bd_start_sect) {
 			overlap = true;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..32549d675955 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -720,6 +720,11 @@ void invalidate_disk(struct gendisk *disk);
 void set_disk_ro(struct gendisk *disk, bool read_only);
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
+static inline u8 bdev_partno(const struct block_device *bdev)
+{
+	return bdev->bd_partno;
+}
+
 static inline int get_disk_ro(struct gendisk *disk)
 {
 	return disk->part0->bd_read_only ||
@@ -1095,7 +1100,7 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
-	return bdev->bd_partno;
+	return bdev_partno(bdev) != 0;
 }
 
 enum blk_default_limits {
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3f9f1b959ef0..cdd4e2314bfc 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -972,7 +972,7 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 				*buf = 'p';
 			buf++;
 		}
-		buf = number(buf, end, bdev->bd_partno, spec);
+		buf = number(buf, end, bdev_partno(bdev), spec);
 	}
 	return buf;
 }
-- 
2.39.2


