Return-Path: <linux-fsdevel+bounces-16289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2DF89AA0B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4F21F21D9C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFBA405FC;
	Sat,  6 Apr 2024 09:17:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED73BBCE;
	Sat,  6 Apr 2024 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395076; cv=none; b=okpmqc8lMpMyrhuljCPO/S6ZPYD7XpJ1gKR+6y+cy8g92cj9GWDfK4EhaPkipUE64X0ieWP2GyZSOQnYScrvB7GGQ1U8vsh7GhHhGnWPi3uX7kxMSkWMR/oCU/8Qp/w6IQh49Gizsaje6FI9rN//udBoua6ypx+A0Vew70+ScPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395076; c=relaxed/simple;
	bh=sPl5OvusNK1tKYCPnrwI3ydu+x8lrDSjoRqJ2OSjP9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r48t4DsImJKtylWoaH1JI26dH4mxE8VL5oHnR+Wl2680BFneWpFTlox4zGFQBbEi3qOxOeN4gQeDpk/1dhLTkKHMdxfmHvYVvfdiaeQMGKqGAnttVNTuqvbwGkOCioj57iKTg5+6vkcFRpmH8AfBelQhlYKL1Isv3x69Aakpiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBVBM2mltz4f3k6Z;
	Sat,  6 Apr 2024 17:17:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ACC8B1A0176;
	Sat,  6 Apr 2024 17:17:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REyExFm0JDpJA--.50223S27;
	Sat, 06 Apr 2024 17:17:51 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	hch@lst.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH vfs.all 23/26] iomap: add helpers helpers to get and set bdev
Date: Sat,  6 Apr 2024 17:09:27 +0800
Message-Id: <20240406090930.2252838-24-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REyExFm0JDpJA--.50223S27
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr43XFW8Cr4kJFW7Xw1DZFb_yoW8Ww45uo
	WYqw47Jr48KryUJayrCr4rGFW7X3Zxtw4kAFyUWrZ8Xryftw1Uuw47GanrXa47W3s5KFW7
	A343t3y5JF4kWFs5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYu7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

So that we have unified APIs, there are no functional changes and
prepare to convert iomap to use bdev_file.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/fops.c           |  2 +-
 fs/btrfs/inode.c       |  2 +-
 fs/buffer.c            |  2 +-
 fs/erofs/data.c        | 20 ++++++++++++++++----
 fs/erofs/internal.h    |  1 +
 fs/erofs/zmap.c        |  2 +-
 fs/ext2/inode.c        |  2 +-
 fs/ext4/inode.c        |  2 +-
 fs/f2fs/data.c         | 10 ++++++++--
 fs/f2fs/f2fs.h         |  1 +
 fs/fuse/dax.c          |  2 +-
 fs/gfs2/bmap.c         |  2 +-
 fs/hpfs/file.c         |  2 +-
 fs/iomap/buffered-io.c |  8 ++++----
 fs/iomap/direct-io.c   | 11 ++++++-----
 fs/iomap/swapfile.c    |  2 +-
 fs/iomap/trace.h       |  6 ++++--
 fs/xfs/xfs_iomap.c     |  4 ++--
 fs/zonefs/file.c       |  4 ++--
 include/linux/iomap.h  | 11 +++++++++++
 20 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 58b427051c0d..7d177be788cd 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -388,7 +388,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	struct block_device *bdev = I_BDEV(inode);
 	loff_t isize = i_size_read(inode);
 
-	iomap->bdev = bdev;
+	iomap_set_bdev_file(iomap, inode->i_private);
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
 	if (iomap->offset >= isize)
 		return -EIO;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cf692c708d7..e7495581bc58 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7709,7 +7709,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
+	iomap_set_bdev_file(iomap, fs_info->fs_devices->latest_dev->bdev_file);
 	iomap->length = len;
 	free_extent_map(em);
 
diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c46..7900720fc54b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2005,7 +2005,7 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 {
 	loff_t offset = (loff_t)block << inode->i_blkbits;
 
-	bh->b_bdev = iomap->bdev;
+	bh->b_bdev = iomap_bdev(iomap);
 
 	/*
 	 * Block points to offset in file we need to map, iomap contains
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index b0a55b4d8c30..ea149cfef88e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -204,6 +204,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	int id;
 
 	map->m_bdev = sb->s_bdev;
+	map->m_bdev_file = sb->s_bdev_file;
 	map->m_daxdev = EROFS_SB(sb)->dax_dev;
 	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
 	map->m_fscache = EROFS_SB(sb)->s_fscache;
@@ -220,7 +221,13 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		map->m_bdev = dif->bdev_file ? file_bdev(dif->bdev_file) : NULL;
+		if (dif->bdev_file) {
+			map->m_bdev = file_bdev(dif->bdev_file);
+			map->m_bdev_file = dif->bdev_file;
+		} else {
+			map->m_bdev = NULL;
+			map->m_bdev_file = NULL;
+		}
 		map->m_daxdev = dif->dax_dev;
 		map->m_dax_part_off = dif->dax_part_off;
 		map->m_fscache = dif->fscache;
@@ -238,8 +245,13 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				map->m_bdev = dif->bdev_file ?
-					      file_bdev(dif->bdev_file) : NULL;
+				if (dif->bdev_file) {
+					map->m_bdev = file_bdev(dif->bdev_file);
+					map->m_bdev_file = dif->bdev_file;
+				} else {
+					map->m_bdev = NULL;
+					map->m_bdev_file = NULL;
+				}
 				map->m_daxdev = dif->dax_dev;
 				map->m_dax_part_off = dif->dax_part_off;
 				map->m_fscache = dif->fscache;
@@ -278,7 +290,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = mdev.m_daxdev;
 	else
-		iomap->bdev = mdev.m_bdev;
+		iomap_set_bdev_file(iomap, mdev.m_bdev_file);
 	iomap->length = map.m_llen;
 	iomap->flags = 0;
 	iomap->private = NULL;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 39c67119f43b..a91481178876 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -378,6 +378,7 @@ enum {
 struct erofs_map_dev {
 	struct erofs_fscache *m_fscache;
 	struct block_device *m_bdev;
+	struct file *m_bdev_file;
 	struct dax_device *m_daxdev;
 	u64 m_dax_part_off;
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e313c936351d..71e6c5342d72 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -739,7 +739,7 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	if (ret < 0)
 		return ret;
 
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
 	if (map.m_flags & EROFS_MAP_MAPPED) {
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f3d570a9302b..6286d1578426 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -842,7 +842,7 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = sbi->s_daxdev;
 	else
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 
 	if (ret == 0) {
 		/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..588af2604bb8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3235,7 +3235,7 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
 	if (flags & IOMAP_DAX)
 		iomap->dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 	else
-		iomap->bdev = inode->i_sb->s_bdev;
+		iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 	iomap->offset = (u64) map->m_lblk << blkbits;
 	iomap->length = (u64) map->m_len << blkbits;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..8002a5b511d9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1499,10 +1499,12 @@ static bool f2fs_map_blocks_cached(struct inode *inode,
 		struct f2fs_dev_info *dev = &sbi->devs[bidx];
 
 		map->m_bdev = dev->bdev;
+		map->m_bdev_file = dev->bdev_file;
 		map->m_pblk -= dev->start_blk;
 		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
 	} else {
 		map->m_bdev = inode->i_sb->s_bdev;
+		map->m_bdev_file = inode->i_sb->s_bdev_file;
 	}
 	return true;
 }
@@ -1534,6 +1536,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto out;
 
 	map->m_bdev = inode->i_sb->s_bdev;
+	map->m_bdev_file = inode->i_sb->s_bdev_file;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
 
@@ -1651,8 +1654,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		map->m_pblk = blkaddr;
 		map->m_len = 1;
 
-		if (map->m_multidev_dio)
+		if (map->m_multidev_dio) {
 			map->m_bdev = FDEV(bidx).bdev;
+			map->m_bdev_file = FDEV(bidx).bdev_file;
+		}
 	} else if ((map->m_pblk != NEW_ADDR &&
 			blkaddr == (map->m_pblk + ofs)) ||
 			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
@@ -1725,6 +1730,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 			bidx = f2fs_target_device_index(sbi, map->m_pblk);
 
 			map->m_bdev = FDEV(bidx).bdev;
+			map->m_bdev_file = FDEV(bidx).bdev_file;
 			map->m_pblk -= FDEV(bidx).start_blk;
 
 			if (map->m_may_create)
@@ -4189,7 +4195,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
-		iomap->bdev = map.m_bdev;
+		iomap_set_bdev_file(iomap, map.m_bdev_file);
 		iomap->addr = blks_to_bytes(inode, map.m_pblk);
 	} else {
 		if (flags & IOMAP_WRITE)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fced2b7652f4..49894ac4f7ff 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -699,6 +699,7 @@ struct extent_tree_info {
 
 struct f2fs_map_blocks {
 	struct block_device *m_bdev;	/* for multi-device dio */
+	struct file *m_bdev_file;	/* for multi-device dio */
 	block_t m_pblk;
 	block_t m_lblk;
 	unsigned int m_len;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..1fbc1c5688ca 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -575,7 +575,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 
 	iomap->offset = pos;
 	iomap->flags = 0;
-	iomap->bdev = NULL;
+	iomap_set_bdev_file(iomap, NULL);
 	iomap->dax_dev = fc->dax->dev;
 
 	/*
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 789af5c8fade..20eb2db774b0 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -926,7 +926,7 @@ static int __gfs2_iomap_get(struct inode *inode, loff_t pos, loff_t length,
 		iomap->flags |= IOMAP_F_GFS2_BOUNDARY;
 
 out:
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 unlock:
 	up_read(&ip->i_rw_mutex);
 	return ret;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1bb8d97cd9ae..77c01a9252c7 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -128,7 +128,7 @@ static int hpfs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(flags & (IOMAP_WRITE | IOMAP_ZERO)))
 		return -EINVAL;
 
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 	iomap->offset = offset;
 
 	hpfs_lock(sb);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0..66a83c84d11d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -415,7 +415,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
+		ctx->bio = bio_alloc(iomap_bdev(iomap), bio_max_segs(nr_vecs),
 				     REQ_OP_READ, gfp);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
@@ -423,7 +423,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
+			ctx->bio = bio_alloc(iomap_bdev(iomap), 1, REQ_OP_READ,
 					     orig_gfp);
 		}
 		if (ctx->rac)
@@ -662,7 +662,7 @@ static int iomap_read_folio_sync(loff_t block_start, struct folio *folio,
 	struct bio_vec bvec;
 	struct bio bio;
 
-	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
+	bio_init(&bio, iomap_bdev(iomap), &bvec, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
 	bio_add_folio_nofail(&bio, folio, plen, poff);
 	return submit_bio_wait(&bio);
@@ -1684,7 +1684,7 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(wpc->iomap.bdev, BIO_MAX_VECS,
+	bio = bio_alloc_bioset(iomap_bdev(&wpc->iomap), BIO_MAX_VECS,
 			       REQ_OP_WRITE | wbc_to_write_flags(wbc),
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..3e9f54727326 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -56,9 +56,9 @@ static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
 		struct iomap_dio *dio, unsigned short nr_vecs, blk_opf_t opf)
 {
 	if (dio->dops && dio->dops->bio_set)
-		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
+		return bio_alloc_bioset(iomap_bdev(&iter->iomap), nr_vecs, opf,
 					GFP_KERNEL, dio->dops->bio_set);
-	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
+	return bio_alloc(iomap_bdev(&iter->iomap), nr_vecs, opf, GFP_KERNEL);
 }
 
 static void iomap_dio_submit_bio(const struct iomap_iter *iter,
@@ -288,8 +288,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length) & (bdev_logical_block_size(iomap_bdev(iomap)) - 1) ||
+	    !bdev_iter_is_aligned(iomap_bdev(iomap), dio->submit.iter))
 		return -EINVAL;
 
 	if (iomap->type == IOMAP_UNWRITTEN) {
@@ -316,7 +316,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		 */
 		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
 		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
+		    (bdev_fua(iomap_bdev(iomap)) ||
+		     !bdev_write_cache(iomap_bdev(iomap))))
 			use_fua = true;
 		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
 			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 5fc0ac36dee3..20bd67e85d15 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -116,7 +116,7 @@ static loff_t iomap_swapfile_iter(const struct iomap_iter *iter,
 		return iomap_swapfile_fail(isi, "has shared extents");
 
 	/* Only one bdev per swap file. */
-	if (iomap->bdev != isi->sis->bdev)
+	if (iomap_bdev(iomap) != isi->sis->bdev)
 		return iomap_swapfile_fail(isi, "outside the main device");
 
 	if (isi->iomap.length == 0) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 0a991c4ce87d..39ac91fd4a50 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -134,7 +134,8 @@ DECLARE_EVENT_CLASS(iomap_class,
 		__entry->length = iomap->length;
 		__entry->type = iomap->type;
 		__entry->flags = iomap->flags;
-		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+		__entry->bdev = iomap_bdev(iomap) ?
+				iomap_bdev(iomap)->bd_dev : 0;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
 		  "length 0x%llx type %s flags %s",
@@ -181,7 +182,8 @@ TRACE_EVENT(iomap_writepage_map,
 		__entry->length = iomap->length;
 		__entry->type = iomap->type;
 		__entry->flags = iomap->flags;
-		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
+		__entry->bdev = iomap_bdev(iomap) ?
+				iomap_bdev(iomap)->bd_dev : 0;
 	),
 	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
 		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 4087af7f3c9f..cb4ac7129bce 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -129,7 +129,7 @@ xfs_bmbt_to_iomap(
 	if (mapping_flags & IOMAP_DAX)
 		iomap->dax_dev = target->bt_daxdev;
 	else
-		iomap->bdev = target->bt_bdev;
+		iomap_set_bdev_file(iomap, target->bt_bdev_file);
 	iomap->flags = iomap_flags;
 
 	if (xfs_ipincount(ip) &&
@@ -154,7 +154,7 @@ xfs_hole_to_iomap(
 	iomap->type = IOMAP_HOLE;
 	iomap->offset = XFS_FSB_TO_B(ip->i_mount, offset_fsb);
 	iomap->length = XFS_FSB_TO_B(ip->i_mount, end_fsb - offset_fsb);
-	iomap->bdev = target->bt_bdev;
+	iomap_set_bdev_file(iomap, target->bt_bdev_file);
 	iomap->dax_dev = target->bt_daxdev;
 }
 
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 3b103715acc9..34100c6e008d 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -38,7 +38,7 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	 * act as if there is a hole up to the file maximum size.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	isize = i_size_read(inode);
 	if (iomap->offset >= isize) {
@@ -88,7 +88,7 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	 * write pointer) and unwriten beyond.
 	 */
 	mutex_lock(&zi->i_truncate_mutex);
-	iomap->bdev = inode->i_sb->s_bdev;
+	iomap_set_bdev_file(iomap, inode->i_sb->s_bdev_file);
 	iomap->offset = ALIGN_DOWN(offset, sb->s_blocksize);
 	iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
 	isize = i_size_read(inode);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..8ae384f0eeb1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -105,6 +105,17 @@ struct iomap {
 	u64			validity_cookie; /* used with .iomap_valid() */
 };
 
+static inline struct block_device *iomap_bdev(const struct iomap *iomap)
+{
+	return iomap->bdev;
+}
+
+static inline void iomap_set_bdev_file(struct iomap *iomap,
+				       struct file *bdev_file)
+{
+	iomap->bdev = bdev_file ? file_bdev(bdev_file) : NULL;
+}
+
 static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + pos - iomap->offset) >> SECTOR_SHIFT;
-- 
2.39.2


