Return-Path: <linux-fsdevel+bounces-18018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31558B4D63
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357391F21352
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE49A7441C;
	Sun, 28 Apr 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J6ko6ECE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686E7351A;
	Sun, 28 Apr 2024 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714328382; cv=none; b=Hmrf8+jKsPBPHh92zK+uUDpr+ZrmcqWe3SStY/Y4qWJO2aStWR+FP0Y+50DjgBzdJxzViiab+b/R7xqS6tz8214o/22aS3uiOEHdqpTjdUgd1IXClsQv86O51zNnkAG47oaiR1vXOltTjBM7fRKE8MSxColk72eJi1PdkEoSwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714328382; c=relaxed/simple;
	bh=KHWabH/Dh5y+pJMK4dr1ObQ1jU/r8N2vAS44IfI5sJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkPRUCwsIHnVE8nwTiDy39+mjP/l3FGOF7NnVoloimVOddb0gYwL70pPDdIUhjQ6N20K6ckGjYMNtDwXCQQ/1W9pWa7gJpRpmsj9tCkOKybM0ZABfG1fG4J/nSP3YfJopNQeHYB1EtN03a8s02TKktJw7PQT1vziM5qa7uCZmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J6ko6ECE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H5pYDAKHCRpClX9jMWalas5W1Jyl6HgR4eTgrthlE7Q=; b=J6ko6ECEXnhOkftsRWA1k6Tac8
	u3QkzK02ARkqO6LCfpvIfdV/f9xz00AFV6xxjdap8DtC2k/1RTODpuT0/QMMeDfR4Ctb1W6cw1IGr
	aigdDKJzRHUMMmqxYtaT8pLvtdC/P4N69GuwhoUsBvTLiqY9fIG4axJUt+zWkawdqxS5OEMgdrwhN
	nUkadOASticQ++AGUCETjl91IgX2RN4aFBd5PJjkaG5JUBeTLgECi2QhnrppKlfgXzA5rJYRiCS/l
	kLk291G0X2gW96H+9gTTjyciXWaniL91BXjpnvWSc4Ug34s6Hkgo82yJ40GqzwDk9FbsxRtSWt9v6
	M2fSKWOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s197e-006uuH-21;
	Sun, 28 Apr 2024 18:19:34 +0000
Date: Sun, 28 Apr 2024 19:19:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] swapon(2): open swap with O_EXCL
Message-ID: <20240428181934.GV2118490@ZenIV>
References: <20240427210920.GR2118490@ZenIV>
 <20240427211128.GD1495312@ZenIV>
 <CAHk-=wiag-Dn=7v0tX2UazhMTBzG7P42FkgLSsVc=rfN8_NC2A@mail.gmail.com>
 <20240427234623.GS2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427234623.GS2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 28, 2024 at 12:46:23AM +0100, Al Viro wrote:
> On Sat, Apr 27, 2024 at 02:40:22PM -0700, Linus Torvalds wrote:
> > On Sat, 27 Apr 2024 at 14:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > ... eliminating the need to reopen block devices so they could be
> > > exclusively held.
> > 
> > This looks like a good change, but it raises the question of why we
> > did it this odd way to begin with?
> > 
> > Is it just because O_EXCL without O_CREAT is kind of odd, and only has
> > meaning for block devices?
> > 
> > Or is it just that before we used fiel pointers for block devices, the
> > old model made more sense?
> > 
> > Anyway, I like it, it just makes me go "why didn't we do it that way
> > originally?"
> 
> Exclusion for swap partitions:
> 
> commit 75e9c9e1bffbe4a1767172855296b94ccba28f71
> Author: Alexander Viro <viro@math.psu.edu>
> Date:   Mon Mar 4 22:56:47 2002 -0800
> 
>     [PATCH] death of is_mounted() and aother fixes
> 
> 
> O_EXCL for block devices:
> 
> commit c366082d9ed0a0d3c46441d1b3fdf895d8e55ca9
> Author: Andrew Morton <akpm@osdl.org>
> Date:   Wed Aug 20 10:26:57 2003 -0700
> 
>     [PATCH] Allow O_EXCL on a block device to claim exclusive use.
> 
> IOW, O_EXCL hadn't been available at the time - it had been implemented
> on top of bd_claim()/bd_release() introduced in the same earlier commit.
> 
> Switching swap exclusion to O_EXCL could've been done back in 2003 or
> at any later point; it's just that swapon(2)/swapoff(2) is something that
> rarely gets a look...

FWIW, pretty much the same can be done with zram - open with O_EXCL and to
hell with reopening.  Guys, are there any objections to that?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..d882a0c7b522 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -426,11 +426,10 @@ static void reset_bdev(struct zram *zram)
 	if (!zram->backing_dev)
 		return;
 
-	fput(zram->bdev_file);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->bdev_file = NULL;
+	zram->bdev = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
@@ -473,10 +472,8 @@ static ssize_t backing_dev_store(struct device *dev,
 	size_t sz;
 	struct file *backing_dev = NULL;
 	struct inode *inode;
-	struct address_space *mapping;
 	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
-	struct file *bdev_file = NULL;
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
@@ -497,15 +494,14 @@ static ssize_t backing_dev_store(struct device *dev,
 	if (sz > 0 && file_name[sz - 1] == '\n')
 		file_name[sz - 1] = 0x00;
 
-	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE, 0);
+	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE|O_EXCL, 0);
 	if (IS_ERR(backing_dev)) {
 		err = PTR_ERR(backing_dev);
 		backing_dev = NULL;
 		goto out;
 	}
 
-	mapping = backing_dev->f_mapping;
-	inode = mapping->host;
+	inode = backing_dev->f_mapping->host;
 
 	/* Support only block device in this moment */
 	if (!S_ISBLK(inode->i_mode)) {
@@ -513,14 +509,6 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
-	if (IS_ERR(bdev_file)) {
-		err = PTR_ERR(bdev_file);
-		bdev_file = NULL;
-		goto out;
-	}
-
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
@@ -531,7 +519,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	reset_bdev(zram);
 
-	zram->bdev_file = bdev_file;
+	zram->bdev = I_BDEV(inode);
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
@@ -544,9 +532,6 @@ static ssize_t backing_dev_store(struct device *dev,
 out:
 	kvfree(bitmap);
 
-	if (bdev_file)
-		fput(bdev_file);
-
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
 
@@ -587,7 +572,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(file_bdev(zram->bdev_file), 1, parent->bi_opf, GFP_NOIO);
+	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_chain(bio, parent);
@@ -703,7 +688,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, file_bdev(zram->bdev_file), &bio_vec, 1,
+		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 		__bio_add_page(&bio, page, PAGE_SIZE, 0);
@@ -785,7 +770,7 @@ static void zram_sync_read(struct work_struct *work)
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, file_bdev(zw->zram->bdev_file), &bv, 1, REQ_OP_READ);
+	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
 	zw->error = submit_bio_wait(&bio);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 37bf29f34d26..35e322144629 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-	struct file *bdev_file;
+	struct block_device *bdev;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif

