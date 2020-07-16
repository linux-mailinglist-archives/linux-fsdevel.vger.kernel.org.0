Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A822231B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 14:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgGPM5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 08:57:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:28352 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgGPM5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594904234; x=1626440234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jrAmbNIojbRxL8BjE/A9uwenFIDW3MDULcRxctpQaos=;
  b=ZUTOZsJ2MxFOMrXjDCu6sdX0R4i/V/CiHRM4bN1zravrhh396+VQ8QRt
   3dmIduZqcQk6+1RgpVBAEA8zep31/tU5SBw3+goFGSwzyjZhfq+7cQM+z
   KAYbkzZmv7+HCexIS7tp8in1FZ5FuqPIkbikR6bxJVtgWho5wND5vXn0M
   YDJ2m24rqD95EntiOsg8jMQdNsfDQYWrkJoH8AwtGQnvyBeZq543Hf5rF
   b14xi5uyS8PozK+F685AlWV0hD3+dyUmSxV+xWL4Em0hRS/askFFw2ZGy
   Hwesa71/JuEMZS4z2rX0RZ//8iPZOuedq6Txapy9D3285riD3LmbinMI3
   w==;
IronPort-SDR: F987Gjm55WlU4R2mY86Mt9DKj6Rsb7L9Wam0fzpPglFFOK18BZ/BAuSWyEyO8CPX0S4tyZKAAx
 ommPrMToIhHVa85o3EyGnZIurnoSQFkyQE+6yPt42HZ48TZ/1luwQHZFKPXa7OxlQPZ/Gzoss8
 sGv2avs/bOGKDJPLJlgnXLcNGAS1ZYQvciVgYCNHw6JXo7RorLKeO3n/QtcaSADwtZND6HGfyN
 vPdzCCHq77CqwXg48/S9/u89so+K+3fdX1S9hcncrAWnzRdig/aVuV3I0eUOSc0oo7fFkYWawt
 rM8=
X-IronPort-AV: E=Sophos;i="5.75,359,1589212800"; 
   d="scan'208";a="251874258"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 20:57:14 +0800
IronPort-SDR: Mojky53HkmqIcTA4B1ZIifYFgPzLW40MLE7lcHo+onkKgHQ+CriRd4QdnpI1O/ApcHzcTI/zkK
 NoGVje4rSjwRk+nvdJ+L2sWVyp9ODqJeE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 05:45:04 -0700
IronPort-SDR: wEqqKOh5hdClK2c+ZWefFnzK7NuOOpU7TqzS1w1i0+ogBY+mfvQYoGoHRaU+JQGOsURZuyBljB
 EJOwXXEKdd+A==
WDCIronportException: Internal
Received: from aravind-workstation.hgst.com (HELO localhost.localdomain) ([10.64.18.44])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 05:57:11 -0700
From:   Aravind Ramesh <aravind.ramesh@wdc.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, hch@lst.de
Cc:     Damien.LeMoal@wdc.com, niklas.cassel@wdc.com,
        matias.bjorling@wdc.com, Aravind Ramesh <aravind.ramesh@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v3 1/1] f2fs: support zone capacity less than zone size
Date:   Thu, 16 Jul 2020 18:26:56 +0530
Message-Id: <20200716125656.3662-2-aravind.ramesh@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200716125656.3662-1-aravind.ramesh@wdc.com>
References: <20200716125656.3662-1-aravind.ramesh@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NVMe Zoned Namespace devices can have zone-capacity less than zone-size.
Zone-capacity indicates the maximum number of sectors that are usable in
a zone beginning from the first sector of the zone. This makes the sectors
sectors after the zone-capacity till zone-size to be unusable.
This patch set tracks zone-size and zone-capacity in zoned devices and
calculate the usable blocks per segment and usable segments per section.

If zone-capacity is less than zone-size mark only those segments which
start before zone-capacity as free segments. All segments at and beyond
zone-capacity are treated as permanently used segments. In cases where
zone-capacity does not align with segment size the last segment will start
before zone-capacity and end beyond the zone-capacity of the zone. For
such spanning segments only sectors within the zone-capacity are used.

During writes and GC manage the usable segments in a section and usable
blocks per segment. Segments which are beyond zone-capacity are never
allocated, and do not need to be garbage collected, only the segments
which are before zone-capacity needs to garbage collected.
For spanning segments based on the number of usable blocks in that
segment, write to blocks only up to zone-capacity.

Zone-capacity is device specific and cannot be configured by the user.
Since NVMe ZNS device zones are sequentially write only, a block device
with conventional zones or any normal block device is needed along with
the ZNS device for the metadata operations of F2fs.

A typical nvme-cli output of a zoned device shows zone start and capacity
and write pointer as below:

SLBA: 0x0     WP: 0x0     Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ
SLBA: 0x20000 WP: 0x20000 Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ
SLBA: 0x40000 WP: 0x40000 Cap: 0x18800 State: EMPTY Type: SEQWRITE_REQ

Here zone size is 64MB, capacity is 49MB, WP is at zone start as the zones
are in EMPTY state. For each zone, only zone start + 49MB is usable area,
any lba/sector after 49MB cannot be read or written to, the drive will fail
any attempts to read/write. So, the second zone starts at 64MB and is
usable till 113MB (64 + 49) and the range between 113 and 128MB is
again unusable. The next zone starts at 128MB, and so on.

Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 Documentation/filesystems/f2fs.rst |  15 +++
 fs/f2fs/f2fs.h                     |   5 +
 fs/f2fs/gc.c                       |  25 +++--
 fs/f2fs/gc.h                       |  44 +++++++-
 fs/f2fs/segment.c                  | 156 ++++++++++++++++++++++++++---
 fs/f2fs/segment.h                  |  26 +++--
 fs/f2fs/super.c                    |  41 ++++++--
 7 files changed, 275 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 535021c46260..cec2167a31db 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -766,3 +766,18 @@ Compress metadata layout::
 	+-------------+-------------+----------+----------------------------+
 	| data length | data chksum | reserved |      compressed data       |
 	+-------------+-------------+----------+----------------------------+
+
+NVMe Zoned Namespace devices
+----------------------------
+
+- ZNS defines a per-zone capacity which can be equal or less than the
+  zone-size. Zone-capacity is the number of usable blocks in the zone.
+  F2fs checks if zone-capacity is less than zone-size, if it is, then any
+  segment which starts after the zone-capacity is marked as not-free in
+  the free segment bitmap at initial mount time. These segments are marked
+  as permanently used so they are not allocated for writes and
+  consequently are not needed to be garbage collected. In case the
+  zone-capacity is not aligned to default segment size(2MB), then a segment
+  can start before the zone-capacity and span across zone-capacity boundary.
+  Such spanning segments are also considered as usable segments. All blocks
+  past the zone-capacity are considered unusable in these segments.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e6e47618a357..73219e4e1ba4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1232,6 +1232,7 @@ struct f2fs_dev_info {
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int nr_blkz;		/* Total number of zones */
 	unsigned long *blkz_seq;	/* Bitmap indicating sequential zones */
+	block_t *zone_capacity_blocks;  /* Array of zone capacity in blks */
 #endif
 };
 
@@ -3395,6 +3396,10 @@ void f2fs_destroy_segment_manager_caches(void);
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
 enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 			enum page_type type, enum temp_type temp);
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
+			unsigned int segno);
+unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
+			unsigned int segno);
 
 /*
  * checkpoint.c
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 9a40761445d3..429e7dae807d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -266,13 +266,14 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned char age = 0;
 	unsigned char u;
 	unsigned int i;
+	unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi, segno);
 
-	for (i = 0; i < sbi->segs_per_sec; i++)
+	for (i = 0; i < usable_segs_per_sec; i++)
 		mtime += get_seg_entry(sbi, start + i)->mtime;
 	vblocks = get_valid_blocks(sbi, segno, true);
 
-	mtime = div_u64(mtime, sbi->segs_per_sec);
-	vblocks = div_u64(vblocks, sbi->segs_per_sec);
+	mtime = div_u64(mtime, usable_segs_per_sec);
+	vblocks = div_u64(vblocks, usable_segs_per_sec);
 
 	u = (vblocks * 100) >> sbi->log_blocks_per_seg;
 
@@ -536,6 +537,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 	int phase = 0;
 	bool fggc = (gc_type == FG_GC);
 	int submitted = 0;
+	unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
 
 	start_addr = START_BLOCK(sbi, segno);
 
@@ -545,7 +547,7 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 	if (fggc && phase == 2)
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 
-	for (off = 0; off < sbi->blocks_per_seg; off++, entry++) {
+	for (off = 0; off < usable_blks_in_seg; off++, entry++) {
 		nid_t nid = le32_to_cpu(entry->nid);
 		struct page *node_page;
 		struct node_info ni;
@@ -1033,13 +1035,14 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	int off;
 	int phase = 0;
 	int submitted = 0;
+	unsigned int usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
 
 	start_addr = START_BLOCK(sbi, segno);
 
 next_step:
 	entry = sum;
 
-	for (off = 0; off < sbi->blocks_per_seg; off++, entry++) {
+	for (off = 0; off < usable_blks_in_seg; off++, entry++) {
 		struct page *data_page;
 		struct inode *inode;
 		struct node_info dni; /* dnode info for the data */
@@ -1204,6 +1207,15 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 	if (__is_large_section(sbi))
 		end_segno = rounddown(end_segno, sbi->segs_per_sec);
 
+	/*
+	 * zone-capacity can be less than zone-size in zoned devices,
+	 * resulting in less than expected usable segments in the zone,
+	 * calculate the end segno in the zone which can be garbage collected
+	 */
+	if (f2fs_sb_has_blkzoned(sbi))
+		end_segno -= sbi->segs_per_sec -
+					f2fs_usable_segs_in_sec(sbi, segno);
+
 	/* readahead multi ssa blocks those have contiguous address */
 	if (__is_large_section(sbi))
 		f2fs_ra_meta_pages(sbi, GET_SUM_BLOCK(sbi, segno),
@@ -1356,7 +1368,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
 		goto stop;
 
 	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type);
-	if (gc_type == FG_GC && seg_freed == sbi->segs_per_sec)
+	if (gc_type == FG_GC &&
+		seg_freed == f2fs_usable_segs_in_sec(sbi, segno))
 		sec_freed++;
 	total_freed += seg_freed;
 
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index db3c61046aa4..ee5d7f30a1f8 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -44,13 +44,49 @@ struct gc_inode_list {
 /*
  * inline functions
  */
+
+/*
+ * On a Zoned device zone-capacity can be less than zone-size and if
+ * zone-capacity is not aligned to f2fs segment size(2MB), then the segment
+ * starting just before zone-capacity has some blocks spanning across the
+ * zone-capacity, these blocks are not usable.
+ * Such spanning segments can be in free list so calculate the sum of usable
+ * blocks in currently free segments including normal and spanning segments.
+ */
+static inline block_t free_segs_blk_count_zoned(struct f2fs_sb_info *sbi)
+{
+	block_t free_seg_blks = 0;
+	struct free_segmap_info *free_i = FREE_I(sbi);
+	int j;
+
+	spin_lock(&free_i->segmap_lock);
+	for (j = 0; j < MAIN_SEGS(sbi); j++)
+		if (!test_bit(j, free_i->free_segmap))
+			free_seg_blks += f2fs_usable_blks_in_seg(sbi, j);
+	spin_unlock(&free_i->segmap_lock);
+
+	return free_seg_blks;
+}
+
+static inline block_t free_segs_blk_count(struct f2fs_sb_info *sbi)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return free_segs_blk_count_zoned(sbi);
+
+	return free_segments(sbi) << sbi->log_blocks_per_seg;
+}
+
 static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
 {
-	if (free_segments(sbi) < overprovision_segments(sbi))
+	block_t free_blks, ovp_blks;
+
+	free_blks = free_segs_blk_count(sbi);
+	ovp_blks = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
+
+	if (free_blks < ovp_blks)
 		return 0;
-	else
-		return (free_segments(sbi) - overprovision_segments(sbi))
-			<< sbi->log_blocks_per_seg;
+
+	return free_blks - ovp_blks;
 }
 
 static inline block_t limit_invalid_user_blocks(struct f2fs_sb_info *sbi)
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c35614d255e1..b36b4eb9e2a5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -859,20 +859,22 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	unsigned short valid_blocks, ckpt_valid_blocks;
+	unsigned int usable_blocks;
 
 	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
 		return;
 
+	usable_blocks = f2fs_usable_blks_in_seg(sbi, segno);
 	mutex_lock(&dirty_i->seglist_lock);
 
 	valid_blocks = get_valid_blocks(sbi, segno, false);
 	ckpt_valid_blocks = get_ckpt_valid_blocks(sbi, segno);
 
 	if (valid_blocks == 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABLED) ||
-				ckpt_valid_blocks == sbi->blocks_per_seg)) {
+		ckpt_valid_blocks == usable_blocks)) {
 		__locate_dirty_segment(sbi, segno, PRE);
 		__remove_dirty_segment(sbi, segno, DIRTY);
-	} else if (valid_blocks < sbi->blocks_per_seg) {
+	} else if (valid_blocks < usable_blocks) {
 		__locate_dirty_segment(sbi, segno, DIRTY);
 	} else {
 		/* Recovery routine with SSR needs this */
@@ -915,9 +917,11 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi)
 	for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(sbi)) {
 		se = get_seg_entry(sbi, segno);
 		if (IS_NODESEG(se->type))
-			holes[NODE] += sbi->blocks_per_seg - se->valid_blocks;
+			holes[NODE] += f2fs_usable_blks_in_seg(sbi, segno) -
+							se->valid_blocks;
 		else
-			holes[DATA] += sbi->blocks_per_seg - se->valid_blocks;
+			holes[DATA] += f2fs_usable_blks_in_seg(sbi, segno) -
+							se->valid_blocks;
 	}
 	mutex_unlock(&dirty_i->seglist_lock);
 
@@ -2167,7 +2171,7 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	offset = GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
 
 	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
-				(new_vblocks > sbi->blocks_per_seg)));
+			(new_vblocks > f2fs_usable_blks_in_seg(sbi, segno))));
 
 	se->valid_blocks = new_vblocks;
 	se->mtime = get_mtime(sbi, false);
@@ -2933,9 +2937,9 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
 {
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
-	if (curseg->next_blkoff < sbi->blocks_per_seg)
-		return true;
-	return false;
+
+	return curseg->next_blkoff < f2fs_usable_blks_in_seg(sbi,
+							curseg->segno);
 }
 
 int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
@@ -4294,9 +4298,12 @@ static void init_free_segmap(struct f2fs_sb_info *sbi)
 {
 	unsigned int start;
 	int type;
+	struct seg_entry *sentry;
 
 	for (start = 0; start < MAIN_SEGS(sbi); start++) {
-		struct seg_entry *sentry = get_seg_entry(sbi, start);
+		if (f2fs_usable_blks_in_seg(sbi, start) == 0)
+			continue;
+		sentry = get_seg_entry(sbi, start);
 		if (!sentry->valid_blocks)
 			__set_free(sbi, start);
 		else
@@ -4316,7 +4323,7 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int segno = 0, offset = 0, secno;
-	unsigned short valid_blocks;
+	unsigned short valid_blocks, usable_blks_in_seg;
 	unsigned short blks_per_sec = BLKS_PER_SEC(sbi);
 
 	while (1) {
@@ -4326,9 +4333,10 @@ static void init_dirty_segmap(struct f2fs_sb_info *sbi)
 			break;
 		offset = segno + 1;
 		valid_blocks = get_valid_blocks(sbi, segno, false);
-		if (valid_blocks == sbi->blocks_per_seg || !valid_blocks)
+		usable_blks_in_seg = f2fs_usable_blks_in_seg(sbi, segno);
+		if (valid_blocks == usable_blks_in_seg || !valid_blocks)
 			continue;
-		if (valid_blocks > sbi->blocks_per_seg) {
+		if (valid_blocks > usable_blks_in_seg) {
 			f2fs_bug_on(sbi, 1);
 			continue;
 		}
@@ -4678,6 +4686,101 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 
 	return 0;
 }
+
+static bool is_conv_zone(struct f2fs_sb_info *sbi, unsigned int zone_idx,
+						unsigned int dev_idx)
+{
+	if (!bdev_is_zoned(FDEV(dev_idx).bdev))
+		return true;
+	return !test_bit(zone_idx, FDEV(dev_idx).blkz_seq);
+}
+
+/* Return the zone index in the given device */
+static unsigned int get_zone_idx(struct f2fs_sb_info *sbi, unsigned int secno,
+					int dev_idx)
+{
+	block_t sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
+
+	return (sec_start_blkaddr - FDEV(dev_idx).start_blk) >>
+						sbi->log_blocks_per_blkz;
+}
+
+/*
+ * Return the usable segments in a section based on the zone's
+ * corresponding zone capacity. Zone is equal to a section.
+ */
+static inline unsigned int f2fs_usable_zone_segs_in_sec(
+		struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	unsigned int dev_idx, zone_idx, unusable_segs_in_sec;
+
+	dev_idx = f2fs_target_device_index(sbi, START_BLOCK(sbi, segno));
+	zone_idx = get_zone_idx(sbi, GET_SEC_FROM_SEG(sbi, segno), dev_idx);
+
+	/* Conventional zone's capacity is always equal to zone size */
+	if (is_conv_zone(sbi, zone_idx, dev_idx))
+		return sbi->segs_per_sec;
+
+	/*
+	 * If the zone_capacity_blocks array is NULL, then zone capacity
+	 * is equal to the zone size for all zones
+	 */
+	if (!FDEV(dev_idx).zone_capacity_blocks)
+		return sbi->segs_per_sec;
+
+	/* Get the segment count beyond zone capacity block */
+	unusable_segs_in_sec = (sbi->blocks_per_blkz -
+				FDEV(dev_idx).zone_capacity_blocks[zone_idx]) >>
+				sbi->log_blocks_per_seg;
+	return sbi->segs_per_sec - unusable_segs_in_sec;
+}
+
+/*
+ * Return the number of usable blocks in a segment. The number of blocks
+ * returned is always equal to the number of blocks in a segment for
+ * segments fully contained within a sequential zone capacity or a
+ * conventional zone. For segments partially contained in a sequential
+ * zone capacity, the number of usable blocks up to the zone capacity
+ * is returned. 0 is returned in all other cases.
+ */
+static inline unsigned int f2fs_usable_zone_blks_in_seg(
+			struct f2fs_sb_info *sbi, unsigned int segno)
+{
+	block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
+	unsigned int zone_idx, dev_idx, secno;
+
+	secno = GET_SEC_FROM_SEG(sbi, segno);
+	seg_start = START_BLOCK(sbi, segno);
+	dev_idx = f2fs_target_device_index(sbi, seg_start);
+	zone_idx = get_zone_idx(sbi, secno, dev_idx);
+
+	/*
+	 * Conventional zone's capacity is always equal to zone size,
+	 * so, blocks per segment is unchanged.
+	 */
+	if (is_conv_zone(sbi, zone_idx, dev_idx))
+		return sbi->blocks_per_seg;
+
+	if (!FDEV(dev_idx).zone_capacity_blocks)
+		return sbi->blocks_per_seg;
+
+	sec_start_blkaddr = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secno));
+	sec_cap_blkaddr = sec_start_blkaddr +
+				FDEV(dev_idx).zone_capacity_blocks[zone_idx];
+
+	/*
+	 * If segment starts before zone capacity and spans beyond
+	 * zone capacity, then usable blocks are from seg start to
+	 * zone capacity. If the segment starts after the zone capacity,
+	 * then there are no usable blocks.
+	 */
+	if (seg_start >= sec_cap_blkaddr)
+		return 0;
+	if (seg_start + sbi->blocks_per_seg > sec_cap_blkaddr)
+		return sec_cap_blkaddr - seg_start;
+
+	return sbi->blocks_per_seg;
+}
 #else
 int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
 {
@@ -4688,7 +4791,36 @@ int f2fs_check_write_pointer(struct f2fs_sb_info *sbi)
 {
 	return 0;
 }
+
+static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_sb_info *sbi,
+							unsigned int segno)
+{
+	return 0;
+}
+
+static inline unsigned int f2fs_usable_zone_segs_in_sec(struct f2fs_sb_info *sbi,
+							unsigned int segno)
+{
+	return 0;
+}
 #endif
+unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
+					unsigned int segno)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return f2fs_usable_zone_blks_in_seg(sbi, segno);
+
+	return sbi->blocks_per_seg;
+}
+
+unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
+					unsigned int segno)
+{
+	if (f2fs_sb_has_blkzoned(sbi))
+		return f2fs_usable_zone_segs_in_sec(sbi, segno);
+
+	return sbi->segs_per_sec;
+}
 
 /*
  * Update min, max modified time for cost-benefit GC algorithm
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f261e3e6a69b..e1ca41fc3bfe 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -411,6 +411,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
+	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
 
 	spin_lock(&free_i->segmap_lock);
 	clear_bit(segno, free_i->free_segmap);
@@ -418,7 +419,7 @@ static inline void __set_free(struct f2fs_sb_info *sbi, unsigned int segno)
 
 	next = find_next_bit(free_i->free_segmap,
 			start_segno + sbi->segs_per_sec, start_segno);
-	if (next >= start_segno + sbi->segs_per_sec) {
+	if (next >= start_segno + usable_segs) {
 		clear_bit(secno, free_i->free_secmap);
 		free_i->free_sections++;
 	}
@@ -444,6 +445,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 	unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 	unsigned int next;
+	unsigned int usable_segs = f2fs_usable_segs_in_sec(sbi, segno);
 
 	spin_lock(&free_i->segmap_lock);
 	if (test_and_clear_bit(segno, free_i->free_segmap)) {
@@ -453,7 +455,7 @@ static inline void __set_test_and_free(struct f2fs_sb_info *sbi,
 			goto skip_free;
 		next = find_next_bit(free_i->free_segmap,
 				start_segno + sbi->segs_per_sec, start_segno);
-		if (next >= start_segno + sbi->segs_per_sec) {
+		if (next >= start_segno + usable_segs) {
 			if (test_and_clear_bit(secno, free_i->free_secmap))
 				free_i->free_sections++;
 		}
@@ -546,8 +548,8 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi)
 	/* check current node segment */
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = sbi->blocks_per_seg -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
+				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
 		if (node_blocks > left_blocks)
 			return false;
@@ -555,7 +557,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi)
 
 	/* check current data segment */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = sbi->blocks_per_seg -
+	left_blocks = f2fs_usable_blks_in_seg(sbi, segno) -
 			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 	if (dent_blocks > left_blocks)
 		return false;
@@ -677,21 +679,22 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
 	bool is_valid  = test_bit_le(0, raw_sit->valid_map) ? true : false;
 	int valid_blocks = 0;
 	int cur_pos = 0, next_pos;
+	unsigned int usable_blks_per_seg = f2fs_usable_blks_in_seg(sbi, segno);
 
 	/* check bitmap with valid block count */
 	do {
 		if (is_valid) {
 			next_pos = find_next_zero_bit_le(&raw_sit->valid_map,
-					sbi->blocks_per_seg,
+					usable_blks_per_seg,
 					cur_pos);
 			valid_blocks += next_pos - cur_pos;
 		} else
 			next_pos = find_next_bit_le(&raw_sit->valid_map,
-					sbi->blocks_per_seg,
+					usable_blks_per_seg,
 					cur_pos);
 		cur_pos = next_pos;
 		is_valid = !is_valid;
-	} while (cur_pos < sbi->blocks_per_seg);
+	} while (cur_pos < usable_blks_per_seg);
 
 	if (unlikely(GET_SIT_VBLOCKS(raw_sit) != valid_blocks)) {
 		f2fs_err(sbi, "Mismatch valid blocks %d vs. %d",
@@ -700,8 +703,13 @@ static inline int check_block_count(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
+	if (usable_blks_per_seg < sbi->blocks_per_seg)
+		f2fs_bug_on(sbi, find_next_bit_le(&raw_sit->valid_map,
+				sbi->blocks_per_seg,
+				usable_blks_per_seg) != sbi->blocks_per_seg);
+
 	/* check segment usage, and check boundary of a given segment number */
-	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > sbi->blocks_per_seg
+	if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
 					|| segno > TOTAL_SEGS(sbi) - 1)) {
 		f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
 			 GET_SIT_VBLOCKS(raw_sit), segno);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 80cb7cd358f8..7ced425dc102 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1164,6 +1164,7 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 		blkdev_put(FDEV(i).bdev, FMODE_EXCL);
 #ifdef CONFIG_BLK_DEV_ZONED
 		kvfree(FDEV(i).blkz_seq);
+		kfree(FDEV(i).zone_capacity_blocks);
 #endif
 	}
 	kvfree(sbi->devs);
@@ -3039,13 +3040,26 @@ static int init_percpu_info(struct f2fs_sb_info *sbi)
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
+
+struct f2fs_report_zones_args {
+	struct f2fs_dev_info *dev;
+	bool zone_cap_mismatch;
+};
+
 static int f2fs_report_zone_cb(struct blk_zone *zone, unsigned int idx,
-			       void *data)
+			      void *data)
 {
-	struct f2fs_dev_info *dev = data;
+	struct f2fs_report_zones_args *rz_args = data;
+
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
+		return 0;
+
+	set_bit(idx, rz_args->dev->blkz_seq);
+	rz_args->dev->zone_capacity_blocks[idx] = zone->capacity >>
+						F2FS_LOG_SECTORS_PER_BLOCK;
+	if (zone->len != zone->capacity && !rz_args->zone_cap_mismatch)
+		rz_args->zone_cap_mismatch = true;
 
-	if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
-		set_bit(idx, dev->blkz_seq);
 	return 0;
 }
 
@@ -3053,6 +3067,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 {
 	struct block_device *bdev = FDEV(devi).bdev;
 	sector_t nr_sectors = bdev->bd_part->nr_sects;
+	struct f2fs_report_zones_args rep_zone_arg;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
@@ -3078,12 +3093,26 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!FDEV(devi).blkz_seq)
 		return -ENOMEM;
 
-	/* Get block zones type */
+	/* Get block zones type and zone-capacity */
+	FDEV(devi).zone_capacity_blocks = f2fs_kzalloc(sbi,
+					FDEV(devi).nr_blkz * sizeof(block_t),
+					GFP_KERNEL);
+	if (!FDEV(devi).zone_capacity_blocks)
+		return -ENOMEM;
+
+	rep_zone_arg.dev = &FDEV(devi);
+	rep_zone_arg.zone_cap_mismatch = false;
+
 	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES, f2fs_report_zone_cb,
-				  &FDEV(devi));
+				  &rep_zone_arg);
 	if (ret < 0)
 		return ret;
 
+	if (!rep_zone_arg.zone_cap_mismatch) {
+		kfree(FDEV(devi).zone_capacity_blocks);
+		FDEV(devi).zone_capacity_blocks = NULL;
+	}
+
 	return 0;
 }
 #endif
-- 
2.19.1

