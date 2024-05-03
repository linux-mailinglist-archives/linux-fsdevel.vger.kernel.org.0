Return-Path: <linux-fsdevel+bounces-18553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACC8BA45E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 02:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA331F23EA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C670FEC0;
	Fri,  3 May 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FLyhRQk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B87AD23;
	Fri,  3 May 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695026; cv=none; b=LC9bsIHDzZpq7umHugMjVwpNuTzHKI3XVn6KUOBOrxVTlpDxCok2CuAeNq/iue7+EZ2MYGIQs319uB98HAA4wUpmTvgYI16k/NG9Ulw0E6zZN5goqqhoFjd2Obwv/YdhzlDg6kp0fzM76q6ZHDmTrq1hq+0SU0GPgRELjtzp2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695026; c=relaxed/simple;
	bh=a0/gi46X7y3jTzuYMVtk8CxDU9bN3SH73R3EnPynBN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b//7xzbqwDxPlfFumFHMGDLySUXlkxroB6ckjthrp/3+5glFcz/zy2nhKiXWNRiizu3mGasMQ7AgjXnoWey/aGqEGLyCEPJecbq9fNTpqf46RCuaNWDBTQ6Esw1ZVr/L4/Ya+8kxd8VO/AK7QQMki5Wehpp4R+eFx2hbb2y4/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FLyhRQk0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hnUHDwXj43ZP3pn4nhfhUHKbkW/EIaViouUuR/zUvvQ=; b=FLyhRQk0SuesAp8ZfuH1ZS40GK
	ma+/xNeWkgwx1cJ82Hva7VMrXA30rkaz5Z5h59jC+n5hkiMlfXxOyM1QfhWa0aVza7evHEQZsevk7
	mDKN3XV5kaELurrGp/+nodG96liN14HAxNxRc9WpDLfewWmKSdH/yRRZdps0ou5qCsaUcf3UquaDw
	s44M+WR6pzw6bFdlnop9vsIf6eRcSskHXoxgGtlnx80KpxZkY2oNIRJXBiXJGt9FgQ4hlHeRtnKnB
	/T7wdo8Nji0SQmgXkENdRQYxRdHL3nS/2X/u2wt35RCz8e3WkVbAjdPLk7sK5CNyk79k5HUELdV7u
	ZyWO7bEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2gVK-009tPa-2V;
	Fri, 03 May 2024 00:10:23 +0000
Date: Fri, 3 May 2024 01:10:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>,
	linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 6/8] bdev: move ->bd_has_subit_bio to ->__bd_flags
Message-ID: <20240503001022.GF2357260@ZenIV>
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

In bdev_alloc() we have all flags initialized to false, so
assignment to ->bh_has_submit_bio n there is a no-op unless
we have partno != 0 and flag already set on entire device.

In device_add_disk() we have just allocated the block_device
in question and it had been a full-device one, so the flag
is guaranteed to be still clear when we get to assignment.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 block/bdev.c              | 6 ++----
 block/blk-core.c          | 4 ++--
 block/genhd.c             | 3 ++-
 include/linux/blk_types.h | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 9df9a59f0900..fae30eae7741 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -414,10 +414,8 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	atomic_set(&bdev->__bd_flags, partno);
 	bdev->bd_inode = inode;
 	bdev->bd_queue = disk->queue;
-	if (partno)
-		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
-	else
-		bdev->bd_has_submit_bio = false;
+	if (partno && bdev_test_flag(disk->part0, BD_HAS_SUBMIT_BIO))
+		bdev_set_flag(bdev, BD_HAS_SUBMIT_BIO);
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/block/blk-core.c b/block/blk-core.c
index 20322abc6082..f61460b65408 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -615,7 +615,7 @@ static void __submit_bio(struct bio *bio)
 	if (unlikely(!blk_crypto_bio_prep(&bio)))
 		return;
 
-	if (!bio->bi_bdev->bd_has_submit_bio) {
+	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
@@ -723,7 +723,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
 	 */
 	if (current->bio_list)
 		bio_list_add(&current->bio_list[0], bio);
-	else if (!bio->bi_bdev->bd_has_submit_bio)
+	else if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO))
 		__submit_bio_noacct_mq(bio);
 	else
 		__submit_bio_noacct(bio);
diff --git a/block/genhd.c b/block/genhd.c
index bb29a68e1d67..19cd1a31fa80 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	elevator_init_mq(disk->queue);
 
 	/* Mark bdev as having a submit_bio, if needed */
-	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
+	if (disk->fops->submit_bio)
+		bdev_set_flag(disk->part0, BD_HAS_SUBMIT_BIO);
 
 	/*
 	 * If the driver provides an explicit major number it also must provide
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e45a490d488e..11b9e8eeb79f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -49,7 +49,7 @@ struct block_device {
 #define BD_PARTNO		255	// lower 8 bits; assign-once
 #define BD_READ_ONLY		(1u<<8) // read-only policy
 #define BD_WRITE_HOLDER		(1u<<9)
-	bool			bd_has_submit_bio;
+#define BD_HAS_SUBMIT_BIO	(1u<<10)
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
-- 
2.39.2


