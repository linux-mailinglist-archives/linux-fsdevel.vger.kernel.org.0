Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD212398EB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhFBPeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 11:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhFBPeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:34:06 -0400
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D4C061574;
        Wed,  2 Jun 2021 08:32:23 -0700 (PDT)
Received: from sas1-6b1512233ef6.qloud-c.yandex.net (sas1-6b1512233ef6.qloud-c.yandex.net [IPv6:2a02:6b8:c14:44af:0:640:6b15:1223])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id ADC562E1D28;
        Wed,  2 Jun 2021 18:29:20 +0300 (MSK)
Received: from sas2-d40aa8807eff.qloud-c.yandex.net (sas2-d40aa8807eff.qloud-c.yandex.net [2a02:6b8:c08:b921:0:640:d40a:a880])
        by sas1-6b1512233ef6.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id GmqcA41Nf1-TJ1mkN3p;
        Wed, 02 Jun 2021 18:29:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1622647760; bh=CK9yOrypVPtvStyIHv45RQwCxZOuMnmfxcH0vFg/HM4=;
        h=Message-Id:References:Date:Subject:To:From:In-Reply-To:Cc;
        b=r0RWbFGRrYflZylCxI5eCX+BhRkrn/35zU9QRALOwyNQysMzBDDLG4Uf8/9+q9pyT
         U1+RIGQHn0DayZ9BiA2P//QYrlPUTD0M4eXQc5ixprgr9SiCPESkJPQ0XBWK+uudFp
         MvVsUykkHXN/oOh0NBaGjokkATwK/1GDgjI7qkZo=
Authentication-Results: sas1-6b1512233ef6.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from warwish-linux.sas.yp-c.yandex.net (warwish-linux.sas.yp-c.yandex.net [2a02:6b8:c1b:2920:0:696:cc9e:0])
        by sas2-d40aa8807eff.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 42DbdVHlBw-TJoiKvUR;
        Wed, 02 Jun 2021 18:29:19 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Anton Suvorov <warwish@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     warwish@yandex-team.ru, linux-fsdevel@vger.kernel.org,
        dmtrmonakhov@yandex-team.ru, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH 05/10] block: reduce stack footprint dealing with block device names
Date:   Wed,  2 Jun 2021 18:28:58 +0300
Message-Id: <20210602152903.910190-6-warwish@yandex-team.ru>
In-Reply-To: <20210602152903.910190-1-warwish@yandex-team.ru>
References: <20210602152903.910190-1-warwish@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stack usage reduced (measured with allyesconfig):

./block/blk-core.c	submit_bio_checks	248	112	-136
./block/blk-lib.c	__blkdev_issue_discard	240	104	-136
./block/blk-settings.c	disk_stack_limits	256	192	-64
./block/partitions/amiga.c	amiga_partition	424	368	-56
./block/partitions/sgi.c	sgi_partition	352	288	-64
./block/partitions/sun.c	sun_partition	392	328	-64
./drivers/block/drbd/drbd_req.c	drbd_report_io_error	200	72	-128
./drivers/block/pktcdvd.c	pkt_seq_show	288	224	-64
./drivers/block/pktcdvd.c	pkt_setup_dev	272	136	-136
./drivers/block/pktcdvd.c	pkt_submit_bio	288	224	-64

Signed-off-by: Anton Suvorov <warwish@yandex-team.ru>
---
 block/blk-core.c         | 12 ++++--------
 block/blk-lib.c          |  5 +----
 block/blk-settings.c     |  7 ++-----
 block/partitions/amiga.c | 13 ++++++-------
 block/partitions/sgi.c   |  5 ++---
 block/partitions/sun.c   |  5 ++---
 drivers/block/pktcdvd.c  | 15 ++++++---------
 7 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 689aac2625d2..d85693882e6e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -650,11 +650,9 @@ EXPORT_SYMBOL(blk_put_request);
 
 static void handle_bad_sector(struct bio *bio, sector_t maxsector)
 {
-	char b[BDEVNAME_SIZE];
-
 	pr_info_ratelimited("attempt to access beyond end of device\n"
-			    "%s: rw=%d, want=%llu, limit=%llu\n",
-			    bio_devname(bio, b), bio->bi_opf,
+			    "%pg: rw=%d, want=%llu, limit=%llu\n",
+			    bio->bi_bdev, bio->bi_opf,
 			    bio_end_sector(bio), maxsector);
 }
 
@@ -696,14 +694,12 @@ static inline bool should_fail_request(struct block_device *part,
 static inline bool bio_check_ro(struct bio *bio)
 {
 	if (op_is_write(bio_op(bio)) && bdev_read_only(bio->bi_bdev)) {
-		char b[BDEVNAME_SIZE];
-
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return false;
 
 		WARN_ONCE(1,
-		       "Trying to write to read-only block-device %s (partno %d)\n",
-			bio_devname(bio, b), bio->bi_bdev->bd_partno);
+		       "Trying to write to read-only block-device %pg (partno %d)\n",
+			bio->bi_bdev, bio->bi_bdev->bd_partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7b256131b20b..6fe52f7f3f48 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -49,10 +49,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	/* In case the discard granularity isn't set by buggy device driver */
 	if (WARN_ON_ONCE(!q->limits.discard_granularity)) {
-		char dev_name[BDEVNAME_SIZE];
-
-		bdevname(bdev, dev_name);
-		pr_err_ratelimited("%s: Error: discard_granularity is 0.\n", dev_name);
+		pr_err_ratelimited("%pg: Error: discard_granularity is 0.\n", bdev);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 902c40d67120..01972174b1b9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -662,13 +662,10 @@ void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 
 	if (blk_stack_limits(&t->limits, &bdev_get_queue(bdev)->limits,
 			get_start_sect(bdev) + (offset >> 9)) < 0) {
-		char top[BDEVNAME_SIZE], bottom[BDEVNAME_SIZE];
+		char top[BDEVNAME_SIZE];
 
 		disk_name(disk, 0, top);
-		bdevname(bdev, bottom);
-
-		printk(KERN_NOTICE "%s: Warning: Device %s is misaligned\n",
-		       top, bottom);
+		pr_notice("%s: Warning: Device %pg is misaligned\n", top, bdev);
 	}
 
 	blk_queue_update_readahead(disk->queue);
diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
index 9526491d9aed..36255fba6863 100644
--- a/block/partitions/amiga.c
+++ b/block/partitions/amiga.c
@@ -34,15 +34,14 @@ int amiga_partition(struct parsed_partitions *state)
 	int start_sect, nr_sects, blk, part, res = 0;
 	int blksize = 1;	/* Multiplier for disk block size */
 	int slot = 1;
-	char b[BDEVNAME_SIZE];
 
 	for (blk = 0; ; blk++, put_dev_sector(sect)) {
 		if (blk == RDB_ALLOCATION_LIMIT)
 			goto rdb_done;
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read RDB block %d\n",
-			       bdevname(state->bdev, b), blk);
+			pr_err("Dev %pg: unable to read RDB block %d\n",
+			       state->bdev, blk);
 			res = -1;
 			goto rdb_done;
 		}
@@ -63,8 +62,8 @@ int amiga_partition(struct parsed_partitions *state)
 			break;
 		}
 
-		pr_err("Dev %s: RDB in block %d has bad checksum\n",
-		       bdevname(state->bdev, b), blk);
+		pr_err("Dev %pg: RDB in block %d has bad checksum\n",
+		       state->bdev, blk);
 	}
 
 	/* blksize is blocks per 512 byte standard block */
@@ -83,8 +82,8 @@ int amiga_partition(struct parsed_partitions *state)
 		blk *= blksize;	/* Read in terms partition table understands */
 		data = read_part_sector(state, blk, &sect);
 		if (!data) {
-			pr_err("Dev %s: unable to read partition block %d\n",
-			       bdevname(state->bdev, b), blk);
+			pr_err("Dev %pg: unable to read partition block %d\n",
+			       state->bdev, blk);
 			res = -1;
 			goto rdb_done;
 		}
diff --git a/block/partitions/sgi.c b/block/partitions/sgi.c
index 4273f1bb0515..65cf137760ac 100644
--- a/block/partitions/sgi.c
+++ b/block/partitions/sgi.c
@@ -43,7 +43,6 @@ int sgi_partition(struct parsed_partitions *state)
 	Sector sect;
 	struct sgi_disklabel *label;
 	struct sgi_partition *p;
-	char b[BDEVNAME_SIZE];
 
 	label = read_part_sector(state, 0, &sect);
 	if (!label)
@@ -62,8 +61,8 @@ int sgi_partition(struct parsed_partitions *state)
 		csum += be32_to_cpu(cs);
 	}
 	if(csum) {
-		printk(KERN_WARNING "Dev %s SGI disklabel: csum bad, label corrupted\n",
-		       bdevname(state->bdev, b));
+		pr_warn("Dev %pg SGI disklabel: csum bad, label corrupted\n",
+			state->bdev);
 		put_dev_sector(sect);
 		return 0;
 	}
diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index 47dc53eccf77..483be15f2800 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -65,7 +65,6 @@ int sun_partition(struct parsed_partitions *state)
 	} * label;
 	struct sun_partition *p;
 	unsigned long spc;
-	char b[BDEVNAME_SIZE];
 	int use_vtoc;
 	int nparts;
 
@@ -85,8 +84,8 @@ int sun_partition(struct parsed_partitions *state)
 	for (csum = 0; ush >= ((__be16 *) label);)
 		csum ^= *ush--;
 	if (csum) {
-		printk("Dev %s Sun disklabel: Csum bad, label corrupted\n",
-		       bdevname(state->bdev, b));
+		pr_info("Dev %pg Sun disklabel: Csum bad, label corrupted\n",
+			state->bdev);
 		put_dev_sector(sect);
 		return 0;
 	}
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index bd3556585122..765c2d1567ba 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2405,14 +2405,13 @@ static void pkt_make_request_write(struct request_queue *q, struct bio *bio)
 static blk_qc_t pkt_submit_bio(struct bio *bio)
 {
 	struct pktcdvd_device *pd;
-	char b[BDEVNAME_SIZE];
 	struct bio *split;
 
 	blk_queue_split(&bio);
 
 	pd = bio->bi_bdev->bd_disk->queue->queuedata;
 	if (!pd) {
-		pr_err("%s incorrect request queue\n", bio_devname(bio, b));
+		pr_err("%pg incorrect request queue\n", bio->bi_bdev);
 		goto end_io;
 	}
 
@@ -2476,11 +2475,10 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 {
 	struct pktcdvd_device *pd = m->private;
 	char *msg;
-	char bdev_buf[BDEVNAME_SIZE];
 	int states[PACKET_NUM_STATES];
 
-	seq_printf(m, "Writer %s mapped to %s:\n", pd->name,
-		   bdevname(pd->bdev, bdev_buf));
+	seq_printf(m, "Writer %s mapped to %pg:\n", pd->name,
+		   pd->bdev);
 
 	seq_printf(m, "\nSettings:\n");
 	seq_printf(m, "\tpacket size:\t\t%dkB\n", pd->settings.size / 2);
@@ -2537,7 +2535,6 @@ static int pkt_seq_show(struct seq_file *m, void *p)
 static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 {
 	int i;
-	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
 
 	if (pd->pkt_dev == dev) {
@@ -2549,8 +2546,8 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 		if (!pd2)
 			continue;
 		if (pd2->bdev->bd_dev == dev) {
-			pkt_err(pd, "%s already setup\n",
-				bdevname(pd2->bdev, b));
+			pkt_err(pd, "%pg already setup\n",
+				pd2->bdev);
 			return -EBUSY;
 		}
 		if (pd2->pkt_dev == dev) {
@@ -2583,7 +2580,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	}
 
 	proc_create_single_data(pd->name, 0, pkt_proc, pkt_seq_show, pd);
-	pkt_dbg(1, pd, "writer mapped to %s\n", bdevname(bdev, b));
+	pkt_dbg(1, pd, "writer mapped to %pg\n", bdev);
 	return 0;
 
 out_mem:
-- 
2.25.1

