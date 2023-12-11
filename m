Return-Path: <linux-fsdevel+bounces-5486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109CB80CD89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E9B218A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDCF4CB53;
	Mon, 11 Dec 2023 14:07:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07BD5266;
	Mon, 11 Dec 2023 06:07:35 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Spk8g4r4Qz4f3kJw;
	Mon, 11 Dec 2023 22:07:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C905C1A07CC;
	Mon, 11 Dec 2023 22:07:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xGTF3dlDYFxDQ--.28013S13;
	Mon, 11 Dec 2023 22:07:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: axboe@kernel.dk,
	roger.pau@citrix.com,
	colyli@suse.de,
	kent.overstreet@gmail.com,
	joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	sth@linux.ibm.com,
	hoeppner@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	nico@fluxnic.net,
	xiang@kernel.org,
	chao@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	agruenba@redhat.com,
	jack@suse.com,
	konishi.ryusuke@gmail.com,
	willy@infradead.org,
	akpm@linux-foundation.org,
	p.raghav@samsung.com,
	hare@suse.de
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH RFC v2 for-6.8/block 09/18] btrfs: use bdev apis
Date: Mon, 11 Dec 2023 22:05:43 +0800
Message-Id: <20231211140552.973290-10-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211140552.973290-1-yukuai1@huaweicloud.com>
References: <20231211140552.973290-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xGTF3dlDYFxDQ--.28013S13
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWUur17WF47JrWfZry7Wrg_yoWfJFW5pr
	W7Cas5trWUJrn8Ww1kXw4kAw1Sq3sFvay8CFy3Gw4Ska45t345KF1vv34Fqa4Fkry8JFyk
	XF4UtFWxuF1xCF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ
	SdkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

On the one hand covert to use folio while reading bdev inode, on the
other hand prevent to access bd_inode directly.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/btrfs/disk-io.c | 71 +++++++++++++++++++++-------------------------
 fs/btrfs/volumes.c | 17 ++++++-----
 fs/btrfs/zoned.c   | 15 +++++-----
 3 files changed, 48 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..c373806dc793 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3620,28 +3620,24 @@ ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 static void btrfs_end_super_write(struct bio *bio)
 {
 	struct btrfs_device *device = bio->bi_private;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
-	struct page *page;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		page = bvec->bv_page;
+	struct folio_iter fi;
 
+	bio_for_each_folio_all(fi, bio) {
 		if (bio->bi_status) {
 			btrfs_warn_rl_in_rcu(device->fs_info,
 				"lost page write due to IO error on %s (%d)",
 				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
-			ClearPageUptodate(page);
-			SetPageError(page);
+			folio_clear_uptodate(fi.folio);
+			folio_set_error(fi.folio);
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
 		} else {
-			SetPageUptodate(page);
+			folio_mark_uptodate(fi.folio);
 		}
 
-		put_page(page);
-		unlock_page(page);
+		folio_put(fi.folio);
+		folio_unlock(fi.folio);
 	}
 
 	bio_put(bio);
@@ -3651,9 +3647,9 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 						   int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
-	struct page *page;
+	struct folio *folio;
 	u64 bytenr, bytenr_orig;
-	struct address_space *mapping = bdev->bd_inode->i_mapping;
+	unsigned int nofs_flag;
 	int ret;
 
 	bytenr_orig = btrfs_sb_offset(copy_num);
@@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
 		 * Drop the page of the primary superblock, so later read will
 		 * always read from the device.
 		 */
-		invalidate_inode_pages2_range(mapping,
-				bytenr >> PAGE_SHIFT,
+		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
 				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
 	}
 
-	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
+	nofs_flag = memalloc_nofs_save();
+	folio = bdev_read_folio(bdev, bytenr);
+	memalloc_nofs_restore(nofs_flag);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 
-	super = page_address(page);
+	super = folio_address(folio);
 	if (btrfs_super_magic(super) != BTRFS_MAGIC) {
 		btrfs_release_disk_super(super);
 		return ERR_PTR(-ENODATA);
@@ -3740,7 +3737,6 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3753,7 +3749,7 @@ static int write_dev_supers(struct btrfs_device *device,
 	shash->tfm = fs_info->csum_shash;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
 
@@ -3778,9 +3774,10 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
-		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
-					   GFP_NOFS);
-		if (!page) {
+		folio = __bdev_get_folio(device->bdev, bytenr,
+					 FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
+					 GFP_NOFS);
+		if (IS_ERR(folio)) {
 			btrfs_err(device->fs_info,
 			    "couldn't get super block page for bytenr %llu",
 			    bytenr);
@@ -3789,9 +3786,9 @@ static int write_dev_supers(struct btrfs_device *device,
 		}
 
 		/* Bump the refcount for wait_dev_supers() */
-		get_page(page);
+		folio_get(folio);
 
-		disk_super = page_address(page);
+		disk_super = folio_address(folio);
 		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
@@ -3805,8 +3802,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
 		bio->bi_private = device;
 		bio->bi_end_io = btrfs_end_super_write;
-		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
-			       offset_in_page(bytenr));
+		bio_add_folio_nofail(bio, folio, BTRFS_SUPER_INFO_SIZE,
+				     offset_in_folio(folio, bytenr));
 
 		/*
 		 * We FUA only the first super block.  The others we allow to
@@ -3842,7 +3839,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
 	for (i = 0; i < max_mirrors; i++) {
-		struct page *page;
+		struct folio *folio;
 
 		ret = btrfs_sb_log_location(device, i, READ, &bytenr);
 		if (ret == -ENOENT) {
@@ -3857,27 +3854,23 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
-				     bytenr >> PAGE_SHIFT);
-		if (!page) {
+		folio = __bdev_get_folio(device->bdev, bytenr, 0, 0);
+		if (!IS_ERR(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 			continue;
 		}
 		/* Page is submitted locked and unlocked once the IO completes */
-		wait_on_page_locked(page);
-		if (PageError(page)) {
+		folio_wait_locked(folio);
+		if (folio_test_error(folio)) {
 			errors++;
 			if (i == 0)
 				primary_failed = true;
 		}
 
-		/* Drop our reference */
-		put_page(page);
-
-		/* Drop the reference from the writing run */
-		put_page(page);
+		/* Drop our reference and the reference from the writing run */
+		folio_put_refs(folio, 2);
 	}
 
 	/* log error, force error return */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c6f16625af51..b3538777683c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1230,16 +1230,16 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
 {
-	struct page *page = virt_to_page(super);
+	struct folio *folio = virt_to_folio(super);
 
-	put_page(page);
+	folio_put(folio);
 }
 
 static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 						       u64 bytenr, u64 bytenr_orig)
 {
 	struct btrfs_super_block *disk_super;
-	struct page *page;
+	struct folio *folio;
 	void *p;
 	pgoff_t index;
 
@@ -1257,15 +1257,14 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 		return ERR_PTR(-EINVAL);
 
 	/* pull in the page with our super */
-	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index, GFP_KERNEL);
+	folio = bdev_read_folio(bdev, index);
+	if (IS_ERR(folio))
+		return ERR_CAST(folio);
 
-	if (IS_ERR(page))
-		return ERR_CAST(page);
-
-	p = page_address(page);
+	p = folio_address(folio);
 
 	/* align our pointer to the offset of the super block */
-	disk_super = p + offset_in_page(bytenr);
+	disk_super = p + offset_in_folio(folio, bytenr);
 
 	if (btrfs_super_bytenr(disk_super) != bytenr_orig ||
 	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 188378ca19c7..aea0a433b3e5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -120,8 +120,6 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		return -ENOENT;
 	} else if (full[0] && full[1]) {
 		/* Compare two super blocks */
-		struct address_space *mapping = bdev->bd_inode->i_mapping;
-		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
 		int i;
 
@@ -129,15 +127,18 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
 			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
 						BTRFS_SUPER_INFO_SIZE;
+			struct folio *folio;
+			unsigned int nofs_flag;
 
-			page[i] = read_cache_page_gfp(mapping,
-					bytenr >> PAGE_SHIFT, GFP_NOFS);
-			if (IS_ERR(page[i])) {
+			nofs_flag = memalloc_nofs_save();
+			folio = bdev_read_folio(bdev, bytenr);
+			memalloc_nofs_restore(nofs_flag);
+			if (IS_ERR(folio)) {
 				if (i == 1)
 					btrfs_release_disk_super(super[0]);
-				return PTR_ERR(page[i]);
+				return PTR_ERR(folio);
 			}
-			super[i] = page_address(page[i]);
+			super[i] = folio_address(folio);
 		}
 
 		if (btrfs_super_generation(super[0]) >
-- 
2.39.2


