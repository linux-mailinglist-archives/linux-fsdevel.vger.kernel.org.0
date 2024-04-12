Return-Path: <linux-fsdevel+bounces-16769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7F8A253E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C921F22469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866CF1BC23;
	Fri, 12 Apr 2024 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="g/z90OwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439561B5AA;
	Fri, 12 Apr 2024 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896890; cv=none; b=mf76ttY72W21sQQrtwHThf3Z9lCUFLGmsLDg1+iSVeDi8MucmSrOES1k36ruCZuby5Vyf/kn4CoEcDTvVIS4zSiMWOS8kYL5tH6kg0dMcpJs0JPkeKTh4ezX17gCCcSk7KksrO1B8ppqkdXVvOgiXuHApY3v26U68aBx2/n0K2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896890; c=relaxed/simple;
	bh=z/LOpcSzeOyZbYTDmi18DQjPd0NiPfv3eoOL1VTh0P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBXG5XaR5zDL8S2BO97GUcXAvMWW/MOuaCKfbjlc78qTAkdcMQdLnj7YodYl35NxjfMeRIRSmOs3a2NuXr9UpMf1bQ3/Hp9+gTnI5b4fqUzpl5YBhElgldnE1m7fKOXIM0isUcBwnsyhEXC+NbsF5jFnmbhwaj7hrrh6qO6BAG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=g/z90OwG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kxUK7vnEnWrzxvUtGitETuSyZ6Al5NMvCSvPBvG8VLc=; b=g/z90OwGy0lAqXEUuZsQMhK6P6
	58WTJSFAscxus66wG8ENrL4XNwJxWpXXeM3yU2ppGzN1ELcXKVjEfVIbVSp+SV1uI09vBQVeeBS3v
	VWETDtn0J/62nUrYQYiX+NLicqtHKcc7CWhQg4kRoE2VcGk9pD89hQCwy+jj4Sz/KQj6OHGJmZqGZ
	3EgKYHgPqtd3RJaRf4ycO3o0XtAl/Fpntu9fhJppQ8TVULoAdNEJPp5IsNOkwFMcmNymw/piGOflm
	/DzdjpJ9n0LXjmx8pHEsdNPMcSKc1JvHitIGPerGgKNO6HqSfsPFFOcLPHV4SxZ31pNeH3f1CFKbk
	aVe4jjKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rv8iy-00AwK6-25;
	Fri, 12 Apr 2024 04:41:16 +0000
Date: Fri, 12 Apr 2024 05:41:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
Message-ID: <20240412044116.GL2118490@ZenIV>
References: <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3>
 <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV>
 <20240411144930.GI2118490@ZenIV>
 <d89916c0-6220-449e-ff5f-f299fd4a1483@huaweicloud.com>
 <20240412025910.GJ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412025910.GJ2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Apr 12, 2024 at 03:59:10AM +0100, Al Viro wrote:
> for multiple writers, but you need it anyway - e.g. this
>         if (bdev->bd_disk->fops->set_read_only) {
> 		ret = bdev->bd_disk->fops->set_read_only(bdev, n);
> 		if (ret)
> 			return ret;
> 	}
> 	bdev->bd_read_only = n;
> will need the exclusion over the entire "call ->set_read_only() and set
> the flag", not just for setting the flag itself.
> 
> And yes, it's a real-world bug - two threads calling BLKROSET on the
> same opened file can race, with inconsistency between the flag and
> whatever state ->set_read_only() modifies.

BLKROSET is CAP_SYS_ADMIN-only, so it's not a CVE fodder; the sky
is not falling.  The bug is real, though.

I see Christoph's postings in that thread; the thing is, it's not
just the flags that need to be protected.  If we end up deciding
that serialization for different flags should not be tied to the
same thing (which is reasonable - e.g. md_set_read_only() is not
something you want to shove under existing lock), I would still
suggest something along the lines of

	u32 __bd_flags;		// partno and flags

static inline u8 bd_partno(struct block_device *bdev)
{
	return bdev->__bd_flags & 0xff;
}

static void bd_set_flag(struct block_device *bdev, int flag)
{
	u32 v = bdev->__bd_flags;

	for (;;) {
		u32 w = cmpxchg(&bdev->__bd_flags, v, v | (1 << (flag + 8)));
		if (w == v)
			return;
		v = w;
	}
}

and similar for bd_clear_flag().  Changes of ->bd_partno never
happen - we set it at allocation time and never modify the sucker.

This is orthogonal to BLKROSET/BLKROSET exclusion, converting
->bd_inode accesses, etc.

Christoph, do you have any problems with that approach?

COMPLETELY UNTESTED patch along those lines follows; if it works,
it would need to be carved up.  And I would probably switch the
places where we do if (bdev->bd_partno) to if (bdev_is_partition(bdev)),
for better readability.

I'd converted only those 3 flags; again, this is just an untested
illustration to the above.

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..9aa23620fe92 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -411,13 +411,11 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 	mutex_init(&bdev->bd_fsfreeze_mutex);
 	spin_lock_init(&bdev->bd_size_lock);
 	mutex_init(&bdev->bd_holder_lock);
-	bdev->bd_partno = partno;
+	bdev->__bd_flags = partno;
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
@@ -624,7 +622,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 		bdev->bd_holder = NULL;
 		bdev->bd_holder_ops = NULL;
 		mutex_unlock(&bdev->bd_holder_lock);
-		if (bdev->bd_write_holder)
+		if (bdev_test_flag(bdev, BD_WRITE_HOLDER))
 			unblock = true;
 	}
 	if (!whole->bd_holders)
@@ -640,7 +638,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 	 */
 	if (unblock) {
 		disk_unblock_events(bdev->bd_disk);
-		bdev->bd_write_holder = false;
+		bdev_clear_flag(bdev, BD_WRITE_HOLDER);
 	}
 }
 
@@ -892,9 +890,10 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		 * writeable reference is too fragile given the way @mode is
 		 * used in blkdev_get/put().
 		 */
-		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
+		if ((mode & BLK_OPEN_WRITE) &&
+		    !bdev_test_flag(bdev, BD_WRITE_HOLDER) &&
 		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
-			bdev->bd_write_holder = true;
+			bdev_set_flag(bdev, BD_WRITE_HOLDER);
 			unblock_events = false;
 		}
 	}
diff --git a/block/blk-core.c b/block/blk-core.c
index a16b5abdbbf5..6a28b6b7062a 100644
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
@@ -759,7 +759,7 @@ void submit_bio_noacct(struct bio *bio)
 	if (!bio_flagged(bio, BIO_REMAPPED)) {
 		if (unlikely(bio_check_eod(bio)))
 			goto end_io;
-		if (bdev->bd_partno && unlikely(blk_partition_remap(bio)))
+		if (bdev_partno(bdev) && unlikely(blk_partition_remap(bio)))
 			goto end_io;
 	}
 
@@ -989,7 +989,7 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
 			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
 	}
-	if (part->bd_partno) {
+	if (bdev_partno(part)) {
 		part = bdev_whole(part);
 		goto again;
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32afb87efbd0..1c4bd891fd6d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -92,7 +92,7 @@ static bool blk_mq_check_inflight(struct request *rq, void *priv)
 	struct mq_inflight *mi = priv;
 
 	if (rq->part && blk_do_io_stat(rq) &&
-	    (!mi->part->bd_partno || rq->part == mi->part) &&
+	    (!bdev_partno(mi->part) || rq->part == mi->part) &&
 	    blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
 		mi->inflight[rq_data_dir(rq)]++;
 
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
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaa..be173e4ff43d 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -402,7 +402,10 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
 		if (ret)
 			return ret;
 	}
-	bdev->bd_read_only = n;
+	if (n)
+		bdev_set_flag(bdev, BD_READ_ONLY);
+	else
+		bdev_clear_flag(bdev, BD_READ_ONLY);
 	return 0;
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
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index cb1526ec44b5..bbbcbb36fb6e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -45,10 +45,7 @@ struct block_device {
 	struct request_queue *	bd_queue;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
-	bool			bd_read_only;	/* read-only policy */
-	u8			bd_partno;
-	bool			bd_write_holder;
-	bool			bd_has_submit_bio;
+	u32			__bd_flags;	// partition number + flags
 	dev_t			bd_dev;
 	struct inode		*bd_inode;	/* will die */
 
@@ -86,6 +83,12 @@ struct block_device {
 #define bdev_kobj(_bdev) \
 	(&((_bdev)->bd_device.kobj))
 
+enum {
+	BD_READ_ONLY,		// read-only policy
+	BD_WRITE_HOLDER,
+	BD_HAS_SUBMIT_BIO
+};
+
 /*
  * Block error status values.  See block/blk-core:blk_errors for the details.
  * Alpha cannot write a byte atomically, so we need to use 32-bit value.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be..d556cec9224b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -720,15 +720,51 @@ void invalidate_disk(struct gendisk *disk);
 void set_disk_ro(struct gendisk *disk, bool read_only);
 void disk_uevent(struct gendisk *disk, enum kobject_action action);
 
+static inline u8 bdev_partno(const struct block_device *bdev)
+{
+	return bdev->__bd_flags & 0xff;
+}
+
+static inline bool bdev_test_flag(const struct block_device *bdev, int flag)
+{
+	return bdev->__bd_flags & (1 << (flag + 8));
+}
+
+static inline void bdev_set_flag(struct block_device *bdev, int flag)
+{
+	u32 v = bdev->__bd_flags;
+
+	for (;;) {
+		u32 w = cmpxchg(&bdev->__bd_flags, v, v | (1 << (flag + 8)));
+
+		if (v == w)
+			return;
+		v = w;
+	}
+}
+
+static inline void bdev_clear_flag(struct block_device *bdev, int flag)
+{
+	u32 v = bdev->__bd_flags;
+
+	for (;;) {
+		u32 w = cmpxchg(&bdev->__bd_flags, v, v & ~(1 << (flag + 8)));
+
+		if (v == w)
+			return;
+		v = w;
+	}
+}
+
 static inline int get_disk_ro(struct gendisk *disk)
 {
-	return disk->part0->bd_read_only ||
+	return bdev_test_flag(disk->part0, BD_READ_ONLY) ||
 		test_bit(GD_READ_ONLY, &disk->state);
 }
 
 static inline int bdev_read_only(struct block_device *bdev)
 {
-	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
+	return bdev_test_flag(bdev, BD_READ_ONLY) || get_disk_ro(bdev->bd_disk);
 }
 
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
@@ -1095,7 +1131,7 @@ static inline int sb_issue_zeroout(struct super_block *sb, sector_t block,
 
 static inline bool bdev_is_partition(struct block_device *bdev)
 {
-	return bdev->bd_partno;
+	return bdev_partno(bdev) != 0;
 }
 
 enum blk_default_limits {
diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index abeba356bc3f..ec7eb365b152 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -59,7 +59,7 @@ static inline void part_stat_set_all(struct block_device *part, int value)
 
 #define part_stat_add(part, field, addnd)	do {			\
 	__part_stat_add((part), field, addnd);				\
-	if ((part)->bd_partno)						\
+	if (bdev_partno(part))						\
 		__part_stat_add(bdev_whole(part), field, addnd);	\
 } while (0)
 
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 552738f14275..e05583e54fa5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -966,13 +966,13 @@ char *bdev_name(char *buf, char *end, struct block_device *bdev,
 
 	hd = bdev->bd_disk;
 	buf = string(buf, end, hd->disk_name, spec);
-	if (bdev->bd_partno) {
+	if (bdev_partno(bdev)) {
 		if (isdigit(hd->disk_name[strlen(hd->disk_name)-1])) {
 			if (buf < end)
 				*buf = 'p';
 			buf++;
 		}
-		buf = number(buf, end, bdev->bd_partno, spec);
+		buf = number(buf, end, bdev_partno(bdev), spec);
 	}
 	return buf;
 }

